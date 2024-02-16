Return-Path: <linux-kernel+bounces-68268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9298577FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01921F22004
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EE182D8;
	Fri, 16 Feb 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lTG+/3IC"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED51798E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073267; cv=none; b=I1ivuitEptRoW7M5frvlVaM6rPdZh0ZlkTPw5tkMQ2IHD/YUOACOADASdVnpNbstTt3qXPBk3oN49lSCdS/L2PoIfM/UOFb+SkpwT4+MdWoRQtklW2M1yUt5N6mmLrr8FTZ+Y4YZelRVtMqfamzUWoWICWyZbFUvFnDd3bNCezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073267; c=relaxed/simple;
	bh=7O4Za22TfMXoaNzcbnPDMdkzDAdQuWqygdt/zrphP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFfR+7fFbQvB/slJlqXd/Us0ww9jQM+8MHJmC5YOVU6LBgXZppja1jR2emPD0x3ehkhPZm0B0w9acETPUjWT/SRdaSoDix1Mgr+/uGzeWHmq4bYKpQ8tcV1cP3yAyt5jHTF7NWLBAh1oJtW3g1nFtJdj0kL7IF7Tkq1sMA2JIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lTG+/3IC; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c0485fc8b8so1551116b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708073264; x=1708678064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upnkKGhfzc8qqiqM2ipvrycRNTREZNhhxEHc3oR8BjY=;
        b=lTG+/3IC/4NqThwYBOSFpt4ihKdNQ6ORZOmoIy0wB5vJ0KczAL7fV64wB0GOJjEAWd
         gvdl4Vqgb1WK+csetdiklEcOC5ZTgACKCi8ugX/pjd3PiFTerGK7GU/vq8mSSewM1ZgA
         aobMJJgdbTbCved3X7ypTS1zyKnQI+O7I8nfIvQMqdhiMXs6S7bS4OXYr/8VO03yexVw
         WyF5Qw/8o4rzOTKJjmazjLlOaurJeZ+G4plzPFImVF0pjG4IGyG8xDLYvBl7tE5h9hV7
         lrVGSVhmHpdD+qH2Fx9v8kDd26kBQKQAWmi73OfB4wCSLXLA1C/a/8cE+NFEw6R/G8tE
         lNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708073264; x=1708678064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upnkKGhfzc8qqiqM2ipvrycRNTREZNhhxEHc3oR8BjY=;
        b=E31FqSrVeo3xhEQ6WoIZTLlOGbNJu0x9hBsUqg2arRZe9ycu7iJe35rOxLqVGrUuor
         6m+H0NbugWpaIm0YHOPERbsnZ0Aq1/pI+YEJUCbF1b6lCWFOCX4R++B6sEsZ4QXZvzsx
         EKH6xz/owQJ4P938e5qduKgIx6RSD6CX7RzPOsYfpkjLAt/EtSErpOxAHwvlNSyvqwiz
         0TShM1hbODXNOA4Fy5KjArXLnPJlUJfGJOVfUrM+TB4sjaVRoEeNSD2g5WAIWEVmjPT+
         wBrq91cTgmuoI+1JP3S9/eHEim4GUsZM+Nk/hA6XiYri1Ee+qY15Rn0bRx8SQYzkQwOR
         80FA==
X-Forwarded-Encrypted: i=1; AJvYcCWe0CElAJIGh/1pSybSTlvZlWTxuYEATR6OzebCfYTPCn634/ndSWxaxbf/akvWMvjXEg92Py7tJsciVIeZXoojgNoG+I28PHobw1qi
X-Gm-Message-State: AOJu0Yx6foc1GHuRMUw+SjAdL4WzIHa+MiEsy3HZDMeF4Iotv5gsrsmi
	gUX2UlIBTjQuThqlkWLYD5k7PBz+0KFpsd4y5jVDuNXRhUpuo0zeC8QmH6FJeBE=
X-Google-Smtp-Source: AGHT+IEqstXlPoKBOibfxM+Y85KLlPqpY851hu7oh3SjO27Hz6LOHiAT6sfWa+W7yLi0PA9vPrimoA==
X-Received: by 2002:a05:6808:1448:b0:3c0:4129:946b with SMTP id x8-20020a056808144800b003c04129946bmr5317425oiv.46.1708073264459;
        Fri, 16 Feb 2024 00:47:44 -0800 (PST)
Received: from [10.4.195.175] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006e042b50c39sm2666275pfl.144.2024.02.16.00.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:47:44 -0800 (PST)
Message-ID: <e5b65d4e-55ff-4b9a-9add-563738b7193f@bytedance.com>
Date: Fri, 16 Feb 2024 16:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v2-0-fbee3b11a62e@bytedance.com>
 <20240210-zswap-global-lru-v2-1-fbee3b11a62e@bytedance.com>
 <Zc0Silj_TKkUBRBF@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Zc0Silj_TKkUBRBF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/15 03:20, Yosry Ahmed wrote:
> On Wed, Feb 14, 2024 at 08:54:37AM +0000, Chengming Zhou wrote:
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
> 
> I think the rationale here was to try and empty the old pool first so
> that we can completely drop it. However, since we only support exclusive
> loads now, the LRU ordering should be entirely decided by the order of
> stores, so I think the oldest entries on the LRU will naturally be the
> from the oldest pool, right?
> 
> Probably worth stating this.

Right, will add your this part in the commit message.

> 
>>
>> Anyway, having a global lru and shrinker shared by all zswap_pools
>> is better and efficient.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> LGTM with a few comments, with those:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> 
>> ---
>>  mm/zswap.c | 170 +++++++++++++++++++++++--------------------------------------
>>  1 file changed, 65 insertions(+), 105 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 62fe307521c9..dbff67d7e1c7 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -176,14 +176,18 @@ struct zswap_pool {
>>  	struct kref kref;
>>  	struct list_head list;
>>  	struct work_struct release_work;
>> -	struct work_struct shrink_work;
>>  	struct hlist_node node;
>>  	char tfm_name[CRYPTO_MAX_ALG_NAME];
>> +};
>> +
>> +static struct {
>>  	struct list_lru list_lru;
>> -	struct mem_cgroup *next_shrink;
>> -	struct shrinker *shrinker;
>>  	atomic_t nr_stored;
>> -};
>> +	struct shrinker *shrinker;
>> +	struct work_struct shrink_work;
>> +	struct mem_cgroup *next_shrink;
>> +	spinlock_t shrink_lock;
> 
> The lock is exclusively protecting next_shrink, right? Perhaps we should
> rename it to next_shrink_lock or at least document this.

Ok, I will add a comment to it.

> 
>> +} zswap;
>>  
>>  /*
>>   * struct zswap_entry
>> @@ -301,9 +305,6 @@ static void zswap_update_total_size(void)
>>  * pool functions
>>  **********************************/
>>  
>> -static void zswap_alloc_shrinker(struct zswap_pool *pool);
>> -static void shrink_worker(struct work_struct *w);
>> -
>>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  {
>>  	int i;
>> @@ -353,30 +354,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>  	if (ret)
>>  		goto error;
>>  
>> -	zswap_alloc_shrinker(pool);
>> -	if (!pool->shrinker)
>> -		goto error;
>> -
>> -	pr_debug("using %s compressor\n", pool->tfm_name);
> 
> nit: the next patch introduces a new failure case between this debug
> print and zswap_pool_debug() below, so it will become possible again
> that we get one and not the other. Not a big deal though.

Yes, not a big deal.

Thanks!

