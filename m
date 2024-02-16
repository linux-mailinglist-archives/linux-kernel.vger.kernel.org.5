Return-Path: <linux-kernel+bounces-68270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4A857800
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708D8284916
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2E179AF;
	Fri, 16 Feb 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LGDUuhVu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A681B940
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073375; cv=none; b=daB5+8f45QFDNGTY4OM8A0576P90l5JWltWVC3UofhEW+TdlFHnSbEmt77unTBUoscm21lB9T/tqDiFgPD9qbyxzIWs0v+9zxtSfETxjqXlZ9ZKmWUIsT01w6N4Po8vgPHv+xNqbc67q7P8qz9hSzJjfQyqm8YUbpj7DJ7MUR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073375; c=relaxed/simple;
	bh=8b1PfdK9G1UP8DWcZnanoDD6WxYD/lC1F5tGyAhoVsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TraPQ25Dp6Y4KKzL/jjBIrROomnyJl1zA8NKIoTEgj7UAbetRzZ/86zuYE8ZnmQiz5URv5ZqPUPexLls2nZ4MnZ0xC1HgEPxh97u8qaHus+FW+cc79Cb0Mh66RN5WMgbVz8Qzxw6Hf9gAbhPoPs7Bjc7iAFgje9My3FSye6rNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LGDUuhVu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7393de183so15669755ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708073373; x=1708678173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ef4J5UO4FCUkGSsVpOjeciLsm69YrWZrK7HVqGKOCu8=;
        b=LGDUuhVuCx9iOEioHTkUfTimFq1bTIjMsd2XdnLUIUEF3J95fjgjv1H/wLJkx9rT20
         1EzcTfJv0IK6NRB/VZPsd6wNgxOLUjngfruTjO+0NGATIyHGbl/jJjMlsk60GOgv6qrE
         +ijRXlOC7yW8/VYK30pip+EbgT5PVS67zwCK6EsP8S0RvQLCj/dmptpuBxtnxtI99e6S
         XhGYJE77EFpn8EDgn4P5vt2/CR7+ro5JhGNuCklbzXJEjrIkOcnWQ7o7jd9UROmUY0cq
         D3r6aQ4/MihV8RFKs3V1VEjfuhcdKUc/OR7HKRuZs+gItyCO7AnOuej1sM8S+z6uekAL
         plSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708073373; x=1708678173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef4J5UO4FCUkGSsVpOjeciLsm69YrWZrK7HVqGKOCu8=;
        b=buA0LoxVS+drq/qkVOglK7v4kw4reFaBBPG3ZZHoGA4S222LEibkLnpeUeKALIYj/x
         kQkMi29M+iqXhxmuE7D0oU9ji7Lg2WEpmiULJNoLlRKZ9EPLJZYHXCY8ClS6GaW7tynO
         9qCwCCd3JiWgATgbJarbQi4e+JwTTbwPbN70Yo8xHSwFkmUxaBdtPZvvVR+iOXCyRvTx
         d10XcUAkZ3++NdmvlKiLWU1ENXBGUQpJCgiDE/q3eOM38iTnEUwBcJnTECUjif/db/o/
         wZ2eYGXwipXuKQHU2AE6Bdafy6NUHyl2VPiC4maNrD99sim4GLf8ohHvWydug/cWagH1
         NnDA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1i91aiYBQboSWqZzDAWFG5cwx7bSu+G8yZosqX2kcs2fgCB6p9e0eq3DUf+LemLk2Mu6bpZfdF8F+jMHKHcJGYsdXH/MEXL09E/Q
X-Gm-Message-State: AOJu0YyTm7l2KRVZuJ4GOYkPJycIZfm47KuyCDPVzHAW9UQQORkLTUE9
	idfCLuLSa3YV/yAd9q0wnJLDIoZ4nV9qzzyE8GjEhsaFCM51U457CMX+DzGkjbw=
X-Google-Smtp-Source: AGHT+IFfZdn6OadDErDuWgbMNaXtVYv3uOoUsCK9yeWZpHnbz45NwSh2/3MVCHzMg/GqBeE2vQzRUQ==
X-Received: by 2002:a17:902:ec82:b0:1da:498:24be with SMTP id x2-20020a170902ec8200b001da049824bemr5056656plg.40.1708073372919;
        Fri, 16 Feb 2024 00:49:32 -0800 (PST)
Received: from [10.4.195.175] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id u20-20020a170902e21400b001db4c89aea5sm2529069plb.158.2024.02.16.00.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:49:32 -0800 (PST)
Message-ID: <fbf19a7e-f70f-4d13-ab7d-69982b526168@bytedance.com>
Date: Fri, 16 Feb 2024 16:49:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/zswap: change zswap_pool kref to percpu_ref
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com>
 <20240210-zswap-global-lru-v2-2-fbee3b11a62e@bytedance.com>
 <Zc0eJ84FeR9yQ99T@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Zc0eJ84FeR9yQ99T@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/15 04:10, Yosry Ahmed wrote:
> On Wed, Feb 14, 2024 at 08:54:38AM +0000, Chengming Zhou wrote:
>> All zswap entries will take a reference of zswap_pool when
>> zswap_store(), and drop it when free. Change it to use the
>> percpu_ref is better for scalability performance.
>>
>> Although percpu_ref use a bit more memory which should be ok
>> for our use case, since we almost have only one zswap_pool to
>> be using. The performance gain is for zswap_store/load hotpath.
>>
>> Testing kernel build (32 threads) in tmpfs with memory.max=2GB.
>> (zswap shrinker and writeback enabled with one 50GB swapfile,
>> on a 128 CPUs x86-64 machine, below is the average of 5 runs)
>>
>>         mm-unstable  zswap-global-lru
>> real    63.20        63.12
>> user    1061.75      1062.95
>> sys     268.74       264.44
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 31 ++++++++++++++++++++++---------
>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index dbff67d7e1c7..f6470d30d337 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
>>  struct zswap_pool {
>>  	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>>  	struct crypto_acomp_ctx __percpu *acomp_ctx;
>> -	struct kref kref;
>> +	struct percpu_ref ref;
>>  	struct list_head list;
>>  	struct work_struct release_work;
>>  	struct hlist_node node;
>> @@ -304,6 +304,7 @@ static void zswap_update_total_size(void)
>>  /*********************************
>>  * pool functions
>>  **********************************/
>> +static void __zswap_pool_empty(struct percpu_ref *ref);
>>  
>>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  {
>> @@ -357,13 +358,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  	/* being the current pool takes 1 ref; this func expects the
>>  	 * caller to always add the new pool as the current pool
>>  	 */
>> -	kref_init(&pool->kref);
>> +	ret = percpu_ref_init(&pool->ref, __zswap_pool_empty,
>> +			      PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
>> +	if (ret)
>> +		goto ref_fail;
>>  	INIT_LIST_HEAD(&pool->list);
>>  
>>  	zswap_pool_debug("created", pool);
>>  
>>  	return pool;
>>  
>> +ref_fail:
>> +	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
>>  error:
>>  	if (pool->acomp_ctx)
>>  		free_percpu(pool->acomp_ctx);
>> @@ -436,8 +442,9 @@ static void __zswap_pool_release(struct work_struct *work)
>>  
>>  	synchronize_rcu();
>>  
>> -	/* nobody should have been able to get a kref... */
>> -	WARN_ON(kref_get_unless_zero(&pool->kref));
>> +	/* nobody should have been able to get a ref... */
>> +	WARN_ON(percpu_ref_tryget(&pool->ref));
> 
> Just curious, was there any value from using kref_get_unless_zero() over
> kref_read() here? If not, I think percpu_ref_is_zero() is more
> intuitive. This also seems like it fits more as a debug check.

Agree, percpu_ref_is_zero() is better for debug.

> 
>> +	percpu_ref_exit(&pool->ref);
>>  
>>  	/* pool is now off zswap_pools list and has no references. */
>>  	zswap_pool_destroy(pool);
>> @@ -445,11 +452,11 @@ static void __zswap_pool_release(struct work_struct *work)
>>  
>>  static struct zswap_pool *zswap_pool_current(void);
>>  
>> -static void __zswap_pool_empty(struct kref *kref)
>> +static void __zswap_pool_empty(struct percpu_ref *ref)
>>  {
>>  	struct zswap_pool *pool;
>>  
>> -	pool = container_of(kref, typeof(*pool), kref);
>> +	pool = container_of(ref, typeof(*pool), ref);
>>  
>>  	spin_lock(&zswap_pools_lock);
>>  
>> @@ -468,12 +475,12 @@ static int __must_check zswap_pool_get(struct zswap_pool *pool)
>>  	if (!pool)
>>  		return 0;
>>  
>> -	return kref_get_unless_zero(&pool->kref);
>> +	return percpu_ref_tryget(&pool->ref);
>>  }
>>  
>>  static void zswap_pool_put(struct zswap_pool *pool)
>>  {
>> -	kref_put(&pool->kref, __zswap_pool_empty);
>> +	percpu_ref_put(&pool->ref);
>>  }
>>  
>>  static struct zswap_pool *__zswap_pool_current(void)
>> @@ -603,6 +610,12 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>>  
>>  	if (!pool)
>>  		pool = zswap_pool_create(type, compressor);
>> +	else {
>> +		/* Resurrect percpu_ref to percpu mode. */
>> +		percpu_ref_resurrect(&pool->ref);
> 
> I think this is not very clear. The previous code relied on the ref from
> zswap_pool_find_get() to replace the initial ref that we had dropped
> before. This is not needed with percpu_ref_resurrect() because it
> already restores the initial ref dropped by percpu_ref_kill().
> 
> Perhaps something like:
> 		/*
> 		 * Restore the initial ref dropped by percpu_ref_kill()
> 		 * when the pool was decommissioned and switch it again
> 		 * to percpu mode.
> 		 /
> 

Ok, will add this comment, it's clearer.

Thanks!

