Return-Path: <linux-kernel+bounces-44012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1C841C32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F52F1F25AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD14EB41;
	Tue, 30 Jan 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtP8ph31"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271545015
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597630; cv=none; b=SGTRdNNDt36Quze85JufA25jq6mZ6295z2aPG6mK5qobY1NF2yP56OsuYVEWWIQ7epH/o6D1Sxid9IJ1NBix3gUFJko2Xrkq6uGrSvjceAxNh8GYlmZeauYhxAwwcZu7u7nC9is8BI+uoqaKKqS3AgnL254qsX6ORoD670FDVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597630; c=relaxed/simple;
	bh=XuL5FUOw/lRKWw3rpv80uzch5cxyVqNAA8Vqzs9upeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=beQ4M5DBttXDEYRXzT5esed1f9H/ph3a23IKJ/Erhb/UllF2/VaZd1yph3ajPwCW1jsLVILPl/jhZ5MJFmFRKIi6Du+6fZ4ngfdqEwNanU0uurcobKNmyIYHkCoL50RWUsdjKPvbeX0bGWxpL9e28Loa3/C/DEv3B0yQPqc5VcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtP8ph31; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706597629; x=1738133629;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XuL5FUOw/lRKWw3rpv80uzch5cxyVqNAA8Vqzs9upeg=;
  b=ZtP8ph31cIxsQzGwkl7t6KRhQXLU1PbSrCIuBZGx4l/FLEQZtFxgLh6m
   yPI84LGnSYlkgY4+pTurrIODAHNH8wKjwBJ1wmma23VUoQyhd0ftLVGUI
   i7MIXfNc7+0Y1Zu9l8uI47uIA+p1P2v56+2sjH4Y3+LI5qQm7SKHQea5a
   ZZygwZyk/4ZDzW6D4OE3i/7vbvRoe6UFrt3RgRmiCssTb+KrQq1aEDsao
   aCf6ZGrn+rFeYmQ/ZTIKY+JVDwoIPoseeo18417iJiLgCc317aS5nogAK
   BMIFuDDKagmYJ4qNIm8Ycn4M76d1goLOIPnvMluguwLEIpUBDOoy3WJgP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10573029"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10573029"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3645352"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:53:45 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mm/swap: avoid a duplicated swap cache lookup
 for SWP_SYNCHRONOUS_IO
In-Reply-To: <20240129175423.1987-6-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Jan 2024 01:54:20 +0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-6-ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 14:51:48 +0800
Message-ID: <87jznrgvp7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> When a xa_value is returned by the cache lookup, keep it to be used
> later for workingset refault check instead of doing the looking up again
> in swapin_no_readahead.
>
> Shadow look up and workingset check is skipped for swapoff to reduce
> overhead, workingset checking for anon pages upon swapoff is not
> helpful, simply consider all pages as inactive make more sense since
> swapoff doesn't mean pages is being accessed.
>
> After this commit, swappin is about 4% faster for ZRAM, micro benchmark
> result which use madvise to swap out 10G zero-filled data to ZRAM then
> read them in:
>
> Before: 11143285 us
> After:  10692644 us (+4.1%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/memory.c     |  5 +++--
>  mm/shmem.c      |  2 +-
>  mm/swap.h       | 11 ++++++-----
>  mm/swap_state.c | 23 +++++++++++++----------
>  mm/swapfile.c   |  4 ++--
>  5 files changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 8711f8a07039..349946899f8d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3800,6 +3800,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	struct swap_info_struct *si = NULL;
>  	rmap_t rmap_flags = RMAP_NONE;
>  	bool exclusive = false;
> +	void *shadow = NULL;
>  	swp_entry_t entry;
>  	pte_t pte;
>  	vm_fault_t ret = 0;
> @@ -3858,14 +3859,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (unlikely(!si))
>  		goto out;
>  
> -	folio = swap_cache_get_folio(entry, vma, vmf->address);
> +	folio = swap_cache_get_folio(entry, vma, vmf->address, &shadow);
>  	if (folio)
>  		page = folio_file_page(folio, swp_offset(entry));
>  	swapcache = folio;
>  
>  	if (!folio) {
>  		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> -				     vmf, &swapcache);
> +				     vmf, &swapcache, shadow);
>  		if (!folio) {
>  			/*
>  			 * Back out if somebody else faulted in this pte
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d7c84ff62186..698a31bf7baa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1873,7 +1873,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	}
>  
>  	/* Look it up and read it in.. */
> -	folio = swap_cache_get_folio(swap, NULL, 0);
> +	folio = swap_cache_get_folio(swap, NULL, 0, NULL);
>  	if (!folio) {
>  		/* Or update major stats only when swapin succeeds?? */
>  		if (fault_type) {
> diff --git a/mm/swap.h b/mm/swap.h
> index 8f8185d3865c..ca9cb472a263 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -42,7 +42,8 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				  unsigned long end);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr);
> +		struct vm_area_struct *vma, unsigned long addr,
> +		void **shadowp);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>  		pgoff_t index);
>  
> @@ -54,8 +55,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
>  		bool skip_if_exists);
>  struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
> -struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
> -			   struct vm_fault *vmf, struct folio **swapcached);
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t flag, struct vm_fault *vmf,
> +		struct folio **swapcached, void *shadow);
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -87,7 +88,7 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
>  }
>  
>  static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
> -			struct vm_fault *vmf, struct folio **swapcached)
> +			struct vm_fault *vmf, struct folio **swapcached, void *shadow)
>  {
>  	return NULL;
>  }
> @@ -98,7 +99,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>  }
>  
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr)
> +		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
>  {
>  	return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 5e06b2e140d4..e41a137a6123 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -330,12 +330,18 @@ static inline bool swap_use_vma_readahead(void)
>   * Caller must lock the swap device or hold a reference to keep it valid.
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr)
> +		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
>  {
>  	struct folio *folio;
>  
> -	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
> -	if (!IS_ERR(folio)) {
> +	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
> +	if (xa_is_value(folio)) {
> +		if (shadowp)
> +			*shadowp = folio;
> +		return NULL;
> +	}
> +
> +	if (folio) {
>  		bool vma_ra = swap_use_vma_readahead();
>  		bool readahead;
>  
> @@ -365,8 +371,6 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
>  			if (!vma || !vma_ra)
>  				atomic_inc(&swapin_readahead_hits);
>  		}
> -	} else {
> -		folio = NULL;
>  	}
>  
>  	return folio;
> @@ -866,16 +870,16 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
> + * @shadow: workingset shadow corresponding to entry
>   *
>   * Returns the struct folio for entry and addr after the swap entry is read
>   * in.
>   */
>  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> -				  struct vm_fault *vmf)
> +				  struct vm_fault *vmf, void *shadow)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio;
> -	void *shadow = NULL;
>  
>  	/* skip swapcache */
>  	folio = vma_alloc_folio(gfp_mask, 0,
> @@ -892,7 +896,6 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  		}
>  		mem_cgroup_swapin_uncharge_swap(entry);
>  
> -		shadow = get_shadow_from_swap_cache(entry);
>  		if (shadow)
>  			workingset_refault(folio, shadow);
>  
> @@ -922,7 +925,7 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>   * or skip the readahead(ie, ramdisk based swap device).
>   */
>  struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
> -			   struct vm_fault *vmf, struct folio **swapcache)
> +			   struct vm_fault *vmf, struct folio **swapcache, void *shadow)
>  {
>  	struct mempolicy *mpol;
>  	struct folio *folio;
> @@ -930,7 +933,7 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
>  
>  	if (data_race(swp_swap_info(entry)->flags & SWP_SYNCHRONOUS_IO) &&
>  	    __swap_count(entry) == 1) {
> -		folio = swapin_direct(entry, gfp_mask, vmf);
> +		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
>  	} else {
>  		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>  		if (swap_use_vma_readahead())
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1cf7e72e19e3..aac26f5a6cec 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1865,7 +1865,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		pte_unmap(pte);
>  		pte = NULL;
>  
> -		folio = swap_cache_get_folio(entry, vma, addr);
> +		folio = swap_cache_get_folio(entry, vma, addr, NULL);
>  		if (!folio) {
>  			struct vm_fault vmf = {
>  				.vma = vma,
> @@ -1875,7 +1875,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			};
>  
>  			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> -					    &vmf, NULL);
> +					    &vmf, NULL, NULL);
>  		}
>  		if (!folio) {
>  			/*

