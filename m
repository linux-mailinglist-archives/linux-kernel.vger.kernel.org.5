Return-Path: <linux-kernel+bounces-158230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933DE8B1D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B89B23294
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F881AA3;
	Thu, 25 Apr 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSA1jr50"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60061DFE4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035681; cv=none; b=Byn1npXt8NEeZ/4q3EAbfVpmoNFf+/6KRlAlWNhPrtBpZruCyldKvsdIlmcQAPOp7vlUbw5qA/jjdSp45DKsyQRxf+1RTnvqhkNeYnEo1H0Bngtjtvpvr0XIA0aCVlV4L8sG6xP2v3JgC4fszp/yVuRxyeR8vKluWPPchdAF17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035681; c=relaxed/simple;
	bh=R/OeS8T3/7Ad1KMp8ZIyz8a/Q3amLDgC/pqomz/JtTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/dydDIUN8MNSMuRmSoPhxyy9P+7bjPJ7mQ6Z/A0KdQ/4HzkGgUOs/nYunufngdDCjkHjkuDx8x9MYlVX5/1b1pQ6Iv2s+Obvo23RcLrACuKt5Clg7E4tZhOMRPndoqi7qugMSCv4GNlFya4lGaGQAG4/QTtgDvyvoSH9oliT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSA1jr50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714035678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cTLZcx23+RXa6+to2zh9cSsCTfbEYQvY2lm+ZXLpqes=;
	b=TSA1jr50Ic8MfA6zszZqdeguRrAf6CDaRVtPryHjPcwLEix7fWPpBNzu1B8Kgw/2VFfa9q
	5z5wWcHftqgbo57cH59T2UJ3tmpVee0kRXsyCyohYAVAMXgSQsXFR8BiG36UlwahoAidoC
	ou9ibzNT2WIijW5XZMS3NYJoXxbmwuk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-w-2_6FqqO4WWmuW5jIOfEw-1; Thu, 25 Apr 2024 05:01:16 -0400
X-MC-Unique: w-2_6FqqO4WWmuW5jIOfEw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416a844695dso3541515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035675; x=1714640475;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTLZcx23+RXa6+to2zh9cSsCTfbEYQvY2lm+ZXLpqes=;
        b=CzA+l4G0bw0WjOFJklnbJk+s1Ejq05LhjNFvrV29FQNEYK5cMltCvoMwgaYKJ99ji+
         dJJpAOaucWHS0q0Gs5Qa50TZM6OOvHJJYqNgCqHieQR60FrKvZl4wDwJLlVOAls/bo43
         rEFdBex1dk9u/e3sKPJKjfhSWf5nA28UEEuyNHa2LLA3tLsQtATLH5p6Z+GY8XaYn9ul
         tG3z2tO9Q9r9LL5K9iscFmwJTlbKkUACEAN8x+Q7XnaxoxsWosZ5wCVb8nLyet/XpAfN
         Aujfk9p9g4GXc/3f56blF7GrNWt9RWZg954vTKz8/q52QlBgHmXgXWU4UsDR9tj7245X
         WuUg==
X-Forwarded-Encrypted: i=1; AJvYcCVTeJmckXIqDDIFU+etW8zgoF4wUg5KgA9YXX880lZWF/URyOqWyD79gxGAd830ec+YP+XmBQ6aMq4t3+9cPSVDsYTyaTJ2NMg3lCBy
X-Gm-Message-State: AOJu0Yz3C73Ql6yfBEwUTWi/1mAV8bjNb2BNfkvXGrLT74JTs8UbF9Yl
	ZSkobtg5YuO9/irJlHt8xCS4IXuZOE90zkQM4kKSEbZW08e+uJ0MZsk5UtRWc8VU7kBtJOnNg4u
	8mKjJ6cG17vilfT/1La/UnHg+26iI5mZ9pqJWFScdw/NCQKBgECV5eqQCSOG8zQ==
X-Received: by 2002:a05:600c:22c7:b0:418:ee2:5911 with SMTP id 7-20020a05600c22c700b004180ee25911mr3685514wmg.28.1714035675350;
        Thu, 25 Apr 2024 02:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnLMTo0ouWsulr3PXIFkUJCPPT1VaaD8aSL6Z9vvprI8sq0FvV5XRVGuo0grGkia+tyb6V2w==
X-Received: by 2002:a05:600c:22c7:b0:418:ee2:5911 with SMTP id 7-20020a05600c22c700b004180ee25911mr3685490wmg.28.1714035674913;
        Thu, 25 Apr 2024 02:01:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b00417e8be070csm26910729wms.9.2024.04.25.02.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:01:14 -0700 (PDT)
Message-ID: <49394660-8455-48ec-8ae1-fbd2d590d27a@redhat.com>
Date: Thu, 25 Apr 2024 11:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, ziy@nvidia.com
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, fengwei.yin@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, maskray@google.com,
 mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiehuan09@gmail.com,
 zokeefe@google.com
References: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
 <20240425085051.74889-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240425085051.74889-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 10:50, Lance Yang wrote:
> Hey Zi, David,

Hi,

> 
> How about this change(diff against mm-unstable) as follows?

goes into the right direction, please resent the whole thing, that will 
make it easier to review.

> 
> I'd like to add __try_to_unmap_huge_pmd() as a new internal function
> specifically for unmapping PMD-mapped folios. If, for any reason, we cannot
> unmap the folio, then we'll still split it as previously done.
> 
> Currently, __try_to_unmap_huge_pmd() only handles lazyfree THPs, but it
> can be extended to support other large folios that are PMD-mapped in the
> future if needed.
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 670218f762c8..0f906dc6d280 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -100,8 +100,6 @@ enum ttu_flags {
>   					 * do a final flush if necessary */
>   	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>   					 * caller holds it */
> -	TTU_LAZYFREE_THP	= 0x100, /* avoid splitting PMD-mapped THPs
> -					  * that are marked as lazyfree. */
>   };
>   
>   #ifdef CONFIG_MMU
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a7913a454028..879c8923abfc 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1606,6 +1606,19 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> +static bool __try_to_unmap_huge_pmd(struct vm_area_struct *vma,
> +				    unsigned long addr, struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> +		return discard_trans_pmd(vma, addr, folio);
> +#endif
> +
> +	return false;
> +}
> +
>   /*
>    * @arg: enum ttu_flags will be passed to this argument
>    */
> @@ -1631,14 +1644,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	if (flags & TTU_SYNC)
>   		pvmw.flags = PVMW_SYNC;
>   
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (flags & TTU_LAZYFREE_THP)
> -		if (discard_trans_pmd(vma, address, folio))
> +	if (flags & TTU_SPLIT_HUGE_PMD) {
> +		if (__try_to_unmap_huge_pmd(vma, address, folio))
>   			return true;
> -#endif
> -
> -	if (flags & TTU_SPLIT_HUGE_PMD)
>   		split_huge_pmd_address(vma, address, false, folio);
> +	}
>   

I was wondering if we can better integrate that into the pagewalk below.

That is, don't do the TTU_SPLIT_HUGE_PMD immediately. Start the pagewalk 
first. If we walk a PMD, try to unmap it. Only if that fails, split it.

Less working on "vma + address" and instead directly on PMDs.

-- 
Cheers,

David / dhildenb


