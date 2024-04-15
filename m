Return-Path: <linux-kernel+bounces-145833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9F8A5B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FBC1F247C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE315E5BA;
	Mon, 15 Apr 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gokTabRt"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F415E218;
	Mon, 15 Apr 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210434; cv=fail; b=OttKyZ7TNbqEgTNOfFybT9O9u+Mb2VVmUughpQI1OTBq6OSe+b9x8d/oQAhTMV1tn42bAY8PoidwCM+8p6W+x5jU/NPzfqJe5jmQBjkRLlaRAcPG+BUPeG54whxkP5aSUBmlAIhAGwliqTz8DV5T2HvWOTmRL5MT6Gx7NtgN7jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210434; c=relaxed/simple;
	bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jXak3LBySa7GRJCsY+CdLPginmpOZT1SIkTHMCwUuZCkUXw7Oox1galuV8qxdruEcBIjEmBKSBSqXwv3Rh9H7WQAnKqtqmofDeeAW9aK78SCW56Za0Dqv38p4sEWVdhhU0I3lZs4rgGjrr938D6YPESQ8Nv+98SVKcVMEn59Vgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gokTabRt; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih98assRqoBxQ9Wn04pTNtDLoVFoh6QwnppiEg4uRe4c/dgBI112tHfupuXqxVb36MkS31WJcn/4cPuZPCQHSwweOCs98/wgOohhXrFwVBXaWN+Qg3mwI8Kri/XtPkaSZzZgn3GN2V5Mgtyg7pbqGAa7h/OWHjfhYCcb/6pt1lC1m/W1fDTU0lQ40apAfGmG85uNozF+opw5kwk79rDQ+aQDpYqyXt7BYv5GtT55qjVmpEB06BLrO9h2263P8rdZHWlWVrPyzM9k6PtwG8IumLcaKdF0eoXTdMRKE/Zr1BMhnKfOk3vZaFBU1aULRqHXydIJG/YAcGXWJ1bkxJOLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=ROcNskUWM2p1puR+oLCUJjBgEQqsA3/Bm+euqraxiwm8qCwzggKdPm4vjCUvg9oVer9v9svut9cdBqol2vZFHZk19CfDencRpW6zrXux4ZJFtJPxHwVbLUS7BOSCc8+H1eS/cQHkVuFNTFgtzOOs//qbStYQ3z6jAGw+GkaOz5AaB1O5ZFbQ8NdNH7paGmhrH1ZDIaxmpHgf0xWCHYq03MIldw/hvms35Y/m74HOpEfqVp7biuJMymkcI4+Qtq8z9mCuFuP2MgBbGKRKFBhvuL022KINySoPCyjU97aL4Cags9i8GqtUIACI9ey4QewEd4yjxFf/Kfake2GwCqZ+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=gokTabRt8cBoPJIUtKbQez/VdoO7V7zLorVjLIzdvi25jeg/JZhTKhhhwaOw/gNn+t7fDULUdyaplJ6Mbrel+O5fF597khZtghHgf5DaYXl+HRerpwe7V4pFmvNE38hhl3tLueyoRb/nDHR4rDFR70DXuw7NkUuVR3Yge2dva5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:38 -0400
Subject: [PATCH 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=17204;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
 b=HBC4KCJrbODaJ1k7rAK8ekeI2szDdrtAKYb2Cyd8WDVBWww22jNMLdHMWJ3Kxsr/DQfFKaoz0
 ynd+9r/0BOXDunSmK6uOsDoDGNdqkPQIp4n1cOtS/iwpkbgK6F2EQ/o
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
X-MS-Office365-Filtering-Correlation-Id: 05e5b492-72ef-4d07-690c-08dc5d84d697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	as/lKu+8JJvDy78A8Pd1fE4zeOE9x8H7krhq226qF1t82Gdwz9fkIxFXN8mdSDGsbFD8LQQOhYgXyRHB9syvCICg96fW8gMMEYT73N/TiImn2+5aXEokicHs70rjxQ/ZdLpPShuhcpghRIbl0IHIfsZgKC2fQFCv21xWakjJScv3eztM294Ds25ja1zy0XiUdDzW+zLi7HAfVSPTWkEtgPVyXE0Cf0XLZwmKvy7jgaPgh8IDAuesb2XNeFALQugClpawRqLIOJ1gtKwt1xmSCFQot+lV4Nw4mAymK9LPjFXLX9jqZ2g9rlE2eT02TWcTe3CEvEX1qZDEG8KwuhJKMtMOSI46hAzV+5TKXTyX0uoUF0btx8jeDaU1uHhxQiIGUOFoRAhg7qHBHkQfQLFouXOm+hmqdlZ9iiWxqXcj+MbMHQHShpD8AOBe1SV9GrvKJv0uU8kcHQuyiLagXmwZmDWnmVK8shY6nnAUbMnVwpDfarJn9G+PmjAkHbRpAd3spAvotFO3Svar2K2zekjg8U5VOyAY4ZHFr0ToWzUlyV1n5THkoPFd3OH1//kpFm4OWA0gKFZz2A1i1z8yJ9o8x32gg+H27WJPfZfpuRn8lLI5V5+NNK8oZoEXjx5zEGIedHKEKed6DEFVbGihsqPZOCUHIZ88Ip9+ihAlTO93izXNPBxV6r7/J/zuX6IdHnkK0Pe+0YHve4+G+I7TwgpI8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmNxTTg2MEhYalhGVHdncVVjdk9weW5hTnYyWmphamtvb24vWGQzUi9zbGc4?=
 =?utf-8?B?T21xRk0zb0xhUjRNUzRUQXV3MFNhbURad2Y0c05BZW5XeWdqVkQ4M1BTRXpv?=
 =?utf-8?B?cU1tR1Q3NU9CMGRJZFk1dUNBRW1CUWJnVVJkMVJYUFFkT3Zsa3lab1c4YXJG?=
 =?utf-8?B?RlNuK3M2eGdQZXg2YUVVd2ZLditiUXdmNXVLN2tzOGJUYTkxTENMR1V1ZUM2?=
 =?utf-8?B?QVBuVjdybXFOTGp3V0FlZFZCOE05UzJYa3F1aUk4cnFTdkx1V2t3ZEFNVy9W?=
 =?utf-8?B?aGhjYUZ3eURLUDBSdXVKSURQYlI1blRyZFJMQWNuc2NhUGcrQTNzK0NmMTIx?=
 =?utf-8?B?WFJkV1NGdTE4SUp1NHFVV0JIRGhrY3AvVlJaOEdXTDV1VzU5NWVNcUxpcVZ1?=
 =?utf-8?B?dDNmaGpRU2pYUzFxdUJTYUk4djl5aGV0RnNZVWJaNnlhTW80ZlUzeENac1Ja?=
 =?utf-8?B?STBiZjVUZGxqdmVxbXlzeHV4RTBzWS9QZ3BXdUhOY28wY3BTd1gvaVo0RHJv?=
 =?utf-8?B?QnJsWXJKWmhDbnU1dTI4ODdrblk5b2o3SWZGTk9YZGpsQW1MSjREYlFpVkta?=
 =?utf-8?B?bWUvUTFaeldsaGlFU083R0pPSVBvNXJMVzhFbFQxampjS0pMV1BDRDhRb3dn?=
 =?utf-8?B?ekk0eHFsdm9xR25xKzdJM1JMYWFGdFFycmlNblhselQzd0pYMlNaWFpKQnRt?=
 =?utf-8?B?V3AzRDFHQVg1akljSmNXN2FMVS9mQ2hmQzdXdUhTeW1hVlBjMW5hOTQxMkZG?=
 =?utf-8?B?WGYvR1N5ZHluS0sybmdPSmpuTTBZeG1jSXVuUDVhZklUeWxST3ZSOS9VY2lL?=
 =?utf-8?B?ZWttL1BNWXdYUVo5NDJkQ1ZkM2tJRjA2WVV1dlRZZlFCQzZXNTFWUlFNWmZ3?=
 =?utf-8?B?Z3VoVy85NHkwV0E3K3N0K0lVQ0pMNHFYalVMNGFMS21QY2dvZVRPaWVQbFNx?=
 =?utf-8?B?bWVBWmw0NXR1Vkd6TWdRZG9OQmlMK0RIK09sWnhFcGxPbTRnNzkzTFVvT3Zu?=
 =?utf-8?B?TG85dVBmWVVENzFQcUVUUjFIbzVaUlFNVDdEYTdPT1hhYktkS1loVzlyRy9q?=
 =?utf-8?B?T1hMOEVNdEptODRTbzV6bUM1QklHV3UyWWZYMjhNdjhrUHN2bDNnYkxSaWhB?=
 =?utf-8?B?MDRDSVRsWjZBZDdpbEVBRlcrYld3QTRZSUt1dVA5VGV4T09tV2RJdUR0Y0Vv?=
 =?utf-8?B?clhRbXZMTkhDWFZWQXlsTHU2eTRVNVlzTTIwQjRVNHhMWFBxT2hmTGlZRXdx?=
 =?utf-8?B?YkZZZUN5c2prN0NGdmJQb0lNZHp6SUc4VmVKcER6ZUxHdjJ3anE3T3MycDE4?=
 =?utf-8?B?THArQWdleEpRSUloUG41YUhrQUNudS9SblA5ZlJjeWhDcTJ1NDMrMU5KY0NV?=
 =?utf-8?B?ZjlsRW9Tei9VWUZtYk5RNVBzVVNuZXJyL0tFa2dwTkV2L2lqN2R3MnJ3QVlp?=
 =?utf-8?B?akZ6UUxVanF3OTF5Vk1HMWJjTmNQUGZ1dWxLTXFBVDE5YlU1TnNkT1hzOVls?=
 =?utf-8?B?eFZjQ0toREp2ak95VlB2TGY0N1poVml6Y01xbmRLK1hRQ2lPd3hoaDJvdys4?=
 =?utf-8?B?VXB0Yjc1bjRyVWNMY2g5Q2c1QVBkWHl4Yjg1YkcxRmtJRkk2cTE0TmJjRmFz?=
 =?utf-8?B?Q0FKZ2haNGE1MFNsZ1IzVDMzWFRXWnU1YVZBSEJwQk8yRElyK2FjQjlNcGlt?=
 =?utf-8?B?OFJKNTFQaUZlaHMvR25rWUxxR0xpdkUwWUdlSlRmNTlBMGhUTFlmT09Zc1ho?=
 =?utf-8?B?d3ZLMUgwWGQ0Mm83anBsYWQ4OWljeVAwSnlPWk5Pdm9uK1dJMGJOL2dBR1lU?=
 =?utf-8?B?cVdzZC9ZcndTNmZZZXppQWdQaXNyb3FZVk9qU2cxN1hUTEpFdGVWbU9wbm51?=
 =?utf-8?B?UTZKMmlhY1pXc083RkRnMjBrVnVPc0FsRmg3U0xmb2NieTg4eCs5M1dNK0c5?=
 =?utf-8?B?cmxpZTJIQ0hNbGJobzFraTN4NS9hU21DdzFSZ1NKN0tQMlZEZGdJR09Rendx?=
 =?utf-8?B?M3RlcDNBQkY3UHMzOGx3TUd3TThEVzVtN3RqZko2U3orOGROT0hHMFlzeFhp?=
 =?utf-8?B?S1FpSXN1VFIyRWM0ZHpsamhqUm1MNTVyeThoazZIcU5PQjcybUxZZWN1bXFI?=
 =?utf-8?Q?gJL6dmG9dyiTI57wPznHvZ4ru?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e5b492-72ef-4d07-690c-08dc5d84d697
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:09.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ+q+LULdxG5f4bvL/Y7cDLOEzm8SgZ677FIQrhwB8ajR75FYIgDYbNxGWYVz4X82373nnZ2ROx34CfvVrgZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
 2 files changed, 559 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
new file mode 100644
index 0000000000000..ed5a1b4af1d76
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/delete-node/ &acm;
+/delete-node/ &sai4;
+/delete-node/ &sai5;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5_lpcg;
+
+/* edma2 called in imx8qm RM with the same address in edma0 of imx8qxp */
+&edma0{
+	reg = <0x591f0000 0x150000>;
+	dma-channels = <20>;
+	dma-channel-mask = <0>;
+	interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>, /* asrc0 */
+		     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* esai0 */
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
+		     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>, /* spdif1 */
+		     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
+		     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
+		     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+	power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
+			<&pd IMX_SC_R_DMA_2_CH1>,
+			<&pd IMX_SC_R_DMA_2_CH2>,
+			<&pd IMX_SC_R_DMA_2_CH3>,
+			<&pd IMX_SC_R_DMA_2_CH4>,
+			<&pd IMX_SC_R_DMA_2_CH5>,
+			<&pd IMX_SC_R_DMA_2_CH6>,
+			<&pd IMX_SC_R_DMA_2_CH7>,
+			<&pd IMX_SC_R_DMA_2_CH8>,
+			<&pd IMX_SC_R_DMA_2_CH9>,
+			<&pd IMX_SC_R_DMA_2_CH10>,
+			<&pd IMX_SC_R_DMA_2_CH11>,
+			<&pd IMX_SC_R_DMA_2_CH12>,
+			<&pd IMX_SC_R_DMA_2_CH13>,
+			<&pd IMX_SC_R_DMA_2_CH14>,
+			<&pd IMX_SC_R_DMA_2_CH15>,
+			<&pd IMX_SC_R_DMA_2_CH16>,
+			<&pd IMX_SC_R_DMA_2_CH17>,
+			<&pd IMX_SC_R_DMA_2_CH18>,
+			<&pd IMX_SC_R_DMA_2_CH19>;
+};
+
+/* edma3 called in imx8qm RM with the same address in edma1 of imx8qxp */
+&edma1{
+	reg = <0x599F0000 0xc0000>;
+	dma-channels = <11>;
+	dma-channel-mask = <0xc0>;
+	interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* asrc1 */
+		     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai6 */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai7 */
+	power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+			<&pd IMX_SC_R_DMA_3_CH1>,
+			<&pd IMX_SC_R_DMA_3_CH2>,
+			<&pd IMX_SC_R_DMA_3_CH3>,
+			<&pd IMX_SC_R_DMA_3_CH4>,
+			<&pd IMX_SC_R_DMA_3_CH5>,
+			<&pd IMX_SC_R_DMA_3_CH6>,
+			<&pd IMX_SC_R_DMA_3_CH7>,
+			<&pd IMX_SC_R_DMA_3_CH8>,
+			<&pd IMX_SC_R_DMA_3_CH9>,
+			<&pd IMX_SC_R_DMA_3_CH10>;
+};
+
+&asrc0 {
+	clocks = <&asrc0_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc0_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_0>;
+};
+
+&esai0 {
+	clocks = <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&esai0_lpcg IMX_LPCG_CLK_4>,
+		 <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ESAI_0>;
+};
+
+&spdif0 {
+	clocks = <&spdif0_lpcg IMX_LPCG_CLK_4>,	/* core */
+		 <&clk_dummy>,			/* rxtx0 */
+		 <&spdif0_lpcg IMX_LPCG_CLK_5>,	/* rxtx1 */
+		 <&clk_dummy>,			/* rxtx2 */
+		 <&clk_dummy>,			/* rxtx3 */
+		 <&clk_dummy>,			/* rxtx4 */
+		 <&audio_ipg_clk>,		/* rxtx5 */
+		 <&clk_dummy>,			/* rxtx6 */
+		 <&clk_dummy>,			/* rxtx7 */
+		 <&clk_dummy>;			/* spba */
+	power-domains = <&pd IMX_SC_R_SPDIF_0>;
+};
+
+&sai0 {
+	clocks = <&sai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai0_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_0>;
+};
+
+&sai1 {
+	clocks = <&sai1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai1_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_1>;
+};
+
+&sai2 {
+	clocks = <&sai2_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai2_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_2>;
+};
+
+&sai3 {
+	clocks = <&sai3_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai3_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_3>;
+};
+
+&asrc1 {
+	clocks = <&asrc1_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc1_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_1>;
+};
+
+&amix {
+	dais = <&sai6>, <&sai7>;
+};
+
+&asrc0_lpcg {
+	clocks = <&audio_ipg_clk>,
+		 <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc0_lpcg_ipg_clk", "asrc0_lpcg_mem_clk";
+};
+
+&esai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "esai0_lpcg_extal_clk", "esai0_lpcg_ipg_clk";
+};
+
+&spdif0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_4>;
+	clock-output-names = "spdif0_lpcg_tx_clk", "spdif0_lpcg_gclkw";
+};
+
+&sai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai0_lpcg_mclk", "sai0_lpcg_ipg_clk";
+};
+
+&sai1_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai1_lpcg_mclk", "sai1_lpcg_ipg_clk";
+};
+
+&sai2_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai2_lpcg_mclk", "sai2_lpcg_ipg_clk";
+};
+
+&sai3_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai3_lpcg_mclk", "sai3_lpcg_ipg_clk";
+};
+
+&asrc1_lpcg {
+	clocks = <&audio_ipg_clk>, <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc1_lpcg_ipg_clk", "asrc1_lpcg_mem_clk";
+};
+
+&mqs0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "mqs0_lpcg_mclk", "mqs0_lpcg_ipg_clk";
+};
+
+&dsp_lpcg {
+	status = "disabled";
+};
+
+&dsp_ram_lpcg {
+	status = "disabled";
+};
+
+&audio_subsys {
+
+	acm: acm@59e00000 {
+		compatible = "fsl,imx8qm-acm";
+		reg = <0x59e00000 0x1D0000>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+				<&pd IMX_SC_R_AUDIO_CLK_1>,
+				<&pd IMX_SC_R_MCLK_OUT_0>,
+				<&pd IMX_SC_R_MCLK_OUT_1>,
+				<&pd IMX_SC_R_AUDIO_PLL_0>,
+				<&pd IMX_SC_R_AUDIO_PLL_1>,
+				<&pd IMX_SC_R_ASRC_0>,
+				<&pd IMX_SC_R_ASRC_1>,
+				<&pd IMX_SC_R_ESAI_0>,
+				<&pd IMX_SC_R_ESAI_1>,
+				<&pd IMX_SC_R_SAI_0>,
+				<&pd IMX_SC_R_SAI_1>,
+				<&pd IMX_SC_R_SAI_2>,
+				<&pd IMX_SC_R_SAI_3>,
+				<&pd IMX_SC_R_SAI_4>,
+				<&pd IMX_SC_R_SAI_5>,
+				<&pd IMX_SC_R_SAI_6>,
+				<&pd IMX_SC_R_SAI_7>,
+				<&pd IMX_SC_R_SPDIF_0>,
+				<&pd IMX_SC_R_SPDIF_1>,
+				<&pd IMX_SC_R_MQS_0>;
+		clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_mlb_clk>,
+			 <&clk_hdmi_rx_mclk>,
+			 <&clk_ext_aud_mclk0>,
+			 <&clk_ext_aud_mclk1>,
+			 <&clk_esai0_rx_clk>,
+			 <&clk_esai0_rx_hf_clk>,
+			 <&clk_esai0_tx_clk>,
+			 <&clk_esai0_tx_hf_clk>,
+			 <&clk_esai1_rx_clk>,
+			 <&clk_esai1_rx_hf_clk>,
+			 <&clk_esai1_tx_clk>,
+			 <&clk_esai1_tx_hf_clk>,
+			 <&clk_spdif0_rx>,
+			 <&clk_spdif0_rx>,
+			 <&clk_sai0_rx_bclk>,
+			 <&clk_sai0_tx_bclk>,
+			 <&clk_sai1_rx_bclk>,
+			 <&clk_sai1_tx_bclk>,
+			 <&clk_sai2_rx_bclk>,
+			 <&clk_sai3_rx_bclk>,
+			 <&clk_sai4_rx_bclk>,
+			 <&clk_sai5_rx_bclk>,
+			 <&clk_sai6_rx_bclk>;
+		clock-names = "aud_rec_clk0_lpcg_clk",
+			      "aud_rec_clk1_lpcg_clk",
+			      "aud_pll_div_clk0_lpcg_clk",
+			      "aud_pll_div_clk1_lpcg_clk",
+			      "mlb_clk",
+			      "hdmi_rx_mclk",
+			      "ext_aud_mclk0",
+			      "ext_aud_mclk1",
+			      "esai0_rx_clk",
+			      "esai0_rx_hf_clk",
+			      "esai0_tx_clk",
+			      "esai0_tx_hf_clk",
+			      "esai1_rx_clk",
+			      "esai1_rx_hf_clk",
+			      "esai1_tx_clk",
+			      "esai1_tx_hf_clk",
+			      "spdif0_rx",
+			      "spdif1_rx",
+			      "sai0_rx_bclk",
+			      "sai0_tx_bclk",
+			      "sai1_rx_bclk",
+			      "sai1_tx_bclk",
+			      "sai2_rx_bclk",
+			      "sai3_rx_bclk",
+			      "sai4_rx_bclk",
+			      "sai5_tx_bclk",
+			      "sai6_rx_bclk";
+	};
+
+	sai4: sai@59080000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59080000 0x10000>;
+		interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx";
+		dmas = <&edma0 18 0 1>;
+		fsl,dataline = <0 0xf 0x0>;
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59090000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59090000 0x10000>;
+		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma0 19 0 0>;
+		fsl,dataline = <0 0x0 0xf>;
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	esai1: esai@59810000 {
+		compatible = "fsl,imx8qm-esai";
+		reg = <0x59810000 0x10000>;
+		interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&esai1_lpcg IMX_LPCG_CLK_4>,
+			 <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma1 6 0 1>, <&edma1 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+		status = "disabled";
+	};
+
+	sai6: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai6_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai6_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx", "tx";
+		dmas = <&edma1 8 0 1>, <&edma1 9 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+		status = "disabled";
+	};
+
+	sai7: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai7_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai7_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma1 10 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+		status = "disabled";
+	};
+
+	sai4_lpcg: clock-controller@59480000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai4_lpcg_mclk", "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5_lpcg: clock-controller@59490000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai5_lpcg_mclk", "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	esai1_lpcg: clock-controller@59c10000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI1_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "esai1_lpcg_extal_clk", "esai1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+	};
+
+	sai6_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai6_lpcg_mclk", "sai6_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+	};
+
+	sai7_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai7_lpcg_mclk", "sai7_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b3d01677b70c4..da49d4bad32ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -461,7 +461,92 @@ drc_crit0: trip1 {
 		};
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+	};
+
+	clk_mlb_clk: clock-mlb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "mlb_clk";
+	};
+
+	clk_esai1_rx_clk: clock-esai1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_clk";
+	};
+
+	clk_esai1_rx_hf_clk: clock-esai1-rx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_hf_clk";
+	};
+
+	clk_esai1_tx_clk: clock-esai1-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_clk";
+	};
+
+	clk_esai1_tx_hf_clk: clock-esai1-tx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_hf_clk";
+	};
+
+	clk_spdif1_rx: clock-spdif1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "spdif1_rx";
+	};
+
+	clk_sai5_rx_bclk: clock-sai5-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_rx_bclk";
+	};
+
+	clk_sai5_tx_bclk: clock-sai5-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_tx_bclk";
+	};
+
+	clk_sai6_rx_bclk: clock-sai6-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_rx_bclk";
+	};
+
+	clk_sai6_tx_bclk: clock-sai6-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_tx_bclk";
+	};
+
+	clk_hdmi_rx_mclk: clock-hdmi-rx-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "hdmi-rx-mclk";
+	};
+
 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

-- 
2.34.1


