Return-Path: <linux-kernel+bounces-17541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE8824F19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CC8285C85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953611F95F;
	Fri,  5 Jan 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkwDt/BG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD381EB3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704439012; x=1735975012;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rmI+/pbw5vwRtTdn9jKRFOQEK4BpH6g7BJ8uZMZV//0=;
  b=nkwDt/BGCxA7IYG6zPysGh885y97wruhn61RD6q/cKTIdDf6HurOQek4
   WicV6gNEqkW0FBoYWfDNCUD5Mz/yZMnkCN0Nv4hBqRmODNVWcn2UYLYJE
   KmJ1WB1KCZsu9lgmmXZH5ZtSKAJsotZvhI+h+5XSJQAbdWvsGrDs1vL2e
   BSLTAi++XL5uTdR36RDD7cGUnQ1mZbDNkHEb30xIqRkHXcA8v89zLQSBJ
   oBgcWNey7PDaxWmi/w5e78kOqsPJ+EVW9tyK0CZnCgUMNk9KDQAtUR3hX
   SsSzSdZt+SmlnnxxzfaIEn9bp/cbdRLyijqpzr0WF0mzySg1x+Ja+tJ7m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10822152"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="10822152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="809473787"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="809473787"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:16:47 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] mm/swap: always account swapped in page into
 current memcg
In-Reply-To: <20240102175338.62012-5-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:33 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-5-ryncsn@gmail.com>
Date: Fri, 05 Jan 2024 15:14:49 +0800
Message-ID: <878r54b6ae.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> mm argument as NULL, except in swapin_direct.
>
> swapin_direct is used when swapin should skip readahead and
> swapcache (SWP_SYNCHRONOUS_IO). Other caller paths of
> mem_cgroup_swapin_charge_folio are for swapin that should
> not skip readahead and cache.
>
> This could cause swapin charging to behave differently depending
> on swap device. This currently didn't happen because the only call
> path of swapin_direct is the direct anon page fault path, where mm
> equals to current->mm, but will no longer be true if swapin_direct
> is shared and have other callers (eg, swapoff).
>
> So make swapin_direct also passes NULL for mm, no feature change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 6130de8d5226..d39c5369da21 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -881,7 +881,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  				vma, vmf->address, false);
>  	if (folio) {
> -		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> +		if (mem_cgroup_swapin_charge_folio(folio, NULL,
>  						   GFP_KERNEL, entry)) {
>  			folio_put(folio);
>  			return NULL;

I think that why not provide "mm" when it's available?  For
swapin_direct() called by do_swap_page(), mm can be provided.  While,
for swapin_direct() called by shmem swapin, mm will be NULL.  We can
even provide "mm" for __read_swap_cache_async() for VMA based swapin and
for the fault address for cluster swapin.

--
Best Regards,
Huang, Ying

