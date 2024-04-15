Return-Path: <linux-kernel+bounces-144771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA5C8A4A84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4382A1F21C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAC3839C;
	Mon, 15 Apr 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1Eu25sS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5423770C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170398; cv=none; b=uzXRppSsz9J4C/iWoshbOE0f6w9tBuAZ5H1n6emqAgXW2A8FIX89WOO62sMvvdytJowAE3VKxitgYXMxenXwPSpsJJnoDC5729Wi19+xf8Eh0Hb4L0v7sBhfV+vUGw36DisOKk/9e/yu4k8sALv+4NVNLptBZPf98ENz+biiINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170398; c=relaxed/simple;
	bh=Vj4AFOE+O6c1sBlimkPSxbt9T/kes+LkocA0fd9Khgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D/n+1GXoEoyIhynKstHN3RU5y3Ont/jn8H5rv0KFE/70+zRjdyDNit4An3wYIrFOOYPiwVo8luq5FAlFIBan15UF0Fv0/nKy6qe3AL3JPHxrQUpuQ40zZbw4NyKhiZOowt3aoNpYf5yxS2GaKq8KP+hzcNDSTuLBnebGHNivrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1Eu25sS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713170397; x=1744706397;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Vj4AFOE+O6c1sBlimkPSxbt9T/kes+LkocA0fd9Khgw=;
  b=G1Eu25sS6aTq3bdUez3Uar0dOPeh/yQEzIDs9HfgxbXIOzR/gvvrfqBE
   +Ye2Z3SX0+SH+Rghv6/qAuqdmRz9C+8wkk3GjIBqN4f/U2FJNzBtVy88b
   bMNy8hlaqJpVCsfjskR4cQfANbzbdpBM3hjDhzenD81nu7v+CkBKdSfKI
   zRQj1oE2vmE9xDPMAIJLKezgIO13YJ9FR8h6TxPdpx1Rfa1ZuUC78C5g9
   4q4ke10Gga+Ut5WX/9XFuBSZ3ROqnQJu9ZkCszan41X+zms/Q0y9dSfkJ
   Qy6XxRTDu4EnGGPhcsk6YQe9scr2w1+uTq9/LCE9QYsnpgm/Zt0vbVOIW
   w==;
X-CSE-ConnectionGUID: FjnjbSKRRse3wn78kdx4Pw==
X-CSE-MsgGUID: /YQEnU5XSVKeb2eSsIYjxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19695388"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19695388"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:39:56 -0700
X-CSE-ConnectionGUID: /KkjZGMNSh6TZTU57YptGQ==
X-CSE-MsgGUID: 7yCVsFnoQByTSOmVj/WfiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52796101"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:39:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in
 swapcache
In-Reply-To: <20240409082631.187483-5-21cnbao@gmail.com> (Barry Song's message
	of "Tue, 9 Apr 2024 20:26:30 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-5-21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 16:37:58 +0800
Message-ID: <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

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

IMHO, it's better to rename the above 2 local variables to "address" and
"ptep".  Just my personal opinion.  Feel free to ignore the comments.

> +	bool any_swap_shared = false;
>  
>  	if (!pte_unmap_same(vmf))
>  		goto out;
> @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 */
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);

We should move pte check here.  That is,

  	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  		goto out_nomap;

This will simplify the situation for large folio.

> +
> +	/* We hit large folios in swapcache */

The comments seems unnecessary because the code tells that already.

> +	if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)) {
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

It's better to construct pte based on fault PTE via generalizing
pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can find
inconsistent PTEs quicker.

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
> -	vmf->orig_pte = pte;
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

Do we need to call arch_do_swap_page() for each subpage?  IIUC, the
corresponding arch_unmap_one() will be called for each subpage.

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

--
Best Regards,
Huang, Ying

