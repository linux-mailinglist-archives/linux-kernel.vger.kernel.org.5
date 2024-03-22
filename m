Return-Path: <linux-kernel+bounces-111800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFE887120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152871C21CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C05D47A;
	Fri, 22 Mar 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GfW4Vs3V"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520B54FB0;
	Fri, 22 Mar 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126045; cv=fail; b=SglEXoZTUSQMpGcpc+n8JAyut+mckhNg+iRyGAMYToNe1eJfwixcksXp8hECt1kqJnyIAU7Yk8lwJd6G3ZJ9RbCbYKuJSdvaIV7wX5QMTobsDYlfyb1w2BHAk0jPNZprr671kOEPRJQijAn1RKBi4jn8jZBbwSvZnx72KcxGBp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126045; c=relaxed/simple;
	bh=x4Agbi4JG6RT6eEHAcI7QdDsYeCUF81txT8lsWqvImU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pB/GFpsNnO0Z9Lo/BQ4eTyONWjbjHN2Q4eFKFOLGr26DtuTq3vU0BsN/w2oDmEofM14Fix2VG3xAwqRMGlk3nKzWZmI/7mmpK7wb138eZoo/ri3bx6kaq1jZEx1OSDB8jPzYMa1wkSABvQGYzovzUz5vD5L4WWb/VQVY/wspzaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GfW4Vs3V; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+VIzEdgDmrC82lfdQ/7Q2PvovYb97o2LpAomwkzZe/t8kUGaIVPnpF5YCT+VwfRsUsqnCCM+oy0ioyTWr3nnlixC9BIJUDSV4XOhH1covyZcC7weUGUCKlxGy9nbfYhgNzvgiTRnIfbqp9G4u7xzFEBaEZNr6o0WkQr2YursSRWmjbGkmkr0SbQfooM/NJBB3U9hVU3P3AUv1RuDlOj1JnTPw1GoCGADzU1GgJIbbZ691yRyR8o1ZkNnEUugbaR2v5nCZF5e0d397SqCcOzSp9lbd/kAwaILEsL8Fln99dVFp3l4e5RcHeQ+7XbFVufZzyTs9oJIeXH2Sn5vb6ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q95J9wkBjmG8HlTJHJKKLK7f5frw5MA4lLnjSh4FkNE=;
 b=DscUzN76sS66EceVMEdGGuD+M7IC3jFr12eiAd0Jt6mYP7eh6FqHnWfLWXYu+0BxdIgMUTQfkv2fCeQAtpD9Ivx2lnbTjzb4fzTymEJnvzE10XtyXZ1SBfniMK/X2o0K7xBtLcChKROORdJp4NpIQvxFTfcogZJ/WwVco/B1yiYZVOWLRtaPXeNC9PQFeI86UwAwmekQ5ekIiNyrtfNDyjQO0CQAaWJu1T1/ciAjRIY+xehBlCVxJnCfQl6DmDeGI5PM3b/6KPu4ur+4Jk/C2FypDg5DMWskO0renOpHCgWGI9zXbpawzvg3sXPZYWLfh91EY6y51iA9vzE4WhZfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q95J9wkBjmG8HlTJHJKKLK7f5frw5MA4lLnjSh4FkNE=;
 b=GfW4Vs3Vp4VVO2bRxXuyDM0iJlQUR973PrFURcFeEux14bDqc528S/ADByH+24qGr+KFUCWvGhTHxc9LrxRHbFmYws6BOqrLTh3W5ndorMld7BmDhhYhdLgBgbZCewsQvS7LFH/IikliG4/w7S8l18ChR3SuAEmixIktxb+Xo3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 22 Mar
 2024 16:47:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 16:47:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
Date: Fri, 22 Mar 2024 12:47:05 -0400
Message-Id: <20240322164706.2626088-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: e775c2ae-d62a-47e1-e868-08dc4a8fbd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QQs51n5k+mQw6TZWA05nxz8u/PuOb+Qd2shssjKB4dm8STbMSfcmZQwQx1NCtHCxH5kEuZWbVdXstDnyBTqhm7hZMU2FRL5RKCg6ruJF+6NjUTt3kfnNQ5HLbGAtX7lZM1q4BWKLErMpOUw8uclMMYSaehRVOu9L5ThqRQHbjOVbw/KAWNnQWBNscX8VtJzfHt0t22C8y2BWxZD6qEBLf0CM1zurSEbxZsQEHnB/QDuQCo63I6NAxUjLc0rPtdenun7hUayBrhYKM3e1qGmPI77jOW6jKxizBa8UxeMju7wUCgqwgqC+oUGkelI7Z9aYQQt4cULJhc+LYNsBr7Grg76oQIRvrqlQusqv13wsNCKljY5+NANr1wh0QdEgScT5U16F6sEU+ppWCBCICcMOGnJw/VbNYpQGFke6XgAQGcu6R2DGoRzxtDs+pyuQg+UEUF1b1su73U5ls4ERzjpquLw9wiz661xFmq4bbhenPQnmgEzqbEeZWT7384IFkQKQSXQ79IPF7Wxo+rzfelZUU5pDP9kj3L0Gvc1dRZ+p/JbP1vkHqaNXMLnM81j2Q8LbIkkk0qYuebNuTarOOD4WSZP9oYD9XDWSAvzdlLLxA8Tq0Mrg9lOvBYHxbPRycDyZX1BuLUoGSP6ZrBK5zBVtQjYmFixLSaMuXnoLo3FA0dmMrYVbmoGihDWIvIfs2E6lMEaAVRwnBZ/BVxQjNtTwPD4LJ47bIjj8h+xJezhbuUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uW01BKcEzHzegBJC+e7UjxBY0+xNpFFnacIfq8Y0xiYdWTKzGdjv5d6k2MDy?=
 =?us-ascii?Q?wQVHGFFJJkEF4Vwe8ezzrCWX/ZnVrZ6aFVR3vHAqePJS4/bJWH/p0TkvkAkf?=
 =?us-ascii?Q?4aENNDw46K8a3ci1w8t0KiXVdqKXztzTUle3JHGWhgEr5OpM5/Ce5jSVh8lx?=
 =?us-ascii?Q?KFJSxhMqpNAvvXwaU9ThLacwTnoRaRVVo0W/h1XcR5Gwcfn6/bEhD+b/U5RS?=
 =?us-ascii?Q?Kav9NHgdv+aOW74lOshQlQ7EZJsjblgK3h9ZRe6USzsdfYfMA/Z1h9KSGjqp?=
 =?us-ascii?Q?0lKYXDGeRBaGILqtJxf81bZf4nyOV/5I7+H5JPti5MdtDqmzDdeOIkhfgRhL?=
 =?us-ascii?Q?dDvBPifdQtvv/jwMQo9Utw+tBULUdOj4UrPYU0KTtHefVXEJTy3SkzEyYJA/?=
 =?us-ascii?Q?/XOqJ21qPT4oANT7LCeTx3sAOw1ljC6eUoo79QJZ6ZwCOWOK2tWVJRQ+bz4k?=
 =?us-ascii?Q?wqPNwND0Ew2aCUxwQ5d28h7P8h6TVFGPXxTa1+/8zVeDFBYUhGQMeAY8ypER?=
 =?us-ascii?Q?e9rgP2RXEu7YcOL/BFE2dCvk66czvCLDJ4k7DmrCfKU8WsXqkhLDQOMcNKtT?=
 =?us-ascii?Q?0mRIeE8Q+6rHdVP59MrpBSmYP6lC8znYDFe1VVudVxM1n+blVKyTHBrMf4qn?=
 =?us-ascii?Q?3qm1F8NkdfIVAmZ36MbROLjI9MRFU5vl4IOuECKfP8kBzJLKg+AaBySFxgNR?=
 =?us-ascii?Q?vblUPK66bHj/6BrieIB+YXS6w2V4xC+3kXRo1UAyWMPLgjCKoHJGzfC1lixg?=
 =?us-ascii?Q?bXBKvdlTLN5QNJ4vfcqPZphrOAPWI3HLqE7wIPnL87EMwZfcycc1UvZdFPCz?=
 =?us-ascii?Q?XD5gG8jAb8xCn158jjm2lwB36Xp6k82WVrQHvMZ+mr0S+vbRMVEcFdp1RbOJ?=
 =?us-ascii?Q?f3TeJ1EAcEX14WP19ss7Y1ies8Xhd8V8AGIVxsbo7loyZfwUr1u3CgMb49Q5?=
 =?us-ascii?Q?sqR6Tq/7XefFr8VN2sduoHTNhfQw1RkM+rqf7SozRGN4Z1fZOP2pOjcC1X36?=
 =?us-ascii?Q?vgzt1Rixhy5MWCzyuj2uam9+zIOUWrT5suYo+TTOyFds0S8FqRcUuczncRJa?=
 =?us-ascii?Q?mkGUSgrM1xRm/7Mqw1V1O2jx8dnPhd/ddr1HFimEmcFTs4PtkP8QxrhphtlF?=
 =?us-ascii?Q?uXFQvNyNMsQ3j3AenO/cJSS6UIq1HqtZ6h9Z754gv1cYfKZmBlA5NUFZNbii?=
 =?us-ascii?Q?r22ST7KISzdYhzSTsmABlWalzFL5OXdBcxfmiIB+v43z2RBLTF2OoPVjlT8a?=
 =?us-ascii?Q?tPk4a/Z7EaAmu8zY/fKbDFRnZZpa4vYiRijQXqnPoT7D+fEpvIyivnKjnTuz?=
 =?us-ascii?Q?k5vxDbl1ilJ7MMzV4+TvvwJ+arLvyxnewFu+Ovc63TmSX7k1y59w24Iz3RHd?=
 =?us-ascii?Q?f1GgudpxVhUhthq3HfyUFNda3ZPBRjnIAHyJe7ALWOZYCUpTEjnY3YaNx5TZ?=
 =?us-ascii?Q?qQK4PQtJOraOLxOckA6b7mEHiI5EvaHWVBAcKEggA4qZzP9U6QvnsEcRjpa4?=
 =?us-ascii?Q?a5kGj0pCixqqF0aYuGbkxHyl+AY8TQ01AeWAf7R4H8R7XIpabog+gQxi5SFT?=
 =?us-ascii?Q?bK6zLHZAxBr77XV/6xGvFiCxjVc47Gg2PaUovo/Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e775c2ae-d62a-47e1-e868-08dc4a8fbd8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 16:47:20.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jbcFlFBYJp4yPhgTH85LE7VsjRKSOo2DYphe3Ly0uSdPAxYupI46paYhodLmiqdP/Q9K6UHzhGNlKqzVejwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477

The actual clock show wrong frequency:

   echo on >/sys/devices/platform/bus\@5b000000/5b010000.mmc/power/control
   cat /sys/kernel/debug/mmc0/ios

   clock:          200000000 Hz
   actual clock:   166000000 Hz
                   ^^^^^^^^^
   .....

According to

sdhc0_lpcg: clock-controller@5b200000 {
                compatible = "fsl,imx8qxp-lpcg";
                reg = <0x5b200000 0x10000>;
                #clock-cells = <1>;
                clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>,
                         <&conn_ipg_clk>, <&conn_axi_clk>;
                clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>,
                                <IMX_LPCG_CLK_5>;
                clock-output-names = "sdhc0_lpcg_per_clk",
                                     "sdhc0_lpcg_ipg_clk",
                                     "sdhc0_lpcg_ahb_clk";
                power-domains = <&pd IMX_SC_R_SDHC_0>;
        }

"per_clk" should be IMX_LPCG_CLK_0 instead of IMX_LPCG_CLK_5.

After correct clocks order:

   echo on >/sys/devices/platform/bus\@5b000000/5b010000.mmc/power/control
   cat /sys/kernel/debug/mmc0/ios

   clock:          200000000 Hz
   actual clock:   198000000 Hz
                   ^^^^^^^^
   ...

Fixes: 16c4ea7501b1 ("arm64: dts: imx8: switch to new lpcg clock binding")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 3c42240e78e24..af2259e997967 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -67,8 +67,8 @@ usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
 		clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
@@ -78,8 +78,8 @@ usdhc2: mmc@5b020000 {
 		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b020000 0x10000>;
 		clocks = <&sdhc1_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc1_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
@@ -91,8 +91,8 @@ usdhc3: mmc@5b030000 {
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b030000 0x10000>;
 		clocks = <&sdhc2_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc2_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
-- 
2.34.1


