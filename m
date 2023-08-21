Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67494783060
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjHUSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjHUSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:38:00 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD25708D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:56 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44bfe8bcf78so809264137.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643071; x=1693247871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oIQcd8rRXP7RBwvXlPFe1yS+MOvZC6u1A+9FyFyqFE=;
        b=kgMeXntxKQR8tuNiSCez1fknacAOE/h+FkxoUZt3pChYph14NTG2kuLWqggZuVBkgz
         1TPK0+Ib0YstWWTPm5g5jrkWXyurGI517D2VqyFPKaUup4SiiUF/iYe6sozGLCAbGusy
         Cuk/X/7jw5JoTa4djmj1/aXJFiK3LI5OM9K8lOShOFTz4qROpE3sQQ4oE8kOOxG2S7TT
         36JcX9dQCxx4kGv+up4S225n4jA/0jes8XxNH9tHySvNQwEOa8lCM6bYsyxq+iKXNyki
         Z2sTPO3iUOXqC/u+HUrO5E8bFfklkWce1iO9kAY5GZ36G3sBYdwZeb6JsZTJ16647Ac3
         wblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643071; x=1693247871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oIQcd8rRXP7RBwvXlPFe1yS+MOvZC6u1A+9FyFyqFE=;
        b=KJVJDlNq8eLEe94fhlnQc6OpVjbecLVTdX2gGIkt6AHoEXvN5NvvkqfpA1T7l5J5JU
         uUXnW+oFeMwn+RPOVX1lRgOZt8an1NBWElhbrBv6A0F1ULnGN6h+/n70SYQMyfkY3rGC
         /dej14VOVbZf2gE88vSRF3FIesJLxVX6YCOBADPkbjnHQ3jX1NXF65b1bHh+zOcYCTQ8
         zkJ/QXQNidgTYMS5mD30HrsVMputskZlIgLWzhBv2I2zjvMTthJNjGqzGtQZpYtfN+3J
         SydtML7JQDz4nyfbTA0YuOnCZloCVNSBroYj8oWfUz6wSHH9CrM9EGxy7SQUXZzJuXwM
         jHiQ==
X-Gm-Message-State: AOJu0YxlgV5+fO8BXRsOjgpgnzog2GrpENHKNpIjowhjvLo5dnWj8Cqr
        iM+0T0dy2UqXwy80vAQNss1SRw==
X-Google-Smtp-Source: AGHT+IHy2SwpHDcKAyBf07pwHL85neqFey+ZV007pcfVvgRBdnkAqr4gl581JRzxxc13F3O06WJlyg==
X-Received: by 2002:a67:ebd7:0:b0:44d:4553:4fd8 with SMTP id y23-20020a67ebd7000000b0044d45534fd8mr2148296vso.18.1692643071064;
        Mon, 21 Aug 2023 11:37:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cca10000000b0064b502fdeecsm2625786qvk.68.2023.08.21.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:50 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] mm: page_alloc: fix freelist movement during block conversion
Date:   Mon, 21 Aug 2023 14:33:39 -0400
Message-ID: <20230821183733.106619-8-hannes@cmpxchg.org>
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

Currently, page block type conversion during fallbacks, atomic
reservations and isolation can strand various amounts of free pages on
incorrect freelists.

For example, fallback stealing moves free pages in the block to the
new type's freelists, but then may not actually claim the block for
that type if there aren't enough compatible pages already allocated.

In all cases, free page moving might fail if the block straddles more
than one zone, in which case no free pages are moved at all, but the
block type is changed anyway.

This is detrimental to type hygiene on the freelists. It encourages
incompatible page mixing down the line (ask for one type, get another)
and thus contributes to long-term fragmentation.

Split the process into a proper transaction: check first if conversion
will happen, then try to move the free pages, and only if that was
successful convert the block to the new type.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h |   3 +-
 mm/page_alloc.c                | 176 ++++++++++++++++++++-------------
 mm/page_isolation.c            |  22 +++--
 3 files changed, 121 insertions(+), 80 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 4ac34392823a..8550b3c91480 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,8 +34,7 @@ static inline bool is_migrate_isolate(int migratetype)
 #define REPORT_FAILURE	0x2
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
-int move_freepages_block(struct zone *zone, struct page *page,
-				int migratetype, int *num_movable);
+int move_freepages_block(struct zone *zone, struct page *page, int migratetype);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6fcda8e96f16..42b62832323f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1646,9 +1646,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  * Note that start_page and end_pages are not aligned on a pageblock
  * boundary. If alignment is required, use move_freepages_block()
  */
-static int move_freepages(struct zone *zone,
-			  unsigned long start_pfn, unsigned long end_pfn,
-			  int migratetype, int *num_movable)
+static int move_freepages(struct zone *zone, unsigned long start_pfn,
+			  unsigned long end_pfn, int migratetype)
 {
 	struct page *page;
 	unsigned long pfn;
@@ -1658,14 +1657,6 @@ static int move_freepages(struct zone *zone,
 	for (pfn = start_pfn; pfn <= end_pfn;) {
 		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
-			/*
-			 * We assume that pages that could be isolated for
-			 * migration are movable. But we don't actually try
-			 * isolating, as that would be expensive.
-			 */
-			if (num_movable &&
-					(PageLRU(page) || __PageMovable(page)))
-				(*num_movable)++;
 			pfn++;
 			continue;
 		}
@@ -1683,26 +1674,62 @@ static int move_freepages(struct zone *zone,
 	return pages_moved;
 }
 
-int move_freepages_block(struct zone *zone, struct page *page,
-				int migratetype, int *num_movable)
+static bool prep_move_freepages_block(struct zone *zone, struct page *page,
+				      unsigned long *start_pfn,
+				      unsigned long *end_pfn,
+				      int *num_free, int *num_movable)
 {
-	unsigned long start_pfn, end_pfn, pfn;
-
-	if (num_movable)
-		*num_movable = 0;
+	unsigned long pfn, start, end;
 
 	pfn = page_to_pfn(page);
-	start_pfn = pageblock_start_pfn(pfn);
-	end_pfn = pageblock_end_pfn(pfn) - 1;
+	start = pageblock_start_pfn(pfn);
+	end = pageblock_end_pfn(pfn) - 1;
 
 	/* Do not cross zone boundaries */
-	if (!zone_spans_pfn(zone, start_pfn))
-		start_pfn = zone->zone_start_pfn;
-	if (!zone_spans_pfn(zone, end_pfn))
-		return 0;
+	if (!zone_spans_pfn(zone, start))
+		start = zone->zone_start_pfn;
+	if (!zone_spans_pfn(zone, end))
+		return false;
+
+	*start_pfn = start;
+	*end_pfn = end;
+
+	if (num_free) {
+		*num_free = 0;
+		*num_movable = 0;
+		for (pfn = start; pfn <= end;) {
+			page = pfn_to_page(pfn);
+			if (PageBuddy(page)) {
+				int nr = 1 << buddy_order(page);
+
+				*num_free += nr;
+				pfn += nr;
+				continue;
+			}
+			/*
+			 * We assume that pages that could be isolated for
+			 * migration are movable. But we don't actually try
+			 * isolating, as that would be expensive.
+			 */
+			if (PageLRU(page) || __PageMovable(page))
+				(*num_movable)++;
+			pfn++;
+		}
+	}
+
+	return true;
+}
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype,
-								num_movable);
+int move_freepages_block(struct zone *zone, struct page *page,
+			 int migratetype)
+{
+	unsigned long start_pfn, end_pfn;
+
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       NULL, NULL))
+		return -1;
+
+	return move_freepages(zone, start_pfn, end_pfn, migratetype);
 }
 
 /*
@@ -1776,33 +1803,36 @@ static inline bool boost_watermark(struct zone *zone)
 }
 
 /*
- * This function implements actual steal behaviour. If order is large enough,
- * we can steal whole pageblock. If not, we first move freepages in this
- * pageblock to our migratetype and determine how many already-allocated pages
- * are there in the pageblock with a compatible migratetype. If at least half
- * of pages are free or compatible, we can change migratetype of the pageblock
- * itself, so pages freed in the future will be put on the correct free list.
+ * This function implements actual steal behaviour. If order is large enough, we
+ * can claim the whole pageblock for the requested migratetype. If not, we check
+ * the pageblock for constituent pages; if at least half of the pages are free
+ * or compatible, we can still claim the whole block, so pages freed in the
+ * future will be put on the correct free list. Otherwise, we isolate exactly
+ * the order we need from the fallback block and leave its migratetype alone.
  */
 static void steal_suitable_fallback(struct zone *zone, struct page *page,
-		unsigned int alloc_flags, int start_type, bool whole_block)
+				    int current_order, int order, int start_type,
+				    unsigned int alloc_flags, bool whole_block)
 {
-	unsigned int current_order = buddy_order(page);
 	int free_pages, movable_pages, alike_pages;
-	int old_block_type;
+	unsigned long start_pfn, end_pfn;
+	int block_type;
 
-	old_block_type = get_pageblock_migratetype(page);
+	block_type = get_pageblock_migratetype(page);
 
 	/*
 	 * This can happen due to races and we want to prevent broken
 	 * highatomic accounting.
 	 */
-	if (is_migrate_highatomic(old_block_type))
+	if (is_migrate_highatomic(block_type))
 		goto single_page;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
+		del_page_from_free_list(page, zone, current_order);
 		change_pageblock_range(page, current_order, start_type);
-		goto single_page;
+		expand(zone, page, order, current_order, start_type);
+		return;
 	}
 
 	/*
@@ -1817,8 +1847,11 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (!whole_block)
 		goto single_page;
 
-	free_pages = move_freepages_block(zone, page, start_type,
-						&movable_pages);
+	/* moving whole block can fail due to zone boundary conditions */
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       &free_pages, &movable_pages))
+		goto single_page;
+
 	/*
 	 * Determine how many pages are compatible with our allocation.
 	 * For movable allocation, it's the number of movable pages which
@@ -1834,29 +1867,27 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 		 * vice versa, be conservative since we can't distinguish the
 		 * exact migratetype of non-movable pages.
 		 */
-		if (old_block_type == MIGRATE_MOVABLE)
+		if (block_type == MIGRATE_MOVABLE)
 			alike_pages = pageblock_nr_pages
 						- (free_pages + movable_pages);
 		else
 			alike_pages = 0;
 	}
 
-	/* moving whole block can fail due to zone boundary conditions */
-	if (!free_pages)
-		goto single_page;
-
 	/*
 	 * If a sufficient number of pages in the block are either free or of
 	 * comparable migratability as our allocation, claim the whole block.
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
-			page_group_by_mobility_disabled)
+			page_group_by_mobility_disabled) {
+		move_freepages(zone, start_pfn, end_pfn, start_type);
 		set_pageblock_migratetype(page, start_type);
-
-	return;
+		block_type = start_type;
+	}
 
 single_page:
-	move_to_free_list(page, zone, current_order, start_type);
+	del_page_from_free_list(page, zone, current_order);
+	expand(zone, page, order, current_order, block_type);
 }
 
 /*
@@ -1921,9 +1952,10 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
 	mt = get_pageblock_migratetype(page);
 	/* Only reserve normal pageblocks (i.e., they can merge with others) */
 	if (migratetype_is_mergeable(mt)) {
-		zone->nr_reserved_highatomic += pageblock_nr_pages;
-		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
-		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
+		if (move_freepages_block(zone, page, MIGRATE_HIGHATOMIC) != -1) {
+			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
+			zone->nr_reserved_highatomic += pageblock_nr_pages;
+		}
 	}
 
 out_unlock:
@@ -1948,7 +1980,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	struct zone *zone;
 	struct page *page;
 	int order;
-	bool ret;
+	int ret;
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
 								ac->nodemask) {
@@ -1997,10 +2029,14 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * of pageblocks that cannot be completely freed
 			 * may increase.
 			 */
+			ret = move_freepages_block(zone, page, ac->migratetype);
+			/*
+			 * Reserving this block already succeeded, so this should
+			 * not fail on zone boundaries.
+			 */
+			WARN_ON_ONCE(ret == -1);
 			set_pageblock_migratetype(page, ac->migratetype);
-			ret = move_freepages_block(zone, page, ac->migratetype,
-									NULL);
-			if (ret) {
+			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return ret;
 			}
@@ -2021,7 +2057,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
-static __always_inline bool
+static __always_inline struct page *
 __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
@@ -2068,7 +2104,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		goto do_steal;
 	}
 
-	return false;
+	return NULL;
 
 find_smallest:
 	for (current_order = order; current_order <= MAX_ORDER;
@@ -2089,13 +2125,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 do_steal:
 	page = get_page_from_free_area(area, fallback_mt);
 
-	steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
-								can_steal);
+	/* take off list, maybe claim block, expand remainder */
+	steal_suitable_fallback(zone, page, current_order, order,
+				start_migratetype, alloc_flags, can_steal);
 
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);
 
-	return true;
+	return page;
 
 }
 
@@ -2123,15 +2160,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 				return page;
 		}
 	}
-retry:
+
 	page = __rmqueue_smallest(zone, order, migratetype);
 	if (unlikely(!page)) {
 		if (alloc_flags & ALLOC_CMA)
 			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page && __rmqueue_fallback(zone, order, migratetype,
-								alloc_flags))
-			goto retry;
+		else
+			page = __rmqueue_fallback(zone, order, migratetype,
+						  alloc_flags);
 	}
 	return page;
 }
@@ -2586,12 +2622,10 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt)) {
-				set_pageblock_migratetype(page,
-							  MIGRATE_MOVABLE);
-				move_freepages_block(zone, page,
-						     MIGRATE_MOVABLE, NULL);
-			}
+			if (migratetype_is_mergeable(mt) &&
+			    move_freepages_block(zone, page,
+						 MIGRATE_MOVABLE) != -1)
+				set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		}
 	}
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6599cc965e21..f5e4d8676b36 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -178,15 +178,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		unsigned long nr_pages;
+		int nr_pages;
 		int mt = get_pageblock_migratetype(page);
 
+		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE);
+		/* Block spans zone boundaries? */
+		if (nr_pages == -1) {
+			spin_unlock_irqrestore(&zone->lock, flags);
+			return -EBUSY;
+		}
+		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
-									NULL);
-
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
 	}
@@ -206,7 +209,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 static void unset_migratetype_isolate(struct page *page, int migratetype)
 {
 	struct zone *zone;
-	unsigned long flags, nr_pages;
+	unsigned long flags;
 	bool isolated_page = false;
 	unsigned int order;
 	struct page *buddy;
@@ -252,7 +255,12 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 * allocation.
 	 */
 	if (!isolated_page) {
-		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
+		int nr_pages = move_freepages_block(zone, page, migratetype);
+		/*
+		 * Isolating this block already succeeded, so this
+		 * should not fail on zone boundaries.
+		 */
+		WARN_ON_ONCE(nr_pages == -1);
 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
 	}
 	set_pageblock_migratetype(page, migratetype);
-- 
2.41.0

