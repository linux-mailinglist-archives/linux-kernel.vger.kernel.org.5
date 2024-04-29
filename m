Return-Path: <linux-kernel+bounces-162313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2838B59BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82F8B2338E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49387E0F6;
	Mon, 29 Apr 2024 13:02:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DC768EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395724; cv=none; b=hEqLpV4jeLifYWS4TRl+mKD4oPQ7gVHilUyetYy/rYXOJ5xD8V8rWz11vf9KUX+N44DbA3AR8qzOKNjZUZMRvGoxq8BBSkf0PtB1A6Wq53kTd1/KLq7ThIZzFmrg2LhVYc/6zHAItcp1vbYfQQaQW+BIjg2tN92sARR1BjxevAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395724; c=relaxed/simple;
	bh=9RweQkFjPTIyzYThCrvr3HO3NRl/CHRiMeAk6BYiStQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2vviQ5zbHlTc0V+SvN44qE5YdlgHrl4nOHskAffM8Tr3MPja6FxSl5IVXTVi7azdDl9CF6YUncpv2oE3L1vQm170WVp0KqNWty2HfyNWE6HEYOfVjZliHTTKYhti2+J2XQgjgW3ku73t5v018saKeCiEcboHhQQtHgOudy22Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED5442F4;
	Mon, 29 Apr 2024 06:02:22 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 949073F73F;
	Mon, 29 Apr 2024 06:01:54 -0700 (PDT)
Message-ID: <e946c510-9ba3-4d7b-9561-5ded86086df0@arm.com>
Date: Mon, 29 Apr 2024 14:01:53 +0100
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
 <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
 <df0475e1-9078-4629-b23d-0919ab1e37c2@arm.com>
 <eed172b5-c71a-469f-a790-76126760ca7c@arm.com> <Ziu-r2nkssCQ_uCS@arm.com>
 <f5de5685-d955-4aa0-a307-a4da927f36f0@arm.com> <Zi-UyS5IC_truh8M@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zi-UyS5IC_truh8M@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 13:38, Catalin Marinas wrote:
> On Mon, Apr 29, 2024 at 11:04:53AM +0100, Ryan Roberts wrote:
>> On 26/04/2024 15:48, Catalin Marinas wrote:
>>> On Thu, Apr 25, 2024 at 11:37:42AM +0100, Ryan Roberts wrote:
>>>> Also, IMHO we shouldn't really need to reserve PMD_PRESENT_INVALID for swap
>>>> ptes; it would be cleaner to have one bit that defines "present" when valid is
>>>> clear (similar to PTE_PROT_NONE today) then another bit which is only defined
>>>> when "present && !valid" which tells us if this is PTE_PROT_NONE or
>>>> PMD_PRESENT_INVALID (I don't think you can ever have both at the same time?).
>>>
>>> I think this make sense, maybe rename the above to PTE_PRESENT_INVALID
>>> and use it for both ptes and pmds.
>>
>> Yep, sounds good. I've already got a patch to do this, but it's exposed a bug in
>> core-mm so will now fix that before I can validate my change. see
>> https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
>>
>> With this in place, I'm proposing to remove PTE_PROT_NONE entirely and instead
>> represent PROT_NONE as a present but invalid pte (PTE_VALID=0, PTE_INVALID=1)
>> with both PTE_WRITE=0 and PTE_RDONLY=0.
>>
>> While the HW would interpret PTE_WRITE=0/PTE_RDONLY=0 as "RW without dirty bit
>> modification", this is not a problem as the pte is invalid, so the HW doesn't
>> interpret it. And SW always uses the PTE_WRITE bit to interpret the writability
>> of the pte. So PTE_WRITE=0/PTE_RDONLY=0 was previously an unused combination
>> that we now repurpose for PROT_NONE.
> 
> Why not just keep the bits currently in PAGE_NONE (PTE_RDONLY would be
> set) and check PTE_USER|PTE_UXN == 0b01 which is a unique combination
> for PAGE_NONE (bar the kernel mappings).

Yes I guess that works. I personally prefer my proposal because it is more
intuitive; you have an R bit and a W bit, and you encode RO, WR, and NONE. But
if you think reusing the kernel mapping check (PTE_USER|PTE_UXN == 0b01) is
preferable, then I'll go with that.

> 
> For ptes, it doesn't matter, we can assume that PTE_PRESENT_INVALID
> means pte_protnone(). For pmds, however, we can end up with
> pmd_protnone(pmd_mkinvalid(pmd)) == true for any of the PAGE_*
> permissions encoded into a valid pmd. That's where a dedicated
> PTE_PROT_NONE bit helped.

Yes agreed.

> 
> Let's say a CPU starts splitting a pmd and does a pmdp_invalidate*()
> first to set PTE_PRESENT_INVALID. A different CPU gets a fault and since
> the pmd is present, it goes and checks pmd_protnone() which returns
> true, ending up on do_huge_pmd_numa_page() path. Maybe some locks help
> but it looks fragile to rely on them.
> 
> So I think for protnone we need to check some other bits (like USER and
> UXN) in addition to PTE_PRESENT_INVALID.

Yes 100% agree. But using PTE_WRITE|PTE_RDONLY==0b00 is just as valid for that
purpose, I think?

> 
>> This will subtly change behaviour in an edge case though. Imagine:
>>
>> pte_t pte;
>>
>> pte = pte_modify(pte, PAGE_NONE);
>> pte = pte_mkwrite_novma(pte);
>> WARN_ON(pte_protnone(pte));
>>
>> Should that warning fire or not? Previously, because we had a dedicated bit for
>> PTE_PROT_NONE it would fire. With my proposed change it will not fire. To me
>> it's more intuitive if it doesn't fire. Regardless there is no core code that
>> ever does this. Once you have a protnone pte, its terminal - nothing ever
>> modifies it with these helpers AFAICS.
> 
> I don't think any core code should try to make page a PAGE_NONE pte
> writeable.

I looked at some other arches; some (at least alpha and hexagon) will not fire
this warning because they have R and W bits and 0b00 means NONE. Others (x86)
will fire it because they have an explicit NONE bit and don't remove it on
permission change. So I conclude its UB and fine to do either.

> 
>> Personally I think this is a nice tidy up that saves a SW bit in both present
>> and swap ptes. What do you think? (I'll just post the series if its easier to
>> provide feedback in that context).
> 
> It would be nice to tidy this up and get rid of PTE_PROT_NONE as long as
> it doesn't affect the pmd case I mentioned above.
> 
>>>> But there is a problem with this: __split_huge_pmd_locked() calls
>>>> pmdp_invalidate() for a pmd before it determines that it is pmd_present(). So
>>>> the PMD_PRESENT_INVALID can be set in a swap pte today. That feels wrong to me,
>>>> but was trying to avoid the whole thing unravelling so didn't persue.
>>>
>>> Maybe what's wrong is the arm64 implementation setting this bit on a
>>> swap/migration pmd (though we could handle this in the core code as
>>> well, it depends what the other architectures do). The only check for
>>> the PMD_PRESENT_INVALID bit is in the arm64 code and it can be absorbed
>>> into the pmd_present() check. I think it is currently broken as
>>> pmd_present() can return true for a swap pmd after pmd_mkinvalid().
>>
>> I've posted a fix here:
>> https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/
>>
>> My position is that you shouldn't be calling pmd_mkinvalid() on a non-present pmd.
> 
> I agree, thanks.
> 


