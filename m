Return-Path: <linux-kernel+bounces-4061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62904817763
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F721C23F14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEF4239A;
	Mon, 18 Dec 2023 16:26:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E8E578
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93AD02F4;
	Mon, 18 Dec 2023 08:27:30 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C852E3F5A1;
	Mon, 18 Dec 2023 08:26:44 -0800 (PST)
Message-ID: <593c4eb0-e430-4186-a95c-9d2ebd91235c@arm.com>
Date: Mon, 18 Dec 2023 16:26:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/39] mm/rmap: introduce
 folio_add_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-15-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-15-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's mimic what we did with folio_add_file_rmap_*() so we can similarly
> replace page_add_anon_rmap() next.
> 
> Make the compiler always special-case on the granularity by using
> __always_inline.
> 
> Note that the new functions ignore the RMAP_COMPOUND flag, which we will
> remove as soon as page_add_anon_rmap() is gone.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/rmap.h |   6 +++
>  mm/rmap.c            | 118 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 88 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 7198905dc8be..3b5357cb1c09 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -234,6 +234,12 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
>   * rmap interfaces called when adding or removing pte of page
>   */
>  void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
> +void folio_add_anon_rmap_ptes(struct folio *, struct page *, int nr_pages,
> +		struct vm_area_struct *, unsigned long address, rmap_t flags);
> +#define folio_add_anon_rmap_pte(folio, page, vma, address, flags) \
> +	folio_add_anon_rmap_ptes(folio, page, 1, vma, address, flags)
> +void folio_add_anon_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *, unsigned long address, rmap_t flags);
>  void page_add_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
>  void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c5761986a411..7787499fa2ad 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1300,38 +1300,20 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  		unsigned long address, rmap_t flags)
>  {
>  	struct folio *folio = page_folio(page);
> -	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	int nr = 0, nr_pmdmapped = 0;
> -	bool compound = flags & RMAP_COMPOUND;
> -	bool first;
>  
> -	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(!compound)) {
> -		first = atomic_inc_and_test(&page->_mapcount);
> -		nr = first;
> -		if (first && folio_test_large(folio)) {
> -			nr = atomic_inc_return_relaxed(mapped);
> -			nr = (nr < COMPOUND_MAPPED);
> -		}
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> +	if (likely(!(flags & RMAP_COMPOUND)))
> +		folio_add_anon_rmap_pte(folio, page, vma, address, flags);
> +	else
> +		folio_add_anon_rmap_pmd(folio, page, vma, address, flags);
> +}
>  
> -		first = atomic_inc_and_test(&folio->_entire_mapcount);
> -		if (first) {
> -			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> -			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
> -				nr_pmdmapped = folio_nr_pages(folio);
> -				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> -				/* Raced ahead of a remove and another add? */
> -				if (unlikely(nr < 0))
> -					nr = 0;
> -			} else {
> -				/* Raced ahead of a remove of COMPOUND_MAPPED */
> -				nr = 0;
> -			}
> -		}
> -	}
> +static __always_inline void __folio_add_anon_rmap(struct folio *folio,
> +		struct page *page, int nr_pages, struct vm_area_struct *vma,
> +		unsigned long address, rmap_t flags, enum rmap_mode mode)
> +{
> +	unsigned int i, nr, nr_pmdmapped = 0;
>  
> +	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
>  	if (nr_pmdmapped)
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
>  	if (nr)
> @@ -1345,18 +1327,34 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  		 * folio->index right when not given the address of the head
>  		 * page.
>  		 */
> -		VM_WARN_ON_FOLIO(folio_test_large(folio) && !compound, folio);
> +		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> +				 mode != RMAP_MODE_PMD, folio);
>  		__folio_set_anon(folio, vma, address,
>  				 !!(flags & RMAP_EXCLUSIVE));
>  	} else if (likely(!folio_test_ksm(folio))) {
>  		__page_check_anon_rmap(folio, page, vma, address);
>  	}
> -	if (flags & RMAP_EXCLUSIVE)
> -		SetPageAnonExclusive(page);
> -	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
> -	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
> -			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
> -			 PageAnonExclusive(page), folio);
> +
> +	if (flags & RMAP_EXCLUSIVE) {
> +		switch (mode) {
> +		case RMAP_MODE_PTE:
> +			for (i = 0; i < nr_pages; i++)
> +				SetPageAnonExclusive(page + i);
> +			break;
> +		case RMAP_MODE_PMD:
> +			SetPageAnonExclusive(page);

Just to check; I suppose only setting this on the head is ok, because it's an
exclusive mapping and therefore by definition it can only be mapped by pmd?

> +			break;
> +		}
> +	}
> +	for (i = 0; i < nr_pages; i++) {
> +		struct page *cur_page = page + i;
> +
> +		/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
> +		VM_WARN_ON_FOLIO((atomic_read(&cur_page->_mapcount) > 0 ||
> +				  (folio_test_large(folio) &&
> +				   folio_entire_mapcount(folio) > 1)) &&
> +				 PageAnonExclusive(cur_page), folio);
> +	}
>  
>  	/*
>  	 * For large folio, only mlock it if it's fully mapped to VMA. It's
> @@ -1368,6 +1366,54 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  		mlock_vma_folio(folio, vma);
>  }
>  
> +/**
> + * folio_add_anon_rmap_ptes - add PTE mappings to a page range of an anon folio
> + * @folio:	The folio to add the mappings to
> + * @page:	The first page to add
> + * @nr_pages:	The number of pages which will be mapped
> + * @vma:	The vm area in which the mappings are added
> + * @address:	The user virtual address of the first page to map
> + * @flags:	The rmap flags
> + *
> + * The page range of folio is defined by [first_page, first_page + nr_pages)
> + *
> + * The caller needs to hold the page table lock, and the page must be locked in
> + * the anon_vma case: to serialize mapping,index checking after setting,
> + * and to ensure that an anon folio is not being upgraded racily to a KSM folio
> + * (but KSM folios are never downgraded).
> + */
> +void folio_add_anon_rmap_ptes(struct folio *folio, struct page *page,
> +		int nr_pages, struct vm_area_struct *vma, unsigned long address,
> +		rmap_t flags)
> +{
> +	__folio_add_anon_rmap(folio, page, nr_pages, vma, address, flags,
> +			      RMAP_MODE_PTE);
> +}
> +
> +/**
> + * folio_add_anon_rmap_pmd - add a PMD mapping to a page range of an anon folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + * @address:	The user virtual address of the first page to map
> + * @flags:	The rmap flags
> + *
> + * The page range of folio is defined by [first_page, first_page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock, and the page must be locked in
> + * the anon_vma case: to serialize mapping,index checking after setting.
> + */
> +void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma, unsigned long address, rmap_t flags)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	__folio_add_anon_rmap(folio, page, HPAGE_PMD_NR, vma, address, flags,
> +			      RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>  /**
>   * folio_add_new_anon_rmap - Add mapping to a new anonymous folio.
>   * @folio:	The folio to add the mapping to.


