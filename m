Return-Path: <linux-kernel+bounces-38178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595083BC08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7041C25739
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9A0C2C4;
	Thu, 25 Jan 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SxjCDQqs"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9EE54C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171441; cv=none; b=m5yIsJp9/LIPt5G5cBHrUXItC+p6film3kK6rWTcYPIsRNtGdLoVQ7Ou+0n45i5eukxfwTNdrlmL1GNXric2D/lDF0pYbGp6ygVCUlY0/0feT1sLo7snMnA+3URRjr4mcfLKFjDp7uNBKShj6EwBjNeztelZ1rUKDREtUclln6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171441; c=relaxed/simple;
	bh=l44oJ0CyULOdaERxz736Gu+dFcSUOIqqwHFZRrU8ers=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO6pcGC/Cx+iGxCv0s07x7+qw23K3A6i1Ck1qvI+T5yz2ZjEVe0VzydRIK7Ea5EzU+3fDQu7ODiaDX0KTi1vY6yYAHupb9AKF1jK15nMp5Q9okUIfqhud9n1qgSQ25xIHEm3+pbpczOV/4RZubXttjZJzegxkffrpA+GUrbu9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SxjCDQqs; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5994e320086so3549409eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706171437; x=1706776237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwxZ89BJlc+x6KjX9RIj+qjWv5VNKTF5oPpXEEUlSoI=;
        b=SxjCDQqsEi8NxIHq9/RQFm1YT2xcrBd2H7MkkfY8UHrfmGDxVxVXs9USWRVPMbPlZW
         1PQQfPeZS2i+UFyfdR8uOw+DINcIPb2mIrsAgIJxH8dbdPMmCykjkv/nhcspmGHZaKNG
         WrVLfJDQBR/ka7VXzA1Y0iD0D7fiA8z37Psr4gCJe8MKcfRshvh7BQwiP0VwtJDCtVLp
         eqfUBoIJDx3+vqnR/bTNFQ2iyRtd3Q+bXBrjUbvOQdS4tobP6qPOGc1hDtpyAWQ5gLNE
         j/swaDO3IYz+59DNN4IOT4Qn0Vy3JvchvMtTMK89WXIGJ+hxJsu0JLmqxdoufpHu3i/b
         +6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171437; x=1706776237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwxZ89BJlc+x6KjX9RIj+qjWv5VNKTF5oPpXEEUlSoI=;
        b=gfxGzXccIMmnjlQZTwsgRIghWnyTxHrqx4Vz1XXeedobPLkNi/UeJRi8XSjD0BrZIc
         149UbTkBu8le5Yt9pcI7h/dx2+fWtLceNQEytuTDyvixjuVOaontq41ZULh2rbK5WSWJ
         oQzVVLzX/gJxpVJ7r8Ydkrya5YHxlNCbYjxqUt0RnWKgRWxJ+3AqpIL1qRvPPCLKAytd
         YmXB4o5kT+3ZnwZIFKsT32mzgUHSbFMsxFuHE+sVzrTSW66ikUN6oVw5wKF2MTDUqfC5
         HwLNd8I/CeOKR2uGas31GyAyXOeC6LVKfEXlXXJpMAU7J4z583gSjXsXqvlgf1Fj5eYO
         xOtw==
X-Gm-Message-State: AOJu0YyXv5QVwto99Zq84BUrMgz9tsz1skZAjNW6NekAx0L7vi3WuAc8
	Q+zMwFEegT44FnyO2tfhCsVO8X9EfY6pzsOtHI1oni713NXxJ2vIi0ZoLfPKPew=
X-Google-Smtp-Source: AGHT+IGk/ptGROJhqqMQq2ViqVW7xz+uINt3phL+/LVfUWQOsNEd1sf1i68ZEjnezYTXkBlml1Kp9A==
X-Received: by 2002:a05:6358:2244:b0:170:17eb:b4c with SMTP id i4-20020a056358224400b0017017eb0b4cmr618258rwc.54.1706171437371;
        Thu, 25 Jan 2024 00:30:37 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00000400b006ddcb9adda1sm919738pfk.163.2024.01.25.00.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:30:37 -0800 (PST)
Message-ID: <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com>
Date: Thu, 25 Jan 2024 16:30:31 +0800
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
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/25 15:53, Yosry Ahmed wrote:
>> Hello,
>>
>> I also thought about this problem for some time, maybe something like below
>> can be changed to fix it? It's likely I missed something, just some thoughts.
>>
>> IMHO, the problem is caused by the different way in which we use zswap entry
>> in the writeback, that should be much like zswap_load().
>>
>> The zswap_load() comes in with the folio locked in swap cache, so it has
>> stable zswap tree to search and lock... But in writeback case, we don't,
>> shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
>> then release lru lock to get tree lock, which maybe freed already.
>>
>> So we should change here, we read swpentry from entry with lru list lock held,
>> then release lru lock, to try to lock corresponding folio in swap cache,
>> if we success, the following things is much the same like zswap_load().
>> We can get tree lock, to recheck the invalidate race, if no race happened,
>> we can make sure the entry is still right and get refcount of it, then
>> release the tree lock.
> 
> Hmm I think you may be onto something here. Moving the swap cache
> allocation ahead before referencing the tree should give us the same
> guarantees as zswap_load() indeed. We can also consolidate the
> invalidate race checks (right now we have one in shrink_memcg_cb() and
> another one inside zswap_writeback_entry()).

Right, if we successfully lock folio in the swap cache, we can get the
tree lock and check the invalidate race, only once.

> 
> We will have to be careful about the error handling path to make sure
> we delete the folio from the swap cache only after we know the tree
> won't be referenced anymore. Anyway, I think this can work.

Yes, we can't reference tree if we early return or after unlocking folio,
since the reference of zswap entry can't protect the tree.

> 
> On a separate note, I think there is a bug in zswap_writeback_entry()
> when we delete a folio from the swap cache. I think we are missing a
> folio_unlock() there.

Ah, yes, and folio_put().

> 
>>
>> The main differences between this writeback with zswap_load() is the handling
>> of lru entry and the tree lifetime. The whole zswap_load() function has the
>> stable reference of zswap tree, but it's not for shrink_memcg_cb() bottom half
>> after __swap_writepage() since we unlock the folio after that. So we can't
>> reference the tree after that.
>>
>> This problem is easy to fix, we can zswap_invalidate_entry(tree, entry) early
>> in tree lock, since thereafter writeback can't fail. BTW, I think we should
>> also zswap_invalidate_entry() early in zswap_load() and only support the
>> zswap_exclusive_loads_enabled mode, but that's another topic.
> 
> zswap_invalidate_entry() actually doesn't seem to be using the tree at all.
> 
>>
>> The second difference is the handling of lru entry, which is easy that we
>> just zswap_lru_del() in tree lock.
> 
> Why do we need zswap_lru_del() at all? We should have already isolated
> the entry at that point IIUC.

I was thinking how to handle the "zswap_lru_putback()" if not writeback,
in which case we can't use the entry actually since we haven't got reference
of it. So we can don't isolate at the entry, and only zswap_lru_del() when
we are going to writeback actually.

Thanks!

