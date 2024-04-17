Return-Path: <linux-kernel+bounces-148060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E28A7D26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE281C20E00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015D7441F;
	Wed, 17 Apr 2024 07:34:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAD7B3C1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339267; cv=none; b=q+9OtdFE8wyepEnkunIrmQyveHhO8YruGIQtYhUdq1YszwvanP/M+G8tMLHy8t5ruh1+JHt2EiM5ZIKJouF2EYG/Ao2tmy00UL1KwrdyQ9GLyN4IzRsMm4AuUefXw9VuMiy3TLg8JzP4bnHBYQaI0U1NZ0hBg6uonSYkWrnJ2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339267; c=relaxed/simple;
	bh=Kbkgd8H70pfYdspSdFN3QXQdKpQDFz84yPpR6OVboYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JygE4hi4HUe1C6HhNXLmoFz1uDxxCRgi2HRuisHlGvMB9OTtglsBv0W6xBoUF/CKTAZ9Ha6O7GNDBT+jbduP3I/kH+jysblQddZjTb7phpXF9WggUJ8l1DJUFwclkR7YWGiRCTDK7RUEJkwDUbpnBKplB5XIhGAagZM6OkZJWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b1-661f77e2c364
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 7/8] mm: add folio_put_mgen() to deliver migrc's generation number to pcp or buddy
Date: Wed, 17 Apr 2024 16:18:46 +0900
Message-Id: <20240417071847.29584-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe6jcvk0gxkf1C3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	mc3djAUbFjBWXP7/mK2BcUUjYxcjJ4eEgInE5Ac/WGDsu8+PMIHYbALqEjdu/GQGsUUEzCQO
	tv5hB7GZBe4ySRzoZwOxhQVSJQ5e3gEWZxFQlXg5fStYnFfAVKJr5gkmiJnyEqs3HACbwwk0
	Z3PzGrAaIaCa7yc+AtlcQDWf2SRmr5wL1SApcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhlVOZl
	Vugl5+duYgSG/7LaP9E7GD9dCD7EKMDBqMTDaxAllybEmlhWXJl7iFGCg1lJhLdFWDZNiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2PMyvntHbr1N2Ub
	UlYckI8skrr9pWdeJL/QjBnsz6Yq2N+3Fhf8raihlXjvz+7l0tdLLhcvPd6e0ntqieEUt/Cw
	qMIOneYn97VlvA87fp/8v8zzjyfjhPM753ayyByKPqPY0NnqfZLLQpGnSafgxiSTH1FOYh/T
	Q2KmTf3rtl0pZMnldZsjviixFGckGmoxFxUnAgAy+kDEewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7NYN1DGYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZZzZ3M1YsGEBY8Xl/4/ZGhhXNDJ2MXJySAiYSNx9foQJxGYTUJe4ceMnM4gt
	ImAmcbD1DzuIzSxwl0niQD8biC0skCpx8PIOsDiLgKrEy+lbweK8AqYSXTNPMEHMlJdYveEA
	2BxOoDmbm9eA1QgB1Xw/8ZFtAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIHBvKz2
	z8QdjF8uux9iFOBgVOLhNYiSSxNiTSwrrsw9xCjBwawkwtsiLJsmxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwNg3Q8WyRv3wgStWqjsPVP5dzmu9cm/W
	eWHJ79ViE9tN/mS1FhoIhWz74mXV/vVkn6Pq94RuRzbfV91hJ051fjzqtyvJIlBmbXBpoGPU
	Rc77cXn/Z0x9acn1II87genAmu9JlgfWPvjOE/Iu/uE+//2z36t8SGG+aZiVvHXGg9/Hvvz7
	WXiwpVqJpTgj0VCLuag4EQCfLBuuYgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduced a new API, folio_put_mgen(), to deliver migrc's generation
number to pcp or buddy that will be used by migrc mechanism to track
need of tlb flush for each page residing in pcp or buddy.

migrc makes decision whether tlb flush is needed or not, based on a
generation number stored in the interesting page and the global
generation number, for that tlb flush required has been completed.

For now, the delivery works only for the following call path but not for
e.g. free_the_page(), __free_pages_ok() and free_unref_page_list() that
are not for releasing source folios during migration:

   folio_put_mgen()
      __folio_put_mgen()
	__folio_put_small()
	   free_unref_page()
	      free_unref_page_commit()
	      free_one_page()
	         __free_one_page()

The generation number should be handed over properly when pages travel
between pcp and buddy, and must do necessary things on exit from pcp or
buddy.

It's worth noting that this patch doesn't include actual body for tlb
flush on the exit, which will be filled by the main patch of migrc
mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h    |  22 ++++++++
 include/linux/sched.h |   1 +
 mm/compaction.c       |  10 ++++
 mm/internal.h         |  41 ++++++++++++++-
 mm/page_alloc.c       | 114 +++++++++++++++++++++++++++++++++++-------
 mm/page_reporting.c   |  10 ++++
 mm/swap.c             |  19 +++++--
 7 files changed, 195 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b0ee64225de..f99072ca5bbc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1307,6 +1307,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_mgen(struct folio *folio, unsigned short int mgen);
 
 void put_pages_list(struct list_head *pages);
 
@@ -1506,6 +1507,27 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+/**
+ * folio_put_mgen - Decrement the last reference count on a folio.
+ * @folio: The folio.
+ * @mgen: The migrc generation # of TLB flush that the folio requires.
+ *
+ * The folio's reference count should be one since the only user, folio
+ * migration code, calls folio_put_mgen() only when the folio has no
+ * reference else.  The memory will be released back to the page
+ * allocator and may be used by another allocation immediately.  Do not
+ * access the memory or the struct folio after calling folio_put_mgen().
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_mgen(struct folio *folio, unsigned short int mgen)
+{
+	if (WARN_ON(!folio_put_testzero(folio)))
+		return;
+	__folio_put_mgen(folio, mgen);
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 823d83b24364..74f8d106be79 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1335,6 +1335,7 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
+	unsigned short int		mgen;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/compaction.c b/mm/compaction.c
index 807b58e6eb68..b095b159bc6b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -701,6 +701,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	if (locked)
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+	/*
+	 * Check and flush before using the isolated pages.
+	 */
+	check_flush_task_mgen();
+
 	/*
 	 * Be careful to not go outside of the pageblock.
 	 */
@@ -1673,6 +1678,11 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		spin_unlock_irqrestore(&cc->zone->lock, flags);
 
+		/*
+		 * Check and flush before using the isolated pages.
+		 */
+		check_flush_task_mgen();
+
 		/* Skip fast search if enough freepages isolated */
 		if (cc->nr_freepages >= cc->nr_migratepages)
 			break;
diff --git a/mm/internal.h b/mm/internal.h
index e3a8b77b58ca..f381af27e6d1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -544,7 +544,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
-void free_unref_page(struct page *page, unsigned int order);
+void free_unref_page(struct page *page, unsigned int order, unsigned short int mgen);
 void free_unref_folios(struct folio_batch *fbatch);
 
 extern void zone_pcp_reset(struct zone *zone);
@@ -1379,4 +1379,43 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+static inline unsigned short int mgen_latest(unsigned short int a, unsigned short int b)
+{
+	if (!a || !b)
+		return a + b;
+
+	/*
+	 * The mgen is wrapped around so let's use this trick.
+	 */
+	if ((short int)(a - b) < 0)
+		return b;
+	else
+		return a;
+}
+
+static inline void update_task_mgen(unsigned short int mgen)
+{
+	current->mgen = mgen_latest(current->mgen, mgen);
+}
+
+static inline unsigned int hand_over_task_mgen(void)
+{
+	return xchg(&current->mgen, 0);
+}
+
+static inline void check_flush_task_mgen(void)
+{
+	/*
+	 * XXX: migrc mechanism will handle this. For now, do nothing
+	 * but reset current's mgen to finalize this turn.
+	 */
+	current->mgen = 0;
+}
+#else /* CONFIG_MIGRATION && CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline unsigned short int mgen_latest(unsigned short int a, unsigned short int b) { return 0; }
+static inline void update_task_mgen(unsigned short int mgen) {}
+static inline unsigned int hand_over_task_mgen(void) { return 0; }
+static inline void check_flush_task_mgen(void) {}
+#endif
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 555f6d2e33ea..aefa3cde62d2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -561,7 +561,7 @@ static inline bool pcp_allowed_order(unsigned int order)
 static inline void free_the_page(struct page *page, unsigned int order)
 {
 	if (pcp_allowed_order(order))		/* Via pcp? */
-		free_unref_page(page, order);
+		free_unref_page(page, order, 0);
 	else
 		__free_pages_ok(page, order, FPI_NONE);
 }
@@ -703,6 +703,7 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	if (page_reported(page))
 		__ClearPageReported(page);
 
+	update_task_mgen(page_buddy_mgen(page));
 	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
@@ -768,7 +769,7 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 static inline void __free_one_page(struct page *page,
 		unsigned long pfn,
 		struct zone *zone, unsigned int order,
-		int migratetype, fpi_t fpi_flags)
+		int migratetype, fpi_t fpi_flags, unsigned short int mgen)
 {
 	struct capture_control *capc = task_capc(zone);
 	unsigned long buddy_pfn = 0;
@@ -786,8 +787,17 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
+	/*
+	 * Ensure private is zero before using it inside buddy.
+	 */
+	set_page_private(page, 0);
 	while (order < MAX_PAGE_ORDER) {
 		if (compaction_capture(capc, page, order, migratetype)) {
+			/*
+			 * Capturer will check_flush_task_mgen() through
+			 * prep_new_page().
+			 */
+			update_task_mgen(mgen);
 			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
 			return;
@@ -819,6 +829,11 @@ static inline void __free_one_page(struct page *page,
 		if (page_is_guard(buddy))
 			clear_page_guard(zone, buddy, order, migratetype);
 		else
+			/*
+			 * del_page_from_free_list() updates current's
+			 * mgen that pairs with hand_over_task_mgen() below
+			 * in this funtion.
+			 */
 			del_page_from_free_list(buddy, zone, order);
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
@@ -827,7 +842,8 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order_mgen(page, order, 0);
+	mgen = mgen_latest(mgen, hand_over_task_mgen());
+	set_buddy_order_mgen(page, order, mgen);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -869,6 +885,7 @@ int split_free_page(struct page *free_page,
 	int free_page_order;
 	int mt;
 	int ret = 0;
+	unsigned short int mgen;
 
 	if (split_pfn_offset == 0)
 		return ret;
@@ -884,7 +901,13 @@ int split_free_page(struct page *free_page,
 	if (likely(!is_migrate_isolate(mt)))
 		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 
+	/*
+	 * del_page_from_free_list() updates current's mgen that pairs
+	 * with the following hand_over_task_mgen().
+	 */
 	del_page_from_free_list(free_page, zone, order);
+	mgen = hand_over_task_mgen();
+
 	for (pfn = free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
@@ -893,7 +916,7 @@ int split_free_page(struct page *free_page,
 					pfn ? __ffs(pfn) : order,
 					__fls(split_pfn_offset));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
-				mt, FPI_NONE);
+				mt, FPI_NONE, mgen);
 		pfn += 1UL << free_page_order;
 		split_pfn_offset -= (1UL << free_page_order);
 		/* we have done the first part, now switch to second part */
@@ -1094,6 +1117,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	/*
+	 * Ensure private is zero before using it inside pcp.
+	 */
+	set_page_private(page, 0);
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -1224,10 +1252,16 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		nr_pages = 1 << order;
 		do {
 			int mt;
+			unsigned short int mgen;
 
 			page = list_last_entry(list, struct page, pcp_list);
 			mt = get_pcppage_migratetype(page);
 
+			/*
+			 * pcp uses private to store mgen.
+			 */
+			mgen = page_private(page);
+
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
 			count -= nr_pages;
@@ -1239,7 +1273,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			if (unlikely(isolated_pageblocks))
 				mt = get_pageblock_migratetype(page);
 
-			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE, mgen);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1250,7 +1284,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 static void free_one_page(struct zone *zone,
 				struct page *page, unsigned long pfn,
 				unsigned int order,
-				int migratetype, fpi_t fpi_flags)
+				int migratetype, fpi_t fpi_flags,
+				unsigned short int mgen)
 {
 	unsigned long flags;
 
@@ -1259,7 +1294,7 @@ static void free_one_page(struct zone *zone,
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags, mgen);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
@@ -1280,7 +1315,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	 */
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
-	free_one_page(zone, page, pfn, order, migratetype, fpi_flags);
+	free_one_page(zone, page, pfn, order, migratetype, fpi_flags, 0);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
@@ -1541,6 +1576,10 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
+	/*
+	 * Check and flush before using the pages.
+	 */
+	check_flush_task_mgen();
 	post_alloc_hook(page, order, gfp_flags);
 
 	if (order && (gfp_flags & __GFP_COMP))
@@ -1576,6 +1615,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with check_flush_task_mgen() in prep_new_page().
+		 */
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
 		set_pcppage_migratetype(page, migratetype);
@@ -2430,7 +2473,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, unsigned short int mgen)
 {
 	int high, batch;
 	int pindex;
@@ -2444,6 +2487,11 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	pcp->alloc_factor >>= 1;
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
+
+	/*
+	 * pcp uses private to store mgen.
+	 */
+	set_page_private(page, mgen);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
@@ -2479,7 +2527,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+void free_unref_page(struct page *page, unsigned int order,
+		     unsigned short int mgen)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2500,7 +2549,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE, mgen);
 			return;
 		}
 		pcpmigratetype = MIGRATE_MOVABLE;
@@ -2510,10 +2559,10 @@ void free_unref_page(struct page *page, unsigned int order)
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
+		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order, mgen);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
+		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE, mgen);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2547,7 +2596,7 @@ void free_unref_folios(struct folio_batch *folios)
 		if (!pcp_allowed_order(order) ||
 		    is_migrate_isolate(migratetype)) {
 			free_one_page(folio_zone(folio), &folio->page, pfn,
-					order, migratetype, FPI_NONE);
+					order, migratetype, FPI_NONE, 0);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2582,7 +2631,7 @@ void free_unref_folios(struct folio_batch *folios)
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page,
 						folio_pfn(folio), order,
-						migratetype, FPI_NONE);
+						migratetype, FPI_NONE, 0);
 				locked_zone = NULL;
 				continue;
 			}
@@ -2598,7 +2647,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				order, 0);
 	}
 
 	if (pcp) {
@@ -2650,6 +2699,11 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 	}
 
+	/*
+	 * del_page_from_free_list() updates current's mgen. The user of
+	 * the isolated page should check_flush_task_mgen() before using
+	 * it.
+	 */
 	del_page_from_free_list(page, zone, order);
 
 	/*
@@ -2691,7 +2745,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL, 0);
 }
 
 /*
@@ -2836,6 +2890,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
+
+		/*
+		 * Pairs with check_flush_task_mgen() in prep_new_page().
+		 */
+		update_task_mgen(page_private(page));
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
@@ -6659,10 +6718,19 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
 		order = buddy_order(page);
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with check_flush_task_mgen() below in this function.
+		 */
 		del_page_from_free_list(page, zone, order);
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush before using it.
+	 */
+	check_flush_task_mgen();
 }
 #endif
 
@@ -6738,6 +6806,11 @@ bool take_page_off_buddy(struct page *page)
 			int migratetype = get_pfnblock_migratetype(page_head,
 								   pfn_head);
 
+			/*
+			 * del_page_from_free_list() updates current's
+			 * mgen that pairs with check_flush_task_mgen() below
+			 * in this function.
+			 */
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
@@ -6751,6 +6824,11 @@ bool take_page_off_buddy(struct page *page)
 			break;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush before using it.
+	 */
+	check_flush_task_mgen();
 	return ret;
 }
 
@@ -6768,7 +6846,7 @@ bool put_page_back_buddy(struct page *page)
 	spin_lock_irqsave(&zone->lock, flags);
 	if (put_page_testzero(page)) {
 		ClearPageHWPoisonTakenOff(page);
-		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
 		}
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61d8c..95b771ae4653 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -221,6 +221,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 		/* release lock before waiting on report processing */
 		spin_unlock_irq(&zone->lock);
 
+		/*
+		 * Check and flush before using the isolated pages.
+		 */
+		check_flush_task_mgen();
+
 		/* begin processing pages in local list */
 		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
 
@@ -253,6 +258,11 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 	spin_unlock_irq(&zone->lock);
 
+	/*
+	 * Check and flush before using the isolated pages.
+	 */
+	check_flush_task_mgen();
+
 	return err;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 500a09a48dfd..1c4ebe0febc6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -112,11 +112,24 @@ static void page_cache_release(struct folio *folio)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 }
 
-static void __folio_put_small(struct folio *folio)
+static void __folio_put_small(struct folio *folio, unsigned short int mgen)
 {
 	page_cache_release(folio);
 	mem_cgroup_uncharge(folio);
-	free_unref_page(&folio->page, 0);
+	free_unref_page(&folio->page, 0, mgen);
+}
+
+void __folio_put_mgen(struct folio *folio, unsigned short int mgen)
+{
+	if (unlikely(folio_is_zone_device(folio)))
+		WARN_ON(1);
+	else if (unlikely(folio_test_large(folio)))
+		WARN_ON(1);
+	/*
+	 * For now, migrc supports this case only.
+	 */
+	else
+		__folio_put_small(folio, mgen);
 }
 
 static void __folio_put_large(struct folio *folio)
@@ -139,7 +152,7 @@ void __folio_put(struct folio *folio)
 	else if (unlikely(folio_test_large(folio)))
 		__folio_put_large(folio);
 	else
-		__folio_put_small(folio);
+		__folio_put_small(folio, 0);
 }
 EXPORT_SYMBOL(__folio_put);
 
-- 
2.17.1


