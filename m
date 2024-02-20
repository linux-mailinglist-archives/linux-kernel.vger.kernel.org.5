Return-Path: <linux-kernel+bounces-72259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD885B13E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A334F1C20A87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300B44C9C;
	Tue, 20 Feb 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VGjgAMXG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62C433B3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399450; cv=none; b=hdjR9jMzGGvM/syY/srrK+3f1NrlnQwMsfuw9phzaJ//MKRpWe6hgYGFnO+FSGJOg5q0sqyEcsk0ppxLn+PE78t0V6fNYsPHn0q+BBSyjBpVh8ukcHLqd7S9oRSTSgNr67qDx2ViWTYuJ/DE4vKSQKiksOxIK/vq67l1WdWx8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399450; c=relaxed/simple;
	bh=ECJyM00yOqsiV5DQ/phD4Mbs2UZTKNvckupP2+MkVbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlHfj4r7wutm5zkOvvbVPwP/ip+4MM5EwQjOfb+V6nfhV1OO0y2Ko27QnIEhzEBALcvXmlm4ua9ed6Qbzk63O39cTx4RLZlluW3POUegNH0iAHqSrt4dkGIw0/k89JGFlLMKJgckQeF1RP2hdM8Ijp+oYo7zi3C1Iwl5Qn/KtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VGjgAMXG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so1813782b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708399448; x=1709004248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hf1JftyPCJ/e/S2Ajsn23dPixx108Nels4BBRFt3s8=;
        b=VGjgAMXGo4LT+1eZLC1OLsmTDH1eoXV+h56iwchMrNfDtLLZyycp23R5kA0lLmw+3G
         vbmwl/0MZZqHE+qIPGZz9KOClTPJkLCRnim2DHYyYFBf4mJMEcK+U80Fpy7I+CAPooqH
         Yibo4di5Q8GaBFSv7nQMqzDWS5+j4ps5XZ9eefVD9HWuvEw1ejgR8Cl5otIqZjKkHjRW
         u+86GGNyWhyq1X3Zb92lbIx36qfUk8xVgBJvKH61V5atUHS1lNvE+z0nksQU1iGPnwh+
         eIxvkfp/DkplKJM0NNxYqVSg2Qjhjz6XrS4CYAfNqQ20OOcB0g+/Hc0SjO9vJcNsSzq8
         KA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708399448; x=1709004248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hf1JftyPCJ/e/S2Ajsn23dPixx108Nels4BBRFt3s8=;
        b=FhEpLN4zbASZM/IQzV7MaIIAPY/aFfM27dc+dWZaogWfALHBU/cPek4se39+Vc22uX
         Gw8b1MNxfG485Qo0RRnzIWTepdsKSTTKBnfKQqG4MIrwHRqPB4oMS7rgcMrjCa+JRrh2
         74HyVK/7lH1+1/SwE3kn1QUZies+y6DioHBaK/QD+mJOmSIiZubifCU/EpNYxcvuGMSz
         n10NXO6dJZzm/k+M+1NueWub8jnOZCorEg43KSw53MaKvQv0KBnGeUo1lg9A7g5jvS47
         XrxUx8RdYBWfeEY0u4qug3iC2bFAH85GKk9+mGCcYuisohtPoV8vcsfLnCe0mnIAvMaB
         84PA==
X-Forwarded-Encrypted: i=1; AJvYcCW0CEfTmT++00WeoQvY9cewHosBZs/3IsFMia7MygY2jVyMlyrA3k4FivkFehfBcZZ3T9ref3juKxilyhcnij517Lw0+X2e8pZYf41M
X-Gm-Message-State: AOJu0YzjVwffxgYhYTSVjz+3gq+dYxhW7s/MBBu5Lwy3ePztPB64070r
	LdVMHZbRR4mQ6T6p6GU2peQ66i1HBjdGmBS1MXnxdIZYCsmoQh1Kl6yhW3SKXh4=
X-Google-Smtp-Source: AGHT+IEJ0H3EvdJYSoSpOLcIAdWmBhK4wZEzXFXYvaGjt3+9rPnc32Q0j1sI1CuxMkQoznN7vItrSA==
X-Received: by 2002:a62:cd82:0:b0:6e4:3ea4:a7e1 with SMTP id o124-20020a62cd82000000b006e43ea4a7e1mr3625483pfg.27.1708399448424;
        Mon, 19 Feb 2024 19:24:08 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79843000000b006e319d8c752sm5143715pfq.150.2024.02.19.19.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 19:24:08 -0800 (PST)
Message-ID: <03b83a30-742e-4885-a478-d3dadf444de2@bytedance.com>
Date: Tue, 20 Feb 2024 11:24:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
 <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240210-zswap-global-lru-v3-0-200495333595@bytedance.com>
 <20240210-zswap-global-lru-v3-1-200495333595@bytedance.com>
 <CAKEwX=Mc3TTL3aW-69SV_G8UhWBhgfNpEQvuz93P+pmpVyAzmg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=Mc3TTL3aW-69SV_G8UhWBhgfNpEQvuz93P+pmpVyAzmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/20 09:28, Nhat Pham wrote:
> On Fri, Feb 16, 2024 at 12:55 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
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
>>    will try to shrink its lru list. The rationale here was to
>>    try and empty the old pool first so that we can completely
>>    drop it. However, since we only support exclusive loads now,
>>    the LRU ordering should be entirely decided by the order of
>>    stores, so the oldest entries on the LRU will naturally be
>>    from the oldest pool.
>>
>> Anyway, having a global lru and shrinker shared by all zswap_pools
>> is better and efficient.
>>
>> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 171 ++++++++++++++++++++++++-------------------------------------
>>  1 file changed, 66 insertions(+), 105 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 62fe307521c9..d275eb523fc4 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -176,14 +176,19 @@ struct zswap_pool {
>>         struct kref kref;
>>         struct list_head list;
>>         struct work_struct release_work;
>> -       struct work_struct shrink_work;
>>         struct hlist_node node;
>>         char tfm_name[CRYPTO_MAX_ALG_NAME];
>> +};
>> +
>> +static struct {
>>         struct list_lru list_lru;
>> -       struct mem_cgroup *next_shrink;
>> -       struct shrinker *shrinker;
>>         atomic_t nr_stored;
>> -};
>> +       struct shrinker *shrinker;
>> +       struct work_struct shrink_work;
>> +       struct mem_cgroup *next_shrink;
>> +       /* The lock protects next_shrink. */
>> +       spinlock_t shrink_lock;
>> +} zswap;
> 
> nit: Is there a reason why we're putting these in a struct instead of
> just a bunch of static variables (perhaps prefixed with zswap?)

No reason, both is ok for me. I thought there should be no difference.
But I can change to static variables if it's preferred in kernel. :)


