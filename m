Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDED7D6006
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjJYCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYCnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:43:15 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA6129
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 19:43:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vusq8o5_1698201785;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vusq8o5_1698201785)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 10:43:06 +0800
Message-ID: <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 10:43:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Alistair Popple <apopple@nvidia.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal>
 <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87ttqfqw8f.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 9:58 AM, Alistair Popple wrote:
> 
> Barry Song <21cnbao@gmail.com> writes:
> 
>> On Wed, Oct 25, 2023 at 9:18 AM Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>>
>>> Barry Song <21cnbao@gmail.com> writes:
>>>
>>>> On Wed, Oct 25, 2023 at 7:16 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>
>>>>> On Tue, Oct 24, 2023 at 8:57 PM Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
> 
> [...]
> 
>>>>> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
>>>>> page,  B might
>>>>> be a correct choice.
>>>>
>>>> Plus, I doubt B is really going to happen. as after a page is promoted to
>>>> the head of lru list or new generation, it needs a long time to slide back
>>>> to the inactive list tail or to the candidate generation of mglru. the time
>>>> should have been large enough for tlb to be flushed. If the page is really
>>>> hot, the hardware will get second, third, fourth etc opportunity to set an
>>>> access flag in the long time in which the page is re-moved to the tail
>>>> as the page can be accessed multiple times if it is really hot.
>>>
>>> This might not be true if you have external hardware sharing the page
>>> tables with software through either HMM or hardware supported ATS
>>> though.
>>>
>>> In those cases I think it's much more likely hardware can still be
>>> accessing the page even after a context switch on the CPU say. So those
>>> pages will tend to get reclaimed even though hardware is still actively
>>> using them which would be quite expensive and I guess could lead to
>>> thrashing as each page is reclaimed and then immediately faulted back
>>> in.

That's possible, but the chance should be relatively low. At least on 
x86, I have not heard of this issue.

>> i am not quite sure i got your point. has the external hardware sharing cpu's
>> pagetable the ability to set access flag in page table entries by
>> itself? if yes,
>> I don't see how our approach will hurt as folio_referenced can notify the
>> hardware driver and the driver can flush its own tlb. If no, i don't see
>> either as the external hardware can't set access flags, that means we
>> have ignored its reference and only knows cpu's access even in the current
>> mainline code. so we are not getting worse.
>>
>> so the external hardware can also see cpu's TLB? or cpu's tlb flush can
>> also broadcast to external hardware, then external hardware sees the
>> cleared access flag, thus, it can set access flag in page table when the
>> hardware access it?  If this is the case, I feel what you said is true.
> 
> Perhaps it would help if I gave a concrete example. Take for example the
> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one of
> two ways depending on the specific HW implementation.
> 
> If broadcast TLB maintenance (BTM) is supported it will snoop CPU TLB
> invalidations. If BTM is not supported it relies on SW to explicitly
> forward TLB invalidations via MMU notifiers.

On our ARM64 hardware, we rely on BTM to maintain TLB coherency.

> Now consider the case where some external device is accessing mappings
> via the SMMU. The access flag will be cached in the SMMU TLB. If we
> clear the access flag without a TLB invalidate the access flag in the
> CPU page table will not get updated because it's already set in the SMMU
> TLB.
> 
> As an aside access flag updates happen in one of two ways. If the SMMU
> HW supports hardware translation table updates (HTTU) then hardware will
> manage updating access/dirty flags as required. If this is not supported
> then SW is relied on to update these flags which in practice means
> taking a minor fault. But I don't think that is relevant here - in
> either case without a TLB invalidate neither of those things will
> happen.
> 
> I suppose drivers could implement the clear_flush_young() MMU notifier
> callback (none do at the moment AFAICT) but then won't that just lead to
> the opposite problem - that every page ever used by an external device
> remains active and unavailable for reclaim because the access flag never
> gets cleared? I suppose they could do the flush then which would ensure

Yes, I think so too. The reason there is currently no problem, perhaps I 
think, there are no actual use cases at the moment? At least on our 
Alibaba's fleet, SMMU and MMU do not share page tables now.

> the page is marked inactive if it's not referenced between the two
> folio_referenced calls().
> 
> But that requires changes to those drivers. SMMU from memory doesn't
> even register for notifiers if BTM is supported.
> 
>   - Alistair
> 
>>>
>>> Of course TLB flushes are equally (perhaps even more) expensive for this
>>> kind of external HW so reducing them would still be beneficial. I wonder
>>> if there's some way they could be deferred until the page is moved to
>>> the inactive list say?
>>>
>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.com/
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>>   arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++---------------
>>>>>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>>>> index 0bd18de9fd97..2979d796ba9d 100644
>>>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>>>> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>>>>   static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>>>                                           unsigned long address, pte_t *ptep)
>>>>>>   {
>>>>>> -       int young = ptep_test_and_clear_young(vma, address, ptep);
>>>>>> -
>>>>>> -       if (young) {
>>>>>> -               /*
>>>>>> -                * We can elide the trailing DSB here since the worst that can
>>>>>> -                * happen is that a CPU continues to use the young entry in its
>>>>>> -                * TLB and we mistakenly reclaim the associated page. The
>>>>>> -                * window for such an event is bounded by the next
>>>>>> -                * context-switch, which provides a DSB to complete the TLB
>>>>>> -                * invalidation.
>>>>>> -                */
>>>>>> -               flush_tlb_page_nosync(vma, address);
>>>>>> -       }
>>>>>> -
>>>>>> -       return young;
>>>>>> +       /*
>>>>>> +        * This comment is borrowed from x86, but applies equally to ARM64:
>>>>>> +        *
>>>>>> +        * Clearing the accessed bit without a TLB flush doesn't cause
>>>>>> +        * data corruption. [ It could cause incorrect page aging and
>>>>>> +        * the (mistaken) reclaim of hot pages, but the chance of that
>>>>>> +        * should be relatively low. ]
>>>>>> +        *
>>>>>> +        * So as a performance optimization don't flush the TLB when
>>>>>> +        * clearing the accessed bit, it will eventually be flushed by
>>>>>> +        * a context switch or a VM operation anyway. [ In the rare
>>>>>> +        * event of it not getting flushed for a long time the delay
>>>>>> +        * shouldn't really matter because there's no real memory
>>>>>> +        * pressure for swapout to react to. ]
>>>>>> +        */
>>>>>> +       return ptep_test_and_clear_young(vma, address, ptep);
>>>>>>   }
>>>>>>
>>>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>> --
>>>>>> 2.39.3
>>>>>>
>>>>>
>>>>> Thanks
>>>>> Barry
>>>
>> Thanks
>> Barry
