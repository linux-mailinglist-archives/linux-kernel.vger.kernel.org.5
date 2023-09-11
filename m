Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09779C020
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377890AbjIKW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbjIKTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:44 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA21A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-64cca551ae2so31102166d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461838; x=1695066638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU89p8TG5c7Q3Tc81fgPY+LY6pa0Rdp9Sv7NpbIR5yI=;
        b=mWgMzEHhtqe0g5uR3rQEE88xtioyXtvXsRgXa6ucAEEjOttof+gqkHPJLGlmZhQ91H
         I/jqCjHwcvpZpAwPw7OnFPRV2kbRdr5qD+lDhP5bjYL32CvVWqZF1iQIQai3Fej3b7HG
         3zasNx72Q86yyaK5qPiyRMNY/ano3FVL5e+zWNxBANzBx1sv8pNe9nmO/4BPBe05wqyJ
         fxcGgTr+X72F/xyqcbQzkUnOqJIwUmE3zvK0oIlxWbhoibU1b6N9xNEuzMsNKPXhqSsH
         J8eURqqcG939gM1WDEIscerRcaWIuuOfuSPKEQaYNr4/o5Eaf3Yfzrk2up3bo7j2rxv1
         yoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461838; x=1695066638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU89p8TG5c7Q3Tc81fgPY+LY6pa0Rdp9Sv7NpbIR5yI=;
        b=NoVNq2VAH6KpbJ4L1rgvx9i/gZy2HJhrLtgbFCvFhPkIG5mE2ustArmABflYepDAjR
         tnIziLi8PuUFtamsNaaN2GvylXbXsgnsH+dnei1OciYGPfwIqCEHYiu1H2s0MbF9B0e8
         P/h9zD0lQJ/x9l4+Gj3xHtKMN7YNDw/xh3ERVetXnv1YaIhWJNir80MUU1zFVy2+7O+8
         8mJ90DJwiLYUi7tgiJ7FdCjcSnmYbezhcXpM8pnunCUKzBDL2vZr5AyOHYiGpcG029PF
         YFNCqnjUFj+OXE9mA1YNY+xWTrkV//wJNW117rY8AmGe1DTOtdo90IU8+iqpCwIlGnlj
         FcWw==
X-Gm-Message-State: AOJu0YzrbtHZ46cyOaCEqJKUkjmNb7axLVpUFrpvhb+m6/nyXsoAlGOg
        VPwFrncR2/krSoUOtE4VOWaCjQ==
X-Google-Smtp-Source: AGHT+IH4M19lI0SDJVY6f78Lb3HcLcJw1JfP6kv4TxQN92+T5Gq5JV7EW0oHeoj0yCZP9Qf0W9+btw==
X-Received: by 2002:a0c:8cc1:0:b0:653:5b5e:7a96 with SMTP id q1-20020a0c8cc1000000b006535b5e7a96mr10400951qvb.1.1694461838052;
        Mon, 11 Sep 2023 12:50:38 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id o3-20020a0ce403000000b00653589babfcsm3146243qvl.132.2023.09.11.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:37 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm: page_alloc: fix freelist movement during block conversion
Date:   Mon, 11 Sep 2023 15:41:46 -0400
Message-ID: <20230911195023.247694-6-hannes@cmpxchg.org>
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
 mm/page_alloc.c                | 171 ++++++++++++++++++++-------------
 mm/page_isolation.c            |  22 +++--
 3 files changed, 118 insertions(+), 78 deletions(-)

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
index 5bbe5f3be5ad..a902593f16dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1601,9 +1601,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
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
@@ -1613,14 +1612,6 @@ static int move_freepages(struct zone *zone,
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
@@ -1638,26 +1629,62 @@ static int move_freepages(struct zone *zone,
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
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype,
-								num_movable);
+	return true;
+}
+
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
 
 static void change_pageblock_range(struct page *pageblock_page,
@@ -1742,33 +1769,36 @@ static inline bool boost_watermark(struct zone *zone)
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
@@ -1783,10 +1813,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (!whole_block)
 		goto single_page;
 
-	free_pages = move_freepages_block(zone, page, start_type,
-						&movable_pages);
 	/* moving whole block can fail due to zone boundary conditions */
-	if (!free_pages)
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       &free_pages, &movable_pages))
 		goto single_page;
 
 	/*
@@ -1804,7 +1833,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 		 * vice versa, be conservative since we can't distinguish the
 		 * exact migratetype of non-movable pages.
 		 */
-		if (old_block_type == MIGRATE_MOVABLE)
+		if (block_type == MIGRATE_MOVABLE)
 			alike_pages = pageblock_nr_pages
 						- (free_pages + movable_pages);
 		else
@@ -1815,13 +1844,15 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * compatible migratability as our allocation, claim the whole block.
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
@@ -1885,9 +1916,10 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
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
@@ -1912,7 +1944,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	struct zone *zone;
 	struct page *page;
 	int order;
-	bool ret;
+	int ret;
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
 								ac->nodemask) {
@@ -1961,10 +1993,14 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -1985,7 +2021,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
-static __always_inline bool
+static __always_inline struct page *
 __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
@@ -2032,7 +2068,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		goto do_steal;
 	}
 
-	return false;
+	return NULL;
 
 find_smallest:
 	for (current_order = order; current_order <= MAX_ORDER;
@@ -2053,14 +2089,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
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
-
+	return page;
 }
 
 /*
@@ -2087,15 +2123,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
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
@@ -2548,12 +2583,10 @@ int __isolate_free_page(struct page *page, unsigned int order)
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
index bcf99ba747a0..cc48a3a52f00 100644
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
2.42.0

