Return-Path: <linux-kernel+bounces-3134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F38167D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF814282E84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2610795;
	Mon, 18 Dec 2023 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k+GQvKus"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57A10780
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3b81d9719so2017335ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702886803; x=1703491603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKpKYYK42lyrlJVZUzEtCbY2uWIDCagMFLNrbzTht/c=;
        b=k+GQvKuswG5FnZSZ0ij7TjtaNR4IUfCTkTai8I/tQwl49LPilSJg62cd6uwTAtPVZ4
         yuG8Qejy9VXNORMYxsyXHtF4bH7q8vWcNGGhD5b3yr30TIq1RHpkcysUyQ4du15IWNNr
         /1aesnxd2U74UZgjWKoSkI2vsn1YB6kqPnC4xNsg52oOEHLdwXnwMsU3bzM2GkPvT6ST
         Nxf5m8W7+zmkw13ZLEu228H+KIw6JPFKUsE+P3yBonWnY6hppqv8kKAzOK/uqtxhlYI5
         yyFV7MqXJooIJ8nDLFbJqyRuL7hyGINCnVRWIVOb5EgqARGzlFW0w7upc2Fc48Z07nLt
         YbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702886803; x=1703491603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKpKYYK42lyrlJVZUzEtCbY2uWIDCagMFLNrbzTht/c=;
        b=rwRmfl/XSUJ0ZLvjsk5bLH4/8+n+Zg0S/OS2DpDO2vrUgLufly/0GUyieLyychvMpb
         iZwLMU7ZGknRkMDEjzyk/Fs8whNYx2kLYguqkcdp+t942DbkcZ7V5XzTBoqb5a78eOwC
         3UcbOb4vyWrB75yava96OlNT8ANhI2gItIm0M+MJG4RUBiHHtyF1hjGRCkrpJopwcwEq
         /GBkvi8Wa+a8+f2/sRys54k/y4ubqGXkJkF8fFauoSz1AMdhUknyHI05HacHRatsi7ZA
         kqPaWqblI2E8a+fAmnKguH/Wcch+dfIj/V+GQXIOZK0djxNG9teBdaMiDIpb0hiEbf7D
         rkMg==
X-Gm-Message-State: AOJu0YxNhqXYZTvi5SRcj2ozs9CDnJ0w7y70cB6+lfpnXuTali57ik6z
	w/CpnttC5glSh6nQmaHl0PHcsw==
X-Google-Smtp-Source: AGHT+IEmBpCgHNY3z24DRgeInDn/ZQYlcH3au2XzyksRfAJCYpV0kqf7zyoMsEDi0od3TsN7l4Z/tA==
X-Received: by 2002:a17:903:2b03:b0:1d3:6df0:840d with SMTP id mc3-20020a1709032b0300b001d36df0840dmr3174222plb.138.1702886803356;
        Mon, 18 Dec 2023 00:06:43 -0800 (PST)
Received: from [10.4.170.32] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001d0b6ba60fdsm18404547plp.175.2023.12.18.00.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:06:42 -0800 (PST)
Message-ID: <d45d1879-bbc0-4d74-b34f-92f9753d1a30@bytedance.com>
Date: Mon, 18 Dec 2023 16:06:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
 <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
 <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com>
 <CAJD7tkbS_3eEDbfo-w1Z+tuY44YKMYnAqaL0684Y6nh2EmHq+Q@mail.gmail.com>
 <dc84f965-9174-4ce7-aedf-f68d8e8003b4@bytedance.com>
 <CAJD7tkYdisUg+wphANLFcBSLB13jH+NxqFdc-EjKBq0H-=S00Q@mail.gmail.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkYdisUg+wphANLFcBSLB13jH+NxqFdc-EjKBq0H-=S00Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/15 02:24, Yosry Ahmed wrote:
> On Thu, Dec 14, 2023 at 6:42 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> [..]
>>>>>> -
>>>>>>         /* decompress */
>>>>>> -       dlen = PAGE_SIZE;
>>>>>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>>>>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>>>>>> +       mutex_lock(acomp_ctx->mutex);
>>>>>>
>>>>>> +       zpool = zswap_find_zpool(entry);
>>>>>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>>>>>         if (!zpool_can_sleep_mapped(zpool)) {
>>>>>> -               memcpy(tmp, src, entry->length);
>>>>>> -               src = tmp;
>>>>>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>>>>>> +               src = acomp_ctx->dstmem;
>>>>>
>>>>> I don't like that we are now using acomp_ctx->dstmem and
>>>>> acomp_ctx->mutex now for purposes other than what the naming suggests.
>>>>
>>>> The "mutex" name is coherent, "dstmem" depends on how we use IMHO.
>>>> Change to just "mem"? Or do you have a better name to replace?
>>>>
>>>>>
>>>>> How about removing these two fields from acomp_ctx, and directly using
>>>>> zswap_dstmem and zswap_mutex in both the load and store paths, rename
>>>>> them, and add proper comments above their definitions that they are
>>>>> for generic percpu buffering on the load and store paths?
>>>>
>>>> Yes, they are percpu memory and lock, but they are used by per acomp_ctx,
>>>> and the cpu maybe changing in the middle, so maybe better to keep them.
>>>
>>> I don't mean to remove completely. Keep them as (for example)
>>> zswap_mem and zswap_mutex global percpu variables, and not have
>>> pointers in acomp_ctx to them. Instead of using acomp_ctx->dstmem
>>> today, we directly use the global zswap_mem (same for the mutex).
>>>
>>> This makes it clear that the buffers are not owned or exclusively used
>>> by the acomp_ctx. WDYT?
>>
>> Does this look good to you?
>>
>> ```
>> int cpu = raw_smp_processor_id();
>>
>> mutex = per_cpu(zswap_mutex, cpu);
>> mutex_lock(mutex);
>>
>> dstmem = per_cpu(zswap_dstmem, cpu);
> 
> Renaming to zswap_buffer or zswap_mem would be better I think, but
> yeah what I had in mind is having zswap_mutex and
> zswap_[dstmem/mem/buffer] be generic percpu buffers that are used by
> store and load paths for different purposes, not directly linked to
> acomp_ctx.
> 

Ok, I'll append a patch to do the refactor & cleanup: remove mutex
and dstmem from acomp_ctx, and rename to zswap_buffer, then directly
use them on the load/store paths.

>> acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
>>
>> /* compress or decompress */
>> ```
>>
>> Another way I just think of is to make acomp_ctx own its lock and buffer,
>> and we could delete these percpu zswap_mutex and zswap_dstmem instead.
> 
> You mean have two separate set of percpu buffers for zswap load &
> stores paths? This is probably unnecessary.

Alright. Thanks.

