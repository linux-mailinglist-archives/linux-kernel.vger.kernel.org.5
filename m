Return-Path: <linux-kernel+bounces-70273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D161C859576
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5951C21416
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79FF4F1;
	Sun, 18 Feb 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRvUw14P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F67EAF1;
	Sun, 18 Feb 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243321; cv=none; b=Wpx4aY7V6pS1Y9BJBsfUm1Z8t+64jS/X92h4/02z4OGRX1/Rflwiq14N2rp34Dkq6PEysZpUF6RmHeBYPuz7nVhcTbq+sx2cA8WD8mG02GdouXRMAmq0OVnFlWzY7wHX3abJaC7uByNcjrOIuzGflI7G16QsGeFk8+OjHUeBDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243321; c=relaxed/simple;
	bh=lqXIwndud1ddMp3xILkmsTnX7OTQWZCxIFPe2f0/ln0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ly0qV6BJMkL8rgnU+k4YGhB2dmyjXuyCTHSiCAkLsRA3VU9aGgE3n7vtU3UC1xwfyro9XYNHJzN28/bXS4fNIl2nZjpA1NwcCa+uQizXEnEopWKJKMyTmsZE3f6nEM1rHLbfbC3WgQlqYFPb0+ZzGut4Vy8pRLmfQ68yNe7XFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRvUw14P; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708243319; x=1739779319;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lqXIwndud1ddMp3xILkmsTnX7OTQWZCxIFPe2f0/ln0=;
  b=LRvUw14Ps10EP0UWzuq/TuVuZmUfsfNbbWXgwdvNWXN8UTZoKgocPGNL
   L0MqfK2D51aUzCYZ+8PN0FPSw4yJWnTZo2Vf1i1MZuogRTWnbmYDiKJVY
   zqNkPsNS8Jgzb5go8ogujSkIlbDrQ00ZbZJmSzghwYERcjA+BO9hojBBe
   1EMbZaGv1Xq7OjqRWkzP4vZnjpnxJCvpK8x1aet2IfPheQ4H8C9DbPk25
   aYDFsRwLrvh9YL9mMZKhly7/ASRQ9fPk6DQHqVJM11SSmu1LaVuyeThXn
   ljd0N/vr9f8s6T09N9sqTMUyGVxATnDdu2p655rT5D9dn9xEv9jbJtk+W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2445755"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2445755"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4364943"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:01:54 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>,  linux-mm@kvack.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Barry Song
 <v-songbaohua@oppo.com>,  SeongJae Park <sj@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  stable@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
In-Reply-To: <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com> (David
	Hildenbrand's message of "Fri, 16 Feb 2024 17:53:25 +0100")
References: <20240216095105.14502-1-ryncsn@gmail.com>
	<c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
Date: Sun, 18 Feb 2024 15:59:59 +0800
Message-ID: <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 16.02.24 10:51, Kairui Song wrote:
>> From: Kairui Song <kasong@tencent.com>
>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more
>> threads
>> swapin the same entry at the same time, they get different pages (A, B).
>> Before one thread (T0) finishes the swapin and installs page (A)
>> to the PTE, another thread (T1) could finish swapin of page (B),
>> swap_free the entry, then swap out the possibly modified page
>> reusing the same entry. It breaks the pte_same check in (T0) because
>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>> install a stalled page (A) into the PTE and cause data corruption.
>> One possible callstack is like this:
>> CPU0                                 CPU1
>> ----                                 ----
>> do_swap_page()                       do_swap_page() with same entry
>> <direct swapin path>                 <direct swapin path>
>> <alloc page A>                       <alloc page B>
>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
>> <slow on later locks or interrupt>   <finished swapin first>
>> ...                                  set_pte_at()
>>                                       swap_free() <- entry is free
>>                                       <write to page B, now page A stalled>
>>                                       <swap out page B to same swap entry>
>> pte_same() <- Check pass, PTE seems
>>                unchanged, but page A
>>                is stalled!
>> swap_free() <- page B content lost!
>> set_pte_at() <- staled page A installed!
>> And besides, for ZRAM, swap_free() allows the swap device to discard
>> the entry content, so even if page (B) is not modified, if
>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> it may also cause data loss.
>> To fix this, reuse swapcache_prepare which will pin the swap entry
>> using
>> the cache flag, and allow only one thread to pin it. Release the pin
>> after PT unlocked. Racers will simply wait since it's a rare and very
>> short event. A schedule() call is added to avoid wasting too much CPU
>> or adding too much noise to perf statistics
>> Other methods like increasing the swap count don't seem to be a good
>> idea after some tests, that will cause racers to fall back to use the
>> swap cache again. Parallel swapin using different methods leads to
>> a much more complex scenario.
>> Reproducer:
>> This race issue can be triggered easily using a well constructed
>> reproducer and patched brd (with a delay in read path) [1]:
>> With latest 6.8 mainline, race caused data loss can be observed
>> easily:
>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>    Polulating 32MB of memory region...
>>    Keep swapping out...
>>    Starting round 0...
>>    Spawning 65536 workers...
>>    32746 workers spawned, wait for done...
>>    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>    Round 0 Failed, 15 data loss!
>> This reproducer spawns multiple threads sharing the same memory
>> region
>> using a small swap device. Every two threads updates mapped pages one by
>> one in opposite direction trying to create a race, with one dedicated
>> thread keep swapping out the data out using madvise.
>> The reproducer created a reproduce rate of about once every 5
>> minutes,
>> so the race should be totally possible in production.
>> After this patch, I ran the reproducer for over a few hundred rounds
>> and no data loss observed.
>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>> zram:
>> Before:     10934698 us
>> After:      11157121 us
>> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
>> synchronous device")
>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>> Cc: stable@vger.kernel.org
>> ---
>> Update from V2:
>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>    and add noise to perf statistics.
>> - Use a bool to state the special case instead of reusing existing
>>    variables fixing error handling [Minchan Kim].
>> V2:
>> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>> Update from V1:
>> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
>> - Update comments make it cleaner [Huang, Ying]
>> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
>> - Update commit message.
>> - Collect Review and Acks.
>> V1:
>> https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>>   include/linux/swap.h |  5 +++++
>>   mm/memory.c          | 20 ++++++++++++++++++++
>>   mm/swap.h            |  5 +++++
>>   mm/swapfile.c        | 13 +++++++++++++
>>   4 files changed, 43 insertions(+)
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 4db00ddad261..8d28f6091a32 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>   	return 0;
>>   }
>>   +static inline int swapcache_prepare(swp_entry_t swp)
>> +{
>> +	return 0;
>> +}
>> +
>>   static inline void swap_free(swp_entry_t swp)
>>   {
>>   }
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7e1f4849463a..7059230d0a54 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   	struct page *page;
>>   	struct swap_info_struct *si = NULL;
>>   	rmap_t rmap_flags = RMAP_NONE;
>> +	bool need_clear_cache = false;
>>   	bool exclusive = false;
>>   	swp_entry_t entry;
>>   	pte_t pte;
>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   	if (!folio) {
>>   		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>   		    __swap_count(entry) == 1) {
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

The swap entry may be kept in swap cache for long time.  For example, it
may be read into swap cache via MADV_WILLNEED.

--
Best Regards,
Huang, Ying

> 	
> 	/*
>          * See __read_swap_cache_async(). We might either have raced against
>          * another thread, or the entry could have been freed and reused in the
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

