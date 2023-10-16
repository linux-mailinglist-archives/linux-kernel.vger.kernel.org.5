Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34107C9ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjJPFbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJPFbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:31:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16008D49
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434255; x=1728970255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDEUGRS7WQQwagCwDvutKWW3kgub6dOrNZn90bOr990=;
  b=UcYHKJjURJ01rEadIjviB31G/FlKApcV0aago1QDrRNd/riwp7eEaFt7
   uAE3De9NdvbKcng/dN2/oiOYFNmkbjB4xnv7ix0H0rSB0J0aWSePwG7tC
   C/woxy3T55sgsxVagdXayA2TLN62D+xfgoEKB8m50X4+g3Vgim/+lD9pL
   4dYpZJz+ivaZBuZ4YdXJyzW/CmS6/SX4FFJIH1A+U0L0R9yLgC4+3785h
   DZPuoHEV5tuysaHpaQR8jyeHNyOc0tD0NOKtQJuLhWGZm6oXOTOA2zxNQ
   jtQt4DIJcosx8iuh8OA5Y0/+NFlnamFgrBoYm1WS0yH6mHkeNzpuDS3kH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308148"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308148"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356777"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356777"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:51 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V3 9/9] mm, pcp: reduce detecting time of consecutive high order page freeing
Date:   Mon, 16 Oct 2023 13:30:02 +0800
Message-Id: <20231016053002.756205-10-ying.huang@intel.com>
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
processes.  With the patch, the network bandwidth improves 5.0%.  This
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
 mm/page_alloc.c        | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c88770381aaf..57086c57b8e4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -700,10 +700,10 @@ struct per_cpu_pages {
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
index 253fc7d0498e..28088dd7a968 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2369,13 +2369,10 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free
 	max_nr_free = high - batch;
 
 	/*
-	 * Double the number of pages freed each time there is subsequent
-	 * freeing of pages without any allocation.
+	 * Increase the batch number to the number of the consecutive
+	 * freed pages to reduce zone lock contention.
 	 */
-	batch <<= pcp->free_factor;
-	if (batch <= max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
-		pcp->free_factor++;
-	batch = clamp(batch, min_nr_free, max_nr_free);
+	batch = clamp_t(int, pcp->free_count, min_nr_free, max_nr_free);
 
 	return batch;
 }
@@ -2403,7 +2400,9 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	 * stored on pcp lists
 	 */
 	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags)) {
-		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		int free_count = max_t(int, pcp->free_count, batch);
+
+		pcp->high = max(high - free_count, high_min);
 		return min(batch << 2, pcp->high);
 	}
 
@@ -2411,10 +2410,12 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		return high;
 
 	if (test_bit(ZONE_BELOW_HIGH, &zone->flags)) {
-		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		int free_count = max_t(int, pcp->free_count, batch);
+
+		pcp->high = max(high - free_count, high_min);
 		high = max(pcp->count, high_min);
 	} else if (pcp->count >= high) {
-		int need_high = (batch << pcp->free_factor) + batch;
+		int need_high = pcp->free_count + batch;
 
 		/* pcp->high should be large enough to hold batch freed pages */
 		if (pcp->high < need_high)
@@ -2451,7 +2452,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 * stops will be drained from vmstat refresh context.
 	 */
 	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
-		free_high = (pcp->free_factor &&
+		free_high = (pcp->free_count >= batch &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
 			      pcp->count >= READ_ONCE(batch)));
@@ -2459,6 +2460,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
 	}
+	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
+		pcp->free_count += (1 << order);
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
@@ -2855,7 +2858,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
-	pcp->free_factor >>= 1;
+	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
 	pcp_spin_unlock(pcp);
@@ -5488,7 +5491,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	pcp->high_min = BOOT_PAGESET_HIGH;
 	pcp->high_max = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
-	pcp->free_factor = 0;
+	pcp->free_count = 0;
 }
 
 static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high_min,
-- 
2.39.2

