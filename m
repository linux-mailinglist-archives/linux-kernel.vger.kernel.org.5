Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE90808758
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378921AbjLGMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:08:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54577C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:08:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F1B12FC;
        Thu,  7 Dec 2023 04:09:12 -0800 (PST)
Received: from [10.1.32.134] (XHFQ2J9959.cambridge.arm.com [10.1.32.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4777D3F6C4;
        Thu,  7 Dec 2023 04:08:23 -0800 (PST)
Message-ID: <126c3b71-1acc-4851-9986-4228cb8a8660@arm.com>
Date:   Thu, 7 Dec 2023 12:08:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-5-ryan.roberts@arm.com>
 <71040a8c-4ea1-4f21-8ac8-65f7c25c217e@redhat.com>
 <f2896d7f-183b-48fb-a3aa-d21bf2257043@arm.com>
 <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com>
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

On 07/12/2023 11:08, David Hildenbrand wrote:
> [...]
> 
>>>
>>> Nit: the orders = ... order = ... looks like this might deserve a helper
>>> function that makes this easier to read.
>>
>> To be honest, the existing function that I've modified is a bit of a mess.
> 
> It's all an ugly mess and I hate it.
> 
> It would be cleanest if we'd just have "thp_vma_configured_orders()" that gives
> us all configured orders for the given VMA+flags combination. No passing in of
> orders, try handling the masking in the caller.
> 
> Then, we move that nasty "transhuge_vma_suitable" handling for !in_pf out of
> there and handle that in the callers. The comment "Huge fault does the check in
> fault handlers. And this check is not suitable for huge PUD fault handlers."
> already makes me angry, what a mess.

My thp_vma_suitable_order[s]() does now at least work correctly for PUD.

> 
> 
> Then, we'd have a thp_vma_fitting_orders() / thp_vma_is_fitting_order() function
> that does the filtering only based on the given address + vma size/alignment.
> That's roughly "thp_vma_suitable_orders()".
> 
> 
> Finding a good name to combine both could be something like
> "thp_vma_possible_orders()".
> 
> 
> Would make more sense to me (but again, German guy, so it's probably all wrong).
> 
> 
>> thp_vma_allowable_orders() calls thp_vma_suitable_orders() if we are not in a
>> page fault, because the page fault handlers already do that check themselves. It
>> would be nice to refactor the whole thing so that thp_vma_allowable_orders() is
>> a strict superset of thp_vma_suitable_orders(). Then this can just call
>> thp_vma_allowable_orders(). But that's going to start touching the PMD and PUD
>> handlers, so prefer if we leave that for a separate patch set.
>>
>>>
>>> Nit: Why call thp_vma_suitable_orders if the orders are already 0? Again, some
>>> helper might be reasonable where that is handled internally.
>>
>> Because thp_vma_suitable_orders() will handle it safely and is inline, so it
>> should just as efficient? This would go away with the refactoring described
>> above.
> 
> Right. Won't win in a beauty contest. Some simple helper might make this much
> easier to digest.
> 
>>
>>>
>>> Comment: For order-0 we'll always perform a function call to both
>>> thp_vma_allowable_orders() / thp_vma_suitable_orders(). We should perform some
>>> fast and efficient check if any <PMD THP are even enabled in the system / for
>>> this VMA, and in that case just fallback before doing more expensive checks.
>>
>> thp_vma_allowable_orders() is inline as you mentioned.
>>
>> I was deliberately trying to keep all the decision logic in one place
>> (thp_vma_suitable_orders) because it's already pretty complicated. But if you
>> insist, how about this in the header:
>>
>> static inline
>> unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>                        unsigned long vm_flags, bool smaps,
>>                        bool in_pf, bool enforce_sysfs,
>>                        unsigned long orders)
>> {
>>     /* Optimization to check if required orders are enabled early. */
>>     if (enforce_sysfs && vma_is_anonymous(vma)) {
>>         unsigned long mask = READ_ONCE(huge_anon_orders_always);
>>
>>         if (vm_flags & VM_HUGEPAGE)
>>             mask |= READ_ONCE(huge_anon_orders_madvise);
>>         if (hugepage_global_always() ||
>>             ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
>>             mask |= READ_ONCE(huge_anon_orders_inherit);
>>
>>         orders &= mask;
>>         if (!orders)
>>             return 0;
>>        
>>         enforce_sysfs = false;
>>     }
>>
>>     return __thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf,
>>                       enforce_sysfs, orders);
>> }
>>
>> Then the above check can be removed from __thp_vma_allowable_orders() - it will
>> still retain the `if (enforce_sysfs && !vma_is_anonymous(vma))` part.
>>
> 
> Better. I still kind-of hate having to pass in orders here. Such masking is
> better done in the caller (see above how it might be done when moving the
> transhuge_vma_suitable() check out).
> 
>>
>>>
>>>> +
>>>> +    if (!orders)
>>>> +        goto fallback;
>>>> +
>>>> +    pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>> +    if (!pte)
>>>> +        return ERR_PTR(-EAGAIN);
>>>> +
>>>> +    order = first_order(orders);
>>>> +    while (orders) {
>>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>> +        vmf->pte = pte + pte_index(addr);
>>>> +        if (pte_range_none(vmf->pte, 1 << order))
>>>> +            break;
>>>
>>> Comment: Likely it would make sense to scan only once and determine the "largest
>>> none range" around that address, having the largest suitable order in mind.
>>
>> Yes, that's how I used to do it, but Yu Zhou requested simplifying to this,
>> IIRC. Perhaps this an optimization opportunity for later?
> 
> Yes, definetly.
> 
>>
>>>
>>>> +        order = next_order(&orders, order);
>>>> +    }
>>>> +
>>>> +    vmf->pte = NULL;
>>>
>>> Nit: Can you elaborate why you are messing with vmf->pte here? A simple helper
>>> variable will make this code look less magical. Unless I am missing something
>>> important :)
>>
>> Gahh, I used to pass the vmf to what pte_range_none() was refactored into (an
>> approach that was suggested by Yu Zhou IIRC). But since I did some refactoring
>> based on some comments from JohnH, I see I don't need that anymore. Agreed; it
>> will be much clearer just to use a local variable. Will fix.
>>
>>>
>>>> +    pte_unmap(pte);
>>>> +
>>>> +    gfp = vma_thp_gfp_mask(vma);
>>>> +
>>>> +    while (orders) {
>>>> +        addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>> +        folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>>> +        if (folio) {
>>>> +            clear_huge_page(&folio->page, addr, 1 << order);
>>>> +            return folio;
>>>> +        }
>>>> +        order = next_order(&orders, order);
>>>> +    }
>>>> +
>>>
>>> Queestion: would it make sense to combine both loops? I suspect memory
>>> allocations with pte_offset_map()/kmao are problematic.
>>
>> They are both operating on separate orders; next_order() is "consuming" an order
>> by removing the current one from the orders bitfield and returning the next one.
>>
>> So the first loop starts at the highest order and keeps checking lower orders
>> until one fully fits in the VMA. And the second loop starts at the first order
>> that was found to fully fits and loops to lower orders until an allocation is
>> successful.
> 
> Right, but you know from the first loop which order is applicable (and will be
> fed to the second loop) and could just pte_unmap(pte) + tryalloc. If that fails,
> remap and try with the next orders.

You mean something like this?

	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
	if (!pte)
		return ERR_PTR(-EAGAIN);

	order = highest_order(orders);
	while (orders) {
		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
		if (!pte_range_none(pte + pte_index(addr), 1 << order)) {
			order = next_order(&orders, order);
			continue;
		}

		pte_unmap(pte);
		
		folio = vma_alloc_folio(gfp, order, vma, addr, true);
		if (folio) {
			clear_huge_page(&folio->page, vmf->address, 1 << order);
			return folio;
		}

		pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
		if (!pte)
			return ERR_PTR(-EAGAIN);

		order = next_order(&orders, order);
	}

	pte_unmap(pte);

I don't really like that because if high order folio allocations fail, then you
are calling pte_range_none() again for the next lower order; once that check has
succeeded for an order it shouldn't be required for any lower orders. In this
case you also have lots of pte map/unmap.

The original version feels more efficient to me.

> 
> That would make the code certainly easier to understand. That "orders" magic of
> constructing, filtering, walking is confusing :)
> 
> 
> I might find some time today to see if there is an easy way to cleanup all what
> I spelled out above. It really is a mess. But likely that cleanup could be
> deferred (but you're touching it, so ... :) ).

I'm going to ignore the last 5 words. I heard the "that cleanup could be
deferred" part loud and clear though :)


> 

