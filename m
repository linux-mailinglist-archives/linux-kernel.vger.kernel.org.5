Return-Path: <linux-kernel+bounces-61684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC72851558
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298231C2084B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B9446C5;
	Mon, 12 Feb 2024 13:27:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6ED3B194
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744429; cv=none; b=R7EBLqPFwoWw4v6bsxYNgsI9uX/psqgFse/JoVJEotVNxyGncMosuTvrM7Ri9XDHH39ZguD2jr5L4KNdNdpM8os2moM+lA9ladkhFhdhgjzp4XSLNn9nE3xzmk/7pZFz0+HG3H0vmMkPK3XKyUmJPlblq8e2mQyCJ60aWH4QqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744429; c=relaxed/simple;
	bh=b9bJMcwC+cn00rgdnKEXAAs3PpIJ9WUsM3I1xGcJypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfat0lpb/rQpsFNIrfIhtz+npcX/ADm6f9tBpld9CqKc4mkpSKms4GlNqqUB4Oi0MNoUNB0iw4Qmqzxs6gb+sl+NuEfi7Lq02ff+FMQnoOn+GqA2EouFQpZV2wdQ1ozZ8Yui8Cb5KJe8V02Ur+W0eB3vG4lGCAj1oHgvtT7E3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3AF9DA7;
	Mon, 12 Feb 2024 05:27:47 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009623F7BD;
	Mon, 12 Feb 2024 05:27:01 -0800 (PST)
Message-ID: <e19ba38c-8935-47be-be2a-1920b09034c8@arm.com>
Date: Mon, 12 Feb 2024 13:27:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/25] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-19-ryan.roberts@arm.com>
 <9e1d793a-02c9-4dbb-a6d4-1e1c0c42638c@redhat.com>
 <1ef4c737-0926-424c-9698-794c23370b74@arm.com>
 <608feac1-8cd6-48c2-87ab-688fb9c0bda4@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <608feac1-8cd6-48c2-87ab-688fb9c0bda4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 13:15, David Hildenbrand wrote:
> On 12.02.24 14:05, Ryan Roberts wrote:
>> On 12/02/2024 12:44, David Hildenbrand wrote:
>>> On 02.02.24 09:07, Ryan Roberts wrote:
>>>> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
>>>> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
>>>> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
>>>> trailing DSB. Forthcoming "contpte" code will take advantage of this
>>>> when clearing the young bit from a contiguous range of ptes.
>>>>
>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/tlbflush.h
>>>> b/arch/arm64/include/asm/tlbflush.h
>>>> index 79e932a1bdf8..50a765917327 100644
>>>> --- a/arch/arm64/include/asm/tlbflush.h
>>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>>> @@ -422,7 +422,7 @@ do {                                    \
>>>>    #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>>>>        __flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false,
>>>> kvm_lpa2_is_enabled());
>>>>    -static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>>>>                         unsigned long start, unsigned long end,
>>>>                         unsigned long stride, bool last_level,
>>>>                         int tlb_level)
>>>> @@ -456,10 +456,19 @@ static inline void __flush_tlb_range(struct
>>>> vm_area_struct *vma,
>>>>            __flush_tlb_range_op(vae1is, start, pages, stride, asid,
>>>>                         tlb_level, true, lpa2_is_enabled());
>>>>    -    dsb(ish);
>>>>        mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>>>>    }
>>>>    +static inline void __flush_tlb_range(struct vm_area_struct *vma,
>>>> +                     unsigned long start, unsigned long end,
>>>> +                     unsigned long stride, bool last_level,
>>>> +                     int tlb_level)
>>>> +{
>>>> +    __flush_tlb_range_nosync(vma, start, end, stride,
>>>> +                 last_level, tlb_level);
>>>> +    dsb(ish);
>>>> +}
>>>> +
>>>>    static inline void flush_tlb_range(struct vm_area_struct *vma,
>>>>                       unsigned long start, unsigned long end)
>>>>    {
>>>
>>> You're now calling dsb() after mmu_notifier_arch_invalidate_secondary_tlbs().
>>>
>>>
>>> In flush_tlb_mm(), we have the order
>>>
>>>      dsb(ish);
>>>      mmu_notifier_arch_invalidate_secondary_tlbs()
>>>
>>> In flush_tlb_page(), we have the effective order:
>>>
>>>      mmu_notifier_arch_invalidate_secondary_tlbs()
>>>      dsb(ish);
>>>
>>> In flush_tlb_range(), we used to have the order:
>>>
>>>      dsb(ish);
>>>      mmu_notifier_arch_invalidate_secondary_tlbs();
>>>
>>>
>>> So I *suspect* having that DSB before
>>> mmu_notifier_arch_invalidate_secondary_tlbs() is fine. Hopefully, nothing in
>>> there relies on that placement.
>>
>> Will spotted this against v3. My argument was that I was following the existing
>> pattern in flush_tlb_page(). Apparently that is not correct and needs changing,
>> but the conclusion was to leave my change as is for now, since it is consistent
>> and change them at a later date together.
> 
> Good, I think you should add a few words to the patch description ("ordering
> might be incorrect, but is in-line with __flush_tlb_page()"; will be resolved
> separately).
> 

ACK, will do. Thanks!


