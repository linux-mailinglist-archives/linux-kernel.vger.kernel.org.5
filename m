Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715E7A72BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjITGUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjITGUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A061DE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190793; x=1726726793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=34wdsgvd2w4CDiR/vU6T5wdv61OCb5iOnSh2X+G58Mc=;
  b=Gp7YBX0nMiS5QX/TBV6p3G9xBLqXObK3Vvn25jn0OFU44htoSWmGhBO8
   xv+t8h02FgEdi0dLRwcRuNl+mmOHsEUyEh19kd0qiPcLb1h9X9r+m6g+P
   46KrzmOYM6RpgA/E5m+Ss6UN+SmSG2y2EZXtAFsP+YNEKXaVLb8pIKvQw
   f2vNEubh7v0tTgZd06YUAYshMqmz01kfTsWsgDY/ZE8yUaBoZ8b39gR26
   yvYxuPJhy/kgH6wXcGB43jfeTboGe301YHenTKyzBvXwNivj3kxFNzKF9
   Ot6gSC5Ku1KrPsELcyzePifubGKcLVYcgHfzN3Q2K/gww5copN/jP0P2G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187681"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187681"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060606"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060606"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:49 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 05/10] mm, page_alloc: scale the number of pages that are batch allocated
Date:   Wed, 20 Sep 2023 14:18:51 +0800
Message-Id: <20230920061856.257597-6-ying.huang@intel.com>
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

When a task is allocating a large number of order-0 pages, it may
acquire the zone->lock multiple times allocating pages in batches.
This may unnecessarily contend on the zone lock when allocating very
large number of pages.  This patch adapts the size of the batch based
on the recent pattern to scale the batch size for subsequent
allocations.

On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
one socket with `make -j 112`.  With the patch, the cycles% of the
spinlock contention (mostly for zone lock) decreases from 40.5% to
37.9% (with PCP size == 361).

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/mmzone.h |  3 ++-
 mm/page_alloc.c        | 52 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4132e7490b49..4f7420e35fbb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -685,9 +685,10 @@ struct per_cpu_pages {
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	u8 flags;		/* protected by pcp->lock */
+	u8 alloc_factor;	/* batch scaling factor during allocate */
 	u8 free_factor;		/* batch scaling factor during free */
 #ifdef CONFIG_NUMA
-	short expire;		/* When 0, remote pagesets are drained */
+	u8 expire;		/* When 0, remote pagesets are drained */
 #endif
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 30554c674349..30bb05fa5353 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2376,6 +2376,12 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	int pindex;
 	bool free_high = false;
 
+	/*
+	 * On freeing, reduce the number of pages that are batch allocated.
+	 * See nr_pcp_alloc() where alloc_factor is increased for subsequent
+	 * allocations.
+	 */
+	pcp->alloc_factor >>= 1;
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
@@ -2682,6 +2688,41 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	return page;
 }
 
+static int nr_pcp_alloc(struct per_cpu_pages *pcp, int order)
+{
+	int high, batch, max_nr_alloc;
+
+	high = READ_ONCE(pcp->high);
+	batch = READ_ONCE(pcp->batch);
+
+	/* Check for PCP disabled or boot pageset */
+	if (unlikely(high < batch))
+		return 1;
+
+	/*
+	 * Double the number of pages allocated each time there is subsequent
+	 * refiling of order-0 pages without drain.
+	 */
+	if (!order) {
+		max_nr_alloc = max(high - pcp->count - batch, batch);
+		batch <<= pcp->alloc_factor;
+		if (batch <= max_nr_alloc && pcp->alloc_factor < PCP_BATCH_SCALE_MAX)
+			pcp->alloc_factor++;
+		batch = min(batch, max_nr_alloc);
+	}
+
+	/*
+	 * Scale batch relative to order if batch implies free pages
+	 * can be stored on the PCP. Batch can be 1 for small zones or
+	 * for boot pagesets which should never store free pages as
+	 * the pages may belong to arbitrary zones.
+	 */
+	if (batch > 1)
+		batch = max(batch >> order, 2);
+
+	return batch;
+}
+
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
@@ -2694,18 +2735,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 
 	do {
 		if (list_empty(list)) {
-			int batch = READ_ONCE(pcp->batch);
+			int batch = nr_pcp_alloc(pcp, order);
 			int alloced;
 
-			/*
-			 * Scale batch relative to order if batch implies
-			 * free pages can be stored on the PCP. Batch can
-			 * be 1 for small zones or for boot pagesets which
-			 * should never store free pages as the pages may
-			 * belong to arbitrary zones.
-			 */
-			if (batch > 1)
-				batch = max(batch >> order, 2);
 			alloced = rmqueue_bulk(zone, order,
 					batch, list,
 					migratetype, alloc_flags);
-- 
2.39.2

