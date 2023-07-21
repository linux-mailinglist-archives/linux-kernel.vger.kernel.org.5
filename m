Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A075C525
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGUK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGUK6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:58:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EEBE1FE1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:57:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A1912F4;
        Fri, 21 Jul 2023 03:58:09 -0700 (PDT)
Received: from [10.57.64.194] (unknown [10.57.64.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD993F738;
        Fri, 21 Jul 2023 03:57:23 -0700 (PDT)
Message-ID: <cbdf2289-bd5c-a882-3181-591bd765e9ec@arm.com>
Date:   Fri, 21 Jul 2023 11:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230714161733.4144503-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 17:17, Ryan Roberts wrote:
> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> allocated in large folios of a determined order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
> 
> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> defaults to disabled for now; The long term aim is for this to defaut to
> enabled, but there are some risks around internal fragmentation that
> need to be better understood first.
> 
> When enabled, the folio order is determined as such: For a vma, process
> or system that has explicitly disabled THP, we continue to allocate
> order-0. THP is most likely disabled to avoid any possible internal
> fragmentation so we honour that request.
> 
> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> that have not explicitly opted-in to use transparent hugepages (e.g.
> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
> arch_wants_pte_order() is limited by the new cmdline parameter,
> `flexthp_unhinted_max`. This allows for a performance boost without
> requiring any explicit opt-in from the workload while allowing the
> sysadmin to tune between performance and internal fragmentation.
> 
> arch_wants_pte_order() can be overridden by the architecture if desired.
> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
> set of ptes map physically contigious, naturally aligned memory, so this
> mechanism allows the architecture to optimize as required.
> 
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order; first
> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

...

> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4057,11 +4199,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   */
>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  {
> +	int i = 0;
> +	int nr_pages = 1;
>  	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio;
>  	vm_fault_t ret = 0;
>  	pte_t entry;
> +	unsigned long addr;
>  
>  	/* File mapping without ->vm_ops ? */
>  	if (vma->vm_flags & VM_SHARED)
> @@ -4101,10 +4246,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	/* Allocate our own private page. */
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto oom;
> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	ret = alloc_anon_folio(vmf, &folio);
> +	if (unlikely(ret == -EAGAIN))
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
> @@ -4116,17 +4266,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	 */
>  	__folio_mark_uptodate(folio);
>  
> -	entry = mk_pte(&folio->page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
> -	if (vma->vm_flags & VM_WRITE)
> -		entry = pte_mkwrite(pte_mkdirty(entry));
> -
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
> @@ -4141,16 +4286,24 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>  	}
>  
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	folio_add_new_anon_rmap(folio, vma, addr);
>  	folio_add_lru_vma(folio, vma);
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		entry = mk_pte(folio_page(folio, i), vma->vm_page_prot);
> +		entry = pte_sw_mkyoung(entry);
> +		if (vma->vm_flags & VM_WRITE)
> +			entry = pte_mkwrite(pte_mkdirty(entry));
>  setpte:
> -	if (uffd_wp)
> -		entry = pte_mkuffd_wp(entry);
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +		if (uffd_wp)
> +			entry = pte_mkuffd_wp(entry);
> +		set_pte_at(vma->vm_mm, addr + PAGE_SIZE * i, vmf->pte + i, entry);

I've just spotted a bug here for the case where we arrive via goto setpte; in
this case, addr is not initialized. This crept in during the refactoring and I
have no idea how this could possibly have not fallen over in a heap when
executed. Sorry about that. I'm fixing in v4.

>  
> -	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(vma, vmf->address, vmf->pte);
> +		/* No need to invalidate - it was non-present before */
> +		update_mmu_cache(vma, addr + PAGE_SIZE * i, vmf->pte + i);
> +	}
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);

