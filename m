Return-Path: <linux-kernel+bounces-35312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84CA838F62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CACAB26C12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD205EE85;
	Tue, 23 Jan 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSjS2GNe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F665FF03
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015185; cv=none; b=Na6LkI/y23lHPxSebc337dT/w2h48I/HHxM2LafTGJncJ2kVu6Q3TZUlASCKp6w5GMkKhFmvGcuF4z2UXIgMQldNzde1tIWO3pRt9f8U1EcHZb/otxYbpnPQLxxstrvKVnKKc9TszSHFtsvW1IOCgmuFNAJpkhR73n2ZPjwI1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015185; c=relaxed/simple;
	bh=rWTpoy2IULBbk4dO8cvIhOjJ8xhuJs9AukBufe5CU0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snObcLN1v8S57JmATW0AHrMLGH1r2Oq8xb93V2+wAFzzHQJnBXUFPimC+OHMFD/TtWCkRFBlu2scwzu/GUP7ishleZ6FIFTac4LctxFPzHMChCCswlodPLAEtrDUY+PyZXBW84EBIMSP48Sc0yUx5fZeWKlK1nP5VdAjIn/BDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSjS2GNe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706015182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9ZO5/S+WkNilMPFC8u75P1EqsJQAK0BAvGyC/8CmXAo=;
	b=YSjS2GNe2ebjammJRRd/GyRQ3zGSArl8bwsn5Poh5WpPoCpaPTsCPPTIfIBa3t1rXaoRIL
	EIbP/KZNg1vVenizcGytJ8hEm0M5M+sbgqHZZpIYT5rX/vsaoByoiJLwKOCaXHMb5P/I7r
	Q4XYV5SDkqlwVfwUtgZabwcykM9oaWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-5BWs_ywnOlCYYzb_OGCSKg-1; Tue, 23 Jan 2024 08:06:21 -0500
X-MC-Unique: 5BWs_ywnOlCYYzb_OGCSKg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337d2ccaab0so2503683f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015180; x=1706619980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZO5/S+WkNilMPFC8u75P1EqsJQAK0BAvGyC/8CmXAo=;
        b=LoKb+Ut9IHm784cPwRgfD8Hv0GUlDtj4V2J7dOVNoeJNQelpr2Sl+bTFoVQzTVCkFG
         L7KIt+VIcpHI0tjhZoopml2J/rMtd0frkyMsBQPs6LFQljpUiVs/1WaBRArM3Z1fCVAj
         AMJldAZMnMu40GoxS9D4jYU/etnVAUXhaD2GANTxhstA+5kq8J3oAkqUJxCBfoheHCzj
         JHR3UvwNqtNKRFq2ige9gzESmukkJAALEaedZFs0FOny9dWZDu/s6KxgVRBz0i4OdUQj
         /cIXQ7G4DmBkemjsYtJfo8MFYIYdyy/Ohp5NLj3Rn2m+P3fn9VgeEump+pCo3mpRl92k
         dPdw==
X-Gm-Message-State: AOJu0YwTcsZ78hBt52jd/UyVItp88yWXjJ9VRtscq+QAUd5Q0lVBdX8I
	X++3xlbGj4Y2TbOEHmav0RhfHs7yMI8gdoiidBu0Np0PpECNKRXzs9UYukXWSdh01xw9cpiKzrJ
	YytDvJELlkgfVHTSrNJdI3LxKWaPmS1n4FIswcUmFygMpuKmxLP1NqLpBzQzbwDpzwLjkJg==
X-Received: by 2002:a05:6000:1012:b0:336:6dd3:bfcf with SMTP id a18-20020a056000101200b003366dd3bfcfmr3242299wrx.121.1706015180237;
        Tue, 23 Jan 2024 05:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxwabGnuZ5662MibBSnjCQiIAfXFlXMdO5ToPcXe4cQUWhf8E4e/TKd7vjqnqy/svNYk3hvg==
X-Received: by 2002:a05:6000:1012:b0:336:6dd3:bfcf with SMTP id a18-20020a056000101200b003366dd3bfcfmr3242259wrx.121.1706015179841;
        Tue, 23 Jan 2024 05:06:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c741:de00:bf0f:cd46:dc1c:2de9? (p200300cbc741de00bf0fcd46dc1c2de9.dip0.t-ipconnect.de. [2003:cb:c741:de00:bf0f:cd46:dc1c:2de9])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d4e87000000b00337d56264d4sm13371802wru.8.2024.01.23.05.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 05:06:19 -0800 (PST)
Message-ID: <76740e33-9b52-4e23-b407-8ae38bac15ec@redhat.com>
Date: Tue, 23 Jan 2024 14:06:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] mm/memory: ignore dirty/accessed/soft-dirty bits
 in folio_pte_batch()
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
 <20240122194200.381241-11-david@redhat.com>
 <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.01.24 13:25, Ryan Roberts wrote:
> On 22/01/2024 19:41, David Hildenbrand wrote:
>> Let's ignore these bits: they are irrelevant for fork, and will likely
>> be irrelevant for upcoming users such as page unmapping.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index f563aec85b2a8..341b2be845b6e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -953,24 +953,30 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>>   	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>   }
>>   
>> +static inline pte_t __pte_batch_clear_ignored(pte_t pte)
>> +{
>> +	return pte_clear_soft_dirty(pte_mkclean(pte_mkold(pte)));
>> +}
>> +
>>   /*
>>    * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>>    * pages of the same folio.
>>    *
>>    * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
> 
> nit: last char should be a comma (,) not a full stop (.)
> 
>> + * the accessed bit, dirty bit and soft-dirty bit.
>>    */
>>   static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>   		pte_t *start_ptep, pte_t pte, int max_nr)
>>   {
>>   	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>>   	const pte_t *end_ptep = start_ptep + max_nr;
>> -	pte_t expected_pte = pte_next_pfn(pte);
>> +	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte));
>>   	pte_t *ptep = start_ptep + 1;
>>   
>>   	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>   
>>   	while (ptep != end_ptep) {
>> -		pte = ptep_get(ptep);
>> +		pte = __pte_batch_clear_ignored(ptep_get(ptep));
>>   
>>   		if (!pte_same(pte, expected_pte))
>>   			break;
> 
> I think you'll lose dirty information in the child for private mappings? If the
> first pte in a batch is clean, but a subsequent page is dirty, you will end up
> setting all the pages in the batch as clean in the child. Previous behavior
> would preserve dirty bit for private mappings.
> 
> In my version (v3) that did arbitrary batching, I had some fun and games
> tracking dirty, write and uffd_wp:
> https://lore.kernel.org/linux-arm-kernel/20231204105440.61448-2-ryan.roberts@arm.com/
> 
> Also, I think you will currently either set soft dirty on all or none of the
> pages in the batch, depending on the value of the first. I previously convinced
> myself that the state was unimportant so always cleared it in the child to
> provide consistency.

Good points regarding dirty and soft-dirty. I wanted to avoid passing 
flags to folio_pte_batch(), but maybe that's just what we need to not 
change behavior.

-- 
Cheers,

David / dhildenb


