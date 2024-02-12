Return-Path: <linux-kernel+bounces-62403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDFE851FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4977E285436
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6454D5B5;
	Mon, 12 Feb 2024 21:35:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106C4CE0F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773702; cv=none; b=SS4S9tE8YaMoht59FtNQ725uKCa/mw+y9vMPI7d5izvEnEkIIDuX6x5d9gQ4Uww/735Z/Pt53vQ0m2W9j94idUzbKJ2W5EbH8wfSGPUuZ3iTlLIppq5SOfEwRTktRUHYpLUKFQNjL+VV6vTJj6F8oUPDjGXIeDc6iqMhjqgx7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773702; c=relaxed/simple;
	bh=E1kWsqFDQhM/T3jJEBZxpbYuGRyEfIFfPycZCQEx3vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYgQn2W4uSq4QX7bKdIjKS2e5bARXHPRprIt/HuTON2Fj7K8mOo0Si3FooMU9pcyp6MHtMT8wBp0jeR/h+5pSSK9x6DpL5Sr30IrQ8uosibX5Z2kceLb23MbvWi+49YB+GxVmm/dzezFAXodXZE1Z/h6LXZaHf0/8SARRVglfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8BEDA7;
	Mon, 12 Feb 2024 13:35:39 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5003F766;
	Mon, 12 Feb 2024 13:34:54 -0800 (PST)
Message-ID: <3bc05163-2671-4239-ae5a-b9207fdca459@arm.com>
Date: Mon, 12 Feb 2024 21:34:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] mm: Make pte_next_pfn() a wrapper around
 pte_advance_pfn()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-4-ryan.roberts@arm.com>
 <c269c2e0-afca-4ff0-8ffd-9049fb52c905@redhat.com>
 <cdf4e537-5b0d-45ba-8094-527127c791a6@arm.com>
 <828d2573-b5fe-43b3-b955-944c05bcdb60@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <828d2573-b5fe-43b3-b955-944c05bcdb60@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 14:29, David Hildenbrand wrote:
> On 12.02.24 15:10, Ryan Roberts wrote:
>> On 12/02/2024 12:14, David Hildenbrand wrote:
>>> On 02.02.24 09:07, Ryan Roberts wrote:
>>>> The goal is to be able to advance a PTE by an arbitrary number of PFNs.
>>>> So introduce a new API that takes a nr param.
>>>>
>>>> We are going to remove pte_next_pfn() and replace it with
>>>> pte_advance_pfn(). As a first step, implement pte_next_pfn() as a
>>>> wrapper around pte_advance_pfn() so that we can incrementally switch the
>>>> architectures over. Once all arches are moved over, we will change all
>>>> the core-mm callers to call pte_advance_pfn() directly and remove the
>>>> wrapper.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    include/linux/pgtable.h | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 5e7eaf8f2b97..815d92dcb96b 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -214,9 +214,15 @@ static inline int pmd_dirty(pmd_t pmd)
>>>>        #ifndef pte_next_pfn
>>>> +#ifndef pte_advance_pfn
>>>> +static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>>>> +{
>>>> +    return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
>>>> +}
>>>> +#endif
>>>>    static inline pte_t pte_next_pfn(pte_t pte)
>>>>    {
>>>> -    return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>>>> +    return pte_advance_pfn(pte, 1);
>>>>    }
>>>>    #endif
>>>>    
>>>
>>> I do wonder if we simply want to leave pte_next_pfn() around? Especially patch
>>> #4, #6 don't really benefit from the change? So are the other set_ptes()
>>> implementations.
>>>
>>> That is, only convert all pte_next_pfn()->pte_advance_pfn(), and leave a
>>> pte_next_pfn() macro in place.
>>>
>>> Any downsides to that?
>>
>> The downside is just having multiple functions that effectively do the same
>> thing. Personally I think its cleaner and easier to understand the code with
>> just one generic function which we pass 1 to it where we only want to advance by
>> 1. In the end, there are only a couple of places where pte_advance_pfn(1) is
>> used, so doesn't really seem valuable to me to maintain a specialization.
> 
> Well, not really functions, just a macro. Like we have set_pte_at() translating
> to set_ptes().
> 
> Arguably, we have more callers of set_pte_at().
> 
> "Easier to understand", I don't know. :)
> 
>>
>> Unless you feel strongly that we need to keep pte_next_pfn() then I'd prefer to
>> leave it as I've done in this series.
> 
> Well, it makes you patch set shorter and there is less code churn.
> 
> So personally, I'd just leave pte_next_pfn() in there. But whatever you prefer,
> not the end of the world.

I thought about this a bit more and remembered that I'm the apprentice so I've
changed it as you suggested.


