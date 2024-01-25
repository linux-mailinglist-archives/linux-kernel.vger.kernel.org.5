Return-Path: <linux-kernel+bounces-38291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD5383BD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A301C23CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1561CD1C;
	Thu, 25 Jan 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OuqMn9lr"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA091CD16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175510; cv=none; b=P7jE0Ck3q7RWDr0sO6+Q/9q++EOydrP+EsCEgVjFY0pGjaIoUPh71ttMIIAapQIWJGMA9ZH/TiZG/ML7lg8GLkIhzuU6gsVP7/K98Ajkg4KBla+AWM2458OtWPwUtkaFBQrDMDuOT5+vWXhiWkVUcf8YTV6WqZMUCuJSegElfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175510; c=relaxed/simple;
	bh=0sOcb8GBs2ftSAjMf8ketU17zizcRDHYVrBzO0rltrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4XJYXczI5p8k83mvoyVYOx71JKM6VHdw/sD655NNF6ew5vXz7/40teeMkEVYQVbQiH3iWFCvoCMnI+vzS2KYveF/wMrJgIeiVzp4DDGfVyskgWkKNhQhm2FMhp5wY53vBusVguDeSVB66txKoYvG30/C0ireu3MbFSAXwH5EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OuqMn9lr; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-362a24b136fso1186335ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706175507; x=1706780307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KW4jHyEa7kFs7oT9yas8ifPzAyaH1yeBSUUUHJFfAc=;
        b=OuqMn9lr6yb0cTQpXBfSijWWI9VNhxKjRjU2SgHnjQcn8bvCbhX/NjKoxkJV2bJaMn
         74tp5XHuC4eHtxEblfieUCLKG/dQkJxzNDrWyT5iC6wCuSktLc81098NG5+Pe3xV5/9W
         B7hwX4w9SSDFk5Q0zS2Ok9qdlLnPUiTtR+TtBywu6BSso1WRAnd/l1tzfb0DwN702cXb
         c3wFskp3U4/kCGNGcdyF81EsgkwNs+IBd+rdtz5CpbwYryD0ynRCpKowVHpNEf5+ykE7
         JO//vrkslwU5BILXXsE/i+7wxOvo9yJbFxcW7ka9GNxtAzEFQXpAw5cUeDlmYS5+qy6w
         DRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175507; x=1706780307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KW4jHyEa7kFs7oT9yas8ifPzAyaH1yeBSUUUHJFfAc=;
        b=wB5IiKDim7e3RnSEu776BvhNBMb+Ig2MLytpHb+m7pZVwHW+D5M7UejgrCGzVLt3NR
         zhbyP4Z5SoQ3dhGeZ8SqtYLD02IxFr8h63DPxCm6fTxAMHooIyAfg8paHzzPQfkD+ZsE
         g0j/cvZo3ixrNfrKEWTCH3piTuYqnPzz5gvP2ulaGlDE113wKe3FHIbH1p+AJglIfr/y
         zglDljckenNAOyeaUP8qjGagfmNpWooM4QBYi+W21o13GfR+Hdst2lTZCtwYm2RjoLUx
         yPx9lXTDwLDnPpttMJU5Rrcu9WRE3n4r88PTy5bBWpLC7XuMcHIFNyT60z3L86gXaF9s
         SBWQ==
X-Gm-Message-State: AOJu0YyMkGWS23d2SzdFV8sfz9+LsWVkpmGtnbGYR5BWFVwWB0gInM/5
	tlYTTgWPS+JBjE2wqZtfcX/a77TA7agGvzFjGxqHxRGhQbOEZKTrLxdYYNwcBUM=
X-Google-Smtp-Source: AGHT+IE0YcGyxn+lstZACLJCx7aiaPb2obv9RRNzDuZgcO5pg9nfVRo//pcffrCR8x+sc55LCaFcvA==
X-Received: by 2002:a05:6e02:80e:b0:361:a91d:aaac with SMTP id u14-20020a056e02080e00b00361a91daaacmr915987ilm.63.1706175507515;
        Thu, 25 Jan 2024 01:38:27 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id k69-20020a633d48000000b005cf5bf78b74sm12849244pga.17.2024.01.25.01.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:38:27 -0800 (PST)
Message-ID: <68b7f87b-7f15-410c-9094-9fe9865b4bc4@bytedance.com>
Date: Thu, 25 Jan 2024 17:38:21 +0800
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
 <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com>
 <CAJD7tkak+ZA8t+AVbYNXYWnrmVBBs=NfMTBQBsnHJQni2=gG2Q@mail.gmail.com>
 <1a8a513f-fa84-41ca-b7f4-62726e78fd31@bytedance.com>
 <CAJD7tkYBLkh82VQ6DmNQNXtnCxTVOY_7JRjARRtDrkKfKyTFSQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkYBLkh82VQ6DmNQNXtnCxTVOY_7JRjARRtDrkKfKyTFSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/25 17:26, Yosry Ahmed wrote:
> On Thu, Jan 25, 2024 at 1:22 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/1/25 17:03, Yosry Ahmed wrote:
>>>>>>>> The second difference is the handling of lru entry, which is easy that we
>>>>>>>> just zswap_lru_del() in tree lock.
>>>>>>>
>>>>>>> Why do we need zswap_lru_del() at all? We should have already isolated
>>>>>>> the entry at that point IIUC.
>>>>>>
>>>>>> I was thinking how to handle the "zswap_lru_putback()" if not writeback,
>>>>>> in which case we can't use the entry actually since we haven't got reference
>>>>>> of it. So we can don't isolate at the entry, and only zswap_lru_del() when
>>>>>> we are going to writeback actually.
>>>>>
>>>>> Why not just call zswap_lru_putback() before we unlock the folio?
>>>>
>>>> When early return because __read_swap_cache_async() return NULL or !folio_was_allocated,
>>>> we don't have a locked folio yet. The entry maybe invalidated and freed concurrently.
>>>
>>> Oh, that path, right.
>>>
>>> If we don't isolate the entry straightaway, concurrent reclaimers will
>>> see the same entry, call __read_swap_cache_async(), find the folio
>>> already in the swapcache and stop shrinking. This is because usually
>>> this means we are racing with swapin and hitting the warmer part of
>>> the zswap LRU.
>>>
>>> I am not sure if this would matter in practice, maybe Nhat knows
>>> better. Perhaps we can rotate the entry in the LRU before calling
>>> __read_swap_cache_async() to minimize the chances of such a race? Or
>>> we can serialize the calls to __read_swap_cache_async() but this may
>>> be an overkill.
>>
>> Also, not sure, rotate the entry maybe good IMHO since we will zswap_lru_del()
>> once we checked the invalidate race.
> 
> Not sure what you mean. If we rotate first, we won't have anything to
> do in the failure case (if the folio is not locked). We will have to
> do zswap_lru_del() if actually writeback, yes, but in this case no
> synchronization is needed because the folio is locked, right?

Right, sorry for my confusing expression. We rotate first in lru lock,
and only zswap_lru_del() later if actually writeback.

What I want to mean is that the possibility of seeing the entry on lru list
by another reclaimer is very low, since we rotate and the timing between
__read_swap_cache_async() and zswap_lru_del() should be short.

