Return-Path: <linux-kernel+bounces-126679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7A893B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EEC281F58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6503FB17;
	Mon,  1 Apr 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gpJb6M/Z"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CA3F9FD;
	Mon,  1 Apr 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977646; cv=fail; b=bKnYG9gPJgp/1uxkVS/akVligaBF1jY+9fDLvCzOQkEDAZ3MBbxQAMdlEuFjRKkxRKjP7E7XsIrwlWMAxW50AzIjPzuqSC/L2Bbeoxma0Xt29AEzcAtLrCZBHpW0uRMEedkN5Q2Kfzo2gIhsGBSYMyxzkUOZLzcXNOx4L390FcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977646; c=relaxed/simple;
	bh=uKars9QeWZOCGMweRl8L+tN290XbFRYnGGKHP6MH480=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=am/RXZJiEKUZXcc5hAeez4pj2usVjpsWn7P35H+virPDzCD0oQMJlBAkOry6QXv8o03ow+mDa6H+s4b27TYAO4gpWjNgLiHs7g6aGfnDhoNkZmHNOLDoja88hM2mZZMoOAK8w3XibMKbF2Fj41N/m+Q7VMoN1jchzXkLWWzqJI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gpJb6M/Z; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4md2k6m7Lm6LVDP8WiPDcKlTIW50V0RTWUSmcDic+XRQkeDTkCc/guG++4YwB3dn5qgTChR5aBx8JD95RQMs6v4CNP8ZvsaSW2cDiKwgO/rQHMibz4kbFAPo3YbZfyd6fOR/YhM9KBPiHzTpK9y8xJR+qRDLrJBbvzyywWcbytf3yEejmjcCNe8GQKtN+zXmBqpL55H1gshmOA6mvbvDx4svBLsgTX1C2Cjrm7uuD7P4AnxJKDWJwri33/O702xNzgpX819IL7B+//hAOQq6WNipus2XbIkrhS6alowJlWXJrDgehpi5QnIL9D/+xl2l5yBO8ObP9yzNOJMF4lCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fB2552dozNz7oolfBN8GOavrG4RGRY+wnbzvnVytu4E=;
 b=ImGo2RkCkWlMP5nPUMpO7E7azeMpKfbH2OA0CM8RooFGQUhDwKonSpWqiY048Z4W+Vo+znmvdabtT2b/P2D8g6tYFOo7ZYBySS6VUmC4/bg0u/5+FiAo0cJG4JnrcC8sRPZXJwQb+6DRNBG0LQ3/3q7Pb3CbIoagrtlfKqlRs6Q6lIoctv+KhkCvftIw6PDTPE23TmacFehZQ8VcpAfC95yOCWjKG5c8A1sFGnuz8sZCg1kz4P7qkn8EZ4/xlL1G4lWQ9gjDC3Rli1xIXviLpc8++fV+KeXm20zgaGf4v69iDP7yJaZEZ/1ggIHl4PMU8uUgNLD9fwJ5WtTUwz7/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB2552dozNz7oolfBN8GOavrG4RGRY+wnbzvnVytu4E=;
 b=gpJb6M/ZqaglQScoOo2CryJ26dsNAE5AO0F6S8k6bwSmdibOWEYzFi5F8Tm1oWa16v2vcM6ODPX/voNk7QLznmKg+INzDf1vdRhFuS3sBXw0p1N2AlnIu3wt1opUtClbGNHmD7n+GaC/CCrzx4V1MpFQ8tOsgRNbd3kZJNu5t0A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:20:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 13:20:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 01 Apr 2024 21:28:18 +0800
Subject: [PATCH v6 4/4] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-imx95-blk-ctl-v6-4-84d4eca1e759@nxp.com>
References: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
In-Reply-To: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711978117; l=13494;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xzv7F5B5CXm1dZs8nwLHMmANyW/2UzYOiOTIeUWzojA=;
 b=iwBthqUbA2XjKDMrLkUb86eUUZ9Slw5TBYrz+xaNG0ykqEXd1AXiYvtNywtEtLfo7Zn37kUYd
 AXt3wjelrnACCgKH8f/FE3huchuVnmyUpYUtFL4Y0Vo03kI0cuT3ne0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8766:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oNQP67R7+9VFloqohCVw3xO+PRLji1Vkn0tRldyJiWyVoSmG86Wqu2eCtc4GlVzry0ZAhPEYKFQyKhsh3Qq3EwoA/KkaEpZW9SE6Hgqd38VCOf27lvx7+Meic2XT1D38R/JYRGLf/DUbpIAFvoS4yQ366zV6mv/sBXfKX2mFrGXk7S2ROTd2ZcJh9qmWlhIQf8gohD0p5bzP7BWQE67P1aGZiSLbjTc5DS1Pk7zlxuKjyA6vnC5tLQg4CY/5PTzm4OvchJ6G7/SlK7yc1p+fPzKSBzxf7ALOs2cBaXT9nh5gu9jG6AurkKTL+hG4x62uAbEB5NJvPdxUtZ/RmvCbKePfW2Efq71lXUDcCcSYnzFz6S7namjLhx7hSXoIZMvUvW4NEzngkdoH6anUrtUripsAwXvdO3WxNg1twFiEAdi0fLbn+Vo27cH7sStqBz6TzX6ZedxFj9Q4GfogkpxGz90IM5ExRbkw06x7WwUYexsppn17kCqHe2hD8ewtIUP3B2R5aZkTzNU0XY32unBZr3o2thKu/cPXnQz5nQwYdIivSGNi5BoFBeYkL3DFn6dIeKLBpYXwQcdx8VZm7+rfyYxBmTIyLEBZWESMUFDZvVgKuEK5bX40xqERzV5wMsICkJWfrDcDYvpXoa9jPI1dEtQNqtFI1kbMeTYuLk9h46oBSvfxKs6bICZkamNjdh9W4T/O3KkUIsaSFdwXFu72uoNs3bM+PRpjjm6VTEQw97E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhPVnpLWDJqVEJiK29vckpIZ2JmWklTTm5jY3BNZTIxMnZiamFrc0VkUUdU?=
 =?utf-8?B?V0JGMjhxTHV0Z1BYVU02MWkwSnhoZEpjTSt4c2gxUzlFak9EaUFkRitBcnFK?=
 =?utf-8?B?d3lRTVlYVVNFTlQ0aS84Z3RhdVdYL1BxNEhDUWdDMmhZZktmSm85dU5QOXNx?=
 =?utf-8?B?bEtxNlFrTlptQ0s1cE8yQ1RhcmJtS0JwekNtQ1NxMnJ5YW93akpGZFU3NnJR?=
 =?utf-8?B?cWVxWlB1b3NybFhNZEFxdWk4SU9ZNXhYLzBobVo1bUZBNDJiZEpHdXp1M3NU?=
 =?utf-8?B?dnczNUxJNWtHcGc3Ryt1YTJuaktmeTEvOEV1UEJXKzJNS2t3TFhYUHdRUzJa?=
 =?utf-8?B?cVhGdVllV0FSa0NFWEJWY2pzREd1dnJMNE9SWEFITnQ5OGRMWHBwcml4RjI1?=
 =?utf-8?B?M3R1OXJDdVRIRmpXbjU3WkowTGluKytpMmMrY1kzYndNQzQvTTc3QnkwaXM0?=
 =?utf-8?B?Yk5BTVUyNWJ0YjlXdnpsVVZJWEszZ1F2bHNaWmlhLzZuaDJmdmVmaWJCSDVx?=
 =?utf-8?B?aGVEeFNZOXFPM1VvRjlTZWhBSkU0QzRvcXQvR01CYlFGWXlVYlY0VVNaMTlJ?=
 =?utf-8?B?bHlQZGRaOGVxVTVmQTBqakxGbFBtZi9NWXI1elgrUnhNcE02T0QzY242TFIz?=
 =?utf-8?B?U0xvckRJR3hWeU1YL1RmY3ZTR3pxYkcrWDNHZEZlcUdYclF0Q3I2OHBCeVd2?=
 =?utf-8?B?SXlScDVtS2VDWFFiQjF3Q2ZWN2laY0Vtd1dvY1dwM3d2TFBxWmNYbXAvaWdv?=
 =?utf-8?B?My9pZStPRjNqNFRYeGRKK3VhbUV5QjUxUllTcDNicmgrQTNpUW1CcUY4UFM3?=
 =?utf-8?B?NysweUh6OWFCd0ZURXBWdkJRSlNMV3RNREs4NGY0QjVYK3VKRmxZUUkwQUtm?=
 =?utf-8?B?VHQ0WVMyaTFRZm9ENXRFT1BjSDYrMEVlMDNOWG9jUGF0R3lYdW1UcjVZVW00?=
 =?utf-8?B?VlJTdG15UGpyZTZ5WG11ZjlpTWtBUnJ5a3k4aExTdTEvRm1RcUtyOHVHSFQ3?=
 =?utf-8?B?Z3h2NkdBN05aZFlsUFpiS0g4MWRIZnRxTUd2N1lYaE1OaCs2SnMxc2hUYTB5?=
 =?utf-8?B?Q0d0Wkt3U3F3NDZpWTZmcDRJcTFkMDZYVFBZdjYzeU5LK0xLRWdFejlwZitw?=
 =?utf-8?B?VitCQlhqdUhoQXZXZVJycmQ4enVBd2pVcFI3L0swY00xSDdsRi9Gb2ZIR2Rs?=
 =?utf-8?B?amU3eXpNc2ZCVG1FYWExc2lrZlBmQzBjSmYzN3dnVTdzaW83cXpFMmZKbFRE?=
 =?utf-8?B?djlobWNReC9EdzFIRC9JZDdjK095Zy9vRlF4L0pNSEljQzBDWUNRM1JCOG5Y?=
 =?utf-8?B?RnF5ay9ZNEh2SUs2SnFMdE5IVUNpSGFzNW5tbXNMM3hSZjRiK3BUSEJVM1ht?=
 =?utf-8?B?TUJIRndjWldFbWdodUdCZmpHYUZYWThiaEJ3WUx3SVBmTlRzMS8wcDFEa3JL?=
 =?utf-8?B?Y20xNFdvMmp0S29xMytiNjh0dU4wblh4bTIzL2FDU1FJS0hvelJ6TjZJb2Zi?=
 =?utf-8?B?QmxpaHh1R2J4MnM2S3BZcmQrNnJvTDRKeVdWOWsrZzRpUGNZMjVIS2JIaWJ2?=
 =?utf-8?B?ZEtRWEszcUlSaThQQVNYYWlQT1VEQzVGSEhaSWoxZWNuTHN1MFhWT2ExaDBn?=
 =?utf-8?B?eHFGclpWRHpyRmF6R2I1WngwMVNXRWxIL2pMeGFSYlNtVVNNUXRqSzVHQTZS?=
 =?utf-8?B?eTB5SklMNUl3OEhiTk1KazNzUVhjcHFlcERvN2ZUbENPTFByUythMmlXaEF6?=
 =?utf-8?B?dGdqNCs5aExOcGFzck1vdHNNVDRjcFNLbUVpdXd5WXN5aVl1WXVSOFpHbk1t?=
 =?utf-8?B?allMcGpWME1MQmJxYlVVVkRURDlnVVlrelJtNzRWNnQzQ1RmNmpEVzhORi9R?=
 =?utf-8?B?WHRmMzhEK0gydktpeU9hZVZtSU9yYU1uc1JXMGVuaEtNZC9iVFZUaVd3em9u?=
 =?utf-8?B?R1N3QkRGYUk1K3hxdFRqMUxYSUJUMCtTQ1NqWnJxU0V2elM2N1c2MThISnpI?=
 =?utf-8?B?MUtMRU8yeWNwMUsrZHAzSXI5bjVKY244VlFaaEpleTFGNHc5YStjVGtwbEtr?=
 =?utf-8?B?K1pmc2JWSkNnNG9OVmFDS0p5RE80bkNHRTF5YXJkNDJxcjUvS2M4TExTMDFz?=
 =?utf-8?Q?RchLR3IgsKvEPytJ0+KGA1+5/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324bb192-7bc7-4436-2da6-08dc524e87c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:20:41.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoazbPYRsFOvNVex++zxiZqza9wSMAdDHCXZ/XMB9cFR/0TITXJ6pdze/HNlL6bhyhj58L2G5FW/rH9XT/jn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

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
index 000000000000..74f595f9e5e3
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
+	.num_clks = ARRAY_SIZE(vpublk_clk_dev_data),
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
+	.num_clks = ARRAY_SIZE(camblk_clk_dev_data),
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
+	.num_clks = ARRAY_SIZE(lvds_clk_dev_data),
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
+	.num_clks = ARRAY_SIZE(dispmix_csr_clk_dev_data),
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
+		.of_match_table = imx95_bc_of_match,
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


