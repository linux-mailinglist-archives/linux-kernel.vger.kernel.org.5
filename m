Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8447C9EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJPFbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjJPFbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:31:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D137FE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434246; x=1728970246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfRpoz7hyBU9JmRbw98oRPbnFFeRDJT3CelEzN0A4Iw=;
  b=PNh7XY77Uf6TWtMldCBfLzfmXdIfIhsi3ls1Zt1tDxzlwNR3sPcTWGkk
   RGxZABjK8gv5WM5uapvbpWHVHG1x7FPyBwph7CQbTUcdpCEUsuwgPbpUU
   WfByHLxUbK3aELph82n+nvq/mD5J+05k2m7dRaXQPnJrJg/9N50dEXmLc
   V0ePC84EwJQfmVvZe0b+rWyNZpo95VXAP8weUMw0F9iLkzAYNqpiCezy8
   HYe7ldW4CvX7YJsNygP8bzGYDm0Bg+ZVJ9pwrEymPlNqVn7AQMFqcuc2n
   5JB/k2+64dQgtxgInKHyecJa2I1meDGOUUlb3KZbRCkIb5/C4lomxjizy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308092"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308092"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356736"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356736"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:43 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V3 7/9] mm: tune PCP high automatically
Date:   Mon, 16 Oct 2023 13:30:00 +0800
Message-Id: <20231016053002.756205-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016053002.756205-1-ying.huang@intel.com>
References: <20231016053002.756205-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target to tune PCP high automatically is as follows,

- Minimize allocation/freeing from/to shared zone

- Minimize idle pages in PCP

- Minimize pages in PCP if the system free pages is too few

To reach these target, a tuning algorithm as follows is designed,

- When we refill PCP via allocating from the zone, increase PCP high.
  Because if we had larger PCP, we could avoid to allocate from the
  zone.

- In periodic vmstat updating kworker (via refresh_cpu_vm_stats()),
  decrease PCP high to try to free possible idle PCP pages.

- When page reclaiming is active for the zone, stop increasing PCP
  high in allocating path, decrease PCP high and free some pages in
  freeing path.

So, the PCP high can be tuned to the page allocating/freeing depth of
workloads eventually.

One issue of the algorithm is that if the number of pages allocated is
much more than that of pages freed on a CPU, the PCP high may become
the maximal value even if the allocating/freeing depth is small.  But
this isn't a severe issue, because there are no idle pages in this
case.

One alternative choice is to increase PCP high when we drain PCP via
trying to free pages to the zone, but don't increase PCP high during
PCP refilling.  This can avoid the issue above.  But if the number of
pages allocated is much less than that of pages freed on a CPU, there
will be many idle pages in PCP and it is hard to free these idle
pages.

1/8 (>> 3) of PCP high will be decreased periodically.  The value 1/8
is kind of arbitrary.  Just to make sure that the idle PCP pages will
be freed eventually.

On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.
With the patch, the build time decreases 3.5%.  The cycles% of the
spinlock contention (mostly for zone lock) decreases from 11.0% to
0.5%.  The number of PCP draining for high order pages
freeing (free_high) decreases 65.6%.  The number of pages allocated
from zone (instead of from PCP) decreases 83.9%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/gfp.h |   1 +
 mm/page_alloc.c     | 119 ++++++++++++++++++++++++++++++++++----------
 mm/vmstat.c         |   8 +--
 3 files changed, 99 insertions(+), 29 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 665edc11fb9f..5b917e5b9350 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -320,6 +320,7 @@ extern void page_frag_free(void *addr);
 #define free_page(addr) free_pages((addr), 0)
 
 void page_alloc_init_cpuhp(void);
+int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1fb2c6ebde9c..8382ad2cdfd4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2157,6 +2157,40 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	return i;
 }
 
+/*
+ * Called from the vmstat counter updater to decay the PCP high.
+ * Return whether there are addition works to do.
+ */
+int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
+{
+	int high_min, to_drain, batch;
+	int todo = 0;
+
+	high_min = READ_ONCE(pcp->high_min);
+	batch = READ_ONCE(pcp->batch);
+	/*
+	 * Decrease pcp->high periodically to try to free possible
+	 * idle PCP pages.  And, avoid to free too many pages to
+	 * control latency.  This caps pcp->high decrement too.
+	 */
+	if (pcp->high > high_min) {
+		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+				 pcp->high - (pcp->high >> 3), high_min);
+		if (pcp->high > high_min)
+			todo++;
+	}
+
+	to_drain = pcp->count - pcp->high;
+	if (to_drain > 0) {
+		spin_lock(&pcp->lock);
+		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		spin_unlock(&pcp->lock);
+		todo++;
+	}
+
+	return todo;
+}
+
 #ifdef CONFIG_NUMA
 /*
  * Called from the vmstat counter updater to drain pagesets of this
@@ -2318,14 +2352,13 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
 	return true;
 }
 
-static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
+static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free_high)
 {
 	int min_nr_free, max_nr_free;
-	int batch = READ_ONCE(pcp->batch);
 
-	/* Free everything if batch freeing high-order pages. */
+	/* Free as much as possible if batch freeing high-order pages. */
 	if (unlikely(free_high))
-		return pcp->count;
+		return min(pcp->count, batch << CONFIG_PCP_BATCH_SCALE_MAX);
 
 	/* Check for PCP disabled or boot pageset */
 	if (unlikely(high < batch))
@@ -2340,7 +2373,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 	 * freeing of pages without any allocation.
 	 */
 	batch <<= pcp->free_factor;
-	if (batch < max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
+	if (batch <= max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
 		pcp->free_factor++;
 	batch = clamp(batch, min_nr_free, max_nr_free);
 
@@ -2348,28 +2381,48 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 }
 
 static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
-		       bool free_high)
+		       int batch, bool free_high)
 {
-	int high = READ_ONCE(pcp->high_min);
+	int high, high_min, high_max;
 
-	if (unlikely(!high || free_high))
+	high_min = READ_ONCE(pcp->high_min);
+	high_max = READ_ONCE(pcp->high_max);
+	high = pcp->high = clamp(pcp->high, high_min, high_max);
+
+	if (unlikely(!high))
 		return 0;
 
-	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
-		return high;
+	if (unlikely(free_high)) {
+		pcp->high = max(high - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
+				high_min);
+		return 0;
+	}
 
 	/*
 	 * If reclaim is active, limit the number of pages that can be
 	 * stored on pcp lists
 	 */
-	return min(READ_ONCE(pcp->batch) << 2, high);
+	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags)) {
+		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		return min(batch << 2, pcp->high);
+	}
+
+	if (pcp->count >= high && high_min != high_max) {
+		int need_high = (batch << pcp->free_factor) + batch;
+
+		/* pcp->high should be large enough to hold batch freed pages */
+		if (pcp->high < need_high)
+			pcp->high = clamp(need_high, high_min, high_max);
+	}
+
+	return high;
 }
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
 				   unsigned int order)
 {
-	int high;
+	int high, batch;
 	int pindex;
 	bool free_high = false;
 
@@ -2384,6 +2437,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
+	batch = READ_ONCE(pcp->batch);
 	/*
 	 * As high-order pages other than THP's stored on PCP can contribute
 	 * to fragmentation, limit the number stored when PCP is heavily
@@ -2394,14 +2448,15 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 		free_high = (pcp->free_factor &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
-			      pcp->count >= READ_ONCE(pcp->batch)));
+			      pcp->count >= READ_ONCE(batch)));
 		pcp->flags |= PCPF_PREV_FREE_HIGH_ORDER;
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
 	}
-	high = nr_pcp_high(pcp, zone, free_high);
+	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, free_high), pcp, pindex);
+		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
+				   pcp, pindex);
 	}
 }
 
@@ -2685,24 +2740,38 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	return page;
 }
 
-static int nr_pcp_alloc(struct per_cpu_pages *pcp, int order)
+static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 {
-	int high, batch, max_nr_alloc;
+	int high, base_batch, batch, max_nr_alloc;
+	int high_max, high_min;
 
-	high = READ_ONCE(pcp->high_min);
-	batch = READ_ONCE(pcp->batch);
+	base_batch = READ_ONCE(pcp->batch);
+	high_min = READ_ONCE(pcp->high_min);
+	high_max = READ_ONCE(pcp->high_max);
+	high = pcp->high = clamp(pcp->high, high_min, high_max);
 
 	/* Check for PCP disabled or boot pageset */
-	if (unlikely(high < batch))
+	if (unlikely(high < base_batch))
 		return 1;
 
+	if (order)
+		batch = base_batch;
+	else
+		batch = (base_batch << pcp->alloc_factor);
+
 	/*
-	 * Double the number of pages allocated each time there is subsequent
-	 * allocation of order-0 pages without any freeing.
+	 * If we had larger pcp->high, we could avoid to allocate from
+	 * zone.
 	 */
+	if (high_min != high_max && !test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
+		high = pcp->high = min(high + batch, high_max);
+
 	if (!order) {
-		max_nr_alloc = max(high - pcp->count - batch, batch);
-		batch <<= pcp->alloc_factor;
+		max_nr_alloc = max(high - pcp->count - base_batch, base_batch);
+		/*
+		 * Double the number of pages allocated each time there is
+		 * subsequent allocation of order-0 pages without any freeing.
+		 */
 		if (batch <= max_nr_alloc &&
 		    pcp->alloc_factor < CONFIG_PCP_BATCH_SCALE_MAX)
 			pcp->alloc_factor++;
@@ -2733,7 +2802,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 
 	do {
 		if (list_empty(list)) {
-			int batch = nr_pcp_alloc(pcp, order);
+			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
 			alloced = rmqueue_bulk(zone, order,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..2f716ad14168 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -814,9 +814,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-#ifdef CONFIG_NUMA
 		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
-#endif
 
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			int v;
@@ -832,10 +830,12 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 #endif
 			}
 		}
-#ifdef CONFIG_NUMA
 
 		if (do_pagesets) {
 			cond_resched();
+
+			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
+#ifdef CONFIG_NUMA
 			/*
 			 * Deal with draining the remote pageset of this
 			 * processor
@@ -862,8 +862,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
-		}
 #endif
+		}
 	}
 
 	for_each_online_pgdat(pgdat) {
-- 
2.39.2

