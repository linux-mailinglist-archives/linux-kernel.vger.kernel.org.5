Return-Path: <linux-kernel+bounces-102744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC387B6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF112860E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E26E8BF6;
	Thu, 14 Mar 2024 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XuhoAk4X"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B6D267;
	Thu, 14 Mar 2024 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386508; cv=fail; b=buEsMubK16NYL7R9f8tkoQU4IzXU1paxnTshLUnVd9sTwNWkSFXaAXizYbZckdTZH84Js9tU8q3prfMJqW2y8mwgKXYJSQu74QyHZAqg4fFZ/piZRx4+yF3RrpPmYRlFFAxsa1pZPJTxfVRP9tyFlNXnZ1Io6lmmevDPgwm/C9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386508; c=relaxed/simple;
	bh=qVYK2N/YGGCVMSaz17Hn+0Czr28HgFoXlo41GlCgEJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HalLPlicBJPMfqcM4iEwwiQY1DbTugw7J9EUWqLDktpoZDLQ0IOQkY5X27ZdYLbDKzt0oRHnE2gr88etHz4rFdQ5OdKuPdEOKRYEq3W29CGQOtPjZ4AwLfTfxmvVwYpPsVWWqYZthK9w8eItnHOVSJWC+yS3a7mFxHXlpl18N4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XuhoAk4X; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNJNJPXEePLDJE6/WlMjA6z1okEIxgKsJaYlDiLqQa8vYolf1AVMQTm/kfdXlEQ8nW0cz/5kFgPnLrbNaQrlIVNql37cLSWsFVn7y3+51MEcr0dBhutPKPLwGS58SGtzGuhB2vppnwatvECIRawPr0oPaFbVLbnXcn9n8KF8tn6n8LshOQeV05pGWUiGsW/dzYf/t8zY+37PJWDNznYz6gAzBUFSQZLrRhOXccoCyQ8UMRQsxxjnB8mcYhfQE0PWVc0zAbt7Jf+S40xLtLJTw8BHlIersxV0XBilmdZuCx/iSIeGMiE/7rizKcg3Fenipaz+ShzNkqCBNzxMOAllYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvpP9B5RO8NHgruhTLEb7oHco4LcN2i8dyiQvdQP0eA=;
 b=ixtcb2bobxumC4k/AuQybEMwwDJIFrsCfH7Zc7yGdvrkfWhVey4CwEuJ7je5ud+BW4OlvXtybiOfO/SBhyQAJI3x9aeLrBWMjOoMrga4DYyjR17sWU54TR8lvOjnMkYRjQ+9OOzTK1FhWrxrfaH/y9RM1BfUtfp+RkEp15bvPXFAyPPkQ0hlVkKoWu23vpPfWJDMPdKfpr4cd2BrGtIMz4EKInSOhnKSDQ2kxxBmn7nCfYzb6LlhjQAeqO/bTuQdlZrjmPSyL14cMzia5X3BgkE8dr5U8TGHB1zusBjS5LM5y5l+Yk291ooIEHXYd2RilbQJZ7aQXhhx3ZCcc/uXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvpP9B5RO8NHgruhTLEb7oHco4LcN2i8dyiQvdQP0eA=;
 b=XuhoAk4X69nfFF04KT2/UJTxlDnhU0s2jJOlN/bnLEyXSf1Sy1NXpc8ZdbgXhhROJWNieLZrN3A3+ChzELyVfvqWI4ZEX45YcpZwyjKhtT96hoRfJk4MDZ+QRlYjw6YTmiAzsdlNHJSvw2pAcqWSrMqlqo+pjUemcK8Od8Y+7ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 03:21:43 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 03:21:43 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date: Thu, 14 Mar 2024 11:29:23 +0800
Message-Id: <20240314032923.2360248-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240314032923.2360248-1-joy.zou@nxp.com>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bb253a-fe8f-4533-d2b8-08dc43d5df25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdcpmB27tqQb+XxRbnwiQmEuIcTsot1LerqtYSO29+OSUoQxLhQs5EzwyLiQMCVxIYYX/DDrUnqHslMDEk1QlErR3dvGWL+KuYWTLALInsWQy/O0LYY7NQecNonzhdao2PRHySdXP77D+MCBlC1iFJlJnLgnofLw3/inWfsDYM/urJQqQkMLmzrr/1XSiRus9QFUXzjHgHi6YLw8ueErPltdGC9MiJMlp0szXvbEDZRCxR9RX8Vc2en8sVsMmAnP50hOte4mO+/FfjovcOUWfSz2FBJSYVJMT5hdVLONpCf+WfpGYKF3ibQyMA0dqN+ytJeIf36UP6FS7eMv/hKuf6hwaDsCXY8DzyszmCDrlfwu6+hynuuMfIltUvAFvHPuc1u/nEAjdGd9lb+PUuMIKrLZIq0IwMTZJ4xL6QHAMufCVtKFLEbQ+0tQv7Q+3PtPQn/CNBbYB9fEN/xFJD9BmAYMO8R/ElVKYckU+u/8lCD7q/jqslJg8c67VHFk/aDIc6q0NfpI9grO+dZEOxE51K6DYjmmMbW1mfODz5ii0ttdOEIPaFXDokEMOplKaNLBQLO5f+SdE3k0rCBPt25EFaaKhUtoQP5KEHHZrk3fLt1i6U98DcynZTUq0GIXeGAnrs0uKGtvfRb27RSTmKCt7YxenwhfP9H3nkqDqHk0NU3hPIAcSnYzpSU2Cm5vefdNNdDuRIhEV53/Iqq704Qi+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rCqB5BnjcUHMsrxxRtQIqiJlb2bF5UZWH3w23q27JK3D4R7RjJR5IB3QOOb?=
 =?us-ascii?Q?rZW/n9xMhb9J9y3PY+jRfKXt8uUIuRegVAwYMobhySsILYBVbrUHhU1V3T2N?=
 =?us-ascii?Q?bDwCJdLLQJZDsvV0y0cVY79Mll8wBj+kYMto2+Asty8uhU+5JxxClp4Ho4se?=
 =?us-ascii?Q?IGz9d2bKtXf61cSx83GtuZ6jgVMOvSLhF0z7IhrdUupFZ+j4VAaHjjbxGHMe?=
 =?us-ascii?Q?9Q1K87KiabMY1dmSMAnIU2BtFeZ9vMKYT0DVp01FY0cOS5/R1qEiTx4T0fed?=
 =?us-ascii?Q?GWjhqeAwslw1uuQR79l5KEzEyz0NGDBez7191LcGY7WCPPUbIx7Mrr+O9FyI?=
 =?us-ascii?Q?BShH0qhkMdDxjOHMFVQccRBZhigAk9lHF1MlntsIYc3iFXLh4c3yvEpQAR6C?=
 =?us-ascii?Q?vqgyhos8pH4eVCCEEwEAPXE76UuF4Fijr6DBo9OVV9+3635QPJ18OqvOjgnC?=
 =?us-ascii?Q?nbIyxxLiiQGqAxOBp0mFa4K6BG6i8f2R9TzaLD22B9kHfyfzAPV2F2ZdCUJC?=
 =?us-ascii?Q?VAyqw5wDcoqvRbSujKTW+yrAuw1yEj1Zaxz+p40iu1+/y0iq3qj4wBRT+hnv?=
 =?us-ascii?Q?sBkOAQMj3+f5moWVwfzDbrOy0fCg0HyhqrSkUdX/fQ21D8VxK6WztBIFSapG?=
 =?us-ascii?Q?u59T9UaQRInjN4jWHaGA0a3bgFhSrtJFKrKFLWtT85wllnSc/mxFzKCemHJv?=
 =?us-ascii?Q?RMEHtpyBLDREObkOD2OF5jkK4py4V2/SR30H1yu0HVyd88cyZJHeeqqU7d9x?=
 =?us-ascii?Q?FvLfTTcyRYEcAgee7ACG0aF1bHfGFddOJN9Z2e6Y0F69CBwHfd9Ca0roVcLk?=
 =?us-ascii?Q?FgVDE6KdTm9g6wcU7cQg6y9Pkfb2s81xb0dXSvNrkHfGOyckUigzAEn1Hm4k?=
 =?us-ascii?Q?Hup1cCQrHWc+MRCVQo7dY9xHpJo2Yc7k6h11TFxGN46knmsLsT2dodn1JZvn?=
 =?us-ascii?Q?biplfs8AyoIuNuQJ4QhXWVAVC4Zrp54npSccFEmy5MSVHmKC/YIiLynsr7qb?=
 =?us-ascii?Q?AlxmBX5Yfzcff07oQwNhGvf3oH7eVejw3wtKMGEc4kC0p4rKuMNn1MoRCiZF?=
 =?us-ascii?Q?kR7/mHeuJU5UWv1BiK1FvzPn0yFChlkME+FlZh9Qy6t5OhNUSNIJSwCqaFlj?=
 =?us-ascii?Q?JgesZZ0esXTlijwQq07rw7/gQGpVEk7sNXfd2I0Ydi/lOEfqkurXGBJg6uwg?=
 =?us-ascii?Q?0hwBCNkSO4WmKWW3X5BH7ouccLHxPDBZ32Qym/menOKQL62PzvAHWLSIfM/6?=
 =?us-ascii?Q?wWzNA3QkHZOiXzDgtxzdTz6Ft/QYmgYGGL7ptkwvmRbj2t0bIWGZiVWt6qLz?=
 =?us-ascii?Q?bhKA8+6FIPgi/IKpr50RTB+THJBPS+Q5rMcujZ126dfLDNZA39LzlUHVo8Y6?=
 =?us-ascii?Q?XaMruDcFOTSUPLATn4wM6p9Yph9zi0z0enRBCtvtnxjKCXES8QoY2ijJnDWF?=
 =?us-ascii?Q?52A58Jh+B9mygcbKHSA/vXgU7bR+4M5lNyWptS3+1gtmyhts2WH8d/D5Rnpd?=
 =?us-ascii?Q?33Hl7TKxhFq/XTMURU56DOnzpOFlzMhuqe1zW3GTj1WBjoJ1CNhbcMal+Dta?=
 =?us-ascii?Q?tbXWQlOJC91SNkgxCcqqx6kPgrOKd5aJV294SrI7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bb253a-fe8f-4533-d2b8-08dc43d5df25
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:21:43.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBMwI3dNVBWwh3G4l9aYYBHOuu/gvJAVYDp6djxeTS71glxuS+fiMUjlWa/7qu44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. modify the comment for uSDHC but not i2c.

Changes in v3:
1. modify the voltages constraints according to the imx93 datasheet.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..59740dfa054c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -183,6 +183,105 @@ &wdog3 {
 	status = "okay";
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1140000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -238,6 +337,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
 		>;
 	};
 
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.37.1


