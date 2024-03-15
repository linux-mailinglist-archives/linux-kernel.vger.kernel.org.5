Return-Path: <linux-kernel+bounces-104115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E706887C921
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C34B28260D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC541B275;
	Fri, 15 Mar 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f6Utjm85"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FA1A5AC;
	Fri, 15 Mar 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487533; cv=fail; b=QGmE6QPVmt3TFIKMGOAK4+VeDyUEbTmfiopQsQXvHR2DVc3BpF8pOqSuZvszzin2U4Ch1uSwlJGRazUqMMOvqDQIO9rB/BPxvkWfToTpQcKYIZAhD3j+3tdHT+GntrJUG+FsPOF7HWu1qWqqLZlbeNO2VRR3x8AR+o3QeHHMbXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487533; c=relaxed/simple;
	bh=jRcXYiV2blnf/W6QTuXGIzvFmZKwOmrx4hTXKSw8kxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgFFjitkMIGNGZ5U3gTd9iTq+TU39x4dpgg5Ez0usq3axa3vt6MdsGYLexAXGnk1K8lUgeLBJwS9o5Moe+l1fIhPBSvI1EnCLKdkPNi7vosHmnt5oytekR0tJ+vUX9FKJtIpwqGewgmKiCsRlsxlsxh2uP7ST387q3CC2p5xpso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f6Utjm85; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PucX5gvzLf9mp0K3hT/nxyc0CYeX8i2BEIjzQsH6Qlny2DvEi+O6xEIHi5jI3VxFaEZqDcvJDj9QQNGH9JLc8c3Q5aTTYfFjLRuIsGNrOMQzSOzcuxCbL/6REPQgb/UCXOCwjw13YWW9gvz7phPoNBvpShKy32GD+f1Q0OYzVuAT23JxmlCAihQzhdwqKf/E78CvTY0UOS481Mf6ug/m/b9YZAJ1hf7DU4W92QRnrnwWc1GY3Duxm2G0yktpOXy+Qe4N7xsV0TaKvCdFc0MAlY/4sRW0TWn6sFAbTUDK+RBeIn58v69IuTcLYQW7dTCfcPKcLRbX2zmQd0JVGF0bdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arApGTtzxoeJ7S4Nfnb1krg1XZX4OxDY1kiNqkw+Cfo=;
 b=hMiirCDTSA5EW36D2JQAzP46iYhPpZzRJ4MXz2eIqKkTf5JICVic6uPu4K2sUVXuE5/1/LbX9P/3pJTgRwDVdb6yxsDaOjVP4YuF1R1yGUS+phm1j8OiHypFCu6RP8600hvPQnJ3Dymk/f642HC120HHfr1pNwgGhYxeN3+AbS9Wl/BmlrBlnsMUIsfLy3ut+aJ0UU4UmTFJHQK+qYJYBu2yoAcktV7cwBdQM1g/FWugSyCkLA49ReMe4v+//AROZSpq3lsObu0dAfhVfZu1wPSVAAa8Kwwv+65MWaX/rOS4HV7QzAIC3nSLEwhvsSdcrpwMZfMiWQU/rbmQ6CZVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arApGTtzxoeJ7S4Nfnb1krg1XZX4OxDY1kiNqkw+Cfo=;
 b=f6Utjm85xJ12uqB+5EevhZtKPXB88EiVPd3pQEAj8kibXI1mn+6pDtG2eiOQo6WrIpcBVI1o27qV7IDVcu7ZFzuJTLT34LKG2KKkAZHyCqx88lZ0ODZuTEufeNU4QL8HnZUBUaCxZkLN7LcMwag2/vXdP7AkOHN3AZVV22pGVdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:28 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/11] arm64: dts: imx8m* remove clock-names property from usb controller node
Date: Fri, 15 Mar 2024 15:24:54 +0800
Message-Id: <20240315072455.2481613-10-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5836710d-a364-43b8-b220-08dc44c116ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9EYoYQquP4HvXTSpKrjA2oYdslKhlZWUF+j56EZE7ed2yF98CMu8HcSnB1uR3IfrTthV/Nc7+fnfi7dWI8J6tJ1uIscZtk7z3kqdCNIq18n5zwfFq7Nn+uIZW/aWDFzEDtoMwMcn52YomMkENh0LCkDhdaUgnJgqCAS5WyvjOZojLrcfYzANlzwe1RjFED5KhwW7XyT1/kXJ1jqHPqqhCxRPtL2vnC4qiaH+yuI5sGVdK8Ofa4duPav/+d/E1CIkv40JUKZhHBpFs72KjXxS9qRv4J06ODum6/3yFkGiQkIqRUcWUTiN3isqwTqvO4ff3CUzNn+UXy90vPXCjxIWQurfzaNif/TOXhEy66OUfBsWTPmV+37NFb3Ba7dxNnjeJ13cm64uQwowTKUfJT7RsPjWTxjDoM61c56v4SHm0Ktgyf31oZtvzpsCxZ2zVL3HjfJvYv0w+44QoPd7wKpHeQ4qMUzo8V6k/KaEFUGBVHRqb3aUSI2A6/xxTNjLAtG+O3b4RlsncTcJqSI30+0y5kj/5P6Z+w50AAhNQYx/L62iIxSaPB9EyviCl3tnRbTDu2O1luILcXNfgJz2xX0VZD9D6NqAMs/IIY9N/4+rAsLkUG+a3tKJO1UHspZZNl9dWLABUQE0b/DgAEBXd3Zm4H7pKZeMSLQWyOGbYuOqvht1JOaXAKQ2RyA7X7BGhX1oJ6wVItDZ9Yxf0jlOYiMtzxPJ3yEfF7fPfIZuRg79QTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bSpWes2+LraBENf6z5DxDdfz3rn3U5W7/iPinllr+sSdgwdhSvf5dme2WQ2S?=
 =?us-ascii?Q?1hfnGiIfPVR1YEcf+LHQ8zL72Bx6YirFADMtO3U/ounA6Bu1b+DgukMZNAwk?=
 =?us-ascii?Q?zMHRcfqrU5zv2kJx5lk1PRI9TjvioDv2r99PrNTNwW0Ji571hQSpvWWPxc7M?=
 =?us-ascii?Q?dgRYG66ROFyQs+FUX16Pcdw5IgauK36T55WEw+8KWEWgrudShGWxNU04do/N?=
 =?us-ascii?Q?Sltm7+FZTIFlgX0mljjVmv7pxeplkQ2N2ZApJGDZKcJApqwydum8Jv7euqFj?=
 =?us-ascii?Q?Ytw5MYGqNKvEICjDAZcaLtE9zUySCRBtfwF4NtYS9TItD4k46MsZH1D/IF6j?=
 =?us-ascii?Q?lHNbgJ+vPSyCW35cqWrSk/g3S6uIv8Twh3rEj4Tn1Fq62aGRWrgc6sbJU1i9?=
 =?us-ascii?Q?n+W84u0qxzqruK/ycR/JyRaPQ4hjJbGOpjgjLck+xKljPtIkyMgdRBcX9F/K?=
 =?us-ascii?Q?WArseaR/N2NIKUUhY8/O3Bl3wABBlkLCD1nJAE3AucKYvG++AWZhb7Xkyhls?=
 =?us-ascii?Q?WO/GyRWo50xSPH+5XkYDfciONqyDg7sCXgErnxLYf5P78+Fcoq5LmXllGILY?=
 =?us-ascii?Q?yNGvAje4YBJjm472fGQZi7Q2yeNJo1XDPio4zqeOFkekdfHVLXovzLCRZBL8?=
 =?us-ascii?Q?lvkshs7aqTAOMUMZF7uXuSKdPxnUBDusTJMjPIocqt6kSPQdyfUR2GzEA1rZ?=
 =?us-ascii?Q?z1v4/klrGZFb4xwYKmqGpJczejgYnjxJvfqCEb5GDoKNWs6SQCfyQOLBjcoZ?=
 =?us-ascii?Q?1m5bjQ1AwCQeZL1POOwlwXb4h7ma+djFu9/7DAebC8kZo94sfdYrcQwyOXCa?=
 =?us-ascii?Q?pgg9+nbJYTAh+ikEcS7AP0JE2hFei8Arkm80V/1K50gwlQ4S3k55gDviuxgd?=
 =?us-ascii?Q?xHxNDTLAHOiYPYq5H7tv2u8Z4eiCyvacmdMhhsjI91ohL85d5VPHByyx1Tl2?=
 =?us-ascii?Q?1Xkj9dXRt3S0ZeS3rlHsUhqYdD3xUU0L58C66Hm9YHwkV6V5i8dfq2XAZwA2?=
 =?us-ascii?Q?B2pRaDXy2Dlm331vu6eD3GtBn/niMneau2AfWpAnC2RNFHpv3yt9LlwTJwdz?=
 =?us-ascii?Q?KB/5oAfI1Dy/TLuh0oBls8mCz5zRQpyJ5OqWzIhMLGKyztEM0FlI35QFVY3G?=
 =?us-ascii?Q?LxqiAQ2NqFnk5hTB7fEMyFkDNKGyMLi3eeprxTeHNvDUqN9CpAQ3O7vY8QhQ?=
 =?us-ascii?Q?LYSO7RTDAcHFVNkQnyVdvX/DFWNqB0r6j5z5zcLzi0FZG017fUrrsIyxsE7g?=
 =?us-ascii?Q?8v5KMiJH7LraEea6j8AwjsqDYSu8mLfzyxm4gCxOF5rqS6I9FUbC9Sr/m4WM?=
 =?us-ascii?Q?t+xSsIuBLX27NNiKLsCU7Jljly+14mpuUSl3y30re7NOO26sQnEKsv5cobDm?=
 =?us-ascii?Q?nMBiczYE9Yur0Ca3nGKO4tfkSnvSjSjWkhj3eHoJEPRK8B6rgPFt24bR/WTg?=
 =?us-ascii?Q?IyEj289d4fac9LTf7z3tHlO9A9klHDFLcaEBTRaTftDN9cFLmBhEjv0Lwpon?=
 =?us-ascii?Q?5pP1j4wFMSYqatmBE2wRnvO0xfEmd8a+VdHcvH9uQ/jz8NsGxl17btmYKw05?=
 =?us-ascii?Q?lvCzObklwEuJ7VIbttn/XEsTRI7hJVycsbKWPEWx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5836710d-a364-43b8-b220-08dc44c116ea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:28.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/W9lCT+T14Lu16YSw1k8IAw+EOgFhn7DJFewXtSHaORGAW/NLzOPiSUuV6KiGqYGKyujHh/lbed97ImG3HLsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

The clock-names property is not needed by usb controller node on imx8mm/n.
This will remove it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v9:
 - new patch
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 --
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 8a1b42b94dce..696e96b15585 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1253,7 +1253,6 @@ usbotg1: usb@32e40000 {
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
@@ -1274,7 +1273,6 @@ usbotg2: usb@32e50000 {
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop2>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 136e75c51251..f67816758b21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1213,7 +1213,6 @@ usbotg1: usb@32e40000 {
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MN_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
-- 
2.34.1


