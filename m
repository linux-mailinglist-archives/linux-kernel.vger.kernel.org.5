Return-Path: <linux-kernel+bounces-98546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D6877BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F828143B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D312E52;
	Mon, 11 Mar 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NLLWXtda"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD21802E;
	Mon, 11 Mar 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146424; cv=fail; b=mWHb6/WQ5WRP7vvpkI4WlLLPWd6Z+8gp0LCzvtq0cZHKxTWVh9SqCRNdBzKMhwE/IAtFeGaVTxU9PZ/kj5k2ESoHDXVWc0TGLcFsQrPEV3lKlU6tes5guz+vvV3BsRFVaJ+Oi20a3ASo6ZE9FY7mB98aHuK9p7I9wlVtGwE7TdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146424; c=relaxed/simple;
	bh=nVLyfL6oAub5QxTBIPSFcQT/DmeiCAhQOcUmVWUAo0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9whxAqS3CFQAijLQStD322q8PSErLLui0pvlj1NWPJdjwJB4sIwp/AGgGLoinWYQYBjr9/q7wuN4Jv1rIBKTWwMr75TYbB7cblhmEITEpU5bntijMPCuuICMSuLJ2NIGJKxDq4CsgcCVjH3h4BCs/EVGS4wZAtpQgGPgNb0Bi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NLLWXtda; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXQeTxQmJ1atz/+3y2xB1A64uJO01UU7x+Vcgf4rU7aS/x02ph5Y5Vixm2VCj4iohD5LD+Q6NhSQIY1vdwxe3KW520k3X+px02pAXlluTci1C/TJJaujhFxf1Mb5C/xfbxt37xdRbYOSa871ZLpBYKnC1hlQhXlljc5vRMSRTeMchsBCYvkl0rLqv84AnOT5tmAd6MrsVBp0vg5Je0qJanu/iSQmtOJxi/fuf0svZgdD8ESYfMeWUMBFdlQaKQFrnhmxX0me+IvMsZQQsRFxV44porfPYwLRPMFHeTUpu9++rvatW6lczdyiVAk4kDHmDeS0bp1o8MEDYA/R6Ulcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRfAeEf6ADAR/D5vDs3vSihaef3MqUZXstlPW6KnM/4=;
 b=OsMlMImBVGxKXSjnH+xdH6v4msLRQvWflS7pJ3QK2acW0kABR9WmFFMnBX+LmNUKaJ4EzpPmPLTZWSiTxcyx+Zofph/urSxUPpmyGxkdlEdg8axRYJLDIbMi+I7q9V22cE7YwPyBDLFoNzvL5c+Z63/nvVgdc3+xHz3Vcho25FuzmGfYK8kpzhY0dsD/JPcI+AvCe1BmPQjfCNzU0PzoNAE5/b/BfOqiNDb+NbVJQ9TAoiSyMA1OMsKfQFFS/2NrJP8F76mWPgiVSxogcFaiF3QWGtLP2G9LiylH+AYit6wY2hw33ATDMdwc5qfv8jpsigIJRIttPQxtrwB8bTORiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRfAeEf6ADAR/D5vDs3vSihaef3MqUZXstlPW6KnM/4=;
 b=NLLWXtdaGGbY+P+tNhdPQpvDK43LlhN/xH0npWQSfd4Ttgg1/J74KKV5gy2OHcfeWpKIajLXw/hQmACMMJaK/yCzvkKmINyZ49dZktWLik2PdVv45GCNX9rmX7y5UM7pWIjadUwWZ8zlMN/Sz2XkwtUtjHmLhOUwKAIhaqUYc9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:40:19 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 08:40:19 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date: Mon, 11 Mar 2024 16:47:57 +0800
Message-Id: <20240311084758.377889-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311084758.377889-1-joy.zou@nxp.com>
References: <20240311084758.377889-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b31cc0-3d9f-49b6-c46a-08dc41a6e231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J1AxOpPEaPMkDL3KCkZ7mCwWKdryMdweytWSfiL6cAGm480f5aGmBptA8os9H6v1SRB934qBHCnOvCUNVUcplbiPrN0VvCWX3+28d0aQasEcMVQGuat8uI7zCO5/YODoz7NBlhJQh6vXHdA3UvOvaZj9h5huYpvdtgzznNU2R7iDg4U8TeiO8xybEtJSpT70nvmkglw+dwH6Loow0FUr4Rq2EkxkceLSRJDBGr2/+gMa6CgZKIsnmpmCLZZ6OD/5L5LQNK+szJmJ/aftQj/6YpOY3y8hKs0u2LaIWm9i/LheSsK4yQ3+EVC3hz3f0NGmjZQIBHVFknE5LBRZ7SdBxKldKT+DZMp7Kf8lKkn6DkzKnJUOpaDC8xEDiBiToK/BKhQCCNzc7lR4qVxlu4/g8Mkczn+ukcQRoGD7G01pR4aSaanj+AsNskKGLaszye1l6c1kp04Qbj9O7aVDgcajrjurzOOx4Ya5OjOfatGgx7apdAl+J6VJZKVJWuda5i1rv/Tz8hqYbn8IRugG25n+/IEm5/7Fq5xYnYb/BndALX0SHRkG4rDQLpkBLmWqCQ6BMR4k8OdnBO9pDCHSPg6mUtCBhkFSvqaFYqKSOF7Ds9uGua+JtojdkZjptEF3kNFE86CMBGwrpItb91lYQbrUPv6ovCkbJ3qDX9RKsWpe9pvdkUfVk8fSVrcuYGfqtdZVk9QxuWSfd2aACROKEcTd7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQ7hZ874SDWOkZTodL9VEQ8/SMODlVTXTtEGFRf6Q3RGR0+xa0qKd/6/J89v?=
 =?us-ascii?Q?VM/E3NYpKe+NCcvqeCX+5bscOopXwETgGlWJ38p7QMt1EkNwxk8DKWiuTvvE?=
 =?us-ascii?Q?bN9fS4AgyuoD/HgjQwaxax7j9PXIkBVTvdACxg3JpRD+q2WcFowMdarNw9fJ?=
 =?us-ascii?Q?0K0zgiegwMMKFu91geh4WrRpOm3HG29A+E6lpgmXxrE5boGcrveTKLiYo7Ye?=
 =?us-ascii?Q?+W0OB7Mko6lhk23oV2YtBurR7siToTtyaXNFCjgHRYuZ34HpmnJC69/xXfc4?=
 =?us-ascii?Q?ut454XO6TL316oOy9Jc72HDhomIGDrGmSWeyA5U8wv0aPSIn3xHBWjMbo0Yg?=
 =?us-ascii?Q?S5cGkK4UXnUhm4kxh9OARHmlJmUZESIri02cGkw6d49pHM7wIoHX7OFoBRlA?=
 =?us-ascii?Q?qJMX52cX05rani2nFTbFo4uRHtz+lvUe7dignClRnphqWyOqYvBCmHQ+OZLZ?=
 =?us-ascii?Q?S9DplL8AE1M0B6uL45Mj00prEJgcE92DfwI1Ouh3+RxnS3TdoeMbvXXylLLf?=
 =?us-ascii?Q?QThyYsuuTK/qgc0xJiayXWPVBf6sxP0DghxzxgZLwxHhuiIjnkbjbzD8YLBr?=
 =?us-ascii?Q?xs6RdqzOeS0fuvOk8y5SPjufoFkvieK1miiaMMbAOPTtcnbD/0flM3e+72Wm?=
 =?us-ascii?Q?PY+WwFFJ7ujikQBn81Nqc97yZj7/3LV3ekfVHPJqLJaT2wuL+6xo9jqWSlbz?=
 =?us-ascii?Q?p99mtI9XKiHTrA27zzw6HWCjkXSO0JasakxurX84oILudBcN2HhZZWAFP/3g?=
 =?us-ascii?Q?hFOKsSol4qcqqU3MXz3hkjC+ZXZSwSh5C1X6Nh0Imti0scTfjgseTHNiIK3i?=
 =?us-ascii?Q?yZPGhY4R69MMlwITDjODBxCLnO2sMj3LsbJ9T0mqVCm7BykLJXEzb6WgCifO?=
 =?us-ascii?Q?hysmleOq/wRPHuQr+yNyJQ0rDyCOw8PXdWbZB7O+ofsJTHJJ7QkE/e3NMG0x?=
 =?us-ascii?Q?WyMjmK6xbp5HBhsNrVmvrN9sxWnK1g5EKQPvnVSHTc2vmhywnC5hHN1uvE4w?=
 =?us-ascii?Q?R8KgvGUA/SIOlJClZhcsXDaKzwr7knkQX8B/xzmXZwyFroFw8CrOS8PSM/XJ?=
 =?us-ascii?Q?RNRiVVBCm2hUSTKhRuigDnNqAEUN+zuqiBvs+H3EXocMylyI1TZuWFJMRQQs?=
 =?us-ascii?Q?PWZJP7hVN6lpPgmGJAPhpP9uVvgeINr/qX89MTKHTHCHQV2urfclbBk/P2Ud?=
 =?us-ascii?Q?4mvu/1Eq1MeLlR/E9ZzHFa6mjDDrT2k6jaH9CvA3LOKJlZjF12vUsizj0m6I?=
 =?us-ascii?Q?WOQVcO7OHQnfTSBXBWE7U9gNPNbEsC2arDwaK6dakvm7wVsf6O5hX0uGrFfb?=
 =?us-ascii?Q?vb2a1YHk12Wxc5anNzhC580itCsql+qUBfQgsy+pVjlLXvMJViBCeNIV77Ci?=
 =?us-ascii?Q?HQvJJqqLgRs9l6lgZHgL/s1j6u03gQrJqOUB6Mzprr+j/sGOr+G+PMBHBK7R?=
 =?us-ascii?Q?nok8Y+jO034tLgOaYMLoRrzSw/gBOgUu+BXG3D0FBeHNhlkQT5us4iuxpT+I?=
 =?us-ascii?Q?vogROT423VrzgQwepLUPNN3zfo2Tq1BgjzDk6qQFQEI7jZr8AuCfa4kVlkpt?=
 =?us-ascii?Q?fFCHKkAEoGU7Cod9jFxYZdBTOKjm6giPt5j7Bs2B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b31cc0-3d9f-49b6-c46a-08dc41a6e231
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:40:19.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGhXU26+X2IOfWS0VRJivYBmTbs6nqsyX7L7dNueO3DfpWLjuiGVPRI9OyQ2mkt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..6cb5b7d745bf 100644
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
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
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
@@ -239,6 +338,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
 	};
 
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
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
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-- 
2.37.1


