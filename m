Return-Path: <linux-kernel+bounces-162639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49698B5E69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799C11F22576
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC3839F1;
	Mon, 29 Apr 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i5TEj7+5"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51682D7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406425; cv=none; b=M9Qx5esqAjptzAeu4yt0O5a/+u35BqY7Xy//WL2IDJy95DsGni4Otl8RnlR7dV4GLKPAfuvtggIc73dInd+iezqFV9J4A/GmQCcGNBuUPVMJFRvvkQYS8Jxqmsb2QV2h5qwddWeRFVLxlYkI6sYCnr+0tUBZNhkyy5I89a5CPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406425; c=relaxed/simple;
	bh=uxrQvVi3C6VC3USi0wVs6Bvf3mJa5DUGAbwggGKz0ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQEtpORBfmN1fuCccVgN625eMsFLt0jCPqtr/5tHW9C2KU+ZY4NtXJw5lgIOtClrmquq6cuLiYFuceUTCvriAq3XhJYxHH6VnenmPMLLrH101cx7cUzCd48q3wzQSR7BfOXs7mD0I0vT+u41e7uUdlBhPOYM1L4XsOdE7tT2ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i5TEj7+5; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 09:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsNvp7x461b8Grs3tUPrt/6gegR3eirNH9Z+IzTL520=;
	b=i5TEj7+56rkhJjx8F3DaeWOepz0FRG/jHTzBj1f+8VAEajV8LDr5QwNWjbt54rNRQEAH+v
	UzuQzORHz6rW8bghjfiSpjLA3jALrJLZsn+3WnCFzzJNDUHNU7dOQWAiQoqEVpTjSSBQzJ
	mHzE4gUOjTgMFEEbFyM22zqsCov0DnY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <Zi_EEOUS_iCh2Nfh@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:29PM -0700, Shakeel Butt wrote:
> At the moment, the amount of memory allocated for stats related structs
> in the mem_cgroup corresponds to the size of enum node_stat_item.
> However not all fields in enum node_stat_item has corresponding memcg
> stats. So, let's use indirection mechanism similar to the one used for
> memcg vmstats management.
> 
> For a given x86_64 config, the size of stats with and without patch is:
> 
> structs size in bytes         w/o     with
> 
> struct lruvec_stats           1128     648
> struct lruvec_stats_percpu     752     432
> struct memcg_vmstats          1832    1352
> struct memcg_vmstats_percpu   1280     960
> 
> The memory savings is further compounded by the fact that these structs
> are allocated for each cpu and for each node. To be precise, for each
> memcg the memory saved would be:
> 
> Memory saved = ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODS * NR_CPUS) +
> 	       (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)
> 
> Where 21 is the number of fields eliminated.

Nice savings!

> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 138 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 115 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e337ed6c6bf..c164bc9b8ed6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -576,35 +576,105 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	return mz;
>  }
>  
> +/* Subset of node_stat_item for memcg stats */
> +static const unsigned int memcg_node_stat_items[] = {
> +	NR_INACTIVE_ANON,
> +	NR_ACTIVE_ANON,
> +	NR_INACTIVE_FILE,
> +	NR_ACTIVE_FILE,
> +	NR_UNEVICTABLE,
> +	NR_SLAB_RECLAIMABLE_B,
> +	NR_SLAB_UNRECLAIMABLE_B,
> +	WORKINGSET_REFAULT_ANON,
> +	WORKINGSET_REFAULT_FILE,
> +	WORKINGSET_ACTIVATE_ANON,
> +	WORKINGSET_ACTIVATE_FILE,
> +	WORKINGSET_RESTORE_ANON,
> +	WORKINGSET_RESTORE_FILE,
> +	WORKINGSET_NODERECLAIM,
> +	NR_ANON_MAPPED,
> +	NR_FILE_MAPPED,
> +	NR_FILE_PAGES,
> +	NR_FILE_DIRTY,
> +	NR_WRITEBACK,
> +	NR_SHMEM,
> +	NR_SHMEM_THPS,
> +	NR_FILE_THPS,
> +	NR_ANON_THPS,
> +	NR_KERNEL_STACK_KB,
> +	NR_PAGETABLE,
> +	NR_SECONDARY_PAGETABLE,
> +#ifdef CONFIG_SWAP
> +	NR_SWAPCACHE,
> +#endif
> +};
> +
> +static const unsigned int memcg_stat_items[] = {
> +	MEMCG_SWAP,
> +	MEMCG_SOCK,
> +	MEMCG_PERCPU_B,
> +	MEMCG_VMALLOC,
> +	MEMCG_KMEM,
> +	MEMCG_ZSWAP_B,
> +	MEMCG_ZSWAPPED,
> +};
> +
> +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat_items))
> +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> +
> +static void init_memcg_stats(void)
> +{
> +	int8_t i, j = 0;
> +
> +	/* Switch to short once this failure occurs. */
> +	BUILD_BUG_ON(NR_MEMCG_STATS >= 127 /* INT8_MAX */);
> +
> +	for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; ++i)
> +		mem_cgroup_stats_index[memcg_node_stat_items[i]] = ++j;
> +
> +	for (i = 0; i < ARRAY_SIZE(memcg_stat_items); ++i)
> +		mem_cgroup_stats_index[memcg_stat_items[i]] = ++j;
> +}
> +
> +static inline int memcg_stats_index(int idx)
> +{
> +	return mem_cgroup_stats_index[idx] - 1;
> +}

Hm, I'm slightly worried about the performance penalty due to the increased cache
footprint. Can't we have some formula to translate idx to memcg_idx instead of
a translation table?
If it requires a re-arrangement of items we can add a translation table on the
read side to save the visible order in procfs/sysfs.
Or I'm overthinking and the real difference is negligible?

Thanks!

