Return-Path: <linux-kernel+bounces-39686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE583D4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCAA1F29D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A022EFC;
	Fri, 26 Jan 2024 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TCoWZz5R"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A522EE7;
	Fri, 26 Jan 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252715; cv=fail; b=TXZojr3re9bsC7yXGJ0WjhwPMshSxNtYYiQF/Jr3qa8MmdOx/SoxfN8bBOAEv1Udeywwpuf0Yvs843OPElpWCyU98rer8Nb3GYl5lXIe47dik5yHh8+DXzaisaghQ5qn6ZXxMoC+wmj4QbhYF9F2ZHOoyDwddr5CBsNojqZ/EOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252715; c=relaxed/simple;
	bh=lxusFRPnENHR2KAqamX0aWHdgg93LfYvJoapBJPdPl8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qmpbUWZA6mRNQOJvgh1LmAOlp2Qe+8p5l8rW3cnSJrnVvKp9IBT4N3+PaH8cppKLsmx1xVcEk/U8LgQhLbfmf9GYC95/4zCNfWT1HWDqpsbwVNvCAFNIqbO+LSkbx2tbBroetDgZLU/SEyeaNFDZxqGsqVDJl9yUNbFybcSSnKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TCoWZz5R; arc=fail smtp.client-ip=40.107.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChrQlUShimnV2UfAasZXjH2JrW2LkTVIUbtfJA144ulg3Lzbyr5alHijW8XC2dJq2lAHOvChkiSXA3gFz6ih7BoxLV7MESz26rYR6rV7OQN1IqOClWJLA0m/h2Ehb/b3FH3p+Wuyu8Q2rlI1Im+RCt+l83TPySO7hXgVY3hnqYuxmTYSzh3hZ0hdIQ+Zu1o8PXyOTJmxjy7nmyezVKtHkgipvmDnQQpRZL2m2y0KfE6sM0hNBSWONF7IvN+LbaZhB+VdNvAvfaNW01Wp+lkpeH4y7zp7IdZ12s7q6Xxy+mhJpCNQlbrN9N8oJr3TSexRpLlmeL1V6bkmB4q+5D/XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWwGLQogleAHAp03QiCYcNmz77yayBGa4AxJXmlI5Q0=;
 b=ImYLJUf2BwLRzTncw6BimsuvJYEvFJ9ylcpEKMKdAr+elUe8MbiWU48jSKnWEYwkroeFH05lRHuJVXneVwjHWnm9Zma+0wyq2R6UdOmEUyzBEr8F0pHRD+9/VFfhOeBEo5OqDiYTnMGJ7tsXfK8qWWvro5+TYKw594Yaj6UmR6UXELXp4hG5PWvX8xf/KZU1fwZ4s99O9W6OYrHzG1yl/zl5xHk81q9K/MEqkPvZbBclAhQVXIEJ3nVC83wiAXnwYv781azHDVZ0gycWjXo6cazxDJidet2DupxJYs3qW5nce841McFbzIIa8Dj797Ebi8KLOu4frfMhSi91ebYmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWwGLQogleAHAp03QiCYcNmz77yayBGa4AxJXmlI5Q0=;
 b=TCoWZz5RTxPcnkNv7ZpJcFu55LRky3lUzo5vTCAMN3ZEJ7wJwDpfbVYcgxTI4WYcfOTpjwi7snVAuo4CAx2NL7VB6YyoBTz862ez1Q6T9HWxz50/gqUtTCfsAkCx5GDeRx0UMQQBxhGrfDZxQHplYMrhWwZFOtSuN7xqNVywNZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:05:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:05:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 26 Jan 2024 15:09:19 +0800
Subject: [PATCH v3 2/3] clocksource/drivers/imx-sysctr: drop use global
 variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-imx-sysctr-v3-2-33fe801d5f31@nxp.com>
References: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
In-Reply-To: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706252968; l=4759;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GNd7nn9IlMWOE6EtgMoRLuOvy3mCu2EVYjx6qUvMpbo=;
 b=t0YAXFpShJ+kyGL9+aJ76dTajHOu6B/NgIS6JNiyyk9CXMG97W8VWOXltP2q4yuQwxZ3NJcaY
 ntUjmwCV0g7AB2AdBsIsEyOS07qnyAE9jJ8HoaknPyS/Pbh+WM71P2J
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d483ba1-f61e-4dbd-f76e-08dc1e3d2240
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AOj5PFPHUuMTpYjAH4jb8MlJwdxXjcOrbATAS2eTR/+UP33CYraRDOZ8Gs2myOos1UMAlM0wZsVRz1faQGeFPwsxpXZ81OvuY0TG7VRKp44yWd657nzOfrvoSgXp9s86EfIbZOMG+YiNr3BxlzAaBTzDsdBxzexyTQtz/45w++i6S0x3FVKVf8p02XkFhY6Ts8Pf1jxoMdVnjdiigWbuINoQ8ioRBmmfG9xosO2K0iVi6DTHPzmHqs4VnlLugbV5hoj1Be21Ykg1b/L4cnz7ILDCofzplTu3o+vUgFchLm2PFpWAdpZZg5rB0JxWfrCfMMoaADbOcUwOmsVTokEhqrZSDTVaGC8osMVVKnKYUulDIbVeeQ9YaYfaHf2qzVO6BdLFCPueAMjK4rttLwOq/3PA8JYDYhX6RWUVuA2uuYR59mQE1cImaSKJWrh1Dp1h1wWZNQL+W9tvA+lzzJQDy9qffD5dlQZEbak+iHTbuCWg0Eawq+rZDrn67SQT5V0tsv0hKL2dFNd4LFW14ygLip8PMZhN3UvGGEPmwHxLjYzIQOXfimXJGqOI9f7Yw7pwDT2UqKl1B+0OxiQ7UBJMdj+at53wtloMDoSFt2SA13Z2LHtkrbAygRefsSWiO93gDUxX/pf/Ky29H1AfVyBqfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(478600001)(5660300002)(4326008)(921011)(38350700005)(8936002)(66946007)(66556008)(316002)(36756003)(66476007)(8676002)(41300700001)(6486002)(110136005)(52116002)(6506007)(6512007)(26005)(9686003)(86362001)(6666004)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lNNGdHZkdYMzdxdkFhdVRQa2t4YzhOTHdmdnU5aFBBV2RBOXNVQ003cjNv?=
 =?utf-8?B?WTRqUHFaREVBNnErQVNRK2Yrc2k1S1lXb3hMNGZvbkp1aXk3R0JFYVNDSVQy?=
 =?utf-8?B?clZzVkw1cjdEUVdpNzFoRE52eVFGY2tnc1J4NWtzbmE4NVR6U3BpM0FBSG1Z?=
 =?utf-8?B?cTF1RkdSQ2ZZMVZFQVJLYzVDTWxGdmxJZk5mSmcvY05Gd1ovRWlCNDVwdDVo?=
 =?utf-8?B?OTRrUUlUQmwvMTlQd3laR24veGgwZVNhUEFZcjNEVy8vY2ZyTGpMQmcrZFEy?=
 =?utf-8?B?cUdwd0Jlb1hyakVHTDJ0MitPOEZWRFE1UjBtSkVadGNoOTA4SkxuZmZkdkpy?=
 =?utf-8?B?SDAzTFdWMnJ3clBwVGswbVB0NzhyRDFaQkE5SnNxcEFabXpNSGhqekFIbE1Q?=
 =?utf-8?B?VGY3THF3M1BWMHN3SkJvNytUZExJUmIvMktuSSt6ZjV0cDdjUGVUb0pCbVVo?=
 =?utf-8?B?aU5IeTNRNlNUSTBub0dTcDZoYTJNL3krV3VOc1dvMnRNdGZUa01DcTlpUDFi?=
 =?utf-8?B?S2trb2tiNmlDQ3FieEJabWhyUDBKdDN4SEdzVlcvWVY0T2w4ejdzaXArOU91?=
 =?utf-8?B?OHMxSEMrVDJsaTlmMTNhT1ZML2lWNEdKODdYNkp3TUczMXd1dDBwN1RCREZQ?=
 =?utf-8?B?cXNTdzNyVTNCay81alZHMmpCWGdVbVdtYXhFTzZlcThWdlJ4MFNlMDVQUHov?=
 =?utf-8?B?S3hhOGhud0g1TCsxbzk4LzRTZHNIYXhITlBLUlAxL1dDV0ZCRDZjT2srVHAy?=
 =?utf-8?B?ZkMvQ2RNc1o0Z0N0dktGOVh3eGIyODVnbnBET0JtVlk2OWJKN2xKdm55N3Q0?=
 =?utf-8?B?Vk8zL1lqMWJaWldDczVCNFZEVFl1bmpjMGdCdFBvRVF2Z211U0djSXl0QVRQ?=
 =?utf-8?B?L1paWUJQSFhocW9KNHhIMHhpWlZOZWwyV0Y1bE9wamQrVG9yc0habi80YTVN?=
 =?utf-8?B?OWpJRXVJb1Rsdjhqam56RXZ0WklnUklQRGVNQkdQN0xnZjJyclRudFZKdVlh?=
 =?utf-8?B?aGJpZUJpNVRkTHJkNExadGc0eGlvOHRiZGxtaVRUN2lLUDdaNi9QaFJZQ0s5?=
 =?utf-8?B?Wk1maENsSUNGKzN3SWxhZFEyTmhEZFZDTTZzYkNJVXBCVTdKandRNkcyNm5U?=
 =?utf-8?B?a3c1b0Z1b1c2MS9kaTFCUVI4TEVTVm43VU51WEpNVUIxenp6UXhEM0Voc2JG?=
 =?utf-8?B?d2h5WXlEbDc4OHVpdTd4Qk1qMmZ0Ukh3ZTF0NUxhd29qbklxdlVLMEFqQXpD?=
 =?utf-8?B?S2JIV3BQbG40MEdxMitZYXczaWRGVE1SUXFmcHY1aVF5MUV6NjQyTEF0QjZS?=
 =?utf-8?B?MXp2U2dWdjRFUVpiRjF0a09EM2dhUUtyZE9HQm5GT1VmZlp1MWFKL2xMZFJK?=
 =?utf-8?B?dTJPeXlwd25tbkpOTHdrRisvbVBOM1J6Q2JlVmFxRW8yd1drcWdtYzlDY2c3?=
 =?utf-8?B?UFVYb2pHYjNIOHdOaEJZWC8zODd5dzJtU3ordzhqOEJ5Q0dRTHFkak10TXRT?=
 =?utf-8?B?K3RrVlhBUlc0N1IySnVSRlo3Q0E5YkJrbUJEbS85dytlSG42ODJWNEdtRnJ0?=
 =?utf-8?B?R0RYbUV3TzNNd2x6ZEFFU1JPeDB0Mm1nbXFLaGx5OFNQVVNFdm1leUgvUWd3?=
 =?utf-8?B?NjNGMUlpem1aOFoyUW9EczVQekpkZExTbFh5TlBOOFovRTZOWXRzd0pkRDlE?=
 =?utf-8?B?RFhFRDRwR2xabGgwMThDbTdDWjBMNEpFZnBveUhBVlVjMXNCd1NJNkJzbkE4?=
 =?utf-8?B?QzdMT2pFeFIxNURJTk9UN282Q1lEeDhLWHRZQWlRZG56R2dxbkk4RS94eS9k?=
 =?utf-8?B?RU5QcjduU0tnTHlDWmsva1Fta2dyWnZwaCtzZ0o4a0tpdERnSTFlcmNsbExR?=
 =?utf-8?B?ajFNZXZwbGc1TlVxYnZsdkVmMnJ1clJSblhqWUZrSTltNklSSmpMbkNkSWM4?=
 =?utf-8?B?bUp2MS9kcFZPNThlKzNWZVpXNkxlOS9Bc3BTYmkrenpKcmRBVEt2cU9mU2Y3?=
 =?utf-8?B?SS9ya2N3NzEyQnNJcjY0bkFKVWtoNkxwVTBpR0lwOTZyOTJDTDgwMkh6VDR4?=
 =?utf-8?B?T1MvdXNHUEQ5K0kyZ1RKKzJqeU5wMDYwZUFVbUIvZnpOQVJkVEtudFBkbW5W?=
 =?utf-8?Q?0nc/u4643C+K7TrfDAkecMIet?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d483ba1-f61e-4dbd-f76e-08dc1e3d2240
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:05:09.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwFzY5Y6pLvOM7EmbOReEsFqj+sf3gxXtapxJcFSakT618mOSnw/XhiyGReBB43+3BoF6GOVvdEC41evKS1+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

From: Peng Fan <peng.fan@nxp.com>

Clean up code to not use global variables and introduce sysctr_private
structure to prepare the support for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 75 +++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 5a7a951c4efc..8d5bfb8470fb 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,32 +20,39 @@
 
 #define SYS_CTR_CLK_DIV		0x3
 
-static void __iomem *sys_ctr_base __ro_after_init;
-static u32 cmpcr __ro_after_init;
+struct sysctr_private {
+	u32 cmpcr;
+};
 
-static void sysctr_timer_enable(bool enable)
+static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
 {
-	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
+	void __iomem *base = timer_of_base(to);
+
+	writel(enable ? priv->cmpcr | SYS_CTR_EN : priv->cmpcr, base + CMPCR);
 }
 
-static void sysctr_irq_acknowledge(void)
+static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 {
 	/*
 	 * clear the enable bit(EN =0) will clear
 	 * the status bit(ISTAT = 0), then the interrupt
 	 * signal will be negated(acknowledged).
 	 */
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 }
 
-static inline u64 sysctr_read_counter(void)
+static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
-		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
-		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_lo = readl_relaxed(base + CNTCV_LO);
+		tmp_hi = readl_relaxed(base + CNTCV_HI);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -54,22 +61,24 @@ static inline u64 sysctr_read_counter(void)
 static int sysctr_set_next_event(unsigned long delta,
 				 struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cmp_hi, cmp_lo;
 	u64 next;
 
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
-	next = sysctr_read_counter();
+	next = sysctr_read_counter(evt);
 
 	next += delta;
 
 	cmp_hi = (next >> 32) & 0x00fffff;
 	cmp_lo = next & 0xffffffff;
 
-	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
-	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+	writel_relaxed(cmp_hi, base + CMPCV_HI);
+	writel_relaxed(cmp_lo, base + CMPCV_LO);
 
-	sysctr_timer_enable(true);
+	sysctr_timer_enable(evt, true);
 
 	return 0;
 }
@@ -81,7 +90,7 @@ static int sysctr_set_state_oneshot(struct clock_event_device *evt)
 
 static int sysctr_set_state_shutdown(struct clock_event_device *evt)
 {
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
 	return 0;
 }
@@ -90,7 +99,7 @@ static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
-	sysctr_irq_acknowledge();
+	sysctr_irq_acknowledge(evt);
 
 	evt->event_handler(evt);
 
@@ -117,34 +126,36 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static void __init sysctr_clockevent_init(void)
-{
-	to_sysctr.clkevt.cpumask = cpu_possible_mask;
-
-	clockevents_config_and_register(&to_sysctr.clkevt,
-					timer_of_rate(&to_sysctr),
-					0xff, 0x7fffffff);
-}
-
 static int __init sysctr_timer_init(struct device_node *np)
 {
-	int ret = 0;
+	struct sysctr_private *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	ret = timer_of_init(np, &to_sysctr);
-	if (ret)
+	if (ret) {
+		kfree(priv);
 		return ret;
+	}
 
 	if (!of_property_read_bool(np, "nxp,no-divider")) {
 		/* system counter clock is divided by 3 internally */
 		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
 	}
 
-	sys_ctr_base = timer_of_base(&to_sysctr);
-	cmpcr = readl(sys_ctr_base + CMPCR);
-	cmpcr &= ~SYS_CTR_EN;
+	to_sysctr.clkevt.cpumask = cpu_possible_mask;
+	to_sysctr.private_data = priv;
 
-	sysctr_clockevent_init();
+	base = timer_of_base(&to_sysctr);
+	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
 	return 0;
 }
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);

-- 
2.37.1


