Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350477767F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHITHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:07:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C02E71;
        Wed,  9 Aug 2023 12:07:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F2ED75;
        Wed,  9 Aug 2023 12:08:30 -0700 (PDT)
Received: from [10.57.79.142] (unknown [10.57.79.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7A13F6C4;
        Wed,  9 Aug 2023 12:07:45 -0700 (PDT)
Message-ID: <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
Date:   Wed, 9 Aug 2023 20:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230809083256.699513-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 09:32, David Hildenbrand wrote:
> Let's track the total mapcount for all large folios in the first subpage.
> 
> The total mapcount is what we actually want to know in folio_mapcount()
> and it is also sufficient for implementing folio_mapped(). This also
> gets rid of any "raceiness" concerns as expressed in
> folio_total_mapcount().
> 
> With sub-PMD THP becoming more important and things looking promising
> that we will soon get support for such anon THP, we want to avoid looping
> over all pages of a folio just to calculate the total mapcount. Further,
> we may soon want to use the total mapcount in other context more
> frequently, so prepare for reading it efficiently and atomically.
> 
> Make room for the total mapcount in page[1] of the folio by moving
> _nr_pages_mapped to page[2] of the folio: it is not applicable to hugetlb
> -- and with the total mapcount in place probably also not desirable even
> if PMD-mappable hugetlb pages could get PTE-mapped at some point -- so we
> can overlay the hugetlb fields.
> 
> Note that we currently don't expect any order-1 compound pages / THP in
> rmap code, and that such support is not planned. If ever desired, we could
> move the compound mapcount to another page, because it only applies to
> PMD-mappable folios that are definitely larger. Let's avoid consuming
> more space elsewhere for now -- we might need more space for a different
> purpose in some subpages soon.
> 
> Maintain the total mapcount also for hugetlb pages. Use the total mapcount
> to implement folio_mapcount(), total_mapcount(), folio_mapped() and
> page_mapped().
> 
> We can now get rid of folio_total_mapcount() and
> folio_large_is_mapped(), by just inlining reading of the total mapcount.
> 
> _nr_pages_mapped is now only used in rmap code, so not accidentially
> externally where it might be used on arbitrary order-1 pages. The remaining
> usage is:
> 
> (1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
>  -> If we would account the total folio as mapped when mapping a
>     page (based on the total mapcount), we could remove that usage.
> 
> (2) Detect when to add a folio to the deferred split queue
>  -> If we would apply a different heuristic, or scan using the rmap on
>     the memory reclaim path for partially mapped anon folios to
>     split them, we could remove that usage as well.
> 
> So maybe, we can simplify things in the future and remove
> _nr_pages_mapped. For now, leave these things as they are, they need more
> thought. Hugh really did a nice job implementing that precise tracking
> after all.
> 
> Note: Not adding order-1 sanity checks to the file_rmap functions for
>       now. For anon pages, they are certainly not required right now.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Other than the nits and query on zeroing _total_mapcount below, LGTM. If zeroing
is correct:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  Documentation/mm/transhuge.rst | 12 +++++-----
>  include/linux/mm.h             | 31 ++++++------------------
>  include/linux/mm_types.h       |  6 +++--
>  include/linux/rmap.h           |  7 ++++--
>  mm/debug.c                     |  4 ++--
>  mm/huge_memory.c               |  2 ++
>  mm/hugetlb.c                   |  4 ++--
>  mm/internal.h                  | 17 ++++---------
>  mm/page_alloc.c                |  4 ++--
>  mm/rmap.c                      | 44 ++++++++++++++--------------------
>  10 files changed, 52 insertions(+), 79 deletions(-)
> 
> diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
> index 9a607059ea11..b0d3b1d3e8ea 100644
> --- a/Documentation/mm/transhuge.rst
> +++ b/Documentation/mm/transhuge.rst
> @@ -116,14 +116,14 @@ pages:
>      succeeds on tail pages.
>  
>    - map/unmap of a PMD entry for the whole THP increment/decrement
> -    folio->_entire_mapcount and also increment/decrement
> -    folio->_nr_pages_mapped by COMPOUND_MAPPED when _entire_mapcount
> -    goes from -1 to 0 or 0 to -1.
> +    folio->_entire_mapcount, increment/decrement folio->_total_mapcount
> +    and also increment/decrement folio->_nr_pages_mapped by COMPOUND_MAPPED
> +    when _entire_mapcount goes from -1 to 0 or 0 to -1.
>  
>    - map/unmap of individual pages with PTE entry increment/decrement
> -    page->_mapcount and also increment/decrement folio->_nr_pages_mapped
> -    when page->_mapcount goes from -1 to 0 or 0 to -1 as this counts
> -    the number of pages mapped by PTE.
> +    page->_mapcount, increment/decrement folio->_total_mapcount and also
> +    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
> +    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
>  
>  split_huge_page internally has to distribute the refcounts in the head
>  page to the tail pages before clearing all PG_head/tail bits from the page
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6a95dfed4957..30ac004fa0ef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1187,41 +1187,24 @@ static inline int page_mapcount(struct page *page)
>  	return mapcount;
>  }
>  
> -int folio_total_mapcount(struct folio *folio);
> -
>  /**
> - * folio_mapcount() - Calculate the number of mappings of this folio.
> + * folio_mapcount() - Return the total number of mappings of this folio.
>   * @folio: The folio.
>   *
> - * A large folio tracks both how many times the entire folio is mapped,
> - * and how many times each individual page in the folio is mapped.
> - * This function calculates the total number of times the folio is
> - * mapped.
> - *
> - * Return: The number of times this folio is mapped.
> + * Return: The total number of times this folio is mapped.
>   */
>  static inline int folio_mapcount(struct folio *folio)
>  {
>  	if (likely(!folio_test_large(folio)))
>  		return atomic_read(&folio->_mapcount) + 1;
> -	return folio_total_mapcount(folio);
> +	return atomic_read(&folio->_total_mapcount) + 1;
>  }
>  
>  static inline int total_mapcount(struct page *page)

nit: couldn't total_mapcount() just be implemented as a wrapper around
folio_mapcount()? What's the benefit of PageCompound() check instead of just
getting the folio and checking if it's large? i.e:

static inline int total_mapcount(struct page *page)
{
	return folio_mapcount(page_folio(page));
}

>  {
>  	if (likely(!PageCompound(page)))
>  		return atomic_read(&page->_mapcount) + 1;
> -	return folio_total_mapcount(page_folio(page));
> -}
> -
> -static inline bool folio_large_is_mapped(struct folio *folio)
> -{
> -	/*
> -	 * Reading _entire_mapcount below could be omitted if hugetlb
> -	 * participated in incrementing nr_pages_mapped when compound mapped.
> -	 */
> -	return atomic_read(&folio->_nr_pages_mapped) > 0 ||
> -		atomic_read(&folio->_entire_mapcount) >= 0;
> +	return atomic_read(&page_folio(page)->_total_mapcount) + 1;
>  }
>  
>  /**
> @@ -1234,7 +1217,7 @@ static inline bool folio_mapped(struct folio *folio)
>  {
>  	if (likely(!folio_test_large(folio)))
>  		return atomic_read(&folio->_mapcount) >= 0;
> -	return folio_large_is_mapped(folio);
> +	return atomic_read(&folio->_total_mapcount) >= 0;
>  }
>  
>  /*
> @@ -1246,7 +1229,7 @@ static inline bool page_mapped(struct page *page)
>  {
>  	if (likely(!PageCompound(page)))
>  		return atomic_read(&page->_mapcount) >= 0;
> -	return folio_large_is_mapped(page_folio(page));
> +	return atomic_read(&page_folio(page)->_total_mapcount) >= 0;

nit: same here; couldn't this be a wrapper around folio_mapped()?

>  }
>  
>  static inline struct page *virt_to_head_page(const void *x)
> @@ -2148,7 +2131,7 @@ static inline size_t folio_size(struct folio *folio)
>   * looking at the precise mapcount of the first subpage in the folio, and
>   * assuming the other subpages are the same. This may not be true for large
>   * folios. If you want exact mapcounts for exact calculations, look at
> - * page_mapcount() or folio_total_mapcount().
> + * page_mapcount() or folio_mapcount().
>   *
>   * Return: The estimated number of processes sharing a folio.
>   */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 291c05cacd48..16e66b3332c6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -267,7 +267,8 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>   * @_folio_dtor: Which destructor to use for this folio.
>   * @_folio_order: Do not use directly, call folio_order().
>   * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
> - * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
> + * @_total_mapcount: Do not use directly, call folio_mapcount().
> + * @_nr_pages_mapped: Do not use outside of rmap code (and not for hugetlb).
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
>   * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
> @@ -321,7 +322,7 @@ struct folio {
>  			unsigned char _folio_dtor;
>  			unsigned char _folio_order;
>  			atomic_t _entire_mapcount;
> -			atomic_t _nr_pages_mapped;
> +			atomic_t _total_mapcount;
>  			atomic_t _pincount;
>  #ifdef CONFIG_64BIT
>  			unsigned int _folio_nr_pages;
> @@ -346,6 +347,7 @@ struct folio {
>  			unsigned long _head_2a;
>  	/* public: */
>  			struct list_head _deferred_list;
> +			atomic_t _nr_pages_mapped;
>  	/* private: the union with struct page is transitional */
>  		};
>  		struct page __page_2;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index a3825ce81102..a7b1c005e0c9 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -210,14 +210,17 @@ void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
> -	if (compound) {
> -		struct folio *folio = (struct folio *)page;
> +	struct folio *folio = page_folio(page);
>  
> +	if (compound) {
>  		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  		atomic_inc(&folio->_entire_mapcount);
>  	} else {
>  		atomic_inc(&page->_mapcount);
>  	}
> +
> +	if (folio_test_large(folio))
> +		atomic_inc(&folio->_total_mapcount);
>  }
>  
>  static inline void page_dup_file_rmap(struct page *page, bool compound)
> diff --git a/mm/debug.c b/mm/debug.c
> index ee533a5ceb79..97f6f6b32ae7 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -99,10 +99,10 @@ static void __dump_page(struct page *page)
>  			page, page_ref_count(head), mapcount, mapping,
>  			page_to_pgoff(page), page_to_pfn(page));
>  	if (compound) {
> -		pr_warn("head:%p order:%u entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
> +		pr_warn("head:%p order:%u entire_mapcount:%d total_mapcount:%d pincount:%d\n",
>  				head, compound_order(head),
>  				folio_entire_mapcount(folio),
> -				folio_nr_pages_mapped(folio),
> +				folio_mapcount(folio),
>  				atomic_read(&folio->_pincount));
>  	}
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 154c210892a1..43a2150e41e3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -583,6 +583,7 @@ void prep_transhuge_page(struct page *page)
>  
>  	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
>  	INIT_LIST_HEAD(&folio->_deferred_list);
> +	atomic_set(&folio->_nr_pages_mapped, 0);
>  	folio_set_compound_dtor(folio, TRANSHUGE_PAGE_DTOR);
>  }
>  
> @@ -2795,6 +2796,7 @@ void free_transhuge_page(struct page *page)
>  		}
>  		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  	}
> +	VM_WARN_ON_ONCE(atomic_read(&folio->_nr_pages_mapped));
>  	free_compound_page(page);
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5f498e8025cc..6a614c559ccf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>  	struct page *p;
>  
>  	atomic_set(&folio->_entire_mapcount, 0);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, 0);

Just checking this is definitely what you intended? _total_mapcount is -1 when
it means "no pages mapped", so 0 means 1 page mapped?


>  	atomic_set(&folio->_pincount, 0);
>  
>  	for (i = 1; i < nr_pages; i++) {
> @@ -2027,7 +2027,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	/* we rely on prep_new_hugetlb_folio to set the destructor */
>  	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, -1);
>  	atomic_set(&folio->_pincount, 0);
>  	return true;
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 02a6fd36f46e..e4646fed44a5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -53,10 +53,10 @@ struct folio_batch;
>  void page_writeback_init(void);
>  
>  /*
> - * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
> + * If a 16GB folio were mapped by PTEs of all of its 4kB pages,
>   * its nr_pages_mapped would be 0x400000: choose the COMPOUND_MAPPED bit
> - * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
> - * leaves nr_pages_mapped at 0, but avoid surprise if it participates later.
> + * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE). Not applicable to
> + * hugetlb.
>   */
>  #define COMPOUND_MAPPED		0x800000
>  #define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
> @@ -67,15 +67,6 @@ void page_writeback_init(void);
>   */
>  #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
>  
> -/*
> - * How many individual pages have an elevated _mapcount.  Excludes
> - * the folio's entire_mapcount.
> - */
> -static inline int folio_nr_pages_mapped(struct folio *folio)
> -{
> -	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
> -}
> -
>  static inline void *folio_raw_mapping(struct folio *folio)
>  {
>  	unsigned long mapping = (unsigned long)folio->mapping;
> @@ -420,7 +411,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>  	folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
>  	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
> -	atomic_set(&folio->_nr_pages_mapped, 0);
> +	atomic_set(&folio->_total_mapcount, -1);
>  	atomic_set(&folio->_pincount, 0);
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 96b7c1a7d1f2..5bbd5782b543 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1009,8 +1009,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
>  			bad_page(page, "nonzero entire_mapcount");
>  			goto out;
>  		}
> -		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
> -			bad_page(page, "nonzero nr_pages_mapped");
> +		if (unlikely(atomic_read(&folio->_total_mapcount) + 1)) {
> +			bad_page(page, "nonzero total_mapcount");
>  			goto out;
>  		}
>  		if (unlikely(atomic_read(&folio->_pincount))) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1f04debdc87a..a7dcae48245b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1070,29 +1070,6 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  	return page_vma_mkclean_one(&pvmw);
>  }
>  
> -int folio_total_mapcount(struct folio *folio)
> -{
> -	int mapcount = folio_entire_mapcount(folio);
> -	int nr_pages;
> -	int i;
> -
> -	/* In the common case, avoid the loop when no pages mapped by PTE */
> -	if (folio_nr_pages_mapped(folio) == 0)
> -		return mapcount;
> -	/*
> -	 * Add all the PTE mappings of those pages mapped by PTE.
> -	 * Limit the loop to folio_nr_pages_mapped()?
> -	 * Perhaps: given all the raciness, that may be a good or a bad idea.
> -	 */
> -	nr_pages = folio_nr_pages(folio);
> -	for (i = 0; i < nr_pages; i++)
> -		mapcount += atomic_read(&folio_page(folio, i)->_mapcount);
> -
> -	/* But each of those _mapcounts was based on -1 */
> -	mapcount += nr_pages;
> -	return mapcount;
> -}
> -
>  /**
>   * page_move_anon_rmap - move a page to our anon_vma
>   * @page:	the page to move to our anon_vma
> @@ -1236,6 +1213,9 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  		}
>  	}
>  
> +	if (folio_test_large(folio))
> +		atomic_inc(&folio->_total_mapcount);
> +
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>  	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>  
> @@ -1289,6 +1269,10 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>  	}
>  
> +	if (folio_test_large(folio))
> +		/* increment count (starts at -1) */
> +		atomic_set(&folio->_total_mapcount, 0);
> +
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>  	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
> @@ -1310,14 +1294,14 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  			bool compound)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	unsigned int nr_pmdmapped = 0, first;
> +	unsigned int nr_pmdmapped = 0, i, first;
>  	int nr = 0;
>  
>  	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> -		do {
> +		for (i = 0; i < nr_pages; i++, page++) {
>  			first = atomic_inc_and_test(&page->_mapcount);
>  			if (first && folio_test_large(folio)) {
>  				first = atomic_inc_return_relaxed(mapped);
> @@ -1326,7 +1310,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  
>  			if (first)
>  				nr++;
> -		} while (page++, --nr_pages > 0);
> +		}
>  	} else if (folio_test_pmd_mappable(folio)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> @@ -1346,6 +1330,9 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>  		}
>  	}
>  
> +	if (folio_test_large(folio))
> +		atomic_add(compound ? 1 : nr_pages, &folio->_total_mapcount);
> +
>  	if (nr_pmdmapped)
>  		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
> @@ -1398,6 +1385,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> +	if (folio_test_large(folio))
> +		atomic_dec(&folio->_total_mapcount);
> +
>  	/* Hugetlb pages are not counted in NR_*MAPPED */
>  	if (unlikely(folio_test_hugetlb(folio))) {
>  		/* hugetlb pages are always mapped with pmds */
> @@ -2538,6 +2528,7 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  	BUG_ON(!anon_vma);
>  	/* address might be in next vma when migration races vma_merge */
>  	first = atomic_inc_and_test(&folio->_entire_mapcount);
> +	atomic_inc(&folio->_total_mapcount);
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>  	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>  	if (first)
> @@ -2551,6 +2542,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */
>  	atomic_set(&folio->_entire_mapcount, 0);
> +	atomic_set(&folio->_total_mapcount, 0);
>  	folio_clear_hugetlb_restore_reserve(folio);
>  	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }

