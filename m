Return-Path: <linux-kernel+bounces-158391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53A8B1F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53889281BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CF8664A;
	Thu, 25 Apr 2024 10:29:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F87FBA3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040952; cv=none; b=WnkJpnzMl0XfWndAhgwWZWmb1Uj9n3diZbCBKgsicFyIApotjounAxh/nMxjeuTut65jpCtQQhr8R82s5yRHrNVHR9qTKZcn3QR1dryRt/Cc0jvwESUs4NVAyeEj/vVXznKnrbEeEp5/9Ys6tAUmJABjOtzzoodFMSreN7U+HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040952; c=relaxed/simple;
	bh=qTTJhY7w7vwBXRMOJaRxHFumyZW5E0/9bIl014rfNoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+PyPosA+0LEAuwFXVrjeeVHSK941tKu8i92Ibe9P0TKRQbxj3BwpkP3tMGng0aga8KPW7Zy4Fu0/Se8tq+R1RsMAvASwxwCH72EPbjgDK5goPMMcYN/ezvVr6Jvn9QLKa21AfiQlxWMiR8JfRHuGkWcbA3ug6dRX/CT7a+Q6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7034D1007;
	Thu, 25 Apr 2024 03:29:38 -0700 (PDT)
Received: from [10.1.27.187] (unknown [10.1.27.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CADCD3F64C;
	Thu, 25 Apr 2024 03:29:08 -0700 (PDT)
Message-ID: <df0475e1-9078-4629-b23d-0919ab1e37c2@arm.com>
Date: Thu, 25 Apr 2024 11:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
 <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/04/2024 10:16, David Hildenbrand wrote:
> On 24.04.24 13:10, Ryan Roberts wrote:
>> Previously PTE_PROT_NONE was occupying bit 58, one of the bits reserved
>> for SW use when the PTE is valid. This is a waste of those precious SW
>> bits since PTE_PROT_NONE can only ever be set when valid is clear.
>> Instead let's overlay it on what would be a HW bit if valid was set.
>>
>> We need to be careful about which HW bit to choose since some of them
>> must be preserved; when pte_present() is true (as it is for a
>> PTE_PROT_NONE pte), it is legitimate for the core to call various
>> accessors, e.g. pte_dirty(), pte_write() etc. There are also some
>> accessors that are private to the arch which must continue to be
>> honoured, e.g. pte_user(), pte_user_exec() etc.
>>
>> So we choose to overlay PTE_UXN; This effectively means that whenever a
>> pte has PTE_PROT_NONE set, it will always report pte_user_exec() ==
>> false, which is obviously always correct.
>>
>> As a result of this change, we must shuffle the layout of the
>> arch-specific swap pte so that PTE_PROT_NONE is always zero and not
>> overlapping with any other field. As a result of this, there is no way
>> to keep the `type` field contiguous without conflicting with
>> PMD_PRESENT_INVALID (bit 59), which must also be 0 for a swap pte. So
>> let's move PMD_PRESENT_INVALID to bit 60.
> 
> A note that some archs split/re-combine type and/or offset, to make use of every
> bit possible :) But that's mostly relevant for 32bit.
> 
> (and as long as PFNs can still fit into the swp offset for migration entries etc.)

Yeah, I considered splitting the type or offset field to avoid moving
PMD_PRESENT_INVALID, but thought it was better to avoid the extra mask and shift.

> 
>>
>> In the end, this frees up bit 58 for future use as a proper SW bit (e.g.
>> soft-dirty or uffd-wp).
> 
> I was briefly confused about how you would use these bits as SW bits for swap
> PTEs (which you can't as they overlay the type). See below regarding bit 3.
> 
> I would have said here "proper SW bit for present PTEs".

Yes; I'll clarify in the next version.

> 
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable-prot.h |  4 ++--
>>   arch/arm64/include/asm/pgtable.h      | 16 +++++++++-------
>>   2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h
>> b/arch/arm64/include/asm/pgtable-prot.h
>> index dd9ee67d1d87..ef952d69fd04 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -18,14 +18,14 @@
>>   #define PTE_DIRTY        (_AT(pteval_t, 1) << 55)
>>   #define PTE_SPECIAL        (_AT(pteval_t, 1) << 56)
>>   #define PTE_DEVMAP        (_AT(pteval_t, 1) << 57)
>> -#define PTE_PROT_NONE        (_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>> +#define PTE_PROT_NONE        (PTE_UXN)         /* Reuse PTE_UXN; only when
>> !PTE_VALID */
>>     /*
>>    * This bit indicates that the entry is present i.e. pmd_page()
>>    * still points to a valid huge page in memory even if the pmd
>>    * has been invalidated.
>>    */
>> -#define PMD_PRESENT_INVALID    (_AT(pteval_t, 1) << 59) /* only when
>> !PMD_SECT_VALID */
>> +#define PMD_PRESENT_INVALID    (_AT(pteval_t, 1) << 60) /* only when
>> !PMD_SECT_VALID */
>>     #define _PROT_DEFAULT        (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>>   #define _PROT_SECT_DEFAULT    (PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index afdd56d26ad7..23aabff4fa6f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1248,20 +1248,22 @@ static inline pmd_t pmdp_establish(struct
>> vm_area_struct *vma,
>>    * Encode and decode a swap entry:
>>    *    bits 0-1:    present (must be zero)
>>    *    bits 2:        remember PG_anon_exclusive
>> - *    bits 3-7:    swap type
>> - *    bits 8-57:    swap offset
>> - *    bit  58:    PTE_PROT_NONE (must be zero)
> 
> Reading this patch alone: what happened to bit 3? Please mention that that it
> will be used as a swap pte metadata bit (uffd-wp).

Will do. It's all a bit arbitrary though. I could have put offset in 3-52, and
then 53 would have been spare for uffd-wp. I'm not sure there is any advantage
to either option.

> 
>> + *    bits 4-53:    swap offset
> 
> So we'll still have 50bit for the offset, good. We could even use 61-63 if ever
> required to store bigger PFNs.

yep, or more sw bits.

> 
> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!



