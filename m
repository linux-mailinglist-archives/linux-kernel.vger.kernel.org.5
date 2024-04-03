Return-Path: <linux-kernel+bounces-129343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C98968C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA01C28440D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ABF54F8C;
	Wed,  3 Apr 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bc90ae2e"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA011E515;
	Wed,  3 Apr 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133246; cv=fail; b=MtjY17evncIzVcBBgzRsnr6xbpWQsA0YHSj9qidk4BHWRaqXQfLh+27qDKs2LkOD5GKo7jn7ldmCTvEroHmpqDwoiFHCSmO49/e0wS3KpTfmrEMVL0mljbsACquGR1VQmQkCj2vpFeXg6uJ3Yt9R9EyQBZjm8nndL1BwmRWBMFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133246; c=relaxed/simple;
	bh=E/mse6p/FFY0M1RMOGnUDXGa7+yhZssAsqikXooYy0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d/EoqeMj2bHLQ4zHFc1W1RU+tUHuKYDpJF2cKYx3zauq5CdfRJqpj+neD7EnNIIlZUiMf6HKQ7vQzfrHjjl2B6rxSQJI/HPBbj2nt/vwYnUm750JxPgyvt4auY/jHIddNST3fUkOuPrqTqAcKLPFNxOL/dXmt4X4lTxcf8DdQAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bc90ae2e; arc=fail smtp.client-ip=40.107.8.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L585gTk84hGD5QA7uKzOjDB5XdJ7tfZVRNskHbQpPMyqy/IHlUrAhmFfg/J1+NibQNkLwZhs50SQOhwA6Jypj+3UR5GA/4ioQKO+koREIyy1hsl3tmFlLTOfrWEvPIe9MIWMHOTcmJ/EKMDgIOp3rPSHxIEFald1CISYou0TaP2nBNPqhZ+ua36lhDBFD1NIqrs/gMBW8IBKwJxzSzWZqEMidL1K3myR76htkNeepKm1gaOcQ2qfaGXKjFtkFQVk/SdIGWcqJbgF82HpXl2ywAYCx+5zPTwDOMPov4HCpsQaV25yHXv805e/jR68Pb+7v2LXfZL26b1F/QQuz0zPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfCPdy1PlcCjutst7fJpBQpZnaoYoNBu6UEqWpPkJvs=;
 b=ikSxMCaSPbEN1qHiVnuDLmuNWOx9P8opCjgC4eV47AX687y1J1DXmWns6Y9FMMLGcjwq87qjl2yYZQY6iWpOC/dhOlkmDeYF5jooqcKJXJyH5zN+GnNmEQYvcxKszeKNXRrnu4PbIudO4QzBMpL9TsDiy4XM7oqyqLrBCoqkZbt2coY1TzCBmYi32J/PT5PWzPcw8m41A9D4QGoJn4Y7DLWJo78KnKU2/3a0I7GYUKJbJ7l6C7szC2NU9fwce880RGDd0JmVrHFcMu5R1FYiEV/6o7H24EpDa21r0DxNhWtw15CYwORt0y81ZOF1x0vTawWAYI8vf6iLld/F5Ae4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfCPdy1PlcCjutst7fJpBQpZnaoYoNBu6UEqWpPkJvs=;
 b=Bc90ae2eIa0KpHGOVuRLwCCEjdOOmv4fY9jY5zfOrOk8PgBphqjIwK+Ojon412NLWWDrzPFVnSxqZlqIb+q349nQeSeDQXMF1d164Pit2EsA1ozXWcg7CPueuRx39y6QTXprDrCSFcr4xYmQbyR9e4xqjNmpNnW3gAAZ7Uz+hfU=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI0PR04MB10418.eurprd04.prod.outlook.com (2603:10a6:800:231::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:34:01 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:34:01 +0000
From: carlos.song@nxp.com
To: broonie@kernel.org,
	alexander.sverdlin@siemens.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	haibo.chen@nxp.com,
	jun.li@nxp.com,
	linux-imx@nxp.com
Subject: [PATCH] spi: spi-fsl-lpspi: remove redundant spi_controller_put call
Date: Wed,  3 Apr 2024 16:40:29 +0800
Message-Id: <20240403084029.2000544-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::12) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VI0PR04MB10418:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hN8t88Hybop256ntvn730j439i7YiUZ4VwdOaYPWgAoi15x7QsYsrfgSbtAdQ0NKWqT9JGcwN+SSqXaEUByNs/lI36tSSavXmy+SZ7wncFjX/FgpNeaStnXbwjEc/z7+tGvEYS0F4EgsCMDHQT051qfTRMyS2qWNv5zt2qvQd+Mz2Y2yVN/lnOkzDFkHzsEBYt35bystL6TXjtCJnstGAvaaQn2OjuVB27/ojrl+SXSDA1dCRPGpsKKW85I9yTg2nlworUvLkyTpGYY5bpDxwO3Jnge4qCsSV+bmCdVvxKtCJPB1AuZhvoDIZm1sUPhVS1z5A0+zQO4Dylb9bx9raOEm6n2VVEzHMpuzcXsTrJHrc8iEf7pLzXtpb5E+k6WPr6r3S8LkZZY6JHmuxwzu4/Xdn1iPzyqZqI7TOrFegwdYyMvIUf6F8V245MuyU3zF8f3ooaOrU9TNmYevFC7RjgJiipy4PeUsjBPQCj9lqO/udHC7XrbaYWDGzWNuTMZMmLR2jVrB0OS1LKxmxdchj5jbh//EO21+Waa+CDIqQjI2bzUL/fS1SLYZT7CoeDd3/3YwPwmwZI9H69l2SLSOP84AD6hmghD+Fw5HqIqhoaLp1+5SGHeduQ09cqmLZMKsv3e9WpYjv9Tp0lLfP854wiUMOx18160yyOG2AqCBNGUsksbIIhWxvbeDrErzJ8SBLQd7bO3fQIU4K++Q2qmOlEW9nRR2+dshHUJXuFhGbYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xNaofd3A8AN+MHkknAg8Zdr9/yry/jQIRgA6zpJPyoT4RD1bIIOx2IDseCCZ?=
 =?us-ascii?Q?TuenYUJxMM/xJs1O4D/6DM2MqMkRG5wZCHuIIcubvP1NxdPDPkH1EoDJNt4s?=
 =?us-ascii?Q?ieyr8EsnAfP91MJzUtZYNqD14zyJJ5qNeV6QamLqN8FFJuQitT1jnWxA5ZxY?=
 =?us-ascii?Q?m+DlEO5/Qy7rduqeGM5H9TJdwvbhQNHMlNS1aS1u/KA+vUvXlDznd9qulQ9c?=
 =?us-ascii?Q?jql0VRqFbstdbmvIf6auCtnA3hVgqR+MtMroK1jMFVQD5q5R3sBEkKgKffOM?=
 =?us-ascii?Q?tjbw4wZdcwu0kVMz7BNjWKl3/WeoU8w8tiXSY9/F3DmIvIHyX1OYJRHgHINg?=
 =?us-ascii?Q?ddNhDfPOr6l5tHDYEybnORagywwOv/S6kgyOHnu2EuyJR02cvjZ3HQEW+nE1?=
 =?us-ascii?Q?3Mex0uNWrpszmwm78SmI3oEq7y1CItXbXf4uhqMk2q4EWoLOhu8XNz0pt95U?=
 =?us-ascii?Q?r+bYvLZTXaQxezzLGh/KFCZ9Jwgyn51OWqMDbl7KKdkDcDeLf7m8nCgLuX4h?=
 =?us-ascii?Q?G6uv/QA/2MDDwF2CcVTRoMIOWEuWEeH9sznFhzINNRHvFhOC2I9cqJA6/bMC?=
 =?us-ascii?Q?4unNOcuth15mdg8QYlM49yoEx4n85KahlAGDaCqeW2E0DxChSHbf7VDcqycI?=
 =?us-ascii?Q?TDH4CIwx0OnhjOAwlOJXR3lgn1sw4+aZNFxaUNRC6ibLacOt90jBdfzFsRRa?=
 =?us-ascii?Q?S6ffUdH/x/KjIX7OmoMAc2CS6MJM9LEGB8lEhExHIotnfOKsHDviYlWfciG0?=
 =?us-ascii?Q?ucJ3OsCP+GJiqB233nodtgqf8fOl2eThyrJp78IWxdSW8rFw42EhgSBygcCh?=
 =?us-ascii?Q?Q1wCxEHSZH3zd2pHbGzxmeMsi9BNq3u4UtoxSYbNth2ulvCv4OIJU8eCC/xC?=
 =?us-ascii?Q?OzYjnrOQEeEkdFohcrB4c4Hs6vVImNbSnbcbBWTgduPW2SoOjPcA/yGYLon3?=
 =?us-ascii?Q?juorPbt7d+w+u3Ol1DANes/DdsYM//2arEOgEv8hkpWn41llTvOa33Vho1tw?=
 =?us-ascii?Q?fsA40DWtxONbU5N7Mj4O16pU4smVABXf0ObDU6wR/O63662rk85e3lJ2RD12?=
 =?us-ascii?Q?WAof8eCMsRDjz6/aWxV/E1jltdmMYKwN17KzXqKQase0zJaA8OLYNQ+WNM8E?=
 =?us-ascii?Q?JxjwUt+yI9272Z59HRESYC+6YMqlowUHIoZ4j3Koc6jn9mpHxE36jxrxX8W0?=
 =?us-ascii?Q?y9kJ/QE3nL+VvyEeMnOuQ8Qz91SIjyBT3IhTHVnMPszn8GoYxwpfpNXEaF9M?=
 =?us-ascii?Q?tbNMUg/FjXyzZhivgsbeyRwSm57khePUg08IvDGLA80YP/+EKSQ84SER8Cvb?=
 =?us-ascii?Q?AqX5KWXx/b2Rt7kHucc9xxZLG0/eaUkFLOi6kBDCyj6/Dbq+GYlIRBSdHi+Z?=
 =?us-ascii?Q?4aqaO3SV6J/BfmxYrEee1D0Xho0W6yJvzCLcErWZAQFbTJJ7sHPNiZ1hiEgN?=
 =?us-ascii?Q?thqYRKwL81s9iSUZpADLWNY2DJiDVSlwMN1arGLzswLgyMzyUrlXjz7VLhUL?=
 =?us-ascii?Q?1rmmbjMFgt++pTBldut0DJ8hcRf4KLki5tKkbnwkOEfrs9v5YVJrKCmcdSS3?=
 =?us-ascii?Q?jVYZez+EqI5t1nSSSqo3WgOT68FkDqzkHiv+NIB2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263080f9-0f9f-4401-a6ab-08dc53b8cfde
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:34:01.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR09m8mGJ/4x31QjRbjM1ffxfPMKHsok/HVW5q4GznaKL0f9CE9Ch0gMtrN/WepMDH8VvHm57wG+EudYk9m9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10418

From: Carlos Song <carlos.song@nxp.com>

devm_spi_alloc_controller will allocate an SPI controller and
automatically release a reference on it when dev is unbound from
its driver. It doesn't need to call spi_controller_put explicitly
to put the reference when lpspi driver failed initialization.

Fixes: 2ae0ab0143fc ("spi: lpspi: Avoid potential use-after-free in probe()")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 079035db7dd8..92a662d1b55c 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -852,39 +852,39 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(fsl_lpspi->base)) {
 		ret = PTR_ERR(fsl_lpspi->base);
-		goto out_controller_put;
+		return ret;
 	}
 	fsl_lpspi->base_phys = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_controller_put;
+		return ret;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_controller_put;
+		return ret;
 	}
 
 	fsl_lpspi->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(fsl_lpspi->clk_per)) {
 		ret = PTR_ERR(fsl_lpspi->clk_per);
-		goto out_controller_put;
+		return ret;
 	}
 
 	fsl_lpspi->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(fsl_lpspi->clk_ipg)) {
 		ret = PTR_ERR(fsl_lpspi->clk_ipg);
-		goto out_controller_put;
+		return ret;
 	}
 
 	/* enable the clock */
 	ret = fsl_lpspi_init_rpm(fsl_lpspi);
 	if (ret)
-		goto out_controller_put;
+		return ret;
 
 	ret = pm_runtime_get_sync(fsl_lpspi->dev);
 	if (ret < 0) {
@@ -945,8 +945,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
 	pm_runtime_put_sync(fsl_lpspi->dev);
 	pm_runtime_disable(fsl_lpspi->dev);
-out_controller_put:
-	spi_controller_put(controller);
 
 	return ret;
 }
-- 
2.34.1


