Return-Path: <linux-kernel+bounces-128190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD6895755
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31CB286933
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBBD136647;
	Tue,  2 Apr 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pk067dmg"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2102.outbound.protection.outlook.com [40.107.8.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C249135A6D;
	Tue,  2 Apr 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068920; cv=fail; b=BxkyUaCWZbuNfywx0w7eF9KCpxi29pivPFNpPp2mua/xU1wuHuWavJgfXZXMlDcD+CfyAYSfkdth1aJO2beyheXGarhjvrs9V4UTE6l4yrEE7Wd6FaSCXdABYL5un7qIBRgUyPLn2mz4jIapOfBxhHxI4KqG9q+z4+l1GtrQHcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068920; c=relaxed/simple;
	bh=esaUXn5j695rEnXA59lUD8gx/CRWkoqvPpW0g5t3hFg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NyE9bkk/h/4yIqJou1abXSeG9ZDBuvK0OtaKeWw6BDUgTE0Bz2h0FMpKR/0yiZuRXjtBXlGsxIPMcWeivnWuC4z8UKnSxP8DXx1d1Y8W0uac44wJoamP5KERn9W8st1JPcbVp3xGrc49wT7bjvvcKuf7N0jt3XX6ej6PR/ZUKWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pk067dmg; arc=fail smtp.client-ip=40.107.8.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8bOW+MvzA+RqrXI4mC1y9/RuuvQj/HLuFviPJOrAO4J7ErCTP5KZlEiw8mkiyadyodsZ6/vkTFgF2ZqRPLUYugjc8anITGAtfulMaToK/A+nJ/gJtCUWFxQukVbF0j8M+jwX3YEfquDVz3TEgriy8a7JwPC+uARFrJYrgrkKAm9Qh3m24CaxsIkI+OcDgmIMGpzYq1yA0b38r4PmUOGFyUCh+G1fjXDfV8uCb3TulPfQqJzPYOrK+Mayz7Dr/Fm6CpyxvKYpHwtAOkS4mk9Q8Mwnff2leZgHIDJUruqbFer+J0tXrQFEddECn+GaKOyXV+3iiRlrVJiZ2O+5tiIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq0hyeMveB9fkB2RxISUgJdJr2oy9IkzXbYW1vj/qAc=;
 b=CZJO98SGyceHC5vwSAuztn94XNQ9dQAo8jTAEM1O/5+4S95JJbA/ay5OczFxNxWjzbAUlfJMD+HW36JxxvZqFMu2QBKL3qcVCP5/tYI0eSDN+EKZpQb2j9gqmaPfnvYWQe+s8jfhgMQ4G31A43DfKIppIYorwmOxicYuhVCFT+IrCnxDkFHA1mlBDMj/uzoa2oJjeJsHXiA3TyC7MX5d0n04Dbysgw0YD5Q/Rmfv6VNac22aFoqfiOdrE88PXl7IAmQEuyUYEBzvSv2+hpADJa/t3WNmist/xCixADOVrlsO+ZbYO0nhF6BMu8g8hrARr3jZ+oxKpjXPLx+nyJ6ItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq0hyeMveB9fkB2RxISUgJdJr2oy9IkzXbYW1vj/qAc=;
 b=Pk067dmgA1maEhEs7tQmQ84A329rSvP2uTsAbXoRlLQNsNt3uaIxew2GVFv1BjUf6pfdYzpS+XgvHL7gjRHUXvCq2TXP899JB+edmfhV+JbHkURlTfnPQqM9VC5aRYQQe2lhlJnpHrIQ2TuqHvtf+34sz7izN1Pb1avxSrB1/h4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:41:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:41:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:41:31 -0400
Subject: [PATCH v5 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-m4_lpuart-v5-4-3292629ba808@nxp.com>
References: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
In-Reply-To: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068901; l=2068;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=esaUXn5j695rEnXA59lUD8gx/CRWkoqvPpW0g5t3hFg=;
 b=KlD50xk8AvSU+POCPVTYqhgSuwpGamQSET0TWreZyQhtEgYrjRNZIdJ487XMqfQWXpFClsG4E
 1fZyJrtSpI/Bi68GyxKw8etN3NghEv7OZaIMBKX/+Q9W/ALbTDiR3jV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:510:324::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uaUZkRDuuEhzxu5hcv9OeN6qo9ychmrfuNzvzemV8gbWTFOawhI5O1KQQrlXsBmE387eTANcacq578I3HnQZ7R4DQkpSGp+GuR6TltMegSUoGdT30y1bgK1IIdzNx7NGFrL7FeTlpJwbO+DIfX9ZCptEJa3h9tEy9Qw9wPIfUa0TEXQfqN1EARnYA+3fzQtOAHD/1sUCSPW+ZyYyN/IHWyERlErwl1/14a/3unDW7hTMfbNFhIRVGFivOZDQ32y4iGwefRWcMnvHajyBhpJX2PWvXxB1gN/lCLaiS/noyWYwAC9eIF9qlMJyWyCY77EvhFcX9Y151LsiQkctIHRVRzujNSr+gLqxpZPhIAPQuaxbkC1EfWCn1wHpJyDXD4ORCO9ZdrZEMDBaMXquHz8/unRAelNLcBvg2OnPZ5DGvhqxuUyA7dThil6bdtZF3DJejg4X+52DHx82bkJyHVcDlyBW/fgNeBBQN3H+6mmoOYNwN1Hbmzt7Zbd0/iIsZJUNiQsV22lbTfMyJxzYOlq/XEqwYYBUOyYsYPXuAGb/TRlBHMbVGE3BLeiPT+RHewVkxsSEqaJKgwlQJqou9Jcp0uk/opJElHW3PiYlfAZbQf8en+CWWARyZfy7Ilws8KbdBJjLN5qVdwcg/51yydmjpqvbNam0wuKXqjn5672diA0E/VeV8apQhTbCxFwKvY/NVzzIXnU1w1CGT6k+Eu1qCy28GeZCock21jr0Ah0vkz4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVjMm82TURiQTIrYkpzcmVpYXVrYnBRSnR4eU9JRW4xZWJwUzNrNU1HRjNR?=
 =?utf-8?B?cG10clBuemY4TU5DZjNPQjNGb0JES0xRbUluRWZ0elZjcDZobmdaVzBINFVB?=
 =?utf-8?B?V3lxOFdqN2lDNHhPNGZneVMxbTE3diszYkR3RDV3OGNzQlNlSmd3akJzZk1n?=
 =?utf-8?B?SzFMTlhyeUNOZE0vTmNxZ0xSY0RURUw4L3kxTkl3ek1pOFZxZENzaTRQL2tV?=
 =?utf-8?B?WEV4SWU4V0xVS1hja2ljQmx2c244UXROT3Q2WGFJVFhHUUNub0J4cktYdisw?=
 =?utf-8?B?RW9id2I3aUMzbzFkTnhma0d6SWgxMUlhOW44VU1KZmtlRVQ0bE1FaGJkcXZL?=
 =?utf-8?B?MFN1b3pBK1pZVEovaml4ZGNHQXVOUjJqZEFSd3ZVQzFQd2FSdFlOVjBic1VI?=
 =?utf-8?B?RjkycmVSejcxQ3h0OWJIbE9naU1GRG9ETXhJaTFwS3k4eHpaVmRSTzFXZVFz?=
 =?utf-8?B?cHJremZFeUR0bHpVSGxrT2RLQjRHZ3BzYjVJanJob1pwYWJMQVVpWDlwZkhp?=
 =?utf-8?B?OTV2WnM1L21DVDRLSE1sNEU3ak1qS2dCOWIwc1p0Umdia3FtRW15ZUF2N1ZD?=
 =?utf-8?B?aHVLbm5LT1Jpcmc3QWtNZlNIc1RHaXNsR0ZTQThsUlU4YTFLVFU3eEc1bEMz?=
 =?utf-8?B?dFN5R0VOTUc3RzJaeDM5WUk3Y3hFUEdxQk55SHlpSW9ZN2xISUFrUDJteGN6?=
 =?utf-8?B?aHE5cmxScmdjTHRuczNFK1RjaktYK2pTQmVRbDNNYUdYUTAvQ2ZjRnRQdmFp?=
 =?utf-8?B?b3VNSWVCZm5LeUhHSlEzbEtHZDNpODhjY1VTeXMwV0ZJRDlaOUswS0paUVhv?=
 =?utf-8?B?TXFhNGNwajJTazYwZ0g3cmg2RUJldmVnWTF0UHp1U2dxNTdJOEZOOXcrVG9P?=
 =?utf-8?B?cmtJd1NiTUNLOGJEaGllSks3akRDRGp6Vitwb1lzMGNFNG5zVnJmUGU4aUkw?=
 =?utf-8?B?UytVdGRkamNqcXlKOW9sUXdJeDV1N3l5NXRhRmlObkorNHpvZVdGY1JFLzhn?=
 =?utf-8?B?WXhZK3JaZDlpa2k1aHlwUG9yWEZ1SzQzczJoNktxRTZPakZkUXpXUklmTU1O?=
 =?utf-8?B?TTJQYTAzZ3NrbzlpZzRBWEViLzNQL3lWV09MU0FlMUhBVHJCRHlsN0R4YVFj?=
 =?utf-8?B?aDBVOG8xcXBpaXNaRzgreEdiN2JWWGJWU0NwT2x0Rm5XMDBHVStwb1lCbFpQ?=
 =?utf-8?B?NEMxanJJcXFZVWgxSG5nc2JxNEh6SU04OHgzc1ZybUFMNHA4V1NCcEYyWmVR?=
 =?utf-8?B?L1VIcU1mODNMNEJrTk5oc3R2ZGdyb0NuNjBmTXlTb2xIc2tBUGRkZUpMVlpV?=
 =?utf-8?B?d1JvM1g3QzgyL2ZlSTJSOWM2Znc1ZXFLa2pzVmwrTm4vWmJmOFBWVEgybEdZ?=
 =?utf-8?B?b0xqTWxIakQ0aGdFdXE4MGZzcHZObkRxS0dvdmJQd0M0cmRISjNybDhmTFJY?=
 =?utf-8?B?ckRXbG96ZWhDQWEzYWxkZy9ORGV2ZHQ4WDdwcDZ3aXZ5bXM2bGVKK091dUI1?=
 =?utf-8?B?N2g0blBJZ2EzZTRGTUM1OFFzU3JKR0VSMXlvVjdqK2k1RVBuV3JJS3hiRzJM?=
 =?utf-8?B?YTRzVVd2NEJHUFI2VjBNaXc2aVRKMGpaSVRvL0hMV2IyTm9vN0tmbTlFcWFN?=
 =?utf-8?B?emFXd3dzTFB1VjVnMkt4UmlvTDBESXpJeVpUWVdzYkROMTZBcHprdVJKcjlJ?=
 =?utf-8?B?eE40OGJEQXgvMUlQVGJMdkliN1R6MTl0UDZoaUZ0ZHpMY0lQd3Q0THNPK2lU?=
 =?utf-8?B?S2JUODl0NHRSeXR0b0NEREM4QVpaWlg1M1RDRWlFbXgrT0JqSUo4MGErQVRp?=
 =?utf-8?B?d0d2UEhTVGdaQU5JMUVObXIrMnhRSllpMkRLdTluWGx6alZYemI4RHNOQlli?=
 =?utf-8?B?QzkrTmVUS1k5Q3RFMVFadG1ZYWZTNTJFejdSQi9qYVM3REQyZDZsVjhBOEw0?=
 =?utf-8?B?aENsbFJ2OVFiM3JwOFUyUDhjQ0dvaUxLS1dSSS9ZVGg1bzdpZXZZYVN5QTNJ?=
 =?utf-8?B?V3NtQTVTRkdaWmgvMGgxM1BqenJoL0pOc3V0NDNUdndUdmdQc3RWTlJLT2Jn?=
 =?utf-8?B?djBxVlduQk9QbGFqSjcrWTJiVW5aRENNWm41WmJodlRnYWxpelZwOGN4U2FQ?=
 =?utf-8?Q?tXT6ik3fFu7WxDSm7zg1qYA+Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf3c69-d9e4-4b30-4258-08dc53230b38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:41:55.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3O6UVaVNiDtD1dYfS2GX+h9QjIiWPMHpOqc7N+pqDVbc+TtZHZPB15VLVHSXz1VvqEKTUs2IuKBThRTPPr77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

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


