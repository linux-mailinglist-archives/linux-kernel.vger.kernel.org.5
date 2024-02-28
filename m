Return-Path: <linux-kernel+bounces-85309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570086B3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D2B24642
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62715D5B3;
	Wed, 28 Feb 2024 15:57:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D31146015
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135867; cv=none; b=DXXxWC7/S77kMmNKEFMyxfcVeaKnUnigt3ktIlmdidqAjEu+gbDjq0BSAlJfSeTe9ZdFdFqDL3p7ktUZW99oaBY0OJzmyHWq3N0/te7jRVYNWAetUKk52Fz+0g6nz8ZFmGUBaoCsQ3q9r902DTq0baht7oqBLkGE80EBT2Kkdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135867; c=relaxed/simple;
	bh=r1R+dZHT8m/okG7vXtyVcqqyRBG47io2qdcgo/Nj0SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY5WtHGZWw97s4/GB11GHHYKef1zlG130UShKm0PoTLrLaUB8x4sm3xSDV/vxQJfplPNnGi0i9lR/JOEph/iqjs1FftBAYlXpXDWtpMqc8zSQpaXpEfRa5w8CVcES4azg3yvn5ugcy0YD0mXZZc4zsIaxZ+itFkJG0yAZiMXb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361501FB;
	Wed, 28 Feb 2024 07:58:23 -0800 (PST)
Received: from [10.1.38.163] (XHFQ2J9959.cambridge.arm.com [10.1.38.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244B23F762;
	Wed, 28 Feb 2024 07:57:42 -0800 (PST)
Message-ID: <0761feb8-638c-4b3f-8d91-c0dc9dbbf0c6@arm.com>
Date: Wed, 28 Feb 2024 15:57:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com,
 chrisl@kernel.org, surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240222070544.133673-1-21cnbao@gmail.com>
 <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com>
 <CAGsJ_4zWU91J_71zVjKua-RTO4hDUJMkL7z_RP1GnYf3W1dNEA@mail.gmail.com>
 <a4a9054f-2040-4f70-8d10-a5af4972e5aa@arm.com>
 <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 01:23, Barry Song wrote:
> On Wed, Feb 28, 2024 at 1:06 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 23/02/2024 09:46, Barry Song wrote:
>>> On Thu, Feb 22, 2024 at 11:09 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 22.02.24 08:05, Barry Song wrote:
>>>>> Hi Ryan,
>>>>>
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index 2cc0cb41fb32..ea19710aa4cd 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>>>                                      if (!can_split_folio(folio, NULL))
>>>>>>                                              goto activate_locked;
>>>>>>                                      /*
>>>>>> -                                     * Split folios without a PMD map right
>>>>>> -                                     * away. Chances are some or all of the
>>>>>> -                                     * tail pages can be freed without IO.
>>>>>> +                                     * Split PMD-mappable folios without a
>>>>>> +                                     * PMD map right away. Chances are some
>>>>>> +                                     * or all of the tail pages can be freed
>>>>>> +                                     * without IO.
>>>>>>                                       */
>>>>>> -                                    if (!folio_entire_mapcount(folio) &&
>>>>>> +                                    if (folio_test_pmd_mappable(folio) &&
>>>>>> +                                        !folio_entire_mapcount(folio) &&
>>>>>>                                          split_folio_to_list(folio,
>>>>>>                                                              folio_list))
>>>>>>                                              goto activate_locked;
>>>>>
>>>>> I ran a test to investigate what would happen while reclaiming a partially
>>>>> unmapped large folio. for example, for 64KiB large folios, MADV_DONTNEED
>>>>> 4KB~64KB, and keep the first subpage 0~4KiB.
>>>>
>>>> IOW, something that already happens with ordinary THP already IIRC.
>>>>
>>>>>
>>>>> My test wants to address my three concerns,
>>>>> a. whether we will have leak on swap slots
>>>>> b. whether we will have redundant I/O
>>>>> c. whether we will cause races on swapcache
>>>>>
>>>>> what i have done is printing folio->_nr_pages_mapped and dumping 16 swap_map[]
>>>>> at some specific stage
>>>>> 1. just after add_to_swap   (swap slots are allocated)
>>>>> 2. before and after try_to_unmap   (ptes are set to swap_entry)
>>>>> 3. before and after pageout (also add printk in zram driver to dump all I/O write)
>>>>> 4. before and after remove_mapping
>>>>>
>>>>> The below is the dumped info for a particular large folio,
>>>>>
>>>>> 1. after add_to_swap
>>>>> [   27.267357] vmscan: After add_to_swap shrink_folio_list 1947 mapnr:1
>>>>> [   27.267650] vmscan: offset:101b0 swp_map 40-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
>>>>>
>>>>> as you can see,
>>>>> _nr_pages_mapped is 1 and all 16 swap_map are SWAP_HAS_CACHE (0x40)
>>>>>
>>>>>
>>>>> 2. before and after try_to_unmap
>>>>> [   27.268067] vmscan: before try to unmap shrink_folio_list 1991 mapnr:1
>>>>> [   27.268372] try_to_unmap_one address:ffff731f0000 pte:e8000103cd0b43 pte_p:ffff0000c36a8f80
>>>>> [   27.268854] vmscan: after try to unmap shrink_folio_list 1997 mapnr:0
>>>>> [   27.269180] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
>>>>>
>>>>> as you can see, one pte is set to swp_entry, and _nr_pages_mapped becomes
>>>>> 0 from 1. The 1st swp_map becomes 0x41, SWAP_HAS_CACHE + 1
>>>>>
>>>>> 3. before and after pageout
>>>>> [   27.269602] vmscan: before pageout shrink_folio_list 2065 mapnr:0
>>>>> [   27.269880] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
>>>>> [   27.270691] zram: zram_write_page page:fffffc00030f3400 index:101b0
>>>>> [   27.271061] zram: zram_write_page page:fffffc00030f3440 index:101b1
>>>>> [   27.271416] zram: zram_write_page page:fffffc00030f3480 index:101b2
>>>>> [   27.271751] zram: zram_write_page page:fffffc00030f34c0 index:101b3
>>>>> [   27.272046] zram: zram_write_page page:fffffc00030f3500 index:101b4
>>>>> [   27.272384] zram: zram_write_page page:fffffc00030f3540 index:101b5
>>>>> [   27.272746] zram: zram_write_page page:fffffc00030f3580 index:101b6
>>>>> [   27.273042] zram: zram_write_page page:fffffc00030f35c0 index:101b7
>>>>> [   27.273339] zram: zram_write_page page:fffffc00030f3600 index:101b8
>>>>> [   27.273676] zram: zram_write_page page:fffffc00030f3640 index:101b9
>>>>> [   27.274044] zram: zram_write_page page:fffffc00030f3680 index:101ba
>>>>> [   27.274554] zram: zram_write_page page:fffffc00030f36c0 index:101bb
>>>>> [   27.274870] zram: zram_write_page page:fffffc00030f3700 index:101bc
>>>>> [   27.275166] zram: zram_write_page page:fffffc00030f3740 index:101bd
>>>>> [   27.275463] zram: zram_write_page page:fffffc00030f3780 index:101be
>>>>> [   27.275760] zram: zram_write_page page:fffffc00030f37c0 index:101bf
>>>>> [   27.276102] vmscan: after pageout and before needs_release shrink_folio_list 2124 mapnr:0
>>>>>
>>>>> as you can see, obviously, we have done redundant I/O - 16 zram_write_page though
>>>>> 4~64KiB has been zap_pte_range before, we still write them to zRAM.
>>>>>
>>>>> 4. before and after remove_mapping
>>>>> [   27.276428] vmscan: offset:101b0 swp_map 41-40-40-40-40-40-40-40-40-40-40-40-40-40-40-40
>>>>> [   27.277485] vmscan: after remove_mapping shrink_folio_list 2169 mapnr:0 offset:0
>>>>> [   27.277802] vmscan: offset:101b0 01-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>>>>
>>>>> as you can see, swp_map 1-15 becomes 0 and only the first swp_map is 1.
>>>>> all SWAP_HAS_CACHE has been removed. This is perfect and there is no swap
>>>>> slot leak at all!
>>>>>
>>>>> Thus, only two concerns are left for me,
>>>>> 1. as we don't split anyway, we have done 15 unnecessary I/O if a large folio
>>>>> is partially unmapped.
>>
>> So the cost of this is increased IO and swap storage, correct? Is this a big
>> problem in practice? i.e. do you see a lot of partially mapped large folios in
>> your workload? (I agree the proposed fix below is simple, so I think we should
>> do it anyway - I'm just interested in the scale of the problem).
>>
>>>>> 2. large folio is added as a whole as a swapcache covering the range whose
>>>>> part has been zapped. I am not quite sure if this will cause some problems
>>>>> while some concurrent do_anon_page, swapin and swapout occurs between 3 and
>>>>> 4 on zapped subpage1~subpage15. still struggling.. my brain is exploding...
>>
>> Yes mine too. I would only expect the ptes that map the folio will get replaced
>> with swap entries? So I would expect it to be safe. Although I understand the
>> concern with the extra swap consumption.
> 
> yes. it should still be safe. just more I/O and more swap spaces. but they will
> be removed while remove_mapping happens if try_to_unmap_one makes
> the folio unmapped.
> 
> but with the potential possibility even mapped PTEs can be skipped by
> try_to_unmap_one (reported intermediate PTEs issue - PTL is held till
> a valid PTE, some PTEs might be skipped by try_to_unmap without being
> set to swap entries), we could have the possibility folio_mapped() is still true
> after try_to_unmap_one. so we can't get to __remove_mapping() for a long
> time. but it still doesn't cause a crash.
> 
>>
>> [...]
>>>>>
>>>>> To me, it seems safer to split or do some other similar optimization if we find a
>>>>> large folio has partial map and unmap.
>>>>
>>>> I'm hoping that we can avoid any new direct users of _nr_pages_mapped if
>>>> possible.
>>>>
>>>
>>> Is _nr_pages_mapped < nr_pages a reasonable case to split as we
>>> have known the folio has at least some subpages zapped?
>>
>> I'm not sure we need this - the folio's presence on the split list will tell us
>> everything we need to know I think?
> 
> I agree, this is just one question to David, not my proposal.  if
> deferred_list is sufficient,
> I prefer we use deferred_list.
> 
> I actually don't quite understand why David dislikes _nr_pages_mapped being used
> though I do think _nr_pages_mapped cannot precisely reflect how a
> folio is mapped
> by multi-processes. but _nr_pages_mapped < nr_pages seems be safe to
> tell the folio
> is partially unmapped :-)
> 
>>
>>>
>>>> If we find that the folio is on the deferred split list, we might as
>>>> well just split it right away, before swapping it out. That might be a
>>>> reasonable optimization for the case you describe.
>>
>> Yes, agreed. I think there is still chance of a race though; Some other thread
>> could be munmapping in parallel. But in that case, I think we just end up with
>> the increased IO and swap storage? That's not the end of the world if its a
>> corner case.
> 
> I agree. btw, do we need a spinlock ds_queue->split_queue_lock for checking
> the list? deferred_split_folio(), for itself, has no spinlock while checking
>  if (!list_empty(&folio->_deferred_list)), but why? the read and write
> need to be exclusive.....

I don't think so. It's safe to check if the folio is on the queue like this; but
if it isn't then you need to recheck under the lock, as is done here. So for us,
I think we can also do this safely. It is certainly preferable to avoid taking
the lock.

The original change says this:

Before acquire split_queue_lock, check and bail out early if the THP
head page is in the queue already. The checking without holding
split_queue_lock could race with deferred_split_scan, but it doesn't
impact the correctness here.

> 
> void deferred_split_folio(struct folio *folio)
> {
>         ...
> 
>         if (!list_empty(&folio->_deferred_list))
>                 return;
> 
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (list_empty(&folio->_deferred_list)) {
>                 count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>                 ds_queue->split_queue_len++;
> #ifdef CONFIG_MEMCG
>                 if (memcg)
>                         set_shrinker_bit(memcg, folio_nid(folio),
>                                          deferred_split_shrinker->id);
> #endif
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> }
> 
>>
>>>
>>> i tried to change Ryan's code as below
>>>
>>> @@ -1905,11 +1922,12 @@ static unsigned int shrink_folio_list(struct
>>> list_head *folio_list,
>>>                                          * PMD map right away. Chances are some
>>>                                          * or all of the tail pages can be freed
>>>                                          * without IO.
>>> +                                        * Similarly, split PTE-mapped folios if
>>> +                                        * they have been already
>>> deferred_split.
>>>                                          */
>>> -                                       if (folio_test_pmd_mappable(folio) &&
>>> -                                           !folio_entire_mapcount(folio) &&
>>> -                                           split_folio_to_list(folio,
>>> -                                                               folio_list))
>>> +                                       if
>>> (((folio_test_pmd_mappable(folio) && !folio_entire_mapcount(folio)) ||
>>> +
>>> (!folio_test_pmd_mappable(folio) &&
>>> !list_empty(&folio->_deferred_list)))
>>
>> I'm not sure we need the different tests for pmd_mappable vs !pmd_mappable. I
>> think presence on the deferred list is a sufficient indicator that there are
>> unmapped subpages?
> 
> I don't think there are fundamental differences for pmd and pte. i was
> testing pte-mapped folio at that time, so kept the behavior of pmd as is.
> 
>>
>> I'll incorporate this into my next version.
> 
> Great!
> 
>>
>>> +                                           &&
>>> split_folio_to_list(folio, folio_list))
>>>                                                 goto activate_locked;
>>>                                 }
>>>                                 if (!add_to_swap(folio)) {
>>>
>>> It seems to work as expected. only one I/O is left for a large folio
>>> with 16 PTEs
>>> but 15 of them have been zapped before.
>>>
>>>>
>>>> --
>>>> Cheers,
>>>>
>>>> David / dhildenb
>>>>
>>>
> 
> Thanks
> Barry


