Return-Path: <linux-kernel+bounces-162512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B28B5C73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67ABC1F24041
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565198172A;
	Mon, 29 Apr 2024 15:04:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B681724
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403087; cv=none; b=AtiJFqEShCKpreuuLdhzuclLY7iNwI1A0Y93ED8riT/QpI+p2llGxB1FiAwpYc+Bwc4oqVzz6H/NGiwgTSDOKc8ISTjSDUhv3GhRmf43//AknHSKevvBgs9tn+8hYFIM44BxS6SIAJFTDvmYRnAOn+4E0Kk4hV8M079MHqqjqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403087; c=relaxed/simple;
	bh=/0Qgs/qZnihVbmuYjCKBhuAph99ghoJTYWLuYPavCto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukn6OnTHzf/kbycPRVAG67CEHI2K1haA42bKC/prznsHuUGwbOnPfz/Fv3/2AHehTI+KR/wI3JHH36ig7UYu08xwqHzEHrgxFe4TWY5Jmabrx1Y4W5lt30iUvT5323VoRwnYp3yyj7+DXltQTi12NqSfim1W38sD0HVUgMoCW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E312F4;
	Mon, 29 Apr 2024 08:05:09 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2946E3F793;
	Mon, 29 Apr 2024 08:04:41 -0700 (PDT)
Message-ID: <5ea44a93-08a8-4385-b684-bf6fcd007bfb@arm.com>
Date: Mon, 29 Apr 2024 16:04:39 +0100
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
 <e946c510-9ba3-4d7b-9561-5ded86086df0@arm.com>
 <3ee07020-74d9-4f13-a3d0-4924a1aa69c6@arm.com> <Zi-sReFGhSKmHWNh@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zi-sReFGhSKmHWNh@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 15:18, Catalin Marinas wrote:
> On Mon, Apr 29, 2024 at 02:23:35PM +0100, Ryan Roberts wrote:
>> On 29/04/2024 14:01, Ryan Roberts wrote:
>>> On 29/04/2024 13:38, Catalin Marinas wrote:
>>>> On Mon, Apr 29, 2024 at 11:04:53AM +0100, Ryan Roberts wrote:
>>>>> On 26/04/2024 15:48, Catalin Marinas wrote:
>>>>>> On Thu, Apr 25, 2024 at 11:37:42AM +0100, Ryan Roberts wrote:
>>>>>>> Also, IMHO we shouldn't really need to reserve PMD_PRESENT_INVALID for swap
>>>>>>> ptes; it would be cleaner to have one bit that defines "present" when valid is
>>>>>>> clear (similar to PTE_PROT_NONE today) then another bit which is only defined
>>>>>>> when "present && !valid" which tells us if this is PTE_PROT_NONE or
>>>>>>> PMD_PRESENT_INVALID (I don't think you can ever have both at the same time?).
>>>>>>
>>>>>> I think this make sense, maybe rename the above to PTE_PRESENT_INVALID
>>>>>> and use it for both ptes and pmds.
>>>>>
>>>>> Yep, sounds good. I've already got a patch to do this, but it's exposed a bug in
>>>>> core-mm so will now fix that before I can validate my change. see
>>>>> https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
>>>>>
>>>>> With this in place, I'm proposing to remove PTE_PROT_NONE entirely and instead
>>>>> represent PROT_NONE as a present but invalid pte (PTE_VALID=0, PTE_INVALID=1)
>>>>> with both PTE_WRITE=0 and PTE_RDONLY=0.
>>>>>
>>>>> While the HW would interpret PTE_WRITE=0/PTE_RDONLY=0 as "RW without dirty bit
>>>>> modification", this is not a problem as the pte is invalid, so the HW doesn't
>>>>> interpret it. And SW always uses the PTE_WRITE bit to interpret the writability
>>>>> of the pte. So PTE_WRITE=0/PTE_RDONLY=0 was previously an unused combination
>>>>> that we now repurpose for PROT_NONE.
>>>>
>>>> Why not just keep the bits currently in PAGE_NONE (PTE_RDONLY would be
>>>> set) and check PTE_USER|PTE_UXN == 0b01 which is a unique combination
>>>> for PAGE_NONE (bar the kernel mappings).
>>>
>>> Yes I guess that works. I personally prefer my proposal because it is more
>>> intuitive; you have an R bit and a W bit, and you encode RO, WR, and NONE. But
>>> if you think reusing the kernel mapping check (PTE_USER|PTE_UXN == 0b01) is
>>> preferable, then I'll go with that.
>>
>> Ignore this - I looked at your proposed approach and agree it's better. I'll use
>> `PTE_USER|PTE_UXN==0b01`. Posting shortly...
> 
> You nearly convinced me until I read your second reply ;). The
> PTE_WRITE|PTE_RDONLY == 0b00 still has the mkwrite problem if we care
> about (I don't think it can happen though).

Yes, just to clearly enumerate the reasons I prefer your approach:

 - PTE_RDONLY is also used for HW dirty bit. I had to add a conditional to
   pte_mkclean() for my scheme to prevent pte_mkclean() on a PROT_NONE pte
   eroneously making it RO. No such problem with your scheme.

 - With my scheme, we have the mkwrite problem, as you call it. Although, as I
   said some arches already have this semantic, so I don't think its a problem.
   But with your scheme we keep the existing arm64 semantics so it reduces risk
   of a problem in a corner I overlooked.

Anyway, I've posted the v2. Take a look when you get time - perhaps we can get
it into v6.10?



