Return-Path: <linux-kernel+bounces-61724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB18515D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F199B28F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247553CF40;
	Mon, 12 Feb 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He4R0PHI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AF3C68C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745424; cv=none; b=mVhudyPd77sIjmeN4368Yq1ER1OFldig6aYMvWMkIbL8HwH8ZuotkYvB54FaSu6h07yACr542Ujf2oR/4ITufcac+bMsg0jGB5y0sblDYrIBr2rZq96gK04QkBjy2Axq91+B9iAQFt/iTKWTlnPY9iSgGxyl9fid+uOcGCrjFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745424; c=relaxed/simple;
	bh=LiMx7F+c/Hz4/umurUDvSeADzmq2KWwpE5HUaPRAGpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf2jA7239SH1I2sg4N9ZE+aiNf1j0UTT0FjAwvNw3OoSBqEMbDLVCAZjDdMEjxk/5CqXEtc38WW6hAsSDJXno0vUCsFu8EIswhU6zsD/IT7+3FbUiqOx7blBGFCH9mE8kHwIn0mEJ+FXPkg306uMFAz/+zvhruiEuANuvXpv8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=He4R0PHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707745421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wql6ivQ7cfc4OGlkQ9/pQHxcP/y4XGqiW0VoGmlxwAI=;
	b=He4R0PHICbifGJSs3p3PoX4C4H7Pbcs2TfNjJ4Pe1HE0TVL52GQEyaaYC896y20xLw3rsJ
	koukPgZytnVCQv1/bLwmtApgiHehbdVKylRWeNFC0h31lBIbisoy8/D2PSC/h/k2Hi4NWH
	fdscv2CmxauPmdiPG9rI3jIWFNcWETQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-drvcT31fPgaP0lvYb6teJg-1; Mon, 12 Feb 2024 08:43:39 -0500
X-MC-Unique: drvcT31fPgaP0lvYb6teJg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-511494630d8so3040373e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745418; x=1708350218;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wql6ivQ7cfc4OGlkQ9/pQHxcP/y4XGqiW0VoGmlxwAI=;
        b=Ngtp4OVTVrtof3zAamyuxIyIDIw495IaqAww4komWDC9ivvm2MTWPlJEN/8SjB8uZU
         lU06mWm32fjKSXtLoWoJEgfrPCrPnjMXw9Bp1ban2x3peaUl0GKKCbjQPE3RsnRX26j6
         aRIbIlpd0BRTpbtLD3mNSkF3o/aVJ/XFgV4/7uKP2h5H0GDbLfFRIuN37LycWHRCxAR+
         CYcS0RXPNdS2JnsOIf4NRl9c4YDv7h3ceCv7vXcUWzD0gfVfLnk+CWU0XNckJ/Y5HIP7
         T8qikHVnOwmQYHE2y3wT8pSETw4konuyXUwgSsfe4sHWhJsiVGJ8sTbdzZ1vCTr1dP9+
         0DXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7lKBxsWy/gj19A/+uviepHhmGeIRnOTcKreId8w87bPiweVe0GlpJSC9v3JG/xkYZqOFSjUvy2QchiRydz5KmtureuqNhmUVTXjIj
X-Gm-Message-State: AOJu0YzrAtR4nvxHiyD4md2kgQsO0JNzK6jOpnive4llzxC+UsiwOVOf
	iknXxLe44Ri/5vD03vK2GuQ7XXLX2aiI9aYHFSuzhGGzs7Ytef583heiYQNOVHxWiYvZ4FMdIaH
	+zFx6UF62xXZAqzGh/EIeH222kK35YnUCleUoeDs4XkVWJOr5DvjRDhduPbE2Gw==
X-Received: by 2002:ac2:47e2:0:b0:511:8691:62d4 with SMTP id b2-20020ac247e2000000b00511869162d4mr3105481lfp.41.1707745418189;
        Mon, 12 Feb 2024 05:43:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHriQcdKIy0G7aOEgD/4n4uO0RMT9q+zAxJ7cTjOxnAz+sySW3XjBKf9f9PuPTe0XDPrZOYOQ==
X-Received: by 2002:ac2:47e2:0:b0:511:8691:62d4 with SMTP id b2-20020ac247e2000000b00511869162d4mr3105466lfp.41.1707745417762;
        Mon, 12 Feb 2024 05:43:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBTSCugyK4m0kq/GNHfB0lyJEkLUmPcOKlvn2K+0vuzkghgMruz8tVe3p6sUzcKM/ZawItMbDvog7lgfKXwWbmElUQeXD2LRZBbwqci/woJI27POHKDlWQ4k/GUmOzV608/DE0bjGoYUzMtMoeDKPyI43pJLX2F3pveJriPR5X7KXLuLYE1HoYe9IqY8/nSUyu87qUO1bffgE+5ReolPunc1tOuOTaerknapWOVcS8fd43CKeQoC9ua21iobkEIDDY+IJjig/jA2uKbwCvoW1l8xggZRyUm4XcWgGmp+21ADcP85s9+9FzLHPl3vr15+lE3LMto5KYsUHBsrdnSDLxHDYGygQlhspbJ2EE8oEpdK+xHPvLHKpmSBp7c4kusUr/64MN/rNj6mvgASmdUofglLNfFQkZCl5+10QrO965RgEcbZWMFxJPMrbOpCPhIUxqGsQ1YQCvdYQaRFcDmx6JKEwIXWx/IVWf9Q+k/cJqDo2i/S+FBOvbGAqOap2smE2oqxIbCTJ5+EW7N2DN2k470wDQcFhI2X55LH2ZdjA5p28RrTS3mInkdhv++XF8fpQ3GK32YPIfAhE0zH47S6OY4SU+TF2xU8PXRl1aXxTxZFyNrzjNibySmJUbFiM2qo7QszGA+aH9FHM51LWSnErQXIFfZEg7Lz5jsLsZHweyi008xnr2uysYJBEqdpshVhv0Tmce6Vw8a3WzaFGniw08QzFQQtgbd0pyZ/Ibo/gnsH0u3n4QF70ljbPFhLoPf68O52p3yxi3EgqmpQsb3+/D1hyQcQBgJC1sBL5CCvk2ZV0pJgpn8m9Hn+sHCGoDidWg2/oRfEc8GLHMXmBU75ScBOSS8Udy1gjGOhWAYKlF
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040fc56712e8sm8754772wmo.17.2024.02.12.05.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:43:37 -0800 (PST)
Message-ID: <6d452a1a-1edc-4e97-8b39-99dc48315bb8@redhat.com>
Date: Mon, 12 Feb 2024 14:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/25] mm: Add pte_batch_hint() to reduce scanning in
 folio_pte_batch()
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
 <20240202080756.1453939-23-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240202080756.1453939-23-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.02.24 09:07, Ryan Roberts wrote:
> Some architectures (e.g. arm64) can tell from looking at a pte, if some
> follow-on ptes also map contiguous physical memory with the same pgprot.
> (for arm64, these are contpte mappings).
> 
> Take advantage of this knowledge to optimize folio_pte_batch() so that
> it can skip these ptes when scanning to create a batch. By default, if
> an arch does not opt-in, folio_pte_batch() returns a compile-time 1, so
> the changes are optimized out and the behaviour is as before.
> 
> arm64 will opt-in to providing this hint in the next patch, which will
> greatly reduce the cost of ptep_get() when scanning a range of contptes.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h | 18 ++++++++++++++++++
>   mm/memory.c             | 20 +++++++++++++-------
>   2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 50f32cccbd92..cba31f177d27 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -212,6 +212,24 @@ static inline int pmd_dirty(pmd_t pmd)
>   #define arch_flush_lazy_mmu_mode()	do {} while (0)
>   #endif
>   
> +#ifndef pte_batch_hint
> +/**
> + * pte_batch_hint - Number of pages that can be added to batch without scanning.
> + * @ptep: Page table pointer for the entry.
> + * @pte: Page table entry.
> + *
> + * Some architectures know that a set of contiguous ptes all map the same
> + * contiguous memory with the same permissions. In this case, it can provide a
> + * hint to aid pte batching without the core code needing to scan every pte.

I think we might want to document here the expectation regarding
dirty/accessed bits. folio_pte_batch() will ignore dirty bits only with
FPB_IGNORE_DIRTY. But especially for arm64, it makes sense to ignore them
always when batching, because the dirty bit may target any pte part of the
cont-pte group either way.

Maybe something like:

"
An architecture implementation may only ignore the PTE accessed and dirty bits.
Further, it may only ignore the dirty bit if that bit is already not
maintained with precision per PTE inside the hinted batch, and ptep_get()
would already have to collect it from various PTEs.
"

I think there are some more details to it, but I'm hoping something along
the lines above is sufficient.


> +
>   #ifndef pte_advance_pfn
>   static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>   {
> diff --git a/mm/memory.c b/mm/memory.c
> index 65fbe4f886c1..902665b27702 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -988,16 +988,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   {
>   	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>   	const pte_t *end_ptep = start_ptep + max_nr;
> -	pte_t expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, 1), flags);
> -	pte_t *ptep = start_ptep + 1;
> +	pte_t expected_pte = __pte_batch_clear_ignored(pte, flags);
> +	pte_t *ptep = start_ptep;
>   	bool writable;
> +	int nr;
>   
>   	if (any_writable)
>   		*any_writable = false;
>   
>   	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>   
> -	while (ptep != end_ptep) {
> +	nr = pte_batch_hint(ptep, pte);
> +	expected_pte = pte_advance_pfn(expected_pte, nr);
> +	ptep += nr;
> +

*Maybe* it's easier to get when initializing expected_pte+ptep only once.

Like:

[...]
pte_t expected_pte, *ptep;
[...]

nr = pte_batch_hint(start_ptep, pte);
expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
ptep = start_ptep + nr;

> +	while (ptep < end_ptep) {
>   		pte = ptep_get(ptep);
>   		if (any_writable)
>   			writable = !!pte_write(pte);
> @@ -1011,17 +1016,18 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		 * corner cases the next PFN might fall into a different
>   		 * folio.
>   		 */
> -		if (pte_pfn(pte) == folio_end_pfn)
> +		if (pte_pfn(pte) >= folio_end_pfn)
>   			break;
>   
>   		if (any_writable)
>   			*any_writable |= writable;
>   
> -		expected_pte = pte_advance_pfn(expected_pte, 1);
> -		ptep++;
> +		nr = pte_batch_hint(ptep, pte);
> +		expected_pte = pte_advance_pfn(expected_pte, nr);
> +		ptep += nr;
>   	}
>   
> -	return ptep - start_ptep;
> +	return min(ptep - start_ptep, max_nr);
>   }

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


