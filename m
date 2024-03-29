Return-Path: <linux-kernel+bounces-125182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A78921BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639101F23F88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F3130AD4;
	Fri, 29 Mar 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSAd5esy"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2129.outbound.protection.outlook.com [40.107.20.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1B137C38;
	Fri, 29 Mar 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730265; cv=fail; b=LvSHLEDRVxeNsNACvouQ6F/xR8csfWq6QJzJa8qJE+QG7mq1OrZBqa0gvf+O8WOWw+RtXdjOlxqEfBE4f/i11ulVb9CSVw0Y7R5t7cTcqiRKmaqPWHvAVbNHdOenpQht8JieTWV1MX3dD7qlFi1GcvcwF/uM+F4W9Db84glxvB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730265; c=relaxed/simple;
	bh=esaUXn5j695rEnXA59lUD8gx/CRWkoqvPpW0g5t3hFg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KDKxhmeWi5LQhltNlRd4x/rlunD/Chowu/CVXdpsnjYAQhCi8Stq430GhIF7ijXzCtt63zskvcREoXNF10VZa9yeL8tzsQRnV+aNwcL99SoXR/pZ/n1k0LDqRD3s96AmNCZVELhRWCRneWMSmAB3W4iOq4tlIBeMuZrZVqX2uLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YSAd5esy; arc=fail smtp.client-ip=40.107.20.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxnEx6JyBMf9HIBQnRcLoG0nqpPd5UZTV2dQDFhe+W592kGYcFFOeonOQCKvcvQZhf25u3SpA1GYJTVEDSsUeBWJnyBXX/SY4S/Tu2JV1gsPaLqUPUagvwXAlJXHSJIsRyj/7gokDJ6J87Y2fXCjnNf4oUQWpgtYTI3//Xb4f4FIWzOPgseEsyCVEGu0Ib04+dDZ6+EtcRr67FO5TaEBLbbP1pFIncZ6QGzOvBEnMrA30nlDq7SXDei6Aq5kvA1PLINxKMSYinxEVmDsGyxBNHIySXIJzcxQB1ELOdbgQQWmOx2QWe1dC7p1BUrrI2nzExvRdowE0MtjZtn8ZUlUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq0hyeMveB9fkB2RxISUgJdJr2oy9IkzXbYW1vj/qAc=;
 b=nMyMq5u8xOhAnU2Uxb01L3DYwmVVTtDTIyq7Sb3xrVuTRubp5NSB2B6Gh9x45H6WVzrB7XtrQEx/FNwQISIQy9A36LPXYFewecVBUuuAt4uA3CyVDOmdj29G/MveaWKicatAh9qKJLjs5h+KMT6xqk0+qTIRJKVvGXKPkTWZs0fv0/C9dwmgGXRmuv4OeIMvoxu/tiadeJKmDrkOG5IrHN27gmM39JYu61gDih8IWeOBpI/QNHiooKE6IvNbgH+Fp1wJJGLd7A8PbsheYOmYHsd2bBGk4p6lkV+zeb5/46+zNfe1pyYs0xUTfwYn9MT8gnBeasaXVhFIWNVRiQKxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq0hyeMveB9fkB2RxISUgJdJr2oy9IkzXbYW1vj/qAc=;
 b=YSAd5esyy6xANQfZucXG7kI4QS/E9Pp6Wu0Uqgy6VbHSErkWMANjQ98DpEvxwaTVNZvYA3MSTPic0C9BV3WVtt1mfwq+vc1jygUrwzeYTtFjksP2Q0ncSKcbyuujkiRF/6qvb0c6kmSTMvTD0ERc5hahCQWF25E8/bU2kFlkix0=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 29 Mar
 2024 16:37:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 16:37:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 12:37:08 -0400
Subject: [PATCH v4 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-m4_lpuart-v4-4-c11d9ca2a317@nxp.com>
References: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
In-Reply-To: <20240329-m4_lpuart-v4-0-c11d9ca2a317@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711730244; l=2068;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=esaUXn5j695rEnXA59lUD8gx/CRWkoqvPpW0g5t3hFg=;
 b=wevykxlPtyz01u9QP9Btti5iuLzDF635IeKvDQmUJ890UtT/3k4Dj0PmzkN1ahM68WbxWY1AP
 GTgfet5+4JOCZxvQaj7+Vk1aEodYcO/Hm204jBj2Zx3usZuzae8nvK2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YVcoQwzBMQoDDXeYN/fuBVkOEyfRhgRsh3SP5wTeJ+uHDqQFzoYGm3izzwFjiBrLXN+WhIiLF1Kl6JAsuxnPLRq5AT58dT4wsFrqY5lU/vkwiXABfsgmzeD6cpfS8hpFE6excXUmuFXP6HlZpW2MCcplTRL02Ntk10nf32Upqodpf7hsR9h2S95vqskrSNd4mboNiGI2WbdHoxNa6K7OvNAX1aCTFfAG1hsQOdFPXWUuj6Luup5mjocZ3PqRUM8lZT5Xrf0VMTcbMn6eDfECay43/LZ5LibY9rV9HKXeYg/1xVFjjErrdlqkV7tz1eHfMGj6tKW+d4lQ53+WZHhBPnasLce2Wjawj5c+dkxxk1s+Cn3kv6/iESOpw5Z4Ykyv94WUBAAAyxPYhpY0Lct244yFxHNdk2K83kd2TNjk4aPtswngMQhLGcnJusCMnLIn2kFRUICla6e7uKsu+AGBAZpfQTqJ0ej+Yclb79Ct2Jv6cLYtEBWQ2Vcc896lBOqfdsnD79lQbKfuzUC3DWorVJApfJmJfjUfr//tp5h+ZuQ+UAJMrseYsHTQdwzxUtVUsO/CyrNluymftIlVWwEStCX+qDmm7ziJoZCul6aMYQUt/BLjmgD22SOG3qagySZVaB8ZVFdA3Z6uL5ol1ECHoFofJAQb11CdVBbU/DsCYkluV1Gr9aq6MXSFNpp20W2HXU3X5XDD7QPToJjb2DYHR5o0EnI0jHcF2TwcMfJEBcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVcvTVFZYXZXb3BTZC9RY2Z0RGlabVVRTWZoSVVMMVlwZVpIWGFpMHRjaVh6?=
 =?utf-8?B?d3BKOVI0d0xwcUp5TmFxSU5LSWNTSkJHRWdrWnVZd2oyWmw5b21kQ3BldlRC?=
 =?utf-8?B?TnZTTEtIRlpyUGphUkU2Z1JLc3NlZ01mamkyeE9CWXlJSEtKeUF6WmsvU1lB?=
 =?utf-8?B?VW83UUZ6UE5aVG1UcHkxb3RyTVc3dUJlTGJ4M3IzR1pUNjFKdWVHM002NnZl?=
 =?utf-8?B?OGVGTlZWWHZXSnQ4S2U0Y3lRS2N1RWg3K0F0SWRkKzRUUi9YekNzUnFIZEVr?=
 =?utf-8?B?UGRMMEFUK3htci80Y1hCVzJtVVpnaWZtUWFNa25nWEVraThnSTVTRFpGeUVG?=
 =?utf-8?B?WmdiYXR3WE1YU2hVSlVIMDZZWnRkNFc3dzVhelAzb0E2MEtZMFpvZnB5Q0hE?=
 =?utf-8?B?Q3lzYnNrMHZ5VTRYbUpoZnR3Wk1IcTBGazh3bUdVbS9Zcis0WndzK0h4bWFp?=
 =?utf-8?B?OE5tM2hIQzNVS1d6QWhON2pMb2w1bXNPUHBnSGtqYnQ1OGJaTUQ0TkVvOFdz?=
 =?utf-8?B?L2JjMXVNSVQxNUlha0ROYzk0SUxic2Z3RTBmOTVpZXRuOWVSbWJiY1dKNHBH?=
 =?utf-8?B?azFJaXBXcFpPY01HMExQMnFjSlNhWTlObzRSODBBZ3czUGJ0SGNqZUdieXRS?=
 =?utf-8?B?L2RaOG1YenZiRVJHVmt1OU9PaVloWmdBdHl1UnVSSHJ6NjEwUzBzNGVOWVMy?=
 =?utf-8?B?QzR2QTRBdmlNK3E0clVlQlY4aVVxTSt6N2dJdVdWdG4xbnErcFpBQmJsWTll?=
 =?utf-8?B?ZEVPdXU5Y3J2cktlc2R0Nnp6dFgrbHY1c1dWbWllZ3ZESmpsL3p3M1lzZjdS?=
 =?utf-8?B?WGJZQmM5NEpPOTBLdERtSVNsdmZ1UEZYRjFRUHYzNWU5Qi9RdVJxT05VTUNC?=
 =?utf-8?B?YjFkWWZPWnJIa28rWjNtSUxVc2FUbFNBUC82YUp4T0hONmk5dVF1T3dVNkQ3?=
 =?utf-8?B?OWM2dk94d3M4a01BVitjQ2VOd3VrMDZiRjFQMHJZTFVzM0lJYkw5NWlhNTRF?=
 =?utf-8?B?N3BZd1BrVGFpcGhVNkNLRUk1MHNsR1BjcTVkVWYxQ3VnbTZTTG0rUnhyOHlS?=
 =?utf-8?B?Q3RhYkpzUVdqVXhHZkZSbkpJOGZVOWI2aU5XUTJKeHcrdUY0aUtBL0hmQ3BF?=
 =?utf-8?B?dDhWM2ltdHpRTEljSDYxblN6d2ppT3NzOS9LQ1hCZXBMcGpFd2VYVzJMN29N?=
 =?utf-8?B?b1hxVTZ5NFc5Ykw0Y0ZYYmtuSVQvd0hyNGpaejJGM3djUUhhSTlVM0NmS2ZF?=
 =?utf-8?B?ajF6cml5WitlcXFPZ0hvL09LYmRxVzFvcnJvWGtoMW9pSEhBVmUwTHRwV3Az?=
 =?utf-8?B?bGg2dERmU0dFbmxsNjlmQmRGWjRENVRkdGNQd3ZGZlFhb1hGK3Z5QXpDbmRL?=
 =?utf-8?B?clJVUEVkN2wxQnJyMzZONVBwSldkYmVobnJSS0VjMERDRTBzUUd1cVNDUFpL?=
 =?utf-8?B?bGhZSDhqaVhxVHhSZ2pzL1NCV1A0U080MFBnM3dQZlVqcmIvaUtsYVdKSlZz?=
 =?utf-8?B?ZE5ScklsTVEzWGVXRnY2U25yTzU1MW95ZzM4WnlaNFVML2FxVkhBOHpXSDhN?=
 =?utf-8?B?cXZlVDdwMG10a3RiNEI0MitXYVRyT3JaV2F5eXBJYzhhTW1BZkZvQzVMMUpr?=
 =?utf-8?B?VE1kbHdPZzdoaUhEQ3pKNUR4RkNiRTJjTTFnMTNWRWhHa3dENDE3L1pzbExY?=
 =?utf-8?B?T0tPYzE5bXZtMFdXNkJiWHNRU3lkTmtlTTd5dUNZbnNWVCtMK1p0YktTaXJX?=
 =?utf-8?B?ODVLbnhETFJUVGR5Yzg0TlVwT3ExSlZtL05RYUdmZUF3RnNyVzN5WnhYUW1l?=
 =?utf-8?B?SWNqZFdVNDdqQ2ZFSUo2K2s0YjBQNHd5VEd4U0lzcTRaT3Nydm1ZMm5sN3l2?=
 =?utf-8?B?MWNHdmVWUnRrQnp0b1MvbHJLeDBnWnkwT0hJeC9KL3BlKzdlQ0VKalJqMTlM?=
 =?utf-8?B?K3ppN3hTSUt0Vk9vRTE0MFl3UStiVFZ5YTVtL0plY0QzTjdyTThrSU9YcHFr?=
 =?utf-8?B?cU1TcWNzMUJ4UDVXVXNzUzhEYkg5d3kxRHAxWDJqb09UbHQ5ZEhCOTZmN0pn?=
 =?utf-8?B?Y3RiM0hWQjg2TWw3V2xDc250UWJCc2xRU2ZVc2lxZTFHSzJWU1A3a2xzVERZ?=
 =?utf-8?Q?K56wazBjK7JdDCOgMCsc/mLoR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf5ac48-36e7-4f03-43ed-08dc500e8d1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 16:37:40.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn0bdOMhq6fcKx65cUsnQw7RXmRz3cDH1gZzRelVhH5nXm0oDOqcq6XPPKj0EDRU0EzvGrBqkLO62ZMvPXETSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Add lpuart1 and cm40 uart.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..2412ab145c066 100644
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
 
+	m2_uart1_sel: regulator-m2uart1sel {
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


