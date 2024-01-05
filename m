Return-Path: <linux-kernel+bounces-17547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84FC824F31
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D0E1F2184D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BE2031C;
	Fri,  5 Jan 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7Eu+jEE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B220310
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704439820; x=1735975820;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=miZsVC0cwSQ3wmtUqCj/8APGGPCSDLSbzew/wWh9PYo=;
  b=G7Eu+jEECvaSdoeFsGV5ofHpXpxALbrtwkvagpSe3wnye9hFzlG85mp7
   F7Z/DiRVAfehidPinKq6F/Pcp+utArKobmqmabvJ3tI/ljrzKPwpLwCKy
   Try1uMXo3gK05I7qM2ygnoIVYdFhFVeaN1TmSAaQbcNOfB2M/IU40fn59
   hiwK8uZnlE1TRlQ+Gj+gPoEeTCw1G3cJjJ7RsD4CM01DxcjMwSv2JtqPb
   LYMTYzfPAsuB/tV+uZv7oUnsCphisjIRwBbN8c98ui7oQIf4h4wKYss5B
   HBQQ9bX3kVVPxYtMLbU01f+JoG07KXkefL7C4G0VCZ7XTnEYsN10bt2tl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387901245"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="387901245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:30:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="29060591"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:30:16 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] mm/swap: introduce swapin_entry for unified
 readahead policy
In-Reply-To: <20240102175338.62012-6-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:34 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-6-ryncsn@gmail.com>
Date: Fri, 05 Jan 2024 15:28:18 +0800
Message-ID: <8734vcb5nx.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> policy.
>
> This commit makes swapoff make use of this new helper and now swapping
> off a 10G ZRAM (lzo-rle) is faster since readahead is skipped.
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
>  mm/memory.c     | 21 +++++++--------------
>  mm/swap.h       | 16 ++++------------
>  mm/swap_state.c | 49 +++++++++++++++++++++++++++++++++----------------
>  mm/swapfile.c   |  7 ++-----
>  4 files changed, 46 insertions(+), 47 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 0165c8cad489..b56254a875f8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3801,6 +3801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	rmap_t rmap_flags = RMAP_NONE;
>  	bool exclusive = false;
>  	swp_entry_t entry;
> +	bool swapcached;
>  	pte_t pte;
>  	vm_fault_t ret = 0;
>  
> @@ -3864,21 +3865,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	swapcache = folio;
>  
>  	if (!folio) {
> -		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> -		    __swap_count(entry) == 1) {
> -			/* skip swapcache and readahead */
> -			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -			if (folio)
> -				page = &folio->page;
> +		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> +				     vmf, &swapcached);
> +		if (folio) {
> +			page = folio_file_page(folio, swp_offset(entry));
> +			if (swapcached)
> +				swapcache = folio;
>  		} else {
> -			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -						vmf);
> -			if (page)
> -				folio = page_folio(page);
> -			swapcache = folio;
> -		}
> -
> -		if (!folio) {
>  			/*
>  			 * Back out if somebody else faulted in this pte
>  			 * while we released the pte lock.
> diff --git a/mm/swap.h b/mm/swap.h
> index 83eab7b67e77..502a2801f817 100644
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
> +			    struct vm_fault *vmf, bool *swapcached);
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
> +			struct vm_fault *vmf, bool *swapcached)
>  {
>  	return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d39c5369da21..66ff187aa5d3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
>  	release_pages(pages, nr);
>  }
>  
> +static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
> +}
> +

It appears that there's only one caller of the function in the same
file?  Why add a function?

>  static inline bool swap_use_vma_readahead(void)
>  {
>  	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
> @@ -870,8 +875,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
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
> @@ -908,33 +913,45 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  }
>  
>  /**
> - * swapin_readahead - swap in pages in hope we need them soon
> + * swapin_entry - swap in a page from swap entry
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
> + * @swapcached: pointer to a bool used as indicator if the
> + *              page is swapped in through swapcache.
>   *
>   * Returns the struct page for entry and addr, after queueing swapin.
>   *
> - * It's a main entry function for swap readahead. By the configuration,
> + * It's a main entry function for swap in. By the configuration,
>   * it will read ahead blocks by cluster-based(ie, physical disk based)
> - * or vma-based(ie, virtual address based on faulty address) readahead.
> + * or vma-based(ie, virtual address based on faulty address) readahead,
> + * or skip the readahead (ie, ramdisk based swap device).
>   */
> -struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -				struct vm_fault *vmf)
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
> +			   struct vm_fault *vmf, bool *swapcached)

May be better to use

struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
			   struct vm_fault *vmf, struct folio **swapcache)

In this way, we can reduce the number of source lines in the caller.

>  {
>  	struct mempolicy *mpol;
> -	pgoff_t ilx;
>  	struct folio *folio;
> +	pgoff_t ilx;
> +	bool cached;
>  
> -	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -	folio = swap_use_vma_readahead() ?
> -		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
> -		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> -	mpol_cond_put(mpol);
> +	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> +		folio = swapin_direct(entry, gfp_mask, vmf);
> +		cached = false;
> +	} else {
> +		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> +		if (swap_use_vma_readahead())
> +			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
> +		else
> +			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> +		mpol_cond_put(mpol);
> +		cached = true;
> +	}
>  
> -	if (!folio)
> -		return NULL;
> -	return folio_file_page(folio, swp_offset(entry));
> +	if (swapcached)
> +		*swapcached = cached;
> +
> +	return folio;
>  }
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f7271504aa0a..ce4e6c10dce7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1866,7 +1866,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  		folio = swap_cache_get_folio(entry, vma, addr);
>  		if (!folio) {
> -			struct page *page;
>  			struct vm_fault vmf = {
>  				.vma = vma,
>  				.address = addr,
> @@ -1874,10 +1873,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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

--
Best Regards,
Huang, Ying

