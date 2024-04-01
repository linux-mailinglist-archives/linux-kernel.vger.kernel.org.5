Return-Path: <linux-kernel+bounces-127131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BBC89474D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24831C211EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2858AB8;
	Mon,  1 Apr 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c91ltZ2L"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2090.outbound.protection.outlook.com [40.107.14.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3E58AAF;
	Mon,  1 Apr 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010365; cv=fail; b=IiFMC61FX3jm/Yb135l8hEvuwziOFl1JIZFlxRtrgxmxkqEbhRViJMi8Kva7zk4NlGrePg32ltQzelD8QkXiIExsMvoTKeaSg9ZCSoCFUzP5EJx2yoR8bVRgsOrxmYhd0DhNJ5kwzC3/Dp44CEqFTpjkjLqSx5fO9or8gGAnjAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010365; c=relaxed/simple;
	bh=eO6HQ4nQkUGETGGZsuLNurR+PbulGpVNdui39aXhUCA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lZtO/AaXvzJvixzWCcPfgT+qYKic0pTNsm4+o48sGzCFu7J4M6IIIreXoVnFcHIfhU5IdN2UW2Uj074EGNEOKX8KSjbl/xULKld38TgKSnEPDYHMrvQcZhRTRHsE96sCmj56Azud6OaMvONot0n/VrKi+VvcMFBJWXyzr6PFhZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c91ltZ2L; arc=fail smtp.client-ip=40.107.14.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khnd2/zGCiPNDa8VcDCnz7a2ToWFc9ucxi2CWYCnnhwoEgzs4woskilkyc2s7uQ1wS5C+90ZvePVi7Qi9kPvgn0uPnxIZrCyHOxd/Yddn08ZTGBZULNZd79/ZMTi1R+SUWZ8kdxwhVIOjuN7O+uqV8z4E9eSEKfNZZKYlBh8N2K0dAfvQCVt81dxEBSsIq/A1EpiqqO57wmiEFrO67EH5f4LOC0Ps5UpuVokHIH4mDSko/36RkoR9apOnjBWBDgshXmcYQbsaNC3oTvTmXwQVAVpPPcEeN4dPbZcpfv6slCQ2aV32PgdbpPBZD4ylU5i+WBpX2EXEd5eoiaGGbwMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbfiNiMfF5H3qFP3XuQFZABx3PHhYvzTsVrISPYMpMM=;
 b=AnYaNDXnx13oi7819Po3FXGIDRE5No/Afnc0JBeHN8/GjPGBLasxkHbxwBMWw2xWOjRfOldIEb15wVVuH+qWXMCTYyhQ38LgL4nk2+pa8Hs2wLTm3ceXEq9K6nS54TSmj3V2vKBdxJYxfo2/vvB991fjAo4hbd+AwCAlK6UCcgV7LDOqzf5imbV6we3lR0KQi3E3T8wLLlHN76q4piyDJhlZs/oTdq8thyi2AQmAzQ9GS6Wk3FUP+rNz63vn9E4FSTMhEfT8zHV04gDBVOZBCPtQss8cUEuJIlp/IiYkoT5O2QeAdwdXhhSmQXnYj1rJRFDcOM8blGbNqzLVdwLz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbfiNiMfF5H3qFP3XuQFZABx3PHhYvzTsVrISPYMpMM=;
 b=c91ltZ2LI01blfZVkZqNrlcH9COHXAR+oL0d7KGTf2JX0I4UsV2PCaqsyKYG5F+SDbuoRo+IDxpkT8D3EZQEGJgyMoJ1Y+ZI3hfjqZ8Kek7Qll0yX1gJIfDJ0KCgvywXKIkjLYFEMOL5bFDvzvnVeCdQhJr1gAeJ9lHwUfDDo/M=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:26:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:26:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:08 -0400
Subject: [PATCH 6/7] arm64: dts: imx8-ss-dma: fix can lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-6-8c51ce52d411@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=2525;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eO6HQ4nQkUGETGGZsuLNurR+PbulGpVNdui39aXhUCA=;
 b=zq02e6hO7o7sOd+iifS90EBTE0PozjY776Qcwp0fDEJE0JG5wcKtl6yJHY6rfVcBwVJA2mQj2
 xpAjUTUNd3mBDyCoLoZMMSUc1zK7SLTXxFvmK25fJQtC04PM9miL4bN
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
 dL9FGh+/dH6crvq1A5b/sxHvZFwQjNGqwsMJgtYM91jMV5oO6G024UHzE/WYm9RZ7tQHykH4Ig6N7xgEHUtidPoHlqtSr19JivppzcqzATD7cy4MxrPTC9q+F3OSO68HWsXHH0Q57S6Ryf+91mTxtDuL3aqJHD2WE22z2HmPWTuSoSWnWTUiQXoPSQdt1lBXTE7kRXYEEkRBfwYAt0xb6WfAgEeSpU1c63jRCyNqvVYkrokugVlmFV8z5QhOcoSTxp6ApeOkZN7r8tQh4y/9rAxY4+vne3tfbHwkNjZV5fT4RvI2DuB5GOyFI/qunx1EOGzuq+OsqQhOLseIJRKYAeaTarcOZVukAtkcaUhJnyzD5UvmUMKOJ7yZ9T4ktVvizgI4PBG+CHuBcGE7JYFWoXKUYJ/pi6aUPOzqNrSwmshU5+Vvic7cm/ASsXOPGzw6M9pg6ebHWZ/epsI1qz0fbZKRuvU5Su2rTfE9hThPP0czdWkaKJG/ChhtH6qYWj19mPlQeWkE7gu5VBG6tqU5XXror7cRelsqeMbCEWkvlv0XjFkIt7bZQkIT9cGLO96vRGKLHX6yJOVrJd/8dYh3hkLmNDJb3A4KXxvM5iM3Bv7x+Rhy20hmRuqoeDFh5Wno+C6E/XhN+E3f1T6H/jbHDmuJKcihT5B+BHao2+YUHBFKYXukUTJjnDkGnfR2RLgVM9VHWO4vPOdfd+4rlWAVN4lN6B5rXdHw5KQ0eJCDL3A=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VkZDL212TlM0S3EvTkpENkY4Tzh2S1pvb1p2Q0FNUGFSdzJaLzB1SDM1ek0r?=
 =?utf-8?B?Q0hLWU9QVkx5ODB6Y2dYaVp5UXc5UXFEVHMrU0lZbWZqdkwrMEoxUnh5Z2ZP?=
 =?utf-8?B?Vk5CVU9oc3RWNXZtY3diQjZKZkJVbWlyUFgwN1JmUjBDRTg0Q2RhaUxTc295?=
 =?utf-8?B?TlhMdXp6cjJ5TUcvdnhCbjVaVE80eVVBeTBrMWVYYzZ6QlRSV2xNVW5CQXhL?=
 =?utf-8?B?Z3JDbDVwK1g3WlpkMy9XS3BmRlNKdy9LdUZGbmdiSHR5c3dQblRvOTNTa1Vh?=
 =?utf-8?B?ak5YNkMyUlQrbFBMWjJBSThsRUNrR0hVUnBEVmJxMklsN1NqS1RrbUZxZHRy?=
 =?utf-8?B?WllmaFBqNnM0TGROTmFaakNnVEJCT3ZYRndkakFSSFZYQWFWUTErNFA5WDkr?=
 =?utf-8?B?NnZKeHV1VHNQRXFiZURuZzgvQTlpdzZOZVQ4aE1NYWJRQkIyYlpwYk5YeWFz?=
 =?utf-8?B?ZFVDczJLQjkzVER4OTM1U3hGaWFjZEladzVFM0dRWW5remg4UEVFNDVMZHFW?=
 =?utf-8?B?dmlhOU9iaEk3RnljNGxnMUdFZlYwbnhhTmpySmZ4b2lIamJBcEE0TnAvZkU2?=
 =?utf-8?B?ZnErQ1ZTN3U1T25WN25LZVZKY3E2ckV5bnRFRUQyaWlwUWRnR1BVem9YbmFl?=
 =?utf-8?B?UHY5YjlzalhaWmEyTk01VHhZT3NyYkNMNExXdDA0RFQ3WmhtejVPa3dUZ2hy?=
 =?utf-8?B?YjlMa1NVTWdsd0dha29EMEZIQVZSL1o1ODYwbXBCQXRDVUJFYWloeUs2NnZk?=
 =?utf-8?B?bVNhakw0d0JEVGJUZXdrckRXMkJkbGRZbGRsQk1JNDF2ck40WEw1Rzl3azlm?=
 =?utf-8?B?eHNuMGZtVjcxaEV3QVJvRnFicDRNUTNSQWV5Q0U4ZmZ1SmZEWmF4OUFhZEt1?=
 =?utf-8?B?TlN4L0M4ZFFLR04yQnhHN2pkMHNrc0JzbFJxeDhtQk5jczVLZER4MzlMblNO?=
 =?utf-8?B?ZXBzY3pLMnE3cDBqbDlQRVg0N1Z1bFpac0ZITlVWclNySlp0NXhubDJ6WlFB?=
 =?utf-8?B?bWJvU3crK1AvaUhMMnFFbWtYNEg4UGFxYUtSUVdVNDc2REpWSUpWbktNMGR0?=
 =?utf-8?B?R2N0dWorYzdXcFIwSi9LRlZHR2hDZUxGN1p2UjAxY2dMYUFrS04yaFplUXF3?=
 =?utf-8?B?WE1tb2VzRURJNGw3MDdTT0Vid0lHTWNUSGlLbW1rWEd5Y2JzMGN2REducHJ0?=
 =?utf-8?B?aTVTdXdPOEg5K3A2WmFkT2JjSG1RSUlFNVA5K05pNzRqOUpQR0YxUUZ2Qkdl?=
 =?utf-8?B?WXpBczgrS3p0YjdwRzVVTVprbXdtQ2pmbzUzK3lweWU1TW5nNHZmcWp4dHRk?=
 =?utf-8?B?VW5MZGdjK01SM2lLaWVwT3F6akFka29sanNQSEg0UkVqY0wraEU4OFVGM1I0?=
 =?utf-8?B?QUNKMzFuSkordlZhNVQvT0RWNzRlYjF6eitDdUJvNkVqU0NyRFRZY2Rlem5n?=
 =?utf-8?B?Z09kYnZWUGdsOHBNQlBuTXJkbUo1K2tTMEd2L1lneG92MWFjSnhRMGI4aUxl?=
 =?utf-8?B?UFo2WnNJRVRPR1IvUWFuQVVySWhOcXVsZ3ZFRkRLUXQ4czBaQUVTN25DR3VS?=
 =?utf-8?B?VlV2cHhuVTBpcGdINFdHNVl3U2FxTUN5d2Z5MTBRbGs2VHZFcDBCN0hhTFBx?=
 =?utf-8?B?OGRTRStkcCtyT2k3eDl5MHhFd3p3Qmw0bStSR0VDczBpZDB6YmZ6MlFzR0Rq?=
 =?utf-8?B?c3NXQTBYUzBRcGxOVTdQTnJFQzJNOHpuWmtNSWtueFRRWFpmTVM1b2s5REJh?=
 =?utf-8?B?cG9pQVUxSGYyRU9DMmJlNCtuN0N3VmUrNFd4Z0dDandKbld0RVlGSEtONzF4?=
 =?utf-8?B?eGJld09WeWh3QkEvUllTU09pVVZqb09ubktROEJ6NkZlaGxPWkkxSSthSFZp?=
 =?utf-8?B?K1Vwd0IrWEJNK25kWGJEeVdwZHBxTTdrcmlBRitHSFVJVkJMc3FWb2ZjUmN0?=
 =?utf-8?B?VFpQVmw4dHlHaTY4WW5LS3R4WkxueWxIL3VtTlRIa0tLaG01M0JDL1RVQnNo?=
 =?utf-8?B?N2JoTXRFbHVNNUw5eXdicWhqMWtWOG0vS080aVNxZXRtRkVQUHVJMXR6NGxR?=
 =?utf-8?B?allaVGpGOUo4T0tpZDRqSWJESS9XZU5Da2RKSXpaZFFRNmtrQ0dCQ0hubjV1?=
 =?utf-8?Q?wU1g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20618cd-2734-4a38-cd40-08dc529ab585
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:26:00.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTCo1qOAsCofITJigvj+FC1Q5LGTcbLBcYqDG83GO5/8ZSPfDvQKMguB/lp7c/MLYah20aismRIShL+zxxdM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

can0_lpcg: clock-controller@5acd0000 {
	...						   Col1  Col2
	clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>, // 0    0
		 <&dma_ipg_clk>,			  // 1    4
		 <&dma_ipg_clk>;			  // 2    5
        clock-indices = <IMX_LPCG_CLK_0>,
			<IMX_LPCG_CLK_4>,
			<IMX_LPCG_CLK_5>;
}

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

flexcan1: can@5a8d0000 {
	clocks = <&can0_lpcg 1>, <&can0_lpcg 0>;
			     ^^		     ^^
Should be:
	clocks = <&can0_lpcg IMX_LPCG_CLK_4>, <&can0_lpcg IMX_LPCG_CLK_0>;
};

Arg0 is divided by 4 in lpcg driver. flexcan driver get IMX_SC_PM_CLK_PER
by <&can0_lpcg 1> and <&can0_lpcg 0>. Although function can work, code
logic is wrong. Fix it by using correct clock indices.

Cc: stable@vger.kernel.org
Fixes: 5e7d5b023e03 ("arm64: dts: imx8qxp: add flexcan in adma")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 77ba2dd6847b4..67b3c7573233a 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -406,8 +406,8 @@ flexcan1: can@5a8d0000 {
 		reg = <0x5a8d0000 0x10000>;
 		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&can0_lpcg 1>,
-			 <&can0_lpcg 0>;
+		clocks = <&can0_lpcg IMX_LPCG_CLK_4>,
+			 <&can0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "per";
 		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <40000000>;
@@ -427,8 +427,8 @@ flexcan2: can@5a8e0000 {
 		 * CAN1 shares CAN0's clock and to enable CAN0's clock it
 		 * has to be powered on.
 		 */
-		clocks = <&can0_lpcg 1>,
-			 <&can0_lpcg 0>;
+		clocks = <&can0_lpcg IMX_LPCG_CLK_4>,
+			 <&can0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "per";
 		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <40000000>;
@@ -448,8 +448,8 @@ flexcan3: can@5a8f0000 {
 		 * CAN2 shares CAN0's clock and to enable CAN0's clock it
 		 * has to be powered on.
 		 */
-		clocks = <&can0_lpcg 1>,
-			 <&can0_lpcg 0>;
+		clocks = <&can0_lpcg IMX_LPCG_CLK_4>,
+			 <&can0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "per";
 		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <40000000>;

-- 
2.34.1


