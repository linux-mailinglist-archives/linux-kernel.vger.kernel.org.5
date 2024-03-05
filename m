Return-Path: <linux-kernel+bounces-92641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D587234A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDF41C23222
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7548412AAC2;
	Tue,  5 Mar 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HaA+Opdk"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA11129A89;
	Tue,  5 Mar 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654125; cv=fail; b=GgJlJwTDuNGOzBEfE0v24yL56l8IqAB5B/ww0JwFBvf/uVdgctbM/TPUhXismZlEzTrWN8QG/AYt6Jgtkjw0j6lR5QhCBZDj8ZpxIH5OOHlD/KEpfN/5FEyjaPlpnnYYwFbmpRTSakwOAzdywJKK/6ZyjeBbMd5mcUaSlxCibCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654125; c=relaxed/simple;
	bh=EUFmCqH8t5ggSsnH8xRcNDWzQUXOW/9W9Wm5SRts3u0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rYDg36/DVF8iQd46tavoUtXW3ozn7SxhQBvIJrmtMR+++N89/0weqenIJNnK+ZZsFMwEoOkdDdhQ3oQ/M+A4PqkLzmAnRh7sPQ9EIFvjBzXn7ZHA8hH+0yO1eA/kmkui8lxQYrLv6CIIPFgu0RINwS9KCT83Es/BglaaTN0pA3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HaA+Opdk; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh+InZtzif4e3qt7QxQHPRdjFumnrSrQmv++aU9Uw/WkeaQh66kIS0MrRckyNcU8bKg/qT/G6WSPvYV0mVuwAsyvfjiaVOXQcEZVyo0Sa0OIisiIA9oNjvtSDCEjsQQs0nvGdHBvyfDgOeGfLmUw2RHa53DvXMWATwEzzRJl2sAMVCIXjlITtArzUXruOv3r42NymjLD3R0Qk0El2MhFWu/xFmFpxJBKGE3b9EHFxCQpqboUGHu1ZHvZp4LUdqwU/Dfhe8ME5yHy64Zr6oJxfWP8goipDqwHcJ5j1E53ffVYyNTt9awgO001FwyDbA6zTyElhVXjMb961a1Mm66lxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnozwnmfeHhW/V4TGEHIBOIigCysN0DJ4p3MKs1L8TY=;
 b=T4GDDmHZf81qQ//ALFCm/5oJOOFNVBbb+nTL4acqpLU7rn4c0gZ3e//eYDWUpw008Y6aShIk64RzFWxxliz2teG2vVCILZzqLIoN1992HNI6qAL5PssDhTx5NHPkIxYF/P/hoaGR26FlqsC11nOh5gTvT+7755kv8EUb9KNQesuUsPa7aD/XtaO1Y6PadvLFVDObeoVlvdzsH8cIjns4KW6RZeaLQeXruVyaJYH/YdAzP/yJiS7oCtULGLj1a8yS9yy1PkGUm82l8SnXdS0YmDZrnnnbAFpe0SprWJb9H3zR/lk4jiu+LzOgvaMHWVOOqzDMGt9ikgHHkjuwf5tNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnozwnmfeHhW/V4TGEHIBOIigCysN0DJ4p3MKs1L8TY=;
 b=HaA+OpdkB6JARNcYuMbjCqFSxjXeb3Mf9HH88uaKGPBoUu6PHuA/4nhbT02Pju1WKgSbESQHIf+ZZGNRkljMuyyFWZBNPtCoIoe8VXDED7C0mX8CJUB8xctXaE6yJabiEXIelvkt2QbN2xt5X4PkcTaq8nCCZqHAKsogZGnmm0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:55:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:55:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 10:54:58 -0500
Subject: [PATCH v3 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-m4_lpuart-v3-4-592463ef1d22@nxp.com>
References: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
In-Reply-To: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709654104; l=2066;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EUFmCqH8t5ggSsnH8xRcNDWzQUXOW/9W9Wm5SRts3u0=;
 b=6e730Nbj/dHXeHdM/FWvoHmRbR4wvzPBj2mhaVLvTCzw9oaJMn2qtT54KebfYkswZLwF4x4o4
 bC1ne7WPrK7CSEizsayxmwMkO66q6DBu6/tZKSx6ywx1iHpNJ8OnHNU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: f157b46b-4154-4e1e-291f-08dc3d2ca968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TmXUG5s1yeWf8DbAOkmLg7WTXOt6aLjsBNWzg36OsZ56/LHTkY4Ok566iSRpphYm25B1XUeDscTBAKHCw6KJNs0ieZbn0adqoR1gKjb+uofqpEMVVmTtRqgbiBLSyKqZqAkZ8Nc3ED/yKb1Ds0Dcm50wPiyj4sOdcyNWJP3S0agYFRzGy8VCbPDTWOxmsVgw9+S3TT8AYhLIJV2BG8BUSavhisEFMJlI3UodFo/H/X/GsLRFyBY7x1SbOUZfBE8UIT1RsJJ7kom4/1Ax+qsXJV2vEGyw3IeQsdcaC0unqbLemh4B+KdYBMD2bWvN5VOiC0lRRgj444Dn25AjNykOYZ1TlGmw34NO6tgnI0lBZuL2v4v4Tejv2L9KHhTjHEAA+cBgamKryJvSZ/U2WnOxVkWbhhN9wHNUgr1izxyKfbQ2NEFJKeDh2t5i989R07k3IqAA5aBt4HBLXqTWOqSjPWGgtBzFbN9GVbG0eR89tKP6/GFLD77eFNuFgG3nKCQ5xfJJXMmzdUBhpSDzKIws0M40k1ujP8wicXEqCOWPKaJDku5AuRwu/peYRUqteccc8gBDED0f9ccUVR4AlR30y+0M3RXRYD3JxSD7p+VAly1KleQEocYSI7bAAKkGX5YEJ3n8eipWevLtLZZnMffljnAdzATTRBmqxZ/oUIOgSlD4otvQ2wcgMWqfWXT/a7Yz7UfSAvTeTc3a9hv84dtf87g/MfAwt6hrY79DbLcLW3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJRMEkzcVY5b0dORVkxbjhPa0dQNTFHcUpvL2RlWVdQSjRhTFJVeGlSK3Zq?=
 =?utf-8?B?SFBnSU9VbTZ6SkNEdXM0OTdkaWJJRUZSQStBRmlkVjFOalZsQXI1ZGdVblJG?=
 =?utf-8?B?OUI2cWxiR3h0ekY0RlZqQzFWaHVJdUNxVXVqaHZRZFhONVRRcVlPdGQyYjlr?=
 =?utf-8?B?WFpLOWtYbzB3VVJNN21CaVJjc1lGU1g5dXdoZUxMUUtFenpSMnZheXNjUkNP?=
 =?utf-8?B?MGJvUmlNc0ZPeUlVVkNoN0x2WElwSWVSaWVGQk8xL3dOeWlpL3JSc0VoUkJ0?=
 =?utf-8?B?NEpsbDBVZ0JEbi9nSmhNVnVncU9maHJmK2ZIV2RzWGV2a25aekR6WW8zRW9r?=
 =?utf-8?B?dmdKR1N1YTgySDFXVzgzNkwrTEpqMFUrTVVNUVRqUDJqTy9Wb01LdUJnZnFo?=
 =?utf-8?B?ZXBmNW55VGtJSlppQy95dCttVkJ0SkxQbWNWdkpZRHdZNjN0Q3dVQUlEaVh2?=
 =?utf-8?B?b3YxaStQc3RvSHdnd1JxVjhjWG1STW9ZOS9qeHRpNlBxL3F4cnRmaGYwdVZ6?=
 =?utf-8?B?S2lLVll5Q09CM2NQckFackc0ZHhqeThDQUN0Qm9hc0EwNGlkbEV2K0tsNEhs?=
 =?utf-8?B?Y2JQRStBTWtYM0M3ekQyS1NsYXc5Vmc5Z0pGR0ZabE9mYmZsQ1pzcDNhbE12?=
 =?utf-8?B?QkNjQ0JjSGVWcEVsTmdIYU5tM1JyVFM2czUwNkp0bS9sOHJlMGtxU2VtWWJx?=
 =?utf-8?B?cDBrMllseTVRbld3S29ySU85ZittOEpDSnRodDRKekFUVUl0Vk14bVpBYm5w?=
 =?utf-8?B?UTBJUFcrNWliVDVGeGo3eW9QRkxyMk0yeWVETSt1cDdzLzBmSXBqQWhTaXp6?=
 =?utf-8?B?QWgzN05NTXlUZGo4cHpQMGFxYSt1UWtLUzBmV3dVWjZGNVRySkl5SWxlNFVG?=
 =?utf-8?B?MWw3R1FvbXBGbTZyN3A5bVgrSmtUTnpLZHVFQjZrbVJPdVVVZDYzOXEvUlk3?=
 =?utf-8?B?SGpuRGNyY3I3UDdOUXI3VzQ3VzlTL0Rucjh6cWV4elJObDNzeldBdWovcUZx?=
 =?utf-8?B?T2wwSGxjenc5bUo5WmxvOHFkZUtDNUZnWjJMT01GbG1qWUJiZzV2WEo0NEI1?=
 =?utf-8?B?c2ZmTmlaNmdzU3RDUldHTllML0NRTkNGNTdPNUZZYnRtT1JFWG82VDFDb3d2?=
 =?utf-8?B?aEtNOUFzQnp2OHVNaCtMbnozWEpyTFVnWEVzeHg5WEtSTy82TWxXTFBHR3hL?=
 =?utf-8?B?emRkK2xSTThwL1FOUENjSm9vZ3d2ZVZMRHJpTjVleFNmTjFzcmRNTjY4N1JM?=
 =?utf-8?B?eGRvaDk1N0Z0a3dBejdRWVZmSDBpMFBXOVNlZStYWWhqeXF4ZlVETGtUMEJz?=
 =?utf-8?B?WUp5RnFjaGFVWmcwSUtPRGM4RWNJRG5FS3ZzTVRpMm5NbVJPY1pSYWlEYlB5?=
 =?utf-8?B?RWExWUVBK01LN1Z5Z05IRGEzOGx2VWM4bHhhOCtqT2NTU0VUTFlzZ0J2Rkdi?=
 =?utf-8?B?S1kyWjJLa3VrNmNFcklVbXBRdlcydmJLb1VEUE51aUxQV0RaMmJHWVhqSmV3?=
 =?utf-8?B?R3RhRGE3WUdMc1YxVDFTaS81WmxHQUNGN01XbVkzVytrU2hyblZHVHhsOCtN?=
 =?utf-8?B?NHRzSVpqTjNqOVBHN0hiRTJGMHlGdE9RaTlSUWVBREdBcnZnaDNzT294cjA5?=
 =?utf-8?B?cEZKZ1VIb1FKZmhzcnM4M0w4aXlyZ0xkUC8wS2lXdHRvaTFCNGtvRjVLT2Nl?=
 =?utf-8?B?aE1UV29hd2V1VjNFN2ErYVFCK2J2elFvUi9KbjIvQktQREpReWdqZURKMkVU?=
 =?utf-8?B?MjNPelJ4MzhhRlRyZ1U1Q1hOWmZramRxVVE0aXNpVVQrTmNwK1dDSk1sTW5h?=
 =?utf-8?B?T1hSZ1JmZVpXM1FoVHZ2WnpNRjZTUTU5NlFxR2tPWVpSZTNEelB2OHMrNDBQ?=
 =?utf-8?B?bUE2V1hzMFdXcWVMaTdWWU9VcWJhWWZPTzJXVzRSQ3VvWnN3VlFiVlBZT2d3?=
 =?utf-8?B?WmViM1lmUklOSjRWVWFuNis2R09lZmJ1cnZoTCtSWWZRRDBTMHorcDZZbGh3?=
 =?utf-8?B?ajU0N3k1Tm04RXh6bGZ3akJrS1I0VG5neWdwc2J6QVg0TVRzeHpLZ09JeStu?=
 =?utf-8?B?MVBGaU9aZk9ETUpsWnVjZE1IaUNzTW40ZjAzOGFLRnlUeU0wVTJGR3BhVDhR?=
 =?utf-8?Q?5GnrUbeDhtRxUsD55Miha7Hva?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f157b46b-4154-4e1e-291f-08dc3d2ca968
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:55:21.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUHE12qWxIURakHv+ao49p1iiPGvXFtaVU9MULNqic7RjbbcWSG2XNDQkNgGTuEYXWE12gr/Sr9wqKF+61cRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

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


