Return-Path: <linux-kernel+bounces-61695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A076851573
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A8280F76
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4553C070;
	Mon, 12 Feb 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sn0aw+Rs"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965D3A8C5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744601; cv=none; b=VTRqmDHpNhUx1z3GSzEMPM5XD8uW523SCiUo10EdNLSgOdyZanAmYQNexZV7FVJ5c/x0pTK4ewvGpzCbIFsv1vt0vnqdKjBeoqSFN9nuhOpxf7e9ZYFjglm+l/54rAOe8b60hHDHRiI3Fa95FTwlP9eBAzEftjxxwDdZgzj9cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744601; c=relaxed/simple;
	bh=36NEYkg3cH91XI3+kP+odtUoZAhBvH9xrtISWI8Oqys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xk+kJHLULJK8hWpUZHRsV4GfUPaklJAMitIWtN0k4N/JBbw7x7PPKdgQIdiepi3z8zlYBR17wgpZc6yUtOHQHr/iPt+XeeP05afYs0HDJmbzujf3ng5JBsCGEdab+D1YlFE/SGB/nd4PTdsKCGCFFBbZv/NbDFKAfU9s5+4nRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sn0aw+Rs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e09ea155c5so1386721b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707744598; x=1708349398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKUN4IUfFGbPYG1DZS84NOyg5JfyapaOpinkqXF+JM0=;
        b=Sn0aw+RsUxK7WKoVk91bddiuzBcdqwBHe99e1AYMFEn7AVVknWIB+zHG3H9OGLxwdK
         rq8r6OKmYfKhvgQLldEj0RQrA+U0vgEyNKjAWWwinW3P21KcCGguBkKJ/ZL0Dzv1zBkZ
         r/TdHWipmOG6bu+FIqGe3UBAx7ttB04uz95odFEh28zVQJzp9hdV9iS9AU6r2SKHQiUx
         rV/SqbS0tVdo5y3wtI5pCPLrXixvpdqwPVUO9uVuCsDNWQFZ/+Zu2DOIgr5lq7t/iFCH
         dJtZjHrGUnEaQMvVz9Wv13YUGe0wLe+8dZzMgrpCHYGIRLpoq327mugCI/te2s2M27Ku
         38IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744598; x=1708349398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKUN4IUfFGbPYG1DZS84NOyg5JfyapaOpinkqXF+JM0=;
        b=Sk+lRQG1k+5b1iF0v/g/FDHnRddkty/i281oL894D8DOHQSLzedFH5eAk0JASEqrmx
         JDTtuDQh8VqgPVgSowhJ2p9hMDfPcMhosG7FDfuVegpv7pkUlLrpoRrqKRtFlq4fVPCX
         DZMAqXJ6ChdHf98lSopEATLpkfhosBCU14CKitAxnibMOJit+QOSqkZvta9+CujykuQ/
         xOtPGXdCOufQyAi3St9Ahk5Ew/55SBkEo+MOaZX90YqwdmTAe2SxO7ET6bsWxItFilb+
         iu3I1DJvxJP9Ai02pY9ZUhQ/NFvSe2Hk/+fUUL2VEMDUwF2CCTij1e4dhBBnfnhUiQNA
         jIpg==
X-Forwarded-Encrypted: i=1; AJvYcCUOSavayK0fVifQKZnogAmvLTkQw9CUZWVqu2KqBZKL3ezmdFBVpqqDYz61QxME1eex6AAhvHRwjdb8EVR6LGzUuK+Uy9ZXPu7uGIIW
X-Gm-Message-State: AOJu0Yw3wG7IIl/Cqy3IzdyXNGc5WTg0mqa3G0qQbFnZhEJ+nG/jpSPd
	DpBdK729aRcgrC5uaecHzTew6TlDK0VsjAa0Y9ZHf5Dgm+WzNRcKiHrc9U/R6MQ=
X-Google-Smtp-Source: AGHT+IGi6Ui1vWJezQAjjN3CWL31a2SBj0Cftg5aYyGE6A6tBfoTbuVN6Gxdxxdn49WEkfaRgLladQ==
X-Received: by 2002:a05:6a00:9097:b0:6e0:6dbb:38f6 with SMTP id jo23-20020a056a00909700b006e06dbb38f6mr7154294pfb.13.1707744598322;
        Mon, 12 Feb 2024 05:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiDAJrOiEqYdoEXPkZdyq/ALpytRtiTRbKZQm/x9Ss+j4ivlFjCCD/j0Iq6oU5L5bM+QC2TrqTJZMj1OZH9cIGGCczCeyuqXRp4km4Hwk5AurshT9Eqoibrk8X/NKR5BCoZmmOOWex8QXXOy5ZOlpEcM8HjeJWnTr1UG4/WLYYnWn11AU2CTxyQlDI
Received: from [10.255.183.165] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t10-20020a62d14a000000b006dbda1b19f7sm5730969pfl.159.2024.02.12.05.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:29:57 -0800 (PST)
Message-ID: <900cd5da-da96-4107-b5f0-c7d975a8ba97@bytedance.com>
Date: Mon, 12 Feb 2024 21:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
 <CAKEwX=MCkhH2Qa2+dGErpo2e_27=HyyVeEDWVO=+O6D-7mRQ1Q@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=MCkhH2Qa2+dGErpo2e_27=HyyVeEDWVO=+O6D-7mRQ1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/12 05:21, Nhat Pham wrote:
> On Sun, Feb 11, 2024 at 5:58 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> All zswap entries will take a reference of zswap_pool when
>> zswap_store(), and drop it when free. Change it to use the
>> percpu_ref is better for scalability performance.
>>
>> Testing kernel build in tmpfs with memory.max=2GB
>> (zswap shrinker and writeback enabled with one 50GB swapfile).
>>
>>         mm-unstable  zswap-global-lru
>> real    63.20        63.12
>> user    1061.75      1062.95
>> sys     268.74       264.44
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 7668db8c10e3..afb31904fb08 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
>>  struct zswap_pool {
>>         struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>> -       struct kref kref;
>> +       struct percpu_ref ref;
>>         struct list_head list;
>>         struct work_struct release_work;
>>         struct hlist_node node;
>> @@ -303,6 +303,7 @@ static void zswap_update_total_size(void)
>>  /*********************************
>>  * pool functions
>>  **********************************/
>> +static void __zswap_pool_empty(struct percpu_ref *ref);
>>
>>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  {
>> @@ -356,13 +357,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>         /* being the current pool takes 1 ref; this func expects the
>>          * caller to always add the new pool as the current pool
>>          */
>> -       kref_init(&pool->kref);
>> +       ret = percpu_ref_init(&pool->ref, __zswap_pool_empty,
>> +                             PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
>> +       if (ret)
>> +               goto ref_fail;
>>         INIT_LIST_HEAD(&pool->list);
>>
>>         zswap_pool_debug("created", pool);
>>
>>         return pool;
>>
>> +ref_fail:
>> +       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
>>  error:
>>         if (pool->acomp_ctx)
>>                 free_percpu(pool->acomp_ctx);
>> @@ -435,8 +441,8 @@ static void __zswap_pool_release(struct work_struct *work)
>>
>>         synchronize_rcu();
>>
>> -       /* nobody should have been able to get a kref... */
>> -       WARN_ON(kref_get_unless_zero(&pool->kref));
> 
> Do we no longer care about this WARN? IIUC, this is to catch someone
> still holding a reference to the pool at release time, which sounds
> like a bug. I think we can simulate the similar behavior with:

Ok, I thought it has already been put to 0 when we're here, so any tryget
will fail. But keeping this WARN_ON() is also fine to me, will keep it.

Thanks.

> 
> WARN_ON(percpu_ref_tryget(&pool->ref))
> 
> no? percpu_ref_tryget() should fail when the refcnt goes back down to
> 0. Then we can do percpu_ref_exit() as well.
> 
>> +       /* nobody should have been able to get a ref... */
>> +       percpu_ref_exit(&pool->ref);
>>
>>         /* pool is now off zswap_pools list and has no references. */
>>         zswap_pool_destroy(pool);
>> @@ -444,11 +450,11 @@ static void __zswap_pool_release(struct work_struct *work)
>>
>>  static struct zswap_pool *zswap_pool_current(void);
>>
>> -static void __zswap_pool_empty(struct kref *kref)
>> +static void __zswap_pool_empty(struct percpu_ref *ref)
>>  {
>>         struct zswap_pool *pool;
>>
>> -       pool = container_of(kref, typeof(*pool), kref);
>> +       pool = container_of(ref, typeof(*pool), ref);
>>
>>         spin_lock(&zswap_pools_lock);
>>
>> @@ -467,12 +473,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
>>         if (!pool)
>>                 return 0;
>>
>> -       return kref_get_unless_zero(&pool->kref);
>> +       return percpu_ref_tryget(&pool->ref);
>>  }
>>
>>  static void zswap_pool_put(struct zswap_pool *pool)
>>  {
>> -       kref_put(&pool->kref, __zswap_pool_empty);
>> +       percpu_ref_put(&pool->ref);
>>  }
>>
>>  static struct zswap_pool *__zswap_pool_current(void)
>> @@ -602,6 +608,12 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>>
>>         if (!pool)
>>                 pool = zswap_pool_create(type, compressor);
>> +       else {
>> +               /* Resurrect percpu_ref to percpu mode. */
>> +               percpu_ref_resurrect(&pool->ref);
>> +               /* Drop the ref from zswap_pool_find_get(). */
>> +               zswap_pool_put(pool);
>> +       }
>>
>>         if (pool)
>>                 ret = param_set_charp(s, kp);
>> @@ -640,7 +652,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>>          * or the new pool we failed to add
>>          */
>>         if (put_pool)
>> -               zswap_pool_put(put_pool);
>> +               percpu_ref_kill(&put_pool->ref);
>>
>>         return ret;
>>  }
>>
>> --
>> b4 0.10.1
> 
> The rest of the code looks solid to me FWIW. Number seems to indicate
> this is a good idea as well.

