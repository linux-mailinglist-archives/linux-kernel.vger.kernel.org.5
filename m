Return-Path: <linux-kernel+bounces-83909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFA86A000
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C1A1F23B95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860B151C39;
	Tue, 27 Feb 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/xd9nGc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DF51009
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061447; cv=none; b=QMuWyoYa29yDQ2NBorBxMJTfpkPEi31lW6t8+Y/rlHGXbYmROvLOFdY0Xr6CPCdloIeb/v6Ymdg1b1/q9rM6GzFwbY32nX2bZgbQQmZ/Jku1XEoOLgzKmz64KAM3kngtL1KYDdnSqr1Wer6Cex9TRgZEFq0d7QYe3MzH7Qd/q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061447; c=relaxed/simple;
	bh=A8IBFS071dyM2Dg10M1E1ppdu0bD7izEMCkWACHOLws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh6a0BxNkk+I927GOACktId5nLZHS7sxNxXe+Yd6tJtlrL20c258Zrh83VUXejRE3GP9enrjnsNF7eRXjbhLkdAWogbhDzxthS7LEdqHDOriiau2Lnc9Khqf9l8dv3LoBO+WNKBsvtQjLVPOxJSkMO6hZThNKSZt5kfGqMNluVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/xd9nGc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709061443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L1oAdXBmrTeFXN78UXwakpvEMJ8qj+moPMjuB9Uk/A8=;
	b=e/xd9nGcoe0+zgUYAdBnagiGuFsvn5gmxaBm3Z5pLJMHQy54UeaPHr+cr93mp9yCu+S+u+
	dR9mK96EIhfVjajrwZyfAXkHCEFioApo9aLaOM4aNouZWLt0QnE32y6yM3yeBxOisqSPL0
	ac8YwQ4DpFlgXoVxhsHLSCbQWVbp9Kk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-wvFhG9__OoK-3qN5e9ZWLA-1; Tue, 27 Feb 2024 14:17:21 -0500
X-MC-Unique: wvFhG9__OoK-3qN5e9ZWLA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e40126031so25343085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061441; x=1709666241;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1oAdXBmrTeFXN78UXwakpvEMJ8qj+moPMjuB9Uk/A8=;
        b=YjFSAMXHKWp3zUJtKDszvLpPkIXB6wMKFnRfwQrHpk2R2eFBaG9dRC+048v9UAHtWc
         43ofIuZDoXNYKZHr5kIvzFKJMlvfc/3X95j8Lt+8ft4fV9ffwI40CMcdi+4J9tgpnfwd
         FERbEZ2Lb1BhUXo4csREqbj4LXeXz0Ba7nQn0jRlpGQ3xMPV9qvY+yfPCxSJVDSXZVux
         yybwj2w02zxAmxLGorn9RQamYsJMZKNKAadQrRZF3ReHJcQvVul0nyXi1Xp90dacfP/b
         EWsgDdnunmR+QMmWhAYGFtQrsOXwoPHAPistfIaWcDFAaBRWdsxFaOiVcdJczxinISJM
         hmhQ==
X-Gm-Message-State: AOJu0Yx5NKze3whRvAUNyT/gZU5Dj9aIxwXywQb478P2MTFMpB/OGVyg
	mlrEJ6TZDslVQm6gwqGatyOWg11pxwD5HD8UZ7+SswGNi3FjNZMMrfMhBweyWNzCtJL/oJrpWjy
	soiTEOZ69qavM+Sff9H/76oL+MVZeS8dixPfRrK4cLlYDXi2U9ydHACNUg+Qqhw==
X-Received: by 2002:adf:ec85:0:b0:33d:73de:cd95 with SMTP id z5-20020adfec85000000b0033d73decd95mr7340584wrn.17.1709061440767;
        Tue, 27 Feb 2024 11:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHERnsAmj/9ebdhmnUtbQNXpJRcmXR4EIzyIoN9LmUP6iwTahrw8t8i27XRG+QNTort9I48Ww==
X-Received: by 2002:adf:ec85:0:b0:33d:73de:cd95 with SMTP id z5-20020adfec85000000b0033d73decd95mr7340566wrn.17.1709061440282;
        Tue, 27 Feb 2024 11:17:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0033d56aa4f45sm11925656wri.112.2024.02.27.11.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:17:19 -0800 (PST)
Message-ID: <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
Date: Tue, 27 Feb 2024 20:17:18 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.02.24 18:10, Ryan Roberts wrote:
> Hi David,
> 
> On 26/02/2024 17:41, Ryan Roberts wrote:
>> On 22/02/2024 10:20, David Hildenbrand wrote:
>>> On 22.02.24 11:19, David Hildenbrand wrote:
>>>> On 25.10.23 16:45, Ryan Roberts wrote:
>>>>> As preparation for supporting small-sized THP in the swap-out path,
>>>>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>>>>> which, when present, always implies PMD-sized THP, which is the same as
>>>>> the cluster size.
>>>>>
>>>>> The only use of the flag was to determine whether a swap entry refers to
>>>>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>>>>> Instead of relying on the flag, we now pass in nr_pages, which
>>>>> originates from the folio's number of pages. This allows the logic to
>>>>> work for folios of any order.
>>>>>
>>>>> The one snag is that one of the swap_page_trans_huge_swapped() call
>>>>> sites does not have the folio. But it was only being called there to
>>>>> avoid bothering to call __try_to_reclaim_swap() in some cases.
>>>>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>>>>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>>>>> call site and believe the new logic should be equivalent.
>>>>
>>>> That is the  __try_to_reclaim_swap() -> folio_free_swap() ->
>>>> folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.
>>>>
>>>> The "difference" is that you will now (1) get another temporary
>>>> reference on the folio and (2) (try)lock the folio every time you
>>>> discard a single PTE of a (possibly) large THP.
>>>>
>>>
>>> Thinking about it, your change will not only affect THP, but any call to
>>> free_swap_and_cache().
>>>
>>> Likely that's not what we want. :/
>>>
>>
>> Is folio_trylock() really that expensive given the code path is already locking
>> multiple spinlocks, and I don't think we would expect the folio lock to be very
>> contended?
>>
>> I guess filemap_get_folio() could be a bit more expensive, but again, is this
>> really a deal-breaker?
>>
>>
>> I'm just trying to refamiliarize myself with this series, but I think I ended up
>> allocating a cluster per cpu per order. So one potential solution would be to
>> turn the flag into a size and store it in the cluster info. (In fact I think I
>> was doing that in an early version of this series - will have to look at why I
>> got rid of that). Then we could avoid needing to figure out nr_pages from the folio.
> 
> I ran some microbenchmarks to see if these extra operations cause a performance
> issue - it all looks OK to me.

Sorry, I'm drowning in reviews right now. I was hoping to get some of my own
stuff figured out today ... maybe tomorrow.

> 
> I modified your "pte-mapped-folio-benchmarks" to add a "munmap-swapped-forked"
> mode, which prepares the 1G memory mapping by first paging it out with
> MADV_PAGEOUT, then it forks a child (and keeps that child alive) so that the
> swap slots have 2 references, then it measures the duration of munmap() in the
> parent on the entire range. The idea is that free_swap_and_cache() is called for
> each PTE during munmap(). Prior to my change, swap_page_trans_huge_swapped()
> will return true, due to the child's references, and __try_to_reclaim_swap() is
> not called. After my change, we no longer have this short cut.
> 
> In both cases the results are within 1% (confirmed across multiple runs of 20
> seconds each):
> 
> mm-stable: Average: 0.004997
>   + change: Average: 0.005037
> 
> (these numbers are for Ampere Altra. I also tested on M2 VM - no regression
> their either).
> 
> Do you still have a concern about this change?

The main concern I had was not about overhead due to atomic operations in the
non-concurrent case that you are measuring.

We might now unnecessarily be incrementing the folio refcount and taking
the folio lock. That will affects large folios in the swapcache now IIUC.
Small folios should be unaffected.

The side effects of that can be:
* Code checking for additional folio reference could now detect some and
   back out. (the "mapcount + swapcache*folio_nr_pages != folio_refcount"
   stuff)
* Code that might really benefit from trylocking the folio might fail to
   do so.

For example, splitting a large folio might now fail more often simply
because some process zaps a swap entry and the additional reference+page
lock were optimized out previously.

How relevant is it? Relevant enough that someone decided to put that
optimization in? I don't know :)

Arguably, zapping a present PTE also leaves the refcount elevated for a while
until the mapcount was freed. But here, it could be avoided.

Digging a bit, it was introduced in:

commit e07098294adfd03d582af7626752255e3d170393
Author: Huang Ying <ying.huang@intel.com>
Date:   Wed Sep 6 16:22:16 2017 -0700

     mm, THP, swap: support to reclaim swap space for THP swapped out
     
     The normal swap slot reclaiming can be done when the swap count reaches
     SWAP_HAS_CACHE.  But for the swap slot which is backing a THP, all swap
     slots backing one THP must be reclaimed together, because the swap slot
     may be used again when the THP is swapped out again later.  So the swap
     slots backing one THP can be reclaimed together when the swap count for
     all swap slots for the THP reached SWAP_HAS_CACHE.  In the patch, the
     functions to check whether the swap count for all swap slots backing one
     THP reached SWAP_HAS_CACHE are implemented and used when checking
     whether a swap slot can be reclaimed.
     
     To make it easier to determine whether a swap slot is backing a THP, a
     new swap cluster flag named CLUSTER_FLAG_HUGE is added to mark a swap
     cluster which is backing a THP (Transparent Huge Page).  Because THP
     swap in as a whole isn't supported now.  After deleting the THP from the
     swap cache (for example, swapping out finished), the CLUSTER_FLAG_HUGE
     flag will be cleared.  So that, the normal pages inside THP can be
     swapped in individually.


With your change, if we have a swapped out THP with 512 entries and exit(), we
would now 512 times in a row grab a folio reference and trylock the folio. In the
past, we would have done that at most once.

That doesn't feel quite right TBH ... so I'm wondering if there are any low-hanging
fruits to avoid that.

-- 
Cheers,

David / dhildenb


