Return-Path: <linux-kernel+bounces-147081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25598A6F39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D61F219FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1012FF9F;
	Tue, 16 Apr 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT/Sm+YR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238912FB02
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279703; cv=none; b=AXR6dVd+wlre0F+OjohqQRpBVFqnXeD8WgaN4KL9M7X6VM7wWYMyptocDLiTn/M8fAvdOyUz9jyaG42D9YjoBHml+OquTLpcB2FbgQD+N2LC1rgbDWvLAWDpDS56w9X4boNWc91Is1WHhhFkIgS025qP0iDAqVNLjAxCFWnFZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279703; c=relaxed/simple;
	bh=EhVd777xQDgrbUo3LNG0Q7bOBjr/gFuogDOHVECwMK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJhblZnG2xytygs5V1Zu0bLJqSQLkm2AFWtwRJPRHb7Okh+d5CpaFDTLup3QQklq6EWpPjgXtbqXbsScsAjg/eoxPXtVCNDeGcSxW8Pb/DyA6PGWULBeEPvLJ2O4/T6x+l63NhXYZy43nLZO+qMOmMHeOy2WNAiyli2bO9RpLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT/Sm+YR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713279697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fX5s6m/aCDM62eaS9flLZpnJ3LNIO1PYs20D2U/G8Js=;
	b=iT/Sm+YRJZFzshqLwSHxxIWc2zE3Jqaa8OaBna4YDAbEpZNUU+z0KeBeuf7GW53eVdUwKU
	lqm+9TZKlqvsYWbQqVxceDCABzTtgM1paRRsSmcTxYxA5h9344By3oLEFnkK19mnZ0LdtO
	+ndENQf7PEHz7TZVNjzVkB57Pr1en7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-RBOZ223nO2e58UgED2vr5Q-1; Tue, 16 Apr 2024 11:01:36 -0400
X-MC-Unique: RBOZ223nO2e58UgED2vr5Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4147de378b9so21085855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279695; x=1713884495;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fX5s6m/aCDM62eaS9flLZpnJ3LNIO1PYs20D2U/G8Js=;
        b=Rrvnv7iQ7BVQ91GyiU3zo9KtreT6h8eGgS20wXsEpaJD+Oga0OElODqd3JajHnhoJM
         Qpevwy4e6R60wXUexxDfqZikl/eB2apzbSAzJAxpXSUAglUhiBMWPlceeg/KZ+W/W9OS
         AEDegxWj1JSq7deFLO2oZtwnNDO06X5iceJOQ2PjOgOppYyqnaTwOXHtYI1NCno3MDwZ
         nx51BqyI/plkKotyH/1+g9wCfm0x3xCiDGcLoQ0FJLHRmqgj7Yts/z0uBrj7Hu4PCtba
         oWMnCF3/5qSHAW1opFCoyWjhDW+iHd3DougMjCYXfHmnXwGsN9W+npqZvEvJF/1nt42h
         SPpA==
X-Forwarded-Encrypted: i=1; AJvYcCWlOZczgTluRxEsr3eLTvzNrmNKbhh6jDoB4UKn/759NMBIziGyDQdcjaEuLbTtBNxCkq8ijAbnyVAUIk9hwxWSgePitpYfVKjCSPGo
X-Gm-Message-State: AOJu0YxMDiR2V50DqPVi9ASimtq5xuq/vzJkN1TiOCU5VlxuGr4qDFCy
	7mfWO+zJRad3vmZDSRSui2watMc2W/7Pf64aak75JRyIGPPyYsyz+BEgU8QDzIGOZ3WL03GrheI
	jVp2F6MRM6OjmhWiXEkTmJbWlJmV5Mz5VyUmiADGaXmT0GxBD8yAl8XsGG8ybeA==
X-Received: by 2002:a05:600c:1549:b0:416:af4d:e3dc with SMTP id f9-20020a05600c154900b00416af4de3dcmr12740797wmg.12.1713279695103;
        Tue, 16 Apr 2024 08:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGxJ5ryD2WsSh3kLujn7GHIi4P+rKRylY9As7PwTpWjgyAX5VEbi4BY6/PHK7ivZYLqdV+xA==
X-Received: by 2002:a05:600c:1549:b0:416:af4d:e3dc with SMTP id f9-20020a05600c154900b00416af4de3dcmr12740759wmg.12.1713279694531;
        Tue, 16 Apr 2024 08:01:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id e1-20020adffd01000000b00343ad4bca7dsm15085363wrr.85.2024.04.16.08.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:01:34 -0700 (PDT)
Message-ID: <a0d9e198-8799-47b9-ac20-8460b984afee@redhat.com>
Date: Tue, 16 Apr 2024 17:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-2-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240416033457.32154-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.24 05:34, Lance Yang wrote:
> This commit introduces clear_young_dirty_ptes() to replace mkold_ptes().
> By doing so, we can use the same function for both use cases
> (madvise_pageout and madvise_free), and it also provides the flexibility
> to only clear the dirty flag in the future if needed.
> 
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/mm_types.h |  9 +++++
>   include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
>   mm/madvise.c             |  3 +-
>   3 files changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c432add95913..28822cd65d2a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1367,6 +1367,15 @@ enum fault_flag {
>   
>   typedef unsigned int __bitwise zap_flags_t;
>   
> +/* Flags for clear_young_dirty_ptes(). */
> +typedef int __bitwise cydp_t;
> +
> +/* Clear the access bit */
> +#define CYDP_CLEAR_YOUNG		((__force cydp_t)BIT(0))
> +
> +/* Clear the dirty bit */
> +#define CYDP_CLEAR_DIRTY		((__force cydp_t)BIT(1))
> +
>   /*
>    * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
>    * other. Here is what they mean, and how to use them:
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e2f45e22a6d1..18019f037bae 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>   }
>   #endif
>   
> -#ifndef mkold_ptes
> -/**
> - * mkold_ptes - Mark PTEs that map consecutive pages of the same folio as old.
> - * @vma: VMA the pages are mapped into.
> - * @addr: Address the first page is mapped at.
> - * @ptep: Page table pointer for the first entry.
> - * @nr: Number of entries to mark old.
> - *
> - * May be overridden by the architecture; otherwise, implemented as a simple
> - * loop over ptep_test_and_clear_young().
> - *
> - * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> - * some PTEs might be write-protected.
> - *
> - * Context: The caller holds the page table lock.  The PTEs map consecutive
> - * pages that belong to the same folio.  The PTEs are all in the same PMD.
> - */
> -static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
> -		pte_t *ptep, unsigned int nr)
> -{
> -	for (;;) {
> -		ptep_test_and_clear_young(vma, addr, ptep);
> -		if (--nr == 0)
> -			break;
> -		ptep++;
> -		addr += PAGE_SIZE;
> -	}
> -}
> -#endif
> -
>   #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>   #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>   static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> @@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   }
>   #endif
>   
> +#ifndef clear_young_dirty_ptes
> +/**
> + * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of the
> + *		same folio as old/clean.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old/clean.
> + * @flags: Flags to modify the PTE batch semantics.
> + *
> + * May be overridden by the architecture; otherwise, implemented by
> + * get_and_clear/modify/set for each pte in the range.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  unsigned int nr, cydp_t flags)
> +{
> +	pte_t pte;
> +
> +	for (;;) {
> +		if (flags == CYDP_CLEAR_YOUNG)
> +			ptep_test_and_clear_young(vma, addr, ptep);
> +		else {
> +			pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +			if (flags & CYDP_CLEAR_YOUNG)
> +				pte = pte_mkold(pte);
> +			if (flags & CYDP_CLEAR_DIRTY)
> +				pte = pte_mkclean(pte);
> +			set_pte_at(vma->vm_mm, addr, ptep, pte);
> +		}
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}

The complier *might* generate a bit faster code if you check for 
CYDP_CLEAR_YOUNG outside of the loop, so you don't have to recheck on 
each loop iteration.

For now, nothing to lose sleep about

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


