Return-Path: <linux-kernel+bounces-110889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F31886542
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C251F21239
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FC4A04;
	Fri, 22 Mar 2024 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kORYnHy1"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2510A11
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075516; cv=none; b=HGuaIryGmaaeciANLCfwk7J8TT+H9E4y4fvSoGhoNOHSYnByfe/DWvD+FcEp/Biyz4x3ij+2tJHtGSnQ65njlOMceZEE3FI41EqDxw55zKlkC0uCC0WaALPbUgNXwS6MDJ1d0IIlOC7vI3XPzr5uG52mvNv01X6WVGFQxG9ii7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075516; c=relaxed/simple;
	bh=PqSFyP9+hAJWyMQXtSADpzD7TrIo0vO91UKnoJg9KPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kywICUc9XjGIYHp7rOll3NBauCDDqG66qNEqhuIS0gSrOzJ9BykRGMKZBIBE2U7OU97i8PgE9p19phf+xzDq+tZZMAxYk6qRSQ9E5S6VGlSVLaV1eX5ik9n57g/Z+u7W/Za01nooVlWTrm5IktIcFNciKaH64oEI+7WNLpA9xNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kORYnHy1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a0a3987-bc38-4069-9005-f8097a4d934e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711075511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCTXhEVfRcod0gk2uJbigtkgzM1uKiNOmgoxZlYoNnY=;
	b=kORYnHy1Szf5D8ha4QPHKPsmDUutFpu7FQa1h4gf/O3FrGTgI5ZqhROoEewX027jJhjfoC
	9Xod03XHmavPou4crSHL+p3zUxS9w1UoF7ChrXg/NDEYbOVwYivtMI4PVaxg/vVqTS6olf
	tNzVLSbrM1ZxI1CiPTuDv2U1Ug5CwoE=
Date: Fri, 22 Mar 2024 10:45:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS
 recursion
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240321182532.60000-1-hannes@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240321182532.60000-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/22 02:25, Johannes Weiner wrote:
> Kent forwards this bug report of zswap re-entering the block layer
> from an IO request allocation and locking up:
> 
> [10264.128242] sysrq: Show Blocked State
> [10264.128268] task:kworker/20:0H   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
> [10264.128271] Workqueue: bcachefs_io btree_write_submit [bcachefs]
> [10264.128295] Call Trace:
> [10264.128295]  <TASK>
> [10264.128297]  __schedule+0x3e6/0x1520
> [10264.128303]  schedule+0x32/0xd0
> [10264.128304]  schedule_timeout+0x98/0x160
> [10264.128308]  io_schedule_timeout+0x50/0x80
> [10264.128309]  wait_for_completion_io_timeout+0x7f/0x180
> [10264.128310]  submit_bio_wait+0x78/0xb0
> [10264.128313]  swap_writepage_bdev_sync+0xf6/0x150
> [10264.128317]  zswap_writeback_entry+0xf2/0x180
> [10264.128319]  shrink_memcg_cb+0xe7/0x2f0
> [10264.128322]  __list_lru_walk_one+0xb9/0x1d0
> [10264.128325]  list_lru_walk_one+0x5d/0x90
> [10264.128326]  zswap_shrinker_scan+0xc4/0x130
> [10264.128327]  do_shrink_slab+0x13f/0x360
> [10264.128328]  shrink_slab+0x28e/0x3c0
> [10264.128329]  shrink_one+0x123/0x1b0
> [10264.128331]  shrink_node+0x97e/0xbc0
> [10264.128332]  do_try_to_free_pages+0xe7/0x5b0
> [10264.128333]  try_to_free_pages+0xe1/0x200
> [10264.128334]  __alloc_pages_slowpath.constprop.0+0x343/0xde0
> [10264.128337]  __alloc_pages+0x32d/0x350
> [10264.128338]  allocate_slab+0x400/0x460
> [10264.128339]  ___slab_alloc+0x40d/0xa40
> [10264.128345]  kmem_cache_alloc+0x2e7/0x330
> [10264.128348]  mempool_alloc+0x86/0x1b0
> [10264.128349]  bio_alloc_bioset+0x200/0x4f0
> [10264.128352]  bio_alloc_clone+0x23/0x60
> [10264.128354]  alloc_io+0x26/0xf0 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128361]  dm_submit_bio+0xb8/0x580 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128366]  __submit_bio+0xb0/0x170
> [10264.128367]  submit_bio_noacct_nocheck+0x159/0x370
> [10264.128368]  bch2_submit_wbio_replicas+0x21c/0x3a0 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128391]  btree_write_submit+0x1cf/0x220 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128406]  process_one_work+0x178/0x350
> [10264.128408]  worker_thread+0x30f/0x450
> [10264.128409]  kthread+0xe5/0x120
> 
> The zswap shrinker resumes the swap_writepage()s that were intercepted
> by the zswap store. This will enter the block layer, and may even
> enter the filesystem depending on the swap backing file.
> 
> Make it respect GFP_NOIO and GFP_NOFS.
> 
> Link: https://lore.kernel.org/linux-mm/rc4pk2r42oyvjo4dc62z6sovquyllq56i5cdgcaqbd7wy3hfzr@n4nbxido3fme/
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Cc: stable@vger.kernel.org	[v6.8]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b31c977f53e9..535c907345e0 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1303,6 +1303,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
>  		return 0;
>  
> +	/*
> +	 * The shrinker resumes swap writeback, which will enter block
> +	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
> +	 * rules (may_enter_fs()), which apply on a per-folio basis.
> +	 */
> +	if (!gfp_has_io_fs(sc->gfp_mask))
> +		return 0;
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  	mem_cgroup_flush_stats(memcg);
>  	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;

