Return-Path: <linux-kernel+bounces-95162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F822874A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31C21C2213D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AF82D78;
	Thu,  7 Mar 2024 08:50:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42451C54;
	Thu,  7 Mar 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801415; cv=none; b=H/aOmA9ZmEVbuCW6PBTykosnePkqLekQwoA9xFOuUIp0JdPQsDIHz7pgTOMc8o6Dw8l9Ie8rsGzh44B5h2YCvmXPdQXm2jk7Jjn23UnTGOtFANgR64AKJg7aJPvUQnCbNjBLta9fpEbXYYUuxL355O9eUgpJzefpM1AZ42eHae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801415; c=relaxed/simple;
	bh=nQj/xlh+sQZ1bYu4/N/LeWGrATg1jqRGDx6ZVgj3WRY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nMqYPay+idaGHw8LVfjysDskmIVGwGe7g85ofFKPd7STg/HmNRgkv1p5d7+ClgjY8WPhUHL7N5fa9kcCK3sNxHXYbO7awjHQ0Yjd0xyBeJnhnIV6+3fSy76LGolhflWBZkgfpGQQHWTtH4+zpmHllt/FGJG/dWHELLljFKrMGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tr2y24YNtz1Q9P2;
	Thu,  7 Mar 2024 16:48:10 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 895611404F6;
	Thu,  7 Mar 2024 16:50:09 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 16:50:09 +0800
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
To: "Huang, Ying" <ying.huang@intel.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
 <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
 <ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com>
 <87bk7q7ffp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0925807f-d226-7f08-51d1-ab771b1a6c24@huawei.com>
 <8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <588b8b8f-979c-a4e5-a332-8b0f89421ecd@huawei.com>
Date: Thu, 7 Mar 2024 16:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/3/7 15:34, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2024/3/7 13:56, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> On 2024/3/6 17:31, Ryan Roberts wrote:
>>>>> On 06/03/2024 08:51, Miaohe Lin wrote:
>>>>>> On 2024/3/6 10:52, Huang, Ying wrote:
>>>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>>>
>>>>>>>> There was previously a theoretical window where swapoff() could run and
>>>>>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>>>>>> running in another thread. This could cause, amongst other bad
>>>>>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>>>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>>>>>
>>>>>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>>>>>> a test case. But there has been agreement based on code review that this
>>>>>>>> is possible (see link below).
>>>>>>>>
>>>>>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>>>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>>>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>>>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>>>>>> where this extra check would cause any false alarms.
>>>>>>>>
>>>>>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>>>>>> for deriving this):
>>>>>>>>
>>>>>>>> --8<-----
>>>>>>>>
>>>>>>>> __swap_entry_free() might be the last user and result in
>>>>>>>> "count == SWAP_HAS_CACHE".
>>>>>>>>
>>>>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>>>>
>>>>>>>> So the question is: could someone reclaim the folio and turn
>>>>>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>>>>>
>>>>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>>>>>> still references by swap entries.
>>>>>>>>
>>>>>>>> Process 1 still references subpage 0 via swap entry.
>>>>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>>>>
>>>>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>>> [then, preempted in the hypervisor etc.]
>>>>>>>>
>>>>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>>>
>>>>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>>>>> __try_to_reclaim_swap().
>>>>>>>>
>>>>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>>>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>>>>>> swap_entry_free()->swap_range_free()->
>>>>>>>> ...
>>>>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>>>>
>>>>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>>>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>>>>>
>>>>>>>> --8<-----
>>>>>>>
>>>>>>> I think that this can be simplified.  Even for a 4K folio, this could
>>>>>>> happen.
>>>>>>>
>>>>>>> CPU0                                     CPU1
>>>>>>> ----                                     ----
>>>>>>>
>>>>>>> zap_pte_range
>>>>>>>   free_swap_and_cache
>>>>>>>   __swap_entry_free
>>>>>>>   /* swap count become 0 */
>>>>>>>                                          swapoff
>>>>>>>                                            try_to_unuse
>>>>>>>                                              filemap_get_folio
>>>>>>>                                              folio_free_swap
>>>>>>>                                              /* remove swap cache */
>>>>>>>                                            /* free si->swap_map[] */
>>>>>>>
>>>>>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>>>>>
>>>>>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
>>>>>
>>>>> I don't beleive it has the PTL when called by shmem.
>>>>
>>>> In the case of shmem, folio_lock is used to guard against the race.
>>>
>>> I don't find folio is lock for shmem.  find_lock_entries() will only
>>> lock the folio if (!xa_is_value()), that is, not swap entry.  Can you
>>> point out where the folio is locked for shmem?
>>
>> You're right, folio is locked if not swap entry. That's my mistake. But it seems above race is still nonexistent.
>> shmem_unuse() will first be called to read all the shared memory data that resides in the swap device back into
>> memory when doing swapoff. In that case, all the swapped pages are moved to page cache thus there won't be any
>> xa_is_value(folio) cases when calling shmem_undo_range(). free_swap_and_cache() even won't be called from
>> shmem_undo_range() after shmem_unuse(). Or am I miss something?
> 
> I think the following situation is possible.  Right?
> 
> CPU0                               CPU1
> ----                               ----
> shmem_undo_range
>   shmem_free_swap
>     xa_cmpxchg_irq
>     free_swap_and_cache
>       __swap_entry_free
>       /* swap count become 0 */
>                                    swapoff
>                                      try_to_unuse
>                                        shmem_unuse /* cannot find swap entry */
>                                        find_next_to_unuse
>                                        filemap_get_folio
>                                        folio_free_swap
>                                        /* remove swap cache */
>                                        /* free si->swap_map[] */
>       swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
> 
> shmem_undo_range can run earlier.

Considering above case, I tend to agree it's possible. I can't figure out a mechanism to make it impossible yet.

Thanks.

> 
> --
> Best Regards,
> Huang, Ying
> .
> 


