Return-Path: <linux-kernel+bounces-96091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3492A8756F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5EC1C213E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E8136671;
	Thu,  7 Mar 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SOxfApRv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFD137C48;
	Thu,  7 Mar 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839190; cv=fail; b=OYRMmo1LBJ1qgWePtdfKffQPi7BlU6QEd6Oh5HrGHYJTPj/uabeQ6L96iWyD9aM+YjWgPzwWzdXv8cRWPkFwo+c46HBS5bZXJaMAYaEWJT8XvJVaET8JlQXkD1LQUs7/u35tqOZ9D08vpU2flX/7Ps2RJu4CU8qT+kUkUSIUL+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839190; c=relaxed/simple;
	bh=D/R5xpB7nUStCi7qPZ8KjfQq8oLcfigi288bYzejh2I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GFpmU1M/fBKxtSD9+gKJW1REtZFvL9DXv2iIwYwe17mYL+FJ3y9yFQhY5C0uDuXqCdGnxify5epZTzBBhiHKl4r1Cd59s8xe7TR5ZOx2h2oNUmjSq4UTAUJFWLgga3DS/IuigpNiZxV94sHiP3udpICO1io2Q45tNSStIcFESfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SOxfApRv; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUM582QD911clXxWnkyc7ywxOq2YXFqvips0qfqZlUeSwsC4WfHgXldZOblbxuH6epywH7aYbzUmynJtyMsx2m4CUOci94vR43mGmS+2Vt3ITM5DUsEMxcDgy+D6Bz9O61Zr2jmTwPPe7ubE1GEujdlLIf6b1k/R0FKd2hXJnI9xXaHmOsPi/uij1GcP/z02ofemuCLSAw2/PNShdOi0T+xHMfXB0/hjbKyKbqKc19/CuTuB+L0UaF8D13y1+CIL1xqg+xO2RU8GC1xod8MFHen8//xHlI6+MQjysOQnRcE//O264F6SBI6qvX/PRghrM7YUIiX7Gjj0Qh4DakURVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huR+ZJYUKZikB9kNtJDK+f8LbcOyOe0sZHlOK8cmly4=;
 b=UxawuWZ/yqkZd6WNRTOl7FtyUBGmPOBahhCu+B/mkxQpZBlMYXyG6k6dNKc/XEIPe3eCQoVqz68s/Ylf3PJx1Tu3+UhIHw9oMVc88cM9K6PchVWQwnen5uZqkgFAdp18h3bW98472hpwZdwwbhMzhMlgrcCZOlA16EKve1ftK7/84NAfPGekrmQah1l2NpKnHFB/b4ERd2J2feu7QBXxkBUJAdT9H/AnKkH2nEJnEDLYpWk+PelKhlMYnFbc7s7BsDLFs6p23Q7yZ4hnKgsKC+QVnshVOHEKHQioB1KqVuKrFr+io1Cr7E8794C6W9UkSxUvh0/24O5hxhg1mwe02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huR+ZJYUKZikB9kNtJDK+f8LbcOyOe0sZHlOK8cmly4=;
 b=SOxfApRvScIKz8J/bL9HBt5aavlO+XeZRDGuHWKClo9dDyqneUaOdQk6jaxk6IYu3tm6vH74NGl/W9TnRdBmJIZc+l3pUizTrld3Q8b0PxgVyulNXHJTraS4HoYk1KhvM9JFcucZNKWaACpl977qV0CsJ794XB0yfo5M8EOWO4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:19:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:19:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 14:19:11 -0500
Subject: [PATCH v5 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0
 and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-asrc_8qxp-v5-4-db363740368d@nxp.com>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
In-Reply-To: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709839165; l=9815;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D/R5xpB7nUStCi7qPZ8KjfQq8oLcfigi288bYzejh2I=;
 b=y6bsmqCjCs5a7NPnWr2/cpeO2TPXP6F4lpU+a8ZGU4HY1ta1FdM2P0b7exTaBGAdT8y/RAs4O
 MEv/rpqRcD+AQF9EwdYdDoZVUwpPceSeEGdOvs3tfd0L8z56LduRB1b
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 95afe52e-9a15-4f6e-e698-08dc3edb8c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bL7XQ6JIsRG9uKeWWJWBPLTwZtNkZB98z/sO1nG7g2dkbsCBblWB7T1itEBEdIVFrGOVjBJcyWEUIcNVz+xXCzjZ0je0ibmqV1wpCIEDSHrNOpabGB6KWflwxBrTtm/p0UBUeFAgwSO8NcF8Q33+6S068TR3tkC4EuZFxwcxCg1mUZ0s3fAOKGt+S8075QGxc8IdtMY4ga3YMWV6pz4vZvZzniBF+0Pzle9rQ+uBEHOQTT7bOEwX7DxP1DuASUik/EKAeizX/WxA53oyVfk87znFLwcQt9gpl/2857R0DSIJhkC36N+xjGoM6f5eD8VIDmGIuMHCnWAmUuanXr77t+iE6TirxPK8Y3nlKxDMwchnsUYJrJoi/RJQCly4WMXVRA1tB8NSvNl0HVH6tdB1N6gORy3AjZu1QRoJxfOYL0zfnPiRTOnZvF4KRoyvOTpn101BsD8o8YngUKwvn8XTtOJUtH9nDdaO13MuyHzNJ37htxHaW3cAxDk4CxTYeAzKVMV3I80D5F/QtbWcrDk/uEix/WqWWC5goDW3s2TfOW/JVESZrczJga6xJdhs+adx9r5AFI9Y8icZmKD2m7EdGkT2HDl55ZX06/mulj2dtbJRSX6Sfc8zWkhr8z8CQ9aJZ32P3l16Cd1qnhbPdeijvN7HxrTahyVmZ+XAi5Zntt2PTSPSP2eO4npy5CAkWbVUHox9xQ4DQw9DbBe0IXx1ACbm2Livwk33EvxGLlHn2+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU0zVmZoTmRTdC83MEk2M0V0MW54TEtiSFo5eWJDRjlFUWYvejJ1SU01K3o4?=
 =?utf-8?B?TG1NV05YNDBhYmJhVDFjczRSNGd2elk0VDRoUTNqR3h1b3F1TlRyWmR3TnJL?=
 =?utf-8?B?TEduYm9XUUxwMUZTMzlZTlZrSUlRV0dPbHJNRzRRVTNqRkRTclB1VE5ocmlR?=
 =?utf-8?B?YXNvcXRySzFNWS9ieXRwdksxSUJUWm9xMTduSXdWZjVKQi9nTHpiT3BrOTZy?=
 =?utf-8?B?RUYxam92VldtTEtoalFETGtRNU9NUkhDeUlTM1V1MVRlQkNzU1ZzQmhGYjBU?=
 =?utf-8?B?dVRMSUlQUCtHVTFHYUk3Q1pFb29jeUdCUHc3b1lmbWdIY21OUkpPanJlRXZs?=
 =?utf-8?B?OEs5b0hHcHJWNEtWVStiU05weDVwU2s0SFhXZ1NSMy83emRqV1UwazJxUkNN?=
 =?utf-8?B?OTg5RHZ0M2I5ckVqVzFKaXljUjBTNUw2M3VuWG1TM2k1cmJqV0FreWR3VGNx?=
 =?utf-8?B?Q1lOcWU0NTJ1bmZWbTBlcG9tV2plWGFwY056WXFtMnZkNUcyVFVXUVJ1UmFQ?=
 =?utf-8?B?eDV6N29hakJuR2Nkb01ud1JVOW5Nb2xPU1BlMDRlWm5ISzZscjBIazF6dU5E?=
 =?utf-8?B?THFEeDFzYU0zRDVHaWdBcU44WWRnZ1FNa3RmZVAvdnV0dHVlUlhJUWNZUEJl?=
 =?utf-8?B?SzZxWGVxZW10WmNqTVlFVWwwWmgyUi81WEk0dTRZbFF2RitNcnpTRlhQUTFw?=
 =?utf-8?B?Y3d6SmNucnIwQkdqQ0RGV3EyRHZuNHQ0RG01Ump3NHp5MFlRWWZFb2NDSllH?=
 =?utf-8?B?bUdleTlWNkxmTXdhQzJTbkRpN3dDTjVnOVo1eFd5VUNyeFBtUWdpemNMNGRv?=
 =?utf-8?B?SjhCUnNraGExSVNPQm9PZXhNQTA2NFkwYUF5RHFIYjcrL0tNWnFRckJlamtE?=
 =?utf-8?B?TG1yNXhlQkY2ODVNOFhlMnNsNmY1L1N3WXJOQVY0RlllNFVERWtxSk5ZNDNl?=
 =?utf-8?B?dDlSQ2N2S0xTMHpFeVpKUTNYNUxxYjVqVFZ3NFQ1QmxkL2QwblBxT1V4UlEz?=
 =?utf-8?B?Mk5iQkFPdnlqUUlERWtJdVprM2FQaHl3VjNmTG5YREhLR0laVGVoenh6Z05o?=
 =?utf-8?B?TFQ4bEVEVjYyMlhucjYrWmlheDZTbFBSa0tkRWVOa3lYdUhQOENzb2hiSzdX?=
 =?utf-8?B?b0FNQjVBK2l4bGE3dVpLMGcvZU00aXN6V1lySmdOZGdPWlc2VDZBb2JLZVRK?=
 =?utf-8?B?a3ZKek8rUVF0Y0YxTlQ3NVh0YjQzdVZIejRTZHA5UmMvKzVTQ3lGYVliRXFM?=
 =?utf-8?B?TWVOUmk3UitsR1VpcklsdEg1bERjNzJyS0xKSDJRc2UwTTVlZXJaS2kvbkR4?=
 =?utf-8?B?Yk5JNktFKzNrZ3BoSmg4VnNVTGpLTEdpRkRrQ2dnWlQwcXlrdXJubkxYTnFV?=
 =?utf-8?B?Rkl3cTQxOGNnUWlGc1hhbHJQaDRGYUhjUmpVMVp2QXNqRG5jaVhRdEhxV3NB?=
 =?utf-8?B?ZEtRbGlyVURXV1NIWHkwa1YzNWZGSWtoMC9MY0daZmhjVmVwVWt4YVBjT0cz?=
 =?utf-8?B?RVo5TUF1NXBWMXpuaUV1ZXhxZG1xV3ZhbjcrTE1oUnlYNm5mbFM4OWFNT2k2?=
 =?utf-8?B?NmdsVk1IWHNzdXhuNGxCOGZiaDAzME4welpJQ3FzUWJPVVRYSDlxSzdKSDQ4?=
 =?utf-8?B?UHJienhDMnhmQ1FMajlwY0JBTWZCcTdCY0w1S2xiQTFOcVZmQXJ1L0V2UEFr?=
 =?utf-8?B?TXVjeFFESWlTRVZ3OWxtbWd5MUppM2ltbCtUdUVYRXYzOElPQ1JNcXIrZ1lQ?=
 =?utf-8?B?TUx3ZWdwZW1zVVM2YmtkQms2a0ZjQlNWbHNyZk1TdklsMDNoVERJL1hrTWZa?=
 =?utf-8?B?NlNRWDh1eEJFbENXWUc4S3ZKQ1dNeUdLeUJZeTB2OEZydUZwZGVwdFJNSys4?=
 =?utf-8?B?KzNjTHFUVWppSURVc0NqUnFjanc2SGhRZ01FRyt3NEV2VGt6VmpvUktGRXdz?=
 =?utf-8?B?YVo2VDBYWVpzWnJibkJ3M2NwY0cxUE9sMThoNDdDWFpITEhTZTJuYUdNQ0lz?=
 =?utf-8?B?am5wVWZSTUt0elV1Y1oveVU4YXhvVFY2a1RDY1hmRmh4REkxUXdmVDNka2Fq?=
 =?utf-8?B?WlF2SUxCREJUbkVLWkphK09pOGJWMzFrdlRQSUpvU3ZZd1JnMGFvZXJvR21T?=
 =?utf-8?Q?KJl60rDluJnvpol7SsajGTCAA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95afe52e-9a15-4f6e-e698-08dc3edb8c80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:19:45.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPkJF1veJRxZCBAgWnxXs2jy1gDcpa5FtktdvG+qqwbO5IV6Ir97m4xFgnkBIE6mIMFOnIzSrrA0FIzyclVSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Add asrc[0,1], esai0, spdif0, sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 267 +++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..3c57593687f81 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -119,6 +120,86 @@ audio_subsys: bus@59000000 {
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x1000000>;
 
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
 	sai0: sai@59040000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59040000 0x10000>;
@@ -239,6 +320,40 @@ edma0: dma-controller@591f0000 {
 				<&pd IMX_SC_R_DMA_0_CH23>;
 	};
 
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
 	sai0_lpcg: clock-controller@59440000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x59440000 0x10000>;
@@ -333,6 +448,102 @@ dsp: dsp@596e8000 {
 		status = "disabled";
 	};
 
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
 	edma1: dma-controller@599f0000 {
 		compatible = "fsl,imx8qm-edma";
 		reg = <0x599f0000 0xc0000>;
@@ -481,4 +692,60 @@ acm: acm@59e00000 {
 			      "sai3_rx_bclk",
 			      "sai4_rx_bclk";
 	};
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


