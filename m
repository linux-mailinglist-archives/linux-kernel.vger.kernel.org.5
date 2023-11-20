Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956B87F163D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjKTOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjKTOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:51:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F3AD76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:50:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78727FEC;
        Mon, 20 Nov 2023 06:51:28 -0800 (PST)
Received: from [10.57.37.35] (unknown [10.57.37.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95DD3F6C4;
        Mon, 20 Nov 2023 06:50:38 -0800 (PST)
Message-ID: <18c3ce48-86a7-4880-9b46-816b831145cf@arm.com>
Date:   Mon, 20 Nov 2023 14:50:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Content-Language: en-GB
To:     Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
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
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
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

On 20/11/2023 10:57, Ryan Roberts wrote:
> On 20/11/2023 09:11, David Hildenbrand wrote:
>> On 17.11.23 19:41, Barry Song wrote:
>>> On Fri, Nov 17, 2023 at 7:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 17.11.23 01:15, Barry Song wrote:
>>>>> On Fri, Nov 17, 2023 at 7:47 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Nov 16, 2023 at 5:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 15.11.23 21:49, Barry Song wrote:
>>>>>>>> On Wed, Nov 15, 2023 at 11:16 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On 14.11.23 02:43, Barry Song wrote:
>>>>>>>>>> This patch makes MTE tags saving and restoring support large folios,
>>>>>>>>>> then we don't need to split them into base pages for swapping out
>>>>>>>>>> on ARM64 SoCs with MTE.
>>>>>>>>>>
>>>>>>>>>> arch_prepare_to_swap() should take folio rather than page as parameter
>>>>>>>>>> because we support THP swap-out as a whole.
>>>>>>>>>>
>>>>>>>>>> Meanwhile, arch_swap_restore() should use page parameter rather than
>>>>>>>>>> folio as swap-in always works at the granularity of base pages right
>>>>>>>>>> now.
>>>>>>>>>
>>>>>>>>> ... but then we always have order-0 folios and can pass a folio, or what
>>>>>>>>> am I missing?
>>>>>>>>
>>>>>>>> Hi David,
>>>>>>>> you missed the discussion here:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
>>>>>>>
>>>>>>> Okay, so you want to handle the refault-from-swapcache case where you get a
>>>>>>> large folio.
>>>>>>>
>>>>>>> I was mislead by your "folio as swap-in always works at the granularity of
>>>>>>> base pages right now" comment.
>>>>>>>
>>>>>>> What you actually wanted to say is "While we always swap in small folios, we
>>>>>>> might refault large folios from the swapcache, and we only want to restore
>>>>>>> the tags for the page of the large folio we are faulting on."
>>>>>>>
>>>>>>> But, I do if we can't simply restore the tags for the whole thing at once
>>>>>>> at make the interface page-free?
>>>>>>>
>>>>>>> Let me elaborate:
>>>>>>>
>>>>>>> IIRC, if we have a large folio in the swapcache, the swap entries/offset are
>>>>>>> contiguous. If you know you are faulting on page[1] of the folio with a
>>>>>>> given swap offset, you can calculate the swap offset for page[0] simply by
>>>>>>> subtracting from the offset.
>>>>>>>
>>>>>>> See page_swap_entry() on how we perform this calculation.
>>>>>>>
>>>>>>>
>>>>>>> So you can simply pass the large folio and the swap entry corresponding
>>>>>>> to the first page of the large folio, and restore all tags at once.
>>>>>>>
>>>>>>> So the interface would be
>>>>>>>
>>>>>>> arch_prepare_to_swap(struct folio *folio);
>>>>>>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>>>>>>>
>>>>>>> I'm sorry if that was also already discussed.
>>>>>>
>>>>>> This has been discussed. Steven, Ryan and I all don't think this is a good
>>>>>> option. in case we have a large folio with 16 basepages, as do_swap_page
>>>>>> can only map one base page for each page fault, that means we have
>>>>>> to restore 16(tags we restore in each page fault) * 16(the times of page
>>>>>> faults)
>>>>>> for this large folio.
>>>>>>
>>>>>> and still the worst thing is the page fault in the Nth PTE of large folio
>>>>>> might free swap entry as that swap has been in.
>>>>>> do_swap_page()
>>>>>> {
>>>>>>      /*
>>>>>>       * Remove the swap entry and conditionally try to free up the swapcache.
>>>>>>       * We're already holding a reference on the page but haven't mapped it
>>>>>>       * yet.
>>>>>>       */
>>>>>>       swap_free(entry);
>>>>>> }
>>>>>>
>>>>>> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might
>>>>>> access
>>>>>> a freed tag.
>>>>>
>>>>> And David, one more information is that to keep the parameter of
>>>>> arch_swap_restore() unchanged as folio,
>>>>> i actually tried an ugly approach in rfc v2:
>>>>>
>>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>>> +{
>>>>> + if (system_supports_mte()) {
>>>>> +      /*
>>>>> +       * We don't support large folios swap in as whole yet, but
>>>>> +       * we can hit a large folio which is still in swapcache
>>>>> +       * after those related processes' PTEs have been unmapped
>>>>> +       * but before the swapcache folio  is dropped, in this case,
>>>>> +       * we need to find the exact page which "entry" is mapping
>>>>> +       * to. If we are not hitting swapcache, this folio won't be
>>>>> +       * large
>>>>> +     */
>>>>> + struct page *page = folio_file_page(folio, swp_offset(entry));
>>>>> + mte_restore_tags(entry, page);
>>>>> + }
>>>>> +}
>>>>>
>>>>> And obviously everybody in the discussion hated it :-)
>>>>>
>>>>
>>>> I can relate :D
>>>>
>>>>> i feel the only way to keep API unchanged using folio is that we
>>>>> support restoring PTEs
>>>>> all together for the whole large folio and we support the swap-in of
>>>>> large folios. This is
>>>>> in my list to do, I will send a patchset based on Ryan's large anon
>>>>> folios series after a
>>>>> while. till that is really done, it seems using page rather than folio
>>>>> is a better choice.
>>>>
>>>> I think just restoring all tags and remembering for a large folio that
>>>> they have been restored might be the low hanging fruit. But as always,
>>>> devil is in the detail :)
>>>
>>> Hi David,
>>> thanks for all your suggestions though my feeling is this is too complex and
>>> is not worth it for at least  three reasons.
>>
>> Fair enough.
>>
>>>
>>> 1. In multi-thread and particularly multi-processes, we need some locks to
>>> protect and help know if one process is the first one to restore tags and if
>>> someone else is restoring tags when one process wants to restore. there
>>> is not this kind of fine-grained lock at all.
>>
>> We surely always hold the folio lock on swapin/swapout, no? So when these
>> functions are called.
>>
>> So that might just work already -- unless I am missing something important.
> 
> We already have a page flag that we use to mark the page as having had its mte
> state associated; PG_mte_tagged. This is currently per-page (and IIUC, Matthew
> has been working to remove as many per-page flags as possible). Couldn't we just
> make arch_swap_restore() take a folio, restore the tags for *all* the pages and
> repurpose that flag to be per-folio (so head page only)? It looks like the the
> mte code already manages all the serialization requirements too. Then
> arch_swap_restore() can just exit early if it sees the flag is already set on
> the folio.
> 
> One (probably nonsense) concern that just sprung to mind about having MTE work
> with large folios in general; is it possible that user space could cause a large
> anon folio to be allocated (THP), then later mark *part* of it to be tagged with
> MTE? In this case you would need to apply tags to part of the folio only.
> Although I have a vague recollection that any MTE areas have to be marked at
> mmap time and therefore this type of thing is impossible?

It is possible to use mprotect() to 'upgrade' memory to be MTE. So in
this case you'd need to be able to either split the folio or deal with
only part of it being tagged.

Steve

> Thanks,
> Ryan
> 
> 
> 
>>
>>>
>>> 2. folios are not always large, in many cases, they have just one base page
>>> and there is no tail to remember. and it seems pretty ugly if we turn out have
>>> to use different ways to remember restoring state for small folios and
>>> large folios.
>>
>> if (folio_test_large(folio)) {
>>
>> } else {
>>
>> }
>>
>> Easy ;)
>>
>> Seriously, it's not that complicated and/or ugly.
>>
>>>
>>> 3. there is nothing wrong to use page to restore tags since right now swap-in
>>> is page. restoring tags and swapping-in become harmonious with each other
>>> after this patch. I would argue what is really wrong is the current mainline.
>>>
>>> If eventually we are able to do_swap_page() for the whole large folio, we
>>> move to folios for MTE tags as well. These two behaviours make a new
>>> harmonious picture again.
>>>
>>
>> Just making both functions consume folios is much cleaner and also more future
>> proof.
>>
>> Consuming now a page where we used to consume a folio is a step backwards.
>>
> 

