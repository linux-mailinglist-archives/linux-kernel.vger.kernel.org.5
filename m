Return-Path: <linux-kernel+bounces-104279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DA287CB93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CD1F229BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AFB1B270;
	Fri, 15 Mar 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oT4J9jEV"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DE1AADA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499402; cv=none; b=iOUPcljjfAWskraFm9n0kSkTS5ydPfeBo9gAy/De2LfQgnvTdpkwNhXQ/MOzmnl/7JDUCnVkLj8EmkBASgm/5oymMctM6QlelcsYq79vcrGBtn+q4c0501gP+hxGFdLb3+I6MYBR52wHodsWkOIxvATovaL6sX/EdEb0hXKaa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499402; c=relaxed/simple;
	bh=b1EsDs4Yb3bZWb3zk7JALLrf6EYU2C6HpbnZcyrZKp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjPlSvM68RajlNixom6UmbwsD4IjyHzyCKbpbuuaEUsO1j3SFfXnKr1YJ9SDtRpKorQtANxcWZ23KzvZW7SZuxdUFrCp9n/pQkexdWnZmI8Sq48czKVmWAGArr11Z2wK/oRE9+z6Z1haA/U3QQg5p17+jHqjcLkG6XVzQMnVFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oT4J9jEV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9c5c4128-3836-4b48-8fb8-8179d04fb5f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710499396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddo68Jue+hIogqwzsDAktZjXHMsAm2nR/AfZDU0RU38=;
	b=oT4J9jEVTVwQlCxVb+dYiN40pAqilo3L8PFbP8C+AVBkxocD4Lg8H873Sqx2LqSkdN55jd
	B0Zn8RtQehA0LHgX9cYvkL/LlS/AO7LxI/Y/D6fOqdJJ7wGouBEXv59xDkNv94+8WpoldI
	b93CvAjsL+kZ+qiSBJq1axqho8zbVoo=
Date: Fri, 15 Mar 2024 18:43:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: cachestat: fix two shmem bugs
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20240314164941.580454-1-hannes@cmpxchg.org>
 <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
 <20240315093010.GB581298@cmpxchg.org>
 <ae197190-6a15-49c5-ab3c-3eaac6dd4c5c@linux.dev>
 <20240315095556.GC581298@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240315095556.GC581298@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/15 17:55, Johannes Weiner wrote:
> When cachestat on shmem races with swapping and invalidation, there
> are two possible bugs:
> 
> 1) A swapin error can have resulted in a poisoned swap entry in the
>    shmem inode's xarray. Calling get_shadow_from_swap_cache() on it
>    will result in an out-of-bounds access to swapper_spaces[].
> 
>    Validate the entry with non_swap_entry() before going further.
> 
> 2) When we find a valid swap entry in the shmem's inode, the shadow
>    entry in the swapcache might not exist yet: swap IO is still in
>    progress and we're before __remove_mapping; swapin, invalidation,
>    or swapoff have removed the shadow from swapcache after we saw the
>    shmem swap entry.
> 
>    This will send a NULL to workingset_test_recent(). The latter
>    purely operates on pointer bits, so it won't crash - node 0, memcg
>    ID 0, eviction timestamp 0, etc. are all valid inputs - but it's a
>    bogus test. In theory that could result in a false "recently
>    evicted" count.
> 
>    Such a false positive wouldn't be the end of the world. But for
>    code clarity and (future) robustness, be explicit about this case.
> 
>    Bail on get_shadow_from_swap_cache() returning NULL.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: stable@vger.kernel.org				[v6.5+]
> Reported-by: Chengming Zhou <chengming.zhou@linux.dev>	[Bug #1]
> Reported-by: Jann Horn <jannh@google.com>		[Bug #2]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good to me.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/filemap.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 222adac7c9c5..0aa91bf6c1f7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4198,7 +4198,23 @@ static void filemap_cachestat(struct address_space *mapping,
>  				/* shmem file - in swap cache */
>  				swp_entry_t swp = radix_to_swp_entry(folio);
>  
> +				/* swapin error results in poisoned entry */
> +				if (non_swap_entry(swp))
> +					goto resched;
> +
> +				/*
> +				 * Getting a swap entry from the shmem
> +				 * inode means we beat
> +				 * shmem_unuse(). rcu_read_lock()
> +				 * ensures swapoff waits for us before
> +				 * freeing the swapper space. However,
> +				 * we can race with swapping and
> +				 * invalidation, so there might not be
> +				 * a shadow in the swapcache (yet).
> +				 */
>  				shadow = get_shadow_from_swap_cache(swp);
> +				if (!shadow)
> +					goto resched;
>  			}
>  #endif
>  			if (workingset_test_recent(shadow, true, &workingset))

