Return-Path: <linux-kernel+bounces-95202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38704874A96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A41283478
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E883CA0;
	Thu,  7 Mar 2024 09:19:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB113839F4;
	Thu,  7 Mar 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803167; cv=none; b=utqvuQPAH2eb+s/10JSDSjLY2MlNqCSNDQfhHGgGjz3cNwK9LMsSGcxLJxDOvbtxXDNcpHJbbE58p91gKI6Fr4z3AK8FqgxvW+wE1wiqb6hn+SO89itsf9GdY662v2yJvXLzAc2ONcheaxpe4N+SA7glkmcW4+St/a14t1g+m9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803167; c=relaxed/simple;
	bh=2Ovq5uBAOM0L7vDNedetadWSHR9W5vxYB419k+cm1kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2Z2gP2BDImGNtDflv7fZHJu+SMHZxr1TwM/y1nSOXDTtUyqzjuHsn3GrTI9Cm4ik1SWgbWttWBqPV4k/GDoenIuh87FggjATmPz+B14dfEAKC/eKuDCkNjbko4de6H5Cf3fFpvF6CUTO280gvYIbd84bGSbtNkI3/SjrHZXDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03D381FB;
	Thu,  7 Mar 2024 01:20:01 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6B63F762;
	Thu,  7 Mar 2024 01:19:22 -0800 (PST)
Message-ID: <29335a89-b14b-4ef3-abf8-0b41e6d0ec67@arm.com>
Date: Thu, 7 Mar 2024 09:19:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
 <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
 <ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com>
 <87bk7q7ffp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0925807f-d226-7f08-51d1-ab771b1a6c24@huawei.com>
 <8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <92672c62-47d8-44ff-bd05-951c813c95a5@arm.com>
 <87y1au5smu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87y1au5smu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 08:54, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 07/03/2024 07:34, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> On 2024/3/7 13:56, Huang, Ying wrote:
>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>
>>>>>> On 2024/3/6 17:31, Ryan Roberts wrote:
>>>>>>> On 06/03/2024 08:51, Miaohe Lin wrote:
>>>>>>>> On 2024/3/6 10:52, Huang, Ying wrote:
>>>>>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>>>>>
>>>>>>>>>> There was previously a theoretical window where swapoff() could run and
>>>>>>>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>>>>>>>> running in another thread. This could cause, amongst other bad
>>>>>>>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>>>>>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>>>>>>>
>>>>>>>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>>>>>>>> a test case. But there has been agreement based on code review that this
>>>>>>>>>> is possible (see link below).
>>>>>>>>>>
>>>>>>>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>>>>>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>>>>>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>>>>>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>>>>>>>> where this extra check would cause any false alarms.
>>>>>>>>>>
>>>>>>>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>>>>>>>> for deriving this):
>>>>>>>>>>
>>>>>>>>>> --8<-----
>>>>>>>>>>
>>>>>>>>>> __swap_entry_free() might be the last user and result in
>>>>>>>>>> "count == SWAP_HAS_CACHE".
>>>>>>>>>>
>>>>>>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>>>>>>
>>>>>>>>>> So the question is: could someone reclaim the folio and turn
>>>>>>>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>>>>>>>
>>>>>>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>>>>>>>> still references by swap entries.
>>>>>>>>>>
>>>>>>>>>> Process 1 still references subpage 0 via swap entry.
>>>>>>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>>>>>>
>>>>>>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>>>>> [then, preempted in the hypervisor etc.]
>>>>>>>>>>
>>>>>>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>>>>>
>>>>>>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>>>>>>> __try_to_reclaim_swap().
>>>>>>>>>>
>>>>>>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>>>>>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>>>>>>>> swap_entry_free()->swap_range_free()->
>>>>>>>>>> ...
>>>>>>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>>>>>>
>>>>>>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>>>>>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>>>>>>>
>>>>>>>>>> --8<-----
>>>>>>>>>
>>>>>>>>> I think that this can be simplified.  Even for a 4K folio, this could
>>>>>>>>> happen.
>>>>>>>>>
>>>>>>>>> CPU0                                     CPU1
>>>>>>>>> ----                                     ----
>>>>>>>>>
>>>>>>>>> zap_pte_range
>>>>>>>>>   free_swap_and_cache
>>>>>>>>>   __swap_entry_free
>>>>>>>>>   /* swap count become 0 */
>>>>>>>>>                                          swapoff
>>>>>>>>>                                            try_to_unuse
>>>>>>>>>                                              filemap_get_folio
>>>>>>>>>                                              folio_free_swap
>>>>>>>>>                                              /* remove swap cache */
>>>>>>>>>                                            /* free si->swap_map[] */
>>>>>>>>>
>>>>>>>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>>>>>>>
>>>>>>>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
>>>>>>>
>>>>>>> I don't beleive it has the PTL when called by shmem.
>>>>>>
>>>>>> In the case of shmem, folio_lock is used to guard against the race.
>>>>>
>>>>> I don't find folio is lock for shmem.  find_lock_entries() will only
>>>>> lock the folio if (!xa_is_value()), that is, not swap entry.  Can you
>>>>> point out where the folio is locked for shmem?
>>>>
>>>> You're right, folio is locked if not swap entry. That's my mistake. But it seems above race is still nonexistent.
>>>> shmem_unuse() will first be called to read all the shared memory data that resides in the swap device back into
>>>> memory when doing swapoff. In that case, all the swapped pages are moved to page cache thus there won't be any
>>>> xa_is_value(folio) cases when calling shmem_undo_range(). free_swap_and_cache() even won't be called from
>>>> shmem_undo_range() after shmem_unuse(). Or am I miss something?
>>>
>>> I think the following situation is possible.  Right?
>>>
>>> CPU0                               CPU1
>>> ----                               ----
>>> shmem_undo_range
>>>   shmem_free_swap
>>>     xa_cmpxchg_irq
>>>     free_swap_and_cache
>>>       __swap_entry_free
>>>       /* swap count become 0 */
>>>                                    swapoff
>>>                                      try_to_unuse
>>>                                        shmem_unuse /* cannot find swap entry */
>>>                                        find_next_to_unuse
>>>                                        filemap_get_folio
>>>                                        folio_free_swap
>>>                                        /* remove swap cache */
>>>                                        /* free si->swap_map[] */
>>>       swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>>
>>> shmem_undo_range can run earlier.
>>
>> Yes that's the shmem problem I've been trying to convey. Perhaps there are other
>> (extremely subtle) mechanisms that make this impossible, I don't know.
>>
>> Either way, given the length of this discussion, and the subtleties in the
>> syncrhonization mechanisms that have so far been identified, I think the safest
>> thing to do is just apply the patch. Then we have explicit syncrhonization that
>> we can trivially reason about.
> 
> Yes.  This is tricky and we can improve it.  So I suggest to,
> 
> - Revise the patch description to use shmem race as example except
>   someone found it's impossible.
> 
> - Revise the comments of get_swap_device() about RCU reader side lock
>   (including IRQ off, spinlock, etc.) can prevent swapoff via
>   synchronize_rcu() in swapoff().
> 
> - Revise the comments of synchronize_rcu() in swapoff(), which can
>   prevent swapoff in parallel with RCU reader side lock including swap
>   cache operations, etc.

The only problem with this is that Andrew has already put my v2 into mm-*stable* :-|

So (1) from that list isn't possible. I could do a patch for (2) and (3), but to
be honest, I think you would do a better job of writing it up than I would - any
chance you could post the patch?




> 
> --
> Best Regards,
> Huang, Ying


