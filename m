Return-Path: <linux-kernel+bounces-35127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A9838C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB7BB2204F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212E5D758;
	Tue, 23 Jan 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2JVeR97"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8A5D720
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006919; cv=none; b=SvkJGe69UG7EMov0ntHKmDF8AmPCNzGIKmtNqSX65crRac6sqzNHSqpYJAcVs/9a67gJsizQXN2CJfgYv3gdz1DkTBkGVNrq5/jdUswNq+z+R5cvnIRumGjD1QlqcrcSuWFRl1Az3pqwyVHwXkSz9Xx8O3sNRR4yCLL2btQXfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006919; c=relaxed/simple;
	bh=F6jHY4OHqd8suD//XVsc3Z8iQWKZmS6tiEwe/yedZag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rl+xvIV8SMPpxjpHoyoEp/CoGYCkhNLmM1suchSsXVaht+S1lkozZ2/unL9fbEaVSic5ln5aKv5F+LBVBkuEj1q/IO6sk0Nd9lY3/+BzJ5RuNmi8QPwgeCiKopxq9TbEbuC/6xQz1O/Vm1UbPkEQPhaqu9uZ/8GsXQOxXnPRSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2JVeR97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706006917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iER4mCfZQHjX5vldd+UfqoqhW1+fd9a/CugQqPAvg1o=;
	b=S2JVeR97Fe8QWuA30jcxCcFcxPeIGBiG9oxLIJvo02NyDqHRrHlR9sw5k2IKB4x3fTEtGr
	dUdZCGDElHSxJGXQkn2l7aV+vuQ8oe4ik9iNwqc8cGFoUB64aRH47XSPbKHTRDM0UNS+IF
	79ona7dlgl8deqDa6WjDfNF/Y2t89l0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-WIH1aHAEMoO_z8rA8o9uNg-1; Tue, 23 Jan 2024 05:48:35 -0500
X-MC-Unique: WIH1aHAEMoO_z8rA8o9uNg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso18252825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006914; x=1706611714;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iER4mCfZQHjX5vldd+UfqoqhW1+fd9a/CugQqPAvg1o=;
        b=fVt8EmBRv9k1laNS3jaonjIgcPuAz5Tei9+CPEQLBt9DVpMhbh3221xmxmE/XlWNQS
         dHEl7AQ2hm3JZ0vXI6io9IjcjEVP03ZdG1bOlXlDcrfSdSapW8NABZXttDfezOjBtacV
         3mnJuf5VjF9Ir0zBd9tQuYzpiPk1RTj4amefcmyxXGGbXtkFLkbT6XuavLX5RKopkKcD
         hiiOIMdJpdE+5QCOVwok8a6oWhWC02KFPE/+7cXOgfPhknkwatA9DYSigIX0iRjASpro
         P+r5qpFLNqG4lsC+uIdvgp5YbJhDViQGtyeMUrm4HXcp6kcQfPJE5EU4GVpsPAqZVK0z
         Q9GQ==
X-Gm-Message-State: AOJu0YxL96Z8oMX14RYHbjUsenovaVbNOTD1j/PKHesArNF7Aodl/KWc
	Jx8WP3Zp+mW7D4KckA/8DpDj5Nmid7A92pL2XEVIHiQbT0iSDLNgwsqTqnsJelg2pGHE4v4xbeR
	hJ1GjjwnFtS8vChybFbwDAiwYnC7TZZwUy7zw5jMDoLtUCiyXG8l5zALQCE6j1Q==
X-Received: by 2002:a05:600c:4515:b0:40e:c047:9336 with SMTP id t21-20020a05600c451500b0040ec0479336mr183554wmo.100.1706006914185;
        Tue, 23 Jan 2024 02:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqy0cgCgqnuoQ6JwnAf+pFGk65GDbL13eMCZ3Z9NsmyiQh16dTSTVkrdqi2eQNG6FMLOCVAw==
X-Received: by 2002:a05:600c:4515:b0:40e:c047:9336 with SMTP id t21-20020a05600c451500b0040ec0479336mr183533wmo.100.1706006913777;
        Tue, 23 Jan 2024 02:48:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c741:de00:bf0f:cd46:dc1c:2de9? (p200300cbc741de00bf0fcd46dc1c2de9.dip0.t-ipconnect.de. [2003:cb:c741:de00:bf0f:cd46:dc1c:2de9])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc346000000b0040d81ca11casm40988147wmj.28.2024.01.23.02.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:48:33 -0800 (PST)
Message-ID: <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
Date: Tue, 23 Jan 2024 11:48:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.01.24 11:34, Ryan Roberts wrote:
> On 22/01/2024 19:41, David Hildenbrand wrote:
>> We want to make use of pte_next_pfn() outside of set_ptes(). Let's
>> simpliy define PFN_PTE_SHIFT, required by pte_next_pfn().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/arm/include/asm/pgtable.h   | 2 ++
>>   arch/arm64/include/asm/pgtable.h | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>> index d657b84b6bf70..be91e376df79e 100644
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -209,6 +209,8 @@ static inline void __sync_icache_dcache(pte_t pteval)
>>   extern void __sync_icache_dcache(pte_t pteval);
>>   #endif
>>   
>> +#define PFN_PTE_SHIFT		PAGE_SHIFT
>> +
>>   void set_ptes(struct mm_struct *mm, unsigned long addr,
>>   		      pte_t *ptep, pte_t pteval, unsigned int nr);
>>   #define set_ptes set_ptes
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 79ce70fbb751c..d4b3bd96e3304 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -341,6 +341,8 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
>>   		mte_sync_tags(pte, nr_pages);
>>   }
>>   
>> +#define PFN_PTE_SHIFT		PAGE_SHIFT
> 
> I think this is buggy. And so is the arm64 implementation of set_ptes(). It
> works fine for 48-bit output address, but for 52-bit OAs, the high bits are not
> kept contigously, so if you happen to be setting a mapping for which the
> physical memory block straddles bit 48, this won't work.

Right, as soon as the PTE bits are not contiguous, this stops working, 
just like set_ptes() would, which I used as orientation.

> 
> Today, only the 64K base page config can support 52 bits, and for this,
> OA[51:48] are stored in PTE[15:12]. But 52 bits for 4K and 16K base pages is
> coming (hopefully v6.9) and in this case OA[51:50] are stored in PTE[9:8].
> Fortunately we already have helpers in arm64 to abstract this.
> 
> So I think arm64 will want to define its own pte_next_pfn():
> 
> #define pte_next_pfn pte_next_pfn
> static inline pte_t pte_next_pfn(pte_t pte)
> {
> 	return pfn_pte(pte_pfn(pte) + 1, pte_pgprot(pte));
> }
> 
> I'll do a separate patch to fix the already broken arm64 set_ptes() implementation.

Make sense.

> 
> I'm not sure if this type of problem might also apply to other arches?

I saw similar handling in the PPC implementation of set_ptes, but was 
not able to convince me that it is actually required there.

pte_pfn on ppc does:

static inline unsigned long pte_pfn(pte_t pte)
{
	return (pte_val(pte) & PTE_RPN_MASK) >> PTE_RPN_SHIFT;
}

But that means that the PFNs *are* contiguous. If high bits are used for 
something else, then we might produce a garbage PTE on overflow, but 
that shouldn't really matter I concluded for folio_pte_batch() purposes, 
we'd not detect "belongs to this folio batch" either way.

Maybe it's likely cleaner to also have a custom pte_next_pfn() on ppc, I 
just hope that we don't lose any other arbitrary PTE bits by doing the 
pte_pgprot().


I guess pte_pfn() implementations should tell us if anything special 
needs to happen.

-- 
Cheers,

David / dhildenb


