Return-Path: <linux-kernel+bounces-106541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A1D87F01C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA65A1C223E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAA56741;
	Mon, 18 Mar 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gq10Uf/7"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2D5813B;
	Mon, 18 Mar 2024 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788467; cv=fail; b=JM7UoMnABjJRURe3JH23vg7XVltYzoirR3Ptev8cTgCfac600L7AOYvz9XCI51s2CSPuVBueUxY3qtShF7tO3WkBVWHF0Cg3NhN7nPLe0YwC9VZkFGpOU9lo3SOfLEAEpcUyoMrRaiwRUe9tS2NrGc1aL4U8v6QxUtQiAmgjNdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788467; c=relaxed/simple;
	bh=qAfBYrkO08yGnKQGR6fjbQTnvzJDmfUQKuhObdOe3bE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZTMd3vyJMD3cbc9tpZq2RcLlfxD6k+DEG/rZiAxuz0pBfXuJ03qySSP7WN+6LPxdCqsq5gkMD23R/kudomywADS2nU9XqWMcD3sVpVc+hA+nEsvTdDyFpkjnyakC5ACdlJvJqdTRZ0MKBlwgM8VFSssY0dWPW/qx9sgKvw+ZRZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gq10Uf/7; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLigXHYEvvbS2dUEq5KkhWgJihGbGzLL7KL1ozDZuZ9qCiWk/MsMGGZdgKuDM7cZ6V1MY8KtXrkhr2gnuODhJvGKcdP35o8Y275cmQZbOvTIZrj6tvkg13CJ+IQVF/7MyJAYosi8/7tc48FgjBQ3XTNJ6zUW10qMR3PfvY+Hlk8TD1qkO9QG4dRVIK+fCquCgeozRugI1IoDRa0wZNtEutF7sFunoFNhQo8fzjxqwc2pvp2PyshRx8lYbzuxpktL1y37fAvVpwirFc+kUo26gpG5a/t4IdV9TUEC8jrHH8qx6xPDQleiT8ztaYl8/Xm1plhwMqie2Q4/SqmOsZwuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkg2H7ddNwIZIQC1R8Zb0q6hwKirK7cL/YmbIpemUvg=;
 b=ZpR60Q4uNWgcfiEWgQHxy8GT4J9zONfUAeOBUPAlcZh+TgA2ZX2wX0BZxpYlkIdiDqGAnvTtwFpzOrdsS5cGLcYYDKQnw4tnsPKKeWYdKtlp9yLIv7kWExDgFKqG5gTjcgeIscpXq0GGbYX3kfDP14pB9CbNVLEyjdcUG71uaiejHn9SGSS5vmeEQutxEzxT4n2d1DdoyIu1XaTC4mt8Ebbtjh+OuSbeYvq8SwEo45rQV3HAsLWy785r4IGEcgFNIx74c6FyJoOL5Ii23c4Fu0RyJ+iarNoOXodbajv9SciGN6UiE5omzY6TMBNMgsz34zp3OSVBryOoRHAUMo6FFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkg2H7ddNwIZIQC1R8Zb0q6hwKirK7cL/YmbIpemUvg=;
 b=gq10Uf/7LKrQofMuiSYCvz9ReWhkjsTb94AlSNr+yUcKApXZmH/pmBTxBNaZdeuOF8uOaXUnhxcPYh93FbIxnadGZHazxtyfkYyLViB3zEDmwvekg2qUToj7CIppZ6d/aTXbx8FIbF/onnxtJ/2H11O0qIAhGkug9DB92lg3s1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:01:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:01:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 15:00:10 -0400
Subject: [PATCH v7 4/4] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0
 and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-asrc_8qxp-v7-4-01ce5264a761@nxp.com>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
In-Reply-To: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710788441; l=9795;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qAfBYrkO08yGnKQGR6fjbQTnvzJDmfUQKuhObdOe3bE=;
 b=NvWdQIrH2FgAj/Lm22MQbHmPvo7CbRZWdBCWKfIb3hwjSWQFt35zA1ATJ0sq6wjDOfka6CW6M
 9cOXXuRZRG2AFgFqGZn00sL/F+5OzS/AyNbcjTCjRSRJzNdA4KxvaYM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: fa91049a-97b4-4da5-ad39-08dc477dc119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qmOJDEWQeXuuxJ0VThkZkWDT+m7mK0d2CmL7zdNiqfhxptq9gR/Gw50sX3uyaFhkBHwidYnxUg+UD664ByT83G60fbPD9+pFpmsW9Lbiq9EUsf7lg2PHlQW4FTVcqOqlz4rYJ88wEGaBY1Lg8jldjkDLY8YyFdVX93OoeNPD27ewXOTPhVtqr3OuYOWgSi+zJe/wq1qgzLLdnPasix8CGCS3J0Z0bvwx76Nx2HaQSXi5wIkc9qu+/m/J1ZDsXd6x64QakLBWmut7aQ/3YlYcGtlCIpUDRNi8+c3/lBqLi+FDzZt4gKnzcmjHWEEt/T5J3q4XJ8qzkAwc1EDrIDNzmWQ6ape2lJ3E4bSXAxj6QmZr1uUqdwEeUJjFm3Kr0F2msITAv7QU8RyYIZs1qS+4qrRKOU8N3IsxOUg6uo6sZRqSQoA6Vam66MDMZ4ZcndwIaJp1DAgsMT9GxyUkQTbX7oQAeWqvpNtJQv8lfumhgdXRGXb2UVWD2dNYmLk8L9RhOSMrtpzOh5a0ehNqIZU4ErWcFaoziNeDGDwN2axyYUP/VWzBr+kaUN/zOSqmCw1DqW5mW7LNDTS6H995Q9lxpaw2EM5qZkwDSobwNW7sENavHGM2Sw6RNhyLwUQKIMI2HcoBedtz0Onhdk1KH6gVLNmFOVmH0l1mPlc2bp64KEg8hitZsMXWbLDs+gbA+P8syJHgCGWyyTnWEnbxlJz4prOdm7e3GjBDVRGbgHvabLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJkN0MyaURONk95Y1RSNTVRUDBqaCs1WFpwT29IY0M5OWlmWURBNFpzTVJr?=
 =?utf-8?B?dzNBVmhIVWtabGlaVDFRbGVzTlFUUXlWbG5VTkhQOU1FQ3RlYVRkcE5TZFVM?=
 =?utf-8?B?TXQ2TEwrN0FDK0NzSDRKaC9WeGVYb082RUZvK20vQVBKVWdnMmNJdXR0SlR3?=
 =?utf-8?B?ZHVXaUEvb0h4SnVqN1Nqb3F4MVBDbDc3OU8xZ0x4Q3RJVHU0S1hPVVFtRUFT?=
 =?utf-8?B?MlowRWl5TE1QWWI4LzRSL0tGZ3Y1V1lDaDhvcloxMjB3VGJqSFhWRUxVbWov?=
 =?utf-8?B?UW9yVXJjTUtNa0ltYm1rUUdVbUM5VlhYeUxTT3ZpWlRQNmNSbmdrVzNNaVJo?=
 =?utf-8?B?eWltcWYrelhlMlJGZzVnSUpkemtTNHBOampOa0R1dVpvOWkwNElUTTVUaWtT?=
 =?utf-8?B?dmxrenIrQ0xOOWFVUFlNVGZ4Yng1RUhZUEZacTdzMHEvbjlVT1pzOU1GZURE?=
 =?utf-8?B?ckt5STkyLytkSGtyR3NPS0RaTWRGblROUk5jZ21McGF5Q1BHTmY5UmYyOGVW?=
 =?utf-8?B?MVNObnQ3eXJYbkp4VkNNNU5uM2JCRmxoY2RZaXNtZWZkSEFydW8rMmFjMmdT?=
 =?utf-8?B?cEFWZ0RIaTZSRzh2VWVtWVVTY0ZOVFB6WmVOZmtCWHpvVjVESTBhbDdDb21k?=
 =?utf-8?B?NGpsU3ZGQjV6dFRibkhsdHJ0aS9VWGwrMkJZU21rSk51Tmppc0JoYjlxTXl2?=
 =?utf-8?B?MW9rNExwS3pyZmp1aWpUdDc3Tms5eUozTnpPVDltRCtWNmFhVnRFck5mQmpr?=
 =?utf-8?B?bjcwS3E5OWR1Ti9zUzhiVy84Zk1lalFGVkpPNVRSdDVmSXZ3SWI4WVlFWTFa?=
 =?utf-8?B?NVpXa0tNUVlBSXBKK0xhMzk5MnNPM3dIbHY0Y2J1RThVenFWcFYzVjdpa1N6?=
 =?utf-8?B?V2w2dEl4M0FaS3BGc3JtZzFLcml4TUhXK05rdk8xZ1BodUdKcmJFdytFM3Nt?=
 =?utf-8?B?SWhpZmJibE9Dd3o5UkxoZFo3SEY4NGFMT0lYUXpPRlJKOEsxZmQ3VTI5SGlG?=
 =?utf-8?B?V3dFejZpS1RZQ0tZRzFzeEpJeFcxNy9jd1BwQUNLMjBIM1Z1Ky9jMTdDZmp4?=
 =?utf-8?B?dU9CM3dLbzNqbTBGTUZVTnBYVk1uRGtGTjJJVnJ4UVJtVGN4OEJORXoyZVIr?=
 =?utf-8?B?bDdFRUhjV3pHdXdTWHhaMmVXNGFPRUZLUzg0eVJyMTNEZTZhVGlwQlowTmQ2?=
 =?utf-8?B?azVGZUxZWmhzUW1FQW9PcTJQVU1WcjQ0R1FxeEZvSktLV2tjd2V4eUg5UWlw?=
 =?utf-8?B?OUgvejVhMDRoV2VOSDhWS3ZsV2FxZVFWdzByK3NxSkRPMnZWbTI2M1BGRGlR?=
 =?utf-8?B?ZzJJblBZMENkZEtrQk01cXYxUmZlVXp4bDVwRWlYRTlDeStaSzFZNnRTbndv?=
 =?utf-8?B?V0xKTXpjOEh6TnZVMU81ZENFdFEwSTdkNHd3QnIza081bnhtTUcrODB2YzdZ?=
 =?utf-8?B?S0JnLzNFcDA2QzIwdzJKSUhBdlprZWR6c1ZnYkE0d2dFYVYvNy8zZnFDMGs5?=
 =?utf-8?B?WUdrZjFycWVCekdCWEhIb1JOcU5JZnN5ODFWMWczaVBXQzhib0o1Q2dqOHBi?=
 =?utf-8?B?WEF3NDlSaDZXMWYxL08zSkI3WGxubkZhaENYMkp5L1FlcGQvQ3RkSmNiUXEr?=
 =?utf-8?B?dHdsMm0vb3JXUThvT0t4Wm9SNjlTL3FSNVNxbzU2dG9lVyt5WFVUT2xwK3Y3?=
 =?utf-8?B?eWUvNEZUeDVNWDZwck55SDhtY1JhM1B2YXBuM2NiWE1rWXZ0dXhma0xqYVZY?=
 =?utf-8?B?cU92UDdpbUgyeHBmZkpoYnU0c0d5OW9JRlpOQUNPNVVkcXNieGFjSko0VkE3?=
 =?utf-8?B?UUF5UDlPN05JZW1nQzk0NGp6VGxCUWZ5VWVPaVRWc2Uxcnp5Snpsd1lTaUtN?=
 =?utf-8?B?cWxKQ1RJWmdxNk9vWDQ3RTJNbmNNS2o0OHlxbTcrTk5CU0hWaTAwbFdwL1Vo?=
 =?utf-8?B?YjlnQ2liVTBGdzdMcjdKVnlZYmVwVlBXekRwUlNVYVE0RFl0bjJKbHJidWhr?=
 =?utf-8?B?cER6UGhNWkYxZTJNclRNa2ZGR2dwc1hBanpGZU9LYnRCQmRxWmtUeUtWTEZC?=
 =?utf-8?B?WnQ2YUJNYUVuZjI1RE5SVjJwd2tMU2R2T3BlNkt5Vk9WNXh4UVRzeVNFNnpu?=
 =?utf-8?Q?/n0OSH9QGADIjQE/eB7KK3xZg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa91049a-97b4-4da5-ad39-08dc477dc119
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:01:01.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czS+7Y4T+kD1GV8fsBk+Rf/5hU0X1ABM/8nwXl6zBdK9Qy4yZGxEYOp7URzMbRjsrLcqLmTCZDiQagAxI5QPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

Add asrc[0,1], esai0, spdif0, sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 267 +++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..d50457e745259 100644
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
+		compatible = "fsl,imx8qm-esai";
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


