Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEB7C9EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJPFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjJPFam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337B115
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434239; x=1728970239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2DHjUu90tq7FGOt8u63umE+5KVYee9+PKxuiyDDeGjc=;
  b=LTe2YsPJIWcng/GwbQhgXxtHJu6CJE0iIjRMoiJsZLLtyb0G7uSvYS6c
   yED5M0vm/O6t1lIh//kDwzqEZH0jE3lohkhIX430/auLuFbUbM+xIqZEL
   XJc4hWYANkPgv3XZwc1LuGeDpDW+riyk4b17Wj9SE9SW9MXik6SMt841t
   9K9NtcJcG7etODiFzdPc/SB8r5d830jKkIDzRpXt4beBFT4llrCZLh50i
   s0Ocfc9jdZlBmPDuJ3K12TSdpeFsAM6yxuNAgqExP+Xjaze7RXzuY9GYM
   Gfjy3XupZesIVxbkygazydc3jKOobjoFq/MRdoJuBsItxOSrlRU/I3INf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308038"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356707"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356707"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:36 -0700
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
Subject: [PATCH -V3 5/9] mm, page_alloc: scale the number of pages that are batch allocated
Date:   Mon, 16 Oct 2023 13:29:58 +0800
Message-Id: <20231016053002.756205-6-ying.huang@intel.com>
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
zone lock) decreases from 12.6% to 11.0% (with PCP size == 367).

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
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
 mm/page_alloc.c        | 53 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cdff247e8c6f..ba548ae20686 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -697,9 +697,10 @@ struct per_cpu_pages {
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
index a5a5a4c3cd2b..eeef0ead1c2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2373,6 +2373,12 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
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
@@ -2679,6 +2685,42 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
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
+	 * allocation of order-0 pages without any freeing.
+	 */
+	if (!order) {
+		max_nr_alloc = max(high - pcp->count - batch, batch);
+		batch <<= pcp->alloc_factor;
+		if (batch <= max_nr_alloc &&
+		    pcp->alloc_factor < CONFIG_PCP_BATCH_SCALE_MAX)
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
@@ -2691,18 +2733,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 
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

