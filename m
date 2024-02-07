Return-Path: <linux-kernel+bounces-55879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4070184C2E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90BF1F29318
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44504FBE5;
	Wed,  7 Feb 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2j+J1ps"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919CF515
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275091; cv=none; b=Y8RDzpKSvzd4AaUM+3usaXnN12VcjLVxSkLE4A6MGLcXG4jEYikH05cTRZOjM55S64goUCpWvehhML12EQp1y5/LGvyhUFCfLBMEG4lAVW6XzEbnHw7P6mtA3LeNf7mdDCzGTFC0QR1O1Pinumd0Q8GmtRCDl3Tc9QTXC3W/XF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275091; c=relaxed/simple;
	bh=jjyo6oLa4+X/ISknl14tDw/49LaHcu3rQgBObBdx2Kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxXAvObbW6sLp2JVC6UuXkulUGGvZ2rMGy2qRJOf45O9/SKjQX2C3yQ837jCT5fGwSBs5a4RcNiTKxqlzaXOUCALb/o9omojGWtIfVi0W7P0wrY/P/TpNCQwBprIOcXdSyeA0VI22Z7ZPpYqHO7cfPwYqoHPKRi1+W4Iyh67BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2j+J1ps; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707275089; x=1738811089;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jjyo6oLa4+X/ISknl14tDw/49LaHcu3rQgBObBdx2Kk=;
  b=W2j+J1psECxMjz+Ao9GQm/ogi9aUd82lbUS7j/zFfaj+4SOX9YuRMfl0
   OAhsGe+GmbVcJD+fIA0UU9IAmJilSo6UuvZGbjwXm8xvfFwyEreotGeDQ
   u0pPAuqR2AZcx+6ubWZQMHQ9BPUOQHxPeAOsPHAKpC2YyxzMlAvqBiiht
   G8ZMLQeLCq3yFBFppRzmhd9bnnOtkGkGsUuoKymhHpA7CaK//G7JpO9MZ
   LtdF5elHV8tECACh6tCNfpsN0o+x29E0zAANSvk1oeLgVtkGkNs7eys3L
   1bSHKSjYVkSh4SKFkACtMsiBgH5d2njXkayflH0bbRRgMX9kFJtzmrk0S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1046714"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1046714"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1196327"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:04:33 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] mm/demotion: print demotion targets
In-Reply-To: <20240206020151.605516-1-lizhijian@fujitsu.com> (Li Zhijian's
	message of "Tue, 6 Feb 2024 10:01:51 +0800")
References: <20240206020151.605516-1-lizhijian@fujitsu.com>
Date: Wed, 07 Feb 2024 11:02:37 +0800
Message-ID: <87cyt9yo1e.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Li Zhijian <lizhijian@fujitsu.com> writes:

> Currently, when a demotion occurs, it will prioritize selecting a node
> from the preferred targets as the destination node for the demotion. If
> the preferred node does not meet the requirements, it will try from all
> the lower memory tier nodes until it finds a suitable demotion destination
> node or ultimately fails.
>
> However, the demotion target information isn't exposed to the users,
> especially the preferred target information, which relies on more factors.
> This makes users hard to understand the exact demotion behavior.
>
> Rather than having a new sys interface to expose this information,
> printing directly to kernel messages, just like the current page
> allocation fallback order does.
>
> A dmesg example with this patch is as follows:
> [    0.704860] Demotion targets for Node 0: null
> [    0.705456] Demotion targets for Node 1: null
> // node 2 is onlined
> [   32.259775] Demotion targets for Node 0: perferred: 2, fallback: 2
> [   32.261290] Demotion targets for Node 1: perferred: 2, fallback: 2
> [   32.262726] Demotion targets for Node 2: null
> // node 3 is onlined
> [   42.448809] Demotion targets for Node 0: perferred: 2, fallback: 2-3
> [   42.450704] Demotion targets for Node 1: perferred: 2, fallback: 2-3
> [   42.452556] Demotion targets for Node 2: perferred: 3, fallback: 3
> [   42.454136] Demotion targets for Node 3: null
> // node 4 is onlined
> [   52.676833] Demotion targets for Node 0: perferred: 2, fallback: 2-4
> [   52.678735] Demotion targets for Node 1: perferred: 2, fallback: 2-4
> [   52.680493] Demotion targets for Node 2: perferred: 4, fallback: 3-4
> [   52.682154] Demotion targets for Node 3: null
> [   52.683405] Demotion targets for Node 4: null
> // node 5 is onlined
> [   62.931902] Demotion targets for Node 0: perferred: 2, fallback: 2-5
> [   62.938266] Demotion targets for Node 1: perferred: 5, fallback: 2-5
> [   62.943515] Demotion targets for Node 2: perferred: 4, fallback: 3-4
> [   62.947471] Demotion targets for Node 3: null
> [   62.949908] Demotion targets for Node 4: null
> [   62.952137] Demotion targets for Node 5: perferred: 3, fallback: 3-4
>
> CC: "Huang, Ying" <ying.huang@intel.com>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> V2:
> Regarding this requirement, we have previously discussed [1].
> The initial proposal involved introducing a new sys interface.
> However, due to concerns about potential changes and compatibility
> issues with the interface in the future, a consensus was not
> reached with the community. Therefore, this time, we are directly
> printing out the information.
>
> [1] https://lore.kernel.org/all/d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com/
> ---
>  mm/memory-tiers.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 5462d9e3c84c..4d3506a290b7 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -359,6 +359,26 @@ static void disable_all_demotion_targets(void)
>  	synchronize_rcu();
>  }
>  
> +static void dump_demotion_targets(void)
> +{
> +	int node;
> +
> +	for_each_node_state(node, N_MEMORY) {
> +		struct memory_tier *memtier = __node_get_memory_tier(node);
> +		nodemask_t preferred = node_demotion[node].preferred;
> +
> +		if (!memtier)
> +			continue;
> +
> +		if (nodes_empty(preferred))
> +			pr_info("Demotion targets for Node %d: null\n", node);
> +		else
> +			pr_info("Demotion targets for Node %d: preferred: %*pbl, fallback: %*pbl\n",
> +				node, nodemask_pr_args(&preferred),
> +				nodemask_pr_args(&memtier->lower_tier_mask));
> +	}
> +}
> +
>  /*
>   * Find an automatic demotion target for all memory
>   * nodes. Failing here is OK.  It might just indicate
> @@ -443,7 +463,7 @@ static void establish_demotion_targets(void)
>  	 * Now build the lower_tier mask for each node collecting node mask from
>  	 * all memory tier below it. This allows us to fallback demotion page
>  	 * allocation to a set of nodes that is closer the above selected
> -	 * perferred node.
> +	 * preferred node.
>  	 */
>  	lower_tier = node_states[N_MEMORY];
>  	list_for_each_entry(memtier, &memory_tiers, list) {
> @@ -456,6 +476,8 @@ static void establish_demotion_targets(void)
>  		nodes_andnot(lower_tier, lower_tier, tier_nodes);
>  		memtier->lower_tier_mask = lower_tier;
>  	}
> +
> +	dump_demotion_targets();
>  }
>  
>  #else

