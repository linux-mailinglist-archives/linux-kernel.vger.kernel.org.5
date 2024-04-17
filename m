Return-Path: <linux-kernel+bounces-148761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8338A8713
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215DB282164
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87202146D4B;
	Wed, 17 Apr 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kzqb3kN+"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BF1411E0;
	Wed, 17 Apr 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366530; cv=fail; b=c/VwU3gKSILO6TeXuTsGqzhmo1PgikvIVjh6uejREenFYBXy88EAUSBir/hkdmHic23wLl3iq23mqJYVkYE4i04vGXDgjX8b7dr1WUdFMWUPg5OgjTnSV8WtoN5ycyENvXkfIY8rJ1vLjg1c7EBOjXwL3bp94I7wLGfkv1R/g98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366530; c=relaxed/simple;
	bh=+BVPsbMFvje2NRfb+swkGtsWSsA7M8v/pVSqYn2+Jx8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bokCgvYa7ZS4HWY0Vz+WOTtEDA5j5VYwImg2Q59UKiT7G1y5hL4r7Zar3/2s3VyKMeEbSwAg562lwHIzywap8xrlUzOu7GFZ5GrHJxw5AqlptYTEr/gc1HYkrIZuh93WdU58v9y9Q+LWdgwGERM9WIYKcsr12S3xxMsK9JtKWxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kzqb3kN+; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVpQEJXePQAEe37PNDs+wJFJjk6XIrQLoX2QqIAn7k6K+woHLx9+0VB3WiTZJ820w2lTOqUplx67UaoDQtjuXgBsWv2HotrqVRFfiX9w60Wq3a5QIO35wQpnfkAKKdOKiMt6FDBZAvGK4XDNeIrxbTCh4RQENggYp8YDnvdEyLUlZSjneLVNDckN6btnjQ9u6YrUOp7WWTbgjxkSij3vFR3EdVxoiMlPa1Ky5r9wNEKShc6tbeuEXcayDaAXOx9lc6XWhwrv6lqb/1WoIL9XldUClfb1h1i0ZHLeOpSs3L2A60beCwVysrT2/qae6dZeAtQg0AeWiFlvuFiuoM9f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgKdrK42KUG+TVXEyj4o1LR5EJrzb0b3TPA7V+1Cwwg=;
 b=b9BpRUJDJcpPduY5myWs4Kbq6r3khoRVHzNoeevSuro44mkz5zOM9AzFS0MOUzbtzDxUXMqmiJqYhCuNTk/TUIXXjJ/zw/vU4cZusluAQfhB9vnRu6x7XCvovVAmUx/1XRf9Ww8jSI0RQ1jZRWIiT3+VcUztTSx55IM0nF2PFzjCF744EO7mzGIiIuxGO2EbDMZd4h2QeG2NEoddFjAgh8LIwOEmYVEXpq8CVrNG4UewIoIRLltoNFLTbzuuhvwlWw4nxEQikmYNRawWMFluO0fSvD1oXrp4atB9GJjOGEBuxYLk7do11QPVzZpLge5+rzYAlI86nV5nPQiNnMV5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgKdrK42KUG+TVXEyj4o1LR5EJrzb0b3TPA7V+1Cwwg=;
 b=Kzqb3kN+oHhepwi8DmFAGyKudSAZU0mMVrqP9ie3c7aXalythWAUrB2tPpTDWlCGMz8t1N3CGwv7ZiPLNcCwEuY3cxHCGjns1I0iA4yqcxuaSCh3oPrLQhykSm2zArHTGTlen+VwELcrOOQPcoOvhcNiFUfa7W7ghvHqR7oU7cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10266.eurprd04.prod.outlook.com (2603:10a6:800:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 15:08:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:08:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: francesco@dolcini.it,
	festevam@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and sai[0,1,4,5]
Date: Wed, 17 Apr 2024 11:08:29 -0400
Message-Id: <20240417150829.333152-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 8349510d-545f-4e51-c438-08dc5ef046ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XeKDD5ZFagAsmE5NES0UDQjfP4LtDDuEL3fW03R4qYy51OGdIHE1uW2s6ZHlyKCR43dNjALJOAmwcNRvoCQOebs/reh3TliibDwJtwhbjsLXuysZgTMx5GI0hrI0iDOl0mMRTwdf9sfcOQr71i3TV7OQa7ILVCDEtYPKxG2XMUSfZmMkvn+FIV2SyHYGKqiFNBua9kwimKP5A93XwI1XLjWiITtoJelHesIetI9OTYeNF8Qpxn8dasbcLx5RJrMVnhOqEUxQkO5aQiyWHQ8lORIxwotbj5p6LniXTETEm/L/EBS5ac46og1oU9X7cd9yCdt4CF1MP7S8k/zpHNC/QbfQFr75qQfNMkVwgeb9VVZQd/AkEJ+CpuodtKzUfY6OwHFzv+Q2UXtem+FXFwDaGNZpsAiUqaQK1ZXHXcPJfT1mUMeb+7l8lLUfvD7wj4HeE0Yr5aFfZ9EKUc64n3MXawVaefqD7SRWkbykXRQ0qxrHSS8JZAZkTXi7UzXrH/mnBng6V/ZJiOMGe7iG7obnYieT+XOYoWo7xE5QH2Cqr4oUfzehbVROQY9TVGZlHR+CHWo5q0oNnHcrOgIMFNZjJZa+O7fQDw7r6ePscxJR9XwZWHsbrIf5dk1RJi2A+PXCgMZMqOHSR8+nwn5wteMVhcZf3PwzFA09iVElP50U3ylPYLJTPxqJUn9snskoTv/aaBqwI/JD5yqhgxSJVhUw7mJduoApJDMXIj15H/LaEIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFAiY3UDtMC2KyYGL6lmaDodk6NZ0U/VB+DW71P54UKQcaOmtfbkQizks3oo?=
 =?us-ascii?Q?SHGIkeBcjFTUHrUS2r41ZEfbDhrC9VM2HSuqgtKyjs7K5BBCeb2b072z4vXZ?=
 =?us-ascii?Q?MbswDvhBTEzGnDILD1Zz6yCiqATmJqw9Uwi3GTQMP2u2WdGzNGE++CUR2PyC?=
 =?us-ascii?Q?PJuQhX5ux/wLGE/RyTVM+FQhZWFBIkA7yrTJ1yC3UdoFNv3TZBvpARJSvqht?=
 =?us-ascii?Q?W4fQYnNhik2ogabMGMFNhxpOumozoNk6UP94MZAFjfquOM/Ir/yiD2rkOhv6?=
 =?us-ascii?Q?/Cb6xssTLWbM1TvQmulUT+z7hHtv274hWhXbLnfBQrfBkhD+ud3cG+gsYUfy?=
 =?us-ascii?Q?19hlDFXdijlMcHqBLsynl6jz/7tMHXXa+y2P9FDpFHSy4Y1YNCU4XzGd5FkD?=
 =?us-ascii?Q?diYASYa2fODyB/oGGoRp6P5lO2yOOWL54OAZE1izoGFj1NNzK27Bm1ca16M3?=
 =?us-ascii?Q?3BcGoqAw7EhwRTEB484PFlA6/k3s6YUWsV1uV6jyW+AImppi0t/FsFQwMP5q?=
 =?us-ascii?Q?0kc3WMMDrgr8gKPGGTHcylDyj6zwwpqKtDJ4kzFwVFe0j7FG4VM4rUtkH4j2?=
 =?us-ascii?Q?4d/660hYEnvg95lXEkxTIktJyzM39b6H3npt0FSkcpgIuUjyBdFKGTUEMmAy?=
 =?us-ascii?Q?2ZQ8AuhXWo9FfhK/SKBDK54kLGflYCl+GxpN2QfgUTS2sAa9OrJkU0fxsjRq?=
 =?us-ascii?Q?FtRzGB4KTQrljqHPqT9MSLjoqjlkrdLqcUsZr9Agxzv0+N/2z4TVqq2vZ1In?=
 =?us-ascii?Q?1xiYqFiOQhQSzGjwnPVVPEJwfQm9VoBSh+cMWARrGgxtVFj3ZW+EL1oAsBgO?=
 =?us-ascii?Q?90OgPO5ClARqZtRVpJc/auxxCMgv12XuLQhVZaZmz3rUxkofa4WSQXj0oN/N?=
 =?us-ascii?Q?fWzs+7ZFNBre6pUuyzkFPTQK7fR3hlI+ptGiVcAkjsKJE9SBV60M37shn57a?=
 =?us-ascii?Q?fm1NFf/quhnmaXcMd5dozkR69G0tDyelTn9F8TdgywfKZpMgWfvBIN3W9dzI?=
 =?us-ascii?Q?uPh4jtpgQCsv4+h3RMl/yEN9LfJ6FpWwIwWf/ETBtgdsLXwtRQwz5WfRskaL?=
 =?us-ascii?Q?70dgduNNAOTr/gJLDnXFnqR1Ru2VqIF/nsmG/J+WIZic+uZDaTiEVRs3LYn0?=
 =?us-ascii?Q?nd4OvNTr1MCjTXiA4CqGekT0aVcwvw89+DlOy4J3i6tmiFe4N6kb3Ch9WeBF?=
 =?us-ascii?Q?SvswMLy3acB7mpVQy4T6+ni0A43U54hoO0vl0Aq9PPqtXUaehWcZesViys5I?=
 =?us-ascii?Q?+GXSPpx0MGBaXfTaYtWLSE1cnZutWbrcMLjCB0f8WzyZE1SpM0O9sTW3LBAP?=
 =?us-ascii?Q?dSe8QZHp7AuFxAVSImJYBg2RKMKkdzkMUomRWvKlvDjS3r37tsktuCsLiWGn?=
 =?us-ascii?Q?63CMrlQdVI0ON75dZ5+8eZNHlGMUE8LSx9Ukivm49iAL/iOcLyDab+AuOSCt?=
 =?us-ascii?Q?vzToGLkac8NrDgYisu/wCMCwpzlSg1Krx7WY4lbwVZ3RHgDkB023n1ivH1jU?=
 =?us-ascii?Q?qKUqa8RRRXleTKfqjPwPoVc2JcQ/YL4bvsSBrtFqOOypQ4dJi3B++al9SkIR?=
 =?us-ascii?Q?eaFu0EgyVBmT4FFocOypDFSm6J6WhTroMI7pLOau?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8349510d-545f-4e51-c438-08dc5ef046ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:08:45.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuUxRt4m/x+u9F1N51Nne7bN68CcprqHOq4kXTBx+kMoC0tNJPjT7bvOyZVZamMIc7din2CE+iA8eHLFAgE3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10266

Add cm40_i2c, wm8960 and sai[0,1,4,5] for imx8qxp-mek (SCH-38813).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Chagne from v2 to v3
    - using audio-codec@1a instead of wm8960@1a
    - move wlf,* to last
    
    Change from v1 to v2
    - Remove dummy i2c bus to support both wm8960 and wm8962 boards.
    - Only support old wm8960 boards in this patch, which most popluar in market.

 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 8360bb851ac03..75e424e8c8ec2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -44,6 +44,23 @@ usb3_data_ss: endpoint {
 			};
 		};
 	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio1 0 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
 };
 
 &dsp {
@@ -188,6 +205,47 @@ typec_con_ss: endpoint {
 
 };
 
+&cm40_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_cm40_i2c>;
+	pinctrl-1 = <&pinctrl_cm40_i2c_gpio>;
+	scl-gpios = <&lsio_gpio1 10 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&lsio_gpio1 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	wm8960: audio-codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>,
+				       <49152000>,
+				       <12288000>,
+				       <12288000>;
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+	};
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm40_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -218,6 +276,53 @@ &scu_key {
 	status = "okay";
 };
 
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai4 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai4_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai5 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai5_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &thermal_zones {
 	pmic-thermal {
 		polling-delay-passive = <250>;
@@ -314,6 +419,21 @@ &vpu_core1 {
 };
 
 &iomuxc {
+
+	pinctrl_cm40_i2c: cm40i2cgrp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_M40_I2C0_SDA                            0x0600004c
+			IMX8QXP_ADC_IN0_M40_I2C0_SCL                            0x0600004c
+		>;
+	};
+
+	pinctrl_cm40_i2c_gpio: cm40i2cgpio-grp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN1_LSIO_GPIO1_IO09				0xc600004c
+			IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
@@ -385,6 +505,25 @@ IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09           0x60
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QXP_SAI0_TXD_ADMA_SAI0_TXD		0x06000060
+			IMX8QXP_SAI0_RXD_ADMA_SAI0_RXD		0x06000040
+			IMX8QXP_SAI0_TXC_ADMA_SAI0_TXC		0x06000040
+			IMX8QXP_SAI0_TXFS_ADMA_SAI0_TXFS	0x06000040
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QXP_SAI1_RXD_ADMA_SAI1_RXD     0x06000040
+			IMX8QXP_SAI1_RXC_ADMA_SAI1_TXC     0x06000040
+			IMX8QXP_SAI1_RXFS_ADMA_SAI1_TXFS   0x06000040
+			IMX8QXP_SPI0_CS1_ADMA_SAI1_TXD     0x06000060
+			IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00   0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK			0x06000041
-- 
2.34.1


