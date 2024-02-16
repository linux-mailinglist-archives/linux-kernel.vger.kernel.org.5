Return-Path: <linux-kernel+bounces-69111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879988584BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA4B284520
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53072133995;
	Fri, 16 Feb 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMfZRKr2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D9133439
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106498; cv=none; b=qe+gORCg2SkT8hbWY3hQLBFlNnYSz4XNOBpyqJ8evS6daoO4J2Dz8GxLRHeuDfAqkN3VcCZkToentEOQGxu2v08NPThjLQX3AOVOIhGMG9pgzsLqpjEo370XjQ9zCXaQHaBWIvj/XSoRMLzxbpHBoZ0TwhG6DJvomVN7AyB3KVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106498; c=relaxed/simple;
	bh=auU8x7KBIZ2o3totzpO/+qU4bnp5V6Itz3csC7kJmX8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kiRJAhMucne73D2ptR9HRKOEJqIeW4Hu7AqAuIa3aVluymfc9Zr8IdJ0BYzVz2QdO0cdEBHcvBrH/N787uP+tIpZWYztuRDRdPUS9hB2IacoskQCKakBJdtjIJfYY80Ewj8i54LLkSLkHBHzaTfCkt3wyUlDkmM5ing6IKggC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMfZRKr2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708106494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aPeQsXRRlSRnTkrY5ryff46Xk3MXoXe6wCZy2RF2ng8=;
	b=PMfZRKr2u+NzTTeb/1ew1/4r5XJuyR3ZTcDaP9/gSuiemsiC04qS9Bg2aMKMzefuEadIzQ
	LgNNywJPvhMZBSuaWLT4OUyDSGm89hKM3WujKJpjAJbiEGEfmPThxQxPnjut2Q1N0RIKRD
	lqQB1iaKA+S+JxJ3PoSnu7sR6hiLcUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-V7QPD15NMWCpFaxmt2fHmQ-1; Fri, 16 Feb 2024 13:01:32 -0500
X-MC-Unique: V7QPD15NMWCpFaxmt2fHmQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso12553665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106491; x=1708711291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPeQsXRRlSRnTkrY5ryff46Xk3MXoXe6wCZy2RF2ng8=;
        b=qhbq/rHhoVewuHICKxl+P+HuXJuUZkC0ZCwyiWoTjcXUmHMLAJrkCg/g+K55Gbhch3
         YLmdQpKQpTgJsHA8WLaO9MoZMYEq3sURtFPdqxujTM0H4c7hMyKyI+A3/2cjUYi0FA2W
         jSG/QbPJOLw0WiEdZeIg1vlb9nvrIcFxpHuIYzHofT5e8bBalWmncC01pYew6BpopxQH
         a0h02TbSvNn1F/2DVMjQWYF2WxyIkMdG1mm6mQQxpLyne+pjZNjvZRKDuD8QnpAHuhmw
         GZz5CawrcWkuj4Ts83ae8lIHLQ3ITuuvJQktcSY7Taxt4jvcEcKnIm1WLqQZ5u7EuX1M
         1sCw==
X-Forwarded-Encrypted: i=1; AJvYcCUUu4xPotESbnmVsheqZDvEWwCgGDUlaRcjq0TGsKxKgP8c1t6R+7df4SZgn7PANcxiUf3UH3P+HuGY7KzX1MP5v2poPOiwqL9ppQ5h
X-Gm-Message-State: AOJu0YyaP4GjLO/+xb8m2zUjJaJdZ+GmoT0lqAVEzf2OwCxwcw1xbce5
	WBDeLgRMXiWmyD36ymRIH8pN1efownuWgVVp0LcCfqXK4UZ/s+OjVt3xfcKhgflhTteNoWIo+ko
	Ys1HS9DXfEQviFE4DC1UmyiA6W9AhLWdH3kuQbQE2ldwB+V9nryxNjJVp3Q8ScA==
X-Received: by 2002:a5d:6f0d:0:b0:33d:1d6f:9a30 with SMTP id ay13-20020a5d6f0d000000b0033d1d6f9a30mr2434283wrb.27.1708106490776;
        Fri, 16 Feb 2024 10:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJWWRPc5Uvwi3BEUnSY+TUGlvsL2HHWr3ZR/5laB1qhSPOmap5CfcOtgdKaLtQFmjieV3ZTA==
X-Received: by 2002:a5d:6f0d:0:b0:33d:1d6f:9a30 with SMTP id ay13-20020a5d6f0d000000b0033d1d6f9a30mr2434245wrb.27.1708106490310;
        Fri, 16 Feb 2024 10:01:30 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id u5-20020a056000038500b0033b66ce7ae9sm2873580wrf.84.2024.02.16.10.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:01:29 -0800 (PST)
Message-ID: <fca46c3d-1a4f-411c-b60b-b6978b127bc5@redhat.com>
Date: Fri, 16 Feb 2024 19:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216095105.14502-1-ryncsn@gmail.com>
 <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.02.24 17:53, David Hildenbrand wrote:
> On 16.02.24 10:51, Kairui Song wrote:
>> From: Kairui Song <kasong@tencent.com>
>>
>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>> swapin the same entry at the same time, they get different pages (A, B).
>> Before one thread (T0) finishes the swapin and installs page (A)
>> to the PTE, another thread (T1) could finish swapin of page (B),
>> swap_free the entry, then swap out the possibly modified page
>> reusing the same entry. It breaks the pte_same check in (T0) because
>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>> install a stalled page (A) into the PTE and cause data corruption.
>>
>> One possible callstack is like this:
>>
>> CPU0                                 CPU1
>> ----                                 ----
>> do_swap_page()                       do_swap_page() with same entry
>> <direct swapin path>                 <direct swapin path>
>> <alloc page A>                       <alloc page B>
>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
>> <slow on later locks or interrupt>   <finished swapin first>
>> ...                                  set_pte_at()
>>                                        swap_free() <- entry is free
>>                                        <write to page B, now page A stalled>
>>                                        <swap out page B to same swap entry>
>> pte_same() <- Check pass, PTE seems
>>                 unchanged, but page A
>>                 is stalled!
>> swap_free() <- page B content lost!
>> set_pte_at() <- staled page A installed!
>>
>> And besides, for ZRAM, swap_free() allows the swap device to discard
>> the entry content, so even if page (B) is not modified, if
>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> it may also cause data loss.
>>
>> To fix this, reuse swapcache_prepare which will pin the swap entry using
>> the cache flag, and allow only one thread to pin it. Release the pin
>> after PT unlocked. Racers will simply wait since it's a rare and very
>> short event. A schedule() call is added to avoid wasting too much CPU
>> or adding too much noise to perf statistics
>>
>> Other methods like increasing the swap count don't seem to be a good
>> idea after some tests, that will cause racers to fall back to use the
>> swap cache again. Parallel swapin using different methods leads to
>> a much more complex scenario.
>>
>> Reproducer:
>>
>> This race issue can be triggered easily using a well constructed
>> reproducer and patched brd (with a delay in read path) [1]:
>>
>> With latest 6.8 mainline, race caused data loss can be observed easily:
>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>     Polulating 32MB of memory region...
>>     Keep swapping out...
>>     Starting round 0...
>>     Spawning 65536 workers...
>>     32746 workers spawned, wait for done...
>>     Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>     Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>     Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>     Round 0 Failed, 15 data loss!
>>
>> This reproducer spawns multiple threads sharing the same memory region
>> using a small swap device. Every two threads updates mapped pages one by
>> one in opposite direction trying to create a race, with one dedicated
>> thread keep swapping out the data out using madvise.
>>
>> The reproducer created a reproduce rate of about once every 5 minutes,
>> so the race should be totally possible in production.
>>
>> After this patch, I ran the reproducer for over a few hundred rounds
>> and no data loss observed.
>>
>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>> zram:
>>
>> Before:     10934698 us
>> After:      11157121 us
>> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>
>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>> Cc: stable@vger.kernel.org
>>
>> ---
>> Update from V2:
>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>     and add noise to perf statistics.
>> - Use a bool to state the special case instead of reusing existing
>>     variables fixing error handling [Minchan Kim].
>>
>> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>>
>> Update from V1:
>> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
>> - Update comments make it cleaner [Huang, Ying]
>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
>> - Update commit message.
>> - Collect Review and Acks.
>>
>> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>>
>>    include/linux/swap.h |  5 +++++
>>    mm/memory.c          | 20 ++++++++++++++++++++
>>    mm/swap.h            |  5 +++++
>>    mm/swapfile.c        | 13 +++++++++++++
>>    4 files changed, 43 insertions(+)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 4db00ddad261..8d28f6091a32 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>    	return 0;
>>    }
>>    
>> +static inline int swapcache_prepare(swp_entry_t swp)
>> +{
>> +	return 0;
>> +}
>> +
>>    static inline void swap_free(swp_entry_t swp)
>>    {
>>    }
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7e1f4849463a..7059230d0a54 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>    	struct page *page;
>>    	struct swap_info_struct *si = NULL;
>>    	rmap_t rmap_flags = RMAP_NONE;
>> +	bool need_clear_cache = false;
>>    	bool exclusive = false;
>>    	swp_entry_t entry;
>>    	pte_t pte;
>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>    	if (!folio) {
>>    		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>    		    __swap_count(entry) == 1) {
>> +			/*
>> +			 * Prevent parallel swapin from proceeding with
>> +			 * the cache flag. Otherwise, another thread may
>> +			 * finish swapin first, free the entry, and swapout
>> +			 * reusing the same entry. It's undetectable as
>> +			 * pte_same() returns true due to entry reuse.
>> +			 */
>> +			if (swapcache_prepare(entry)) {
>> +				/* Relax a bit to prevent rapid repeated page faults */
>> +				schedule();
>> +				goto out;
>> +			}
>> +			need_clear_cache = true;
>> +
> 
> I took a closer look at __read_swap_cache_async() and it essentially
> does something similar.
> 
> Instead of returning, it keeps retrying until it finds that
> swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
> freed concurrently) or it finds the entry in the swapcache.
> 
> So if you would succeed here on a freed+reused swap entry,
> __read_swap_cache_async() would simply retry.
> 
> It spells that out:
> 
> 		/*
> 		 * We might race against __delete_from_swap_cache(), and
> 		 * stumble across a swap_map entry whose SWAP_HAS_CACHE
> 		 * has not yet been cleared.  Or race against another
> 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
> 		 * in swap_map, but not yet added its folio to swap cache.
> 		 */
> 
> Whereby we could not race against this code here as well where we
> speculatively set SWAP_HAS_CACHE and might never add something to the swap
> cache.
> 
> 
> I'd probably avoid the wrong returns and do something even closer to
> __read_swap_cache_async().
> 
> while (true) {
> 	/*
> 	 * Fake that we are trying to insert a page into the swapcache, to
> 	 * serialize against concurrent threads wanting to do the same.
> 	 * [more from your description]
> 	 */
> 	ret = swapcache_prepare(entry);
> 	if (likely(!ret)
> 		/*
> 		 * Move forward with swapin, we'll recheck if the PTE hasn't
> 		 * changed later.
> 		 */
> 		break;
> 	else if (ret != -EEXIST)
> 		goto out;
> 	
> 	/*
>            * See __read_swap_cache_async(). We might either have raced against
>            * another thread, or the entry could have been freed and reused in the
> 	 * meantime. Make sure that the PTE did not change, to detect freeing.
> 	 */
> 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> 				       vmf->address, &vmf->ptl);
> 	if (!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))
> 		goto unlock;
> 
> 
> 	schedule();
> }
> 
> 
> 
> I was skeptical about the schedule(), but __read_swap_cache_async() does it
> already because there is no better way to wait for the event to happen.
> 
> With something like above you would no longer depend on the speed of schedule() to
> determine how often you would retry the fault, which would likely make sense.
> 
> I do wonder about the schedule() vs. schedule_timeout_uninterruptible(), though.
> No expert on that area, do you have any idea?
> 


Forgot to add

Acked-by: David Hildenbrand <david@redhat.com>

But I suspect we do not want to not rely on schedule() to actually 
sleep, and instead keep retrying until the other thread finished, 
similar to above.

-- 
Cheers,

David / dhildenb


