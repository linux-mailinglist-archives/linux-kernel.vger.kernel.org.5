Return-Path: <linux-kernel+bounces-132539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9589966E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A491C21658
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60149339A8;
	Fri,  5 Apr 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpIAX7zP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E724B5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301788; cv=none; b=h3jWb/h8tFVw7hkhW28O/hpUp106j95+qQMnd37wfp77xEp+j38L2kCfdFm5tohCi1NUNRlJlg0pakuUIR5m3V5yDB3tgiJSQRFQAMNFjZqw4oZAzJMP4SHrOB0LVOJ4ae6d1QXngSDDDPSXOXEIP68yFLTiAOBwPTKpo7ewL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301788; c=relaxed/simple;
	bh=4zy5R5VMd2UQLQtDJETC066s0vkWdzxcGbp2CLkHw3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRoMOuo847zRyhBNnfgN34xGu7eOP36fXL81+cNpxpoVmhhH4IwE7zzj1soX8x5wo0mow/nReKcd8f3zxPRSNb14vKijVAQ0Jqcc3qpc6wnpGcwjohLQuFqjfwSR3TnMxstU1V9vVJWcMXYXpBO90NopLb1mJBtpiQjwACByxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpIAX7zP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712301785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5bNmy+qfalu205HO5QSi0WdStaw2vHqHKX3BP6Qt0VY=;
	b=NpIAX7zP3n3O8y7B85sUBRZmW0r0FOnxcK7iO1tyQ/d1Ot5VcSZI274qRR9PXpCobH+5Kl
	pqYxjB9Xg1TuZSOspRntMRl3kNDNaqPQ38SWl4zKml4qwXLmOEpdOSVPLFYqKLZHY6RgEl
	YkykCWvRDA5AzRX6lvfq62M1+ROuDlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-808OqmfMM-61XwusJ2kwew-1; Fri, 05 Apr 2024 03:23:04 -0400
X-MC-Unique: 808OqmfMM-61XwusJ2kwew-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c6a990dbso642697f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301783; x=1712906583;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5bNmy+qfalu205HO5QSi0WdStaw2vHqHKX3BP6Qt0VY=;
        b=h0h3VDnpUVBCvDaLdFeVKGm4ZV2W4kUF+IybQZ9KbLHup9IHLd5eQ453/dO7yLWCbs
         /0QfwiY5rpQaPF3cQ631iCMUt5zJuOqtAi3AALOBKUfAUGVTnQfOGhggsEFBt6oNz1tQ
         +HQO+Fo8fzvL1DiZJSrAx0AhxUpeh6seA5tsnmCLVOGVo7pcI7CALH+eil7JaO+retmp
         GyPgh1k/uBn6V6LzH6Lv5H6L3BHcjwgEJ9r3MVz3TJIrmCwrm83dGajFIT2A/juiEAet
         98Fp0HxpN1u+wJJp+5xauhB6OqyDDueYJCWUnT8gD2yuZOIu8QrWJTQS2OFqY2z8l8BY
         X8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWcNn+PE14hWIoYYejfqCMzr14usGPOywMvIvY/QvdoEeEFZrfDTinpy+oKo1DqF4D4qr42rH+tF2CgW021cKDYbnX2p8ViSWU1DAnT
X-Gm-Message-State: AOJu0Yzzi9w87V9StbRWNG6baVz/JLcBGCo5ntYuoZAk65fRVSY+GVDw
	f/rrH65wQKq+CHXBDDB9UtEI/eRQutgiJEfBkKu86GYKE7qaRuIeAFOJOLXWwun6kbbvdzugpRV
	OU4zgjJ9oznv3+lvB1v5eWSfThSfLvO2R+ykgfxvQmBo0PyC7rn8flkxX19vQpw==
X-Received: by 2002:adf:e6cf:0:b0:343:39a6:93bc with SMTP id y15-20020adfe6cf000000b0034339a693bcmr727761wrm.11.1712301782984;
        Fri, 05 Apr 2024 00:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEknfDnC4CBXKnlcXwO0sY2ag+ubd9gEq/3a9mvTrOFUGseBOHvQIiAlmsfSVkzz105VGH54A==
X-Received: by 2002:adf:e6cf:0:b0:343:39a6:93bc with SMTP id y15-20020adfe6cf000000b0034339a693bcmr727740wrm.11.1712301782620;
        Fri, 05 Apr 2024 00:23:02 -0700 (PDT)
Received: from [192.168.3.108] (p4ff2306b.dip0.t-ipconnect.de. [79.242.48.107])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b003434b41c83fsm1288994wrv.81.2024.04.05.00.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:23:02 -0700 (PDT)
Message-ID: <e16806b0-7c17-4356-8b47-30f624756e85@redhat.com>
Date: Fri, 5 Apr 2024 09:23:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] mm/ksm: use folio in write_protect_page
To: alexs@kernel.org, Matthew Wilcox <willy@infradead.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-8-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240325124904.398913-8-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 13:48, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Compound page is checked and skipped before write_protect_page() called,
> use folio to save a few compound_head checking.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---
>   mm/ksm.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 95a487a21eed..5d1f62e7462a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1289,22 +1289,22 @@ static u32 calc_checksum(struct page *page)
>   	return checksum;
>   }
>   
> -static int write_protect_page(struct vm_area_struct *vma, struct page *page,
> +static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>   			      pte_t *orig_pte)
>   {
>   	struct mm_struct *mm = vma->vm_mm;
> -	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
> +	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
>   	int swapped;
>   	int err = -EFAULT;
>   	struct mmu_notifier_range range;
>   	bool anon_exclusive;
>   	pte_t entry;
>   
> -	pvmw.address = page_address_in_vma(page, vma);
> +	pvmw.address = page_address_in_vma(&folio->page, vma);
>   	if (pvmw.address == -EFAULT)
>   		goto out;
>   
> -	BUG_ON(PageTransCompound(page));
> +	VM_BUG_ON(folio_test_large(folio));

I suggest

if (WARN_ON_ONCE(folio_test_large(folio)))
	return err;

before the page_address_in_vma() call.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


