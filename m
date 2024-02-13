Return-Path: <linux-kernel+bounces-63661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED18532E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF09287E61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389857895;
	Tue, 13 Feb 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OrFB+gRt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17155788C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834053; cv=none; b=mqLTuzL8hOuI7s+gKmJN3tMa6fbEZUHprQOfudPYxtcPGzR1J2GGocbbIrM/Rb4phV9sAJ3FJ1zVBcn3UWnplP2zBhAk+vTcI40XOKVzM4K/5iX7R+Uq20AVsBUldb19MI8x/+cFPSQz2LOSdg6dOSGTy/c2nVaQdn+wjX2jjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834053; c=relaxed/simple;
	bh=NJiEdWz6qkdGRgdenXyeE137tHslQCGSIA7xfayvbdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajKnN3/t9sz6/FqHQmFBGWFbY55OOsxK2shyLTX8pnr3ffSiEeXDI4C/8foguPjHeLLYLAPA7HpQe3Gu/nJD9oLpQ1qFMi3ibB5oK5iJV6PyR3rf+r9e2DFS72eypJ5s8CanVJ8NRcYf9e8wECb5gHpdhfMDo6Op2zk41FV+Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OrFB+gRt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d95d67ff45so32242255ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707834051; x=1708438851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTcGaRpU/+l4xDwi5UtlkinpqIiMd4C3NS8zazX5S0Q=;
        b=OrFB+gRtM6E20ES9T+Laoo58DU0tqogMHLgUTFYm932WIz31K0Cfrjuqw7iFSyEOg9
         XGZ3LJ0Ezw2umsYDm5htCoxb/K8t/gr5G3E9p3A6jvjjsBUqVbak1T62nH7yhhw440hB
         cwQ/5ja43NqwUYP2MZ1jdhY4PAAAGIcMvVi6l/fDTjxXL90tFPp96j1RLvSqPZ/KJmKo
         elkxpOWkjStmV6eKiwoziE1K9Dce7WWToAmtrUH2Qj47RV7ITED/xvFZDpyMJEiqTTIr
         gUICDaqcoXIcZaPx4Ezm/BhSo0EqYaO0t7n5iOkzsIH/N2zri+4TbRG5nzj/M2lOjpmP
         h7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834051; x=1708438851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTcGaRpU/+l4xDwi5UtlkinpqIiMd4C3NS8zazX5S0Q=;
        b=ln0W9fl0kwInFCHmaA1ikFxhqc8xceu67tmTfodFb58FaY0GzAhyTuQLLJHfFo+wla
         /E0S8PS/bJ6SrUa1GFWXDk+x50qO9sm2np2P7hMKqJljMNOjmwLk4JXX7T4s8Qz2TgMb
         UlA6wQqbnRU3aXiiVcDpCY4/olBhsiDMx82jtuXrkqIvfDCP22MTmIwukeyNqZjLs6i/
         7KzR48NHoW/423yknno584HBEb1rgiIvss6m9/YF2+F2O61cGuimcDFadDXDEGEQdNqb
         BDXwEEmfe2iULtWItHpoItVn9OTYJW7NENFOdZbBb5zgArtmtCFybmSZZqEz00N0AKzf
         92YA==
X-Forwarded-Encrypted: i=1; AJvYcCXHQ3uHHBwHUEnJfh+r6GN7UTAcPHtuSs3Ckb0kuX0xH6YDk6ExHfUPtzfVCc1pJN86vQGW/MBFOrh7WqNZM6S1YEHUxvVuTbWMFeN+
X-Gm-Message-State: AOJu0Yx5q39+C2raghJ5tpGuZw8EpJ0OzZvXI9ByTm2PPvstVJ20YhIA
	3yQNkceYmZlBSD9j3Hg9Bk6/81I66cZcl5f3hPlRW57DqVwTZav9vOFWsuljiV8=
X-Google-Smtp-Source: AGHT+IFC0zRVfeHLWIKSSUI/LH5Kvnm+N+P+n9nWieGwSgDYEkSwY3aO0jbvZN7e9sK6rk5P5/rYtQ==
X-Received: by 2002:a17:902:e892:b0:1d9:d:5730 with SMTP id w18-20020a170902e89200b001d9000d5730mr10135618plg.3.1707834050787;
        Tue, 13 Feb 2024 06:20:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkFxktchCDjxL1MugrEwsm+qtbm23g5veNOLjR4ppC8qSMns8qsFl6bEPEA7UiV/avBdswEdD6YFS227oQC5V28ulahf93te+cscHizShKVOpZsh8+9u3esPmaR9Rgvk3ZWohIUV17q3guT9x7gIWIT+Bwr7TWhB9VI6GIRcwwHRpZIrETQ90=
Received: from [10.254.125.113] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903209200b001d50ca466e5sm2131088plc.133.2024.02.13.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:20:50 -0800 (PST)
Message-ID: <e094857d-41c8-4064-8475-a5a43e315f6d@bytedance.com>
Date: Tue, 13 Feb 2024 22:20:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
 <ZctnRnNMOwQNn_3j@google.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZctnRnNMOwQNn_3j@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/13 20:57, Yosry Ahmed wrote:
> On Sun, Feb 11, 2024 at 01:57:04PM +0000, Chengming Zhou wrote:
>> Dynamic zswap_pool creation may create/reuse to have multiple
>> zswap_pools in a list, only the first will be current used.
>>
>> Each zswap_pool has its own lru and shrinker, which is not
>> necessary and has its problem:
>>
>> 1. When memory has pressure, all shrinker of zswap_pools will
>>    try to shrink its own lru, there is no order between them.
>>
>> 2. When zswap limit hit, only the last zswap_pool's shrink_work
>>    will try to shrink its lru, which is inefficient.
>>
>> Anyway, having a global lru and shrinker shared by all zswap_pools
>> is better and efficient.
> 
> It is also a great simplification.
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 153 ++++++++++++++++++++++---------------------------------------
>>  1 file changed, 55 insertions(+), 98 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 62fe307521c9..7668db8c10e3 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -176,14 +176,17 @@ struct zswap_pool {
>>  	struct kref kref;
>>  	struct list_head list;
>>  	struct work_struct release_work;
>> -	struct work_struct shrink_work;
>>  	struct hlist_node node;
>>  	char tfm_name[CRYPTO_MAX_ALG_NAME];
>> +};
>> +
>> +struct {
> 
> static?

Ah, right, will add static.

> 
>>  	struct list_lru list_lru;
>> -	struct mem_cgroup *next_shrink;
>> -	struct shrinker *shrinker;
> 
> Just curious, any reason to change the relative ordering of members
> here? It produces a couple more lines of diff :)

The list_lru and nr_stored atomic variable are used in zswap_store/load
hotpath, the other shrinker related sound like cold path. I thought it's
normal and clearer to put them according to their usages.

> 
>>  	atomic_t nr_stored;
>> -};
>> +	struct shrinker *shrinker;
>> +	struct work_struct shrink_work;
>> +	struct mem_cgroup *next_shrink;
>> +} zswap;
>>  
>>  /*
>>   * struct zswap_entry
>> @@ -301,9 +304,6 @@ static void zswap_update_total_size(void)
>>  * pool functions
>>  **********************************/
>>  
>> -static void zswap_alloc_shrinker(struct zswap_pool *pool);
>> -static void shrink_worker(struct work_struct *w);
>> -
>>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  {
>>  	int i;
>> @@ -353,30 +353,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  	if (ret)
>>  		goto error;
>>  
>> -	zswap_alloc_shrinker(pool);
>> -	if (!pool->shrinker)
>> -		goto error;
>> -
>> -	pr_debug("using %s compressor\n", pool->tfm_name);
>> -
> 
> Why are we removing this debug print?

Oh, I just noticed it's only necessary to print dmesg when "create" success,
the below "zswap_pool_debug()" will print its compressor too.

> 
>>  	/* being the current pool takes 1 ref; this func expects the
>>  	 * caller to always add the new pool as the current pool
>>  	 */
>>  	kref_init(&pool->kref);
>>  	INIT_LIST_HEAD(&pool->list);
>> -	if (list_lru_init_memcg(&pool->list_lru, pool->shrinker))
>> -		goto lru_fail;
>> -	shrinker_register(pool->shrinker);
>> -	INIT_WORK(&pool->shrink_work, shrink_worker);
>> -	atomic_set(&pool->nr_stored, 0);
>>  
>>  	zswap_pool_debug("created", pool);
>>  
>>  	return pool;
>>  
>> -lru_fail:
>> -	list_lru_destroy(&pool->list_lru);
>> -	shrinker_free(pool->shrinker);
>>  error:
>>  	if (pool->acomp_ctx)
>>  		free_percpu(pool->acomp_ctx);
> [..]
>> @@ -816,14 +777,10 @@ void zswap_folio_swapin(struct folio *folio)
>>  
>>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>>  {
>> -	struct zswap_pool *pool;
>> -
>> -	/* lock out zswap pools list modification */
>> +	/* lock out zswap shrinker walking memcg tree */
>>  	spin_lock(&zswap_pools_lock);
>> -	list_for_each_entry(pool, &zswap_pools, list) {
>> -		if (pool->next_shrink == memcg)
>> -			pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
>> -	}
>> +	if (zswap.next_shrink == memcg)
>> +		zswap.next_shrink = mem_cgroup_iter(NULL, zswap.next_shrink, NULL);
> 
> Now that next_shrink has nothing to do with zswap pools, it feels weird
> that we are using zswap_pools_lock for its synchronization. Does it make
> sense to have a separate lock for it just for semantic purposes?

Agree, I think so, it's clearer to have another lock.

> 
>>  	spin_unlock(&zswap_pools_lock);
>>  }
>>  
> [..]
>> @@ -1328,7 +1284,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
>>  static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>>  		struct shrink_control *sc)
>>  {
>> -	struct zswap_pool *pool = shrinker->private_data;
>>  	struct mem_cgroup *memcg = sc->memcg;
>>  	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
>>  	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
>> @@ -1343,7 +1298,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>>  #else
>>  	/* use pool stats instead of memcg stats */
>>  	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
> 
> "pool" is still being used here.

Oops, should be changed to zswap_pool_total_size here.

> 
>> -	nr_stored = atomic_read(&pool->nr_stored);
>> +	nr_stored = atomic_read(&zswap.nr_stored);
>>  #endif
>>  
>>  	if (!nr_stored)
> [..]  
>> @@ -1804,6 +1749,21 @@ static int zswap_setup(void)
>>  	if (ret)
>>  		goto hp_fail;
>>  
>> +	shrink_wq = alloc_workqueue("zswap-shrink",
>> +			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>> +	if (!shrink_wq)
>> +		goto hp_fail;
> 
> I think we need a new label here to call cpuhp_remove_multi_state(), but
> apparently this is missing from the current code for some reason.

You are right! This should use a new label to "cpuhp_remove_multi_state()",
will fix it.

> 
>> +
>> +	zswap.shrinker = zswap_alloc_shrinker();
>> +	if (!zswap.shrinker)
>> +		goto shrinker_fail;
>> +	if (list_lru_init_memcg(&zswap.list_lru, zswap.shrinker))
>> +		goto lru_fail;
>> +	shrinker_register(zswap.shrinker);
>> +
>> +	INIT_WORK(&zswap.shrink_work, shrink_worker);
>> +	atomic_set(&zswap.nr_stored, 0);
>> +
>>  	pool = __zswap_pool_create_fallback();
>>  	if (pool) {
>>  		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
>> @@ -1815,19 +1775,16 @@ static int zswap_setup(void)
>>  		zswap_enabled = false;
>>  	}
>>  
>> -	shrink_wq = alloc_workqueue("zswap-shrink",
>> -			WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>> -	if (!shrink_wq)
>> -		goto fallback_fail;
>> -
>>  	if (zswap_debugfs_init())
>>  		pr_warn("debugfs initialization failed\n");
>>  	zswap_init_state = ZSWAP_INIT_SUCCEED;
>>  	return 0;
>>  
>> -fallback_fail:
>> -	if (pool)
>> -		zswap_pool_destroy(pool);
>> +lru_fail:
>> +	list_lru_destroy(&zswap.list_lru);
> 
> Do we need to call list_lru_destroy() here? I know it is currently being
> called if list_lru_init_memcg() fails, but I fail to understand why. It
> seems like list_lru_destroy() will do nothing anyway.

Right, it's not needed to call list_lru_destroy() here, it should do nothing,
will delete it.

Thanks!

> 
>> +	shrinker_free(zswap.shrinker);
>> +shrinker_fail:
>> +	destroy_workqueue(shrink_wq);
>>  hp_fail:
>>  	kmem_cache_destroy(zswap_entry_cache);
>>  cache_fail:
>>
>> -- 
>> b4 0.10.1

