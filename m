Return-Path: <linux-kernel+bounces-149565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4158A92E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371561C20D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ABD6A8AD;
	Thu, 18 Apr 2024 06:16:01 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1A77F1B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420960; cv=none; b=IqVJ+6GpaeOXciA1tNULWB0iALX0Nk17Ubky6gPE+A+15tzGUyKevXLEZ7/6yhKHum7Hcz7x2fcnbZF844OzHPsSkJVb2cJlGmzqNFO3FyPSeCrZsXaHbO6Za76cE955vfBMu+31hJdsF078ShbUBIyfSG1wQeoxGhIRA25h93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420960; c=relaxed/simple;
	bh=3K8oohgDbM4UukM+dd219oH37IxlXtQ7c1IZ+c08qDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dARuoIimUsgDmtVZk0ILhqr+3PLFCrqKHG8lCwov02LU9M35kakNqylhzoNuVcQ0ZwOgYtjiSACdQpDrdh9f6wkICGgvep8QEB0j8OL7bZI15NlXsjPNbYI3a87NagwEDXuVBFs7j6QD6/pNXda021Wqc5iWIW53RuxPzNYwoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-1b-6620ba935444
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
Subject: [PATCH v9 rebase on mm-unstable 7/8] mm: add folio_put_mgen() to deliver migrc's generation number to pcp or buddy
Date: Thu, 18 Apr 2024 15:15:35 +0900
Message-Id: <20240418061536.11645-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnke7kXQppBgcmCFnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	L6/NCpbtZKz4dGUBYwNjy1TGLkZODgkBE4kj87qYYOxNsw+xgdhsAuoSN278ZAaxRQTMJA62
	/mEHsZkF7jJJHOgHquHgEBaoluh5zg8SZhFQlbj27ggLiM0rYCpx6m4/O8RIeYnVGw6AjeEE
	GtP//hAjSKsQUM2FvyFdjFxAJZ/ZJDadv84KUS8pcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhl
	VOZlVugl5+duYgQG/rLaP9E7GD9dCD7EKMDBqMTDe/KAfJoQa2JZcWXuIUYJDmYlEd4WYdk0
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYyGGw5c3Nqx
	f1nExTyjynfKM6JOJM46ePIzC1PR8trJf/faLJ6w8VYD7+H5Iae1pVVnm3+zCQu7FT5b8vD1
	NxfDpxYuf7AmqKHjT5XNS5HFEy1VTB4Ktm+dsfbZW/etYSfVDLk8DrL9khTXd4369uH7/suL
	qh79PcW02831rqzl8Zs7fdkyNLhdlFiKMxINtZiLihMBjBTo8HgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrDt5l0KawdLt7BZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyvjy2qxg2U7Gik9XFjA2MLZMZexi5OSQEDCR2DT7EBuIzSagLnHjxk9mEFtE
	wEziYOsfdhCbWeAuk8SBfqAaDg5hgWqJnuf8IGEWAVWJa++OsIDYvAKmEqfu9rNDjJSXWL3h
	ANgYTqAx/e8PMYK0CgHVXPgbMoGRawEjwypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAMF5W
	+2fiDsYvl90PMQpwMCrx8J44IJ8mxJpYVlyZe4hRgoNZSYS3RVg2TYg3JbGyKrUoP76oNCe1
	+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoEx89MXi5pZjDHmy5a/D0/gYeA/zG0d
	5blvhYjn8kMbRJtnceX3RuwOdvQOXjV7uvvFW3NyxLTuh3r7cr85s/3ax7mfQp9yTfd+dTjF
	+sTkRyovDprsdr4TsW0BT3p1M88etZ0pahmb39vmb9Z4POukdcHZjJshzefX7Vt+4N6tsLh9
	V/VXST5YpcRSnJFoqMVcVJwIAH2/15tfAgAA
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
the others that are not for releasing source folios during migration:

	folio_put_mgen()
	   __folio_put_mgen()
	      free_unref_page()
	         free_unref_page_commit()
	         free_one_page()
	            __free_one_page()

The generation number should be handed over properly when pages travel
between pcp and buddy, and must do necessary handling on exit from pcp
or buddy.

It's worth noting that this patch doesn't include actual body for tlb
flush on the exit, which will be filled by the main patch of migrc
mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h    |  22 +++++++
 include/linux/sched.h |   1 +
 mm/compaction.c       |  10 +++
 mm/internal.h         |  41 +++++++++++-
 mm/page_alloc.c       | 144 ++++++++++++++++++++++++++++++++++--------
 mm/page_isolation.c   |   6 ++
 mm/page_reporting.c   |  10 +++
 mm/swap.c             |  20 +++++-
 8 files changed, 226 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc33f8269fb5..2e266dca1577 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1312,6 +1312,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_mgen(struct folio *folio, unsigned short int mgen);
 
 void put_pages_list(struct list_head *pages);
 
@@ -1509,6 +1510,27 @@ static inline void folio_put(struct folio *folio)
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
index f9f8091f354f..8125014dd57d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1340,6 +1340,7 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
+	unsigned short int		mgen;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/compaction.c b/mm/compaction.c
index e731d45befc7..cf7cbffc411e 100644
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
index 0336375c6e8b..484bb960aeb7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -638,7 +638,7 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
-void free_unref_page(struct page *page, unsigned int order);
+void free_unref_page(struct page *page, unsigned int order, unsigned short int mgen);
 void free_unref_folios(struct folio_batch *fbatch);
 
 extern void zone_pcp_reset(struct zone *zone);
@@ -1516,4 +1516,43 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
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
index cbde22c4c189..7343882f077a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -696,6 +696,7 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
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
@@ -783,12 +784,22 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
+	/*
+	 * Ensure private is zero before using it inside buddy.
+	 */
+	set_page_private(page, 0);
+
 	account_freepages(zone, 1 << order, migratetype);
 
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
 
 		if (compaction_capture(capc, page, order, migratetype)) {
+			/*
+			 * Capturer will check_flush_task_mgen() through
+			 * prep_new_page().
+			 */
+			update_task_mgen(mgen);
 			account_freepages(zone, -(1 << order), migratetype);
 			return;
 		}
@@ -819,6 +830,11 @@ static inline void __free_one_page(struct page *page,
 		if (page_is_guard(buddy))
 			clear_page_guard(zone, buddy, order);
 		else
+			/*
+			 * __del_page_from_free_list() updates current's
+			 * mgen that pairs with hand_over_task_mgen() below
+			 * in this funtion.
+			 */
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
 
 		if (unlikely(buddy_mt != migratetype)) {
@@ -837,7 +853,8 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order_mgen(page, order, 0);
+	mgen = mgen_latest(mgen, hand_over_task_mgen());
+	set_buddy_order_mgen(page, order, mgen);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1048,6 +1065,11 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	/*
+	 * Ensure private is zero before using it inside pcp.
+	 */
+	set_page_private(page, 0);
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
@@ -1179,17 +1201,23 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		do {
 			unsigned long pfn;
 			int mt;
+			unsigned short int mgen;
 
 			page = list_last_entry(list, struct page, pcp_list);
 			pfn = page_to_pfn(page);
 			mt = get_pfnblock_migratetype(page, pfn);
 
+			/*
+			 * pcp uses private to store mgen.
+			 */
+			mgen = page_private(page);
+
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE, mgen);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1199,14 +1227,14 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
-			  fpi_t fpi_flags)
+			  fpi_t fpi_flags, unsigned short int mgen)
 {
 	unsigned long flags;
 	int migratetype;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	migratetype = get_pfnblock_migratetype(page, pfn);
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags, mgen);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
@@ -1219,7 +1247,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	if (!free_pages_prepare(page, order))
 		return;
 
-	free_one_page(zone, page, pfn, order, fpi_flags);
+	free_one_page(zone, page, pfn, order, fpi_flags, 0);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
@@ -1484,6 +1512,10 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
+	/*
+	 * Check and flush before using the pages.
+	 */
+	check_flush_task_mgen();
 	post_alloc_hook(page, order, gfp_flags);
 
 	if (order && (gfp_flags & __GFP_COMP))
@@ -1519,6 +1551,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with check_flush_task_mgen() in prep_new_page().
+		 */
 		del_page_from_free_list(page, zone, current_order, migratetype);
 		expand(zone, page, order, current_order, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
@@ -1681,7 +1717,8 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 
 /* Split a multi-block free page into its individual pageblocks */
 static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order)
+			      unsigned long pfn, int order,
+			      unsigned short int mgen)
 {
 	unsigned long end_pfn = pfn + (1 << order);
 
@@ -1694,7 +1731,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	while (pfn != end_pfn) {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
-		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE);
+		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE, mgen);
 		pfn += pageblock_nr_pages;
 		page = pfn_to_page(pfn);
 	}
@@ -1736,22 +1773,34 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 	if (pfn != start_pfn) {
 		struct page *buddy = pfn_to_page(pfn);
 		int order = buddy_order(buddy);
+		unsigned short int mgen;
 
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with the following hand_over_task_mgen().
+		 */
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
+		mgen = hand_over_task_mgen();
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order);
+		split_large_buddy(zone, buddy, pfn, order, mgen);
 		return true;
 	}
 
 	/* We're the starting block of a larger buddy */
 	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
 		int order = buddy_order(page);
+		unsigned short int mgen;
 
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with the following hand_over_task_mgen().
+		 */
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
+		mgen = hand_over_task_mgen();
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order);
+		split_large_buddy(zone, page, pfn, order, mgen);
 		return true;
 	}
 move:
@@ -1871,6 +1920,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with check_flush_task_mgen() in prep_new_page().
+		 */
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		expand(zone, page, order, current_order, start_type);
@@ -1926,6 +1979,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	}
 
 single_page:
+	/*
+	 * del_page_from_free_list() updates current's mgen that pairs
+	 * with check_flush_task_mgen() in prep_new_page().
+	 */
 	del_page_from_free_list(page, zone, current_order, block_type);
 	expand(zone, page, order, current_order, block_type);
 	return page;
@@ -2547,7 +2604,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, unsigned short int mgen)
 {
 	int high, batch;
 	int pindex;
@@ -2561,6 +2618,11 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
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
 
@@ -2596,7 +2658,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+void free_unref_page(struct page *page, unsigned int order,
+		     unsigned short int mgen)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2622,7 +2685,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, FPI_NONE, mgen);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -2632,10 +2695,10 @@ void free_unref_page(struct page *page, unsigned int order)
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order, mgen);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE, mgen);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2666,7 +2729,7 @@ void free_unref_folios(struct folio_batch *folios)
 		 */
 		if (!pcp_allowed_order(order)) {
 			free_one_page(folio_zone(folio), &folio->page,
-				      pfn, order, FPI_NONE);
+				      pfn, order, FPI_NONE, 0);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2702,7 +2765,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, 0);
 				continue;
 			}
 
@@ -2715,7 +2778,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, FPI_NONE);
+					      order, FPI_NONE, 0);
 				continue;
 			}
 			locked_zone = zone;
@@ -2730,7 +2793,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				order, 0);
 	}
 
 	if (pcp) {
@@ -2781,6 +2844,11 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			return 0;
 	}
 
+	/*
+	 * del_page_from_free_list() updates current's mgen. The user of
+	 * the isolated page should check_flush_task_mgen() before using
+	 * it.
+	 */
 	del_page_from_free_list(page, zone, order, mt);
 
 	/*
@@ -2822,7 +2890,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL);
+			FPI_SKIP_REPORT_NOTIFY | FPI_TO_TAIL, 0);
 }
 
 /*
@@ -2965,6 +3033,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
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
@@ -4791,11 +4864,11 @@ void __free_pages(struct page *page, unsigned int order)
 	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
-		free_unref_page(page, order);
+		free_unref_page(page, order, 0);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
-			free_unref_page(page + (1 << order), order);
+			free_unref_page(page + (1 << order), order, 0);
 	}
 }
 EXPORT_SYMBOL(__free_pages);
@@ -4857,7 +4930,7 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
 	if (page_ref_sub_and_test(page, count))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -4898,7 +4971,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 
 		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+			free_unref_page(page, compound_order(page), 0);
 			goto refill;
 		}
 
@@ -4942,7 +5015,7 @@ void page_frag_free(void *addr)
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
-		free_unref_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page), 0);
 }
 EXPORT_SYMBOL(page_frag_free);
 
@@ -6751,10 +6824,19 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		BUG_ON(!PageBuddy(page));
 		VM_WARN_ON(get_pageblock_migratetype(page) != MIGRATE_ISOLATE);
 		order = buddy_order(page);
+		/*
+		 * del_page_from_free_list() updates current's mgen that
+		 * pairs with check_flush_task_mgen() below in this function.
+		 */
 		del_page_from_free_list(page, zone, order, MIGRATE_ISOLATE);
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
 
@@ -6830,6 +6912,11 @@ bool take_page_off_buddy(struct page *page)
 			int migratetype = get_pfnblock_migratetype(page_head,
 								   pfn_head);
 
+			/*
+			 * del_page_from_free_list() updates current's
+			 * mgen that pairs with check_flush_task_mgen() below
+			 * in this function.
+			 */
 			del_page_from_free_list(page_head, zone, page_order,
 						migratetype);
 			break_down_buddy_pages(zone, page_head, page, 0,
@@ -6842,6 +6929,11 @@ bool take_page_off_buddy(struct page *page)
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
 
@@ -6860,7 +6952,7 @@ bool put_page_back_buddy(struct page *page)
 		int migratetype = get_pfnblock_migratetype(page, pfn);
 
 		ClearPageHWPoisonTakenOff(page);
-		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
+		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE, 0);
 		if (TestClearPageHWPoison(page)) {
 			ret = true;
 		}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 042937d5abe4..ab90481cf0fa 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -260,6 +260,12 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Check and flush for the pages that have been isolated.
+	 */
+	if (isolated_page)
+		check_flush_task_mgen();
 }
 
 static inline struct page *
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
index f0d478eee292..95c11547e831 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -126,10 +126,28 @@ void __folio_put(struct folio *folio)
 	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
 		folio_undo_large_rmappable(folio);
 	mem_cgroup_uncharge(folio);
-	free_unref_page(&folio->page, folio_order(folio));
+	free_unref_page(&folio->page, folio_order(folio), 0);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_mgen(struct folio *folio, unsigned short int mgen)
+{
+	if (unlikely(folio_is_zone_device(folio)))
+		WARN_ON(1);
+	else if (unlikely(folio_test_hugetlb(folio)))
+		WARN_ON(1);
+	else if (unlikely(folio_test_large(folio)))
+		WARN_ON(1);
+	/*
+	 * For now, migrc supports this case only.
+	 */
+	else {
+		page_cache_release(folio);
+		mem_cgroup_uncharge(folio);
+		free_unref_page(&folio->page, 0, mgen);
+	}
+}
+
 /**
  * put_pages_list() - release a list of pages
  * @pages: list of pages threaded on page->lru
-- 
2.17.1


