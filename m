Return-Path: <linux-kernel+bounces-3372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB453816B97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94549283B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F031A73D;
	Mon, 18 Dec 2023 10:51:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B61A72E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA9C81424;
	Mon, 18 Dec 2023 02:52:13 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4DF3F738;
	Mon, 18 Dec 2023 02:51:25 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/16] mm: Batch-clear PTE ranges during zap_pte_range()
Date: Mon, 18 Dec 2023 10:50:47 +0000
Message-Id: <20231218105100.172635-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218105100.172635-1-ryan.roberts@arm.com>
References: <20231218105100.172635-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert zap_pte_range() to copy a batch of ptes in one go. A given batch
is determined by the architecture (see pte_batch_remaining()), and maps
a physically contiguous block of memory, all belonging to the same
folio. A pte batch is cleared using the new helper, clear_ptes().

The primary motivation for this change is to reduce the number of tlb
maintenance operations that the arm64 backend has to perform during exit
and other syscalls that cause zap_pte_range() (e.g. munmap,
madvise(DONTNEED), etc.), as it is about to add transparent support for
the "contiguous bit" in its ptes. By clearing ptes using the new
clear_ptes() API, the backend doesn't have to perform an expensive
unfold operation when a PTE being cleared is part of a contpte block.
Instead it can just clear the whole block immediately.

This code is very performance sensitive, and a significant amount of
effort has been put into not regressing performance for the order-0
folio case. By default, pte_batch_remaining() always returns 1, which
enables the compiler to simplify the extra loops that are added for
batching and produce code that is equivalent (and equally performant) as
the previous implementation.

This change addresses the core-mm refactoring only, and introduces
clear_ptes() with a default implementation that calls
ptep_get_and_clear_full() for each pte in the range. Note that this API
returns the pte at the beginning of the batch, but with the dirty and
young bits set if ANY of the ptes in the cleared batch had those bits
set; this information is applied to the folio by the core-mm. Given the
batch is guaranteed to cover only a single folio, collapsing this state
does not lose any useful information.

A separate change will implement clear_ptes() in the arm64 backend to
realize the performance improvement as part of the work to enable
contpte mappings.

The following microbenchmark results demonstate that there is no
madvise(dontneed) performance regression (and actually an improvement in
some cases) after this patch. madvise(dontneed) is called for each page
of a 1G populated mapping and the total time is measured. 100 iterations
per run, 8 runs performed on both Apple M2 (VM) and Ampere Altra (bare
metal). Tests performed for case where 1G memory is comprised of order-0
folios and case where comprised of pte-mapped order-9 folios. Negative
is faster, positive is slower, compared to baseline upon which the
series is based:

| Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
| dontneed      |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    7.5% |    0.0% |    7.9% |
| after-change  |   -9.6% |    3.1% |   -4.9% |    8.1% |

| Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
| dontneed      |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    0.1% |    0.0% |    0.0% |
| after-change  |   -0.2% |    0.1% |   -0.1% |    0.0% |

The following microbenchmark results demonstate that there is no munmap
performance regression (and actually an improvement in some cases) after
this patch. munmap is called for a 1G populated mapping and the time to
execute the function is measured. 100 iterations per run, 8 runs
performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
performed for case where 1G memory is comprised of order-0 folios and
case where comprised of pte-mapped order-9 folios. Negative is faster,
positive is slower, compared to baseline upon which the series is based:

| Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
| munmap        |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    3.8% |    0.0% |    6.4% |
| after-change  |   -1.9% |    0.2% |   -4.7% |    0.8% |

| Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
| munmap        |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    0.9% |    0.0% |    0.1% |
| after-change  |   -0.2% |    0.6% |   -3.2% |    0.2% |

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/asm-generic/tlb.h | 11 +++++++
 include/linux/pgtable.h   | 43 ++++++++++++++++++++++++++
 mm/memory.c               | 64 ++++++++++++++++++++++++++++-----------
 mm/mmu_gather.c           | 15 +++++++++
 4 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..1b25929d2000 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -75,6 +75,10 @@
  *    boolean indicating if the queue is (now) full and a call to
  *    tlb_flush_mmu() is required.
  *
+ *    tlb_reserve_space() attempts to preallocate space for nr pages and returns
+ *    the minimum garanteed number of pages that can be queued without overflow,
+ *    which may be more or less than requested.
+ *
  *    tlb_remove_page() and tlb_remove_page_size() imply the call to
  *    tlb_flush_mmu() when required and has no return value.
  *
@@ -263,6 +267,7 @@ struct mmu_gather_batch {
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 				   struct encoded_page *page,
 				   int page_size);
+extern unsigned int tlb_reserve_space(struct mmu_gather *tlb, unsigned int nr);
 
 #ifdef CONFIG_SMP
 /*
@@ -273,6 +278,12 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 #endif
 
+#else
+static inline unsigned int tlb_reserve_space(struct mmu_gather *tlb,
+					     unsigned int nr)
+{
+	return 1;
+}
 #endif
 
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index db93fb81465a..170925379534 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -601,6 +601,49 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_ptes
+struct mm_struct;
+/**
+ * clear_ptes - Clear a consecutive range of ptes and return the previous value.
+ * @mm: Address space that the ptes map.
+ * @address: Address corresponding to the first pte to clear.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of ptes to clear.
+ * @full: True if systematically clearing all ptes for the address space.
+ *
+ * A batched version of ptep_get_and_clear_full(), which returns the old pte
+ * value for the first pte in the range, but with young and/or dirty set if any
+ * of the ptes in the range were young or dirty.
+ *
+ * May be overridden by the architecture, else implemented as a loop over
+ * ptep_get_and_clear_full().
+ *
+ * Context: The caller holds the page table lock. The PTEs are all in the same
+ * PMD.
+ */
+static inline pte_t clear_ptes(struct mm_struct *mm,
+				unsigned long address, pte_t *ptep,
+				unsigned int nr, int full)
+{
+	unsigned int i;
+	pte_t pte;
+	pte_t orig_pte = ptep_get_and_clear_full(mm, address, ptep, full);
+
+	for (i = 1; i < nr; i++) {
+		address += PAGE_SIZE;
+		ptep++;
+		pte = ptep_get_and_clear_full(mm, address, ptep, full);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+#endif
 
 /*
  * If two threads concurrently fault at the same page, the thread that
diff --git a/mm/memory.c b/mm/memory.c
index 111f8feeb56e..81b023cf3182 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1447,6 +1447,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	int nr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
@@ -1459,6 +1460,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	do {
 		pte_t ptent = ptep_get(pte);
 		struct page *page;
+		int i;
+
+		nr = 1;
 
 		if (pte_none(ptent))
 			continue;
@@ -1467,43 +1471,67 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
+			unsigned int delay_rmap = 0;
+			struct folio *folio;
+			bool full = false;
+
+			/*
+			 * tlb_gather always has at least one slot so avoid call
+			 * to tlb_reserve_space() when pte_batch_remaining() is
+			 * a compile-time constant 1 (default).
+			 */
+			nr = pte_batch_remaining(ptent, addr, end);
+			if (unlikely(nr > 1))
+				nr = min_t(int, nr, tlb_reserve_space(tlb, nr));
 
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
+			ptent = clear_ptes(mm, addr, pte, nr, tlb->fullmm);
 			arch_check_zapped_pte(vma, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
-						      ptent);
+
+			for (i = 0; i < nr; i++) {
+				unsigned long subaddr = addr + PAGE_SIZE * i;
+
+				tlb_remove_tlb_entry(tlb, &pte[i], subaddr);
+				zap_install_uffd_wp_if_needed(vma, subaddr,
+						&pte[i], details, ptent);
+			}
 			if (unlikely(!page)) {
 				ksm_might_unmap_zero_page(mm, ptent);
 				continue;
 			}
 
-			delay_rmap = 0;
-			if (!PageAnon(page)) {
+			folio = page_folio(page);
+			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
-					set_page_dirty(page);
+					folio_mark_dirty(folio);
 					if (tlb_delay_rmap(tlb)) {
 						delay_rmap = 1;
 						force_flush = 1;
 					}
 				}
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					mark_page_accessed(page);
+					folio_mark_accessed(folio);
 			}
-			rss[mm_counter(page)]--;
-			if (!delay_rmap) {
-				page_remove_rmap(page, vma, false);
-				if (unlikely(page_mapcount(page) < 0))
-					print_bad_pte(vma, addr, ptent, page);
+			rss[mm_counter(page)] -= nr;
+			for (i = 0; i < nr; i++, page++) {
+				if (!delay_rmap) {
+					page_remove_rmap(page, vma, false);
+					if (unlikely(page_mapcount(page) < 0))
+						print_bad_pte(vma, addr, ptent, page);
+				}
+
+				/*
+				 * nr calculated based on available space, so
+				 * can only be full on final iteration.
+				 */
+				VM_WARN_ON(full);
+				full = __tlb_remove_page(tlb, page, delay_rmap);
 			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+			if (unlikely(full)) {
 				force_flush = 1;
-				addr += PAGE_SIZE;
+				addr += PAGE_SIZE * nr;
 				break;
 			}
 			continue;
@@ -1557,7 +1585,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd21..39725756e6bf 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -47,6 +47,21 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	return true;
 }
 
+unsigned int tlb_reserve_space(struct mmu_gather *tlb, unsigned int nr)
+{
+	struct mmu_gather_batch *batch = tlb->active;
+	unsigned int nr_alloc = batch->max - batch->nr;
+
+	while (nr_alloc < nr) {
+		if (!tlb_next_batch(tlb))
+			break;
+		nr_alloc += tlb->active->max;
+	}
+
+	tlb->active = batch;
+	return nr_alloc;
+}
+
 #ifdef CONFIG_SMP
 static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
 {
-- 
2.25.1


