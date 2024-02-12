Return-Path: <linux-kernel+bounces-61905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FFA85182B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F771C21A35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218173C684;
	Mon, 12 Feb 2024 15:34:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBD3C478
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752092; cv=none; b=SG375eZ66H1uGyBvPbSXMN2+iAewDvXUVdmgmj+CZTM2zrGMabFF4pqL7NzHd21xGiaPDuKHJaApgwL/8phc+nlgdaz9xv0Tm/168ysoPIqeDBdeGKOOpEopt/znnD+WoUkrSoPK5Izc+fbT1S5fm9685izPpZV9IrbyRWDRzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752092; c=relaxed/simple;
	bh=fDYaR6n0CYl6u9/RTHsHKwhIKw3nTGbXvq3+M6mhgh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KchOIHxE/xsUkKUJP+kWRUBK06g10C+lLffWnzfQascELWuVoj0+WQDL6QY6IBrnVEGoxw9k8/Fmnh5TIOzKH3qW4mPJAd7euS2gFX/+YAnVa4BmGT5k5se0UQlUPeS+4tJLQnA8lBYcbfZdZ+nfh8nMBeWNTZuQHiKfh5FsC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600FDDA7;
	Mon, 12 Feb 2024 07:35:31 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D37C3F766;
	Mon, 12 Feb 2024 07:34:45 -0800 (PST)
Message-ID: <abe814c9-71f3-4d7d-bdc8-9dd930d6f0b2@arm.com>
Date: Mon, 12 Feb 2024 15:34:43 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <427ba87a-7dd0-4f3e-861f-fe6946b7cd97@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 15:26, David Hildenbrand wrote:
> On 12.02.24 15:45, Ryan Roberts wrote:
>> On 12/02/2024 13:54, David Hildenbrand wrote:
>>>>> If so, I wonder if we could instead do that comparison modulo the access/dirty
>>>>> bits,
>>>>
>>>> I think that would work - but will need to think a bit more on it.
>>>>
>>>>> and leave ptep_get_lockless() only reading a single entry?
>>>>
>>>> I think we will need to do something a bit less fragile. ptep_get() does
>>>> collect
>>>> the access/dirty bits so its confusing if ptep_get_lockless() doesn't IMHO. So
>>>> we will likely want to rename the function and make its documentation explicit
>>>> that it does not return those bits.
>>>>
>>>> ptep_get_lockless_noyoungdirty()? yuk... Any ideas?
>>>>
>>>> Of course if I could convince you the current implementation is safe, I
>>>> might be
>>>> able to sidestep this optimization until a later date?
>>>
>>> As discussed (and pointed out abive), there might be quite some callsites where
>>> we don't really care about uptodate accessed/dirty bits -- where ptep_get() is
>>> used nowadays.
>>>
>>> One way to approach that I had in mind was having an explicit interface:
>>>
>>> ptep_get()
>>> ptep_get_uptodate()
>>> ptep_get_lockless()
>>> ptep_get_lockless_uptodate()
>>
>> Yes, I like the direction of this. I guess we anticipate that call sites
>> requiring the "_uptodate" variant will be the minority so it makes sense to use
>> the current names for the "_not_uptodate" variants? But to do a slow migration,
>> it might be better/safer to have the weaker variant use the new name - that
>> would allow us to downgrade one at a time?
> 
> Yes, I was primarily struggling with names. Likely it makes sense to either have
> two completely new function names, or use the new name only for the "faster but
> less precise" variant.
> 
>>
>>>
>>> Especially the last one might not be needed.
>> I've done a scan through the code and agree with Mark's original conclusions.
>> Additionally, huge_pte_alloc() (which isn't used for arm64) doesn't rely on
>> access/dirty info. So I think I could migrate everything to the weaker variant
>> fairly easily.
>>
>>>
>>> Futher, "uptodate" might not be the best choice because of PageUptodate() and
>>> friends. But it's better than "youngdirty"/"noyoungdirty" IMHO.
>>
>> Certainly agree with "noyoungdirty" being a horrible name. How about "_sync" /
>> "_nosync"?
> 
> I could live with
> 
> ptep_get_sync()
> ptep_get_nosync()
> 
> with proper documentation :)

but could you live with:

ptep_get()
ptep_get_nosync()
ptep_get_lockless_nosync()

?

So leave the "slower, more precise" version with the existing name.

> 
> I don't think we use "_sync" / "_nosync" in the context of pte operations yet.
> 
> Well, there seems to be "__arm_v7s_pte_sync" in iommu code, bit at least in core
> code nothing jumped at me.
> 


