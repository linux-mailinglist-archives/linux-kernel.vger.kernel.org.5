Return-Path: <linux-kernel+bounces-109284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664C1881721
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896CD1C2096F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0073538;
	Wed, 20 Mar 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="tE242TK3"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD066BFAF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957909; cv=none; b=tb+gxVMCjybxSRiexruHCp3nVccDDrNO0Eg+K82wRQFlRFmOJpUZasRocKxVsvD6YPiE5zlTX3cUkwR4RBthvcnnKdtWfR5SdXMYGTpb425EVzANKNVD9YyG2hBu44CDTabRHhX5+Gnga/TBMY5XCoTX9V+ub2Zdr6ZIynDHT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957909; c=relaxed/simple;
	bh=AwllyVEXplO6B1YnZtndWQKYFsp+t6u+xzc8uEKXXEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRrdCpLjLvcA/RsKzFBdCWQslI/2xIpQWIqKW8Mi5+zHqjn1Of2TrsFwbMGwOqphkegJl/iKIGYnJ0XwTrAv3WDoSxhTV8jR/KTfco/7gUTnE898s17FupW/fYOAF7jQDFMrTp+zoQmWb/qOx244Z2ner9bdOG90QHQX7Js98JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=tE242TK3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690b8788b12so1071276d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957906; x=1711562706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7usfWeQLN0+E1Z1UvH5iS/0eHw0DMUF9yV4ujEabP2Q=;
        b=tE242TK3VxclJLxdmsyG78T2iRy5Uk4M6tk5ANKbGW8KC8rNxUjB6QiCm63wuY/0wC
         OnY0rPNDrtv/jdNMGxnpsz7ujf+Ri9VX0j1JXfzd3J8eiroJXGMJcxPD+/81DJ7j6ky8
         cufAb2bVx2r0imXbkphrO65OuFo/DG4OWFCos4H6DJdC9+54odAvMgxOWwCmOamn46Uh
         yXrOoDXyRTpUfSy0VGNX5rPll9akuhmtgen/lTeIZnOk66GojffP0Gvy+b8IfvPhKr+7
         VSF0lDqdM1QTIV/MPzaTNB+3tDYBceVTuCTF03N8n+pF8EmdpSCM4gg5RExiBYEkWMhh
         OZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957906; x=1711562706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7usfWeQLN0+E1Z1UvH5iS/0eHw0DMUF9yV4ujEabP2Q=;
        b=DXzbUb+I0rRpE8Q++FBqM/hOVa3O3LxatsCGzz9eycS6oAo1a4JxaIzANG/wt+DjM2
         6gcK9VV9bNTxTuBi4m8NWMvUz1nrPp15HC+nPFSKRxbiNoe4cSno57fM8QlaLho8IsMW
         pjdi3UssFQBWyg7shdZgeO1+S51KRfgauvljIFyfvY5ClcoTRWLhiDJXYyk4kbSs8m2v
         EcpQCQYRF5+7NWakSCxvPMIEcZg66fgDSLsY30qhkn6e7QyngTiZVlX5Zz5ZzsqNZ6Mj
         wBl9vwuByprZoeEd4St7IpogDzv5Cup2RpL3JwvNU7uVUliwPU3ggtT9CiCn0eN+JaFA
         39Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wepmlpgR/dPVD0/+wrXa96/UUIVJaeeJoMRwXHib/YmZKT0Au8IRCF4Z3f5AzviaCRyAjCMI/TivE/LPXE3F+zs8n2sHLOeLxRbJ
X-Gm-Message-State: AOJu0Yx8PWrnqILtKg33rG8c11DDfb9TStnfT8ySolXrIUGGVTZKeM/+
	N7Y2UIwSo7eAz4eK81W4ea4jXn4c47Ykz+0466szfRrTRkDifC/XGGiwN0ifRmvQ+W2PRnf1ioB
	s
X-Google-Smtp-Source: AGHT+IHMjYEE88Dv6WAVJtdVPq3oYrOoMOFbiUGH9pcBJQM3z1kAVXkhzhyLSrzGgEmTgy1mssmPRA==
X-Received: by 2002:a0c:c20b:0:b0:696:2b3e:7813 with SMTP id l11-20020a0cc20b000000b006962b3e7813mr8058795qvh.17.1710957905785;
        Wed, 20 Mar 2024 11:05:05 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id g15-20020a0562140acf00b0069150ebcc30sm8045119qvi.76.2024.03.20.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:05:05 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Date: Wed, 20 Mar 2024 14:02:15 -0400
Message-ID: <20240320180429.678181-11-hannes@cmpxchg.org>
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

Free page accounting currently happens a bit too high up the call
stack, where it has to deal with guard pages, compaction capturing,
block stealing and even page isolation. This is subtle and fragile,
and makes it difficult to hack on the code.

Now that type violations on the freelists have been fixed, push the
accounting down to where pages enter and leave the freelist.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm.h     |  18 ++--
 include/linux/vmstat.h |   8 --
 mm/debug_page_alloc.c  |  12 +--
 mm/internal.h          |   5 --
 mm/page_alloc.c        | 194 +++++++++++++++++++++++------------------
 mm/page_isolation.c    |   3 +-
 6 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8147b1302413..bd2e94391c7e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3781,24 +3781,22 @@ static inline bool page_is_guard(struct page *page)
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
@@ -3808,9 +3806,9 @@ static inline unsigned int debug_guardpage_minorder(void) { return 0; }
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
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 343906a98d6e..735eae6e272c 100644
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
index 6755f0c9d4a3..d46acf989dde 100644
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
index d6e6c7d9f04e..0a4007b03d0d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1036,11 +1036,6 @@ static inline bool is_migrate_highatomic(enum migratetype migratetype)
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
index efb2581ac142..c46491f83ac2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -642,42 +642,72 @@ compaction_capture(struct capture_control *capc, struct page *page,
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
+static inline void __add_to_free_list(struct page *page, struct zone *zone,
+				      unsigned int order, int migratetype,
+				      bool tail)
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
 }
 
+static inline void add_to_free_list(struct page *page, struct zone *zone,
+				    unsigned int order, int migratetype,
+				    bool tail)
+{
+	__add_to_free_list(page, zone, order, migratetype, tail);
+	account_freepages(page, zone, 1 << order, migratetype);
+}
+
 /*
  * Used for pages which are on another list. Move the pages to the tail
  * of the list - so the moved pages won't immediately be considered for
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
 
-static inline void del_page_from_free_list(struct page *page, struct zone *zone,
-					   unsigned int order)
+static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
+					     unsigned int order, int migratetype)
 {
+        VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
+		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
+		     get_pageblock_migratetype(page), migratetype, 1 << order);
+
 	/* clear reported state and update reported page count */
 	if (page_reported(page))
 		__ClearPageReported(page);
@@ -688,6 +718,13 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	zone->free_area[order].nr_free--;
 }
 
+static inline void del_page_from_free_list(struct page *page, struct zone *zone,
+					   unsigned int order, int migratetype)
+{
+	__del_page_from_free_list(page, zone, order, migratetype);
+	account_freepages(page, zone, -(1 << order), migratetype);
+}
+
 static inline struct page *get_page_from_free_area(struct free_area *area,
 					    int migratetype)
 {
@@ -759,18 +796,16 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
 
 	VM_BUG_ON(migratetype == -1);
-	if (likely(!is_migrate_isolate(migratetype)))
-		__mod_zone_freepage_state(zone, 1 << order, migratetype);
-
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
+	account_freepages(page, zone, 1 << order, migratetype);
+
 	while (order < MAX_PAGE_ORDER) {
-		if (compaction_capture(capc, page, order, migratetype)) {
-			__mod_zone_freepage_state(zone, -(1 << order),
-								migratetype);
+		int buddy_mt = migratetype;
+
+		if (compaction_capture(capc, page, order, migratetype))
 			return;
-		}
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
 		if (!buddy)
@@ -783,19 +818,12 @@ static inline void __free_one_page(struct page *page,
 			 * pageblock isolation could cause incorrect freepage or CMA
 			 * accounting or HIGHATOMIC accounting.
 			 */
-			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
+			buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
 
-			if (migratetype != buddy_mt) {
-				if (!migratetype_is_mergeable(migratetype) ||
-				    !migratetype_is_mergeable(buddy_mt))
-					goto done_merging;
-				/*
-				 * Match buddy type. This ensures that
-				 * an expand() down the line puts the
-				 * sub-blocks on the right freelists.
-				 */
-				set_pageblock_migratetype(buddy, migratetype);
-			}
+			if (migratetype != buddy_mt &&
+			    (!migratetype_is_mergeable(migratetype) ||
+			     !migratetype_is_mergeable(buddy_mt)))
+				goto done_merging;
 		}
 
 		/*
@@ -803,9 +831,19 @@ static inline void __free_one_page(struct page *page,
 		 * merge with it and move up one order.
 		 */
 		if (page_is_guard(buddy))
-			clear_page_guard(zone, buddy, order, migratetype);
+			clear_page_guard(zone, buddy, order);
 		else
-			del_page_from_free_list(buddy, zone, order);
+			__del_page_from_free_list(buddy, zone, order, buddy_mt);
+
+		if (unlikely(buddy_mt != migratetype)) {
+			/*
+			 * Match buddy type. This ensures that an
+			 * expand() down the line puts the sub-blocks
+			 * on the right freelists.
+			 */
+			set_pageblock_migratetype(buddy, migratetype);
+		}
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
@@ -822,10 +860,7 @@ static inline void __free_one_page(struct page *page,
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
-	if (to_tail)
-		add_to_free_list_tail(page, zone, order, migratetype);
-	else
-		add_to_free_list(page, zone, order, migratetype);
+	__add_to_free_list(page, zone, order, migratetype, to_tail);
 
 	/* Notify page reporting subsystem of freed page */
 	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
@@ -1314,10 +1349,10 @@ static inline void expand(struct zone *zone, struct page *page,
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
@@ -1487,7 +1522,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
-		del_page_from_free_list(page, zone, current_order);
+		del_page_from_free_list(page, zone, current_order, migratetype);
 		expand(zone, page, order, current_order, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
@@ -1527,7 +1562,7 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
  * type's freelist.
  */
 static int move_freepages(struct zone *zone, unsigned long start_pfn,
-			  unsigned long end_pfn, int migratetype)
+			  unsigned long end_pfn, int old_mt, int new_mt)
 {
 	struct page *page;
 	unsigned long pfn;
@@ -1549,12 +1584,14 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
 		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
 
 		order = buddy_order(page);
-		move_to_free_list(page, zone, order, migratetype);
+
+		move_to_free_list(page, zone, order, old_mt, new_mt);
+
 		pfn += 1 << order;
 		pages_moved += 1 << order;
 	}
 
-	set_pageblock_migratetype(pfn_to_page(start_pfn), migratetype);
+	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
 
 	return pages_moved;
 }
@@ -1612,7 +1649,7 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 }
 
 static int move_freepages_block(struct zone *zone, struct page *page,
-				int migratetype)
+				int old_mt, int new_mt)
 {
 	unsigned long start_pfn, end_pfn;
 
@@ -1620,7 +1657,7 @@ static int move_freepages_block(struct zone *zone, struct page *page,
 				       NULL, NULL))
 		return -1;
 
-	return move_freepages(zone, start_pfn, end_pfn, migratetype);
+	return move_freepages(zone, start_pfn, end_pfn, old_mt, new_mt);
 }
 
 #ifdef CONFIG_MEMORY_ISOLATION
@@ -1692,7 +1729,6 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				  int migratetype)
 {
 	unsigned long start_pfn, end_pfn, pfn;
-	int nr_moved, mt;
 
 	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
 				       NULL, NULL))
@@ -1703,11 +1739,9 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 	if (pfn != start_pfn) {
 		struct page *buddy = pfn_to_page(pfn);
 		int order = buddy_order(buddy);
-		int mt = get_pfnblock_migratetype(buddy, pfn);
 
-		if (!is_migrate_isolate(mt))
-			__mod_zone_freepage_state(zone, -(1UL << order), mt);
-		del_page_from_free_list(buddy, zone, order);
+		del_page_from_free_list(buddy, zone, order,
+					get_pfnblock_migratetype(buddy, pfn));
 		set_pageblock_migratetype(page, migratetype);
 		split_large_buddy(zone, buddy, pfn, order);
 		return true;
@@ -1715,23 +1749,17 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 	/* We're the starting block of a larger buddy */
 	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
-		int mt = get_pfnblock_migratetype(page, pfn);
 		int order = buddy_order(page);
 
-		if (!is_migrate_isolate(mt))
-			__mod_zone_freepage_state(zone, -(1UL << order), mt);
-		del_page_from_free_list(page, zone, order);
+		del_page_from_free_list(page, zone, order,
+					get_pfnblock_migratetype(page, pfn));
 		set_pageblock_migratetype(page, migratetype);
 		split_large_buddy(zone, page, pfn, order);
 		return true;
 	}
 
-	mt = get_pfnblock_migratetype(page, start_pfn);
-	nr_moved = move_freepages(zone, start_pfn, end_pfn, migratetype);
-	if (!is_migrate_isolate(mt))
-		__mod_zone_freepage_state(zone, -nr_moved, mt);
-	else if (!is_migrate_isolate(migratetype))
-		__mod_zone_freepage_state(zone, nr_moved, migratetype);
+	move_freepages(zone, start_pfn, end_pfn,
+		       get_pfnblock_migratetype(page, start_pfn), migratetype);
 	return true;
 }
 #endif /* CONFIG_MEMORY_ISOLATION */
@@ -1845,7 +1873,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
-		del_page_from_free_list(page, zone, current_order);
+		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		expand(zone, page, order, current_order, start_type);
 		return page;
@@ -1895,12 +1923,12 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
-		move_freepages(zone, start_pfn, end_pfn, start_type);
+		move_freepages(zone, start_pfn, end_pfn, block_type, start_type);
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
 single_page:
-	del_page_from_free_list(page, zone, current_order);
+	del_page_from_free_list(page, zone, current_order, block_type);
 	expand(zone, page, order, current_order, block_type);
 	return page;
 }
@@ -1970,7 +1998,7 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
 	mt = get_pageblock_migratetype(page);
 	/* Only reserve normal pageblocks (i.e., they can merge with others) */
 	if (migratetype_is_mergeable(mt))
-		if (move_freepages_block(zone, page,
+		if (move_freepages_block(zone, page, mt,
 					 MIGRATE_HIGHATOMIC) != -1)
 			zone->nr_reserved_highatomic += pageblock_nr_pages;
 
@@ -2011,11 +2039,13 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
+			int mt;
 
 			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
 			if (!page)
 				continue;
 
+			mt = get_pageblock_migratetype(page);
 			/*
 			 * In page freeing path, migratetype change is racy so
 			 * we can counter several free pages in a pageblock
@@ -2023,7 +2053,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * from highatomic to ac->migratetype. So we should
 			 * adjust the count once.
 			 */
-			if (is_migrate_highatomic_page(page)) {
+			if (is_migrate_highatomic(mt)) {
 				/*
 				 * It should never happen but changes to
 				 * locking could inadvertently allow a per-cpu
@@ -2045,7 +2075,8 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * of pageblocks that cannot be completely freed
 			 * may increase.
 			 */
-			ret = move_freepages_block(zone, page, ac->migratetype);
+			ret = move_freepages_block(zone, page, mt,
+						   ac->migratetype);
 			/*
 			 * Reserving this block already succeeded, so this should
 			 * not fail on zone boundaries.
@@ -2251,12 +2282,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -2748,11 +2774,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
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
@@ -2767,7 +2791,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * with others)
 			 */
 			if (migratetype_is_mergeable(mt))
-				move_freepages_block(zone, page,
+				move_freepages_block(zone, page, mt,
 						     MIGRATE_MOVABLE);
 		}
 	}
@@ -2852,8 +2876,6 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 				return NULL;
 			}
 		}
-		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
@@ -6737,8 +6759,9 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
+		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
-		del_page_from_free_list(page, zone, order);
+		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -6788,10 +6811,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			current_buddy = page + size;
 		}
 
-		if (set_page_guard(zone, current_buddy, high, migratetype))
+		if (set_page_guard(zone, current_buddy, high))
 			continue;
 
-		add_to_free_list(current_buddy, zone, high, migratetype);
+		add_to_free_list(current_buddy, zone, high, migratetype, false);
 		set_buddy_order(current_buddy, high);
 	}
 }
@@ -6817,12 +6840,11 @@ bool take_page_off_buddy(struct page *page)
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
@@ -6930,7 +6952,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	list_del(&page->lru);
 	last = list_empty(&zone->unaccepted_pages);
 
-	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(page, zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -6982,7 +7004,7 @@ static bool __free_unaccepted(struct page *page)
 	spin_lock_irqsave(&zone->lock, flags);
 	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
-	__mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	account_freepages(page, zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 042937d5abe4..914a71c580d8 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -252,7 +252,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
+		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page,
+							   migratetype));
 	} else {
 		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
-- 
2.44.0


