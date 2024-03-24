Return-Path: <linux-kernel+bounces-112614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647B887BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909EC1F21C33
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AC17BCE;
	Sun, 24 Mar 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RV/Bh+hj"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46B17BB4;
	Sun, 24 Mar 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266256; cv=fail; b=j5TVyycjCvBJaPGcoGkbLiddf+K7aj8zTWccB0y0KEzsgGoJwZChyeTCOTj2MBABoZGp4DBHT5i+lOMQNlODwUZscuKj3F8kUjBoqefwfzGLFWVE0nn90MasS4iym9jLuYe6u4ncIRuQN7QWicUeYw9eOqAa8zvqDnmfB8T62Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266256; c=relaxed/simple;
	bh=/ONMWA5HwK7f2Lau5bEiPM0rZ6FI1rljIhuFBs9ogjY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bTxh5jP8TeTM1+lowHdACQkEppk3BfxPcXUrbDlmbKsRv4KV57/4Y74j5LlUU0yj/J2ZnH7Z/pATeaFlLJPk3dTczYFEEmOoVgfgK/JdQ44x5AoqCYDPAb498/tlWPtnAerP9O94cMwL4yz0sSNk19uEqYk4TQuVf8Z+DI5iBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RV/Bh+hj; arc=fail smtp.client-ip=40.107.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1Ckw7Xqv2+qII/3Q3YDmKyDHeT8NOF2k9mvaUEx4jtX1QKxdckqafOnw4KYYAHQ7xw3EVeFEimxqHjfrTdtS/w4Jny8n0ZhjV5RzV+A1LLOm8MzebrRHtjNnvTMwnPkWA4/VTPrKx+rvu0VP8Jpr27PLhypAlLda5+t7n2yqDhTCzmmT3JFmdlSBXt+23P4EKqdSUsSaDwU6VYr970eXr3yx2B/liCYX0WdlPwvhVJotwNc8gAx0A7bxkgRahirHZs8S15Jy347OmO6ONYRkxmTd48LRYPUkaD+bqEoKRjnLqxrSolLuqPMSDjqkAtAltNLDiPnM72rShhi1YbemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSMzMeRyEuAdBLvPMQRnGts0Y+Aedb8psU6zwGhY10I=;
 b=Yv5PCV2uOARDiwkRFvc+xheK4EXKRWHf+cVogi9F7CXvM+U/Y6sLs1nNyLw3O6lhSLi9eFW78Dh3kU6X04BZwu9oRvaaaOF3yg9KpVDtnjTf+7SI/PSjDoArORucPIm2vG41IOS0Xd+zIl3SCnYuk32OkCzE97RRpJEh5FMDmS/jagkxBAveIPZAIpCHDYDRHDLZkDLFZiEBhVleq98BzE7hLUY83UqnOhWYKvaJxh1RGxEPe3eq9FpOBCgamYpB3cYRdYKySC1p8jMhqrwIOXNNNDQzT7jmsDokDfY3lJ4FSTN32k2hdAEg/4oLnU4xfH8To4pJEedCF8BswQT8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSMzMeRyEuAdBLvPMQRnGts0Y+Aedb8psU6zwGhY10I=;
 b=RV/Bh+hjXSq7jjdd6Z+OswBUWC+bxVOvW0qBLnj786h/QzUknczddX+99GbmfcquJopH46AkH42No9+C44Ka0otFkqThvY2Ien7Qyse0ZElkMOH2ge8rpQHJZmViSVqrBaOSTmq6FJP9BbWFJqPwmarzHAyfuHA5Pf+a0VRWmHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 07:44:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 07:44:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 15:52:03 +0800
Subject: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-imx95-blk-ctl-v5-4-7a706174078a@nxp.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
In-Reply-To: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711266729; l=13472;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=l4DlMaNZtr5nsDFzShy8D+H0Cb79cmMx/CoZVs4+aCg=;
 b=wAeVNu0Lnlb7BIheYg8vwO33sGCHCkBBf34IbLSeyYmGomVsz1d0WsIcvExgncM1wVZMDWqkc
 DRD8HpwpEZKCBWADhE7ngD1KZb6PB7/wfCs4mViAg6Ye5LzcL/fNZhD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be63ba3-5698-4cde-89d5-08dc4bd631bc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MG74kizBpw8GKuQaCk4nxH8lzmLoKs/+e4JKROPGiSnk1Z1QLnxvkAEyzPb7tkUCQGG2Qjh93gP3WLEQMlJROm41PpJ4SuNjShBl4ipVJY3bmvjkNewoDaEF7Xw0TqG29U//IfcSid6zdX3EMPzirQiY/jDszp/dbruUv67eAlUPkwGf9W4wA6+vpB8HZEeDFUNCliYoSDcxw5qLRy/G7PkxhY4IFALTe3RW1HkppeaWzrWfxq3OXNXy8PaaYCmakEh5ozX3wAwtV/zBDWvYoJ3XuT8pTOMZHxtbwMP29E/dVXdsz5GetU11BbAVfU+KJyZXUZ9v3Qbt9TPZPFPsW7AGCTzpr4BrBt0yS4584maJE/nV43NBLv7S7ih2Bo6+fg3Kn4KTkS8TRifn/OdI5/RJsYCVO7yjcjQS2x/9eV032DXyDpDCdHhNHyFxBpQLceXBrQn8cexOwCvU79g9yKgYDpVHqGBzUZmyradC335Y5LDSIYXQ9gmbQZ2qgjFjSuLvEfBUIWNBwWFuuW/z0qZrtdwJWysMvZS2PuGf1mbNgQeIrBZnq9UPBQTU8TIWRh7MZOdhkgNnJFZv6JPt6Y8G6PseAlQYYUdxloh8MYAB6MSs0lIxWA4tWctT6FSwvWQ+jY5cUE3VaL/sIJU58eoCAgjWU0VWtHyZZNqqFykhbX6ULlsPoM5NXP/BSLIRKWAnyqlvPJ6F+HBYDqnJV9+E6g4/MVKL5Vpw0MlvOT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVFOVVhpU0s5VCthV1ViQi90bXBYUHRkemJyVGYrcE5hUUJnbGxSaTJDVmM1?=
 =?utf-8?B?YmZNMytVUUl5RjNIUERBNTFyK0t0anlTaTQvYUpPM2Jsa1l3dTJ5TFFPcVdl?=
 =?utf-8?B?QVZZd1ZNNG9VcHNnSitlS3RqSlVtaXA4Q09Sb0wyR2x6eWhJeS9vWjBvMmox?=
 =?utf-8?B?T3doOXJiMjlGL3RNdnAyZGx5ZXB4UWIyeDhtd3VHTFpUcEUzbElsZDl4ZUE4?=
 =?utf-8?B?TEJUR0lqY0orOExqRUtIMmVZZC82RlQzZ2dkYnRQRXpoV2gzSDdOdThHNG1u?=
 =?utf-8?B?ZVI3N1I5L2wxOFNTM21zcVlabEwzeHNBTGx6ZWtJWmVwT05jbnNxRVVpTkFu?=
 =?utf-8?B?NDYwWXhBNXQ3VDJqWW1rOWo3UkpUTVdXL09aUWdjMkFyV3gwRlJFYXRYbXg4?=
 =?utf-8?B?bGlYWTJKTFF1TVpuendCSk1rR0hwTVUwZUxUNUkwZjdWRVU5emRUdmUyVURZ?=
 =?utf-8?B?V3NQUSt6TmpNZklybG53SWVDMTlFTjVJOEJoaWFtMUhyalNkTm1yS1hIRXZy?=
 =?utf-8?B?Y2ZqVDF2cC9Vdkk4TVE4TkN2TjN5V21HUXNlaEsvdCtGekNLeHZzV0VzOVg1?=
 =?utf-8?B?d3M0VUs3ZTltb3YxcG5vMEQrVFg3Y2xWaEpXT0xTNHZRemtQbVRNcktOa2l1?=
 =?utf-8?B?eERLRndsWGhSM1IxRjBqZk1qL2swVE1PY1VnYk5FSlNnV3F6S1RXcG9QZ29B?=
 =?utf-8?B?emt6bkczVndsejFaUnVRNnI1ellOaXhkNjJyTEhLNkhxZ2JZZm4xdFNiOTVt?=
 =?utf-8?B?YWNvQ2dWRVF0Qlo0SzdJaml5NEpidHQ2TWJMQ1l1aGFkeUdra2tLYXFza3NB?=
 =?utf-8?B?RExwM1E4dHZnM0VwSS9RVTNKUk0reTBjbXBMQVBoWGgvaVFMWi9OcnE3RTJP?=
 =?utf-8?B?Tkxwa0pYWkRpWGw2Szg3a2RiOFF4eitCREswVWM4V0htZWxIdFV5TWRJd3RM?=
 =?utf-8?B?NExsaThiNFI1MER1UVBtdTdsa1JpbVhlTzgzTjhaUmJDWFh4WGF2RHVGcVhP?=
 =?utf-8?B?L2xPN2YvYXgrTzdaN0Jyckt3eCtiUmFQY0FiVFFCSU5jeXAvSEh3ZnJ6THVq?=
 =?utf-8?B?d2N1eWRCcmxGS2lQQUtCNGo4L1AySHVpNWoxNmI3bWUzN0VSWUNQL0dPSnk0?=
 =?utf-8?B?aDZZWE9rK3FLbFQ0V0dhVFVRbEk2cUYrMlNUdXd2RDh2blp3dXFqMUhEWits?=
 =?utf-8?B?Mk1aYWR1cFUzaDYxWmQ2azBiRjhPWU5mTkFmUXF0ZkthR2MreUo2YVgyb2FL?=
 =?utf-8?B?YTBydjlORFJWdFdOWE9yRWlIbytwRGVFWG9vWmlxdlc2L01zTlNjY2pVaG1H?=
 =?utf-8?B?dUxHV2V4R1pQVGJpRXZUVjNRcGtIdm8rdGgrcVh4TVFOekl5eHJObkZURTAv?=
 =?utf-8?B?aDhwQlB4U213NWFHeFUxMDg0TS9rcGIyK3F4eXJkaUt5K1RvUEw2dnFVcThw?=
 =?utf-8?B?Vi9kcXhXWUFCL1pCZElBdVFuOC80TFVVaWR5eEx4TjdPV1FweWs3Rjhmdmpa?=
 =?utf-8?B?Q1pVQmlWaEZhWWhxTDVOOXp3aHdhY3pTOVVla0lFcisxRDBveG1IRkhYYmF6?=
 =?utf-8?B?VXdJWDNRblgrbERscERnN1dQd0I2QmhnZTBVeHlrVE50RnFQeko4dm9wbzY3?=
 =?utf-8?B?bUlCeGpyOFluL1ZLUW40QmJIVjZzN0E2bm1oWk5ONFRKZlpSOTFaT1pCMFhh?=
 =?utf-8?B?WElQSlVFZS9aZjY5dVd6cWs2V0VvVlRLeWcyWGJyQWFwVEh6YnZBeWd0L2xU?=
 =?utf-8?B?SFR2c25ocnpQOUlJN2tObXRPY1lEdU4wNDZsOGxiN1hJS1BuQXJ3bUJ0cnJ1?=
 =?utf-8?B?N3dBWHhadCszWU1UZXpicmRDTFBNdHlhOG84MmQxc3JpK1NJUnpNQS9GTmpQ?=
 =?utf-8?B?SmMvSTluYlVtakhDZG1tYmg0RzRQUTNRek1PMmJBSVY0NzNhT24zTjJuYldq?=
 =?utf-8?B?M2pvZWZ3SzlLNmRhMU1GVHFJd3RHaWJyV3dwZk5tN1NqQ240SExjdmhEbmxK?=
 =?utf-8?B?S0VFc0JPdXcyc0p3L3QvZTFvTFhZN21nb3l2b3JEVytDYlVFempPOWNQd3lY?=
 =?utf-8?B?aWdGbGFPWEEwenYvR1piQWhUZ1NFV25kNm1IMng5d2lKdlhNSndja0Z0d2Zp?=
 =?utf-8?Q?v2ImxwRVfCqX4VNCFsRBOUQlb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be63ba3-5698-4cde-89d5-08dc4bd631bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:44:11.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8n0DzLUIupEAnolOywkEeU1YWoj5B6FcfpFheG+X8ueWk96kgombGmfzUrczn3i9c5IfHGo5C1TK8rG8b35QiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has BLK CTL modules in various MIXes, the BLK CTL modules
support clock features such as mux/gate/div. This patch
is to add the clock feature of BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig             |   7 +
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c | 438 ++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9..6da0fba68225 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -114,6 +114,13 @@ config CLK_IMX93
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
+config CLK_IMX95_BLK_CTL
+	tristate "IMX95 Clock Driver for BLK CTL"
+	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
+	help
+	    Build the clock driver for i.MX95 BLK CTL
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT || COMPILE_TEST
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d4b8e10b1970..03f2b2a1ab63 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-imx8mp-audiomix.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX95_BLK_CTL) += clk-imx95-blk-ctl.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
new file mode 100644
index 000000000000..afda463e28b1
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl {
+	struct device *dev;
+	spinlock_t lock;
+	struct clk *clk_apb;
+
+	void __iomem *base;
+	/* clock gate register */
+	u32 clk_reg_restore;
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 bit_width;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	bool rpm_enabled;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data vpublk_clk_dev_data[] = {
+	[IMX95_CLK_VPUBLK_WAVE] = {
+		.name = "vpublk_wave_vpu",
+		.parent_names = (const char *[]){ "vpu", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_ENC] = {
+		.name = "vpublk_jpeg_enc",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_DEC] = {
+		.name = "vpublk_jpeg_dec",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data vpublk_dev_data = {
+	.num_clks = IMX95_CLK_VPUBLK_END,
+	.clk_dev_data = vpublk_clk_dev_data,
+	.rpm_enabled = true,
+	.clk_reg_offset = 8,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data camblk_clk_dev_data[] = {
+	[IMX95_CLK_CAMBLK_CSI2_FOR0] = {
+		.name = "camblk_csi2_for0",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_CSI2_FOR1] = {
+		.name = "camblk_csi2_for1",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_AXI] = {
+		.name = "camblk_isp_axi",
+		.parent_names = (const char *[]){ "camaxi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_PIXEL] = {
+		.name = "camblk_isp_pixel",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 5,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP] = {
+		.name = "camblk_isp",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data camblk_dev_data = {
+	.num_clks = IMX95_CLK_CAMBLK_END,
+	.clk_dev_data = camblk_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 1,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_LVDS_CSR_END,
+	.clk_dev_data = lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
+		.name = "disp_engine0_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
+		.name = "disp_engine1_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_END,
+	.clk_dev_data = dispmix_csr_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_bc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	struct imx95_blk_ctl *bc;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int i, ret;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+	bc->dev = dev;
+	dev_set_drvdata(&pdev->dev, bc);
+
+	spin_lock_init(&bc->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->base = base;
+	bc->clk_apb = devm_clk_get(dev, NULL);
+	if (IS_ERR(bc->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(bc->clk_apb), "failed to get APB clock\n");
+
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret) {
+		dev_err(dev, "failed to enable apb clock: %d\n", ret);
+		return ret;
+	}
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return devm_of_platform_populate(dev);
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+				   GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_enable(&pdev->dev);
+
+	clk_hw_data->num = bc_data->num_clks;
+	hws = clk_hw_data->hws;
+
+	for (i = 0; i < bc_data->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+		void __iomem *reg = base + data->reg;
+
+		if (data->type == CLK_MUX) {
+			hws[i] = clk_hw_register_mux(dev, data->name, data->parent_names,
+						     data->num_parents, data->flags, reg,
+						     data->bit_idx, data->bit_width,
+						     data->flags2, &bc->lock);
+		} else if (data->type == CLK_DIVIDER) {
+			hws[i] = clk_hw_register_divider(dev, data->name, data->parent_names[0],
+							 data->flags, reg, data->bit_idx,
+							 data->bit_width, data->flags2, &bc->lock);
+		} else {
+			hws[i] = clk_hw_register_gate(dev, data->name, data->parent_names[0],
+						      data->flags, reg, data->bit_idx,
+						      data->flags2, &bc->lock);
+		}
+		if (IS_ERR(hws[i])) {
+			ret = PTR_ERR(hws[i]);
+			dev_err(dev, "failed to register: %s:%d\n", data->name, ret);
+			goto cleanup;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret)
+		goto cleanup;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		of_clk_del_provider(dev->of_node);
+		goto cleanup;
+	}
+
+	if (pm_runtime_enabled(bc->dev))
+		clk_disable_unprepare(bc->clk_apb);
+
+	return 0;
+
+cleanup:
+	for (i = 0; i < bc_data->num_clks; i++) {
+		if (IS_ERR_OR_NULL(hws[i]))
+			continue;
+		clk_hw_unregister(hws[i]);
+	}
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int imx95_bc_runtime_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(bc->clk_apb);
+	return 0;
+}
+
+static int imx95_bc_runtime_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(bc->clk_apb);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int imx95_bc_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	int ret;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	if (bc_data->rpm_enabled) {
+		ret = pm_runtime_get_sync(bc->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(bc->dev);
+			return ret;
+		}
+	}
+
+	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+
+	return 0;
+}
+
+static int imx95_bc_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_put(bc->dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx95_bc_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx95_bc_runtime_suspend, imx95_bc_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(imx95_bc_suspend, imx95_bc_resume)
+};
+
+static const struct of_device_id imx95_bc_of_match[] = {
+	{ .compatible = "nxp,imx95-camera-csr", .data = &camblk_dev_data },
+	{ .compatible = "nxp,imx95-display-master-csr", },
+	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
+	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
+
+static struct platform_driver imx95_bc_driver = {
+	.probe = imx95_bc_probe,
+	.driver = {
+		.name = "imx95-blk-ctl",
+		.of_match_table = of_match_ptr(imx95_bc_of_match),
+		.pm = &imx95_bc_pm_ops,
+	},
+};
+module_platform_driver(imx95_bc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX95 blk ctl driver");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_LICENSE("GPL");

-- 
2.37.1


