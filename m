Return-Path: <linux-kernel+bounces-89507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40AB86F151
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E77B20FD9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F22BD00;
	Sat,  2 Mar 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nx7iqs1I"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B12261F;
	Sat,  2 Mar 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396904; cv=fail; b=cTtaRsd0prpRK27aUNaJdhoEHHixJ29WCQJ2eIyvfHfWbRV3rFAh4QffyKBO1NwzonkdjXQkj5dkPgmvY+LRQvgRwlS33yXvoS8TgLzrEVSpV+WwdwltUQu+AvmnWFhSnRYiCQbNJJ03srerx5LqsGEKlxC6Ec76wxfntnyW2go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396904; c=relaxed/simple;
	bh=EUFmCqH8t5ggSsnH8xRcNDWzQUXOW/9W9Wm5SRts3u0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZHz73KnJACk3uU1veIT+SJ3OfGfWkhPkGBsrlDyP8hUMEUEtmvuI/5ffErWIVXIy6yi/XCYnrHuI76WjE61VhjY/NMN9U4eG4uTQEL8D33HgYlyXWQ1fflwQU8nb0BRb/J2KJjNokRpk2kn56oMK6PwfLSo+yxKA7RePnNZ2UWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nx7iqs1I; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncGtnDvE0I9H1Za3ocAkzvWUSdTXyGnqUPjAyVINzbKAnECPlre2epTbMjTOjj37Y3oS6etPvYQjoY6AFbfba25jbJ5EUtafwoNhMAU97tw+dmuv5Fdi9ej03HrU4YZAtwbIQnjPUZjlNwH0bvTGRzF+xbB0gF+vgS4IcrQekbVVqsUPb7STnEyKKYL6UeBF4uBIltwr5WHjnXLRn5ILo3Nw5I5/8rOhpyRjWKac1ucyPyAuZHpMZVW+StXRKOFHnIHvSn7o+YGqJAW/ZH4SbJOVyeMkNQAIpXPw/xw87vhJwonQhdE/VLjvSNfgcErFpXOe+ZhySASKW6h9jrKn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnozwnmfeHhW/V4TGEHIBOIigCysN0DJ4p3MKs1L8TY=;
 b=c4+Us2tLaTC3gP5taDBXVB6GcByWf4qs2/+wA/VJqkPPAHew85IsNbO1GH8iIhW3m4DZrWe0Hwq45wPjKGXgqrnd6/TfQNAh7m23nTy2Wsfqc5WSNqJVj2agOJUjt3Rl0a0jBGeC4Xw6T2AcL+w03Q1DfYjUVSffpckBxWKo0UGYA4B5BwpAICkR0FXAT+ZXmUUTDPAzG8NnUxabqxB39mrtvGqcXJaTtB02MTHLB4Jf4QMxkkIVXAgDVyPieoXTmeSmz9PMLo2R+mzHauenBz1sIaPeaCnPhil2k2dUagqpJK0ejzEFa0RQmMfu7TSppVPyMOwVIkA897oemvBJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnozwnmfeHhW/V4TGEHIBOIigCysN0DJ4p3MKs1L8TY=;
 b=nx7iqs1Ie0XUn4WbB049/yyaTcfbjc5d00/m3RJR5m8VwcaWzD32CqJHRqH9gdktBlC2XWBe8czmbzu4oF//UQ+du66IK9KosYVZO3hNXwlOSBc3fqOsnh1QYg0fljD+fAZPLeXoXXjyLV4h7ZNzkW8G8QwAbAREm1n5zwYdYtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sat, 2 Mar
 2024 16:28:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:28:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 02 Mar 2024 11:27:47 -0500
Subject: [PATCH v2 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-m4_lpuart-v2-4-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
In-Reply-To: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709396885; l=2066;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EUFmCqH8t5ggSsnH8xRcNDWzQUXOW/9W9Wm5SRts3u0=;
 b=eqsRhEQ5cbLK8M5Ye0r1l+jwF5lcaP2jVSPsYxgUSzOL7d0v6aSEdgH/hUEtMA8v3MT6kCcua
 EaHkbA0KB6OAytqZLS8oTvC9bVIIghu4ysfw8AGBdji403c/p/NLnde
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4882bfc2-5460-4a7f-5226-08dc3ad5c69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WqwEmaWYkfxGM5uXpdCbxcaGd9IDrBi3JPj+FckMT4IjDGlK/j5RFw5MC0Ajlc1UWG3Bz2X8zK/4QgbWj6WWuBoEkUhkVZNuVH/WH2W1rf9sTmlH9Fcx2lHRJoa55qLrm7wMdkJdYehnKeHf++m1JP6MYpmIAGxgFequ6ThP5P3xpt3nrNT10km7cQGPBmroEjiBaAs5M3A7ilT7k0HSJu0RqlRy5E0WOO3Y3bSnLtbAfNWmhi1WqFUNDhT9pjcIVvhtAim2Y19vYyjxnvoQnR3Z5PZCOD1S85kgPU+62GQPb5YvM/Rl4ZWx3TUBbPzzVvoxnbck+TVY7LVDbOgIIu4yCWPXhVvJYsmvX/i+gBrp9NfpWRnMHdYZEAUUYWqQS4WB/QeCG8L/20J0kJS2jgswwTxeSpNEDV8fCAnCwYJieYp/CZVfc9BZhgnTn6kLMNxcAXJXJIihO778aP1Mk9uLT87WOkAcaF/jPUQIufFQHPD+A2YhZ8v9s05Jtgqpzp3AsTzEy+5KeThFa1QBoxIwAMtmdvAXvDIOISolYa/bKcGV2P2NWMcVLP4YC7OBQUJr5UxVDV4ANgnt98WROkmGuMsKBUsSxY3GlxuMb2Q+BrauzSsLP2+LX7fWHsJ/xKv+11wXlDnZxkH2q2BBJB75AUB13kDXF0DCDkaAeryJt3mjvjfnbnaQ/vt40I2Fuh1JAf1q8abAOl3sUQO+Y9vcZbz4jVMrlds2IZrnCYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWdiS2JWKzh0cHNRUEQzMjFGdEtsei80Q1JFRmVUdWRGS096TkdPM2FtbnM1?=
 =?utf-8?B?VHdESCtoNk5RbTZmOU05ZkVUN0MyYW5rWmRTYkM0RUVoU3hHV25JbWFGamhD?=
 =?utf-8?B?dUQ5U0VvOWhyWVhDY3dCOXc4SkhHRWJ0dHQ1T3V4N2cxSU9MN0prRHpPYzUy?=
 =?utf-8?B?Y1JTOHdyU1cyVm13SnpRL29YNFRNRTMwSmxvOXd0bHFicnk2cTgwSkVBa05T?=
 =?utf-8?B?Z1YxbTZVRVhMMHJMSy9hcEZsZ1ozT1VGZkFIYlQyWVhTTnJtU0phem5WR3R1?=
 =?utf-8?B?elB3Q21LQWd6WjFjeHYyV25SakJqRDh4K3dCaE1abXd4MTl3dnNEOEZRbXgw?=
 =?utf-8?B?MGJ4SWI1bWRhWGlYbHpzZ1hGcUN0aFpETVJoUHZRR0lubHNSUTlNYVYxamhF?=
 =?utf-8?B?eTFjL0NSbVpRZmRVaG52UUdDWktXMTFxYzZ0VGFlSVVCQmNDOWowQ3J6VDZs?=
 =?utf-8?B?ZTIyMjZZdnRCT0Fwd05MMTQ2Qzdjdk14aHNqc3AzSEVyUXZYK2NsalVWZDhj?=
 =?utf-8?B?Q0dMK3FsdzBqbjlPdmpTL3I1YWFVUUZVSzR5bjlwTnhTNitmR0ozeVhhRURh?=
 =?utf-8?B?NE02ZjQ3NnJGNm52dFlaN1lhUStsT0JvV0JTd0V5d0F0NkNWa2p1cHRxWmpG?=
 =?utf-8?B?c0hlcy92TUJXbVRVRTB5R3RtREV4cWlyNUF3V3pGR1NhcjBLY0ZMQkExaTRH?=
 =?utf-8?B?LzNlTmJ1eEtWV2x2ZjVJZGRXRzA5eHUrcDNrU3FpWHpteHBNZUJaQkl3NndR?=
 =?utf-8?B?MjZiTW5WZ1p1ZzduWWRJaXlHczhvV0FkV2dEaGZzd0ZtNkJzb05iYWlmQWZB?=
 =?utf-8?B?VUhyRXEwRFRrQ1RRSmxzZUtwc2xOOWhvbG4xeUNrd0FXRFZYaEZJVzVJMGFQ?=
 =?utf-8?B?VWk1NXVNV0MzeHU5ejlkcHZ6YTk1bXNBMnNjVCtEeitGSURmUU9pVkpRdXVp?=
 =?utf-8?B?aTVKdUx2dkhweVdEYVUwTnU5ZXJ6T0QxcGo1dm1LUWtVL0orV2RBdjhZMkhr?=
 =?utf-8?B?QnVlZXh2Vnd6VjN1R2pyeEFtVlg3SFBuZDVhRWMvcWoreHMzVHNaZ1Q2bFFu?=
 =?utf-8?B?ZTgzb3ptUzlJT2JNc1pSZnFSQjFUby9tV2lsVjd2R05QVEVRWmZhc29YaDgv?=
 =?utf-8?B?a0plZ0MzejROeStuN0FiNHlORFFmaEpYVGllbE5HR0UxU1FHMlc2WlNvSjY3?=
 =?utf-8?B?cjFPNG5MdU0vWUVDSmtvNnA0U0ZBOVQ4bHdkRkpJTXZsaG1tZ0RYU1d4SHhM?=
 =?utf-8?B?bnh0SnlnSG8vQVh4aVlEWEhoRS95ekp3WWh6T3VlN1hCMllkT3dtTlQyUEpL?=
 =?utf-8?B?SlFqUEtwa1Brb0ZBdnN4UmhpWUoxUXh0MnNNU2ZmMXdneHFNWjJDSnRZUXJK?=
 =?utf-8?B?dUV4Zi9IWUNPNnlxM2crcXpLbXdCU2hFMENqdmVFRUVzb0F1MTJoSG5LUnQ3?=
 =?utf-8?B?TDR1YjlGMlpHWklieHd4dGx2bkZWUDkrSVkyTHdTZlBUQlBFbHUvTWJpRy91?=
 =?utf-8?B?K3ZQZTFjYk15Q1VlN0Z3K3ZKTDFyQ042Nm5tRkFHeXFjVmhENm9STS9DMXNy?=
 =?utf-8?B?ZEVHZFVqSEttNVZHa09tblI2SzFEREtMMEpndEVLdVdCM3NZbVYxYXAyMlha?=
 =?utf-8?B?bXAwNnpORWJmWmNyUFZGbnhWa1EzNG1Bd3g4SDlvVWx0bzVudzAzdDBWcy9M?=
 =?utf-8?B?bHFWZkhzaktNZ3BGYS9adGxFSkpKOHRHMEhFdTVJejNqeTliTTJlUHZnSWRn?=
 =?utf-8?B?V29xVXdQaHpSMVNJZlpmSEtKYmZGL2o4bnV6UjhSREt0alRCdC9qclBlS1J2?=
 =?utf-8?B?SCs4VjVvTCt3WjVVbEFVOS9vbEhYUmtCNjRXbFc3L3NnNVF0cm9OVDhtaUxp?=
 =?utf-8?B?RkhES2pPWHlDU3hmZEVwL3plaTFxUVlRUzdabHNiME9pbHVMMnVmaG1HVG5j?=
 =?utf-8?B?aWR6WkFqcUlHdG9Ob0NId1M2c2pxbGRKUDZuSjdRajAxdU52Uk9VaTdtL3pE?=
 =?utf-8?B?cENmTmNDalB4Q2UyUlg5a21OUWxvbTNPVHpmUllKNCtkTjdLWStkNGFxa3RS?=
 =?utf-8?B?eWRJSXRjcUluR0xYczdyS0JnZ25lOHFhb0ZsRTY2M1JLSGkvaWx0S1A1NG4z?=
 =?utf-8?Q?Fysk3AFXflC/EdxpMZRM3xYq3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4882bfc2-5460-4a7f-5226-08dc3ad5c69c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:28:21.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zAbeYnPIGvorCpknJOq7O0mjYNroP0mbk7RHTmK5+rOqcTsIo9jRFUplR9dt8uiu2LdS8K6QNBSNh14CHUO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

Add lpuart1 and cm40 uart.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..737bacacc2da1 100644
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
@@ -51,6 +53,16 @@ linux,cma {
 		};
 	};
 
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
@@ -340,6 +352,12 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+};
+
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
@@ -354,6 +372,16 @@ &flexcan3 {
 	status = "okay";
 };
 
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
@@ -595,6 +623,15 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
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


