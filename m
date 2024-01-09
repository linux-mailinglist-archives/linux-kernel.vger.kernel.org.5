Return-Path: <linux-kernel+bounces-20246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7492827C61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A94228547E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADE10E2;
	Tue,  9 Jan 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2iUp0lw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF0A41
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704762662; x=1736298662;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EvwXiRnbFEjCkclnoZp2pYvmciSarjgraPw+NcDeueE=;
  b=W2iUp0lwRA46q1da/s0yYLN1DIk6n6IJgaAvQeeanSMxel7tuiunVuAV
   lXWvGW266BhSLvLMJzdfSYY3wnGw8mAAMSJMABExKJWtkic7xlWe9V6Tq
   KGhW6f0imsnayZaeYUvg6XLhzp2BwRZOzNxFfZH2+/ZAorqeXMk6spzN9
   bBix1nPukLU5CnygmwbFxQRKOcz0enqGBQVDgTgqnU5HtPclWacPdLopD
   ya27jo+B4AynNye1/HeuAg5z23Y5G9C7fkbnBMo/+5xO7JnA5j4c06PCd
   Hk/s82bojHtwg5Grtr0J5sR58JFKTFjPOpmtVozcWPIJcAv8SGXpGuMYa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5396021"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5396021"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="815785098"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="815785098"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:10:57 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without
 vmfault
In-Reply-To: <20240102175338.62012-9-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:37 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-9-ryncsn@gmail.com>
Date: Tue, 09 Jan 2024 09:08:59 +0800
Message-ID: <875y039utw.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> There are two places where swapin is not caused by direct anon page fault:
> - shmem swapin, invoked indirectly through shmem mapping
> - swapoff
>
> They used to construct a pseudo vmfault struct for swapin function.
> Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
> ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
> path is still using one.
>
> Introduce a helper for them both, this help save stack usage for swapoff
> path, and help apply a unified swapin cache and readahead policy check.
>
> Due to missing vmfault info, the caller have to pass in mempolicy
> explicitly, make it different from swapin_entry and name it
> swapin_entry_mpol.
>
> This commit convert swapoff to use this helper, follow-up commits will
> convert shmem to use it too.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h       |  9 +++++++++
>  mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
>  mm/swapfile.c   | 15 ++++++---------
>  3 files changed, 47 insertions(+), 17 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 9180411afcfe..8f790a67b948 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>  		struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
>  			    struct vm_fault *vmf, enum swap_cache_result *result);
> +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
> +				struct mempolicy *mpol, pgoff_t ilx,
> +				enum swap_cache_result *result);
>  
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
>  	return NULL;
>  }
>  
> +static inline struct page *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
> +		struct mempolicy *mpol, pgoff_t ilx, enum swap_cache_result *result)
> +{
> +	return NULL;
> +}
> +
>  static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>  {
>  	return 0;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 21badd4f0fc7..3edf4b63158d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>   * in.
>   */
>  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> -				  struct vm_fault *vmf, void *shadow)
> +				   struct mempolicy *mpol, pgoff_t ilx,
> +				   void *shadow)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio;
>  
> -	/* skip swapcache */
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> -				vma, vmf->address, false);
> +	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0,
> +			mpol, ilx, numa_node_id());
>  	if (folio) {
>  		if (mem_cgroup_swapin_charge_folio(folio, NULL,
>  						   GFP_KERNEL, entry)) {
> @@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
>  		goto done;
>  	}
>  
> +	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>  	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> -		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
> +		folio = swapin_direct(entry, gfp_mask, mpol, ilx, shadow);
>  		cache_result = SWAP_CACHE_BYPASS;
>  	} else {
> -		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>  		if (swap_use_vma_readahead())
>  			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
>  		else
>  			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> -		mpol_cond_put(mpol);
>  		cache_result = SWAP_CACHE_MISS;
>  	}
> +	mpol_cond_put(mpol);
>  done:
>  	if (result)
>  		*result = cache_result;
> @@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
>  	return folio;
>  }
>  
> +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
> +				struct mempolicy *mpol, pgoff_t ilx,
> +				enum swap_cache_result *result)
> +{
> +	enum swap_cache_result cache_result;
> +	void *shadow = NULL;
> +	struct folio *folio;
> +
> +	folio = swap_cache_get_folio(entry, NULL, 0, &shadow);
> +	if (folio) {
> +		cache_result = SWAP_CACHE_HIT;
> +	} else if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> +		folio = swapin_direct(entry, gfp_mask, mpol, ilx, shadow);
> +		cache_result = SWAP_CACHE_BYPASS;
> +	} else {
> +		folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> +		cache_result = SWAP_CACHE_MISS;
> +	}
> +
> +	if (result)
> +		*result = cache_result;
> +
> +	return folio;
> +}
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
>  				     struct kobj_attribute *attr, char *buf)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5aa44de11edc..2f77bf143af8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  	do {
>  		struct folio *folio;
>  		unsigned long offset;
> +		struct mempolicy *mpol;
>  		unsigned char swp_count;
>  		swp_entry_t entry;
> +		pgoff_t ilx;
>  		int ret;
>  		pte_t ptent;
>  
> -		struct vm_fault vmf = {
> -			.vma = vma,
> -			.address = addr,
> -			.real_address = addr,
> -			.pmd = pmd,
> -		};
> -
>  		if (!pte++) {
>  			pte = pte_offset_map(pmd, addr);
>  			if (!pte)
> @@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		pte_unmap(pte);
>  		pte = NULL;
>  
> -		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> -				     &vmf, NULL);
> +		mpol = get_vma_policy(vma, addr, 0, &ilx);
> +		folio = swapin_entry_mpol(entry, GFP_HIGHUSER_MOVABLE,
> +					  mpol, ilx, NULL);
> +		mpol_cond_put(mpol);
>  		if (!folio) {
>  			/*
>  			 * The entry could have been freed, and will not

IIUC, after the change, we will always use cluster readahead for
swapoff.  This may be OK.  But, at least we need some test results which
show that this will not cause any issue for this behavior change.  And
the behavior change should be described explicitly in patch description.

And I don't think it's a good abstraction to make swapin_entry_mpol()
always use cluster swapin, while swapin_entry() will try to use vma
swapin.  I think we can add "struct mempolicy *mpol" and "pgoff_t ilx"
to swapin_entry() as parameters, and use them if vmf == NULL.  If we
want to enforce cluster swapin in swapoff path, it will be better to add
some comments to describe why.

--
Best Regards,
Huang, Ying

