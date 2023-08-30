Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415478DC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjH3SpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbjH3OwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:52:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6BAFF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Owktm7TNdNcXZnY3mU7B54RV0SGTtbMUwxa+1pnnvlE=; b=WQ8aA33cFEtJf2oQ1LM/zm9Ilz
        qYU8KUCQ+Sgkl6W3x+0468BBJfAIT+3EUlmmrw7wpxTl8RHlnMBF67qHjRD3LVbVUKpFGmgSBuMUR
        a61fa55sqTeQVoFUtw22VGJ9epY4bbxFZDvTQf1sf6rsin1GSdI1lH/PLw+KbG2qoANFXD7In4QjU
        v2NUvQKE9Ee1d52QbOx6oXxP3mBoJe38WKKFJTcZievYeilP+Nt02d/zVEJNFzTHc+w84o36ourLl
        vSin1cH+kK2LyEMw6hrO0C8ETaNytK5XUb0NQF2ARaqYqMjMAFoxDlBbAjFZy79nbnvhhp0W7VScE
        U8eYWuEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbMXq-00DLm7-Fq; Wed, 30 Aug 2023 14:51:46 +0000
Date:   Wed, 30 Aug 2023 15:51:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: Implement folio_remove_rmap_range()
Message-ID: <ZO9XgttGXnx5dxFZ@casper.infradead.org>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830095011.1228673-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:50:07AM +0100, Ryan Roberts wrote:
> Like page_remove_rmap() but batch-removes the rmap for a range of pages
> belonging to a folio. This can provide a small speedup due to less
> manipuation of the various counters. But more crucially, if removing the
> rmap for all pages of a folio in a batch, there is no need to
> (spuriously) add it to the deferred split list, which saves significant
> cost when there is contention for the split queue lock.
> 
> All contained pages are accounted using the order-0 folio (or base page)
> scheme.
> 
> page_remove_rmap() is refactored so that it forwards to
> folio_remove_rmap_range() for !compound cases, and both functions now
> share a common epilogue function. The intention here is to avoid
> duplication of code.

What would you think to doing it like this instead?  This probably doesn't
even compile and it's definitely not sanity checked; just trying to get
across an idea of the shape of this code.  I think this is more like
what DavidH was asking for (but he's on holiday this week so won't be
able to confirm).


diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a3825ce81102..d442d1e5425d 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -202,6 +202,8 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
 		struct vm_area_struct *, bool compound);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+		int nr, struct vm_area_struct *vma);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index ec7f8e6c9e48..2592be47452e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1380,24 +1380,26 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 }
 
 /**
- * page_remove_rmap - take down pte mapping from a page
- * @page:	page to remove mapping from
- * @vma:	the vm area from which the mapping is removed
- * @compound:	uncharge the page as compound or small page
+ * folio_remove_rmap_range - Take down PTE mappings from a range of pages.
+ * @folio:	Folio containing all pages in range.
+ * @page:	First page in range to unmap.
+ * @nr:		Number of pages to unmap.  -1 to unmap a PMD.
+ * @vma:	The VM area containing the range.
  *
- * The caller needs to hold the pte lock.
+ * All pages in the range must belong to the same VMA & folio.
+ *
+ * Context: Caller holds the pte lock.
  */
-void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
-		bool compound)
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+			int pages, struct vm_area_struct *vma)
 {
-	struct folio *folio = page_folio(page);
 	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int nr_unmapped = 0;
+	int nr_mapped = 0;
 	int nr = 0, nr_pmdmapped = 0;
 	bool last;
 	enum node_stat_item idx;
 
-	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
-
 	/* Hugetlb pages are not counted in NR_*MAPPED */
 	if (unlikely(folio_test_hugetlb(folio))) {
 		/* hugetlb pages are always mapped with pmds */
@@ -1405,14 +1407,25 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		return;
 	}
 
-	/* Is page being unmapped by PTE? Is this its last map to be removed? */
-	if (likely(!compound)) {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
-		if (last && folio_test_large(folio)) {
-			nr = atomic_dec_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
+	/* Are we taking down a PMD mapping? */
+	if (likely(pages > 0)) {
+		VM_WARN_ON_ONCE(page < folio_page(folio, 0) ||
+				page + pages > folio_page(folio,
+						folio_nr_pages(folio)));
+		while (pages) {
+			/* Is this the page's last map to be removed? */
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last)
+				nr_unmapped++;
+			pages--;
+			page++;
 		}
+
+		/* Pages still mapped if folio mapped entirely */
+		nr_mapped = atomic_sub_return_relaxed(nr_unmapped, mapped);
+		if (nr_mapped >= COMPOUND_MAPPED)
+			nr_unmapped = 0;
+
 	} else if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
@@ -1441,18 +1454,19 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 			idx = NR_FILE_PMDMAPPED;
 		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
 	}
+
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
 		__lruvec_stat_mod_folio(folio, idx, -nr);
 
 		/*
-		 * Queue anon THP for deferred split if at least one
-		 * page of the folio is unmapped and at least one page
-		 * is still mapped.
+		 * Queue large anon folio for deferred split if at least one
+		 * page of the folio is unmapped and at least one page is still
+		 * mapped.
 		 */
-		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
-			if (!compound || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_large(folio) && folio_test_anon(folio) &&
+		    nr_mapped)
+			deferred_split_folio(folio);
 	}
 
 	/*
@@ -1466,6 +1480,20 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	munlock_vma_folio(folio, vma, compound);
 }
 
+/**
+ * page_remove_rmap - take down pte mapping from a page
+ * @page:	page to remove mapping from
+ * @vma:	the vm area from which the mapping is removed
+ * @compound:	uncharge the page as compound or small page
+ *
+ * The caller needs to hold the pte lock.
+ */
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
+		bool compound)
+{
+	folio_remove_rmap_range(page_folio(page), page, compound ? -1 : 1, vma);
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
