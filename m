Return-Path: <linux-kernel+bounces-63576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34E8531A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104131F23118
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4B5381D;
	Tue, 13 Feb 2024 13:21:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DABD55C01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830464; cv=none; b=XiQXdAkY03hz44icvmlAJx2RJR21OS6G1eUP3iubYJgAEFfVdBdEoSfI43oOyoxqJiCQTziI23HTC6RGziKoqDi5kERQdiFiJVH+5WcmQbGB0G0rUvzgAltI3AHgOQMvY0jhRK7AVmnFE4i4Ud5onqBtCoVHiqhyL5+n0a3lGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830464; c=relaxed/simple;
	bh=FmvIhG9gIv0Yx6WYx650HxW0UcaYosnlTfhklJmt5D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFyOssl8E+OGnOwPcYl2e6PxbAlWfCFBVVEE3pE5WdUU8KWl4k3eSUhXezL+jTxLeoO8KjcVXSvitrFr5j5I0PfVF75vMGfYuvYsda3ykfLUYX1w599r2kofsHiyZe/LNXMNC/J0AT5FkpMfpVLZWKFV2Wtk09zrUQzFyDfKGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4FADA7;
	Tue, 13 Feb 2024 05:21:41 -0800 (PST)
Received: from [10.1.36.184] (XHFQ2J9959.cambridge.arm.com [10.1.36.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E9C13F762;
	Tue, 13 Feb 2024 05:20:56 -0800 (PST)
Message-ID: <dce5f80d-942f-439c-a549-5290666464ca@arm.com>
Date: Tue, 13 Feb 2024 13:20:55 +0000
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
 <aa232591-e0c8-422d-a641-fa555914c5f0@arm.com>
 <64395ae4-3a7d-45dd-8f1d-ea6b232829c5@arm.com>
 <d6ce951f-f83b-4a5a-a814-311f2d8b01e4@arm.com>
 <41499621-482f-455b-9f68-b43ea8052557@redhat.com>
 <1d302d7a-50ab-4ab4-b049-75ed4a71a87d@arm.com>
 <99e2a92c-f2a2-4e1e-8ce2-08caae2cb7e4@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <99e2a92c-f2a2-4e1e-8ce2-08caae2cb7e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 13:13, David Hildenbrand wrote:
> On 13.02.24 14:06, Ryan Roberts wrote:
>> On 13/02/2024 12:19, David Hildenbrand wrote:
>>> On 13.02.24 13:06, Ryan Roberts wrote:
>>>> On 12/02/2024 20:38, Ryan Roberts wrote:
>>>>> [...]
>>>>>
>>>>>>>>> +static inline bool mm_is_user(struct mm_struct *mm)
>>>>>>>>> +{
>>>>>>>>> +    /*
>>>>>>>>> +     * Don't attempt to apply the contig bit to kernel mappings, because
>>>>>>>>> +     * dynamically adding/removing the contig bit can cause page faults.
>>>>>>>>> +     * These racing faults are ok for user space, since they get
>>>>>>>>> serialized
>>>>>>>>> +     * on the PTL. But kernel mappings can't tolerate faults.
>>>>>>>>> +     */
>>>>>>>>> +    return mm != &init_mm;
>>>>>>>>> +}
>>>>>>>>
>>>>>>>> We also have the efi_mm as a non-user mm, though I don't think we
>>>>>>>> manipulate
>>>>>>>> that while it is live, and I'm not sure if that needs any special handling.
>>>>>>>
>>>>>>> Well we never need this function in the hot (order-0 folio) path, so I
>>>>>>> think I
>>>>>>> could add a check for efi_mm here with performance implication. It's
>>>>>>> probably
>>>>>>> safest to explicitly exclude it? What do you think?
>>>>>>
>>>>>> Oops: This should have read "I think I could add a check for efi_mm here
>>>>>> *without* performance implication"
>>>>>
>>>>> It turns out that efi_mm is only defined when CONFIG_EFI is enabled. I can do
>>>>> this:
>>>>>
>>>>> return mm != &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm != &efi_mm);
>>>>>
>>>>> Is that acceptable? This is my preference, but nothing else outside of efi
>>>>> references this symbol currently.
>>>>>
>>>>> Or perhaps I can convince myself that its safe to treat efi_mm like userspace.
>>>>> There are a couple of things that need to be garanteed for it to be safe:
>>>>>
>>>>>     - The PFNs of present ptes either need to have an associated struct
>>>>> page or
>>>>>       need to have the PTE_SPECIAL bit set (either pte_mkspecial() or
>>>>>       pte_mkdevmap())
>>>>>
>>>>>     - Live mappings must either be static (no changes that could cause
>>>>> fold/unfold
>>>>>       while live) or the system must be able to tolerate a temporary fault
>>>>>
>>>>> Mark suggests efi_mm is not manipulated while live, so that meets the latter
>>>>> requirement, but I'm not sure about the former?
>>>>
>>>> I've gone through all the efi code, and conclude that, as Mark suggests, the
>>>> mappings are indeed static. And additionally, the ptes are populated using only
>>>> the _private_ ptep API, so there is no issue here. As just discussed with Mark,
>>>> my prefereence is to not make any changes to code, and just add a comment
>>>> describing why efi_mm is safe.
>>>>
>>>> Details:
>>>>
>>>> * Registered with ptdump
>>>>       * ptep_get_lockless()
>>>> * efi_create_mapping -> create_pgd_mapping … -> init_pte:
>>>>       * __ptep_get()
>>>>       * __set_pte()
>>>> * efi_memattr_apply_permissions -> efi_set_mapping_permissions … ->
>>>> set_permissions
>>>>       * __ptep_get()
>>>>       * __set_pte()
>>>
>>> Sound good. We could add some VM_WARN_ON if we ever get the efi_mm via the
>>> "official" APIs.
>>
>> We could, but that would lead to the same linkage issue, which I'm trying to
>> avoid in the first place:
>>
>> VM_WARN_ON(IS_ENABLED(CONFIG_EFI) && mm == efi_mm);
>>
>> This creates new source code dependencies, which I would rather avoid if
>> possible.
> 
> Just a thought, you could have a is_efi_mm() function that abstracts all that.
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c74f47711f0b..152f5fa66a2a 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -692,6 +692,15 @@ extern struct efi {
>  
>  extern struct mm_struct efi_mm;
>  
> +static inline void is_efi_mm(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_EFI
> +       return mm == &efi_mm;
> +#else
> +       return false;
> +#endif
> +}
> +
>  static inline int
>  efi_guidcmp (efi_guid_t left, efi_guid_t right)
>  {
> 
> 

That would definitely work, but in that case, I might as well just check for it
in mm_is_user() (and personally I would change the name to mm_is_efi()):


static inline bool mm_is_user(struct mm_struct *mm)
{
	return mm != &init_mm && !mm_is_efi(mm);
}

Any objections?


