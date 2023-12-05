Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF78056FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjLEOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjLEOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:16:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A24C1B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:16:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF00A139F;
        Tue,  5 Dec 2023 06:17:45 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87FDD3F6C4;
        Tue,  5 Dec 2023 06:16:55 -0800 (PST)
Message-ID: <0b48135a-a44b-4b5a-a33b-abd3a3b47ff8@arm.com>
Date:   Tue, 5 Dec 2023 14:16:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
 <a12ce4f8-feb0-4e35-8f55-9270fe5a808b@redhat.com>
 <104de2d6-ecf9-4b0c-a982-5bd8e1aea758@redhat.com>
 <5b8b9f8c-8e9b-42a5-b8b2-9b96903f3ada@redhat.com>
 <a81dc390-8b10-4ce9-b72f-57f253e77af3@arm.com>
 <df99bb4e-f69d-4d94-baa5-2fc336df1a7b@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <df99bb4e-f69d-4d94-baa5-2fc336df1a7b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 12:04, David Hildenbrand wrote:
> On 05.12.23 12:30, Ryan Roberts wrote:
>> On 04/12/2023 17:27, David Hildenbrand wrote:
>>>>
>>>> With rmap batching from [1] -- rebased+changed on top of that -- we could turn
>>>> that into an effective (untested):
>>>>
>>>>            if (page && folio_test_anon(folio)) {
>>>> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>>>> end,
>>>> +                                               pte, enforce_uffd_wp,
>>>> &nr_dirty,
>>>> +                                               &nr_writable);
>>>>                    /*
>>>>                     * If this page may have been pinned by the parent process,
>>>>                     * copy the page immediately for the child so that we'll
>>>> always
>>>>                     * guarantee the pinned page won't be randomly replaced
>>>> in the
>>>>                     * future.
>>>>                     */
>>>> -               folio_get(folio);
>>>> -               if (unlikely(folio_try_dup_anon_rmap_pte(folio, page,
>>>> src_vma))) {
>>>> +               folio_ref_add(folio, nr);
>>>> +               if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page, nr,
>>>> src_vma))) {
>>>>                            /* Page may be pinned, we have to copy. */
>>>> -                       folio_put(folio);
>>>> -                       return copy_present_page(dst_vma, src_vma, dst_pte,
>>>> src_pte,
>>>> -                                                addr, rss, prealloc, page);
>>>> +                       folio_ref_sub(folio, nr);
>>>> +                       ret = copy_present_page(dst_vma, src_vma, dst_pte,
>>>> +                                               src_pte, addr, rss, prealloc,
>>>> +                                               page);
>>>> +                       return ret == 0 ? 1 : ret;
>>>>                    }
>>>> -               rss[MM_ANONPAGES]++;
>>>> +               rss[MM_ANONPAGES] += nr;
>>>>            } else if (page) {
>>>> -               folio_get(folio);
>>>> -               folio_dup_file_rmap_pte(folio, page);
>>>> -               rss[mm_counter_file(page)]++;
>>>> +               nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>>>> end,
>>>> +                                               pte, enforce_uffd_wp,
>>>> &nr_dirty,
>>>> +                                               &nr_writable);
>>>> +               folio_ref_add(folio, nr);
>>>> +               folio_dup_file_rmap_ptes(folio, page, nr);
>>>> +               rss[mm_counter_file(page)] += nr;
>>>>            }
>>>>
>>>>
>>>> We'll have to test performance, but it could be that we want to specialize
>>>> more on !folio_test_large(). That code is very performance-sensitive.
>>>>
>>>>
>>>> [1] https://lkml.kernel.org/r/20231204142146.91437-1-david@redhat.com
>>>
>>> So, on top of [1] without rmap batching but with a slightly modified version of
>>
>> Can you clarify what you mean by "without rmap batching"? I thought [1]
>> implicitly adds rmap batching? (e.g. folio_dup_file_rmap_ptes(), which you've
>> added in the code snippet above).
> 
> Not calling the batched variants but essentially doing what your code does (with
> some minor improvements, like updating the rss counters only once).
> 
> The snipped above is only linked below. I had the performance numbers for [1]
> ready, so I gave it a test on top of that.
> 
> To keep it simple, you might just benchmark w and w/o your patches.
> 
>>
>>> yours (that keeps the existing code structure as pointed out and e.g., updates
>>> counter updates), running my fork() microbenchmark with a 1 GiB of memory:
>>>
>>> Compared to [1], with all order-0 pages it gets 13--14% _slower_ and with all
>>> PTE-mapped THP (order-9) it gets ~29--30% _faster_.
>>
>> What test are you running - I'd like to reproduce if possible, since it sounds
>> like I've got some work to do to remove the order-0 regression.
> 
> Essentially just allocating 1 GiB of memory an measuring how long it takes to
> call fork().
> 
> order-0 benchmarks:
> 
> https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/order-0-benchmarks.c?ref_type=heads
> 
> e.g.,: $ ./order-0-benchmarks fork 100
> 
> 
> pte-mapped-thp benchmarks:
> 
> https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-thp-benchmarks.c?ref_type=heads
> 
> e.g.,: $ ./pte-mapped-thp-benchmarks fork 100
> 
> 
> Ideally, pin to one CPU and get stable performance numbers by disabling
> SMT+turbo etc.

This is great - thanks! I'll get to work...

> 
>>
>>>
>>> So looks like we really want to have a completely seprate code path for
>>> "!folio_test_large()" to keep that case as fast as possible. And "Likely" we
>>> want to use "likely(!folio_test_large()". ;)
>>
>> Yuk, but fair enough. If I can repro the perf numbers, I'll have a go a
>> reworking this.
>>
>> I think you're also implicitly suggesting that this change needs to depend on
>> [1]? Which is a shame...
> 
> Not necessarily. It certainly cleans up the code, but we can do that in any
> order reasonable.
> 
>>
>> I guess I should also go through a similar exercise for patch 2 in this series.
> 
> 
> Yes. There are "unmap" and "pte-dontneed" benchmarks contained in both files above.
> 

