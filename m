Return-Path: <linux-kernel+bounces-63803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AD8534A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A6D1C21121
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C25DF3A;
	Tue, 13 Feb 2024 15:29:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739405DF0B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838174; cv=none; b=FGEu8aiji1Z5rDIkwMyULCGp88+JZYEMbQoO7QtW4f6uoWtfQT8E+AvURVEX6143IC2MK2t+6fxG58+0Xzww6xF6TgWTpW5HJoJ6c9imAhySZnuhXvrGSqH/UzyCP/aRURmxh0PwNkZzxq6zwLu+TQaR5tymIhNTOaq1kL9Z4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838174; c=relaxed/simple;
	bh=p93QLxYMw2eMpxXpo9DyjtVLHNaR0wFglfAKDKchBfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFPO59FenauaJzVQZpAaPEKChHfXFgCnooZf/bg6CxBaxeoEsphTBosPySV0R+BEZlCniRzOV4sb70WvVVy98LfXxhuj3wFeG0sK9LKCVWHEOYPN6YVq2Bol6P1RM4VBvcMhuE1Y328++oNVBl0D+x4D509Ft9FqelyTtadGqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19912DA7;
	Tue, 13 Feb 2024 07:30:11 -0800 (PST)
Received: from [10.1.36.184] (XHFQ2J9959.cambridge.arm.com [10.1.36.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37F103F7B4;
	Tue, 13 Feb 2024 07:29:26 -0800 (PST)
Message-ID: <b5d26583-386b-41b4-83d1-30500e6837a9@arm.com>
Date: Tue, 13 Feb 2024 15:29:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-20-ryan.roberts@arm.com>
 <ZcoIVypNwOPIX30w@FVFF77S0Q05N>
 <c899f252-dbf3-4e7b-8342-b5a5180486cd@arm.com>
 <a91cfe1c-289e-4828-8cfc-be34eb69a71b@redhat.com>
 <502a3ea7-fd86-4314-8292-c7999eda92eb@arm.com>
 <427ba87a-7dd0-4f3e-861f-fe6946b7cd97@redhat.com>
 <abe814c9-71f3-4d7d-bdc8-9dd930d6f0b2@arm.com>
 <55a1e0ef-14b3-4311-b2aa-a6add76fa2ed@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <55a1e0ef-14b3-4311-b2aa-a6add76fa2ed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 16:24, David Hildenbrand wrote:
> On 12.02.24 16:34, Ryan Roberts wrote:
>> On 12/02/2024 15:26, David Hildenbrand wrote:
>>> On 12.02.24 15:45, Ryan Roberts wrote:
>>>> On 12/02/2024 13:54, David Hildenbrand wrote:
>>>>>>> If so, I wonder if we could instead do that comparison modulo the
>>>>>>> access/dirty
>>>>>>> bits,
>>>>>>
>>>>>> I think that would work - but will need to think a bit more on it.
>>>>>>
>>>>>>> and leave ptep_get_lockless() only reading a single entry?
>>>>>>
>>>>>> I think we will need to do something a bit less fragile. ptep_get() does
>>>>>> collect
>>>>>> the access/dirty bits so its confusing if ptep_get_lockless() doesn't
>>>>>> IMHO. So
>>>>>> we will likely want to rename the function and make its documentation
>>>>>> explicit
>>>>>> that it does not return those bits.
>>>>>>
>>>>>> ptep_get_lockless_noyoungdirty()? yuk... Any ideas?
>>>>>>
>>>>>> Of course if I could convince you the current implementation is safe, I
>>>>>> might be
>>>>>> able to sidestep this optimization until a later date?
>>>>>
>>>>> As discussed (and pointed out abive), there might be quite some callsites
>>>>> where
>>>>> we don't really care about uptodate accessed/dirty bits -- where ptep_get() is
>>>>> used nowadays.
>>>>>
>>>>> One way to approach that I had in mind was having an explicit interface:
>>>>>
>>>>> ptep_get()
>>>>> ptep_get_uptodate()
>>>>> ptep_get_lockless()
>>>>> ptep_get_lockless_uptodate()
>>>>
>>>> Yes, I like the direction of this. I guess we anticipate that call sites
>>>> requiring the "_uptodate" variant will be the minority so it makes sense to use
>>>> the current names for the "_not_uptodate" variants? But to do a slow migration,
>>>> it might be better/safer to have the weaker variant use the new name - that
>>>> would allow us to downgrade one at a time?
>>>
>>> Yes, I was primarily struggling with names. Likely it makes sense to either have
>>> two completely new function names, or use the new name only for the "faster but
>>> less precise" variant.
>>>
>>>>
>>>>>
>>>>> Especially the last one might not be needed.
>>>> I've done a scan through the code and agree with Mark's original conclusions.
>>>> Additionally, huge_pte_alloc() (which isn't used for arm64) doesn't rely on
>>>> access/dirty info. So I think I could migrate everything to the weaker variant
>>>> fairly easily.
>>>>
>>>>>
>>>>> Futher, "uptodate" might not be the best choice because of PageUptodate() and
>>>>> friends. But it's better than "youngdirty"/"noyoungdirty" IMHO.
>>>>
>>>> Certainly agree with "noyoungdirty" being a horrible name. How about "_sync" /
>>>> "_nosync"?
>>>
>>> I could live with
>>>
>>> ptep_get_sync()
>>> ptep_get_nosync()
>>>
>>> with proper documentation :)
>>
>> but could you live with:
>>
>> ptep_get()
>> ptep_get_nosync()
>> ptep_get_lockless_nosync()
>>
>> ?
>>
>> So leave the "slower, more precise" version with the existing name.
> 
> Sure.
> 

I'm just implementing this (as a separate RFC), and had an alternative idea for
naming/semantics:

ptep_get()
ptep_get_norecency()
ptep_get_lockless()
ptep_get_lockless_norecency()

The "_norecency" versions explicitly clear the access/dirty bits. This is useful
for the "compare to original pte to check we are not racing" pattern:

pte = ptep_get_lockless_norecency(ptep)
..
<lock>
if (!pte_same(pte, ptep_get_norecency(ptep)))
	// RACE!
..
<unlock>

With the "_nosync" semantic, the access/dirty bits may or may not be set, so the
user has to explicitly clear them to do the comparison. (although I considered a
pte_same_nosync() that would clear the bits for you - but that name is pretty naff).

Although the _norecency semantic requires always explicitly clearing the bits,
so may be infinitesimally slower, it gives a very clear expectation that the
access/dirty bits are always clear and I think that's conveyed well in the name too.

Thoughts?


