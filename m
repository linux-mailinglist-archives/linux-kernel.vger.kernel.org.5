Return-Path: <linux-kernel+bounces-93318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC61872DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F86E28C2DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982117BC5;
	Wed,  6 Mar 2024 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="K7PtJSuK"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1B1BC4A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698591; cv=none; b=RVk2xkQMWDnLwRQZKvDdotFBOjCCtAGRmFCB7oEJrKK+NIMJ3BoJ904WCJ3w9YNvMG30qFyJbO7f3QC2AbRTeYaONUJHGqegZYLMr330eumTuc1Z5RiHGXDxhUjHojk6MiTiCvHU7MPBFtd3wXoNVROukLeukI/glfMsfvs5NxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698591; c=relaxed/simple;
	bh=EZ5xlN9F24HLZEexd83GzWUxnCifac2GOPFdap/UrtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB/YOW9GWHn99DglcVTkVOi/IxO3q4yAMVzEkIfFRtqxi201I0ImGcVz52K0KoRGQYXqdoB1mTnYSqD/u1RSkU/TrlYRGu2yVymvVh711E/Ggrv3dZZeFGIx04kIRTDjcRkJw05TstIBkpHkKeFZwig4Gzqn8EQ+n0MbRNr6N4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=K7PtJSuK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a029c8e62so50049561cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698588; x=1710303388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOxJcdsW+fkh1fTmaf28JkWR8jDRw9yVS7tVyo6ygLc=;
        b=K7PtJSuKVGh9s5oKCrvgPj3nn387yv8UBOEDR6ZV/cQLMOocHuI45m+hSeyJZw/mgC
         BFXxYgB694lM2zBR9nNF5YAIfLIV7frJVEYkiM3939/h6cZf6ZrRZIy8y2HYwVYlYsDt
         cy1eJaXblMBW/kBIvtHnmOh79Y7YI2Tk0qtRPB1B4tzCWD+ioK5jG5kx2X91/Cqp2tKY
         enq9vYcurpNEDmr3I0bKaw5I9PPHI7l9IvqrXeYOTwjGpA/UlJwiZ/wijlkN+xQMGk68
         BYsgUKhslgE3wFDVchjZoLwObBs6qmUUl3NqEbM8ToiCz7AmddSg+JYbHKZOkFYeIry/
         VZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698588; x=1710303388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOxJcdsW+fkh1fTmaf28JkWR8jDRw9yVS7tVyo6ygLc=;
        b=f7uWLok8zbMTYm47h7reHxIG2DtoFVzy2Ylx0F/6tMaQ8MvIQ2z0SBC9eU51WRuKPi
         k8HNelkOuAS+Ncm6N8h5A8SPsMbD+48888DPiPUHLdw+KVwRN7tf/LJdorO3xdPa+qcA
         puZVMsSGJYuZtuyXVCZhxMN0DKCV3s2FGqB8qPdGqYKBHqzm/0PnHqc9whHYXNbJp7Yv
         tYH5JZGuIiZ0QelmSvIREKsVMIlrMjm6a49dWRB6pSCzVmMTEYZ4ynFeC1u6KWuxkihs
         YqZwPU0kM6UbSfKF6XJPQNHMd5sZVF1RIRB8YyWMlCLpc+CcjxmONPNu96oo0QBOnhF9
         EwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwUCv+GDhuw39wN/suDzI5X+lc5nrGBtGYYDrEVzTuc/yYK5Te3APwssPGK7ppgp69f7p49wDSPtlp44ezT0Czt9xIMe4KmGM8GpqY
X-Gm-Message-State: AOJu0YzeRBkNxTENBe6iGRJdjKousyiLVZLaj8jOE5rzyn7cBTtVoqEa
	u4ETZPAgTuZSv2nvPSo05rGsGUbgPHh5JktBGMK74xdBePjwXbFaU2cYPl2RuOk=
X-Google-Smtp-Source: AGHT+IFJvT3s0a3iT7I+hclpblwvoPOqaKROp/uBLu39M5KRQh7DpEKmnGy5yCCJ2YIyvBlrTk3AJw==
X-Received: by 2002:a05:622a:653:b0:42f:10a9:e8df with SMTP id a19-20020a05622a065300b0042f10a9e8dfmr324741qtb.11.1709698588166;
        Tue, 05 Mar 2024 20:16:28 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id l2-20020ac80782000000b0042eef746ef7sm2795888qth.9.2024.03.05.20.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:27 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] mm: page_alloc: fix freelist movement during block conversion
Date: Tue,  5 Mar 2024 23:08:37 -0500
Message-ID: <20240306041526.892167-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h |   3 +-
 mm/page_alloc.c                | 175 ++++++++++++++++++++-------------
 mm/page_isolation.c            |  22 +++--
 3 files changed, 121 insertions(+), 79 deletions(-)

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
index 787ae3f0ac06..9cf7ed0c4cd6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1596,9 +1596,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
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
@@ -1608,14 +1607,6 @@ static int move_freepages(struct zone *zone,
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
@@ -1633,17 +1624,16 @@ static int move_freepages(struct zone *zone,
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
 
 	/*
 	 * The caller only has the lock for @zone, don't touch ranges
@@ -1652,13 +1642,50 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	 * accompanied by other operations such as migratetype updates
 	 * which also should be locked.
 	 */
-	if (!zone_spans_pfn(zone, start_pfn))
-		return 0;
-	if (!zone_spans_pfn(zone, end_pfn))
-		return 0;
+	if (!zone_spans_pfn(zone, start))
+		return false;
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
+
+int move_freepages_block(struct zone *zone, struct page *page,
+			 int migratetype)
+{
+	unsigned long start_pfn, end_pfn;
+
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       NULL, NULL))
+		return -1;
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype,
-								num_movable);
+	return move_freepages(zone, start_pfn, end_pfn, migratetype);
 }
 
 static void change_pageblock_range(struct page *pageblock_page,
@@ -1743,33 +1770,37 @@ static inline bool boost_watermark(struct zone *zone)
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
-static void steal_suitable_fallback(struct zone *zone, struct page *page,
-		unsigned int alloc_flags, int start_type, bool whole_block)
+static struct page *
+steal_suitable_fallback(struct zone *zone, struct page *page,
+			int current_order, int order, int start_type,
+			unsigned int alloc_flags, bool whole_block)
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
+		return page;
 	}
 
 	/*
@@ -1784,10 +1815,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
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
@@ -1805,7 +1835,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 		 * vice versa, be conservative since we can't distinguish the
 		 * exact migratetype of non-movable pages.
 		 */
-		if (old_block_type == MIGRATE_MOVABLE)
+		if (block_type == MIGRATE_MOVABLE)
 			alike_pages = pageblock_nr_pages
 						- (free_pages + movable_pages);
 		else
@@ -1816,13 +1846,16 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * compatible migratability as our allocation, claim the whole block.
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
-			page_group_by_mobility_disabled)
+			page_group_by_mobility_disabled) {
+		move_freepages(zone, start_pfn, end_pfn, start_type);
 		set_pageblock_migratetype(page, start_type);
-
-	return;
+		return __rmqueue_smallest(zone, order, start_type);
+	}
 
 single_page:
-	move_to_free_list(page, zone, current_order, start_type);
+	del_page_from_free_list(page, zone, current_order);
+	expand(zone, page, order, current_order, block_type);
+	return page;
 }
 
 /*
@@ -1890,9 +1923,10 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
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
@@ -1917,7 +1951,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 	struct zone *zone;
 	struct page *page;
 	int order;
-	bool ret;
+	int ret;
 
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
 								ac->nodemask) {
@@ -1966,10 +2000,14 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -1990,7 +2028,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
-static __always_inline bool
+static __always_inline struct page *
 __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
@@ -2037,7 +2075,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		goto do_steal;
 	}
 
-	return false;
+	return NULL;
 
 find_smallest:
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
@@ -2057,14 +2095,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 do_steal:
 	page = get_page_from_free_area(area, fallback_mt);
 
-	steal_suitable_fallback(zone, page, alloc_flags, start_migratetype,
-								can_steal);
+	/* take off list, maybe claim block, expand remainder */
+	page = steal_suitable_fallback(zone, page, current_order, order,
+				       start_migratetype, alloc_flags, can_steal);
 
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);
 
-	return true;
-
+	return page;
 }
 
 #ifdef CONFIG_CMA
@@ -2127,15 +2165,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
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
@@ -2672,12 +2709,10 @@ int __isolate_free_page(struct page *page, unsigned int order)
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
index a5c8fa4c2a75..71539d7b96cf 100644
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
2.44.0


