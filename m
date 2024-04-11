Return-Path: <linux-kernel+bounces-140841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC48A192A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF231F22DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677A13248B;
	Thu, 11 Apr 2024 15:34:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B4131E3A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849641; cv=none; b=qsZo9ad0EqoqcA4k3M1ML/GzpZgFOLZiZHDR7sfuiWnYnl4rIxzxASsbW4lCToVzRwa2WcisMUiuy9lje4NDM1dM9BuV8SISe1uHUR4BAwV1A3qmb/PUWSTd2VQTtcOuM2DnvMVoxAbcTuO5R9/V/9zYVGV+rPXOrYMOAMrJcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849641; c=relaxed/simple;
	bh=1+6YDXwbCpxGbp/uhTyuUqLzfyfMgk+8nnvTf69RPCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXy/wZ8v+i8ciLbkpbY7C3ARY5Ur6BsOPwYWGjBoKhEqG6jXdSL3TpCu5sevWoRd52zRBqgTFfGAS30IRYcZB/9jfrbAaETBfw98Yw8ZV2vHYfCcUaZzmkYe55ODsfrf5r+QYylJB13zkeTX6Nxv5tuM0dvECxB3ulgBcdcWGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33778113E;
	Thu, 11 Apr 2024 08:34:28 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F8313F6C4;
	Thu, 11 Apr 2024 08:33:56 -0700 (PDT)
Message-ID: <1008d688-757a-4c2d-86bd-793f5e787d30@arm.com>
Date: Thu, 11 Apr 2024 16:33:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in
 swapcache
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-5-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240409082631.187483-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:26, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> When a large folio is found in the swapcache, the current implementation
> requires calling do_swap_page() nr_pages times, resulting in nr_pages
> page faults. This patch opts to map the entire large folio at once to
> minimize page faults. Additionally, redundant checks and early exits
> for ARM64 MTE restoring are removed.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 64 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c4a52e8d740a..9818dc1893c8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3947,6 +3947,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte_t pte;
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
> +	int nr_pages = 1;
> +	unsigned long start_address = vmf->address;
> +	pte_t *start_pte = vmf->pte;

possible bug?: there are code paths that assign to vmf-pte below in this
function, so couldn't start_pte be stale in some cases? I'd just do the
assignment (all 4 of these variables in fact) in an else clause below, after any
messing about with them is complete.

nit: rename start_pte -> start_ptep ?

> +	bool any_swap_shared = false;

Suggest you defer initialization of this to your "We hit large folios in
swapcache" block below, and init it to:

	any_swap_shared = !pte_swp_exclusive(vmf->pte);

Then the any_shared semantic in swap_pte_batch() can be the same as for
folio_pte_batch().

>  
>  	if (!pte_unmap_same(vmf))
>  		goto out;
> @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 */
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);

bug: vmf->pte may be NULL and you are not checking it until check_pte:. Byt you
are using it in this block. It also seems odd to do all the work in the below
block under the PTL but before checking if the pte has changed. Suggest moving
both checks here.

> +
> +	/* We hit large folios in swapcache */
> +	if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)) {

What's the start_pte check protecting?

> +		int nr = folio_nr_pages(folio);
> +		int idx = folio_page_idx(folio, page);
> +		unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
> +		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
> +		pte_t *folio_ptep;
> +		pte_t folio_pte;
> +
> +		if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
> +			goto check_pte;
> +		if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
> +			goto check_pte;
> +
> +		folio_ptep = vmf->pte - idx;
> +		folio_pte = ptep_get(folio_ptep);
> +		if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio_pte)) ||
> +		    swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) != nr)
> +			goto check_pte;
> +
> +		start_address = folio_start;
> +		start_pte = folio_ptep;
> +		nr_pages = nr;
> +		entry = folio->swap;
> +		page = &folio->page;
> +	}
> +
> +check_pte:
>  	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
>  		goto out_nomap;
>  
> @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			 */
>  			exclusive = false;
>  		}
> +
> +		/* Reuse the whole large folio iff all entries are exclusive */
> +		if (nr_pages > 1 && any_swap_shared)
> +			exclusive = false;

If you init any_shared with the firt pte as I suggested then you could just set
exclusive = !any_shared at the top of this if block without needing this
separate fixup.
>  	}
>  
>  	/*
> @@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 * We're already holding a reference on the page but haven't mapped it
>  	 * yet.
>  	 */
> -	swap_free(entry);
> +	swap_free_nr(entry, nr_pages);
>  	if (should_try_to_free_swap(folio, vma, vmf->flags))
>  		folio_free_swap(folio);
>  
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> +
>  	pte = mk_pte(page, vma->vm_page_prot);
>  
>  	/*
> @@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 * exclusivity.
>  	 */
>  	if (!folio_test_ksm(folio) &&
> -	    (exclusive || folio_ref_count(folio) == 1)) {
> +	    (exclusive || (folio_ref_count(folio) == nr_pages &&
> +			   folio_nr_pages(folio) == nr_pages))) {
>  		if (vmf->flags & FAULT_FLAG_WRITE) {
>  			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  			vmf->flags &= ~FAULT_FLAG_WRITE;
>  		}
>  		rmap_flags |= RMAP_EXCLUSIVE;
>  	}
> -	flush_icache_page(vma, page);
> +	flush_icache_pages(vma, page, nr_pages);
>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>  		pte = pte_mksoft_dirty(pte);
>  	if (pte_swp_uffd_wp(vmf->orig_pte))
>  		pte = pte_mkuffd_wp(pte);

I'm not sure about all this... you are smearing these SW bits from the faulting
PTE across all the ptes you are mapping. Although I guess actually that's ok
because swap_pte_batch() only returns a batch with all these bits the same?

> -	vmf->orig_pte = pte;

Instead of doing a readback below, perhaps:

	vmf->orig_pte = pte_advance_pfn(pte, nr_pages);

>  
>  	/* ksm created a completely new copy */
>  	if (unlikely(folio != swapcache && swapcache)) {
> -		folio_add_new_anon_rmap(folio, vma, vmf->address);
> +		folio_add_new_anon_rmap(folio, vma, start_address);
>  		folio_add_lru_vma(folio, vma);
>  	} else {
> -		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> -					rmap_flags);
> +		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
> +					 rmap_flags);
>  	}
>  
>  	VM_BUG_ON(!folio_test_anon(folio) ||
>  			(pte_write(pte) && !PageAnonExclusive(page)));
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
> +	set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> +	vmf->orig_pte = ptep_get(vmf->pte);
> +	arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
>  
>  	folio_unlock(folio);
>  	if (folio != swapcache && swapcache) {
> @@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +	update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);


