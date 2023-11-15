Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB07EC899
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjKOQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjKOQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:30:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FB298
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:30:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C680D15DB;
        Wed, 15 Nov 2023 08:31:26 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A573F641;
        Wed, 15 Nov 2023 08:30:32 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
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
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Date:   Wed, 15 Nov 2023 16:30:05 +0000
Message-Id: <20231115163018.1303287-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115163018.1303287-1-ryan.roberts@arm.com>
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
maps a physically contiguous block of memory, all belonging to the same
folio, with the same permissions, and for shared mappings, the same
dirty state. This will likely improve performance by a tiny amount due
to batching the folio reference count management and calling set_ptes()
rather than making individual calls to set_pte_at().

However, the primary motivation for this change is to reduce the number
of tlb maintenance operations that the arm64 backend has to perform
during fork, as it is about to add transparent support for the
"contiguous bit" in its ptes. By write-protecting the parent using the
new ptep_set_wrprotects() (note the 's' at the end) function, the
backend can avoid having to unfold contig ranges of PTEs, which is
expensive, when all ptes in the range are being write-protected.
Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
in the child, the backend does not need to fold a contiguous range once
they are all populated - they can be initially populated as a contiguous
range in the first place.

This change addresses the core-mm refactoring only, and introduces
ptep_set_wrprotects() with a default implementation that calls
ptep_set_wrprotect() for each pte in the range. A separate change will
implement ptep_set_wrprotects() in the arm64 backend to realize the
performance improvement as part of the work to enable contpte mappings.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h |  13 +++
 mm/memory.c             | 175 +++++++++++++++++++++++++++++++---------
 2 files changed, 150 insertions(+), 38 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..1c50f8a0fdde 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
+#ifndef ptep_set_wrprotects
+struct mm_struct;
+static inline void ptep_set_wrprotects(struct mm_struct *mm,
+				unsigned long address, pte_t *ptep,
+				unsigned int nr)
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
index 1f18ed4a5497..b7c8228883cf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -921,46 +921,129 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		/* Uffd-wp needs to be delivered to dest pte as well */
 		pte = pte_mkuffd_wp(pte);
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
-	return 0;
+	return 1;
+}
+
+static inline unsigned long page_cont_mapped_vaddr(struct page *page,
+				struct page *anchor, unsigned long anchor_vaddr)
+{
+	unsigned long offset;
+	unsigned long vaddr;
+
+	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
+	vaddr = anchor_vaddr + offset;
+
+	if (anchor > page) {
+		if (vaddr > anchor_vaddr)
+			return 0;
+	} else {
+		if (vaddr < anchor_vaddr)
+			return ULONG_MAX;
+	}
+
+	return vaddr;
+}
+
+static int folio_nr_pages_cont_mapped(struct folio *folio,
+				      struct page *page, pte_t *pte,
+				      unsigned long addr, unsigned long end,
+				      pte_t ptent, bool *any_dirty)
+{
+	int floops;
+	int i;
+	unsigned long pfn;
+	pgprot_t prot;
+	struct page *folio_end;
+
+	if (!folio_test_large(folio))
+		return 1;
+
+	folio_end = &folio->page + folio_nr_pages(folio);
+	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
+	floops = (end - addr) >> PAGE_SHIFT;
+	pfn = page_to_pfn(page);
+	prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
+
+	*any_dirty = pte_dirty(ptent);
+
+	pfn++;
+	pte++;
+
+	for (i = 1; i < floops; i++) {
+		ptent = ptep_get(pte);
+		ptent = pte_mkold(pte_mkclean(ptent));
+
+		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
+		    pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
+			break;
+
+		if (pte_dirty(ptent))
+			*any_dirty = true;
+
+		pfn++;
+		pte++;
+	}
+
+	return i;
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
+		  pte_t *dst_pte, pte_t *src_pte,
+		  unsigned long addr, unsigned long end,
+		  int *rss, struct folio **prealloc)
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	unsigned long vm_flags = src_vma->vm_flags;
 	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
+	int nr = 1;
+	bool anon;
+	bool any_dirty = pte_dirty(pte);
+	int i;
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (page)
+	if (page) {
 		folio = page_folio(page);
-	if (page && folio_test_anon(folio)) {
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
+		anon = folio_test_anon(folio);
+		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
+						end, pte, &any_dirty);
+
+		for (i = 0; i < nr; i++, page++) {
+			if (anon) {
+				/*
+				 * If this page may have been pinned by the
+				 * parent process, copy the page immediately for
+				 * the child so that we'll always guarantee the
+				 * pinned page won't be randomly replaced in the
+				 * future.
+				 */
+				if (unlikely(page_try_dup_anon_rmap(
+						page, false, src_vma))) {
+					if (i != 0)
+						break;
+					/* Page may be pinned, we have to copy. */
+					return copy_present_page(
+						dst_vma, src_vma, dst_pte,
+						src_pte, addr, rss, prealloc,
+						page);
+				}
+				rss[MM_ANONPAGES]++;
+				VM_BUG_ON(PageAnonExclusive(page));
+			} else {
+				page_dup_file_rmap(page, false);
+				rss[mm_counter_file(page)]++;
+			}
 		}
-		rss[MM_ANONPAGES]++;
-	} else if (page) {
-		folio_get(folio);
-		page_dup_file_rmap(page, false);
-		rss[mm_counter_file(page)]++;
+
+		nr = i;
+		folio_ref_add(folio, nr);
 	}
 
 	/*
@@ -968,24 +1051,28 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
+		ptep_set_wrprotects(src_mm, addr, src_pte, nr);
 		pte = pte_wrprotect(pte);
 	}
-	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * If it's a shared mapping, mark it clean in the child. If its a
+	 * private mapping, mark it dirty in the child if _any_ of the parent
+	 * mappings in the block were marked dirty. The contiguous block of
+	 * mappings are all backed by the same folio, so if any are dirty then
+	 * the whole folio is dirty. This allows us to determine the batch size
+	 * without having to ever consider the dirty bit. See
+	 * folio_nr_pages_cont_mapped().
 	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
-	pte = pte_mkold(pte);
+	pte = pte_mkold(pte_mkclean(pte));
+	if (!(vm_flags & VM_SHARED) && any_dirty)
+		pte = pte_mkdirty(pte);
 
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_clear_uffd_wp(pte);
 
-	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
-	return 0;
+	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
+	return nr;
 }
 
 static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
@@ -1087,15 +1174,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			 */
 			WARN_ON_ONCE(ret != -ENOENT);
 		}
-		/* copy_present_pte() will clear `*prealloc' if consumed */
-		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+		/* copy_present_ptes() will clear `*prealloc' if consumed */
+		ret = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
+				       addr, end, rss, &prealloc);
+
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
 		 */
 		if (unlikely(ret == -EAGAIN))
 			break;
+
+		/*
+		 * Positive return value is the number of ptes copied.
+		 */
+		VM_WARN_ON_ONCE(ret < 1);
+		progress += 8 * ret;
+		ret--;
+		dst_pte += ret;
+		src_pte += ret;
+		addr += ret << PAGE_SHIFT;
+		ret = 0;
+
 		if (unlikely(prealloc)) {
 			/*
 			 * pre-alloc page cannot be reused by next time so as
@@ -1106,7 +1206,6 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			folio_put(prealloc);
 			prealloc = NULL;
 		}
-		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
 	arch_leave_lazy_mmu_mode();
-- 
2.25.1

