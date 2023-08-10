Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5987775E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHJKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJKdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:33:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD1AE4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:33:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA50113E;
        Thu, 10 Aug 2023 03:34:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396243F6C4;
        Thu, 10 Aug 2023 03:33:46 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] mm: Implement folio_remove_rmap_range()
Date:   Thu, 10 Aug 2023 11:33:29 +0100
Message-Id: <20230810103332.3062143-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810103332.3062143-1-ryan.roberts@arm.com>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like page_remove_rmap() but batch-removes the rmap for a range of pages
belonging to a folio. This can provide a small speedup due to less
manipuation of the various counters. But more crucially, if removing the
rmap for all pages of a folio in a batch, there is no need to
(spuriously) add it to the deferred split list, which saves significant
cost when there is contention for the split queue lock.

All contained pages are accounted using the order-0 folio (or base page)
scheme.

page_remove_rmap() is refactored so that it forwards to
folio_remove_rmap_range() for !compound cases, and both functions now
share a common epilogue function. The intention here is to avoid
duplication of code.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/rmap.h |   2 +
 mm/rmap.c            | 125 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 97 insertions(+), 30 deletions(-)

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
index 1f04debdc87a..d82d52ebf3a6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1379,6 +1379,94 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
 }
 
+/**
+ * __remove_rmap_finish - common operations when taking down a mapping.
+ * @folio:	Folio containing all pages taken down.
+ * @vma:	The VM area containing the range.
+ * @compound:	True if pages were taken down from PMD or false if from PTE(s).
+ * @nr_unmapped: Number of pages within folio that are now unmapped.
+ * @nr_mapped:	Number of pages within folio that are still mapped.
+ */
+static void __remove_rmap_finish(struct folio *folio,
+				struct vm_area_struct *vma, bool compound,
+				int nr_unmapped, int nr_mapped)
+{
+	enum node_stat_item idx;
+
+	if (nr_unmapped) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
+
+		/*
+		 * Queue large anon folio for deferred split if at least one
+		 * page of the folio is unmapped and at least one page is still
+		 * mapped.
+		 */
+		if (folio_test_large(folio) &&
+		    folio_test_anon(folio) && nr_mapped)
+			deferred_split_folio(folio);
+	}
+
+	/*
+	 * It would be tidy to reset folio_test_anon mapping when fully
+	 * unmapped, but that might overwrite a racing page_add_anon_rmap
+	 * which increments mapcount after us but sets mapping before us:
+	 * so leave the reset to free_pages_prepare, and remember that
+	 * it's only reliable while mapped.
+	 */
+
+	munlock_vma_folio(folio, vma, compound);
+}
+
+/**
+ * folio_remove_rmap_range - Take down PTE mappings from a range of pages.
+ * @folio:	Folio containing all pages in range.
+ * @page:	First page in range to unmap.
+ * @nr:		Number of pages to unmap.
+ * @vma:	The VM area containing the range.
+ *
+ * All pages in the range must belong to the same VMA & folio. They must be
+ * mapped with PTEs, not a PMD.
+ *
+ * Context: Caller holds the pte lock.
+ */
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+					int nr, struct vm_area_struct *vma)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int nr_unmapped = 0;
+	int nr_mapped = 0;
+	bool last;
+
+	if (unlikely(folio_test_hugetlb(folio))) {
+		VM_WARN_ON_FOLIO(1, folio);
+		return;
+	}
+
+	VM_WARN_ON_ONCE(page < &folio->page ||
+			page + nr > (&folio->page + folio_nr_pages(folio)));
+
+	if (!folio_test_large(folio)) {
+		/* Is this the page's last map to be removed? */
+		last = atomic_add_negative(-1, &page->_mapcount);
+		nr_unmapped = last;
+	} else {
+		for (; nr != 0; nr--, page++) {
+			/* Is this the page's last map to be removed? */
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last)
+				nr_unmapped++;
+		}
+
+		/* Pages still mapped if folio mapped entirely */
+		nr_mapped = atomic_sub_return_relaxed(nr_unmapped, mapped);
+		if (nr_mapped >= COMPOUND_MAPPED)
+			nr_unmapped = 0;
+	}
+
+	__remove_rmap_finish(folio, vma, false, nr_unmapped, nr_mapped);
+}
+
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
@@ -1405,15 +1493,13 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		return;
 	}
 
-	/* Is page being unmapped by PTE? Is this its last map to be removed? */
+	/* Is page being unmapped by PTE? */
 	if (likely(!compound)) {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
-		if (last && folio_test_large(folio)) {
-			nr = atomic_dec_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
+		folio_remove_rmap_range(folio, page, 1, vma);
+		return;
+	}
+
+	if (folio_test_pmd_mappable(folio)) {
 		/* That test is redundant: it's for safety or to optimize out */
 
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
@@ -1441,29 +1527,8 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 			idx = NR_FILE_PMDMAPPED;
 		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
 	}
-	if (nr) {
-		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr);
-
-		/*
-		 * Queue anon THP for deferred split if at least one
-		 * page of the folio is unmapped and at least one page
-		 * is still mapped.
-		 */
-		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
-			if (!compound || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
-	}
-
-	/*
-	 * It would be tidy to reset folio_test_anon mapping when fully
-	 * unmapped, but that might overwrite a racing page_add_anon_rmap
-	 * which increments mapcount after us but sets mapping before us:
-	 * so leave the reset to free_pages_prepare, and remember that
-	 * it's only reliable while mapped.
-	 */
 
-	munlock_vma_folio(folio, vma, compound);
+	__remove_rmap_finish(folio, vma, compound, nr, nr_pmdmapped - nr);
 }
 
 /*
-- 
2.25.1

