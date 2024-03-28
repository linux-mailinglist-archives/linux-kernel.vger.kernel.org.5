Return-Path: <linux-kernel+bounces-122586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D788FA07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2A31F283BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06F44C6F;
	Thu, 28 Mar 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LMkhFwCT"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F428DB3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614706; cv=none; b=tSTNqn7B3yxyxN8r4AdT9R2In9h3MM2uGLep75Zz2krK0Oi1CVKlSM4JuEV/kJoAGA4uWFnDSp14fpjsrZ0nt3GM0zuoBxosp8PNVdg+qi6z04plGSIx0qJylOcUSilvhBQ8VhhHBbcwwKoZ92q0P3FZT3nKZ6sDS34aXUVacsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614706; c=relaxed/simple;
	bh=qm6MN9HJBj2/qglfnTiwAPaiTq94YBkgyy2nwy+si5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7S2Mrr5Wuz4sn90LrfnAwLFZ3AIHxTaew3fLwQIGQ7BiJGA+H3H5tiJrq5/cgB7SKuKBrgq1A0gZC6g1i0Bn3wWwe2XWY33R+Fk9gYe68ZnJFIgPnTueFIAA+GsGu7KnrtQlexPALjyHDIDU5ucPnBjAZptSVm+kvyqbd45eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LMkhFwCT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6352794b-f5a2-4525-8185-c910739683e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711614702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrTMwHNtGxgQoxiGyZ4qpRHY+py29G4illAnWUnjIPg=;
	b=LMkhFwCTqMPuIwWNQ6SzbIJcFT5HOU/A4szBZAjclAVYCtm8MpakStdwHfPS5A4IaoG7xa
	PyAlMeeFsanRnRAS9xIOVUjVa99uoaGRsXfA7dp++c2Z1BhJJQDAaM+RxmNji3uSdjwRo4
	fqeJPO64D9K+pe3+1/o7TXHjar9Am2Y=
Date: Thu, 28 Mar 2024 16:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 9/9] mm: zswap: use zswap_entry_free() for partially
 initialized entries
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-10-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-10-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> zswap_entry_free() performs four types of cleanups before freeing a
> zswap_entry:
> - Deletes the entry from the LRU.
> - Frees compressed memory.
> - Puts the pool reference.
> - Uncharges the compressed memory and puts the objcg.
> 
> zswap_entry_free() always expects a fully initialized entry. Allow
> zswap_entry_free() to handle partially initialized entries by making it
> possible to identify what cleanups are needed as follows:
> - Allocate entries with __GFP_ZERO and initialize zswap_entry.lru when
>   the entry is allocated. Points are NULL and length is zero upon
>   initialization.
> - Use zswap_entry.length to identify if there is compressed memory to
>   free. This is possible now that zero-filled pages are handled
>   separately, so a length of zero means we did not successfully compress
>   the page.
> - Only initialize entry->objcg after the memory is charged in
>   zswap_store().
> 
> With this in place, use zswap_entry_free() in the failure path of
> zswap_store() to cleanup partially initialized entries. This simplifies
> the cleanup code in zswap_store(). While we are at it, rename the
> remaining cleanup labels to more meaningful names.

Not sure if it's worthwhile to clean up the fail path with the normal path
gets a little verbose.

> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 62 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9357328d940af..c50f9df230ca3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -774,12 +774,13 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>  
> -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> +static struct zswap_entry *zswap_entry_cache_alloc(int nid)
>  {
>  	struct zswap_entry *entry;
> -	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> -	if (!entry)
> -		return NULL;
> +	entry = kmem_cache_alloc_node(zswap_entry_cache,
> +				      GFP_KERNEL | __GFP_ZERO, nid);
> +	if (entry)
> +		INIT_LIST_HEAD(&entry->lru);
>  	return entry;
>  }
>  
> @@ -795,9 +796,12 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>  
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
> -	zswap_lru_del(&zswap_list_lru, entry);
> -	zpool_free(zswap_find_zpool(entry), entry->handle);
> -	zswap_pool_put(entry->pool);
> +	if (!list_empty(&entry->lru))
> +		zswap_lru_del(&zswap_list_lru, entry);
> +	if (entry->length)
> +		zpool_free(zswap_find_zpool(entry), entry->handle);
> +	if (entry->pool)
> +		zswap_pool_put(entry->pool);
>  	if (entry->objcg) {
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
> @@ -1447,7 +1451,7 @@ bool zswap_store(struct folio *folio)
>  		return false;
>  
>  	if (!zswap_enabled)
> -		goto check_old;
> +		goto erase_old;
>  
>  	/* Check cgroup limits */
>  	objcg = get_obj_cgroup_from_folio(folio);
> @@ -1455,54 +1459,52 @@ bool zswap_store(struct folio *folio)
>  		memcg = get_mem_cgroup_from_objcg(objcg);
>  		if (shrink_memcg(memcg)) {
>  			mem_cgroup_put(memcg);
> -			goto reject;
> +			goto put_objcg;
>  		}
>  		mem_cgroup_put(memcg);
>  	}
>  
>  	if (zswap_is_folio_zero_filled(folio)) {
>  		if (zswap_store_zero_filled(tree, offset, objcg))
> -			goto reject;
> +			goto put_objcg;
>  		goto stored;
>  	}
>  
>  	if (!zswap_non_zero_filled_pages_enabled)
> -		goto reject;
> +		goto put_objcg;
>  
>  	if (!zswap_check_limit())
> -		goto reject;
> +		goto put_objcg;
>  
> -	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> +	entry = zswap_entry_cache_alloc(folio_nid(folio));
>  	if (!entry) {
>  		zswap_reject_kmemcache_fail++;
> -		goto reject;
> +		goto put_objcg;
>  	}
>  
> -	/* if entry is successfully added, it keeps the reference */
>  	entry->pool = zswap_pool_current_get();
>  	if (!entry->pool)
> -		goto freepage;
> +		goto free_entry;
>  
>  	if (objcg) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);
>  		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
>  			mem_cgroup_put(memcg);
> -			goto put_pool;
> +			goto free_entry;
>  		}
>  		mem_cgroup_put(memcg);
>  	}
>  
>  	if (!zswap_compress(folio, entry))
> -		goto put_pool;
> -
> -	entry->swpentry = swp;
> -	entry->objcg = objcg;
> +		goto free_entry;
>  
>  	if (zswap_tree_store(tree, offset, entry))
> -		goto store_failed;
> +		goto free_entry;
>  
> -	if (objcg)
> +	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
> +		entry->objcg = objcg;
> +	}
>  
>  	/*
>  	 * We finish initializing the entry while it's already in xarray.
> @@ -1514,7 +1516,7 @@ bool zswap_store(struct folio *folio)
>  	 *    The publishing order matters to prevent writeback from seeing
>  	 *    an incoherent entry.
>  	 */
> -	INIT_LIST_HEAD(&entry->lru);
> +	entry->swpentry = swp;
>  	zswap_lru_add(&zswap_list_lru, entry);
>  
>  stored:
> @@ -1525,17 +1527,13 @@ bool zswap_store(struct folio *folio)
>  
>  	return true;
>  
> -store_failed:
> -	zpool_free(zswap_find_zpool(entry), entry->handle);
> -put_pool:
> -	zswap_pool_put(entry->pool);
> -freepage:
> -	zswap_entry_cache_free(entry);
> -reject:
> +free_entry:
> +	zswap_entry_free(entry);
> +put_objcg:
>  	obj_cgroup_put(objcg);
>  	if (zswap_pool_reached_full)
>  		queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +erase_old:
>  	/*
>  	 * If the zswap store fails or zswap is disabled, we must invalidate the
>  	 * possibly stale entry which was previously stored at this offset.

