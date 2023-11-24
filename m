Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D77F6EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjKXIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:54:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E32D48
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:54:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934A01042;
        Fri, 24 Nov 2023 00:55:05 -0800 (PST)
Received: from [10.57.71.2] (unknown [10.57.71.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FE283F73F;
        Fri, 24 Nov 2023 00:54:15 -0800 (PST)
Message-ID: <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
Date:   Fri, 24 Nov 2023 08:54:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Content-Language: en-GB
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87y1eovsn5.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 01:35, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 23/11/2023 05:13, Alistair Popple wrote:
>>>
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> ptep_get_and_clear_full() adds a 'full' parameter which is not present
>>>> for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
>>>> a full address space teardown is in progress. We use this information to
>>>> optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
>>>> tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
>>>> contiguous neighbours to keep their contig bit set, because we know we
>>>> are about to clear the rest too.
>>>>
>>>> Before this optimization, the cost of arm64_sys_exit_group() exploded to
>>>> 32x what it was before PTE_CONT support was wired up, when compiling the
>>>> kernel. With this optimization in place, we are back down to the
>>>> original cost.
>>>>
>>>> This approach is not perfect though, as for the duration between
>>>> returning from the first call to ptep_get_and_clear_full() and making
>>>> the final call, the contpte block in an intermediate state, where some
>>>> ptes are cleared and others are still set with the PTE_CONT bit. If any
>>>> other APIs are called for the ptes in the contpte block during that
>>>> time, we have to be very careful. The core code currently interleaves
>>>> calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
>>>> must be careful to ignore the cleared entries when accumulating the
>>>> access and dirty bits - the same goes for ptep_get_lockless(). The only
>>>> other calls we might resonably expect are to set markers in the
>>>> previously cleared ptes. (We shouldn't see valid entries being set until
>>>> after the tlbi, at which point we are no longer in the intermediate
>>>> state). Since markers are not valid, this is safe; set_ptes() will see
>>>> the old, invalid entry and will not attempt to unfold. And the new pte
>>>> is also invalid so it won't attempt to fold. We shouldn't see this for
>>>> the 'full' case anyway.
>>>>
>>>> The last remaining issue is returning the access/dirty bits. That info
>>>> could be present in any of the ptes in the contpte block. ptep_get()
>>>> will gather those bits from across the contpte block. We don't bother
>>>> doing that here, because we know that the information is used by the
>>>> core-mm to mark the underlying folio as accessed/dirty. And since the
>>>> same folio must be underpinning the whole block (that was a requirement
>>>> for folding in the first place), that information will make it to the
>>>> folio eventually once all the ptes have been cleared. This approach
>>>> means we don't have to play games with accumulating and storing the
>>>> bits. It does mean that any interleaved calls to ptep_get() may lack
>>>> correct access/dirty information if we have already cleared the pte that
>>>> happened to store it. The core code does not rely on this though.
>>>
>>> Does not *currently* rely on this. I can't help but think it is
>>> potentially something that could change in the future though which would
>>> lead to some subtle bugs.
>>
>> Yes, there is a risk, although IMHO, its very small.
>>
>>>
>>> Would there be any may of avoiding this? Half baked thought but could
>>> you for example copy the access/dirty information to the last (or
>>> perhaps first, most likely invalid) PTE?
>>
>> I spent a long time thinking about this and came up with a number of
>> possibilities, none of them ideal. In the end, I went for the simplest one
>> (which works but suffers from the problem that it depends on the way it is
>> called not changing).
> 
> Ok, that answers my underlying question of "has someone thought about
> this and are there any easy solutions". I suspected that was the case
> given the excellent write up though!
> 
>> 1) copy the access/dirty flags into all the remaining uncleared ptes within the
>> contpte block. This is how I did it in v1; although it was racy. I think this
>> could be implemented correctly but its extremely complex.
>>
>> 2) batch calls from the core-mm (like I did for pte_set_wrprotects()) so that we
>> can clear 1 or more full contpte blocks in a single call - the ptes are never in
>> an intermediate state. This is difficult because ptep_get_and_clear_full()
>> returns the pte that was cleared so its difficult to scale that up to multiple ptes.
>>
>> 3) add ptep_get_no_access_dirty() and redefine the interface to only allow that
>> to be called while ptep_get_and_clear_full() calls are on-going. Then assert in
>> the other functions that ptep_get_and_clear_full() is not on-going when they are
>> called. So we would get a clear sign that usage patterns have changed. But there
>> is no easy place to store that state (other than scanning a contpte block
>> looking for pte_none() amongst pte_valid_cont() entries) and it all felt ugly.
>>
>> 4) The simple approach I ended up taking; I thought it would be best to keep it
>> simple and see if anyone was concerned before doing something more drastic.
>>
>> What do you think? If we really need to solve this, then option 1 is my
>> preferred route, but it would take some time to figure out and reason about a
>> race-free scheme.
> 
> Well I like simple, and I agree the risk is small. But I can't help feel
> the current situation is too subtle, mainly because it is architecture
> specific and the assumptions are not communicated in core-mm code
> anywhere. But also none of the aternatives seem much better.
> 
> However there are only three callers of ptep_get_and_clear_full(), and
> all of these hold the PTL. So if I'm not mistaken that should exclude
> just about all users of ptep_get*() which will take the ptl before hand.

The problem isn't racing threads because as you say, the PTL is already
serializing all calls except ptep_get_lockless(). And although there are 3
callers to ptep_get_and_clear_full(), only the caller in zap_pte_range() ever
calls it with full=1, as I recall.

The problem is that the caller in zap_pte_range() does this:

ptl = lock_page_table()
for each pte {
	ptent = ptep_get(pte);
	if (pte_present(ptent) {
		ptent = ptep_get_and_clear_full(ptent);
		if (pte_dirty(ptent))
			...
		if (pte_young(ptent))
			...
	}
}
unlock_page_table(ptl)

It deliberately interleves calls to ptep_get() and ptep_get_and_clear_full()
under the ptl. So if the loop is iterating over a contpte block and the HW
happens to be storing the access/dirty info in the first pte entry, then the
first time through the loop, ptep_get() will return the correct access/dirty
info, as will ptep_get_and_clear_full(). The next time through the loop though,
the access/dirty info which was in the previous pte is now cleared so ptep_get()
and ptep_get_and_clear_full() will return old/clean. It all works, but is fragile.


> 
> So really that only leaves ptep_get_lockless() that could/should
> interleave right? 

Yes, but ptep_get_lockless() is special. Since it is called without the PTL, it
is very careful to ensure that the contpte block is in a consistent state and it
keeps trying until it is. So this will always return the correct consistent
information.

> From a quick glance of those users none look at the
> young/dirty information anyway, so I wonder if we can just assert in the
> core-mm that ptep_get_lockless() does not return young/dirty information
> and clear it in the helpers? That would make things explicit and
> consistent which would address my concern (although I haven't looked too
> closely at the details there).

As per explanation above, its not ptep_get_lockless() that is the problem so I
don't think this helps.

Thanks,
Ryan

> 
>> Thanks,
>> Ryan
> 

