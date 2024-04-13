Return-Path: <linux-kernel+bounces-143504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B38A3A45
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685771F2279A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227513ADA;
	Sat, 13 Apr 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="hpYsdouy"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C610A19
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973269; cv=fail; b=tvuLG4aXefYmbjYQsD0dBPjO45g1fcai2ebKVHbweAfuPdED/4GyDVphqflRIcSeOwuI9qDXpYpE/uyrHN3Vux8A1laHJSIzPypZHAPoo3Z9V4uz52q7mUeHoYkp9mAlhfp3HV/B4/cOktzO5VNxhcWTr8bk7BxTCiBT22ry2Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973269; c=relaxed/simple;
	bh=LjeQGiwkrVkqgxirDEiM2UAn/FsoGcCoHBjgzCqsOco=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VGyRSQOeWPJiVBmo0MiX6BZhBmv2Cj/oc4KAn/s1lIQDzBBDU5JZE0m0xiZXAhM1/unShi43QF1HDxZ24KcG/6fEjWT7huoSJiQyBn5HmOsaMuDRaj2MeNH6DzWnnkBrhSjZ3WmThNhcbkSS3EKkesozg0RugKiZX47WJbvHpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=hpYsdouy; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXL65s7F53wdO2jwUs7+cVrZPjDzL+TT+n201xUV9PHRR/vXWXa8FScRKQ+xVDujkmoFdwqaUxnpGABNNbUj1KevcUbKXfAv/Y1AN9qyzRJ3oUvRyDUIWlwcsSSiqbVlmi8cd2NvWfEsn+kQ0uWF0lotOQZb8QOXeF/6YgNCoKjP3hWZRHhrATTA7McJY3A4ekbUGtSXxEoOLL0oXSYRmJGK2pwGc+epDe2czXcjHwXqH35q15o3qxFPJmm4/yLdqTn6O7TI8FulNFJOe7mZ9k5FPSE3Q6gDwuXWs15QMimTkC8pqnRKJVgnG9Ft3r+RmBoihkRaLVGnZgXu1YcEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoOqGlUky+dfhm8Lfwlb/S6UsR4rw5eDoLwrsZdAdCg=;
 b=a5MgdP2lXt8vdBGnBwmzgVzwabrH67L/aUsoZYWxvk9/nvRpE0OL5G+V/pB/kWrSjbvKatyBUCBxIk4qtz50VP4meQeU60uEVqQ+xmW1niQnhRg0xugtHAMuvmI27MijgDRhjy3pOxluzvNNiE3AZVZLzHYBYejF4kG2iIhHbZ3OB8KR4VEEMRvY/Ow2duickAJQONxsphpi5cJ/aPqZEMJ2bYzknN5UV5cLxLCUiJ3iD+gGpsaXuFjOiAeUIYBp/hiBbA+WUVU6fIVzYhmpNYehksXxtuaMK9YLz//hV58m266Iis91AGPzYmxd8k6989ddgo2dGzX8shtHphmc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoOqGlUky+dfhm8Lfwlb/S6UsR4rw5eDoLwrsZdAdCg=;
 b=hpYsdouyyzqNYdJGsEnXJz3mzHqklNMCenB9bETvZA+iPTxwsMbEK+3BwPbiPJ8rnkU6lWGfuaH5pSv0hhbZ6e+j9xFbIPCRN2+8KE0F2zyZziqY3z1nTCcrRpcP/uSEBHTndnKs67ToLT5P98wrPs1Iw+OacRK4xZtyWS9w0s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEYPR02MB5632.apcprd02.prod.outlook.com (2603:1096:101:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 01:54:23 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%5]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 01:54:21 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	21cnbao@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
Date: Sat, 13 Apr 2024 09:54:10 +0800
Message-Id: <20240413015410.30951-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SEYPR02MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 281291fe-d430-4854-243e-08dc5b5ca303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RZaZD2lTgOnGaeWRgTAS/iUcTTRWW3qNbVOq/elRoNVz0SC4CQaoQgyC8eaQxy0RJf+UeLGWGFw2nWlIuAc1fr3rsISbhxe8SUCFB4KVIlft5wC0vIme0kRBl646/y3+4acAZWxA7sUnl0QeFHNfM0GcA9+2Z1KY+UUvy+lobxNrM/hLFZ47lSkq/gGb2nf61YwFVM6I4rNDUX2fVQYCHtLbWR0d3mgQnaVOC8BPRwCIWPLg0CYcYGukYbv5Y/zakCOexJ3p8Ms9u1aQX2sFLuJIUAnLwmlub6Z9pX+Mwvf9eKbFOev/5ZhTHk/L/hho66H1aa1KA38Gh3CZN2doIeGFodLNJVjaCWbTcpk8BmhcR/e6bKS6e2Xo0bUmxKsk0pzRcc8i4uSbY9mVnbDB19ijX+n2BbZX+x2Z858/Yr6JlwWxSRg6VcvymLpzrC3HDdCozmNsXHwS2z9ZlhthPRGg8ks/5xSoUlEsLkVSEXDmSXYrzEuiHAoY2zOZ9cX4WdoaiDcqDFim9CD69DRC+ez03zrk52uP45xIGifFz4Eb+EmVVE8DLSXfb/b8h5F/Nspg3oWxo9RE/l7f7UIxQQA9bDJ2RnFgoQxeip3fdIF0n2qytt6J8o6J+l+X6z/MuECaBQ5lreAvf6UJwa1grihOSyAsuWGYMFPz0b9H4Wv8892FEym1Azw6AFGZWbn8kyDrOjZNIV2JmaMP5W3UZqF/3b5YLwYw6ZnJCCe60KU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSToP8hThWN0HWkrxizNqRUKtvXbnnrOAbAaulDoYbfLGHqTcQcJoIayvzGZ?=
 =?us-ascii?Q?QGOqKy5brSYgfYb8c/JChGan/b8KJsQk5Ln5hL7O2DE8/CUlDepxOdDcaeiL?=
 =?us-ascii?Q?Xks8ZIi0c3j3z0EH+PVgidd0B4mzvziJOwNib7eW8og0IGEy6yE2zI5PDtDS?=
 =?us-ascii?Q?/Yh0R1s/wvEmr0X8vLbYMHidQ+SUl438aNC4yJ/mxcxK3FA2Hl0tcpT347qn?=
 =?us-ascii?Q?sHTrh9ChG0yiPcSI4bxoBFau+aF/y/6p9uMk/fqNCGXssYMJh0SEdDwrKI+E?=
 =?us-ascii?Q?j/geyRp0Tg36GH3Mb4KOYKZ9zKg/pdWXWCYTfLI2WNjeDv3815Y6Q0ZGq9eB?=
 =?us-ascii?Q?ILGEFFsDYzsYx+Bp6b67E6EvFTkiQdfRZOVmX5Hd2GYKUUyjldkedk9MKLEo?=
 =?us-ascii?Q?cjPKFRIns+ziU95hI2AAgUqCOvArflsARxZsLLcF1OW4661MqWgxRWoEI7Y3?=
 =?us-ascii?Q?Ix5CpuhD/n8j7DjhojntabA7i2R3lJRwOI2rW2GfK5n44JIMSQe+Ne/r/Wiy?=
 =?us-ascii?Q?bwE3oi+dXXqAmq9Wfh3A3hUdwd8nk+7T1QjqcxkPUP5d+922yEIgHfdyoMNb?=
 =?us-ascii?Q?/kodXqECvavnBMtC3t75NcduXEIiid5uVVD1QH8XuzcFy6ZM0E8PY3nWrIqH?=
 =?us-ascii?Q?sDTrW176z9rnlQc9woMcunBXFZMQ57Dxkhf34LAjW2q1D3ucAESSVrxIqTOQ?=
 =?us-ascii?Q?7ibWeNoHAclCk46L1k26nOuaB0t9uhpHYzzEhW/toOcfLXVPyxdASw6PvDN7?=
 =?us-ascii?Q?5QLcwz02zKmiLcPSzr7tcFY2VrJnzeJzenuOSQmtEaFgP2orLQrsM3dybnF8?=
 =?us-ascii?Q?Q7koSocf4W4MaM8H81T0oFn+WrvLJQagIIFmPIKJo2+RcgR2gaEMbG1v7blC?=
 =?us-ascii?Q?nyn7apv5LR0tqJR7MaR8aGEkDFX6b+15lvXFAKqPjsWHuKaUB31vXkc/W/2H?=
 =?us-ascii?Q?/zQCkvsZWprPymiB1PHgbgRiaZHkiQ9Q9yvyUjWuJMTbd3Qo/l9KKDF2Kzx0?=
 =?us-ascii?Q?Y+kcScNcpcT3MWvsowuETO/+D/MVw9CCNf+y3SzynNypbaSNyUKrIJ0Uj2h9?=
 =?us-ascii?Q?q9YTDqo/6qLBiAIU/ZxtwkAwIboM8o6vlhXE+0YpWLS2HQ2U2nyQDDPsN/Cs?=
 =?us-ascii?Q?xbZUGlx4RV6CiG60Ylp+YLi0MPomx8HELEtRzEgg2KOCunUv6iCSV3kfDGdV?=
 =?us-ascii?Q?rX/9eQU6jn1ABGQTrdUrBcleJwIbrjuOvY6nkHNOS4UiMRBX5Shu5PTJbSxZ?=
 =?us-ascii?Q?pjzZspLNiuW3KHvhVfHor7paj0S87pixfHiGZLopol81gt74j9OZFvSfqCsg?=
 =?us-ascii?Q?rgclfJgMARcInHBbCsq/uFY1xLDgYPhhkjkWVNRS9q4lh3WUyPSi+4mwhu9G?=
 =?us-ascii?Q?dZjOiAsxokuI6ZJYa77v6kxffCKXA0I3lO96K5l6gTDGysKkuxC55VS45il9?=
 =?us-ascii?Q?BfpUpvQNUmyfLlZkB0EgJ/cEQ7G6lpJ6yZ1MyWIxYGGcMUsM/UIakrcFuSj3?=
 =?us-ascii?Q?FyDieOkhpW0xuuxC4ghoCMXL+a+ewO7fSK53LHOPxcuRK18PZMXq4PCkSzsr?=
 =?us-ascii?Q?6cfC8yE3eYV8SZX4Z8oYG8Wngo4vkXXEMN6RsQRg?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281291fe-d430-4854-243e-08dc5b5ca303
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 01:54:21.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjBzoSgEeSdZHlp5G+4Ks+koat92wl/IEnR+wnndGz2bEqUy6X/X52OOYXiFREqSG+mjqkFDz906r4c1MtbcEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5632

From: Peifeng Li <lipeifeng@oppo.com>

In the case of insufficient memory, threads will be in direct_reclaim to
reclaim memory, direct_reclaim will call shrink_slab to run sequentially
each shrinker callback. If there is a lock-contention in the shrinker
callback,such as spinlock,mutex_lock and so on, threads may be likely to
be stuck in direct_reclaim for a long time, even if the memfree has reached
the high watermarks of the zone, resulting in poor performance of threads.

Example 1: shrinker callback may wait for spinlock
static unsigned long mb_cache_shrink(struct mb_cache *cache,
                                     unsigned long nr_to_scan)
{
        struct mb_cache_entry *entry;
        unsigned long shrunk = 0;

        spin_lock(&cache->c_list_lock);
        while (nr_to_scan-- && !list_empty(&cache->c_list)) {
                entry = list_first_entry(&cache->c_list,
                                         struct mb_cache_entry, e_list);
                if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
                    atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
                        clear_bit(MBE_REFERENCED_B, &entry->e_flags);
                        list_move_tail(&entry->e_list, &cache->c_list);
                        continue;
                }
                list_del_init(&entry->e_list);
                cache->c_entry_count--;
                spin_unlock(&cache->c_list_lock);
                __mb_cache_entry_free(cache, entry);
                shrunk++;
                cond_resched();
                spin_lock(&cache->c_list_lock);
        }
        spin_unlock(&cache->c_list_lock);

        return shrunk;
}
Example 2: shrinker callback may wait for mutex lock
static
unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker *s,
		struct shrink_control *sc)
{
	struct kbase_context *kctx;
	struct kbase_mem_phy_alloc *alloc;
	struct kbase_mem_phy_alloc *tmp;
	unsigned long freed = 0;

	kctx = container_of(s, struct kbase_context, reclaim);

	// MTK add to prevent false alarm
	lockdep_off();

	mutex_lock(&kctx->jit_evict_lock);

	list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, evict_node) {
		int err;

		err = kbase_mem_shrink_gpu_mapping(kctx, alloc->reg,
				0, alloc->nents);
		if (err != 0) {
			freed = -1;
			goto out_unlock;
		}

		alloc->evicted = alloc->nents;

		kbase_free_phy_pages_helper(alloc, alloc->evicted);
		freed += alloc->evicted;
		list_del_init(&alloc->evict_node);

		kbase_jit_backing_lost(alloc->reg);

		if (freed > sc->nr_to_scan)
			break;
	}
out_unlock:
	mutex_unlock(&kctx->jit_evict_lock);

	// MTK add to prevent false alarm
	lockdep_on();

	return freed;
}

In mobile-phone,threads are likely to be stuck in shrinker callback during
direct_reclaim, with example like the following:
<...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
			dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
<...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
			dynamic_mem_shrink_scan+0x0/0xb8 ...

For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM that
allows driver to set shrinker callback not to be called in direct_reclaim
unless sc->priority is 0.

The reason why sc->priority=0 allows shrinker callback to be called in
direct_reclaim is for two reasons:
1.Always call all shrinker callback in drop_slab that priority is 0.
2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to call
shrinker callback, to reclaim memory timely.

Note:
1.shrinker_register() default not to set SHRINKER_NO_DIRECT_RECLAIM, to
maintain the current behavior of the code.
2.Logic of kswapd and drop_slab to call shrinker callback isn't affected.

Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
---
-v2: fix the commit message
 include/linux/shrinker.h |  5 +++++
 mm/shrinker.c            | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 1a00be90d93a..2d5a8b3a720b 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -130,6 +130,11 @@ struct shrinker {
  * non-MEMCG_AWARE shrinker should not have this flag set.
  */
 #define SHRINKER_NONSLAB	BIT(4)
+/*
+ * Can shrinker callback be called in direct_relcaim unless
+ * sc->priority is 0?
+ */
+#define SHRINKER_NO_DIRECT_RECLAIM	BIT(5)
 
 __printf(2, 3)
 struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..7a5dffd166cd 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -4,7 +4,7 @@
 #include <linux/shrinker.h>
 #include <linux/rculist.h>
 #include <trace/events/vmscan.h>
-
+#include <linux/swap.h>
 #include "internal.h"
 
 LIST_HEAD(shrinker_list);
@@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			if (!memcg_kmem_online() &&
 			    !(shrinker->flags & SHRINKER_NONSLAB))
 				continue;
-
+			/*
+			 * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
+			 * should not be called in direct_reclaim unless priority
+			 * is 0.
+			 */
+			if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
+					!current_is_kswapd()) {
+				/*
+				 * 1.Always call shrinker callback in drop_slab that
+				 * priority is 0.
+				 * 2.sc->priority is 0 during direct_reclaim, allow
+				 * direct_reclaim to call shrinker callback, to reclaim
+				 * memory timely.
+				 */
+				if (priority)
+					continue;
+			}
 			ret = do_shrink_slab(&sc, shrinker, priority);
 			if (ret == SHRINK_EMPTY) {
 				clear_bit(offset, unit->map);
@@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			continue;
 
 		rcu_read_unlock();
-
+		/*
+		 * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
+		 * should not be called in direct_reclaim unless priority
+		 * is 0.
+		 */
+		if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
+				!current_is_kswapd()) {
+			/*
+			 * 1.Always call shrinker callback in drop_slab that
+			 * priority is 0.
+			 * 2.sc->priority is 0 during direct_reclaim, allow
+			 * direct_reclaim to call shrinker callback, to reclaim
+			 * memory timely.
+			 */
+			if (priority)
+				continue;
+		}
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
-- 
2.34.1


