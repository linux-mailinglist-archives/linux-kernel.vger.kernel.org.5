Return-Path: <linux-kernel+bounces-162596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833B8B5DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBCF1C216BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12889823A8;
	Mon, 29 Apr 2024 15:35:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC764CC0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404900; cv=none; b=QjSLgRWOf0O3R5kFwZCrttufZA10kJSppYm6O1YsBcKotfpd/0HRGIONuLNZOLLe/ffFnngxggAK76uWYyLe0vkncnxmk9nVTiRfxY5aoIKlTPWgHneV2RB/V6+OIWWcc4Y3kKTLH6iA2iO55IWOpYXBf/4CUY1W/iAIHjt/y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404900; c=relaxed/simple;
	bh=1+k1quiOkszeSfEDn/ofRri5lvYBYUzIqrPAxFaeW2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmSAYwShl3L5X//xBrtLaOm+s2/+d69QtNpg2pp2yVj1DXS1CMJIfe+YnYVGWXu86y20x7L2Jg/3/oRqqysT1wQiqmIN3bosKYoN0BpExA0PmHazP4oaZA1eMZfieos0NgpDZUPCEXlBQz/EVtKmoUZu1urQ5Mm+6ou7i/dtq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29D292F4;
	Mon, 29 Apr 2024 08:35:25 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623AE3F793;
	Mon, 29 Apr 2024 08:34:57 -0700 (PDT)
Message-ID: <99384a25-9ff5-43c9-b09d-5a048c456d02@arm.com>
Date: Mon, 29 Apr 2024 16:34:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <23fbca83-a175-4d5a-8cf7-ed54c1830d37@arm.com>
 <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/04/2024 15:45, Zi Yan wrote:
> On 29 Apr 2024, at 5:29, Ryan Roberts wrote:
> 
>> On 27/04/2024 20:11, John Hubbard wrote:
>>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>>> unconditionally on the pmdp and only determines if it is present or not
>>>>>> based on the returned old pmd. This is a problem for the migration entry
>>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>>>>> called for a present pmd.
>>>>>>
>>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>>>> future call to pmd_present() will return true. And therefore any
>>>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>>>> and start interpretting the fields as if it were present, leading to
>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>>>> I suspect the same is possible on other architectures.
>>>>>>
>>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>>>>>
>>>>> Yes, this seems like a good design decision (after reading through the
>>>>> discussion that you all had in the other threads).
>>>>
>>>> This will only be good for arm64 and does not prevent other arch developers
>>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can turn
>>>> a swap entry to a pmd_present() entry.
>>>
>>> Well, let's characterize it in a bit more detail, then:
>>
>> Hi All,
>>
>> Thanks for all the feedback! I had thought that this patch would be entirely
>> uncontraversial - obviously I was wrong :)
>>
>> I've read all the emails, and trying to summarize a way forward here...
>>
>>>
>>> 1) This patch will make things better for arm64. That's important!
>>>
>>> 2) Equally important, this patch does not make anything worse for
>>>    other CPU arches.
>>>
>>> 3) This patch represents a new design constraint on the CPU arch
>>>    layer, and thus requires documentation and whatever enforcement
>>>    we can provide, in order to keep future code out of trouble.
>>
>> I know its only semantics, but I don't view this as a new design constraint. I
>> see it as an existing constraint that was previously being violated, and this
>> patch aims to fix that. The generic version of pmdp_invalidate() unconditionally
>> does a tlb invalidation on the address range covered by the pmd. That makes no
>> sense unless the pmd was previously present. So my conclusion is that the
>> function only expects to be called for present pmds.
>>
>> Additionally Documentation/mm/arch_pgtable_helpers.rst already says this:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
>> "
>>
>> I read "mapped" to be a synonym for "present". So I think its already
>> documented. Happy to explcitly change "mapped" to "present" though, if it helps?
>>
>> Finally, [1] which is linked from Documentation/mm/arch_pgtable_helpers.rst,
>> also implies this constraint, although it doesn't explicitly say it.
>>
>> [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/
>>
>>>
>>> 3.a) See the VM_WARN_ON() hunks below.
>>
>> It sounds like everybody would be happy if I sprinkle these into the arches that
>> override pmdp_invalidate[_ad]()? There are 3 arches that have their own version
>> of pmdp_invalidate(); powerpc, s390 and sparc. And 1 that has its own version of
>> pmdp_invalidate_ad(); x86. I'll add them in all of those.
>>
>> I'll use VM_WARN_ON_ONCE() as suggested by John.
>>
>> I'd rather not put it directly into pmd_mkinvalid() since that would set a
>> precedent for adding them absolutely everywhere. (e.g. pte_mkdirty(), ...).
> 
> I understand your concern here. I assume you also understand the potential issue
> with this, namely it does not prevent one from using pmd_mkinvalid() improperly
> and causing a bug and the bug might only appear on arm64.

Are you saying that arm64 is the *only* arch where pmd_mkinvalid() can turn a
swap pte into a present pte? I hadn't appreciated that; in your first reply to
this patch you said "I notice that x86, risc-v, mips behave the same" - I
thought you were saying they behaved the same as arm64, but on re-reading, I
think I've taken that out of context.

But in spite of that, it still remains my view that making arm64's
pmd_mkinvalid() robust to non-present ptes is not the right fix - or at least
not sufficient on its own. That change on its own would still result in issuing
a TLBI for the non-present pte from pmdp_invalidate(). That's not a correctness
issue, but certainly could be a performance concern.

I think its much better to have the design constraint that pmd_mkinvalid(),
pmdp_invalidate() and pmdp_invalidate_ad() can only be called for present ptes.
And I think the combination of WARNs and docs that we've discussed should be
enough to allay your concerns about introduction of arm64-specific bugs.

> 
>>
>>>
>>> 3.b) I like the new design constraint, because it is reasonable and
>>>      clearly understandable: don't invalidate a non-present page
>>>      table entry.
>>>
>>> I do wonder if there is somewhere else that this should be documented?
>>
>> If I change:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
>> "
>>
>> To:
>>
>> "
>> | pmd_mkinvalid             | Invalidates a present PMD; do not call for       |
>> |                             non-present pmd [1]                              |
>> "
>>
>> Is that sufficient? (I'll do the same for pud_mkinvalid() too.
> 
> Sounds good to me.
> 
> Also, if you move pmdp_invalidate(), please move the big comment with it to
> avoid confusion. Thanks.

Yes good spot, I'll move it.

> 
> --
> Best Regards,
> Yan, Zi


