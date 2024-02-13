Return-Path: <linux-kernel+bounces-63668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B43A853302
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438F12815BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417935788A;
	Tue, 13 Feb 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A50BY/KL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704A5787C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834169; cv=none; b=n6DM14ROpMEy4SUw4WueKeRDtIDjxj3Zjcl8EEZ6ofW+N8H2YeCK4RwJK8udAraBd6d8ARH+djo1sppCK4aMliqgmCFRBu41/wfJ8V4XnzqT75So0UiynawK40L2VDggkD3jQQYQ7RV69hhZ1Syj1PlfpttOfKszfDGjxInTEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834169; c=relaxed/simple;
	bh=J43zOcElWg4UxeJmgC3Ghm7RwJqXsIj/fnaTglFh3OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKHEjr+QzMc/3XeZoSZdPEcJpajGIVnWayJHzlKHu5c3ug9fq3eUB0gX8TX9zA8oQuidFnFZ72Zoo3Vi4thIsX0uxFuhQRj6A9DoJL/N8Dlc9IxBc89ebIdN0f8IOVi9aES+8gQ/znenhjOX/0LkNPpOHKEmL0PZU7vBC5u8pPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A50BY/KL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e06c06c0f6so3104732b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707834166; x=1708438966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoOD+hWlWE/17i8/Lqi/FjvHCDIa9+g3UCcdDeLmuOw=;
        b=A50BY/KL4b6dh4Mz4G1R+ofttwZRGYdSaENw5ZUW6Gc+/C0d2VV/9cxDQqwgsP7gPG
         g8CY+6UMenxzcUKLQXwzsjBZhkFPgNDOMtZ5BdMN7Lu08ARKnyQDX0mkU5FnduT72FT8
         2wDGDVFOTfaWNDaP7EF4HZkTaUeT4Ru1j1GF7Z0jxPeh+xnVmC7kQwigUrFoHxB3nNty
         CZSgfe8krYlptz+6mZHUYCqqQpJA14yowmauggkWwtB+qNidZTTDpr+XlyXkuK1i+MLU
         iww1gs2d2Kahwz2AqINJhcqGWKbYli6ziLG7onLibWIoaervDpu+UFOInIM28Y5JsoEM
         k4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834166; x=1708438966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoOD+hWlWE/17i8/Lqi/FjvHCDIa9+g3UCcdDeLmuOw=;
        b=O0MDDlIenxcRHWYNFHlzVinOiIuTZlkFt5xs9sLycwpRQXeZ5pwvCAayMODksPUTLD
         Ib+8vqziLvN5JwRwy+ydq9PltjA2DUqs7uqZUFdEvc5loL0AHRkutUMF89ofU7XRuRyc
         5HxCKzzFN+BkWoZZoXFv12IPZb7OtpTJ9ri7QD3GxR2+8gvZI9mgY/8FfN2yP3SFEXfZ
         +jCLPucREo6GsFoSvQyVSiAu7dDIelMdDECqNjKE+PLBvuGMVx80XoX8DVqFxYtRg0ux
         SJnOny8qjWKZIu00ZX/qRMNOqz204M67VX6jXzp1kgzh8fvGxD1o3JAZpyCVJ2d38b4V
         GL5w==
X-Forwarded-Encrypted: i=1; AJvYcCWzDDSAYYwjAoU3pT+ls5cEg7C7egrbAaBOb0chiJItRhBoUDV8mcRPpnF9hvWaZGj/Y1tNKr1eaIzT3qCvHenM5SMgF0LUuB5U1ihI
X-Gm-Message-State: AOJu0Yy/rQ1nT9cgRCOopEej6NGwoUzwtECo4gJZJY8+dz7b+/zZ9AKo
	V6MyK3Jh2/yFXQ+XZKK44/hRtcquqEs5ZIeWCdxrLPeXBXlBwHmZFHrl54vr/p8=
X-Google-Smtp-Source: AGHT+IHFb+hFkNqYKVSW8GLr5IBYjAxPORH03FsRoQfyMkPGmpev9pa2Jb48PJVDq1OtWR9Q55jyUg==
X-Received: by 2002:a05:6a21:998a:b0:19e:c985:f9f3 with SMTP id ve10-20020a056a21998a00b0019ec985f9f3mr3105250pzb.12.1707834166638;
        Tue, 13 Feb 2024 06:22:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmez5g8ORnZeCquaDa/pZEmHRpwGrwjXKMqaErxTDvZ007StaGvM1GQU14+e8TOcPHNYo8vnAQxxwDsyhXkEMqPooTRUEWiHvamrONe/ICFwtA5koW1vrBLKNFMFgEWPsCCODQp5o9DiKVbZddgoFbhlflFzPlz/jchblMgiunfp2N+C5zPMSOcT8u
Received: from [10.254.125.113] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id ca29-20020a056a02069d00b005cf5cbac29asm2142042pgb.53.2024.02.13.06.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:22:46 -0800 (PST)
Message-ID: <e4f3acd9-88a4-428a-8f66-1486037c35f9@bytedance.com>
Date: Tue, 13 Feb 2024 22:22:40 +0800
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
 <900cd5da-da96-4107-b5f0-c7d975a8ba97@bytedance.com>
 <CAKEwX=PtOWJ3=dur30sPBmhrAemPcoEQqJkOXCo8=XQLqO1Fvw@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=PtOWJ3=dur30sPBmhrAemPcoEQqJkOXCo8=XQLqO1Fvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/2/13 02:53, Nhat Pham wrote:
> On Mon, Feb 12, 2024 at 5:29 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/2/12 05:21, Nhat Pham wrote:
>>> On Sun, Feb 11, 2024 at 5:58 AM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> All zswap entries will take a reference of zswap_pool when
>>>> zswap_store(), and drop it when free. Change it to use the
>>>> percpu_ref is better for scalability performance.
>>>>
>>>> Testing kernel build in tmpfs with memory.max=2GB
>>>> (zswap shrinker and writeback enabled with one 50GB swapfile).
>>>>
>>>>         mm-unstable  zswap-global-lru
>>>> real    63.20        63.12
>>>> user    1061.75      1062.95
>>>> sys     268.74       264.44
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  mm/zswap.c | 30 +++++++++++++++++++++---------
>>>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>> index 7668db8c10e3..afb31904fb08 100644
>>>> --- a/mm/zswap.c
>>>> +++ b/mm/zswap.c
>>>> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
>>>>  struct zswap_pool {
>>>>         struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>>>>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>>>> -       struct kref kref;
>>>> +       struct percpu_ref ref;
>>>>         struct list_head list;
>>>>         struct work_struct release_work;
>>>>         struct hlist_node node;
>>>> @@ -303,6 +303,7 @@ static void zswap_update_total_size(void)
>>>>  /*********************************
>>>>  * pool functions
>>>>  **********************************/
>>>> +static void __zswap_pool_empty(struct percpu_ref *ref);
>>>>
>>>>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>>>  {
>>>> @@ -356,13 +357,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>>>         /* being the current pool takes 1 ref; this func expects the
>>>>          * caller to always add the new pool as the current pool
>>>>          */
>>>> -       kref_init(&pool->kref);
>>>> +       ret = percpu_ref_init(&pool->ref, __zswap_pool_empty,
>>>> +                             PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
>>>> +       if (ret)
>>>> +               goto ref_fail;
>>>>         INIT_LIST_HEAD(&pool->list);
>>>>
>>>>         zswap_pool_debug("created", pool);
>>>>
>>>>         return pool;
>>>>
>>>> +ref_fail:
>>>> +       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
>>>>  error:
>>>>         if (pool->acomp_ctx)
>>>>                 free_percpu(pool->acomp_ctx);
>>>> @@ -435,8 +441,8 @@ static void __zswap_pool_release(struct work_struct *work)
>>>>
>>>>         synchronize_rcu();
>>>>
>>>> -       /* nobody should have been able to get a kref... */
>>>> -       WARN_ON(kref_get_unless_zero(&pool->kref));
>>>
>>> Do we no longer care about this WARN? IIUC, this is to catch someone
>>> still holding a reference to the pool at release time, which sounds
>>> like a bug. I think we can simulate the similar behavior with:
>>
>> Ok, I thought it has already been put to 0 when we're here, so any tryget
>> will fail. But keeping this WARN_ON() is also fine to me, will keep it.
> 
> Yup - it should fail, if the code is not buggy. But that's a pretty big if :)
> 
> Jokes aside, we can remove it if folks think the benefit is not worth
> the cost/overhead. However, I'm a bit hesitant to remove checks in
> zswap, especially given how buggy it has been (some of which are
> refcnt bugs as well, IIRC).

Yes, agree. It looks clearer to keep it, which should be no cost at all.

Thanks!

