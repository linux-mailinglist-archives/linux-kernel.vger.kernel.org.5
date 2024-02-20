Return-Path: <linux-kernel+bounces-72597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB3485B5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450E62832C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8FA5F54D;
	Tue, 20 Feb 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTimyH1M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B515F541
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418896; cv=none; b=WUNJFbYZUZXu04n8S29AEU6ncjzVVjIUc1BFLHzhkPzk43sJsKBPoR1eRxUth7Jeo44yNuw0kSXhjRU6bgE4sib+JEWdptHZCiC7zqLy50fhzY66l4TP9/Ub5CwKuPz2OLIa8UcZUVE4wQjK7Snq9xqIBy3AweGKo7w2igqXUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418896; c=relaxed/simple;
	bh=1NNeHJZmBgdW4D+46onJlsg4dEoKuQr+5svivfT+Qb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxmcD9wfCxi1P3sdCqe2YaO9ukDF0MqWXT793VTxMfs6GD07nOJ2yJbeSt/ylZK2BBNHuI1QXnEtLK9vjCby/XQo0DI/7nhvXIAiarbjQQ6ponw7B41mx/2rKN8ePakm0yq/mBri53JB/+ZH5Q9BA+OcIXf09evoqnpNAfBMA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTimyH1M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708418892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jE+NRG5Jai/u4VO86x5WSunHbwJ2hR8+UZgnT29myF8=;
	b=UTimyH1M5j63VEwrRNWvdiEyRbBen00vkqfbsATbVBN8gP2sKugOJ53lJpmYeF1wY0PxYq
	oottXX0t4TADUVecJg3WMH+s+eNekEDpqF7RM376/agW7uscpJrcRKwsPUVg9/bsEo3UE4
	+RJwhIyB/cWe4zmofJz2RKNe1tlT9h0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Ebry6Cn2M3q5vGOu9PPuGw-1; Tue, 20 Feb 2024 03:48:11 -0500
X-MC-Unique: Ebry6Cn2M3q5vGOu9PPuGw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412565214c3so20097745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418890; x=1709023690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE+NRG5Jai/u4VO86x5WSunHbwJ2hR8+UZgnT29myF8=;
        b=mRun/VlcOxAUXsHrRMLSiPxZ5VshtkEQDpQYhl2BOGpdGmFZ2oVMU0xnsjhhAL+zPU
         EkeubZPiTq7/01LaQX1oJojf1ZASlzFxuHybbT68Nxk88hWRSG5+gQbEqaQdYzJYBYMY
         w4tzxnuZOSaOsWZoSTkV9/0A4A9MO3JDajplkjddNElloXmvJd6+iELZ52KuLJBXvvCd
         ZZU6eYgEDMqxq6LlRA0eI66QJ+89K5khpWOZuf0uPLcT/CxR8biBmiR0fl0s/K3Ed5GO
         fIjEdjk07yOms6e38r0uUrH6cJSu6JOjsaZjrjGnO619d3o/Ls+joIiv/sERweeEQRdr
         fh0w==
X-Forwarded-Encrypted: i=1; AJvYcCWci518cvnYyckEB2SZnV0ghHgHx0Z5vmwAWxsnd+6VBo2KiJKWM7LUDKsPL5VShYPYyUenJ3/I74kHFs6F3X3j/21qmaLvKFE+/eaN
X-Gm-Message-State: AOJu0YysbPFWSY6CujZHxt1PGvg1EnYBybisOJIq0jgY8y8yr9U6Ytlp
	Uf3g+5slD+ztwfGA3poekr/oc2+dIMyj9zs67pAnnqFHOmg5ZiGeRSQxOhjTMA9EWWoeF8KxRke
	n84hoHsO9cmfMd8/sc0+0tAjpFbMBz94hEVbU019a43Tu7jzzmZXioFxl+SMGbg==
X-Received: by 2002:a05:600c:4691:b0:410:c25d:37e9 with SMTP id p17-20020a05600c469100b00410c25d37e9mr10309622wmo.16.1708418890193;
        Tue, 20 Feb 2024 00:48:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK7Xan/vm/PZMeHodtFHhBI0/9gn0hYjvl8SM7tt8BClIw12vF9L0yXJTnfLuMXUWn2DUjyQ==
X-Received: by 2002:a05:600c:4691:b0:410:c25d:37e9 with SMTP id p17-20020a05600c469100b00410c25d37e9mr10309600wmo.16.1708418889804;
        Tue, 20 Feb 2024 00:48:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6ac7000000b0033d1500b639sm12755646wrw.30.2024.02.20.00.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:48:09 -0800 (PST)
Message-ID: <95fb8698-2fdc-4b4d-a48e-5fb33c75162d@redhat.com>
Date: Tue, 20 Feb 2024 09:48:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] mm/page_alloc: remove unused fpi_flags in
 free_pages_prepare()
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240216170432.1268753-2-zi.yan@sent.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240216170432.1268753-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.02.24 18:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> fpi_flags is only passed to should_skip_kasan_poison() but ignored
> by the function. Remove the unused parameter.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/page_alloc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7ae4b74c9e5c..70c1ed3addf3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1061,7 +1061,7 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
>    * on-demand allocation and then freed again before the deferred pages
>    * initialization is done, but this is not likely to happen.
>    */
> -static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
> +static inline bool should_skip_kasan_poison(struct page *page)
>   {
>   	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>   		return deferred_pages_enabled();
> @@ -1081,10 +1081,10 @@ static void kernel_init_pages(struct page *page, int numpages)
>   }
>   
>   static __always_inline bool free_pages_prepare(struct page *page,
> -			unsigned int order, fpi_t fpi_flags)
> +			unsigned int order)
>   {
>   	int bad = 0;
> -	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
> +	bool skip_kasan_poison = should_skip_kasan_poison(page);
>   	bool init = want_init_on_free();
>   	bool compound = PageCompound(page);
>   
> @@ -1266,7 +1266,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>   	unsigned long pfn = page_to_pfn(page);
>   	struct zone *zone = page_zone(page);
>   
> -	if (!free_pages_prepare(page, order, fpi_flags))
> +	if (!free_pages_prepare(page, order))
>   		return;
>   
>   	/*
> @@ -2379,7 +2379,7 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
>   {
>   	int migratetype;
>   
> -	if (!free_pages_prepare(page, order, FPI_NONE))
> +	if (!free_pages_prepare(page, order))
>   		return false;
>   
>   	migratetype = get_pfnblock_migratetype(page, pfn);

Likely due to

commit 0a54864f8dfb64b64c84c9db6ff70e0e93690a33
Author: Peter Collingbourne <pcc@google.com>
Date:   Thu Mar 9 20:29:14 2023 -0800

     kasan: remove PG_skip_kasan_poison flag

That removed the usage of fpi_flags in should_skip_kasan_poison.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


