Return-Path: <linux-kernel+bounces-83216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE386905E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07311F2ADC7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C213A878;
	Tue, 27 Feb 2024 12:22:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9E13958B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036566; cv=none; b=lJuMpv55WB3EnpAXdULLTXkMVXqGjPccALuQeSG5aOXBj72gwaGj15e5gm0+ajHAJbwd0CFUmiKBT6VRn5U8ib3XQHj5g6+X7Pj9DWMO5WCaR4Jj9ApQkTeVgeGf88AcFeW729bxUKzuFNsCzRWT4FVh83lvxSTF1iTFek5vuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036566; c=relaxed/simple;
	bh=bxTT6QCGxLPCfoIx4ZxFSkQ8XMQcRsLmgOD3i629X1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRoqSIg/dUhnv4MXrtSD2BeN+xrUG90N5LpIFVJFvUQI0I/s+EHsLv+LhP12seCh3BSBNHcQVjTzppvn/iiCXJzMzV88fxu+H0cP4a4NjRpSbN8thdbl5PQvlmfUNIFO6nPajqHw7X9Jj+ctvFe093LpbOG56aeddRdX3nLOAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93EADA7;
	Tue, 27 Feb 2024 04:23:21 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453053F73F;
	Tue, 27 Feb 2024 04:22:41 -0800 (PST)
Message-ID: <bafb4ab0-ebf5-4736-8a9d-a70a06c92013@arm.com>
Date: Tue, 27 Feb 2024 12:22:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>,
 Barry Song <v-songbaohua@oppo.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240118111036.72641-7-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Barry,

I've scanned through this patch as part of trying to understand the races you
have reported (It's going to take me a while to fully understand it all :) ). In
the meantime I have a few comments on this patch...

On 18/01/2024 11:10, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset has
> supported swapping large folios out as a whole for vmscan case. This patch
> extends the feature to madvise.
> 
> If madvised range covers the whole large folio, we don't split it. Otherwise,
> we still need to split it.
> 
> This patch doesn't depend on ARM64's CONT-PTE, alternatively, it defines one
> helper named pte_range_cont_mapped() to check if all PTEs are contiguously
> mapped to a large folio.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/asm-generic/tlb.h | 10 +++++++
>  include/linux/pgtable.h   | 60 +++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c              | 48 +++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 129a3a759976..f894e22da5d6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -608,6 +608,16 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>  	} while (0)
>  
> +#define tlb_remove_nr_tlb_entry(tlb, ptep, address, nr)			\
> +	do {                                                    	\
> +		int i;							\
> +		tlb_flush_pte_range(tlb, address,			\
> +				PAGE_SIZE * nr);			\
> +		for (i = 0; i < nr; i++)				\
> +			__tlb_remove_tlb_entry(tlb, ptep + i,		\
> +					address + i * PAGE_SIZE);	\
> +	} while (0)

David has recently added tlb_remove_tlb_entries() which does the same thing.

> +
>  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
>  	do {							\
>  		unsigned long _sz = huge_page_size(h);		\
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 37fe83b0c358..da0c1cf447e3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -320,6 +320,42 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
>  }
>  #endif
>  
> +#ifndef pte_range_cont_mapped
> +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
> +					 pte_t *start_pte,
> +					 unsigned long start_addr,
> +					 int nr)
> +{
> +	int i;
> +	pte_t pte_val;
> +
> +	for (i = 0; i < nr; i++) {
> +		pte_val = ptep_get(start_pte + i);
> +
> +		if (pte_none(pte_val))
> +			return false;
> +
> +		if (pte_pfn(pte_val) != (start_pfn + i))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +#endif

David has recently added folio_pte_batch() which does a similar thing (as
discussed in other context).

> +
> +#ifndef pte_range_young
> +static inline bool pte_range_young(pte_t *start_pte, int nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++)
> +		if (pte_young(ptep_get(start_pte + i)))
> +			return true;
> +
> +	return false;
> +}
> +#endif

I wonder if this should come from folio_pte_batch()?

> +
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					    unsigned long address,
> @@ -580,6 +616,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  }
>  #endif
>  
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_RANGE_FULL
> +static inline pte_t ptep_get_and_clear_range_full(struct mm_struct *mm,
> +						  unsigned long start_addr,
> +						  pte_t *start_pte,
> +						  int nr, int full)
> +{
> +	int i;
> +	pte_t pte;
> +
> +	pte = ptep_get_and_clear_full(mm, start_addr, start_pte, full);
> +
> +	for (i = 1; i < nr; i++)
> +		ptep_get_and_clear_full(mm, start_addr + i * PAGE_SIZE,
> +					start_pte + i, full);
> +
> +	return pte;
> +}

David has recently added get_and_clear_full_ptes(). Your version isn't gathering
access/dirty, which may be ok for your case, but not ok in general.

>  
>  /*
>   * If two threads concurrently fault at the same page, the thread that
> @@ -995,6 +1048,13 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  })
>  #endif
>  
> +#ifndef pte_nr_addr_end
> +#define pte_nr_addr_end(addr, size, end)				\
> +({	unsigned long __boundary = ((addr) + size) & (~(size - 1));	\
> +	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> +})
> +#endif
> +
>  /*
>   * When walking page tables, we usually want to skip any p?d_none entries;
>   * and any p?d_bad entries - reporting the error before resetting to none.
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..262460ac4b2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -452,6 +452,54 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (folio_test_large(folio)) {
>  			int err;
>  
> +			if (!folio_test_pmd_mappable(folio)) {
> +				int nr_pages = folio_nr_pages(folio);
> +				unsigned long folio_size = PAGE_SIZE * nr_pages;
> +				unsigned long start_addr = ALIGN_DOWN(addr, nr_pages * PAGE_SIZE);;

I doubt it is correct to align down here. Couldn't you be going outside the
bounds that the user supplied?

nit: you've defined folio_size, why not use it here?
nit: double semi-colon.

> +				unsigned long start_pfn = page_to_pfn(folio_page(folio, 0));
> +				pte_t *start_pte = pte - (addr - start_addr) / PAGE_SIZE;

I think start_pte could be off the start of the pgtable and into random memory
in some corner cases (and outside the protection of the PTL)? You're assuming
that the folio is fully and contigously mapped and correctly aligned. mremap
(and other things) could break that assumption.

> +				unsigned long next = pte_nr_addr_end(addr, folio_size, end);
> +
> +				if (!pte_range_cont_mapped(start_pfn, start_pte, start_addr, nr_pages))
> +					goto split;
> +
> +				if (next - addr != folio_size) {
> +					goto split;
> +				} else {
> +					/* Do not interfere with other mappings of this page */
> +					if (folio_estimated_sharers(folio) != 1)
> +						goto skip;
> +
> +					VM_BUG_ON(addr != start_addr || pte != start_pte);
> +
> +					if (pte_range_young(start_pte, nr_pages)) {
> +						ptent = ptep_get_and_clear_range_full(mm, start_addr, start_pte,
> +										      nr_pages, tlb->fullmm);
> +						ptent = pte_mkold(ptent);
> +
> +						set_ptes(mm, start_addr, start_pte, ptent, nr_pages);
> +						tlb_remove_nr_tlb_entry(tlb, start_pte, start_addr, nr_pages);
> +					}
> +
> +					folio_clear_referenced(folio);
> +					folio_test_clear_young(folio);
> +					if (pageout) {
> +						if (folio_isolate_lru(folio)) {
> +							if (folio_test_unevictable(folio))
> +								folio_putback_lru(folio);
> +							else
> +								list_add(&folio->lru, &folio_list);
> +						}
> +					} else
> +						folio_deactivate(folio);
> +				}
> +skip:
> +				pte += (next - PAGE_SIZE - (addr & PAGE_MASK))/PAGE_SIZE;
> +				addr = next - PAGE_SIZE;
> +				continue;
> +
> +			}
> +split:
>  			if (folio_estimated_sharers(folio) != 1)
>  				break;
>  			if (pageout_anon_only_filter && !folio_test_anon(folio))


