Return-Path: <linux-kernel+bounces-43975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE26841BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE9D1F283A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39838DE5;
	Tue, 30 Jan 2024 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7SEU3xm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC138DE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595293; cv=none; b=R685Sr7CeH6dmS8TtVlo5QmUIbo0xP8rA51jlLeL053Ng03h5n4lcpliQvG+81miyy3MlMWIxzLl1KlUjcx7EU8CPs3uH/cxjmDwISCEkycezBTikpUHPpP7f7sDjiPtjMVyEPsVkPtfPRUdVpWgiUVYFJCciIzySIghMtTdA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595293; c=relaxed/simple;
	bh=6tMx4zes44BHB3RxXD/liTKY4G8BQEwt5jh/+9tg+Sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aotZfD9ZTugLzYgeT5LwlxCalv/DIysqs8rCi1FjmIb0KClHy2+qkK4StuRFtz+Z4CLvQUQWJhmgt6uQ0hzN7S8z6vBfkjHFe3oEKtvTaHoVWgcutGAPUlHrP3Y4djhpcJtBwJh4RDbJ6moZWpUDv7R+UB0HYIOVY19OyQRQzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7SEU3xm; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706595290; x=1738131290;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6tMx4zes44BHB3RxXD/liTKY4G8BQEwt5jh/+9tg+Sc=;
  b=m7SEU3xmfWofRq+D4pP3kFkIugoJioNWWCvUeDzvEzLPtwjcfU7MmdDj
   tQAQ653pHCm2gF3/8CC1BG69dhOmgSocYugbz/z1L2ezSVNFbi0eA4s7U
   i23fwxwTCdHUr5y43ZrvxCNCrs57j2Cilh9L6KwfFvdylsj2eTUH8p4T1
   T33DQUbG9mhQTySikiSa10pey6bm+3FcfupBmZgoSccTy4XalbzkL4LPm
   DB+aFW6D3UpibzAgq9mF0vELFxqg/Sn2n5vpSgIFC2+Ib6+5+XgK8UtHt
   twXg2bvhi33dbyXGoDBIjTeDj2z9WMTFOtuWqAvVg8PEyvKuJaOjwdDug
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393613454"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="393613454"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3565532"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:14:47 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] mm/swap: always account swapped in page into
 current memcg
In-Reply-To: <20240129175423.1987-4-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Jan 2024 01:54:18 +0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-4-ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 14:12:50 +0800
Message-ID: <87sf2fgxi5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> Currently, mem_cgroup_swapin_charge_folio is always called with
> mm == NULL, except in swapin_direct.
>
> swapin_direct is only used when swapin should skip readahead
> and swapcache (SWP_SYNCHRONOUS_IO). All other callers of
> mem_cgroup_swapin_charge_folio are for swapin that should
> not skip readahead and cache.
>
> This could cause swapin charging to behave differently depending
> on swap device, which is unexpected.
>
> This is currently not happening because the only caller of
> swapin_direct is the direct anon page fault path, where mm always
> equals to current->mm, but will no longer be true if swapin_direct
> is shared and have other callers (eg, swapoff) to share the
> readahead skipping logic.
>
> So make swapin_direct also pass NULL for mm, so swpain charge
> will behave consistently and not effected by type of swapin device
> or readahead policy.
>
> After this, the second param of mem_cgroup_swapin_charge_folio is
> never used now, so it can be safely dropped.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 5 ++---
>  mm/swap_state.c            | 7 +++----
>  3 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 20ff87f8e001..540590d80958 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -693,7 +693,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  		long nr_pages);
>  
> -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> +int mem_cgroup_swapin_charge_folio(struct folio *folio,
>  				  gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>  
> @@ -1281,7 +1281,7 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
>  }
>  
>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
> -			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
> +		gfp_t gfp, swp_entry_t entry)
>  {
>  	return 0;
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4c8735e7c85..5852742df958 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7306,8 +7306,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
> -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> -				  gfp_t gfp, swp_entry_t entry)
> +int mem_cgroup_swapin_charge_folio(struct folio *folio, gfp_t gfp, swp_entry_t entry)
>  {
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
> @@ -7320,7 +7319,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
>  	if (!memcg || !css_tryget_online(&memcg->css))
> -		memcg = get_mem_cgroup_from_mm(mm);
> +		memcg = get_mem_cgroup_from_current();

The behavior of get_mem_cgroup_from_mm(NULL) and
get_mem_cgroup_from_current() isn't same exactly.  Are you sure that
this is OK?

--
Best Regards,
Huang, Ying


>  	rcu_read_unlock();
>  
>  	ret = charge_memcg(folio, memcg, gfp);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 645f5bcad123..a450d09fc0db 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -495,7 +495,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	__folio_set_locked(folio);
>  	__folio_set_swapbacked(folio);
>  
> -	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
> +	if (mem_cgroup_swapin_charge_folio(folio, gfp_mask, entry))
>  		goto fail_unlock;
>  
>  	/* May fail (-ENOMEM) if XArray node allocation failed. */
> @@ -884,9 +884,8 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  		__folio_set_locked(folio);
>  		__folio_set_swapbacked(folio);
>  
> -		if (mem_cgroup_swapin_charge_folio(folio,
> -					vma->vm_mm, GFP_KERNEL,
> -					entry)) {
> +		if (mem_cgroup_swapin_charge_folio(folio, GFP_KERNEL,
> +						   entry)) {
>  			folio_unlock(folio);
>  			folio_put(folio);
>  			return NULL;

