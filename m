Return-Path: <linux-kernel+bounces-94868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25118874626
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA00BB20A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD960611E;
	Thu,  7 Mar 2024 02:38:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909B634;
	Thu,  7 Mar 2024 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779135; cv=none; b=PgNmsOt9gfo3t0H8pSlYeuaXbEarlADfS0zJJe4C1bpfahm1JirTJ23c/1sNpVJjxNybCbMTCR9jgSZFjldXC11h5ckNI14zF3yG/jfDBQ+CKfn5XF2n1LhnB+dxgKNA4+LoPXSChZxiGX9EDZ9nVTpXP5nmqwNgrCKfM7sVmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779135; c=relaxed/simple;
	bh=I1Wv8eWLueECEbm/aljAThrcOJwuRiULiF4kYPDDxhc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oDYzZlrxmOJPZfmzrLaqrQNXgO1Y93QvcyKJESZjMejvQF7bVxgBndkhXKfiz1xF94b4bs2/ajsoNEg3XC7pnmYRrKnIuxDg6g+GJtfMRB8zvgfIQ7/b4vEZsaJnEdQTSwKBBsZigbK7KSzb/uZnxpHld9fypc2acJntSd2bh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tqtj71HnVz1h1WY;
	Thu,  7 Mar 2024 10:36:27 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id AF7DB180060;
	Thu,  7 Mar 2024 10:38:48 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 10:38:48 +0800
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
To: Ryan Roberts <ryan.roberts@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
 <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com>
Date: Thu, 7 Mar 2024 10:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/3/6 17:31, Ryan Roberts wrote:
> On 06/03/2024 08:51, Miaohe Lin wrote:
>> On 2024/3/6 10:52, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> There was previously a theoretical window where swapoff() could run and
>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>> running in another thread. This could cause, amongst other bad
>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>
>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>> a test case. But there has been agreement based on code review that this
>>>> is possible (see link below).
>>>>
>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>> where this extra check would cause any false alarms.
>>>>
>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>> for deriving this):
>>>>
>>>> --8<-----
>>>>
>>>> __swap_entry_free() might be the last user and result in
>>>> "count == SWAP_HAS_CACHE".
>>>>
>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>
>>>> So the question is: could someone reclaim the folio and turn
>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>
>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>> still references by swap entries.
>>>>
>>>> Process 1 still references subpage 0 via swap entry.
>>>> Process 2 still references subpage 1 via swap entry.
>>>>
>>>> Process 1 quits. Calls free_swap_and_cache().
>>>> -> count == SWAP_HAS_CACHE
>>>> [then, preempted in the hypervisor etc.]
>>>>
>>>> Process 2 quits. Calls free_swap_and_cache().
>>>> -> count == SWAP_HAS_CACHE
>>>>
>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>> __try_to_reclaim_swap().
>>>>
>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>> swap_entry_free()->swap_range_free()->
>>>> ...
>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>
>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>
>>>> --8<-----
>>>
>>> I think that this can be simplified.  Even for a 4K folio, this could
>>> happen.
>>>
>>> CPU0                                     CPU1
>>> ----                                     ----
>>>
>>> zap_pte_range
>>>   free_swap_and_cache
>>>   __swap_entry_free
>>>   /* swap count become 0 */
>>>                                          swapoff
>>>                                            try_to_unuse
>>>                                              filemap_get_folio
>>>                                              folio_free_swap
>>>                                              /* remove swap cache */
>>>                                            /* free si->swap_map[] */
>>>
>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>
>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
> 
> I don't beleive it has the PTL when called by shmem.

In the case of shmem, folio_lock is used to guard against the race.

> 
>> So synchronize_rcu (called by swapoff) will wait zap_pte_range to release the pte lock. So this
>> theoretical problem can't happen. Or am I miss something?
> 
> For Huang Ying's example, I agree this can't happen because try_to_unuse() will
> be waiting for the PTL (see the reply I just sent).

Do you mean the below message?
"
I don't think si->inuse_pages is decremented until __try_to_reclaim_swap() is
called (per David, above), which is called after swap_page_trans_huge_swapped()
has executed. So in CPU1, try_to_unuse() wouldn't see si->inuse_pages being zero
until after CPU0 has completed accessing si->swap_map, so if swapoff starts
where you have put it, it would get stalled waiting for the PTL which CPU0 has.
"

I agree try_to_unuse() will wait for si->inuse_pages being zero. But why will it waits
for the PTL? It seems PTL is not used to protect si->inuse_pages. Or am I miss something?

> 
>>
>> CPU0                                     CPU1
>> ----                                     ----
>>
>> zap_pte_range
>>   pte_offset_map_lock -- spin_lock is held.
>>   free_swap_and_cache
>>    __swap_entry_free
>>    /* swap count become 0 */
>>                                          swapoff
>>                                            try_to_unuse
>>                                              filemap_get_folio
>>                                              folio_free_swap
>>                                              /* remove swap cache */
>> 					    percpu_ref_kill(&p->users);
>>    swap_page_trans_huge_swapped
>>   pte_unmap_unlock -- spin_lock is released.
>> 					    synchronize_rcu();  --> Will wait pte_unmap_unlock to be called?
> 
> Perhaps you can educate me here; I thought that synchronize_rcu() will only wait
> for RCU critical sections to complete. The PTL is a spin lock, so why would
> synchronize_rcu() wait for the PTL to become unlocked?

I assume PTL will always disable preemption which disables a grace period until PTL is released.
But this might be fragile and I'm not really sure. I might be wrong.

Thanks.
> 
> 
>>                                            /* free si->swap_map[] */
>>
>> Thanks.
>>
>>
> 
> .
> 


