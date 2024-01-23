Return-Path: <linux-kernel+bounces-35207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DABFF838D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0921F24C52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A15D8E7;
	Tue, 23 Jan 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvhrH7+b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812C5D73B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010032; cv=none; b=d+rQrg/sgiTqF/XIVC0xaQYq3XbYwabjVQfWxTygkfyhhkzgqVXytvIAjASL5Kyf8DJGboEPQksLd8oVkdvK4nqlIVXQtzps4TgHXaa8NNOMW2gX/dgEWszes9/j11PG8rZf4tOjP2fL/8kcg3ZKtxun4CXHRZwmtJZ3p4i+sdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010032; c=relaxed/simple;
	bh=3lw6fkEeKPQQpby9h20PCdsfOK4dXffCnjpHFKUVZKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITx0SWfZzF4pXOLco0Ah/sy2TvJQwOVutHFYuv5n9ivyO3ya5ztZ6bFBxWof8fOVrvw55mFSWCeNgk5SvArhafuNLT45r7BNvzJd1B5j8lmrJOAWOwvS2Ofxmtkfe9qTQhTxj9Dxv40Z/JTTkpjI2A9Lipu1215aoxtmgPWtnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvhrH7+b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706010030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mHQJhRmmFuVPQzf2Ks7ba/QVJg0CSBYgTnFxRHPHOBc=;
	b=YvhrH7+bS2kujALY3KWebTiqVv+qOsGbouiXaxtxBHmIjIcOEeJ/EL13WDwR1E0oSBOZ3G
	tMtjJg/waM5+xBUxk0KToisheBU9igyZx1FuFgTGfvEmiYNgcnV1PqRzzcCKZWP/kyNeIH
	cxUgbb4EShNiodgVpChy59Q67mabzQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-jJclY4itPTaHPSiViRKNfw-1; Tue, 23 Jan 2024 06:40:28 -0500
X-MC-Unique: jJclY4itPTaHPSiViRKNfw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33920ab4159so2050473f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010027; x=1706614827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHQJhRmmFuVPQzf2Ks7ba/QVJg0CSBYgTnFxRHPHOBc=;
        b=fYiMmdtAay9AlM5MrOhudECUoz28KjvFz2+SYgBGNIk5LbjAF0j5pEpITccOmg5S8e
         UQEIioBo3LMNrbzrcA8+l6wo1RBgeEP7SQJ5+YB5Vvbs4xcdYJasLhPWoXPF6Va0nA7h
         JDojUM8mVI2N/vIs97tD4kcSHFNalomJI5KESfypvVcyTfbwzOLjAHBH4ilpIVdlOv8v
         nvK6rbdzt0oJOGZwdSSkdlaZlRylp1Hw4Gls+5OoXSDbZ0Om26HkUeDBetE6MLkP0PMq
         31FooBMjvlAeg42Wb0mY1dxGvomjX/1HQASt3v1CCn/eTfxa5KX/lJkNYn5OxTeLZr56
         tXuw==
X-Gm-Message-State: AOJu0Yx+7XIOrMRwpPax+hTWnbjsMtZ9svVP7KwXiB6Pibo1xFVrz8j4
	mMr6HvYc/RGD1R8SgvdkfzknjTyIa9owyxfFDKE8lzT3xcrprUEZSkwaqbyThH/8bGEMr9hhF68
	EVYfdUpWmBEcj5TvuUx+Hgh0kehRFkOICBMwkFuLHs5dvomfDhtg7fsekdkRJlg==
X-Received: by 2002:a05:600c:4f12:b0:40e:bf59:8246 with SMTP id l18-20020a05600c4f1200b0040ebf598246mr46519wmq.117.1706010027562;
        Tue, 23 Jan 2024 03:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1kFvm+DlgIqRqwbxyQH1B05JVSmcOI99Tf5Z/okgQJwonXU9OBUcVluhtsVk4NbD4ebx2hg==
X-Received: by 2002:a05:600c:4f12:b0:40e:bf59:8246 with SMTP id l18-20020a05600c4f1200b0040ebf598246mr46493wmq.117.1706010027150;
        Tue, 23 Jan 2024 03:40:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c741:de00:bf0f:cd46:dc1c:2de9? (p200300cbc741de00bf0fcd46dc1c2de9.dip0.t-ipconnect.de. [2003:cb:c741:de00:bf0f:cd46:dc1c:2de9])
        by smtp.gmail.com with ESMTPSA id jb13-20020a05600c54ed00b0040e418494absm41219877wmb.46.2024.01.23.03.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:40:26 -0800 (PST)
Message-ID: <794c1dc3-520c-4030-b0fe-e24782576347@redhat.com>
Date: Tue, 23 Jan 2024 12:40:24 +0100
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
To: Ryan Roberts <ryan.roberts@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
 <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
 <ae3d826f-758f-4738-b72a-e99f098bb2b3@csgroup.eu>
 <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
 <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.01.24 12:38, Ryan Roberts wrote:
> On 23/01/2024 11:31, David Hildenbrand wrote:
>>>>
>>>>> If high bits are used for
>>>>> something else, then we might produce a garbage PTE on overflow, but that
>>>>> shouldn't really matter I concluded for folio_pte_batch() purposes, we'd not
>>>>> detect "belongs to this folio batch" either way.
>>>>
>>>> Exactly.
>>>>
>>>>>
>>>>> Maybe it's likely cleaner to also have a custom pte_next_pfn() on ppc, I just
>>>>> hope that we don't lose any other arbitrary PTE bits by doing the pte_pgprot().
>>>>
>>>> I don't see the need for ppc to implement pte_next_pfn().
>>>
>>> Agreed.
>>
>> So likely we should then do on top for powerpc (whitespace damage):
>>
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index a04ae4449a025..549a440ed7f65 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -220,10 +220,7 @@ void set_ptes(struct mm_struct *mm, unsigned long addr,
>> pte_t *ptep,
>>                          break;
>>                  ptep++;
>>                  addr += PAGE_SIZE;
>> -               /*
>> -                * increment the pfn.
>> -                */
>> -               pte = pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
>> +               pte = pte_next_pfn(pte);
>>          }
>>   }
> 
> Looks like commit 47b8def9358c ("powerpc/mm: Avoid calling
> arch_enter/leave_lazy_mmu() in set_ptes") changed from doing the simple
> increment to this more complex approach, but the log doesn't say why.

@Aneesh, was that change on purpose?

-- 
Cheers,

David / dhildenb


