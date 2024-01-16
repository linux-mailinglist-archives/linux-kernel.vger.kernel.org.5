Return-Path: <linux-kernel+bounces-28251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C433982FC23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B49428DE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D42263A;
	Tue, 16 Jan 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUbuRYh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB0225D4;
	Tue, 16 Jan 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437148; cv=none; b=jZy7Ehb5JJsFgi5BNrllPLr8KN1IzH6GJj6sduIHzJKsa25NHDw78/vUg5euxMKmMV1b9inDtSFQMJkT11yi1w15gnDk8jKs49XqueoEJef2meWkbrsJId93GQNp7sCb8H2jYEyrllkhDsD6kKC6lhphhSUCmnAL8Nu1c8E/9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437148; c=relaxed/simple;
	bh=hTVTYscRjGrplcweWIL5zwVPwqAVm2ZnNC28xvD/AAA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=hfkhlv5W/h4uM/DVV1STRf3lZeBWlyYjV+ehZwxeAo8owB3JdYL9azmZCjBAWZwxoqL9CZnzcQpiBCcLshtT/Q5/lt0T1Pmi+e3m2d78KNkTFc1KiVZhgxeRBopZSkvZnU0Rh/aMCSweYQVPO4SWU6YDjlMVwW1023Q5MlDTMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUbuRYh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92320C433F1;
	Tue, 16 Jan 2024 20:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705437148;
	bh=hTVTYscRjGrplcweWIL5zwVPwqAVm2ZnNC28xvD/AAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUbuRYh8qWs/aoDu8zwjxoFVWQk7B9X6vMJolSIJKZJJX4pF2rkKbirY916s8ps3n
	 loFL/xADLpsXMdrTQTjUdPAECxdclqNSwVS5G6Hf8XH+tWy6qLXZF2meZiU1Nf/2FX
	 i9pTmIRzEzBIoNECJqKpo9yyihDH9UdCiScCrLSxs3/YC3OKS56sS+BHJ6aDTgMQpg
	 G42Uz3QxEMx8bjyhO/7T0ne98T+hazFwRLX0gpQJF8oX7b0pNUxVvC7lsbeyb96YPz
	 9GqsaxHskd8p3fN7zMOhi7w2ZFRfvXxNwGYU5ZtR27f76GXnW0kaWxDfwhoXzGCINT
	 0dTy65a/oIZWQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [RFC PATCH 3/4] mm/memory-tiers: add next_promotion_node to find promotion target
Date: Tue, 16 Jan 2024 12:32:24 -0800
Message-Id: <20240116203224.52877-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115045253.1775-4-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 13:52:51 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> From: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> This patch adds next_promotion_node that can be used to identify the
> appropriate promotion target based on memory tiers.  When multiple
> promotion target nodes are available, the nearest node is selected based
> on numa distance.
> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> ---
>  include/linux/memory-tiers.h | 11 +++++++++
>  mm/memory-tiers.c            | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 1e39d27bee41..0788e435fc50 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -50,6 +50,7 @@ int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
>  int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
> +int next_promotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>  bool node_is_toptier(int node);
>  #else
> @@ -58,6 +59,11 @@ static inline int next_demotion_node(int node)
>  	return NUMA_NO_NODE;
>  }
>  
> +static inline int next_promotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +
>  static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  {
>  	*targets = NODE_MASK_NONE;
> @@ -101,6 +107,11 @@ static inline int next_demotion_node(int node)
>  	return NUMA_NO_NODE;
>  }
>  
> +static inline int next_promotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +
>  static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  {
>  	*targets = NODE_MASK_NONE;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 8d5291add2bc..0060ee571cf4 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -335,6 +335,49 @@ int next_demotion_node(int node)
>  	return target;
>  }
>  
> +/*
> + * Select a promotion target that is close to the from node among the given
> + * two nodes.
> + *
> + * TODO: consider other decision policy as node_distance may not be precise.
> + */
> +static int select_promotion_target(int a, int b, int from)
> +{
> +	if (node_distance(from, a) < node_distance(from, b))
> +		return a;
> +	else
> +		return b;
> +}
> +
> +/**
> + * next_promotion_node() - Get the next node in the promotion path
> + * @node: The starting node to lookup the next node
> + *
> + * Return: node id for next memory node in the promotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is the toptier.
> + */
> +int next_promotion_node(int node)
> +{
> +	int target = NUMA_NO_NODE;
> +	int nid;
> +
> +	if (node_is_toptier(node))
> +		return NUMA_NO_NODE;
> +
> +	rcu_read_lock();
> +	for_each_node_state(nid, N_MEMORY) {
> +		if (node_isset(node, node_demotion[nid].preferred)) {
> +			if (target == NUMA_NO_NODE)
> +				target = nid;
> +			else
> +				target = select_promotion_target(nid, target, node);
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return target;
> +}
> +

If this is gonna used by only DAMON and we don't have a concrete plan to making
this used by others, I think implementing this in mm/damon/ might make sense.

>  static void disable_all_demotion_targets(void)
>  {
>  	struct memory_tier *memtier;
> -- 
> 2.34.1

