Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0478DFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbjH3TVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjH3Juq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:50:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE8051B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:50:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E52A2F4;
        Wed, 30 Aug 2023 02:51:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7E13F64C;
        Wed, 30 Aug 2023 02:50:39 -0700 (PDT)
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
Subject: [PATCH v2 5/5] mm/mmu_gather: Store and process pages in contig ranges
Date:   Wed, 30 Aug 2023 10:50:11 +0100
Message-Id: <20230830095011.1228673-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830095011.1228673-1-ryan.roberts@arm.com>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
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

mmu_gather accumulates a set of pages into a buffer for later rmap
removal and freeing. Page pointers were previously stored in a "linked
list of arrays", then at flush time, each page in the buffer was removed
from the rmap, removed from the swapcache and its refcount was
decremented; if the refcount reached 0, then it was freed.

With increasing numbers of large folios (or at least contiguous parts of
large folios) mapped into userspace processes (pagecache pages for
supporting filesystems currently, but in future also large anonymous
folios), we can measurably improve performance of process teardown:

- For rmap removal, we can batch-remove a range of pages belonging to
  the same folio with folio_remove_rmap_range(), which is more efficient
  because atomics can be manipulated just once per range. In the common
  case, it also allows us to elide adding the (anon) folio to the
  deferred split queue, only to remove it a bit later, once all pages of
  the folio have been removed fro mthe rmap.

- For swapcache removal, we only need to check and remove the folio from
  the swap cache once, rather than trying for each individual page.

- For page release, we can batch-decrement the refcount for each page in
  the folio and free it if it hits zero.

Change the page pointer storage format within the mmu_gather batch
structure to store "pfn_range"s; a [start, end) pfn pair. This allows us
to run length encode a contiguous range of pages that all belong to the
same folio. This likely allows us to improve cache locality a bit. But
it also gives us a convenient format for implementing the above 3
optimizations.

Of course if running on a system that does not extensively use large
pte-mapped folios, then the RLE approach uses twice as much memory,
because each range is 1 page long and uses 2 words. But performance
measurements show no impact in terms of performance.

Macro Performance Results
-------------------------

Test: Timed kernel compilation on Ampere Altra (arm64), 80 jobs
Configs: Comparing with and without large anon folios

Without large anon folios:
| kernel           |   real-time |   kern-time |   user-time |
|:-----------------|------------:|------------:|------------:|
| baseline-laf-off |        0.0% |        0.0% |        0.0% |
| mmugather-range  |       -0.3% |       -0.3% |        0.1% |

With large anon folios (order-3):
| kernel           |   real-time |   kern-time |   user-time |
|:-----------------|------------:|------------:|------------:|
| baseline-laf-on  |        0.0% |        0.0% |        0.0% |
| mmugather-range  |       -0.7% |       -3.9% |       -0.1% |

Test: Timed kernel compilation in VM on Apple M2 MacBook Pro, 8 jobs
Configs: Comparing with and without large anon folios

Without large anon folios:
| kernel           |   real-time |   kern-time |   user-time |
|:-----------------|------------:|------------:|------------:|
| baseline-laf-off |        0.0% |        0.0% |        0.0% |
| mmugather-range  |       -0.9% |       -2.9% |       -0.6% |

With large anon folios (order-3):
| kernel           |   real-time |   kern-time |   user-time |
|:-----------------|------------:|------------:|------------:|
| baseline-laf-on  |        0.0% |        0.0% |        0.0% |
| mmugather-range  |       -0.4% |       -3.7% |       -0.2% |

Micro Performance Results
-------------------------

Flame graphs for kernel compilation on Ampere Altra show reduction in
cycles consumed by __arm64_sys_exit_group syscall:

    Without large anon folios: -2%
    With large anon folios:    -26%

For the large anon folios case, it also shows a big difference in cost
of rmap removal:

   baseline: cycles in page_remove_rmap(): 24.7B
   mmugather-range: cycles in folio_remove_rmap_range(): 5.5B

Furthermore, the baseline shows 5.2B cycles used by
deferred_split_folio() which has completely disappeared after
applying this series.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/asm-generic/tlb.h |  7 +++--
 include/linux/mm.h        |  7 +++++
 include/linux/swap.h      |  6 ++--
 mm/mmu_gather.c           | 59 +++++++++++++++++++++++++++++++++------
 mm/swap.c                 | 26 +++++++++++++++++
 mm/swap_state.c           | 11 ++++----
 6 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index d874415aaa33..04e23cad6d1f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -246,11 +246,11 @@ struct mmu_gather_batch {
 	struct mmu_gather_batch	*next;
 	unsigned int		nr;
 	unsigned int		max;
-	struct page		*pages[];
+	struct pfn_range	folios[];
 };
 
 #define MAX_GATHER_BATCH	\
-	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
+	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(struct pfn_range))
 
 /*
  * Limit the maximum number of mmu_gather batches to reduce a risk of soft
@@ -342,7 +342,8 @@ struct mmu_gather {
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
-	struct page		*__pages[MMU_GATHER_BUNDLE];
+	struct pfn_range	__folios[MMU_GATHER_BUNDLE];
+	unsigned long		range_limit;
 	struct mmu_gather_batch *rmap_pend;
 	unsigned int		rmap_pend_first;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9cd20a38089c..f62d3d8ea0e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1476,6 +1476,13 @@ static inline void folio_put_refs(struct folio *folio, int refs)
 		__folio_put(folio);
 }
 
+struct pfn_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+void folios_put_refs(struct pfn_range *folios, int nr);
+
 /*
  * union release_pages_arg - an array of pages or folios
  *
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 9e12c6d49997..cd12056a6a5f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -451,7 +451,7 @@ static inline unsigned long total_swapcache_pages(void)
 
 extern void free_swap_cache(struct page *page);
 extern void free_page_and_swap_cache(struct page *);
-extern void free_pages_and_swap_cache(struct page **, int);
+extern void free_folios_and_swap_cache(struct pfn_range *, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
@@ -528,8 +528,8 @@ static inline void put_swap_device(struct swap_info_struct *si)
  * so leave put_page and release_pages undeclared... */
 #define free_page_and_swap_cache(page) \
 	put_page(page)
-#define free_pages_and_swap_cache(pages, nr) \
-	release_pages((pages), (nr));
+#define free_folios_and_swap_cache(folios, nr) \
+	folios_put_refs((folios), (nr))
 
 /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
 #define free_swap_and_cache(e) is_pfn_swap_entry(e)
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index cdebb5b9f5c4..c8687ce07ce0 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -22,6 +22,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	batch = tlb->active;
 	if (batch->next) {
 		tlb->active = batch->next;
+		tlb->range_limit = ULONG_MAX;
 		return true;
 	}
 
@@ -39,6 +40,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 
 	tlb->active->next = batch;
 	tlb->active = batch;
+	tlb->range_limit = ULONG_MAX;
 
 	return true;
 }
@@ -49,9 +51,12 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch,
 				 struct vm_area_struct *vma)
 {
 	for (int i = first; i < batch->nr; i++) {
-		struct page *page = batch->pages[i];
+		struct pfn_range *range = &batch->folios[i];
+		int nr = range->end - range->start;
+		struct page *start = pfn_to_page(range->start);
+		struct folio *folio = page_folio(start);
 
-		page_remove_rmap(page, vma, false);
+		folio_remove_rmap_range(folio, start, nr, vma);
 	}
 }
 
@@ -75,6 +80,11 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	for (batch = batch->next; batch && batch->nr; batch = batch->next)
 		tlb_flush_rmap_batch(batch, 0, vma);
 
+	/*
+	 * Move to the next range on next page insertion to prevent any future
+	 * pages from being accumulated into the range we just did the rmap for.
+	 */
+	tlb->range_limit = ULONG_MAX;
 	tlb_discard_rmaps(tlb);
 }
 
@@ -94,7 +104,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct page **pages = batch->pages;
+		struct pfn_range *folios = batch->folios;
 
 		do {
 			/*
@@ -102,14 +112,15 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 			 */
 			unsigned int nr = min(512U, batch->nr);
 
-			free_pages_and_swap_cache(pages, nr);
-			pages += nr;
+			free_folios_and_swap_cache(folios, nr);
+			folios += nr;
 			batch->nr -= nr;
 
 			cond_resched();
 		} while (batch->nr);
 	}
 	tlb->active = &tlb->local;
+	tlb->range_limit = ULONG_MAX;
 	tlb_discard_rmaps(tlb);
 }
 
@@ -127,6 +138,8 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
 {
 	struct mmu_gather_batch *batch;
+	struct pfn_range *range;
+	unsigned long pfn = page_to_pfn(page);
 
 	VM_BUG_ON(!tlb->end);
 
@@ -135,11 +148,38 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 #endif
 
 	batch = tlb->active;
+	range = &batch->folios[batch->nr - 1];
+
+	/*
+	 * If there is a range being accumulated, add the pfn to the range if
+	 * its contiguous, else start the next range. range_limit is always
+	 * ULONG_MAX when nr is 0, which protects the batch->folios[-1] case.
+	 */
+	if (tlb->range_limit != ULONG_MAX && pfn == range->end) {
+		range->end++;
+	} else {
+		struct folio *folio = page_folio(page);
+
+		range = &batch->folios[batch->nr++];
+		range->start = pfn;
+		range->end = pfn + 1;
+
+		tlb->range_limit = page_to_pfn(&folio->page) +
+							folio_nr_pages(folio);
+	}
+
+	/*
+	 * If we have reached the end of the folio, move to the next range when
+	 * we add the next page; Never span multiple folios in the same range.
+	 */
+	if (range->end == tlb->range_limit)
+		tlb->range_limit = ULONG_MAX;
+
 	/*
-	 * Add the page and check if we are full. If so
-	 * force a flush.
+	 * Check if we are full. If so force a flush. In order to ensure we
+	 * always have a free range for the next added page, the last range in a
+	 * batch always only has a single page.
 	 */
-	batch->pages[batch->nr++] = page;
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
@@ -318,8 +358,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->need_flush_all = 0;
 	tlb->local.next = NULL;
 	tlb->local.nr   = 0;
-	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
+	tlb->local.max  = ARRAY_SIZE(tlb->__folios);
 	tlb->active     = &tlb->local;
+	tlb->range_limit = ULONG_MAX;
 	tlb->batch_count = 0;
 	tlb->rmap_pend	= &tlb->local;
 	tlb->rmap_pend_first = 0;
diff --git a/mm/swap.c b/mm/swap.c
index 5d3e35668929..d777f2b47674 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1037,6 +1037,32 @@ static void __folios_put_refs_do_one(struct folios_put_refs_ctx *ctx,
 	list_add(&folio->lru, &ctx->pages_to_free);
 }
 
+/**
+ * folios_put_refs - batched folio_put_refs()
+ * @folios: array of `struct pfn_range`s to release
+ * @nr: number of folio ranges
+ *
+ * Each `struct pfn_range` describes the start and end pfn of a range within a
+ * single folio. The folio reference count is decremented once for each pfn in
+ * the range. If it fell to zero, remove the page from the LRU and free it.
+ */
+void folios_put_refs(struct pfn_range *folios, int nr)
+{
+	int i;
+	struct folios_put_refs_ctx ctx;
+
+	__folios_put_refs_init(&ctx);
+
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = pfn_folio(folios[i].start);
+		int refs = folios[i].end - folios[i].start;
+
+		__folios_put_refs_do_one(&ctx, folio, refs);
+	}
+
+	__folios_put_refs_complete(&ctx);
+}
+
 /**
  * release_pages - batched put_page()
  * @arg: array of pages to release
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2132340c6e61..900e57bf9882 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -304,15 +304,16 @@ void free_page_and_swap_cache(struct page *page)
 }
 
 /*
- * Passed an array of pages, drop them all from swapcache and then release
- * them.  They are removed from the LRU and freed if this is their last use.
+ * Passed an array of folio ranges, drop all folios from swapcache and then put
+ * a folio reference for each page in the range.  They are removed from the LRU
+ * and freed if this is their last use.
  */
-void free_pages_and_swap_cache(struct page **pages, int nr)
+void free_folios_and_swap_cache(struct pfn_range *folios, int nr)
 {
 	lru_add_drain();
 	for (int i = 0; i < nr; i++)
-		free_swap_cache(pages[i]);
-	release_pages(pages, nr);
+		free_swap_cache(pfn_to_page(folios[i].start));
+	folios_put_refs(folios, nr);
 }
 
 static inline bool swap_use_vma_readahead(void)
-- 
2.25.1

