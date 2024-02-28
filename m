Return-Path: <linux-kernel+bounces-84543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3741C86A810
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0F1C23C00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5A22324;
	Wed, 28 Feb 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YEKuBjin"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50675225AE;
	Wed, 28 Feb 2024 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098507; cv=fail; b=V1yT22cexfOhn+Mpmlz2keMHE/lNTc03PFz1Ltx7HV+Csk+RCbuHyPGP/kyq3GJZnTHq6s9kesMwFk8psUh1AIm8Teg1g8SO0LD1k+YFqsS+sKCHnm9S4HbVsQsHbOUx9JPaUbksHM2WPGoT1Qg6UCjSgDw40v8GZFFLrPFcrEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098507; c=relaxed/simple;
	bh=fDE9BWjTxN0JFNMOAlkEvZ2Xp4/m3vom/AAIEN+mkLY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cLFHKM7YpRMweRDBS1ZVp5y7x9BzrEPFvzEzL7t/YcWdZt188sODDf9473F5+/SoOvuakxK9Fc2oLeW3f0wQsyDwcTgvJBPiyps4HsOn5c0oZgeATYMzgZ/NYhojtL46Tc6newI789PC1Ycu0fRWx93Sx7PkT0ZE7ABUWey67Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YEKuBjin; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvbB9EmQQK8U3LjafLfcTVsj/OeZ1pVT61LJiX4+v69cNbMUd/BLOzNICj9DOUeCwcwbFlCdlGdJMUZ6Uc6du25AKZ3fQdjtjd0+NQ4TpBMuS6lpWoHwe229RvGQ433Ja/Wpmtgn8Qi87SrStbmj1AMPh/qd8SSw9hDSy7uDE2zhJtxJK+MrS8DECVZowUOlNHSNRxKCy988HTmHgeuQSbs1kD396JOTIWiLWUjsUZJ2Gfot3EsQkM8evybuDO01gqQ2LhomHA5E4Fit4dr4lTLH4nwGjUEwYqe5tEOQ+nNKyiDEuzZD5mZ//BxXOQsKuK6GGhcvoxJiSOhfmFbI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=boAo3WD2rBmAkH9l/4rkrbycJP0qHfeXW38Y6KiQDPDm5urYTdU0QeDqjJhTNwDfPKwwtyjk1mFmTTYVd19l7mxbhejpkeJIL/aDTWvvEhVAFytQSAYiCLqbfQru0RgkJ/UuvnHOhjrPRIwKvlkv39zyQtg07kFDdwbEztXOzHIGucXUoq6/NF8/xcp/mehXzky1hhxF+txGqmRBlKB07JlVAKSl9F8uyNSmWgnngbOFTmuleUX7WR9ArTvvqll40nAU+IGrO6ngxksmldRiUf0mFeHcIyeW1lok6czkuJKN9GyEaSYW8tsB+2njTTII/sGbDq/p7SiP7pkawK0ZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWFZDVTupKRHqGzPzOcozEj38Hip9TgR0m5LQhPIOCE=;
 b=YEKuBjinq5IfiKDTh7KwQ3Lqqb4XPegV6ubbGTbuIS82n6aEcQwuwdR74TrLihk16CkKSfd8sZ2m6z8O/Ts851OokLNlAI/5EbtZIs6Vp0m24qygmLQMGNrYr7IWyTfzU3pwGsmKd41UkmTD8vsKvv4MJPWIHy7o55xWXex03OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 05:35:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 05:35:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 13:43:06 +0800
Subject: [PATCH v2 2/2] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v2-2-ffb7eefb6dcd@nxp.com>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709098992; l=13492;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xdgyrgvjxybTyzDq8X/GTHuUjGIxReFNUQBlt7Wg4qY=;
 b=f9YFYxZSOWqKPqciCGeucA2E7VHpuRFnz0L7kbuHPCzs5l45CeaGfETmDDMXMButZmoao1z/S
 eVWZIs2/uVbAcCRHdhqBbitj4q3zqrgja0wymAosk4YQMPY5XFBHj0a
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: d67fad88-177a-4c9b-e49d-08dc381f0292
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVT1nnSrpMr+52UcuWgLCaBgrthTqCIoN+qJkcvTeNWB9FBub6aP5Hiv3AFEMMDLGRYbNCFI/hgu5LDOzgY5bGALPhW5JR5v1jntHpMBoIRdREv7fDllakJoeGf7zi96RjuBctrV7RfKjddoSA/VBFJRi+Vj9MBdUGO2DsuPwMbCnZz4cug/5AxgmyBFEP3ry2nLxlrwapT/6KofSrIMB019Klmdp7ADUkpaV/n7uuhJs6kMO1BA9QVT270noj3HEU0KyuXeAA4FuUHFLT4qE38xGs7idWlVFq7P6FNExfom6omyRFP0/IiNyQ+naxhf2Jc8IQTyT6Mkxcft4bAyMB5ZN/cF9Fy6UAjTrwmQ2GQyKOb+hXIlJWdZgsl1IrumQxkpjKD8Skq0JA+ZDoTgmH6KOdoVcTtSD8lUn/PCrv6msnj95L+sCGLZysR5CBOwlGLnohnWF5CSK4kQNTKVvjIfc5KqJerRWQOK8uTPkFrWCUQdvKeSgqFOQSwsDU/c7tZACNwwaN/geVoSmn7o1cKNPrIcz6sw3LFo9uGYp1U9IVFsaLT5+ez+vY0SqYbtiqvG9bsuCi/eSs+ycEYEgOp6L+JecbRakwe1nyWnT7BUxMngwglErb7TheCLzygjPbPQpekbu++Uv7cXvxq7Di2YcLv/GJob7WTSpCNlu2UmEFc50iORaJ3txUShLegTrvIrs9J1QIIcl4Oo1uQG16WC1REiuKqkiRsxFa5txRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjI1MHZuR2FoSzBqcm5GRXhJeWpyL0tzTkYyaUVOcUVTaVR0cDFyclZGQmt0?=
 =?utf-8?B?QzQySUc0REdUODVhVHJPTUErZHBNUmFUeHBkZXZZU2RpemZOeUFvSGkzYTlF?=
 =?utf-8?B?V200R2M4NDROVm5CQ1M3aGQwRWtHeUMvTDdhSmh4MEp1OS9Qd3ViQ2NaUTJ1?=
 =?utf-8?B?cGZYak9qQVIwN0xNNUtiUVJaUlkrYmVLSUVwNENzME5HSnNicFVjSCs5aVZl?=
 =?utf-8?B?RENEQytRYXlZS0QxK2plckYwVURtSDlZa3cxajFtNjc2WjkxY3A3ZWkvQ2Iy?=
 =?utf-8?B?ZHhGU1hqSXp0WVY3bmtma05SM2NzQWFmaGRvZVpiQU5yZzhzM2huamNpWGpj?=
 =?utf-8?B?SmxiSVVMWUNCT3BBQUp5ei9GbmdOTFFGc1R2RUVURFp0djlkM1Y4R0hnN09C?=
 =?utf-8?B?M1dGdUh1KzVETnRDYTBhSjVvV1JDa0ZNUHU0MU51TXdaMWtVa0JpY1doVVhy?=
 =?utf-8?B?VVFuMFU1bVdmZDZVYmhwYzF5bm9qNXZhTW9IanhZSGNaaC9UYVNta2g1NjBI?=
 =?utf-8?B?S1o4aWVrT0lqS253QUQwRDZobWswWkFZcmlUdG9hOHQydHJiWXMwT2FVMDVV?=
 =?utf-8?B?SEVXTFRDL0tCazhNK3hLNi80djVEb28rQ25lQ2NKWXdFNVA2bkxXUDFKcUJU?=
 =?utf-8?B?c08zaTE1cERxNVgxV0ZIK2JDdDdOSU5jY2RhMGlhWWgvQ2ZzaHJUYlcraTh3?=
 =?utf-8?B?Smd2K2huNWlOUmp5U2tEQlFISFRoZmFRbzNtOFNRWlpwT2c3Qmo0a3k1OFg1?=
 =?utf-8?B?NUJySVVmckdPSmJZT0FNOW5xbDVqOXpwenJuNVRtdG1aYVNVN1dvcmtlbVhu?=
 =?utf-8?B?b1lXeE5vMjQyRDhXZGRhMlliL2hCYlNXZU9EWmsrOE1FYWFENExlRy9sYU43?=
 =?utf-8?B?bXFKU3Uvd2hLTHEvOE5kSGw5SlBFZmJaTzZhWVJlUVl1U2piQ0NESW9jZFN6?=
 =?utf-8?B?MzgySFAvNitEUldBSGw0SXE1bkZsRFpmajN1QktTUHB0OGFEa1pTbzRsR014?=
 =?utf-8?B?WGpoNm9sMXRzQ0FjaVdNWWFIa2grSlJ2a0wvZlZqSTJyNkI4S2NTcWhTL2l3?=
 =?utf-8?B?ckwweU55TzM3bXRJWXg2ZTRjQ2dwNUFlbWw5cVN1Q3VlTG9Fb3I0Vjl5anVK?=
 =?utf-8?B?d0poVE5YUThPOWNPRloxczR5TlRYbGJObDNNSVhBVlpub3NPanpEWU9wMWhw?=
 =?utf-8?B?R29ueEpkM1pRcVFmRmdPN0YwRkNlZVAzTzJTeWE4aFFGYVJQTGp6bDZtaDF2?=
 =?utf-8?B?TCs1andQU3ZoSUc3QTkxT2Q0V1V4dTBZNy9YeU1YRythNG1MUzd1dmIzM3N2?=
 =?utf-8?B?dFdTdFpLeU1JZTkwbDM0T3ZvUnhyc0F5aSt2aTdpQWVlVFZqRy9LNW1kWHp1?=
 =?utf-8?B?bi84NGV4ZGZYNjNBVnFUbzZzMSszWEEyN2YxN1VxNmxOZkFPZlVRSWFIcVEy?=
 =?utf-8?B?WWNDZkRkZnRhSm9QSUpTOGZHTHRuYU9wVXpNMi85cVlYTFo0bUtlRkJaT0xE?=
 =?utf-8?B?ZW1zS3JiQzk1RXQ2ZXRmaWJNeEF1aTA0RGdzSHUzZlFVMmxTbDkwK2MvT3lh?=
 =?utf-8?B?N1RyekhrZ2t3by80NnhXcTlxeldrc1J3cm14aEdUSjQvM2lmM25QMUdpVkV4?=
 =?utf-8?B?OWlabUNKMkhDRityb0NNR0lhU0tBYVR3MUNmMjhUS0g5OEJ0QXAwL05Jb2pi?=
 =?utf-8?B?U1dOa2Y1TGN0dzNBa1NUckNOWC9OZUlOZU93MEsxZGNIOVBDa1huYWtKY3NB?=
 =?utf-8?B?STM3TnNHWDd1UDR3Qk1Nc3JudGZSM25XZnRkcUU3Y0dMdmVMRXpSZC9nVC9W?=
 =?utf-8?B?WE5TMm8yOXE1eTRKQnVCVjR5S1NlbWRWY3ZuU254ZGRjdzJEejZTanpMNk5s?=
 =?utf-8?B?R0duTHFXd3plSXljand4eGI4U1RkV3htSlg0STVhUjd3VEVENllISVJudk5x?=
 =?utf-8?B?ZjhEWG52RlRYNE5xb0VzUDM5T0J2c0xJeXFua3E2OFVuTlNrUzNVMzdVODly?=
 =?utf-8?B?cUpRUE1nckZxUDhYSXhwbzZ2Z3RoYjZySFA5OFQ3TVlIYTVVYWZCS2xKelA0?=
 =?utf-8?B?TWRkeEk0TXE4ZEw0OUs1eXdlNFdpYk9Cb05YamxyTU9uL1FRT3NqeTBwU0pw?=
 =?utf-8?Q?J5+Pv830dyfRvaQwGZ0QwP4wV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67fad88-177a-4c9b-e49d-08dc381f0292
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:35:01.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrlyRdJS0R5cU0NX/Hj6vzJCCSAe/vRKUyI8200sOEouirH5KV1bmRtx5Kl5uz5/RNviQMjEZs0hv8X9kbZvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has BLK CTL modules in various MIXes, the BLK CTL modules
support clock features such as mux/gate/div. This patch
is to add the clock feature of BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig             |   7 +
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c | 438 ++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9..6da0fba68225 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -114,6 +114,13 @@ config CLK_IMX93
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
+config CLK_IMX95_BLK_CTL
+	tristate "IMX95 Clock Driver for BLK CTL"
+	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
+	help
+	    Build the clock driver for i.MX95 BLK CTL
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT || COMPILE_TEST
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d4b8e10b1970..03f2b2a1ab63 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-imx8mp-audiomix.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX95_BLK_CTL) += clk-imx95-blk-ctl.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
new file mode 100644
index 000000000000..4448b7a3a2a3
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl {
+	struct device *dev;
+	spinlock_t lock;
+	struct clk *clk_apb;
+
+	void __iomem *base;
+	/* clock gate register */
+	u32 clk_reg_restore;
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 bit_width;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	bool rpm_enabled;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data vpublk_clk_dev_data[] = {
+	[IMX95_CLK_VPUBLK_WAVE] = {
+		.name = "vpublk_wave_vpu",
+		.parent_names = (const char *[]){ "vpu", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_ENC] = {
+		.name = "vpublk_jpeg_enc",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_DEC] = {
+		.name = "vpublk_jpeg_dec",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data vpublk_dev_data = {
+	.num_clks = IMX95_CLK_VPUBLK_END,
+	.clk_dev_data = vpublk_clk_dev_data,
+	.rpm_enabled = true,
+	.clk_reg_offset = 8,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data camblk_clk_dev_data[] = {
+	[IMX95_CLK_CAMBLK_CSI2_FOR0] = {
+		.name = "camblk_csi2_for0",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_CSI2_FOR1] = {
+		.name = "camblk_csi2_for1",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_AXI] = {
+		.name = "camblk_isp_axi",
+		.parent_names = (const char *[]){ "camaxi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_PIXEL] = {
+		.name = "camblk_isp_pixel",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 5,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP] = {
+		.name = "camblk_isp",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data camblk_dev_data = {
+	.num_clks = IMX95_CLK_CAMBLK_END,
+	.clk_dev_data = camblk_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 1,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_LVDS_CSR_END,
+	.clk_dev_data = lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
+		.name = "disp_engine0_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
+		.name = "disp_engine1_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_END,
+	.clk_dev_data = dispmix_csr_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_bc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	struct imx95_blk_ctl *bc;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int i, ret;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+	bc->dev = dev;
+	dev_set_drvdata(&pdev->dev, bc);
+
+	spin_lock_init(&bc->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->base = base;
+	bc->clk_apb = devm_clk_get(dev, NULL);
+	if (IS_ERR(bc->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(bc->clk_apb), "failed to get APB clock\n");
+
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret) {
+		dev_err(dev, "failed to enable apb clock: %d\n", ret);
+		return ret;
+	}
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return devm_of_platform_populate(dev);
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+				   GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_enable(&pdev->dev);
+
+	clk_hw_data->num = bc_data->num_clks;
+	hws = clk_hw_data->hws;
+
+	for (i = 0; i < bc_data->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+		void __iomem *reg = base + data->reg;
+
+		if (data->type == CLK_MUX) {
+			hws[i] = clk_hw_register_mux(dev, data->name, data->parent_names,
+						     data->num_parents, data->flags, reg,
+						     data->bit_idx, data->bit_width,
+						     data->flags2, &bc->lock);
+		} else if (data->type == CLK_DIVIDER) {
+			hws[i] = clk_hw_register_divider(dev, data->name, data->parent_names[0],
+							 data->flags, reg, data->bit_idx,
+							 data->bit_width, data->flags2, &bc->lock);
+		} else {
+			hws[i] = clk_hw_register_gate(dev, data->name, data->parent_names[0],
+						      data->flags, reg, data->bit_idx,
+						      data->flags2, &bc->lock);
+		}
+		if (IS_ERR(hws[i])) {
+			ret = PTR_ERR(hws[i]);
+			dev_err(dev, "failed to register: %s:%d\n", data->name, ret);
+			goto cleanup;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret)
+		goto cleanup;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		of_clk_del_provider(dev->of_node);
+		goto cleanup;
+	}
+
+	if (pm_runtime_enabled(bc->dev))
+		clk_disable_unprepare(bc->clk_apb);
+
+	return 0;
+
+cleanup:
+	for (i = 0; i < bc_data->num_clks; i++) {
+		if (IS_ERR_OR_NULL(hws[i]))
+			continue;
+		clk_hw_unregister(hws[i]);
+	}
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int imx95_bc_runtime_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(bc->clk_apb);
+	return 0;
+}
+
+static int imx95_bc_runtime_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(bc->clk_apb);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int imx95_bc_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	int ret;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	if (bc_data->rpm_enabled) {
+		ret = pm_runtime_get_sync(bc->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(bc->dev);
+			return ret;
+		}
+	}
+
+	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+
+	return 0;
+}
+
+static int imx95_bc_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_put(bc->dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx95_bc_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx95_bc_runtime_suspend, imx95_bc_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(imx95_bc_suspend, imx95_bc_resume)
+};
+
+static const struct of_device_id imx95_bc_of_match[] = {
+	{ .compatible = "nxp,imx95-cameramix-csr", .data = &camblk_dev_data },
+	{ .compatible = "nxp,imx95-display-master-csr", },
+	{ .compatible = "nxp,imx95-dispmix-lvds-csr", .data = &lvds_csr_dev_data },
+	{ .compatible = "nxp,imx95-dispmix-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", },
+	{ .compatible = "nxp,imx95-vpumix-csr", .data = &vpublk_dev_data },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx95_blk_ctl_match);
+
+static struct platform_driver imx95_bc_driver = {
+	.probe = imx95_bc_probe,
+	.driver = {
+		.name = "imx95-blk-ctl",
+		.of_match_table = of_match_ptr(imx95_bc_of_match),
+		.pm = &imx95_bc_pm_ops,
+	},
+};
+module_platform_driver(imx95_bc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX95 blk ctl driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


