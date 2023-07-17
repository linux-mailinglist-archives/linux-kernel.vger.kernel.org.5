Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275C875665E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGQObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjGQOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:31:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F17EE5E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:31:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 642BD11FB;
        Mon, 17 Jul 2023 07:32:08 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749663F738;
        Mon, 17 Jul 2023 07:31:23 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Date:   Mon, 17 Jul 2023 15:31:09 +0100
Message-Id: <20230717143110.260162-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717143110.260162-1-ryan.roberts@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
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

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/rmap.h |  2 ++
 mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
index 2baf57d65c23..1da05aca2bb1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	mlock_vma_folio(folio, vma, compound);
 }
 
+/*
+ * folio_remove_rmap_range - take down pte mappings from a range of pages
+ * belonging to a folio. All pages are accounted as small pages.
+ * @folio:	folio that all pages belong to
+ * @page:       first page in range to remove mapping from
+ * @nr:		number of pages in range to remove mapping from
+ * @vma:        the vm area from which the mapping is removed
+ *
+ * The caller needs to hold the pte lock.
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
+	if (!folio_test_large(folio)) {
+		/* Is this the page's last map to be removed? */
+		last = atomic_add_negative(-1, &page->_mapcount);
+		nr_unmapped = last;
+	} else {
+		for (; nr != 0; nr--, page++) {
+			/* Is this the page's last map to be removed? */
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last) {
+				/* Page still mapped if folio mapped entirely */
+				nr_mapped = atomic_dec_return_relaxed(mapped);
+				if (nr_mapped < COMPOUND_MAPPED)
+					nr_unmapped++;
+			}
+		}
+	}
+
+	if (nr_unmapped) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
+
+		/*
+		 * Queue anon THP for deferred split if we have just unmapped at
+		 * least 1 page, while at least 1 page remains mapped.
+		 */
+		if (folio_test_large(folio) && folio_test_anon(folio))
+			if (nr_mapped)
+				deferred_split_folio(folio);
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

