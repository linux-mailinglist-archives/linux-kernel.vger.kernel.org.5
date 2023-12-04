Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55B2803002
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjLDKVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbjLDKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:20:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF67D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3365916A3;
        Mon,  4 Dec 2023 02:21:51 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD0B3F6C4;
        Mon,  4 Dec 2023 02:21:01 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/10] mm: thp: Support allocation of anonymous multi-size THP
Date:   Mon,  4 Dec 2023 10:20:21 +0000
Message-Id: <20231204102027.57185-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
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

Introduce the logic to allow THP to be configured (through the new sysfs
interface we just added) to allocate large folios to back anonymous
memory, which are larger than the base page size but smaller than
PMD-size. We call this new THP extension "multi-size THP" (mTHP).

mTHP continues to be PTE-mapped, but in many cases can still provide
similar benefits to traditional PMD-sized THP: Page faults are
significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
the configured order), but latency spikes are much less prominent
because the size of each page isn't as huge as the PMD-sized variant and
there is less memory to clear in each page fault. The number of per-page
operations (e.g. ref counting, rmap management, lru list management) are
also significantly reduced since those ops now become per-folio.

Some architectures also employ TLB compression mechanisms to squeeze
more entries in when a set of PTEs are virtually and physically
contiguous and approporiately aligned. In this case, TLB misses will
occur less often.

The new behaviour is disabled by default, but can be enabled at runtime
by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
(see documentation in previous commit). The long term aim is to change
the default to include suitable lower orders, but there are some risks
around internal fragmentation that need to be better understood first.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/huge_mm.h |   6 ++-
 mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd0eadd3befb..91a53b9835a4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
 /*
- * Mask of all large folio orders supported for anonymous THP.
+ * Mask of all large folio orders supported for anonymous THP; all orders up to
+ * and including PMD_ORDER, except order-0 (which is not "huge") and order-1
+ * (which is a limitation of the THP implementation).
  */
-#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
+#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
 
 /*
  * Mask of all large folio orders supported for file THP.
diff --git a/mm/memory.c b/mm/memory.c
index 3ceeb0f45bf5..bf7e93813018 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	return ret;
 }
 
+static bool pte_range_none(pte_t *pte, int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (!pte_none(ptep_get_lockless(pte + i)))
+			return false;
+	}
+
+	return true;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static struct folio *alloc_anon_folio(struct vm_fault *vmf)
+{
+	gfp_t gfp;
+	pte_t *pte;
+	unsigned long addr;
+	struct folio *folio;
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long orders;
+	int order;
+
+	/*
+	 * If uffd is active for the vma we need per-page fault fidelity to
+	 * maintain the uffd semantics.
+	 */
+	if (userfaultfd_armed(vma))
+		goto fallback;
+
+	/*
+	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
+	 * for this vma. Then filter out the orders that can't be allocated over
+	 * the faulting address and still be fully contained in the vma.
+	 */
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
+					  BIT(PMD_ORDER) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+
+	if (!orders)
+		goto fallback;
+
+	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
+	if (!pte)
+		return ERR_PTR(-EAGAIN);
+
+	order = first_order(orders);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		vmf->pte = pte + pte_index(addr);
+		if (pte_range_none(vmf->pte, 1 << order))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	vmf->pte = NULL;
+	pte_unmap(pte);
+
+	gfp = vma_thp_gfp_mask(vma);
+
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vma, addr, true);
+		if (folio) {
+			clear_huge_page(&folio->page, addr, 1 << order);
+			return folio;
+		}
+		order = next_order(&orders, order);
+	}
+
+fallback:
+	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
+}
+#else
+#define alloc_anon_folio(vmf) \
+		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
+#endif
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4132,6 +4210,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  */
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
+	int i;
+	int nr_pages = 1;
+	unsigned long addr = vmf->address;
 	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
@@ -4176,10 +4257,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
+	folio = alloc_anon_folio(vmf);
+	if (IS_ERR(folio))
+		return 0;
 	if (!folio)
 		goto oom;
 
+	nr_pages = folio_nr_pages(folio);
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
+
 	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	folio_throttle_swaprate(folio, GFP_KERNEL);
@@ -4196,12 +4282,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry), vma);
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	if (!vmf->pte)
 		goto release;
-	if (vmf_pte_changed(vmf)) {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
+	if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
+	    (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
 		goto release;
 	}
 
@@ -4216,16 +4303,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	folio_add_new_anon_rmap(folio, vma, vmf->address);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	folio_add_new_anon_rmap(folio, vma, addr);
 	folio_add_lru_vma(folio, vma);
 setpte:
 	if (uffd_wp)
 		entry = pte_mkuffd_wp(entry);
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.25.1

