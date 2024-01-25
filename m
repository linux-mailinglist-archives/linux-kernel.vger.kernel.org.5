Return-Path: <linux-kernel+bounces-38477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53583C074
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FB297797
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972085FEF6;
	Thu, 25 Jan 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XZN0xj34"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E75FEE3;
	Thu, 25 Jan 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180747; cv=fail; b=eRtG8renNyrn6cMvtP2Sfn/b9leY0VfbgV/0l6A4Dfe+0dd3U0Eb+T/tqQMWhX3JiLRoPu8wf/Bqv+XQJdwPV2M7LJ6MUvMdTTYCVUhLXLrCWaVEBPlq7Ny7y4ZD75dwp2YBghy6yH/5mEmzFZRKo/Vp1+b/PtmWv6bDtP7cbgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180747; c=relaxed/simple;
	bh=lxusFRPnENHR2KAqamX0aWHdgg93LfYvJoapBJPdPl8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ERo39ByK7jEGOXXriPNEP5IR8K74MoQ5+x1C2oXjM2/61ckwl3rNxloATNIbQfzGCpyn8zhfZNLNkuRdpU7YTZ8RWPn4SQYf1ZJdZetajKa2idiRAT7whEAm5kzCDizMv611qglLExtQcKO3s/0T0q7XqW+gaV/ioTVV1q3ziDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XZN0xj34; arc=fail smtp.client-ip=40.107.14.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C84lg08fhkgsO5OeRHzjtAOxv7ov4HyuY8TlFDDhDSJTtmfHJxBMiSARI6jmfZq9Iy0xVPefPvKDxAB1oHCSBqOFJr+sODbVydZCGJSOgPPJwL9/wpOyYL78HnElOyxsjrkLe0HQbnS6P56geBUVwVttcL6hzgXlWaZcLSWmGoD9UUy2XKt5wc5gK2FKuUaa7YvX2T9/rqByYl1cqJ00xvWSebVMdSiFPkKJ19aQjJL6gO5xrBurjFLP1KKL+e7yJmkiTa19UtXl3sRxXFu61XABqN3SYX01rO6aMdJaDcnJ/U4m5Dki64sY4aM++KhoArvBu6SAesw0sV8pP178pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWwGLQogleAHAp03QiCYcNmz77yayBGa4AxJXmlI5Q0=;
 b=jby5FDyblc/RcfRS2m0vdQQxr9AJbNQMy8jNelYVnhZ72f7hoRKxfGOP8Y/IyFvKmiHYhkzM36FVTGuYIC5W6v4b8k8elloNtAD5f0/ZqFIABArnB43Vil+gbR6m29YB6bIPw7EEgpOxx9P8QrtFAUoNcfNZ4QStmiAjZbMoXbkZEG4T5zJranPyHYfGby78Vl9IFBTSObP0xqa2DITLe1Qlo+AD1WQBccpSJDE2JsKjdik1CT1hynYhaJZHYVcHR89bNGJfN06ngk7aYv7/zaNtUOgSichV5PKeMuuCZ9yT5acml5T44YiHx56WJDbOtHxAC7jaCFEZqRk15RT3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWwGLQogleAHAp03QiCYcNmz77yayBGa4AxJXmlI5Q0=;
 b=XZN0xj34dtqLvx7kvNic3IyDIeCAh0qqg6/8sBuKbXKzjekI9kbFE7EUWUeXOXmoojewpax+xNgCF6TY3TjyZ30qY/yBWu7H259jzvs9QTCGOiyIwkGxJO/uM3Egb4/Kb+j0rWBeFAPeseCQwV/8zJncR73Uknol/AONFYfwR70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 11:05:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:05:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 19:09:48 +0800
Subject: [PATCH v2 2/3] clocksource/drivers/imx-sysctr: drop use global
 variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-sysctr-v2-2-7332470cd7ae@nxp.com>
References: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
In-Reply-To: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706180999; l=4759;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GNd7nn9IlMWOE6EtgMoRLuOvy3mCu2EVYjx6qUvMpbo=;
 b=dn1TEThnSRcjvftsi3iJdbkAzSukqL/cb2uLA4ObGSO5pOv0YwGAnL9daYSCbheeUkvEwZSU+
 JkrmfMb7E2VBcDGumZp1EuD/hye0V1ixPi7PHZ3lohRT7Hl0nzgVndf
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f1e9df-12a3-4207-9563-08dc1d959213
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	65D27arOJpganCZP8lOdCqJHgYNh/iPFiU43cEXcQdachQpNQ4uNCRsgyFZyFAJNemPiGGAOOOaLiJYW0Gwz+ps73MrBXYDry4fLekMmx7SNyZyQwOGjmzOyntBzFRKg8Ztxduv8LQ+0pFcOSMmNZKdiYBuHsAqKo5fJCeDj7mmkL40SsVjn3iFDXsiqnx+fWeM+xdBVsJva5JH29INwPFB2QyoILoZfFwJOyVSbZcnVhCc3iAOPzffA/MUiYaroGkxqSj+fEdchNm4RW7y0ouIiuWXin6iayDVufSK2C4FJSJBVn1jlFhYZZ07fIF4YSbnVApzDEBSsdzswpQwT/FKwfqCmdBFoJc1ngtSY0leu8POo5y55XBfJMzY0tKsq+jPPNvg7WKbhwbzKKS4/dbP8L9K8YcFgdjve8q02efdN9Jm91NU+KLdnQnsNA9nrjRgBhFgkbrp+4vrs2msNJ/TTlEoAKbbpqkp0fNR0OXvm8Uscs7WUVRgaAieC4ANsuFmhPfuhwVS8vFCNMKYx0Q9q+wu8x0uts2kAfBLl7hvhVbv2UTYHONkknjRVItivqtasxw32hJvj0pFo8T653OwJ6AVBzRp+b84H4u8of6Jklv+dx8IVyP7jb0cSVA4ap07xfh3BbuIJQRgfCvAGjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(2906002)(8936002)(110136005)(7416002)(66476007)(8676002)(5660300002)(66946007)(83380400001)(26005)(38350700005)(86362001)(36756003)(66556008)(316002)(921011)(52116002)(6486002)(9686003)(6512007)(6506007)(478600001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5uamNkeTNDU2QyR2xzSHdNOFZ4QnMrYURRbzFYS1pCY0crNHJGa3lKUUJl?=
 =?utf-8?B?QVpNckxWdTZ6aUxnNnhWbmJOLytSNDJGUkRuUHFSWUQ3U2FMNGpNcGFMQmxI?=
 =?utf-8?B?RVNzaGRyRjc0azdRQk5wWXNmZ1VMNnorWGhIZ0pXdm5JaFdYNmxud3ZpamI5?=
 =?utf-8?B?QStSVDMvZEkrdzBwZjhDRTlDYWw5eVFUTVJ3ckRMN3lHKzJnZXNBMURLd0lF?=
 =?utf-8?B?OXZlSm54bU0wNWhTdkw1QnY0R3BLTGFaYUdPM1ZqdmRVd3R0UjU1YmI4akxu?=
 =?utf-8?B?WVFjUTF3VXJuVzI1aW90TDJCYXBYODJPRmt4VFdsMnk5UEwwZU41RjhEUEll?=
 =?utf-8?B?T0FkUFFRREpMVkxFdE1HVE9hbndSdWs4emlOVFRZQTZ1dFNrSWdLbWxzM2NZ?=
 =?utf-8?B?Yk1YWXBlOVczSHJRUGRxTXZndENsSC80MmdVMlF5U3NEZGVLSlljL3I5VnZU?=
 =?utf-8?B?SVhFbkMwK2o4WkN6NiswZDRhZDZIVWdJVDBsOUVLRXozenNHRlNpWmRLT3pT?=
 =?utf-8?B?d3FZVE1WejBPVW9QclhBeXM1cUQzRi9ZZWdZb1lienAxRHRkYTFTRExnWUp1?=
 =?utf-8?B?dHFpMEU2aEpMN00vNmdaOVByTmUwMTJBQ2YvWm5Fd1k4enJ1aEhpeTJ5SjJY?=
 =?utf-8?B?NmZXV21rQkFsc3ErQUZYR0lhcDRlZzZ2YkFkcmNLUERVaHpyek1oUU4wQXo1?=
 =?utf-8?B?Uk5XQnVuS1h5Vkl0dXdwSDBQYTFSZHl3R1lyOFR0Q0laMlNkMVhEWmZUV1Az?=
 =?utf-8?B?Q0tmWXJMWjBGdmxsZnJCd1hxTGdrWEI0ajZTT256bHRRM1hpczlKd1VLNGtV?=
 =?utf-8?B?UEIwQXFHS3VZaDNlcWw0a3l4ZWMyRHp6cHpUZHdJeDR2QzhJQmNaUnM5Ungz?=
 =?utf-8?B?K2ZpNlpZUTZMeHVDS2RMeE44QVBBMGpjY1BSTmxqaGpmNDNYQ1d1dGJNd2Zq?=
 =?utf-8?B?OERUbG1rdzNDMGRrRUJZRkVLOFBWKzEySzRvcEdWekl0MlhtRTJRNGRnOEJF?=
 =?utf-8?B?SHJ3RTdnTHNmTDAwbEJTMlhBR0JMMVBQT29LWnhNbFlWL0JJVFB6T1lpSmFo?=
 =?utf-8?B?TzhIYjVWcFB1OHNmVXY5N1UzTjRpU1dxcWNPUStOdnhFMEIydEJVemp3Ly9U?=
 =?utf-8?B?b0kvY3pTeTdxUmlwRW00YU1veEgrYmJzaVlha29KSHB5M3pqeVVNQ2dlcmUz?=
 =?utf-8?B?clVqS1BGMFBYTjRZQVZzbEFvN1VWZCtOekc5MHZWeHpSbUpFa1lHZmdCbGVa?=
 =?utf-8?B?VlR4azJ3RU9QL2Y2eUZkdGdXeDV1aUs4ektGR1NSdjU5emlTMnF1MDZlSnpN?=
 =?utf-8?B?TTRYMkpQdWJ6eGtWNDZuRHRmckJHSkNnRXlieXRtN2Z2Z01MUUpYU1dSVnZN?=
 =?utf-8?B?dVJmV3VETzdUL2xNSStZNkpYenVxRmZLU3F5TDhESXIwMk40QzNBVm9vTmRP?=
 =?utf-8?B?QUVsbkhZc2ZTenRMZzBNK1RuR2RiOGpINW1ndnJIZFJIbDNJWktVakV1NEdS?=
 =?utf-8?B?UGlPQ2ZKV2RsOEdCZ2NsUno5QlIvQkUxNUZmaDU3RWhNeVVkdXdHK0oxWnc3?=
 =?utf-8?B?cU02dnFlNDd4cit1dUZyd0lTZkozSktEM3FaV0hUQ3IyY0Y5TU5nakczcWw1?=
 =?utf-8?B?MHFJc1pwY0Q3SWhZcGxyczBUMGp0bmZld2tEZ3JwcEtOR0I2UVpGUVU1M080?=
 =?utf-8?B?ZmlSSmFwbDNoTWlCclZ6VFlvMUk1eXAwZWtEVWVUVGJzcncrYTRvQm1uNXIz?=
 =?utf-8?B?RktjcjdYZnlIVGRBM2NYMzhjUjM5S1ZrTG8xVUxNRlZ3SFUxWG84di9HSzN5?=
 =?utf-8?B?S09rQkZTSlhHVmdyYlB6Z0swY28vSVUyQTFFNjdnOHhBZUhuQ0wwNWNQVFFO?=
 =?utf-8?B?c1NmRTVuazBNZTluUlN1Q1ZuMWdteU9VWjJCeW54Ym5ST0RHTjlLRTZyakpB?=
 =?utf-8?B?NFhRbXp5QlR4QzY5RzliTU5vNXo4RitteXN4YmhESDRsMmtIWVlmVldGR1dX?=
 =?utf-8?B?ZUZ6d21LbEdTWTFSV0lLMG5CRmZNTnRYWmY0N1JBc1p3b1M0Qnh0aUM5eGRD?=
 =?utf-8?B?RmtBSHhMbTFQN25KNmJQUjFFbWMrRHVBelZZN1B1dVpsQTN6aE5xYndIQ0ZI?=
 =?utf-8?Q?I+Gc/9xKmUTLJgTYFx3s1HlzO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f1e9df-12a3-4207-9563-08dc1d959213
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:05:41.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eLFqH0X0w3OKLt/iTYTvnVEYP3KxZVXELKiAb2URe0j7qYyg/jgKPeoG5BNrghEbAG3xzAct6ZOpi9t1o3DrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013

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


