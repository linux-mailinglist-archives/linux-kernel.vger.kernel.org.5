Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CA7F9F25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjK0L4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjK0L4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:56:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAE8A1A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402192F4;
        Mon, 27 Nov 2023 03:57:42 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0FB3F73F;
        Mon, 27 Nov 2023 03:56:52 -0800 (PST)
Message-ID: <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com>
Date:   Mon, 27 Nov 2023 11:56:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>, Steven Price <steven.price@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
 <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
 <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
 <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com>
 <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com>
 <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com>
 <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 18:14, Barry Song wrote:
> On Fri, Nov 24, 2023 at 10:55 PM Steven Price <steven.price@arm.com> wrote:
>>
>> On 24/11/2023 09:01, Ryan Roberts wrote:
>>> On 24/11/2023 08:55, David Hildenbrand wrote:
>>>> On 24.11.23 02:35, Barry Song wrote:
>>>>> On Mon, Nov 20, 2023 at 11:57 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 20/11/2023 09:11, David Hildenbrand wrote:
>>>>>>> On 17.11.23 19:41, Barry Song wrote:
>>>>>>>> On Fri, Nov 17, 2023 at 7:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On 17.11.23 01:15, Barry Song wrote:
>>>>>>>>>> On Fri, Nov 17, 2023 at 7:47 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, Nov 16, 2023 at 5:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 15.11.23 21:49, Barry Song wrote:
>>>>>>>>>>>>> On Wed, Nov 15, 2023 at 11:16 PM David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 14.11.23 02:43, Barry Song wrote:
>>>>>>>>>>>>>>> This patch makes MTE tags saving and restoring support large folios,
>>>>>>>>>>>>>>> then we don't need to split them into base pages for swapping out
>>>>>>>>>>>>>>> on ARM64 SoCs with MTE.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> arch_prepare_to_swap() should take folio rather than page as parameter
>>>>>>>>>>>>>>> because we support THP swap-out as a whole.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Meanwhile, arch_swap_restore() should use page parameter rather than
>>>>>>>>>>>>>>> folio as swap-in always works at the granularity of base pages right
>>>>>>>>>>>>>>> now.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> ... but then we always have order-0 folios and can pass a folio, or what
>>>>>>>>>>>>>> am I missing?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi David,
>>>>>>>>>>>>> you missed the discussion here:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
>>>>>>>>>>>>
>>>>>>>>>>>> Okay, so you want to handle the refault-from-swapcache case where you
>>>>>>>>>>>> get a
>>>>>>>>>>>> large folio.
>>>>>>>>>>>>
>>>>>>>>>>>> I was mislead by your "folio as swap-in always works at the granularity of
>>>>>>>>>>>> base pages right now" comment.
>>>>>>>>>>>>
>>>>>>>>>>>> What you actually wanted to say is "While we always swap in small
>>>>>>>>>>>> folios, we
>>>>>>>>>>>> might refault large folios from the swapcache, and we only want to restore
>>>>>>>>>>>> the tags for the page of the large folio we are faulting on."
>>>>>>>>>>>>
>>>>>>>>>>>> But, I do if we can't simply restore the tags for the whole thing at once
>>>>>>>>>>>> at make the interface page-free?
>>>>>>>>>>>>
>>>>>>>>>>>> Let me elaborate:
>>>>>>>>>>>>
>>>>>>>>>>>> IIRC, if we have a large folio in the swapcache, the swap
>>>>>>>>>>>> entries/offset are
>>>>>>>>>>>> contiguous. If you know you are faulting on page[1] of the folio with a
>>>>>>>>>>>> given swap offset, you can calculate the swap offset for page[0] simply by
>>>>>>>>>>>> subtracting from the offset.
>>>>>>>>>>>>
>>>>>>>>>>>> See page_swap_entry() on how we perform this calculation.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> So you can simply pass the large folio and the swap entry corresponding
>>>>>>>>>>>> to the first page of the large folio, and restore all tags at once.
>>>>>>>>>>>>
>>>>>>>>>>>> So the interface would be
>>>>>>>>>>>>
>>>>>>>>>>>> arch_prepare_to_swap(struct folio *folio);
>>>>>>>>>>>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>>>>>>>>>>>>
>>>>>>>>>>>> I'm sorry if that was also already discussed.
>>>>>>>>>>>
>>>>>>>>>>> This has been discussed. Steven, Ryan and I all don't think this is a good
>>>>>>>>>>> option. in case we have a large folio with 16 basepages, as do_swap_page
>>>>>>>>>>> can only map one base page for each page fault, that means we have
>>>>>>>>>>> to restore 16(tags we restore in each page fault) * 16(the times of page
>>>>>>>>>>> faults)
>>>>>>>>>>> for this large folio.
>>>>>>>>>>>
>>>>>>>>>>> and still the worst thing is the page fault in the Nth PTE of large folio
>>>>>>>>>>> might free swap entry as that swap has been in.
>>>>>>>>>>> do_swap_page()
>>>>>>>>>>> {
>>>>>>>>>>>       /*
>>>>>>>>>>>        * Remove the swap entry and conditionally try to free up the
>>>>>>>>>>> swapcache.
>>>>>>>>>>>        * We're already holding a reference on the page but haven't
>>>>>>>>>>> mapped it
>>>>>>>>>>>        * yet.
>>>>>>>>>>>        */
>>>>>>>>>>>        swap_free(entry);
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might
>>>>>>>>>>> access
>>>>>>>>>>> a freed tag.
>>>>>>>>>>
>>>>>>>>>> And David, one more information is that to keep the parameter of
>>>>>>>>>> arch_swap_restore() unchanged as folio,
>>>>>>>>>> i actually tried an ugly approach in rfc v2:
>>>>>>>>>>
>>>>>>>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>>>>>>>> +{
>>>>>>>>>> + if (system_supports_mte()) {
>>>>>>>>>> +      /*
>>>>>>>>>> +       * We don't support large folios swap in as whole yet, but
>>>>>>>>>> +       * we can hit a large folio which is still in swapcache
>>>>>>>>>> +       * after those related processes' PTEs have been unmapped
>>>>>>>>>> +       * but before the swapcache folio  is dropped, in this case,
>>>>>>>>>> +       * we need to find the exact page which "entry" is mapping
>>>>>>>>>> +       * to. If we are not hitting swapcache, this folio won't be
>>>>>>>>>> +       * large
>>>>>>>>>> +     */
>>>>>>>>>> + struct page *page = folio_file_page(folio, swp_offset(entry));
>>>>>>>>>> + mte_restore_tags(entry, page);
>>>>>>>>>> + }
>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> And obviously everybody in the discussion hated it :-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I can relate :D
>>>>>>>>>
>>>>>>>>>> i feel the only way to keep API unchanged using folio is that we
>>>>>>>>>> support restoring PTEs
>>>>>>>>>> all together for the whole large folio and we support the swap-in of
>>>>>>>>>> large folios. This is
>>>>>>>>>> in my list to do, I will send a patchset based on Ryan's large anon
>>>>>>>>>> folios series after a
>>>>>>>>>> while. till that is really done, it seems using page rather than folio
>>>>>>>>>> is a better choice.
>>>>>>>>>
>>>>>>>>> I think just restoring all tags and remembering for a large folio that
>>>>>>>>> they have been restored might be the low hanging fruit. But as always,
>>>>>>>>> devil is in the detail :)
>>>>>>>>
>>>>>>>> Hi David,
>>>>>>>> thanks for all your suggestions though my feeling is this is too complex and
>>>>>>>> is not worth it for at least  three reasons.
>>>>>>>
>>>>>>> Fair enough.
>>>>>>>
>>>>>>>>
>>>>>>>> 1. In multi-thread and particularly multi-processes, we need some locks to
>>>>>>>> protect and help know if one process is the first one to restore tags and if
>>>>>>>> someone else is restoring tags when one process wants to restore. there
>>>>>>>> is not this kind of fine-grained lock at all.
>>>>>>>
>>>>>>> We surely always hold the folio lock on swapin/swapout, no? So when these
>>>>>>> functions are called.
>>>>>>>
>>>>>>> So that might just work already -- unless I am missing something important.
>>>>>>
>>>>>> We already have a page flag that we use to mark the page as having had its mte
>>>>>> state associated; PG_mte_tagged. This is currently per-page (and IIUC, Matthew
>>>>>> has been working to remove as many per-page flags as possible). Couldn't we just
>>>>>> make arch_swap_restore() take a folio, restore the tags for *all* the pages and
>>>>>> repurpose that flag to be per-folio (so head page only)? It looks like the the
>>>>>> mte code already manages all the serialization requirements too. Then
>>>>>> arch_swap_restore() can just exit early if it sees the flag is already set on
>>>>>> the folio.
>>>>>>
>>>>>> One (probably nonsense) concern that just sprung to mind about having MTE work
>>>>>> with large folios in general; is it possible that user space could cause a large
>>>>>> anon folio to be allocated (THP), then later mark *part* of it to be tagged with
>>>>>> MTE? In this case you would need to apply tags to part of the folio only.
>>>>>> Although I have a vague recollection that any MTE areas have to be marked at
>>>>>> mmap time and therefore this type of thing is impossible?
>>>>>
>>>>> right, we might need to consider only a part of folio needs to be
>>>>> mapped and restored MTE tags.
>>>>> do_swap_page() can have a chance to hit a large folio but it only
>>>>> needs to fault-in a page.
>>>>>
>>>>> A case can be quite simple as below,
>>>>>
>>>>> 1. anon folio shared by process A and B
>>>>> 2. add_to_swap() as a large folio;
>>>>> 3. try to unmap A and B;
>>>>> 4. after A is unmapped(ptes become swap entries), we do a
>>>>> MADV_DONTNEED on a part of the folio. this can
>>>>> happen very easily as userspace is still working in 4KB level;
>>>>> userspace heap management can free an
>>>>> basepage area by MADV_DONTNEED;
>>>>> madvise(address, MADV_DONTNEED, 4KB);
>>>>> 5. A refault on address + 8KB, we will hit large folio in
>>>>> do_swap_page() but we will only need to map
>>>>> one basepage, we will never need this DONTNEEDed in process A.
>>>>>
>>>>> another more complicated case can be mprotect and munmap a part of
>>>>> large folios. since userspace
>>>>> has no idea of large folios in their mind, they can do all strange
>>>>> things. are we sure in all cases,
>>>>> large folios have been splitted into small folios?
>>>
>>> I don;'t think these examples you cite are problematic. Although user space
>>> thinks about things in 4K pages, the kernel does things in units of folios. So a
>>> folio is either fully swapped out or not swapped out at all. MTE tags can be
>>> saved/restored per folio, even if only part of that folio ends up being mapped
>>> back into user space.
> 
> I am not so optimistic :-)
> 
> but zap_pte_range() due to DONTNEED on a part of swapped-out folio can
> free a part of swap
> entries? thus, free a part of MTE tags in a folio?
> after process's large folios are swapped out, all PTEs in a large
> folio become swap
> entries, but DONTNEED on a part of this area will only set a part of
> swap entries to
> PTE_NONE, thus decrease the swapcount of this part?
> 
> zap_pte_range
>     ->
>           entry = pte_to_swp_entry
>                   -> free_swap_and_cache(entry)
>                       -> mte tags invalidate

OK I see what you mean.

Just trying to summarize this, I think there are 2 questions behind all this:

1) Can we save/restore MTE tags on at the granularity of a folio?

I think the answer is no; we can enable MTE on a individual pages within a folio
with mprotect, and we can throw away tags on individual pages as you describe
above. So we have to continue to handle tags per-page.

2) Should we use `struct folio` or `struct page` in the MTE interface? And if
using folio, what is the semantic?

If using `struct folio` I don't like the original semantic you had where the
implementation had to work out which sub-page was the target of the operation
from the swap entry. So if we opt for folio, then I guess that implies we would
want to save/restore tags for "all contained page which have MTE enabled". On
the restore path, the function will get called per-page so we will end up doing
a lot of uneccessary looping and early-exiting, I think?

So for me, it feels cleaner if we stick with the `struct page` approach on the
restore path, as you have it in your v3. It makes the semantic clear and avoids
all the extra looping.


> 
>>>
>>> The problem is that MTE tagging could be active only for a selection of pages
>>> within the folio; that's where it gets tricky.
>>>
>>>>
>>>> To handle that, we'd have to identify
>>>>
>>>> a) if a subpage has an mte tag to save during swapout
>>>> b) if a subpage has an mte tag to restore during swapin
>>>>
>>>> I suspect b) can be had from whatever datastructure we're using to actually save
>>>> the tags?
>>>>
>>>> For a), is there some way to have that information from the HW?
>>>
>>> Yes I agree with this approach. I don't know the answer to that question though;
>>> I'd assume it must be possible. Steven?
>>
>> Architecturally 'all' pages have MTE metadata (although see Alex's
>> series[1] which would change this).
>>
>> The question is: could user space have put any data in the tag storage?
>> We currently use the PG_mte_tagged page flag to keep track of pages
>> which have been mapped (to user space) with MTE enabled. If the page has
>> never been exposed to user space with MTE enabled (since being cleared)
>> then there's nothing of interest to store.
>>
>> It would be possible to reverse this scheme - we could drop the page
>> flag and just look at the actual tag storage. If it's all zeros then
>> obviously there's no point in storing it. Note that originally we had a
>> lazy clear of tag storage - i.e. if user space only had mapping without
>> MTE enabled then the tag storage could contain junk. I believe that's
>> now changed and the tag storage is always cleared at the same time as
>> the data storage.
>>
>> The VMAs (obviously) also carry the information about whether a range is
>> MTE-enabled (the VM_MTE flag controlled by PROT_MTE in user space), but
>> there could be many VMAs and they may have different permissions, so
>> fetching the state from there would be expensive.
>>
>> Not really relevant here, but the kernel can also use MTE (HW_TAGS
>> KASAN) - AFAIK there's no way of identifying if the MTE tag storage is
>> used or not for kernel pages. But this only presents an issue for
>> hibernation which uses a different mechanism to normal swap.
>>
>> Steve
>>
>> [1]
>> https://lore.kernel.org/r/20231119165721.9849-1-alexandru.elisei%40arm.com
> 
> Thanks
> Barry

