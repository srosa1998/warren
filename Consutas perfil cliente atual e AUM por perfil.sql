# Consultas para ver o AUM por faixas de idade e valor declarado investido (a consulta para ver por renda mensal seguiria o mesmo racional)

## Por faixas de idade
SELECT 
     aux.faixas_idade,
     SUM(aux.AUM) AS AUM
FROM
(SELECT
       CustomerId,
       CustomerApiid,
       RegisterDate,
       Age,
        CASE 
            WHEN c.Age >= 0 AND c.Age <= 17 THEN '0 a 17 anos'
            WHEN c.Age >= 18 AND c.Age <= 24 THEN '18 a 24 anos'
            WHEN c.Age >= 25 AND c.Age <= 34 THEN '25 a 34 anos'
            WHEN c.Age >= 35 AND c.Age <= 44 THEN '35 a 44 anos'
            WHEN c.Age >= 45 AND c.Age <= 54 THEN '44 a 55 anos'
            WHEN c.Age >= 55 AND c.Age <= 64 THEN '55 a 64 anos'
            WHEN c.Age >= 65 THEN '65 anos +'
         END AS faixas_idade,
       AmountFirstDeposit,
       TotalDeposits,
       TotalWithdrawals,
       AUM,
       ComputedRiskTolerance,
       FinancialInvestmentsValue,
       MonthlyIncome 
FROM 
    Customers c) AS aux
GROUP BY
     aux.faixas_idade

## Por faixas de investimento declarado
SELECT 
     aux.faixas_investimento,
     SUM(aux.AUM) AS AUM
FROM
(SELECT
       CustomerId,
       CustomerApiid,
       RegisterDate,
       Age,
        CASE 
            WHEN c.FinancialInvestmentsValue >= 0 AND c.FinancialInvestmentsValue <= 1000 THEN 'Até R$ 1 mil'
            WHEN c.FinancialInvestmentsValue >= 1000.01 AND c.FinancialInvestmentsValue <= 5000 THEN 'R$ 1.000,01 a R$ 5.000,00'
            WHEN c.FinancialInvestmentsValue >= 5000.01 AND c.FinancialInvestmentsValue <= 20000 THEN 'R$ 5.000,01 a R$ 20.000,00'
            WHEN c.FinancialInvestmentsValue >= 20000.01 AND c.FinancialInvestmentsValue <= 50000 THEN 'R$ R$ 20.000,01 a R$ 50.000,00'
            WHEN c.FinancialInvestmentsValue >= 50000.01 AND c.FinancialInvestmentsValue <= 100000 THEN 'R$ R$ 50.000,01 a R$ 100.000,00'
            WHEN c.FinancialInvestmentsValue >= 100000.01 AND c.FinancialInvestmentsValue <= 500000 THEN 'R$ R$ 100.000,01 a R$ 500.000,00'
            WHEN c.FinancialInvestmentsValue >= 500000.01 AND c.FinancialInvestmentsValue <= 1000000 THEN 'R$ R$ 500.000,01 a R$ 1.000.000,00'
            WHEN c.FinancialInvestmentsValue >= 1000000.01 AND c.FinancialInvestmentsValue <= 10000000 THEN 'R$ R$ R$ 1.000.000,01 a R$ 10.000.000,00'
            WHEN c.FinancialInvestmentsValue >= 10000000.01 THEN 'Acima R$ 10 milhões'
         END AS faixas_investimento,
       AmountFirstDeposit,
       TotalDeposits,
       TotalWithdrawals,
       AUM,
       ComputedRiskTolerance,
       FinancialInvestmentsValue,
       MonthlyIncome 
FROM 
    Customers c) AS aux
GROUP BY
     aux.faixas_investimento
     
# Perfi dos clientes que entraram mais recentemente (2021)
     
SELECT 
     SUM(c.AUM)/COUNT(c.CustomerId) AS AUM_medio,
     SUM(c.Age)/COUNT(c.CustomerId) AS Age_media,
     SUM(c.MonthlyIncome)/COUNT(c.CustomerId) AS Renda_mensal_media,
     SUM(c.ComputedRiskTolerance)/COUNT(c.CustomerId) AS tolerancia_risco_media,
     SUM(c.FinancialInvestmentsValue)/COUNT(c.CustomerId) AS Investimento_declarado_medio,
     SUM(c.AmountFirstDeposit)/COUNT(c.CustomerId) AS Valor_medio_primeiro_deposito,
     SUM(c.TotalDeposits)/COUNT(c.CustomerId) AS Num_depositos_medio,
     SUM(c.TotalWithdrawals)/COUNT(c.CustomerId) AS Num_retiradas_medio
FROM
    Customers c 
WHERE 
    c.RegisterDate >= '2021-01-01 00:00:00' AND c.RegisterDate <= '2021-12-31 23:59:59'
    
