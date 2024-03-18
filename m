Return-Path: <linux-kernel+bounces-106111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CC87E94D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBA1F23315
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B73A381C1;
	Mon, 18 Mar 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/GNjHFV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F735F0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764980; cv=none; b=IyZlCd1iXi6GI9ebxlk42tLt2XfxlCSrYmeTLWaUL0sNz3A27gaZVAVXDLyIbusdyvs9SiaxAyijzaLRsJZhHSbUbYdkXd87anNyOY5tEPsd429u9wGm17xYBjScQwItVprE9Jr7mZKgB0KTooH3sD1NjgDl+bLOQAeWoDodNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764980; c=relaxed/simple;
	bh=c03dE12UeJlqwedqJCILCOd1Aabrn0LF0cxuIHLG2CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F9cJFbg5MuEvnl5tMpDlJZ8potj0gfrUwCn3WalSA7sCAHaJmt5yyL+txg0B57poVNqGMu6dPtW23GLzZq+VaQFtE76qFMy+hYqX3Su5DlZ3IFNaaU/FpDrDAXTovAzKPjzJuCKZZ866qpQQRyYekEB0X5r90nXsl9aBxhdaxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/GNjHFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710764977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qd3Ti1yhOKyhE1wdO4t/ObQcvkCuqFS6ubwJ/hFGslE=;
	b=F/GNjHFVyAs+/0CrbTQwEyIzfLnyfOQpK6BQIwlOujMJkaSnmPc2S4eHgT/0whAzadGQkp
	A546OGEtd2aTCvmk6Ka/0TjTXwGP+stlWgQ4sd+KJHe1PK1PrYt3yj9Pn4N8mLpM0gFOLB
	Nz6qMZVasViPbSM6REDgnx/bBuNhZOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-mQ2o3y_QP3eH8xj5NY5RzA-1; Mon, 18 Mar 2024 08:29:36 -0400
X-MC-Unique: mQ2o3y_QP3eH8xj5NY5RzA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41330261f8cso21173385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710764975; x=1711369775;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qd3Ti1yhOKyhE1wdO4t/ObQcvkCuqFS6ubwJ/hFGslE=;
        b=jy9iO6x0UaUwf+jtBvgQga8azyH33Bb55Y/RVolbiSGSPvG03/+kb6tXrhmiGupsJo
         41gLLtsikG2K0Lj2nVEFNnsaGvLHzLh7s32k+QuaPtORW/5MEyVF2e/ldJdN8Qm/U6I/
         3xvLxt7ZAifdjS9gJBQCrNyThVEeqw0Ob7z1MaRLB1iPmBG08eCnA5UiQaRO2u8FvMHY
         4nT+cAiWKqGUz2hcnU91rcF/sClhhfadnhdWm04l9YUubfZDUxdPsPaM44WIqN3yCy5T
         GsMIqPNZdlx/yFoNkf7DrAfDARLwKW2aWnh8EjDs86N2mr9LWzIqCEGMIE2utcFKze37
         Ppyw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8tN4gQkO4ltS1S4MJqwYFfIRGL20RtfoXhSgNiOfuuOa1vM08dt7w3pDavLsc5b13UQDbU8oePz0aCDGgzttkpXz/LdBtEZ++HSN
X-Gm-Message-State: AOJu0Yybnx2XBZA1vcc8D1s/aRGc5bXQNWsfeEJadzPZkZAdcdFmubsC
	cm5WSCnHZ3tI/qRiSkyt7BYwOkiO/LADTrqfh8xgdRjs80RvCp6RqV0m6vnbtQWkGv0D646AdGh
	0tsin8WQUpSa25DvAn3y0Ey4Wt2gynjzp8Vm/JBtGxJXdIQG/izGmvObtaHRenA==
X-Received: by 2002:adf:f68a:0:b0:33e:1ee0:6292 with SMTP id v10-20020adff68a000000b0033e1ee06292mr8701883wrp.58.1710764974904;
        Mon, 18 Mar 2024 05:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXKWayXUSnshm/cgscrcgeZ+/KdZxTg5IOFA7dJBV5T7MU6u5AGUiuKx1zQsFuOlof/ONBXQ==
X-Received: by 2002:adf:f68a:0:b0:33e:1ee0:6292 with SMTP id v10-20020adff68a000000b0033e1ee06292mr8701868wrp.58.1710764974451;
        Mon, 18 Mar 2024 05:29:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b00341798ba0a8sm1446779wrb.87.2024.03.18.05.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 05:29:34 -0700 (PDT)
Message-ID: <bdd94939-efda-443f-9d2b-0e507923fd01@redhat.com>
Date: Mon, 18 Mar 2024 13:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/gup: pass flags by value in faultin_page
Content-Language: en-US
To: yorha.op@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240317124611.81280-1-yorha.op@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240317124611.81280-1-yorha.op@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.03.24 13:46, yorha.op@gmail.com wrote:
> From: Alex Rusuf <yorha.op@gmail.com>
> 
> There's no need to pass flags as a pointer,
> because it's not expected to be changed now.
> 
> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> ---
>   mm/gup.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 231711efa390..f308785fa530 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -915,19 +915,19 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>    * to 0 and -EBUSY returned.
>    */
>   static int faultin_page(struct vm_area_struct *vma,
> -		unsigned long address, unsigned int *flags, bool unshare,
> +		unsigned long address, unsigned int flags, bool unshare,
>   		int *locked)
>   {
>   	unsigned int fault_flags = 0;
>   	vm_fault_t ret;
>   
> -	if (*flags & FOLL_NOFAULT)
> +	if (flags & FOLL_NOFAULT)
>   		return -EFAULT;
> -	if (*flags & FOLL_WRITE)
> +	if (flags & FOLL_WRITE)
>   		fault_flags |= FAULT_FLAG_WRITE;
> -	if (*flags & FOLL_REMOTE)
> +	if (flags & FOLL_REMOTE)
>   		fault_flags |= FAULT_FLAG_REMOTE;
> -	if (*flags & FOLL_UNLOCKABLE) {
> +	if (flags & FOLL_UNLOCKABLE) {
>   		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>   		/*
>   		 * FAULT_FLAG_INTERRUPTIBLE is opt-in. GUP callers must set
> @@ -935,12 +935,12 @@ static int faultin_page(struct vm_area_struct *vma,
>   		 * That's because some callers may not be prepared to
>   		 * handle early exits caused by non-fatal signals.
>   		 */
> -		if (*flags & FOLL_INTERRUPTIBLE)
> +		if (flags & FOLL_INTERRUPTIBLE)
>   			fault_flags |= FAULT_FLAG_INTERRUPTIBLE;
>   	}
> -	if (*flags & FOLL_NOWAIT)
> +	if (flags & FOLL_NOWAIT)
>   		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
> -	if (*flags & FOLL_TRIED) {
> +	if (flags & FOLL_TRIED) {
>   		/*
>   		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
>   		 * can co-exist
> @@ -974,7 +974,7 @@ static int faultin_page(struct vm_area_struct *vma,
>   	}
>   
>   	if (ret & VM_FAULT_ERROR) {
> -		int err = vm_fault_to_errno(ret, *flags);
> +		int err = vm_fault_to_errno(ret, flags);
>   
>   		if (err)
>   			return err;
> @@ -1236,7 +1236,7 @@ static long __get_user_pages(struct mm_struct *mm,
>   
>   		page = follow_page_mask(vma, start, foll_flags, &ctx);
>   		if (!page || PTR_ERR(page) == -EMLINK) {
> -			ret = faultin_page(vma, start, &foll_flags,
> +			ret = faultin_page(vma, start, foll_flags,
>   					   PTR_ERR(page) == -EMLINK, locked);
>   			switch (ret) {
>   			case 0:

Right, possibly my commit

commit 5535be3099717646781ce1540cf725965d680e7b
Author: David Hildenbrand <david@redhat.com>
Date:   Tue Aug 9 22:56:40 2022 +0200

     mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW


Removed the last modifications.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


