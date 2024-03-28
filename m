Return-Path: <linux-kernel+bounces-123113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830E89024E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799F31C24816
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C012FF99;
	Thu, 28 Mar 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o2krP25l"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540112FF8C;
	Thu, 28 Mar 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637546; cv=fail; b=Qh2hbCn2ux5yc8Om/136J0bvrCWiOAOuVH/EKyVimkI7XR25q8hUFXO33tdPtxW4mk85V39Rn/28ZKOkBNDE0WbjTxc4F+dIE56BBS0d5ptdLvdzx9jQOwUktFt4g/KnstLNdOyAZEZBpM7bGFEO3m8FDfRqeoE/DYenmGEm7C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637546; c=relaxed/simple;
	bh=kebe5cQr5QQNFmAgU1d6RmS7Q1Va455YLR9DzcW/ZU0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uHuFCv6tSCDOXjc4OM5C5GBgATwN1QvF+ecn05mAyCLWhtWum2THSLNHUeUREw/Gwr9HZg2Mu07XGMEQtsE7TZO71ZTI5PJHxuoZ0iwXPH8T16RwnPjMmAbsdNcXMed4Vlw5wq7a2IVCE7OlGoRaBDnh/kMUVSlfphWhmchawJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o2krP25l; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx/kF7QgfM3Ozhn/la68J8bivPOvks1K/UTEY2AndWYL2JyMZCws35utl5of+9iEqmMfHCuimAi6BdfMfF7Uj6I9vutXEo548FDjzkqMVipNYF5WYARHbWkpOeDq4TIvZCFzp4jIDHvZciY4OVjfAntrKB3c2BSvvOQkCcF84yYSZIBA5pz3ZM17qTKCZ/2hAXQlnkiW2aHOO2JDaggqIWGPBi2dWJllAFg6qEGcsMRPhqn19HWEtb3/u79x63VNEgkWLcnF7OUp/qmJVZsjPKySNY5CxC/LSF51Ai8G5ixh23r0Dyxz3YOLUYpT4e/QNV4CxdESJqA92g8AUUfOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p8Odp+4eZYMmmwYwYzbMTpxcJtOIzF8WNPePWtS2fo=;
 b=dbq/BKTs1tOrKOegus/YmGQczu4JIzJTsJEFqx9GS6ry+9SZLFKsaj0DS5RXXgm9Qs3H3GTen3lDpmEusm5yL7SqNY39YLUbOBXIX/etQowydprI0BDro3K67/fsQeonrt3A54O2G4R1nYrtCs2GzO+wKEclwWrlaphekbkdn38+WF4ksIj3/hD47N3SA9zhu/X0md8papPdKhvwdrDYkb6zgzO6BJ31GzFbT0SgZDcN8buFIUSFLNMpQJ2yd0mlfiMh99X/qG9G+djRo7AGVnblTMkYYxmRwWH6KrcHLq+LSim1Og3OsoXulOi9WtlDqsFObmImftld2j27XjcfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p8Odp+4eZYMmmwYwYzbMTpxcJtOIzF8WNPePWtS2fo=;
 b=o2krP25ljw2QJ4UE2HhkBHVvnct5owdU95eeTEw1JGGZWj2onVWk9fXIlBBj5H0895iHJDUpXwPkDbgzMslwppAuRdZ+TT0gbbQyEKTGcDADkJg0U+bydywO0fDYWksjBWjLLjlPfq5k3Ouh7LsO/X/UqqvxYJKhx39FMjgkXl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 28 Mar 2024 10:51:37 -0400
Subject: [PATCH v8 5/5] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0
 and sai[4,5]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-asrc_8qxp-v8-5-801cd6bb5be2@nxp.com>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
In-Reply-To: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=10072;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kebe5cQr5QQNFmAgU1d6RmS7Q1Va455YLR9DzcW/ZU0=;
 b=NcY3l6Kb0ENkFCKFjLByEG8Zzh+kNoMCt2UA5cwVtLQLkUuObAGLKAYVYn5VXIKiAuF59PUSI
 qoXhOa9GBCMCjaZYiSHnQ9nYgwaQXFntVaAmENRy8e6Kk88HKChae+M
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: f485af91-e862-443a-adc9-08dc4f36ac18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ALBQI+anZyUaIuD2LknxtdtSKSDXmRSbruLQG+8Fy3mzAPB7nGv/2d4slSeCsm52dguO1r+eT0WAfdLTZJrMa7Et1arCJVBvOZ/SKJMfTYwc46rgfImmHihmfBbzs8VoQNhkelMAaDGQCyUVGnGk75R2AKKqlb9X7tjT3ZA7IGE9YE+F5IdkF+rG2dEGIHJPUxeI1dkRAEpBqDAcxtCJijeFddeZJNwUJcUp19dU5EyeLrpg8a5QRDKDs5vci7yb4kNL33t0HwMioVy0NfqX0euRzV7mH5JNVCi5sXv0YTDNfr1DHE5PP3Yqgs22wYR+/hqhTkaigvoqTff0poRophu+Z5W+6i4YMxMirp1lHSDZRruUVMQbBk15lSfersfHo+q19YHuvRUJ2joPbVYDt/gzSc8aPSeVfZHLJf3am9Si3qbuchD0dFopTeToHu2YlHiSB+eQc04bJyk04Vhs313ld0n+7zTav2yg/S3EvQXdtuJCtsSeIoxoemMps4JcpUOavdfrQt81fggIsgq+MxVlwHQUXqxAR5601P9Cdq5YDSoBtnGGDiKNy5eMEr48a1WCsoIL4ZzA0Lkfbcmb3vxS7h/56wRRcDlcxrUOoHNi8CmlicIfDRPVYFCNQhtxVY/pJqzByHpVpHfbaVVai8qJtQ4VGPnx+3R+ih9QRq5oZ1BQ6Hvz3BSbr7uuJzDCyt/VbrOgPqn4jq1qWlGx5hW8wVwa2Ly05i8MW5fMfSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tlc2UjNGd1hVRUFkYmw5T21UeSsza1U4bkluaTM0eThBUEZ4cUZVQW9WWGdo?=
 =?utf-8?B?dkRFZnVxRktWelliNklJR2JSNS9OY0JTdXJyV3pZN3N1T1VXdDNiRTN3UWl6?=
 =?utf-8?B?bzhnaG9ZWGFLeVFnanZJcjBvaFBEc2M1Lzluc3JtOWZocnVCVWg5ak1EUnhM?=
 =?utf-8?B?UWlYTTRpVDNoNW1meXBEeTdYSjNCWjFoK094YVN2NWJUVExYYUVxbDJZVEw0?=
 =?utf-8?B?VFJJTHdLSWxGeExsQktacVdPTlJVVGpDVk1TWUhKb21JYStLSm5DUExyekNq?=
 =?utf-8?B?Q0k3VHhRaFlhT0haOGpkdG45cWpmeXU2OXZpaEVwbHI4bHc1bTRlRE1xQ1lp?=
 =?utf-8?B?SWlWZE96TFpnek5tY1h5N29nZStpZ3pvVVMyMHJyL3BmRlpvOGZEU3Z1NUxX?=
 =?utf-8?B?ZGNIOVBETVNzaDB5Nytlb25LK2VLTmJJWWJuMXkybHB2NUNVOS9uUUVKRzFU?=
 =?utf-8?B?SSt5OTRraDZKZFJsdVZySXlLSk5hYjMzc0Q3V1Z5a1pvdzRZZUt4YXFUOUJ5?=
 =?utf-8?B?Q2xYNC9sVXRwVmhsWXVyZzU3ZVlkT3ZDYVp3bnFoOExPUjVvcXhHaG5YRTNL?=
 =?utf-8?B?YTBFVGxtbXlMTXF3Y0lvTEVGc1gxeFZmdFpoMEhucU1yd3lLRUZvRk84MEk2?=
 =?utf-8?B?QjFzUE5jK2lCZnNQTVJUaUwxaG1jNDBMUkhOTU1RMFFBMXFzckxVbzRreGNX?=
 =?utf-8?B?MzFRZGQxaTdjZk9qNUFIZC9uTEhuNVpPOU1XYy9SVCs4cDJwOVNHNXU0Wjh1?=
 =?utf-8?B?RXpKZ25icGVlQmhTM0ZpNkR3blVmZ3VZQkVOeUJneFRYeFR3ZmdRWU5RUW5n?=
 =?utf-8?B?b1FFbzFIdzBJRnBidDlRUGRNWkJ4QkVuZkxJSG53T1VmZWdZYW5abkxKRzg2?=
 =?utf-8?B?VjlLQzJ1elVYMUs0Sm9FM2pkVkI2VlJPb2VGZUFUcFY1WjlVS1lSbUlsZ3M1?=
 =?utf-8?B?UHBGbjFLRGE3OU04Rlh3OVlqSU9WdTBOOFpUbzVwaVQrVm9RUm0xSXdpTExS?=
 =?utf-8?B?U1NydDhkaURhcGN0QTlabXJHSitnZW5HdmZ5TCt1c0dSc28yQVhWSVM4K2E0?=
 =?utf-8?B?L3JHV0pPeTNZWkVFRDJaSU9zMUkvaDBTRVk5V3ZEbVBNS0ltV1R5UGJtMVNV?=
 =?utf-8?B?eHM3b2t2MDJxRFNCdEZNY0VFVXhScXZKUHJibkNPTUZxcSt4dG03WU5pUklF?=
 =?utf-8?B?OUI4QjNoUVFQQzcwVzE2RXU2cCtEU1J2bHQrTml0MnZqUVZ0Q2Z5YW1qZmto?=
 =?utf-8?B?WDgzOWIxZ1phUFVkdXR5ZVdJVUxhbDNOTXgydGErZUdQN0lNRE92V2xvL2NZ?=
 =?utf-8?B?NU9TbjRXYmcraTdYNG4ydGVtODN4MWJQMld4aWpPcnZ3MWJ2bkQ0ZHFVWFZQ?=
 =?utf-8?B?Vy9zRzhISzAvcThqTVAwTy9aalFEMXpHOEFIQWpYclh0MEdRYVpndGdhdVNx?=
 =?utf-8?B?UVJvNTNSaENxcHppLzBHWWQ0VUV2WFRiYzlWRFJaM3I4aDM2cUJ2emRHbU1B?=
 =?utf-8?B?eTVHcVNrODVaRWlqOXNZY3ltVjNFTjRFOHRqWXpBdDg3SGs1bS9iMlJpUVcw?=
 =?utf-8?B?bmN6bVp1bnAwck0xRTNEbDdnckZVUFkwci9ZM1JMOUVrc1Y5RFFERUU3TlB0?=
 =?utf-8?B?eUVsMEF2WFZlbGxRVkFHSUJRTng4T3hRaXBzRnl4RjMwZWxrUU1XVEJnclR3?=
 =?utf-8?B?aXVEZDV0ckI0QkdlSGRRK3JUeHNOUndiTXRJQWxlbWI2RDdQK3Q4OFFCT01o?=
 =?utf-8?B?dlQ0S1hBYUJ6TThqR2pyUEFnb2ZWOWQyOVdraU8yYVpGY2RZNkpGS3JSb3Uy?=
 =?utf-8?B?bmFzZnpFdnRDdzNVUVpENnAxaldtWExjak96dXRrdnlxYjI3RSsvQVJ2eGJQ?=
 =?utf-8?B?QlhkQWg3SUNuRmkvTnRnbGhZVFBtVm91QW9ld1V5TDZoUkpleEFTUFRkMG1w?=
 =?utf-8?B?YXFFajRjcUpqMmlnYkFrTUFURWFLeDFmOGNVM2RwTGNMUjVOTWZtRU1lWWlC?=
 =?utf-8?B?cy8yRlhwdXB1Z3JXVkhJSzZXN1FlRGM2aHFkL2xWdUdYWjVrNEpIMG5GU3RK?=
 =?utf-8?B?SXJuZG5GeFplRnJuelFEWWVEcUhMWEp2dXN2WURCYml6b2pSUFBWUVYrUC8y?=
 =?utf-8?Q?yUecT6KgjMr0F/WZ8DGYnKA8k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f485af91-e862-443a-adc9-08dc4f36ac18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:21.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAYkRzOaRHwyWS1mgXRYKUaPku8LhhU10MUapB99pzwT8wotxzDk7Qqz8lQ/WGcthvyWwpUBAiKhk7F9PRH2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

Add asrc[0,1], esai0, spdif0, sai[4,5] and related lpcg node for
imx8 audio subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 269 +++++++++++++++++++++++
 1 file changed, 269 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index d8bbe53320bce..897cbb7b67422 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/clock/imx8-lpcg.h>
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 audio_ipg_clk: clock-audio-ipg {
@@ -119,6 +120,89 @@ audio_subsys: bus@59000000 {
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x1000000>;
 
+	asrc0: asrc@59000000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59000000 0x10000>;
+		interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc0_lpcg IMX_LPCG_CLK_0>,
+			 <&asrc0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div0_lpcg IMX_LPCG_CLK_4>,
+			 <&aud_pll_div1_lpcg IMX_LPCG_CLK_4>,
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
+		fsl,asrc-rate = <8000>;
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
+		clocks = <&esai0_lpcg IMX_LPCG_CLK_4>,
+			 <&esai0_lpcg IMX_LPCG_CLK_0>,
+			 <&esai0_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>;
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
+		interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>, /* rx */
+			     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>; /* tx */
+		clocks = <&spdif0_lpcg IMX_LPCG_CLK_4>,	/* core */
+			 <&clk_dummy>,			/* rxtx0 */
+			 <&spdif0_lpcg IMX_LPCG_CLK_0>,	/* rxtx1 */
+			 <&clk_dummy>,			/* rxtx2 */
+			 <&clk_dummy>,			/* rxtx3 */
+			 <&clk_dummy>,			/* rxtx4 */
+			 <&audio_ipg_clk>,		/* rxtx5 */
+			 <&clk_dummy>,			/* rxtx6 */
+			 <&clk_dummy>,			/* rxtx7 */
+			 <&clk_dummy>;			/* spba */
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
@@ -239,6 +323,40 @@ edma0: dma-controller@591f0000 {
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
@@ -333,6 +451,101 @@ dsp: dsp@596e8000 {
 		status = "disabled";
 	};
 
+	asrc1: asrc@59800000 {
+		compatible = "fsl,imx8qm-asrc";
+		reg = <0x59800000 0x10000>;
+		interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&asrc1_lpcg IMX_LPCG_CLK_4>,
+			 <&asrc1_lpcg IMX_LPCG_CLK_4>,
+			 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
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
+		fsl,asrc-rate = <8000>;
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
+		clocks = <&sai4_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg IMX_LPCG_CLK_0>,
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
+		clocks = <&sai5_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg IMX_LPCG_CLK_0>,
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
+		clocks = <&amix_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_AMIX>;
+		dais = <&sai4>, <&sai5>;
+		status = "disabled";
+	};
+
+	mqs: mqs@59850000 {
+		compatible = "fsl,imx8qm-mqs";
+		reg = <0x59850000 0x10000>;
+		clocks = <&mqs0_lpcg IMX_LPCG_CLK_4>, <&mqs0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk", "core";
+		power-domains = <&pd IMX_SC_R_MQS_0>;
+		status = "disabled";
+	};
+
 	edma1: dma-controller@599f0000 {
 		compatible = "fsl,imx8qm-edma";
 		reg = <0x599f0000 0xc0000>;
@@ -481,4 +694,60 @@ acm: acm@59e00000 {
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


