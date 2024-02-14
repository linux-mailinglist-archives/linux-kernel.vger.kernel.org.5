Return-Path: <linux-kernel+bounces-64930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3F8544CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9026E1F26775
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F7125C2;
	Wed, 14 Feb 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUZ2+EVG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7DCA73
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902054; cv=none; b=atlLecb3YMzhdMw/wpwHZWx1h73WoO7DxbXE25yHv79K8imG3IyM+ndKjPCFx63WZlHGofWLRESvOAq/jgf29hDRm34vsYnCrMhaUQBuLftuhTNpS0SYvobOutlmy4elF63S41H+GaEy+h4h9bUMhD0/GO0IphO/rZThl9rVnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902054; c=relaxed/simple;
	bh=vtR61y4sN+L/+ao7o/NIKSd9KRV2BjPDABQwHbHGFmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFGN6RbCYxYOl2M8I31Y+X/zAQs0sTwlD2OAd8xwvawPZNDmHXo1scPgPjg2izITVoA9C8ZQkvugrR0Ou4bx4kVYN5JuYWi2tIMAYdE3gtswkGRaW1QWJrf88gs0KCdvUGlt2pSsQcpKB8QMlt3jipUv77FiuT6fgSO0WSQqM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUZ2+EVG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707902052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yF6KCGZ2SgAsNegJkudNmU2sSgptrONfebjoagaAkcY=;
	b=BUZ2+EVGqQBgF1YdkZLG8lcFKbmyQ0oWMmIyne/BpcfvOXQS08eYnDxbQBugwGJqtcpVSH
	xmgD/DjtoYPA6ZsZl9a5SZhaxSwLFWdjgDwPWUXGiH+k3sKh9MIrdZPAkrzZg121xJxT8t
	2h6SXZegMEDwWDsf0zo5EwBnsr2+E4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-4YDtbKnbO9umFC5iDUBYjg-1; Wed, 14 Feb 2024 04:14:10 -0500
X-MC-Unique: 4YDtbKnbO9umFC5iDUBYjg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ceca744d9so224104f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902049; x=1708506849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF6KCGZ2SgAsNegJkudNmU2sSgptrONfebjoagaAkcY=;
        b=IU79jlGIwYtXhdkHVDJITF2MmyBKcIsvD0hXOcG93fgoLMjP4m6CEi21fBVGqh27qr
         5PZ9omyzlpOuUn2XxjSM9tGKHiHucoz2vTzhYMQvsNiGaR9hF5ZjUKTTnQ/BwFdGz94p
         dYig5V5g2GwPMHAW5o/u0DUrOm2Q7LD74VMagb/l6qeVmOuQWGfsYPFZDvKTLekn5ADb
         gze1CVZItLJoWpGbBv8anrDuE7KOTwCDGlTnbKwaN433B2t2SoIoGYBO/rLuCNgApv8a
         uHytfCOSMaE/nW4iq0B0E+lsnqFGUm+5cpgnBSOWMw1t+p42ww/83FM7TSF0HZMEEDW9
         xygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJjFsee9DdBo0OIkTbXJ7ljtv3pgxdFqcOlC1I0A847kkV17t+b/+Z6pD+j1lRNpzY89mRGCbJ+QCwMFd/M4yo3+3PZHbmMhLUi3vH
X-Gm-Message-State: AOJu0YzXCfMEO+nsoz8CYATsPwFxbSYMUDoo7XQfIW/ir2xKWjfmnXcL
	ocQpO2Hsaz7mSxYOa7YhYKxF/1uS0FaSVYdLFcUTRQ7HsZpKwGar+mo/x3Th30uUMqPmtX39O1w
	cYc7jq8pv5GqG3Bqw/vKnzdqXew3sIw75KrEi+Cu1jk+yPJ+/Ro1GY5otKEwz/Q==
X-Received: by 2002:a5d:4fce:0:b0:33b:6267:c594 with SMTP id h14-20020a5d4fce000000b0033b6267c594mr1349246wrw.10.1707902049470;
        Wed, 14 Feb 2024 01:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGARvO3alTod/7fEEMprPUww3ZuSO77uKkZhZPmv4kYJGvEw1gD2bI2kkXnpmfnuumVCc9x5A==
X-Received: by 2002:a5d:4fce:0:b0:33b:6267:c594 with SMTP id h14-20020a5d4fce000000b0033b6267c594mr1349234wrw.10.1707902049108;
        Wed, 14 Feb 2024 01:14:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfC+oqcJxekVmFZDfLL8+ZEkSTIXEf0lqJvPGIBIVEVQ3syv9iqUCzwHg0ersrQawhtBD4SoAjeOdOyGZxchiiMbSPfcQkmp8Lkb1py99Fl8CwLLw4zwbDKHXNLcZmA72adapBLeJBSj7hXAYZ75xbFJO5YLYfLB3SHdp97YSPcFyttsoI4ko6QMTQsQ5mDFtHMYFbHaFPqhGPgPgtR7sHUOE8i1oBE76PF7kU3zVO8CTSjKyD4KBoxRT9VGpeuVp3C3tkmaevIEkn1hIjoAOLq4YkO5cC8zEGOzh3akZiGQPMoIKgqfKsNId7O58APBOpme8vVxN/DKSO3+FZZJHHgekMZmKesWCDvK0g2euaEbFmI5ZaN0g8PKMyKBSjYAgWfh2ymj6RPjSj1+FYQq2hyr4hISaPr60P+TtVMSD7JBC1mIXV/41d+Pij/p0ZQQS7xDXnRZUlGJvh3pGY62qofsJuWd5eYQh9Ar+0apfS9VIhHu5rGOLnfls4PAa9rZiwom31N1x7RZ8Xi+ouPl7h0z8xVHhR2hMujQP/46dTjHU32siECcuwoaNipbdkTu+4
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b0033cf0f5a01fsm504394wrv.33.2024.02.14.01.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:14:08 -0800 (PST)
Message-ID: <73b550a1-05f2-46b2-a0bc-574fabe8460a@redhat.com>
Date: Wed, 14 Feb 2024 10:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] mm/page_owner: use order instead of nr in
 split_page_owner()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-3-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213215520.1048625-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 22:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> We do not have non power of two pages, using nr is error prone if nr
> is not power-of-two. Use page order instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/page_owner.h | 8 ++++----
>   mm/huge_memory.c           | 2 +-
>   mm/page_alloc.c            | 4 ++--
>   mm/page_owner.c            | 3 ++-
>   4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 119a0c9d2a8b..d7878523adfc 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
>   extern void __reset_page_owner(struct page *page, unsigned short order);
>   extern void __set_page_owner(struct page *page,
>   			unsigned short order, gfp_t gfp_mask);
> -extern void __split_page_owner(struct page *page, unsigned int nr);
> +extern void __split_page_owner(struct page *page, int order);
>   extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
>   extern void __set_page_owner_migrate_reason(struct page *page, int reason);
>   extern void __dump_page_owner(const struct page *page);
> @@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
>   		__set_page_owner(page, order, gfp_mask);
>   }
>   
> -static inline void split_page_owner(struct page *page, unsigned int nr)
> +static inline void split_page_owner(struct page *page, int order)
>   {
>   	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, nr);
> +		__split_page_owner(page, order);
>   }
>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
>   {
> @@ -60,7 +60,7 @@ static inline void set_page_owner(struct page *page,
>   {
>   }
>   static inline void split_page_owner(struct page *page,
> -			unsigned short order)
> +			int order)

I assume this will fit into a single line now.



Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


