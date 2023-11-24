Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60077F74E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjKXN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKXN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6141BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/66tdUTtIlpBX26NzgkLUQsEQZwgNiRXmWKFnjYfBOk=;
        b=CrFVJ/ygWBgIybi1/fSnA/wAKPEiWLgD0ZYic3dKzEo7XN3acPK5j4U63r7qSRCpCLuDDJ
        nkO4oYWIVrbYFGdhp025iQF6a2Eay6m+71puab/MJgGnD6Y63sJ1ovmczu/IfFKQu/oi39
        MsNZ0NV1Pjophm8DPa4gTe83gBX68CA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ojdg3s0mO9myWpWvuZxs4w-1; Fri, 24 Nov 2023 08:26:39 -0500
X-MC-Unique: ojdg3s0mO9myWpWvuZxs4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01090185A781;
        Fri, 24 Nov 2023 13:26:39 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9A22166B2A;
        Fri, 24 Nov 2023 13:26:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 02/20] mm: add a total mapcount for large folios
Date:   Fri, 24 Nov 2023 14:26:07 +0100
Message-ID: <20231124132626.235350-3-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's track the total mapcount for all large folios in the first subpage.

The total mapcount is what we actually want to know in folio_mapcount()
and it is also sufficient for implementing folio_mapped().

With PTE-mapped THP becoming more important and soon more widely used, we
want to avoid looping over all pages of a folio just to calculate the total
mapcount. Further, we might soon want to use the total mapcount in other
context more frequently, so prepare for reading it efficiently and
atomically.

Maintain the total mapcount also for hugetlb pages. Use the total mapcount
to implement folio_mapcount(). Make folio_mapped() simply call
folio_mapped().

We can now get rid of folio_large_is_mapped() and move
folio_large_total_mapcount() to mm.h. Similarly, get rid of
folio_nr_pages_mapped() and stop dumping that value in __dump_page().

While at it, simplify total_mapcount() by calling folio_mapcount() and
page_mapped() by calling folio_mapped(): it seems to add only one more MOV
instruction on x86-64 to the compiled code, which we shouldn't have to
worry about.

_nr_pages_mapped is now only used in rmap code, so not accidentally
externally where it might be used on arbitrary order-1 pages. The remaining
usage is:

(1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
 -> If we would account the total folio as mapped when mapping a
    page (based on the total mapcount), we could remove that usage.
    We'll have to be careful about memory-sensitive applications that also
    adjust /sys/kernel/debug/fault_around_bytes to not get a large
    folio completely mapped on page fault.

(2) Detect when to add an anon folio to the deferred split queue
 -> If we would apply a different heuristic, or scan using the rmap on
    the memory reclaim path for partially mapped anon folios to
    split them, we could remove that usage as well.

For now, these things remain as they are, they need more thought. Hugh
really did a fantastic job implementing that tracking after all.

Note that before the total mapcount would overflow, already our refcount
would overflow: each distinct mapping requires a distinct reference.
Probably, in the future, we want 64bit refcount+mapcount for larger
folios.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst | 12 +++++------
 include/linux/mm.h             | 37 +++++++++-----------------------
 include/linux/mm_types.h       |  5 +++--
 include/linux/rmap.h           | 15 ++++++++-----
 mm/debug.c                     |  4 ++--
 mm/hugetlb.c                   |  4 ++--
 mm/internal.h                  | 10 +--------
 mm/page_alloc.c                |  4 ++++
 mm/rmap.c                      | 39 ++++++++++++----------------------
 9 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 9a607059ea11..b0d3b1d3e8ea 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -116,14 +116,14 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
-    folio->_entire_mapcount and also increment/decrement
-    folio->_nr_pages_mapped by COMPOUND_MAPPED when _entire_mapcount
-    goes from -1 to 0 or 0 to -1.
+    folio->_entire_mapcount, increment/decrement folio->_total_mapcount
+    and also increment/decrement folio->_nr_pages_mapped by COMPOUND_MAPPED
+    when _entire_mapcount goes from -1 to 0 or 0 to -1.
 
   - map/unmap of individual pages with PTE entry increment/decrement
-    page->_mapcount and also increment/decrement folio->_nr_pages_mapped
-    when page->_mapcount goes from -1 to 0 or 0 to -1 as this counts
-    the number of pages mapped by PTE.
+    page->_mapcount, increment/decrement folio->_total_mapcount and also
+    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
+    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
 
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..fe91aaefa3db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,17 +1207,16 @@ static inline int page_mapcount(struct page *page)
 	return mapcount;
 }
 
-int folio_total_mapcount(struct folio *folio);
+static inline int folio_total_mapcount(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
+	return atomic_read(&folio->_total_mapcount) + 1;
+}
 
 /**
- * folio_mapcount() - Calculate the number of mappings of this folio.
+ * folio_mapcount() - Number of mappings of this folio.
  * @folio: The folio.
  *
- * A large folio tracks both how many times the entire folio is mapped,
- * and how many times each individual page in the folio is mapped.
- * This function calculates the total number of times the folio is
- * mapped.
- *
  * Return: The number of times this folio is mapped.
  */
 static inline int folio_mapcount(struct folio *folio)
@@ -1229,19 +1228,7 @@ static inline int folio_mapcount(struct folio *folio)
 
 static inline int total_mapcount(struct page *page)
 {
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-	return folio_total_mapcount(page_folio(page));
-}
-
-static inline bool folio_large_is_mapped(struct folio *folio)
-{
-	/*
-	 * Reading _entire_mapcount below could be omitted if hugetlb
-	 * participated in incrementing nr_pages_mapped when compound mapped.
-	 */
-	return atomic_read(&folio->_nr_pages_mapped) > 0 ||
-		atomic_read(&folio->_entire_mapcount) >= 0;
+	return folio_mapcount(page_folio(page));
 }
 
 /**
@@ -1252,9 +1239,7 @@ static inline bool folio_large_is_mapped(struct folio *folio)
  */
 static inline bool folio_mapped(struct folio *folio)
 {
-	if (likely(!folio_test_large(folio)))
-		return atomic_read(&folio->_mapcount) >= 0;
-	return folio_large_is_mapped(folio);
+	return folio_mapcount(folio) > 0;
 }
 
 /*
@@ -1264,9 +1249,7 @@ static inline bool folio_mapped(struct folio *folio)
  */
 static inline bool page_mapped(struct page *page)
 {
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) >= 0;
-	return folio_large_is_mapped(page_folio(page));
+	return folio_mapped(page_folio(page));
 }
 
 static inline struct page *virt_to_head_page(const void *x)
@@ -2139,7 +2122,7 @@ static inline size_t folio_size(struct folio *folio)
  * looking at the precise mapcount of the first subpage in the folio, and
  * assuming the other subpages are the same. This may not be true for large
  * folios. If you want exact mapcounts for exact calculations, look at
- * page_mapcount() or folio_total_mapcount().
+ * page_mapcount() or folio_mapcount().
  *
  * Return: The estimated number of processes sharing a folio.
  */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..99b84b4797b9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -264,7 +264,8 @@ typedef struct {
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
- * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
+ * @_total_mapcount: Do not use directly, call folio_mapcount().
+ * @_nr_pages_mapped: Do not use outside of rmap code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
@@ -323,8 +324,8 @@ struct folio {
 		struct {
 			unsigned long _flags_1;
 			unsigned long _head_1;
-			unsigned long _folio_avail;
 	/* public: */
+			atomic_t _total_mapcount;
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b26fe858fd44..42e2c74d4d6e 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -210,14 +210,19 @@ void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
-	if (compound) {
-		struct folio *folio = (struct folio *)page;
+	struct folio *folio = page_folio(page);
 
-		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
-		atomic_inc(&folio->_entire_mapcount);
-	} else {
+	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
+	if (likely(!folio_test_large(folio))) {
 		atomic_inc(&page->_mapcount);
+		return;
 	}
+
+	if (compound)
+		atomic_inc(&folio->_entire_mapcount);
+	else
+		atomic_inc(&page->_mapcount);
+	atomic_inc(&folio->_total_mapcount);
 }
 
 static inline void page_dup_file_rmap(struct page *page, bool compound)
diff --git a/mm/debug.c b/mm/debug.c
index ee533a5ceb79..97f6f6b32ae7 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -99,10 +99,10 @@ static void __dump_page(struct page *page)
 			page, page_ref_count(head), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
-		pr_warn("head:%p order:%u entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
+		pr_warn("head:%p order:%u entire_mapcount:%d total_mapcount:%d pincount:%d\n",
 				head, compound_order(head),
 				folio_entire_mapcount(folio),
-				folio_nr_pages_mapped(folio),
+				folio_mapcount(folio),
 				atomic_read(&folio->_pincount));
 	}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..cf84784064c7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1509,7 +1509,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
 	struct page *p;
 
 	atomic_set(&folio->_entire_mapcount, 0);
-	atomic_set(&folio->_nr_pages_mapped, 0);
+	atomic_set(&folio->_total_mapcount, 0);
 	atomic_set(&folio->_pincount, 0);
 
 	for (i = 1; i < nr_pages; i++) {
@@ -2119,7 +2119,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	/* we rely on prep_new_hugetlb_folio to set the destructor */
 	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
-	atomic_set(&folio->_nr_pages_mapped, 0);
+	atomic_set(&folio->_total_mapcount, -1);
 	atomic_set(&folio->_pincount, 0);
 	return true;
 
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..bb2e55c402e7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -67,15 +67,6 @@ void page_writeback_init(void);
  */
 #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
 
-/*
- * How many individual pages have an elevated _mapcount.  Excludes
- * the folio's entire_mapcount.
- */
-static inline int folio_nr_pages_mapped(struct folio *folio)
-{
-	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
-}
-
 static inline void *folio_raw_mapping(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
@@ -429,6 +420,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	struct folio *folio = (struct folio *)page;
 
 	folio_set_order(folio, order);
+	atomic_set(&folio->_total_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..aad45758c0c7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -988,6 +988,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero entire_mapcount");
 			goto out;
 		}
+		if (unlikely(atomic_read(&folio->_total_mapcount) + 1)) {
+			bad_page(page, "nonzero total_mapcount");
+			goto out;
+		}
 		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
diff --git a/mm/rmap.c b/mm/rmap.c
index afddf3d82a8f..38765796dca8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1104,35 +1104,12 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 	return page_vma_mkclean_one(&pvmw);
 }
 
-int folio_total_mapcount(struct folio *folio)
-{
-	int mapcount = folio_entire_mapcount(folio);
-	int nr_pages;
-	int i;
-
-	/* In the common case, avoid the loop when no pages mapped by PTE */
-	if (folio_nr_pages_mapped(folio) == 0)
-		return mapcount;
-	/*
-	 * Add all the PTE mappings of those pages mapped by PTE.
-	 * Limit the loop to folio_nr_pages_mapped()?
-	 * Perhaps: given all the raciness, that may be a good or a bad idea.
-	 */
-	nr_pages = folio_nr_pages(folio);
-	for (i = 0; i < nr_pages; i++)
-		mapcount += atomic_read(&folio_page(folio, i)->_mapcount);
-
-	/* But each of those _mapcounts was based on -1 */
-	mapcount += nr_pages;
-	return mapcount;
-}
-
 static unsigned int __folio_add_rmap_range(struct folio *folio,
 		struct page *page, unsigned int nr_pages, bool compound,
 		int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int first, nr = 0;
+	int first, count, nr = 0;
 
 	VM_WARN_ON_FOLIO(compound && page != &folio->page, folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
@@ -1144,6 +1121,7 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (!compound) {
+		count = nr_pages;
 		do {
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first) {
@@ -1151,7 +1129,8 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 				if (first < COMPOUND_MAPPED)
 					nr++;
 			}
-		} while (page++, --nr_pages > 0);
+		} while (page++, --count > 0);
+		atomic_add(nr_pages, &folio->_total_mapcount);
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1169,6 +1148,7 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 				nr = 0;
 			}
 		}
+		atomic_inc(&folio->_total_mapcount);
 	} else {
 		VM_WARN_ON_ONCE_FOLIO(true, folio);
 	}
@@ -1348,6 +1328,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
 	}
 
+	if (folio_test_large(folio))
+		/* increment count (starts at -1) */
+		atomic_set(&folio->_total_mapcount, 0);
+
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 	__folio_set_anon(folio, vma, address, true);
 	SetPageAnonExclusive(&folio->page);
@@ -1427,6 +1411,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
+	if (folio_test_large(folio))
+		atomic_dec(&folio->_total_mapcount);
+
 	/* Hugetlb pages are not counted in NR_*MAPPED */
 	if (unlikely(folio_test_hugetlb(folio))) {
 		/* hugetlb pages are always mapped with pmds */
@@ -2576,6 +2563,7 @@ void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
+	atomic_inc(&folio->_total_mapcount);
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(&folio->page);
 	VM_WARN_ON_FOLIO(folio_entire_mapcount(folio) > 1 &&
@@ -2588,6 +2576,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
+	atomic_set(&folio->_total_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
 	__folio_set_anon(folio, vma, address, true);
 	SetPageAnonExclusive(&folio->page);
-- 
2.41.0

