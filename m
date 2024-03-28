Return-Path: <linux-kernel+bounces-123112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB58889024C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC531C231FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174DD12FF96;
	Thu, 28 Mar 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R9g71rtI"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE012FF80;
	Thu, 28 Mar 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637544; cv=fail; b=YSpoarP8mK4w8j9upVD6qJaM1uuv7MqYEdLCld91GtXWy2a8syOuOyqqVCXXXY1gu1Ku8QTy4842ssqpv4YvM3JDBXo1flSLsV+jhS+Pey475sG3+GxGwUfyU8xoYhwyq+Wp0kr+HWShrOTZpXnu1PTktJRWVkZfSm1Er4xfMHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637544; c=relaxed/simple;
	bh=/PdQ4YvjdSlrCyI1P1udeJhqTS+Sl1PFyZdORP2g+WY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GaRBTVY1N5uheahuS5c4/ZNMHlkd4B/n8gA2Z9ghY1PyYzYY0MR91101wTk38K9Ci9whml4SQmdPvQEEGR0AyHyeR7GBZm3eL6dK+11IOgK58dEMwQMH2HrIXvxOdRfgys6G7I1uWfq6BkCBX1kTpaTan10ucrbuHJDn6v+z6rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R9g71rtI; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncrEBsrRuNBvsFNU8QadeIKnpd0l8sDK9FlILLVtppNyGwwvBJw+2N9oTktXUGMI0WtCrpLgcAbgBfTr5pMzuNzwdGmjUH07dafAmhQbsbFUEHkDp8tnKnjVxkcsK7rQI65ZqqRnOoESQPgl9qNumFErW+VnG6fuzCO2YNIVfLMwysCf4wY+ly3bu34p8UEOMxDXGEctLSHqSZdD/QLwPGM9rYiIcmf+NXWTqzEsZkIQKo2MKYjRNB6KkEMWLfgPMG4AIEcS7E9dlFneFSKnCYbLA0bAFjucZuDoJQNCQxrUhi7ogzzYbxpazROGkQqrwkE41kwlwfOMgsZgKZdoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN14lHU+0CsdUJqY1Rzb8KcbmwECVonpQGw+AiHtz6s=;
 b=l1ajqAz1dkb/SY1IiwAj1Dz/xapf0I6rGpyCvt/3DyoLVm08v+tfD4XCtEQnLDzHRnUYs2dLEJavRUyRhEPHfIkh2kzoL1uMBRqAF4CBv7twtm4Bw6Sr0WnH6CVo9NBRsSfpduRnS2r5MVchQh7zK/Prq7EEGzBDn6f5R/6366mIDy1y3mh6ZPKejP/z0zjnvCcxs0csmhhK2lurF6iTYHZa8HgZP7TeLc8CZrBCwnvzukD+qGBgXULwuXeTaTeaX7TLHj3ZHhl6yViMsKeXaPp/fzekSLKqLUJB3dBBOKEfUQ64WFSJu8oM8MyN7sOSgtAC5yHWX3Vnvyt4L2yPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN14lHU+0CsdUJqY1Rzb8KcbmwECVonpQGw+AiHtz6s=;
 b=R9g71rtIjesXnd1xsQXX5citau4LPSoyaE4EcJ+7jrGN00s1hSHJpgJE8F+zzPUuk37cHTguLAr4fsA6Ro16YWqJvJczjM7PgbAYuAdhmhcUsH20PusLAubqgoZEn25aivOO0I85LUM9Az4vXEy1x0iV9OHF58N7iJ8kseHzrUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 28 Mar 2024 10:51:36 -0400
Subject: [PATCH v8 4/5] arm64: dts: imx8: fix audio lpcg index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-asrc_8qxp-v8-4-801cd6bb5be2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=2684;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/PdQ4YvjdSlrCyI1P1udeJhqTS+Sl1PFyZdORP2g+WY=;
 b=9fgcL/tK4jBcmXzGRgfA7M0USXD8mOkQAKg27MKhroZzhkldxI1lzUNQVD/SsY6nsgNoUxnZM
 Nsb8WyylcUyBvzG1WG6dOmiFphJzENDeZb35/QE59a5KWD5HS/IenEA
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
X-MS-Office365-Filtering-Correlation-Id: 251bb4fb-b304-4fb2-7702-08dc4f36a9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IwifRQVqgYxjeIR20pySEySUtchegjatFNw1SiitnEf/jWEN9qNluR3pxTRvSnCeS2L6TN+oU98vq9NgJK3BCrxen+6FxFrMBtQZXmfFGmc4CIoLSd5ZtNZZlivBbS0av+CmcUhyR2SD1iB/HEkrILPw5pK1vBIWXi7IzgByWvt59uE3PFz0EBvHdp9S27qLP6sZeryxv9KkrGzTB3tO7KhPHw9tphnk+SCzR5WdImnVU6wEwS8GpWyAJPn9wE8+CwgDATU/O9WXgYLTLLm3ahsgjEA7WBp4fs6Oy6RBoMFNQlYZrK5/WJy0iYryVB4FKxVOc8yNXL4kw3Ls/uCL4RdIvQX8TM0M8Rz5giHnwek1xFaJywDXQ08VasLZ+8M3q9/EBGEO0cxYBfAL1ExnukbtTbJr8MJb3QRiEGnE7eO5YpV7Bkqd27ifDEe2Kth2TNNEYtOswK5M0SfhYa7ywOQkE32JttjYJWxoArlKsA5j5GNuFFSjXon+fT2PGea7vzqSMhkFHz79vCkXU0mqhG2HHuGOdp6lPQwmF/DM0Mif5cJ2wKZ8m5GOiteV8dRek36E2KY2VTXETr/Cvi8450zH7zcmgPWqE5H55Hm7NL7DCkWDi0cs8aJ0Y5CdH0mbgqpAGVS5o1gA7oMXDgoC4LsLMOcfMUeoUOgRq/NEomd9P2NqsoG9yp6+EI6yRSwWw4MOjAXUMtNg5YFBvshRA267NEfO4JbNyek7odClIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVVtM3NKb3l1dHc5RGtCTzJnSjhvV0thVW5XWmtidXQyRmJwRnNXZVgzSCt5?=
 =?utf-8?B?NXZxTmRsUS94cWVwRitsOTM5M01iQUdkTHJMZjEySGEwVytZUHIwK29YNjJD?=
 =?utf-8?B?cUVIT1MzVnY4NlVNcDNtVzRPYW1wOFFNZWovWlVXT2VGdC9vNWFpM3pXV0l6?=
 =?utf-8?B?SHJIWG5yNUp6Vk95dCtvUTN2blJ3YjBLQnpBSDM4Z29TRHB5bkg1S3NUOWNL?=
 =?utf-8?B?ZXFiYkRMaGpLOGFBZnR6OGtRbXRSWFVZL1E1ZFN5dUdiTEFzajdmb2FLQWxx?=
 =?utf-8?B?K0pHMlEvbHcvd0pLak9KM0xOVXpVWEVSbnV6N0dXZmFRVkx1OURNL29VNjlN?=
 =?utf-8?B?bUhCNjQzZTRUNEV1LyszZXpWVVNmYlE5SzVEd2M0V0pyYnV0bWgxamM4elVy?=
 =?utf-8?B?aUNOTnJJcHVobmZLUEF0WGxEL042OTZkN3dnMEVTcEF5NE51TldMcStLQ2gz?=
 =?utf-8?B?djVtS3dCdGlyejh0TjdEM3RqbjlQTlFRRVYyb0xiaGpjVzF0YjRNQ1NKK1pU?=
 =?utf-8?B?VGdjL1JtcEtwamFhNHVET3N6dWY2THVFL1hEWENWQU9TcWdaTWlyVXBpNmt2?=
 =?utf-8?B?OEprY3B0SlNYQ3c1WU5Cblc3TFplSURIQS9mNWVHS1UyUHpWYkFEZ29CS2pX?=
 =?utf-8?B?bjJzVkV1ZFBYMFVqNTV4bUM3eFFUM085aGtnb25iQXhQemh2NGlYOThkQnFq?=
 =?utf-8?B?dTkvUHpzdjFTdkVaNVI3WlcwVFl6ZjlVWnF6eXZpQUREVUFHS2s3ajNQdkgw?=
 =?utf-8?B?ZnREZWVHUTZ4c0lyWHp2U1hMRkI5Yi9lOHZBN0pNR0JycVFhT1o1SElMNGJK?=
 =?utf-8?B?RWprV1BJNHM1MXRkYkQwV2g4LzNxMmY5aUYrN01wTkJEVDNBOUZDT0l0TSs3?=
 =?utf-8?B?YnNGMCtpMHZ5WHVZQXpwTmFHak9rVVlmZXpjZ1F4aDk2QU96MXBXcjNJc2Z2?=
 =?utf-8?B?bjNXbEdXRXhwM1QxbzlZaUNNTnl2ZXlIRFliTDFHSmNiYXN6RSswU2NhVlhC?=
 =?utf-8?B?R1JHeDlsT3lXQ3lKeFZjNTVnQWk0dkUvRWphN1RNMm1oY3VGZTd6U3dmN1pu?=
 =?utf-8?B?aTF5YUtTNVlmOHhyNTJuRW1NdUwxQVgvczBycmo3V1dlcE4rbStnY2hvYlN5?=
 =?utf-8?B?VTdYYjh0QzV2MnVFdXZ5UFY1Wkd3VXNCU0gzYW5rMG9pQmxabWRyVUozZ2hO?=
 =?utf-8?B?RXB2RGo3eGZEZDNPSEVsUUlKTjltNHE1ZkhlVkt2dERueWV6NWx0eTBDK05r?=
 =?utf-8?B?akdmRDV1VjdrblMwUHdrR0YwdmYzeVJ0VUJuTXhuWkFlUmJIbThQUmIzYXY0?=
 =?utf-8?B?bkh6QjdKWG5yM3FaMjl3WGZUS0xTd251bGF0bnJiQUdQMW15N0EzVGFpeisy?=
 =?utf-8?B?S0Z0UW1MaGJwV3Fnd2VuNmJOQmNCb3lsTi9NOXd4aTJLc0djMkhJR21OaU5r?=
 =?utf-8?B?L2N6ZkVsRzZZNUF1cmNjaDUrNTNJdGEvVThVcjZMQUl4R2hNY2JBeThuUCtC?=
 =?utf-8?B?Q21DTlM1dW45NDJQWmRRVXpodEJzMGZjaktHSm04Q000TWpOR0s2bXYvRWl2?=
 =?utf-8?B?Z1JUM2JIbzFycEZmazdUbG1uOGZuMU9Lc3p6QjhscFRJOUdLcmNPZW5FMXRY?=
 =?utf-8?B?SUVNWDNXamxjWWdNOXBJRjJ3QUdBamV1ajRiNkVENEpwYXJldlNSMndtWUdL?=
 =?utf-8?B?ays3YlJPWXg5dDFBMGs1by8yYXg0bGpmdU02RG1CaVZTVGdyb1BuK21Qekoz?=
 =?utf-8?B?cEFCQzdXc1JTYU9VSWlPQWZUL3IvOC9XUjhZV2w1eGlnSkVhSnhKbHhsUWlS?=
 =?utf-8?B?TnRab1NvY0U0K2lPWWE4dUlxdWZkc0Z1Y3BTWnVNS0FlQ3lFaElSWUZHMG15?=
 =?utf-8?B?U3M0ZFFlbW5NMXdwSXgrbFZFdCtVS0YrSzEyelFGdUNWL0FXUmdESGtZU0FM?=
 =?utf-8?B?Z0hLZTNLc05wZlVpYm0yOUVIbHdXNzV4NmZlWCt2OTd5ak4rWkxNV0NsUlVt?=
 =?utf-8?B?MWtrYVRURW85ZCt6c2xrYU05cit1aGhOLzR1SS9WemQ4MmpEdXdweWcxMUlJ?=
 =?utf-8?B?cDdYTHc3YWpVTHA2SnJSQ1F6Y2g0Uy9DVXlQblZ4QU5Vem9SeGttZitkbDJB?=
 =?utf-8?Q?WqvVB0h9xmZDx6gGPN7vVQZuF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251bb4fb-b304-4fb2-7702-08dc4f36a9e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:17.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfILx6AytqDQNFORDVCv7tkfga1OO/2J85OiiSbZ2t27e8Ji/MZFyF4K6xLkX48plujgJsum5JSG11WLrxwnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

lpcg cell0 should be clock's 'indices' instead of 'index'.

imx_lpcg_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
{
        struct clk_hw_onecell_data *hw_data = data;
        unsigned int idx = clkspec->args[0] / 4;

	....
}

<@sai0_lpcg 1> will be the same as <@sai_lpcg 0>.

Replace 0 with IMX_LPCG_CLK_0 and replace 1 with IMX_LPCG_CLK_4.

It can work at iMX8QXP because IMX_LPCG_CLK_4 is ipg clock, which already
enabled. But for iMX8QM IMX_LPCG_CLK_4 is mclk, which trigger issue.

Fixes: 0a9279e9ae88 ("arm64: dts: imx8qxp: Add audio SAI nodes")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 07afeb78ed564..d8bbe53320bce 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -123,9 +123,9 @@ sai0: sai@59040000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59040000 0x10000>;
 		interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sai0_lpcg 1>,
+		clocks = <&sai0_lpcg IMX_LPCG_CLK_4>,
 			 <&clk_dummy>,
-			 <&sai0_lpcg 0>,
+			 <&sai0_lpcg IMX_LPCG_CLK_0>,
 			 <&clk_dummy>,
 			 <&clk_dummy>;
 		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
@@ -139,9 +139,9 @@ sai1: sai@59050000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59050000 0x10000>;
 		interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sai1_lpcg 1>,
+		clocks = <&sai1_lpcg IMX_LPCG_CLK_4>,
 			 <&clk_dummy>,
-			 <&sai1_lpcg 0>,
+			 <&sai1_lpcg IMX_LPCG_CLK_0>,
 			 <&clk_dummy>,
 			 <&clk_dummy>;
 		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
@@ -155,9 +155,9 @@ sai2: sai@59060000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59060000 0x10000>;
 		interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sai2_lpcg 1>,
+		clocks = <&sai2_lpcg IMX_LPCG_CLK_4>,
 			 <&clk_dummy>,
-			 <&sai2_lpcg 0>,
+			 <&sai2_lpcg IMX_LPCG_CLK_0>,
 			 <&clk_dummy>,
 			 <&clk_dummy>;
 		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
@@ -171,9 +171,9 @@ sai3: sai@59070000 {
 		compatible = "fsl,imx8qm-sai";
 		reg = <0x59070000 0x10000>;
 		interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sai3_lpcg 1>,
+		clocks = <&sai3_lpcg IMX_LPCG_CLK_4>,
 			 <&clk_dummy>,
-			 <&sai3_lpcg 0>,
+			 <&sai3_lpcg IMX_LPCG_CLK_0>,
 			 <&clk_dummy>,
 			 <&clk_dummy>;
 		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

-- 
2.34.1


