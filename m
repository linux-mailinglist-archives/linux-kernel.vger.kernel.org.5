Return-Path: <linux-kernel+bounces-145839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D48A5BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB96B24FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9113B78F;
	Mon, 15 Apr 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDn7uoj2"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5515FA75;
	Mon, 15 Apr 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210444; cv=fail; b=a4nce/d0ABIcHoPvsG64NDv0OfyivMzmQEY0S0szhu7gQy7svcx/+VBB3ZR85JbtafDXX720RslOc8CpZLOh0lt0dGpF5yzWv2p83vz/VP1Ugif8KceWpP6Jr5UgMXsHpNLwOPKOx6xQU+6Zr3gEXfpjF5vBI1lyZaVxhpbMFeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210444; c=relaxed/simple;
	bh=tAEu2cjhvJES6EJR8Wiztl3r0OgUGKBUl8GHUotDjU8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C/wZ+z5lThx89UngoRXEmVFBNxG5tKtB0WLTaMi/Vp8P8t8xJXZ1+LPZpBrn1hXCOMZqa4rVTL0ieD9/0KDPl5BjiVhva+QB2qlhs22A8mOh0/usntIJSVN1louABLGDrCaxlfWn3Rcor0mNvjgyUO/vtfHnF4XSu3nmyv4zfFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDn7uoj2; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4c0TLdXnApJxuAqLtOm+d9IbDEqtzlfB+j/9CtMPyMDy7cAL4D23yz/5vQx8CeXaqP/yF1KTW7cNX2BROxi1+Pre4CNP0mYP7mb42EtpU6uC/6kVsWF0jLJzyqR2MQvCCd/fUXPRM4E3M0gPOE9cxe00TDVZIo6b+3QUwcSKjg9CFuQvdopS5CFWQrgIjGwWJfaURtGFG/W6Nzjr1Pmkee0DdTcXKhNnbAOGLY6aniMaWpGYppnnkLEmBdzrENDJ+apam/X/ODCXTtq8S59WXP7UHmndOJN3Uv+Q1HNjl111vltLycrO+EqtmFkneE+RYkQ9qHBgSXWLTdRCfFKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5a/9/wZExo56noJCufyQkV1IznGXo+eMrVxef4qAOM=;
 b=Z8PFqIY9viMvrksmx91eCE0oKTFNlAH6siJWoCSDRNUf2Zl1hmz7MGt2rO4W/zeQN5gealdHpp7pt5hDKqXAlO0qhApDQIQs/flVCX4Tx/EcNIJRvEWusqsG+G1QKv+8dv/5EeBDo6zk/+sPR1kPKMVA3khke3MtELZt1YLZ2EoqoCc2mZgHWQ3n4jy1DnWAydICg+f+aXgphoXVoiD2zlMZPbn2rXlrXzli3qelvtrNgbEO/Om67X+Ly+jHJ/EZI+2zViUXgnU5UlJwsHCPzTqFYH9QeIit8G92LX5h15+5nnBaWlwaEEHHiaASvAuXmC8SjJvHnchCdvej+xgS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5a/9/wZExo56noJCufyQkV1IznGXo+eMrVxef4qAOM=;
 b=QDn7uoj25PzQ3hmkapoM5K0OSm/B9ZNRMTjFjsrsAHbaEyFnTdikcJiynIGdJBaEf0Md1t53nUl7dwmYTWjyExmZhOPTLzAD6nu0ZDEzEynH71vi6LFerCxEF/Bkv2sSjErlCRflrKto3JSYJUxEm92uceL9ulzT9loIsKuFVsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:42 -0400
Subject: [PATCH 06/10] arm64: dts: imx8qm-mek: add cm41_i2c and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-6-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=1328;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tAEu2cjhvJES6EJR8Wiztl3r0OgUGKBUl8GHUotDjU8=;
 b=OzuQp1Hsdbb3iR7HOudi7Vdj1Ioazr/4m7oqeL/WS16OG5LTylqtFkjKC/+41DLEiQTSXk+r9
 qUhnt3iuGDNDQFBbInKpCxxmu3v1jP1235u5D+0O6HcafMqWSy+5fxA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 500add61-898a-43ae-d04c-08dc5d84dd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8glrO+q9XhCg87fRse9vq3VB8demqXbcOeFHlmjHMkwMhhM6QjnewjmFigPcL2GdXaYMTMUpJgSaikyEC9t6n8Y0tppLA5J2UYFlmoAjxMrDe/LVXZhYJn/RG1TY2iOIDR4B4wQVeEaIVHl2eKZq8MLZW+gyJG6XR/kZpB5V0d4fpjwbSOLGXyq0DE/iymnDjzu0RvfFtrR45syqnPbSG6+MX1zO2cUvz6vVglBR//CmZM5/xIk82MRMPiwtZvEYC89Ig77Dk+s+IBylCphEOsNSaI2csbBmdvoixqduRuNZRW23HBCsnwUmBATM/XxGfHnvUb/rjlarwVt/47hEVbchRh+4wbcsgwRSoTrmplcen7GEAxB24zxCWzw9aEZIdikmmiLfRCqRgiKCZCSL6P3wm3j8Mr0buQKOSQdTffRTYGNZ3be9aDq5BqQZOaSFVWAJeP/81BbQNPSU78z/D0XbLnFGw3h2Ne+ckEUZSfQ6SVBZmcJieP1+jnNgYrs+06mKRvrPL/e8hrpOw6/JDvI2enML7afqzyktDyNLPG9oT6AfdvE5eXQIpDYm7iB6NoVY0YQD/HufTNvR+06yqnoAxRobW1Tz1/Bd6q7S8obiwSHNdDs90PcpznKjXAVLDvi+K5JB543g8OSTrUxwr0L5jJY2V0rQSTF8iuCg6vuSJ01EEpRCz5nvjhXc+ApW3WWIElIi7soilMs+B7CgSGaglaCjaGM6a5gvHueTrKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjc1V09lclAzNTRSbW9hWmdtV2E5NkxxdGdtRndPaHJmTFhWL05QU0l6cmNi?=
 =?utf-8?B?cnEzMkEwZW4xNDByZnBMc25CSVo4ZmFNUHhDVitrY2E4bXZWNmRrdVJNQmNO?=
 =?utf-8?B?eDZmeDZ6dUM0eFNQSGlTak1PaVZsdzhrTzJudGVuQTR0ZGV2dXdPRVBJenVu?=
 =?utf-8?B?dXF2dkFYSnkzTGJIU1M0WWk3MWdINU52S0ltTVVXN25JYU5vbFRYL2lBVmc2?=
 =?utf-8?B?aHJ3enFQRGJ1Tyt0Uk9zQ2Vab09Vc2VPZU5lNHJta2l4bU85NzJ2VVo5alJE?=
 =?utf-8?B?VlY3akVhampIemdnRmo5Tm9SNkt0V0VTL01QanlKUlduWk1iT0hnUHgzR3Ay?=
 =?utf-8?B?bzE1Qmp3dmJxZ29HR2R0WWd0a2hSVHVOYi9LdFg3M3BrU2lJRmYyekJLZm9E?=
 =?utf-8?B?YjAxbXlaKzVnd1dHL0ovMHFMR2JCREM3cDJxTzZQc2NzV1BYc2J6eW9CbHJ4?=
 =?utf-8?B?dnFrWGEzU2Q5blZoaTJISFJ2T3BFRzZvc0JWZ0tZMklPdUp1QmFaUzkrUlFD?=
 =?utf-8?B?UDQzeCs1NUptUWxka0c2S1AzSnl2eFdBVWxBYTNNdDNLQWZwcDJqTVkzVXdr?=
 =?utf-8?B?SFFQTlJpazYxZEhXd0Mzcy9JS1JKZlZHUGJvMkttRlhlOTlUSTdiSGdSUUpw?=
 =?utf-8?B?Z29iL2VKY0cxT2h1WEd3Ti9TKzkzTUFNaDA1ZnRQRlBXVUpqc0xYOHFkOEln?=
 =?utf-8?B?VEFpYzRjT2c1TUd6RkhUaVpjUlkyUFZiRlpyMVNCdzdnUEd4THFpUnJPRlFE?=
 =?utf-8?B?RzcwQXdSN2tSWjZpeHdaZk52WXNPWk9hd0pURnBLZ1VqVkhoODJmbkFUcm1T?=
 =?utf-8?B?d3I3dnlVZEFiY2VqSVRhU1NGbjFWcWwyWXhiMnJhTm9rSDNEeHJSY1ZKckZ6?=
 =?utf-8?B?N0ZQQ2lpV29rbEkxNUFaa3V2WVZSVWpxblZiOGh2endKbW9CblVya1dCSEMy?=
 =?utf-8?B?VWowNEFHdGNyWmI3elppbTJBaDliUnpLSUQ0a0plOVVGSzhUekt1LzU0TTFz?=
 =?utf-8?B?cXVjc0VGSTVuT29yVFN3c3dvUjY2Q2pYV1JubStVK1Q2czZBWFR1Q3NkTnhF?=
 =?utf-8?B?eThUSno3ZldHVmcxQzlYdFZFV3JnWGViZmdvSTFHQ2E3UG12T1ZzQTdkdDRM?=
 =?utf-8?B?bXBYbUdnUnhwS1htVnhEYkwzOG1PVVJOVHBXbmYyaEpRMU9MRW1vYTJxYU9I?=
 =?utf-8?B?VmpacHlQRmpqejU1cWZhQ25YUThxdmhsMHliMjYxMG1Td2xXdjBVUmFpV1Uw?=
 =?utf-8?B?dk56WThpMnJIK1hYQ0pUbm1WNG04aWN5aHRpWEUxUmd5N0tOZnQvdGFxSWk1?=
 =?utf-8?B?WVhOc2dVaVIxZGhka2NSRnZvcjE4TC80WjRlK0Q4RC9ETVJaYzlZVDFpKzRv?=
 =?utf-8?B?RWIzSkt4dkc0WGF0YkQ1VkRGSDFRTS9XdElWWXUzTERSVFdLRkFwRFRoa0Fm?=
 =?utf-8?B?T1NjODRRK0ErZDBiWEltS2tSM01LYkFSK3dIeExkZHB5TzMrYkVVcEhBNitv?=
 =?utf-8?B?bEVZcTJIL0x1dzU1bGg4ald5NzZjTENCaWtLeHdnb0ViL1BHYU5QRnFselhz?=
 =?utf-8?B?K1Fxdnl1MG50dndIRlNvUzJHSTZkZ2JpRitpbUR3WUZlUDVrZy9JT0VvRGkr?=
 =?utf-8?B?WUhDV0lxeC9laFppTURNNUJUS0JETVppV0x6bGNKZzg3dkJheU1zU3FQVnc5?=
 =?utf-8?B?eUp5TEk2TFUvRjJkM1UvT01tN2Via1VkZ2hFWUZLQTJHYzJtNXJUaUhFdmRF?=
 =?utf-8?B?aDJyUzRVcU1HTm1YMHl0dURpanYwTmRLYmRQczZkRk5vTEdDbDVrdjgxdC9M?=
 =?utf-8?B?Z3A4WlB1bVhpOHF0L0EraFpFZmh0SnNnKzZWaXdGZUdWQ282aElLbWZ1enZF?=
 =?utf-8?B?bW5ZNWZCRGJEN1M4KzhmRlVGUWl5QWRyWnViYzREcW5QSFRUVzFmaGdmUVhM?=
 =?utf-8?B?V2lTMS93R1NjU3A0U1ZwQ0I0L2ZxWFo2bjIwbTBreFRUZnJ6RGlpS0tlTEty?=
 =?utf-8?B?b2lOWlA4Rkg2YTZXNHJkd1IrVEhnODdVQnMwZE0ydC9WRXozSjZrK1FxTnRa?=
 =?utf-8?B?WUdxK0hsdjhuUzVpN3Rvcm5kMHoxVTJHQTZ2MTVoWjFLektZVGFHK1ZUa1k1?=
 =?utf-8?Q?G/FTmXb78x1+GN0KHbrcJ7lp6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500add61-898a-43ae-d04c-08dc5d84dd8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:21.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSguI0PnpsagP1RcU6MdaR1wdEuuKCo3HuF68iwlHEbMylkEfQZuNWlfYuNk8qHYzz1HIgpQIW+T7g98LHGivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

Add cm41_i2c and devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index d321876754e9b..4b87e13923328 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -222,6 +222,26 @@ &sai7 {
 	status = "okay";
 };
 
+&cm41_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm41_i2c>;
+	status = "okay";
+
+	pca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&cm41_intmux {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -353,6 +373,13 @@ IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
 		>;
 	};
 
+	pinctrl_cm41_i2c: cm41i2cgrp {
+		fsl,pins = <
+			IMX8QM_M41_I2C0_SDA_M41_I2C0_SDA			0x0600004c
+			IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL			0x0600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020

-- 
2.34.1


