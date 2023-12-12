Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616F480EAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjLLLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:47:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9167EA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:47:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61161143D;
        Tue, 12 Dec 2023 03:47:54 -0800 (PST)
Received: from [10.1.39.183] (XHFQ2J9959.cambridge.arm.com [10.1.39.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B122A3F762;
        Tue, 12 Dec 2023 03:47:04 -0800 (PST)
Message-ID: <0969c413-bf40-4c46-9f1e-a92101ff2d2e@arm.com>
Date:   Tue, 12 Dec 2023 11:47:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
To:     Will Deacon <will@kernel.org>
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
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231212113517.GA28857@willie-the-truck>
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

On 12/12/2023 11:35, Will Deacon wrote:
> On Mon, Dec 04, 2023 at 10:54:37AM +0000, Ryan Roberts wrote:
>> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
>> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
>> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
>> trailing DSB. Forthcoming "contpte" code will take advantage of this
>> when clearing the young bit from a contiguous range of ptes.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index bb2c2833a987..925ef3bdf9ed 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -399,7 +399,7 @@ do {									\
>>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
>>  
>> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
>> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>>  				     unsigned long start, unsigned long end,
>>  				     unsigned long stride, bool last_level,
>>  				     int tlb_level)
>> @@ -431,10 +431,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>  	else
>>  		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
>>  
>> -	dsb(ish);
>>  	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>>  }
>>  
>> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
>> +				     unsigned long start, unsigned long end,
>> +				     unsigned long stride, bool last_level,
>> +				     int tlb_level)
>> +{
>> +	__flush_tlb_range_nosync(vma, start, end, stride,
>> +				 last_level, tlb_level);
>> +	dsb(ish);
>> +}
> 
> Hmm, are you sure it's safe to defer the DSB until after the secondary TLB
> invalidation? It will have a subtle effect on e.g. an SMMU participating
> in broadcast TLB maintenance, because now the ATC will be invalidated
> before completion of the TLB invalidation and it's not obviously safe to me.

I'll be honest; I don't know that it's safe. The notifier calls turned up during
a rebase and I stared at it for a while, before eventually concluding that I
should just follow the existing pattern in __flush_tlb_page_nosync(): That one
calls the mmu notifier without the dsb, then flush_tlb_page() does the dsb
after. So I assumed it was safe.

If you think it's not safe, I guess there is a bug to fix in
__flush_tlb_page_nosync()?



> 
> Will

