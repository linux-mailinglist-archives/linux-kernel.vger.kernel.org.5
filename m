Return-Path: <linux-kernel+bounces-161807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDAD8B517D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D4D1C2184D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167F16419;
	Mon, 29 Apr 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y12jZu7T"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870714A90;
	Mon, 29 Apr 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372302; cv=fail; b=E6tSxY5QFX/RkKbOK60PL76Qc3wS+0Ttl1tQC1vsf7J8nlQk3NqoFDMrnJ+XWGcb/IC2mWtT7Jj+YXt9bxM+NVL7xg1YvDvq9v/NfeMtvyhnQ7+tIaU23SBfVKl/48MDSmNLuvGq0Mc/mI6mglVHHliu/ET1q7UN9cvSpulzJLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372302; c=relaxed/simple;
	bh=HZjnpdqoTXPEKvzwBPW1pKQHoSOt5dasS5atxl0MdOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLueuKIvw3doUKiKiCxUds9xHZ7w88O8rrsi+uguvsjnk4Z5Dhi51vMRn6tCELA5qLWowHwdGIo/yywL1Gx6SahjKNDCqfBiMwScZei7BZlqE9aOgiSfmxEJ5T3HhbpyefKK6tFgqqe69wJ4bahdTPoqahY2GhH3nHcM0RidUOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y12jZu7T; arc=fail smtp.client-ip=40.107.14.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob2X73854027tKKEleSEK/ExCTEL6n/03sYEp11sWN0sq0uY/OTgxl9T307KsEt50f0oRf1804hsT65PbRy0dxdTjusfwUtJbPL809Jubtcgx8//ah1jKjaw39EOByq5eM3BYxFp+MG9jGnWPobrBaOHI1jfP/0R/zIszH2Ec8aMJq+jmUuLiWDGYb8TB0ndJeY/hdk4cznI/vucIe6ARFt7IHMunW1BrNFG71PrKgzn/rjgmbX0xgiG1oJRNCOCLDZZHA2Zrl83lwd+A9ovMYOEQyE/BR00xNAr0uWKLzSR9R7/b/ohXk8IRK0cY0pxGB19hqeeyx/jNt4umgWkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=908o77j8T4UJZ1C/rwaUWC06rj/MZNwWxqT9RoT1sSA=;
 b=I40sLlbNrAPnK1IlyWQtUgpnUz8guWODhWCGRAm65+gip/ItDhqAZR5ByBnetb0xzmoe2moiD7yJwBcLsH82/fCacPkG6P9Hj9QNWCk989GwM5UxBqtVWySn5/R/oxZLLYZ+yt+1Gnwq1UJ1t+RxmJ7C/n8BD3y2f2/ajYHwR7XcgL27+KGdTTwA4NH3w8Wo+FJeDVxpgYWxYdjJu83rZWcee6QxvhtDuVmheFuquR/jgnYk3tKzZqy7HMnA3sAMAXIHiijYwJIuLY7Acko3vdGlZ3eFR2ln1wYzOhRuaio/yZdd7c5FxZA+lEnqYQ+e8JuUt5z+rFRwajc9iGyzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=908o77j8T4UJZ1C/rwaUWC06rj/MZNwWxqT9RoT1sSA=;
 b=Y12jZu7T+OklAaBX/N0Uggf4lSBl4qOeHYKPFHZwZNVluF+/zLQay+MJenR8Wq52VM5eN8GlgpkwohVgPdz7RODVH3kiprdNJLnvcfH/CFnOn8xcYSbQwe114lCSsV6OB9g1UID+ep7q7dZMlnmBw44Rnn37CWLcgchWQQapEeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DUZPR04MB9919.eurprd04.prod.outlook.com (2603:10a6:10:4d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:31:38 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:38 +0000
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
Date: Mon, 29 Apr 2024 11:58:53 +0530
Message-Id: <20240429062855.923595-4-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f104762-348d-4fd7-a0b7-08dc6816066b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jgZG86IO2eNXMTFVw8B8P8n7tvF6cZEKtCgQHRtIQPt+u0QrQcoZeQf13L4?=
 =?us-ascii?Q?xTdhY2hOkLk6lwWAWYCkivCBrPBG6zGoN1QCS34btYTeJwGftkjHNpuCWC5b?=
 =?us-ascii?Q?7ukOYmL9O0E4dMuknUZuM7ubziIxwJdFw7Zae429lAFAPRa55J1w5gJRYF4W?=
 =?us-ascii?Q?hBNJvpCm64+TMZ2KVvW6rYINbXgInIv9MOF+NB01en+WSOx0TKVgUNf7G2KZ?=
 =?us-ascii?Q?R8FKT3MPOweVV38uidxRG40NQ1cDA7NU55zELoedeyE9S0zAvkLYZMwN9bOK?=
 =?us-ascii?Q?BviWirdO5eGk6aUmLMqSjntrnglG/EpBcnmWhY6OcBbxbUxUFWaiGEMJ0kaP?=
 =?us-ascii?Q?XJ4EFO3dLN5dOA4USQXWiAJk7xtLeBc7+2YhCyuOcIFftPuB/RlYtkckSeSK?=
 =?us-ascii?Q?NNs5XExLAFyJLZCsMRD54Z+X/SCIo6aoP5o6aPXiNAEt6pqIC1DsK9AZPEU4?=
 =?us-ascii?Q?O1DtEul96cqpzjtp2tuefK6VxT+mZl53Nqx72fu1pZRfD4oR3ihNu6Mdc0zi?=
 =?us-ascii?Q?0njfnznjjlLHrXcuZcwn0/mcnKJqwloxuxbAy4vWEpXz5T/miAUOs/hvGMqR?=
 =?us-ascii?Q?oB6Y9OIRTxZMTRBtf8rAUkN0fxyRXBu67wwumsuivWv3PQJr+4eCEy2siVBu?=
 =?us-ascii?Q?8b1uZMguxnjzjMCylotlb4cZu2Hj+ls7NOWoI3lEdIl8WXQEXAl3RdvIY5gj?=
 =?us-ascii?Q?yVhFSaJ2VeuxXeEFqNCc5IynqNa4dIPLGPR32IleUCH3R3+I09RVinQSFP4K?=
 =?us-ascii?Q?Q+YpN2KKL1wZuZ82UxSKREMnRL2aQHBuKmbIHdsynfwQJHAo/LWGcCf9foc8?=
 =?us-ascii?Q?C4+9aXYK3W9jufXBcHiTfdPqgdpwhZ8DX1C+MCyKOYjB6SDbeLM01zfWQVqj?=
 =?us-ascii?Q?BOu959rJcsNdjxGXBJ/mplGqNzo/To+BRuwGxkMsIeVGUnsMM8ixCU84S4PH?=
 =?us-ascii?Q?cyWbqX3kq50O+twIUUhA+OdwEdd4y5pP+ozGBy3JHNW/L0XE+PyVQpiE4GeS?=
 =?us-ascii?Q?mznBLJNI6QvaXPhHUFqhxS01kqJK6KwlYrQbDzIkx+hG1nedJpCdM4y1DETr?=
 =?us-ascii?Q?cDSDtfyeRY9OQIgkFjC/PSa+M5WEeILp/HFt11ulg47LQsn8ijeTHakJhu3W?=
 =?us-ascii?Q?TEmPTSgTo75uJ/4oIvCHkbJUSwgoRi+HIxHzARdho1j8ps6BgcfO/BKS256N?=
 =?us-ascii?Q?im4uSF3lylTINnK8Cjqyt/y2jyRdmps1mN1z7NT4lbE18yhx76hlIuQ5bwPj?=
 =?us-ascii?Q?tQmLPhQimrr/jJtQYD2jLQ7iex6yKD+FKsY+Dclmt+7P+vUC5iuD9LmB/o0I?=
 =?us-ascii?Q?rua/4f6An0Cj/5N97CD1yPVWXATsNhi8MLf9Rd21HyANuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4bOvnVGuT/zkjWQvJKLzt30kN/bGjr+ZTpXUnHgcY30DtzmfTLxqM1RJRMrM?=
 =?us-ascii?Q?fA5vk5WPbVOtaJjIvlH9diVVrhHbLQQNi7FLMhWh1zVHvutyovB6/JXeKhoB?=
 =?us-ascii?Q?XF+kSrSQCUhrLqe5tymounU/4TqzpLxqapUg4FT9GXNf0RMIN+cLvQuOCI/s?=
 =?us-ascii?Q?lg3Dex8Lj4sXoKLFv9MAjjSlnWbYiu9uPM7HexCs3K4ESnOvOdQEGTMe2Bb8?=
 =?us-ascii?Q?VsCpY2dfHtY/GTXjJ3iVhUez9EB8h5cMpMGVEAT5FJ71FZdG3dI/z5md3yGr?=
 =?us-ascii?Q?xBqd1nYqpChNDREt7HCYoloLTYOqsZxIvasURsP6WtQefz72V0cgtDFZBqbz?=
 =?us-ascii?Q?oeHDw5EpxoEQjjUgRrXOlEU3YwYTnkd8Mb0kNdp4YuYVreCBQ3iMf7MWALYw?=
 =?us-ascii?Q?/axm9cvY29vpEd2AglXk2Q5fzlO6eIiVp8inIdHtx/r7aFQ88WVJmfJx0S+q?=
 =?us-ascii?Q?8+B3kShnFGbY88gmm4SL93HNwBQnVzjIYJ6rIs6hFqBb0KzpP0NU4H5UOHF+?=
 =?us-ascii?Q?LX4QgMVuFUqTR90/VBmaGSz9m4135IzzuHw+tZIxOnY+j4Wt9Uj6VYC7lmVS?=
 =?us-ascii?Q?n4zUzAnfxBUqvs6ZWh/rqg0hXaVS8KejPiwtpjzzbQaq4zQ4o1IRBkqczGYA?=
 =?us-ascii?Q?KspARScBB0DOZ94a9MqkR0sRxX+ZzULk13K8906RAjfb7sVUKvqLprQ0BeGY?=
 =?us-ascii?Q?PMO9I2HebxWYEmuNPJJAhVtPr85sP/pOUHRzEtmuOY/Shl30Dvkn7qeJ1Jq1?=
 =?us-ascii?Q?fynm+oQMy2W3jfFsG57EQWChidD6KDC+PVm9i8P8LITTrjhAFK8LdVoop3JB?=
 =?us-ascii?Q?z3tmUgEpOAxHFKfsb5oy3AglemB5ZIc+4V+unj4k9G7RlDV5qDOoMGMrVnoU?=
 =?us-ascii?Q?HVDZMogef4UqIToWNw6BkRbNwR6vrBRBvwed+9zyo+eyDE1d+ZTSOw4wTrjf?=
 =?us-ascii?Q?s5VGlyaLnHCg0740BOI83qxQUmXWFRGB6W0dRdCNr2y6gfzT5+9o5tTUbv02?=
 =?us-ascii?Q?rICdaArvRgJ6EDUAvW7+VqziVGYAVTaJbB2n04vqBAnLTSlPSKLDVL7JvlJm?=
 =?us-ascii?Q?8lGQE6diBBuYhkvjLfUX/RktTTUNv/E7o3Cr+RcbaIsJwfqGV/TiaM5REoDO?=
 =?us-ascii?Q?IHj/356VshqkajvLZ0uBU6tY1kpCAOBnG38BEr3KEGRFAS6wEFksZGQCgT42?=
 =?us-ascii?Q?cGnjTZUi1V20xYeNOWbqyvXBzg0KKtvrHmHoY3WxbyXjwBanllpWEbW0NOUi?=
 =?us-ascii?Q?LROCjBohXlbuu/Za7qGkHgSxbRocvx1xMs/YIkp0NNta5PABLFTCcSzbemhz?=
 =?us-ascii?Q?crrrLMGCwDstPNidSzWpjPw9mIdCN0865aCG7hhdAdxELCjTkEN7cTgOwUrT?=
 =?us-ascii?Q?b3G7Wwwr15pwIEmyelGELj24V5Q8dHkDqASRFOZSYFDV2xV64tmHUjtdhK6K?=
 =?us-ascii?Q?V7gCyf8Cl4A9Ig1KZ4ieHXabfcmzSStzXBHB9Gcpp6TALznen9M2EAClAQW7?=
 =?us-ascii?Q?8JEFVi3Borm3SyeFTw/bB1xeb4OoolydOOzCJBkz0UG5esZHLf0WD4ItD8KP?=
 =?us-ascii?Q?9s6hr7SOw4epjOaBBWjVGaTZdwUIE9YW1cvfDO97?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f104762-348d-4fd7-a0b7-08dc6816066b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:38.7899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeKAnxSzJpxdIeVvGDBK/oBtGCjLL8IVtmnUF4do847ctyY20Dy4T1aiPnH5ueCWbK2xAA0PqzR58aFET1Xkmw==
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


