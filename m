Return-Path: <linux-kernel+bounces-61825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65C851706
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C531C213E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807A3AC14;
	Mon, 12 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLbjyhjJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAA179B5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748149; cv=none; b=JRNxY5QZwDIHCRQIEx/lKbUUU3UPLqpLlALO25+fOHdWdpFRDZT3Bh495pD0mjAA5IfesSG0SRZbK+zlYx6LG3N07SFESQOagKpIZA2peqUE60CeXVQ0vOSaL6X8j4KkQ5wBtVXuh1dr4VvhzZKX3YMrLVrCAsqV1m59C6So+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748149; c=relaxed/simple;
	bh=A3wp2IP/yNmM86Q/WVwL0DtLYx64we30mZY/VVkliU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTL7J25ntO7117ySESBNcsw7FBqQIx4ZiEC1KnrAiCW1iCoLI7LnFg78wHAt6D6HAkzEDRvTIGr61FYAHDG2j3GdIPpMes8Mu3IIP12Erpq1TsdridpVMEWdcosagrnFy0Mc3NVZslFtkQf5KQUiGg3r8WUocNzGXOkTa1iJ0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLbjyhjJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707748146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y1iBmVLe4HVtHWPlPjgAf9jKOA4FlhTnh8w7eMyeSU8=;
	b=hLbjyhjJHno5vJAiEMpukHez/rQOzmwxNMmMz+xSat1hZ40aRt2f7me0HS21HtWeuAmb2X
	gi7TDM+Qw2VuKviPs+OeDjgOK/xqsulB6GTbaw8VMsAPcjRe45Oj0LBB7v0+u97nVAmK4C
	l32raLFQTkMvgmRo3ub0fRBH0SVJtZ4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Al_xOuXuNFSBVNtIARdZrA-1; Mon, 12 Feb 2024 09:29:04 -0500
X-MC-Unique: Al_xOuXuNFSBVNtIARdZrA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51169a55bddso3329796e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748143; x=1708352943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1iBmVLe4HVtHWPlPjgAf9jKOA4FlhTnh8w7eMyeSU8=;
        b=Mf+MlY6p4fDDTqhuZ/majeIm/BLLO3p1rfThPu3WFgjb3H23D/uBEX2tsJIct7llJ9
         AnAFv8oZWvaYWrGs/5QTLEXYqpMGDh0T6pkjmfuNavM3ECU9eGY1xhrpiE5CyMtkuauH
         k1qPAQFKLlVipJwKDPD/6q+3mv2o+ei7mrid9D0oD22ly3TZFBORlk45jmyEhO83YXEE
         sfJ7B/1TjV8+tna8KB01OnbV7gX/mr3m76z7koB8V5R43xXE8D0ry74XVhjTbxnKL4gf
         l5lqgApcX54kaO2/KSxJOf63u4qE3BOgneG782WZ+/cTHfaFplim/CY1Zi4wlxh3u8QR
         7Nqg==
X-Gm-Message-State: AOJu0YzSbIhdKP+yaDhAZa1stseY8RZ4fr0qzrs6oQe5V7B1VcZIMJC1
	GCiLfX0nYlcAHuhtfA+snnd+E5up8Zd0Qq7KJrGHS5yWZqQ4mr+sdJb86fiDh7qgm3g9Z6+KyNj
	OZ8blTAvGV9vIQBRXBpNundygZUPFXCrJ3wYr1awsl693zPHkAPiaO/DPXxQGMg==
X-Received: by 2002:a05:6512:10d6:b0:511:79df:6fbb with SMTP id k22-20020a05651210d600b0051179df6fbbmr6103212lfg.41.1707748143175;
        Mon, 12 Feb 2024 06:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZIAv2vWR8GnyGEMfj/PpLJ5rTzChVdvHt5E3a/obvhgIrOp7r2Gsn6GPEwtKTd1RgfqUxag==
X-Received: by 2002:a05:6512:10d6:b0:511:79df:6fbb with SMTP id k22-20020a05651210d600b0051179df6fbbmr6103178lfg.41.1707748142705;
        Mon, 12 Feb 2024 06:29:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV10iGglTNSiASSJPdNc7cHsOJihnJwmuLBvoB6a70FoqPRTcI3Cy3ghRZxEfejnPaRwKtzistV5YrMC02R1iTWVJbchsHEX1oREncVH3JHtfcT4jn0q/NurqJRJwfbc+l4B3f4qBqSUcBlTKYaSngnFG40We7oOqYM+VfKooc0cYWkhyDODVKeAlTM4dODj1st6T/XDRVC8E6D1mDrG9SxvzL1BDi0n2uOsY9G4tOUI6TWFwnqeP7qFoAE0BHjCLW+WdwAN/O3pqhbw2gR7UiBVWfmpkb23swH3oCVU3M7M6YqGLHd5KWl7ItCQgvBJKVWkzwFdPXs+DCfMtxm+QmBR2St6plaaC8Z+WKNClvwelqqaCyj2JUv8aQDsHNUhh+LW3uf36nKBnrONe4H3LIZ/dv0jM8ODqsPcfxASIXMwp588o8HXwCTqTmvaEMtteX58CFtQEaDVw0dPpEkfPGdYdrfMv6TyAIFJuOK45rU6OBE/AFyhFa5R8JXGWxP/vpVP00V+AR/0xzfgj6tlpwlLDbbamEr8xvm5CtsGeyOGICXDctTTSdO7Kw+hwvC+MxrC6WZdv8dSrdNsH67Jg3rKYsSjrE2MClFdzn7N7uGh3ueeOtoYlbmouius5u6MXMXy3PEicdGmL0Jj/KkViq2qFYOyu5IMlCHtkSr+QeeHhQ+jP9b72SyR/pAY3MzuYp2rEIjwDIrvA6/UDa1jkMPWzLF8zqXqcb2t+rnX4mp4eaa2HjbnqxciPxB1LWPCe+XUcoKx6ypoLTZ4u1QVBfj7bN3ErJNQseLOUGI8/NhzipwKfSyf7r5uF18mX2QLou6tjJotxdciU8bHASie2/EFUmLn6GQUO3ljahcYSDn
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00410bc833c2csm1259221wms.1.2024.02.12.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:29:02 -0800 (PST)
Message-ID: <828d2573-b5fe-43b3-b955-944c05bcdb60@redhat.com>
Date: Mon, 12 Feb 2024 15:29:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] mm: Make pte_next_pfn() a wrapper around
 pte_advance_pfn()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cdf4e537-5b0d-45ba-8094-527127c791a6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 15:10, Ryan Roberts wrote:
> On 12/02/2024 12:14, David Hildenbrand wrote:
>> On 02.02.24 09:07, Ryan Roberts wrote:
>>> The goal is to be able to advance a PTE by an arbitrary number of PFNs.
>>> So introduce a new API that takes a nr param.
>>>
>>> We are going to remove pte_next_pfn() and replace it with
>>> pte_advance_pfn(). As a first step, implement pte_next_pfn() as a
>>> wrapper around pte_advance_pfn() so that we can incrementally switch the
>>> architectures over. Once all arches are moved over, we will change all
>>> the core-mm callers to call pte_advance_pfn() directly and remove the
>>> wrapper.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    include/linux/pgtable.h | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 5e7eaf8f2b97..815d92dcb96b 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -214,9 +214,15 @@ static inline int pmd_dirty(pmd_t pmd)
>>>        #ifndef pte_next_pfn
>>> +#ifndef pte_advance_pfn
>>> +static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>>> +{
>>> +    return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
>>> +}
>>> +#endif
>>>    static inline pte_t pte_next_pfn(pte_t pte)
>>>    {
>>> -    return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>>> +    return pte_advance_pfn(pte, 1);
>>>    }
>>>    #endif
>>>    
>>
>> I do wonder if we simply want to leave pte_next_pfn() around? Especially patch
>> #4, #6 don't really benefit from the change? So are the other set_ptes()
>> implementations.
>>
>> That is, only convert all pte_next_pfn()->pte_advance_pfn(), and leave a
>> pte_next_pfn() macro in place.
>>
>> Any downsides to that?
> 
> The downside is just having multiple functions that effectively do the same
> thing. Personally I think its cleaner and easier to understand the code with
> just one generic function which we pass 1 to it where we only want to advance by
> 1. In the end, there are only a couple of places where pte_advance_pfn(1) is
> used, so doesn't really seem valuable to me to maintain a specialization.

Well, not really functions, just a macro. Like we have set_pte_at() 
translating to set_ptes().

Arguably, we have more callers of set_pte_at().

"Easier to understand", I don't know. :)

> 
> Unless you feel strongly that we need to keep pte_next_pfn() then I'd prefer to
> leave it as I've done in this series.

Well, it makes you patch set shorter and there is less code churn.

So personally, I'd just leave pte_next_pfn() in there. But whatever you 
prefer, not the end of the world.

-- 
Cheers,

David / dhildenb


