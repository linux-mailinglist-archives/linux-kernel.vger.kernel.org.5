Return-Path: <linux-kernel+bounces-72461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821C85B3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D6C283FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2595A4CB;
	Tue, 20 Feb 2024 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US5bUEHK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98075A109
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413616; cv=none; b=Roe846o+G9NOJyQGWodFXCdcXrahufL9XOrqwGn9dKf2oLa7pkhy3kg63gGtDAhk40C47OJFxQs++EZrb8rK6yY4ennp0JpijlQHuq3ngV7GifGBWlYZWZwUTjhvxLq93msWbORi0RWLpRWpXwYOiDKHGQ7hS2A1TP7fI6PAszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413616; c=relaxed/simple;
	bh=OHde8bTYZStDVq7VnJxwBpRl980/3rKekMTSgOwZ8Pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7bVx7T1mppsJor8hRZCG083Zn1xqRzsyg0m9Zz+Kgf6tlD6hdprQVzYk4tfJ3CeUrJ0wRwO7Qh7IYh74AfyFICPjk6QMBWmtRpmlSw21KLkxTXaI0cOVZQL7LMNN6VABunDvciz96wnBgHoUj7+COrsplDsEp/pJ7tejnSSwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US5bUEHK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708413615; x=1739949615;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OHde8bTYZStDVq7VnJxwBpRl980/3rKekMTSgOwZ8Pw=;
  b=US5bUEHK8TZwuGqzRhbntdG1nMZsbWjpSmkghueMVch8odXFw/GC0Y84
   5AGrs6W5GzMiiKoRb2Qdil/CDxJaemF9YTfL/vhYkC+dCMOHFNpoJMG1b
   EJ/ZOpy2hWiQPvftclDm0HG1TOQ2HiQ2SveknHwUO2msdXYJXV0sLAHpW
   eaE+JDLXj5xGqricNSO8BuNK2EIQgxvGP1uSMRoTlWr+noQExUr4K5vzz
   vBFRQ134WCO5kAYCX72wwygsCj7B/MXGXrpNIsqEtL5dl/d3sh/M1h9fM
   KdMkf0HiCtRu9QLtoY2jX5r127zY/tr6fuPXrMhrGIfQDGy/i16LqSJYL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19937358"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="19937358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9308569"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:20:08 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Aneesh Kumar <aneesh.kumar@kernel.org>,
  Dave Hansen <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,
  Ben Widawsky <ben.widawsky@intel.com>,  Feng Tang <feng.tang@intel.com>,
  Michal Hocko <mhocko@kernel.org>,  Andrea Arcangeli
 <aarcange@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Mike
 Kravetz <mike.kravetz@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Dan
 Williams <dan.j.williams@intel.com>,  Hugh Dickins <hughd@google.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
	(Donet Tom's message of "Sat, 17 Feb 2024 01:31:35 -0600")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
Date: Tue, 20 Feb 2024 15:18:13 +0800
Message-ID: <877cizppsa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Donet Tom <donettom@linux.ibm.com> writes:

> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
> nodes") added support for migrate on protnone reference with MPOL_BIND
> memory policy. This allowed numa fault migration when the executing node
> is part of the policy mask for MPOL_BIND. This patch extends migration
> support to MPOL_PREFERRED_MANY policy.
>
> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
> the kernel should not allocate pages from the slower memory tier via
> allocation control zonelist fallback. Instead, we should move cold pages
> from the faster memory node via memory demotion. For a page allocation,
> kswapd is only woken up after we try to allocate pages from all nodes in
> the allocation zone list. This implies that, without using memory
> policies, we will end up allocating hot pages in the slower memory tier.
>
> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
> allocation control when we have memory tiers in the system. With
> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
> of faster memory nodes. When we fail to allocate pages from the faster
> memory node, kswapd would be woken up, allowing demotion of cold pages
> to slower memory nodes.
>
> With the current kernel, such usage of memory policies implies we can't
> do page promotion from a slower memory tier to a faster memory tier
> using numa fault. This patch fixes this issue.
>
> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
> mask, we allow numa migration to the executing nodes. If the executing
> node is not in the policy node mask but the folio is already allocated
> based on policy preference (the folio node is in the policy node mask),
> we don't allow numa migration. If both the executing node and folio node
> are outside the policy node mask, we allow numa migration to the
> executing nodes.
>
> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 73d698e21dae..8c4c92b10371 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1458,9 +1458,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>  	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>  		return -EINVAL;
>  	if (*flags & MPOL_F_NUMA_BALANCING) {
> -		if (*mode != MPOL_BIND)
> +		if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
> +			*flags |= (MPOL_F_MOF | MPOL_F_MORON);
> +		else
>  			return -EINVAL;
> -		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>  	}
>  	return 0;
>  }
> @@ -2463,6 +2464,23 @@ static void sp_free(struct sp_node *n)
>  	kmem_cache_free(sn_cache, n);
>  }
>  
> +static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
> +					    struct mempolicy *pol)
> +{
> +	/* if the executing node is in the policy node mask, migrate */
> +	if (node_isset(exec_node, pol->nodes))
> +		return true;
> +
> +	/* If the folio node is in policy node mask, don't migrate */
> +	if (node_isset(folio_node, pol->nodes))
> +		return false;
> +	/*
> +	 * both the folio node and executing node are outside the policy nodemask,
> +	 * migrate as normal numa fault migration.
> +	 */
> +	return true;

Why?  This may cause some unexpected result.  For example, pages may be
distributed among multiple sockets unexpectedly.  So, I prefer the more
conservative policy, that is, only migrate if this node is in
pol->nodes.

--
Best Regards,
Huang, Ying

> +}
> +
>  /**
>   * mpol_misplaced - check whether current folio node is valid in policy
>   *
> @@ -2526,6 +2544,12 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  		break;
>  
>  	case MPOL_PREFERRED_MANY:
> +		if (pol->flags & MPOL_F_MORON) {
> +			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
> +				goto out;
> +			break;
> +		}
> +
>  		/*
>  		 * use current page if in policy nodemask,
>  		 * else select nearest allowed node, if any.

