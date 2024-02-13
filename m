Return-Path: <linux-kernel+bounces-63629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF385327A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3491C21BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1C56767;
	Tue, 13 Feb 2024 14:02:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F056473
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832930; cv=none; b=gr3LvzwSPLK5xvEQQBMIHdXZVCtdDJxEGlprhk40c88qkxcKFvNr/ODQj/8QCImEjiFWzFhfCW2EVEqA+pRXVsLG3oHj+7Lk0cpD27wc1KLkSzM09YqUwhcle8kaQzJ8iAsgXbwxRcXFa/aoh1AseNZ/J02az7QYk96vnnZwLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832930; c=relaxed/simple;
	bh=vxFVD4NN2SHVvYOBr+DD2O4CZVXIBKJXkB3cdNZt8hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qchCWHz8FzwJBFq3+sN5HQUogQ0OjAeZnx6XpgMWsvpzFd31ZXPpqc8mI5PcNEuipVNzdCz5ZAP110OWWFZ4/vwj+QxsY8cQeSnGmWzZTcVf4nIXZWmINVvhjbkB7TDIq/ghfffNerqy1diRPIiL2AYDgZcHEAHN940jqYtiRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18234DA7;
	Tue, 13 Feb 2024 06:02:48 -0800 (PST)
Received: from [10.1.36.184] (XHFQ2J9959.cambridge.arm.com [10.1.36.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7B53F762;
	Tue, 13 Feb 2024 06:02:03 -0800 (PST)
Message-ID: <3de2130b-9f0f-4a11-ac06-7bf814de641c@arm.com>
Date: Tue, 13 Feb 2024 14:02:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
 <aa232591-e0c8-422d-a641-fa555914c5f0@arm.com>
 <64395ae4-3a7d-45dd-8f1d-ea6b232829c5@arm.com>
 <d6ce951f-f83b-4a5a-a814-311f2d8b01e4@arm.com>
 <41499621-482f-455b-9f68-b43ea8052557@redhat.com>
 <1d302d7a-50ab-4ab4-b049-75ed4a71a87d@arm.com>
 <99e2a92c-f2a2-4e1e-8ce2-08caae2cb7e4@redhat.com>
 <dce5f80d-942f-439c-a549-5290666464ca@arm.com>
 <CAMj1kXEVf1m4hVXORc6t9ytAOb75KZLcW-OJ6999VaKbkVdQ3A@mail.gmail.com>
 <64b872bd-4b12-4dbd-b043-1ad11aeaa19a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <64b872bd-4b12-4dbd-b043-1ad11aeaa19a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 13:45, David Hildenbrand wrote:
> On 13.02.24 14:33, Ard Biesheuvel wrote:
>> On Tue, 13 Feb 2024 at 14:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 13/02/2024 13:13, David Hildenbrand wrote:
>>>> On 13.02.24 14:06, Ryan Roberts wrote:
>>>>> On 13/02/2024 12:19, David Hildenbrand wrote:
>>>>>> On 13.02.24 13:06, Ryan Roberts wrote:
>>>>>>> On 12/02/2024 20:38, Ryan Roberts wrote:
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>>> +static inline bool mm_is_user(struct mm_struct *mm)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    /*
>>>>>>>>>>>> +     * Don't attempt to apply the contig bit to kernel mappings,
>>>>>>>>>>>> because
>>>>>>>>>>>> +     * dynamically adding/removing the contig bit can cause page
>>>>>>>>>>>> faults.
>>>>>>>>>>>> +     * These racing faults are ok for user space, since they get
>>>>>>>>>>>> serialized
>>>>>>>>>>>> +     * on the PTL. But kernel mappings can't tolerate faults.
>>>>>>>>>>>> +     */
>>>>>>>>>>>> +    return mm != &init_mm;
>>>>>>>>>>>> +}
>>>>>>>>>>>
>>>>>>>>>>> We also have the efi_mm as a non-user mm, though I don't think we
>>>>>>>>>>> manipulate
>>>>>>>>>>> that while it is live, and I'm not sure if that needs any special
>>>>>>>>>>> handling.
>>>>>>>>>>
>>>>>>>>>> Well we never need this function in the hot (order-0 folio) path, so I
>>>>>>>>>> think I
>>>>>>>>>> could add a check for efi_mm here with performance implication. It's
>>>>>>>>>> probably
>>>>>>>>>> safest to explicitly exclude it? What do you think?
>>>>>>>>>
>>>>>>>>> Oops: This should have read "I think I could add a check for efi_mm here
>>>>>>>>> *without* performance implication"
>>>>>>>>
>>>>>>>> It turns out that efi_mm is only defined when CONFIG_EFI is enabled I
>>>>>>>> can do
>>>>>>>> this:
>>>>>>>>
>>>>>>>> return mm != &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm != &efi_mm);
>>>>>>>>
>>>>>>>> Is that acceptable? This is my preference, but nothing else outside of efi
>>>>>>>> references this symbol currently.
>>>>>>>>
>>>>>>>> Or perhaps I can convince myself that its safe to treat efi_mm like
>>>>>>>> userspace.
>>>>>>>> There are a couple of things that need to be garanteed for it to be safe:
>>>>>>>>
>>>>>>>>      - The PFNs of present ptes either need to have an associated struct
>>>>>>>> page or
>>>>>>>>        need to have the PTE_SPECIAL bit set (either pte_mkspecial() or
>>>>>>>>        pte_mkdevmap())
>>>>>>>>
>>>>>>>>      - Live mappings must either be static (no changes that could cause
>>>>>>>> fold/unfold
>>>>>>>>        while live) or the system must be able to tolerate a temporary fault
>>>>>>>>
>>>>>>>> Mark suggests efi_mm is not manipulated while live, so that meets the
>>>>>>>> latter
>>>>>>>> requirement, but I'm not sure about the former?
>>>>>>>
>>>>>>> I've gone through all the efi code, and conclude that, as Mark suggests, the
>>>>>>> mappings are indeed static. And additionally, the ptes are populated
>>>>>>> using only
>>>>>>> the _private_ ptep API, so there is no issue here. As just discussed with
>>>>>>> Mark,
>>>>>>> my prefereence is to not make any changes to code, and just add a comment
>>>>>>> describing why efi_mm is safe.
>>>>>>>
>>>>>>> Details:
>>>>>>>
>>>>>>> * Registered with ptdump
>>>>>>>        * ptep_get_lockless()
>>>>>>> * efi_create_mapping -> create_pgd_mapping … -> init_pte:
>>>>>>>        * __ptep_get()
>>>>>>>        * __set_pte()
>>>>>>> * efi_memattr_apply_permissions -> efi_set_mapping_permissions … ->
>>>>>>> set_permissions
>>>>>>>        * __ptep_get()
>>>>>>>        * __set_pte()
>>>>>>
>>>>>> Sound good. We could add some VM_WARN_ON if we ever get the efi_mm via the
>>>>>> "official" APIs.
>>>>>
>>>>> We could, but that would lead to the same linkage issue, which I'm trying to
>>>>> avoid in the first place:
>>>>>
>>>>> VM_WARN_ON(IS_ENABLED(CONFIG_EFI) && mm == efi_mm);
>>>>>
>>>>> This creates new source code dependencies, which I would rather avoid if
>>>>> possible.
>>>>
>>>> Just a thought, you could have a is_efi_mm() function that abstracts all that.
>>>>
>>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>>> index c74f47711f0b..152f5fa66a2a 100644
>>>> --- a/include/linux/efi.h
>>>> +++ b/include/linux/efi.h
>>>> @@ -692,6 +692,15 @@ extern struct efi {
>>>>
>>>>   extern struct mm_struct efi_mm;
>>>>
>>>> +static inline void is_efi_mm(struct mm_struct *mm)
>>>> +{
>>>> +#ifdef CONFIG_EFI
>>>> +       return mm == &efi_mm;
>>>> +#else
>>>> +       return false;
>>>> +#endif
>>>> +}
>>>> +
>>>>   static inline int
>>>>   efi_guidcmp (efi_guid_t left, efi_guid_t right)
>>>>   {
>>>>
>>>>
>>>
>>> That would definitely work, but in that case, I might as well just check for it
>>> in mm_is_user() (and personally I would change the name to mm_is_efi()):
>>>
>>>
>>> static inline bool mm_is_user(struct mm_struct *mm)
>>> {
>>>          return mm != &init_mm && !mm_is_efi(mm);
>>> }
>>>
>>> Any objections?
>>>
>>
>> Any reason not to use IS_ENABLED(CONFIG_EFI) in the above? The extern
>> declaration is visible to the compiler, and any references should
>> disappear before the linker could notice that efi_mm does not exist.
>>
> 
> Sure, as long as the linker is happy why not. I'll let Ryan mess with that :)

I'm not sure if you are suggesting dropping the mm_is_efi() helper and just use
IS_ENABLED(CONFIG_EFI) in mm_is_user() to guard efi_mm, or if you are suggesting
using IS_ENABLED(CONFIG_EFI) in mm_is_efi() instead of the ifdefery?

The former was what I did initially; It works great, but I didn't like that I
was introducing a new code dependecy between efi and arm64 (nothing else outside
of efi references efi_mm).

So then concluded that it is safe to not worry about efi_mm (thanks for your
confirmation). But then David wanted a VM_WARN check, which reintroduces the
code dependency. So he suggested the mm_is_efi() helper to hide that... This is
all starting to feel circular...

Since I've jsut updated the code to do it David's way, I propose leaving it as
is since nobody has strong feelings.

> 
>> In any case, feel free to add
>>
>> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Great thanks!

> 
> Thanks for the review.
> 


