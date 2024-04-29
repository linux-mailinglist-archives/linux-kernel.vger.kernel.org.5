Return-Path: <linux-kernel+bounces-162617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A658B5E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D101C21534
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25182886;
	Mon, 29 Apr 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8EKPJVx"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DED8288C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405819; cv=none; b=DI45/K3pmmpI0i/oh/F8ysuPmRfAvayUTjx4nRJHWQZo3n0IBu99+UaQxobj7int680ydjNSXAi+OYh/XEdLaayeL5x/LQZpxxm5/hfC8n6zcafeUCKEGA9MzGhK9+C5vs8MZrU7OSYeBakSbFQ8G+4Uw5cQsAqZ2Fg/rp+1gPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405819; c=relaxed/simple;
	bh=zhTFpTkOh72Y5V9Sb34S2CuiXD0kXEZqWspBJFl1XXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQnCgib7GL8k2u7pgPlgo6koKCLydFRreXkIQBE74au/uPQWO8O63qaN7SOYqfazP0XqNjrAZOLGi+gGUC4WSpfG5Z9fG5xj2Ex4LZ0/WhxNOthn/wrfpuElx3pKiSwfpP9232siD5b+ygrD7aU5ckhKyvlu91k/WPa/Z532mfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8EKPJVx; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 08:50:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714405815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKgMs8IC2AjlGiD4IMMSk2bRlPofCUkI6VfQX63dzXs=;
	b=U8EKPJVxDe+gGrnq8VxO9TUzwVfMi12vCHwaC4iKRbH8fpLgeztt2LNd09ccuI4RfWN6rU
	ju1yfFWF5PZ0dxpPtCic709OqJrJr/m75dMyXzVvLr8XSFZQ7MtyKfr5i6zlkXVWhPGG2r
	Escx8Kb6Jo1GI7h7/KHairkqLfrX25A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] memcg: dynamically allocate lruvec_stats
Message-ID: <Zi_BsznrtoC1N_lq@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-3-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:28PM -0700, Shakeel Butt wrote:
> To decouple the dependency of lruvec_stats on NR_VM_NODE_STAT_ITEMS, we
> need to dynamically allocate lruvec_stats in the mem_cgroup_per_node
> structure. Also move the definition of lruvec_stats_percpu and
> lruvec_stats and related functions to the memcontrol.c to facilitate
> later patches. No functional changes in the patch.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 62 +++------------------------
>  mm/memcontrol.c            | 87 ++++++++++++++++++++++++++++++++------
>  2 files changed, 81 insertions(+), 68 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9aba0d0462ca..ab8a6e884375 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -83,6 +83,8 @@ enum mem_cgroup_events_target {
>  
>  struct memcg_vmstats_percpu;
>  struct memcg_vmstats;
> +struct lruvec_stats_percpu;
> +struct lruvec_stats;
>  
>  struct mem_cgroup_reclaim_iter {
>  	struct mem_cgroup *position;
> @@ -90,25 +92,6 @@ struct mem_cgroup_reclaim_iter {
>  	unsigned int generation;
>  };
>  
> -struct lruvec_stats_percpu {
> -	/* Local (CPU and cgroup) state */
> -	long state[NR_VM_NODE_STAT_ITEMS];
> -
> -	/* Delta calculation for lockless upward propagation */
> -	long state_prev[NR_VM_NODE_STAT_ITEMS];
> -};
> -
> -struct lruvec_stats {
> -	/* Aggregated (CPU and subtree) state */
> -	long state[NR_VM_NODE_STAT_ITEMS];
> -
> -	/* Non-hierarchical (CPU aggregated) state */
> -	long state_local[NR_VM_NODE_STAT_ITEMS];
> -
> -	/* Pending child counts during tree propagation */
> -	long state_pending[NR_VM_NODE_STAT_ITEMS];
> -};
> -
>  /*
>   * per-node information in memory controller.
>   */
> @@ -116,7 +99,7 @@ struct mem_cgroup_per_node {
>  	struct lruvec		lruvec;
>  
>  	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
> -	struct lruvec_stats			lruvec_stats;
> +	struct lruvec_stats			*lruvec_stats;
>  
>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>  
> @@ -1037,42 +1020,9 @@ static inline void mod_memcg_page_state(struct page *page,
>  }
>  
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
> -
> -static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
> -					      enum node_stat_item idx)
> -{
> -	struct mem_cgroup_per_node *pn;
> -	long x;
> -
> -	if (mem_cgroup_disabled())
> -		return node_page_state(lruvec_pgdat(lruvec), idx);
> -
> -	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> -}
> -
> -static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> -						    enum node_stat_item idx)
> -{
> -	struct mem_cgroup_per_node *pn;
> -	long x = 0;
> -
> -	if (mem_cgroup_disabled())
> -		return node_page_state(lruvec_pgdat(lruvec), idx);
> -
> -	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats.state_local[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> -}
> +unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
> +unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> +				      enum node_stat_item idx);
>  
>  void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 53769d06053f..5e337ed6c6bf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -576,6 +576,60 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	return mz;
>  }
>  
> +struct lruvec_stats_percpu {
> +	/* Local (CPU and cgroup) state */
> +	long state[NR_VM_NODE_STAT_ITEMS];
> +
> +	/* Delta calculation for lockless upward propagation */
> +	long state_prev[NR_VM_NODE_STAT_ITEMS];
> +};
> +
> +struct lruvec_stats {
> +	/* Aggregated (CPU and subtree) state */
> +	long state[NR_VM_NODE_STAT_ITEMS];
> +
> +	/* Non-hierarchical (CPU aggregated) state */
> +	long state_local[NR_VM_NODE_STAT_ITEMS];
> +
> +	/* Pending child counts during tree propagation */
> +	long state_pending[NR_VM_NODE_STAT_ITEMS];
> +};
> +
> +unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> +{
> +	struct mem_cgroup_per_node *pn;
> +	long x;
> +
> +	if (mem_cgroup_disabled())
> +		return node_page_state(lruvec_pgdat(lruvec), idx);
> +
> +	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> +	x = READ_ONCE(pn->lruvec_stats->state[idx]);
> +#ifdef CONFIG_SMP
> +	if (x < 0)
> +		x = 0;
> +#endif
> +	return x;
> +}
> +
> +unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> +				      enum node_stat_item idx)
> +{
> +	struct mem_cgroup_per_node *pn;
> +	long x = 0;
> +
> +	if (mem_cgroup_disabled())
> +		return node_page_state(lruvec_pgdat(lruvec), idx);
> +
> +	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> +	x = READ_ONCE(pn->lruvec_stats->state_local[idx]);
> +#ifdef CONFIG_SMP
> +	if (x < 0)
> +		x = 0;
> +#endif

Not directly related to your change, but do we still need it? And if yes,
do we really care about !CONFIG_SMP case enough to justify these #ifdefs?

> +	return x;
> +}
> +
>  /* Subset of vm_event_item to report for memcg event stats */
>  static const unsigned int memcg_vm_event_stat[] = {
>  	PGPGIN,
> @@ -5492,18 +5546,25 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return 1;
>  
> +	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
> +					node);

Why not GFP_KERNEL_ACCOUNT?

> +	if (!pn->lruvec_stats)
> +		goto fail;
> +
>  	pn->lruvec_stats_percpu = alloc_percpu_gfp(struct lruvec_stats_percpu,
>  						   GFP_KERNEL_ACCOUNT);
> -	if (!pn->lruvec_stats_percpu) {
> -		kfree(pn);
> -		return 1;
> -	}
> +	if (!pn->lruvec_stats_percpu)
> +		goto fail;
>  
>  	lruvec_init(&pn->lruvec);
>  	pn->memcg = memcg;
>  
>  	memcg->nodeinfo[node] = pn;
>  	return 0;
> +fail:
> +	kfree(pn->lruvec_stats);
> +	kfree(pn);
> +	return 1;
>  }
>  
>  static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> @@ -5514,6 +5575,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  		return;
>  
>  	free_percpu(pn->lruvec_stats_percpu);
> +	kfree(pn->lruvec_stats);
>  	kfree(pn);
>  }
>  
> @@ -5866,18 +5928,19 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  
>  	for_each_node_state(nid, N_MEMORY) {
>  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> -		struct mem_cgroup_per_node *ppn = NULL;
> +		struct lruvec_stats *lstats = pn->lruvec_stats;
> +		struct lruvec_stats *plstats = NULL;
>  		struct lruvec_stats_percpu *lstatc;
>  
>  		if (parent)
> -			ppn = parent->nodeinfo[nid];
> +			plstats = parent->nodeinfo[nid]->lruvec_stats;
>  
>  		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
>  
>  		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> -			delta = pn->lruvec_stats.state_pending[i];
> +			delta = lstats->state_pending[i];
>  			if (delta)
> -				pn->lruvec_stats.state_pending[i] = 0;
> +				lstats->state_pending[i] = 0;
>  
>  			delta_cpu = 0;
>  			v = READ_ONCE(lstatc->state[i]);
> @@ -5888,12 +5951,12 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  			}
>  
>  			if (delta_cpu)
> -				pn->lruvec_stats.state_local[i] += delta_cpu;
> +				lstats->state_local[i] += delta_cpu;
>  
>  			if (delta) {
> -				pn->lruvec_stats.state[i] += delta;
> -				if (ppn)
> -					ppn->lruvec_stats.state_pending[i] += delta;
> +				lstats->state[i] += delta;
> +				if (plstats)
> +					plstats->state_pending[i] += delta;
>  			}
>  		}
>  	}
> -- 
> 2.43.0
> 

