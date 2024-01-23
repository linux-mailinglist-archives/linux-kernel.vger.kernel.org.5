Return-Path: <linux-kernel+bounces-35224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78C838E15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29813284150
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9585D91C;
	Tue, 23 Jan 2024 12:01:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F1B5A114;
	Tue, 23 Jan 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011278; cv=none; b=el8PuKVcrfpbmuH5juQcOD3bjKEkvcTj/ehPUu/UaPRRgmPjcSJ6uT+0mpsLB3iyB7Tk5blUfr034rY1cNxt80eJUSgSE5JrUek04bczs7bFgIHFcVKROQREU86DazynAyfg2iikX5QFOMl70XA30C7M5Ms8f+F8PGpgeTijhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011278; c=relaxed/simple;
	bh=kylJn5VAfTSxuUnBHu/knjs62NSXWINLYRsOOyA0pxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZg/OpkIf6s7oRRj4r/8ZuP1q80yBNXw/olS6fP+kSkjk0PKOEHEjKk/ZLoJGXhgcAWolOlHKJOgCGv5NvwHnR5I8adRYbnzsmE/FcPA9R5GLu+WfUr2vVUdyM9wee053UAzoYfkPoeBwVa9x6bf/4tROl9QUiQPouPoQb2lkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AB021FB;
	Tue, 23 Jan 2024 04:02:00 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C3E03F762;
	Tue, 23 Jan 2024 04:01:10 -0800 (PST)
Message-ID: <63be0c3c-bf34-4cbb-b47b-7c9be0e65058@arm.com>
Date: Tue, 23 Jan 2024 12:01:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] mm/memory: optimize fork() with PTE-mapped THP
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-10-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> Let's implement PTE batching when consecutive (present) PTEs map
> consecutive pages of the same large folio, and all other PTE bits besides
> the PFNs are equal.
> 
> We will optimize folio_pte_batch() separately, to ignore some other
> PTE bits. This patch is based on work by Ryan Roberts.
> 
> Use __always_inline for __copy_present_ptes() and keep the handling for
> single PTEs completely separate from the multi-PTE case: we really want
> the compiler to optimize for the single-PTE case with small folios, to
> not degrade performance.
> 
> Note that PTE batching will never exceed a single page table and will
> always stay within VMA boundaries.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/pgtable.h |  17 +++++-
>  mm/memory.c             | 113 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 109 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f6d0e3513948a..d32cedf6936ba 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -212,8 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
>  #define arch_flush_lazy_mmu_mode()	do {} while (0)
>  #endif
>  
> -#ifndef set_ptes
> -
>  #ifndef pte_next_pfn
>  static inline pte_t pte_next_pfn(pte_t pte)
>  {
> @@ -221,6 +219,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
>  }
>  #endif
>  
> +#ifndef set_ptes
>  /**
>   * set_ptes - Map consecutive pages to a contiguous range of addresses.
>   * @mm: Address space to map the pages into.
> @@ -650,6 +649,20 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>  }
>  #endif
>  
> +#ifndef wrprotect_ptes

I wrote some documentation for this (based on Matthew's docs for set_ptes() in
my version. Perhaps it makes sense to add it here, given this is overridable by
the arch.

/**
 * wrprotect_ptes - Write protect a consecutive set of pages.
 * @mm: Address space that the pages are mapped into.
 * @addr: Address of first page to write protect.
 * @ptep: Page table pointer for the first entry.
 * @nr: Number of pages to write protect.
 *
 * May be overridden by the architecture, else implemented as a loop over
 * ptep_set_wrprotect().
 *
 * Context: The caller holds the page table lock. The PTEs are all in the same
 * PMD.
 */

> +static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
> +{
> +	for (;;) {
> +		ptep_set_wrprotect(mm, addr, ptep);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +#endif
> +
>  /*
>   * On some architectures hardware does not set page access bit when accessing
>   * memory page, it is responsibility of software setting this bit. It brings
> diff --git a/mm/memory.c b/mm/memory.c
> index 185b4aff13d62..f563aec85b2a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -930,15 +930,15 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	return 0;
>  }
>  
> -static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
> +static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,

nit: doesn't the addition of __always_inline really belong in the patch where
you factored this out? (#7)

>  		struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
> -		pte_t pte, unsigned long addr)
> +		pte_t pte, unsigned long addr, int nr)
>  {
>  	struct mm_struct *src_mm = src_vma->vm_mm;
>  
>  	/* If it's a COW mapping, write protect it both processes. */
>  	if (is_cow_mapping(src_vma->vm_flags) && pte_write(pte)) {
> -		ptep_set_wrprotect(src_mm, addr, src_pte);
> +		wrprotect_ptes(src_mm, addr, src_pte, nr);
>  		pte = pte_wrprotect(pte);
>  	}
>  
> @@ -950,26 +950,94 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
>  	if (!userfaultfd_wp(dst_vma))
>  		pte = pte_clear_uffd_wp(pte);
>  
> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
> +	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> +}
> +
> +/*
> + * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> + * pages of the same folio.
> + *
> + * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
> + */
> +static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> +		pte_t *start_ptep, pte_t pte, int max_nr)
> +{
> +	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> +	const pte_t *end_ptep = start_ptep + max_nr;
> +	pte_t expected_pte = pte_next_pfn(pte);
> +	pte_t *ptep = start_ptep + 1;
> +
> +	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> +
> +	while (ptep != end_ptep) {
> +		pte = ptep_get(ptep);
> +
> +		if (!pte_same(pte, expected_pte))
> +			break;
> +
> +		/*
> +		 * Stop immediately once we reached the end of the folio. In
> +		 * corner cases the next PFN might fall into a different
> +		 * folio.
> +		 */
> +		if (pte_pfn(pte) == folio_end_pfn)
> +			break;
> +
> +		expected_pte = pte_next_pfn(expected_pte);
> +		ptep++;
> +	}
> +
> +	return ptep - start_ptep;
>  }
>  
>  /*
> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
> - * is required to copy this pte.
> + * Copy one present PTE, trying to batch-process subsequent PTEs that map
> + * consecutive pages of the same folio by copying them as well.
> + *
> + * Returns -EAGAIN if one preallocated page is required to copy the next PTE.
> + * Otherwise, returns the number of copied PTEs (at least 1).
>   */
>  static inline int
> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
> -		 int *rss, struct folio **prealloc)
> +		 int max_nr, int *rss, struct folio **prealloc)
>  {
>  	struct page *page;
>  	struct folio *folio;
> +	int err, nr;
>  
>  	page = vm_normal_page(src_vma, addr, pte);
>  	if (unlikely(!page))
>  		goto copy_pte;
>  
>  	folio = page_folio(page);
> +
> +	/*
> +	 * If we likely have to copy, just don't bother with batching. Make
> +	 * sure that the common "small folio" case stays as fast as possible
> +	 * by keeping the batching logic separate.
> +	 */
> +	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
> +		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
> +		if (folio_test_anon(folio)) {
> +			folio_ref_add(folio, nr);
> +			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
> +								  nr, src_vma))) {

What happens if its not the first page of the batch that fails here? Aren't you
signalling that you need a prealloc'ed page for the wrong pte? Shouldn't you
still batch copy all the way up to the failing page first? Perhaps it all comes
out in the wash and these events are so infrequent that we don't care about the
lost batching opportunity?

> +				folio_ref_sub(folio, nr);
> +				return -EAGAIN;
> +			}
> +			rss[MM_ANONPAGES] += nr;
> +			VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
> +		} else {
> +			folio_ref_add(folio, nr);

Perhaps hoist this out to immediately after folio_pte_batch() since you're
calling it on both branches?

> +			folio_dup_file_rmap_ptes(folio, page, nr);
> +			rss[mm_counter_file(page)] += nr;
> +		}
> +		__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte,
> +				    addr, nr);
> +		return nr;
> +	}
> +
>  	if (folio_test_anon(folio)) {
>  		/*
>  		 * If this page may have been pinned by the parent process,
> @@ -981,8 +1049,9 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
>  			/* Page may be pinned, we have to copy. */
>  			folio_put(folio);
> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> -						 addr, rss, prealloc, page);
> +			err = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
> +						addr, rss, prealloc, page);
> +			return err ? err : 1;
>  		}
>  		rss[MM_ANONPAGES]++;
>  		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
> @@ -993,8 +1062,8 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	}
>  
>  copy_pte:
> -	__copy_present_pte(dst_vma, src_vma, dst_pte, src_pte, pte, addr);
> -	return 0;
> +	__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte, addr, 1);
> +	return 1;
>  }
>  
>  static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
> @@ -1031,10 +1100,11 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	pte_t *src_pte, *dst_pte;
>  	pte_t ptent;
>  	spinlock_t *src_ptl, *dst_ptl;
> -	int progress, ret = 0;
> +	int progress, max_nr, ret = 0;
>  	int rss[NR_MM_COUNTERS];
>  	swp_entry_t entry = (swp_entry_t){0};
>  	struct folio *prealloc = NULL;
> +	int nr;
>  
>  again:
>  	progress = 0;
> @@ -1065,6 +1135,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	arch_enter_lazy_mmu_mode();
>  
>  	do {
> +		nr = 1;
> +
>  		/*
>  		 * We are holding two locks at this point - either of them
>  		 * could generate latencies in another task on another CPU.
> @@ -1101,9 +1173,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			 */
>  			WARN_ON_ONCE(ret != -ENOENT);
>  		}
> -		/* copy_present_pte() will clear `*prealloc' if consumed */
> -		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       ptent, addr, rss, &prealloc);
> +		/* copy_present_ptes() will clear `*prealloc' if consumed */
> +		max_nr = (end - addr) / PAGE_SIZE;
> +		ret = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
> +					ptent, addr, max_nr, rss, &prealloc);
>  		/*
>  		 * If we need a pre-allocated page for this pte, drop the
>  		 * locks, allocate, and try again.
> @@ -1120,8 +1193,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  			folio_put(prealloc);
>  			prealloc = NULL;
>  		}
> -		progress += 8;
> -	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
> +		nr = ret;
> +		progress += 8 * nr;
> +	} while (dst_pte += nr, src_pte += nr, addr += PAGE_SIZE * nr,
> +		 addr != end);
>  
>  	arch_leave_lazy_mmu_mode();
>  	pte_unmap_unlock(orig_src_pte, src_ptl);
> @@ -1142,7 +1217,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
>  		if (!prealloc)
>  			return -ENOMEM;
> -	} else if (ret) {
> +	} else if (ret < 0) {
>  		VM_WARN_ON_ONCE(1);
>  	}
>  


