Return-Path: <linux-kernel+bounces-150502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6C8AA039
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD763B25E36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087FF172763;
	Thu, 18 Apr 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mBRWgx3c"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1D171E62;
	Thu, 18 Apr 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458225; cv=fail; b=aMXYserbW93D//2cArlD40n04I8dpQxtK8Ure9X1vTLENtF0KRlsCYddCgVmzxly/RNdbtFVIVsVtg/8Dxo6V6T3AXVpawGiB7zYWhUjEUYqSSErfX4o3L0UoOn0hpkB05nm/NHhHRaWQbZ/0HnR2zwvdGYtIVKFNN6ZwO83lGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458225; c=relaxed/simple;
	bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jCJcgXqLngSWfqQ7xM0CknLFkLLS8EPoKwkklIr5FOcXNQcuOkdYI7QW6qr9e3T+75+Bb+TAkUVVGHKMe5rswqnYi6xMNbFCPg7nE0DKgGMZSnlMbk75kFUyKRYRW5ZrhlmeMvDp1UnJVhoucrqOaKGxQmnK5HqIiS4yr7ajPyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mBRWgx3c; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv5SeyNt3nktqPKv+O4YMUY/LIlSFDrAlvdUQYTI9g/ckj576w9ECAX6QaBl1I2Zjs/fHIIBqsKft57R06YRAYiSsZH5fm4+BW4fVNc0NJK6Kte4/7RfFXQE83mikabG9AhdeS31pTsHz/D1tVYrV8JDoP50eBn047CGl4WwT81QC2avYWCdVGL8rqCSyk42w+/0+jUC9iBfTgAf03DEmRLy8nE/1IYICfbYW985BAZRgX3iYI6Mq0LNl5BqNgTYpHZgoFrNT1NRcsFUdDLOXoMxNouEqxNhzm6Tfa0iuJ/tzDnKLwSQldXPHQwOGWEMxmzdd9kpVZf/gSrtYWewbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=BUxR1l4R0qt3q1PlIAjjhv0lIJ7TrzjJa+4RvcQwUy96kYqFXvIlgCiDlCzaB8gFjZr5r9wqPtFCEzajFB4CraN28iBrU+/zyTEF9gnUygb0dotLgb6iB4qQsNsKdrWRmabOH6o3FmUbhI5OQ+cyR1EAqT3Bh3ctFdTXGaEtSVNG7lrlUdbO2YYS6ha8oc3EBnkcOzkAMHH+F0/0i6i21gWL0fOEESb2QANikuyt0YbeDEfT/6PWkcVKYbFrqVQ/SiyWykAeflsQQSLJ3JtMfFB3ieetr+BH3A2wGr2s8tYUoO+r3T4zlqgoszwnqij4qhZilfLNyvS+IGowJEgFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=mBRWgx3c10PcoIrkaBjNHVP9Y2WB+j7pavXq7W0nKLcCyyrFzJ3Qeohab+/M/lzdAKSyxSCpuH2xrpmy3bm4S9MP3Um5D/HcUNSy0ikwktUBMvUfqvYYgsA+rlEcjZ6M2RHVif0411uv+jZ1RmUNRa4rROzeKy23EMMqLbtnKbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:36:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:36:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:37 -0400
Subject: [PATCH v2 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-2-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=17204;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
 b=ki8LbDvDBH03+IjkEyfQi/KfakyQeYnMPoN3Vxk2q3IWjcHGh5cIEKJPnIdwH1d9ikyN0D5BB
 2BSpV/8M0TnAAn9jGtbId9vd3HOMIiqFX+DxqDZ5asV0SM3rGt2lrA9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 929c005d-94cf-4716-262d-08dc5fc5c4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/otHEYYz8/i2bkarQUy06c3j+dVG+b/LY8uEJMkkC7FeSu4N+IyrBvwVl8S6PSnTk/scFflKkRztkpgh2W2MHE6UUoR4fgFrSZUeMx4wduM52p1htRqGWItlQ+KRbBQlv7RKXcU120UZXaI0U+C5lyE8YPOMqJJP+lZQ5ScYC9ektCCFgW1U40qlHxPnWM9xg2KWG8pJ+Uq/f0dkgSgJVk4BmVWsb8pxbYl5+doDTFNDcwTpsUfYNzd2cMnlN6Wle2bOfUoxciv4P0+vSheVk282DYTYVjEarEy6JyxtuATGNuGDdPkpL0CmnfZV5bqZArrACgEA6i4xkVbGGf8FdlxbTswdGl451y+IGnFIMUTV1V3KNJmmfasSm2Osp9JoMj4BqQyM9DvNjH/22J3fCwt/FXIB1+TkX4k7Zpq8BenE6AsYh5zn41ZlVEc+2DFdqSJiO0uh2Up2Aqb3e+7wGvk6pWyFZbJZviDAmDXawCOogEOYGpUN34ysuLWo0wri5uQw5RLGI1KMbXxx+LS7OW5XC6KGBTMiSR1+YAPS1qlLpzXgSTfNzDWfy6wtbpJVf4g6/FlqnV97xr+piY8vk1XfpX5IWeNqdm2QCtO53ZDMBEYBljuCiTMaKva6YuE4Ccq2AAlZDKAZGo2DhfeoQE5CA54Fjf5T3qFX+34kPaO5gHklfY9Fk0FBVdBqH2AJJyAjRSg7QqV/vA0HSfyyKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpqa25JNXJBUzdYOU9FdFRzaEdzUUdNR3lZak1oVG5mcjhXTno1UnIyTXFL?=
 =?utf-8?B?bEc3c0t3Mktja3ZUcWphRWNxajVMKzVtTnY0YXJ3azMwZTdTR1NFcnNJU3J0?=
 =?utf-8?B?U3Y4clJFYTBja1U2U0JxQUNIY0gzejMzdlNEMmJ6Z3JMSlVMMldHNEJjRnNZ?=
 =?utf-8?B?WVFSMU5XY3hXOVhkV08xN3ZMb1l2NVZGdzB1R2hEbmNCVlNKU01pQ1dJQ05x?=
 =?utf-8?B?N2gwRnplVXpIcHpWSldrRFFER3I2RStEMzhWNGIwVDR2ZThENEpOZVZtcmVG?=
 =?utf-8?B?Z3kvbWRhZEx0Wnh2S25ETWNzNGE5eHMrcDlYOVhOQzBHZk5XdUVSQ0NZQXpl?=
 =?utf-8?B?TXNDcEx6SUV2Z3RvSTJwWUdjRlVzUXdNMVJLanlkTGprWVIyN2FRNTFuY3ZI?=
 =?utf-8?B?ZEJaSXRrTHVaaHZpRGhNN0t5ZWxmby82UzlEN2lGcDJmY3NLazhJSElRWDVQ?=
 =?utf-8?B?Wk5FQkJRZEJsemRqdEpvTzBkajdPRStpMTF4YWo2bFdvM1JTcXhQV0dGWGRY?=
 =?utf-8?B?UU15Q0EzWHh2ZWNTZ3RoZnpFWUY5N0N4MUxaakVFRmpNa2s3S1F6b200Mllm?=
 =?utf-8?B?QS96R0NjQlpoV1RoSmtPL0ZhM3VJRWZHU3lBa0p5T1VyRy85Z3RqUEZ2VEU4?=
 =?utf-8?B?bnkwUDN6TmhSN3ZncXB2UEpFaHQwUXpLMG1QaWpvUm9pMTZ4bWNET1pmNGNk?=
 =?utf-8?B?U0VWMmx2S3NubmgwQkpwR25mOWVGVmZqMU9kdGFpaGtXUVhLOWZWcFNGTFV2?=
 =?utf-8?B?TitrdTZadm8zTDlqaUphVEoxeVFxdGpnSm5qVFhaV2JHbVZrbit2T3IwSXE1?=
 =?utf-8?B?dUNzVndEYmdiRHBaVytBSUdZR2dMTmJLYkZ1dEtTT0FVc2U0bGgzYzdxMUZw?=
 =?utf-8?B?Z1pJUGRnc2lHVEJEMmVvRE9oSGdCM2NiVjJOMTM3M0V3aXZKNERBMEdEMWFQ?=
 =?utf-8?B?WXhOWXUvYndTK2JZRkpTeE10SVZnNThad0oydEhGczdmMFc2b242K0xydHN2?=
 =?utf-8?B?Si9aaFpRTmt2SGJwUW42Z0ViSW1nR05iM0IrQWE1Nkp6YWo4VWZSZGxGamRI?=
 =?utf-8?B?YnJQQUtzbllxNkFuMExIS2QzZm51UzJjd1VGUTdiZmY1VzhZRXJ3QVNJTFRt?=
 =?utf-8?B?cTdvazlnSk93NkdsQWViR0l2ODdnUVkxQUFoZVJGNVRPWUUydFhpTVM2cnYy?=
 =?utf-8?B?OGk3VjF3eVRZSk5WZUk4SjFnZDFQRzN4RlJpTG5NRVpCMU5rWGd0TlE3aG5H?=
 =?utf-8?B?aDVZejBPK1pZL1JrS3BXZ0luSGhYaDNmQ3RaUENsV21HMGdNWHFmZXRvTXYy?=
 =?utf-8?B?ZlVDRkloeU5LbjFaelNCRUN1VHMya1pIdy9rb3RoczhRSGl5c29uQzdiMnVH?=
 =?utf-8?B?NmlNWUpLMERMRXJJdk9XazRQVXVvWTlYMHNTOW1WcnBQeE4vbGpKMmNySjha?=
 =?utf-8?B?UmpiMmRqemQrWHAvRE0wRFZLMDBHOHlyRCtnMWw2elJLTkxNVkMyeEU2UUlE?=
 =?utf-8?B?UkdXdHNaZnNkd1U4NVgyY3czOUY3cU4yS0M4STZnaFFlOEZhQVI4R0pJbWl2?=
 =?utf-8?B?NzdMVlVWenJpU2gvQjd4dWIrRWJDcjdLVlIrYkJURlozMWVVZ3ZIekh0QWVa?=
 =?utf-8?B?T2NrNlpyN3hSVnJtZ3dGc2t0MXdXZnZHaU9xRWIxRENuV1JZdFBnVGNaenBj?=
 =?utf-8?B?b2RZWG5ralJjVXlJNnNvMm0wa0l5eDl5NGdTZDdqWC8vMFBSbU80L2ltd0ox?=
 =?utf-8?B?RXdYR2xQOHhtdFBlb3lrQlNOVWo0MmpnaWk0elYvd1FQWFV2SEUxVlMraXVE?=
 =?utf-8?B?L2lnTHhaNjExUWd6U2JZUVFuWU9kUXB4TEozRzYwUVIrSWcxR0xwOTIvemV5?=
 =?utf-8?B?U0hiUU5xaTNPR2VnMWwrS2JKcFlTTmRQMHZXR0tJUjcrd0NXZUhmNEZXT0dl?=
 =?utf-8?B?aG1HRGdkSk1CUTBzbjJwNnpsRWRzVExjd1dvYWhDSS8xZHh2MFZySTNDZTRF?=
 =?utf-8?B?OGN6VkdYQzdQRUZlZmdVSzAwZzNldlh6clVrSkdSTWs3d1IxQkVpaWVUYmRS?=
 =?utf-8?B?d1F6Z0gyVkMwVmp2Q1RMaVRsSTVhS1BxUXVMWk5nT2k4Nm0zMVRkNlNLSjNm?=
 =?utf-8?Q?CECm73jdtIMawl3Oej2yUjq9a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929c005d-94cf-4716-262d-08dc5fc5c4c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:36:59.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO2krNoD2AOoEb4ZH0novBrQZjrDr8YbfIzH7CupPtaluM+tDuvzu9/XxnEJA5QLtZb4nsL1PO1x3fNAKrOhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

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


