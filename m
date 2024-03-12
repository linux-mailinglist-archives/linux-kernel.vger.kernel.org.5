Return-Path: <linux-kernel+bounces-99832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC292878E08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C64C28279C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977D3FE46;
	Tue, 12 Mar 2024 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wrx7O/+3"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5C3FB81
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219407; cv=none; b=ue23+A3NqiOYfJ+f1/PfNtvTs62OhMWYRLVRvPev/+Cm/Rs24eEYtM39UX7j9PHLwTPUfH+cZwJqcYe33y3XP/pqce1MrKJZ5Hv4bYrMCprEDsZ/IqQ0iQq+6oUzuIcFauFouJqbc16rRaplwdnZLRJa7wJ01VSvZUxajpq+vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219407; c=relaxed/simple;
	bh=mzgU+nStrjJoWqCQO1AwyeENQKZDP1kBTG++YrAOUM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUouEF/zBqBUFmMV53zAhBhOJyb1UeoZZjsunXku28AoY56T3ySNDlmlafoxqg96uacH+thUYKteebALWRxaCLRqxhguySKXTCWffGJt6Qsytepm79ZWdt8xzAIWTXnXVQLpKR3WpSG9xk6U6hQ66U626ziHSC05yWEhzrduC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wrx7O/+3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02886208-06df-4370-b0a1-6295b654bea2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710219403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjdG0PtOxjtchDedrvDz9Mya7+ckepXI9cgYn3cZEtQ=;
	b=wrx7O/+3WGmpKxjSrJwL+tAIQeQh6DYEDgz6mr0ByLRlBUOlyx5q6AStc4k4GmkhLyHl78
	QJoKuwN9FwpP4mPTaxP91IFqdYcTuBMT9T25nLm2RFIsO0Iu8bwAJGnvCFn7A5MMaK744X
	0ykcakWwMcBNE4XbzmV84x5Z1rtlEHk=
Date: Tue, 12 Mar 2024 12:56:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm: zpool: return pool size in pages
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
 <20240311161214.1145168-2-hannes@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240311161214.1145168-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/12 00:12, Johannes Weiner wrote:
> All zswap backends track their pool sizes in pages. Currently they
> multiply by PAGE_SIZE for zswap, only for zswap to divide again in
> order to do limit math. Report pages directly.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

With the incremental diff, feel free to add:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/z3fold.c   | 2 +-
>  mm/zbud.c     | 2 +-
>  mm/zpool.c    | 4 ++--
>  mm/zsmalloc.c | 2 +-
>  mm/zswap.c    | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 7ab05621052d..9bacacd4168c 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1404,7 +1404,7 @@ static void z3fold_zpool_unmap(void *pool, unsigned long handle)
>  
>  static u64 z3fold_zpool_total_size(void *pool)
>  {
> -	return z3fold_get_pool_size(pool) * PAGE_SIZE;
> +	return z3fold_get_pool_size(pool);
>  }
>  
>  static struct zpool_driver z3fold_zpool_driver = {
> diff --git a/mm/zbud.c b/mm/zbud.c
> index 2190cc1f37b3..b7d8a22bbf5f 100644
> --- a/mm/zbud.c
> +++ b/mm/zbud.c
> @@ -412,7 +412,7 @@ static void zbud_zpool_unmap(void *pool, unsigned long handle)
>  
>  static u64 zbud_zpool_total_size(void *pool)
>  {
> -	return zbud_get_pool_size(pool) * PAGE_SIZE;
> +	return zbud_get_pool_size(pool);
>  }
>  
>  static struct zpool_driver zbud_zpool_driver = {
> diff --git a/mm/zpool.c b/mm/zpool.c
> index 846410479c2f..410808aee7fe 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -324,9 +324,9 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
>   * zpool_get_total_size() - The total size of the pool
>   * @zpool:	The zpool to check
>   *
> - * This returns the total size in bytes of the pool.
> + * This returns the total size in pages of the pool.
>   *
> - * Returns: Total size of the zpool in bytes.
> + * Returns: Total size of the zpool in pages.
>   */
>  u64 zpool_get_total_size(struct zpool *zpool)
>  {
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 7d7cb3eaabe0..398f3856817f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -401,7 +401,7 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
>  
>  static u64 zs_zpool_total_size(void *pool)
>  {
> -	return zs_get_total_pages(pool) << PAGE_SHIFT;
> +	return zs_get_total_pages(pool);
>  }
>  
>  static struct zpool_driver zs_zpool_driver = {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7c39327a7cc2..fe4343e416e0 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -507,7 +507,7 @@ static unsigned long zswap_max_pages(void)
>  unsigned long zswap_total_pages(void)
>  {
>  	struct zswap_pool *pool;
> -	u64 total = 0;
> +	unsigned long total = 0;
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(pool, &zswap_pools, list) {
> @@ -518,7 +518,7 @@ unsigned long zswap_total_pages(void)
>  	}
>  	rcu_read_unlock();
>  
> -	return total >> PAGE_SHIFT;
> +	return total;
>  }
>  
>  /*********************************

