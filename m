Return-Path: <linux-kernel+bounces-38196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BC83BC58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7350C1F2A5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912D11B96C;
	Thu, 25 Jan 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lTOnOuYp"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87EF18044
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172741; cv=none; b=JPlvaj/GMkIeCbjHuERJ6TNR70anib3NxA0QvSrtD2B++yg0L/8nSJzcTcvVFwSLDYldwaLJ0mx+3AwtN+MQ9lxBcDFQdvYoR7qtjo9DzjrJ+KKc8cAu50IX8vZezy/fvv9UyQhKmpflmdLekpmiohFQ07T5TFoSC5PpI6LsBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172741; c=relaxed/simple;
	bh=HEnUBiuLw+OIx22HFEZkQL3JqRl3WIca8WvxBLm7tn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWvTUQM6g4sGBPIvxvlkCMVw9hb8YEj2b9lQkw6m9pZF68HnMny9XGudw0TeYOyrf3snWesY9/ztypiwZlFgL4gmZM/bWMud4AA53ArPqlgNeRvc/hn+cnzBp3rAaLN6hOxVPIW8VLW4yOSSw1ZLQSWvqL48OiRdFv877U3/Aak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lTOnOuYp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bda5be862eso4062896b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706172739; x=1706777539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkGQoIYNC+nMybNFXcUXZhNlJLPpzMlk/G5qwiD/mfw=;
        b=lTOnOuYpySqhrtWUUysEz1fcgKX45Eg56HQNOwFpaAa2e432tB9uxlZqlOCsWZa1r5
         FD9XH1o0hR2Ejts5xizSF3GQxlRl9IH1eTd+xmmajPugx/RGFkRisgCSGLXGyVq8f3PI
         qwyzkaMnikeEfS4GNMzL7zxj0E0NEmzSthaKJGInPnWa/A/JS7BGmGgWYXtrYG78QzuB
         70qODfmQ2n2tp5ol8vAzJdMM3tRLJ7rAGAXJXZKjg26rX4/QLmoBWY/nsvQ4WAiK2TBI
         DmbkS3IrAgogDA0T8hzUjBMdQMulY3RaPAHH4R3e+8cXuLDiGX0fBAteADAVHQOO/BxK
         k5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172739; x=1706777539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkGQoIYNC+nMybNFXcUXZhNlJLPpzMlk/G5qwiD/mfw=;
        b=Ql93rQAxiezWwu+V3v7GwMuRKjTMNfAv4z26tFIVlIspGFxdyQNRn7o7k/MKDUzUaX
         nWzf7ITvhA8izR7ZbnzeV4FyOUNaUWTD2ck6YzbqQgqRiUkqPBhmOW3+mqT8hajsJyDJ
         7mc2HOBB4Mji/2kOBFwaE3MQ//NciA7ov2wGaxHVLF2eIEVkQ9LVr+H3GkdYJIXr4ndY
         LwTqMfidxVyBtqlirZQvnn3bz12MQyBO/Tns5dQW9saQVmCkrxy1/+Bemzm1Zm6Oeqdw
         pdvMag/SctHkANAlhKtMb6cCeOHnpxmCnFh0pNdmrEhJDMt3/PtZ974/Rfk6edO0NlV4
         +U9Q==
X-Gm-Message-State: AOJu0YyJMmVv7xurvvXELUJVFnRlG/2af0PHlS3wteCrAr2E7dQdfBvh
	kc0ONke2G0+gvRfbR+dVPawJBRLlgfmNeyzjfiGoi+Y7TvwWw5OlDLfcTHw5fnU=
X-Google-Smtp-Source: AGHT+IE3KQ6LFPbSUS7KHTooCvwgkX/cufH/YfcEdQp9M1/ylyfGjHKPw8tFuV/tMyB3cXv/EPsLGQ==
X-Received: by 2002:a05:6808:148f:b0:3bd:dae2:b9b1 with SMTP id e15-20020a056808148f00b003bddae2b9b1mr603753oiw.3.1706172738781;
        Thu, 25 Jan 2024 00:52:18 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a11-20020aa780cb000000b006dbd5a5dca9sm8764698pfn.185.2024.01.25.00.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:52:18 -0800 (PST)
Message-ID: <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com>
Date: Thu, 25 Jan 2024 16:52:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
 <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org>
 <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org>
 <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
 <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
 <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com>
 <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/25 16:42, Yosry Ahmed wrote:
> On Thu, Jan 25, 2024 at 12:30 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/1/25 15:53, Yosry Ahmed wrote:
>>>> Hello,
>>>>
>>>> I also thought about this problem for some time, maybe something like below
>>>> can be changed to fix it? It's likely I missed something, just some thoughts.
>>>>
>>>> IMHO, the problem is caused by the different way in which we use zswap entry
>>>> in the writeback, that should be much like zswap_load().
>>>>
>>>> The zswap_load() comes in with the folio locked in swap cache, so it has
>>>> stable zswap tree to search and lock... But in writeback case, we don't,
>>>> shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
>>>> then release lru lock to get tree lock, which maybe freed already.
>>>>
>>>> So we should change here, we read swpentry from entry with lru list lock held,
>>>> then release lru lock, to try to lock corresponding folio in swap cache,
>>>> if we success, the following things is much the same like zswap_load().
>>>> We can get tree lock, to recheck the invalidate race, if no race happened,
>>>> we can make sure the entry is still right and get refcount of it, then
>>>> release the tree lock.
>>>
>>> Hmm I think you may be onto something here. Moving the swap cache
>>> allocation ahead before referencing the tree should give us the same
>>> guarantees as zswap_load() indeed. We can also consolidate the
>>> invalidate race checks (right now we have one in shrink_memcg_cb() and
>>> another one inside zswap_writeback_entry()).
>>
>> Right, if we successfully lock folio in the swap cache, we can get the
>> tree lock and check the invalidate race, only once.
>>
>>>
>>> We will have to be careful about the error handling path to make sure
>>> we delete the folio from the swap cache only after we know the tree
>>> won't be referenced anymore. Anyway, I think this can work.
>>
>> Yes, we can't reference tree if we early return or after unlocking folio,
>> since the reference of zswap entry can't protect the tree.
>>
>>>
>>> On a separate note, I think there is a bug in zswap_writeback_entry()
>>> when we delete a folio from the swap cache. I think we are missing a
>>> folio_unlock() there.
>>
>> Ah, yes, and folio_put().
> 
> Yes. I am preparing a fix.
> 
>>
>>>
>>>>
>>>> The main differences between this writeback with zswap_load() is the handling
>>>> of lru entry and the tree lifetime. The whole zswap_load() function has the
>>>> stable reference of zswap tree, but it's not for shrink_memcg_cb() bottom half
>>>> after __swap_writepage() since we unlock the folio after that. So we can't
>>>> reference the tree after that.
>>>>
>>>> This problem is easy to fix, we can zswap_invalidate_entry(tree, entry) early
>>>> in tree lock, since thereafter writeback can't fail. BTW, I think we should
>>>> also zswap_invalidate_entry() early in zswap_load() and only support the
>>>> zswap_exclusive_loads_enabled mode, but that's another topic.
>>>
>>> zswap_invalidate_entry() actually doesn't seem to be using the tree at all.
>>>
>>>>
>>>> The second difference is the handling of lru entry, which is easy that we
>>>> just zswap_lru_del() in tree lock.
>>>
>>> Why do we need zswap_lru_del() at all? We should have already isolated
>>> the entry at that point IIUC.
>>
>> I was thinking how to handle the "zswap_lru_putback()" if not writeback,
>> in which case we can't use the entry actually since we haven't got reference
>> of it. So we can don't isolate at the entry, and only zswap_lru_del() when
>> we are going to writeback actually.
> 
> Why not just call zswap_lru_putback() before we unlock the folio?

When early return because __read_swap_cache_async() return NULL or !folio_was_allocated,
we don't have a locked folio yet. The entry maybe invalidated and freed concurrently.


