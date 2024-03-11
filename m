Return-Path: <linux-kernel+bounces-98759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A2877EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9328212C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0D39FF2;
	Mon, 11 Mar 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cZ+SNbAu"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D63C08D;
	Mon, 11 Mar 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156277; cv=fail; b=TA3WOzUo5UbJnPc7NOVNnfUH2jSdQOLtx+Yzb5/VP0qh6aDfgXQZuEivxvmPA0nTYbN4TA7Boolbcm+KVZcQJNWcbmS3GYI62WDW7nyIx1pLof48k4PunKiFOX1hgh8hcofW01euXKVjQiTIUysMQmp6F/ox+2Mz6V72Yb31XHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156277; c=relaxed/simple;
	bh=Q2eLqGtbdtqnDMuL5jU5fgPfd756WXPUeGFWQy6iTCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWeMzU7GuGnrnyUgyXHMysM4SV8cbM4PB49KxK00JTPdhyUF/DniJZBVRIuBI8CQH6Mds3hcY2GLMJUogGq2lnzWDdIz9WDmu8kVC/nFIrOCmKQqe5c3VpPgMjmuxLLOs29R11UOQtYOMwN2IeJJOTxAafSxwnhLWxAkfEm/ajI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cZ+SNbAu; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTHDP4R3mM2rROHUadZlEoaEyG2gRmQipi0u+Id/WCuC7w8oTQBu3ymEkgPMg1eKYfdln+k/DTNI6TIIpvB4Cvs9H913c4bS+dMig4JlcEe8eXr1zoFJ9+ZN0Db1yEGXY3ghk3UkudrU4bjiBie0VrRrrrHBOJu6Cb37HM/+NO6ggkutwwlckqH4PGI3VbrYCQ90ZrAAJHIxEM1TkQ5CGoyRCQcr/oxLmOEbQHjkYE/ijpWTyLSPrlGf5av06ZG0kuOLYMYDL0jWk8MF5AVZFRXDjie7u8aOITtff9EcNV6cHpILemHlGPTb75f4uAD9Y75asz/bUXuIVDF31SP4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdLF19Jws4piMqTerCa0/qywk3QqGuWAVnD/OhUW/Es=;
 b=TzoTTn+KajDLC8muzuIplNUEIlG9sPDnmqcaDurLnc1MJuayhFAEmE98wlZ4OmlR7Y+LrY8qCNtz92bDDVUVHoArc6FQWRN9gqIjmAxglBWPZb2l1iB+cf9j032iztRdvdWVqpmickOg1Ti6b5iBuH6dAd3jbWYNuEqA0JRZDkO5tUgwch75V7qEEkBeZR4TRorPEcT9oSxWWN9q9AOmolP7GLcRnQd22jtiA3KOWxCQFX1XwWUQEXzGNNH1RkmZ3ocRoU7uq8+WkYlVqG6WZ3ao7hW5GdV19jPfeA/SJ+q3G/esnR233f/w4X1btSdK/HpSB9Isv/NtemCml4MXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdLF19Jws4piMqTerCa0/qywk3QqGuWAVnD/OhUW/Es=;
 b=cZ+SNbAub/cnV+B9aMX9TP99mKm0dxAM4jzZS4nt2c4XM27EoEecWby7ryDYp4NmZlLohHFvw5K1/cfgR2WpzMI3IuFRyvSVQmmlY7AigtwI2s+V9cpC1kE7TdDqwDsSA1IECJqevhRFp1GY8hDmDzypYWny4nZQXPiU+s2mr7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:24:29 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 11:24:29 +0000
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
Subject: [PATCH v3 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date: Mon, 11 Mar 2024 19:32:01 +0800
Message-Id: <20240311113201.664252-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311113201.664252-1-joy.zou@nxp.com>
References: <20240311113201.664252-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ac28eb-854c-4706-53cd-08dc41bdd12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dwvyGBZCvoVN9jRT5tGBdErBKtvYKPiqtTiwWp86vdE7TngvZwKBtReADzXv701dQbYBSG+0cpT2UGtXsGi3sM86Tp2AekGvXVadB/tqCWKvPMliG/seOnlBzDbo4kowsonomjJe36jgm4jJhqt9YGt0wpw4IXB03cUDXuuCUIXrgcpDxva2DHWcq1VZdvkde06GwcMm7ZgtJxT2cPaej//k+sABCcoLsM+mO/QoK9g/qQ8ypPdISuqNEfNSwrKF9vQ5d1WJQ0+2UJ5vJhk6gTtiJCVX3UmzdhYWOE+husq3mSpw2t4TWt96GLKs4D5428zlDMC8ptvmdlQqeUtUbg2NKh6y8M3bmy8aFsCTMa3YwppfcH6HHOncS9xCaZpM+cxb8c+L7pt2sNePBtP8nGrQXBKxEAMWwNYBidHvW1+nPBodcpIAeDR/P+48yEXFcTjWWAZFZKrmYARLwpg8cwoFiEpF7iLFIcLMWrUl1PXYfa99tGEOl86EHMLSJfdHps95w3/5h0dEfLUEZECKOSCssnx84zMo99wfkjybSYR+E/5+ALruXKrEoRsMoCABCX+PGqWC0NQ116xTFVMuC1eRmXtMT49nKl/lA3A5wNdAEZ1hSmP49GApzlwnbUTff4aI/FNNTQtEvj2SBudPYlFML4Y9j0WQ1BS/YCk1CHwnagN5xveM/WgXmEX9WBMzkCvzWTCAqHnq6JuPB4rw3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVLRDnLzch0oWj4YyiFn0+x/64K4rcj0UKTAjLlkQ/QD3kxUsulrCS62CrYX?=
 =?us-ascii?Q?2tkY3N554ZX7ANn3VroTYkQ+FYyTq5QXeyFc0j5WdClnSO1EnzxHKHp5YgXo?=
 =?us-ascii?Q?EaRV2NOit5wAJ9aebwTPYt9X9u3B+x9ZfZRXAvT+/ccWpX9sDUkjU2uDw3aL?=
 =?us-ascii?Q?b9ElRFyWzLNfIWUJauYn+xenJqQD2vQE/VFx/GsFKQejhVANATumWO+2Rh8o?=
 =?us-ascii?Q?HPzEOsG6TkA3gZdw+ce/o13eJrhHrn0mspXd8crdA5hqQi5k5jQurKHb4Fj2?=
 =?us-ascii?Q?eu4+4kUas7MRfMPijbb1Zh7SEYbfaHsBPTE7QmcYIxt1qLseNvk/j6+of1oH?=
 =?us-ascii?Q?sKK1x9S7kcTJ1wSfF59sCZZiYT8ysSBMH3c8P/CKmoD1yDTJn1mFKNPdNcU7?=
 =?us-ascii?Q?AnhBgBH+glR8qWHFrkPeE6ciw+NEgKbT0vEc10WanMTcdX+hpMsRp374io3h?=
 =?us-ascii?Q?4LPxJGQYCvQYaw5U8cHda9m6vsLW0YgVX19JGO4EAhb1wj9mV4J+um2TT3uJ?=
 =?us-ascii?Q?Pgr9EqOfu6oKrk7pB4ab7pVk2XFyfibnK35O8YaWWchPTq68ZRxt4WslXe+b?=
 =?us-ascii?Q?0ljjAbV3pqWq+X9A8VRkCvRMfrK2PFhBxKNAFl2vagduLBA99NpYhkRuugjZ?=
 =?us-ascii?Q?FAEeqjZUgASoOKivTYA82ALxEC7YmLTcAwC/5TsCzTtQQ7/kxCFu1StJKwjQ?=
 =?us-ascii?Q?Ym3VFXnKOmV/Ai3chr2w0DppNPCr7K4fAUDIt03ANJeSsEacB0sVW6DNJ0Nm?=
 =?us-ascii?Q?kdzdGGPUvuLjMlsvAe+4ezCe6f+I52ZJWq5+/6isJQry1wZT9ey7Qbt070E9?=
 =?us-ascii?Q?OKTpz772FyEQN7FWDq6ghRVKRH4Uw6gz4K7EkeVfuNLhWoWNWzTgn3sLhHd9?=
 =?us-ascii?Q?LZ8HSVUcSJ5wIN8EVFtHY+dnLugYZheXLYaFELW2fts6WxVkum85CbgisA1X?=
 =?us-ascii?Q?sjb6JHf7uCb3y2jU/zxW14nTrlpSlWdkYuwX9aVSOTo4/eeVQXUNqdrJXAMn?=
 =?us-ascii?Q?5sfxsjF14QKRK5K6wcFBc8947qVzaBCB/OIw/ny7S5w70EPBJymOmEVfM4GW?=
 =?us-ascii?Q?qz3Yu8Wnn53dDIUmJ83WI0ElaRxXh/r/w2SXIy3D792cicpbynB8wnZz+tFr?=
 =?us-ascii?Q?OLJp2RlM89cgqGz6dJpMAonyTyQqQ+Ea0TInUcEOM3IhBA5X2nBBVZ4j+IU0?=
 =?us-ascii?Q?Sfnnve5y8lTPOb8UMtDomKp4xIeYtPxBIJi7lElB5Xk57WUj6oPItGQ2XGfI?=
 =?us-ascii?Q?6YcmyYb2ZpDaYEgXtPbnqtCXTWu5rvXE3AZDBp9cCFQeNVklmPuuA7gpWsgj?=
 =?us-ascii?Q?W+HNsIbg+S2GcRthbd44FO1ngXmphr03Q8ZHkw8GRfZoqzAmanEbMfHum4KE?=
 =?us-ascii?Q?nxSP33MkVa17rlDRTTRO21ozq3Ug9g02Uea9l7yGq4hTgizHdKW1A3m4VfDd?=
 =?us-ascii?Q?JzbWhVbIkptyBs0DeidQICNDhoV2vhPj6B2S28i2c7YyyV23NhSdRTh1A9C+?=
 =?us-ascii?Q?DN0ay9Wjy10LbxYbflqTsXsH271Mi3J1FTuWLE3xfHmZmOzqY7e4MLCLoRi4?=
 =?us-ascii?Q?gMkeV5Ck0H1AY543JaBQ3NKea562B0l4XlBigQEw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ac28eb-854c-4706-53cd-08dc41bdd12c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:24:29.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U9emIJS4AKF8Ot3b8tnLkgs/Z/bf8wfcY5Bllu3pGhPz3JRM6rIUYcmE8NdzS+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. modify the voltages constraints according to the imx93 datasheet.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..1efaf1ca3504 100644
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


