Return-Path: <linux-kernel+bounces-128701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07387895E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7241C1F246AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA015ECDC;
	Tue,  2 Apr 2024 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WXiRNqxY"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2123.outbound.protection.outlook.com [40.107.6.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289715E81E;
	Tue,  2 Apr 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091817; cv=fail; b=Mqkqpgp4Na7k/xcvom+ZWT+hesG09PZkZdFxAv7Hv9gtSQ2yX78gn92AbZqImi4H0FuK/uvt/y0Tr883HobVDz7qE1vIYfoXpEGXOqmChy75suFbjcV4vpVkFjBBMNQVCFE8SSYjqtlKFfZK8hY3XxhUNWfMdC4OIPseB2iTE/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091817; c=relaxed/simple;
	bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B0PwFphorUBcaNLPKFGRenqD+AaCxGlQRc8bid8prEG6vK6hmptXz7G64l9FmeXC+ZabeCmEFQLfTD9DVkHox8tZORcu4yBmgMy3v9JsElXPXvKSS+MJkSiAeJ55td+2OgHEGmsXuGRw/Tk/yHojl39Xaj6K0fVmUdgYz4iwE84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WXiRNqxY; arc=fail smtp.client-ip=40.107.6.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX76YVBPQe+jLNvUMMFuvdmtcihDnXyx2uX4cXIuDQI2sVSA3vJGY+ZufBkGIE3RC8WotYdFQ1rpe9o09DrP3Q6k/Wnbl3hJ1KGRJL6wPoRn+KfhbGH6OaGWYS8WhhK+wvmH/JoxsMmDKgw8ISF4yRHKQ9YFxB8H6i8fEyl7hXhpE5c3VSyMCMzEaa+y8vb35heb3v6OsDDlxHJwHDwPMI/E7C5rJijreQwDze0hfR1TXmuclUivrv/I00o3+hfVZyiVWLeGNHRvOapLBe1FUR2a49Af/SvAKlc47MqnbsladhRWYZJDmVrQDdBmxDROy8cUrRMZK9vvq5nIgDmkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=kPAT5+6ArlomovKfmpj7KhrO0TiRqxvsbo6TdUV3VjOKUpzwOzwYALsXDhkjgN3Lo7PTo1uHdAnZ3BSo3u0qyTeUYVZPkRufigfvD7qAfLWsiQItMsAtEftGHaa+A2DWmkxasXj4NG2d+ZoZ8PmswXRVi33Gt3wbOOjcugzuDkMttq7azld7nCWANpuH3ecymtEdyemFnZpVtZGIVa14xe+M6Z59D0P0horHvLDsNpzTS0iEkCepw9u5invncwynlcH3CAyuGhR6XwFB+lHYGSpmdCQqLyKh164ymtK9FH6ts81oQrn8r9JcxJAjWqDdwWn6cfBI4OI0qGGtZI9iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=WXiRNqxYlbCf1pzJKtm8nEsA9GKc0u2WkmrkJ29v8JeHrypiJUkbNFVZ2OhgnUz8wuGCLAczk2sQUcc21Z8nQsLIEXBCnc0ktUMJLjYnhib5DcVgc5W1fDBZTRK1/syHfFZKaokS8EQJ+sOtlEfMzzkG56qrET9Kn2NHsZoqfAY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:03:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:03:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 17:02:28 -0400
Subject: [PATCH 1/3] arm64: dts: imx8dxl-ss-adma: delete unused node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-b4-dts_dxl_audio-v1-1-d26d25b84a08@nxp.com>
References: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
In-Reply-To: <20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712091807; l=949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
 b=QhJrTBSE3g/ISHfFZd6QN4n/pTTiPAKQTBxAj2jiFjtqi5FV4pES5OZ8Ec/ZTeD4oKfWMoo5M
 N4mUA7fmRiRDlqhIH5vKfYIerhbzby9cU2YzSM34yx731kBTfwLiS4G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	03jmBcVtx+37oWlJw+0LQLw9wTwFziKch1/JueCac3D5CEVa3d5gtiwM7GL+fEbBVqjRMpv5XSpCzTdpILdHzWUirhn1LPY/fVdSXmk3PRredmOqC1XwCGzAYLUbYeo7ag20aUlnyfLUQEbC7z3NuOMckyOc8zd3Sj/Lhj4dw+9zH8VAkwNWrbyirFmPWtF043nERoyaZ5QhCx+dVGqYtMlwzRcQDKMThRERpDAsIzimZMpgyHlSzL8H0hiaFgZ8yt/p9vbO+oly5oetyGFPvpTksLdy71+eAOMWMMjHwaQl9uuLDozeupBjgQkfVX/viZw+l3iZJ0LwPEAmlitzqDU9d1Fwztpt6Rg9uOG+4ZZiv55K/uhnVYAIwX78wD176LmvqtZETZPagPCHUCU0K3Bpn4FjUDT0nUefxSRNuYBBaK1W10U01fxFiF2S5A43pjAfPjrMQ3YLfaHA5TbFMGXC+V9G9kXmdfJRH0qG93W6TtSoBA137eR4SlUD1PmzJ0ItZ0KZCvzcT/tCzUTfKn5sKHu0jO5GeaVo+wN7P+e5hG4Fn09ie8wS+2HKSoqDPskHtN5mKWtbQpjp9RMoBO4n7ldvPX5D6HBwc6pjaeB7wXz8kd0Et2clBydGka4DhQ9LN0JXPb0zexfbV6dtEbcFbBglStPO0ssS7uoHONTJtQWwvb/XPKW5NMnAkE7fPHa7cy7xpDlITQORM5hKNWRDAbNFg0FVGbfH2yMhyj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXlGYXM2SlZoWHVhd3JJWTZrZFBVUnRkc2tEUnRGKy90aFZFdHNHQVNuZW5z?=
 =?utf-8?B?S0UvSkRRK1dlOG8wVWFpMHFCdmh4TWZRSVZBWXZkTTVqTERTcW5HQW9kWWw1?=
 =?utf-8?B?ZDJRVXlwYUFSYWhGeUFyRTdhTTVySnVHeXRpYU9kdVRyZ0lVdU94Yk82Tlpl?=
 =?utf-8?B?VEhqOERiaStzOVIrQmgrU0dNRThUU2M5Y0ZZaXY4Tm55c3EvMldUNURWQ2Zx?=
 =?utf-8?B?dlZzdWNMM3owTC9TUHBYeHNwSS90a09lWmFMeEpSTXJLcHhFbXN6VFlPekZo?=
 =?utf-8?B?SjBrd0xxdm9keWRJMjBOQ2plWlJpdkNMWUwrUzFPZ0g5QUwwZkw5REx1OHBz?=
 =?utf-8?B?WkpXclBBbHk2dmg4YnM2eHd5N3dqK1ZjazNNK1hQZlkvZGtURzgzL0xGeFor?=
 =?utf-8?B?MmxBTDA4bzVlb0RNdzBlNHF4NjdoeWRkanRPRXpSVkM4bEhEeEJFTkhweWcr?=
 =?utf-8?B?M3A4QlhUYk5TSU1aMEJXWmc2WW90RFJQamY3NVVHSzBrajdGZi9oQUhFNTJI?=
 =?utf-8?B?WFRRN245Q3NBVXRIVVlZZ3N5RHJUeW9kVE5vR1dWN1R1NlcwNkNtYjB5eG9h?=
 =?utf-8?B?aGJCN1RmWXloMktXMHdQQjFPTWdIQnlVVVJ0b3lDS0hFelpKR25RcjVJSFVR?=
 =?utf-8?B?Yjhja3k2RjdkY0JPWEhSMmlZd3VnQkoyMmJJbXlzRTU0MGd0RFJwUlZPdmNP?=
 =?utf-8?B?ZDFmdGJzMGgwaHg1MjczNGRwY3FMV2x1VVNYbkpZY3pKbVhhcXI2VTg2ckZ1?=
 =?utf-8?B?SGlNZVR4dHJVUTNoYXdPemJpd3UyNU9uZjhZYlFXWGdnV1ZxTDBKT0FtN3dC?=
 =?utf-8?B?UkY4b0lYOFN0K0ZZamR3bzUyY29IUTJPRUZQTXBCRTh4MUdSVm1LWllLY2xz?=
 =?utf-8?B?SjR2V0wwcnFjVldxcWRjVkljNTJXckhkTE8xN00wNjFmTUZpMER0cTZLOHg1?=
 =?utf-8?B?STBaSnUvK012VkxPcU1CM05IWTJLN2hyaTBUcGlUQjEvN1pzcTFuNmpuMDZn?=
 =?utf-8?B?UEc4QXc2K2EyYy9qYlBPZ3RsUURCSEZIbWtWNnhsMWdRTFVDQ240b213OHEw?=
 =?utf-8?B?bVdaK0RSSU41alNMUGZxM0F1bHdrVGg5SDJXWmthM0g5UU9DSEU1dVh1RzdC?=
 =?utf-8?B?U0toV0lrMXJwamIwVWlXbEdlUjFQSERtOWtWSWEvZTk0bVowSEdJU1ZhMXlw?=
 =?utf-8?B?bFduVExkbEFaWVdIVi9La2tSS3JnU1pzYzBvZXd1NTJRQ1FzUlZYU050RUUz?=
 =?utf-8?B?ZXNBa2xGY3MyZDhlY3RTWENrdlN3YTgvS2trREwxajl1UlJmVi9ITi9yN254?=
 =?utf-8?B?SFJrSW1mYmlQVW5zV2dwY0w0bEN1aTd5cVlKQnFEb2FRaUlDTDRrVkpNTFov?=
 =?utf-8?B?cWJTQWxrRmY4OUl3VUVzVUNUT2dnL3RhcUlIVEZlR2paTk5MdFBLRGk3UHZq?=
 =?utf-8?B?VE53WGI5V3pETlV2RW9lbVlTbEpuMXJneFJSSkF1NnhOWWthZFlBRENvUUM4?=
 =?utf-8?B?RzhzZ0s5ZnJoZGcyM3F0Q0JYOWkrYmZHMHVLM1Eva2VuZkNhbjQzcmd0WHBD?=
 =?utf-8?B?S3ZBcWR0Ymdzc1pNZmExL2RCZU1zdWEvY1R2dVIvbThZbUg5NTFYZ2JXbUh3?=
 =?utf-8?B?K3FZZC80NGhMclU1eGdwaERWQUZzdDRQS1BkU0oyakRkcllRQWZ3RVVINnV5?=
 =?utf-8?B?MmZKREZ0cDBLK0NJaEpWTTdjckh4bVVIMXZuTzdBcFE5akZMVDAxSXVlVEhh?=
 =?utf-8?B?SWs4TzNLZjRpNHlSZTdZSURYcXkvMVBKQ1VnRlgyQ3liWVI0c2tNazZhWVA3?=
 =?utf-8?B?bHQxYzJSQ0JyNTRWckU1OXVoQkw5OTJGVVpqSzBRSENWdmM2Rk41VnJ0YkxJ?=
 =?utf-8?B?NkZYR3NEdm9tUGpDaDdKSFJray9jb2R4TW5WVUM3N0ZsU1U5aHpucitPenRR?=
 =?utf-8?B?VnpoVjVLQXlRdHZlVTEyZC9uQkhBa3pYWTFvWHFrTjZwWHBhWHJWUjlJcWo5?=
 =?utf-8?B?djFadmwzek1yOHQ5bG04ejh4TS9SNFNzd0FPaVNPN0haamI1Q2cvL1NxZUZw?=
 =?utf-8?B?UWJIUUVRWUFCNE9aOW1MZno5bnphZWlQd1V5anNJVFYzeC8xbit4VllUc2g0?=
 =?utf-8?Q?stUpLVOcs3Ldj1OvmHG0SKyxH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6461e8-4e30-4cea-1a67-08dc53585b59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:03:33.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caqrfugh2g3SQxkyyYOwQohkc7SOecGnSIXeyEAN/1pfC6GmSKohVI/uc+ZHRPOARItJtm8ucW48mWraSXjO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

Delete unused node in adma subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 5d012c95222f5..f5dcdd9405928 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -3,6 +3,20 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+/delete-node/ &asrc1;
+/delete-node/ &asrc1_lpcg;
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &amix;
+/delete-node/ &amix_lpcg;
+/delete-node/ &edma1;
+/delete-node/ &esai0;
+/delete-node/ &esai0_lpcg;
+/delete-node/ &sai4;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5;
+/delete-node/ &sai5_lpcg;
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.34.1


