Return-Path: <linux-kernel+bounces-61567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371638513B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D51EB25F83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA439FF0;
	Mon, 12 Feb 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP6+QdbS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C983A1BE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741876; cv=none; b=nmN38Z5B0aSojC7bydtXUyp71fM5755t3P1yU6HNT5+vqPDjw+v12DHrZIxMWGDoLvyWGjIL0KAIDCTgDoVdmibZUjBlQ0iN5mEoyhwo5EmjS+9n5rNO5t7hB2onSlkr3TTe+GoGInGjuoc9OreUmkqiLm9ifyAGcrf9yYCGLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741876; c=relaxed/simple;
	bh=RrZ7C1+V3eC1pBeUe7JBTXmLzHWTxbHLfWYqhhpGt5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZCdfD1GQF4yGXVbIdo/CX5GgyuoOiPyhri4u7oUyr9jmb+YhblAv6c38ewlvIK9a0j5NFk2X1K+XAK8YPabx/68hXscQxvoZqw4wpjkExq6Nu/bZ27yKqAkCXMCwx5q2NkdVphW090o1yKgyR8Rg8aG6vhJ5fquNfGCqtVDdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP6+QdbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707741873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxQt4VmIwKD6sNqK2F5SoCirm4b+V1qWF+R3MtkmanE=;
	b=iP6+QdbSM8OtmS88k5ed6LhFGXVEtg56uvD+a+DV117CVlQ5DYCkmxdmxu7RPpJqyNOcUu
	XQ3ZdG5l8WB8AXCXdHKnybNr3tYDzVGSqTDcHNhmPT0z8HYa23GS4fiiS0DDDvsBSlZZj0
	Z+x435TJ88ZQX2D61na1gVRgd5Vs210=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ElUapmj1PTCziDs1HaeZYA-1; Mon, 12 Feb 2024 07:44:32 -0500
X-MC-Unique: ElUapmj1PTCziDs1HaeZYA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b0c264adbso1929177f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741871; x=1708346671;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxQt4VmIwKD6sNqK2F5SoCirm4b+V1qWF+R3MtkmanE=;
        b=iYtZCKA8bo7BYQMwJbYMnKSURclxzSbu6k9lceWNjTo1tEsXZpYN5O26Wcu6mQSVY/
         XU4GMInuBtMsQxKgoODYD5TdK+CAKKftQTATJ85if93bdOqOYIzBbTw2k3dG5k0fphnm
         e8OA7fV504gT65E+gadIx1gg+AzIrI+s41NEIrry6hSDmgnQ4q8SOKlf1SCwmcW0ZbOm
         bVyNK/TqrugpHs4gcd0A9tU8rVxUADBJDT8FqXUtWZKgfCydM6QDCBSzQcboRzuUkNyb
         3FG8c/a7WF7xgSAKsqNNyxFw+5EYfz76l7v8myHmFABomGvuzDyjFQ7h6du/S0PtPimr
         qj8A==
X-Forwarded-Encrypted: i=1; AJvYcCXsANJrvAk9a55iDfLtLnZihP/Cevq15qh520ZBQol8ZLhQC89hyHH4eHoq04dmHyIkoev8Iz/bnsZhi3CeNthIexfvPFEQVSedo48F
X-Gm-Message-State: AOJu0YxLfu3PEyS9jjnaAfxzNkUmQ+TAxpna1GDuDm9xF2JOSumj3m94
	1yAK9aPCHGSgW3EEZo/r4dYXYHZSpcKqDZhpIboEaFBWosko5UaoZWx1EkRc+t8kWKZUnCBeq5j
	CeOjH7tIDAs17No4BQRovTTIfaks+mfRJeMpau6D4Umfle5kxmuGFi+XPZb/4WA==
X-Received: by 2002:a5d:514d:0:b0:33b:3ce6:e1f1 with SMTP id u13-20020a5d514d000000b0033b3ce6e1f1mr4450817wrt.24.1707741871231;
        Mon, 12 Feb 2024 04:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1Rgw5eL0JikDiy1r/QQpL/QxHlZSGiPqnEyLKGoN+62pU3bHS1TIuQ7jLxurQKs/351qeJw==
X-Received: by 2002:a5d:514d:0:b0:33b:3ce6:e1f1 with SMTP id u13-20020a5d514d000000b0033b3ce6e1f1mr4450797wrt.24.1707741870848;
        Mon, 12 Feb 2024 04:44:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/kGBkcH254DgVE4siqKZ5+Qh62PP0z1RwDpGsPTgNddfE+JhflxrpB7HQP6Es9CvEsXjT6jaA6GfRNim2JxrD68ufJb2kYnVabzN77shxlbnrS9dEgXU97/O+c9P2sy5n2/V6S8eyuhbsI2IHi+V75R/G9zqcloprT7HODY54bfYwOWp26+40i3WhXr2CPLqfbKhl3LSpm40IRq+Icyfeq4tfiNP6uWXoQc7nK8go0MWUpbF317t3OhRhn5sEb2J+kJN+/h1mR5LvHCvodOhSFbk9YOVLZzF/4OK9seNVSJRI5MyvAIipTyKiV/Gn9PDI0CjYzOWJ4vb3TFMu9C0dFF/uCrMQhB91oyxsaYrbufm3YkkEjfnjrVYm56A1TnMBsqnzIhOJ3GTER7k4aA/LNdLp229Nc3tTpJ17GVlRaNPiBjztYaLF0IGl5lCvpOU+ksRDcNaB0Q3VICJMuJmkgFR4fODmVH0CJVuA0ZfZzc1yKMTiRdAGukELtLHME6pT+X375JKQGg79bWjKCBd5h+qij/NKB+GzjcWUZmuGs+XgiTGK8A6pspvtarjK6zclc8/JX31l4b5pi/4mfustwyLPH2Sx0BuKUNOnc6YlrNJwkoK1LWM3L5Dx74RGD4HCopz4WzpmQ94cfobKT1SJuhBB4vU4cj+6gyLuDYrg47/1nEc/68JV0H64HyGwBr0FkZT0kZLzr2ezh1KnoGFzP8c3ZXAob3+5vcvsFxy3lf0ZmT9PQxM6KSMxL4qqW7NWCQOhk5WFpFn6QeALp+7/a09DRvb9+ugSfTDS7e0XnZR8BSKiNeuyYLadKA/lKR/QxWcqlLjQk1V8OiDEG4jQIpSBavGQPYf9vY2iWrQq
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id bt25-20020a056000081900b0033b792ed609sm4508483wrb.91.2024.02.12.04.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:44:30 -0800 (PST)
Message-ID: <9e1d793a-02c9-4dbb-a6d4-1e1c0c42638c@redhat.com>
Date: Mon, 12 Feb 2024 13:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/25] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
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
 <20240202080756.1453939-19-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240202080756.1453939-19-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.02.24 09:07, Ryan Roberts wrote:
> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
> trailing DSB. Forthcoming "contpte" code will take advantage of this
> when clearing the young bit from a contiguous range of ptes.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/include/asm/tlbflush.h | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 79e932a1bdf8..50a765917327 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -422,7 +422,7 @@ do {									\
>   #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>   	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false, kvm_lpa2_is_enabled());
>   
> -static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>   				     unsigned long start, unsigned long end,
>   				     unsigned long stride, bool last_level,
>   				     int tlb_level)
> @@ -456,10 +456,19 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
>   				     tlb_level, true, lpa2_is_enabled());
>   
> -	dsb(ish);
>   	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
>   }
>   
> +static inline void __flush_tlb_range(struct vm_area_struct *vma,
> +				     unsigned long start, unsigned long end,
> +				     unsigned long stride, bool last_level,
> +				     int tlb_level)
> +{
> +	__flush_tlb_range_nosync(vma, start, end, stride,
> +				 last_level, tlb_level);
> +	dsb(ish);
> +}
> +
>   static inline void flush_tlb_range(struct vm_area_struct *vma,
>   				   unsigned long start, unsigned long end)
>   {

You're now calling dsb() after 
mmu_notifier_arch_invalidate_secondary_tlbs().


In flush_tlb_mm(), we have the order

	dsb(ish);	
	mmu_notifier_arch_invalidate_secondary_tlbs()

In flush_tlb_page(), we have the effective order:

	mmu_notifier_arch_invalidate_secondary_tlbs()
	dsb(ish);

In flush_tlb_range(), we used to have the order:

	dsb(ish);
	mmu_notifier_arch_invalidate_secondary_tlbs();


So I *suspect* having that DSB before 
mmu_notifier_arch_invalidate_secondary_tlbs() is fine. Hopefully, 
nothing in there relies on that placement.

Maybe wort spelling out in the patch description

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


