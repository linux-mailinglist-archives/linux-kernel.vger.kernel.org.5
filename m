Return-Path: <linux-kernel+bounces-142209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006388A28E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F34BB22016
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25EE50269;
	Fri, 12 Apr 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="oiRW40pV"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2060.outbound.protection.outlook.com [40.107.215.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD24F20C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909245; cv=fail; b=gYpTBywLOfINOP2jxgI6VCBrpOFEjYoQ1dX5pvN04ZD2bmy3o2/Dqo2LPSsFv506ZV8ZVYRYFW0ILUB/88PAJCud16u+uBbI1s0wtvz7V8XQWQEW9VKfHxpjjp6Io2VImJIFTMrGGOKJmJ7SgUShqx1fSeqfj9gzPxvsJ4u04nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909245; c=relaxed/simple;
	bh=CD9JeHXOlbHKTXLT93mEhBNLGm6v100gsewI4SD04z0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gBPp7bTg+dJskpi0QlmnzBLYKXO97MMkVwcRPOJTSIjwaSA0N22bhsZBlqFQ4+YNQlcZX81wzGtUnEl88PADeJCv+p4Sc8pyuOH8QpANDJjNgVDwsgofJQTtf7jULzqQ9F2eDjHPnwBX/jFMHXMFnHEAK3wwr6iacd07ij+A1I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=oiRW40pV; arc=fail smtp.client-ip=40.107.215.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfcW8XMlyMB2rpnBstSocOjM9Y7Sdv2fg5jeHH2q9XVW+juOr4cXaKvSbgq39ZED/V/T62mO4o3bkmifpmOUo8+433S+InVRGnBCSlB7n1QqP8uy7CGWUi1ANTXVRulN9JZ/fa2fhaRHEKvZhiOY+aW7E1D3SG597loItxeCfHyqsWlVLpsY8/LvQ1xGZxo1ZsuvrNSBvtk5UQGJy1fsIUYdiypLD3X4iJmHI5kHI3fZBJoCWeAYzIMLbk8RoEQa1MII6FRnCjays2LPYcm4llWBJ3XZljGCdaXP3iSsFb4PfrbQuzTPs1SiLtwh5l4HRj6HP6//9baMGwbhFkfKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOMLzTAf430Yv7GQG6MHNG0SQhYE5EfZjOPPcbet9/k=;
 b=XCUlTmVxQTbXhk5AQ4BwDHTHWa+x/JhklHUwuWlfbt5uIMj5Y9zmfm4ZgZ3Xy9FuLfRtpNljmVvUmhdaHeLQ7dZh0lfeSDlylWXmtuUnJZNjW/H8HIckHpaTg9aCPi7hGbz1zc3K9WegOMUdvLWLxIHw1rYN7BMlTHd9L5yvYKzs8euzq43fYUY0YUAZHoeSXHm8SLfkcyPhwJjnMFFi1Pkg05bVrU/ZgXaSzpq/dG86cWW+QrmOUOCRdE8zx5hJgv17dYbsWRJen85OmkNvk/8EP8GJlGqBaW7ngMMfsPiT7l8QdIyaHh8TrMHCE9YtuBWwRhsosLzlQUCsUKB68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOMLzTAf430Yv7GQG6MHNG0SQhYE5EfZjOPPcbet9/k=;
 b=oiRW40pV7qG2cemGtEcrY7keIOQAnnf6v/zPqISTeC3KIN/JQwxvVYIAUg64EfcdJ4tW2Jjc3UP3TSV6mije4sK9vHMdS5afwdmgiSRGNX0h0sYFw0IxYUvNdKNQKFmNp/jQYlLXK63zv941bb4LF3CpLKNkg5Vrh08xDUmhi/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by JH0PR02MB7549.apcprd02.prod.outlook.com (2603:1096:990:69::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:07:20 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 08:07:19 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
Date: Fri, 12 Apr 2024 16:07:06 +0800
Message-Id: <20240412080706.744-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|JH0PR02MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 934f5831-5776-4959-8a64-08dc5ac792f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qL07g8B+u9atSSj7SjevhMwVZSWumxYnwIfSYqM4NHAxadvV/wpHYwTIXUcqjIYhTEYwvY3PuWzgQA4gVN064ZJHRnYdAHJU7aPABBOe+tvybLvG25TpePIn/VCnlZx3EVFxA6TEe2JqwC+3mWkitavU/Nfjn95zEkbG8gTHE/BFrJmuZn6Iw2T3gTaXr1iVWrQciHMIS8s2Wt6vzgno8Me7LkkdtMKDD+Rv5CWDC1WpqPFBuA+qBjThqu+w4XDzPAFi8xlWxaC176t9hm+qiKKsq+Z0tY0m5juyCy98yImXYo0OY5WCyf9jlUjwoKkfV0FQVptJs/VJ1F5TPn+5kW4OPt38yJSRn5mdGynzegNoWhn23ohNJDjDk+3G4err6vUEdoy71rdD46weq9cD6Nm3h/seF0TPj48AcZ3oUbxeqvFjgJzWC3BM+JEiT4/6kEkzTkhm8BTcQ8faaTdVQc/P6cT2xAelKj4gCv7jI/ifDGub6jlFNBjlVmaF0lqf16Yc6d7dzNLkreUOc73UkOM57IBSP3bGAudMUzjAD1pyc5ncMZHzY7+6xlm2FPPwDxv3qROdSrG5nNLknT2uk+S3csAt/P3o8Ni671rPo+na7LEQf1cPhpmawu2vyaXPLDOSkp5Zwe3rhWypKvTGlJDC1HpxMPUj9L12enUmShGrH2LelDSd9uVV93OL+c1Qt7dG6HLL9aD3jTAAmdJabLj4PJdKIOO9ZbzM0CLSvPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGLf+IeVgpj+XI8CSi1Ax4kJCfFOPm1zPxQaAQJ7nlETaTOzputRPh2fx+4K?=
 =?us-ascii?Q?RRqFGnSnrUWLhvn5xO6eCDaWETr+XcwI9fBi85hx98tWw17EgIMp+vbENBkb?=
 =?us-ascii?Q?4Nre6EPTNgwiO90W84hq80A1t4/sOdGK7PPMDqvHzFG7i60RwG/dXbSBc4pg?=
 =?us-ascii?Q?hxOGE6I2MpOqRuc8arwutdgkSXUCraNN7y8qdDV/EYnQdSQeh4rPEKZnOTEt?=
 =?us-ascii?Q?n+Z5rpxhf5/N8W2GtUAZRsD9meaTZ2s8hz9K09H1KN8m5WPSHC4XlKTkb7HV?=
 =?us-ascii?Q?6bt40fvwLKHBgThUYIw4bqkaXg+81nBRRRyRZeUl9Rn4KF9qR5jvtx3hFyB3?=
 =?us-ascii?Q?EhLxQ9c3S9x/dMUgcWPwxUjB3lYs/Omh02tKDpfr+zBXXLBv0j++CPg/Fa0W?=
 =?us-ascii?Q?a6shsHY1tbMIJsU1fgnB58JFgXTtKU+1CZdYaLFxAa9Ek3g796Ry+/la1x1g?=
 =?us-ascii?Q?MqAKqgeLBPOEWC9oIQ/foCzslxqwt/2usQX4Jxk2XBDY0jPjpJx6sTYfE4hK?=
 =?us-ascii?Q?di5NVAvRgNx3tSff7nBoNxjSwhxU+AmVbqdKBLqZLIeIufsAJUf7J5wLynGE?=
 =?us-ascii?Q?Cr7AvYlZd3fuTeQPubZ7g6313UllNa83mVL9OzLbbURmnTfcsMSpgrzhfBow?=
 =?us-ascii?Q?nIhUeYu3M9mVgsQ4fWXmASk7klEcmWtmf+U6y3LNkFdiBeuUkz4HNk14eOd8?=
 =?us-ascii?Q?+GkxhkX1BXSmwNGcdmKDYdOkJ422OrmD8EYyC8krnT9ro+dviKe+yi83ujL1?=
 =?us-ascii?Q?hN7v9jgkAq5HlHqx8AwGSeWzuelZyRqzI3ky1yUqD+kmBbklNxGT/FhVinj+?=
 =?us-ascii?Q?Lvp0xqwa05sIIluSOHXR5r3Y8Mty7p2/d7FEQ+cENYTZBxiAzZJ2OfSN5YK+?=
 =?us-ascii?Q?1suSQritVElJwrTPeukzJTy9QQXvVsp1KP7T/GVl/otyF7X3oZS/Fa3pxWEi?=
 =?us-ascii?Q?lxe7jWq0HFtrEWcxNbNthgpRRe0umPo2n6aDVtspOlPOC9udnYwW+hlM/6JE?=
 =?us-ascii?Q?Z26QdZ1vbg4S9sCV4Lu1cKB3eX8lSnVYV0k2B3SBed+wY0NhWy/kSj4bkzL/?=
 =?us-ascii?Q?ofl1RLRMiVclqZcWJLqS1xnj7AY89rK0sxA7syFU4gAiga+IS3RpzOkb/Ntf?=
 =?us-ascii?Q?a6lCotV5GlL11cmv2k/YlYniBZ0XH2J1XHoZ0wtt8/tvC2UzSkcSNOURccQQ?=
 =?us-ascii?Q?i3wcxd1DLvLQjwX0VesHpA891/kWZtndB/zAnFk0BspL5DT+mrNdmX0o78gm?=
 =?us-ascii?Q?KeZlh3hvwH72b4DUWbDa6po7S5mOS1CaT+ls0BQfmtqwWfK7O+fXoQncTFdm?=
 =?us-ascii?Q?l8L6wYJ0yLVokEYiyzAylGLNbpNvHF+PAUBD+22ICiOp13DA1CjZ4+VOPjMH?=
 =?us-ascii?Q?cXip1YN4xzVKbAtOs9bVqSY0fxLEAd2ndDIOxxMbmo27LtbP68cNYdqZrEDe?=
 =?us-ascii?Q?tzYlm2LYNtcc82hk9uAmHc2OVoMxwCMiji0erxJzywo2d9jmPPQSBoR3OK3P?=
 =?us-ascii?Q?hgPFwAeUfxZ7rdYSX443eC2Cq/XQ6vdRVupC4ZzYoxZFmS4AB1M8zt/HSKCw?=
 =?us-ascii?Q?AXA29ZrVlUrB01qkfXXWKaSK5AVH/3M0JbFVJ346?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f5831-5776-4959-8a64-08dc5ac792f7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:07:19.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJTNBmGBqienfADFx52klyxu5DfPj7SZqkc868B8gVx8XM5nqFxOSwb5d0czHGWcGxHK+yBLEFsprTfPVyBYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7549

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
1.Register_shrinker_prepared() default not to set
SHRINKER_NO_DIRECT_RECLAIM, to maintain the current behavior of the code.
2.Logic of kswapd and drop_slab to call shrinker callback isn't affected.

Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
---
 include/linux/shrinker.h |  5 +++++
 mm/shrinker.c            | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

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
index dc5d2a6fcfc4..3ac50da72494 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
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


