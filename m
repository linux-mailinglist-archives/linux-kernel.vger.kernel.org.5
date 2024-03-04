Return-Path: <linux-kernel+bounces-91331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398A870F88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED41B22B93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B537AE6B;
	Mon,  4 Mar 2024 21:55:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB71C6AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589337; cv=none; b=bUFMed9bZw52978cI0gVvVMtkuJYf47iSx3Pnnxx2lZFUmfTHLIeXuukqp4poGmuR5Pf/HHTHDSTwJLROtg971jR7wKaFmwy9iBdn6phtbb3QHANShEIJV2YyrVlWTi2s8XhiXeKeC4NIfz907rqKkgXpOv4+XznlHG4mLI3gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589337; c=relaxed/simple;
	bh=zzxnjcPWqYVHLpSydgzNKYkbJMrP+/KrDyhCMMneXU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQvaHBvlaG7rbG8flIdFC8YRQhINWjenhtmP9MD8vIkXBqngglfsTWnE3FCMfPKvaB1MBIjmLgZFgrtGpVGOhPhI2Elanm/L0qxgG1HYMAqFqTv+SV8+bfCrKy8IkBs96Sgu4OFxfg++iYMZCppdT6maWqESwhOVAJ2SSKwNssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E3D2F4;
	Mon,  4 Mar 2024 13:56:05 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0147B3F73F;
	Mon,  4 Mar 2024 13:55:25 -0800 (PST)
Message-ID: <6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
Date: Mon, 4 Mar 2024 21:55:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
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
 <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
 <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
 <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
 <65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 20:50, David Hildenbrand wrote:
>>>>
>>>> This is the existing free_swap_and_cache(). I think _swap_info_get() would
>>>> break
>>>> if this could race with swapoff(), and __swap_entry_free() looks up the cluster
>>>> from an array, which would also be freed by swapoff if racing:
>>>>
>>>> int free_swap_and_cache(swp_entry_t entry)
>>>> {
>>>>      struct swap_info_struct *p;
>>>>      unsigned char count;
>>>>
>>>>      if (non_swap_entry(entry))
>>>>          return 1;
>>>>
>>>>      p = _swap_info_get(entry);
>>>>      if (p) {
>>>>          count = __swap_entry_free(p, entry);
>>>
>>> If count dropped to 0 and
>>>
>>>>          if (count == SWAP_HAS_CACHE)
>>>
>>>
>>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We removed
>>> it. That one would have to be reclaimed asynchronously.
>>>
>>> The existing code we would call swap_page_trans_huge_swapped() with the SI it
>>> obtained via _swap_info_get().
>>>
>>> I also don't see what should be left protecting the SI. It's not locked anymore,
>>> the swapcounts are at 0. We don't hold the folio lock.
>>>
>>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
>>
>> But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
>> think this all works out ok? While free_swap_and_cache() is running,
>> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
>> free_swap_and_cache() will never be called because the swap entry will have been
>> removed from the PTE?
> 
> But can't try_to_unuse() run, detect !si->inuse_pages and not even bother about
> scanning any further page tables?
> 
> But my head hurts from digging through that code.

Yep, glad I'm not the only one that gets headaches from swapfile.c.

> 
> Let me try again:
> 
> __swap_entry_free() might be the last user and result in "count == SWAP_HAS_CACHE".
> 
> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
> 
> 
> So the question is: could someone reclaim the folio and turn si->inuse_pages==0,
> before we completed swap_page_trans_huge_swapped().
> 
> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are still
> references by swap entries.
> 
> Process 1 still references subpage 0 via swap entry.
> Process 2 still references subpage 1 via swap entry.
> 
> Process 1 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> [then, preempted in the hypervisor etc.]
> 
> Process 2 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> 
> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
> __try_to_reclaim_swap().
> 
> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->put_swap_folio()->
> free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_range_free()->
> ...
> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> 
> 
> What stops swapoff to succeed after process 2 reclaimed the swap cache but
> before process 1 finished its call to swap_page_trans_huge_swapped()?

Assuming you are talking about anonymous memory, process 1 has the PTL while
it's executing free_swap_and_cache(). try_to_unuse() iterates over every vma in
every mm, and it swaps-in a page for every PTE that holds a swap entry for the
device being swapoff'ed. It takes the PTL while converting the swap entry to
present PTE - see unuse_pte(). Process 1 must have beaten try_to_unuse() to the
particular pte, because if try_to_unuse() got there first, it would have
converted it from a swap entry to present pte and process 1 would never even
have called free_swap_and_cache(). So try_to_unuse() will eventually wait on the
PTL until process 1 has released it after free_swap_and_cache() completes. Am I
missing something? Because that part feels pretty clear to me.

Its the shmem case that I'm struggling to explain.

> 
> 
> 
>>
>> That just leaves shmem... I suspected there might be some serialization between
>> shmem_unuse() (called from try_to_unuse()) and the shmem free_swap_and_cache()
>> callsites, but I can't see it. Hmm...
>>
>>>
>>> Would performing the overall operation under lock_cluster_or_swap_info help? Not
>>> so sure :(
>>
>> No - that function relies on being able to access the cluster from the array in
>> the swap_info and lock it. And I think that array has the same lifetime as
>> swap_map, so same problem. You'd need get_swap_device()/put_swap_device() and a
>> bunch of refactoring for the internals not to take the locks, I guess. I think
>> its doable, just not sure if neccessary...
> 
> Agreed.
> 


