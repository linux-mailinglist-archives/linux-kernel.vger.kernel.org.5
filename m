Return-Path: <linux-kernel+bounces-111128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2EF886840
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A0D28303D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020F18659;
	Fri, 22 Mar 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUpPQHxp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB17748
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096461; cv=none; b=CLN9C9Jj90Z+rUpLYnbL0Uu05jv8CzeWDDNeUXN7qpS5Wn5qAk9Bj15zvkBEBpLv0amLTTD0l/SExuN68n8RETb+YSUi2/mUOs+0JilYNt3QCAeG3UUX85P0uhgKDGhS6WVpB8sm0gcRfWwFu8dDORLIbhVXWJzTs2qk3PIhvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096461; c=relaxed/simple;
	bh=mRVzyIiP7iscM7MSn5nw7hKjhSKi3ZHs2yFxGw3ITds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQayDcFkE611INKw+h74kSdmmeyIGNRBv4nLWcHcs+iVU6IQXSAsffo52jivTPDdblMFJxlF+ymirJkAq9GnlOH0s5uwiaU6ELiB5D8c6nXIfYcXfB2bUKv81FJdWJIFtxhv6/Or1wqNpiMLiZeXDIqg4rw+206ayOqv7SWos4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUpPQHxp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711096460; x=1742632460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mRVzyIiP7iscM7MSn5nw7hKjhSKi3ZHs2yFxGw3ITds=;
  b=cUpPQHxpcPVYzxvyl1mOAAIUVIB4T2z/AFrp9LuEDcLkZ9B0V9tZefxR
   nLOKXW8dG8WoyzqfUjPeyjQeIEp0Nb8sUuyPh4IVorxSTIOwowCUEkk6h
   OGNz5arW93szvEpYOBdRIssien4PumoL+AJpUEnuENVUPD4IEOTwQhKCO
   q8fJwt5wElhT/+hJdxth8YMWzI7wXvtFPyQ4c8xQ7NW9zp+Ro+VTm8ePk
   kITkmoGVnSpugINhh8Sq5S7Nl9wutJi+FtQr+L+5/RmlW+VgfBxPh4dsO
   YM+EZn2ZXAAvB7E2gLIn0yWCSxHSNItY8S8683GGl9c2bW2rOZj1+z34Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6024928"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6024928"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 01:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19381543"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 01:34:14 -0700
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
Subject: Re: [PATCH v3 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <b1599085e1d2f3e48dc71c7991283b8aaa0fe00c.1711002865.git.donettom@linux.ibm.com>
	(Donet Tom's message of "Thu, 21 Mar 2024 06:29:51 -0500")
References: <cover.1711002865.git.donettom@linux.ibm.com>
	<b1599085e1d2f3e48dc71c7991283b8aaa0fe00c.1711002865.git.donettom@linux.ibm.com>
Date: Fri, 22 Mar 2024 16:32:20 +0800
Message-ID: <87h6gyr7jf.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Can we provide more information about this?  I suggest to use an
example, for instance, pages may be distributed among multiple sockets
unexpectedly.

--
Best Regards,
Huang, Ying

> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  mm/mempolicy.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index aa48376e2d34..13100a290918 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1504,9 +1504,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
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
> @@ -2770,15 +2771,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
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

