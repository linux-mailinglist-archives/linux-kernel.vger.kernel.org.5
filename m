Return-Path: <linux-kernel+bounces-82292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98468681F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DDE1F24F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FAC131734;
	Mon, 26 Feb 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oFFCX6pI"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5B12F592;
	Mon, 26 Feb 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979664; cv=fail; b=YG594PzxVLsZKPDVdpy/a1Zrdjj2xVzEQKP2ZRPAcmHS9e5GHDPCUAvEv6eMPqtPpVB2o832uZKQeymL+Mui9128lRtWXFjW0gRZk5iX6iSofHBRsUkJ2JAs5GJrTvvHibe9oHHy7AxAcBpti7m5Spjdwd+rNIVDgDD/i+QUe7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979664; c=relaxed/simple;
	bh=GeoPg2+Ud5gJZAGdEfAeGQxXL1gzpT96oxfP33y0w/E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+3ZzOvNmRFomuLkQYswF+73RkMb+xOrhGAQINM70YuOgzKxqrj3qIhpzVkJH4O4+oziOx0BWbe6Eus3wJ/dHC3wzx3jEdPRve3KrPWSi00pdm72bEf5Zw9/Kosu+MrNHWstIagOBZMRvpvcp03HP0KLC5tHEWalB+Hygc9PhU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oFFCX6pI; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzLqezbfkBCJR3Av/cvB8bVJGqQrrnLbkGeA9Qzkkw+lZ8iNCtg7yONEoF0P3PlPeFk2SSIwBCZdPbNKykha6hP1piEUfYUVncKfhHg2f4ozHk9rsDg16N4MG8cD1gkS9HHGvdMgqm+ZVF2rpw8KRO3FSYpLCqjF30CH7ZVveY3j/oVNp7i7zVsHpggH/3KJ8+WNaTXtf1JYh/enQzfx1wChkeW7IOK/9DSwpI3ZrVy069fqwikJVdLD+jwc4OfnQbSiT+fdVRkbF6nXhTyEwYcZViwsZfGZ5ZpZ2TZW2w8dBtpDAgw25WDOzu8Hg8dzaCJjEL9fo2mgtHNCOoR/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p88hGTQRJgJkqWH7aUjxSUyEFcouoAzrQOG2xuXaQp8=;
 b=nlnaLGlgD0BKh3zDJi5bqtHt4YC62kvXL2NEuzQ7PwIqNdCSIapmrISXz0u7zbxqg9o2KHubInnft272xxGv/JFWQqXMzlj5ognCjsDlUbjk0XjEQM+kr38/Mu1egFkAnk9q98bpwuYXmm5G9GeLF6PsWhHCbqqNyYzbRfZjJXQnKQJsXlMvnqvLIDlaN67NGunbwTjeJemHS5gMYrNyqRPjoSxYXEvJyQkTKIfCUDbqjYPBisXKTBOAMzZ8WTpE2VY8TPGQYKkfBl++yJi1iSCvUrCuovuPODRxoOms+gTw7BOV2SIIKuSXIMPWtkXm5A4tqOM6hOenLEQP9e/Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p88hGTQRJgJkqWH7aUjxSUyEFcouoAzrQOG2xuXaQp8=;
 b=oFFCX6pIrxWEWIiR2ZAeJSECMJJXFerM0CLohdsz9jPuqBRNOiANVOFnBMGvogSWQx94F3QYLXsUpxwvI1UOYUVpPlNyU2PnYr0D2rOZWONIQjtfiZm4biofx7J4clthIq5CjXjy8eXO8yqwXqIqsq0Ohg2QXOHjLtlwcix67aE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 20:34:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 20:34:20 +0000
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
Subject: [PATCH 2/3] arm64: dts: imx8qm-mek: add lpspi2 support
Date: Mon, 26 Feb 2024 15:33:56 -0500
Message-Id: <20240226203358.275986-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226203358.275986-1-Frank.Li@nxp.com>
References: <20240226203358.275986-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a11fe3-68c1-4111-f5e5-08dc370a4f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dYwLe01QAq5PRZBFAWX1ao9C5VCtSzMhmhb2aDtCdRVlSHFbh/a9658jc5AEpUFE0dUVAKmcrPLcXniEYfMfIPsURy9qvGWtsJ3XZlJeVTVz4ytZDvh/g1VphWY5Ciyd6w++7xnm9kI4dfD1TI8HX/OgRtPinEqKq/fbW3Tm19/Qj75w/WYiIknmdhEClYEq6HEu1rClHAg3kW3Idm4LNmsbxgbcvs7GVS2vzT5xFneHBD1TIXSVxtHj0WQCO0uDJ1mXmAH+IewPGp/MHJ42fTpDn3ECm4sDagc9PSvod7N9e7ucjvSoM8rSjgIjUm6twsEAiUZLCqqe2p5VviJk2SBe75dyjVkT5EUBJJ9liXCnpjyMo4czDGWToSKOQfvzPXNwm0sQH4zRcpgZp7ZEbR2V+IEjLLgXmLYMKsAPrgBCntSykBb0GwsloaDQRwtOnrA/H3k72+PfBXrm2g00FxO+uVgiIh25W779ytvrlbaL+HMqasZ9ndSZX1QnKo0u42I8jWXrbjNQC9A0qxHJzear3J2L5Mqt6kX9FjnB2Cg/zZ3DdxRAFLRQO3ggy7AHgbhs6szjfm2rEB1dAptRrOnBag8R8sUzWWs/0YZ0r5CSXofTTM8CZtLpFWbClu1XctBP+7380e7KmwJRJVWcOVvHUrBZITd+9upLE3UrfCmvit9ig8A9sQDNhVpaxxPZicwzQnXL7vxflAJF0BIlKukytBOTrEIVYW3H7Wb1PGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGYFPzdAiIXoJ4+IAdr0EagYgumpFvaDXfFZsUZEimrzSp49dPyaqMIk1Y8f?=
 =?us-ascii?Q?R5wZsofVOCY3dg6drUYNjfwME3ocrs7u3m/AaaayFtFngBNz/5reRK6hJMPr?=
 =?us-ascii?Q?dGrGz+t+u0tzubv8nVWCjIP7/tqDBy+T9Ip2BcGu0jBcgpzfg1sygsNSl6um?=
 =?us-ascii?Q?j6GWqQhdPAe+/g7rfucNqfsGpyDivigEPPGLlFzj2/lt5HDELUfR7qYQCMZG?=
 =?us-ascii?Q?Yzb19Dup5ebIqi6WWrKzCd+DDPIlT5gvRi5Kv7I340kO+VFX0wrdM0UYosAG?=
 =?us-ascii?Q?SinAv9hA40mj/QrfPJiduwY1gfWfT+qvGCmwdm6ueg+ErVvnvyKhzFMc4VUv?=
 =?us-ascii?Q?FjnQbE+atU0ieJnsdxiZC7S/Io8un3vnqtHSBvQJsK+rFeHLfrOhJinfMzHZ?=
 =?us-ascii?Q?gj/A96B93f3XJKgdmDiB0e/Vsh5tXOs7wiZjj2ibY/ZKxPKFeN58Av4uzzDX?=
 =?us-ascii?Q?PFDXl0EtZBgCHdiENjCuUS89Wjk6KE4uSd9ARr0PQS+NPYvMWPvSIc0T+WCQ?=
 =?us-ascii?Q?wQyeI0yytMVTpb0KBfJWSKq8F4RqfZEynjSXQ23Ng7Oh1KoSRwmacO/IDLDF?=
 =?us-ascii?Q?557Gdy0nOLZgzBUQTothtC5fnAahD8dOWZoNvHW5m8RaWdid6G0S/10YNMDt?=
 =?us-ascii?Q?7SyWjRvTeptlkvCVkeUdYv2bcJAqvfsMxjEw39d2LgCtHFiW2xXQB6LAGlVt?=
 =?us-ascii?Q?IWpH6dPdFVZcioAkpmlDEhdrbhxtoJ1Vh0YkNN9fFP9PdPcAtYOxx58hRiDe?=
 =?us-ascii?Q?wupcwj3fPw5pbu4/QgbodOTYiI8hziYcdzhnPUrFEEL8uPfYa0VfBXTVEgFL?=
 =?us-ascii?Q?K+GZuTGyI/PaWrJrA+c3oXduiZ9gT3JvskRQHOHvEwWwGCzicrOL3IAXCP6a?=
 =?us-ascii?Q?DwxaVSNhRnWGIdif8q8KryDtA5e4ljCQSCATI2mu3d3ZFI/faUZ1uZN1e4RC?=
 =?us-ascii?Q?OgS5WTSiaBESSm4Q2N6gOUsuRNDiM5GlPebylsZP9ZLYBO8VGq4XIiU3qR0L?=
 =?us-ascii?Q?K58Lhitw/k2vqcDk/SObzxDiH+DXjuHqvs3Xs9U2HutKMMC0dZUOLYeKrI8T?=
 =?us-ascii?Q?8/9gnG05NrG+krpj9MaiKNl45B/rQBNQxA/5cZbAcobeVqugG8bwoNXHuaEq?=
 =?us-ascii?Q?t4t553sGx/iEvTO7jk60CQbG1gnkzus/L8TWFAKO/KSd4Fr+KUvWZw0d2K2A?=
 =?us-ascii?Q?dsEMmYSE/U1M1B/YPRKMhTaXBY+5MHvKcVRVgeQ1oXLlc74C+AVhUJLRzSbs?=
 =?us-ascii?Q?8WPS9gfyRS4QmLHhZWGZ0maybZPP6pCttl80jSi2sBlSF96v5OkpjsNXVCQm?=
 =?us-ascii?Q?t96UVBkqaDOuMnd+bAK+qIrtYPicLK+9slQyGpS3q1B3MyL1sKoV1gGvAz5c?=
 =?us-ascii?Q?11gcM1A2PeO/AwXB77cqABdkmLt3zTnYM3VIiGmSUus4qPt498ILj0nwoCRC?=
 =?us-ascii?Q?ZLcXd+j3/VdwEd5Z0loISx9lNHSBeua6xEk5B4pmTx437+ewDrITFia6QTVA?=
 =?us-ascii?Q?p5kSaNxh3vPhQpH3cYGofwtXTpOxQ2l/dg9rV5WsYVUD9TEmkzxHv2J6oOGB?=
 =?us-ascii?Q?0jZ9BgpaNV/SK9WW/YJUdWcYqkBdXncqaMaWRA/C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a11fe3-68c1-4111-f5e5-08dc370a4f97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:34:20.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUc2fDI/AK9+lmmxtXCp9GqmmoxrYCcpBU20HG8u5FTCc/0BbNddkI3UBwkDLKNJgFpsW0jalrQfsZ30okFwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

Add lpspi2 support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 0c4972724b041..800dcb67642b1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -85,6 +85,22 @@ &lpuart3 {
 	status = "okay";
 };
 
+&lpspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi2 &pinctrl_lpspi2_cs>;
+	cs-gpios = <&lsio_gpio3 10 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	spidev0: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <30000000>;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -169,6 +185,20 @@ IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_lpspi2: lpspi2grp {
+		fsl,pins = <
+			IMX8QM_SPI2_SCK_DMA_SPI2_SCK		0x06000040
+			IMX8QM_SPI2_SDO_DMA_SPI2_SDO		0x06000040
+			IMX8QM_SPI2_SDI_DMA_SPI2_SDI		0x06000040
+		>;
+	};
+
+	pinctrl_lpspi2_cs: lpspi2cs {
+		fsl,pins = <
+			IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
-- 
2.34.1


