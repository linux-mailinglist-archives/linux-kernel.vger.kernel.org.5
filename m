Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95267F9F32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjK0MBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjK0MBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07096101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701086473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DEGlXRGinJqVpSdJyXUQkv9137ntAYjqn0/11AplDSc=;
        b=EBulbKCN9ZtuUciTNSXLcx2rxQBFUXOJckV0oZaSeILkyIXuOp0Q/LHGm1PHLtM745WHUW
        95mbLphkOnv6ouSte3KAJFKksHEiUMh5CLnX4cBlULbeTzEw53ATOhYjB7GxsfbRYUEO0H
        lGtQNtTI8yHsREiquD3QscFX0x+yP64=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-iYKHqY6eMliBtSnll0oS5g-1; Mon, 27 Nov 2023 07:01:11 -0500
X-MC-Unique: iYKHqY6eMliBtSnll0oS5g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c87972a358so36311671fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086470; x=1701691270;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEGlXRGinJqVpSdJyXUQkv9137ntAYjqn0/11AplDSc=;
        b=pd/S7fuvIp0jCGmwCQOW6eG8fvEnACxJf8n/bzjV1Zb16sZ0vw1jMIVb8Fhpn4nNKH
         HJwqpQb/mlREgBIzb+ULvy9aLS7fZ2MU5aeBMFSASr+6/bjbYgJ0jtQ7lOhMsFQbceRV
         jCkJA2csjGwTuYdUTSY+HjXXKKXzsk4IjZTMg+rcHYq8GRR3j2WcdCfIMRjwzpDAYSvF
         2mKm3zRN6jylWi37i4dUnGjJNcixz5HYSCxU2wcF+owg44Tp6qdzg6jsnF4I0rtcm7aa
         OE5x97Z3wvruTWbY+K8KaSAIaCjzmkgKKAQk1OX8CvWa1iV9FMIQxCpi14Bz1eCUiQyn
         3wUg==
X-Gm-Message-State: AOJu0YyG/wJWfXcPMBPH8I4qW7/sL/axbdOO4IBArRTV/71ETIvQoSJa
        DgQDVObEv4V2nwucsE6yCweubzt83lnxOc0vRuUpzrLigyog86J77hWzaa6o4pdRll6l3jEd6Ak
        mX75B/x5OuW46LhCkXnMK6ZAy
X-Received: by 2002:a2e:a691:0:b0:2c9:a178:41af with SMTP id q17-20020a2ea691000000b002c9a17841afmr1864956lje.45.1701086469950;
        Mon, 27 Nov 2023 04:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJIa+spGALi0wSgxPsdhOV5PnqUioZNuhD4uBt2764CL9FwF8/7Xc1aYJIZBXSILui1GYWjA==
X-Received: by 2002:a2e:a691:0:b0:2c9:a178:41af with SMTP id q17-20020a2ea691000000b002c9a17841afmr1864932lje.45.1701086469459;
        Mon, 27 Nov 2023 04:01:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id n44-20020a05600c502c00b004083a105f27sm14404237wmr.26.2023.11.27.04.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:01:09 -0800 (PST)
Message-ID: <c5c82611-3153-4d56-b799-a1df3c953efe@redhat.com>
Date:   Mon, 27 Nov 2023 13:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Barry Song <21cnbao@gmail.com>,
        Steven Price <steven.price@arm.com>
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
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com>
 <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com>
 <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
 <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 12:56, Ryan Roberts wrote:
> On 24/11/2023 18:14, Barry Song wrote:
>> On Fri, Nov 24, 2023 at 10:55 PM Steven Price <steven.price@arm.com> wrote:
>>>
>>> On 24/11/2023 09:01, Ryan Roberts wrote:
>>>> On 24/11/2023 08:55, David Hildenbrand wrote:
>>>>> On 24.11.23 02:35, Barry Song wrote:
>>>>>> On Mon, Nov 20, 2023 at 11:57 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> On 20/11/2023 09:11, David Hildenbrand wrote:
>>>>>>>> On 17.11.23 19:41, Barry Song wrote:
>>>>>>>>> On Fri, Nov 17, 2023 at 7:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 17.11.23 01:15, Barry Song wrote:
>>>>>>>>>>> On Fri, Nov 17, 2023 at 7:47 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, Nov 16, 2023 at 5:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 15.11.23 21:49, Barry Song wrote:
>>>>>>>>>>>>>> On Wed, Nov 15, 2023 at 11:16 PM David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 14.11.23 02:43, Barry Song wrote:
>>>>>>>>>>>>>>>> This patch makes MTE tags saving and restoring support large folios,
>>>>>>>>>>>>>>>> then we don't need to split them into base pages for swapping out
>>>>>>>>>>>>>>>> on ARM64 SoCs with MTE.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> arch_prepare_to_swap() should take folio rather than page as parameter
>>>>>>>>>>>>>>>> because we support THP swap-out as a whole.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Meanwhile, arch_swap_restore() should use page parameter rather than
>>>>>>>>>>>>>>>> folio as swap-in always works at the granularity of base pages right
>>>>>>>>>>>>>>>> now.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ... but then we always have order-0 folios and can pass a folio, or what
>>>>>>>>>>>>>>> am I missing?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi David,
>>>>>>>>>>>>>> you missed the discussion here:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com/
>>>>>>>>>>>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com/
>>>>>>>>>>>>>
>>>>>>>>>>>>> Okay, so you want to handle the refault-from-swapcache case where you
>>>>>>>>>>>>> get a
>>>>>>>>>>>>> large folio.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I was mislead by your "folio as swap-in always works at the granularity of
>>>>>>>>>>>>> base pages right now" comment.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What you actually wanted to say is "While we always swap in small
>>>>>>>>>>>>> folios, we
>>>>>>>>>>>>> might refault large folios from the swapcache, and we only want to restore
>>>>>>>>>>>>> the tags for the page of the large folio we are faulting on."
>>>>>>>>>>>>>
>>>>>>>>>>>>> But, I do if we can't simply restore the tags for the whole thing at once
>>>>>>>>>>>>> at make the interface page-free?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Let me elaborate:
>>>>>>>>>>>>>
>>>>>>>>>>>>> IIRC, if we have a large folio in the swapcache, the swap
>>>>>>>>>>>>> entries/offset are
>>>>>>>>>>>>> contiguous. If you know you are faulting on page[1] of the folio with a
>>>>>>>>>>>>> given swap offset, you can calculate the swap offset for page[0] simply by
>>>>>>>>>>>>> subtracting from the offset.
>>>>>>>>>>>>>
>>>>>>>>>>>>> See page_swap_entry() on how we perform this calculation.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> So you can simply pass the large folio and the swap entry corresponding
>>>>>>>>>>>>> to the first page of the large folio, and restore all tags at once.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So the interface would be
>>>>>>>>>>>>>
>>>>>>>>>>>>> arch_prepare_to_swap(struct folio *folio);
>>>>>>>>>>>>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm sorry if that was also already discussed.
>>>>>>>>>>>>
>>>>>>>>>>>> This has been discussed. Steven, Ryan and I all don't think this is a good
>>>>>>>>>>>> option. in case we have a large folio with 16 basepages, as do_swap_page
>>>>>>>>>>>> can only map one base page for each page fault, that means we have
>>>>>>>>>>>> to restore 16(tags we restore in each page fault) * 16(the times of page
>>>>>>>>>>>> faults)
>>>>>>>>>>>> for this large folio.
>>>>>>>>>>>>
>>>>>>>>>>>> and still the worst thing is the page fault in the Nth PTE of large folio
>>>>>>>>>>>> might free swap entry as that swap has been in.
>>>>>>>>>>>> do_swap_page()
>>>>>>>>>>>> {
>>>>>>>>>>>>        /*
>>>>>>>>>>>>         * Remove the swap entry and conditionally try to free up the
>>>>>>>>>>>> swapcache.
>>>>>>>>>>>>         * We're already holding a reference on the page but haven't
>>>>>>>>>>>> mapped it
>>>>>>>>>>>>         * yet.
>>>>>>>>>>>>         */
>>>>>>>>>>>>         swap_free(entry);
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might
>>>>>>>>>>>> access
>>>>>>>>>>>> a freed tag.
>>>>>>>>>>>
>>>>>>>>>>> And David, one more information is that to keep the parameter of
>>>>>>>>>>> arch_swap_restore() unchanged as folio,
>>>>>>>>>>> i actually tried an ugly approach in rfc v2:
>>>>>>>>>>>
>>>>>>>>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>>>>>>>>> +{
>>>>>>>>>>> + if (system_supports_mte()) {
>>>>>>>>>>> +      /*
>>>>>>>>>>> +       * We don't support large folios swap in as whole yet, but
>>>>>>>>>>> +       * we can hit a large folio which is still in swapcache
>>>>>>>>>>> +       * after those related processes' PTEs have been unmapped
>>>>>>>>>>> +       * but before the swapcache folio  is dropped, in this case,
>>>>>>>>>>> +       * we need to find the exact page which "entry" is mapping
>>>>>>>>>>> +       * to. If we are not hitting swapcache, this folio won't be
>>>>>>>>>>> +       * large
>>>>>>>>>>> +     */
>>>>>>>>>>> + struct page *page = folio_file_page(folio, swp_offset(entry));
>>>>>>>>>>> + mte_restore_tags(entry, page);
>>>>>>>>>>> + }
>>>>>>>>>>> +}
>>>>>>>>>>>
>>>>>>>>>>> And obviously everybody in the discussion hated it :-)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I can relate :D
>>>>>>>>>>
>>>>>>>>>>> i feel the only way to keep API unchanged using folio is that we
>>>>>>>>>>> support restoring PTEs
>>>>>>>>>>> all together for the whole large folio and we support the swap-in of
>>>>>>>>>>> large folios. This is
>>>>>>>>>>> in my list to do, I will send a patchset based on Ryan's large anon
>>>>>>>>>>> folios series after a
>>>>>>>>>>> while. till that is really done, it seems using page rather than folio
>>>>>>>>>>> is a better choice.
>>>>>>>>>>
>>>>>>>>>> I think just restoring all tags and remembering for a large folio that
>>>>>>>>>> they have been restored might be the low hanging fruit. But as always,
>>>>>>>>>> devil is in the detail :)
>>>>>>>>>
>>>>>>>>> Hi David,
>>>>>>>>> thanks for all your suggestions though my feeling is this is too complex and
>>>>>>>>> is not worth it for at least  three reasons.
>>>>>>>>
>>>>>>>> Fair enough.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 1. In multi-thread and particularly multi-processes, we need some locks to
>>>>>>>>> protect and help know if one process is the first one to restore tags and if
>>>>>>>>> someone else is restoring tags when one process wants to restore. there
>>>>>>>>> is not this kind of fine-grained lock at all.
>>>>>>>>
>>>>>>>> We surely always hold the folio lock on swapin/swapout, no? So when these
>>>>>>>> functions are called.
>>>>>>>>
>>>>>>>> So that might just work already -- unless I am missing something important.
>>>>>>>
>>>>>>> We already have a page flag that we use to mark the page as having had its mte
>>>>>>> state associated; PG_mte_tagged. This is currently per-page (and IIUC, Matthew
>>>>>>> has been working to remove as many per-page flags as possible). Couldn't we just
>>>>>>> make arch_swap_restore() take a folio, restore the tags for *all* the pages and
>>>>>>> repurpose that flag to be per-folio (so head page only)? It looks like the the
>>>>>>> mte code already manages all the serialization requirements too. Then
>>>>>>> arch_swap_restore() can just exit early if it sees the flag is already set on
>>>>>>> the folio.
>>>>>>>
>>>>>>> One (probably nonsense) concern that just sprung to mind about having MTE work
>>>>>>> with large folios in general; is it possible that user space could cause a large
>>>>>>> anon folio to be allocated (THP), then later mark *part* of it to be tagged with
>>>>>>> MTE? In this case you would need to apply tags to part of the folio only.
>>>>>>> Although I have a vague recollection that any MTE areas have to be marked at
>>>>>>> mmap time and therefore this type of thing is impossible?
>>>>>>
>>>>>> right, we might need to consider only a part of folio needs to be
>>>>>> mapped and restored MTE tags.
>>>>>> do_swap_page() can have a chance to hit a large folio but it only
>>>>>> needs to fault-in a page.
>>>>>>
>>>>>> A case can be quite simple as below,
>>>>>>
>>>>>> 1. anon folio shared by process A and B
>>>>>> 2. add_to_swap() as a large folio;
>>>>>> 3. try to unmap A and B;
>>>>>> 4. after A is unmapped(ptes become swap entries), we do a
>>>>>> MADV_DONTNEED on a part of the folio. this can
>>>>>> happen very easily as userspace is still working in 4KB level;
>>>>>> userspace heap management can free an
>>>>>> basepage area by MADV_DONTNEED;
>>>>>> madvise(address, MADV_DONTNEED, 4KB);
>>>>>> 5. A refault on address + 8KB, we will hit large folio in
>>>>>> do_swap_page() but we will only need to map
>>>>>> one basepage, we will never need this DONTNEEDed in process A.
>>>>>>
>>>>>> another more complicated case can be mprotect and munmap a part of
>>>>>> large folios. since userspace
>>>>>> has no idea of large folios in their mind, they can do all strange
>>>>>> things. are we sure in all cases,
>>>>>> large folios have been splitted into small folios?
>>>>
>>>> I don;'t think these examples you cite are problematic. Although user space
>>>> thinks about things in 4K pages, the kernel does things in units of folios. So a
>>>> folio is either fully swapped out or not swapped out at all. MTE tags can be
>>>> saved/restored per folio, even if only part of that folio ends up being mapped
>>>> back into user space.
>>
>> I am not so optimistic :-)
>>
>> but zap_pte_range() due to DONTNEED on a part of swapped-out folio can
>> free a part of swap
>> entries? thus, free a part of MTE tags in a folio?
>> after process's large folios are swapped out, all PTEs in a large
>> folio become swap
>> entries, but DONTNEED on a part of this area will only set a part of
>> swap entries to
>> PTE_NONE, thus decrease the swapcount of this part?
>>
>> zap_pte_range
>>      ->
>>            entry = pte_to_swp_entry
>>                    -> free_swap_and_cache(entry)
>>                        -> mte tags invalidate
> 
> OK I see what you mean.
> 
> Just trying to summarize this, I think there are 2 questions behind all this:
> 
> 1) Can we save/restore MTE tags on at the granularity of a folio?
> 
> I think the answer is no; we can enable MTE on a individual pages within a folio
> with mprotect, and we can throw away tags on individual pages as you describe
> above. So we have to continue to handle tags per-page.

Can you enlighten me why the scheme proposed by Steven doesn't work?

I mean, having a mixture of tagged vs. untagged is assumed to be the 
corner case, right?

-- 
Cheers,

David / dhildenb

