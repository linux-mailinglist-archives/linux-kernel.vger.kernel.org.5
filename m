Return-Path: <linux-kernel+bounces-141226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5A8A1B18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF821F2164E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0E537FB;
	Thu, 11 Apr 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2ADhQG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815653815
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850412; cv=none; b=S8vy4UWDu5FhHc01EKmoT3cstlLsIYaJBpzZziYQmuaHOzUANc9/rfCtnST7bza5gVd1zj+rleXZ+V0srIaaTAxdtu0+IMERL+xs/hvULnnhyq3cge7daxH5Vago3SzYCprczLjOHVX1NzgQMJnaJVAEF1a6BQO9d7ZBnmrFmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850412; c=relaxed/simple;
	bh=FoPVgdFbMGDkUH7fKW2usuW1gpP2wbkHhfwYrcnMxyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHqAawzdZR9DatmDdTt4P8Ysnd/4i172L9uuFV5vay1X+mjFSq2CcPLC86bbk10sEkrtHe2aUgyj/b/QhgREzJhngUhdIMHH9wVc0yULBOv2ey3AxTKvgzeapmFtc3JBN2eOswX8qaKcMn1RVa0lESHQuqk304fJd2rpWJ/J4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2ADhQG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712850409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UEZGV9VCe3aTsy6N7RQCWu4uCsIfjLyWqxbtHAKGNN4=;
	b=G2ADhQG4O6Z19KevAZbKLiplPMyXUNrE9j/ZW9Bcdp8zGI+m9fVNaVJCF+PELtb2UWRpil
	PNIZAtKO2CEh4i3X35Bhiii6YdgAh7NRz8od0zgQurbaUq+G9oQYemBcX0Hldj/wiAeH9a
	sKaj5vNC85Gyg4GcHED1Ta52eacCbC8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-oZ6mRIZ8NRC0piBEhFsW0Q-1; Thu, 11 Apr 2024 11:46:48 -0400
X-MC-Unique: oZ6mRIZ8NRC0piBEhFsW0Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416e58bdc1eso4205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850407; x=1713455207;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEZGV9VCe3aTsy6N7RQCWu4uCsIfjLyWqxbtHAKGNN4=;
        b=GTqA3gFazaAsI+NBIlpzJnFSFcg2q6xaLMM6j2K6UoG8BsSMXLHQoFFm0j/HK/ZgGl
         khMTHMo8IxVhuZhcTT8KAblsnxwcBhDLyIiocvpJbQKWjnBE/EEMH/uCSlpwPebdU8hS
         /jkCtzH1ehHNlyTo/8jrcherlMqzQDGM0JnZ58dIXCKMJgAgwa5XNSzobaGhJQ8tnVmg
         L3CSj95uAwrDQFr3IMXXS9n7rzbMUKJcK9dlgnkwmznT6HOVPwZ67WatPDCrmoRgnVdv
         wZ0RJ1RxzCNifB6vNzF2SxH1i4LSOqmKqx2EIhCRkVHTs+cV9lpGFD6/sb/D3JngqUPY
         4uhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZuJzqXHDr8MvDyHB9NnV5IzySVldFrkYZZLzwkANnHGNWrN/kggBmEZG8OmWozc23Ji/8Yt/Mcv5K/1nz//+OYP307+bcbqVTW7ik
X-Gm-Message-State: AOJu0YxbMB/h1NVeSB7jtjHziGUWFErL4HSYAdijDwUVsTriQwBLnun2
	LmzF0nxsQMOPlBaEkngUH2mXFmfnIFmOs7iNKlYYinsfRDKGGZH5Dz7MSBJdjwh6nPUt6lo9v6w
	MBXxfnIC6MiBIHfhs1bLUkcO7spmVrCBOfm2AQm/mqc/JZYdAx97UKjWpaN22YM/eqdfFSA==
X-Received: by 2002:a05:600c:35ce:b0:416:9e38:3bdd with SMTP id r14-20020a05600c35ce00b004169e383bddmr129431wmq.27.1712850407037;
        Thu, 11 Apr 2024 08:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxor1/9ucJeIy1LK54eldxqmchESlilSiUTk4WniHLuvcgqIR+xz6Rwmt5XvZDncL3E9GVSQ==
X-Received: by 2002:a05:600c:35ce:b0:416:9e38:3bdd with SMTP id r14-20020a05600c35ce00b004169e383bddmr129396wmq.27.1712850405736;
        Thu, 11 Apr 2024 08:46:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0041624ddff48sm5919487wms.28.2024.04.11.08.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:46:45 -0700 (PDT)
Message-ID: <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
Date: Thu, 11 Apr 2024 17:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240411153232.169560-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240411153232.169560-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 17:32, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In __folio_remove_rmap(), a large folio is added to deferred split list
> if any page in a folio loses its final mapping. It is possible that
> the folio is unmapped fully, but it is unnecessary to add the folio
> to deferred split list at all. Fix it by checking folio mapcount before
> adding a folio to deferred split list.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/rmap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..d599a772e282 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		enum rmap_level level)
>   {
>   	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	int last, nr = 0, nr_pmdmapped = 0;
> +	int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
>   	enum node_stat_item idx;
>   
>   	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   			break;
>   		}
>   
> -		atomic_sub(nr_pages, &folio->_large_mapcount);
> +		mapcount = atomic_sub_return(nr_pages,
> +					     &folio->_large_mapcount) + 1;

That becomes a new memory barrier on some archs. Rather just re-read it 
below. Re-reading should be fine here.

>   		do {
>   			last = atomic_add_negative(-1, &page->_mapcount);
>   			if (last) {
> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		 * is still mapped.
>   		 */
>   		if (folio_test_large(folio) && folio_test_anon(folio))
> -			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
> +			if ((level == RMAP_LEVEL_PTE &&
> +			     mapcount != 0) ||
> +			    (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped))
>   				deferred_split_folio(folio);
>   	}

But I do wonder if we really care? Usually the folio will simply get 
freed afterwards, where we simply remove it from the list.

If it's pinned, we won't be able to free or reclaim, but it's rather a 
corner case ...

Is it really worth the added code? Not convinced.

-- 
Cheers,

David / dhildenb


