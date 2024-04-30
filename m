Return-Path: <linux-kernel+bounces-164293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C38B7BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FA1286C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D5143759;
	Tue, 30 Apr 2024 15:39:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162C770F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491573; cv=none; b=FG7WR7vxAIKBpkNGkybpt+eZKoHESVYJdpcWih/8mPBmUq0dS2oXs079MEkIHA3be7LiuPWSsFOmkiAEi/mo4zW4ihyINliDtqO3siC7ju49ICKFQDgUiZqfgwfU5fWXEZnsL7S+aQXyxmsqAqPUyVsD5SGCQIZNyy4HSl0XP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491573; c=relaxed/simple;
	bh=L15iQtDesWFaGQwpEEUCt+iitso/G50vY9MhY0Vsyh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYNAKkIzDEv+rrAgAOVC72saR5f4BMJ9MaIK9USoJYkZYt8tgBR1kk1epV89z1IRBd5gKLAlyuq2Fx+EMixw2G4jAUMnokcBt3+/Rg5zmxl43xhHEmWWerm/BBlTkPj5uxsPLsGl0s4huH+8wz/Pgp0WTwLkuSsszZzW6D4t+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466E1339;
	Tue, 30 Apr 2024 08:39:57 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE593F793;
	Tue, 30 Apr 2024 08:39:29 -0700 (PDT)
Message-ID: <e51216b3-d55e-481a-8a63-6c4aeb11a315@arm.com>
Date: Tue, 30 Apr 2024 16:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly
 <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
 <20240430133037.GA13848@willie-the-truck>
 <96fc0d1a-0c5f-4ca3-ad99-a64346990536@arm.com>
 <20240430150453.GA14187@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430150453.GA14187@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 16:04, Will Deacon wrote:
> On Tue, Apr 30, 2024 at 03:02:21PM +0100, Ryan Roberts wrote:
>> On 30/04/2024 14:30, Will Deacon wrote:
>>> On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
>>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>>>> index dd9ee67d1d87..de62e6881154 100644
>>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>>> @@ -18,14 +18,7 @@
>>>>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>>>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>>> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>>> -
>>>> -/*
>>>> - * This bit indicates that the entry is present i.e. pmd_page()
>>>> - * still points to a valid huge page in memory even if the pmd
>>>> - * has been invalidated.
>>>> - */
>>>> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>>>> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
>>>
>>> So this now overlaps with AttrIndx[3] if FEAT_AIE is implemented. Although
>>> this shouldn't matter on the face of things because it's only used for
>>> invalid entries, we originally moved the PROT_NONE bit from 2 to 57 back
>>> in 3676f9ef5481 ("arm64: Move PTE_PROT_NONE higher up") because it was
>>> possible to change the memory type for PROT_NONE mappings via some
>>> drivers.
>>
>> I'm not sure I follow your argument.
>>
>>  1. We don't support FEAT_AIE (currently) so AttrIndx[3] is always going to be 0
>> for valid ptes. Drivers are only calling our helpers (e.g.
>> pgprot_writecombine(), right?) and those only know how to set AttrIndx[2:0].
> 
> Sure, but we might want to use it in future and chucking that out for the
> sake of uffd doesn't seem like an obviously worthwhile trade-off to me.

Totally agree, which is why I move it in the next patch. I was just commenting
that its not a problem for this intermediate state between patches because the
kernel doesn't support FEAT_AIE today.

> 
>>  2. PMD_PRESENT_INVALID was already occupying bit 59. So wouldn't the same shape
>> of concern apply there too for PMDs that have been invalidated, where the driver
>> then comes along and changes the memory type? (Perhaps because
>> PMD_PRESENT_INVALID is only set while the PTL is held this can't happen).
> 
> I was mainly thinking of the PROT_NONE case, to be honest with you. I
> struggle to envisage how a driver could sensibly mess with the memory
> type for anonymous mappings, let alone huge pages! But perhaps I just
> lack imagination :)
> 
>>  3. I had this same vague concern about confusion due to overlapping bit 59,
>> which is why in the next patch, I'm moving it to the NS bit.
>>
>> Experience tells me that when I'm arguing confidently with someone who is much
>> more expert than me, then I'm using wrong... so what have I missed? :)

Sorry that was meant to say "I'm *usually* wrong" in case it wasn't obvious.

>>
>>>
>>> Moving the field to the NS bit (as you do later in the series) resolves
>>> this, but the architecture currently says that the NS bit is RES0. How
>>> can we guarantee that it won't be repurposed by hardware in future?
>>
>> Well it remains free for use in valid entries of course.
> 
> I think that's what I'm actually questioning! 

Sorry I'm not sure if we are talking cross-purposes... PTE_INVALID is only
overlayed on the NS bit when PTE_VALID=0. So the NS bit remains 0 for valid PTEs
today, and in future, any new feature control within the bit could be set as
required for valid ptes.

But I *think* you are concerned about the possibility that any future feature
control that occupies that bit could also require persisting in pte/pmd even
when its invalidated (i.e. pmd_mkinvalid(pmd) or pte_modify(pte, PAGE_NONE))?

> RES0 doesn't mean that
> tomorrow's whizz-bang CPU extension isn't allowed to use it, but that's
> a guarantee that we need if we're going to use it for our own purposes.
> 
>> So I guess you are asking how to guarantee we won't also need to be able
>> to modify it on the fly for PROT_NONE entries? I don't have a definite
>> answer, but I've been working on the assumption that the architecture
>> introducing a feature that is only needed in states where NS is not needed
>> is unlikely (so using that bit for the feature is also unlikely). And then
>> needing to manipulate that feature dyanically for PROT_NONE mappings is
>> even less likely.
> 
> The architects are quite good at inventing unlikely features :) SVE
> blowing the sigcontext comes to mind. I think we should seek
> clarification that the NS bit won't be allocated in the future if we are
> going to use it for our own stuff.

OK, clarification sought; the architects are *not* willing to upgrade the res0
to "IGNORED"...

> 
>> If all else fails we could move it to nG (bit 11) to free up bit 5. But that
>> requires a bit more fiddling with the swap pte format.
> 
> Oh, cunning, I hadn't thought of that. I think that's probably a better
> approach if the NS bit isn't guaranteed to be left alone by the
> architecture.

..So I'll change patch 2 to move the bit to nG (bit 11). Does that work for
you? I *think* an alternative could be the contig bit. But nG feels safest to me
- I'd have to think a lot harder about contig bit.

> 
>>>> @@ -469,7 +477,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>>>   */
>>>>  static inline int pte_protnone(pte_t pte)
>>>>  {
>>>> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
>>>> +	return pte_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
>>>>  }
>>>
>>> Why do we need to check pte_user_*() here? Isn't PROT_NONE the only case
>>> in which a pte will have PTE_INVALID set?
>>
>> I guess for *ptes* this is technically correct. But I was trying to make the
>> format generic and reusable for *pmds* too. (pmd_protnone() wraps
>> pte_protnone()). For pmds, PTE_INVALID also represents invalid-but-present PMDs
>> (i.e. pmds on which pmd_mkinvalid() has been called).
>>
>> The intention is that PTE_INVALID indicates "present but not valid in HW". And
>> (!pte_user(pte) && !pte_user_exec(pte)) indicates the PROT_NONE permission.
> 
> Ok, but it does mean the compiler can't emit a nice TBNZ instruction for
> the pte macro. Can you either seperate out the pmd/pte versions of the
> macro or just add a comment along the lines of what you said above, please?

I'll add a comment; I'd rather not have the implementations diverge unless there
is a clear performance advantage.

Thanks for the review!

> 
> Cheers,
> 
> Will


