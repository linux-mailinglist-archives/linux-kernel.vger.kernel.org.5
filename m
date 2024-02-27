Return-Path: <linux-kernel+bounces-84002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7B86A152
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6107EB28CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6D14EFEB;
	Tue, 27 Feb 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KCQ/vgHF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0614EFCB;
	Tue, 27 Feb 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067301; cv=fail; b=fKpYZFrWSBcjhGmZH0OFmKyMUrVfvY0SnK4Bg2JdtpZbLxO3QRlftHtgNM6srHiCOSWOLHRFEktVHuqK1EeTuFe0ZD1egUEka2Xn20wjcvIwqS/VLo6Nak7uiwvYC2uQ9RZd+NPZs0aWf4Qt8VTPtWoYq5+YA8MMRqAIGybhelk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067301; c=relaxed/simple;
	bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FYkbdNDP9yoQEGtptQhUfQfAl9othxHAmVoKVIXPwz4/20oQWQdf13tD7bmYfH59iXjKqFx50YPalpmWwcElrEs3EI//ysv70/3An3GXGf4gazB3NVrMdae41jAk3c0qdUtZp+SB/h7kHDNACyd8fvat8DSW2OK1D2JDomqJ2kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KCQ/vgHF; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIvozbuwNW+PkKc0rkcHuWiRfxx26rMzUCmOQgXBJitD9Nv7Emdim3U7/9p3kiCb/LWpmoQn9bIARi3tz0Z3XWRyFEcL/RV54I8i6OB2alMDI9TI5BencDk68nZIkDwp6XwP1jnV8Zgtq5Uv4hoUu7+PYAU/d3Da/kG847GowhK5iOdhEHwP6qt8ZvjuFW0rXjjgExilOTDGNE2dZBNEcDMSri3YqXXArJejf9wr7rmCmJWAeKYi6sNdoT/yv+7DQxk6/6wE73wZq6FpNn5eHSd7VD2MSWGfveUmo1IcVQjOSMsKr2sfSz4depPHXt2/NGkWrHuga7bh3v8F+oAMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=f7LiiRNPuWywhGG9zRf0BkF3rkel0K+/m7IZ3Ly0qqRnnFn2IQaMArwdzfRXidQxJ+5bPnntu29AZaXGUARW5kmLJInxiwYnaBmDC9eNbjqPliCHh4n/1wv3tW+vO0e/E61nssw5dATLaTJkpsAW9GSLAaq2A41c9NBZXCVSb9pMjDFo7TAv4jfsmgKPDDvugK/7IMWzmeGuyGVgahM8gjDVc88CKP3PCqNUpj3yMHJe+7gFv5h3ns6GjWmThlfs9AAOC8Iz4mZyybrY/oghgy4pCX8+sYmcprPi1SMtGwrYUBhEBuzn7J8ObQUXrgjic2NH04+yAI7xnzyApWftIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PZ5N9gHK+DW2QnqzPlUHbIbh+Ah3oD1V2TcxCSFXQE=;
 b=KCQ/vgHFLTcPIfuqD1ocBKNHScYUWvSWl81u3ApKvvi5EWzQnYvAvCR8wrLXwiCk9MWbArsxDhemwzYKwiTLpn+HZgEerzYiC3S+3Q0hJ0S/OZ4A2Bzo7gFPcZbuUyrtr47MZF7mHsP7LYEgRl1r8YhRMA83P/vhTQrp5CM1Bzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 20:54:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:54:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 15:54:12 -0500
Subject: [PATCH v2 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0,
 spdif[0,1] and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-asrc_8qxp-v2-4-521bcc7eb1c0@nxp.com>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
In-Reply-To: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709067274; l=10528;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=scx2tJGGMPCuV31oHuIscaL9iO3JoVAe7DIQfQq/hnM=;
 b=9k+5gKVlaSZ0RLwuEAuOiVi+2p1COfUip0J7bOStCIkkAGWN2xgS4WHxosnN/PPP83HjHxU5B
 4en9mNAwoeQBHrucFFrN59gXepJRF/DtpgkgQ4dW0ErUuFiJEi33Hvb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc973b8-f0fa-4a98-f069-08dc37d658a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ACQnMaZxZPcCA50rFr+D+zLJ33nr1hMSsHES15WAmYbJAJcAb9WyvrMfVep0Xi3ahVJKnIdjBHc4tY7wOsECY4V/qgQWXSc3fDC+n3vPik+DBcAwHpWfWbjoxJm4u4YbOygZxExv2Imhw09M6qfVydUZhiasA/1Q5rm4ocWtrCNdsz0bFkTRgXyc9NF2+FPkU1i6bQr0fU4DaXSxUr4b/rnu67oUM65Mvvr2Pb0HAPMpA1Rbk82NWXAqCR9FXCX1YT1h8XLz5C2Zumv3ogfe/dfTkTzddDhmDvCZgbZrj3OAY6XbRumgg+fE7038klopvaMGbbWnSM8mRV2L5RjaVOb4WRFS5V/ehBpDpiME5Vxe8wtYOzkOBTljKtJhTXwKLtPyY1rZqGw7Qota+wjdJC94It5N78OeiJWX/fwE1rJKaWiKixajSFwRUqSE24L8/8ytmWKmwPnyv51wpc52rfCOTz/0ZE+cD6fxagbHeFWiNJ0C5X8RaEcOqeku33QPGN1TvfX1p5pPjpzJmxBDrae5a/QNh1qcI1Y5fKVXgoUgswJLlqh29acRbIed9GzvJka45CYCaoQSQYdFvBszgPXEGuYB9FnkwDT2JJxLynWW1laf3k3GBodgNLT3vcOs8//pOhEiBngmlP37bL5s8onn+QDmvdUYqxJGlz0b3h4/9xUT7MhxyskcuW5ATgeSW0EHa2bBDS0BYr2JxD3OhU8cbWUrcL+kIjDP8rI1txw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVVJZDU5RGFkN0FJR2cxL2JTQW8wNEd0RmNQVkMzVk9kUkFydk95ZlNhc2hF?=
 =?utf-8?B?T0ZpOURaZDRabWRtRWNOSkgzZndXU1M0MWdzbXNxTTM3cUZ0dnByeUt1aTVp?=
 =?utf-8?B?UlBObkJ0NW1LaDJGdm00OTA1enpMMkxXQWtpaDFqL0J2dUd3aG5GZjF5NmNF?=
 =?utf-8?B?WXNYQXV0Y0NnQUpwVC9iTWw2K0xXUkRiUXpxTTc2cmdMWldUZ0pHSVdHTllS?=
 =?utf-8?B?aVNDaXcrd2JObFJUNW44eVVFRUdoZGd4OWtQTDFWQ2E3ZGc2UEJiNlcxWkdR?=
 =?utf-8?B?TWZFSzVmdmsyMzVhV0RqZ3VGTDVpQUpJME43UnNBYzFIZldrdkRvcFVjV01v?=
 =?utf-8?B?ckdMalBlTUprSFZtV3l4T0Y5VGFrN05wbE83Ykx3SzhmejQwQW5rc3ZrSHow?=
 =?utf-8?B?YWNiQ2E1aHV6VFY0amVSeVo0SjV3QXBaK0NRQ2k1aHRORHNndHVrcW92NWJL?=
 =?utf-8?B?QWNPVlY5LzRpZTBIQ0Q5aXl3YjRWZ2dLSm5EdmtXUTEyRkRwTkYxKzAwTGNR?=
 =?utf-8?B?NW55cGZlbUlJQnByTSs1R241eStpUlRNVEUzTjEvYWtoK0s3NjZtSFhiWXpK?=
 =?utf-8?B?VHFVbmZDTUllT1kxdDhqa2t4RWNabkF3VHNicldOMERjdUpMZ2UvK1BYRUFs?=
 =?utf-8?B?bjFTcWFUSTlPNmRDMEdJRmRJOW42Qllpd0Zwc0tvZjZWRmlhUkpiKzN3Witz?=
 =?utf-8?B?YnZVdnJveE84YWVhOXcwQTA0RjFWbHRvTCt5L3p2ZW9DMW5NaUswQUJuZ1lC?=
 =?utf-8?B?OVptT3hLQWlsMkx3dnVDTWRCU1FMaElHSnJqQ3Urb0gzUlJvZ1lNRXdRZzd0?=
 =?utf-8?B?R1V4ZWUzdlZLN2o0cTd1MlZZRURNc083a2k4eWdYVStWQWl0NDc1K2Z5dm5I?=
 =?utf-8?B?ZFFhT2dGVmhWZTJvTWVJbXRDdVp4WEFsVk5RaEVsVWJsR2FyOTEwN052ai9w?=
 =?utf-8?B?WFhOMXA2bi9SaE56KzZSK05lQXJDbmxGVkJvdGtlemZkTWtGcW14bUlQNzFJ?=
 =?utf-8?B?YVY2Mzg3WEZsVkNiWjl1eEF1Rzh6bytUM0dZM0xyWnAxS0lNMUxaOUZPNXFy?=
 =?utf-8?B?dCt1U0xOSlA4eFdiZlVaNldHVDhlYWlOY0Y4aU5PcmVFbkJVUExzZHg5dGFr?=
 =?utf-8?B?M2l5RW5lL250ck02aTVqOEg0ZzBvcnJSSktnYk9JYm1ORklZYkVjcGdDd2l3?=
 =?utf-8?B?RXFwMENLRHV6aitIUU1SM1hIamh6bDdQRm9vNFZVdHlFT1Jra3RKSHc4Zlpv?=
 =?utf-8?B?Q0Y4QVN3bHNWN3ErK2RmUkZJdFpZZnJCZFo0WjBLZmJZaDU1RkdrYkFkd0dO?=
 =?utf-8?B?cnFDQS9vRzA2TTQyTjlIdkpVVkdFZGR4OXhIWVIyUWpObEVGM3NtRWhLWkFh?=
 =?utf-8?B?US8rcWJzY1ZZRFFwUVdrM0ViS2pIdnVEc0V3V2dDQ1NnUVlabEdvQkpHVGJ3?=
 =?utf-8?B?VlRBOEVJN3gvK25oQ2o5MkZsMDRQVi91Y3VpWjV6cjlUS2t6REJ6YXd4N3VC?=
 =?utf-8?B?Tm1XTlV3Rk9JT3RLNGc0dDROOGpNK3Q4VHM4bFRSRjBSa3VCTWh6L0VHUExy?=
 =?utf-8?B?TldtTkJ4N2g2SUIyN1dJUGNvTmR5SU9XWFBBQ0lCL2NZNHNlMHRaK1k0Zk90?=
 =?utf-8?B?V081YVdJaS83SjJrWml3NVNNaU1qUEF1RmVheTUwOVg2QS9IVlZnRXdYYW1R?=
 =?utf-8?B?K3Y3UzlaakhPL0tSYjByaGF6dlFoNnd6NG8rUmVhR3FCMmY3T25QUzdFMlQy?=
 =?utf-8?B?ZmFUaDJTSDc3c1Nmc0FsQkxmWW5ILzdvM09xY0lQbWZENkpkcUdVeXdmdE5N?=
 =?utf-8?B?TWxjNHZYSkFtRnE1dUhQc0Z5ZUdLd0JLaWZ4U0VXS2ZjQ05Gb3FKVWI3RjFG?=
 =?utf-8?B?SlBkTHFLRGVGL1pBcUUwOWQwZ29NamNPZmRzTXQrYWh4SWJ1UDdFM3E4Y09V?=
 =?utf-8?B?TUZJbEpOWjZhV3ptZnJvUkQyb1A0UXJuRTZTSUZIckI4Z2YxUlRvZG5wSTI3?=
 =?utf-8?B?SW9LUENVZ0djMFhDWjA2OEN0Z3YrbmJwYXVMM0gyWDcyOElZdERUNm5XcTJM?=
 =?utf-8?B?NG5KMkdJOUNtTGhrYk80WStUOWFKVjZiU09JWDllcW1adUx5R0lidlZUT2NP?=
 =?utf-8?Q?um9lsYHN/sqt1KKmdyacQ3FQ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc973b8-f0fa-4a98-f069-08dc37d658a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:54:52.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYgSKMzyrk1ZsQW+DKKP1eR3XW83+hliZYRDQGMdJp7ac2dEyBPAJKiDxFvgQiZ5WpVgYpStkz9AFIAa00FAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

Add asrc[0,1], esai0, spdif[0,1], sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 304 +++++++++++++++++++++++
 1 file changed, 304 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..78305559f15c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -481,4 +482,307 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
+
+	asrc0: asrc@59000000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59000000 0x10000>;
+		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc0_lpcg 0>,
+			 <&asrc0_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma0 0 0 0>,
+		       <&edma0 1 0 0>,
+		       <&edma0 2 0 0>,
+		       <&edma0 3 0 FSL_EDMA_RX>,
+		       <&edma0 4 0 FSL_EDMA_RX>,
+		       <&edma0 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <0>;
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+		status = "disabled";
+	};
+
+	esai0: esai@59010000 {
+		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
+		reg = <0x59010000 0x10000>;
+		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>, <&esai0_lpcg 1>, <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma0 6 0 FSL_EDMA_RX>, <&edma0 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+		status = "disabled";
+	};
+
+	spdif0: spdif@59020000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59020000 0x10000>;
+		interrupts =  <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif0_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif0_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 8 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 9 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+		status = "disabled";
+	};
+
+	spdif1: spdif@59030000 {
+		compatible = "fsl,imx8qm-spdif";
+		reg = <0x59030000 0x10000>;
+		interrupts =  <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif1_lpcg 1>,	/* core */
+			 <&clk_dummy>,		/* rxtx0 */
+			 <&spdif1_lpcg 0>,	/* rxtx1 */
+			 <&clk_dummy>,		/* rxtx2 */
+			 <&clk_dummy>,		/* rxtx3 */
+			 <&clk_dummy>,		/* rxtx4 */
+			 <&audio_ipg_clk>,	/* rxtx5 */
+			 <&clk_dummy>,		/* rxtx6 */
+			 <&clk_dummy>,		/* rxtx7 */
+			 <&clk_dummy>;		/* spba */
+		clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4",
+			      "rxtx5", "rxtx6", "rxtx7", "spba";
+		dmas = <&edma0 10 0 (FSL_EDMA_MULTI_FIFO | FSL_EDMA_RX)>,
+		       <&edma0 11 0 FSL_EDMA_MULTI_FIFO>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1: asrc@59800000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59800000 0x10000>;
+		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc1_lpcg 0>,
+			 <&asrc1_lpcg 0>,
+			 <&aud_pll_div0_lpcg 0>,
+			 <&aud_pll_div1_lpcg 0>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+			 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "mem", "ipg",
+			      "asrck_0", "asrck_1", "asrck_2", "asrck_3",
+			      "asrck_4", "asrck_5", "asrck_6", "asrck_7",
+			      "asrck_8", "asrck_9", "asrck_a", "asrck_b",
+			      "asrck_c", "asrck_d", "asrck_e", "asrck_f",
+			      "spba";
+		dmas = <&edma1 0 0 0>,
+		       <&edma1 1 0 0>,
+		       <&edma1 2 0 0>,
+		       <&edma1 3 0 FSL_EDMA_RX>,
+		       <&edma1 4 0 FSL_EDMA_RX>,
+		       <&edma1 5 0 FSL_EDMA_RX>;
+		/* tx* is output channel of asrc, it is rx channel for eDMA */
+		dma-names = "rxa", "rxb", "rxc", "txa", "txb", "txc";
+		fsl,asrc-rate  = <8000>;
+		fsl,asrc-width = <16>;
+		fsl,asrc-clk-map = <1>;
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+		status = "disabled";
+	};
+
+	sai4: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 8 0 FSL_EDMA_RX>, <&edma1 9 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg 1>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg 0>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dmas = <&edma1 10 0 0>;
+		dma-names = "tx";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	amix: amix@59840000 {
+		compatible = "fsl,imx8qm-audmix";
+		reg = <0x59840000 0x10000>;
+		clocks = <&amix_lpcg 0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+		dais = <&sai4>, <&sai5>;
+		status = "disabled";
+	};
+
+	mqs: mqs@59850000 {
+		compatible = "fsl,imx8qm-mqs";
+		reg = <0x59850000 0x10000>;
+		clocks = <&mqs0_lpcg 0>,
+			<&mqs0_lpcg 1>;
+		clock-names = "mclk", "core";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+		status = "disabled";
+	};
+
+	asrc0_lpcg: clock-controller@59400000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_0>;
+	};
+
+	esai0_lpcg: clock-controller@59410000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "esai0_lpcg_extal_clk",
+				     "esai0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_0>;
+	};
+
+	spdif0_lpcg: clock-controller@59420000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif0_lpcg_tx_clk",
+				     "spdif0_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_0>;
+	};
+
+	spdif1_lpcg: clock-controller@59430000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SPDIF1_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spdif1_lpcg_tx_clk",
+				     "spdif1_lpcg_gclkw";
+		power-domains = <&pd IMX_SC_R_SPDIF_1>;
+		status = "disabled";
+	};
+
+	asrc1_lpcg: clock-controller@59c00000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c00000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "asrc1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ASRC_1>;
+	};
+
+	sai4_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai4_lpcg_mclk",
+				     "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+	};
+
+	sai5_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "sai5_lpcg_mclk",
+				     "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+	};
+
+	amix_lpcg: clock-controller@59c40000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c40000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "amix_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+	};
+
+	mqs0_lpcg: clock-controller@59c50000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c50000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_MQS_TX_CLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mqs0_lpcg_mclk",
+				     "mqs0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+	};
 };

-- 
2.34.1


