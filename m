Return-Path: <linux-kernel+bounces-65876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2F855327
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47151F217F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776113AA5E;
	Wed, 14 Feb 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmaS6Mdf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A680134738
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938447; cv=none; b=l9fVAnpDLP/8C0kt4DxYEnU0oyGdQYeuU6w6Ut59Ynbt+b+iqZ+7xmDspcGHb2K5IMgtA7rsEzxuiPh8a50TV13eMnVHSRE6HUbTSvdH4HKAmH3K5RG1dUo9G5tEp3IxVWB+znAlxGPpesGqk8Sh8ALXCpgHcV3SFTiFIPufU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938447; c=relaxed/simple;
	bh=mLhKSThWNBsAgqj+wm1xVzGaoOhMAV4m0QcyCJ1ZIfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XACXWrdQv+eh+j6vdICVbO1JrMO8et0EVXDJmMDKOJdx2HGxWBM+kb397D9TxXOQ1MqXkOfWltu+rNG+62FfUtpq0phd82lfCFkPaQkosS4vLzlQa1L4+lI2c3c4EkIPtNA0LPpqt8+IBwfmLOU+Vcf6+De6akrxDJ8pJuZvDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmaS6Mdf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso10815276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707938444; x=1708543244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAjX6cjzXezxso5mboiYm7K+A2aJaJqFnNgHNs+0SmU=;
        b=pmaS6Mdf97ZzDJjLSu+DcN4xGnruIzrFd3Nq/FrzWx36ELYuwxrUema976y0wDzPd1
         vKaJXddH24xlyyoNUV5ZyVMReim3u4IcUcU8EyZnvHxTsX2jVdVwQv1/O2TqG59TiXCH
         nSDkmQV9Yay/bvHAhs5xTyo0KZD8DhsG++B/IKcNoc6Uy0RKLlFzn+g+B/nH+qFokOu+
         6tANi835bSf3zGvqwsQdRTvf574795S0R3+ah7d58SJeM1A4qkHZjHrewPwuLMvZt9Rv
         Gn40bUQvsYyYkoAZteNFjlIHCwvVgtX6zl+51HkyK/zGbBVgfX/38r0AHyAywFNiV5yw
         ZKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938444; x=1708543244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAjX6cjzXezxso5mboiYm7K+A2aJaJqFnNgHNs+0SmU=;
        b=RGLdm8RP+sSTq9P7XAzNsEzGzQPtQvJrrnq8xKO/l7g2ElsXAdpNFYrgMDSxuwRtqL
         AOH7xBfz+/iwLCfNdn0G+JbsBDekUXFGlR1QWAPWlasETKfHuWZYFGEbYoqdU08RxSmv
         U/9aoZvrlao9zvUUAMYen3/18xociZVIzlOtwZ8PH4chXjmNrZwbhGKLonKxLIg3xK9m
         MHM9EfitqcjCmzFZiDhOwhZGwV9yjjxxYN0/U+UZHkctSJ6AG0iNIWy7FV8wtXftfxkv
         R2d7c67fEGvvj2WTBItMoFtG31s9GQ1ncvWkiIC/LPuz1Afreiu9I2123/2NfWOYnvcK
         GMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWNUHb499Dhhd4AALPqT0hJiFB6nefJ8hGerAB/wvac6HHIAM3ZBPqPamlvlv90atCoqx8gEsf62J8ybCXYCiunpH+l5dyDilXV9ovy
X-Gm-Message-State: AOJu0Yz+SoY6oR4BgAel2SPZIJs9L+M13nPZVx/ukhc+xuEGQmBQVH5F
	mHDFKLVF3xEUyTo4jzvv8xf2AGzoLyPG+VGnCxioKusYfkCmDIH750GBBB1M7TMHB53lWcX0iwy
	d9c9lJkyzbaugqQAwAQ==
X-Google-Smtp-Source: AGHT+IG4cf16vGGDe/S2yO28fy0rp6cQJ+6K4Ey93242LRfpUYLtWyDQrpE/+vrDqxsVt0h8q4aXCwbewraQ2c04
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1894:b0:dc6:d233:ffdd with
 SMTP id cj20-20020a056902189400b00dc6d233ffddmr751295ybb.0.1707938444372;
 Wed, 14 Feb 2024 11:20:44 -0800 (PST)
Date: Wed, 14 Feb 2024 19:20:42 +0000
In-Reply-To: <20240210-zswap-global-lru-v2-1-fbee3b11a62e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com> <20240210-zswap-global-lru-v2-1-fbee3b11a62e@bytedance.com>
Message-ID: <Zc0Silj_TKkUBRBF@google.com>
Subject: Re: [PATCH v2 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 14, 2024 at 08:54:37AM +0000, Chengming Zhou wrote:
> Dynamic zswap_pool creation may create/reuse to have multiple
> zswap_pools in a list, only the first will be current used.
> 
> Each zswap_pool has its own lru and shrinker, which is not
> necessary and has its problem:
> 
> 1. When memory has pressure, all shrinker of zswap_pools will
>    try to shrink its own lru, there is no order between them.
> 
> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>    will try to shrink its lru, which is inefficient.

I think the rationale here was to try and empty the old pool first so
that we can completely drop it. However, since we only support exclusive
loads now, the LRU ordering should be entirely decided by the order of
stores, so I think the oldest entries on the LRU will naturally be the
from the oldest pool, right?

Probably worth stating this.

> 
> Anyway, having a global lru and shrinker shared by all zswap_pools
> is better and efficient.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM with a few comments, with those:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 170 +++++++++++++++++++++++--------------------------------------
>  1 file changed, 65 insertions(+), 105 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c9..dbff67d7e1c7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -176,14 +176,18 @@ struct zswap_pool {
>  	struct kref kref;
>  	struct list_head list;
>  	struct work_struct release_work;
> -	struct work_struct shrink_work;
>  	struct hlist_node node;
>  	char tfm_name[CRYPTO_MAX_ALG_NAME];
> +};
> +
> +static struct {
>  	struct list_lru list_lru;
> -	struct mem_cgroup *next_shrink;
> -	struct shrinker *shrinker;
>  	atomic_t nr_stored;
> -};
> +	struct shrinker *shrinker;
> +	struct work_struct shrink_work;
> +	struct mem_cgroup *next_shrink;
> +	spinlock_t shrink_lock;

The lock is exclusively protecting next_shrink, right? Perhaps we should
rename it to next_shrink_lock or at least document this.

> +} zswap;
>  
>  /*
>   * struct zswap_entry
> @@ -301,9 +305,6 @@ static void zswap_update_total_size(void)
>  * pool functions
>  **********************************/
>  
> -static void zswap_alloc_shrinker(struct zswap_pool *pool);
> -static void shrink_worker(struct work_struct *w);
> -
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  {
>  	int i;
> @@ -353,30 +354,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	if (ret)
>  		goto error;
>  
> -	zswap_alloc_shrinker(pool);
> -	if (!pool->shrinker)
> -		goto error;
> -
> -	pr_debug("using %s compressor\n", pool->tfm_name);

nit: the next patch introduces a new failure case between this debug
print and zswap_pool_debug() below, so it will become possible again
that we get one and not the other. Not a big deal though.

> -
>  	/* being the current pool takes 1 ref; this func expects the
>  	 * caller to always add the new pool as the current pool
>  	 */
>  	kref_init(&pool->kref);
>  	INIT_LIST_HEAD(&pool->list);
> -	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
> -		goto lru_fail;
> -	shrinker_register(pool->shrinker);
> -	INIT_WORK(&pool->shrink_work, shrink_worker);
> -	atomic_set(&pool->nr_stored, 0);
>  
>  	zswap_pool_debug("created", pool);
>  
>  	return pool;
>  
> -lru_fail:
> -	list_lru_destroy(&pool->list_lru);
> -	shrinker_free(pool->shrinker);
>  error:
>  	if (pool->acomp_ctx)
>  		free_percpu(pool->acomp_ctx);

