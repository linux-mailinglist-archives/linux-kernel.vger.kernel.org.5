Return-Path: <linux-kernel+bounces-120210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056088D47E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014DB1F2E6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D888208BB;
	Wed, 27 Mar 2024 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpehwpH0"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAB1D52B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506087; cv=none; b=txhGPmCH4KZzGjjIVnMh1UPT9P13L/BoMUvPviXtw/WKrrEGEVAyMvRoCb/HGOD16lCdjHAhyAN+7Geq+k63PTLf/48b0DQzoUCdHYwVe8rc8DxYr6Rx47A8Rtz3icGfl34oYRwIpDJt3jvXMT6CuFvozQgC4rzEf/uWP7/9jkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506087; c=relaxed/simple;
	bh=v4x0Y7hSnISohPJpBvBc+/MOVgZqjd1Hsd5OKcuSH0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyuhSaL1S1JkZfdVqM9WMvn32bazAvwH8Bi1WvYDdWTb5FJp7wOy1gkgjwRfduMA6DyKQraJ4HQ7facHX7tE/Rktlxz6FP6hi0kfRd/JJdcWhjWIOU2+sUcg0VbtihAT93ltiQe1joGKyFkQ9FQNfEXO1gDDAiWnSWfcasvITLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpehwpH0; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e041120-cffb-42cd-8373-b254590f0e93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711506083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7kH22AwCzuZEuUkefxu0LWRPDiK+9VavfBLe/z9g4I=;
	b=vpehwpH0I+B9Vh7ynhlAvoaKoW0ELRndHaNhnJO6ezsgVlbZjiOXPomg9s5Lg+bdAF1lkD
	jWgTLTUVsXXqIRrXxyIBS4Zz9QyvrpjLIM/qpR3uBUrInSbuFqXi7tHjVCYUQyjBpkgd3O
	sTNregWkPZfKr9A4leNs7l5c9P8ysZ4=
Date: Wed, 27 Mar 2024 10:21:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/9] mm: zswap: always shrink in zswap_store() if
 zswap_pool_reached_full
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-2-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-2-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> The cleanup code in zswap_store() is not pretty, particularly the
> 'shrink' label at the bottom that ends up jumping between cleanup
> labels.
> 
> Instead of having a dedicated label to shrink the pool, just use
> zswap_pool_reached_full directly to figure out if the pool needs
> shrinking. zswap_pool_reached_full should be true if and only if the
> pool needs shrinking.
> 
> The only caveat is that the value of zswap_pool_reached_full may be
> changed by concurrent zswap_store() calls between checking the limit and
> testing zswap_pool_reached_full in the cleanup code. This is fine
> because:
> - If zswap_pool_reached_full was true during limit checking then became
>   false during the cleanup code, then someone else already took care of
>   shrinking the pool and there is no need to queue the worker. That
>   would be a good change.
> - If zswap_pool_reached_full was false during limit checking then became
>   true during the cleanup code, then someone else hit the limit
>   meanwhile. In this case, both threads will try to queue the worker,
>   but it never gets queued more than once anyway. Also, calling
>   queue_work() multiple times when the limit is hit could already happen
>   today, so this isn't a significant change in any way.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Looks good to me.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c4979c76d58e3..1cf3ab4b22e64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1429,12 +1429,12 @@ bool zswap_store(struct folio *folio)
>  	if (cur_pages >= max_pages) {
>  		zswap_pool_limit_hit++;
>  		zswap_pool_reached_full = true;
> -		goto shrink;
> +		goto reject;
>  	}
>  
>  	if (zswap_pool_reached_full) {
>  		if (cur_pages > zswap_accept_thr_pages())
> -			goto shrink;
> +			goto reject;
>  		else
>  			zswap_pool_reached_full = false;
>  	}
> @@ -1540,6 +1540,8 @@ bool zswap_store(struct folio *folio)
>  	zswap_entry_cache_free(entry);
>  reject:
>  	obj_cgroup_put(objcg);
> +	if (zswap_pool_reached_full)
> +		queue_work(shrink_wq, &zswap_shrink_work);
>  check_old:
>  	/*
>  	 * If the zswap store fails or zswap is disabled, we must invalidate the
> @@ -1550,10 +1552,6 @@ bool zswap_store(struct folio *folio)
>  	if (entry)
>  		zswap_entry_free(entry);
>  	return false;
> -
> -shrink:
> -	queue_work(shrink_wq, &zswap_shrink_work);
> -	goto reject;
>  }
>  
>  bool zswap_load(struct folio *folio)

