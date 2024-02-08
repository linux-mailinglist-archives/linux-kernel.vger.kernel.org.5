Return-Path: <linux-kernel+bounces-57527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A916284DA3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2C21C2353F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188D67E76;
	Thu,  8 Feb 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXfgqLd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D367E7F;
	Thu,  8 Feb 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374542; cv=none; b=U6P9CO5M6GwMzRDndVUpt62GAknglYxyxvosUJB+3VRv9OPA1BQqn4tQ8q4eNE8ABeJVBffY5DiWYh9GeCiqMMFzvNJK8xz/TGOwLF3K6CEnDDVNVpAxE9Ki5g1dboFPRGGQckKswx0aIBnAchBzAeUiGhIqOvVfZH+KTEl9yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374542; c=relaxed/simple;
	bh=Q0QBXUvi2DClMvfJ1phvhOK/w5j08YYDMbbsStc2yQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNQJ7DW7k9pc17yK4gF6NwJbJ3/RXP39u4t1K4kVcuiuDps8PxRESxDs8yLXyuAt93R62mHsGZCiqpUnOxI5l/fkk2y5f8q77knCDcNicVJOJrZo/8ROHTo9+8Y6+XvD7NZSwi/A/OTfLDmP4Hgru7Aipe+3bMb4cqUqPpaSbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXfgqLd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F50CC433F1;
	Thu,  8 Feb 2024 06:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707374541;
	bh=Q0QBXUvi2DClMvfJ1phvhOK/w5j08YYDMbbsStc2yQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXfgqLd9QUTkGv1W/ehUJa6sFq/3CyaP+4cUEidecXWVvmJDu0n0P2UECcJisR0V2
	 nnothRp+ORVk0TwoCH5+vNTVME7CguMXp89J9uvilciQbgHWYfuEWVDbdHKWwSNNqe
	 5wbTtAY2q2gPs3rWjC7SlZQ/ijex0YMpSx+folwS99tLA9ZOiYYITQKkCrNzvOaqUn
	 iMy2sDTQ/gPsjSG6OLfzWCW8/vPiLhkOmtQjiRoIvv2V/+O3l61ylegyS3T8TFd/bI
	 rcGpkK9gsaHzsD813FYOI9Ou4R8DWf6hWVerVSdfv4BAO+ExblwYIjadHW9Le24NAi
	 oMymplkqG1vyA==
Date: Thu, 8 Feb 2024 08:41:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 13/15] mm/memory: optimize fork() with PTE-mapped THP
Message-ID: <ZcR3tBy9n0Yp5eq2@kernel.org>
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-14-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129124649.189745-14-david@redhat.com>

On Mon, Jan 29, 2024 at 01:46:47PM +0100, David Hildenbrand wrote:
> Let's implement PTE batching when consecutive (present) PTEs map
> consecutive pages of the same large folio, and all other PTE bits besides
> the PFNs are equal.
> 
> We will optimize folio_pte_batch() separately, to ignore selected
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
> Further, processing PTE-mapped THP that maybe pinned and have
> PageAnonExclusive set on at least one subpage should work as expected,
> but there is room for improvement: We will repeatedly (1) detect a PTE
> batch (2) detect that we have to copy a page (3) fall back and allocate a
> single page to copy a single page. For now we won't care as pinned pages
> are a corner case, and we should rather look into maintaining only a
> single PageAnonExclusive bit for large folios.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h |  31 +++++++++++
>  mm/memory.c             | 112 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 124 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 351cd9dc7194..aab227e12493 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -650,6 +650,37 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>  }
>  #endif
>  
> +#ifndef wrprotect_ptes
> +/**
> + * wrprotect_ptes - Write-protect PTEs that map consecutive pages of the same
> + *		    folio.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to write-protect.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_set_wrprotect().
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
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
> index 41b24da5be38..86f8a0021c8e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -930,15 +930,15 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	return 0;
>  }
>  
> -static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
> +static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
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
> @@ -950,26 +950,93 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
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
> +	 * sure that the common "small folio" case is as fast as possible
> +	 * by keeping the batching logic separate.
> +	 */
> +	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
> +		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
> +		folio_ref_add(folio, nr);
> +		if (folio_test_anon(folio)) {
> +			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
> +								  nr, src_vma))) {
> +				folio_ref_sub(folio, nr);
> +				return -EAGAIN;
> +			}
> +			rss[MM_ANONPAGES] += nr;
> +			VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
> +		} else {
> +			folio_dup_file_rmap_ptes(folio, page, nr);
> +			rss[mm_counter_file(folio)] += nr;
> +		}
> +		__copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte, pte,
> +				    addr, nr);
> +		return nr;
> +	}
> +
>  	folio_get(folio);
>  	if (folio_test_anon(folio)) {
>  		/*
> @@ -981,8 +1048,9 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> @@ -992,8 +1060,8 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> @@ -1030,10 +1098,11 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> @@ -1064,6 +1133,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	arch_enter_lazy_mmu_mode();
>  
>  	do {
> +		nr = 1;
> +
>  		/*
>  		 * We are holding two locks at this point - either of them
>  		 * could generate latencies in another task on another CPU.
> @@ -1100,9 +1171,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> @@ -1119,8 +1191,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
> @@ -1141,7 +1215,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
>  		if (!prealloc)
>  			return -ENOMEM;
> -	} else if (ret) {
> +	} else if (ret < 0) {
>  		VM_WARN_ON_ONCE(1);
>  	}
>  
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

