Return-Path: <linux-kernel+bounces-92688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A1C87245F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EF9286391
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9AA8F7A;
	Tue,  5 Mar 2024 16:33:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68B35256;
	Tue,  5 Mar 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656399; cv=none; b=FNd/9AzmtLXMScxtGDcHEeKSOAeKsyaqrBDNZhC0V4OLNIDeJcOPKwmaO+0d9Dz6hCSITnZXnzzboXrxSLfATKue4/QBkkUGSvjijwbHkaFLwuQjW5lQs9DupubqF0eg7AoAd3BmbnWCO8PMUq7tEzxdzBo0xkQcRsz5asDdLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656399; c=relaxed/simple;
	bh=f5Lp8EFVZnUWM98jg6oEX+5rvZnQO3fYT71oARwy5D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRJ65iYMDujzoU4VTjuakHIlZ6jhst/ZG5+OZdpCLumxRlduXOqat8i+s17iWYGTLd+FX4YXYYFpDeOTCIA1mI7IZA8yfsaQdQC2v6Ka80WdKK6TAL1FIC8lSD8VE/5A1rKh5ew7ov7teECvwDLNByXt4I9B4RQirgCA6+2j0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3D5D1FB;
	Tue,  5 Mar 2024 08:33:51 -0800 (PST)
Received: from [10.1.39.151] (XHFQ2J9959.cambridge.arm.com [10.1.39.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AA163F738;
	Tue,  5 Mar 2024 08:33:14 -0800 (PST)
Message-ID: <8989df79-84f5-488c-bd74-c11d2241eff1@arm.com>
Date: Tue, 5 Mar 2024 16:33:12 +0000
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
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 15:50, David Hildenbrand wrote:
> On 05.03.24 16:13, Ryan Roberts wrote:
>> There was previously a theoretical window where swapoff() could run and
>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>> running in another thread. This could cause, amongst other bad
>> possibilities, swap_page_trans_huge_swapped() (called by
>> free_swap_and_cache()) to access the freed memory for swap_map.
>>
>> This is a theoretical problem and I haven't been able to provoke it from
>> a test case. But there has been agreement based on code review that this
>> is possible (see link below).
>>
>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>> the swap entry was valid. This wasn't present in get_swap_device() so
>> I've added it. I couldn't find any existing get_swap_device() call sites
>> where this extra check would cause any false alarms.
>>
>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>> for deriving this):
> 
> Almost
> 
> "s/Hilenbrand/Hildenbrand/" :)

Ahh sorry... I even explicitly checked it against your name on emails... fat
fingers...

> 
>>
>> --8<-----
>>
>> __swap_entry_free() might be the last user and result in
>> "count == SWAP_HAS_CACHE".
>>
>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>
>> So the question is: could someone reclaim the folio and turn
>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>
>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>> still references by swap entries.
>>
>> Process 1 still references subpage 0 via swap entry.
>> Process 2 still references subpage 1 via swap entry.
>>
>> Process 1 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>> [then, preempted in the hypervisor etc.]
>>
>> Process 2 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>>
>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>> __try_to_reclaim_swap().
>>
>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>> swap_entry_free()->swap_range_free()->
>> ...
>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>
>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>
>> --8<-----
>>
>> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
>> Closes:
>> https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Applies on top of v6.8-rc6 and mm-unstable (b38c34939fe4).
>>
>> Thanks,
>> Ryan
>>
>>   mm/swapfile.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 2b3a2d85e350..f580e6abc674 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1281,7 +1281,9 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>       smp_rmb();
>>       offset = swp_offset(entry);
>>       if (offset >= si->max)
>> -        goto put_out;
>> +        goto bad_offset;
>> +    if (data_race(!si->swap_map[swp_offset(entry)]))
>> +        goto bad_free;
>>
>>       return si;
>>   bad_nofile:
>> @@ -1289,9 +1291,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t
>> entry)
>>   out:
>>       return NULL;
>>   put_out:
>> -    pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>>       percpu_ref_put(&si->users);
>>       return NULL;
>> +bad_offset:
>> +    pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>> +    goto put_out;
>> +bad_free:
>> +    pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
>> +    goto put_out;
>>   }
>>
>>   static unsigned char __swap_entry_free(struct swap_info_struct *p,
>> @@ -1609,13 +1616,14 @@ int free_swap_and_cache(swp_entry_t entry)
>>       if (non_swap_entry(entry))
>>           return 1;
>>
>> -    p = _swap_info_get(entry);
>> +    p = get_swap_device(entry);
>>       if (p) {
>>           count = __swap_entry_free(p, entry);
>>           if (count == SWAP_HAS_CACHE &&
>>               !swap_page_trans_huge_swapped(p, entry))
>>               __try_to_reclaim_swap(p, swp_offset(entry),
>>                             TTRS_UNMAPPED | TTRS_FULL);
>> +        put_swap_device(p);
>>       }
>>       return p != NULL;
>>   }
>> -- 
>> 2.25.1
>>
> 
> LGTM
> 
> Are you planning on sending a doc extension for get_swap_device()?

I saw your comment:

We should likely update the documentation of get_swap_device(), that after
decrementing the refcount, the SI might become stale and should not be touched
without a prior get_swap_device().

But when I went to make the changes, I saw the documentation already said:

..we need to enclose all swap related functions with get_swap_device() and
put_swap_device()... Notice that swapoff ... can still happen before the
percpu_ref_tryget_live() in get_swap_device() or after the percpu_ref_put() in
put_swap_device()... The caller must be prepared for that.

I thought that already covered it? I'm sure as usual, I've misunderstood your
point. Happy to respin if you have something in mind?

