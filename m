Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D197AE58D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjIZGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjIZGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:10:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C34199
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708587; x=1727244587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZtH26z6BJyiTQzNvHwodkC3VC0x9VX0B8MkwItrlS3k=;
  b=P3UNhv/zAZz09D9nv4Yo/kpXMR/CYI5XtN2Y/Z+8nnNU5KODgePXwOXn
   KNLTqixsr1DhB92CPOPkLSqSTdNFQ5XJCJflIaSXVFqViBPDejZIlUYdD
   5uoV6ZROLT2IoXOLuzflf2YLpk63NfQPIAio+zKXq6CpiG61Vm1YyAoUl
   bYVjivihThW4FMW78d/1xpK8Tp3augNY66nTtm9iq+JEGmJJ6lnUMy5lq
   GhPMM7ClolfgbyK7R1z33KJ514DKQsWs+eBAebI5HT/OugOcA92RulRF8
   QfJ4nqZqfaX7wKYEb7r8VZSCuBtjkBDi9Wo0sWiQWuM/UHHb5ihDJOjq5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447991360"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447991360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892075929"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892075929"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:08:39 -0700
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
Subject: [PATCH -V2 05/10] mm, page_alloc: scale the number of pages that are batch allocated
Date:   Tue, 26 Sep 2023 14:09:06 +0800
Message-Id: <20230926060911.266511-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926060911.266511-1-ying.huang@intel.com>
References: <20230926060911.266511-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.
With the patch, the cycles% of the spinlock contention (mostly for
zone lock) decreases from 11.7% to 10.0% (with PCP size == 361).

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
index 4b601f505401..b9226845abf7 100644
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

