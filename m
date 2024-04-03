Return-Path: <linux-kernel+bounces-130303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B5897745
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9F2B3105C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC61552FD;
	Wed,  3 Apr 2024 17:18:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB9158A30
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164682; cv=none; b=P9VHI83mu09DxayYam5NWP14c7Mx8ZDa0lPVMfzLDfLSmb9k9BzJuYXjh8ujqJ/DS0RUK1ob6b8gyFxGQyxytI4/4YjJVTLoTtkv2z4+dfzbGtKqsgOwGu3DwrP9YK74zJj4uRT8X9YtQqHNDCVKKvrGHfArOSz7PjlFSLgrZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164682; c=relaxed/simple;
	bh=Q29mpD0EmqamgWB6Ygpwj68UWL7t7DlCQWlhiViUwrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPMv/dvDxCJjnqUNU6FXcs1nbz4gOLNh3oN7T8BN0bBXfhvwZhQsMkK3i4Kjejj3KBXLIArs/saMApk9teGky0grA60IB90+C2FxrADHGe+MPy+/vJhWiGh+lG3zaq5RlCtJGvvxqpRxi52oHftHl65vRuX76gzX0UhZNIDnlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525811007;
	Wed,  3 Apr 2024 10:18:31 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 466DF3F766;
	Wed,  3 Apr 2024 10:17:58 -0700 (PDT)
Message-ID: <5c42d627-d601-4397-823a-e3e113a00ff7@arm.com>
Date: Wed, 3 Apr 2024 18:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-7-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240403114032.1162100-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 12:40, Ryan Roberts wrote:
> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
> folio that is fully and contiguously mapped in the pageout/cold vm
> range. This change means that large folios will be maintained all the
> way to swap storage. This both improves performance during swap-out, by
> eliding the cost of splitting the folio, and sets us up nicely for
> maintaining the large folio when it is swapped back in (to be covered in
> a separate series).
> 
> Folios that are not fully mapped in the target range are still split,
> but note that behavior is changed so that if the split fails for any
> reason (folio locked, shared, etc) we now leave it as is and move to the
> next pte in the range and continue work on the proceeding folios.
> Previously any failure of this sort would cause the entire operation to
> give up and no folios mapped at higher addresses were paged out or made
> cold. Given large folios are becoming more common, this old behavior
> would have likely lead to wasted opportunities.
> 
> While we are at it, change the code that clears young from the ptes to
> use ptep_test_and_clear_young(), via the new mkold_ptes() batch helper
> function. This is more efficent than get_and_clear/modify/set,
> especially for contpte mappings on arm64, where the old approach would
> require unfolding/refolding and the new approach can be done in place.
> 
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 30 ++++++++++++++
>  mm/internal.h           | 12 +++++-
>  mm/madvise.c            | 88 ++++++++++++++++++++++++-----------------
>  mm/memory.c             |  4 +-
>  4 files changed, 93 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 0278259f7078..0f4b2faa1d71 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -361,6 +361,36 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +#ifndef mkold_ptes
> +/**
> + * mkold_ptes - Mark PTEs that map consecutive pages of the same folio as old.
> + * @vma: VMA the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_test_and_clear_young().
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
> +{
> +	for (;;) {
> +		ptep_test_and_clear_young(vma, addr, ptep);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> diff --git a/mm/internal.h b/mm/internal.h
> index 88705ab4c50a..003bc189736b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -130,6 +130,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   * @flags: Flags to modify the PTE batch semantics.
>   * @any_writable: Optional pointer to indicate whether any entry except the
>   *		  first one is writable.
> + * @any_young: Optional pointer to indicate whether any entry except the
> + *		  first one is young.
>   *
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same large folio.
> @@ -145,16 +147,18 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> -		bool *any_writable)
> +		bool *any_writable, bool *any_young)
>  {
>  	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>  	const pte_t *end_ptep = start_ptep + max_nr;
>  	pte_t expected_pte, *ptep;
> -	bool writable;
> +	bool writable, young;
>  	int nr;
>  
>  	if (any_writable)
>  		*any_writable = false;
> +	if (any_young)
> +		*any_young = false;
>  
>  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> @@ -168,6 +172,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  		pte = ptep_get(ptep);
>  		if (any_writable)
>  			writable = !!pte_write(pte);
> +		if (any_young)
> +			young = !!pte_young(pte);
>  		pte = __pte_batch_clear_ignored(pte, flags);
>  
>  		if (!pte_same(pte, expected_pte))
> @@ -183,6 +189,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  
>  		if (any_writable)
>  			*any_writable |= writable;
> +		if (any_young)
> +			*any_young |= young;
>  
>  		nr = pte_batch_hint(ptep, pte);
>  		expected_pte = pte_advance_pfn(expected_pte, nr);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 070bedb4996e..c1377f3b5ca1 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	LIST_HEAD(folio_list);
>  	bool pageout_anon_only_filter;
>  	unsigned int batch_count = 0;
> +	int nr;
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		return 0;
>  	flush_tlb_batched_pending(mm);
>  	arch_enter_lazy_mmu_mode();
> -	for (; addr < end; pte++, addr += PAGE_SIZE) {
> +	for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
> +		nr = 1;
>  		ptent = ptep_get(pte);
>  
>  		if (++batch_count == SWAP_CLUSTER_MAX) {
> @@ -447,55 +449,67 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			continue;
>  
>  		/*
> -		 * Creating a THP page is expensive so split it only if we
> -		 * are sure it's worth. Split it if we are only owner.
> +		 * If we encounter a large folio, only split it if it is not
> +		 * fully mapped within the range we are operating on. Otherwise
> +		 * leave it as is so that it can be swapped out whole. If we
> +		 * fail to split a folio, leave it in place and advance to the
> +		 * next pte in the range.
>  		 */
>  		if (folio_test_large(folio)) {
> -			int err;
> -
> -			if (folio_likely_mapped_shared(folio))
> -				break;
> -			if (pageout_anon_only_filter && !folio_test_anon(folio))
> -				break;
> -			if (!folio_trylock(folio))
> -				break;
> -			folio_get(folio);
> -			arch_leave_lazy_mmu_mode();
> -			pte_unmap_unlock(start_pte, ptl);
> -			start_pte = NULL;
> -			err = split_folio(folio);
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			if (err)
> -				break;
> -			start_pte = pte =
> -				pte_offset_map_lock(mm, pmd, addr, &ptl);
> -			if (!start_pte)
> -				break;
> -			arch_enter_lazy_mmu_mode();
> -			pte--;
> -			addr -= PAGE_SIZE;
> -			continue;
> +			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
> +						FPB_IGNORE_SOFT_DIRTY;
> +			int max_nr = (end - addr) / PAGE_SIZE;
> +			bool any_young;
> +
> +			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
> +					     fpb_flags, NULL, &any_young);
> +			if (any_young)
> +				ptent = pte_mkyoung(ptent);
> +
> +			if (nr < folio_nr_pages(folio)) {
> +				int err;
> +
> +				if (folio_likely_mapped_shared(folio))
> +					continue;
> +				if (pageout_anon_only_filter && !folio_test_anon(folio))
> +					continue;
> +				if (!folio_trylock(folio))
> +					continue;
> +				folio_get(folio);
> +				arch_leave_lazy_mmu_mode();
> +				pte_unmap_unlock(start_pte, ptl);
> +				start_pte = NULL;
> +				err = split_folio(folio);
> +				folio_unlock(folio);
> +				folio_put(folio);
> +				start_pte = pte =
> +					pte_offset_map_lock(mm, pmd, addr, &ptl);
> +				if (!start_pte)
> +					break;
> +				if (err)
> +					continue;
> +				arch_enter_lazy_mmu_mode();

Damn, this is still broken; arch_enter_lazy_mmu_mode() needs to be before the
continue. (thanks to Lance Yang; I noticed this while reviewing his MADV_FREE
series).


Andrew, is it possible to fix this up as you add it to mm-unstable, or do you
want me to send a v7?

The change would be:


diff --git a/mm/madvise.c b/mm/madvise.c
index c1377f3b5ca1..bf26cf2b7715 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -486,10 +486,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
                                        pte_offset_map_lock(mm, pmd, addr, &ptl);
                                if (!start_pte)
                                        break;
-                               if (err)
-                                       continue;
                                arch_enter_lazy_mmu_mode();
-                               nr = 0;
+                               if (!err)
+                                       nr = 0;
                                continue;
                        }
                }

> +				nr = 0;
> +				continue;
> +			}
>  		}
>  
>  		/*
>  		 * Do not interfere with other mappings of this folio and
> -		 * non-LRU folio.
> +		 * non-LRU folio. If we have a large folio at this point, we
> +		 * know it is fully mapped so if its mapcount is the same as its
> +		 * number of pages, it must be exclusive.
>  		 */
> -		if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
> +		if (!folio_test_lru(folio) ||
> +		    folio_mapcount(folio) != folio_nr_pages(folio))
>  			continue;
>  
>  		if (pageout_anon_only_filter && !folio_test_anon(folio))
>  			continue;
>  
> -		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>  		if (!pageout && pte_young(ptent)) {
> -			ptent = ptep_get_and_clear_full(mm, addr, pte,
> -							tlb->fullmm);
> -			ptent = pte_mkold(ptent);
> -			set_pte_at(mm, addr, pte, ptent);
> -			tlb_remove_tlb_entry(tlb, pte, addr);
> +			mkold_ptes(vma, addr, pte, nr);
> +			tlb_remove_tlb_entries(tlb, pte, nr, addr);
>  		}
>  
>  		/*
> diff --git a/mm/memory.c b/mm/memory.c
> index ef2968894718..912cd738ec03 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  			flags |= FPB_IGNORE_SOFT_DIRTY;
>  
>  		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
> -				     &any_writable);
> +				     &any_writable, NULL);
>  		folio_ref_add(folio, nr);
>  		if (folio_test_anon(folio)) {
>  			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
> @@ -1559,7 +1559,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
>  	 */
>  	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
>  		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
> -				     NULL);
> +				     NULL, NULL);
>  
>  		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
>  				       addr, details, rss, force_flush,


