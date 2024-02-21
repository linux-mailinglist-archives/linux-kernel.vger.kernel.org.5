Return-Path: <linux-kernel+bounces-74377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A616485D331
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6D3B24D32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A223D0B3;
	Wed, 21 Feb 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxff+Ts1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263603C497
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506939; cv=none; b=npvOM4PYbMJE+Uz6dHwqhGV2kr5gRQ5MtfOSUdd9Ql+lyGg4FiGPxaNgY4lt6T/48+AMqgmIMmhyDGGweTILqqmIC/loQhUMbEDOohWEuHBTN5BMeeOlQPbcTAbMQ072WlnlIDEVe1cMVE7Keo6P++wpVm8T4gVWGgriRVsdgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506939; c=relaxed/simple;
	bh=8j8CxPWIRsCtueYCxlRlcdGfvemqXnBGj23Bs2qQUlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCESGAXycLSL6bFRVil368bJLNigFSLfZuebXO0ZvIuZWpT2iwI5OHF88n747qF+X7/4DL7WgZTrITXhiz1on+U22/NYK97aZsVgyUjlqymMmGOVco/l4zafnVojAXhStp/g+uUQ2c/bES0esAU0TIxINrRsh6wTUSS5PlvT9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxff+Ts1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708506937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F6T4lfbBYjm9+K0rdV6lhOz4YZ8fC6PRsKLFRTgCxXQ=;
	b=Xxff+Ts1uBB/ggkZBU3PGdv7u9gNF675ENl1fhm84nGLurzgKIJRD0pauJSTPb5M4ChucG
	ZaNBm9vIuGnbzLA2whCSK0M9Pbx6DdzL0rH/Orranfr+hCqktbDkifHZBMwDO4zS25AM7T
	TOBKrdfi3P5go4bDHfW4eEaSW4mqMtg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Bimk5Z7DOQikkQRw4JtZ2A-1; Wed, 21 Feb 2024 04:15:35 -0500
X-MC-Unique: Bimk5Z7DOQikkQRw4JtZ2A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4127721e3a3so1354735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506934; x=1709111734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6T4lfbBYjm9+K0rdV6lhOz4YZ8fC6PRsKLFRTgCxXQ=;
        b=dvHVKzi8vHtiWbNHXt6s7Ols6Zf5o9z9zuiauJaAbdZ0KKFxmQP0jtM3IbAKufczI/
         HQfBxnm9Bq9ufHMQtkVLGWh+m9gD20DaFyCSCKeWCLPof4CGx/ET3J4YwUNnXw0iqhRP
         hwA7bBdZsIzPEZ4GRrMk5UqpR1tfpm4ekF1JSpX5/YQkBMD+i60zvFZ0YLXHZiwowEwD
         cHmZmk+ebuA06zMJRW8LNPy1ysH+57T4nq0+RKjUPEqXTLOYpgfbAKqqgcfKrevI4SHb
         85X2GCOgUXjSHZnwEQoqgQZtrnx9GB8F4MVR9XTaNGV7dBxaVDGP0s1UdRRm9DbFMk27
         wlVA==
X-Gm-Message-State: AOJu0Yx0u734gYppuqQYB2GRAYe/5lpifu3lY+nvpu+EFxeftQ83Cug9
	wMRR1ntnnHQeVt/hj75WxyItCvyIqeZeiao7IXgbuBmvRWY2K3/XvPfvyr2M6+W+QRmFVYRiHY4
	MDZqzyTB7x9Zl9cDyQottVeKegLq2NlSfmmru7xtCedvkpP/glptzXRak4ztgDQ==
X-Received: by 2002:a05:600c:1c83:b0:412:6ddd:460d with SMTP id k3-20020a05600c1c8300b004126ddd460dmr3069922wms.3.1708506934456;
        Wed, 21 Feb 2024 01:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEAGN0W7JBpqEg7d0YVD9zGauJLD/EgCVsXguYJKLgcRLKodusPKtkEQ1YCAR/9JU3jOf8Ow==
X-Received: by 2002:a05:600c:1c83:b0:412:6ddd:460d with SMTP id k3-20020a05600c1c8300b004126ddd460dmr3069899wms.3.1708506934069;
        Wed, 21 Feb 2024 01:15:34 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b0041277b5da5csm797595wmq.36.2024.02.21.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:15:33 -0800 (PST)
Message-ID: <4c1224e3-5c02-4d5d-9379-d3b74b1174dd@redhat.com>
Date: Wed, 21 Feb 2024 10:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>, Vishal Moola <vishal.moola@gmail.com>,
 Yang Shi <shy828301@gmail.com>
References: <20240221085036.105621-1-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240221085036.105621-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.24 09:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The purpose is stopping splitting large folios whose mapcount are 2 or
> above. Folios whose estimated_shares = 0 should be still perfect and
> even better candidates than estimated_shares = 1.
> 
> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
> the current code will split folios and reclaim them while madvise goes
> on this folio; but if we unmap subpage 0, we will keep this folio and
> break. This is weird.
> 
> For pmd-mapped large folios, we can still use "= 1" as the condition
> as anyway we have the entire map for it. So this patch doesn't change
> the condition for pmd-mapped large folios.
> This also explains why we had been using "= 1" for both pmd-mapped and
> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
> madvise_cold_or_pageout_pte_range() to use folios"), because in the
> past, we used the mapcount of the specific subpage, since the subpage
> had pte present, its mapcount wouldn't be 0.
> 
> The problem can be quite easily reproduced by writing a small program,
> unmapping the first subpage of a pte-mapped large folio vs. unmapping
> anyone other than the first subpage.
> 
> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/madvise.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..abde3edb04f0 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>   		if (folio_test_large(folio)) {
>   			int err;
>   
> -			if (folio_estimated_sharers(folio) != 1)
> +			if (folio_estimated_sharers(folio) > 1)
>   				break;
>   			if (pageout_anon_only_filter && !folio_test_anon(folio))
>   				break;

That's also what I do in

https://lkml.kernel.org/r/20231124132626.235350-4-david@redhat.com

I'll revive that soon.

-- 
Cheers,

David / dhildenb


