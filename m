Return-Path: <linux-kernel+bounces-119537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5888CA23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCD11C6273F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951D13D880;
	Tue, 26 Mar 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWS/89xw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55113D538
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472550; cv=none; b=rv5X9Q4dNGaNm/E3XFRAneqyD1mWVf1GhqVAI1Cw4EFBQhI8G3COa9HRtNf2fUTZH6AEQFhn20SzdGmGDlvXH1AnmsqyUI4ujALABn7w96Ef9+7cdYYY5DzQ/B+9G9WWHya6ZamdxnX/zieO2RseInvL91ll+1DMvla7MmY8j/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472550; c=relaxed/simple;
	bh=Wv/33BTcTJ8QNjfvmqHqUBlXZjtELzn2f3TpbsQtRaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB9ghRWcyC+5kbgOJIrRRWb+IdU0niOPEMOHPUN7t5zzT1MnorU49Ox+hz4gJWEE7oGGHVKOxEMCXjL4teDn+zmo4xOcpTMe235vH72QpEG+yOTwKvlqYFPCMaubZmLFtxsZ8Qu8dnMWLiqQXzuW9zKs61msM7wKYjKN0tkZN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWS/89xw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711472547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1uw+Pse+hEjqp2IInnIpkApQjiMh/+MIWQ0lKJPzHCg=;
	b=eWS/89xwqngtbHXxWMWKkPaiXVzi5RjI5yKKJBReDLKsLBJjoo1f5u1vWbo8IpecCsckCm
	EqHkbxJp1dFNEYfM2115YZVvIT/pu8AZ+KFkXGPrbgSMkem9mOnAYIB76USlTifLjuigll
	5Xx488QvTvHJ8Z12XrWAGD0o3fmux7w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-cVZQbs4aNZaPI31Ffx1Ktw-1; Tue, 26 Mar 2024 13:02:26 -0400
X-MC-Unique: cVZQbs4aNZaPI31Ffx1Ktw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41407fd718dso31609525e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472545; x=1712077345;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uw+Pse+hEjqp2IInnIpkApQjiMh/+MIWQ0lKJPzHCg=;
        b=cjw95SkibuLYCI6cxtDr8oa/RbtOfuErlaSssuukdI5yFhFBThX81p3DcQz7f7eGfn
         pTsQZR9sGHvrHMAUo/AUnBvtmEBI/I9qG6HcAJ4VOBK/sFlSCnbzEPEZCuyoyaDH+N/1
         MAn4BTbeGkW4H6v3StTG6LEhDlSMnDDOD+byFXNEr9ew8NCQ5ryFBmUFNem7cR0LXq74
         +Ghw0d7xzkZAjqdahSx+9TNtimnins+X1bkkeK1mCPV6238S63qfBpJN5Qnchg90T66r
         GOTQHU60k/vUDHDHB+Tlnc1GYYdD8T1NnYgULbZVo8l9peIA6BsHY7+L+F/O57CHBGqC
         308A==
X-Forwarded-Encrypted: i=1; AJvYcCWg46mEc1BJrLjh2asibHM9BVbTXqr1NRU5BPy/pZ9WQBCYjdktFI+lpljgKWeQRxa8wg7pb2eCEj9r4A4O/WYGg3Usm9Z9nSDbTadP
X-Gm-Message-State: AOJu0YzISu/+xZq8shE3p+NeJcLVKsvpgJNDih2BfrQoll03HoPLe0y3
	+wUBI14OAt/zKEdw9V2QPicE6hZODbSwPYnXzR2PXl7eLzfn6MHUQYvGKRNhVgAQls76ahuFeSs
	9R8vUcR3vr+k3M/NZ18CzZr8B0HKG63wbhSie436nvP6XtUgXds4DYyvyFQpe5Q==
X-Received: by 2002:a5d:58d9:0:b0:341:b4bf:f0bc with SMTP id o25-20020a5d58d9000000b00341b4bff0bcmr6939837wrf.71.1711472544868;
        Tue, 26 Mar 2024 10:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7MtWaB4IMdU0Fs6kw5+r/J58scc0bGrfuwmJ/itc54CTilbkBjvYCyAJI81RCPhAft7ZJQA==
X-Received: by 2002:a5d:58d9:0:b0:341:b4bf:f0bc with SMTP id o25-20020a5d58d9000000b00341b4bff0bcmr6939812wrf.71.1711472544333;
        Tue, 26 Mar 2024 10:02:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm4164872wrb.98.2024.03.26.10.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:02:23 -0700 (PDT)
Message-ID: <e0bdbd5e-a098-422a-90af-9cf07ce378a4@redhat.com>
Date: Tue, 26 Mar 2024 18:02:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm/memory: Use ptep_get_lockless_norecency()
 for orig_pte
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
 <20240215121756.2734131-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215121756.2734131-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 13:17, Ryan Roberts wrote:
> Let's convert handle_pte_fault()'s use of ptep_get_lockless() to
> ptep_get_lockless_norecency() to save orig_pte.
> 
> There are a number of places that follow this model:
> 
>      orig_pte = ptep_get_lockless(ptep)
>      ...
>      <lock>
>      if (!pte_same(orig_pte, ptep_get(ptep)))
>              // RACE!
>      ...
>      <unlock>
> 
> So we need to be careful to convert all of those to use
> pte_same_norecency() so that the access and dirty bits are excluded from
> the comparison.
> 
> Additionally there are a couple of places that genuinely rely on the
> access and dirty bits of orig_pte, but with some careful refactoring, we
> can use ptep_get() once we are holding the lock to achieve equivalent
> logic.

We really should document that changed behavior somewhere where it can 
be easily found: that orig_pte might have incomplete/stale 
accessed/dirty information.


> @@ -5343,7 +5356,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   						 vmf->address, &vmf->ptl);
>   		if (unlikely(!vmf->pte))
>   			return 0;
> -		vmf->orig_pte = ptep_get_lockless(vmf->pte);
> +		vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte);
>   		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
> 
>   		if (pte_none(vmf->orig_pte)) {
> @@ -5363,7 +5376,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> 
>   	spin_lock(vmf->ptl);
>   	entry = vmf->orig_pte;
> -	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
> +	if (unlikely(!pte_same_norecency(ptep_get(vmf->pte), entry))) {
>   		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>   		goto unlock;

I was wondering about the following:

Assume the PTE is not dirty.

Thread 1 does

vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
/* not dirty */

/* Now, thread 2 ends up setting the PTE dirty under PT lock. */

spin_lock(vmf->ptl);
entry = vmf->orig_pte;
if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
	...
}
..
entry = pte_mkyoung(entry);
if (ptep_set_access_flags(vmf->vma, ...)
..
pte_unmap_unlock(vmf->pte, vmf->ptl);


Generic ptep_set_access_flags() will do another pte_same() check and 
realize "hey, there was a change!" let's update the PTE!

set_pte_at(vma->vm_mm, address, ptep, entry);

would overwrite the dirty bit set by thread 2.

-- 
Cheers,

David / dhildenb


