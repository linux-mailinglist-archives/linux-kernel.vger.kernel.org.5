Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D281302C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573062AbjLNMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573099AbjLNMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:30:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB3C12B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:31:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E66C15;
        Thu, 14 Dec 2023 04:31:48 -0800 (PST)
Received: from [10.57.86.13] (unknown [10.57.86.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BF53F738;
        Thu, 14 Dec 2023 04:30:58 -0800 (PST)
Message-ID: <fbcda9e1-0473-4669-a869-d4de351c3197@arm.com>
Date:   Thu, 14 Dec 2023 12:30:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
        jean-philippe@linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-13-ryan.roberts@arm.com>
 <20231212113517.GA28857@willie-the-truck>
 <0969c413-bf40-4c46-9f1e-a92101ff2d2e@arm.com>
 <2e6f06d3-6c8e-4b44-b6f2-e55bd5be83d6@arm.com>
 <20231214121336.GA1015@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231214121336.GA1015@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-14 12:13 pm, Will Deacon wrote:
> On Thu, Dec 14, 2023 at 11:53:52AM +0000, Ryan Roberts wrote:
>> On 12/12/2023 11:47, Ryan Roberts wrote:
>>> On 12/12/2023 11:35, Will Deacon wrote:
>>>> On Mon, Dec 04, 2023 at 10:54:37AM +0000, Ryan Roberts wrote:
>>>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>>>> index bb2c2833a987..925ef3bdf9ed 100644
>>>>> --- a/arch/arm64/include/asm/tlbflush.h
>>>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>>>> @@ -399,7 +399,7 @@ do {									\
>>>>>   #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>>>>>   	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
>>>>>   
>>>>> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>>> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>>>>>   				     unsigned long start, unsigned long end,
>>>>>   				     unsigned long stride, bool last_level,
>>>>>   				     int tlb_level)
>>>>> @@ -431,10 +431,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>>>   	else
>>>>>   		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
>>>>>   
>>>>> -	dsb(ish);
>>>>>   	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>>>>>   }
>>>>>   
>>>>> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>>> +				     unsigned long start, unsigned long end,
>>>>> +				     unsigned long stride, bool last_level,
>>>>> +				     int tlb_level)
>>>>> +{
>>>>> +	__flush_tlb_range_nosync(vma, start, end, stride,
>>>>> +				 last_level, tlb_level);
>>>>> +	dsb(ish);
>>>>> +}
>>>>
>>>> Hmm, are you sure it's safe to defer the DSB until after the secondary TLB
>>>> invalidation? It will have a subtle effect on e.g. an SMMU participating
>>>> in broadcast TLB maintenance, because now the ATC will be invalidated
>>>> before completion of the TLB invalidation and it's not obviously safe to me.
>>>
>>> I'll be honest; I don't know that it's safe. The notifier calls turned up during
>>> a rebase and I stared at it for a while, before eventually concluding that I
>>> should just follow the existing pattern in __flush_tlb_page_nosync(): That one
>>> calls the mmu notifier without the dsb, then flush_tlb_page() does the dsb
>>> after. So I assumed it was safe.
>>>
>>> If you think it's not safe, I guess there is a bug to fix in
>>> __flush_tlb_page_nosync()?
>>
>> Did you have an opinion on this? I'm just putting together a v4 of this series,
>> and I'll remove this optimization if you think it's unsound. But in that case, I
>> guess we have an existing bug to fix too?
> 
> Sorry, Ryan, I've not had a chance to look into it in more detail. But as
> you rightly point out, you're not introducing the issue (assuming it is
> one), so I don't think it needs to hold you up. Your code just makes the
> thing more "obvious" to me.
> 
> Robin, Jean-Philippe -- do we need to make sure that the SMMU has completed
> its TLB invalidation before issuing an ATC invalidate? My half-baked worry
> is whether or not an ATS request could refill the ATC before the TLBI
> has completed, therefore rendering the ATC invalidation useless.

I would agree, and the spec for CMD_ATC_INV does call out a 
TLBI->sync->ATCI->sync sequence. At the moment the SVA notifier is 
issuing its own command-based TLBIs anyway so the necessary sync is 
implicit there, but if and when we get BTM support wired up properly it 
would be nice not to have to bodge in an additional sync/DSB.

Cheers,
Robin.
