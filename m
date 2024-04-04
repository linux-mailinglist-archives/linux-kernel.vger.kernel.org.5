Return-Path: <linux-kernel+bounces-131976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F070898E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AE21C29330
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E0131759;
	Thu,  4 Apr 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="UgbAZkMD"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2090.outbound.protection.outlook.com [40.107.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CB1DFCE;
	Thu,  4 Apr 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256202; cv=fail; b=sWogAQpgr5PZ5p3Mbnv8X30FTWQtmMPYmRoZM8t1F52M0OYQlbaOhedkxIKT7DzTNLAmRFUaxbBrQmL8BIiAMY3UDzs7Heug1Ddr8AGVcSblnouzTPghSgO7wxGf5I/gNM+JkSXRDr2FUHWO7b9O4dB8wgwz5uF47yQYGbVn7lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256202; c=relaxed/simple;
	bh=Div5nXBj8/LcuYwR/kfNb2tB3JPfaDy/w5XFXz2HNS8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AI1D3w/rlYVp8B717bUisfoCSpRm/4HDG7hI4NjUXhWOhoXdeFov/nD+p5lx6od6E19iFv86vqBcnzRYMSS2mIKWwzzB+96fou1tX8HJasAJCsxYTTvYOvUBgKuEkT5Ely1FRtcjP7VrUMFJ3XJ6deBeEnmR/HDPOWiFs1Toro4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=UgbAZkMD; arc=fail smtp.client-ip=40.107.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2qlNXNbKvczdmpiNrm2ouH5x/ptpmKDJbzNMQSf9bNy8+7Mprc1P7+eiLG/45L1s64e/8d7J8HysrQeP8nuEr5U1gG4diOOUmvisC9qJziv/ihX2El3ojaO1HQG6s8MsGR3olcz6fDqlqB6CUnr7UTzxNWunYp6B26R47O0s0GWTgupqliRGubShcowkVxtsP6rt89PVO/jawarKVJ2bJcLk0y6NuRltb3nqqYWjKY1T0SU6JC6Iu1OntiRn5vsafeBzEgjm9EEClHAp35A7y/R5tN/XYdbdyKzjQudYzPnTy3Od30onC1XAwgnKpjp8p4Fn2m1NQ2XwW4usdmhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D1cEqMPA0OeCNQiaWcEFD6v2gZtjI01qHCPL6fH8RM=;
 b=FL5VoRfFYQkzUzfTvQIB8ymP25tir7JwQTiJcNJIpVVi8TSbMSFk5rId0zbkVRrkhsKsHeJuDrBwPDfqMm63LeEUaj5AMtzl2lYreU/0MMGccXRJchfWhkQprtI7ABdTzEjCiBcvFGJ80zgJ0J8H2ha1uUstrOHfjpNF+8yTYOwpr3wW7RO+Et72k1pkNq6jqWR2RigEe4HPJaKEVdPzTn4AVtM0TBXRFcrJwlInaH2uxlmBN2jHXOPsY/C/Gg9gCuybs1tK+hmEXx6vLtF0Yj+n8tt0oQWW9LUU6Fswsay8BhYAlvjB/W8quTICTrfQwzFeDdCVjGzQ/dJgvvxIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D1cEqMPA0OeCNQiaWcEFD6v2gZtjI01qHCPL6fH8RM=;
 b=UgbAZkMDKe40zQ3Rk7RVj4vY5HymvFVVsbegaIgUPWfkLOEMCSaKImyYVHskAL1Lg0hP3ZdfqawEqeM2c5LbuCqXGy4hWxC8Ot6g6mqwf+P3d5yRTVnfPDXn4up5Pn6Q9xLaL74dk1n/DAWXX6NIKa+Z2BDtkqS70vUKjUFgZgU=
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CH3PR22MB4337.namprd22.prod.outlook.com (2603:10b6:610:17a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:43:16 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::d052:d553:e415:22e6]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::d052:d553:e415:22e6%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:43:15 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio Codec
Date: Thu,  4 Apr 2024 11:42:50 -0700
Message-Id: <20240404184250.3772829-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CH3PR22MB4337:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R9r7SP8ZxrmRAU1XfrjKOutc7FPp/JKGskmkwGGj9ZzMws1y4y3cRoJ6oR/0T8jhVceecLjYX41/ZZCfeP4iffoL44HQkY2+vwqOaHuKLPLFdO2t+6U4qcLkF7CnfMwMXAOqmhIC7swSBxoFYWP29KdrvOLrD0ce2sUBM8/IdxzM2dWw7liWLG2zlkqlB2i+27Y5kBLrz4QX0Pu/64K5xA7Q+dMrtqgsuA99Omf/JIdLHNH1zxuF+lnA8C6erHOadpvu9COBYvwFDuE4lo1gg1qrj1NaIIXwCj/a3cNFzR6/Y96vwiWyNTc+sG9gIaJbflpVYFSFYu9Fn0XH9k7oQYTJEQXQehbK+wA3I8tuEffFeNyHwhgaQbFVvdB/dTiES7rextvX7JGImkprWOIL0FHUC2b0SyZUpolCF9AnD09Z+DJstuEIrNR+tqA0erjY6rYYs+35KFZEHLhg/8nxjy1pj2Au0emZTgWzGO3IXJek6+lVZzgQbzRvBLhhqix/W6nxJcLaYUgR4Q3OaMELysS72hMEsL9wTHIjMF27mRnyMV77/AFKjOcG/ohOjTySB/ZP204aAnJgm1ZN73xKmfSzHqLl+jJGjckkvShLL7fw33Tq84Oa5jlAOHWxSX7sWr5EW1jc+3+zJQtpJuzhwB90ldsy/rJeA31xlE9KVRZDiqMYin+vO6eSq63FvanvT+B1qEgZLS3UYk+mAuEghQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDptlm+SmF4XYh6UCfKmHGIJHH2z+igJaCn2Oleg0HynnzmANAEu6BXTBAZT?=
 =?us-ascii?Q?50qrLmBiUPVqptodtUTBVQppsbowSWia9d7/49wefMQLyqYCYA0Fh5pldlhc?=
 =?us-ascii?Q?v81LB0XvwT/efCczep2JA0QJOHjDcm9C98Xj/i6EQ0SBgzux2mhTl2y2dTa3?=
 =?us-ascii?Q?+unq4OxUqUYuNcUYwfaAmLMr1y7V8zOWsxcfc3BbVhpyGRk5aPlPRMw5MHsw?=
 =?us-ascii?Q?v7PULERH/kJpX0UfWXEJ8jMyC2tRtCIRztBg5oZtLc6LaWK/vzcbeY0JqEA5?=
 =?us-ascii?Q?2viu3KDaSjbofOgeKHoqmXne2bsGw6Zk6AyLYi+I+FX9OoVXXcGge/1m1af5?=
 =?us-ascii?Q?T49M/mDH1Ls0H31RUys8bGQRIb2/1ECPCXFeQFZa1vs35U3+UveJ/SQy8Amw?=
 =?us-ascii?Q?hfiZjtUl7u/jQ/Iqmnr3cxmMlCBBC5tpHU0uHYbG2r2fvLNRaAcJJ93hCqkL?=
 =?us-ascii?Q?pHjPZxVy8wfkk0m9Wp69z1ulklxlSA8mWmaz72hM/ZHxY2I9t4JiUErTxZY6?=
 =?us-ascii?Q?xouQ7M+oWsZGRmp/coyy+Pqn4KW5wjw1ZpyMu81JmQ9MgXjY/weCWjDSeSj1?=
 =?us-ascii?Q?OWtv4+wQaQBjun0D8ubp9TO+Kkco5kEfzYXqPSm0fL857UPtwEFaY2bViB1p?=
 =?us-ascii?Q?cokxRoYmEYLK7Ud8ibphNXDNGBMXNJ1o01oi34A5Yai0cLN80B3VMjDL78uP?=
 =?us-ascii?Q?8lekNXZcyF6HMkVln/HPQmesAXbWORYxPlNr6Vs+JiUyySqRCrYhem6mOYPK?=
 =?us-ascii?Q?Bs+pmz15mRCtnTn2ptZytrCnYqSOR4YV2K62Do3YxsDodl9rUX9F6WtUfkA0?=
 =?us-ascii?Q?YDLUtXr7ukumRRYyR4w8yzq50oksSYB43hbVtgkVgXs4bOxkX46Xz5uzNVuV?=
 =?us-ascii?Q?74tEhVxnJ1E2cNTyLvw9v1UVwgSKRegjsln/96dl8AfUqV7roNTtawKsq74P?=
 =?us-ascii?Q?LrqNRqx2/XGwxFXVeA+JrV5RdiHb1N4/ZBtvLTSkEqYB+xvpYjJgYMUq+9KE?=
 =?us-ascii?Q?rB5c7N9441QSZhi4duVnFNENJ3Imykg2kryDDCz6nypyBRkXgDszT7Iti/1K?=
 =?us-ascii?Q?vuO2REq/J8JhOD/WMIgA1MG+zOniOLMtW5p0lLsYiY9gQktCj/GShA3Jylv6?=
 =?us-ascii?Q?3D1vpe3OP8rKl+qrneWewvaw/C7TT5DBuel0m6IkfjZAKA/5jGaU1Sf7KnTI?=
 =?us-ascii?Q?MyjbVJGLQofB5lqcl+6UP+u6oaWgNZ/Gz1KEetuoOgtSWMfCKz3kCmlPtRLB?=
 =?us-ascii?Q?lg3MV7gT/UO/PCCfPIrnOKp15TZaZBWQU3sxKZLxThEM4W1JBNZx7kImxrrY?=
 =?us-ascii?Q?kMXD6rjEKoFhytTE57dQbms24IQ7hsKdXUT1+HsrBH5aegkibQ1HUl0OKMPl?=
 =?us-ascii?Q?hSkRU292Vpsz8N9oHk5msvNEu9dfYi1oqLWbHtYAUpXxY8PZuzv+BLXelp2e?=
 =?us-ascii?Q?HlhJvAD2lS4r6E1mbKEHfYd2DhNWUAJIvTZvTS0zLfrK/PkBRa2xTJZBpooh?=
 =?us-ascii?Q?ymVKnli0A9ZIKXJOvCW0/e5YGo84+8AvKr61h3BwkPXU10F2PhQ19YJ/zaqg?=
 =?us-ascii?Q?9aAeFM7YDKJKZSv43Bn6OfUPB4jmIHBktN080aSO?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a600872b-6c11-4841-6a08-08dc54d7169d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:43:15.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUl0NM7zqppO/2e32WjjQ8s4/D214u5RyXI+KsOHsDSr919lkAODMLd9AsksDHo75bAGlLZB7dW55VaswIe+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4337

The Audio Codec runs over the MCASP (Multichannel Audio Serial Port).

Add pinmux for the Audio Reference Clock and MCASP2.

Add DT nodes for Audio Codec, MCASP2, VCC 1v8 and VCC 3v3 regulators.

Additionally, create a sound node that connects our sound card and the
MCASP2.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index a83a90497857..dfc78995d30a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -66,6 +66,35 @@ key-menu {
 		};
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "phyBOARD-Lyra";
+		simple-audio-card,widgets =
+			"Microphone",           "Mic Jack",
+			"Headphone",            "Headphone Jack",
+			"Speaker",              "External Speaker";
+		simple-audio-card,routing =
+			"MIC3R",                "Mic Jack",
+			"Mic Jack",             "Mic Bias",
+			"Headphone Jack",       "HPLOUT",
+			"Headphone Jack",       "HPROUT",
+			"External Speaker",     "SPOP",
+			"External Speaker",     "SPOM";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp2>;
+		};
+
+		sound_master: simple-audio-card,codec {
+				sound-dai = <&audio_codec>;
+				clocks = <&audio_refclk1>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -82,6 +111,15 @@ led-2 {
 		};
 	};
 
+	vcc_1v8: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3_MMC";
@@ -90,9 +128,24 @@ vcc_3v3_mmc: regulator-vcc-3v3-mmc {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vcc_3v3_sw: regulator-vcc-3v3-sw {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &main_pmx0 {
+	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
+
 	gpio_keys_pins_default: gpio-keys-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
@@ -150,6 +203,15 @@ AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
 		>;
 	};
 
+	main_mcasp2_pins_default: main-mcasp2-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
+			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
+			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
+			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
@@ -254,6 +316,21 @@ &main_i2c1 {
 	clock-frequency = <100000>;
 	status = "okay";
 
+	audio_codec: audio-codec@18 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
+
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3007";
+		reg = <0x18>;
+		ai3x-micbias-vg = <2>;
+
+		AVDD-supply = <&vcc_3v3_sw>;
+		IOVDD-supply = <&vcc_3v3_sw>;
+		DRVDD-supply = <&vcc_3v3_sw>;
+		DVDD-supply = <&vcc_1v8>;
+	};
+
 	gpio_exp: gpio-expander@21 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_exp_int_pins_default>;
@@ -329,6 +406,28 @@ &main_uart1 {
 	status = "okay";
 };
 
+&mcasp2 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp2_pins_default>;
+
+	/* MCASP_IIS_MODE */
+	op-mode = <0>;
+	tdm-slots = <2>;
+
+	/* 0: INACTIVE, 1: TX, 2: RX */
+	serial-dir = <
+			0 0 1 2
+			0 0 0 0
+			0 0 0 0
+			0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
 &sdhci1 {
 	vmmc-supply = <&vcc_3v3_mmc>;
 	vqmmc-supply = <&vddshv5_sdio>;
-- 
2.25.1


