Return-Path: <linux-kernel+bounces-138127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F689ECE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FA328164C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059013D52B;
	Wed, 10 Apr 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwfll1ik"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2096.outbound.protection.outlook.com [40.107.105.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638713D517;
	Wed, 10 Apr 2024 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736033; cv=fail; b=GuKRNzfya6cCGa7Bf7HdzmPIWgqZA/mj1bMIN47O5i3PELvk5pdaTjTYn6+yCrYrQzZk2pc4UyyBYlYgQLArlZelAD+QPpVeVZczHeAlqpJSewZ3lkMa2WzpOQBzI9gfANR4TP4dwPSFrEvBxkAwg0ilis8f/Vd9RWHePahUOKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736033; c=relaxed/simple;
	bh=F3uq0v9dgLFsAY7E0zpd7AIKtPkEeYvSSF2XOQbeV7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cUg09eimbNQkgG2+zuBvJD7TaNjHYKZRvxgbehkwfmAZe418Z0GyY/todM5z6aIjZ9rB73H+vYuzpVo1jh/foQ/NLDqTKOjcIZO4emVF1AZ0HUebP9xLscAOT6yAE9yEdu91kYvTmVniBiQrC5VcdZrlfvuov2V4tq67wNBcZu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pwfll1ik; arc=fail smtp.client-ip=40.107.105.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWxPEyWV55nbWduG/s1eGsKCyqhjVCXDAOaJcyMVUJ5rLEqHKGLWaiqfP/eqPWwhOi1vkredytpSXyk2+vG/u3a69/+2WrBCRVsFOyXc15QkueMK4Az5YHNaBwDaS9O3BbV38IJN5O/BjBg/S8GGMtC30YDgai/n2aiJOF1Mq1Ke5nB6mxhHlvpfhR2YrIN2nPx1t5MoPIWid5nJoxTX59Fmw2H3xLdmWM1Cqo65lfaktFlFWRqr9I6zOPzhAS9v9vxKz/4Fl8OqBCL3L+C47W4lpZ8u3bFxPA+hxXR/+dPexls82E88xf2DF9Ep75E8YQkP5Ga3uxPKft221G+Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb2USNHHb14ukpE7Sy8XvY7D8BZzVCUopGDU7W5xVrI=;
 b=WyED0jkJoy7J3ZY7aWxZ9nyUAVHoubP7R69i3lBvQir7WsYXA63xj3i9Fr6Svui8wFZLwGA9aQr6CyjApdX7394Jr3OtdQiWVAAH8iH3Isqc8V2DwK+jxzQnGBe7GWqi1kV33SGoeojyxlQlPqIRtkf36B78zQRzJSRGbaht6LfPNnozQy/JUzU5r6cMrbDHsDD9dwQynKJ/paLf48T248gpw8fD/GI8EiY/pGD/V6qax7+iOTiiA3nua2nwurqvIDw1wcg0hU88yrc8cbevj0Tyrt3y+ulPmozY+8p75HemDuaVva1xm9qB8IcJ49CQihmEvRfuPdMVO0U3ci6NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb2USNHHb14ukpE7Sy8XvY7D8BZzVCUopGDU7W5xVrI=;
 b=pwfll1ikWwkil+nxdwHJPDbIM4FRA/BEbL1uZn/RZQG1UINtNy6RUYBz1Zgv89M8CWe7vggvmpx/a88jXR+uhioHlwEd/1382MZ73o1ftGyp9MVZWOet5x64S295zba1DkuMSufv0fB2nROzSm9Gis/8bZIMO8gdrTM5TPmbeeM=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:00:27 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:00:27 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2] caam: init-clk based on caam-page0-access
Date: Wed, 10 Apr 2024 13:28:15 +0530
Message-Id: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB7004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ct5tKS7MWKcbM0S8bvoghG4Sf07BnxZ1oaXK4ptI8yi2ZkxAy1eQdqeOvqCts5IzfY20vmwTzQB87/PIWRYqdbdQKYrlSnHYhb43+mrHWqiiPofXKRlLSU4z6RKxpG9Rvuc2hhUJb8myUvGZHdgFXLdE8nZy3+hj/c1XgLYF+oStdcNQxfc7/PvLdsAQ75lIruHuogenaWxBiu+T8pcIWjTUfMsu2P6Om18zFdnEjzwFkzZZF/c+2vqoKaOw/HiQNFhvBYJuCF3FRW8uKH3w36hBRMkS8A3QYYVyQFs8f9a6tXYwAlG0JpevVLwD0S0u3wC86cgh0Vuc0RyTvoyCHCCnyjkg8MFgMsPtXYu0Ep1mfdlA4ORw8o0+89/V9ebZr/lTQC7PSzbO29XpkGTiWb4+x9fGbqdzfaav2tu4bBdEM/4wQrgjOl0xBko6atFdT3JsLsFhpaLTrJduogkKcnJ41fqwVWJDMBz0oYYr9O3JX/pPyZB7LVqPdDH9BwBLZd/qvK7XOooqhJ+lBVqknrQaNpdipXGLLahrEgv7X4oNqii32ZYvXPZAo4qBLNpQzmXTn5LP4cYB/dtzBd2AWll24dPRTww6LyqRGvlmr02DNXmXnIXur9y1E+wexE+qOQQK5Siob6SGsJ5dY3CBZHIHaQBTFk+WwtpYwwos15d/tTryyB1ob7HIN0rzuFcDY1laqMYz6uTrKVH/VXuKEkjnZimMRbbiSCwE+gcCNBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/h4neB/hf5A2HaHQSm6P8gycKu6HBKNYXH3Dc/pQ4o+VlvY24i7LuRjLfUhs?=
 =?us-ascii?Q?zqKQfUPNEv73orEzbs1utrcwWOz71HqATcyn9N55cmKBUNE6m+QXHgMhR3uJ?=
 =?us-ascii?Q?nAMuKhtpkW/CzfuUjQ3K9WFGXrlgRrC4oM+mdpZdxmog7pY0RP2jHKwy/0le?=
 =?us-ascii?Q?M3bq805hH2+o8uMjAX/L7we9WQc/Y6CdRikDuPv8m7m3zGhMUGRvBg+iLlYC?=
 =?us-ascii?Q?gVq4JJC4M0EBGbf72fTNk9pnwzdgDs93MOH2OWEVbPbgPRv492Wo9KIaQYdN?=
 =?us-ascii?Q?YynsGbPscY3HUhJdnJtWak+rTbSeDiDQISdgZ0jWVBBOLlan1HcprWbqB1b9?=
 =?us-ascii?Q?PNh7NDafoAIIGCUFacGUWbe/Jbf4YeoBOpnlJIQdJwz2tXPeqX5dycgRPh9k?=
 =?us-ascii?Q?ZPSjeQuVYAoMa7E4f67izAUz0syCbLf46ah8P4G+I3HiG1sC90HbYGaDkUHV?=
 =?us-ascii?Q?s750+n6Ef7tbgohc4SFMNc4QbKOupNz6b6uLkZJKbnRkmT2uWGv8g4GFozbL?=
 =?us-ascii?Q?N1zv9ktJhTcIcIX1d3q1CbuugRR9Rpao/g7WLgkZ7lNcp/Im1Kjk71fpZTka?=
 =?us-ascii?Q?S/3LqW/YPGicP68vgpPh1xv4SfctYZkck/QL96i8IUXxuIppGJADsvE9k31Y?=
 =?us-ascii?Q?DlgLAeuR3LTUw2Ud1c3thqZ+im84z1iHfZN8vLB9qKxqpmfiPDJEOJ1fDGPq?=
 =?us-ascii?Q?u/rYDAArQskjZstoOkCqJ5+7kEuGTkSJNBjvFYs88TzDJQmYKtsV7TTlRWL+?=
 =?us-ascii?Q?PqVQ3omuz6iBstuAjgQa7Q6X77THpI4AIgoNo3+DkAJOJruD9iZBYpvfc5iw?=
 =?us-ascii?Q?KTJJqynEHpqEshGViHcJpJZFdE13Em7XYqigAe/ZKvm+9A8GprCyaYhJphT8?=
 =?us-ascii?Q?Aq7Zh+JpbQo0JsdafLqtQN8ZuZz6MKdB88SbZzz/4Aylkf/Yp70nTAB9XqWF?=
 =?us-ascii?Q?HBJdIZhriCGMvc+BJ/NYrOlPW4FONOSv2XX0ZNNtiWH+00YoLj6UvZUanxfA?=
 =?us-ascii?Q?RTYccl4/OcwL/TTXoboUjNDwKs8dyCitfvTnEGg45hhd6L/wbD/CcQMSB/Uh?=
 =?us-ascii?Q?2+X5xsO4zbNrzB8mmeUek/cjI8lSEzoYq/aoCSUHVn8ODRJbIEGzjV2nj7w+?=
 =?us-ascii?Q?NSUptm4d3Ix9o5cQPpC3wP/ZwXiuoFmBh+fY59hVS4ugUTBEG9JnYlidAkWI?=
 =?us-ascii?Q?GEcHJPtBOk42v1Sx+sYDvygI11GaL1iaIDWVM2KqA16yau5LpY1mUbi/rs2v?=
 =?us-ascii?Q?KbT774Q/5rZdqPQgVLgv0RE+SworEVIZPFaZNE/iwtJMfFvCO1GJidOCZw+S?=
 =?us-ascii?Q?x6axLFHGwZLqjexylLQ75IjNX37YHigV5NigsOcvEgbwjGQV3u34xpZ3zDgV?=
 =?us-ascii?Q?dPouDlG07cfInhOQtSsu7gbVYm32QqQ4rpffawwFDSFciACP/dfGvKEBA29W?=
 =?us-ascii?Q?wt3K5ebEJ75Sn61OCfBNolwXmYlgMen3/+pgJ5f15uz0tjbbivql6WV6U15I?=
 =?us-ascii?Q?N9tpIpTKVbvH0g79RIXvZe/+qDRJvTYqrjtO1easjGKZgYaqHPQI6oh5Ggqh?=
 =?us-ascii?Q?oW0w63BB8MwQevJpmyYJ03iNBZWYBwdu8QaEnahJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f21f51-3c22-4174-a91b-08dc593448cf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:00:27.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTqpJVZgenPHdPeNxvk/MJyYXzJ8yOrMkoEnRj7W+cTBi0fDkKKtVuIEmzRzIMtYf66uevJh1j3s9JEcdaPUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004

CAAM clock initialization to be done based on, soc specific
info stored in struct caam_imx_data:
- caam-page0-access flag
- num_clks

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
v2:
 - Considering the OPTEE enablement check too, for setting the
   variable 'reg_access'.

 drivers/crypto/caam/ctrl.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index bdf367f3f679..355ff92f4549 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -512,6 +512,7 @@ static const struct of_device_id caam_match[] = {
 MODULE_DEVICE_TABLE(of, caam_match);
 
 struct caam_imx_data {
+	bool page0_access;
 	const struct clk_bulk_data *clks;
 	int num_clks;
 };
@@ -524,6 +525,7 @@ static const struct clk_bulk_data caam_imx6_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6_data = {
+	.page0_access = true,
 	.clks = caam_imx6_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6_clks),
 };
@@ -534,6 +536,7 @@ static const struct clk_bulk_data caam_imx7_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx7_data = {
+	.page0_access = true,
 	.clks = caam_imx7_clks,
 	.num_clks = ARRAY_SIZE(caam_imx7_clks),
 };
@@ -545,6 +548,7 @@ static const struct clk_bulk_data caam_imx6ul_clks[] = {
 };
 
 static const struct caam_imx_data caam_imx6ul_data = {
+	.page0_access = true,
 	.clks = caam_imx6ul_clks,
 	.num_clks = ARRAY_SIZE(caam_imx6ul_clks),
 };
@@ -554,15 +558,23 @@ static const struct clk_bulk_data caam_vf610_clks[] = {
 };
 
 static const struct caam_imx_data caam_vf610_data = {
+	.page0_access = true,
 	.clks = caam_vf610_clks,
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
 
+static const struct caam_imx_data caam_imx8ulp_data = {
+	.page0_access = false,
+	.clks = NULL,
+	.num_clks = 0,
+};
+
 static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8ULP", .data = &caam_imx8ulp_data },
 	{ .soc_id = "VF*",     .data = &caam_vf610_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
@@ -860,6 +872,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool reg_access = true;
+	const struct caam_imx_data *imx_soc_data;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -889,7 +902,15 @@ static int caam_probe(struct platform_device *pdev)
 
 		reg_access = !ctrlpriv->optee_en;
 
-		if (!imx_soc_match->data) {
+		if (imx_soc_match->data) {
+			imx_soc_data = imx_soc_match->data;
+			reg_access = reg_access && imx_soc_data->page0_access;
+			/*
+			 * CAAM clocks cannot be controlled from kernel.
+			 */
+			if (!imx_soc_data->num_clks)
+				goto iomap_ctrl;
+		} else {
 			dev_err(dev, "No clock data provided for i.MX SoC");
 			return -EINVAL;
 		}
@@ -899,7 +920,7 @@ static int caam_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-
+iomap_ctrl:
 	/* Get configuration properties from device tree */
 	/* First, get register page */
 	ctrl = devm_of_iomap(dev, nprop, 0, NULL);
-- 
2.34.1


