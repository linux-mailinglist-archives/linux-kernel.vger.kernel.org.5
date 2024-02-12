Return-Path: <linux-kernel+bounces-61951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D198518DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE3D1F21F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6253D0DD;
	Mon, 12 Feb 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3C/A2QW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6F3C490
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755063; cv=none; b=lVJOgoQPZD95JrkF0TjOJIRGemHNqDfoy1qjrqDfK4zSuiJqylszldlfk/EMk6x0u4qHKhHG0LvyJ6sdtc09+iRgMppG8VMUutzlIbPeNKeUk7iVOG9rQCIfuiWtM/SGYXt2YBYBLeTf1KadfkwjErOKdWT1jw0xmUucsg6kq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755063; c=relaxed/simple;
	bh=fhTWGDqJVnvpZDhfwtSMgK0nGfsFr0wROBkm7wiC6cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2kjd7TfntS3Mq48TflFeK/Nf1SsZ6sQGS7sJnNbTeXeuNWq/zX57XbEnUX5+d/KTHkFZKpfyXTsUjXaW26KKYYmLq8N+cfmcmSEegFfP+q9b2XJyuRW4eCw37JMlL1Imvpn+Z4OoVvJkQnrLr+m6gdoeQ6s3eJqfbPnco/nKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3C/A2QW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707755060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GOwkoYQuMIadcYKF6zWQ+GFY38QcIy38SlPZ0TdQSoI=;
	b=C3C/A2QW8Vd+pmjYRw4Xt+vj8ISrKq4oBpK77RBaVGda7rcFtD1uChvJs1//oDyAX0QUwF
	2vTiJ2TrUpA3wLkWY/YzA7a/vvK7BwGI41qWq3nTXeNfFiX2casEDY4X1vUzMOF2o8iCU9
	wroIZOhOOqqcNKfb846ZWLHRqKTELds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-3C9AdAlyN8ajHOxuLiXmgw-1; Mon, 12 Feb 2024 11:24:19 -0500
X-MC-Unique: 3C9AdAlyN8ajHOxuLiXmgw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4114d21fca5so2845835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755058; x=1708359858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOwkoYQuMIadcYKF6zWQ+GFY38QcIy38SlPZ0TdQSoI=;
        b=aUWhO6X1QDMvPTQlQKR9b1SvBuOEo0i/VlvaK5gAL8+RBffbk7EjsOIn6PJNaUgwML
         QFZ6pOWiaffZMa0Mty96VZh3z1Kwz8APX9+evGsToWiEK7UbEjZtCEuujpQ16EBEGQgj
         boc2b+weNloBOvS4VblmvBI7ER7Iptn5meSEnJpIsPQ99gi+tvsLepFP+zOR75hWGddd
         r7DBAAKfA1s+TFOeZa8T2gUvMUiYq3/hXuJaqKEdYXri3Hm9QdBZC1XhkGHWjRb077oa
         zKG5Zj4RHEzVSxErA+8pZHrz7A7SfFKj3PQiCY54oDkwSCWSAAXl2v97McMvU4FNtXzp
         bnVA==
X-Gm-Message-State: AOJu0YzNklg/Woo7hQ/6w85PXQBqBp0FuR9DIoD0uLynY5p2m71XTGvn
	4C1wY6xfKH4ppyZdQE9nH7xQ3drnNOkGGxbP5ztq2iqz3Js3zSMr3orc89MjY+ObLJZq7c1DfG7
	2AP3z+JvZGYiafbrvuEpgabgVO8G0RR9EbCr3gNYyGKsN3UUS8pcShrgBNIynGg==
X-Received: by 2002:a05:600c:190b:b0:410:cba3:e9bd with SMTP id j11-20020a05600c190b00b00410cba3e9bdmr2495708wmq.28.1707755057972;
        Mon, 12 Feb 2024 08:24:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa+/LDsRbiSrsZ5Rbz6fAK2jroCNh9cGIGgIF5DWkXAgF3SQjE5r82GE/sU/WYYMsCIGr5iw==
X-Received: by 2002:a05:600c:190b:b0:410:cba3:e9bd with SMTP id j11-20020a05600c190b00b00410cba3e9bdmr2495688wmq.28.1707755057590;
        Mon, 12 Feb 2024 08:24:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULdexwSi/k/92KIdSOYdk8rpF78Q4lMIQFUDCbWlvl3HIL/Fub6NIzLu+OMbQYR4XFRlWx/dGMhGFMSXsHSg304PacKZwFBjzSMmypGS1rS3TdVBYqfuCcn9H+JQ9H9Vnmm5YfoS3t6RC+wwU1x0MDsL4q2NGV6qyTC+awk89EA4T7LQ9kAjv0ZyaLWgeAFMBZ2etCxohBWcBKH7m7OFqMMcfjv56JNFvl/CFNhDefQNIuRmhWQ8jBwEObTo4kvrFU3iF7q7DXK5SNbow7RpT4zVk0CJ5H9pZwSqGb8LLUGJ6Kg+r4wpsRvDhaa51ZZ7TxEb68iKusA4+0044CgHUR3oQV3sP9sMDO7rN1Kv1ffctEIQzSfS3xor3K907T47af9C2easkgfPeUJyNACy7bvJB9hmOZw6uUqDc4gwf2z43lclyCt91I/kXv4L68EV282UQ6qJFNJLH6hjhlqB3GseeSADKQGgjbD0onQk0lE7rtdzY64Bd/5BqID+MP1M8ql5EhRBUW/z7e411rk4VyJAlsq06K9NbCVR5W0x0G0cAiXWtnzjVGfPdyGjkQGQO4TCc93L2m//nm2ZsdkJP2BNFjYX3xCvIRaM7hQy64hEHM+QBoUmNAVGDHEWAocLQcKq1e9WysOsPx93O7anc8ztt1+LssUF0rn2KT2GNQEDQWrnHyIfQGmHoUTQPZ0PXoPJcpIrFDDqf0YEzrc4QJT3XZRp6ADy5j6mCvXN1uNO9Y23TenQnqwN/PwPyZjEw9qKmWIiF1eIMoQ0c63+U/NGwbOMiaQpGlkUbeO9wfTA7EzzEouzOlCLt9uZf1KkTOScZih1sIawwvya3NYJPBEkbXgAi9PG9jw/E1fCDZzqKkdDbZI0d6XGPJdA==
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id i13-20020adffc0d000000b0033b63a0bd0dsm7214339wrr.109.2024.02.12.08.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:24:17 -0800 (PST)
Message-ID: <55a1e0ef-14b3-4311-b2aa-a6add76fa2ed@redhat.com>
Date: Mon, 12 Feb 2024 17:24:15 +0100
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
 <a91cfe1c-289e-4828-8cfc-be34eb69a71b@redhat.com>
 <502a3ea7-fd86-4314-8292-c7999eda92eb@arm.com>
 <427ba87a-7dd0-4f3e-861f-fe6946b7cd97@redhat.com>
 <abe814c9-71f3-4d7d-bdc8-9dd930d6f0b2@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <abe814c9-71f3-4d7d-bdc8-9dd930d6f0b2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.24 16:34, Ryan Roberts wrote:
> On 12/02/2024 15:26, David Hildenbrand wrote:
>> On 12.02.24 15:45, Ryan Roberts wrote:
>>> On 12/02/2024 13:54, David Hildenbrand wrote:
>>>>>> If so, I wonder if we could instead do that comparison modulo the access/dirty
>>>>>> bits,
>>>>>
>>>>> I think that would work - but will need to think a bit more on it.
>>>>>
>>>>>> and leave ptep_get_lockless() only reading a single entry?
>>>>>
>>>>> I think we will need to do something a bit less fragile. ptep_get() does
>>>>> collect
>>>>> the access/dirty bits so its confusing if ptep_get_lockless() doesn't IMHO. So
>>>>> we will likely want to rename the function and make its documentation explicit
>>>>> that it does not return those bits.
>>>>>
>>>>> ptep_get_lockless_noyoungdirty()? yuk... Any ideas?
>>>>>
>>>>> Of course if I could convince you the current implementation is safe, I
>>>>> might be
>>>>> able to sidestep this optimization until a later date?
>>>>
>>>> As discussed (and pointed out abive), there might be quite some callsites where
>>>> we don't really care about uptodate accessed/dirty bits -- where ptep_get() is
>>>> used nowadays.
>>>>
>>>> One way to approach that I had in mind was having an explicit interface:
>>>>
>>>> ptep_get()
>>>> ptep_get_uptodate()
>>>> ptep_get_lockless()
>>>> ptep_get_lockless_uptodate()
>>>
>>> Yes, I like the direction of this. I guess we anticipate that call sites
>>> requiring the "_uptodate" variant will be the minority so it makes sense to use
>>> the current names for the "_not_uptodate" variants? But to do a slow migration,
>>> it might be better/safer to have the weaker variant use the new name - that
>>> would allow us to downgrade one at a time?
>>
>> Yes, I was primarily struggling with names. Likely it makes sense to either have
>> two completely new function names, or use the new name only for the "faster but
>> less precise" variant.
>>
>>>
>>>>
>>>> Especially the last one might not be needed.
>>> I've done a scan through the code and agree with Mark's original conclusions.
>>> Additionally, huge_pte_alloc() (which isn't used for arm64) doesn't rely on
>>> access/dirty info. So I think I could migrate everything to the weaker variant
>>> fairly easily.
>>>
>>>>
>>>> Futher, "uptodate" might not be the best choice because of PageUptodate() and
>>>> friends. But it's better than "youngdirty"/"noyoungdirty" IMHO.
>>>
>>> Certainly agree with "noyoungdirty" being a horrible name. How about "_sync" /
>>> "_nosync"?
>>
>> I could live with
>>
>> ptep_get_sync()
>> ptep_get_nosync()
>>
>> with proper documentation :)
> 
> but could you live with:
> 
> ptep_get()
> ptep_get_nosync()
> ptep_get_lockless_nosync()
> 
> ?
> 
> So leave the "slower, more precise" version with the existing name.

Sure.

-- 
Cheers,

David / dhildenb


