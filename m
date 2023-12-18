Return-Path: <linux-kernel+bounces-3984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8993817654
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EF51F26EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8324FF63;
	Mon, 18 Dec 2023 15:48:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3674FF7D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EE7FEC;
	Mon, 18 Dec 2023 07:49:37 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69A0A3F5A1;
	Mon, 18 Dec 2023 07:48:51 -0800 (PST)
Message-ID: <82505851-d83b-4d34-afb3-30d548941730@arm.com>
Date: Mon, 18 Dec 2023 15:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/39] mm/rmap: convert folio_add_file_rmap_range()
 into folio_add_file_rmap_[pte|ptes|pmd]()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-8-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's get rid of the compound parameter and instead define implicitly

nit: think you mean explicitly

> which mappings we're adding. That is more future proof, easier to read
> and harder to mess up.
> 
> Use an enum to express the granularity internally. Make the compiler
> always special-case on the granularity by using __always_inline. Replace
> the "compound" check by a switch-case that will be removed by the
> compiler completely.
> 
> Add plenty of sanity checks with CONFIG_DEBUG_VM. Replace the
> folio_test_pmd_mappable() check by a config check in the caller and
> sanity checks. Convert the single user of folio_add_file_rmap_range().
> 
> This function design can later easily be extended to PUDs and to batch
> PMDs. Note that for now we don't support anything bigger than
> PMD-sized folios (as we cleanly separated hugetlb handling). Sanity checks
> will catch if that ever changes.
> 
> Next up is removing page_remove_rmap() along with its "compound"
> parameter and smilarly converting all other rmap functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/rmap.h | 47 +++++++++++++++++++++++++--
>  mm/memory.c          |  2 +-
>  mm/rmap.c            | 75 +++++++++++++++++++++++++++++---------------
>  3 files changed, 95 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index e3857d26b944..1753900f4aed 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -191,6 +191,45 @@ typedef int __bitwise rmap_t;
>   */
>  #define RMAP_COMPOUND		((__force rmap_t)BIT(1))
>  
> +/*
> + * Internally, we're using an enum to specify the granularity. Usually,
> + * we make the compiler create specialized variants for the different
> + * granularity.
> + */
> +enum rmap_mode {
> +	RMAP_MODE_PTE = 0,
> +	RMAP_MODE_PMD,
> +};
> +
> +static inline void __folio_rmap_sanity_checks(struct folio *folio,
> +		struct page *page, int nr_pages, enum rmap_mode mode)
> +{
> +	/* hugetlb folios are handled separately. */
> +	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> +			 !folio_test_large_rmappable(folio), folio);
> +
> +	VM_WARN_ON_ONCE(nr_pages <= 0);
> +	VM_WARN_ON_FOLIO(page_folio(page) != folio, folio);
> +	VM_WARN_ON_FOLIO(page_folio(page + nr_pages - 1) != folio, folio);
> +
> +	switch (mode) {
> +	case RMAP_MODE_PTE:
> +		break;
> +	case RMAP_MODE_PMD:
> +		/*
> +		 * We don't support folios larger than a single PMD yet. So
> +		 * when RMAP_MODE_PMD is set, we assume that we are creating
> +		 * a single "entire" mapping of the folio.
> +		 */
> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
> +		break;
> +	default:
> +		VM_WARN_ON_ONCE(true);
> +	}
> +}
> +
>  /*
>   * rmap interfaces called when adding or removing pte of page
>   */
> @@ -203,8 +242,12 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> -void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
> -		struct vm_area_struct *, bool compound);
> +void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
> +		struct vm_area_struct *);
> +#define folio_add_file_rmap_pte(folio, page, vma) \
> +	folio_add_file_rmap_ptes(folio, page, 1, vma)
> +void folio_add_file_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f0b936b90b5..6a5540ba3c65 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4515,7 +4515,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>  		folio_add_lru_vma(folio, vma);
>  	} else {
>  		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
> -		folio_add_file_rmap_range(folio, page, nr, vma, false);
> +		folio_add_file_rmap_ptes(folio, page, nr, vma);
>  	}
>  	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 41597da14f26..4f30930a1162 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1376,31 +1376,20 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>  }
>  
> -/**
> - * folio_add_file_rmap_range - add pte mapping to page range of a folio
> - * @folio:	The folio to add the mapping to
> - * @page:	The first page to add
> - * @nr_pages:	The number of pages which will be mapped
> - * @vma:	the vm area in which the mapping is added
> - * @compound:	charge the page as compound or small page
> - *
> - * The page range of folio is defined by [first_page, first_page + nr_pages)
> - *
> - * The caller needs to hold the pte lock.
> - */
> -void folio_add_file_rmap_range(struct folio *folio, struct page *page,
> -			unsigned int nr_pages, struct vm_area_struct *vma,
> -			bool compound)
> +static __always_inline void __folio_add_file_rmap(struct folio *folio,
> +		struct page *page, int nr_pages, struct vm_area_struct *vma,
> +		enum rmap_mode mode)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>  	unsigned int nr_pmdmapped = 0, first;
>  	int nr = 0;
>  
> -	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> -	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(!compound)) {
> +	switch (mode) {
> +	case RMAP_MODE_PTE:
>  		do {
>  			first = atomic_inc_and_test(&page->_mapcount);
>  			if (first && folio_test_large(folio)) {
> @@ -1411,9 +1400,8 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  			if (first)
>  				nr++;
>  		} while (page++, --nr_pages > 0);
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> -
> +		break;
> +	case RMAP_MODE_PMD:
>  		first = atomic_inc_and_test(&folio->_entire_mapcount);
>  		if (first) {
>  			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1428,6 +1416,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  				nr = 0;
>  			}
>  		}
> +		break;
>  	}
>  
>  	if (nr_pmdmapped)
> @@ -1441,6 +1430,43 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  		mlock_vma_folio(folio, vma);
>  }
>  
> +/**
> + * folio_add_file_rmap_ptes - add PTE mappings to a page range of a folio
> + * @folio:	The folio to add the mappings to
> + * @page:	The first page to add
> + * @nr_pages:	The number of pages that will be mapped using PTEs
> + * @vma:	The vm area in which the mappings are added
> + *
> + * The page range of the folio is defined by [page, page + nr_pages)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
> +		int nr_pages, struct vm_area_struct *vma)
> +{
> +	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_MODE_PTE);
> +}
> +
> +/**
> + * folio_add_file_rmap_pmd - add a PMD mapping to a page range of a folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	__folio_add_file_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>  /**
>   * page_add_file_rmap - add pte mapping to a file page
>   * @page:	the page to add the mapping to
> @@ -1453,16 +1479,13 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  		bool compound)
>  {
>  	struct folio *folio = page_folio(page);
> -	unsigned int nr_pages;
>  
>  	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>  
>  	if (likely(!compound))
> -		nr_pages = 1;
> +		folio_add_file_rmap_pte(folio, page, vma);
>  	else
> -		nr_pages = folio_nr_pages(folio);
> -
> -	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
> +		folio_add_file_rmap_pmd(folio, page, vma);
>  }
>  
>  /**


