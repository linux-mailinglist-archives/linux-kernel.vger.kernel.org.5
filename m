Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB9805539
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjLEMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbjLEMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:52:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E34A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:52:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24428139F;
        Tue,  5 Dec 2023 04:53:28 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5BAA3F5A1;
        Tue,  5 Dec 2023 04:52:39 -0800 (PST)
Message-ID: <b113e197-d802-4972-b2df-a47d334629f6@arm.com>
Date:   Tue, 5 Dec 2023 12:52:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 23/39] mm/rmap: introduce
 folio_remove_rmap_[pte|ptes|pmd]()
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
 <20231204142146.91437-24-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204142146.91437-24-david@redhat.com>
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
> Let's mimic what we did with folio_add_file_rmap_*() and
> folio_add_anon_rmap_*() so we can similarly replace page_remove_rmap()
> next.
> 
> Make the compiler always special-case on the granularity by using
> __always_inline.
> 
> We're adding folio_remove_rmap_ptes() handling right away, as we want to
> use that soon for batching rmap operations when unmapping PTE-mapped
> large folios.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/rmap.h |  6 ++++
>  mm/rmap.c            | 76 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 017b216915f19..dd4ffb1d8ae04 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -241,6 +241,12 @@ void folio_add_file_rmap_pmd(struct folio *, struct page *,
>  		struct vm_area_struct *);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void folio_remove_rmap_ptes(struct folio *, struct page *, unsigned int nr,
> +		struct vm_area_struct *);
> +#define folio_remove_rmap_pte(folio, page, vma) \
> +	folio_remove_rmap_ptes(folio, page, 1, vma)
> +void folio_remove_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *);
>  
>  void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 3587225055c5e..50b6909157ac1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1463,25 +1463,36 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		bool compound)
>  {
>  	struct folio *folio = page_folio(page);
> +
> +	if (likely(!compound))
> +		folio_remove_rmap_pte(folio, page, vma);
> +	else
> +		folio_remove_rmap_pmd(folio, page, vma);
> +}
> +
> +static __always_inline void __folio_remove_rmap(struct folio *folio,
> +		struct page *page, unsigned int nr_pages,
> +		struct vm_area_struct *vma, enum rmap_mode mode)
> +{
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	int nr = 0, nr_pmdmapped = 0;
> -	bool last;
> +	int last, nr = 0, nr_pmdmapped = 0;

nit: you're being inconsistent across the functions with signed vs unsigned for
page counts (e.g. nr, nr_pmdmapped) - see __folio_add_rmap(),
__folio_add_file_rmap(), __folio_add_anon_rmap().

I suggest pick one and stick to it. Personally I'd go with signed int (since
that's what all the counters in struct folio that we are manipulating are,
underneath the atomic_t) then check that nr_pages > 0 in
__folio_rmap_sanity_checks().

>  	enum node_stat_item idx;
>  
> -	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> -	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>  
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
> -	if (likely(!compound)) {
> -		last = atomic_add_negative(-1, &page->_mapcount);
> -		nr = last;
> -		if (last && folio_test_large(folio)) {
> -			nr = atomic_dec_return_relaxed(mapped);
> -			nr = (nr < COMPOUND_MAPPED);
> -		}
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> +	if (likely(mode == RMAP_MODE_PTE)) {
> +		do {
> +			last = atomic_add_negative(-1, &page->_mapcount);
> +			if (last && folio_test_large(folio)) {
> +				last = atomic_dec_return_relaxed(mapped);
> +				last = (last < COMPOUND_MAPPED);
> +			}
>  
> +			if (last)
> +				nr++;
> +		} while (page++, --nr_pages > 0);
> +	} else if (mode == RMAP_MODE_PMD) {
>  		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>  		if (last) {
>  			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1517,7 +1528,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		 * is still mapped.
>  		 */
>  		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))

folio_test_pmd_mappable() -> folio_test_large()

Since you're converting this to support batch PTE removal, it might as well also
support smaller-than-pmd too?

I currently have a patch to do this same change in the multi-size THP series.


> -			if (!compound || nr < nr_pmdmapped)
> +			if (mode == RMAP_MODE_PTE || nr < nr_pmdmapped)
>  				deferred_split_folio(folio);
>  	}
>  
> @@ -1532,6 +1543,43 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  	munlock_vma_folio(folio, vma);
>  }
>  
> +/**
> + * folio_remove_rmap_ptes - remove PTE mappings from a page range of a folio
> + * @folio:	The folio to remove the mappings from
> + * @page:	The first page to remove
> + * @nr_pages:	The number of pages that will be removed from the mapping
> + * @vma:	The vm area from which the mappings are removed
> + *
> + * The page range of the folio is defined by [page, page + nr_pages)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_remove_rmap_ptes(struct folio *folio, struct page *page,
> +		unsigned int nr_pages, struct vm_area_struct *vma)
> +{
> +	__folio_remove_rmap(folio, page, nr_pages, vma, RMAP_MODE_PTE);
> +}
> +
> +/**
> + * folio_remove_rmap_pmd - remove a PMD mapping from a page range of a folio
> + * @folio:	The folio to remove the mapping from
> + * @page:	The first page to remove
> + * @vma:	The vm area from which the mapping is removed
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	__folio_remove_rmap(folio, page, HPAGE_PMD_NR, vma, RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>  /*
>   * @arg: enum ttu_flags will be passed to this argument
>   */

