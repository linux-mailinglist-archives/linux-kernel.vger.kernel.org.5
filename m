Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD1805595
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjLENM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjLENMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:12:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE2D197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:13:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD77139F;
        Tue,  5 Dec 2023 05:13:46 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73CD43F5A1;
        Tue,  5 Dec 2023 05:12:58 -0800 (PST)
Message-ID: <b7ef017b-f651-40f3-a2bd-70ebe9411dc1@arm.com>
Date:   Tue, 5 Dec 2023 13:12:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204142146.91437-35-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 14:21, David Hildenbrand wrote:
> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
> remove them.
> 
> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
> baching during fork() soon.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h   |   6 --
>  include/linux/rmap.h | 145 +++++++++++++++++++++++++++++--------------
>  2 files changed, 100 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 24c1c7c5a99c0..f7565b35ae931 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
>  	return folio_maybe_dma_pinned(folio);
>  }
>  
> -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> -					  struct page *page)
> -{
> -	return folio_needs_cow_for_dma(vma, page_folio(page));
> -}
> -
>  /**
>   * is_zero_page - Query if a page is a zero page
>   * @page: The page to query
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 21d72cc602adc..84439f7720c62 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>  #endif
>  }
>  
> -static inline void __page_dup_rmap(struct page *page, bool compound)
> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,

__always_inline?

> +		struct page *page, unsigned int nr_pages,
> +		struct vm_area_struct *src_vma, enum rmap_mode mode)
>  {
> -	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
> +	int i;
>  
> -	if (compound) {
> -		struct folio *folio = (struct folio *)page;
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>  
> -		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> -		atomic_inc(&folio->_entire_mapcount);
> -	} else {
> -		atomic_inc(&page->_mapcount);
> +	/*
> +	 * No need to check+clear for already shared PTEs/PMDs of the folio.
> +	 * This includes PTE mappings of (order-0) KSM folios.
> +	 */
> +	if (likely(mode == RMAP_MODE_PTE)) {

Presumbly if __always_inline then the compiler will remove this if/else and just
keep the part indicated by mode? In which case "likely" is pretty useless? Same
for all similar sites in the other patches.

> +		for (i = 0; i < nr_pages; i++) {
> +			if (PageAnonExclusive(page + i))
> +				goto clear;
> +		}
> +	} else if (mode == RMAP_MODE_PMD) {
> +		if (PageAnonExclusive(page))
> +			goto clear;
>  	}
> +	goto dup;
> +
> +clear:
> +	/*
> +	 * If this folio may have been pinned by the parent process,
> +	 * don't allow to duplicate the mappings but instead require to e.g.,
> +	 * copy the subpage immediately for the child so that we'll always
> +	 * guarantee the pinned folio won't be randomly replaced in the
> +	 * future on write faults.
> +	 */
> +	if (likely(!folio_is_device_private(folio) &&
> +	    unlikely(folio_needs_cow_for_dma(src_vma, folio))))
> +		return -EBUSY;
> +
> +	if (likely(mode == RMAP_MODE_PTE)) {
> +		for (i = 0; i < nr_pages; i++)

Do you really need to reset i=0 here? You have already checked that lower pages
are shared in the above loop, so can't you just start from the first exclusive
page here?

> +			ClearPageAnonExclusive(page + i);
> +	} else if (mode == RMAP_MODE_PMD) {
> +		ClearPageAnonExclusive(page);
> +	}
> +
> +dup:
> +	__folio_dup_rmap(folio, page, nr_pages, mode);
> +	return 0;
>  }
>  
>  /**
> - * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
> - *			    anonymous page
> - * @page: the page to duplicate the mapping for
> - * @compound: the page is mapped as compound or as a small page
> - * @vma: the source vma
> + * folio_try_dup_anon_rmap_ptes - try duplicating PTE mappings of a page range
> + *				  of a folio
> + * @folio:	The folio to duplicate the mappings of
> + * @page:	The first page to duplicate the mappings of
> + * @nr_pages:	The number of pages of which the mapping will be duplicated
> + * @src_vma:	The vm area from which the mappings are duplicated
>   *
> - * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
> + * The page range of the folio is defined by [page, page + nr_pages)
>   *
> - * Duplicating the mapping can only fail if the page may be pinned; device
> - * private pages cannot get pinned and consequently this function cannot fail.
> + * The caller needs to hold the page table lock and the
> + * vma->vma_mm->write_protect_seq.
> + *
> + * Duplicating the mappings can only fail if the folio may be pinned; device
> + * private folios cannot get pinned and consequently this function cannot fail.
> + *
> + * If duplicating the mappings succeeded, the duplicated PTEs have to be R/O in
> + * the parent and the child. They must *not* be writable after this call.
> + *
> + * Returns 0 if duplicating the mappings succeeded. Returns -EBUSY otherwise.
> + */
> +static inline int folio_try_dup_anon_rmap_ptes(struct folio *folio,
> +		struct page *page, unsigned int nr_pages,
> +		struct vm_area_struct *src_vma)
> +{
> +	return __folio_try_dup_anon_rmap(folio, page, nr_pages, src_vma,
> +					 RMAP_MODE_PTE);
> +}
> +#define folio_try_dup_anon_rmap_pte(folio, page, vma) \
> +	folio_try_dup_anon_rmap_ptes(folio, page, 1, vma)
> +
> +/**
> + * folio_try_dup_anon_rmap_pmd - try duplicating a PMD mapping of a page range
> + *				 of a folio
> + * @folio:	The folio to duplicate the mapping of
> + * @page:	The first page to duplicate the mapping of
> + * @src_vma:	The vm area from which the mapping is duplicated
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock and the
> + * vma->vma_mm->write_protect_seq.
>   *
> - * If duplicating the mapping succeeds, the page has to be mapped R/O into
> - * the parent and the child. It must *not* get mapped writable after this call.
> + * Duplicating the mapping can only fail if the folio may be pinned; device
> + * private folios cannot get pinned and consequently this function cannot fail.
> + *
> + * If duplicating the mapping succeeds, the duplicated PMD has to be R/O in
> + * the parent and the child. They must *not* be writable after this call.
>   *
>   * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
>   */
> +static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
> +		struct page *page, struct vm_area_struct *src_vma)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, src_vma,
> +					 RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>  static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>  					 struct vm_area_struct *vma)
>  {
> -	VM_BUG_ON_PAGE(!PageAnon(page), page);
> -
> -	/*
> -	 * No need to check+clear for already shared pages, including KSM
> -	 * pages.
> -	 */
> -	if (!PageAnonExclusive(page))
> -		goto dup;
> -
> -	/*
> -	 * If this page may have been pinned by the parent process,
> -	 * don't allow to duplicate the mapping but instead require to e.g.,
> -	 * copy the page immediately for the child so that we'll always
> -	 * guarantee the pinned page won't be randomly replaced in the
> -	 * future on write faults.
> -	 */
> -	if (likely(!is_device_private_page(page) &&
> -	    unlikely(page_needs_cow_for_dma(vma, page))))
> -		return -EBUSY;
> +	struct folio *folio = page_folio(page);
>  
> -	ClearPageAnonExclusive(page);
> -	/*
> -	 * It's okay to share the anon page between both processes, mapping
> -	 * the page R/O into both processes.
> -	 */
> -dup:
> -	__page_dup_rmap(page, compound);
> -	return 0;
> +	if (likely(!compound))
> +		return folio_try_dup_anon_rmap_pte(folio, page, vma);
> +	return folio_try_dup_anon_rmap_pmd(folio, page, vma);
>  }
>  
>  /**

