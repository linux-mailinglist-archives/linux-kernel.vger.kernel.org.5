Return-Path: <linux-kernel+bounces-62347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC775851EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8952283204
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297D405FB;
	Mon, 12 Feb 2024 20:39:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0B41DA5B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770349; cv=none; b=qtg0cKcjwL47AjgV1qp9sgP9ACAC4OEBStM/nXQT6sfNjjZVLG4huWrwh26BiThYM5ALLCwMOU8bv4IvGMtlgenrp+HnTdZxU52+3P2WdyIOa+7qF3IVOV/i0o5Uv7RPNh5SBioUwrQatL9jaBfKR2WYluBnT8KSp1W6Ypr+QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770349; c=relaxed/simple;
	bh=4n4tjW723V0IAbGF5or8C4v6NovmCSgEHxp3WKxnaao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=traWz+FkjRS5gBmXOdXeiEkbguy1z3QjkC+M95Wwq1HQG+ncXVpv2TSRQGvMs7xfuG+sNhSxW9t1s1yB8rQmMlXd77FlJqLwd76rnjMGAw/afpFlSCxIEa9XSrCdP2WC42jjxi9kY9DdCUyJihnO14Uj2CCyvYQ09jowk7yBSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56446DA7;
	Mon, 12 Feb 2024 12:39:47 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95403F766;
	Mon, 12 Feb 2024 12:39:00 -0800 (PST)
Message-ID: <64395ae4-3a7d-45dd-8f1d-ea6b232829c5@arm.com>
Date: Mon, 12 Feb 2024 20:38:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
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
 <aa232591-e0c8-422d-a641-fa555914c5f0@arm.com>
In-Reply-To: <aa232591-e0c8-422d-a641-fa555914c5f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

>>>> +static inline bool mm_is_user(struct mm_struct *mm)
>>>> +{
>>>> +	/*
>>>> +	 * Don't attempt to apply the contig bit to kernel mappings, because
>>>> +	 * dynamically adding/removing the contig bit can cause page faults.
>>>> +	 * These racing faults are ok for user space, since they get serialized
>>>> +	 * on the PTL. But kernel mappings can't tolerate faults.
>>>> +	 */
>>>> +	return mm != &init_mm;
>>>> +}
>>>
>>> We also have the efi_mm as a non-user mm, though I don't think we manipulate
>>> that while it is live, and I'm not sure if that needs any special handling.
>>
>> Well we never need this function in the hot (order-0 folio) path, so I think I
>> could add a check for efi_mm here with performance implication. It's probably
>> safest to explicitly exclude it? What do you think?
> 
> Oops: This should have read "I think I could add a check for efi_mm here
> *without* performance implication"

It turns out that efi_mm is only defined when CONFIG_EFI is enabled. I can do this:

return mm != &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm != &efi_mm);

Is that acceptable? This is my preference, but nothing else outside of efi
references this symbol currently.

Or perhaps I can convince myself that its safe to treat efi_mm like userspace.
There are a couple of things that need to be garanteed for it to be safe:

  - The PFNs of present ptes either need to have an associated struct page or
    need to have the PTE_SPECIAL bit set (either pte_mkspecial() or
    pte_mkdevmap())

  - Live mappings must either be static (no changes that could cause fold/unfold
    while live) or the system must be able to tolerate a temporary fault

Mark suggests efi_mm is not manipulated while live, so that meets the latter
requirement, but I'm not sure about the former?

Thanks,
Ryan


