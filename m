Return-Path: <linux-kernel+bounces-4033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8128176FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FBA1F25710
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7B5BF9F;
	Mon, 18 Dec 2023 16:07:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765C5BF86
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7E12F4;
	Mon, 18 Dec 2023 08:08:14 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C254E3F5A1;
	Mon, 18 Dec 2023 08:07:28 -0800 (PST)
Message-ID: <e5b69854-2bb3-4df4-92cc-3101e9691615@arm.com>
Date: Mon, 18 Dec 2023 16:07:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/39] mm/rmap: factor out adding folio mappings into
 __folio_add_rmap()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-14-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-14-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's factor it out to prepare for reuse as we convert
> page_add_anon_rmap() to folio_add_anon_rmap_[pte|ptes|pmd]().
> 
> Make the compiler always special-case on the granularity by using
> __always_inline.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/rmap.c | 81 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2ff2f11275e5..c5761986a411 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1157,6 +1157,49 @@ int folio_total_mapcount(struct folio *folio)
>  	return mapcount;
>  }
>  
> +static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
> +		struct page *page, int nr_pages, enum rmap_mode mode,
> +		unsigned int *nr_pmdmapped)
> +{
> +	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	int first, nr = 0;
> +
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
> +
> +	/* Is page being mapped by PTE? Is this its first map to be added? */

I suspect this comment is left over from the old version? It sounds a bit odd in
its new context.

> +	switch (mode) {
> +	case RMAP_MODE_PTE:
> +		do {
> +			first = atomic_inc_and_test(&page->_mapcount);
> +			if (first && folio_test_large(folio)) {
> +				first = atomic_inc_return_relaxed(mapped);
> +				first = (first < COMPOUND_MAPPED);
> +			}
> +
> +			if (first)
> +				nr++;
> +		} while (page++, --nr_pages > 0);
> +		break;
> +	case RMAP_MODE_PMD:
> +		first = atomic_inc_and_test(&folio->_entire_mapcount);
> +		if (first) {
> +			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> +			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
> +				*nr_pmdmapped = folio_nr_pages(folio);
> +				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> +				/* Raced ahead of a remove and another add? */
> +				if (unlikely(nr < 0))
> +					nr = 0;
> +			} else {
> +				/* Raced ahead of a remove of COMPOUND_MAPPED */
> +				nr = 0;
> +			}
> +		}
> +		break;
> +	}
> +	return nr;
> +}
> +
>  /**
>   * folio_move_anon_rmap - move a folio to our anon_vma
>   * @folio:	The folio to move to our anon_vma
> @@ -1380,45 +1423,11 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
>  		enum rmap_mode mode)
>  {
> -	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	unsigned int nr_pmdmapped = 0, first;
> -	int nr = 0;
> +	unsigned int nr, nr_pmdmapped = 0;

You're still being inconsistent with signed/unsigned here. Is there a reason
these can't be signed like nr_pages in the interface?

>  
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> -	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
> -
> -	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	switch (mode) {
> -	case RMAP_MODE_PTE:
> -		do {
> -			first = atomic_inc_and_test(&page->_mapcount);
> -			if (first && folio_test_large(folio)) {
> -				first = atomic_inc_return_relaxed(mapped);
> -				first = (first < COMPOUND_MAPPED);
> -			}
> -
> -			if (first)
> -				nr++;
> -		} while (page++, --nr_pages > 0);
> -		break;
> -	case RMAP_MODE_PMD:
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
> -		break;
> -	}
>  
> +	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
>  	if (nr_pmdmapped)
>  		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);


