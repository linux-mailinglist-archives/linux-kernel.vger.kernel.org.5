Return-Path: <linux-kernel+bounces-70983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3921859F01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FE61F22F27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93D22063;
	Mon, 19 Feb 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcvPVqrT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69D21370
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333286; cv=none; b=Z5WU66Kyg2AOC34PDkF/IAUslydU9km3PWMfQ6mFJi9ljaYjdvwweFB10b1OP+aO++H7BTsLUZT05z8MaIUHOTUs2QC+hBgzJe/eRzBhpluADnUdaFjfXHFH128kZx1mVLiEHPa0pTCfNiEoNAxmeO0nkFJPyaOKK+7ZaK2iiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333286; c=relaxed/simple;
	bh=Qx/ly5SaDjGc9q6kHVgqelbArL59OTkoLPoeg8J5wi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otx69VG844S774PsnrE+Q7GEoLdwmFQfC8eMtRUB+5YqxOpSqFmRhv86vS7BteWNlo3BFyxUCl6FcaxQeEw/DE8f+3YYJ0SE0RqZpQJx2x5gGaGuLEI9Ic2JexYjmKc7a3R500H0YloRVPjVNY1oyJEcMl4ZUEOJMImOIU0xZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcvPVqrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708333283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jluwWOTlkHle+7tEQx830n7N9r9EKidLwTohIxeHs78=;
	b=gcvPVqrTRR1Z/AkLGPJRJeUW3fb9hpDxM6qAhcxVjMh6CYCO+6D2R/QIC29J6sbzk2akxF
	ZZr+d9j/Z9kNLGf3oxhW9HeUzyM1eHGAAK+zA1d49pggWF5Ex0hMoEVkyBlRWMNhOBk1fi
	7mHmVCVIirHfeZIoXTK0VGn2HFoXoKQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-rGHUWrUpPn689-jE-YgvHQ-1; Mon, 19 Feb 2024 04:01:21 -0500
X-MC-Unique: rGHUWrUpPn689-jE-YgvHQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51162d43c64so3725710e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333279; x=1708938079;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jluwWOTlkHle+7tEQx830n7N9r9EKidLwTohIxeHs78=;
        b=nDExwoPC3HB4nZLqUJIUAnovlYd6sUmtI5IKjgBRS5UJ8AgAKyi89hfqFX19lrK8GP
         Wei6cXSBx466lnyWSzCJuwxPgkiu8KyyHkPpz75Og27Sa5lOEhzqPBavL3nr6VpktaKN
         QvC3TejKMGYGcgqY731OHPjRcE4JNlAk+JBf+pCjqz41AGxtMX9cpT9nwp331hwZojnt
         SHAYq06e1LA/FXDOnnt4PPSWAoRzqadhPSGvQxNlBiPHoEj5ToXOp3BxlC+oiA+e6C19
         F1BD3VTVsazvlkY2nCOGRRYYMfnMhk0QqSRLR2Sn5CTv49XuiSWhyC5DnZDTkyDsIXa1
         kq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWXb1JKbBFkwOyLmhppn38g9pvjdH5mXQn1oHwdEB/P2VHXJ0FzPabSKZY39CAA0haY/kR4pFzkqcPq7n/5LIHUpas7JRQx6IxXg8of
X-Gm-Message-State: AOJu0Yz1M4uwa7EMImxLPQherRQO49exZ0seVsUxYD10lUH1z25SYRUT
	p01SfWW1s8X1v1IKH0Hjhmqsr/1N28dez0B+KT2gQ+O+1PMq3QYvu9QbWcjzxMu5eH3uUEjFcyN
	9hfnKC86GgYBk5PtXdbMomxyRqBrxV0LOGf4m21bR/z/mFLb5BVnm3bb/GX9/9w==
X-Received: by 2002:a05:6512:31d1:b0:512:8d6d:4804 with SMTP id j17-20020a05651231d100b005128d6d4804mr9848457lfe.15.1708333279700;
        Mon, 19 Feb 2024 01:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3ye5iBZ5wV4dHS7rteYk1dfb2UaMLYWRJwYCKSUCu4BByxAzn6tMYJnoKm8Evf4a0rfUlLQ==
X-Received: by 2002:a05:6512:31d1:b0:512:8d6d:4804 with SMTP id j17-20020a05651231d100b005128d6d4804mr9848419lfe.15.1708333279218;
        Mon, 19 Feb 2024 01:01:19 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm7505288wmq.10.2024.02.19.01.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:01:18 -0800 (PST)
Message-ID: <726f3658-a5d2-4c14-a584-312883846303@redhat.com>
Date: Mon, 19 Feb 2024 10:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216095105.14502-1-ryncsn@gmail.com>
 <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
 <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.24 08:59, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 16.02.24 10:51, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more
>>> threads
>>> swapin the same entry at the same time, they get different pages (A, B).
>>> Before one thread (T0) finishes the swapin and installs page (A)
>>> to the PTE, another thread (T1) could finish swapin of page (B),
>>> swap_free the entry, then swap out the possibly modified page
>>> reusing the same entry. It breaks the pte_same check in (T0) because
>>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>>> install a stalled page (A) into the PTE and cause data corruption.
>>> One possible callstack is like this:
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
>>> And besides, for ZRAM, swap_free() allows the swap device to discard
>>> the entry content, so even if page (B) is not modified, if
>>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>>> it may also cause data loss.
>>> To fix this, reuse swapcache_prepare which will pin the swap entry
>>> using
>>> the cache flag, and allow only one thread to pin it. Release the pin
>>> after PT unlocked. Racers will simply wait since it's a rare and very
>>> short event. A schedule() call is added to avoid wasting too much CPU
>>> or adding too much noise to perf statistics
>>> Other methods like increasing the swap count don't seem to be a good
>>> idea after some tests, that will cause racers to fall back to use the
>>> swap cache again. Parallel swapin using different methods leads to
>>> a much more complex scenario.
>>> Reproducer:
>>> This race issue can be triggered easily using a well constructed
>>> reproducer and patched brd (with a delay in read path) [1]:
>>> With latest 6.8 mainline, race caused data loss can be observed
>>> easily:
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
>>> This reproducer spawns multiple threads sharing the same memory
>>> region
>>> using a small swap device. Every two threads updates mapped pages one by
>>> one in opposite direction trying to create a race, with one dedicated
>>> thread keep swapping out the data out using madvise.
>>> The reproducer created a reproduce rate of about once every 5
>>> minutes,
>>> so the race should be totally possible in production.
>>> After this patch, I ran the reproducer for over a few hundred rounds
>>> and no data loss observed.
>>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>>> zram:
>>> Before:     10934698 us
>>> After:      11157121 us
>>> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
>>> synchronous device")
>>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> Update from V2:
>>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>>     and add noise to perf statistics.
>>> - Use a bool to state the special case instead of reusing existing
>>>     variables fixing error handling [Minchan Kim].
>>> V2:
>>> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>>> Update from V1:
>>> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
>>> - Update comments make it cleaner [Huang, Ying]
>>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
>>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
>>> - Update commit message.
>>> - Collect Review and Acks.
>>> V1:
>>> https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>>>    include/linux/swap.h |  5 +++++
>>>    mm/memory.c          | 20 ++++++++++++++++++++
>>>    mm/swap.h            |  5 +++++
>>>    mm/swapfile.c        | 13 +++++++++++++
>>>    4 files changed, 43 insertions(+)
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 4db00ddad261..8d28f6091a32 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>>    	return 0;
>>>    }
>>>    +static inline int swapcache_prepare(swp_entry_t swp)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>>    static inline void swap_free(swp_entry_t swp)
>>>    {
>>>    }
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 7e1f4849463a..7059230d0a54 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    	struct page *page;
>>>    	struct swap_info_struct *si = NULL;
>>>    	rmap_t rmap_flags = RMAP_NONE;
>>> +	bool need_clear_cache = false;
>>>    	bool exclusive = false;
>>>    	swp_entry_t entry;
>>>    	pte_t pte;
>>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    	if (!folio) {
>>>    		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>>    		    __swap_count(entry) == 1) {
>>> +			/*
>>> +			 * Prevent parallel swapin from proceeding with
>>> +			 * the cache flag. Otherwise, another thread may
>>> +			 * finish swapin first, free the entry, and swapout
>>> +			 * reusing the same entry. It's undetectable as
>>> +			 * pte_same() returns true due to entry reuse.
>>> +			 */
>>> +			if (swapcache_prepare(entry)) {
>>> +				/* Relax a bit to prevent rapid repeated page faults */
>>> +				schedule();
>>> +				goto out;
>>> +			}
>>> +			need_clear_cache = true;
>>> +
>>
>> I took a closer look at __read_swap_cache_async() and it essentially
>> does something similar.
>>
>> Instead of returning, it keeps retrying until it finds that
>> swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
>> freed concurrently) or it finds the entry in the swapcache.
>>
>> So if you would succeed here on a freed+reused swap entry,
>> __read_swap_cache_async() would simply retry.
>>
>> It spells that out:
>>
>> 		/*
>> 		 * We might race against __delete_from_swap_cache(), and
>> 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
>> 		 * has not yet been cleared.  Or race against another
>> 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
>> 		 * in swap_map, but not yet added its folio to swap cache.
>> 		 */
>>
>> Whereby we could not race against this code here as well where we
>> speculatively set SWAP_HAS_CACHE and might never add something to the swap
>> cache.
>>
>>
>> I'd probably avoid the wrong returns and do something even closer to
>> __read_swap_cache_async().
>>
>> while (true) {
>> 	/*
>> 	 * Fake that we are trying to insert a page into the swapcache, to
>> 	 * serialize against concurrent threads wanting to do the same.
>> 	 * [more from your description]
>> 	 */
>> 	ret = swapcache_prepare(entry);
>> 	if (likely(!ret)
>> 		/*
>> 		 * Move forward with swapin, we'll recheck if the PTE hasn't
>> 		 * changed later.
>> 		 */
>> 		break;
>> 	else if (ret != -EEXIST)
>> 		goto out;
> 
> The swap entry may be kept in swap cache for long time.  For example, it
> may be read into swap cache via MADV_WILLNEED.

Right, we'd have to check for the swapcache.

I briefly thought about just factoring out what we have in 
__read_swap_cache_async() and reusing here. Similar problem to solve, 
and quite a lot of duplicate code.

But not worth the churn in a simple fix. We could explore that option
as a cleanup on top.

-- 
Cheers,

David / dhildenb


