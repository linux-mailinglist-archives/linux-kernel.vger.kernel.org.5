Return-Path: <linux-kernel+bounces-162017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391938B54B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31091F222C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536AF2E41C;
	Mon, 29 Apr 2024 10:05:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9072DF84
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385100; cv=none; b=gcKkN2gdRVFbKHlRG70oFh/JBmwblbN9E2Jt1Wh6YnrrNfpBjFh4S/iFHlVgohl+EFPf3zRLKhJlC5xGdtU9IiY4WesbTEyGJHgLwY1AED0BmhPSbhl4aSC0MD1vj4M458LxyrV9tz1HXyNCpRku1TjHDeWnytGVuqQZM+GMfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385100; c=relaxed/simple;
	bh=34WzQl9GT4Za2QymXSBmg6u6dOgh91fS2RdcnWcNQf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1cT4iRlrLdrt4mpPyFj1unimJikjWfNTgJTt1eMucoeaKMKLyM9pcpTMykZhLD3EuYYw10QfIxRlcrTF1tTsO80+q4ofxGXRHcFfSa91P0qtZPEnj84wJEYbcTXzsOugr5ctmP2uHD0Gbt2rZju2yRxxQQ6wdNZLhn9b5fCZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0BC02F4;
	Mon, 29 Apr 2024 03:05:23 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F073F793;
	Mon, 29 Apr 2024 03:04:55 -0700 (PDT)
Message-ID: <f5de5685-d955-4aa0-a307-a4da927f36f0@arm.com>
Date: Mon, 29 Apr 2024 11:04:53 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Ziu-r2nkssCQ_uCS@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/2024 15:48, Catalin Marinas wrote:
> On Thu, Apr 25, 2024 at 11:37:42AM +0100, Ryan Roberts wrote:
>> Also, IMHO we shouldn't really need to reserve PMD_PRESENT_INVALID for swap
>> ptes; it would be cleaner to have one bit that defines "present" when valid is
>> clear (similar to PTE_PROT_NONE today) then another bit which is only defined
>> when "present && !valid" which tells us if this is PTE_PROT_NONE or
>> PMD_PRESENT_INVALID (I don't think you can ever have both at the same time?).
> 
> I think this make sense, maybe rename the above to PTE_PRESENT_INVALID
> and use it for both ptes and pmds.

Yep, sounds good. I've already got a patch to do this, but it's exposed a bug in
core-mm so will now fix that before I can validate my change. see
https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/

With this in place, I'm proposing to remove PTE_PROT_NONE entirely and instead
represent PROT_NONE as a present but invalid pte (PTE_VALID=0, PTE_INVALID=1)
with both PTE_WRITE=0 and PTE_RDONLY=0.

While the HW would interpret PTE_WRITE=0/PTE_RDONLY=0 as "RW without dirty bit
modification", this is not a problem as the pte is invalid, so the HW doesn't
interpret it. And SW always uses the PTE_WRITE bit to interpret the writability
of the pte. So PTE_WRITE=0/PTE_RDONLY=0 was previously an unused combination
that we now repurpose for PROT_NONE.

This will subtly change behaviour in an edge case though. Imagine:

pte_t pte;

pte = pte_modify(pte, PAGE_NONE);
pte = pte_mkwrite_novma(pte);
WARN_ON(pte_protnone(pte));

Should that warning fire or not? Previously, because we had a dedicated bit for
PTE_PROT_NONE it would fire. With my proposed change it will not fire. To me
it's more intuitive if it doesn't fire. Regardless there is no core code that
ever does this. Once you have a protnone pte, its terminal - nothing ever
modifies it with these helpers AFAICS.

Personally I think this is a nice tidy up that saves a SW bit in both present
and swap ptes. What do you think? (I'll just post the series if its easier to
provide feedback in that context).

> 
>> But there is a problem with this: __split_huge_pmd_locked() calls
>> pmdp_invalidate() for a pmd before it determines that it is pmd_present(). So
>> the PMD_PRESENT_INVALID can be set in a swap pte today. That feels wrong to me,
>> but was trying to avoid the whole thing unravelling so didn't persue.
> 
> Maybe what's wrong is the arm64 implementation setting this bit on a
> swap/migration pmd (though we could handle this in the core code as
> well, it depends what the other architectures do). The only check for
> the PMD_PRESENT_INVALID bit is in the arm64 code and it can be absorbed
> into the pmd_present() check. I think it is currently broken as
> pmd_present() can return true for a swap pmd after pmd_mkinvalid().

I've posted a fix here:
https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/

My position is that you shouldn't be calling pmd_mkinvalid() on a non-present pmd.

> 
> So I don't think we lose anything if pmd_mkinvalid() skips any bit
> setting when !PTE_VALID. Maybe it even fixes some corner case we never
> hit yet (like pmd_present() on a swap/migration+invalid pmd).
> 


