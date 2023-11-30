Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3947FEEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjK3MOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345279AbjK3MO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:14:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73D6D46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:14:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 029701042;
        Thu, 30 Nov 2023 04:15:21 -0800 (PST)
Received: from [10.1.34.169] (XHFQ2J9959.cambridge.arm.com [10.1.34.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4C533F5A1;
        Thu, 30 Nov 2023 04:14:31 -0800 (PST)
Message-ID: <529f35ed-8c3e-4c90-a0cd-4fb7567ae52c@arm.com>
Date:   Thu, 30 Nov 2023 12:14:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs
 interface
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-4-ryan.roberts@arm.com>
 <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
 <0641d171-731c-4c12-83c2-8212c63ffade@arm.com>
 <83744787-6bc5-4958-bdaa-030c9ed8225a@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <83744787-6bc5-4958-bdaa-030c9ed8225a@nvidia.com>
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

On 29/11/2023 19:40, John Hubbard wrote:
> 1On 11/29/23 03:05, Ryan Roberts wrote:
>> On 29/11/2023 03:42, John Hubbard wrote:
>>> On 11/22/23 08:29, Ryan Roberts wrote:
> ...
>>>> +As well as PMD-sized THP described above, it is also possible to
>>>> +configure the system to allocate "small-sized THP" to back anonymous
>>>
>>> Here's one of the places to change to the new name, which lately is
>>> "multi-size THP", or mTHP or m_thp for short. (I've typed "multi-size"
>>> instead of "multi-sized", because the 'd' doesn't add significantly to
>>> the meaning, and if in doubt, shorter is better.
>>
>> I was thinking of some light changes to the start of this paragraph, something
>> like:
>>
>> Modern kernels support "multi-size THP" (mTHP), which introduces the ability to
>> allocate memory in blocks that are bigger than a base page but smaller than
>> traditional PMD-size (as described above, in increments of a power-of-2 number
>> of pages. mTHP can back anonymous
>>
> 
> Very nice.
> 
> 
> ...
>>> By default, PMD-sized hugepages have enabled="inherited" and all other
>>> hugepage sizes have enabled="never".
>>
>> That all sounds good; will update.
>>
>> I wonder if "inherit" is even better than "inherited" though?
> 
> Yes, I think so. "inherit" was actually my first idea, and after
> thinking about it, I just made it worse by adding the "ed". haha. :)
> 
> ...
>>>>    Khugepaged controls
>>>>    -------------------
>>>>
>>>> +.. note::
>>>> +   khugepaged currently only searches for opportunities to collapse to
>>>> +   PMD-sized THP and no attempt is made to collapse to small-sized
>>>> +   THP.
>>>> +
>>
>> "small-sized THP" used here too; I propose to change it to "... collapse to
>> other THP sizes."
> 
> OK, looks good.
> 
>>
>>>>    khugepaged runs usually at low frequency so while one may not want to
>>>>    invoke defrag algorithms synchronously during the page faults, it
>>>>    should be worth invoking defrag at least in khugepaged. However it's
>>>> @@ -282,10 +321,11 @@ force
>>>>    Need of application restart
>>>>    ===========================
>>>>
>>>> -The transparent_hugepage/enabled values and tmpfs mount option only affect
>>>> -future behavior. So to make them effective you need to restart any
>>>> -application that could have been using hugepages. This also applies to the
>>>> -regions registered in khugepaged.
>>>> +The transparent_hugepage/enabled and
>>>> +transparent_hugepage/hugepages-<size>kB/enabled values and tmpfs mount
>>>> +option only affect future behavior. So to make them effective you need
>>>> +to restart any application that could have been using hugepages. This
>>>> +also applies to the regions registered in khugepaged.
>>>>
>>>>    Monitoring usage
>>>>    ================
>>>> @@ -308,6 +348,10 @@ frequently will incur overhead.
>>>>    There are a number of counters in ``/proc/vmstat`` that may be used to
>>>>    monitor how successfully the system is providing huge pages for use.
>>>>
>>>> +.. note::
>>>> +   Currently the below counters only record events relating to
>>>> +   PMD-sized THP. Events relating to small-sized THP are not included.
>>>
>>> Here's another spot to rename to "multi-size THP".
>>
>> I propose to change it to "Events relating to other THP sizes..."
>>
>> I'm also going to move this note to just under the "Monitoring Usage" heading
>> since its current position doesn't make it clear that it includes
>> "AnonHugePages". I'll also make it clear in the text that mentions AnonHugePages
>> counter that it "only applies to traditional PMD-sized THP for historical
>> reasons" and that "AnonHugePages should have been called AnonHugePmdMapped" as
>> David suggested in the other thread.
> 
> OK.
> 
> Are we entirely dropping the AnonHugePtePages that was there in v6? I'm

Yes, afraid so. David raised some concerns about the semantics of the counters
and also highlighted that (Greg KH?) doesn't want to see sysfs files with
multiple values so we might need to design a whole new interface eventually.

> looking for some way to monitor this. I may have missed it because I haven't
> gone through all of v7 yet.
> 
> ...
>>>> -"THPeligible" indicates whether the mapping is eligible for allocating THP
>>>> -pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
>>>> -It just shows the current status.
>>>> +"THPeligible" indicates whether the mapping is eligible for allocating
>>>> +naturally aligned THP pages of any currently enabled size. 1 if true, 0
>>>> +otherwise. It just shows the current status.
>>>
>>> "It just shows the current status"...as opposed to what? I'm missing an
>>> educational opportunity here--not sure what this means. :)
>>
>> I have no idea either - it seems superfluous. But that sentence was there
>> already. I can remove it if you like?
>>
> 
> Yes, let's remove it, please.
> 
> ...
>>>> +/*
>>>> + * Mask of all large folio orders supported for anonymous THP.
>>>> + */
>>>> +#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>>>> +
>>>> +/*
>>>> + * Mask of all large folio orders supported for file THP.
>>>> + */
>>>> +#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>>
>>> Is there something about file THP that implies PUD_ORDER? This
>>> deserves an explanatory comment, I think.
>>
>> Sorry, I'm not really sure what you are asking? Today's kernel supports
>> PUD-mapping file-backed memory (mostly DAX I believe). I'm not sure what comment
>> you want me to add, other than "file-backed memory can support PUD-mapping", but
>> that's self-evident from the define, isn't it?
>>
> 
> Well, it's sort of evident, but confusing to me anyway, because it
> combines THP and PUD. Which seems to imply that we have PUD-based THPs
> supported, but only for file-backed mappings. Which is weird and needs
> some explanation, right?

Ahh yes, you have fallen into the trap of thinking that until this point THP is
PMD-size only, which indeed is not the case for file-backed mappings; they
already support PMD- and PUD-size. And this is another reason why I think its OK
to continue to call the new sizes "THP".

I'm still not sure what you want me to explain in the code though... It's an
existing feature.


> 
>>>
>>>> +
>>>> +/*
>>>> + * Mask of all large folio orders supported for THP.
>>>> + */
>>>> +#define THP_ORDERS_ALL        (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
>>>> +
>>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>    #define HPAGE_PMD_SHIFT PMD_SHIFT
>>>>    #define HPAGE_PMD_SIZE    ((1UL) << HPAGE_PMD_SHIFT)
>>>> @@ -78,13 +93,18 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>>
>>>>    extern unsigned long transparent_hugepage_flags;
>>>>
>>>> -#define hugepage_flags_enabled()                           \
>>>> -    (transparent_hugepage_flags &                       \
>>>> -     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |               \
>>>> -      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>>>> -#define hugepage_flags_always()                \
>>>> -    (transparent_hugepage_flags &            \
>>>> -     (1<<TRANSPARENT_HUGEPAGE_FLAG))
>>>
>>> Are macros actually required? If not, static inlines would be nicer.
>>
>> I agree static inlines are nicer. Here I'm removing existing macros though, and
> 
> Oh, I see that I replied in the wrong part of the email, since that's the
> *removal* part. oops. :)
> 
> ...
>>>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>>>> -        unsigned long addr)
>>>> -{
>>>> -    unsigned long haddr;
>>>> -
>>>> -    /* Don't have to check pgoff for anonymous vma */
>>>> -    if (!vma_is_anonymous(vma)) {
>>>> -        if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>>>> -                HPAGE_PMD_NR))
>>>> -            return false;
>>>> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
>>>> +        unsigned long addr, unsigned long orders)
>>>
>>> Changing this from a bool to a mask of orders is quite significant, and
>>> both the function name and the function-level comment documentation need
>>> to also be adjusted. Here, perhaps one of these names would work:
>>>
>>>          transhuge_vma_suitable_orders()
>>
>> This is my preference, but its getting a bit long. How about:
>>
>>     thp_vma_suitable_orders()
>>
>> I could then call the other one:
>>
>>     thp_vma_allowable_orders()
>>
>> So we have a clearly related pair?
> 
> Oh yes, that works nicely.
> 
>>
>>
>>>          transhuge_vma_orders()>
>>>
>>>> +{
>>>> +    int order;
>>>> +
>>>> +    /*
>>>> +     * Iterate over orders, highest to lowest, removing orders that don't
>>>> +     * meet alignment requirements from the set. Exit loop at first order
>>>> +     * that meets requirements, since all lower orders must also meet
>>>> +     * requirements.
>>>
>>> Should we add a little note here, to the effect of, "this is unilaterally
>>> taking over a certain amount of allocation-like policy, by deciding how
>>> to search for folios of a certain size"?
>>>
>>> Or is this The Only Way To Do It, after all? I know we had some discussion
>>> about it, and intuitively it feels reasonable, but wanted to poke at it
>>> one last time anyway.
>>
>> This function isn't trying to implement policy, its just filtering out orders
>> that don't fit and therefore definitely cannot be used. The result is a set of
>> orders the could be used and its the policy maker's job to decide which one.
>> Currently that policy is "biggest one that fits && does not overlap other
>> non-none ptes && folio successfully allocated". That's implemented in the next
>> patch and would potentially be swapped out in the future for something more
>> exotic/optimal.
>>
>> So I don't think we need any extra comments here.
> 
> Ack.
> 
> ...
>>>> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>>>> -            bool smaps, bool in_pf, bool enforce_sysfs)
>>>> +#define hugepage_global_enabled()            \
>>>> +    (transparent_hugepage_flags &            \
>>>> +     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |        \
>>>> +      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>>>> +
>>>> +#define hugepage_global_always()            \
>>>> +    (transparent_hugepage_flags &            \
>>>> +     (1<<TRANSPARENT_HUGEPAGE_FLAG))
>>>> +
>>>
>>> Here again, I'd like to request that we avoid macros, as I don't think
>>> they are strictly required.
>>
>> Yeah I agree. I did them this way, because they already existed and I was just
>> moving them from the header to here. But I'll change to static inline.
>>
>>>
>>>> +bool hugepage_flags_enabled(void)
>>>>    {
>>>> +    /*
>>>> +     * We cover both the anon and the file-backed case here; we must return
>>>> +     * true if globally enabled, even when all anon sizes are set to never.
>>>> +     * So we don't need to look at huge_anon_orders_global.
>>>> +     */
>>>> +    return hugepage_global_enabled() ||
>>>> +           huge_anon_orders_always ||
>>>> +           huge_anon_orders_madvise;
>>>> +}
>>>> +
>>>> +/**
>>>> + * hugepage_vma_check - determine which hugepage orders can be applied to vma
>>>> + * @vma:  the vm area to check
>>>> + * @vm_flags: use these vm_flags instead of vma->vm_flags
>>>> + * @smaps: whether answer will be used for smaps file
>>>> + * @in_pf: whether answer will be used by page fault handler
>>>> + * @enforce_sysfs: whether sysfs config should be taken into account
>>>> + * @orders: bitfield of all orders to consider
>>>> + *
>>>> + * Calculates the intersection of the requested hugepage orders and the
>>>> allowed
>>>> + * hugepage orders for the provided vma. Permitted orders are encoded as a set
>>>> + * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
>>>> + * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
>>>> + *
>>>> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no
>>>> hugepage
>>>> + * orders are allowed.
>>>> + */
>>>> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
>>>> +                 unsigned long vm_flags, bool smaps, bool in_pf,
>>>> +                 bool enforce_sysfs, unsigned long orders)
>>>
>>> Here again, a bool return type has been changed to a bitfield. Let's
>>> also update the function name. Maybe one of these:
>>>
>>>          hugepage_vma_orders()
>>>          hugepage_vma_allowable_orders()
>>
>> thp_vma_allowable_orders()?
>>
> 
> Even better, yes.

Great thanks for the review! I'll get all these changes folded in and if I don't
get any further feedback by the end of the week, I'll repost on Monday.

> 
> 
> thanks,

