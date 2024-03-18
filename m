Return-Path: <linux-kernel+bounces-105907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0189187E644
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2168A1C216E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8635358A5;
	Mon, 18 Mar 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sFdlv2os"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150E2E85D;
	Mon, 18 Mar 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755343; cv=fail; b=OIjhaPxi0WrDppjOBtSiWRhu/PATRmJfvxhHc+JUKAVy1Vr8t0k+5vGf53Wv+wGqQi8lxRo0D5+ES+1bzs2XiMyR9niglfLFT34MwaM9KLRVLFEhXqtI0nRGtUzizVoIh90DF6SeZwudrmcqxx/WWTjoF0wvzmUP6tCTOikWT3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755343; c=relaxed/simple;
	bh=N8z57Dl5gheCpgM/X0woyO5vQavBrbt4clMFKAkqHqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCI2TIaXBUqPcsJWYp4YACnoYIM66s2b9nd0fk/7ADkcLo35T3iksxXJ5Sfm8yvSPQwE8BWizOFQvTpstnMnIOv/mMD9JQ0R8CVAVZ7Fm1Xd67OSoR75FbqP8uMJNjqDCluiUnWNSrRLoRMKPT+JyEj5lnBKdqzwG1MlFdjgnqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sFdlv2os; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvakmKRA9tw1pjupiB65Ejd21q1JwrbYYmmTUa0e+9jayDk5Wc+6ZJOJuTyKaDOgi8AVcXgnGTfwUw5eRbuu2sNtC7A9IJEr0+GLTJuj2F0Vn8PMqwmWw51ywvD7KjekHe35EkAUTAyLmLyKrJmx1BNWI16KSZkRXV3MfLg7S+RhfVNZ4TTGU6nunNCMlsiL1dlRXsLL3UmrEAQz/SiFferHHxsgbgimFmQVGptV8LGXXZeHuoD/hAD8sMND4HnoLqtAN7K8FJszksw0UrhGiey5Ns55CZ/DCrag0OrlyZfPLqS1Tjp+MJ8ovynSDx2HC5RWfI+UqplHuYJHszx6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egm0GF7MlITBOeFYJDhBZ782GpWxW5Bdw7LL2IoieLY=;
 b=YmD5Z27YGDvkwZ/9cvQcEh3VW9359Notke2OdYRqvmx8bj8N0NFUEp1dQqCr8NkMayVxWrtQvpoDodqiTXDqAsVEReXEjiJ/ajp/7Ozq45Oy9JDxB8boHS4VzXqjYFm895DQa1+rKn1CIm9eKNelyc40AUljoD9+iLkiBYbt5sj2v6Q4kDgzJFmUNb5tE7llw2BhzuAjLa/6Qqmf/6cppqCnTTX9LrFAXhQhE0R8HNiCNBkB8CZOo6deutweJprX/GXBdQC2GxhAPClkihG81cXJLajVCracJ2St9eCd19rGdWN7a5x34CqIkqsCNeynls3au5CrzKG6CJZPmEVrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egm0GF7MlITBOeFYJDhBZ782GpWxW5Bdw7LL2IoieLY=;
 b=sFdlv2os3MbDIWu4p1QFcWy/7Sj/ObO0o3/xjBMZSap7Q7QqPewq+P6mgnQ1X/7E7YJ9RgETtHniBicembm5s3jJXH4NlJYWGJLzBXkdiFHkSmIhfG5xAdhCpCRKKNkrMCYqGSyvzB27WAMusKTGR7RPogKMDPg5kxLZMMxLe2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 09:48:58 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 09:48:58 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
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
Subject: [PATCH v5 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date: Mon, 18 Mar 2024 17:56:33 +0800
Message-Id: <20240318095633.4079027-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240318095633.4079027-1-joy.zou@nxp.com>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f8e011-2ad4-4c6c-4ccc-08dc4730a23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FRItNZK9jC2+8OyPxUOQoS1vRNvOMQ5BcNahwL4pr1gyDq95Z9vjFANz/5VUhDKs7g25HqFsIYXBuKb9HBySFaRKRMjG8f8Yvpm3Ci8h1IrkZPhu1ZW/HrLtmmm9vP1QIAN79qJHzLEzd8ne0kNCRJFXiJIbMkp2M7rhdQSK7DI77vcrNKkN7HwxPq7dBasaNtAjURM64yWmsayg4fFPzrORkpVajZZ+Qb8n+aNbsjOVJnyiFY4rV8x67LnyslwxIxuBkO9g+JqiG1ATwLB7Nm1kL8ep0JY+D4er29Msv+iRsYWiGN+SGTVdT2QLBvfEoktsYvg/KIC5f1pH8CR5QzUH5HjLZwc61wnAA17s5iPVzBB5zgmSlBUfgwZzwXlTJmE/OnSkpL+dJ37e5YbLH1E5jXkW27ARLQP796U9X3L7ivtpnGifwSrl0KOBwTIkavz/uDsu/Jp46bBedQe+j6VpjoCIYEn2wYJpz0HFcHyesoHebUzXZ4iysjFA7P/MToxL9UAA6JwOyZJp3MiGFwZebGyGjEW4yFCVeVuCf0yFPJtvwCI+5TZFJjAyKU66tlme5QsYPgIddha9uXU8CpDYdjHLIAIFKqYbFOSvcO23C74cInxMCWcXJWLbXb7+fXRSHCLtr9J8gFOicN3DDS0pmh6OwiIFE5FZq9TvPwofgS0oI1jS8JSh1MH2ovBfzQxXVGCmJnvF3fmd2zcr8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2Q7SydOSTMrH6DoFiJaMkjiHOSQURd+iZfJs8Jo+dhIzMN1W7NiC/1+STzk?=
 =?us-ascii?Q?c4mzowwjHdt7zwuW+EIXiPSwBC0jVpTQg7K7z71DeBrpshZTK50nzbxV0ndV?=
 =?us-ascii?Q?xWMfkuG3Y+T+e8u9Wk47DiiP7LtLh264plc/vIG3sdKWqt0xHAK9xG+1SJyZ?=
 =?us-ascii?Q?2HgMi9ZajbYWBbSFhhEGtRc32jVj06nYSlfZMly+aDXwiKUQDhq30mVKvYFZ?=
 =?us-ascii?Q?jw12e6STmzRKewWg/XlgNqwPDfr5hgwufQmd2uMalBtDO8QSy6hREhZ8JMKE?=
 =?us-ascii?Q?yWKovT31lIDNz2rgfw9ujHdXTNoC23+qyw0sts2IZIUYwVQnFHWrm9/8mVHh?=
 =?us-ascii?Q?BvLYr1qQkk/w2GooTwmE5DpFXZHSdfyZIte7MvM0Fe94BAuuwNh3wL5A/So3?=
 =?us-ascii?Q?AZuIdNcuM7SY9X9V/Ii/NhIXRQ0dEiHrQQPZyedgDWGu+o+bj/SrLTVnFswh?=
 =?us-ascii?Q?JXZJ4EqoSSsPmde0c1fTNVIvt2zxSoyRr2uLVCVoDgbvA7SNtksLZ59TqCpp?=
 =?us-ascii?Q?Powu5xAMXOE+ozWytEu4y9uXXGtya6cmALzRAEE8MdQ2yrPdLWrkDTjBUB6f?=
 =?us-ascii?Q?ncfMX8qNez06GjzGUv4pZnniVQjDv9wjw/8uEVMhVUJ9+vmOuCDuNzYOErfS?=
 =?us-ascii?Q?Fcj4+2gbmZRXhAAjUQU78X0EwSPwasya+Jtav2wSYCr7kbEeZIUFVVaD45I7?=
 =?us-ascii?Q?oD7NwgMJ85rLwt6lOX5jEuvuj5IALaTwUaK4j5nusmSf27WwQafDfBlzF/Ne?=
 =?us-ascii?Q?J24d/1MAQmq7hEuOebPxrIy9ggNv/rKe6dME1Lk23wgCSh9WcxlkidPHeCi8?=
 =?us-ascii?Q?pvbBThzslxfxoIKhibsoP9ln+3NNGhNvE5tohlpk7cn6ivPfECV9AixmIlrC?=
 =?us-ascii?Q?9zwtdQPX4AYywbADvO5UxOkYx8vjgHcuzXEQc1Q2TjnqiR84GtMb6pbTwGgN?=
 =?us-ascii?Q?wDYPFvTeBxT9SA4WGZhlaV0BPMpuppaOda2OQfP+fla3Q5tHHzYddtdsUOc4?=
 =?us-ascii?Q?qPgOC7af62cM9fSl0qBiNBBchjLgxb1XcWFTS8WzS9Ymi0sejqWV7I1qe0uL?=
 =?us-ascii?Q?59mGhuk/7Aeonx/UnNQ+LZgffT7bbLF1zch/RL38NSbYY2p74ANl1/tyuHck?=
 =?us-ascii?Q?2f0cJSx9pGRS2Ucf+O0b5L3uRXaWCMf8hOB3cGjJZaW9Ut6Qi1XZkUwmHkIk?=
 =?us-ascii?Q?AtC0R2dZzNUkn7OPPGPRCp1+W/vvzFCgkcZTbBJK81Fq9w47aHHDUbQiaAHU?=
 =?us-ascii?Q?4JJhule7OyZZX0HleOFP/DvIUkf9hXR319sPs6PDwHfOLt855MRzQkLeVDjN?=
 =?us-ascii?Q?JSPuc34njZUXb8Gh13MK4hD38YU+SQrhQnXkZrIhLEa4Y3gsumVKYLcp2iVL?=
 =?us-ascii?Q?OfWzmvyWFt3pzNQy6oHWVG7Tj47dkm90R6uDpxdPcP+GKyC/cT1J+Mv4ptzp?=
 =?us-ascii?Q?BdZOzMZ8iJMO4l6S84WLVkvKdif0wq1TZTmdki4cretEGSititxwhNM/Hxxg?=
 =?us-ascii?Q?PKS/hfcp5/dpsGLz1CRBotOkt5UhUY4zJlASWajIUcVEwnoOZcGyYR3WaoVN?=
 =?us-ascii?Q?3shhNJP2Xy4QurBJ5KACGuDWlosz9codGXmyNex9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f8e011-2ad4-4c6c-4ccc-08dc4730a23a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:58.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQPZSIVEFJcyJvnuKe9uddo1gJzCs5n2guHzgib5iZSFFkayk5qNiKqf1dZvTt27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v5:
1.adjust gpio@22 to the front of pmic@25.

Changes in v4:
1. modify the comment for uSDHC but not i2c.

Changes in v3:
1. modify the voltages constraints according to the imx93 datasheet.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..478a134d4416 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -183,6 +183,104 @@ &wdog3 {
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
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -238,6 +336,19 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
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


