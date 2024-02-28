Return-Path: <linux-kernel+bounces-85726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFB86B9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAA1F292F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749B70037;
	Wed, 28 Feb 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iH3Z0KSh"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE020DF4;
	Wed, 28 Feb 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156042; cv=fail; b=Xty1+6q/nsA/BpriDnnqvylYV0aIQceE2btEh1hN7w7bwb8bxWGIDdS7b4z5BQk4+Lf5lA43PTa68+2iAStImWP0xp+Gc25jIEZFiA9rIM7vi5Vqm4Hne62MKrNQDQ82Sj6W/glIZacF+3pG+bT6Nra7fn/MOS3Ui5vcyEmJQtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156042; c=relaxed/simple;
	bh=SEIsL9UwhzrcjDs50PF11fO17sKUiy/+4sJyr3mfJek=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HVZmyHxVJKAKheS0HtGPvCFBtSSd2xTkezFMOGqB4rTVE9z3Kz9K/nkJS0u8bvPoepGVmpLdMObiWo+p6koz58uPDq76+cP+vM8cDEpm2B5PX5Th6YQeSzj4DSXX3BrMsXhsJd3NjmltE8HYVjrOAivaTVYds479M7OT1sD9zn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iH3Z0KSh; arc=fail smtp.client-ip=40.107.6.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPTi97qx3ANcDwA7ud2e7akQfU8XZSrZqct928Lr64vXaKABbuBeP8FJuAxKcgV+cS9ISiZD3Dl//BUVEDDhoQcg16VhsnSNtcc3qKe980w0kObuh+mAmyNxVGbbzPThmCqx4GpgMfHauu4jT9orvPuXlww1Lc5/L0rf6mL9z21zZ05IA/CEQiPWnLkJwEgWdPEPdJkG3RC84RNI4FLah/fqchsSQRJz4NXuw/BQKCmdmVEoTzdWHJOdDRVKRrHAZgHuhEK90HeKtgVYaj36ZPrbQhmkbFNpP1lV7dpIIatv9sLWaNbMb81wqApw3uTvtBHlp/9i0l5RFAizr7O7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQMwrNtot/f+LQElR7BhPcRNEpdMIcLYWX3EWOenaMQ=;
 b=mKffa/K+0H9xkgJCwXJH9ZRIjokA0aPVEL0fcJlGCObFbDXMpeLWcXszFMh7/V1D/Rke+MYNehBTwxdzg4pJ9KjP1da+EXMlHMxSGv3SRGzVpbZbccaJRP4kv/PkDL1OIBVis2XoJVFoMr6ThUqpG+HD4EzvwzZLVsBvMBobpfiV8yO/GkQdlHcL6NinMfTjAfweQVhnYP0fkLf+IQyLTxzpPXXdGlRKy3qu6cUVu81hGEwlWGspmObZzr0pym98snv/OUknV3ewHPpyJta8zGqCU8YoPc289Dd1s82NAquLt4Odph6mlo05QwW2weC1FtPfFj5GInfMmrgUi77sWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQMwrNtot/f+LQElR7BhPcRNEpdMIcLYWX3EWOenaMQ=;
 b=iH3Z0KShFpEw6/v0M28HPz5VR9na+U0jnwlRIeupP28slJNlUk17OZ+lTJqttAXmSX7VLBTLN4IHaj6i1ZygEhjtWo7NV2Dylm0zgcEwpoX6mjoS85mOHFWQ2kvZOANNjNz4fsjx+is7ew0/zBiYiPL3g7Rnrjedd1BPNQA2O2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:33:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 21:33:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Date: Wed, 28 Feb 2024 16:33:43 -0500
Message-Id: <20240228213343.631846-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f638f65-62fc-4ec8-f542-08dc38a4f804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RmyIdUbAemARSMcm0ogilaySQEOL+wZN+VUZ6rKrt8lbX6HK01v7aJYsJ3PBRCAL8ZdsnzBQfYfBiTSMDzpq4GRK3dJQ+vABRn9hdgtXpyeox+8Jy/iCQA0ZurPqNItpgeCsR5F5nkvvXazwVEiHieY8lbYzjCuRwreMb1mhSqlLm5maQCqNPAevPT0nKJW/Wsy/L9X8S22SvtmEDFya8f/dAfmPilLga2eNxmRoMfkCAMrVoUckhwxK8GdQnVHUjjwgnl2ZlK7PsxYRBr09VWooxP7hBZN7OzQY9PvpZsvjsGq7FBHKT2oN/I5oLIvbz0yU+TOe1WX2rPR0pI2+ooxiCh2LW+I6SsIszs5d8vEdvgmt0y+NDHrIzK1Vhwnm3DNw4qpEi7ZZABFodAlyb/XnxkAyX8W9Uc9Q2TdV4GUtV3JCk3gPPY8upjdei4fDl2YjbghqrqT8jzsdRlUYaLPFjbfzi90RbDAlLPx2gPM1au/A91C52Rx+oA2DgIXt8rEM1AzCIRgW2ChHHbcEqXr1OJ9USkHkrfQ18bvtwrklltC5KhkHi8FwG6uXnh6adWe3d86tnxS7LzLnifILK3Hi4zQDlqM9I2zuQIcnimxDjH2roUTGGpYZ1SbS0er2SWXtRdmPf73j6DAioVFr5ECY2+vcxGiyiHzKEEGg6+GXWZwDssZaBSDxHc4YemhXLoGtrga1TGuYkwuBNke6+qvjSn4xaYw1bc8GZDpGv04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ME3xbsWMelA7oGzDaUsOzGF09+qg7LgDeuw+SngWU91GTFWD9vIaU3yMqUKP?=
 =?us-ascii?Q?nONYlN4GICOcrZYlhOI6sCg4chuyrosx1iAS4TOgkLDxT/FoFhqvsQ0xD+kv?=
 =?us-ascii?Q?2PHQfocaMjvX/sGi8JnTesSXzRLvBzv6oyLh9OIM+jiQyz192Rz3YW7d3nDc?=
 =?us-ascii?Q?Bv3Y2InOtTERw15rgkdWMpLyLYIaMNvXXwh/qEa223o1fv6syl9EVz5HhGvm?=
 =?us-ascii?Q?hi9dxvZOfovIT+Xv16V9YvPBLPLnoHIr/PR5wvxIUVgBr0duJ9I3rvXj+6sY?=
 =?us-ascii?Q?moS146IfzvlqT/y1MrSnY9LiqF+LZDrBlamL1u8mWyf/vQC9yLhksaYdjPLg?=
 =?us-ascii?Q?SYh7Lt4PDTIleoLpC9eESpHMRGDrqIoj8qaXEx6pW/UuQVAks7IRsjwZGs60?=
 =?us-ascii?Q?qG1HTNShAN6eTNbbsuXQQcgHBxgbXoT3TFUKl5aI8jbBcHynBcn4rBU41C9W?=
 =?us-ascii?Q?EiZyl1jylyYI/iUy6HVNZcqBP27Bgfq/Ya3gEAKDRgrE7kn/NdYyau5KfvG5?=
 =?us-ascii?Q?Q6/ZKh6MMU/7UF7Wo6DXZO72Ihg0roLSqs4RkpLWa0Vy3JzkzdET3utNferm?=
 =?us-ascii?Q?IY383eFfC8wbNH0hmgAtRO5d4jhMWf2820/1OxbcSu5eyUGdtVvzhPmDDXIV?=
 =?us-ascii?Q?Uvxwl82v/9/LpxgMwdrDc6tYnPj/XiHONkP7h/M9T9/OoHuTIDhUgOFGn3lx?=
 =?us-ascii?Q?5ZeOkI5eWs6oEzFI8pZTNesrEaTmZTvUHDcL67VyE37we1L2sd4YrGzHz/zg?=
 =?us-ascii?Q?pnc3dcIlnP22fR4mobOpxB3i9u/YyM0j6TrBZLEMkZiJfp0iL9g8tKBJ6VPT?=
 =?us-ascii?Q?7AWFwtGmQF2FNegbWmgc3pet40JOCK7Mfrco2TSJ+ovFhuNwG5/ZoUB2kYW1?=
 =?us-ascii?Q?G5EjbhAwW3a9UTnGVxFV9IywOLiyHqZDUwCK/XGRbGLpJDL0jGyjAKj9zYbT?=
 =?us-ascii?Q?XC/hm84MpjVnP1vJuFmmybS8jT6Y4HqpL5J1bFKOghiOXLoQ76do20E+2IJG?=
 =?us-ascii?Q?eRgaZOSWbM8p9NSqPV5TldgpeGjxvWHCw4nkDb6jeUwgjlsJqS7CcfsAc8xI?=
 =?us-ascii?Q?qP5xaAoWUzRl983theoaRjtXbW4jr9+R2Fcjlnt3vojwuiwpcU+ApNjqQqbs?=
 =?us-ascii?Q?LU9ygJAtNMkRDq6IyszAkdaGNC4QHBMBn5QZPw73Pb7tOpUKxozqR8N0Lk/d?=
 =?us-ascii?Q?1dVuzOW3qu4wEupMRttw4fW57F2s7jtsou4Z8EAEL68wjwczn5XPTaRFf5/F?=
 =?us-ascii?Q?loTNVYPJu8FS6Av+nvAOjKs+Sw0vVQKruw4xQE3mLF9X6D6thF1CvD6gWVUH?=
 =?us-ascii?Q?ss9vkZvAjcRifnBzdpZCTYAPLCEKPf1S3oAQ30EO6fdisL+QxGuWqX9R451s?=
 =?us-ascii?Q?s+UBb511kUjWg3uuX7BQa+WIxSP+gVWtOiRLrUda6N6qcqyER/P3XXLeHSqS?=
 =?us-ascii?Q?287J+oCquNUeptakWQQNHyeVk2AKu9VLosTLhk1kFv7PnCIEdGd6fAdPJml0?=
 =?us-ascii?Q?DPJmo3zXMdY9SlCpwvhiJ7x5YuJBGvZPDYYP7WSlb+i5Sd/LNXPN8/cnbw/y?=
 =?us-ascii?Q?F9HJF0sVhACrmcimUbZk0exoIycuH1aO4gcizTsM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f638f65-62fc-4ec8-f542-08dc38a4f804
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:33:56.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTMtPcBqPlTcnwt8XCdvcufQmCC334MqpK/ucbdlwQ5unxPFjrgiOjXDYL6eRJchUS+N1IStL44F+ZvGCq+BMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

Add lpuart1 and cm40 uart.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..3c3dc44e2957b 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -16,6 +16,8 @@ aliases {
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial6 = &cm40_lpuart;
 	};
 
 	chosen {
@@ -51,6 +53,24 @@ linux,cma {
 		};
 	};
 
+	modem_reset: modem-reset {
+		compatible = "gpio-reset";
+		reset-gpios = <&pca6416_2 0 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <2000>;
+		reset-post-delay-ms = <40>;
+		#reset-cells = <0>;
+	};
+
+	m2_uart1_sel: fixedregulator-101 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "m2_uart1_sel";
+		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	mux3_en: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
@@ -354,6 +374,27 @@ &flexcan3 {
 	status = "okay";
 };
 
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	resets = <&modem_reset>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&cm40_intmux {
+	status = "disabled";
+};
+
+&cm40_lpuart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm40_lpuart>;
+	status = "disabled";
+};
+
 &lsio_gpio4 {
 	status = "okay";
 };
@@ -595,6 +636,15 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			IMX8DXL_UART1_TX_ADMA_UART1_TX          0x06000020
+			IMX8DXL_UART1_RX_ADMA_UART1_RX          0x06000020
+			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B    0x06000020
+			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
-- 
2.34.1


