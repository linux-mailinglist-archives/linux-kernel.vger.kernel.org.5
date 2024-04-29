Return-Path: <linux-kernel+bounces-161806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54F8B517B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AF31F22623
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A214AB4;
	Mon, 29 Apr 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DG5QgFq2"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D614005;
	Mon, 29 Apr 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372299; cv=fail; b=GCaozbvUpMZi8SxJrT5mvntehfiYy5TvshtXodOEyMzdujkqJeQFPgYmyS1tuDk4W4MUsT9Ujd4JATw86aNc5ZuEmBq1NzRjDedB0FNg3HPECXtdoFX/Gsp7qMVNAVipWJkCBM0dBA+fZeB58nchBQSwh+/LZ45zBPAoVYKRhPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372299; c=relaxed/simple;
	bh=HZjnpdqoTXPEKvzwBPW1pKQHoSOt5dasS5atxl0MdOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4UUhZODouQNwNPhLggW5lbNtIghM63bfwwcTEkvi6wZnGU4NdsRr1BsLyexQlGsPTClDd6b2KW4oVjncwF+5MQ6vqQm6k5UQ1vspD22qwaMeOtzfj7I1ai5OBM64Ktd+qFk0Tf0xOxgjSHZzP0+h7D2dob/IZ11msBGAMMgEk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DG5QgFq2; arc=fail smtp.client-ip=40.107.14.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCCn/93S1nWNPO2Vdxr44vy8b3YObSqlFMEoWNAuJoNK4pG0aq6GcxgB4noBcR6FggNcgjWAWvllBpASCoKIfGdAJR2CUhKpYyC+JIOBLhxcQJAQbwITJlxNLhNY7aSXxivKrECdAFVvE8KV6Ice0DAfpSIUtTwaO6puu1OPvlL+pZckem4jQKAdIOwErd+KRqmfMpPxzr1qTL4XEQkmL2fNOQB0HA02nNFgofgGZIiZo7q1nxVZ2nlRYoLtVAIzWwHu37LMDh2ofhYBBsmN9ZrDkrlEpkl9Vx9CyC/a/qIl++NTy2pV6sh4vLT2tr1mLVmu3ti7655NXN/++ihndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=908o77j8T4UJZ1C/rwaUWC06rj/MZNwWxqT9RoT1sSA=;
 b=DSMQ9+p2npZ6sPm51iZGBo4Eu0HVUERNMbDNZ1xUVIVc+jcgw0z9MgTetGqGZzHiuD1wqhRF1Qp4KrYhF2czoOhXbP7dWabnRxCQ2PABxoEqEHyNnu8/AvRpZKb2IoGkISZRPeG3TAGdkgU5Nm138btxm65OXRvjRLfQ7ArwbIAZs5d+NS/fNmDd4p1kG3GrHWFcR+37xb2J4QFR8jcrlpqEHr56fPWtPA20hEjALOVJArK4pRWAL9fgfOBMsIsOBGSyf8H3g8HkA2aX30AiYvnugrc/VFM407FzqQZfZPprkF+fMJ9gcdByoqXE5vbM/IgDfVd33jBqeEbJ6pMPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=908o77j8T4UJZ1C/rwaUWC06rj/MZNwWxqT9RoT1sSA=;
 b=DG5QgFq2gvYb+wYprOqhJVZPQF3lP4q/hHydMDfzJNpyBmDfAK2pVbLz149y7V+ouyDOwRkn51w/t3pSz59lyxnanadhLnXtu0YJMC6TxXH6VZocR3iCn6zAn2mAN2XmBWZ0Jr7spLImJCWEALL9T89MF8n1IQ0bR0LgdWzanpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DUZPR04MB9919.eurprd04.prod.outlook.com (2603:10a6:10:4d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:31:34 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:34 +0000
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
Subject: [PATCH v4 1/2] caam: init-clk based on caam-page0-access
Date: Mon, 29 Apr 2024 11:58:52 +0530
Message-Id: <20240429062855.923595-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429062855.923595-1-pankaj.gupta@nxp.com>
References: <20240429062855.923595-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DUZPR04MB9919:EE_
X-MS-Office365-Filtering-Correlation-Id: 26355f26-3b23-4f37-e80b-08dc681603e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?asfsM4KmqE+Id5OdNRZDHSV1wmkGqv/rcOK6ZGi50TLmeFu2ICmt2pMlgDZ3?=
 =?us-ascii?Q?J4U3G2+xyFuQCXC1kKaJ4aRgGf0jOIwOPdcTC86jWlzaGfSDb7l3lIERLZhh?=
 =?us-ascii?Q?iAwAuHRErffq9DtPn2vVIfuxVx6ecC0gjEH1yP15iLNsfvVDHaEWzEmmQQQj?=
 =?us-ascii?Q?E1AlRIoXsTggLIWgGJHoTCxioHxfUz/JoXQIRmD+ZrXYVut4vZRNDBhlDURS?=
 =?us-ascii?Q?Oygi57t9wAZkPO59cFfdhQFnr4cs9uNQGzi0Z4avVH6iU+ET4RmRt1ZtYg3d?=
 =?us-ascii?Q?8PYIIMH018pukKT9nm2WtEDavx8hm46BzICG1jXJcs0wA5iJUECng/tr6/pN?=
 =?us-ascii?Q?Tt2crrxTbYZVq4QqTN42UCy8HBwC+DrFcycDvvAKpv/BlPzxbQELppB8LLt7?=
 =?us-ascii?Q?8fCIaQ8UASHy6zUaI1nB5s44Kid8MhXc7dk1xfZFyOU3t1wIVmI1IWstgFJM?=
 =?us-ascii?Q?6mvLPlbVibEkbzrPOrU+63JjMvMVcxiaL0d9sM0l+UqhE8FL9fIF4P4EtmaG?=
 =?us-ascii?Q?9JEtDchX4MjrroqgdUOrURUf111mlmTrQV+Nuv1Z6wtI6FvmfDqIOB6wVYKv?=
 =?us-ascii?Q?gSoLXR9/xGcFeUXoe4drs+leDfMVF7QRkYhqYr3KcxVZtnHvJ+BusScn+m+z?=
 =?us-ascii?Q?VhLkAB/U4tADyCpZ9pmseZ88l7LUdzYr6IF/fXXHe47admGe2F1AW8y7JZOK?=
 =?us-ascii?Q?kioL15niev0/r77gj+AmxKpgaV0nnsRhIS4uXk1VlUO/cU+/21YHJd/igv2T?=
 =?us-ascii?Q?Sh7KsLvMGFGWDsfZkCGGidV00Juola8Y2IcWQBaQyPLK7NnD5H0LAjLLVjGu?=
 =?us-ascii?Q?R/aSeIUp1NIghfUyz57Q1f69IJNr49hDcixxWSYVzndmVbAymbaG60/oEQ/w?=
 =?us-ascii?Q?Th9WuS8FzYTX53S+NMqbX3FB0pnmuLPcirfP/Fqkv26NGxWbYmDjE99f9RXo?=
 =?us-ascii?Q?FEsOcNXqA+Z2+3yLMiySnJn8HWON+vMmbVI0qgpTEnlVshJYzWF2eLu1goub?=
 =?us-ascii?Q?+hZkgMW4OU62qPL0JjVtArErcm8CLAldBFplJjxsssF1qbfbImyEzu952x/N?=
 =?us-ascii?Q?oAJFdXJ5HY06MV+URgvU5i09JBVsrxtq9l1cNa1E/zJvcA0V5DQFNZRO4XdN?=
 =?us-ascii?Q?Ot6sWrS8CtvF1wB+G/Z309xCvgufwdDo5fd03kUnNvefHZYANvy6sRE+V2+L?=
 =?us-ascii?Q?FglBBPFTPWjCDr3HLAp8k6twQJGlNH35SLUwCgCgdUthcjKFnILj++zyjkKM?=
 =?us-ascii?Q?A6bMpyfn5/PN2jJnf9Dfm/ikUPsShwWhRMz8pdQY7sDLfDlipyGyBKVATV5J?=
 =?us-ascii?Q?aMy1TuzxKLyBOMMGxHgqMEOaF9Jig/rqiv7iXdbXNankbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5Z4jiNGsn/t1Kfnd5t7HrI+qY+m80iT8PmG+76M2DPDzPxlCItcP4yeIKdS?=
 =?us-ascii?Q?H1kUD0NL36B1wMerrCmlBx3r7DrDUja6l9PW0jc5+FjpE2NjoNr1P6zzyREB?=
 =?us-ascii?Q?L0rNQdmHCp8m4g+jX9+qNVvVsvsvpofV1g6y4M1EMIDgADjqi/bvn89aRuwQ?=
 =?us-ascii?Q?TGm3O4FiMYezlIkn9IGARaWQxoljKNq3xpfiGeqz7InXrX+i2KedXsjbkL4p?=
 =?us-ascii?Q?ftMlq3ySNBKHe2fmyxb8NToRikuVXL667J/j3bKA5fw/NsxhzzkMHGGTC23u?=
 =?us-ascii?Q?EVJ8EzvQi26LBoewADrj7UuQx9GiUrSdfMq4CLXF/KfiyCW/l2m0CcYqa98n?=
 =?us-ascii?Q?93mIAKXwozkVrTm3zJeRAs0WxmBDCTzqNy3u4LHbGCXgsMcpMDs1UMjcaDMF?=
 =?us-ascii?Q?1F4Rqu1BrR3pkBGhwiOHYgAbSVK9oFDPtQRKVlGgoYUMRTf0vP3FQMfLvk70?=
 =?us-ascii?Q?QLlTKKWU7o6dLkyzpedpuATU+3Fjc6J19jtmA1SGyUEsbq2U2GHAXTQxEvqg?=
 =?us-ascii?Q?5j7NrEHvieaWb9SAMhIhPqF4CJRWvgTrIC4wcqupCegsVDTqibHWbpVVdFJ6?=
 =?us-ascii?Q?X0dPyhht6wpzCbgQ0cOIig8eiK3Xf0odpKBvjYMa0SBabdG+1kUnss8hzJhx?=
 =?us-ascii?Q?MC5H26npRjBWQVlUVI4iuX5n51OJkP7ieUpTPeMLmZm2LOcho2Yd+J11ByRJ?=
 =?us-ascii?Q?ZfHiajhH/x03ERv70NlL7Lubvg1iEDevLwub1Al6oFYKNBbE0+xDBOnPbjXe?=
 =?us-ascii?Q?xee1QZ7Bc3JPdP3BknNlu8xZJGmLwrK9Yb5bltTInNEBqXgixhFVu/NGGI2i?=
 =?us-ascii?Q?ophB/UUxgNL4xBp5WQliuZmRKJ/b4OTxYNcW8kb0X+G7UC/2LuXIouN7EyTp?=
 =?us-ascii?Q?DKNN0h9s5WrTlmp1ZilCB/MrqvTNioTOQo36MjgHvhnJmdWZ3l1VX7ZncEnz?=
 =?us-ascii?Q?GuVJfdAvGfcy2ACMlvfVfxs1wvDTFdxH3VRWX0HCjbI7JSKNYJbcyJ7UfYbi?=
 =?us-ascii?Q?jU+mPsoQi33Y+QcjG42vhN8LwRasLhqlteMy9vhmcQBYG596tNYkZrO+EH2v?=
 =?us-ascii?Q?/3pf5P0/qK/CUs4AhLI6/QR3al0QE+9Eqw3sWOx83C1QpF08b94aOK/55L40?=
 =?us-ascii?Q?PswyiJVUddTgeMSXyoLEYomv7wIXlWS0ufgrjrFctwoRc+MbhPnQovM8NsLa?=
 =?us-ascii?Q?6pWDqPFpEoZlxVqOYV5EvFsrDhDpzhSj9dH4QFDrklbSC2BefrWwR5shF0Bc?=
 =?us-ascii?Q?Nz0Y3bJkQJwgp9e0Ep7ALCEMZo8UkbX7Acss3/R2Q6GeIIX7cSuHH1KLaFou?=
 =?us-ascii?Q?OsiVG1q17UpVEcppfGBfNovxOAN9/IXnyYJ3ivkIoKnsJjW1YxoxZTlamzRw?=
 =?us-ascii?Q?uwkDjnPqglHtoGJfusM4wqEmjrm+YxWuijGa9XX11275ClVQgs3Wft/uCI8H?=
 =?us-ascii?Q?lIwXRE7A6pGKdnZb6M9PaSNAVguJ7260iY3pSXdzkuBt2atXlUwqC03Doijo?=
 =?us-ascii?Q?PvIF7dTVqT5W5YyQ1UeGL0W10ax9UTOkgsMt1bSyuepxwbGI0PpKRHyYNs+1?=
 =?us-ascii?Q?MSLWjFia6eNjNmJ/rbawtReOpgleX21HQSPDV/Aj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26355f26-3b23-4f37-e80b-08dc681603e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:34.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttUqLv5opveEYOl6dAJIQKnIt8Zj0lMDGZ/8Y8ONq8cTra2rNKe4yDrr3cLXAHbk8tzopuD5cB0YeOdhivgxAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9919

CAAM clock initializat is done based on the basis of soc specific
info stored in struct caam_imx_data:
- caam-page0-access flag
- num_clks

CAAM driver needs to be aware of access rights to CAAM control page
i.e., page0, to do things differently.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index bdf367f3f679..02363c467cf3 100644
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
@@ -554,6 +558,7 @@ static const struct clk_bulk_data caam_vf610_clks[] = {
 };
 
 static const struct caam_imx_data caam_vf610_data = {
+	.page0_access = true,
 	.clks = caam_vf610_clks,
 	.num_clks = ARRAY_SIZE(caam_vf610_clks),
 };
@@ -860,6 +865,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool reg_access = true;
+	const struct caam_imx_data *imx_soc_data;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -894,12 +900,20 @@ static int caam_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
+		imx_soc_data = imx_soc_match->data;
+		reg_access = reg_access && imx_soc_data->page0_access;
+		/*
+		 * CAAM clocks cannot be controlled from kernel.
+		 */
+		if (!imx_soc_data->num_clks)
+			goto iomap_ctrl;
+
 		ret = init_clocks(dev, imx_soc_match->data);
 		if (ret)
 			return ret;
 	}
 
-
+iomap_ctrl:
 	/* Get configuration properties from device tree */
 	/* First, get register page */
 	ctrl = devm_of_iomap(dev, nprop, 0, NULL);
-- 
2.34.1


