Return-Path: <linux-kernel+bounces-95064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE528748CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2741C21A31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6866310C;
	Thu,  7 Mar 2024 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EP0k/ibn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DE4A31;
	Thu,  7 Mar 2024 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797001; cv=none; b=BcNFSoqGGo8PBFFb7wwiKJKcmJua+SGLFrOibzaOFXDLEwvQ04hMye+8ypnJ4qLDpV9ZpLbyNXWGNil5FCxuO8f1eBua0LNJ5lhzqOHLjON45TLUbjzVHSMoAsbBIzmU7hbk+8moHfIEsUTo+cjxh5cqta1uPRdh6eEYvgMmuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797001; c=relaxed/simple;
	bh=0kfFQ3v5nLN2q6UY/69rGMRfdWI+zcCCjuvpf3DZH9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iyanZCceEyPOQ1w6refM5scF9dgSos+jAh4H0+SaYdHV8ZLwkRxTffdiJFefcHI4SORfzm+MPjOCeTyGmXBp+No5GU3P9odkHGYBxPw4YOi+t5bcUm8oF6aqkhaMJwtQHbYVEVONPtCdtwBYQIeLfLbkzHsrsjRl7d4+gjIDlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EP0k/ibn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709797000; x=1741333000;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0kfFQ3v5nLN2q6UY/69rGMRfdWI+zcCCjuvpf3DZH9M=;
  b=EP0k/ibnhARYa+vxr6fVHa4p/7iRIhMigb6Edt04DvzvHHjMO3EGKhmC
   Ds78Vtan2n49cgrAEy+iR7PcrPwWNnnf8ekhTmDgFbGsO2iRnLXO/ewrE
   6BRsVMsnLFGGqydBtLOZwxBkEsMYHj6hI72qAJZDC6MZnjzvP0ES5/kQN
   nj55/jjJNYBLM9+deMS8WZpGHwC7WrBAtDroqQFjqvWHeykTiqA9T2hYJ
   NErGmGa+Z0KQnLaTVXZ7zRcryLCOb9RPr/dKU1WqxkkJ3zcp5pdV2fMMW
   g2EfpzJjIQoOhShgQbTQbpnZqI4WBIr/eln/h4uDuDp7eV6Oeg4De4X5a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15174116"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="15174116"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="9930329"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:36:36 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <0925807f-d226-7f08-51d1-ab771b1a6c24@huawei.com> (Miaohe Lin's
	message of "Thu, 7 Mar 2024 14:50:10 +0800")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
	<af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
	<ff6aec00-f939-b7ba-c127-b133c4d95ee5@huawei.com>
	<87bk7q7ffp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<0925807f-d226-7f08-51d1-ab771b1a6c24@huawei.com>
Date: Thu, 07 Mar 2024 15:34:42 +0800
Message-ID: <8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2024/3/7 13:56, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> On 2024/3/6 17:31, Ryan Roberts wrote:
>>>> On 06/03/2024 08:51, Miaohe Lin wrote:
>>>>> On 2024/3/6 10:52, Huang, Ying wrote:
>>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>>
>>>>>>> There was previously a theoretical window where swapoff() could run and
>>>>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>>>>> running in another thread. This could cause, amongst other bad
>>>>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>>>>
>>>>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>>>>> a test case. But there has been agreement based on code review that this
>>>>>>> is possible (see link below).
>>>>>>>
>>>>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>>>>> where this extra check would cause any false alarms.
>>>>>>>
>>>>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>>>>> for deriving this):
>>>>>>>
>>>>>>> --8<-----
>>>>>>>
>>>>>>> __swap_entry_free() might be the last user and result in
>>>>>>> "count == SWAP_HAS_CACHE".
>>>>>>>
>>>>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>>>>
>>>>>>> So the question is: could someone reclaim the folio and turn
>>>>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>>>>
>>>>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>>>>> still references by swap entries.
>>>>>>>
>>>>>>> Process 1 still references subpage 0 via swap entry.
>>>>>>> Process 2 still references subpage 1 via swap entry.
>>>>>>>
>>>>>>> Process 1 quits. Calls free_swap_and_cache().
>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>> [then, preempted in the hypervisor etc.]
>>>>>>>
>>>>>>> Process 2 quits. Calls free_swap_and_cache().
>>>>>>> -> count == SWAP_HAS_CACHE
>>>>>>>
>>>>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>>>>> __try_to_reclaim_swap().
>>>>>>>
>>>>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>>>>> swap_entry_free()->swap_range_free()->
>>>>>>> ...
>>>>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>>>>
>>>>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>>>>
>>>>>>> --8<-----
>>>>>>
>>>>>> I think that this can be simplified.  Even for a 4K folio, this could
>>>>>> happen.
>>>>>>
>>>>>> CPU0                                     CPU1
>>>>>> ----                                     ----
>>>>>>
>>>>>> zap_pte_range
>>>>>>   free_swap_and_cache
>>>>>>   __swap_entry_free
>>>>>>   /* swap count become 0 */
>>>>>>                                          swapoff
>>>>>>                                            try_to_unuse
>>>>>>                                              filemap_get_folio
>>>>>>                                              folio_free_swap
>>>>>>                                              /* remove swap cache */
>>>>>>                                            /* free si->swap_map[] */
>>>>>>
>>>>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>>>>>
>>>>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
>>>>
>>>> I don't beleive it has the PTL when called by shmem.
>>>
>>> In the case of shmem, folio_lock is used to guard against the race.
>> 
>> I don't find folio is lock for shmem.  find_lock_entries() will only
>> lock the folio if (!xa_is_value()), that is, not swap entry.  Can you
>> point out where the folio is locked for shmem?
>
> You're right, folio is locked if not swap entry. That's my mistake. But it seems above race is still nonexistent.
> shmem_unuse() will first be called to read all the shared memory data that resides in the swap device back into
> memory when doing swapoff. In that case, all the swapped pages are moved to page cache thus there won't be any
> xa_is_value(folio) cases when calling shmem_undo_range(). free_swap_and_cache() even won't be called from
> shmem_undo_range() after shmem_unuse(). Or am I miss something?

I think the following situation is possible.  Right?

CPU0                               CPU1
----                               ----
shmem_undo_range
  shmem_free_swap
    xa_cmpxchg_irq
    free_swap_and_cache
      __swap_entry_free
      /* swap count become 0 */
                                   swapoff
                                     try_to_unuse
                                       shmem_unuse /* cannot find swap entry */
                                       find_next_to_unuse
                                       filemap_get_folio
                                       folio_free_swap
                                       /* remove swap cache */
                                       /* free si->swap_map[] */
      swap_page_trans_huge_swapped <-- access freed si->swap_map !!!

shmem_undo_range can run earlier.

--
Best Regards,
Huang, Ying

