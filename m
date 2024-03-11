Return-Path: <linux-kernel+bounces-98399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD0877995
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58826281C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00036A47;
	Mon, 11 Mar 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnVjnoku"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388877EC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121178; cv=none; b=ihA0b9qnnwz/CMcP7WlxKJOzuTTBAqHRNX/EVxlI9CY061Nd+n5B3yjCDnBPhS0hWxFlfjfd83JmcLOYbIJlE4zdKz8PWURR1vNDWSUc3DRb3JqatgOIA5BPffNwpZsFN4ZNl1hGQGI9LZqrGqmTMIK4yyii62GjkhIOndGA9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121178; c=relaxed/simple;
	bh=RH97JCVDoNwe8SVC6X+BVVE8z2EgxsVYbKPbHPNPJLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o+t8AP4NHjEGR2t77oHM8YEa7J9h0OLfqWkDDUG04WhHoHQI8YcFX4OmfUWJgqoKI1epEFgnFO05TC2Z2hsQN4wnQBQ+ojDOWFkeuUCbTIyT1jNe5dmGZYntsao17IwM1epjmcyrHfO/ooLG9xr7Vnflon+Z4WTkILBQA7jSVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnVjnoku; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710121176; x=1741657176;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RH97JCVDoNwe8SVC6X+BVVE8z2EgxsVYbKPbHPNPJLY=;
  b=fnVjnokutBVnw/4/5s6SVG47jRwPm6+pCUDheIPkA4GDrp5Met4Nxp31
   yYcK37+ee+8lZiuGT4IT8TQdMLGgMytGB2NiqvHm1NhCp5/kYGkxkk1+d
   NKiQ/TJuvsx0S5T+QCD59VVr+MSPhiD9Y+P5bixjz2agAu9rABWRyU8zT
   213RV98DJWLYRImBWoaY7Y/RRSNdGD5yoXaWFSnpQiC9VimuxCAKJwOyA
   QVRX1Zdj+nRCFAPF4rasZ302bBORF6dd0fz8uueoNaeK6tebVJYe8+a9l
   qGu2mTIRxh17H5JhN8kpR1bGWQ4O8cmkH9c4toGdqUbfYKE5nKl6Fd590
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30212913"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30212913"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 18:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15665180"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 18:39:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Aneesh Kumar <aneesh.kumar@kernel.org>,
  Michal Hocko <mhocko@kernel.org>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,  Feng Tang
 <feng.tang@intel.com>,  Andrea Arcangeli <aarcange@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van
 Riel <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Vlastimil Babka <vbabka@suse.cz>,  Dan
 Williams <dan.j.williams@intel.com>,  Hugh Dickins <hughd@google.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH v2 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <369d6a58758396335fd1176d97bbca4e7730d75a.1709909210.git.donettom@linux.ibm.com>
	(Donet Tom's message of "Fri, 8 Mar 2024 09:15:38 -0600")
References: <cover.1709909210.git.donettom@linux.ibm.com>
	<369d6a58758396335fd1176d97bbca4e7730d75a.1709909210.git.donettom@linux.ibm.com>
Date: Mon, 11 Mar 2024 09:37:36 +0800
Message-ID: <874jdd5z1b.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> node is not in the policy node mask, we do not allow numa migration.
>
> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  mm/mempolicy.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index e635d7ed501b..ccd9c6c5fcf5 100644
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
> @@ -2515,15 +2516,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
>  		break;
>  
>  	case MPOL_BIND:
> -		/* Optimize placement among multiple nodes via NUMA balancing */
> +	case MPOL_PREFERRED_MANY:
> +		/*
> +		 * Even though MPOL_PREFERRED_MANY can allocate pages outside
> +		 * policy nodemask we don't allow numa migration to nodes
> +		 * outside policy nodemask for now. This is done so that if we
> +		 * want demotion to slow memory to happen, before allocating
> +		 * from some DRAM node say 'x', we will end up using a
> +		 * MPOL_PREFERRED_MANY mask excluding node 'x'. In such scenario
> +		 * we should not promote to node 'x' from slow memory node.
> +		 */

This is a little hard to digest for me.  And, I don't think that we need
to put this policy choice in code comments.  It's better to put it in
patch description.  Where we can give more background, for example, to
avoid cross-socket traffic, etc.

Otherwise, the patchset looks good to me.  Thanks!

>  		if (pol->flags & MPOL_F_MORON) {
> +			/*
> +			 * Optimize placement among multiple nodes
> +			 * via NUMA balancing
> +			 */
>  			if (node_isset(thisnid, pol->nodes))
>  				break;
>  			goto out;
>  		}
> -		fallthrough;
>  
> -	case MPOL_PREFERRED_MANY:
>  		/*
>  		 * use current page if in policy nodemask,
>  		 * else select nearest allowed node, if any.

--
Best Regards,
Huang, Ying

