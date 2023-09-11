Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C779B8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347709AbjIKVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbjIKTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:45 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C81A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:40 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-649921ec030so27190646d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461839; x=1695066639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFKNlfdAcUF/YBe6AFZW8MCMiyqnrgJqmqYsuJYCIEg=;
        b=Bc7ojUBrdeGYbjy0O8rL58H+5uxORmdvS6QeviKiGCjkM9sVTTADVK2f91v1ElBif2
         bIXpxkUn+i1tvBEm3oCRKEvzP3RnaqVoUGp6BvY0bJTuRrkzPmh8P+jXlKcpkUU5gS5w
         QtFSliA88zxV5wRwLS5a+OQ+jBsX6TTYO4hllzQOhjyz5pslBpfnYaOwC5aSx8Yito6f
         W61tdXS6xyp1JOGEEbvrvmrwyAhWKK3ETxbRpN7KtyONXlMJBmuhkfRZ/NOZLo9zHxzX
         nRSaiaFMK0jbqu0qwwle+g/Dixkp+BM1DeOO8HJEkdzkjUueK6pKnjO0RWSuH5sVOuN8
         qvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461839; x=1695066639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFKNlfdAcUF/YBe6AFZW8MCMiyqnrgJqmqYsuJYCIEg=;
        b=OwA/EwHq3wy7tluBAw1OPxksn9jNzdpOW+tpIoFBLhOFG69sWQ+Jg59tRLMJPAIPIN
         cPzrV2ELTqN3HD+lndIbb0jXaewXX89q5YcCt4kenpvy+8fEpAIvK7xYGqgPbBXVTggN
         l0xzwoqjPIqwvzo2MW/3iOsxVfqd3/vihjNuMoGETTh1aYVAIjsLKd35eK3Qg/6c8ns7
         cKbz7Os7vp8YrAZxUJ+JgWRgNbYbrZ7uTTdXmS51YWIF/VmmkBK5Q47Sn60u44eusEy+
         Amb860gQwC+edyEh9KcasYwIe6iph0S5joUt71L+UHBNRqzzaieO1gsQUrbUa9WJiB33
         FR7w==
X-Gm-Message-State: AOJu0Yw8xYR8J7PmXKKNSWSQosStydRgYaAQ33DdrT8plmp6kUnZLjmj
        1kQv/pw51WP+gd2VWrrre1p4pA==
X-Google-Smtp-Source: AGHT+IG6zxV3JjIHBg9m8nfMZE9qw+xm/r+Tycsfv0sTed00Bp/idpnNFj9CfKwZpEhUEgfXYmoHtA==
X-Received: by 2002:a0c:b447:0:b0:64f:92d2:44f8 with SMTP id e7-20020a0cb447000000b0064f92d244f8mr8876365qvf.59.1694461839179;
        Mon, 11 Sep 2023 12:50:39 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id f3-20020a0cf3c3000000b0064743dd0633sm3085730qvm.106.2023.09.11.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:38 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: page_alloc: consolidate free page accounting
Date:   Mon, 11 Sep 2023 15:41:47 -0400
Message-ID: <20230911195023.247694-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911195023.247694-1-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
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

Free page accounting currently happens a bit too high up the call
stack, where it has to deal with guard pages, compaction capturing,
block stealing and even page isolation. This is subtle and fragile,
and makes it difficult to hack on the code.

Now that type violations on the freelists have been fixed, push the
accounting down to where pages enter and leave the freelist.

v3:
- fix CONFIG_UNACCEPTED_MEMORY build (lkp)
v2:
- fix CONFIG_DEBUG_PAGEALLOC build (Mel)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm.h             |  18 ++---
 include/linux/page-isolation.h |   3 +-
 include/linux/vmstat.h         |   8 --
 mm/debug_page_alloc.c          |  12 +--
 mm/internal.h                  |   5 --
 mm/page_alloc.c                | 135 ++++++++++++++++++---------------
 mm/page_isolation.c            |   7 +-
 7 files changed, 90 insertions(+), 98 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..d8698248f280 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3680,24 +3680,22 @@ static inline bool page_is_guard(struct page *page)
 	return PageGuard(page);
 }
 
-bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
-		      int migratetype);
+bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order);
 static inline bool set_page_guard(struct zone *zone, struct page *page,
-				  unsigned int order, int migratetype)
+				  unsigned int order)
 {
 	if (!debug_guardpage_enabled())
 		return false;
-	return __set_page_guard(zone, page, order, migratetype);
+	return __set_page_guard(zone, page, order);
 }
 
-void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
-			int migratetype);
+void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order);
 static inline void clear_page_guard(struct zone *zone, struct page *page,
-				    unsigned int order, int migratetype)
+				    unsigned int order)
 {
 	if (!debug_guardpage_enabled())
 		return;
-	__clear_page_guard(zone, page, order, migratetype);
+	__clear_page_guard(zone, page, order);
 }
 
 #else	/* CONFIG_DEBUG_PAGEALLOC */
@@ -3707,9 +3705,9 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool debug_guardpage_enabled(void) { return false; }
 static inline bool page_is_guard(struct page *page) { return false; }
 static inline bool set_page_guard(struct zone *zone, struct page *page,
-			unsigned int order, int migratetype) { return false; }
+			unsigned int order) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
-				unsigned int order, int migratetype) {}
+				unsigned int order) {}
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef __HAVE_ARCH_GATE_AREA
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 8550b3c91480..901915747960 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,7 +34,8 @@ static inline bool is_migrate_isolate(int migratetype)
 #define REPORT_FAILURE	0x2
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
-int move_freepages_block(struct zone *zone, struct page *page, int migratetype);
+int move_freepages_block(struct zone *zone, struct page *page,
+			 int old_mt, int new_mt);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..a4eae03f6094 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -487,14 +487,6 @@ static inline void node_stat_sub_folio(struct folio *folio,
 	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
 }
 
-static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
-					     int migratetype)
-{
-	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
-	if (is_migrate_cma(migratetype))
-		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
-}
-
 extern const char * const vmstat_text[];
 
 static inline const char *zone_stat_name(enum zone_stat_item item)
diff --git a/mm/debug_page_alloc.c b/mm/debug_page_alloc.c
index f9d145730fd1..03a810927d0a 100644
--- a/mm/debug_page_alloc.c
+++ b/mm/debug_page_alloc.c
@@ -32,8 +32,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 }
 early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
 
-bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
-		      int migratetype)
+bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order)
 {
 	if (order >= debug_guardpage_minorder())
 		return false;
@@ -41,19 +40,12 @@ bool __set_page_guard(struct zone *zone, struct page *page, unsigned int order,
 	__SetPageGuard(page);
 	INIT_LIST_HEAD(&page->buddy_list);
 	set_page_private(page, order);
-	/* Guard pages are not available for any usage */
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
 
 	return true;
 }
 
-void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order,
-		      int migratetype)
+void __clear_page_guard(struct zone *zone, struct page *page, unsigned int order)
 {
 	__ClearPageGuard(page);
-
 	set_page_private(page, 0);
-	if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, (1 << order), migratetype);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..d53b70e9cc3a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -883,11 +883,6 @@ static inline bool is_migrate_highatomic(enum migratetype migratetype)
 	return migratetype == MIGRATE_HIGHATOMIC;
 }
 
-static inline bool is_migrate_highatomic_page(struct page *page)
-{
-	return get_pageblock_migratetype(page) == MIGRATE_HIGHATOMIC;
-}
-
 void setup_zone_pageset(struct zone *zone);
 
 struct migration_target_control {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a902593f16dd..bfede72251d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -640,24 +640,36 @@ compaction_capture(struct capture_control *capc, struct page *page,
 }
 #endif /* CONFIG_COMPACTION */
 
-/* Used for pages not on another list */
-static inline void add_to_free_list(struct page *page, struct zone *zone,
-				    unsigned int order, int migratetype)
+static inline void account_freepages(struct page *page, struct zone *zone,
+				     int nr_pages, int migratetype)
 {
-	struct free_area *area = &zone->free_area[order];
+	if (is_migrate_isolate(migratetype))
+		return;
 
-	list_add(&page->buddy_list, &area->free_list[migratetype]);
-	area->nr_free++;
+	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
+
+	if (is_migrate_cma(migratetype))
+		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
 }
 
 /* Used for pages not on another list */
-static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
-					 unsigned int order, int migratetype)
+static inline void add_to_free_list(struct page *page, struct zone *zone,
+				    unsigned int order, int migratetype,
+				    bool tail)
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
+	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), migratetype, 1 << order);
+
+	if (tail)
+		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
+	else
+		list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
+
+	account_freepages(page, zone, 1 << order, migratetype);
 }
 
 /*
@@ -666,16 +678,28 @@ static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
  * allocation again (e.g., optimization for memory onlining).
  */
 static inline void move_to_free_list(struct page *page, struct zone *zone,
-				     unsigned int order, int migratetype)
+				     unsigned int order, int old_mt, int new_mt)
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
+	/* Free page moving can fail, so it happens before the type update */
+	VM_WARN_ONCE(get_pageblock_migratetype(page) != old_mt,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), old_mt, 1 << order);
+
+	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
+
+	account_freepages(page, zone, -(1 << order), old_mt);
+	account_freepages(page, zone, 1 << order, new_mt);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
-					   unsigned int order)
+					   unsigned int order, int migratetype)
 {
+        VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), migratetype, 1 << order);
+
 	/* clear reported state and update reported page count */
 	if (page_reported(page))
 		__ClearPageReported(page);
@@ -684,6 +708,8 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
+
+	account_freepages(page, zone, -(1 << order), migratetype);
 }
 
 static inline struct page *get_page_from_free_area(struct free_area *area,
@@ -757,23 +783,21 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
 
 	VM_BUG_ON(migratetype == -1);
-	if (likely(!is_migrate_isolate(migratetype)))
-		__mod_zone_freepage_state(zone, 1 << order, migratetype);
-
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
 	while (order < MAX_ORDER) {
-		if (compaction_capture(capc, page, order, migratetype)) {
-			__mod_zone_freepage_state(zone, -(1 << order),
-								migratetype);
+		int buddy_mt;
+
+		if (compaction_capture(capc, page, order, migratetype))
 			return;
-		}
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
 		if (!buddy)
 			goto done_merging;
 
+		buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
+
 		if (unlikely(order >= pageblock_order)) {
 			/*
 			 * We want to prevent merge between freepages on pageblock
@@ -801,9 +825,9 @@ static inline void __free_one_page(struct page *page,
 		 * merge with it and move up one order.
 		 */
 		if (page_is_guard(buddy))
-			clear_page_guard(zone, buddy, order, migratetype);
+			clear_page_guard(zone, buddy, order);
 		else
-			del_page_from_free_list(buddy, zone, order);
+			del_page_from_free_list(buddy, zone, order, buddy_mt);
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -820,10 +844,7 @@ static inline void __free_one_page(struct page *page,
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
-	if (to_tail)
-		add_to_free_list_tail(page, zone, order, migratetype);
-	else
-		add_to_free_list(page, zone, order, migratetype);
+	add_to_free_list(page, zone, order, migratetype, to_tail);
 
 	/* Notify page reporting subsystem of freed page */
 	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
@@ -865,10 +886,8 @@ int split_free_page(struct page *free_page,
 	}
 
 	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
-	if (likely(!is_migrate_isolate(mt)))
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
+	del_page_from_free_list(free_page, zone, order, mt);
 
-	del_page_from_free_list(free_page, zone, order);
 	for (pfn = free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
@@ -1388,10 +1407,10 @@ static inline void expand(struct zone *zone, struct page *page,
 		 * Corresponding page table entries will not be touched,
 		 * pages will stay not present in virtual address space
 		 */
-		if (set_page_guard(zone, &page[size], high, migratetype))
+		if (set_page_guard(zone, &page[size], high))
 			continue;
 
-		add_to_free_list(&page[size], zone, high, migratetype);
+		add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 	}
 }
@@ -1561,7 +1580,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
-		del_page_from_free_list(page, zone, current_order);
+		del_page_from_free_list(page, zone, current_order, migratetype);
 		expand(zone, page, order, current_order, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
@@ -1602,7 +1621,7 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  * boundary. If alignment is required, use move_freepages_block()
  */
 static int move_freepages(struct zone *zone, unsigned long start_pfn,
-			  unsigned long end_pfn, int migratetype)
+			  unsigned long end_pfn, int old_mt, int new_mt)
 {
 	struct page *page;
 	unsigned long pfn;
@@ -1621,7 +1640,7 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
 		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
 
 		order = buddy_order(page);
-		move_to_free_list(page, zone, order, migratetype);
+		move_to_free_list(page, zone, order, old_mt, new_mt);
 		pfn += 1 << order;
 		pages_moved += 1 << order;
 	}
@@ -1676,7 +1695,7 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 }
 
 int move_freepages_block(struct zone *zone, struct page *page,
-			 int migratetype)
+			 int old_mt, int new_mt)
 {
 	unsigned long start_pfn, end_pfn;
 
@@ -1684,7 +1703,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
 				       NULL, NULL))
 		return -1;
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype);
+	return move_freepages(zone, start_pfn, end_pfn, old_mt, new_mt);
 }
 
 static void change_pageblock_range(struct page *pageblock_page,
@@ -1795,7 +1814,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
-		del_page_from_free_list(page, zone, current_order);
+		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		expand(zone, page, order, current_order, start_type);
 		return;
@@ -1845,13 +1864,13 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
-		move_freepages(zone, start_pfn, end_pfn, start_type);
+		move_freepages(zone, start_pfn, end_pfn, block_type, start_type);
 		set_pageblock_migratetype(page, start_type);
 		block_type = start_type;
 	}
 
 single_page:
-	del_page_from_free_list(page, zone, current_order);
+	del_page_from_free_list(page, zone, current_order, block_type);
 	expand(zone, page, order, current_order, block_type);
 }
 
@@ -1916,7 +1935,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
 	mt = get_pageblock_migratetype(page);
 	/* Only reserve normal pageblocks (i.e., they can merge with others) */
 	if (migratetype_is_mergeable(mt)) {
-		if (move_freepages_block(zone, page, MIGRATE_HIGHATOMIC) != -1) {
+		if (move_freepages_block(zone, page,
+					 mt, MIGRATE_HIGHATOMIC) != -1) {
 			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 			zone->nr_reserved_highatomic += pageblock_nr_pages;
 		}
@@ -1959,11 +1979,13 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order <= MAX_ORDER; order++) {
 			struct free_area *area = &(zone->free_area[order]);
+			int mt;
 
 			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
 			if (!page)
 				continue;
 
+			mt = get_pageblock_migratetype(page);
 			/*
 			 * In page freeing path, migratetype change is racy so
 			 * we can counter several free pages in a pageblock
@@ -1971,7 +1993,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * from highatomic to ac->migratetype. So we should
 			 * adjust the count once.
 			 */
-			if (is_migrate_highatomic_page(page)) {
+			if (is_migrate_highatomic(mt)) {
 				/*
 				 * It should never happen but changes to
 				 * locking could inadvertently allow a per-cpu
@@ -1993,7 +2015,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * of pageblocks that cannot be completely freed
 			 * may increase.
 			 */
-			ret = move_freepages_block(zone, page, ac->migratetype);
+			ret = move_freepages_block(zone, page, mt,
+						   ac->migratetype);
 			/*
 			 * Reserving this block already succeeded, so this should
 			 * not fail on zone boundaries.
@@ -2165,12 +2188,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		if (is_migrate_cma(get_pageblock_migratetype(page)))
-			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-					      -(1 << order));
 	}
-
-	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	return i;
@@ -2565,11 +2583,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
-
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 	}
 
-	del_page_from_free_list(page, zone, order);
+	del_page_from_free_list(page, zone, order, mt);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
@@ -2584,7 +2600,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * with others)
 			 */
 			if (migratetype_is_mergeable(mt) &&
-			    move_freepages_block(zone, page,
+			    move_freepages_block(zone, page, mt,
 						 MIGRATE_MOVABLE) != -1)
 				set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		}
@@ -2670,8 +2686,6 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 				return NULL;
 			}
 		}
-		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
@@ -6434,8 +6448,9 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
+		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
-		del_page_from_free_list(page, zone, order);
+		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -6486,11 +6501,12 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			current_buddy = page + size;
 		}
 
-		if (set_page_guard(zone, current_buddy, high, migratetype))
+		if (set_page_guard(zone, current_buddy, high))
 			continue;
 
 		if (current_buddy != target) {
-			add_to_free_list(current_buddy, zone, high, migratetype);
+			add_to_free_list(current_buddy, zone, high,
+					 migratetype, false);
 			set_buddy_order(current_buddy, high);
 			page = next_page;
 		}
@@ -6518,12 +6534,11 @@ bool take_page_off_buddy(struct page *page)
 			int migratetype = get_pfnblock_migratetype(page_head,
 								   pfn_head);
 
-			del_page_from_free_list(page_head, zone, page_order);
+			del_page_from_free_list(page_head, zone, page_order,
+						migratetype);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
 			SetPageHWPoisonTakenOff(page);
-			if (!is_migrate_isolate(migratetype))
-				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
 			break;
 		}
@@ -6630,7 +6645,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	list_del(&page->lru);
 	last = list_empty(&zone->unaccepted_pages);
 
-	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(page, zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -6682,7 +6697,7 @@ static bool __free_unaccepted(struct page *page)
 	spin_lock_irqsave(&zone->lock, flags);
 	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
-	__mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(page, zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index cc48a3a52f00..b5c7a9d21257 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -181,13 +181,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 		int nr_pages;
 		int mt = get_pageblock_migratetype(page);
 
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE);
+		nr_pages = move_freepages_block(zone, page, mt, MIGRATE_ISOLATE);
 		/* Block spans zone boundaries? */
 		if (nr_pages == -1) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
@@ -255,13 +254,13 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 * allocation.
 	 */
 	if (!isolated_page) {
-		int nr_pages = move_freepages_block(zone, page, migratetype);
+		int nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
+						    migratetype);
 		/*
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
 		WARN_ON_ONCE(nr_pages == -1);
-		__mod_zone_freepage_state(zone, nr_pages, migratetype);
 	}
 	set_pageblock_migratetype(page, migratetype);
 	if (isolated_page)
-- 
2.42.0

