Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759A759776
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGSNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGSNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:55:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F0B112C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:55:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4238512FC;
        Wed, 19 Jul 2023 06:55:51 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672B43F6C4;
        Wed, 19 Jul 2023 06:55:06 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/3] mm: Implement folio_remove_rmap_range()
Date:   Wed, 19 Jul 2023 14:54:49 +0100
Message-Id: <20230719135450.545227-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719135450.545227-1-ryan.roberts@arm.com>
References: <20230719135450.545227-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/rmap.h |  2 ++
 mm/rmap.c            | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..f578975c12c0 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+		int nr, struct vm_area_struct *vma);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/rmap.c b/mm/rmap.c
index eb0bb00dae34..4022a3ab73a8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1359,6 +1359,78 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	mlock_vma_folio(folio, vma, compound);
 }
 
+/**
+ * folio_remove_rmap_range - Take down PTE mappings from a range of pages.
+ * @folio:	Folio containing all pages in range.
+ * @page:	First page in range to unmap.
+ * @nr:		Number of pages to unmap.
+ * @vma:	The VM area containing the range.
+ *
+ * All pages in the range must belong to the same VMA & folio.  They
+ * must be mapped with PTEs, not a PMD.
+ *
+ * Context: Caller holds the pte lock.
+ */
+void folio_remove_rmap_range(struct folio *folio, struct page *page,
+					int nr, struct vm_area_struct *vma)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int nr_unmapped = 0;
+	int nr_mapped;
+	bool last;
+	enum node_stat_item idx;
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
+	if (nr_unmapped) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
+
+		/*
+		 * Queue anon large folio for deferred split if at least one
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
+	munlock_vma_folio(folio, vma, false);
+}
+
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
-- 
2.25.1

