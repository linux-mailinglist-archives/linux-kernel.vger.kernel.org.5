Return-Path: <linux-kernel+bounces-88708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1A86E5A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B801F2662B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902F5231;
	Fri,  1 Mar 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZM0Npuu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2F16FF40
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310729; cv=none; b=UGiBGOEhnc6iKM2EduKIi/clghsfrXK9U/zz4kORA3zPPPJaP13J11DXPgAF4/8IqFON2ZpK6bJLcxlWui2romaAmhqN3Cgmhk51++h/5snpvnXQWvuR95Xi0423QW3eh0d+tjU58w1aCixKDtAg0uyPlhqoHLnj09M6FCDWYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310729; c=relaxed/simple;
	bh=uqMkKRJ6B3+MJse4K3jID72MwSNmBCW1dOC04g13JDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+DLb2tmC/K5Tl4GKoOASGAwMezamsRQ0zJZhD08msXzVH4eQzp8dGKj5ODl5/DQkaBso/SNZW1QlTLjyF4tehj/6iQZX9zucSIwqEPVXzPpfjVGimR3slvdDwk0NGs+VLtSm5iAwGCAhXiQ/la2bKwL4/rPuzJRA/M2RazWtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZM0Npuu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709310726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uTwhN2TF09fHVTd85Qn1FuxStIWaXYTKHi2aA5cb25I=;
	b=FZM0Npuu7Sz69XL4zKvdwhmWUik0x5AtobFLNKLof9h5wSBwFOdhP0K8Yys2vo9ubtS9vZ
	kT1YUAMJOo5+9k0WrXVq24WxjLSDrXlEN37uIe6KODEZMbAiwchkBJM7DIC9n548hR6bc/
	PNPsJ6QYnrpC5gspF0DCloRkehX6ieE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ri-_tC1yN-qoG17ti_wJzw-1; Fri, 01 Mar 2024 11:32:05 -0500
X-MC-Unique: ri-_tC1yN-qoG17ti_wJzw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51333e20813so450435e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310724; x=1709915524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTwhN2TF09fHVTd85Qn1FuxStIWaXYTKHi2aA5cb25I=;
        b=K/NX6gdn/UiMh+ucBvyiost2NEIEuh9ybe5ArKj9k5C6/yxKDhB9cSZ7d85bKQf6z3
         4/w3U7U6ooUHoMkwvHdgczMtnS1X2c2se15TpsiyIfaWX4MzOQo2o3j9yz29nbah8Pnv
         TWjOkumdcpC/topvyHm2hkRymKDn6O54FHQAn99FwslJi6Dv8LPSwesALdFUH2WVMNh5
         C0u6kRIzpJElF6dlTnA+bec19E7A2r+2wEHG9JP/IDRJXf5zRTfQHzOvwk5grTbJHxhL
         gYpB+S6iaqVKaZSl7k0crPq2SLshsABsROGJGg3VQ/10cYVDieqv2/sBcRxecwbvM6a5
         RcbQ==
X-Gm-Message-State: AOJu0Yxu10Z1mbkqPs3Yhu9gpHQRyska7Z5LCV+XMGVqhYVJtKAlt0Rx
	Il3OCWcfgRlI5vcs3JmQFGI3EAfCYpToFIZgYRTOMes6f605IOB9caT3URDv99ZN3LYaID0XcL7
	m47LhfCVVhuM2aNyM+zZop1qAFQChNXbDAcCU7SH+9Mmx+gi/88MEA3nmvs9fGhiF+YoETA==
X-Received: by 2002:a05:6512:34c8:b0:512:ed33:c16 with SMTP id w8-20020a05651234c800b00512ed330c16mr1717714lfr.8.1709310723731;
        Fri, 01 Mar 2024 08:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZwq6ERdUXZFp063xBV3pwiQ9RToqSL8DuwtPI6F5Wj1/fp0bmNh0hrZvGt1L/7y12DvmW+w==
X-Received: by 2002:a05:6512:34c8:b0:512:ed33:c16 with SMTP id w8-20020a05651234c800b00512ed330c16mr1717693lfr.8.1709310723246;
        Fri, 01 Mar 2024 08:32:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c713:3200:77d:8652:169f:b5f7? (p200300cbc7133200077d8652169fb5f7.dip0.t-ipconnect.de. [2003:cb:c713:3200:77d:8652:169f:b5f7])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b0033e25c39ac3sm58396wrb.80.2024.03.01.08.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:32:02 -0800 (PST)
Message-ID: <5c929e0d-b3b5-409d-8cf6-38347357eb04@redhat.com>
Date: Fri, 1 Mar 2024 17:32:01 +0100
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
 <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.03.24 17:27, Ryan Roberts wrote:
> On 28/02/2024 15:12, David Hildenbrand wrote:
>> On 28.02.24 15:57, Ryan Roberts wrote:
>>> On 28/02/2024 12:12, David Hildenbrand wrote:
>>>>>> How relevant is it? Relevant enough that someone decided to put that
>>>>>> optimization in? I don't know :)
>>>>>
>>>>> I'll have one last go at convincing you: Huang Ying (original author) commented
>>>>> "I believe this should be OK.  Better to compare the performance too." at [1].
>>>>> That implies to me that perhaps the optimization wasn't in response to a
>>>>> specific problem after all. Do you have any thoughts, Huang?
>>>>
>>>> Might make sense to include that in the patch description!
>>>>
>>>>> OK so if we really do need to keep this optimization, here are some ideas:
>>>>>
>>>>> Fundamentally, we would like to be able to figure out the size of the swap slot
>>>>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>>>>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the
>>>>> cluster
>>>>> to mark it as PMD_SIZE.
>>>>>
>>>>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>>>>> cluster will contain only one size of THPs, but this is not the case when a THP
>>>>> in the swapcache gets split or when an order-0 slot gets stolen. We expect
>>>>> these
>>>>> cases to be rare.
>>>>>
>>>>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>>>>> time it will be the full size of the swap entry, but sometimes it will cover
>>>>> only a portion. In the latter case you may see a false negative for
>>>>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>>>>> There is one wrinkle: currently the HUGE flag is cleared in
>>>>> put_swap_folio(). We
>>>>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole
>>>>> cluster
>>>>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>>>>
>>>>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>>>>> precise information and is conceptually simpler to understand, but will cost
>>>>> more memory (half as much as the initial swap_map[] again).
>>>>>
>>>>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>>>>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>>>>> prototyping.
>>>>
>>>> Taking a step back: what about we simply batch unmapping of swap entries?
>>>>
>>>> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
>>>> lock) that reference consecutive swap offsets in the same swap file.
>>>
>>> Yes in principle, but there are 4 places where free_swap_and_cache() is called,
>>> and only 2 of those are really amenable to batching (zap_pte_range() and
>>> madvise_free_pte_range()). So the other two users will still take the "slow"
>>> path. Maybe those 2 callsites are the only ones that really matter? I can
>>> certainly have a stab at this approach.
>>
>> We can ignore the s390x one. That s390x code should only apply to KVM guest
>> memory where ordinary THP are not even supported. (and nobody uses mTHP there yet).
>>
>> Long story short: the VM can hint that some memory pages are now unused and the
>> hypervisor can reclaim them. That's what that callback does (zap guest-provided
>> guest memory). No need to worry about any batching for now.
>>
>> Then, there is the shmem one in shmem_free_swap(). I really don't know how shmem
>> handles THP+swapout.
>>
>> But looking at shmem_writepage(), we split any large folios before moving them
>> to the swapcache, so likely we don't care at all, because THP don't apply.
>>
>>>
>>>>
>>>> There, we can then first decrement all the swap counts, and then try minimizing
>>>> how often we actually have to try reclaiming swap space (lookup folio, see it's
>>>> a large folio that we cannot reclaim or could reclaim, ...).
>>>>
>>>> Might need some fine-tuning in swap code to "advance" to the next entry to try
>>>> freeing up, but we certainly can do better than what we would do right now.
>>>
>>> I'm not sure I've understood this. Isn't advancing just a matter of:
>>>
>>> entry = swp_entry(swp_type(entry), swp_offset(entry) + 1);
>>
>> I was talking about the advancing swapslot processing after decrementing the
>> swapcounts.
>>
>> Assume you decremented 512 swapcounts and some of them went to 0. AFAIU, you'd
>> have to start with the first swapslot that has now a swapcount=0 one and try to
>> reclaim swap.
>>
>> Assume you get a small folio, then you'll have to proceed with the next swap
>> slot and try to reclaim swap.
>>
>> Assume you get a large folio, then you can skip more swapslots (depending on
>> offset into the folio etc).
>>
>> If you get what I mean. :)
>>
> 
> I've implemented the batching as David suggested, and I'm pretty confident it's
> correct. The only problem is that during testing I can't provoke the code to
> take the path. I've been pouring through the code but struggling to figure out
> under what situation you would expect the swap entry passed to
> free_swap_and_cache() to still have a cached folio? Does anyone have any idea?
> 
> This is the original (unbatched) function, after my change, which caused David's
> concern that we would end up calling __try_to_reclaim_swap() far too much:
> 
> int free_swap_and_cache(swp_entry_t entry)
> {
> 	struct swap_info_struct *p;
> 	unsigned char count;
> 
> 	if (non_swap_entry(entry))
> 		return 1;
> 
> 	p = _swap_info_get(entry);
> 	if (p) {
> 		count = __swap_entry_free(p, entry);
> 		if (count == SWAP_HAS_CACHE)
> 			__try_to_reclaim_swap(p, swp_offset(entry),
> 					      TTRS_UNMAPPED | TTRS_FULL);
> 	}
> 	return p != NULL;
> }
> 
> The trouble is, whenever its called, count is always 0, so
> __try_to_reclaim_swap() never gets called.
> 
> My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT) over
> it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause this
> function to be called for every PTE, but count is always 0 after
> __swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
> order-0 as well as PTE- and PMD-mapped 2M THP.
> 
> I'm guessing the swapcache was already reclaimed as part of MADV_PAGEOUT? I'm
> using a block ram device as my backing store - I think this does synchronous IO
> so perhaps if I have a real block device with async IO I might have more luck?
> Just a guess...
> 
> Or perhaps this code path is a corner case? In which case, perhaps its not worth
> adding the batching optimization after all?

I had to disable zswap in the past and was able to trigger this reliably 
with an ordinary swap backend (e.g., proper disk).

Whenever you involve swap-to-ram, you might just get it reclaimed 
immediately.

-- 
Cheers,

David / dhildenb


