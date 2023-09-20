Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2457A72BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjITGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjITGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:20:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779BCF2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190813; x=1726726813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/60qEX1jhBiS6ZWzLs5VHrBM2EfBeFasIo8hPl4DFY=;
  b=jXr2YEz5bQqQJL6tBRUhfqJ/2om3UBPX4ttJKoUkB70zGed/KbsMcjHt
   GwnxWs9nTzfNbNZZ8aVqrelL+1PLcNHDXec5ADbkRCIr/H878JtAIyvyQ
   rqqY2P9OtbEC4qBmPsIBXZGFNeWmkMFEIG/872CrNvbyl4qfMi/N744JH
   geBo1qcaNYIHzWcrBdskweFXpGVbidnoZ/5BCMTXkSfQgwdIgQhIQs1q/
   rYoApNGtTJZ3+u+BX6I4QU+Zqsukkhn7pbd9ooxywB0RRuRbdbGr3+V+4
   76tCdHwLfb9vUncuIaFZTyubtr7qFVNmnGDu9WOn+9XYzJzFlKK4rDeeJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187807"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187807"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060689"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060689"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:08 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 10/10] mm, pcp: reduce detecting time of consecutive high order page freeing
Date:   Wed, 20 Sep 2023 14:18:56 +0800
Message-Id: <20230920061856.257597-11-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920061856.257597-1-ying.huang@intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current PCP auto-tuning design, if the number of pages allocated is
much more than that of pages freed on a CPU, the PCP high may become
the maximal value even if the allocating/freeing depth is small, for
example, in the sender of network workloads.  If a CPU was used as
sender originally, then it is used as receiver after context
switching, we need to fill the whole PCP with maximal high before
triggering PCP draining for consecutive high order freeing.  This will
hurt the performance of some network workloads.

To solve the issue, in this patch, we will track the consecutive page
freeing with a counter in stead of relying on PCP draining.  So, we
can detect consecutive page freeing much earlier.

On a 2-socket Intel server with 128 logical CPU, we tested
SCTP_STREAM_MANY test case of netperf test suite with 64-pair
processes.  With the patch, the network bandwidth improves 3.1%.  This
restores the performance drop caused by PCP auto-tuning.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 35b78c7522a7..44f6dc3cdeeb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -689,10 +689,10 @@ struct per_cpu_pages {
 	int batch;		/* chunk size for buddy add/remove */
 	u8 flags;		/* protected by pcp->lock */
 	u8 alloc_factor;	/* batch scaling factor during allocate */
-	u8 free_factor;		/* batch scaling factor during free */
 #ifdef CONFIG_NUMA
 	u8 expire;		/* When 0, remote pagesets are drained */
 #endif
+	short free_count;	/* consecutive free count */
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[NR_PCP_LISTS];
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77e9b7b51688..6ae2a5ebf7a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2375,13 +2375,10 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free
 	max_nr_free = high - batch;
 
 	/*
-	 * Double the number of pages freed each time there is subsequent
-	 * freeing of pages without any allocation.
+	 * Increase the batch number to the number of the consecutive
+	 * freed pages to reduce zone lock contention.
 	 */
-	batch <<= pcp->free_factor;
-	if (batch <= max_nr_free && pcp->free_factor < PCP_BATCH_SCALE_MAX)
-		pcp->free_factor++;
-	batch = clamp(batch, min_nr_free, max_nr_free);
+	batch = clamp_t(int, pcp->free_count, min_nr_free, max_nr_free);
 
 	return batch;
 }
@@ -2408,7 +2405,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	 * stored on pcp lists
 	 */
 	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags)) {
-		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		pcp->high = max(high - pcp->free_count, high_min);
 		return min(batch << 2, pcp->high);
 	}
 
@@ -2416,10 +2413,10 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		return high;
 
 	if (test_bit(ZONE_BELOW_HIGH, &zone->flags)) {
-		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		pcp->high = max(high - pcp->free_count, high_min);
 		high = max(pcp->count, high_min);
 	} else if (pcp->count >= high) {
-		int need_high = (batch << pcp->free_factor) + batch;
+		int need_high = pcp->free_count + batch;
 
 		/* pcp->high should be large enough to hold batch freed pages */
 		if (pcp->high < need_high)
@@ -2456,7 +2453,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 * stops will be drained from vmstat refresh context.
 	 */
 	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
-		free_high = (pcp->free_factor &&
+		free_high = (pcp->free_count >= batch &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
 			      pcp->count >= READ_ONCE(batch)));
@@ -2464,6 +2461,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
 	}
+	if (pcp->free_count < (batch << PCP_BATCH_SCALE_MAX))
+		pcp->free_count += (1 << order);
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
@@ -2861,7 +2860,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
-	pcp->free_factor >>= 1;
+	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
 	pcp_spin_unlock(pcp);
@@ -5483,7 +5482,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	pcp->high_min = BOOT_PAGESET_HIGH;
 	pcp->high_max = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
-	pcp->free_factor = 0;
+	pcp->free_count = 0;
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high_min,
-- 
2.39.2

