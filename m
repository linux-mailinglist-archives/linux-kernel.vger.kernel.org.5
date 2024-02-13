Return-Path: <linux-kernel+bounces-63636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD2853294
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C51C22978
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165656469;
	Tue, 13 Feb 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQoMZhzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337E5674B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833124; cv=none; b=gt4O0860FugVB+2JVmfpwGIKBY6JDLnsjZW/bjBYYN+i0Ve+VRZ5h6tMV+9sFjCTR4YDHvq20QapIg7VWtR42USP4Tdp+nyRuyOweETSOqRZk+molYuU4P99/Ws6QgVi0t4WrvCP9YbX2jzSfmgXgmSh9M7tH+qvI1CMUL4gMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833124; c=relaxed/simple;
	bh=iHbLnkyE8VvjETH2XOdLexR/JCioWTT9zh983zlOkcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6iS+oc4bj47hRuVoMO7V1iUX0dee800Ojg6h6sNWbu8eYvnVGCbOdqlQd2vgx13YcYmOQob//4Sj9l77DBeDeQLpy+MBMV5z3ryQ4CJHnwlR7dEW2Wt0QkWqYQTtFx2cS7qNC6l+42mxAKykSuk22kRDMmHYK5XUcNqrmoWsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQoMZhzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707833119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LeZDdyhURL2Mwa6h0r62LQwvQd54o++ieHpD9U2+Gyw=;
	b=VQoMZhzMNGZVpeTQfUAa/0jYrm0fCz75NlQYYi2ulQOvhLtZTmnzRHQKLi/BsAsWfUKjnc
	fY+Qw5prfI+Bm/sLbCrs9w44S6pfOm1MsXDPCn5wQNlCZxK2woexiqccimlBX8ZqY4qpW5
	6SEItbKXWWnAxzVvWlZMiaxWmVwomng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-S58dQMjpOZeFgPss8lXOsg-1; Tue, 13 Feb 2024 09:05:18 -0500
X-MC-Unique: S58dQMjpOZeFgPss8lXOsg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-410422e8cd1so25653835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833117; x=1708437917;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeZDdyhURL2Mwa6h0r62LQwvQd54o++ieHpD9U2+Gyw=;
        b=GO+vrIKlmapfhyepns/QtuseT0/Wgb89aE0HRleYqu3biRKij0N/ci5/YA/s/O0lfV
         1S8insijYarsg09XpMrScj/rUUsS6b/M5jKA2wVm24gYN3dOy/2Rw8M8w41OQEnzt4yE
         cx5vkhwOjVfj+xLie0AgBmv16M3fKDdj5oDXsWibrFYpw8/Yg6D5jkaJegg/m8ppoHwG
         L9umDaX4aZj9PnzV912fUFXxsEm8uifP9tAspnQsiuskVkT8TsMIgjxhXw9zB2XHcJZ7
         HXhgUXVfhEL7SQDG9VyBGrUEO1RIFFv20YLgcYbg2p4dP+RWmejgPF14t4LVh2YNNFW8
         G+cw==
X-Gm-Message-State: AOJu0Yyu1+aK+V81Yq3qYpa67aK8TfTrvpX6hHzK2ST3dukq6aSDX3gw
	WJmsW146CaddMM9oibjL7FU7zopdRnmZRktRKR30IxOlNH4/bykqNKVxrqHjhXPZr2haXrURZZo
	dRkSf4RJkT2KJbNMXysKXUAS9ePlH6NpGu4uJyjtbt5SjGSPzTrYb6gn4dyKHbA==
X-Received: by 2002:a05:600c:4f4f:b0:411:c713:fe95 with SMTP id m15-20020a05600c4f4f00b00411c713fe95mr1001341wmq.34.1707833117032;
        Tue, 13 Feb 2024 06:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG0g0gloXaNlAfhYey1E1Vi//J6vLpOEiIAV7q+Fwk5C+rMKFz7BQB5lkYwYh4NP7/nlS3Vg==
X-Received: by 2002:a05:600c:4f4f:b0:411:c713:fe95 with SMTP id m15-20020a05600c4f4f00b00411c713fe95mr1001306wmq.34.1707833116596;
        Tue, 13 Feb 2024 06:05:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDnHWHbn7N9IrcijXsfF3GbTPJqNeNob5qN6156xA6910AcWeEviLBPtWiahlXZU4NX7wo9BJQD2IaAN+poYV9cJQy6JTNkmnQwgCmKegudzXGLeOQqvypxuew9EitQCsbWL1619N0aw6fqRabS7WpsqwhLwGs5klAqcZwvOkKNKR7nqLDQ/XqZwCyyh9Gr0Nct2uU1kJRUPTd7wOip86iCMo7t6eywGaboETtiSurIYf8uWX/hHQseeJwIEBvJ6aSV+vuAoKZyut7qDiNdkp9ZEvf1d9jBWANXCwDzxT32aut6Y1cFWL3WwjCKq9fNkGdkHaluBPOeScM4emOJ86uwd6ZbZkbMHPF9WUMul3T8T1/sD8cUN46RCO+f1uQvulpUN9q9qdcIb/M9x8P1kRj7eU94UrI3ep1WG65+EWw9LxuwcMt6d/FTrZSEx0h6oILXqBYSded6o02LaL/rJJe6ET7vIovRcJ836NAY7yda7Hqsq45dST0E9uCyqaBi4usVtsyth01Zx+xGrBpq5ovSF35/OD6FWj6rN7yLGIRSKw05SZ3wzyUSpqUu0UQrAIPNhpLIeE78QeapNzhYfeRkj7my6mUN99BqJBpIyTJFZo6n5B1fPQ0bYsKvcgU/gp3bFaQkkZ9x0+lpUt5Z4za3anlOAORl2G8YLRbkTLDWXZJPnavnOHIVfWe3p/OPCQJC3j/CaevE9NTAOBcneDjDMMZVi8RKP7kNsdfdRuLV+al8SYjO8ssNwbd7YN9RslJHiHN5MxRB4CoXmM0jmTZL8NUK6keGcx4oyMekZg/PHOjL2DNGqCPG5EUm+XRSgVlR+a9DOIRfH8BabngNtn1WK6RAz8r5k55WpHjYFLSOWHV59WwHGILm9p4Ok8A9Q==
Received: from ?IPV6:2003:cb:c70a:4d00:b968:9e7a:af8b:adf7? (p200300cbc70a4d00b9689e7aaf8badf7.dip0.t-ipconnect.de. [2003:cb:c70a:4d00:b968:9e7a:af8b:adf7])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b003392206c808sm9629533wrv.105.2024.02.13.06.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:05:15 -0800 (PST)
Message-ID: <f93e5552-5e46-4f49-918a-21b63156eb32@redhat.com>
Date: Tue, 13 Feb 2024 15:05:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>
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
 <3de2130b-9f0f-4a11-ac06-7bf814de641c@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3de2130b-9f0f-4a11-ac06-7bf814de641c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 15:02, Ryan Roberts wrote:
> On 13/02/2024 13:45, David Hildenbrand wrote:
>> On 13.02.24 14:33, Ard Biesheuvel wrote:
>>> On Tue, 13 Feb 2024 at 14:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 13/02/2024 13:13, David Hildenbrand wrote:
>>>>> On 13.02.24 14:06, Ryan Roberts wrote:
>>>>>> On 13/02/2024 12:19, David Hildenbrand wrote:
>>>>>>> On 13.02.24 13:06, Ryan Roberts wrote:
>>>>>>>> On 12/02/2024 20:38, Ryan Roberts wrote:
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>>>>> +static inline bool mm_is_user(struct mm_struct *mm)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>> +     * Don't attempt to apply the contig bit to kernel mappings,
>>>>>>>>>>>>> because
>>>>>>>>>>>>> +     * dynamically adding/removing the contig bit can cause page
>>>>>>>>>>>>> faults.
>>>>>>>>>>>>> +     * These racing faults are ok for user space, since they get
>>>>>>>>>>>>> serialized
>>>>>>>>>>>>> +     * on the PTL. But kernel mappings can't tolerate faults.
>>>>>>>>>>>>> +     */
>>>>>>>>>>>>> +    return mm != &init_mm;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>
>>>>>>>>>>>> We also have the efi_mm as a non-user mm, though I don't think we
>>>>>>>>>>>> manipulate
>>>>>>>>>>>> that while it is live, and I'm not sure if that needs any special
>>>>>>>>>>>> handling.
>>>>>>>>>>>
>>>>>>>>>>> Well we never need this function in the hot (order-0 folio) path, so I
>>>>>>>>>>> think I
>>>>>>>>>>> could add a check for efi_mm here with performance implication. It's
>>>>>>>>>>> probably
>>>>>>>>>>> safest to explicitly exclude it? What do you think?
>>>>>>>>>>
>>>>>>>>>> Oops: This should have read "I think I could add a check for efi_mm here
>>>>>>>>>> *without* performance implication"
>>>>>>>>>
>>>>>>>>> It turns out that efi_mm is only defined when CONFIG_EFI is enabled I
>>>>>>>>> can do
>>>>>>>>> this:
>>>>>>>>>
>>>>>>>>> return mm != &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm != &efi_mm);
>>>>>>>>>
>>>>>>>>> Is that acceptable? This is my preference, but nothing else outside of efi
>>>>>>>>> references this symbol currently.
>>>>>>>>>
>>>>>>>>> Or perhaps I can convince myself that its safe to treat efi_mm like
>>>>>>>>> userspace.
>>>>>>>>> There are a couple of things that need to be garanteed for it to be safe:
>>>>>>>>>
>>>>>>>>>       - The PFNs of present ptes either need to have an associated struct
>>>>>>>>> page or
>>>>>>>>>         need to have the PTE_SPECIAL bit set (either pte_mkspecial() or
>>>>>>>>>         pte_mkdevmap())
>>>>>>>>>
>>>>>>>>>       - Live mappings must either be static (no changes that could cause
>>>>>>>>> fold/unfold
>>>>>>>>>         while live) or the system must be able to tolerate a temporary fault
>>>>>>>>>
>>>>>>>>> Mark suggests efi_mm is not manipulated while live, so that meets the
>>>>>>>>> latter
>>>>>>>>> requirement, but I'm not sure about the former?
>>>>>>>>
>>>>>>>> I've gone through all the efi code, and conclude that, as Mark suggests, the
>>>>>>>> mappings are indeed static. And additionally, the ptes are populated
>>>>>>>> using only
>>>>>>>> the _private_ ptep API, so there is no issue here. As just discussed with
>>>>>>>> Mark,
>>>>>>>> my prefereence is to not make any changes to code, and just add a comment
>>>>>>>> describing why efi_mm is safe.
>>>>>>>>
>>>>>>>> Details:
>>>>>>>>
>>>>>>>> * Registered with ptdump
>>>>>>>>         * ptep_get_lockless()
>>>>>>>> * efi_create_mapping -> create_pgd_mapping … -> init_pte:
>>>>>>>>         * __ptep_get()
>>>>>>>>         * __set_pte()
>>>>>>>> * efi_memattr_apply_permissions -> efi_set_mapping_permissions … ->
>>>>>>>> set_permissions
>>>>>>>>         * __ptep_get()
>>>>>>>>         * __set_pte()
>>>>>>>
>>>>>>> Sound good. We could add some VM_WARN_ON if we ever get the efi_mm via the
>>>>>>> "official" APIs.
>>>>>>
>>>>>> We could, but that would lead to the same linkage issue, which I'm trying to
>>>>>> avoid in the first place:
>>>>>>
>>>>>> VM_WARN_ON(IS_ENABLED(CONFIG_EFI) && mm == efi_mm);
>>>>>>
>>>>>> This creates new source code dependencies, which I would rather avoid if
>>>>>> possible.
>>>>>
>>>>> Just a thought, you could have a is_efi_mm() function that abstracts all that.
>>>>>
>>>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>>>> index c74f47711f0b..152f5fa66a2a 100644
>>>>> --- a/include/linux/efi.h
>>>>> +++ b/include/linux/efi.h
>>>>> @@ -692,6 +692,15 @@ extern struct efi {
>>>>>
>>>>>    extern struct mm_struct efi_mm;
>>>>>
>>>>> +static inline void is_efi_mm(struct mm_struct *mm)
>>>>> +{
>>>>> +#ifdef CONFIG_EFI
>>>>> +       return mm == &efi_mm;
>>>>> +#else
>>>>> +       return false;
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>>    static inline int
>>>>>    efi_guidcmp (efi_guid_t left, efi_guid_t right)
>>>>>    {
>>>>>
>>>>>
>>>>
>>>> That would definitely work, but in that case, I might as well just check for it
>>>> in mm_is_user() (and personally I would change the name to mm_is_efi()):
>>>>
>>>>
>>>> static inline bool mm_is_user(struct mm_struct *mm)
>>>> {
>>>>           return mm != &init_mm && !mm_is_efi(mm);
>>>> }
>>>>
>>>> Any objections?
>>>>
>>>
>>> Any reason not to use IS_ENABLED(CONFIG_EFI) in the above? The extern
>>> declaration is visible to the compiler, and any references should
>>> disappear before the linker could notice that efi_mm does not exist.
>>>
>>
>> Sure, as long as the linker is happy why not. I'll let Ryan mess with that :)
> 
> I'm not sure if you are suggesting dropping the mm_is_efi() helper and just use
> IS_ENABLED(CONFIG_EFI) in mm_is_user() to guard efi_mm, or if you are suggesting
> using IS_ENABLED(CONFIG_EFI) in mm_is_efi() instead of the ifdefery?
> 
> The former was what I did initially; It works great, but I didn't like that I
> was introducing a new code dependecy between efi and arm64 (nothing else outside
> of efi references efi_mm).
> 
> So then concluded that it is safe to not worry about efi_mm (thanks for your
> confirmation). But then David wanted a VM_WARN check, which reintroduces the
> code dependency. So he suggested the mm_is_efi() helper to hide that... This is
> all starting to feel circular...

I think Ard meant that inside mm_is_efi(), we could avoid the #ifdef and 
simply use IS_ENABLED().

-- 
Cheers,

David / dhildenb


