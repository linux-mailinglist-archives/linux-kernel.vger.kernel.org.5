Return-Path: <linux-kernel+bounces-67634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32309856E40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468A0B274C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3713A896;
	Thu, 15 Feb 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAI/fZPZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911D41A81
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027417; cv=none; b=YszQgwJVvGpQMML7MTPa76WdHWxArVBb6T5xQL3HaJydMuq1b2xcOizokQwpwxltPolSiz37kakuGWIjqww/jpy/UQHAtGvLeMSMVdDPulcI5lTK2IKI/IBsn1gG8aW6xFG8YprFxUM8bspSag1HmN2ZNUW5BY4zwhUjF+5QfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027417; c=relaxed/simple;
	bh=joc7jUecmfv4ZmQunJ66BryDpizyrFgZuVEk8Q0QGFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw0FhjplL+kZBL/L3zd2K/ZtUqVw0bUTy6YU2FB5b6hwcavfRlG8gd6fPkggAlYH3OPx/WgtveKNz9GktvWLclr2WWY0Y+cunpu7jFC9qbYqQrQQrcNGYl4ICLgcS3hhlVi/gij/NHcwOtTSwb7apNqEJkjeYfK0nAn+iumcg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAI/fZPZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708027414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ggD1WiwxHAzyRBwakIHl6Y+n5WWW4+lGEIBuFOWxCsk=;
	b=OAI/fZPZUuwNIGC0BIPrxznoHH+7klkcPXkXf8Xg9f2Lkh1KXeQvLFILI3ROD4x6cFkoH0
	eDZ1lOkjjPu5cYefPrYMv4juUijRyx4fHwd1lVBiNBhEWhYTgc1KmIBOgWepm9++RzCUk5
	Zmm7a6xsT4i4ph/kLctl+o9GocybM94=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-XT9vCNUZN2ueoHsRSSRLcg-1; Thu, 15 Feb 2024 15:03:32 -0500
X-MC-Unique: XT9vCNUZN2ueoHsRSSRLcg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d10d7dd7ddso12202881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027410; x=1708632210;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggD1WiwxHAzyRBwakIHl6Y+n5WWW4+lGEIBuFOWxCsk=;
        b=YVb8AJZ8I4SWl0VX+eI2DsTYrCUfcBa9FlNBZpPEzHQUIbffbFhzuN481Z0Oa9O8LB
         9ShrDBNUNeUhP9miY2T70mhzgUavcvVs2wAMO9TmLDNLyESU5ny8MjOn/jc8lm5NTfrt
         TjoFHdXmu1AA9UpBhJZnb8muxGZkTLUcaT3W5hqo+XgBigyifj7T4LtCjexcCKasApYO
         JED97nQWdmkuHdjEDfqFo7dp6g/pYtDFK4gQt7ec3g2apqaEsWftasoGugckfz2YfZCU
         Hs5Sb8Gb9PgpX4kK4jlg6JmS2IyGWxiN5A8vTuEHCrRLgCWLWZ7EHTlCIN2M4y2AQtke
         QDOg==
X-Forwarded-Encrypted: i=1; AJvYcCV7wt+lONGahad1JEkXiV0ffwSZvOGyJlvIVnE2F7okru6pi+ITYR6Hw66pf/D3cFLEjc9gVNCNrzvZBHvpYWZyuyuT7+SMg5dnwbOZ
X-Gm-Message-State: AOJu0YwY8397w+jhPXqB3d5LUKSIa7g0IgZV40fXhUQo1kJ2iUH+cUD5
	CBfxirmPbEqzwKWxC/PGN5GD0fk6tkja6Q4G9d70Kz8d/wQEcNe11yU63hebeLY++6wiW2TdgtN
	AAX/tC3T5fDS3ZsX6aNMblRaBigFDbgXps+LOyQFa1+HB+lgRI9LCVVHLYlSLKw==
X-Received: by 2002:a2e:9989:0:b0:2d2:1244:acbc with SMTP id w9-20020a2e9989000000b002d21244acbcmr758574lji.53.1708027410557;
        Thu, 15 Feb 2024 12:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2pm4DxiCxeC3INj+WyWX6Yc016A9DIBWwdvJxpaX5R8D1q1538WpRo0Y/03xMxRju/fd7YQ==
X-Received: by 2002:a2e:9989:0:b0:2d2:1244:acbc with SMTP id w9-20020a2e9989000000b002d21244acbcmr758550lji.53.1708027409995;
        Thu, 15 Feb 2024 12:03:29 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id bn30-20020a056000061e00b0033cfd32d3afsm122827wrb.1.2024.02.15.12.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 12:03:29 -0800 (PST)
Message-ID: <4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
Date: Thu, 15 Feb 2024 21:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206182559.32264-1-ryncsn@gmail.com>
 <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
 <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.02.24 19:49, Kairui Song wrote:
> On Thu, Feb 15, 2024 at 11:36 PM David Hildenbrand <david@redhat.com> wrote:
>> On 06.02.24 19:25, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>>> swapin the same entry at the same time, they get different pages (A, B).
>>> Before one thread (T0) finishes the swapin and installs page (A)
>>> to the PTE, another thread (T1) could finish swapin of page (B),
>>> swap_free the entry, then swap out the possibly modified page
>>> reusing the same entry. It breaks the pte_same check in (T0) because
>>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>>> install a stalled page (A) into the PTE and cause data corruption.
>>>
>>> One possible callstack is like this:
>>>
>>> CPU0                                 CPU1
>>> ----                                 ----
>>> do_swap_page()                       do_swap_page() with same entry
>>> <direct swapin path>                 <direct swapin path>
>>> <alloc page A>                       <alloc page B>
>>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
>>> <slow on later locks or interrupt>   <finished swapin first>
>>> ...                                  set_pte_at()
>>>                                        swap_free() <- entry is free
>>>                                        <write to page B, now page A stalled>
>>>                                        <swap out page B to same swap entry>
>>> pte_same() <- Check pass, PTE seems
>>>                 unchanged, but page A
>>>                 is stalled!
>>> swap_free() <- page B content lost!
>>> set_pte_at() <- staled page A installed!
>>>
>>> And besides, for ZRAM, swap_free() allows the swap device to discard
>>> the entry content, so even if page (B) is not modified, if
>>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>>> it may also cause data loss.
>>>
>>> To fix this, reuse swapcache_prepare which will pin the swap entry using
>>> the cache flag, and allow only one thread to pin it. Release the pin
>>> after PT unlocked. Racers will simply busy wait since it's a rare
>>> and very short event.
>>>
>>> Other methods like increasing the swap count don't seem to be a good
>>> idea after some tests, that will cause racers to fall back to use the
>>> swap cache again. Parallel swapin using different methods leads to
>>> a much more complex scenario.
>>>
>>> Reproducer:
>>>
>>> This race issue can be triggered easily using a well constructed
>>> reproducer and patched brd (with a delay in read path) [1]:
>>>
>>> With latest 6.8 mainline, race caused data loss can be observed easily:
>>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>>     Polulating 32MB of memory region...
>>>     Keep swapping out...
>>>     Starting round 0...
>>>     Spawning 65536 workers...
>>>     32746 workers spawned, wait for done...
>>>     Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>>     Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>>     Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>>     Round 0 Failed, 15 data loss!
>>>
>>> This reproducer spawns multiple threads sharing the same memory region
>>> using a small swap device. Every two threads updates mapped pages one by
>>> one in opposite direction trying to create a race, with one dedicated
>>> thread keep swapping out the data out using madvise.
>>>
>>> The reproducer created a reproduce rate of about once every 5 minutes,
>>> so the race should be totally possible in production.
>>>
>>> After this patch, I ran the reproducer for over a few hundred rounds
>>> and no data loss observed.
>>>
>>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>>> zram:
>>>
>>> Before:     10934698 us
>>> After:      11157121 us
>>> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>>
>>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>> Acked-by: Yu Zhao <yuzhao@google.com>
>>>
>>> ---
>>> Update from V1:
>>> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
>>> - Update comments make it cleaner [Huang, Ying]
>>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
>>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
>>> - Update commit message.
>>> - Collect Review and Acks.
>>>
>>>    include/linux/swap.h |  5 +++++
>>>    mm/memory.c          | 15 +++++++++++++++
>>>    mm/swap.h            |  5 +++++
>>>    mm/swapfile.c        | 13 +++++++++++++
>>>    4 files changed, 38 insertions(+)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 4db00ddad261..8d28f6091a32 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>>        return 0;
>>>    }
>>>
>>> +static inline int swapcache_prepare(swp_entry_t swp)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>>    static inline void swap_free(swp_entry_t swp)
>>>    {
>>>    }
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 7e1f4849463a..1749c700823d 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>        if (!folio) {
>>>                if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>>                    __swap_count(entry) == 1) {
>>> +                     /*
>>> +                      * Prevent parallel swapin from proceeding with
>>> +                      * the cache flag. Otherwise, another thread may
>>> +                      * finish swapin first, free the entry, and swapout
>>> +                      * reusing the same entry. It's undetectable as
>>> +                      * pte_same() returns true due to entry reuse.
>>> +                      */
>>> +                     if (swapcache_prepare(entry))
>>> +                             goto out;
>>> +
>>
>> Is there anything that guarantees that the following won't
>> happen concurrently, and if it would happen, could it be a problem?
>>
>> Other thread MADV_DONTNEED's the swap entry, swap slot is freed.
>> Some other page gets swapped out, reuses that swap slot.
> 
> Hi David,
> 
> Thanks for adding more comments and sharing your thoughts!
> 
> I'm not sure what you mean by "reuses that swap slot" here, I think
> you just mean reuse that swap entry (and the actual content on swap
> device)?

I tried to be precise but I think that caused more confusion :)

entry = device + offset into swap_map

I called a "swap slot" the metadata that is identified by device + 
offset (swap_map).

I recall that's what we used to call these things [1], e.g., "Allocating 
swap slots ... All page sized slots are tracked by the array 
swap_info_struct→swap_map."

[1] https://www.kernel.org/doc/gorman/html/understand/understand014.html

Anyhow, you got what I mean :)

> 
>> We call swapcache_prepare() on that slot that is being reused
>> elsewhere. (possibly some other thread in the context of the reuses
>> swap slot might do the same!)
> 
> I think this kind of swapcache_prepare() or false swapin read is
> already happening quite frequently by swap readaheads. I've seen swap
> cluster readahead mess up working set activation and memory policy
> already. Swap cluster readahead simply read in nearby entries of
> target entry, regardless of whether they are owned by the reader or
> not.

Okay, thanks for the confirmation!
> 
> For this patch, similar issues also exist, I think it only hurts the
> performance, but that's a really rare thing to happen, so should not
> be a problem.

Okay, good.

> 
>>
>> We would detect later, that the PTE changed, but we would temporarily
>> mess with that swap slot that we might no longer "own".
>>
>> I was thinking about alternatives, it's tricky because of the concurrent
>> MADV_DONTNEED possibility. Something with another fake-swap entry type
>> (similar to migration entries) might work, but would require more changes.
> 
> Yeah, in the long term I also think more work is needed for the swap subsystem.
> 
> In my opinion, for this particular issue, or, for cache bypassed
> swapin, a new swap map value similar to SWAP_MAP_BAD/SWAP_MAP_SHMEM
> might be needed, that may even help to simplify the swap count release
> routine for cache bypassed swapin, and improve the performance.

The question is if we really want to track that in the swapcache and not 
rather in the page table.

Imagine the following:

(1) allocate the folio and lock it (we do that already)

(2) take the page table lock. If the PTE is still the same, insert a new 
"swapin_in_process" fake swp entry that references the locked folio.

(3) read the folio from swap. This will unlock the folio IIUC. (we do 
that already)

(4) relock the folio. (we do that already, might not want to fail)

(4) take the PTE lock. If the PTE did not change, turn it into a present 
PTE entry. Otherwise, cleanup.


Any concurrent swap-in users would spot the new "swapin_in_process" fake 
swp entry and wait for the page lock (just like we do with migration 
entries).

Zap code would mostly only clear the "swapin_in_process" fake swp entry 
and leave the cleanup to (4) above. Fortunately, concurrent fork() is 
impossible as that cannot race with page faults.

There might be one minor thing to optimize with the folio lock above. 
But in essence, it would work just like migration entries, just that 
they are installed only while we actually do read the content from disk etc.

-- 
Cheers,

David / dhildenb


