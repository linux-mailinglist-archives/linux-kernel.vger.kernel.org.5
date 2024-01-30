Return-Path: <linux-kernel+bounces-43995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CE841BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB211C21F56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192ED381C7;
	Tue, 30 Jan 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAWyc6oC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF51172C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596264; cv=none; b=D/EZQdjHedj4gxCcdjaXenKai+VjfOn+usZvAkqX0qjyH96MxRImAJBNDZL8chrsWpwlYo9vxREQpw+gVfU3slO41yu3d67LxSVW0SluA7LQcsE123coxtZ5aTgOy3JJ4dEfO4vf4fhKyZPlCsFgoT/x+rt3NLxYoRletZ12McI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596264; c=relaxed/simple;
	bh=uwEkKH2wJSHeUP8JhuJ79HOvJUStRfChWk3uYCaa9Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTR9XyQpaoDbotig8WqgcyNTPYgorImMvk7Sbu0qXeKtlskYOR18ASvs8rBIxxQy57HQxDNmqCjpodFLm69PAy4WXmCgV5keZ+Qm1P7Ou4RjSU6V4coPFLYjGC099cOxQ2EYCmG8kxhHCfnyCqTXy5KNr/aLyU6FvEw1VD3Otls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAWyc6oC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706596261; x=1738132261;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uwEkKH2wJSHeUP8JhuJ79HOvJUStRfChWk3uYCaa9Fc=;
  b=BAWyc6oCp/4uXoHrYhZ5LURDVZzmwg5IZ6WsPnlcbKExDJmVivBg7l+S
   43LmUC2CnPWW+nWsYbXTtOTaUU5gX+v/iT4q8WkNLW11iTFVxhi281d6j
   cF6uGv++HEBodwcV27286g1lu37KbMueMcCXJS1lO21b7kyOuMCyrtkRg
   EpQiqC/tLw1odCix6+fCLlc+WqHC3M3vWocr73CIzvm19mHCgNXsW2h2R
   a2khJVDA2kvaBPnnZ2ucybBsHFp5cvc16m44u6GJPeeFM9f+ixtlI7g8u
   aBYJG4Mj+FmFcZokQFW5C/nn8LDMBloJsCrOp8mp/X+XngPuEoBbjZjW2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16716558"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16716558"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="911336949"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="911336949"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:30:56 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] mm/swap: introduce swapin_entry for unified
 readahead policy
In-Reply-To: <20240129175423.1987-5-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Jan 2024 01:54:19 +0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-5-ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 14:29:00 +0800
Message-ID: <87o7d3gwr7.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> Introduce swapin_entry which merges swapin_readahead and swapin_direct
> making it the main entry for swapin pages, and use a unified swapin
> readahead policy.
>
> This commit makes swapoff make use of this new helper and skip readahead
> for SYNCHRONOUS_IO device since it's not helpful here. Now swapping
> off a 10G ZRAM (lzo-rle) after same workload is faster since readahead
> is skipped and overhead is reduced.
>
> Before:
> time swapoff /dev/zram0
> real    0m12.337s
> user    0m0.001s
> sys     0m12.329s
>
> After:
> time swapoff /dev/zram0
> real    0m9.728s
> user    0m0.001s
> sys     0m9.719s
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 18 +++---------------
>  mm/swap.h       | 16 ++++------------
>  mm/swap_state.c | 40 ++++++++++++++++++++++++----------------
>  mm/swapfile.c   |  7 ++-----
>  4 files changed, 33 insertions(+), 48 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 81dc9d467f4e..8711f8a07039 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3864,20 +3864,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	swapcache = folio;
>  
>  	if (!folio) {
> -		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> -		    __swap_count(entry) == 1) {
> -			/* skip swapcache and readahead */
> -			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -			if (folio)
> -				page = &folio->page;
> -		} else {
> -			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -						vmf);
> -			if (page)
> -				folio = page_folio(page);
> -			swapcache = folio;
> -		}
> -
> +		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> +				     vmf, &swapcache);
>  		if (!folio) {
>  			/*
>  			 * Back out if somebody else faulted in this pte
> @@ -3890,11 +3878,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				ret = VM_FAULT_OOM;
>  			goto unlock;
>  		}
> -

Change by accident?

>  		/* Had to read the page from swap area: Major fault */
>  		ret = VM_FAULT_MAJOR;
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> +		page = folio_file_page(folio, swp_offset(entry));

Better to move this line just after checking !folio.  This make it a
little easier to associate page to folio.

>  	} else if (PageHWPoison(page)) {
>  		/*
>  		 * hwpoisoned dirty swapcache pages are kept for killing
> diff --git a/mm/swap.h b/mm/swap.h
> index 83eab7b67e77..8f8185d3865c 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -54,10 +54,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
>  		bool skip_if_exists);
>  struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
> -struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> -			      struct vm_fault *vmf);
> -struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> -			    struct vm_fault *vmf);
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
> +			   struct vm_fault *vmf, struct folio **swapcached);
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -88,14 +86,8 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
>  	return NULL;
>  }
>  
> -struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> -			struct vm_fault *vmf)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
> -			struct vm_fault *vmf)
> +static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
> +			struct vm_fault *vmf, struct folio **swapcached)
>  {
>  	return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a450d09fc0db..5e06b2e140d4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -870,8 +870,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>   * Returns the struct folio for entry and addr after the swap entry is read
>   * in.
>   */
> -struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> -			    struct vm_fault *vmf)
> +static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> +				  struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio;
> @@ -908,33 +908,41 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  }
>  
>  /**
> - * swapin_readahead - swap in pages in hope we need them soon
> + * swapin_entry - swap in a folio from swap entry
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
> + * @swapcache: set to the swapcache folio if swapcache is used
>   *
>   * Returns the struct page for entry and addr, after queueing swapin.
>   *
> - * It's a main entry function for swap readahead. By the configuration,
> + * It's the main entry function for swap in. By the configuration,
>   * it will read ahead blocks by cluster-based(ie, physical disk based)
> - * or vma-based(ie, virtual address based on faulty address) readahead.
> + * or vma-based(ie, virtual address based on faulty address) readahead,
> + * or skip the readahead(ie, ramdisk based swap device).
>   */
> -struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -				struct vm_fault *vmf)
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
> +			   struct vm_fault *vmf, struct folio **swapcache)
>  {
>  	struct mempolicy *mpol;
> -	pgoff_t ilx;
>  	struct folio *folio;
> +	pgoff_t ilx;

ditto.

Otherwise, looks good to me.  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  
> -	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -	folio = swap_use_vma_readahead() ?
> -		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
> -		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> -	mpol_cond_put(mpol);
> +	if (data_race(swp_swap_info(entry)->flags & SWP_SYNCHRONOUS_IO) &&
> +	    __swap_count(entry) == 1) {
> +		folio = swapin_direct(entry, gfp_mask, vmf);
> +	} else {
> +		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> +		if (swap_use_vma_readahead())
> +			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
> +		else
> +			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> +		mpol_cond_put(mpol);
> +		if (swapcache)
> +			*swapcache = folio;
> +	}
>  
> -	if (!folio)
> -		return NULL;
> -	return folio_file_page(folio, swp_offset(entry));
> +	return folio;
>  }
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 606d95b56304..1cf7e72e19e3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1867,7 +1867,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  		folio = swap_cache_get_folio(entry, vma, addr);
>  		if (!folio) {
> -			struct page *page;
>  			struct vm_fault vmf = {
>  				.vma = vma,
>  				.address = addr,
> @@ -1875,10 +1874,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				.pmd = pmd,
>  			};
>  
> -			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -						&vmf);
> -			if (page)
> -				folio = page_folio(page);
> +			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> +					    &vmf, NULL);
>  		}
>  		if (!folio) {
>  			/*

