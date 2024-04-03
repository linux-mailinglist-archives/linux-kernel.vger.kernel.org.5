Return-Path: <linux-kernel+bounces-129389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D468969FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1541F26DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CA823AC;
	Wed,  3 Apr 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ELEsXi8l"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2102.outbound.protection.outlook.com [40.107.8.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED9811EB;
	Wed,  3 Apr 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135087; cv=fail; b=cT7oX3CLqnq0yYbTgXvBjPi6T/zF476EjEY19p0SbARrRqd05aNEai5x7Az/4SgDIae4DGqiCbaYKxLESpe6CL0Qrl43AepjtToSLmVozPF6/dZm1aec4FBb6vMsIq73dFT3Gp20CUGnmAavi1JBZKKYj7SP6+gwO6iAqzi61pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135087; c=relaxed/simple;
	bh=kqBOoWI7zdaou2UpJAoQ6FCPmLpdX40ELe+qA7BHOro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wet+ou6N6NXtCMX3I0mj0RXTMWwIQhS0X3UZX91G0XGh4tOMCb6hnYdshB7yPIKSXqfxzcsCAwazJ128kdRiistTmBY8jrMzvAaJd+t/crHeFTa9hI6BSD+zoVUpkz7chqXEiHbvcFlSU8p2cSzLHwExK1pMZHL7AET+r9g5bcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ELEsXi8l; arc=fail smtp.client-ip=40.107.8.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyUp40TXUw5a61SB017Uno6g74rArJQxvOiIQg7QxAn4YXpUarDFodzdphYAnxdv7F4s7WjBPtHHeUrQ81WqD4NAf2u8d1dDqE+iiDHRP9Md7xygrVMRDxG4+XuNdDQxfisvmfRu+6RO30D1Vj37E1gZOX5LNh1AOhQEjLwBtuGhpacBgbDEGgat28Afs1jE4hOqbMzdb3zqiVo3VOL1vH41HMS/WwBPdFk+ffF2PzIGwiD8S6wh+sDiezAatgUfGvCB3aDKsrbhgr0sF0bPLOhx1uVgnUgJAG1WgFByXO2D6kL8EdJl1Jyv/ZMPr6BsxGs+SZztvVTzqxG7+OPbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5KlKuuSE+nG2Kb4H4r1omtMTppra/KhiL/CztXwuRs=;
 b=FGEqf82wiHrK5xy3OMnlO3UNmARJvZzW+s8q1p/XBcp1zUxmGtqfvbAhRJsTWJ5vuL2HdnHyLXGPj2vk0OQDsTA45rcvX9qT+no1KsTWFJkHQtMDFUyXESoQyoeFy1b7B7Hd1F2zrmVzF5uxkDxfztqCOuFGq86QZiaY194BHdS4/VOeSZCF9Av6O+fJqHD08i+2lOUOVwz69kD4BxM7pn9XQm4EkuQl4mVfAHMeYxApua/CTShliCv+IFrMYYsAl635L512Xn/ILs3IF6+QC90dcUk5o8XwCJKtaoKT9X5vvO08Ahxc2PpMZlYl+dKLblnKDrzp0SGfHk6OvZGgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5KlKuuSE+nG2Kb4H4r1omtMTppra/KhiL/CztXwuRs=;
 b=ELEsXi8lU6IlB01zAJVzSKtWKgQgktemMGUlNpMXylrqGSK0GlYpj6rcqfwLMVCRlSHfsJbLPxH7X/IzdvfonYEiOWy0tXWTOJBJ/D4tPMxin2KFltlxVndVOn66l8m8ju4p7e2tKWojgr2C1XNwl1H2eVO5PmBDOrtzj4S+Rro=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:43 +0000
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
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 7/7] arm64: dts: imx8mm/n remove clock-names property from usb controller node
Date: Wed,  3 Apr 2024 17:04:38 +0800
Message-Id: <20240403090438.583326-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403090438.583326-1-xu.yang_2@nxp.com>
References: <20240403090438.583326-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0KmYDpEb+EGpguOIMF5X7DRaLNXQZUVeMGYsL7jqae6Acla1WQcm02IruxfjQMyccK0SmxJM5C0V7moWSTZacwEU9WNzelBxSx1vNVTmMZJ9FELmYfoq2+WOO8sASkEjNNChJ01S1Mj+gcsiAj8TrHSYxZckH3GbUxWVKrJyiT6YMK+cyVoy+vdvm8DErPnxm4gfLVfPUFzdU7p/gutb8qYKC9uY8xh6SgNAS/j2k79LIp1QTfg4e4NDaLgHnjC6a7Ash+6Bg0DR1uw3mPMpKZrHexEnPQ9L+Eq6CHdJe557wEqjN5e3jsC4vm4E8fm3TsvbyE/PkI28RzP2aU5cNG1aZqj66R6TaajslUwhcNnEsFUnOxTiwX8cvwwKbQCiPM1E3TiGRJoKXlsFvSFWd1tlgLerC3N2W5251l6QL92NsunNdQixkCXL8W4APVm1+B1/Q+wDBCeLnASTqtngKCH1+5VusOrj7sSCVGI8N9TyrPyBJ9wpGDoks9FaU2oBZtIrGkngtH5/tzQKEJqASh126HZ6TIvytwTWws88Vfu/nVMBZOvsD2mpeXum1hbb7P6JBaPkbD+dbSFqvIEnBK9zw8SRBatshXESpJsTEAdRIDUmEbgyDsI96BKDnIuuiTYGFtML+I8Almsv9NVD1thpBXYsR5i+ExvuTXjssXKs86iPY/UnuoAXvb3HhgRS5g5cc2lUwEGPSSHdKulxYoLnKVtiQDek1qrKEmdxkpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9blppCjJoOXlfpUCD4d6H+4sqPBWy9d2pDY/1u9Hzk+dGs0S/s8QFJ1pazP9?=
 =?us-ascii?Q?hW/3c9/ctJEi2PiQ/16c9loImQsawvqJFJMgGkOatrox+TdCu+E/XMiGNyAD?=
 =?us-ascii?Q?89Zpv/FMzk/I6K7N7vApPQodyBzzTqzbTtqgE3SNhXjzT9TH1D+YUCfAkYvj?=
 =?us-ascii?Q?xCGPz1UNbs7CV2bnFjZQ5GxxZgdZ2xRFRRfLjHefZ5F2URQRJq0sGCQvUKU8?=
 =?us-ascii?Q?0yI7IDFZdT1J753c8MgKa7WJ3Ly0XKJd8UtMBqisqOtV3TFiodNSONfhaL+P?=
 =?us-ascii?Q?rtECPhvPsiWSTRosw5/g+AZjwd7IAvJE0gYBnmOj2s923+j+8uViPxoGpFqe?=
 =?us-ascii?Q?PoKkjgjXv0OMNEnt08R237yo1u7uHrXp5QMyDCj5sC5Y8pd4DH0GqqiIy1pe?=
 =?us-ascii?Q?PsP95H1h30RH91m6I7xLh4Dk1wn6RAQ1bx0POoOF1A7t+UT+RJoJ48yRdNJU?=
 =?us-ascii?Q?mpn+qaDXZjBDUbZFAUAbcDdawKI1N8oFU4hM6MKMFC2DzPg+1Gj757mkRIpI?=
 =?us-ascii?Q?WGUbSSsfTsRhLXOfo3A91VMUQfJKeYDmWkIRc1/wvGK1MqbZmI6TIHepCHK9?=
 =?us-ascii?Q?BKdbfjMobcjGfWxS1KLEIcU1JuLxbZI4lzUGcHvpMZfzdW7QPMYKfWD5H0CH?=
 =?us-ascii?Q?iomfX9MY++Ovuur0htMtv9YCPz3UMl3I6xtZFWzKIBaU4Yh8KnKngppfLvx8?=
 =?us-ascii?Q?0a0hFMspPhBGIjawVDQ8dE70QB4FgpqwtG7lyjwinz3nH5uOuqaE+k6x97th?=
 =?us-ascii?Q?xhQ3WilTQoGN/FnmjEWywa9SCCKdbdX9H5gXIU/zQj4EenFbQSzBok/I9KjU?=
 =?us-ascii?Q?kf0L7+V5SHdVNRyDiYHakHC3Gbf98gj6hiZmhtHMiM3Xy9BfZOEFdQ/ftHSB?=
 =?us-ascii?Q?MKFFmA1Jv1JkEPm4puy00uhn5bov004aywfPO3QuHveXjltnJAA8y88gvHh1?=
 =?us-ascii?Q?xT5apn8MMzsBNg8edsXNBSqDuuAerwP4iMeG+YYhslFXR5rZWCqMaJcbLLS5?=
 =?us-ascii?Q?uvnVTtkjCQS1ojR4ABR/R2/GdHY1vJFfp9qTdjvx27s7qAiD86RcOFtpEpM5?=
 =?us-ascii?Q?FUZC7AyPYZnVkteq3U3uM+EqHHHC2ibPNN7llK4geUWkHO/MPppSnoIhOqN9?=
 =?us-ascii?Q?DxYqGVOLhB8FY5Gpo2jQVU3nR1MIu0/809VL8i1CKXfgEA4vMRGALNZvmXeB?=
 =?us-ascii?Q?cJm4D+J+Osf4RRyomRmQWOwvyGNkg6Hj5A564OWC+dzt7OedzDYX3erh5CV5?=
 =?us-ascii?Q?FNZ2sTwvgxulk+LBkcekh1n/TN+1UNK7lcvjcBGC1jDaFJOti0MfxNh1rmZV?=
 =?us-ascii?Q?ZftG6JQeq+MXFzeFsBZ8YwmVE2eNthAzfCl3pNhRSHx3scCoyBAypame/Fpu?=
 =?us-ascii?Q?gbscbQT9YOkk2l/h1+HSHVTm2bRe1AC+TMnUiKru581zUyXVb9eXfxbjWNlN?=
 =?us-ascii?Q?n2aBmHlQmDKB/YsFu1snWsV/Los71OaZ4oCgqFmlzrMcHQwaXLbmK2fpTK7o?=
 =?us-ascii?Q?/9j+uF7oX1CZb4adqtQilLLk7pBAf30TRgULTEggZ18aaXeIAXG0IwyZNBc4?=
 =?us-ascii?Q?nhPrrAE3COxfnf+q6a6VMTzYWZ+bOQeGar8Mmqck?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b37e1-3cfc-4007-ae8c-08dc53bd19f2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:43.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+NfmkaABJ/TFFIUtuefYQPjJMDaChAHsadwXEw/T9rCSO7efGrlqPZIlFecJWX8octnmLYKsOaTHFhH+y35Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

The clock-names property is not needed by usb controller node on imx8mm/n.
This will remove it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v9:
 - new patch
Changes in v10:
 - no changes
Changes in v11:
 - no changes
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
index 932c8b05c75f..f017faf87ecd 100644
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


