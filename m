Return-Path: <linux-kernel+bounces-110890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD2886543
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18AD1C2190F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E014C79;
	Fri, 22 Mar 2024 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCW4WnR5"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91334A04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075608; cv=none; b=StkfumJBAaXTsWBEHqlocVYJdAaOq4kOjIZfosbkrMysee/p19Ecfkx+ci8Tt2qP+v1tlaszfepMePAc4mlOPahyQ/3E7aHXA+xHkele7rCWtHrW9V9Yk5R5Z/Q/WlHbeeI4bVxxMZuhvqYFWeLVRxxnlvkGCHl2ttxiok3OgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075608; c=relaxed/simple;
	bh=tkyB+FM/VrG/1L8NIKR4/T0uL2VWd4/bC475DQiTEg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsNkpVVOncZN5Zs+qE1xxZHU7CzZkA+O3BSuiYEedWBVjx4Py6G+QmjYOTCCXp26JmaFfhlzwyMtGGXBOkBpQzOIqYC4LqLJaUqdUX5+XMYO4TTyGR5QGg5BygaQhO0fgDFknZ0wzo7Ksa3cPgzPY8TM/Fh/vSIpLY+CvcTmiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCW4WnR5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f94500bd-052f-476c-a70d-c5f8a5302e53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711075604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzzBekYoUzykx0Ul4jjjQfRti9FFLx15M7jeNES4TuQ=;
	b=tCW4WnR5qvmQ+A4j7Kn75ZnkWF52cjGjFZee4JG+ktwYfATV9aUnQI5iWGDiwPZxyXwWFu
	ChjDLRrMIiLtTMAX/2+MRWAP9p85t5pB3s5gVcbcXslRi0wpfiJq6gqgk/Z6vyl8LO6gEN
	iTK657CEAbuONWolsDOYyDSMq1WBF2M=
Date: Fri, 22 Mar 2024 10:46:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: zswap: remove nr_zswap_stored atomic
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240322001001.1562517-1-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240322001001.1562517-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/22 08:10, Yosry Ahmed wrote:
> nr_stored was introduced by commit b5ba474f3f51 ("zswap: shrink zswap
> pool based on memory pressure") as a per zswap_pool counter of the
> number of stored pages that are not same-filled pages. It is used in
> zswap_shrinker_count() to scale the number of freeable compressed pages
> by the compression ratio.  That is, to reduce the amount of writeback
> from zswap with higher compression ratios as the ROI from IO diminishes.
> 
> Later on, commit bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared
> by all zswap_pools") made the shrinker global (not per zswap_pool), and
> replaced nr_stored with nr_zswap_stored (initially introduced as
> zswap.nr_stored), which is now a global counter.
> 
> The counter is now awfully close to zswap_stored_pages. The only
> difference is that the latter also includes same-filled pages. Also,
> when memcgs are enabled, we use memcg_page_state(memcg, MEMCG_ZSWAPPED),
> which includes same-filled pages anyway (i.e.  equivalent to
> zswap_stored_pages).
> 
> Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
> consistent whether memcgs are enabled or not, and add a comment about
> the number of freeable pages possibly being scaled down more than it
> should if we have lots of same-filled pages (i.e. inflated compression
> ratio).
> 
> Remove nr_zswap_stored and one atomic operation in the store and free
> paths.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b31c977f53e9c..1a79f99606cef 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -181,8 +181,6 @@ struct zswap_pool {
>  
>  /* Global LRU lists shared by all zswap pools. */
>  static struct list_lru zswap_list_lru;
> -/* counter of pages stored in all zswap pools. */
> -static atomic_t zswap_nr_stored = ATOMIC_INIT(0);
>  
>  /* The lock protects zswap_next_shrink updates. */
>  static DEFINE_SPINLOCK(zswap_shrink_lock);
> @@ -885,7 +883,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	else {
>  		zswap_lru_del(&zswap_list_lru, entry);
>  		zpool_free(zswap_find_zpool(entry), entry->handle);
> -		atomic_dec(&zswap_nr_stored);
>  		zswap_pool_put(entry->pool);
>  	}
>  	if (entry->objcg) {
> @@ -1310,7 +1307,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  #else
>  	/* use pool stats instead of memcg stats */
>  	nr_backing = zswap_total_pages();
> -	nr_stored = atomic_read(&zswap_nr_stored);
> +	nr_stored = atomic_read(&zswap_stored_pages);
>  #endif
>  
>  	if (!nr_stored)
> @@ -1330,6 +1327,11 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  	 * This ensures that the better zswap compresses memory, the fewer
>  	 * pages we will evict to swap (as it will otherwise incur IO for
>  	 * relatively small memory saving).
> +	 *
> +	 * The memory saving factor calculated here takes same-filled pages into
> +	 * account, but those are not freeable since they almost occupy no
> +	 * space. Hence, we may scale nr_freeable down a little bit more than we
> +	 * should if we have a lot of same-filled pages.
>  	 */
>  	return mult_frac(nr_freeable, nr_backing, nr_stored);
>  }
> @@ -1575,7 +1577,6 @@ bool zswap_store(struct folio *folio)
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap_list_lru, entry);
> -		atomic_inc(&zswap_nr_stored);
>  	}
>  	spin_unlock(&tree->lock);
>  

