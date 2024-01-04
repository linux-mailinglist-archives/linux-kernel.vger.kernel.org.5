Return-Path: <linux-kernel+bounces-16320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52440823CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C210BB24783
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DAE1F60B;
	Thu,  4 Jan 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gq9zD5ub"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E761EB2F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704353459; x=1735889459;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YAurfh1u9UA6dC9cxd/WLeeXF+n9LButmbp0O/VSSX4=;
  b=gq9zD5ubzpAQ3Anvv7bnG/Aw1ZZDLlUNNf0UxDHyP102LAA9JOc2pceJ
   oqJJdng91RkjpA+C/bvdI7LdgM24F7bWyyd0/yoMeEBDd2VGgTOkDfBp+
   QMxCgi6VuBU3lIsWrwE0j7rNYeOxf7H9Fj771dDa+UqSshV+TjPklahUS
   1cZ84L7IstC5gYmscXMNz0k6rE/JjwkLeHxz7pYUQSaoB6A5UuqPIVofM
   CT3xwB5vujP+jKRKLnM5YcBm+WbZwE35Zdwtjp5GCO3a7yN1QTtOcv0XR
   imUCTzrm8qhkFk4ArPCv9XWVgKdHDw2mENF6/7fK9W84W6UQsE01+900S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387613716"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="387613716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 23:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="923820628"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="923820628"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 23:30:54 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mm/swap: move no readahead swapin code to a
 stand-alone helper
In-Reply-To: <20240102175338.62012-3-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:31 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-3-ryncsn@gmail.com>
Date: Thu, 04 Jan 2024 15:28:57 +0800
Message-ID: <87plyhblqe.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> No feature change, simply move the routine to a standalone function to
> be re-used later. The error path handling is copied from the "out_page"
> label, to make the code change minimized for easier reviewing.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 32 ++++----------------------------
>  mm/swap.h       |  8 ++++++++
>  mm/swap_state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 28 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index a0a50d3754f0..0165c8cad489 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3803,7 +3803,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	swp_entry_t entry;
>  	pte_t pte;
>  	vm_fault_t ret = 0;
> -	void *shadow = NULL;
>  
>  	if (!pte_unmap_same(vmf))
>  		goto out;
> @@ -3867,33 +3866,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> -			/* skip swapcache */
> -			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> -						vma, vmf->address, false);
> -			page = &folio->page;
> -			if (folio) {
> -				__folio_set_locked(folio);
> -				__folio_set_swapbacked(folio);
> -
> -				if (mem_cgroup_swapin_charge_folio(folio,
> -							vma->vm_mm, GFP_KERNEL,
> -							entry)) {
> -					ret = VM_FAULT_OOM;
> -					goto out_page;
> -				}
> -				mem_cgroup_swapin_uncharge_swap(entry);
> -
> -				shadow = get_shadow_from_swap_cache(entry);
> -				if (shadow)
> -					workingset_refault(folio, shadow);
> -
> -				folio_add_lru(folio);
> -
> -				/* To provide entry to swap_read_folio() */
> -				folio->swap = entry;
> -				swap_read_folio(folio, true, NULL);
> -				folio->private = NULL;
> -			}
> +			/* skip swapcache and readahead */
> +			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
> +			if (folio)
> +				page = &folio->page;
>  		} else {
>  			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>  						vmf);
> diff --git a/mm/swap.h b/mm/swap.h
> index 758c46ca671e..83eab7b67e77 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -56,6 +56,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
>  			      struct vm_fault *vmf);
> +struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> +			    struct vm_fault *vmf);
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -86,6 +88,12 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
>  	return NULL;
>  }
>  
> +struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> +			struct vm_fault *vmf)
> +{
> +	return NULL;
> +}
> +
>  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
>  			struct vm_fault *vmf)
>  {
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index e671266ad772..24cb93ed5081 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -861,6 +861,53 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  	return folio;
>  }
>  
> +/**
> + * swapin_direct - swap in folios skipping swap cache and readahead

swap in a folio ...

> + * @entry: swap entry of this memory
> + * @gfp_mask: memory allocation flags
> + * @vmf: fault information
> + *
> + * Returns the struct folio for entry and addr after the swap entry is read
> + * in.
> + */
> +struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> +			    struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct folio *folio;
> +	void *shadow = NULL;
> +
> +	/* skip swapcache */
> +	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,

You passed gfp_mask in, but don't use it.

> +				vma, vmf->address, false);
> +	if (folio) {
> +		__folio_set_locked(folio);
> +		__folio_set_swapbacked(folio);
> +
> +		if (mem_cgroup_swapin_charge_folio(folio,
> +					vma->vm_mm, GFP_KERNEL,
> +					entry)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return NULL;
> +		}
> +		mem_cgroup_swapin_uncharge_swap(entry);
> +
> +		shadow = get_shadow_from_swap_cache(entry);
> +		if (shadow)
> +			workingset_refault(folio, shadow);
> +
> +		folio_add_lru(folio);
> +
> +		/* To provide entry to swap_read_folio() */
> +		folio->swap = entry;
> +		swap_read_folio(folio, true, NULL);
> +		folio->private = NULL;
> +	}
> +
> +	return folio;
> +}
> +
>  /**
>   * swapin_readahead - swap in pages in hope we need them soon
>   * @entry: swap entry of this memory

--
Best Regards,
Huang, Ying

