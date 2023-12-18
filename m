Return-Path: <linux-kernel+bounces-3371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DF816B96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D0C1C229D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77E1A599;
	Mon, 18 Dec 2023 10:51:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5A1A293
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31EB713D5;
	Mon, 18 Dec 2023 02:52:10 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0243F738;
	Mon, 18 Dec 2023 02:51:22 -0800 (PST)
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
Subject: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Date: Mon, 18 Dec 2023 10:50:46 +0000
Message-Id: <20231218105100.172635-3-ryan.roberts@arm.com>
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

Convert copy_pte_range() to copy a batch of ptes in one go. A given
batch is determined by the architecture with the new helper,
pte_batch_remaining(), and maps a physically contiguous block of memory,
all belonging to the same folio. A pte batch is then write-protected in
one go in the parent using the new helper, ptep_set_wrprotects() and is
set in one go in the child using the new helper, set_ptes_full().

The primary motivation for this change is to reduce the number of tlb
maintenance operations that the arm64 backend has to perform during
fork, as it is about to add transparent support for the "contiguous bit"
in its ptes. By write-protecting the parent using the new
ptep_set_wrprotects() (note the 's' at the end) function, the backend
can avoid having to unfold contig ranges of PTEs, which is expensive,
when all ptes in the range are being write-protected. Similarly, by
using set_ptes_full() rather than set_pte_at() to set up ptes in the
child, the backend does not need to fold a contiguous range once they
are all populated - they can be initially populated as a contiguous
range in the first place.

This code is very performance sensitive, and a significant amount of
effort has been put into not regressing performance for the order-0
folio case. By default, pte_batch_remaining() is compile constant 1,
which enables the compiler to simplify the extra loops that are added
for batching and produce code that is equivalent (and equally
performant) as the previous implementation.

This change addresses the core-mm refactoring only and a separate change
will implement pte_batch_remaining(), ptep_set_wrprotects() and
set_ptes_full() in the arm64 backend to realize the performance
improvement as part of the work to enable contpte mappings.

To ensure the arm64 is performant once implemented, this change is very
careful to only call ptep_get() once per pte batch.

The following microbenchmark results demonstate that there is no
significant performance change after this patch. Fork is called in a
tight loop in a process with 1G of populated memory and the time for the
function to execute is measured. 100 iterations per run, 8 runs
performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
performed for case where 1G memory is comprised of order-0 folios and
case where comprised of pte-mapped order-9 folios. Negative is faster,
positive is slower, compared to baseline upon which the series is based:

| Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
| fork          |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.1% |    0.0% |    1.2% |
| after-change  |   -1.0% |    2.0% |   -0.1% |    1.1% |

| Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
| fork          |-------------------|-------------------|
| microbench    |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.0% |    0.0% |    0.1% |
| after-change  |   -0.1% |    1.2% |   -0.1% |    0.1% |

Tested-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 80 +++++++++++++++++++++++++++++++++++
 mm/memory.c             | 92 ++++++++++++++++++++++++++---------------
 2 files changed, 139 insertions(+), 33 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..db93fb81465a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -205,6 +205,27 @@ static inline int pmd_young(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
+#ifndef pte_batch_remaining
+/**
+ * pte_batch_remaining - Number of pages from addr to next batch boundary.
+ * @pte: Page table entry for the first page.
+ * @addr: Address of the first page.
+ * @end: Batch ceiling (e.g. end of vma).
+ *
+ * Some architectures (arm64) can efficiently modify a contiguous batch of ptes.
+ * In such cases, this function returns the remaining number of pages to the end
+ * of the current batch, as defined by addr. This can be useful when iterating
+ * over ptes.
+ *
+ * May be overridden by the architecture, else batch size is always 1.
+ */
+static inline unsigned int pte_batch_remaining(pte_t pte, unsigned long addr,
+						unsigned long end)
+{
+	return 1;
+}
+#endif
+
 #ifndef set_ptes
 
 #ifndef pte_next_pfn
@@ -246,6 +267,34 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #endif
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
+#ifndef set_ptes_full
+/**
+ * set_ptes_full - Map consecutive pages to a contiguous range of addresses.
+ * @mm: Address space to map the pages into.
+ * @addr: Address to map the first page at.
+ * @ptep: Page table pointer for the first entry.
+ * @pte: Page table entry for the first page.
+ * @nr: Number of pages to map.
+ * @full: True if systematically setting all ptes and their previous values
+ *        were known to be none (e.g. part of fork).
+ *
+ * Some architectures (arm64) can optimize the implementation if copying ptes
+ * batach-by-batch from the parent, where a batch is defined by
+ * pte_batch_remaining().
+ *
+ * May be overridden by the architecture, else full is ignored and call is
+ * forwarded to set_ptes().
+ *
+ * Context: The caller holds the page table lock.  The pages all belong to the
+ * same folio.  The PTEs are all in the same PMD.
+ */
+static inline void set_ptes_full(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr, int full)
+{
+	set_ptes(mm, addr, ptep, pte, nr);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
@@ -622,6 +671,37 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
+#ifndef ptep_set_wrprotects
+struct mm_struct;
+/**
+ * ptep_set_wrprotects - Write protect a consecutive set of pages.
+ * @mm: Address space that the pages are mapped into.
+ * @address: Address of first page to write protect.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of pages to write protect.
+ * @full: True if systematically wite protecting all ptes (e.g. part of fork).
+ *
+ * Some architectures (arm64) can optimize the implementation if
+ * write-protecting ptes batach-by-batch, where a batch is defined by
+ * pte_batch_remaining().
+ *
+ * May be overridden by the architecture, else implemented as a loop over
+ * ptep_set_wrprotect().
+ *
+ * Context: The caller holds the page table lock. The PTEs are all in the same
+ * PMD.
+ */
+static inline void ptep_set_wrprotects(struct mm_struct *mm,
+				unsigned long address, pte_t *ptep,
+				unsigned int nr, int full)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
+		ptep_set_wrprotect(mm, address, ptep);
+}
+#endif
+
 /*
  * On some architectures hardware does not set page access bit when accessing
  * memory page, it is responsibility of software setting this bit. It brings
diff --git a/mm/memory.c b/mm/memory.c
index 809746555827..111f8feeb56e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -929,42 +929,60 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 }
 
 /*
- * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
- * is required to copy this pte.
+ * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
+ * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
+ * first pte.
  */
 static inline int
-copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
-		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		 struct folio **prealloc)
+copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		  pte_t *dst_pte, pte_t *src_pte, pte_t pte,
+		  unsigned long addr, unsigned long end,
+		  int *rss, struct folio **prealloc)
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	unsigned long vm_flags = src_vma->vm_flags;
-	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
+	int nr, i, ret;
+
+	nr = pte_batch_remaining(pte, addr, end);
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (page)
+	if (page) {
 		folio = page_folio(page);
+		folio_ref_add(folio, nr);
+	}
 	if (page && folio_test_anon(folio)) {
-		/*
-		 * If this page may have been pinned by the parent process,
-		 * copy the page immediately for the child so that we'll always
-		 * guarantee the pinned page won't be randomly replaced in the
-		 * future.
-		 */
-		folio_get(folio);
-		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
-			/* Page may be pinned, we have to copy. */
-			folio_put(folio);
-			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-						 addr, rss, prealloc, page);
+		for (i = 0; i < nr; i++, page++) {
+			/*
+			 * If this page may have been pinned by the parent
+			 * process, copy the page immediately for the child so
+			 * that we'll always guarantee the pinned page won't be
+			 * randomly replaced in the future.
+			 */
+			if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
+				if (i != 0)
+					break;
+				/* Page may be pinned, we have to copy. */
+				folio_ref_sub(folio, nr);
+				ret = copy_present_page(dst_vma, src_vma,
+							dst_pte, src_pte, addr,
+							rss, prealloc, page);
+				return ret == 0 ? 1 : ret;
+			}
+			VM_BUG_ON(PageAnonExclusive(page));
 		}
-		rss[MM_ANONPAGES]++;
+
+		if (unlikely(i < nr)) {
+			folio_ref_sub(folio, nr - i);
+			nr = i;
+		}
+
+		rss[MM_ANONPAGES] += nr;
 	} else if (page) {
-		folio_get(folio);
-		page_dup_file_rmap(page, false);
-		rss[mm_counter_file(page)]++;
+		for (i = 0; i < nr; i++)
+			page_dup_file_rmap(page + i, false);
+		rss[mm_counter_file(page)] += nr;
 	}
 
 	/*
@@ -972,10 +990,9 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
+		ptep_set_wrprotects(src_mm, addr, src_pte, nr, true);
 		pte = pte_wrprotect(pte);
 	}
-	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
 
 	/*
 	 * If it's a shared mapping, mark it clean in
@@ -988,8 +1005,8 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
-	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
-	return 0;
+	set_ptes_full(dst_vma->vm_mm, addr, dst_pte, pte, nr, true);
+	return nr;
 }
 
 static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
@@ -1030,6 +1047,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
 	struct folio *prealloc = NULL;
+	int nr_ptes;
 
 again:
 	progress = 0;
@@ -1060,6 +1078,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	arch_enter_lazy_mmu_mode();
 
 	do {
+		nr_ptes = 1;
+
 		/*
 		 * We are holding two locks at this point - either of them
 		 * could generate latencies in another task on another CPU.
@@ -1095,16 +1115,21 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			 * the now present pte.
 			 */
 			WARN_ON_ONCE(ret != -ENOENT);
+			ret = 0;
 		}
-		/* copy_present_pte() will clear `*prealloc' if consumed */
-		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+		/* copy_present_ptes() will clear `*prealloc' if consumed */
+		nr_ptes = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
+					    ptent, addr, end, rss, &prealloc);
+
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
 		 */
-		if (unlikely(ret == -EAGAIN))
+		if (unlikely(nr_ptes == -EAGAIN)) {
+			ret = -EAGAIN;
 			break;
+		}
+
 		if (unlikely(prealloc)) {
 			/*
 			 * pre-alloc page cannot be reused by next time so as
@@ -1115,8 +1140,9 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			folio_put(prealloc);
 			prealloc = NULL;
 		}
-		progress += 8;
-	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+		progress += 8 * nr_ptes;
+	} while (dst_pte += nr_ptes, src_pte += nr_ptes,
+		 addr += PAGE_SIZE * nr_ptes, addr != end);
 
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_src_pte, src_ptl);
-- 
2.25.1


