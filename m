Return-Path: <linux-kernel+bounces-85245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9A86B2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B21289480
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0215B995;
	Wed, 28 Feb 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZEKDPp+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758D15A4B9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133147; cv=none; b=hYuI8Pwc7jnYXG0Q2vd0rcijMwU4aq2nmj73D5V7uUJpDl/koGh4xHaTS3F7+iOn8nGy5gjGm6xOi8tf0e2dwS8SnDmSjH0vQjUTxL9CnSx0BKbz0kbZPPaDge0400TLTRr8rj47OFboiQXrHpJm566PUH9OwH6wVpB5L1HeUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133147; c=relaxed/simple;
	bh=1gNZqZ3w91nSviRKhl1gYGK4B6wmiPCq6W3/gE+juCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1PQbDwUEkzQUCR9+aHHjS0CLZwMB7GyAj89kpaoUXQsmd7JZuScNF8gMKMSHpeiQrRg8srdMhraMWJaozORng8bgJEZbCgbNI4xVWzfU2uiYLt9D6jMAGlmXknKa47dgWdJ1F5itxzvpKMeGxDocu8vH4LM6ubyeOolaCCGpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZEKDPp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709133144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sbhMkzaZEl8Vud3IL4fneo3h/1PgiuMba1RO8XifInI=;
	b=AZEKDPp+H0Fb/esNG+jTbOXeT4cSLTSNj5RpUbsWH/8eRI8x4V/NTCjEfOaJT6GekJCid4
	pZLeO8lz07kxMZmkPIFZ/Y87lrRrTjvPCF7VZm9OBLrCdrZ27asr4t1sahIChf2sbqDRqA
	eSLOZvJdUjpdWF8WQhMu4ANGXwEOw24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-I3MSX58mPXOsLAqGUoteiA-1; Wed, 28 Feb 2024 10:12:22 -0500
X-MC-Unique: I3MSX58mPXOsLAqGUoteiA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412ae5704f7so11036055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133141; x=1709737941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbhMkzaZEl8Vud3IL4fneo3h/1PgiuMba1RO8XifInI=;
        b=P0daT696h5cKNuutIXAE8ibXeSTX1FrnYJXW6uVYixX/LMfl4GUg3+x4ocVJH++7VU
         BxTWm5yOWzeC+hbC5haH1xVMNmID0Pe0x/YHTtUSR8zprREzVsvKstzW35WTMaT2WRq8
         kXHHTPtbXp8UspXS3K6YckK5bk0sgsXiZt1AwCPXXHl4r0vm8beWKun+aAZteCKSXrAb
         MJt57U7G1Cuo/iO+ABZKrX63p1sksnHXgSaq6+ZhVr3WCSkqUxKPtzP1mxI5JYv/DdOR
         GYFZiOO7E3LJi3iOe50lOmaQU0MxdjmpweH1Y+DOmv64wAUiF5PlPE/10S14v+awEVHa
         9Wjg==
X-Gm-Message-State: AOJu0Yw96C1KHHr5+G/vGm4WFBVysoZw216Df9Wq4Tl6n7z6tlV9NKhz
	HJdIWmgALPjGaEwnNULTDv9zsXmcFbT2pCexG1wg6UM783ELtqZ9ZMJVmdu7ffT8gsWmW6mYMJk
	LQ551rayUj9WLvg1b7TZFrtlMEstInafKVE/M7feaASYLlgJy0h5i5t+ttImcTg==
X-Received: by 2002:a05:600c:5408:b0:412:9868:97ed with SMTP id he8-20020a05600c540800b00412986897edmr9959273wmb.9.1709133141685;
        Wed, 28 Feb 2024 07:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg35nA6IVKDGDKj6JJLm6P/DQ0qNVHllrnCr02fizsmJOCkUGQgfdXfzTMn+UXg0Su/YfcFA==
X-Received: by 2002:a05:600c:5408:b0:412:9868:97ed with SMTP id he8-20020a05600c540800b00412986897edmr9959253wmb.9.1709133141188;
        Wed, 28 Feb 2024 07:12:21 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bo14-20020a056000068e00b0033d6bc17d0esm15629410wrb.74.2024.02.28.07.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:12:20 -0800 (PST)
Message-ID: <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
Date: Wed, 28 Feb 2024 16:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.02.24 15:57, Ryan Roberts wrote:
> On 28/02/2024 12:12, David Hildenbrand wrote:
>>>> How relevant is it? Relevant enough that someone decided to put that
>>>> optimization in? I don't know :)
>>>
>>> I'll have one last go at convincing you: Huang Ying (original author) commented
>>> "I believe this should be OK.  Better to compare the performance too." at [1].
>>> That implies to me that perhaps the optimization wasn't in response to a
>>> specific problem after all. Do you have any thoughts, Huang?
>>
>> Might make sense to include that in the patch description!
>>
>>> OK so if we really do need to keep this optimization, here are some ideas:
>>>
>>> Fundamentally, we would like to be able to figure out the size of the swap slot
>>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
>>> to mark it as PMD_SIZE.
>>>
>>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>>> cluster will contain only one size of THPs, but this is not the case when a THP
>>> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
>>> cases to be rare.
>>>
>>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>>> time it will be the full size of the swap entry, but sometimes it will cover
>>> only a portion. In the latter case you may see a false negative for
>>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>>> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
>>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
>>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>>
>>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>>> precise information and is conceptually simpler to understand, but will cost
>>> more memory (half as much as the initial swap_map[] again).
>>>
>>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>>> prototyping.
>>
>> Taking a step back: what about we simply batch unmapping of swap entries?
>>
>> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
>> lock) that reference consecutive swap offsets in the same swap file.
> 
> Yes in principle, but there are 4 places where free_swap_and_cache() is called,
> and only 2 of those are really amenable to batching (zap_pte_range() and
> madvise_free_pte_range()). So the other two users will still take the "slow"
> path. Maybe those 2 callsites are the only ones that really matter? I can
> certainly have a stab at this approach.

We can ignore the s390x one. That s390x code should only apply to KVM 
guest memory where ordinary THP are not even supported. (and nobody uses 
mTHP there yet).

Long story short: the VM can hint that some memory pages are now unused 
and the hypervisor can reclaim them. That's what that callback does (zap 
guest-provided guest memory). No need to worry about any batching for now.

Then, there is the shmem one in shmem_free_swap(). I really don't know 
how shmem handles THP+swapout.

But looking at shmem_writepage(), we split any large folios before 
moving them to the swapcache, so likely we don't care at all, because 
THP don't apply.

> 
>>
>> There, we can then first decrement all the swap counts, and then try minimizing
>> how often we actually have to try reclaiming swap space (lookup folio, see it's
>> a large folio that we cannot reclaim or could reclaim, ...).
>>
>> Might need some fine-tuning in swap code to "advance" to the next entry to try
>> freeing up, but we certainly can do better than what we would do right now.
> 
> I'm not sure I've understood this. Isn't advancing just a matter of:
> 
> entry = swp_entry(swp_type(entry), swp_offset(entry) + 1);

I was talking about the advancing swapslot processing after decrementing 
the swapcounts.

Assume you decremented 512 swapcounts and some of them went to 0. AFAIU, 
you'd have to start with the first swapslot that has now a swapcount=0 
one and try to reclaim swap.

Assume you get a small folio, then you'll have to proceed with the next 
swap slot and try to reclaim swap.

Assume you get a large folio, then you can skip more swapslots 
(depending on offset into the folio etc).

If you get what I mean. :)

-- 
Cheers,

David / dhildenb


