Return-Path: <linux-kernel+bounces-43954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8DF841B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88DAB236DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0E381B0;
	Tue, 30 Jan 2024 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5ggNoNw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75F1EA95
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593210; cv=none; b=Km/jDMWoX1mYu8ZjmwsKiEVBFmW2z+gT49u7cObmAs945qXILl3r92gmIBYO+p7fCyOGcfmz1MeB1IZCHIZXjlQHlJXOs2/0F7Aiy8ZH6c91MBlzJP6+S6skL1LGoNDcZzlXRJELaulBVe6evE74vFoJRCyrjHLLT4W9xjDva9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593210; c=relaxed/simple;
	bh=raXv4XJU6Keo6Id4IdBdWVCma99ORpdHFZIYcKh33o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLTB/WCItau2CCCq1ANXZdq1a/YlXyyVwv/0F+YXe13vMmA+luKfdJMAgthMq8TvLsQin23fWpoPovV66+HLmQsmkp63q9hF5edVRqHfVLYz3bIYzfykUMTf4ZWcLykKzEIWTP+0idA5J17enP2rOGSfioAuSK1WmTJCjzlIhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5ggNoNw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706593208; x=1738129208;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=raXv4XJU6Keo6Id4IdBdWVCma99ORpdHFZIYcKh33o8=;
  b=I5ggNoNwlDGlNJ3Rh6s4AKvCtqQlFqbHBJt2h/h4m8MVrkm5rEGbx6Zn
   yH9159+CB1DYgmQr/NjeGDwzrjPRpvS87zxIDpEDcCJclyyXhOLgg64qu
   UnHUx/ZBua9ppSqQuAz2XaNAiDwoLgAqswEP/uU98Oh8nldS6jqUgJqKS
   kKu0qEg5MWgkaS8iFairlVykmDE3hkfktSkFEIw1gNYxVvGbO5zGeCkJz
   2w+EYUcynKHDLQH998RiT7zurozmOhTL2AtpZntL/6Grn1m6EPP0wUgJ4
   tzQ0lEJx0VfCyF5wRA8XPPpMMkvYMtXY1kQyBGV7Df5hHTlyjQABbdnsM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3034756"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3034756"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="22327568"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:40:03 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mm/swap: move no readahead swapin code to a
 stand-alone helper
In-Reply-To: <20240129175423.1987-3-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Jan 2024 01:54:17 +0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-3-ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 13:38:07 +0800
Message-ID: <87wmrrgz40.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

The error processing for mem_cgroup_swapin_charge_folio() failure is
changed a little.  That looks OK for me.  But you need to make it
explicit in change log.  Especially, it's not "no feature change"
strictly.

--
Best Regards,
Huang, Ying

> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 32 ++++----------------------------
>  mm/swap.h       |  8 ++++++++
>  mm/swap_state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 28 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..81dc9d467f4e 100644
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
> index e671266ad772..645f5bcad123 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -861,6 +861,53 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  	return folio;
>  }
>  
> +/**
> + * swapin_direct - swap in a folio skipping swap cache and readahead
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
> +	folio = vma_alloc_folio(gfp_mask, 0,
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

