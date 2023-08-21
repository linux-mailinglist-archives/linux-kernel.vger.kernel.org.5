Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090578305C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjHUSh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjHUShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00457AAF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76da22c090dso121504685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643065; x=1693247865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OXDzqobi26eycvYhGCWs85e727Laa8S1QvcjFdxFeg=;
        b=lgZ1kcSOohYpCTrIyKsC93cc4kIpl8ate6SPXQoHEqFEqxph+VzaCZQQveAtX6GI9/
         bgOak/kNwG6ziWfjfOg6N67Hz/+yuzH8lI580AFM1epn21zvL8vi83X1L7YUHwzpGVvx
         YA01iPY8Lqhd9V73PD1m67deaPbteFXaTthOU6cezFmYs3ymg6qw5Hh/iNtsrcu+USPT
         CxJVbwndANUPXW6bupkU45WerFNpyqEIBPD+cdXldw73OZyfaNREF/atCX7sgh1JYBKf
         xoH6pjR9xo7d8NggsYfek3/nDHteNHpaNgQMI5zY7J4ai1BX6DtyFoJ3TFZZ+p3Oijh6
         WKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643065; x=1693247865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OXDzqobi26eycvYhGCWs85e727Laa8S1QvcjFdxFeg=;
        b=WPjBOulg4iuqo+GRtPrSjKTbQv6Kb2NRVb/uCnel6n6fEZCBUCsF0woQq6FubFEV9P
         NIgFknyGf6PMfCFOfgsLe2kXdfv7B6n+6Nc6bdNy8728Jv8BvXWt4cZ9xYoCT6Lymxyf
         Aj6bpxwiTewduI3pYGe3d+w6sBT1f/uDPl/O57SmNRzqi27Zdny8WdBpnnqXcnxE+ZVO
         1zBGqN0+bwlUxXoOlXgWCZunGa/6ExrVsyJ3mI8xcmDA6Hich0WRo12R8N0ItC8D371N
         C64MoJ9G97PGhoijuRVzjJVwNrFu3UaXn4WgjGBwpYOHV8VN+8BrA0wedLGcVKncoB0+
         W0yw==
X-Gm-Message-State: AOJu0YxrAj2RgxA4s5G0n20g+EpmNGdkVgGIHcjzhr4TYPkGSnx+SDZ5
        2DaB1LY5/efR8Xvi80zzdemObw8LdISRnH6Db0nHJA==
X-Google-Smtp-Source: AGHT+IGJZ+zhp1f2bcF5REuEixNaaCLEE9Htf14o6is5FNd/PZdXWJXddgqEaBhHppgDrV4sWl0WmA==
X-Received: by 2002:a05:620a:4493:b0:76c:e764:508a with SMTP id x19-20020a05620a449300b0076ce764508amr11514961qkp.3.1692643064872;
        Mon, 21 Aug 2023 11:37:44 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id os33-20020a05620a812100b007682af2c8aasm2664017qkn.126.2023.08.21.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:44 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm: page_alloc: remove pcppage migratetype caching
Date:   Mon, 21 Aug 2023 14:33:34 -0400
Message-ID: <20230821183733.106619-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821183733.106619-1-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind the cache is to save get_pageblock_migratetype()
lookups during bulk freeing. A microbenchmark suggests this isn't
helping, though. The pcp migratetype can get stale, which means that
bulk freeing has an extra branch to check if the pageblock was
isolated while on the pcp.

While the variance overlaps, the cache write and the branch seem to
make this a net negative. The following test allocates and frees
batches of 10,000 pages (~3x the pcp high marks to trigger flushing):

Before:
          8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
                19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
                 0      cpu-migrations                   #    0.000 /sec
            17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
    41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
   126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
    25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
        33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )

         0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )

After:
          8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
                22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
                 0      cpu-migrations                   #    0.000 /sec
            17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
    40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
   126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
    25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
        32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )

         0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )

A side effect is that this also ensures that pages whose pageblock
gets stolen while on the pcplist end up on the right freelist and we
don't perform potentially type-incompatible buddy merges (or skip
merges when we shouldn't), whis is likely beneficial to long-term
fragmentation management, although the effects would be harder to
measure. Settle for simpler and faster code as justification here.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 61 ++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e430ac45df7c..20973887999b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -204,24 +204,6 @@ EXPORT_SYMBOL(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-/*
- * A cached value of the page's pageblock's migratetype, used when the page is
- * put on a pcplist. Used to avoid the pageblock migratetype lookup when
- * freeing from pcplists in most cases, at the cost of possibly becoming stale.
- * Also the migratetype set in the page does not necessarily match the pcplist
- * index, e.g. page might have MIGRATE_CMA set but be on a pcplist with any
- * other index - this ensures that it will be put on the correct CMA freelist.
- */
-static inline int get_pcppage_migratetype(struct page *page)
-{
-	return page->index;
-}
-
-static inline void set_pcppage_migratetype(struct page *page, int migratetype)
-{
-	page->index = migratetype;
-}
-
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 unsigned int pageblock_order __read_mostly;
 #endif
@@ -1213,7 +1195,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
-	bool isolated_pageblocks;
 	struct page *page;
 
 	/*
@@ -1226,7 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	pindex = pindex - 1;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
 		struct list_head *list;
@@ -1249,10 +1229,12 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		order = pindex_to_order(pindex);
 		nr_pages = 1 << order;
 		do {
+			unsigned long pfn;
 			int mt;
 
 			page = list_last_entry(list, struct page, pcp_list);
-			mt = get_pcppage_migratetype(page);
+			pfn = page_to_pfn(page);
+			mt = get_pfnblock_migratetype(page, pfn);
 
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
@@ -1261,11 +1243,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-			/* Pageblock could have been isolated meanwhile */
-			if (unlikely(isolated_pageblocks))
-				mt = get_pageblock_migratetype(page);
 
-			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1611,7 +1590,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 			continue;
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
-		set_pcppage_migratetype(page, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
 				migratetype < MIGRATE_PCPTYPES);
@@ -2181,7 +2159,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
+		if (is_migrate_cma(get_pageblock_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
 	}
@@ -2340,19 +2318,6 @@ void drain_all_pages(struct zone *zone)
 	__drain_all_pages(zone, false);
 }
 
-static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
-							unsigned int order)
-{
-	int migratetype;
-
-	if (!free_pages_prepare(page, order, FPI_NONE))
-		return false;
-
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	set_pcppage_migratetype(page, migratetype);
-	return true;
-}
-
 static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch,
 		       bool free_high)
 {
@@ -2440,7 +2405,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
-	if (!free_unref_page_prepare(page, pfn, order))
+	if (!free_pages_prepare(page, order, FPI_NONE))
 		return;
 
 	/*
@@ -2450,7 +2415,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = get_pcppage_migratetype(page);
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
@@ -2486,7 +2451,8 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn, 0)) {
+
+		if (!free_pages_prepare(page, 0, FPI_NONE)) {
 			list_del(&page->lru);
 			continue;
 		}
@@ -2495,7 +2461,7 @@ void free_unref_page_list(struct list_head *list)
 		 * Free isolated pages directly to the allocator, see
 		 * comment in free_unref_page.
 		 */
-		migratetype = get_pcppage_migratetype(page);
+		migratetype = get_pfnblock_migratetype(page, pfn);
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			list_del(&page->lru);
 			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
@@ -2504,10 +2470,11 @@ void free_unref_page_list(struct list_head *list)
 	}
 
 	list_for_each_entry_safe(page, next, list, lru) {
+		unsigned long pfn = page_to_pfn(page);
 		struct zone *zone = page_zone(page);
 
 		list_del(&page->lru);
-		migratetype = get_pcppage_migratetype(page);
+		migratetype = get_pfnblock_migratetype(page, pfn);
 
 		/*
 		 * Either different zone requiring a different pcp lock or
@@ -2530,7 +2497,7 @@ void free_unref_page_list(struct list_head *list)
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, page, page_to_pfn(page),
+				free_one_page(zone, page, pfn,
 					      0, migratetype, FPI_NONE);
 				locked_zone = NULL;
 				continue;
@@ -2705,7 +2672,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			}
 		}
 		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
+					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-- 
2.41.0

