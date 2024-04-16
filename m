Return-Path: <linux-kernel+bounces-147251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33A8A718A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E242856BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC82374EB;
	Tue, 16 Apr 2024 16:35:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A410A14
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285343; cv=none; b=LVo/DIUJ8rZpGg22790puX1AkbgJjmipWIUy7NwLtYbkCVShHI/8vygn9+vejWohqbDMBNhZ9V//Qb16NnxewsfD59I290b7J1nmcq89cCx01RiViHnNzzFK2hjLmKi1Sw67VCf0CFkJBFh/KojrJJ6gf1i7PaaHKFOnYdfKgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285343; c=relaxed/simple;
	bh=g3E5lHZEYrx1U/snow47ZHkbE9EtzY5g4xuA5cPsOBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJy21mDeoq71QIJ1hqbA465NpbI6y3SKArNnSOYE7TO8FFOD9LQ+0wHZluusetN7L6guEJDSWGtepNMdzswcb4Rm7Zi0v7ACvmRszD21mVvWHWpaywE537ASw+OfksQHblarvjCUCT+hb8/OoB6vNLheiCcOa5+N5ToAFz91sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 279E8339;
	Tue, 16 Apr 2024 09:36:09 -0700 (PDT)
Received: from [10.1.39.189] (XHFQ2J9959.cambridge.arm.com [10.1.39.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5C03F792;
	Tue, 16 Apr 2024 09:35:39 -0700 (PDT)
Message-ID: <d833efd7-28fd-42f0-83cd-e29f0f343909@arm.com>
Date: Tue, 16 Apr 2024 17:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-4-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240416033457.32154-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 04:34, Lance Yang wrote:
> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> splitting if the large folio is fully mapped within the target range.
> 
> If a large folio is locked or shared, or if we fail to split it, we just
> leave it in place and advance to the next PTE in the range. But note that
> the behavior is changed; previously, any failure of this sort would cause
> the entire operation to give up. As large folios become more common,
> sticking to the old way could result in wasted opportunities.
> 
> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
> the same size results in the following runtimes for madvise(MADV_FREE) in
> seconds (shorter is better):
> 
> Folio Size |   Old    |   New    | Change
> ------------------------------------------
>       4KiB | 0.590251 | 0.590259 |    0%
>      16KiB | 2.990447 | 0.185655 |  -94%
>      32KiB | 2.547831 | 0.104870 |  -95%
>      64KiB | 2.457796 | 0.052812 |  -97%
>     128KiB | 2.281034 | 0.032777 |  -99%
>     256KiB | 2.230387 | 0.017496 |  -99%
>     512KiB | 2.189106 | 0.010781 |  -99%
>    1024KiB | 2.183949 | 0.007753 |  -99%
>    2048KiB | 0.002799 | 0.002804 |    0%
> 
> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/internal.h |  12 ++++-
>  mm/madvise.c  | 144 ++++++++++++++++++++++++++++----------------------
>  mm/memory.c   |   4 +-
>  3 files changed, 94 insertions(+), 66 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 2adc3f616b71..5d5e49b86fe3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   *		  first one is writable.
>   * @any_young: Optional pointer to indicate whether any entry except the
>   *		  first one is young.
> + * @any_dirty: Optional pointer to indicate whether any entry except the
> + *		  first one is dirty.
>   *
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same large folio.
> @@ -149,18 +151,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> -		bool *any_writable, bool *any_young)
> +		bool *any_writable, bool *any_young, bool *any_dirty)
>  {
>  	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>  	const pte_t *end_ptep = start_ptep + max_nr;
>  	pte_t expected_pte, *ptep;
> -	bool writable, young;
> +	bool writable, young, dirty;
>  	int nr;
>  
>  	if (any_writable)
>  		*any_writable = false;
>  	if (any_young)
>  		*any_young = false;
> +	if (any_dirty)
> +		*any_dirty = false;
>  
>  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>  	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> @@ -176,6 +180,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  			writable = !!pte_write(pte);
>  		if (any_young)
>  			young = !!pte_young(pte);
> +		if (any_dirty)
> +			dirty = !!pte_dirty(pte);
>  		pte = __pte_batch_clear_ignored(pte, flags);
>  
>  		if (!pte_same(pte, expected_pte))
> @@ -193,6 +199,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  			*any_writable |= writable;
>  		if (any_young)
>  			*any_young |= young;
> +		if (any_dirty)
> +			*any_dirty |= dirty;
>  
>  		nr = pte_batch_hint(ptep, pte);
>  		expected_pte = pte_advance_pfn(expected_pte, nr);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index edb592adb749..a6bfbbd881e9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
>  	       file_permission(vma->vm_file, MAY_WRITE) == 0;
>  }
>  
> +static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
> +					  struct folio *folio, pte_t *ptep,
> +					  pte_t pte, bool *any_young,
> +					  bool *any_dirty)
> +{
> +	int max_nr = (end - addr) / PAGE_SIZE;
> +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> +
> +	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
> +			       any_young, any_dirty);
> +}
> +
> +static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t *pmd,
> +					   unsigned long addr,
> +					   struct folio *folio, pte_t **pte,
> +					   spinlock_t **ptl)
> +{
> +	int err;
> +
> +	if (!folio_trylock(folio))
> +		return false;
> +
> +	folio_get(folio);
> +	pte_unmap_unlock(*pte, *ptl);
> +	err = split_folio(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);
> +
> +	*pte = pte_offset_map_lock(mm, pmd, addr, ptl);
> +
> +	return err == 0;
> +}
> +
>  static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
>  				struct mm_walk *walk)
> @@ -456,41 +489,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		 * next pte in the range.
>  		 */
>  		if (folio_test_large(folio)) {
> -			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
> -						FPB_IGNORE_SOFT_DIRTY;
> -			int max_nr = (end - addr) / PAGE_SIZE;
>  			bool any_young;
>  
> -			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
> -					     fpb_flags, NULL, &any_young);
> -			if (any_young)
> -				ptent = pte_mkyoung(ptent);
> +			nr = madvise_folio_pte_batch(addr, end, folio, pte,
> +						     ptent, &any_young, NULL);
>  
>  			if (nr < folio_nr_pages(folio)) {
> -				int err;
> -
>  				if (folio_likely_mapped_shared(folio))
>  					continue;
>  				if (pageout_anon_only_filter && !folio_test_anon(folio))
>  					continue;
> -				if (!folio_trylock(folio))
> -					continue;
> -				folio_get(folio);
> +
>  				arch_leave_lazy_mmu_mode();
> -				pte_unmap_unlock(start_pte, ptl);
> -				start_pte = NULL;
> -				err = split_folio(folio);
> -				folio_unlock(folio);
> -				folio_put(folio);
> -				start_pte = pte =
> -					pte_offset_map_lock(mm, pmd, addr, &ptl);
> +				if (madvise_pte_split_folio(mm, pmd, addr,
> +							    folio, &start_pte, &ptl))
> +					nr = 0;
>  				if (!start_pte)
>  					break;
> +				pte = start_pte;
>  				arch_enter_lazy_mmu_mode();
> -				if (!err)
> -					nr = 0;
>  				continue;
>  			}
> +
> +			if (any_young)
> +				ptent = pte_mkyoung(ptent);
>  		}
>  
>  		/*
> @@ -688,44 +710,51 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			continue;
>  
>  		/*
> -		 * If pmd isn't transhuge but the folio is large and
> -		 * is owned by only this process, split it and
> -		 * deactivate all pages.
> +		 * If we encounter a large folio, only split it if it is not
> +		 * fully mapped within the range we are operating on. Otherwise
> +		 * leave it as is so that it can be marked as lazyfree. If we
> +		 * fail to split a folio, leave it in place and advance to the
> +		 * next pte in the range.
>  		 */
>  		if (folio_test_large(folio)) {
> -			int err;
> +			bool any_young, any_dirty;
>  
> -			if (folio_likely_mapped_shared(folio))
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
> +			nr = madvise_folio_pte_batch(addr, end, folio, pte,
> +						     ptent, &any_young, &any_dirty);
> +
> +			if (nr < folio_nr_pages(folio)) {
> +				if (folio_likely_mapped_shared(folio))
> +					continue;
> +
> +				arch_leave_lazy_mmu_mode();
> +				if (madvise_pte_split_folio(mm, pmd, addr,
> +							    folio, &start_pte, &ptl))
> +					nr = 0;
> +				if (!start_pte)
> +					break;
> +				pte = start_pte;
> +				arch_enter_lazy_mmu_mode();
> +				continue;
> +			}
> +
> +			if (any_young)
> +				ptent = pte_mkyoung(ptent);
> +			if (any_dirty)
> +				ptent = pte_mkdirty(ptent);
>  		}
>  
> +		if (folio_mapcount(folio) != folio_nr_pages(folio))
> +			continue;

Why is this here? I thought we had previously concluded to only do this test
inside the below if statement (where you have it duplicated).

> +
>  		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>  			if (!folio_trylock(folio))
>  				continue;
>  			/*
> -			 * If folio is shared with others, we mustn't clear
> -			 * the folio's dirty flag.
> +			 * If we have a large folio at this point, we know it is
> +			 * fully mapped so if its mapcount is the same as its
> +			 * number of pages, it must be exclusive.
>  			 */
> -			if (folio_mapcount(folio) != 1) {
> +			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
>  				folio_unlock(folio);
>  				continue;
>  			}
> @@ -741,19 +770,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		}
>  
>  		if (pte_young(ptent) || pte_dirty(ptent)) {
> -			/*
> -			 * Some of architecture(ex, PPC) don't update TLB
> -			 * with set_pte_at and tlb_remove_tlb_entry so for
> -			 * the portability, remap the pte with old|clean
> -			 * after pte clearing.
> -			 */
> -			ptent = ptep_get_and_clear_full(mm, addr, pte,
> -							tlb->fullmm);
> -
> -			ptent = pte_mkold(ptent);
> -			ptent = pte_mkclean(ptent);
> -			set_pte_at(mm, addr, pte, ptent);
> -			tlb_remove_tlb_entry(tlb, pte, addr);
> +			clear_young_dirty_ptes(vma, addr, pte, nr,
> +					       CYDP_CLEAR_YOUNG |
> +						       CYDP_CLEAR_DIRTY);
> +			tlb_remove_tlb_entries(tlb, pte, nr, addr);
>  		}
>  		folio_mark_lazyfree(folio);
>  	}
> diff --git a/mm/memory.c b/mm/memory.c
> index 33d87b64d15d..9e07d1b9020c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  			flags |= FPB_IGNORE_SOFT_DIRTY;
>  
>  		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
> -				     &any_writable, NULL);
> +				     &any_writable, NULL, NULL);
>  		folio_ref_add(folio, nr);
>  		if (folio_test_anon(folio)) {
>  			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
> @@ -1558,7 +1558,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
>  	 */
>  	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
>  		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
> -				     NULL, NULL);
> +				     NULL, NULL, NULL);
>  
>  		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
>  				       addr, details, rss, force_flush,


