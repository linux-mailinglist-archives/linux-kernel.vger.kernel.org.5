Return-Path: <linux-kernel+bounces-16353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D206B823D33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CE1F263A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C289200C8;
	Thu,  4 Jan 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWwQqYCj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE9200BA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704355979; x=1735891979;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=w7QdWCpRC9c2jKavjd+5JRPpXv4v1PAmsnvPkAZilfc=;
  b=hWwQqYCjyZFvD5+esyOp3ytzDPalfJe9lP2BKDEbUQJY1P1XCEqDCRLD
   gkrzN451LSGMb9f2MQfH5bonabMYh9Dslvj1172gVaFpwv7xUG+fw2F9H
   QfeKiSydIHz6Ql2Tw2DM2tgqIIeSSxQiz6zvP0DPD/ewx6FhKNPSZUuPk
   91acnHhp9cZRDyVGiNPY/UEIrhM6RmMZzThzIGiXsWbr3yAKgr1gYHbH5
   q3V0QCFA0ruuPZ1iJUo20PgSV4sZyzZNUZZAp+jTR/WSZTvbkDaf5Roi4
   /DqlVj7B9aQyPhajqEOfMKw9xT68e15Izo3ZjPMfidhG+LUWBCVjBiwN5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="15800670"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="15800670"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 00:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783797439"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="783797439"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 00:12:54 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] mm/swap: avoid doing extra unlock error checks
 for direct swapin
In-Reply-To: <20240102175338.62012-4-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:32 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-4-ryncsn@gmail.com>
Date: Thu, 04 Jan 2024 16:10:56 +0800
Message-ID: <87le95bjsf.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> When swapping in a page, mem_cgroup_swapin_charge_folio is called for
> new allocated folio, nothing else is referencing the folio so no need
> to set the lock bit early. This avoided doing extra unlock checks
> on the error path.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 24cb93ed5081..6130de8d5226 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -881,16 +881,15 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  				vma, vmf->address, false);
>  	if (folio) {
> -		__folio_set_locked(folio);
> -		__folio_set_swapbacked(folio);
> -
> -		if (mem_cgroup_swapin_charge_folio(folio,
> -					vma->vm_mm, GFP_KERNEL,
> -					entry)) {
> -			folio_unlock(folio);
> +		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> +						   GFP_KERNEL, entry)) {
>  			folio_put(folio);
>  			return NULL;
>  		}
> +
> +		__folio_set_locked(folio);
> +		__folio_set_swapbacked(folio);
> +
>  		mem_cgroup_swapin_uncharge_swap(entry);
>  
>  		shadow = get_shadow_from_swap_cache(entry);

I don't find any issue with the patch.  But another caller of
mem_cgroup_swapin_charge_folio() in __read_swap_cache_async() setups
newly allocated folio in the same way before the change.  Better to keep
them same?  Because the benefit of change is small too.

--
Best Regards,
Huang, Ying

