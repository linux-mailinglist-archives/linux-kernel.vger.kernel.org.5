Return-Path: <linux-kernel+bounces-138173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E083089EDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981802827C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04730154454;
	Wed, 10 Apr 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBmN48LX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92789EAD0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738054; cv=none; b=esiVVJ4IDZgOZ4/BSjCIX0Wy6jFPtOEJypQbDQLT9BwRBZRxvxuOYLL28omqPQx+56kFdpa8/e0UydWufGBc7QvbfJ5RRsCS7s6VkWibBSQRU+vVnZYoBKNVf4AC1YUFVbcRHGGwUgsFF8hRW7wc1qt9u3WXfvSHDC8451SBwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738054; c=relaxed/simple;
	bh=xNG6hJAju1bizWAzgR+IDcBy4RIZuA6nBaFRSfESPpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQiw5I2Wcjigz8wxKfDQSLJAnFceHRsxmLWo163ZrekoeHvHAMX/H5QfQQKCKr5IR30v8FXuIHYFRfIAsB4dNGnPDEGHFBC/QsSoTHmDW5IIBL8DFv5Wkwvi9qhQSknI8VnyeUS5WFQWkwP/1pAdUtyETCPv1XNqZ0PFH0V5Nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBmN48LX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712738051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BWLZ/q1gyu4D0XmEKgmR0P7MI9xWaMnbKOLpO15YcPM=;
	b=IBmN48LXj3QwCdSPmXt/VOXj+YiGC/KgBLWeEfOTVqdSVP1KKo4PPycRquIAuiOHEloK5S
	IX1PILzGWRj/b9h45mTP5YfNOOHGKl+7iaoDM9eCz5HAfpF0U3GTA77neFinodcdSabm9G
	vohHsSohFxjysNCgKMGKvedEsOYqVvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-qmWndVZ2NmKHaLQf8wWlkQ-1; Wed, 10 Apr 2024 04:34:09 -0400
X-MC-Unique: qmWndVZ2NmKHaLQf8wWlkQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34563e7ccc6so1768374f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738049; x=1713342849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWLZ/q1gyu4D0XmEKgmR0P7MI9xWaMnbKOLpO15YcPM=;
        b=QWWv3hPB19NfV9jAeSQq/QgQNd5hPkCOVqYj+z0YqJVJ2qTfdi5OaJkEJgtkFifhOt
         +/Zz/v4e8lQSIBw5fOTkZlLKnWqlb2mfsEtfV9Ld6ZQPSS5Uzauw5U+X147Z/ndj62Q7
         fQGkfuc1eH5gpeFTR/FC8nNthfCHHMGLHgyMk+TSDNrAQV4pwKEWOZkweuh9xZGh1w1/
         3zHHsKP3BzI/AGcRBgIi1rS6f3NHwAPM/nuHoRc5ggxqO5ffEZUz/fDeB9yHwdeucYTr
         I7FLpE/VhgkI6B49s2F70YHhcxVyMD2o50K6t++N4RuTg5/D6GbYKKSthp8hdpxJOFqK
         RHjw==
X-Forwarded-Encrypted: i=1; AJvYcCV+SWgOmScbRk+3AW7Yxy9ZVZpfQf3YB0/H1gx+2TZ96i6qO6IsbOtOeMDv0kKj7/N5PNYksR1VWeGwtmujWs7ewPKepdIA0UE/20OV
X-Gm-Message-State: AOJu0YyxfOz9hExjWt+VDn5MSm71thziH4hdLEBMB5QELWkrxT+W+Wi5
	cAyO6hBDLCR6djqwtvcM3m2+tFZLLCD7F4ii28dBU9N0yrArlHqVut6QdEngJYHuZtwJECkyoRC
	I3m+b8mk3jtbPqPFa9E9tkucvRFgZsMPJWoP0goQuA7xQhEwdK1+LwA1rvckXxg==
X-Received: by 2002:a5d:4a10:0:b0:343:7ed6:765b with SMTP id m16-20020a5d4a10000000b003437ed6765bmr1267300wrq.39.1712738048789;
        Wed, 10 Apr 2024 01:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPENjs5SpD+lKW7lAXT8GOzgCf+z5bH6hDs/X6I8uA8MRFhnmCFPcQbKBr+NmAukETNiO7hg==
X-Received: by 2002:a5d:4a10:0:b0:343:7ed6:765b with SMTP id m16-20020a5d4a10000000b003437ed6765bmr1267287wrq.39.1712738048415;
        Wed, 10 Apr 2024 01:34:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id i11-20020adfe48b000000b0034330c9eccasm13363017wrm.79.2024.04.10.01.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:34:07 -0700 (PDT)
Message-ID: <81c1de48-1e31-449d-8f5a-9342634cea27@redhat.com>
Date: Wed, 10 Apr 2024 10:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] mm/ksm: add ksm_get_folio
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
 <20240409092826.1733637-2-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240409092826.1733637-2-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 11:28, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> The ksm only contains single pages, so we could add a new func
> ksm_get_folio for get_ksm_page to use folio instead of pages to save a
> couple of compound_head calls.
> 
> After all caller replaced, get_ksm_page will be removed.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/ksm.c | 40 ++++++++++++++++++++++++----------------
>   1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 8c001819cf10..ac080235b002 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -915,10 +915,10 @@ enum get_ksm_page_flags {
>    * a page to put something that might look like our key in page->mapping.
>    * is on its way to being freed; but it is an anomaly to bear in mind.
>    */
> -static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
> +static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,

Just realized that you should adjust the function name in the comment 
above this function in this patch.

-- 
Cheers,

David / dhildenb


