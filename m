Return-Path: <linux-kernel+bounces-84745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B146486AAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63585286002
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA413307B;
	Wed, 28 Feb 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ9k5EHB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04C328DB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111483; cv=none; b=QY4mnEvBEhqMn6lRAOEsISUbRl7k0C/8Rk9ojNF5V/u1E1ve+FFmcDKLr1baH89hOIVS6XS1JIH1vPWCP1xr/iF8Q+3t3Dddnha+55GFpvOCrJRpNAioGxj2BA8/Xqf7R8T9M1ZxBjfP+57gWdd/HaEiRJqJwfBHGjVKFo7wqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111483; c=relaxed/simple;
	bh=Be3t9qcdxeCtd3bczH2cQ8Ym1Grt6Gi+SjyR1CeLF2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWUhSHnQlvyBMnfO8jypJsRNdlTyVg5jp5QEKwn5vfFb+Q09OYBwhWhiSVatPC+/ltiBjLIw9HvZzlwXJPZGHEsCu3RUNKXnyAuK9nZH54k9UqWS2abKmVQs1cuoXj5SZor79xlLxd5XSJGGNjG8ESKoV96CSiDvPrGGBgFmbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJ9k5EHB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709111480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dN6T317PoCbjWQGLhQnKmKdH2dtk/TCnSUmG/U8Ubs0=;
	b=cJ9k5EHB2jbULuyhG7xI2jf8FUkpr1Iu3vlErJAJ94MA2soPm0HjRSJ67Lr1pVDyG1lY7x
	h13iRB0hO9lfY/D6j+kO8s/Q8e2UrNCp5/53135ac0ViFIXXl2cTYoOJWmgdFh7nTpe8hu
	/pfI5iuvaSVBt5mmy/tOT4KlMBFnfGc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-fN5X0l1BNb23cqdGI7lo7g-1; Wed, 28 Feb 2024 04:11:18 -0500
X-MC-Unique: fN5X0l1BNb23cqdGI7lo7g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d23293d981so34576901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111477; x=1709716277;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN6T317PoCbjWQGLhQnKmKdH2dtk/TCnSUmG/U8Ubs0=;
        b=LEZq5PU/NlRTv10pOi7fUibb7I5wTKfIB4uGhhwhX2uQLQYxQhLG5j+cIXODMVK3c7
         ogpReAFxdQEdfGD8akRX/RG+J4ZJ6uf2P2ODyFJLGCauhoqNRONabUkhP14GFBxZnkdD
         2aG3YX3EV7OSA61zlbJ816bIf9v2Le0wFcNkiHlzGiM60XvCvivTeDiq4oydXfY7aQKn
         ckO4xkxfpun8bHb08FoHPrlfCHyW6LwSKMKSURbRMfR8NbHGYSBCvkeXuDTJff6vFAae
         D+LdgL9W+r4KyEZRRemKg+cOI15Kk64IoVpLDwTw32YOk6EOlxbg4F8VaflnTtRvi/+e
         YDMg==
X-Gm-Message-State: AOJu0Yw+anZuRdRSMd9EXH7ZK3AnWo3bSk71ZyOeG8SArIykFzgTsESE
	SVteJLDfDz82/KKens7dQtbcFApmyeqnKQoyRQk+G5zyA7VvWNo/F7l0lFOOJmPE00D1fxBGe9E
	HRe/igzTG2nMPRgZ7i5/0o0pzcX8Qr78WlL6j2fHAKrBQ21Qwrn3Em48ovyza6fiCvCAvmg==
X-Received: by 2002:a05:651c:124b:b0:2d2:5126:5a51 with SMTP id h11-20020a05651c124b00b002d251265a51mr7075144ljh.19.1709111477042;
        Wed, 28 Feb 2024 01:11:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHkx6iVSN3rVE4HxIm2rUXprXHZFwLtKT5APEvaDoJG8o8IKwdVYSKNK0P29Po0bhrs23xgA==
X-Received: by 2002:a05:651c:124b:b0:2d2:5126:5a51 with SMTP id h11-20020a05651c124b00b002d251265a51mr7075131ljh.19.1709111476567;
        Wed, 28 Feb 2024 01:11:16 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d2a8906bdbsm350395ljj.106.2024.02.28.01.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:11:16 -0800 (PST)
Message-ID: <e9c98223-3c75-464f-abe8-4207670fc6dd@redhat.com>
Date: Wed, 28 Feb 2024 10:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory.c: do_numa_page(): remove a redundant page
 table read
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240228034151.459370-1-jhubbard@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240228034151.459370-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.24 04:41, John Hubbard wrote:
> do_numa_page() is reading from the same page table entry, twice, while
> holding the page table lock: once while checking that the pte hasn't
> changed, and again in order to modify the pte.
> 
> Instead, just read the pte once, and save it in the same old_pte
> variable that already exists. This has no effect on behavior, other than
> to provide a tiny potential improvement to performance, by avoiding the
> redundant memory read (which the compiler cannot elide, due to
> READ_ONCE()).
> 
> Also improve the associated comments nearby.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   mm/memory.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0bfc8b007c01..df0711982901 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4928,18 +4928,18 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	int flags = 0;
>   
>   	/*
> -	 * The "pte" at this point cannot be used safely without
> -	 * validation through pte_unmap_same(). It's of NUMA type but
> -	 * the pfn may be screwed if the read is non atomic.
> +	 * The pte cannot be used safely until we verify, while holding the page
> +	 * table lock, that its contents have not changed during fault handling.
>   	 */
>   	spin_lock(vmf->ptl);
> -	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
> +	/* Read the live PTE from the page tables: */
> +	old_pte = ptep_get(vmf->pte);
> +
> +	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>   		pte_unmap_unlock(vmf->pte, vmf->ptl);
>   		goto out;
>   	}
>   
> -	/* Get the normal PTE  */
> -	old_pte = ptep_get(vmf->pte);
>   	pte = pte_modify(old_pte, vma->vm_page_prot);
>   
>   	/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


