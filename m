Return-Path: <linux-kernel+bounces-65918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3098553B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E961C2885B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1313DBAB;
	Wed, 14 Feb 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltY21g8M"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240413DBA1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941420; cv=none; b=IWv4BeqQ73+HdpmVpi6cqSLTF//ueulwwaqaytUflisYwVRHjgV04D9+mxX8x8G7Z+ezcQ/6WWsOLcFMgjlDhA/kacrBvvekQyoy55J3Hikeyb4bn9jH0LWqQCkO31UrPUg8vYBUaWE7R+goqFsXDfYYVBMUTVhM8lyIibWGtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941420; c=relaxed/simple;
	bh=MgBTwy2ApMR4PJ2TUI7t6MHy1tL2iE3qgNZIrilFfl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EGlbZGXEhlOisz0bboKJKDBDgD7F6DSa06amqi5rBmgP4x1eGd5SYKYzpwyeja+tbfPyQSlAYEjuELAbjfzbYT+hREl8AFb3K7xdp6mw0nb1xnUWYZA7lyl757OVgpElLHkabzvyBICTcz6YUaqqcVb4cDvxvmsQ0FKPsDUfb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltY21g8M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso3073317b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707941417; x=1708546217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3emXcyJNvJgc1uWaTQMfWeSm7Af4PAyEZnHoBa2y9Y=;
        b=ltY21g8M9OWh/tRYc3nxgWUXYzranBzGSiiTKuQx0dSCnGRAgbbk+ubqTVEfyyO9cu
         PNaoyUfCrk486XBgsO4fKqH4Lta5gsUlqV2nLYS3uQALiwFH1xKeo7RB0WesjeeKd50b
         ZSHbvpyb+UKuspIllkFsWEHIiZIRYH+s9DsY3uFn9FGA8ZgOwb3QJYuFtIeAGruQIIn2
         /ERbOg9dQuWHJ4if6glakeHP0tJSRXnGUZ/nlLsbddAYvtxhieNAaZRRmqJ99NVV2gXU
         /rH3+aLab/hhns3JpEii0uOz0qUCDGK+zJwuI/I9PsjCYk12ki5G1IVP+4S/j+aurs85
         HwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941417; x=1708546217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3emXcyJNvJgc1uWaTQMfWeSm7Af4PAyEZnHoBa2y9Y=;
        b=e7XqZEu5EtJ2mgBTJq7dGw2T/TBBEE5LOEC80M7+bblFMdmfd7XgNULDzEjug5hDSE
         OQUsyTO/E+wpzr4Jmk3W37a3wBcyOkLcjieNV0m56f2heOMfyKVolOlVgwGZtHAQ6KCj
         2P8I0xd/Deb1JnpoFUGQpsf4QAI6wZ6mbPyRJtTp9xxvYB2CBB3CnUwirBsJcKnRVmy6
         fgs9nyLc7t5JHHiPz9pkY95Auuk/bDihpCKgoztJEaj1qUXWFsqXTOgaOmZm0DzQEVaS
         KtcGgneIoQSmRv8vycHi1iu4QrvyVni4YDsce83kCuTEFMdQUOCSCs2bcPI4O8o+7hrp
         AOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUed+BKQpEWS1Jfbb6zVGKpgjw1Y7UyXYyUC0JmuD0nEaUCQ8DSn0Joc/gE9fnuEDPIq4iisfWAvVVolNwIr745G1eCknv/pEBF0YaO
X-Gm-Message-State: AOJu0YyAkolosuTg4vcFaXZY3vjQ44Z49COM8juBK7ZnPFTOrFgsIVSP
	eYApdbR68svS2CBf0Thz+KKXhVqYKV6oJW4E+S3em+kynTaOJ5p6VkOo2YWnsehzIYbuQkpsTwD
	RiM7u++WoPCRKzxhD3w==
X-Google-Smtp-Source: AGHT+IHBLukHbP00sGK4xmHtUcurDGukWxk53yrUcFWOBVYTNAm6XckUHU8SZszcT68dDDhBzLftJHp7gQoTkb1b
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:d842:0:b0:dc6:e8a7:fdba with SMTP
 id p63-20020a25d842000000b00dc6e8a7fdbamr754527ybg.4.1707941417656; Wed, 14
 Feb 2024 12:10:17 -0800 (PST)
Date: Wed, 14 Feb 2024 20:10:15 +0000
In-Reply-To: <20240210-zswap-global-lru-v2-2-fbee3b11a62e@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com> <20240210-zswap-global-lru-v2-2-fbee3b11a62e@bytedance.com>
Message-ID: <Zc0eJ84FeR9yQ99T@google.com>
Subject: Re: [PATCH v2 2/2] mm/zswap: change zswap_pool kref to percpu_ref
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 14, 2024 at 08:54:38AM +0000, Chengming Zhou wrote:
> All zswap entries will take a reference of zswap_pool when
> zswap_store(), and drop it when free. Change it to use the
> percpu_ref is better for scalability performance.
> 
> Although percpu_ref use a bit more memory which should be ok
> for our use case, since we almost have only one zswap_pool to
> be using. The performance gain is for zswap_store/load hotpath.
> 
> Testing kernel build (32 threads) in tmpfs with memory.max=2GB.
> (zswap shrinker and writeback enabled with one 50GB swapfile,
> on a 128 CPUs x86-64 machine, below is the average of 5 runs)
> 
>         mm-unstable  zswap-global-lru
> real    63.20        63.12
> user    1061.75      1062.95
> sys     268.74       264.44
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index dbff67d7e1c7..f6470d30d337 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
>  struct zswap_pool {
>  	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>  	struct crypto_acomp_ctx __percpu *acomp_ctx;
> -	struct kref kref;
> +	struct percpu_ref ref;
>  	struct list_head list;
>  	struct work_struct release_work;
>  	struct hlist_node node;
> @@ -304,6 +304,7 @@ static void zswap_update_total_size(void)
>  /*********************************
>  * pool functions
>  **********************************/
> +static void __zswap_pool_empty(struct percpu_ref *ref);
>  
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  {
> @@ -357,13 +358,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	/* being the current pool takes 1 ref; this func expects the
>  	 * caller to always add the new pool as the current pool
>  	 */
> -	kref_init(&pool->kref);
> +	ret = percpu_ref_init(&pool->ref, __zswap_pool_empty,
> +			      PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
> +	if (ret)
> +		goto ref_fail;
>  	INIT_LIST_HEAD(&pool->list);
>  
>  	zswap_pool_debug("created", pool);
>  
>  	return pool;
>  
> +ref_fail:
> +	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
>  error:
>  	if (pool->acomp_ctx)
>  		free_percpu(pool->acomp_ctx);
> @@ -436,8 +442,9 @@ static void __zswap_pool_release(struct work_struct *work)
>  
>  	synchronize_rcu();
>  
> -	/* nobody should have been able to get a kref... */
> -	WARN_ON(kref_get_unless_zero(&pool->kref));
> +	/* nobody should have been able to get a ref... */
> +	WARN_ON(percpu_ref_tryget(&pool->ref));

Just curious, was there any value from using kref_get_unless_zero() over
kref_read() here? If not, I think percpu_ref_is_zero() is more
intuitive. This also seems like it fits more as a debug check.

> +	percpu_ref_exit(&pool->ref);
>  
>  	/* pool is now off zswap_pools list and has no references. */
>  	zswap_pool_destroy(pool);
> @@ -445,11 +452,11 @@ static void __zswap_pool_release(struct work_struct *work)
>  
>  static struct zswap_pool *zswap_pool_current(void);
>  
> -static void __zswap_pool_empty(struct kref *kref)
> +static void __zswap_pool_empty(struct percpu_ref *ref)
>  {
>  	struct zswap_pool *pool;
>  
> -	pool = container_of(kref, typeof(*pool), kref);
> +	pool = container_of(ref, typeof(*pool), ref);
>  
>  	spin_lock(&zswap_pools_lock);
>  
> @@ -468,12 +475,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
>  	if (!pool)
>  		return 0;
>  
> -	return kref_get_unless_zero(&pool->kref);
> +	return percpu_ref_tryget(&pool->ref);
>  }
>  
>  static void zswap_pool_put(struct zswap_pool *pool)
>  {
> -	kref_put(&pool->kref, __zswap_pool_empty);
> +	percpu_ref_put(&pool->ref);
>  }
>  
>  static struct zswap_pool *__zswap_pool_current(void)
> @@ -603,6 +610,12 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  
>  	if (!pool)
>  		pool = zswap_pool_create(type, compressor);
> +	else {
> +		/* Resurrect percpu_ref to percpu mode. */
> +		percpu_ref_resurrect(&pool->ref);

I think this is not very clear. The previous code relied on the ref from
zswap_pool_find_get() to replace the initial ref that we had dropped
before. This is not needed with percpu_ref_resurrect() because it
already restores the initial ref dropped by percpu_ref_kill().

Perhaps something like:
		/*
		 * Restore the initial ref dropped by percpu_ref_kill()
		 * when the pool was decommissioned and switch it again
		 * to percpu mode.
		 /

, or am I overthinking this?

> +		/* Drop the ref from zswap_pool_find_get(). */
> +		zswap_pool_put(pool);
> +	}
>  
>  	if (pool)
>  		ret = param_set_charp(s, kp);
> @@ -641,7 +654,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  	 * or the new pool we failed to add
>  	 */
>  	if (put_pool)
> -		zswap_pool_put(put_pool);
> +		percpu_ref_kill(&put_pool->ref);
>  
>  	return ret;
>  }
> 
> -- 
> b4 0.10.1

