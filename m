Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07228086EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjLGLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:44:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59C019A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:44:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7201312FC;
        Thu,  7 Dec 2023 03:44:53 -0800 (PST)
Received: from [10.1.32.134] (XHFQ2J9959.cambridge.arm.com [10.1.32.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94403F762;
        Thu,  7 Dec 2023 03:44:04 -0800 (PST)
Message-ID: <856f4317-43d9-41bb-8096-1eef69c86d3b@arm.com>
Date:   Thu, 7 Dec 2023 11:44:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
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
 <20231204102027.57185-4-ryan.roberts@arm.com>
 <004ed23d-5571-4474-b7fe-7bc08817c165@redhat.com>
 <ca3a2b97-f08e-452a-91dc-1a53dece0aa6@arm.com>
 <378afc6b-f93a-48ad-8aa6-ab171f3b9613@redhat.com>
 <4aa520f0-7c84-4e93-88bf-aee6d8d3ea70@arm.com>
 <44fdd46b-ad46-4ae2-a20f-20374acdf464@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <44fdd46b-ad46-4ae2-a20f-20374acdf464@redhat.com>
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

On 07/12/2023 11:25, David Hildenbrand wrote:
> On 07.12.23 12:22, Ryan Roberts wrote:
>> On 07/12/2023 11:13, David Hildenbrand wrote:
>>>>>
>>>>>> +
>>>>>>         if (!vma->vm_mm)        /* vdso */
>>>>>> -        return false;
>>>>>> +        return 0;
>>>>>>           /*
>>>>>>          * Explicitly disabled through madvise or prctl, or some
>>>>>> @@ -88,16 +141,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>>>>>> unsigned long vm_flags,
>>>>>>          * */
>>>>>>         if ((vm_flags & VM_NOHUGEPAGE) ||
>>>>>>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>>>>> -        return false;
>>>>>> +        return 0;
>>>>>>         /*
>>>>>>          * If the hardware/firmware marked hugepage support disabled.
>>>>>>          */
>>>>>>         if (transparent_hugepage_flags & (1 <<
>>>>>> TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>>>>> -        return false;
>>>>>> +        return 0;
>>>>>>           /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>>>>>>         if (vma_is_dax(vma))
>>>>>> -        return in_pf;
>>>>>> +        return in_pf ? orders : 0;
>>>>>>           /*
>>>>>>          * khugepaged special VMA and hugetlb VMA.
>>>>>> @@ -105,17 +158,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>>>>>> unsigned long vm_flags,
>>>>>>          * VM_MIXEDMAP set.
>>>>>>          */
>>>>>>         if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>>>>>> -        return false;
>>>>>> +        return 0;
>>>>>>           /*
>>>>>> -     * Check alignment for file vma and size for both file and anon vma.
>>>>>> +     * Check alignment for file vma and size for both file and anon vma by
>>>>>> +     * filtering out the unsuitable orders.
>>>>>>          *
>>>>>>          * Skip the check for page fault. Huge fault does the check in fault
>>>>>> -     * handlers. And this check is not suitable for huge PUD fault.
>>>>>> +     * handlers.
>>>>>>          */
>>>>>> -    if (!in_pf &&
>>>>>> -        !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>>>>>> -        return false;
>>>>>> +    if (!in_pf) {
>>>>>> +        int order = first_order(orders);
>>>>>> +        unsigned long addr;
>>>>>> +
>>>>>> +        while (orders) {
>>>>>> +            addr = vma->vm_end - (PAGE_SIZE << order);
>>>>>> +            if (thp_vma_suitable_orders(vma, addr, BIT(order)))
>>>>>> +                break;
>>>>>
>>>>> Comment: you'd want a "thp_vma_suitable_order" helper here. But maybe the
>>>>> compiler is smart enough to optimize the loop and everyything else out.
>>>>
>>>> I'm happy to refactor so that thp_vma_suitable_order() is the basic primitive,
>>>> then make thp_vma_suitable_orders() a loop that calls thp_vma_suitable_order()
>>>> (that's basically how it is laid out already, just all in one function). Is
>>>> that
>>>> what you are requesting?
>>>
>>> You got the spirit, yes.
>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> +
>>>>>> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>>>> +                     struct kobj_attribute *attr,
>>>>>> +                     const char *buf, size_t count)
>>>>>> +{
>>>>>> +    int order = to_thpsize(kobj)->order;
>>>>>> +    ssize_t ret = count;
>>>>>> +
>>>>>> +    if (sysfs_streq(buf, "always")) {
>>>>>> +        set_bit(order, &huge_anon_orders_always);
>>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>>> +    } else if (sysfs_streq(buf, "inherit")) {
>>>>>> +        set_bit(order, &huge_anon_orders_inherit);
>>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>>> +    } else if (sysfs_streq(buf, "madvise")) {
>>>>>> +        set_bit(order, &huge_anon_orders_madvise);
>>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>>> +    } else if (sysfs_streq(buf, "never")) {
>>>>>> +        clear_bit(order, &huge_anon_orders_always);
>>>>>> +        clear_bit(order, &huge_anon_orders_inherit);
>>>>>> +        clear_bit(order, &huge_anon_orders_madvise);
>>>>>
>>>>> Note: I was wondering for a second if some concurrent cames could lead to an
>>>>> inconsistent state. I think in the worst case we'll simply end up with "never"
>>>>> on races.
>>>>
>>>> You mean if different threads try to write different values to this file
>>>> concurrently? Or if there is a concurrent fault that tries to read the flags
>>>> while they are being modified?
>>>
>>> I thought about what you said first, but what you said last might also apply. As
>>> long as "nothing breaks", all good.
>>>
>>>>
>>>> I thought about this for a long time too and wasn't sure what was best. The
>>>> existing global enabled store impl clears the bits first then sets the bit.
>>>> With
>>>> this approach you can end up with multiple bits set if there is a race to set
>>>> diffierent values, and you can end up with a faulting thread seeing never if it
>>>> reads the bits after they have been cleared but before setting them.
>>>
>>> Right, but user space is playing stupid games and can win stupid prices. As long
>>> as nothing breaks, we're good.
>>>
>>>>
>>>> I decided to set the new bit before clearing the old bits, which is
>>>> different; A
>>>> racing fault will never see "never" but as you say, a race to set the file
>>>> could
>>>> result in "never" being set.
>>>>
>>>> On reflection, it's probably best to set the bit *last* like the global control
>>>> does?
>>>
>>> Probably might just slap a simple spinlock in there, so at least the writer side
>>> is completely serialized. Then you can just set the bit last. It's unlikely that
>>> readers will actually run into issues, and if they ever would, we could use some
>>> rcu magic to let them read a consistent state.
>>
>> I'd prefer to leave it as it is now; clear first, set last without any explicit
>> serialization. I've convinced myself that nothing breaks and its the same
>> pattern used by the global control so its consistent. Unless you're insisting on
>> the spin lock?
> 
> No, not at all. But it would certainly remove any possible concerns :)

OK fine, you win :). I'll add a spin lock on the writer side.


