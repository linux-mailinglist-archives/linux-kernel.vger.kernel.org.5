Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF79777D52D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjHOVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjHOVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:34:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37611BDC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692135259; x=1723671259;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DIqWkRUYDm/85sPknON1ARtMy1sClyr2+/1difuy6uE=;
  b=AFW6XbXnd7O6NThjln+vTK4p2TW4YrELtKqBIKxppSKA686dmlQSKw60
   qHpmWzQo6KjO3hVkEh67nKifl48Id+RtxRGijv/DQV+W648QrmKhITIZU
   sQP93mm0yShEpTeFV818RzQGhsoWFWmBuuCJMmDUZd7rWiKCgFnWunzVP
   0ZCEYKlxzY4WlZ78A7COiQ+9Lz+e1ihH9rG/L19ff0fEgOLBnN/iWuJTa
   bokem25JOCVF10NHz/d11Na3FLFGdGyHtuazSGsnbsW5/AV3SSFzfyVqI
   baIjr+sOn4GLZa8AnZiuByTP4QIa0R58II4XAgQaY1nP5xFsM3dD98Ptg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403360236"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="403360236"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="768962222"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="768962222"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:34:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
        <20230810142942.3169679-4-ryan.roberts@arm.com>
Date:   Wed, 16 Aug 2023 05:32:37 +0800
In-Reply-To: <20230810142942.3169679-4-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Thu, 10 Aug 2023 15:29:40 +0100")
Message-ID: <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ryan,

Ryan Roberts <ryan.roberts@arm.com> writes:

> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
> allocated in large folios of a determined order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
>
> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> which defaults to disabled for now; The long term aim is for this to
> defaut to enabled, but there are some risks around internal
> fragmentation that need to be better understood first.
>
> Large anonymous folio (LAF) allocation is integrated with the existing
> (PMD-order) THP and single (S) page allocation according to this policy,
> where fallback (>) is performed for various reasons, such as the
> proposed folio order not fitting within the bounds of the VMA, etc:
>
>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
> ----------------|-----------|-------------|---------------|-------------
> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S           | S             | S

IMHO, we should use the following semantics as you have suggested
before.

                | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
                | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
----------------|-----------|-------------|---------------|-------------
no hint         | S         | S           | LAF>S         | THP>LAF>S
MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
MADV_NOHUGEPAGE | S         | S           | S             | S

Or even,

                | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
                | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
----------------|-----------|-------------|---------------|-------------
no hint         | S         | S           | S             | THP>LAF>S
MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
MADV_NOHUGEPAGE | S         | S           | S             | S

From the implementation point of view, PTE mapped PMD-sized THP has
almost no difference with LAF (just some small sized THP).  It will be
confusing to distinguish them from the interface point of view.

So, IMHO, the real difference is the policy.  For example, prefer
PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
interface is used to specify system global policy.  In the long term, it
can be something like below,

never:      S               # disable all THP
madvise:                    # never by default, control via madvise()
always:     THP>LAF>S       # prefer PMD-sized THP in fact
small:      LAF>S           # prefer small sized THP
auto:                       # use in-kernel heuristics for THP size

But it may be not ready to add new policies now.  So, before the new
policies are ready, we can add a debugfs interface to override the
original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
we have tuned enough workloads, collected enough data, we can add new
policies to the sysfs interface.

--
Best Regards,
Huang, Ying

> This approach ensures that we don't violate existing hints to only
> allocate single pages - this is required for QEMU's VM live migration
> implementation to work correctly - while allowing us to use LAF
> independently of THP (when sysfs=never). This makes wide scale
> performance characterization simpler, while avoiding exposing any new
> ABI to user space.
>
> When using LAF for allocation, the folio order is determined as follows:
> The return value of arch_wants_pte_order() is used. For vmas that have
> not explicitly opted-in to use transparent hugepages (e.g. where
> sysfs=madvise and the vma does not have MADV_HUGEPAGE or sysfs=never),
> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
> is bigger). This allows for a performance boost without requiring any
> explicit opt-in from the workload while limitting internal
> fragmentation.
>
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order; first
> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>
> arch_wants_pte_order() can be overridden by the architecture if desired.
> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
> set of ptes map physically contigious, naturally aligned memory, so this
> mechanism allows the architecture to optimize as required.
>
> Here we add the default implementation of arch_wants_pte_order(), used
> when the architecture does not define it, which returns -1, implying
> that the HW has no preference. In this case, mm will choose it's own
> default order.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h |  13 ++++
>  mm/Kconfig              |  10 +++
>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 158 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 222a33b9600d..4b488cc66ddc 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>  
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
> + * to be at least order-2. Negative value implies that the HW has no preference
> + * and mm will choose it's own default order.
> + */
> +static inline int arch_wants_pte_order(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 721dc88423c7..a1e28b8ddc24 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>  
>  source "mm/damon/Kconfig"
>  
> +config LARGE_ANON_FOLIO
> +	bool "Allocate large folios for anonymous memory"
> +	depends on TRANSPARENT_HUGEPAGE
> +	default n
> +	help
> +	  Use large (bigger than order-0) folios to back anonymous memory where
> +	  possible, even for pte-mapped memory. This reduces the number of page
> +	  faults, as well as other per-page overheads to improve performance for
> +	  many workloads.
> +
>  endmenu
> diff --git a/mm/memory.c b/mm/memory.c
> index d003076b218d..bbc7d4ce84f7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> +{
> +	int i;
> +
> +	if (nr_pages == 1)
> +		return vmf_pte_changed(vmf);
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_LARGE_ANON_FOLIO
> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> +		(ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
> +
> +static int anon_folio_order(struct vm_area_struct *vma)
> +{
> +	int order;
> +
> +	/*
> +	 * If the vma is eligible for thp, allocate a large folio of the size
> +	 * preferred by the arch. Or if the arch requested a very small size or
> +	 * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which still
> +	 * meets the arch's requirements but means we still take advantage of SW
> +	 * optimizations (e.g. fewer page faults).
> +	 *
> +	 * If the vma isn't eligible for thp, take the arch-preferred size and
> +	 * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures workloads
> +	 * that have not explicitly opted-in take benefit while capping the
> +	 * potential for internal fragmentation.
> +	 */
> +
> +	order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
> +
> +	if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +		order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
> +
> +	return order;
> +}
> +
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +{
> +	int i;
> +	gfp_t gfp;
> +	pte_t *pte;
> +	unsigned long addr;
> +	struct folio *folio;
> +	struct vm_area_struct *vma = vmf->vma;
> +	int prefer = anon_folio_order(vma);
> +	int orders[] = {
> +		prefer,
> +		prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
> +		0,
> +	};
> +
> +	/*
> +	 * If uffd is active for the vma we need per-page fault fidelity to
> +	 * maintain the uffd semantics.
> +	 */
> +	if (userfaultfd_armed(vma))
> +		goto fallback;
> +
> +	/*
> +	 * If hugepages are explicitly disabled for the vma (either
> +	 * MADV_NOHUGEPAGE or prctl) fallback to order-0. Failure to do this
> +	 * breaks correctness for user space. We ignore the sysfs global knob.
> +	 */
> +	if (!hugepage_vma_check(vma, vma->vm_flags, false, true, false))
> +		goto fallback;
> +
> +	for (i = 0; orders[i]; i++) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
> +		if (addr >= vma->vm_start &&
> +		    addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
> +			break;
> +	}
> +
> +	if (!orders[i])
> +		goto fallback;
> +
> +	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +	if (!pte)
> +		return ERR_PTR(-EAGAIN);
> +
> +	for (; orders[i]; i++) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
> +		vmf->pte = pte + pte_index(addr);
> +		if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> +			break;
> +	}
> +
> +	vmf->pte = NULL;
> +	pte_unmap(pte);
> +
> +	gfp = vma_thp_gfp_mask(vma);
> +
> +	for (; orders[i]; i++) {
> +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
> +		folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
> +		if (folio) {
> +			clear_huge_page(&folio->page, addr, 1 << orders[i]);
> +			return folio;
> +		}
> +	}
> +
> +fallback:
> +	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +}
> +#else
> +#define alloc_anon_folio(vmf) \
> +		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
> +#endif
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4080,6 +4197,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   */
>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  {
> +	int i;
> +	int nr_pages = 1;
> +	unsigned long addr = vmf->address;
>  	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio;
> @@ -4124,10 +4244,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	/* Allocate our own private page. */
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto oom;
> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	folio = alloc_anon_folio(vmf);
> +	if (IS_ERR(folio))
> +		return 0;
>  	if (!folio)
>  		goto oom;
>  
> +	nr_pages = folio_nr_pages(folio);
> +	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +
>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>  		goto oom_free_page;
>  	folio_throttle_swaprate(folio, GFP_KERNEL);
> @@ -4144,12 +4269,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
>  
> -	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> -			&vmf->ptl);
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>  	if (!vmf->pte)
>  		goto release;
> -	if (vmf_pte_changed(vmf)) {
> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> +	if (vmf_pte_range_changed(vmf, nr_pages)) {
> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>  		goto release;
>  	}
>  
> @@ -4164,16 +4289,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>  	}
>  
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	folio_add_new_anon_rmap(folio, vma, addr);
>  	folio_add_lru_vma(folio, vma);
>  setpte:
>  	if (uffd_wp)
>  		entry = pte_mkuffd_wp(entry);
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
