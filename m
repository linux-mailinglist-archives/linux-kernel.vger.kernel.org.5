Return-Path: <linux-kernel+bounces-76006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1485F1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4146B1F231E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F591799B;
	Thu, 22 Feb 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nupqupw0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09879EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585932; cv=none; b=CF7FDGS7ruBYcT5H4eei38woRVLSdSTn/ljxkuNydPDO59ziC6yOkqH8m94G+GMKnKGylIFYwFR8N6eqKnntAFByvMkftaYD48+RV15OxGCMgKTqUAA/zMOQWR7EISedLH19xkt6ch+zF5O/bv9JmRMtZNLJ7cfZCA385lqPdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585932; c=relaxed/simple;
	bh=hAfXNy4sb7G8TJrzhOnBQmLGKQF74NZNJB0HnSgbT8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABmlW7BkJB2SIhLOjXkb9ucfPrQTLq9SWAIcBgAOYMwVKkfkots0uW+kFJBoz1NK8E3GxRKy3+1gn2tQpjuMLEaCuktj3I9sgSRGWHWixMNIYnWG0vuEIf1wfOqoT4BqEddQxMxVV31O1obIg5TwNhfuPhpWZj6DkOndzl45Rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nupqupw0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708585930; x=1740121930;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hAfXNy4sb7G8TJrzhOnBQmLGKQF74NZNJB0HnSgbT8o=;
  b=Nupqupw0sWOINYLgwNVLPEzrV0iYqO4rqVWYwa5qJmmuPLIKIh+pQZX0
   AlUcdq1fOJJFzcN6nIWwlNhijdIu/KSTCBuof3YwxDaDNxfOAzwA/nwNC
   pTke1a/GZNgZLsA3fc2q8ByAiKTSESMVL7a9asAKQWfkqoI26OHIt65e8
   uJczxJ0eygD0h/eMahtuXtglEYzqVWOetkB2wtzxuZqoqrL5fnt3WS7HS
   syafw5FgizQGSmMhlUe37GKTQ7Z9OnCM4kpvteoxA6wDWt4xRt9Gbg9g2
   CaCsbYVVjuBkaa5kOVAswuOod0xKGXToz0O4rxT6YxRYPoBSw+HCFBvN4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2708653"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2708653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28553917"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:12:06 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  dave.jiang@intel.com,  Gregory Price
 <gregory.price@memverge.com>
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
In-Reply-To: <20240220202529.2365-2-gregory.price@memverge.com> (Gregory
	Price's message of "Tue, 20 Feb 2024 15:25:29 -0500")
References: <20240220202529.2365-1-gregory.price@memverge.com>
	<20240220202529.2365-2-gregory.price@memverge.com>
Date: Thu, 22 Feb 2024 15:10:11 +0800
Message-ID: <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Gregory,

Thanks a lot for working on this!

Gregory Price <gourry.memverge@gmail.com> writes:

> Startup and hotplug code may register HMAT data for memory
> devices. Utilize this data to generate reasonable default
> weighted interleave values.
>
> Introduce `mempolicy_set_node_perf()`. A function which can
> be invoked from node and CXL code to have mempolicy rebalance
> the system default interleave weights.
>
> mempolicy_set_node_perf() cache's each node's bandwidth (in
> this patch: min(read_bw, write_bw)), and recalculates the weight
> associated with each node.  After weights are calculated, we use
> gcd() to reduce these weights to the smallest amount possible in
> and effort to more aggressively interleave on smaller intervals.
>
> For example, a 1-socket system with a CXL memory expander which
> exposes 224GB/s and 64GB/s of bandwidth respectively will end
> up with a weight array of [7,2].
>
> The downside of this approach is that some distributes may
> experience large default values if they happen to a bandwidth
> distribution that includes an unfortunate prime number, or if
> any two values are co-prime.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  drivers/acpi/numa/hmat.c  |   1 +
>  drivers/base/node.c       |   7 +++
>  include/linux/mempolicy.h |   4 ++
>  mm/mempolicy.c            | 129 ++++++++++++++++++++++++++++++--------
>  4 files changed, 116 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d6b85f0f6082..7935d387e001 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -20,6 +20,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/memregion.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>  #include <linux/mutex.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 1c05640461dd..30458df504b4 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>  #include <linux/vmstat.h>
>  #include <linux/notifier.h>
>  #include <linux/node.h>
> @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			break;
>  		}
>  	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord))
> +			pr_info("failed to set node%d mempolicy attrs\n", nid);
> +	}
>  }
>  
>  /**
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 931b118336f4..d564e9e893ea 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
> +#include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/pagemap.h>
>  #include <uapi/linux/mempolicy.h>
> @@ -177,6 +178,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  
>  extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
>  
> +extern int mempolicy_set_node_perf(unsigned int node,
> +				   struct access_coordinate *coords);
> +
>  #else
>  
>  struct mempolicy {};
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ba0b2b81bd08..0a82aa51e497 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -109,6 +109,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/printk.h>
>  #include <linux/swapops.h>
> +#include <linux/gcd.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
> @@ -139,31 +140,114 @@ static struct mempolicy default_policy = {
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
>  /*
> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> - * system-default value should be used. A NULL iw_table also denotes that
> - * system-default values should be used. Until the system-default table
> - * is implemented, the system-default is always 1.
> + * The interleave weight tables denote what weights should be used with
> + * the weighted interleave policy.  There are two tables:
> + *    - iw_table : the sysfs-set interleave weight table
> + *    - default_iw_table : the system default interleave weight table.
>   *
> - * iw_table is RCU protected
> + * If the iw_table is NULL, default_iw_table values are used.
> + * If both tables are NULL, a minimum weight of 1 is always used.
> + * A value of 0 in the iw_table means the system default value will be used.
> + *
> + * iw_table, and default_iw_table are RCU protected
> + * node_bw_table is protected by default_iwt_lock
> + *
> + * system startup and hotplug code may register node performance information
> + * via mempolicy_set_node_attributes()
>   */
> +static unsigned long *node_bw_table;
> +static u8 __rcu *default_iw_table;
> +static DEFINE_MUTEX(default_iwt_lock);
> +
>  static u8 __rcu *iw_table;
>  static DEFINE_MUTEX(iw_table_lock);
>  
>  static u8 get_il_weight(int node)
>  {
> -	u8 *table;
> +	u8 *table, *default_table;
>  	u8 weight;
>  
>  	rcu_read_lock();
>  	table = rcu_dereference(iw_table);
> -	/* if no iw_table, use system default */
> -	weight = table ? table[node] : 1;
> -	/* if value in iw_table is 0, use system default */
> -	weight = weight ? weight : 1;
> +	default_table = rcu_dereference(default_iw_table);
> +	/* if no table pointers or value is 0, use system default or 1 */
> +	weight = table ? table[node] : 0;
> +	weight = weight ? weight : (default_table ? default_table[node] : 1);
>  	rcu_read_unlock();
>  	return weight;
>  }
>  
> +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> +{
> +	unsigned long *old_bw, *new_bw;
> +	unsigned long gcd_val;
> +	u8 *old_iw, *new_iw;
> +	uint64_t ttl_bw = 0;
> +	int i;
> +
> +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> +	if (!new_bw)
> +		return -ENOMEM;

We only use "node_bw_table" in this function with "default_iwt_lock"
held.  So, we don't need to copy-on-write?  Just change in place?

> +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
> +	if (!new_iw) {
> +		kfree(new_bw);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&default_iwt_lock);
> +	old_bw = node_bw_table;
> +	old_iw = rcu_dereference_protected(default_iw_table,
> +					   lockdep_is_held(&default_iwt_lock));
> +
> +	if (old_bw)
> +		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
> +	new_bw[node] = min(coords->read_bandwidth, coords->write_bandwidth);

We need to compress two bandwidth data into one.  The possible choice
could be,

- min(coords->read_bandwidth, coords->write_bandwidth), that is, your code

- coords->read_bandwidth + coords->write_bandwidth

I don't know which one is better.  Do you have some use cases to help to
determine which one is better?
> +
> +	/* New recalculate the bandwidth distribution given the new info */
> +	for (i = 0; i < nr_node_ids; i++)
> +		ttl_bw += new_bw[i];
> +
> +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
> +	for (i = 0; i < nr_node_ids; i++) {
> +		if (new_bw[i])
> +			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);
> +		else
> +			new_iw[i] = 1;

If we lacks performance data for some node, it will use "1" as default
weight.  It doesn't look like the best solution for me.  How about use
the average available bandwidth to calculate the default weight?  Or use
memory bandwidth of node 0 if performance data is missing?

> +	}
> +	/*
> +	 * Now attempt to aggressively reduce the interleave weights by GCD
> +	 * We want smaller interleave intervals to have a better distribution
> +	 * of memory, even on smaller memory regions. If weights are divisible
> +	 * by each other, we can do some quick math to aggresively squash them.
> +	 */
> +reduce:
> +	gcd_val = new_iw[i];

"i" will be "nr_node_ids" in the first loop.  Right?

> +	for (i = 0; i < nr_node_ids; i++) {
> +		/* Skip nodes that haven't been set */
> +		if (!new_bw[i])
> +			continue;
> +		gcd_val = gcd(gcd_val, new_iw[i]);
> +		if (gcd_val == 1)
> +			goto leave;
> +	}
> +	for (i = 0; i < nr_node_ids; i++) {
> +		if (!new_bw[i])
> +			continue;
> +		new_iw[i] /= gcd_val;
> +	}
> +	/* repeat until we get a gcd of 1 */
> +	goto reduce;
> +leave:
> +	node_bw_table = new_bw;
> +	rcu_assign_pointer(default_iw_table, new_iw);
> +	mutex_unlock(&default_iwt_lock);
> +	synchronize_rcu();
> +	kfree(old_bw);
> +	kfree(old_iw);
> +	return 0;
> +}
> +
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -1983,7 +2067,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  {
>  	nodemask_t nodemask;
>  	unsigned int target, nr_nodes;
> -	u8 *table;
> +	u8 *table, *default_table;
>  	unsigned int weight_total = 0;
>  	u8 weight;
>  	int nid;
> @@ -1994,11 +2078,13 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  
>  	rcu_read_lock();
>  	table = rcu_dereference(iw_table);
> +	default_table = rcu_dereference(default_iw_table);
>  	/* calculate the total weight */
>  	for_each_node_mask(nid, nodemask) {
>  		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table ? table[nid] : 0;
> +		weight = weight ? weight :
> +				  (default_table ? default_table[nid] : 1);

This becomes long.  I think that we should define a help function for this.

>  		weight_total += weight;
>  	}
>  
> @@ -2007,8 +2093,9 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  	nid = first_node(nodemask);
>  	while (target) {
>  		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table ? table[nid] : 0;
> +		weight = weight ? weight :
> +				  (default_table ? default_table[nid] : 1);
>  		if (target < weight)
>  			break;
>  		target -= weight;
> @@ -2391,7 +2478,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>  	unsigned long nr_allocated = 0;
>  	unsigned long rounds;
>  	unsigned long node_pages, delta;
> -	u8 *table, *weights, weight;
> +	u8 *weights, weight;
>  	unsigned int weight_total = 0;
>  	unsigned long rem_pages = nr_pages;
>  	nodemask_t nodes;
> @@ -2440,16 +2527,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>  	if (!weights)
>  		return total_allocated;
>  
> -	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> -	if (table)
> -		memcpy(weights, table, nr_node_ids);
> -	rcu_read_unlock();
> -
> -	/* calculate total, detect system default usage */
>  	for_each_node_mask(node, nodes) {
> -		if (!weights[node])
> -			weights[node] = 1;
> +		weights[node] = get_il_weight(node);
>  		weight_total += weights[node];
>  	}

--
Best Regards,
Huang, Ying

