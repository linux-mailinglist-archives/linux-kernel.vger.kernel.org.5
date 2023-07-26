Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9A7632DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjGZJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjGZJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:52:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B22912D5F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:52:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D817F169E;
        Wed, 26 Jul 2023 02:52:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EFDF3F67D;
        Wed, 26 Jul 2023 02:52:02 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Date:   Wed, 26 Jul 2023 10:51:43 +0100
Message-Id: <20230726095146.2826796-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230726095146.2826796-1-ryan.roberts@arm.com>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
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

Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
allocated in large folios of a determined order. All pages of the large
folio are pte-mapped during the same page fault, significantly reducing
the number of page faults. The number of per-page operations (e.g. ref
counting, rmap management lru list management) are also significantly
reduced since those ops now become per-folio.

The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
which defaults to disabled for now; The long term aim is for this to
defaut to enabled, but there are some risks around internal
fragmentation that need to be better understood first.

When enabled, the folio order is determined as such: For a vma, process
or system that has explicitly disabled THP, we continue to allocate
order-0. THP is most likely disabled to avoid any possible internal
fragmentation so we honour that request.

Otherwise, the return value of arch_wants_pte_order() is used. For vmas
that have not explicitly opted-in to use transparent hugepages (e.g.
where thp=madvise and the vma does not have MADV_HUGEPAGE), then
arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
bigger). This allows for a performance boost without requiring any
explicit opt-in from the workload while limitting internal
fragmentation.

If the preferred order can't be used (e.g. because the folio would
breach the bounds of the vma, or because ptes in the region are already
mapped) then we fall back to a suitable lower order; first
PAGE_ALLOC_COSTLY_ORDER, then order-0.

arch_wants_pte_order() can be overridden by the architecture if desired.
Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
set of ptes map physically contigious, naturally aligned memory, so this
mechanism allows the architecture to optimize as required.

Here we add the default implementation of arch_wants_pte_order(), used
when the architecture does not define it, which returns -1, implying
that the HW has no preference. In this case, mm will choose it's own
default order.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h |  13 ++++
 mm/Kconfig              |  10 +++
 mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 172 insertions(+), 17 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..2a1d83775837 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
+#ifndef arch_wants_pte_order
+/*
+ * Returns preferred folio order for pte-mapped memory. Must be in range [0,
+ * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
+ * to be at least order-2. Negative value implies that the HW has no preference
+ * and mm will choose it's own default order.
+ */
+static inline int arch_wants_pte_order(void)
+{
+	return -1;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..fa61ea160447 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
 
 source "mm/damon/Kconfig"
 
+config LARGE_ANON_FOLIO
+	bool "Allocate large folios for anonymous memory"
+	depends on TRANSPARENT_HUGEPAGE
+	default n
+	help
+	  Use large (bigger than order-0) folios to back anonymous memory where
+	  possible, even for pte-mapped memory. This reduces the number of page
+	  faults, as well as other per-page overheads to improve performance for
+	  many workloads.
+
 endmenu
diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..64c3f242c49a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	return ret;
 }
 
+static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
+{
+	int i;
+
+	if (nr_pages == 1)
+		return vmf_pte_changed(vmf);
+
+	for (i = 0; i < nr_pages; i++) {
+		if (!pte_none(ptep_get_lockless(vmf->pte + i)))
+			return true;
+	}
+
+	return false;
+}
+
+#ifdef CONFIG_LARGE_ANON_FOLIO
+#define ANON_FOLIO_MAX_ORDER_UNHINTED \
+		(ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
+
+static int anon_folio_order(struct vm_area_struct *vma)
+{
+	int order;
+
+	/*
+	 * If THP is explicitly disabled for either the vma, the process or the
+	 * system, then this is very likely intended to limit internal
+	 * fragmentation; in this case, don't attempt to allocate a large
+	 * anonymous folio.
+	 *
+	 * Else, if the vma is eligible for thp, allocate a large folio of the
+	 * size preferred by the arch. Or if the arch requested a very small
+	 * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
+	 * which still meets the arch's requirements but means we still take
+	 * advantage of SW optimizations (e.g. fewer page faults).
+	 *
+	 * Finally if thp is enabled but the vma isn't eligible, take the
+	 * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
+	 * This ensures workloads that have not explicitly opted-in take benefit
+	 * while capping the potential for internal fragmentation.
+	 */
+
+	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
+	    !hugepage_flags_enabled())
+		order = 0;
+	else {
+		order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
+
+		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
+			order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
+	}
+
+	return order;
+}
+
+static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
+{
+	int i;
+	gfp_t gfp;
+	pte_t *pte;
+	unsigned long addr;
+	struct vm_area_struct *vma = vmf->vma;
+	int prefer = anon_folio_order(vma);
+	int orders[] = {
+		prefer,
+		prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
+		0,
+	};
+
+	*folio = NULL;
+
+	if (vmf_orig_pte_uffd_wp(vmf))
+		goto fallback;
+
+	for (i = 0; orders[i]; i++) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
+		if (addr >= vma->vm_start &&
+		    addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
+			break;
+	}
+
+	if (!orders[i])
+		goto fallback;
+
+	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
+	if (!pte)
+		return -EAGAIN;
+
+	for (; orders[i]; i++) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
+		vmf->pte = pte + pte_index(addr);
+		if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
+			break;
+	}
+
+	vmf->pte = NULL;
+	pte_unmap(pte);
+
+	gfp = vma_thp_gfp_mask(vma);
+
+	for (; orders[i]; i++) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
+		*folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
+		if (*folio) {
+			clear_huge_page(&(*folio)->page, addr, 1 << orders[i]);
+			return 0;
+		}
+	}
+
+fallback:
+	*folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+	return *folio ? 0 : -ENOMEM;
+}
+#else
+static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
+{
+	*folio = vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
+	return *folio ? 0 : -ENOMEM;
+}
+#endif
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4057,6 +4178,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  */
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
+	int i = 0;
+	int nr_pages = 1;
+	unsigned long addr = vmf->address;
 	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
@@ -4101,10 +4225,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+	ret = alloc_anon_folio(vmf, &folio);
+	if (unlikely(ret == -EAGAIN))
+		return 0;
 	if (!folio)
 		goto oom;
 
+	nr_pages = folio_nr_pages(folio);
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
+
 	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	folio_throttle_swaprate(folio, GFP_KERNEL);
@@ -4116,17 +4245,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 */
 	__folio_mark_uptodate(folio);
 
-	entry = mk_pte(&folio->page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
-
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	if (!vmf->pte)
 		goto release;
-	if (vmf_pte_changed(vmf)) {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
+	if (vmf_pte_range_changed(vmf, nr_pages)) {
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
 		goto release;
 	}
 
@@ -4141,16 +4265,24 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	folio_add_new_anon_rmap(folio, vma, vmf->address);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	folio_add_new_anon_rmap(folio, vma, addr);
 	folio_add_lru_vma(folio, vma);
+
+	for (i = 0; i < nr_pages; i++) {
+		entry = mk_pte(folio_page(folio, i), vma->vm_page_prot);
+		entry = pte_sw_mkyoung(entry);
+		if (vma->vm_flags & VM_WRITE)
+			entry = pte_mkwrite(pte_mkdirty(entry));
 setpte:
-	if (uffd_wp)
-		entry = pte_mkuffd_wp(entry);
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+		if (uffd_wp)
+			entry = pte_mkuffd_wp(entry);
+		set_pte_at(vma->vm_mm, addr + PAGE_SIZE * i, vmf->pte + i, entry);
 
-	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+		/* No need to invalidate - it was non-present before */
+		update_mmu_cache(vma, addr + PAGE_SIZE * i, vmf->pte + i);
+	}
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.25.1

