Return-Path: <linux-kernel+bounces-109283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27FD881720
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1DE28179C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4526F7350B;
	Wed, 20 Mar 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="jLziDhDA"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B56BB24
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957907; cv=none; b=sBfVy7qCOglHp/xYq0G3fCGHs8g5LZpLF0ygKkyYsYIjlXS4aPiLh1hLIM9t9urxg7OpueCHl5DeTMY9xA73FmeH9j9g06HsFYPITZ22yAbFefvIQcS1x9rLUtqyANT9oldjzspGBOPXO3STwX087t1M5AXbMvJdZpesA/l9wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957907; c=relaxed/simple;
	bh=jayebPO8ku15WWHvvCFAB3U+CsvIEHw/u/jVv7l6HCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gViJlTceEyshDM9kuSckRXlZNTkPQmx5Bmx7X/EdA9NyqAR+lhiarDxA0K+eOL6j9Ny05tf/ICcsrqAR43q9N41MKYvNm74q5PFyXNM0sh60G3QKiywUVCF4dJRk6xjRAz2lI/yg3EYdu80IOxK43IaHV07w46h9+c7hOufUo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=jLziDhDA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6969855c8so44567a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957904; x=1711562704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6EDIqJ3GpKNGgGvycU8kV/i4h8q8YkWCZkehwdTQBQ=;
        b=jLziDhDAvWl1IaW8emCTqQ02PqLB9SYDjwnyVmeayvngnIBESS7vBCUoubWhwMyU3Z
         DCzsM11CBXN1PEL7UPqMeAu8fcEFTDPvHaHS4bY3BAV50u35s9L5lQMimUVRyovimE+N
         JZqeRoP9s4DgPeTOC/OPLS009F/LQ+Ta5vNPAQD9+75NMTj2gqB4HWFTmoA4aCF7Vk2w
         ZA0uUysHpxk7Z0viiSDiTch7PJipQQ4RjTnI+baHcKREFEX23hKGJQniMYZP4E7Zbjxb
         g3Efbjzztts8Ce66UEUST/gNRt4aLVczVritcgEBU9liJCZGSen1PXp/oxOWfFz8zBBb
         cbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957904; x=1711562704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6EDIqJ3GpKNGgGvycU8kV/i4h8q8YkWCZkehwdTQBQ=;
        b=dNdHsxgfRxjX9DVHeJzfr31uxTVi94hsTrhhYH591+UfSG0suMmaIfZ54XrJeeYft4
         qZC94yYff3WkHU2zMswsqfovKtbH6AR5JB5zlD+OuqtuUgRJlFWgtm9X0e6wtkfanWDA
         3WNCEvfj6ZwRpkdseiEDEwsuPxx5vOgGwSm4FR1ZxGFZUYsKhSYDId/bDlddMxY1TSoc
         SYyk6GXLKX8ot63zFKpB3L8Wwv/y//IEVvVsVxrm7x83HMnqAV0p+GWJpIegeGkt/M6F
         NizeiQL7X0bOpWWRFA3lKD34IGAil7H9Gnod2yxivvewijiINO/udOaTkjZF7KHGhj3y
         +BHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfSSgzDLXiR5xq4MtekTf6n/Uxk72+feeW9GgxqUUk9+aesjeP3Tsn2SPNDXB+/A4U1VLIsf88b0pqna5/NaOn90eW5bzsHl3frrbe
X-Gm-Message-State: AOJu0Ywoxvm21Kg3sfrXGMR4DAoW1thSuR/dIRsGsfFq4zC6cEfa65Hf
	YJhq7s1BB42JXH5qnIpYGLqCETyivVHTn6FU/96hZ+9fKGr+fI+zrcSEcUgUesY=
X-Google-Smtp-Source: AGHT+IFWSemKRWWruL0QHrLgb/7FgdcOFthYCoNJGsppv1Ywv9Zl8jdZobhkbMs/1qULPD7k8iTkhQ==
X-Received: by 2002:a05:6830:1548:b0:6e6:84b4:5f35 with SMTP id l8-20020a056830154800b006e684b45f35mr6856475otp.8.1710957904362;
        Wed, 20 Mar 2024 11:05:04 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id gf15-20020a056214250f00b006912014b98dsm8137529qvb.129.2024.03.20.11.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:05:03 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] mm: page_isolation: prepare for hygienic freelists
Date: Wed, 20 Mar 2024 14:02:14 -0400
Message-ID: <20240320180429.678181-10-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page isolation currently sets MIGRATE_ISOLATE on a block, then drops
zone->lock and scans the block for straddling buddies to split
up. Because this happens non-atomically wrt the page allocator, it's
possible for allocations to get a buddy whose first block is a regular
pcp migratetype but whose tail is isolated. This means that in certain
cases memory can still be allocated after isolation. It will also
trigger the freelist type hygiene warnings in subsequent patches.

start_isolate_page_range()
  isolate_single_pageblock()
    set_migratetype_isolate(tail)
      lock zone->lock
      move_freepages_block(tail) // nop
      set_pageblock_migratetype(tail)
      unlock zone->lock
                                                     __rmqueue_smallest()
                                                       del_page_from_freelist(head)
                                                       expand(head, head_mt)
                                                         WARN(head_mt != tail_mt)
    start_pfn = ALIGN_DOWN(MAX_ORDER_NR_PAGES)
    for (pfn = start_pfn, pfn < end_pfn)
      if (PageBuddy())
        split_free_page(head)

Introduce a variant of move_freepages_block() provided by the
allocator specifically for page isolation; it moves free pages,
converts the block, and handles the splitting of straddling buddies
while holding zone->lock.

The allocator knows that pageblocks and buddies are always naturally
aligned, which means that buddies can only straddle blocks if they're
actually >pageblock_order. This means the search-and-split part can be
simplified compared to what page isolation used to do.

Also tighten up the page isolation code around the expectations of
which pages can be large, and how they are freed.

Based on extensive discussions with and invaluable input from Zi Yan.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   4 -
 mm/page_alloc.c                | 200 +++++++++++++++++++--------------
 mm/page_isolation.c            | 106 ++++++-----------
 4 files changed, 151 insertions(+), 163 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 8550b3c91480..c16db0067090 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,7 +34,9 @@ static inline bool is_migrate_isolate(int migratetype)
 #define REPORT_FAILURE	0x2
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
-int move_freepages_block(struct zone *zone, struct page *page, int migratetype);
+
+bool move_freepages_block_isolate(struct zone *zone, struct page *page,
+				  int migratetype);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/internal.h b/mm/internal.h
index f8b31234c130..d6e6c7d9f04e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -559,10 +559,6 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
 		unsigned long, enum meminit_context, struct vmem_altmap *, int);
 
-
-int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset);
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d687f27d891f..efb2581ac142 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -832,64 +832,6 @@ static inline void __free_one_page(struct page *page,
 		page_reporting_notify_free(order);
 }
 
-/**
- * split_free_page() -- split a free page at split_pfn_offset
- * @free_page:		the original free page
- * @order:		the order of the page
- * @split_pfn_offset:	split offset within the page
- *
- * Return -ENOENT if the free page is changed, otherwise 0
- *
- * It is used when the free page crosses two pageblocks with different migratetypes
- * at split_pfn_offset within the page. The split free page will be put into
- * separate migratetype lists afterwards. Otherwise, the function achieves
- * nothing.
- */
-int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset)
-{
-	struct zone *zone = page_zone(free_page);
-	unsigned long free_page_pfn = page_to_pfn(free_page);
-	unsigned long pfn;
-	unsigned long flags;
-	int free_page_order;
-	int mt;
-	int ret = 0;
-
-	if (split_pfn_offset == 0)
-		return ret;
-
-	spin_lock_irqsave(&zone->lock, flags);
-
-	if (!PageBuddy(free_page) || buddy_order(free_page) != order) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
-	if (likely(!is_migrate_isolate(mt)))
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
-
-	del_page_from_free_list(free_page, zone, order);
-	for (pfn = free_page_pfn;
-	     pfn < free_page_pfn + (1UL << order);) {
-		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
-
-		free_page_order = min_t(unsigned int,
-					pfn ? __ffs(pfn) : order,
-					__fls(split_pfn_offset));
-		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
-				mt, FPI_NONE);
-		pfn += 1UL << free_page_order;
-		split_pfn_offset -= (1UL << free_page_order);
-		/* we have done the first part, now switch to second part */
-		if (split_pfn_offset == 0)
-			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
-	}
-out:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return ret;
-}
 /*
  * A bad page could be due to a number of fields. Instead of multiple branches,
  * try and check multiple fields with one check. The caller must do a detailed
@@ -1669,8 +1611,8 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 	return true;
 }
 
-int move_freepages_block(struct zone *zone, struct page *page,
-			 int migratetype)
+static int move_freepages_block(struct zone *zone, struct page *page,
+				int migratetype)
 {
 	unsigned long start_pfn, end_pfn;
 
@@ -1681,6 +1623,119 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	return move_freepages(zone, start_pfn, end_pfn, migratetype);
 }
 
+#ifdef CONFIG_MEMORY_ISOLATION
+/* Look for a buddy that straddles start_pfn */
+static unsigned long find_large_buddy(unsigned long start_pfn)
+{
+	int order = 0;
+	struct page *page;
+	unsigned long pfn = start_pfn;
+
+	while (!PageBuddy(page = pfn_to_page(pfn))) {
+		/* Nothing found */
+		if (++order > MAX_PAGE_ORDER)
+			return start_pfn;
+		pfn &= ~0UL << order;
+	}
+
+	/*
+	 * Found a preceding buddy, but does it straddle?
+	 */
+	if (pfn + (1 << buddy_order(page)) > start_pfn)
+		return pfn;
+
+	/* Nothing found */
+	return start_pfn;
+}
+
+/* Split a multi-block free page into its individual pageblocks */
+static void split_large_buddy(struct zone *zone, struct page *page,
+			      unsigned long pfn, int order)
+{
+	unsigned long end_pfn = pfn + (1 << order);
+
+	VM_WARN_ON_ONCE(order <= pageblock_order);
+	VM_WARN_ON_ONCE(pfn & (pageblock_nr_pages - 1));
+
+	/* Caller removed page from freelist, buddy info cleared! */
+	VM_WARN_ON_ONCE(PageBuddy(page));
+
+	while (pfn != end_pfn) {
+		int mt = get_pfnblock_migratetype(page, pfn);
+
+		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE);
+		pfn += pageblock_nr_pages;
+		page = pfn_to_page(pfn);
+	}
+}
+
+/**
+ * move_freepages_block_isolate - move free pages in block for page isolation
+ * @zone: the zone
+ * @page: the pageblock page
+ * @migratetype: migratetype to set on the pageblock
+ *
+ * This is similar to move_freepages_block(), but handles the special
+ * case encountered in page isolation, where the block of interest
+ * might be part of a larger buddy spanning multiple pageblocks.
+ *
+ * Unlike the regular page allocator path, which moves pages while
+ * stealing buddies off the freelist, page isolation is interested in
+ * arbitrary pfn ranges that may have overlapping buddies on both ends.
+ *
+ * This function handles that. Straddling buddies are split into
+ * individual pageblocks. Only the block of interest is moved.
+ *
+ * Returns %true if pages could be moved, %false otherwise.
+ */
+bool move_freepages_block_isolate(struct zone *zone, struct page *page,
+				  int migratetype)
+{
+	unsigned long start_pfn, end_pfn, pfn;
+	int nr_moved, mt;
+
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       NULL, NULL))
+		return false;
+
+	/* We're a tail block in a larger buddy */
+	pfn = find_large_buddy(start_pfn);
+	if (pfn != start_pfn) {
+		struct page *buddy = pfn_to_page(pfn);
+		int order = buddy_order(buddy);
+		int mt = get_pfnblock_migratetype(buddy, pfn);
+
+		if (!is_migrate_isolate(mt))
+			__mod_zone_freepage_state(zone, -(1UL << order), mt);
+		del_page_from_free_list(buddy, zone, order);
+		set_pageblock_migratetype(page, migratetype);
+		split_large_buddy(zone, buddy, pfn, order);
+		return true;
+	}
+
+	/* We're the starting block of a larger buddy */
+	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
+		int mt = get_pfnblock_migratetype(page, pfn);
+		int order = buddy_order(page);
+
+		if (!is_migrate_isolate(mt))
+			__mod_zone_freepage_state(zone, -(1UL << order), mt);
+		del_page_from_free_list(page, zone, order);
+		set_pageblock_migratetype(page, migratetype);
+		split_large_buddy(zone, page, pfn, order);
+		return true;
+	}
+
+	mt = get_pfnblock_migratetype(page, start_pfn);
+	nr_moved = move_freepages(zone, start_pfn, end_pfn, migratetype);
+	if (!is_migrate_isolate(mt))
+		__mod_zone_freepage_state(zone, -nr_moved, mt);
+	else if (!is_migrate_isolate(migratetype))
+		__mod_zone_freepage_state(zone, nr_moved, migratetype);
+	return true;
+}
+#endif /* CONFIG_MEMORY_ISOLATION */
+
 static void change_pageblock_range(struct page *pageblock_page,
 					int start_order, int migratetype)
 {
@@ -6390,7 +6445,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	int order;
 	int ret = 0;
 
 	struct compact_control cc = {
@@ -6463,29 +6517,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * We don't have to hold zone->lock here because the pages are
 	 * isolated thus they won't get removed from buddy.
 	 */
-
-	order = 0;
-	outer_start = start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_PAGE_ORDER) {
-			outer_start = start;
-			break;
-		}
-		outer_start &= ~0UL << order;
-	}
-
-	if (outer_start != start) {
-		order = buddy_order(pfn_to_page(outer_start));
-
-		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
-		 */
-		if (outer_start + (1UL << order) <= start)
-			outer_start = start;
-	}
+	outer_start = find_large_buddy(start);
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, 0)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f84f0981b2df..042937d5abe4 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -178,16 +178,10 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		int nr_pages;
-		int mt = get_pageblock_migratetype(page);
-
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE);
-		/* Block spans zone boundaries? */
-		if (nr_pages == -1) {
+		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -254,13 +248,11 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 * allocation.
 	 */
 	if (!isolated_page) {
-		int nr_pages = move_freepages_block(zone, page, migratetype);
 		/*
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(nr_pages == -1);
-		__mod_zone_freepage_state(zone, nr_pages, migratetype);
+		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
 	} else {
 		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
@@ -374,26 +366,29 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 
 		VM_BUG_ON(!page);
 		pfn = page_to_pfn(page);
-		/*
-		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
-		 * free pages in [start_pfn, boundary_pfn), its head page will
-		 * always be in the range.
-		 */
+
 		if (PageBuddy(page)) {
 			int order = buddy_order(page);
 
-			if (pfn + (1UL << order) > boundary_pfn) {
-				/* free page changed before split, check it again */
-				if (split_free_page(page, order, boundary_pfn - pfn))
-					continue;
-			}
+			/* move_freepages_block_isolate() handled this */
+			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
 
 			pfn += 1UL << order;
 			continue;
 		}
+
 		/*
-		 * migrate compound pages then let the free page handling code
-		 * above do the rest. If migration is not possible, just fail.
+		 * If a compound page is straddling our block, attempt
+		 * to migrate it out of the way.
+		 *
+		 * We don't have to worry about this creating a large
+		 * free page that straddles into our block: gigantic
+		 * pages are freed as order-0 chunks, and LRU pages
+		 * (currently) do not exceed pageblock_order.
+		 *
+		 * The block of interest has already been marked
+		 * MIGRATE_ISOLATE above, so when migration is done it
+		 * will free its pages onto the correct freelists.
 		 */
 		if (PageCompound(page)) {
 			struct page *head = compound_head(page);
@@ -404,16 +399,10 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				pfn = head_pfn + nr_pages;
 				continue;
 			}
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
-			/*
-			 * hugetlb, lru compound (THP), and movable compound pages
-			 * can be migrated. Otherwise, fail the isolation.
-			 */
-			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
-				int order;
-				unsigned long outer_pfn;
+			if (PageHuge(page)) {
 				int page_mt = get_pageblock_migratetype(page);
-				bool isolate_page = !is_migrate_isolate_page(page);
 				struct compact_control cc = {
 					.nr_migratepages = 0,
 					.order = -1,
@@ -426,56 +415,25 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				};
 				INIT_LIST_HEAD(&cc.migratepages);
 
-				/*
-				 * XXX: mark the page as MIGRATE_ISOLATE so that
-				 * no one else can grab the freed page after migration.
-				 * Ideally, the page should be freed as two separate
-				 * pages to be added into separate migratetype free
-				 * lists.
-				 */
-				if (isolate_page) {
-					ret = set_migratetype_isolate(page, page_mt,
-						flags, head_pfn, head_pfn + nr_pages);
-					if (ret)
-						goto failed;
-				}
-
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
 							head_pfn + nr_pages, page_mt);
-
-				/*
-				 * restore the page's migratetype so that it can
-				 * be split into separate migratetype free lists
-				 * later.
-				 */
-				if (isolate_page)
-					unset_migratetype_isolate(page, page_mt);
-
 				if (ret)
 					goto failed;
-				/*
-				 * reset pfn to the head of the free page, so
-				 * that the free page handling code above can split
-				 * the free page to the right migratetype list.
-				 *
-				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_PAGE_ORDER, but after it is
-				 * freed, the free page order is not. Use pfn within
-				 * the range to find the head of the free page.
-				 */
-				order = 0;
-				outer_pfn = pfn;
-				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					/* stop if we cannot find the free page */
-					if (++order > MAX_PAGE_ORDER)
-						goto failed;
-					outer_pfn &= ~0UL << order;
-				}
-				pfn = outer_pfn;
+				pfn = head_pfn + nr_pages;
 				continue;
-			} else
+			}
+
+			/*
+			 * These pages are movable too, but they're
+			 * not expected to exceed pageblock_order.
+			 *
+			 * Let us know when they do, so we can add
+			 * proper free and split handling for them.
+			 */
+			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
+			VM_WARN_ON_ONCE_PAGE(__PageMovable(page), page);
 #endif
-				goto failed;
+			goto failed;
 		}
 
 		pfn++;
-- 
2.44.0


