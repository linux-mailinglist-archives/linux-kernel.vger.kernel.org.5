Return-Path: <linux-kernel+bounces-127130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4989474A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C558F2822C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F656B78;
	Mon,  1 Apr 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MVkI2rh4"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2109.outbound.protection.outlook.com [40.107.14.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCA58217;
	Mon,  1 Apr 2024 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010360; cv=fail; b=JF1irCrhA9W/Zw20ngBsA7jt2+N3tQXFc8vA+Y3LL/sR5MeKhdaVdU9IckM7MnZAKh3HNu4TS0F4aNC5ew/SzsNOQruFZ/OkGLx+mhq0uMaVeIvJrTeYUOhMEozQGDUeqHdKbYXz9WnpBPvZGjR4FvsZ5ApuU+TY3s+C1liyaX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010360; c=relaxed/simple;
	bh=PqFKqzOaCh+9X9gmH8adyKHBMmo89yE+D+WZJtUo004=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WCqZ68cIMTRUuM9F9BB9+tirvsgqAyNGph9suBYnWMkMq0bhlBolpRKviFQ8ij/lCzZh/JB4Sb2qOtr8PzG7+DboXEMHvmGBbbiiwM3knRzKTz9K5tSlrY6RkIbB2SkjTcwFL76m5Yk6SWv2T7rLCxtkEjRWdEJn4/BeznMi/3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MVkI2rh4; arc=fail smtp.client-ip=40.107.14.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myBrHfXm2GBI4QEPng40/pJ8G9E2PUy6kRFIwk4dX2HakHNjeUk9no212Cgg6U2kPg38BiwuHeSaFaCDLWApVWns9pfSClhnMcS0fbgcnN0k49LxY1x3lNmKanbx/jcuh6Cko/CjT/BBicIermky/36AwJ8xdIs5BjhEGqwZ33z+wbX3d69ZxH95UBN7cjl0YFlC0KgzHwH6NoXNsWJP3A7NPSZwJNh35CUfrNaXsfLKtvkDpfTDOMDoV1ch7yhb7OU8lTcQkWC123uJAiM6m72MKdGfZhqUFR4WFpY6LrrkxZjcAolFp25nnSenMKXbdg/d43yIr5g/9t0JfrFJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT3E7dpZi48J1VSrcWmHxpkF+vwdFoPc2vglBlfmOSE=;
 b=kJizs2C/+44RGKCKvbWMb2fsi6xIIHDqGW7l/DyZj3AjE0QZrwGONMcirhvwpP2t5AgzHnvv7K0iwa/mI+US5I+i9UUWBQBCJ4NLl6I2WWuv4BjGXb9vlanJYSrZBgMp+K5pYwGFwysF/hBcjLSKd8NDcxj4Eo47T4mQA0wlx+GxORsJhEUlIRYgYCYpKulP7WUh+UwxI+Xn+GSa84jDZHYEUxj1DbB5yN07G/4Z8lBeorOqDHOzrmTCZudw+sm4MMs0gtt2h3FHsDa1FfhqNqpplurB1OWODbFAmEh5E941THcrG0mu1oEXhiWVcy7BCdyIwUmaU/6ZSll8/FY2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT3E7dpZi48J1VSrcWmHxpkF+vwdFoPc2vglBlfmOSE=;
 b=MVkI2rh4rLTg3oC4dFQPLwtRr7qMFUj26VYvPJYSYGHZC/RpstP2m4R/rfyfuSdKg/nusziV+LYwQuUAUc4Q56qM/uv4i5aKkHNyaU9NuftpnsdcmRTYAtaCZXIaCf2qvuB86sSIDR2vDoJXwQoES2Ek3CikBpSGJ6PmmeDM2Jc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:07 -0400
Subject: [PATCH 5/7] arm64: dts: imx8-ss-dma: fix adc lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-5-8c51ce52d411@nxp.com>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=2028;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PqFKqzOaCh+9X9gmH8adyKHBMmo89yE+D+WZJtUo004=;
 b=3HrnBKewz9QWbC9cMMt4OcuPLW46GVDiuX2FoB41ZgOv9JFkveV7BwHN9mTXY2XCxC4OYuRsV
 1oI0111dVdlCiPZ/xPhQta0xdFC6HfR0p5uu2HzkzpyZrT8hGDpIAeD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 0kl/BZQXYSQjfZehZYZQYFbKCzTxExmh6otv39/LwM5B6fdYN+zaI+GvJmtN/xz2HGFeHm1quSxpxuNHY069UgvG+QYNuciKQ+w7re+Sj0pVksfRTSn9QfNRbqFRiKwHleE5rBcsFE6XJwQ50eJI3QSP15kLD3c3Yg5s0dYHBRw+3TOQr2fvv7GiXoNvGv3Pla/5tM62SdvnINNJqxdFhjM6slTxT1DzNASx7aABRWgK9X+K1Z0aDKmIlAcYAGCsqL1UmUD3ruGO/m/ERNQgXgdegAvUFe4l3ENPi7aW38rxV7+Sch6KAIbu1Ss1zGh18KxGr0sv9GgZG19Iv21uKOtzLmST/76KTJy1iBOBPLUfNVob+TKxeXE9DwiCWoMdjpiYjzEwU3O9O6DE+wAVlsLNovPx+uuhcYfLVbM7Modkj1i8DvwGRyN/E+aU/2pnH0HnZ52K5S/HxAfg5Co1u4CbQcA9KNtolIK1k+cT1YuMFafp0o6EOwU1KMe9lSgTXls1nxcsQmGzIpQQNrv0mkfnEUaWAB15wpxVbDhNn/8VZ2kw2+TNNEQqH1g7wV+edNjjNGvYxk+zPkl4qFqsMgG3NiN6tStlRuYVc2OArqs87ZcWSdPvqJ3IhCfSnyXCoJ1t8+px9lerihpRsyedLte2ce8RNPPz7ivJgSDP2Da6RYPUT9y21yE1Kxov6lS0GgBX6SivA7Q/Tst6l6CKOZICVdK6foif/A1putPnLzQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OVE1NWNCZnMzTUJYZlV6bHpieVY1NnV0RjBzUjlqcVdSdVNNcEdHZ090Um1T?=
 =?utf-8?B?MTdXb2YrRlI4UWhOZUFCblJjK2lSSStUaHplWjBwbWZtZU5wVXRXSkJlNkV2?=
 =?utf-8?B?TjRPNkNCRWFQNVRhNGQzOFVudC9OVG5IcnpwdWQvdm8vUkFjSllKTnZISTlV?=
 =?utf-8?B?dXB3MlVCRzdTdEoxbmtjWWpvYll6TitjaXBFdjdublk3UnhjL1ErazJiVS80?=
 =?utf-8?B?OGFncmwzdElPcWF1T24rVVJLQzViL0xzV2xNM0FHajdjdldIUXl0RE1QR1d5?=
 =?utf-8?B?dG1Xc3duS3BYUHh3cEZCZ25JbzJlWGxjd0Jxd2liNU1DWDVsNVpUZE43bk13?=
 =?utf-8?B?WHFLRGZ0ZHVEbWNwdjNYalg2aGZKNGxGL2wxQ2UrajllWEFCcmgwcmc4N0dM?=
 =?utf-8?B?Z1o0MmJHb2FsZU5waXBOU2dOa1lRVXpiVm8xMDBUWnRLMlpHMEJiOUw2ZEUw?=
 =?utf-8?B?N1pveEo5UWNqUEc1c083UVpyMW84YXJnY1Y3L3Y3WnczcTN2QzYwNjdSNitB?=
 =?utf-8?B?RGRUZmZVcnRKTkw2MDFzVW1ndUo0eWVHdjlUb2QzRWlnL1YvTTM2bkUwb2Vj?=
 =?utf-8?B?Rld2YitZN2NUcDBsRE5nUmQ2UWIvMXZyU05hQkw3b2NNZGNnUTlVSkxFYWJ0?=
 =?utf-8?B?K3pwWnVqMk9IeCtHVGZyWDRlc2NKUTJvdE5pZzEzTjgrZm9BOVJNaldENkZI?=
 =?utf-8?B?cW0xcXVMSmV3c3hvdklXTzZBOTAyLzgyeUxvVjBudG51UFl2RFdldW5vQWto?=
 =?utf-8?B?cE9abW0zSHlWcmxIM3Bhblg3VkxIYkV6NWh0VUtnWDdrZVFuWWM1dENYdGp5?=
 =?utf-8?B?dG9weXc2dnZvTTdjM1JqYjdrenlCeXFHS1JMaS9FalJLMTFiMGxMSmVhY0oy?=
 =?utf-8?B?TSs2ZWhMZTdPeVk0bEVicDBaQ2ZoQmFzbUY4aW5oWFBGUlJPMFRHSEhpNEtB?=
 =?utf-8?B?L2I5TDRSd1pFYjhDd0hXMDlKWWUvR0RURXZhQ2RWWTZUbmhJNHg5ek5HMG5W?=
 =?utf-8?B?Z09nTHR3K3BwOEhJYU1vU0YxdHNIRDRXenFhSXlSamlNNlVnTzVmeG1aTXY5?=
 =?utf-8?B?SS9DRTF0UWFPMGI5ZXAyQlRoVDA5M29WZ0tISkpiSkVjM3Vkdk9OUXdJOUJa?=
 =?utf-8?B?RE1oWDhCZWJCOVdjNXpHWmpNNTNZL1FPZWpIaS9BcmpmN01adVRvNGhsaEJ4?=
 =?utf-8?B?Wlo1SGpibDhteC9PQU8rZVJsV1FqbEFRNkkyRFFxTjFWUXpGRk5yMlM0NXFx?=
 =?utf-8?B?UjdJdUpiYS9NQmwvRmE5QTNWbzkvTUNTZ2ZoaVI5UVNsVFBTVVlTSi9ZYWFu?=
 =?utf-8?B?NmNRS1pnMmdoSDZ4ZmVpcEp0ZlVlZW41ZzgwNDJ5T3FCZS9GMXg5SnV3S1JY?=
 =?utf-8?B?YVVjcVphUkoxRFJHai8zMEJlaU5sSVhiWjh1blFZQkEramFwcTNWNUd2d3JU?=
 =?utf-8?B?OWRtMGErUG1WeDllb083OEZjdGZCeVc5RXYwTlNSOVRRVDdxK3N5WThSUW53?=
 =?utf-8?B?WlhkUGNZZXNUcG1iKzhrbVhXN1Q0cnRUQ2NFN00zeW8yUzR1eW41ODk1b3cy?=
 =?utf-8?B?ME56d0srQ0dPRU1haVVmN3ZyTnpWZllBejU0WWRuLy8yR0FRNkVSeWJnYVNr?=
 =?utf-8?B?cE5IS0hDcGRzeXEwVXE0RDIvcnp2QklFWklPb2N1R1RyaG1jOEpxblVDZFJB?=
 =?utf-8?B?d0syOGZoVXdwY3ZXd0dMR25pQzlrMUZWYnRXdDFiYlNOZy94S1RVbDJ3alpi?=
 =?utf-8?B?QjMrc1NXaGpnbC8wTSszU0ZtNjhaLzQ3ZVhOdllibUdEdFNZdk9HRTk1bHBO?=
 =?utf-8?B?WTdDbXp6VTBJN3VHTFpWYkhWWkVPTE1jaEhxbFZSbTJVaFZyZUplRVUxTi9r?=
 =?utf-8?B?c2pEd3YyQXA4QkdrTUJaUzREQUZmeWZEM0NJQXByejVTRHhFV1AzalZFSUtK?=
 =?utf-8?B?OGUxa3c4QUJuMTlucXg4N09NZFA4NVdhYmJYazk0dnFROXlDR1VtU2FrWGxN?=
 =?utf-8?B?YmtjaUJrRm9TQ21DS2tkeXg4QXBOblB3WjlFTy9PMWtVL2lWYjh3SHEybWVJ?=
 =?utf-8?B?MUV6OWtnSUoxWmlPYlJ5UTlaMVdKdHp6K2wwN2pMbjhHVDNpWDU5OVc3eEM5?=
 =?utf-8?Q?LxXE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8779785-9b18-4049-331c-08dc529ab302
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:56.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb60hX+l6TU5Ok/39CUa+2ZiRGVNaHdRGjdozkr8NWzivTMQYzQlbgfLmTtXi71mCC+BjmZfwgxhExyH4cKDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

adc0_lpcg: clock-controller@5ac80000 {
	...						    Col1   Col2
	clocks = <&clk IMX_SC_R_ADC_0 IMX_SC_PM_CLK_PER>, // 0      0
		 <&dma_ipg_clk>;			  // 1      4
	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

adc0: adc@5a880000 {
	clocks = <&adc0_lpcg 0>, <&adc0_lpcg 1>;
			     ^^              ^^
	clocks = <&adc0_lpcg IMX_LPCG_CLK_0>, <&adc0_lpcg IMX_LPCG_CLK_4>;

Arg0 is divided by 4 in lpcg driver. So adc get IMX_SC_PM_CLK_PER by
<&adc0_lpcg 0>, <&adc0_lpcg 1>. Although function can work, code logic is
wrong. Fix it by using correct indices.

Cc: stable@vger.kernel.org
Fixes: 1db044b25d2e ("arm64: dts: imx8dxl: add adc0 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index d4637037ba1b6..77ba2dd6847b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -377,8 +377,8 @@ adc0: adc@5a880000 {
 		reg = <0x5a880000 0x10000>;
 		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adc0_lpcg 0>,
-			 <&adc0_lpcg 1>;
+		clocks = <&adc0_lpcg IMX_LPCG_CLK_0>,
+			 <&adc0_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_ADC_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;
@@ -392,8 +392,8 @@ adc1: adc@5a890000 {
 		reg = <0x5a890000 0x10000>;
 		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&adc1_lpcg 0>,
-			 <&adc1_lpcg 1>;
+		clocks = <&adc1_lpcg IMX_LPCG_CLK_0>,
+			 <&adc1_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_ADC_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <24000000>;

-- 
2.34.1


