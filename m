Return-Path: <linux-kernel+bounces-93630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A7873292
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2981C26361
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A455DF2B;
	Wed,  6 Mar 2024 09:31:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52D1B7E3;
	Wed,  6 Mar 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717467; cv=none; b=ksppRSttvGleJAR7vd0DsujJUcLOKUv5Av2xl4l4aE8YvUUt1hCZi2qoMibxBDP/iuSwmuccCjzeDY34cucDlzENWchNhdIcWsTjnGbcuj4I1VAAu2jnQZtHiCacPdfBqHaEK5NTc4WFYtB+Fu0bRPffvvCnfqGzoRkLoMBwhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717467; c=relaxed/simple;
	bh=7TVwWAITfTzss3r7zBS+JIIczj4t9ScDlXpSvhDyjFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/mkKSn7JqfgInIcLCgZyKmh3P30nBlTahgybHL+Ay/yu8aUUZ7Il/1Wmw058T648oSfz2kghOfwZEynKtIdDJKiytz12Bi5Migg34rnfsaMrNFHuImTqHzlrfYKo1YxTfP5L+nHFNraB6ItLVN5iAquWEm8XzfzUaCN4v6X+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86C1D1FB;
	Wed,  6 Mar 2024 01:31:41 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E643F762;
	Wed,  6 Mar 2024 01:31:02 -0800 (PST)
Message-ID: <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
Date: Wed, 6 Mar 2024 09:31:01 +0000
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
To: Miaohe Lin <linmiaohe@huawei.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 08:51, Miaohe Lin wrote:
> On 2024/3/6 10:52, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> There was previously a theoretical window where swapoff() could run and
>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>> running in another thread. This could cause, amongst other bad
>>> possibilities, swap_page_trans_huge_swapped() (called by
>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>
>>> This is a theoretical problem and I haven't been able to provoke it from
>>> a test case. But there has been agreement based on code review that this
>>> is possible (see link below).
>>>
>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>> where this extra check would cause any false alarms.
>>>
>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>> for deriving this):
>>>
>>> --8<-----
>>>
>>> __swap_entry_free() might be the last user and result in
>>> "count == SWAP_HAS_CACHE".
>>>
>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>
>>> So the question is: could someone reclaim the folio and turn
>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>
>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>> still references by swap entries.
>>>
>>> Process 1 still references subpage 0 via swap entry.
>>> Process 2 still references subpage 1 via swap entry.
>>>
>>> Process 1 quits. Calls free_swap_and_cache().
>>> -> count == SWAP_HAS_CACHE
>>> [then, preempted in the hypervisor etc.]
>>>
>>> Process 2 quits. Calls free_swap_and_cache().
>>> -> count == SWAP_HAS_CACHE
>>>
>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>> __try_to_reclaim_swap().
>>>
>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>> swap_entry_free()->swap_range_free()->
>>> ...
>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>
>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>
>>> --8<-----
>>
>> I think that this can be simplified.  Even for a 4K folio, this could
>> happen.
>>
>> CPU0                                     CPU1
>> ----                                     ----
>>
>> zap_pte_range
>>   free_swap_and_cache
>>   __swap_entry_free
>>   /* swap count become 0 */
>>                                          swapoff
>>                                            try_to_unuse
>>                                              filemap_get_folio
>>                                              folio_free_swap
>>                                              /* remove swap cache */
>>                                            /* free si->swap_map[] */
>>
>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
> 
> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.

I don't beleive it has the PTL when called by shmem.

> So synchronize_rcu (called by swapoff) will wait zap_pte_range to release the pte lock. So this
> theoretical problem can't happen. Or am I miss something?

For Huang Ying's example, I agree this can't happen because try_to_unuse() will
be waiting for the PTL (see the reply I just sent).

> 
> CPU0                                     CPU1
> ----                                     ----
> 
> zap_pte_range
>   pte_offset_map_lock -- spin_lock is held.
>   free_swap_and_cache
>    __swap_entry_free
>    /* swap count become 0 */
>                                          swapoff
>                                            try_to_unuse
>                                              filemap_get_folio
>                                              folio_free_swap
>                                              /* remove swap cache */
> 					    percpu_ref_kill(&p->users);
>    swap_page_trans_huge_swapped
>   pte_unmap_unlock -- spin_lock is released.
> 					    synchronize_rcu();  --> Will wait pte_unmap_unlock to be called?

Perhaps you can educate me here; I thought that synchronize_rcu() will only wait
for RCU critical sections to complete. The PTL is a spin lock, so why would
synchronize_rcu() wait for the PTL to become unlocked?


>                                            /* free si->swap_map[] */
> 
> Thanks.
> 
> 


