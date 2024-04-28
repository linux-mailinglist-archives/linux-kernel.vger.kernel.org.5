Return-Path: <linux-kernel+bounces-161340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11F8B4AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8331AB2127B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6B54BED;
	Sun, 28 Apr 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LqKZuXh3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2046.outbound.protection.outlook.com [40.92.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BC33C8;
	Sun, 28 Apr 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714295875; cv=fail; b=fVNEcRjwgSspM9hGODSw319Uda0pf8PJ0qB2nu/R8KbofQhclW5yEykdah5g6KNztCcS9t2OG1577hbv6MRO6LWA1U3yBngQ7fsp9aaz3m+xkU1QQVBWMLRiwxlOOITvU2YoXwN57L1feVMFOeP8eBi7LDKimuQjCQmAW4eE64Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714295875; c=relaxed/simple;
	bh=IRIRa2UZls0FWfzts0BH4sQXW+M+hVrbotHHaUkLIRk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gnhztS7UzrAYuqssQuoZmcaHtDlaz+U0S+FAjzNI01HWkn1xZh2PjFjl447yWLIQrvEu/7LhiVm9P1xapHKHagLxGz2XFf5i0PwOLNQ3kSpeEek4Ud1a1ZQyoZr1DaSDSbBkd8sJ4XBvr3nGXdo6BYCfHDG52fME0wbjs1raLKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LqKZuXh3; arc=fail smtp.client-ip=40.92.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM2E8iiBb/0ZDmw9ggwo7eO0GgXwH1GPThrCfmw/29gmeywH59umVb4Em9GCVqRQZvV0Q7ShzH+T0aaKMMV5SAKYNwpMsdHgAsx5xjzAfy/vIpEakks2Zpy5AGwr2Q/sdBEBalTEN9vulNp96kpk0ARAEqZke4lxtmlYpTX++Wuc/176I69id1w2weolUtOWs2d2GU8kuTLTiWhZYJauoJ+RlbWvYVQhL8K3Q811hwsv7659E3RgmDZz9Is3eUhwre5aPzy3MyKqsH4AZAGejan48sfFX0XRGAfQ7w4qWQljHv+R4/5mb7HgFI33VW7YBQkpLQ95rNuWRYKjLryYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVgfvMCI/8UFp3WIhk676005RQilYEc4uHacvIfwnVM=;
 b=fdoV/VNZiz/M247kK7yaOTccVLuYMTgS08lCe6NhbRuPYm/ymA3DHkVA1R/vCuPceXUS6W54V3cMdCqQflZxB/lylKuTi/IX12tfKQUqwD+JFVNVCWp8l5Cs4Rlonpp104ByLu+JwECTipex9B6vT7PO0eGbw9VHEJbrnPhepgP6pthvN1UJ5ViJHog/aNVLmaLii8zl2/xpzg4UdXpmYIPQg0GnpJs7ceaWcbSHxWTemH+HbyoqYD9ImPqSXKWIJaDac4hLGxI/LSIoE+D/1R46250th8B92WCbdD53JJ7+nXBjaFOUeikifS3dgS1mlZVq+wvAZeH9xqIPKZX5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVgfvMCI/8UFp3WIhk676005RQilYEc4uHacvIfwnVM=;
 b=LqKZuXh3Z1CBMmkG6W39a483n82yVVwsgnHLFV1KnaZcwC6pJRKj1iFprjUWvlvgGKVofXzKUJYahyiSDf+xdw4rofdLOG7NPerHk9B07nWCAt80JV0OFTbDhKBGUTz7vaaawhb3QN7k9yJGYlviOrt3SXAcUYTOwC0ePJUUZJ0TjDH5FwdA4vNqisV0qeUwFcgOhf41R/GK7T36NHZHmkSYJNFsFkWlGiyw4WBxIeNXrrV6xIjsvngQKZwojDcvYMNWu6umJsXtZc9KKTsO/naXwZzpTT0SS95tXno5oMxa1LHvSDE4fX8IXrBhQs0nrUzEA6hRk9ClUndB7xzfBg==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by OSQPR04MB7825.apcprd04.prod.outlook.com (2603:1096:604:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 09:17:48 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::e19a:45cb:fc9e:b6af]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::e19a:45cb:fc9e:b6af%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 09:17:48 +0000
From: Enlin Mu <enlin.mu@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	inux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org,
	enlin.mu@unisoc.com,
	enlinmu@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] clocksource/drivers/rda: Add sched_clock_register   for RDA8810PL SoC
Date: Sun, 28 Apr 2024 10:17:38 +0100
Message-ID:
 <TYSPR04MB7084133A983DD3EBE69F4A808A142@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [EAJzKbQU0+HBTwNCpRU+dw9hd+SU/smIHi0P79kYqqduwmXj6WS1Rch56LuI7FV+UdJYuC78j6Y=]
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To TYSPR04MB7084.apcprd04.prod.outlook.com
 (2603:1096:400:47a::10)
X-Microsoft-Original-Message-ID: <20240428091738.9838-1-enlin.mu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|OSQPR04MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 683bdf06-15b4-4db2-9d14-08dc676411ea
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	YiXAS5iG0Um+8iWv2hsBarjKOx2snVIEdPEDZd6GsyTrUWNw+XA+cxfpqn953rgybTwvSLw9DhBL8XAG1hNKhMQRzuf/FfZ5PfBg4CIB/l5g96t+y9vwQEuVUlaRnvj7pPE8mpM0pA3vf2clxydorc9x7+QKkvtcRIu0IuHEH044QUKp2NzEV3wb0GEHJYjRhF8EGI+Pq0uFt6KXT9gOdlS7a967kZR4OCTikq/kbx4Z82im0GXBUOCVOxPGO/zRwVlJhtNIR5z7t2YxmPk07kIksZTbHIy8o4L3f47aMbKRsb491RKpz3PN9af1pYeS5Nqt8PRny9s1DTsePC3e7QffgqzjrrCGF01r4e5kaoSxwAwk4V/ZCDlltbWAUaSi4O9he2P2bwwqURjm3v7C9sJCqHVj8epADBfnxqhwbqZN084A+8kCJw3dSsUbNoYCOxsvjq8brJ8hXp8wgEaJW8OPB+4igIzu5tSjwWqFTIPstdl4wyPGU3hgp2zEZB5KwBtnwzC3LSwSD/M57aehyFZ5C2BYlj6Yw8866DJFWFIUdMUaK0611PVqrznXiJDD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVMyneIiW+xX8GyQIUBPdoGl5J75XmxGRg6rp9KovZH7MmOnCWUi4YiezZqh?=
 =?us-ascii?Q?89Rsu4Pu4CYTNG0M5FB9fpV4XxFTVoa5CkCgl93530lK+4su/4O7hhWyhhlH?=
 =?us-ascii?Q?EFJz3cJ+1CKQcHfK1YImLgvcdd32lkGTab7ZzoQCt5yW9JpxUvm5hMGY+pzQ?=
 =?us-ascii?Q?9UvCusBT9n+CPik7V0m3a2jFsJBFuhzqxnI4Dap96r7iFPXOAgt5fT3tCESY?=
 =?us-ascii?Q?9t6l7a07wqKtfG7fY7FkzyEBSaK5Ykd2eGKAQQtEHtChrXb49GiKMtOdwujE?=
 =?us-ascii?Q?vGszKyPA/q89/J8ZYG/qdOBbeEYu2KnzgW+SrAeRIYQPdACAwIPGSI+8JCSL?=
 =?us-ascii?Q?wfXcF9i2AOTtjvmhyZbuZH47vX+4kLjM0R2a4uUU4YW9pDPmg9s5tJhnqPnu?=
 =?us-ascii?Q?Bvi992rQSHbpCCbeBDUax+RMt+GwJvJeXHdZTYW3JZVrM16VtPiPGJCDD0pY?=
 =?us-ascii?Q?bNjovMBdmxMz7m+W1IfrN2A6YYWdamc4Ot3ac0Np/7YZE4LKUPwS+il/c6wy?=
 =?us-ascii?Q?JCbVafvHrbazc2BMXi+VrjmNnakqboEVk8URlhNGAkmhpS6sBCpvpZnzr1ox?=
 =?us-ascii?Q?cEeTBBPG3OFawcyNZ+aYSUK33TwASQQ/vTBC9YxWz+aXQBUt3sri15G/TQP9?=
 =?us-ascii?Q?WCQd1XCJur6mxHh3ywcx9mAxtcqj+2tQdHb8z1lJO/0VMHG7XK5pxzZW1031?=
 =?us-ascii?Q?zZiv1Y8a4oNZcJFsC9OAIIZBJKpDGTgC/IrBEA8hqZVtuOe1PtTTbBsYNxD6?=
 =?us-ascii?Q?LkUSC7PKq1pjI4yrmmbV9MIBzNpV6YgaGwIpfyFFYdPAQ3RlbYFA/lBpcklz?=
 =?us-ascii?Q?FcCHR0R8G93ynip0ROpxUn8CsFzVH+2Di2rLI/VBHEnXWR1fLnw9h1Y5wq4u?=
 =?us-ascii?Q?BMuOM7iBIqOJLQEgZrdi3mQp5bjj2YnR4BWKmkho5BCFje4XpO+d+UgFkGTo?=
 =?us-ascii?Q?fkzOmDJv1tcBik4zeBGZ8kxDHZ7I7gYZuOztWz4BVNhG3adPyMh5K6lsujVV?=
 =?us-ascii?Q?owrbkh7VRdtE92/k1aS1i5VC0/8Kw1MnNtGIm3pHIdk/OGYiV+XzQ0l4OvZY?=
 =?us-ascii?Q?mmAJr3xvyns2AT4m+gvmFCl+A5Tkgym+yXkn9oFFxH1eAoT5fTe6ZEThet9+?=
 =?us-ascii?Q?fKMZEBGukU1pTlhdGhP+GyKaD7Yb38g2Vzd6Gd6dC0T+NUTGeAWC90pBS1W4?=
 =?us-ascii?Q?FwW7fAHqdC0LP9PhVfVp2yBu7adjpxndR64dhslFW/FV50zi2T7XLBTKdtlc?=
 =?us-ascii?Q?TcA6RriuUcEwhLwK+fnkigBBKokiFvM4kibBqGXO0mwq7VPGWeQ+0Q+UEraz?=
 =?us-ascii?Q?t08s6T5yj9/Pk6eYJDT7Dwbrf838kRgHtTmSfJm7zeE85Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683bdf06-15b4-4db2-9d14-08dc676411ea
X-MS-Exchange-CrossTenant-AuthSource: TYSPR04MB7084.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:17:47.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7825

From: Enlin Mu <enlin.mu@unisoc.com>

Add sched_clock_register  during init
bootup log before this patch:
[    8.044000] UBIFS (ubi0:4): Mounting in unauthenticated mode
[    8.044000] UBIFS error (ubi0:4 pid 176): ubifs_read_superblock: bad superblock, error 4
[    8.048000]  magic          0x6101831
[    8.048000]  crc            0x68cacdd8

bootup log after this patch:
[    8.131116] UBIFS (ubi0:4): Mounting in unauthenticated mode
[    8.132096] UBIFS error (ubi0:4 pid 176): ubifs_read_superblock: bad superblock, error 4
[    8.133352]  magic          0x6101831
[    8.133905]  crc            0x68cacdd8

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 drivers/clocksource/timer-rda.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
index fd1199c189bf..0be8e05970e2 100644
--- a/drivers/clocksource/timer-rda.c
+++ b/drivers/clocksource/timer-rda.c
@@ -13,6 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/sched_clock.h>
 
 #include "timer-of.h"
 
@@ -153,7 +154,7 @@ static struct timer_of rda_ostimer_of = {
 	},
 };
 
-static u64 rda_hwtimer_read(struct clocksource *cs)
+static u64 rda_hwtimer_clocksource_read(void)
 {
 	void __iomem *base = timer_of_base(&rda_ostimer_of);
 	u32 lo, hi;
@@ -167,6 +168,11 @@ static u64 rda_hwtimer_read(struct clocksource *cs)
 	return ((u64)hi << 32) | lo;
 }
 
+static u64 rda_hwtimer_read(struct clocksource *cs)
+{
+	return rda_hwtimer_clocksource_read();
+}
+
 static struct clocksource rda_hwtimer_clocksource = {
 	.name           = "rda-timer",
 	.rating         = 400,
@@ -185,6 +191,7 @@ static int __init rda_timer_init(struct device_node *np)
 		return ret;
 
 	clocksource_register_hz(&rda_hwtimer_clocksource, rate);
+	sched_clock_register(rda_hwtimer_clocksource_read, 64, rate);
 
 	clockevents_config_and_register(&rda_ostimer_of.clkevt, rate,
 					0x2, UINT_MAX);
-- 
2.39.2


