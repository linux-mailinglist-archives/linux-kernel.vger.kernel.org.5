Return-Path: <linux-kernel+bounces-94990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF08747C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0441F24305
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1F1BF27;
	Thu,  7 Mar 2024 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kca758KC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3182256A;
	Thu,  7 Mar 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791122; cv=none; b=XRU4qt6HRRbEbxLB3OhTzUPYnQL6lBeUaWuTpu3KejjJqSSoTbl3h086ihGmdoXsP7N6o9T50EyV2s2B15uwNo9qhE+cCWC0SuOTfuqxP19a5ys94QhVodIbKmIldqQoUFKZ61R4Az4PiHVrd5uWf7HNueRKL/RnAoc6ppdWa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791122; c=relaxed/simple;
	bh=stv0+KAZu3cCYaQgubC9ML8AoaLnW60gSHtE0MTOPJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oHWTFZlsqP2RS3lDYHhe5X2WI4Il/DrsW5KbuEQACDstqSDOsPvNLwx5iL67ewUhAa7zvuD260qeGnBNFbBJvr1Isy02u3cWiK2AI6NR2Ae7pkZZmwvyUMn9eo0I4B2aPTKWdLHGimp14IX/OStvWndkf3np2oxpsqra48ZtiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kca758KC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709791120; x=1741327120;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=stv0+KAZu3cCYaQgubC9ML8AoaLnW60gSHtE0MTOPJE=;
  b=kca758KCTz4J2UHbzqeX1jC5IRfPej6Ly88NtrsP3WO2NVWhsqBQptmF
   1sB9lS3uzwKM/s9GRO2S7Im3eH/2ZDAy+1vqpiT7wz23/LFszdcca8uv/
   SxC41z9gft6TI41m38QBXRPchg0HoIPiKdbgqz5BGEEct9bMCX2Dc48k4
   vV9O2+Vw2mdxXXvf55G5VdcDYob4s0jo2kTG4EoF5eJ0PyHlZHcQH11Ib
   M6W1bxkkBqf0nGlj6EcsYFk68U206C8V6YCZCqjL/mgI8LYW8oM9KKPGZ
   RHvox1tXG0MIX7a1OjCY/hzLvGvSWdjnA9+FxVpZuCaL7JeEkfSHssCsC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15017971"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="15017971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="9895348"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:58:36 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com> (Miaohe Lin's
	message of "Thu, 7 Mar 2024 10:38:47 +0800")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
	<af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
	<ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com>
Date: Thu, 07 Mar 2024 13:56:42 +0800
Message-ID: <87bk7q7ffp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2024/3/6 17:31, Ryan Roberts wrote:
>> On 06/03/2024 08:51, Miaohe Lin wrote:
>>> On 2024/3/6 10:52, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> There was previously a theoretical window where swapoff() could run and
>>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>>> running in another thread. This could cause, amongst other bad
>>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>>
>>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>>> a test case. But there has been agreement based on code review that this
>>>>> is possible (see link below).
>>>>>
>>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>>> where this extra check would cause any false alarms.
>>>>>
>>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>>> for deriving this):
>>>>>
>>>>> --8<-----
>>>>>
>>>>> __swap_entry_free() might be the last user and result in
>>>>> "count == SWAP_HAS_CACHE".
>>>>>
>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>
>>>>> So the question is: could someone reclaim the folio and turn
>>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>>
>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>>> still references by swap entries.
>>>>>
>>>>> Process 1 still references subpage 0 via swap entry.
>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>
>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>> -> count == SWAP_HAS_CACHE
>>>>> [then, preempted in the hypervisor etc.]
>>>>>
>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>> -> count == SWAP_HAS_CACHE
>>>>>
>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>> __try_to_reclaim_swap().
>>>>>
>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>>> swap_entry_free()->swap_range_free()->
>>>>> ...
>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>
>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>>
>>>>> --8<-----
>>>>
>>>> I think that this can be simplified.  Even for a 4K folio, this could
>>>> happen.
>>>>
>>>> CPU0                                     CPU1
>>>> ----                                     ----
>>>>
>>>> zap_pte_range
>>>>   free_swap_and_cache
>>>>   __swap_entry_free
>>>>   /* swap count become 0 */
>>>>                                          swapoff
>>>>                                            try_to_unuse
>>>>                                              filemap_get_folio
>>>>                                              folio_free_swap
>>>>                                              /* remove swap cache */
>>>>                                            /* free si->swap_map[] */
>>>>
>>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>>
>>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
>> 
>> I don't beleive it has the PTL when called by shmem.
>
> In the case of shmem, folio_lock is used to guard against the race.

I don't find folio is lock for shmem.  find_lock_entries() will only
lock the folio if (!xa_is_value()), that is, not swap entry.  Can you
point out where the folio is locked for shmem?

--
Best Regards,
Huang, Ying

>> 
>>> So synchronize_rcu (called by swapoff) will wait zap_pte_range to release the pte lock. So this
>>> theoretical problem can't happen. Or am I miss something?
>> 
>> For Huang Ying's example, I agree this can't happen because try_to_unuse() will
>> be waiting for the PTL (see the reply I just sent).
>
> Do you mean the below message?
> "
> I don't think si->inuse_pages is decremented until __try_to_reclaim_swap() is
> called (per David, above), which is called after swap_page_trans_huge_swapped()
> has executed. So in CPU1, try_to_unuse() wouldn't see si->inuse_pages being zero
> until after CPU0 has completed accessing si->swap_map, so if swapoff starts
> where you have put it, it would get stalled waiting for the PTL which CPU0 has.
> "
>
> I agree try_to_unuse() will wait for si->inuse_pages being zero. But why will it waits
> for the PTL? It seems PTL is not used to protect si->inuse_pages. Or am I miss something?
>
>> 
>>>
>>> CPU0                                     CPU1
>>> ----                                     ----
>>>
>>> zap_pte_range
>>>   pte_offset_map_lock -- spin_lock is held.
>>>   free_swap_and_cache
>>>    __swap_entry_free
>>>    /* swap count become 0 */
>>>                                          swapoff
>>>                                            try_to_unuse
>>>                                              filemap_get_folio
>>>                                              folio_free_swap
>>>                                              /* remove swap cache */
>>> 					    percpu_ref_kill(&p->users);
>>>    swap_page_trans_huge_swapped
>>>   pte_unmap_unlock -- spin_lock is released.
>>> 					    synchronize_rcu();  --> Will wait pte_unmap_unlock to be called?
>> 
>> Perhaps you can educate me here; I thought that synchronize_rcu() will only wait
>> for RCU critical sections to complete. The PTL is a spin lock, so why would
>> synchronize_rcu() wait for the PTL to become unlocked?
>
> I assume PTL will always disable preemption which disables a grace period until PTL is released.
> But this might be fragile and I'm not really sure. I might be wrong.
>
> Thanks.
>> 
>> 
>>>                                            /* free si->swap_map[] */
>>>
>>> Thanks.
>>>
>>>
>> 
>> .
>> 

