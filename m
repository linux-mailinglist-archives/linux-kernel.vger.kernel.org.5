Return-Path: <linux-kernel+bounces-122595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D617688FA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91738294701
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6369F44C67;
	Thu, 28 Mar 2024 08:45:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF24E1C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615522; cv=none; b=Z+oidHmXJc4ZxFk3QaUj41Tf2dDtgBtecScum8cnHeiSn/5wG8eG8/JFgEfylOjcnfL0gEZ/DrBX1TS2Mjlpu8M8CaFZqiQxorOG+PxS9yY9aVEQJKt3cYocr9Q/mro5gFmXCqnOGv0OoU4mVykS7x2RoOfSwq7Oy+ibfbPAiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615522; c=relaxed/simple;
	bh=Y5Xd8Q2+cKEbaBnX1DP+dwC6AhteJyqc2e+mytwPLN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS5jTl0hH8RThgPhw4BWM60Ll7Bmzs0PiR+sjlwpzpGmb939OwcrEqvkVPU2Lk35j0d4aun4JJ52Z+IMW8SrNiighTjRbgxRjbTzc6eli1Sm+fBBPYNbvbWexVuUYjI8d7wOs2xMDS2VgsjLYPTTWiAAcEbkjRN1AqrqDTOnOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36612F4;
	Thu, 28 Mar 2024 01:45:52 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA03A3F64C;
	Thu, 28 Mar 2024 01:45:16 -0700 (PDT)
Message-ID: <a6da59d1-28b5-4cc0-aae9-fca1286be577@arm.com>
Date: Thu, 28 Mar 2024 08:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: mm: Batch dsb and isb when populating pgtables
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <20240327190723.185232-1-ryan.roberts@arm.com>
 <CAMj1kXF68MH0HUH8FHpHAoSs_tPbMGek5mY2U4BL-i_RWoZ+5Q@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXF68MH0HUH8FHpHAoSs_tPbMGek5mY2U4BL-i_RWoZ+5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 07:23, Ard Biesheuvel wrote:
> On Wed, 27 Mar 2024 at 21:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> After removing uneccessary TLBIs, the next bottleneck when creating the
>> page tables for the linear map is DSB and ISB, which were previously
>> issued per-pte in __set_pte(). Since we are writing multiple ptes in a
>> given pte table, we can elide these barriers and insert them once we
>> have finished writing to the table.
>>
> 
> Nice!
> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h |  7 ++++++-
>>  arch/arm64/mm/mmu.c              | 13 ++++++++++++-
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index bd5d02f3f0a3..81e427b23b3f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>>         return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>>  }
>>
>> -static inline void __set_pte(pte_t *ptep, pte_t pte)
>> +static inline void ___set_pte(pte_t *ptep, pte_t pte)
> 
> IMHO, we should either use WRITE_ONCE() directly in the caller, or
> find a better name.

How about __set_pte_nosync() ?

> 
>>  {
>>         WRITE_ONCE(*ptep, pte);
>> +}
>> +
>> +static inline void __set_pte(pte_t *ptep, pte_t pte)
>> +{
>> +       ___set_pte(ptep, pte);
>>
>>         /*
>>          * Only if the new pte is valid and kernel, otherwise TLB maintenance
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 1b2a2a2d09b7..c6d5a76732d4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -301,7 +301,11 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>         do {
>>                 pte_t old_pte = __ptep_get(ptep);
>>
>> -               __set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>> +               /*
>> +                * Required barriers to make this visible to the table walker
>> +                * are deferred to the end of alloc_init_cont_pte().
>> +                */
>> +               ___set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>>
>>                 /*
>>                  * After the PTE entry has been populated once, we
>> @@ -358,6 +362,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>         } while (addr = next, addr != end);
>>
>>         ops->unmap(TYPE_PTE);
>> +
>> +       /*
>> +        * Ensure all previous pgtable writes are visible to the table walker.
>> +        * See init_pte().
>> +        */
>> +       dsb(ishst);
>> +       isb();
>>  }
>>
>>  static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> --
>> 2.25.1
>>


