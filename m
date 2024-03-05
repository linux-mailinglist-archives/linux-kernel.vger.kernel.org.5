Return-Path: <linux-kernel+bounces-91924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4D87187F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E68928347D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0B04DA1F;
	Tue,  5 Mar 2024 08:46:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE3F9EB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628402; cv=none; b=HJz/wPMBu10tXcbz67MOvWEF3Vm52pTCfLJmmKNHmUBjzFaQUUYuW33LzLS+1BWe2hAXZBXGDA5TRS1tmf3ntpjWZRDMHfIum6V1wEOzRHLcuUqkZBPhJGyCRy+kLloYYi5uRH6SlZm37C954lYFKA5KsEeNa3fp/fHq2vhHrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628402; c=relaxed/simple;
	bh=8F+WyhlPFYg9+xtlwiUriad2lyBbLxYiDp3p/WVEEFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD2v2XEl+BAdkA1l11VcJVt502rg75rvbaB9eQ/+qGdOTar5kKA1V5EpZf6npTkEn04Gp0ezZgfHiSNPiU8AwxHyp5pqrNi8iv5H3R65s4M5LfW4nHqkUH0bfzj+tXtMVRjykVUipId1hAFU3Ik6ctyd5dqhQKRw4DDOcs3YSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0E282F4;
	Tue,  5 Mar 2024 00:47:14 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859173F73F;
	Tue,  5 Mar 2024 00:46:36 -0800 (PST)
Message-ID: <62454122-d036-41e2-bd84-8a5839515ba4@arm.com>
Date: Tue, 5 Mar 2024 08:46:35 +0000
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
To: David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
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
 <6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
 <3d47ae7d-297a-441e-941c-5b2e34ba8759@redhat.com>
 <3ae2da13-c33a-402f-9091-2c7328aea66a@arm.com>
 <87plw99phz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9a5cb081-c4f1-4abe-bb86-02aaca4e5433@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9a5cb081-c4f1-4abe-bb86-02aaca4e5433@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 08:35, David Hildenbrand wrote:
> On 05.03.24 07:11, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> + Hugh
>>>
>>> On 04/03/2024 22:02, David Hildenbrand wrote:
>>>> On 04.03.24 22:55, Ryan Roberts wrote:
>>>>> On 04/03/2024 20:50, David Hildenbrand wrote:
>>>>>>>>>
>>>>>>>>> This is the existing free_swap_and_cache(). I think _swap_info_get() would
>>>>>>>>> break
>>>>>>>>> if this could race with swapoff(), and __swap_entry_free() looks up the
>>>>>>>>> cluster
>>>>>>>>> from an array, which would also be freed by swapoff if racing:
>>>>>>>>>
>>>>>>>>> int free_swap_and_cache(swp_entry_t entry)
>>>>>>>>> {
>>>>>>>>>        struct swap_info_struct *p;
>>>>>>>>>        unsigned char count;
>>>>>>>>>
>>>>>>>>>        if (non_swap_entry(entry))
>>>>>>>>>            return 1;
>>>>>>>>>
>>>>>>>>>        p = _swap_info_get(entry);
>>>>>>>>>        if (p) {
>>>>>>>>>            count = __swap_entry_free(p, entry);
>>>>>>>>
>>>>>>>> If count dropped to 0 and
>>>>>>>>
>>>>>>>>>            if (count == SWAP_HAS_CACHE)
>>>>>>>>
>>>>>>>>
>>>>>>>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We
>>>>>>>> removed
>>>>>>>> it. That one would have to be reclaimed asynchronously.
>>>>>>>>
>>>>>>>> The existing code we would call swap_page_trans_huge_swapped() with the
>>>>>>>> SI it
>>>>>>>> obtained via _swap_info_get().
>>>>>>>>
>>>>>>>> I also don't see what should be left protecting the SI. It's not locked
>>>>>>>> anymore,
>>>>>>>> the swapcounts are at 0. We don't hold the folio lock.
>>>>>>>>
>>>>>>>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
>>>>>>>
>>>>>>> But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
>>>>>>> think this all works out ok? While free_swap_and_cache() is running,
>>>>>>> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
>>>>>>> free_swap_and_cache() will never be called because the swap entry will have
>>>>>>> been
>>>>>>> removed from the PTE?
>>>>>>
>>>>>> But can't try_to_unuse() run, detect !si->inuse_pages and not even bother
>>>>>> about
>>>>>> scanning any further page tables?
>>>>>>
>>>>>> But my head hurts from digging through that code.
>>>>>
>>>>> Yep, glad I'm not the only one that gets headaches from swapfile.c.
>>>>>
>>>>>>
>>>>>> Let me try again:
>>>>>>
>>>>>> __swap_entry_free() might be the last user and result in "count ==
>>>>>> SWAP_HAS_CACHE".
>>>>>>
>>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>>
>>>>>>
>>>>>> So the question is: could someone reclaim the folio and turn
>>>>>> si->inuse_pages==0,
>>>>>> before we completed swap_page_trans_huge_swapped().
>>>>>>
>>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>>>> still
>>>>>> references by swap entries.
>>>>>>
>>>>>> Process 1 still references subpage 0 via swap entry.
>>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>>
>>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>>> -> count == SWAP_HAS_CACHE
>>>>>> [then, preempted in the hypervisor etc.]
>>>>>>
>>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>
>>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>>> __try_to_reclaim_swap().
>>>>>>
>>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->put_swap_folio()->
>>>>>> free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_range_free()->
>>>>>> ...
>>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>>
>>>>>>
>>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache but
>>>>>> before process 1 finished its call to swap_page_trans_huge_swapped()?
>>>>>
>>>>> Assuming you are talking about anonymous memory, process 1 has the PTL while
>>>>> it's executing free_swap_and_cache(). try_to_unuse() iterates over every
>>>>> vma in
>>>>> every mm, and it swaps-in a page for every PTE that holds a swap entry for the
>>>>> device being swapoff'ed. It takes the PTL while converting the swap entry to
>>>>> present PTE - see unuse_pte(). Process 1 must have beaten try_to_unuse() to
>>>>> the
>>>>> particular pte, because if try_to_unuse() got there first, it would have
>>>>> converted it from a swap entry to present pte and process 1 would never even
>>>>> have called free_swap_and_cache(). So try_to_unuse() will eventually wait
>>>>> on the
>>>>> PTL until process 1 has released it after free_swap_and_cache() completes.
>>>>> Am I
>>>>> missing something? Because that part feels pretty clear to me.
>>>>
>>>> Why should try_to_unuse() do *anything* if it already finds
>>>> si->inuse_pages == 0 because we (p1 } p2) just freed the swapentries and
>>>> process
>>>> 2 managed to free the last remaining swapcache entry?
>>>
>>> Yeah ok. For some reason I thought unuse_mm() was iterating over all mms and so
>>> the `while (READ_ONCE(si->inuse_pages))` was only evaluated after iterating over
>>> every mm. Oops.
>>>
>>> So yes, I agree with you; I think this is broken. And I'm a bit worried this
>>> could be a can of worms; By the same logic, I think folio_free_swap(),
>>> swp_swapcount() and probably others are broken in the same way.
>>
>> Don't worry too much :-), we have get_swap_device() at least.  We can
>> insert it anywhere we want because it's quite lightweight.  And, because
>> swapoff() is so rare, the race is theoretical only.

Thanks for the response!

>>
>> For this specific case, I had thought that PTL is enough.  But after
>> looking at this more, I found a race here too.  Until
>> __swap_entry_free() return, we are OK, nobody can reduce the swap count
>> because we held the PTL.  

Even that is not true for the shmem case: As far as I can see, shmem doesn't
have the PTL or any other synchronizing lock when it calls
free_swap_and_cache(). I don't think that changes anything solution-wise though.

>> But, after that, even if its return value is
>> SWAP_HAS_CACHE (that is, in swap cache), parallel swap_unuse() or
>> __try_to_reclaim_swap() may remove the folio from swap cache, so free
>> the swap entry.  So, swapoff() can proceed to free the data structures
>> in parallel.
>>
>> To fix the race, we can add get/put_swap_device() in
>> free_swap_and_cache().
>>
>> For other places, we can check whether get/put_swap_device() has been
>> called in callers, and the swap reference we held has been decreased
>> (e.g., swap count protected by PTL, SWAP_HAS_CACHE protected by folio
>> lock).
> 
> Yes, sounds reasonable. We should likely update the documentation of
> get_swap_device(), that after decrementing the refcount, the SI might become
> stale and should not be touched without a prior get_swap_device().

Yep agreed. If nobody else is planning to do it, I'll try to create a test case
that provokes the problem then put a patch together to fix it.



