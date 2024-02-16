Return-Path: <linux-kernel+bounces-69015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74785836D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51641285955
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3660130AD8;
	Fri, 16 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="DzxWotRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoE+JqiG"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD199131E30
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103096; cv=none; b=Jp4YULSkU8svqzDtvSeLZMV/gd0Vww+pNj0BHJfyl161sIUf89pDdkKVJVjF4mVPABrRPf/UlOfdAYEc88tx18w85d19LtMX9Fk3UONGXjmefFYfQ3m4U2ea6d296bCmIiQ8j4Oj2XGDCuM3L/22VykEJkHsQyH4Pqf7sFRMnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103096; c=relaxed/simple;
	bh=DR0lbFckfNuZyhKLKn76lt6oQdPrjkuWzMVEgeHd3OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVwiUG9im2eCFpxz+lpaNKoiUDHq4f5F5f7deetAWymAHbSG25jJnyrgz11aUAjKRzeC6HoSvxfieCIVVN486ppfYkTUZZr4CiwGV4VKZBjZM3X8uYrikUeiTj9ftyJp1PzW5kxDIq6VwGHwuVD80Bb8++66yeJj6twZnrUD8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=DzxWotRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GoE+JqiG; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E46E65C0098;
	Fri, 16 Feb 2024 12:04:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Feb 2024 12:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708103092; x=1708189492; bh=nIAYvnltZL3ZJbh/6F5gZLxtE16cArxedAx
	xW1cUxBU=; b=DzxWotRLufx7pv4QtallMVp2YEhd4si5FmDqgrVdN/IovF6MWz6
	1O0nY1q731gXgns3Hr3abKIdATemnOGe9cPD0sm6QdMjCMK/sne8hwftBGMvHbSG
	5hhPfp6fAeMX6zWr/1NhDEPyqQYfbV//nsZH0bTr1OIkR5EMMZ+SmFJKWnFoKa+r
	s/akEobIzNQSi6TlVEINqok9DIR7/9QBKTRwCYArmv7ZtQu//y0E9OeKAu9ZGU0x
	NHmxIwy21fqvlEPxTRVdFNHmpvEr4ywyq1zLEMHKvDDOJTPZw0G4NHi1Ac6Elf5H
	NoYkNyU8PTgj7WeU+XwZWyBgLVV59IFbQPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708103092; x=1708189492; bh=nIAYvnltZL3ZJbh/6F5gZLxtE16cArxedAx
	xW1cUxBU=; b=GoE+JqiG+iW4WKDPXvVRv2LPw/D1mtJ9WjAy9VG6serbIkjmZ/G
	+/26VHVVwYgc2NwIU6IgKks0sC1QGa1gAB58aj3TP9S+w9HZQScnFDgurCKchrII
	DgL6YBrf5kWArHBKs6qLK0FnBsMqPc+BG8TZ0IZG7WfJdNleBfopCmXii6hRHOiK
	/xNfJmo7P4QgrwZcDJPt4AwtQv5wsfB8Mrqc4bDzOqVvtdAT6dMz6B2X2LQkakzD
	5RuRGF7Guybp+ORIf9tLocFE6JCimXDDRUSBopG44tTTHx8Fhi9c7PYFM/vt/zx1
	z5eJbHRVTfNpoGpGWt6sbWri9v2Uk9FIrow==
X-ME-Sender: <xms:s5XPZQhFHtGgv3e0GrY96-y3gEfP648lIVnpfYr0zGbJsv8gjLJv6A>
    <xme:s5XPZZCwPheCZR5dCV0QVX70H1SQspbWUt3PFQNJ4wh92HTzX3e537GdcAGerZGfa
    2_g7n3OrwDMgktLwQ>
X-ME-Received: <xmr:s5XPZYHlctTKjXjxNBuT_cAgm_drZ64li6Mpvrvlf3bDbXr-15Ot4ALEynik0CDM43dqAJeDsOveJ9HN9VYrYGenWks_Q9Jh44UyPPS2jOxggkPpewUoDSoF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:s5XPZRQK7WSEEKcyqAJr4mdkCdzzROM4MYfiGoHb0YPY3lTj9nz60w>
    <xmx:s5XPZdwGr84uTKnZi9kdvALWZagphZBKykdnCgwLGcTlFUK8_YqC6w>
    <xmx:s5XPZf4vZtz7zJyiLiO1-jg7Jph8zI1QmVeLsBZwAJyHxmKfX-dSLg>
    <xmx:tJXPZeoUH8xXLSatcHK2xGhcCPd-0BDgS0MrRHrfsECUu_O7i1g3lg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 12:04:50 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 3/4] mm/compaction: add support for >0 order folio memory compaction.
Date: Fri, 16 Feb 2024 12:04:31 -0500
Message-ID: <20240216170432.1268753-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216170432.1268753-1-zi.yan@sent.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Before last commit, memory compaction only migrates order-0 folios and
skips >0 order folios.  Last commit splits all >0 order folios during
compaction.  This commit migrates >0 order folios during compaction by
keeping isolated free pages at their original size without splitting them
into order-0 pages and using them directly during migration process.

What is different from the prior implementation:
1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
   lists, where each page list stores free pages in the same order.
2. All free pages are not post_alloc_hook() processed nor buddy pages,
   although their orders are stored in first page's private like buddy
   pages.
3. During migration, in new page allocation time (i.e., in
   compaction_alloc()), free pages are then processed by post_alloc_hook().
   When migration fails and a new page is returned (i.e., in
   compaction_free()), free pages are restored by reversing the
   post_alloc_hook() operations using newly added
   free_pages_prepare_fpi_none().

Step 3 is done for a latter optimization that splitting and/or merging
free pages during compaction becomes easier.

Note: without splitting free pages, compaction can end prematurely due to
migration will return -ENOMEM even if there is free pages.  This happens
when no order-0 free page exist and compaction_alloc() return NULL.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Yu Zhao <yuzhao@google.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/compaction.c | 140 +++++++++++++++++++++++++++---------------------
 mm/internal.h   |   4 +-
 mm/page_alloc.c |   2 +-
 3 files changed, 83 insertions(+), 63 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index aa6aad805c4d..f21836ca243a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -66,45 +66,56 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
-static unsigned long release_freepages(struct list_head *freelist)
+static void split_map_pages(struct list_head *freepages)
 {
+	unsigned int i, order;
 	struct page *page, *next;
-	unsigned long high_pfn = 0;
+	LIST_HEAD(tmp_list);
 
-	list_for_each_entry_safe(page, next, freelist, lru) {
-		unsigned long pfn = page_to_pfn(page);
-		list_del(&page->lru);
-		__free_page(page);
-		if (pfn > high_pfn)
-			high_pfn = pfn;
-	}
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
+		list_for_each_entry_safe(page, next, &freepages[order], lru) {
+			unsigned int nr_pages;
 
-	return high_pfn;
+			list_del(&page->lru);
+
+			nr_pages = 1 << order;
+
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			if (order)
+				split_page(page, order);
+
+			for (i = 0; i < nr_pages; i++) {
+				list_add(&page->lru, &tmp_list);
+				page++;
+			}
+		}
+		list_splice_init(&tmp_list, &freepages[0]);
+	}
 }
 
-static void split_map_pages(struct list_head *list)
+static unsigned long release_free_list(struct list_head *freepages)
 {
-	unsigned int i, order, nr_pages;
-	struct page *page, *next;
-	LIST_HEAD(tmp_list);
-
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
+	int order;
+	unsigned long high_pfn = 0;
 
-		order = page_private(page);
-		nr_pages = 1 << order;
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
+		struct page *page, *next;
 
-		post_alloc_hook(page, order, __GFP_MOVABLE);
-		if (order)
-			split_page(page, order);
+		list_for_each_entry_safe(page, next, &freepages[order], lru) {
+			unsigned long pfn = page_to_pfn(page);
 
-		for (i = 0; i < nr_pages; i++) {
-			list_add(&page->lru, &tmp_list);
-			page++;
+			list_del(&page->lru);
+			/*
+			 * Convert free pages into post allocation pages, so
+			 * that we can free them via __free_page.
+			 */
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			__free_pages(page, order);
+			if (pfn > high_pfn)
+				high_pfn = pfn;
 		}
 	}
-
-	list_splice(&tmp_list, list);
+	return high_pfn;
 }
 
 #ifdef CONFIG_COMPACTION
@@ -657,7 +668,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		nr_scanned += isolated - 1;
 		total_isolated += isolated;
 		cc->nr_freepages += isolated;
-		list_add_tail(&page->lru, freelist);
+		list_add_tail(&page->lru, &freelist[order]);
 
 		if (!strict && cc->nr_migratepages <= cc->nr_freepages) {
 			blockpfn += isolated;
@@ -722,7 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
 			unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
-	LIST_HEAD(freelist);
+	int order;
+	struct list_head tmp_freepages[NR_PAGE_ORDERS];
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
+		INIT_LIST_HEAD(&tmp_freepages[order]);
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -753,7 +768,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, &freelist, 0, true);
+					block_end_pfn, tmp_freepages, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -770,15 +785,15 @@ isolate_freepages_range(struct compact_control *cc,
 		 */
 	}
 
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(&freelist);
-
 	if (pfn < end_pfn) {
 		/* Loop terminated early, cleanup. */
-		release_freepages(&freelist);
+		release_free_list(tmp_freepages);
 		return 0;
 	}
 
+	/* __isolate_free_page() does not map the pages */
+	split_map_pages(tmp_freepages);
+
 	/* We don't use freelists for anything. */
 	return pfn;
 }
@@ -1494,7 +1509,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	if (!page)
 		return;
 
-	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
+	isolate_freepages_block(cc, &start_pfn, end_pfn, cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
 	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
@@ -1623,7 +1638,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				nr_scanned += nr_isolated - 1;
 				total_isolated += nr_isolated;
 				cc->nr_freepages += nr_isolated;
-				list_add_tail(&page->lru, &cc->freepages);
+				list_add_tail(&page->lru, &cc->freepages[order]);
 				count_compact_events(COMPACTISOLATED, nr_isolated);
 			} else {
 				/* If isolation fails, abort the search */
@@ -1700,13 +1715,12 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
 	unsigned long block_end_pfn;	/* end of current pageblock */
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
-	struct list_head *freelist = &cc->freepages;
 	unsigned int stride;
 
 	/* Try a small search of the free lists for a candidate */
 	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
-		goto splitmap;
+		return;
 
 	/*
 	 * Initialise the free scanner. The starting point is where we last
@@ -1766,7 +1780,7 @@ static void isolate_freepages(struct compact_control *cc)
 
 		/* Found a block suitable for isolating free pages from. */
 		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, freelist, stride, false);
+					block_end_pfn, cc->freepages, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn == block_end_pfn)
@@ -1807,10 +1821,6 @@ static void isolate_freepages(struct compact_control *cc)
 	 * and the loop terminated due to isolate_start_pfn < low_pfn
 	 */
 	cc->free_pfn = isolate_start_pfn;
-
-splitmap:
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(freelist);
 }
 
 /*
@@ -1821,24 +1831,22 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
+	int order = folio_order(src);
 
-	/* this makes migrate_pages() split the source page and retry */
-	if (folio_test_large(src) > 0)
-		return NULL;
-
-	if (list_empty(&cc->freepages)) {
+	if (list_empty(&cc->freepages[order])) {
 		isolate_freepages(cc);
-
-		if (list_empty(&cc->freepages))
+		if (list_empty(&cc->freepages[order]))
 			return NULL;
 	}
 
-	dst = list_entry(cc->freepages.next, struct folio, lru);
+	dst = list_first_entry(&cc->freepages[order], struct folio, lru);
 	list_del(&dst->lru);
-	cc->nr_freepages--;
-	cc->nr_migratepages -= 1 << folio_order(src);
-
-	return dst;
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	if (order)
+		prep_compound_page(&dst->page, order);
+	cc->nr_freepages -= 1 << order;
+	cc->nr_migratepages -= 1 << order;
+	return page_rmappable_folio(&dst->page);
 }
 
 /*
@@ -1849,10 +1857,19 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 static void compaction_free(struct folio *dst, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
+	int order = folio_order(dst);
+	struct page *page = &dst->page;
 
-	list_add(&dst->lru, &cc->freepages);
-	cc->nr_freepages++;
-	cc->nr_migratepages += 1 << folio_order(dst);
+	if (folio_put_testzero(dst)) {
+		free_pages_prepare(page, order);
+		list_add(&dst->lru, &cc->freepages[order]);
+		cc->nr_freepages += 1 << order;
+	}
+	cc->nr_migratepages += 1 << order;
+	/*
+	 * someone else has referenced the page, we cannot take it back to our
+	 * free list.
+	 */
 }
 
 /* possible outcome of isolate_migratepages */
@@ -2476,6 +2493,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
 	unsigned int nr_succeeded = 0;
+	int order;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2485,7 +2503,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	cc->total_free_scanned = 0;
 	cc->nr_migratepages = 0;
 	cc->nr_freepages = 0;
-	INIT_LIST_HEAD(&cc->freepages);
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
+		INIT_LIST_HEAD(&cc->freepages[order]);
 	INIT_LIST_HEAD(&cc->migratepages);
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
@@ -2671,7 +2690,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	 * so we don't leave any returned pages behind in the next attempt.
 	 */
 	if (cc->nr_freepages > 0) {
-		unsigned long free_pfn = release_freepages(&cc->freepages);
+		unsigned long free_pfn = release_free_list(cc->freepages);
 
 		cc->nr_freepages = 0;
 		VM_BUG_ON(free_pfn == 0);
@@ -2690,7 +2709,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
-	VM_BUG_ON(!list_empty(&cc->freepages));
 	VM_BUG_ON(!list_empty(&cc->migratepages));
 
 	return ret;
diff --git a/mm/internal.h b/mm/internal.h
index 1e29c5821a1d..93e229112045 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -447,6 +447,8 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
+extern bool free_pages_prepare(struct page *page, unsigned int order);
+
 extern int user_min_free_kbytes;
 
 extern void free_unref_page(struct page *page, unsigned int order);
@@ -481,7 +483,7 @@ int split_free_page(struct page *free_page,
  * completes when free_pfn <= migrate_pfn
  */
 struct compact_control {
-	struct list_head freepages;	/* List of free pages to migrate to */
+	struct list_head freepages[NR_PAGE_ORDERS];	/* List of free pages to migrate to */
 	struct list_head migratepages;	/* List of pages being migrated */
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 70c1ed3addf3..b0b92ce997dc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1080,7 +1080,7 @@ static void kernel_init_pages(struct page *page, int numpages)
 	kasan_enable_current();
 }
 
-static __always_inline bool free_pages_prepare(struct page *page,
+__always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order)
 {
 	int bad = 0;
-- 
2.43.0


