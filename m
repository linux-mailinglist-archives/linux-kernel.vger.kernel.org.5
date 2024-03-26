Return-Path: <linux-kernel+bounces-119465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAC88C95A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14ED1C60882
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC3F9EB;
	Tue, 26 Mar 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGdgGqC4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241034C65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470636; cv=none; b=kpba6Z8aqTOwePb+pnUZlr/7Gal2l8q0Wn0rAFnxUBPFDOlaPV57V1cFk65DcPbR4WO6Xq4LsxC3Oy/8SKLbq9R77KzxBYTOovUPMz1lUuRlQe9IL0UE0FhsO8E7Fd2geDZvowECWLGV9x2aZk1CR6KfJWX5MIk20eERFmYZE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470636; c=relaxed/simple;
	bh=eIHr+eKoGxlkH3Z/ei9j0vosdcQWE7v3blti3OGjiuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM/mSssoaPZDOopW6CTndVszwbVQc/ES2eY1qvtMrZto6h4Y/zIel2lVmcStH2MFEiC1bEE4Os6aHGkI/8AIeKzRlUbTOqfTHDjfkPMg/VBnOtP5aavZtLuoixOS6voST7703nx1oNs5d0J2EXvp+PMj7J5vfNuDxA546Hj6ZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGdgGqC4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711470634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nn/mnDpTqidEVrLysEN0UnzTs/KqUQ/RCKtm5EBNTEY=;
	b=fGdgGqC46NQgkvAihd8a+LbfNnQs9iKmoiMGTPlT1jMIL47iZH11q3atpFw9Y2cmUGqYLb
	yNRikloG6/vcautI8V85vJ2qyYpj02zT/t+31ZHemZmoU361KC5tYx8C7mKsS4QjYUIVMC
	W1gnsXFJ8PAm7H6XELFEw/9/01US57U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-f6-sY2cJNUufKVBkMFb2XA-1; Tue, 26 Mar 2024 12:30:31 -0400
X-MC-Unique: f6-sY2cJNUufKVBkMFb2XA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e91f9d422so5331754e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470630; x=1712075430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn/mnDpTqidEVrLysEN0UnzTs/KqUQ/RCKtm5EBNTEY=;
        b=E6OhYRuMuQrr895PDmCXJVKSQ2OLkhc6ULwrgCAEhu6P55XXbWQfkakaAJmyuOWgEl
         6N5P09GIwh4ic9c79PK3zgsT57FkhczpN7V0Qsvj7y3pGP6zZABPTREHL3I/NspUex8m
         Q/3eIuuFxoRC8DI2rYn2AjVnGo7PNnxrWqSN8mxWwUwUn74dy4ZZkKEj9yrVrNtxNsb4
         0rpzjsOAp2Xjf71CAIUE0dCIe2M0JuheVIkhIhl/Co4dl8xgodKNGzMLJW04mQbkL28B
         sSmcIBUv2V2eBymV8yvt16fLhYhMmY1Ax87/291RXbVFkZTACGxyz30Jqcte9j2s4DoB
         BK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWkHoe1NW+bdOmsYuaLJrg5j4d3+jceKWY4Om1Ds6wWfSajOXITkPscNQkwdLIg8KlvGyxVNPHxQOpJqXHPlG6IopbbjK9el9jinu0F
X-Gm-Message-State: AOJu0YwDa1lhL4+Lou8Xh8E1bI6A9SK/IpNgWMJtScHt4/u4wCX5mtaF
	u0PiphO/TFd2zJjTzIOUPgVq/jRZvxh3XQrUBQvfk0cSCO5H8QHO964ZPEivbD0GXbcS1N1qGWF
	U3RkB7U4AfkYZx76HpYKr0Jm8FWpjcfIFvvTaALwKXUqclh4moDR/XnRS5I5LPg==
X-Received: by 2002:a05:6512:608:b0:515:b0ef:2ae3 with SMTP id b8-20020a056512060800b00515b0ef2ae3mr65142lfe.39.1711470629681;
        Tue, 26 Mar 2024 09:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsbc5I3/mdRSiPnDEiL3mXkX65OqA74KylNSG04oG/vkcfYFpydkLdpBsHCPFkF+OzwQjfeg==
X-Received: by 2002:a05:6512:608:b0:515:b0ef:2ae3 with SMTP id b8-20020a056512060800b00515b0ef2ae3mr65115lfe.39.1711470629198;
        Tue, 26 Mar 2024 09:30:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d69c8000000b0033e206a0a7asm12501977wrw.26.2024.03.26.09.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:30:28 -0700 (PDT)
Message-ID: <5d80c368-7ce7-4a44-9cd7-aee3e1c9182b@redhat.com>
Date: Tue, 26 Mar 2024 17:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] mm/gup: Use ptep_get_lockless_norecency()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-3-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215121756.2734131-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 13:17, Ryan Roberts wrote:
> Gup needs to read ptes locklessly, so it uses ptep_get_lockless().
> However, the returned access and dirty bits are unimportant so let's
> switch over to ptep_get_lockless_norecency().
> 
> The wrinkle is that gup needs to check that the pte hasn't changed once
> it has pinned the folio following this model:
> 
>      pte = ptep_get_lockless_norecency(ptep)
>      ...
>      if (!pte_same(pte, ptep_get_lockless(ptep)))
>              // RACE!
>      ...
> 
> And now that pte may not contain correct access and dirty information,
> the pte_same() comparison could spuriously fail. So let's introduce a
> new pte_same_norecency() helper which will ignore the access and dirty
> bits when doing the comparison.
> 
> Note that previously, ptep_get() was being used for the comparison; this
> is technically incorrect because the PTL is not held. I've also
> converted the comparison to use the preferred pmd_same() helper instead
> of doing a raw value comparison.
> 
> As a side-effect, this new approach removes the possibility of
> concurrent read/write to the page causing a spurious fast gup failure,
> because the access and dirty bits are no longer used in the comparison.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

[...]

>   #ifndef __HAVE_ARCH_PTE_UNUSED
>   /*
>    * Some architectures provide facilities to virtualization guests
> diff --git a/mm/gup.c b/mm/gup.c
> index df83182ec72d..0f96d0a5ec09 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2576,7 +2576,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>   	if (!ptep)
>   		return 0;
>   	do {
> -		pte_t pte = ptep_get_lockless(ptep);
> +		pte_t pte = ptep_get_lockless_norecency(ptep);
>   		struct page *page;
>   		struct folio *folio;
> 
> @@ -2617,8 +2617,9 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>   			goto pte_unmap;
>   		}
> 
> -		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> -		    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
> +		if (unlikely(!pmd_same(pmd, *pmdp)) ||
> +		    unlikely(!pte_same_norecency(pte,
> +					ptep_get_lockless_norecency(ptep)))) {
>   			gup_put_folio(folio, 1, flags);
>   			goto pte_unmap;

We pass the pte into pte_access_permitted(). It would be good to mention 
that you checked all implementations.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


