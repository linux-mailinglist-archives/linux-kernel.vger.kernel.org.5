Return-Path: <linux-kernel+bounces-128189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0E895753
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FB21C20C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51E13F45D;
	Tue,  2 Apr 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jKNnW3M1"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2123.outbound.protection.outlook.com [40.107.8.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DC13F422;
	Tue,  2 Apr 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068915; cv=fail; b=q0J+9zefbVfSt47zKkVBJuajOWESdFmCjtvgp9IIiakPbetu7Vsa3J+mBdjBlQuNVazKDotAwhSiGMsd1Hpib8a4EvK7/ySpu8YaiICgVeviTyQQFgvWQ5wRQ1x01lrBGiEbXM9NpWLaLqxy9BTCCanMbwl8hOBU9Fm+MxQ7ogI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068915; c=relaxed/simple;
	bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BCVt0ZH92GljGXlm4GYORzfF3rgdjPSs6TiYB/7x28xNZHBlrvzx2oh//3AK66ph+piitCVS/7g4EskqlRXnz6RtyrmQ6VVZFKYdeu1WHq+YR1CKNGGrS5xiAN0uBSPLc/KnwWYDkb44v0/zdOaTPGjW/ZGfD8y9Q87Ho1jvib0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jKNnW3M1; arc=fail smtp.client-ip=40.107.8.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0qrLLWYsHhvjur2RflMxCzCIP37FfnNbZzfIONsuzruyiNx9RamJcW0bQruIhkA2oot5SvmrBEH92rCRXf2RMypYqGObKcQyS3459zb622aWHkJrqyvS1Vu7oNVFkZr6Xv73nRDtLAAvgGG5HfnUelEBEpgRmoLnir/KMvlkPhN/dOrq/4+ABPBR/o7l59Mh/IHUuF4rk6EduOHmWQDcI4d1pl2WLCIkyCgd2iDupLBqC9j5IxabudgRoGSQ8VRowjO6wi9eKYKB5sc8R72QSj/FZhrJ+q7QoB0WHYO5mf11pSFEDfUNO9xSJQ2ukj/Agc4QK0ZaRPF0mu608CSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=MfsfKd0gH8xRudxO7fbHkqUkwLcIAm3e90Jrxc+knMVrZg6w3Uv4YVaGGl4QFlsnMorzXKDTwMdnjIICENNwTjgAuh5TNJtbkO+BQMXIgT3Jj4oE0kcWH64qdeG8miXyhzlnN9XNi3F9BGibT+ho+SU8gSG+bae2KOpUG4yZvZHl3Te6cE8q9Oju3JurzRmfKuVgyyRZlZeYpGFtJsgPEOSULvrCjxbExSCtbDCcz8pZqkXEXjHRPIlqnOWIgcurMz5CyFaoaQa84Yj0OLDdU6r/3OySwsh5cl/ozHbdHZ37wrBtNWn7BnppO+vtDF7R2q3CUmElgP3fBD6SJB1nXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=jKNnW3M13IXorRc02ypPzEtIHErUVTGkxkw7q+K+SlIw2LSCtqnPekGwRMX9y6iozXYwQi+DbweNE9WUivAZTwG6jTPmZm3VKoI726YM4BTo2NujSkRuHtCrdx13htq8XSULQ48XlLWoPK+suUpgR9V28d1uITgf5wVZXU7BZyg=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:41:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:41:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:41:30 -0400
Subject: [PATCH v5 3/4] arm64: dts: imx8dxl: update cm40 irq number
 information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-m4_lpuart-v5-3-3292629ba808@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068900; l=974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
 b=oDCwyqHtyEnofrXqR3OA0vEwvEjRUzgZM6/KQiBBjrlrc+FR4Z3P8PaSXZ0FlTIlC/X3oHKwv
 yF94bL7OZzTDqHkoUBWgP7o/TOuAvwWIY8zyQmfoPSO+iE19t6a2oJU
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
	nq91PrAvXC8VS8FJaI/Dd9EdziQZk9NBSx7HKYzv0h+wscNRMpN0oP7DxXmA41eQpGCavQcWnSRQhb0QHwq4WNotyeWZNobXtOeiEC+PM3ZkxeiveTTAWzpniRsFMoXq55ecB4z34gAyG/U0WnZrce1lnCn/9taYNLvQQnE8wJM/pU/51G42ON+kMs5e2huK7IRVOFWkXnDTxQtEqFnWKnu3BYjfWrueaxokGfdwZopzbC53IrNGBq04WAFfmPUGrn3WrLjGUt3o3cg8ia59h9etlrnpXCXNLbNoHvJh9us/rjkpCutxgSvySAzebeY4rzeNq21P0UxSA9qNNrJSu8OFQNd8u362zvel/7k+UEdRM0RWe4EKpiof3JiDftyTReo3SLwq+z1h0+3U7m/XXuyJSJ+RH15p0rHmrJg+prt1MV5yA/J40fYGaLMMYJskYgXt7AfdFY4EFoRsluSv2CEpzGB4YvpyKdj1Ybdz3JT4hDIS8eYppq1PTJKNmayRD0dNGt+2jP91TUI4HU45K9/FEK3rF7fh1H/I8SLtmLOjImJU8aIsx9PFttxn/vORqP6rZUAedOJNmTat4nOpuiRrP3pm9Yjn3bXCNyJJ7MGGqhVHX4jd2B7Ds5pA1chowQI3kQysv5P+6du3qbnSEmmgEsVhXYM1xMd+l8P7vU3zxT8jjKichT1CdUc+7ofMgj6dZ4C17eFHqcLZ9XP8S7ZjWnvevDord8T9UW0m1Ck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVd2a0hOK05GZi9rTWNhcnRnem9RTUpzc2Z4Vkk1dW9KWXJKRzU2anlLWWMx?=
 =?utf-8?B?dVFlSDZ6MnlMVW9ONkt4T3gzQVFvYUI0L3JUM2E5anEyaUhRNUpZM0pLL3dT?=
 =?utf-8?B?a0pERXNybCtyblRKUWlmdVUydTFkaUlPMWlqeHZCNFVpN1RvZmFFWVhIdDhG?=
 =?utf-8?B?djNQZTlxa3lXUVd5MlZEV2Q1WE9adDAxUzZJa3lLbGNJMm5XMkJmdUtic3Ex?=
 =?utf-8?B?dGNCb053RGtYRGtuWFdhaGlGb2VYRVFtaXdCNzRUZXlQMm5GR3lEblpTUXNX?=
 =?utf-8?B?R2RZYnhvRWRCZVAvTkp2d1I3VGkrTWFEL2FNNE9Vb1A1bnVvTndFRm5FMmMy?=
 =?utf-8?B?Zk9CYWxMNzNlNWJvVHlBN0oxRUt5T3orVW9ST3NjSDBFQlZHNUl1bHB2S3pt?=
 =?utf-8?B?b21zLytJc2FzU1VhWFZvbzlDdnIxb0syUFVKY1gyOU5PRFlUckczVk1ncFFE?=
 =?utf-8?B?dWhlTUJHWTR5bHBPTmRQMER2TGNvNXgzUXFNM1BXWHNNTEZSOC9jZkxOTEhF?=
 =?utf-8?B?R20rVHY2RER2SkNvNStsOEdYSEVWYW5OemtNVTY0QjVZWCthZUxqMi9PaGFY?=
 =?utf-8?B?Tk1iNE5pZ2pkUDRRNHpGZHFaUjZMYzZUY1hzNktuZEJaNG1IK0hWT1NOWTEx?=
 =?utf-8?B?bFRzOEc3cS9XTEx2S2NMRzZ3RkhCZS9SRmpPVjVHbiswSDB4UWFEVzFxSWZQ?=
 =?utf-8?B?b2JNeVJCVWZlbVhBcm4vaGdBU1E5dFRSaThPZElnaGdrWmpLZVBvTXdMSXRW?=
 =?utf-8?B?WUs1N1VRUjY5WEFudWtKWG5Wa3dHQUF0ZDRBN0U1SCsyeEVGMXo2ZnMvSXJF?=
 =?utf-8?B?cUs0NkpOdHRhQVFFbmFpQ3VRMFV3ZS9hTmI2U1ArZ3VrVEI4WGJCbjZjaE5x?=
 =?utf-8?B?cmFIdU11ZWVCa3lWUFZpRHkrbVAyQndZRkcvRW1WTGFETEFHd2Z2eVpSVlVy?=
 =?utf-8?B?cndKKzNBQit1NTNLRFcrdkx2ak5yMGZaTFlwS1Z0LzFFL0NtZjNCTzQ0QU05?=
 =?utf-8?B?eFZIUWFEa0RaQ3BEWEhNOUdtT25BWTNXYW9xVEtobmRFbFliNXBqVGdMREJm?=
 =?utf-8?B?Z3VCcGdwMjgxdzJUNkZtZmpwcG5VempBallxTzlyYXBkak9SSFdDdndtdGJQ?=
 =?utf-8?B?d1NmTVVYcy91WjJoZ1NLZ1F3Zm81bjFGdXJqMWk5NFJqSWtqTFZ3YjFYanJr?=
 =?utf-8?B?d282MGVHaURFRytlUU9VTjFTK0d2N2ZvTWR0Ui9aNVZwMEdoSHB5WURSYUJD?=
 =?utf-8?B?SGU5R2hhT2F6VFNVRUFndWdSbjFlLzhiSTBGeFlzQW5HRXJkbitIL0lJVjlC?=
 =?utf-8?B?OTlOTmRBRXdsSFRSaHFVckxreCtVUzl4ZUZ4QkxmRlExSGEzUU5wOTFhRGtP?=
 =?utf-8?B?dk5mdDdldXpWTnVFMDFYc3BJY1NjQzF5UmdLeGkySEt6ZFJpOG91azZBM1d5?=
 =?utf-8?B?Qko1MFJJM3kvY0xFblZVeEdHWkV3QzA3c2VqRE5pcWk3RnJtRTdIQ3YxNk5U?=
 =?utf-8?B?b2Evc0hQeUVGNFU3K3FUYjRvdTlSeTQyck1XRTNNV2tIdFNGc3VBcWJydE90?=
 =?utf-8?B?RXc2WTcwWlBVdUwyaGJrSWNpblhXZGZ1T3VwdWxqVk1GY25VRllXKzZ2Y3Bt?=
 =?utf-8?B?bW5aVnUrSGZXTlNNbUxwek9YaXA3eEw0eCtpbVUwdDgwdlJycTQrblp6Y2x3?=
 =?utf-8?B?bGMrTUhnd2FFVXdjSmZpUnlPZkZZSFR3aTFXSE1qZVRGUVJSaWprQ1h1bk95?=
 =?utf-8?B?VGdTamNxU3NOOWUwK1hIajN1WmoweGR3VzFUZVEzcG4vcHNCaW95NDk2WU55?=
 =?utf-8?B?Y2puYkJjSE5GQThtODRoeXlGSW54c29UdUx6R0orZ3VySkorZkN3d2dyQ3k4?=
 =?utf-8?B?UFhtVko2b3M0SGpPcmU3YmRHWUVqd2V0c2Fhc2htdFBJMkVZUkRSK1FROVpW?=
 =?utf-8?B?VmtTMTAxMS9sSVRNSmJMUFIvMitZa2hFR3plMEthdVpheDh4MXhEeE94WHA3?=
 =?utf-8?B?NE5VUW1KclV6bVlNYjA4Z2pxdzhwVjJZbW42RWpneXFTUyt1eWgrend3cVE1?=
 =?utf-8?B?VWFiZWo3b2x0OGhNS0JjdUxZRXA0V2tra0ZFTkttbkxaYVhSR0Q2Z1RZUDBv?=
 =?utf-8?Q?IitLLg+DKs7HyiHwX4knSKw+h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4391098-4566-4119-a943-08dc532309aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:41:53.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFI6Pu3Ppdvup5RODamt4AvQm9KhZDlJP8i+lDUzE9iYckdwe+n5DqDGz7oUzW7oSRYAlLmR1URMaR4CfdJLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Update cm40 irq number for imx8dxl chip.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 9d49c75a26222..b9d137d69f5a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -243,3 +243,14 @@ xtal24m: clock-xtal24m {
 #include "imx8dxl-ss-conn.dtsi"
 #include "imx8dxl-ss-lsio.dtsi"
 #include "imx8dxl-ss-ddr.dtsi"
+
+&cm40_intmux {
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+};

-- 
2.34.1


