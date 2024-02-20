Return-Path: <linux-kernel+bounces-73630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B9385C54C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA65E1C218D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F314A0BE;
	Tue, 20 Feb 2024 19:59:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08F14A4D8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459139; cv=none; b=r61wrCjXaSPQLhQ/ijEfQD3NC8rAnn9dv1PuWikI9rHlHnD577NH1APw9ZuHSzMiANDkKERqyAusLUWS7dLsE5wnpElcMCLJ9AACAACIE9ITw4OfgVjr7w3HRGNHm6RUYI08J9D9/YcGuTax9T/ik0Uh6w2MJBFaVPKRR8BXWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459139; c=relaxed/simple;
	bh=+i8JjHVQkwYG6aYw9uGp8s+ZPKM0ZgZC8abIOEX9pzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kULGkSV7KeF5ABU6q1WpCbxvUS+QcTeCXvnC6Jp7kGqtI6GZ3VtWws0N+M/eQss85XSlJ85QJF4+yBysBviGmJxsxfpx5uzf4p+BSnETQyslSPEqX3UgD37mmPRa3p2yKBy3nK0JM8+smrVODmUf1Bti/GsVydHv8tC+BK9eqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C06FFEC;
	Tue, 20 Feb 2024 11:59:36 -0800 (PST)
Received: from [172.20.10.9] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C333F73F;
	Tue, 20 Feb 2024 11:58:51 -0800 (PST)
Message-ID: <9cb2b8c6-aac8-4130-8558-6646817689e0@arm.com>
Date: Tue, 20 Feb 2024 20:58:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-13-ryan.roberts@arm.com> <Zc9UQy-mtYAzNWm2@arm.com>
 <892caa6a-e4fe-4009-aa33-0570526961c5@arm.com> <ZdNxSRR9MgvtMVao@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZdNxSRR9MgvtMVao@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 15:18, Catalin Marinas wrote:
> On Fri, Feb 16, 2024 at 12:53:43PM +0000, Ryan Roberts wrote:
>> On 16/02/2024 12:25, Catalin Marinas wrote:
>>> On Thu, Feb 15, 2024 at 10:31:59AM +0000, Ryan Roberts wrote:
>>>> +pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
>>>> +{
>>>> +	/*
>>>> +	 * Gather access/dirty bits, which may be populated in any of the ptes
>>>> +	 * of the contig range. We may not be holding the PTL, so any contiguous
>>>> +	 * range may be unfolded/modified/refolded under our feet. Therefore we
>>>> +	 * ensure we read a _consistent_ contpte range by checking that all ptes
>>>> +	 * in the range are valid and have CONT_PTE set, that all pfns are
>>>> +	 * contiguous and that all pgprots are the same (ignoring access/dirty).
>>>> +	 * If we find a pte that is not consistent, then we must be racing with
>>>> +	 * an update so start again. If the target pte does not have CONT_PTE
>>>> +	 * set then that is considered consistent on its own because it is not
>>>> +	 * part of a contpte range.
>>>> +*/
> [...]
>>> After writing the comments above, I think I figured out that the whole
>>> point of this loop is to check that the ptes in the contig range are
>>> still consistent and the only variation allowed is the dirty/young
>>> state to be passed to the orig_pte returned. The original pte may have
>>> been updated by the time this loop finishes but I don't think it
>>> matters, it wouldn't be any different than reading a single pte and
>>> returning it while it is being updated.
>>
>> Correct. The pte can be updated at any time, before after or during the reads.
>> That was always the case. But now we have to cope with a whole contpte block
>> being repainted while we are reading it. So we are just checking to make sure
>> that all the ptes that we read from the contpte block are consistent with
>> eachother and therefore we can trust that the access/dirty bits we gathered are
>> consistent.
> 
> I've been thinking a bit more about this - do any of the callers of
> ptep_get_lockless() check the dirty/access bits? The only one that seems
> to care is ptdump but in that case I'd rather see the raw bits for
> debugging rather than propagating the dirty/access bits to the rest in
> the contig range.
> 
> So with some clearer documentation on the requirements, I think we don't
> need an arm64-specific ptep_get_lockless() (unless I missed something).

We've discussed similar at [1]. And I've posted an RFC series to convert all
ptep_get_lockless() to ptep_get_lockless_norecency() at [2]. The current spec
for ptep_get_lockless() is that it includes the access and dirty bits. So we
can't just read the single pte - if there is a tlb eviction followed by
re-population for the block, the access/dirty bits could move and that will
break pte_same() comparisons which are used in places.

So the previous conclusion was that we are ok to put this arm64-specific
ptep_get_lockless() in for now, but look to simplify by migrating to
ptep_get_lockless_norecency() in future. Are you ok with that approach?

[1]
https://lore.kernel.org/linux-mm/a91cfe1c-289e-4828-8cfc-be34eb69a71b@redhat.com/
[2] https://lore.kernel.org/linux-mm/20240215121756.2734131-1-ryan.roberts@arm.com/

Thanks,
Ryan


