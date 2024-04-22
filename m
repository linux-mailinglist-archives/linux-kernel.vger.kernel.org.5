Return-Path: <linux-kernel+bounces-153286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900908ACBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA4A286BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40101465B0;
	Mon, 22 Apr 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f45XrFAn"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B76146591
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785106; cv=none; b=knebgGCyovUvgHetOxRMm2nHYT855Umjw74HPKeNj0cXGwcpbpwXhAxBC+RXxxHAofkqGFtdFQGwV6fSwlhjhAIjDEljpbSS8qeAc2dn9tjkmBR2cF+3ySPrnTrALTe5VV5Ss6DePf7Lsd4eQUBBtieEnN4+8cRUpTyEdHNyYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785106; c=relaxed/simple;
	bh=0au7eGUl2EoSbXg8ChxoL5k6QP9ZDvXQU+TKvB3vxDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hsrjwf3sKQMT35rGwdTv16I0wjEGww0ITW55wOCJLiHBByWOt95BI6nnG/rfqXVXKz2yMaK9a75qT7D8W37ZFwZ5VDUt0xBEQ/GsNmGqvCIZfrF21CfHP7aq1DLCRk3xLZAXzzu9i/Yk4pP/NjpPGwsI1bqbWWq/l3wuWblYZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f45XrFAn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ac074ba920so619299a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713785104; x=1714389904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfhbsSjSAQpd7XXl3LTfiYiNn6Efgvd2Ye+Gxcm0xhc=;
        b=f45XrFAnnGnbu4L38rndx4jqxCcnJaY+u5YWcvA28KxK0fIO0qSKXA2mtlcgF643zZ
         gjCOXVyKa3OJOpEd2dOgw8sXPZaJ97EOhr/FcFMLHM/8iNsMNk2lYYnXuYOvhbcUrdQV
         Vf75CZ1OMbgv30InbdxJsyOGvOl9d0mv+cBsJ7V2VhDadSP5EoCDsGAhGfH+nEngmp2z
         yTvYfIztMGvN7dCMRxwAGVv29ZR9Y6fXNtcCJG3WxWnbIgFrabJ4ep8vZiEoxj6COQ+l
         iYzKM+1+WbIJbtx+p6rrQ3MIet5Qdei09Lg9Sg2DR2sXxJq2qGF2k9MUbrO/frFPhPZw
         8WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785104; x=1714389904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfhbsSjSAQpd7XXl3LTfiYiNn6Efgvd2Ye+Gxcm0xhc=;
        b=d3xW1ij4D6eOPwz3gG4ZSqrX2IsAr5Paeyixa+/jFEnqQS2mmIHXSr/g7GIqcM96BM
         EeB7/1YH6Jc65h6hffcT6InPLXmrkLx6IVIf1ZfghsA3N2oWlq2moTsDaXJatYLQJe73
         UuTr9TDLDP7p5nKb+HIukWudtIvLnx/TsAfdurq+aHTW09nhT7d5a6VaAEWxR1MSsXVR
         alxXajSK019qpubegaVZEuRUxK+htMdwepl7uOIMc398mMfHj0gb4LZ03e3cKmtuoNhA
         fhG7OpgKpF4Ek65RTbtcBJtV0aK8v9wG8lO46I4CH+vXStS/a5oD69udFWx3uvepreXA
         ZN+g==
X-Forwarded-Encrypted: i=1; AJvYcCVSGagfOLFJxOWhm7IX6+qkRltLdsywDOvm474ATKKO/ia2Xw81cNJie6mJ55YlioPiANaB4XpyeHD6Oj9VwwaF+shKz00ekponkTiO
X-Gm-Message-State: AOJu0YyVQuZmAY0QRGmw8tfX4kHW4tHJe/R93BPinvaPnQmgOPXwcIXu
	T6ezhGQ9uBQHxoP+BZV0+htzUxclewwo5dBcyj4t/FrGV3cUXgROl6aECiM7pAOiADyH/vlYs50
	J
X-Google-Smtp-Source: AGHT+IH6McFVbyyNID0uEwYo0iYT78ce7s+Ah7GPPJTyDRKcYEsCyizceMe/sPpJAfL0dz8bWsxepg==
X-Received: by 2002:a17:902:760d:b0:1dd:de68:46cf with SMTP id k13-20020a170902760d00b001ddde6846cfmr10786587pll.6.1713785103696;
        Mon, 22 Apr 2024 04:25:03 -0700 (PDT)
Received: from [10.84.154.17] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001dd82855d47sm7865852plq.265.2024.04.22.04.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:25:03 -0700 (PDT)
Message-ID: <abe2a739-d50c-42b4-8701-ae89435da23e@bytedance.com>
Date: Mon, 22 Apr 2024 19:24:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
Content-Language: en-US
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240422105212.1485788-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/22 18:52, Yajun Deng wrote:
> page_table_lock is a lock that for page table, we won't change page
> table in __anon_vma_prepare(). As we can see, it works well in
> anon_vma_clone(). They do the same operation.
> 
> Remove unnecessary page_table_lock in __anon_vma_prepare().

IIUC, the page_table_lock here is not to protect page table, but as
mentioned in the comments, to prevent concurrent modification by
multiple threads.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   mm/rmap.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..e894640a9327 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -187,7 +187,6 @@ static void anon_vma_chain_link(struct vm_area_struct *vma,
>    */
>   int __anon_vma_prepare(struct vm_area_struct *vma)
>   {
> -	struct mm_struct *mm = vma->vm_mm;
>   	struct anon_vma *anon_vma, *allocated;
>   	struct anon_vma_chain *avc;
>   
> @@ -208,8 +207,6 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>   	}
>   
>   	anon_vma_lock_write(anon_vma);
> -	/* page_table_lock to protect against threads */
> -	spin_lock(&mm->page_table_lock);
>   	if (likely(!vma->anon_vma)) {
>   		vma->anon_vma = anon_vma;
>   		anon_vma_chain_link(vma, avc, anon_vma);
> @@ -217,7 +214,6 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>   		allocated = NULL;
>   		avc = NULL;
>   	}
> -	spin_unlock(&mm->page_table_lock);
>   	anon_vma_unlock_write(anon_vma);
>   
>   	if (unlikely(allocated))

