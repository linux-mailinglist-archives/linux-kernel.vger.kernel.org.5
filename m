Return-Path: <linux-kernel+bounces-63297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB710852D65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05391C21164
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F332C696;
	Tue, 13 Feb 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh1sooYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E12BB09
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818478; cv=none; b=CkNSD1k0ubOixXNrY7QP93+i7xbsyF77fd59YqgS8f5i6EdGwfVVNvyxn/GK0u814a+aWm3TB0WsdegYlAiMI3kSj87p+RTEPsAJGYgTAFi2RKLlQfyLcOIOrHFR2h5+y1i9c877pBC2thcNobuuJYgxXYs8AxO9r4trQM+eWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818478; c=relaxed/simple;
	bh=Fna94VtW134jeuDu/4mbAch2zMSRGhJ2QaJxUB+xMkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s75Fdfz8eOLfSAn6/tqclmq0jRsJ6kTnrxU9AJxSf6xiZFQi5HspPDNPcgUM6Ye51RNQerKns8rwn6PfISZhEAWaVKehu/58lPl2SNYZI2wYQX/mt5C+dRcKtIPPmM5VSdJvJShQTy+yVj+rhMijK1eL/cXMT5HwSm/6MT+RLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh1sooYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707818475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eOOGhWUSnVV/mhWF+3X1dD2Ux/VRcraCiGty/87ic5E=;
	b=Oh1sooYAxSa+rknXo0Mc6QvPzYeTnKihVgATL+AbwKuySBIAdaoOKULxjbAnavJ0IrbINV
	9puV5AEs1Z54ZVVLsZIFlzDPgdS8sOK2sMmyoxxZGA3AJZc6LaguIwzDWJBYNwhFQP1TT8
	blq6BYYwaZevqYXeyA5SjWUWyeFF+pM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-qHEeaX73M7SJ0kekFTkG4g-1; Tue, 13 Feb 2024 05:01:13 -0500
X-MC-Unique: qHEeaX73M7SJ0kekFTkG4g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b2875eaa9so1602140f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818472; x=1708423272;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOOGhWUSnVV/mhWF+3X1dD2Ux/VRcraCiGty/87ic5E=;
        b=JQTbUkDmU7M3nY5lQuLKv9SmbvUQCaV9n/y/qorZyvU5G83yobUJDtEaUVbS1FpssZ
         KKnt+s8FARToMOen8dBA4gYr4K82r0+Jgq1EAQsto/TUfl4Yzh2UO3OZ5mRXq1yu6cDS
         YEqlCcRG4lZ2KeAH858bCmjWOaekugmVxmvCQav7Huvl/fSGPYRHpsi38uR/hGDotjkt
         p0fb7ZePP5S/pO0f8cuZ3o6qvvmqPyik7lmWVEAzeCrDMnRTVjzrP9IPqZKx5ysLlHXm
         UxflGCwQpurlWvFOUshmFFSekFc7Uy8UCwVoVht20nE3BD5FRZwKTMyVuONpy6OyxZBe
         ylgA==
X-Gm-Message-State: AOJu0Yw86wYmWa8NduRXXHXeeig4dXXrqylG4byYcnq1aN4Fh4ya+e/Q
	zTU9W3kviWDyNDEYWsur9715c6zjyRVXeRiRU7wKk/0PN+pIXjQDy62Q+UGFtWPaIM+6x7pNeej
	LAHerT9GRxBSrLkXEdpwZyFW7J8jFtid8CwCfOqFw8RmD8wo5MPCMt+esGKNDng==
X-Received: by 2002:adf:f4c4:0:b0:33c:e065:992b with SMTP id h4-20020adff4c4000000b0033ce065992bmr388179wrp.59.1707818472396;
        Tue, 13 Feb 2024 02:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo7BuC5azekhcJ4veBIbYxGMm4YlFVCwY/2ZjCujWQgpT7sZoNPy3woF9ZDl+iJe9qYXWKEw==
X-Received: by 2002:adf:f4c4:0:b0:33c:e065:992b with SMTP id h4-20020adff4c4000000b0033ce065992bmr388148wrp.59.1707818471960;
        Tue, 13 Feb 2024 02:01:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4tSd4c2cvHc+FSJzNu6I7YvcbiHAeITmgqMQ3v+uu5dkbtyL7ZejfS8SydmKrGVYVI2NoCvNYUbEbiI2/0cM8PWHPebKFv+CRqnZtkzRtV0M3l7eJqzDIBIyZsTwg86hCU/idzEZ8xm0w2hHOdL2Unqn/a8DAACEel2WyRfZCNfdBB+aXGbCI8kBf4Yhuzvi1YbkLomBQ65xtidyNBdyn7qaWSyXeWicJEyaMQvDaobQrPvNHIiHUVtGOZ0XeEH7J6N86VHiL3pX4cjkCbrwbrH3Pu9GcmjyFNgfrjGXjFIP80s0i5KbqYWPtYHA5/zu+K/iZCF5jqBX+TlnazLvlAuM0eytMQVg0EFjAEdCK1eRVTMZDmBV1T3T7GondGz/ZhJft+3e5eeb/krH8LUWwbDx32ZqdVYzOYtC2YVKXa0QNJq3hmtNIob4ezPKmUz1yvt1j9hgt2kYc9ivPAl5NWGmqI8HJkfuTudMqAtsOfV8MPbWNvUpP700Svv/T8/iKcvSKli0CHL7ni2ncgFgfYadBMHMq/6QO+vGYquDvkk+GjqFFPkBGui72sm/eLmDvGH3G9oQKORJdhNTznQcn/QWIk+Z1obvehZbENa9XU2nYKVqp4Ae8FHBGVcCfZ7H2u3OCsLxmZtPheE9+Br5w/49IZYpK0LYnWDd30g05ewHkKIP2ZkXz8jI/FzkIQgyZ5OVzSQV0KoJj1NcoJm2O41RjgF9VSixn8ugypffHOlTELXkayKidOEI/rQtHN/llW35IwV+4Cp2Dyhl4Lxc+PdveXT8qWEnqLz3H7BqNOruDonASCgQftc8lOJJdRkOunN5CloXVwj2TusSxIAmmAGIiQfScWHKK5RbeXyuboKr+yhYHm0O6w3BzpQ==
Received: from ?IPV6:2003:cb:c70a:4d00:b968:9e7a:af8b:adf7? (p200300cbc70a4d00b9689e7aaf8badf7.dip0.t-ipconnect.de. [2003:cb:c70a:4d00:b968:9e7a:af8b:adf7])
        by smtp.gmail.com with ESMTPSA id h16-20020a056000001000b0033cdedb3e84sm659589wrx.18.2024.02.13.02.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 02:01:11 -0800 (PST)
Message-ID: <39ee7f6b-082e-4bab-98e1-dc2130131160@redhat.com>
Date: Tue, 13 Feb 2024 11:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <64395ae4-3a7d-45dd-8f1d-ea6b232829c5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.24 21:38, Ryan Roberts wrote:
> [...]
> 
>>>>> +static inline bool mm_is_user(struct mm_struct *mm)
>>>>> +{
>>>>> +	/*
>>>>> +	 * Don't attempt to apply the contig bit to kernel mappings, because
>>>>> +	 * dynamically adding/removing the contig bit can cause page faults.
>>>>> +	 * These racing faults are ok for user space, since they get serialized
>>>>> +	 * on the PTL. But kernel mappings can't tolerate faults.
>>>>> +	 */
>>>>> +	return mm != &init_mm;
>>>>> +}
>>>>
>>>> We also have the efi_mm as a non-user mm, though I don't think we manipulate
>>>> that while it is live, and I'm not sure if that needs any special handling.
>>>
>>> Well we never need this function in the hot (order-0 folio) path, so I think I
>>> could add a check for efi_mm here with performance implication. It's probably
>>> safest to explicitly exclude it? What do you think?
>>
>> Oops: This should have read "I think I could add a check for efi_mm here
>> *without* performance implication"
> 
> It turns out that efi_mm is only defined when CONFIG_EFI is enabled. I can do this:
> 
> return mm != &init_mm && (!IS_ENABLED(CONFIG_EFI) || mm != &efi_mm);

Please use all the lines you need ;)

if (IS_ENABLED(CONFIG_EFI) && unlikely(mm == &efi_mm))
	return false;
return mm != &init_mm;

> 
> Is that acceptable? This is my preference, but nothing else outside of efi
> references this symbol currently.

We could also mark MMs in some way to be special.

return mm->is_user;

Then it's easy to extend.

-- 
Cheers,

David / dhildenb


