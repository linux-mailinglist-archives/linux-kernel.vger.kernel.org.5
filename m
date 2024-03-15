Return-Path: <linux-kernel+bounces-104280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA987CB94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB01C22161
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA01B7F6;
	Fri, 15 Mar 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu30bd9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A531B59F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499406; cv=none; b=beiZnZqWBzp2tK05fjo4JHfaXGQJ1qH/Mlq3hSje7DIHUqpWZyUmDvzYaMtxY9h19agSMs3mB0LDyhdoXI2jCJ7WXeTvGjQ+uvui+FtVmNJSp3WlEylT6jeZYXOGFw2ociEt19G0/yak5mela752qIONtl6s8T09p8anlNs7MT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499406; c=relaxed/simple;
	bh=c+ACrTu4YJZK7FQThz1UJLRVCO0zgqoPh9qrsUaSNqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN+fat+WXU28NFXTNTogFyymu1TpFTAvcICnepLqDglX8J1K5lkSh7o2le7Jm6tnn/gG55HKbomecR24oJJvaDYTC+osNRYE8JSLApDBuTpLPqc5MwHSIvYBy6rdmHosMwm7bkvC8ICbRWEwImPnQjiiG1/sv7ER6Yhozn5DCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu30bd9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710499403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mFYTL2COBcL0eDhJwzMKJs1wuhd9ev/OLLtfRXuhw8w=;
	b=fu30bd9M+H67VO2OYSJexvBgFS5bXhafrZbGyJkAQIYAqQ3yqHieEPjyH0rVrpux8vD1Wy
	8pezG+bTE2tTltAhSiewc2Ev72b+S39LklXF5/sMmov1G8rBIKM5KFO9tltdOWz4ej1UwA
	a3MWOeRObaDTKKxQAGzlNf6llFI4uYQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-j-8yPWTDNjuAmk7gV_2aTA-1; Fri, 15 Mar 2024 06:43:22 -0400
X-MC-Unique: j-8yPWTDNjuAmk7gV_2aTA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed0a8beb5so338684f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710499401; x=1711104201;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFYTL2COBcL0eDhJwzMKJs1wuhd9ev/OLLtfRXuhw8w=;
        b=LK9kGe79wYwPWvQfIGDuy2giagAjpB8b5ypIOEObmOmbf8QyIlW28KrdiypeWVsy6U
         fhadyTuzSsLKZ1vNIO7DPL6r6pjI+8Oyd7xZ+7JEuKE1KAamkOw4ENPzIVPSPRsW2K80
         E7ghuiY/0BhBHQyY1TZ4A/h+0vwb71SXbamu5HN5TQy1ORg0uukMd3AL5ORjCQ+Ehw4d
         51rA52Y/pToz4tMHWDb6jc0dV7FktZpDbD64KvPHLxCZzeYGGZq+hTygmf2prRwAkEsG
         A9ZklwEEos4MNgZNWNujP7VYM+RTl3PfodCaY71Y7hoi8UvM5CgpTjsg35851ErkClIQ
         o3wA==
X-Forwarded-Encrypted: i=1; AJvYcCUmv024YZtQA9yLxOcdf/7DCo0ctcey8ApP0JcMrPgEJb3cO0RxwJ2kUj5Prth/AnD/oXKZoIaHBZpqZRKQ9w4Kn0xXbv2GqDcw7qH8
X-Gm-Message-State: AOJu0Yy2jIbES/gOZah7YXM9X1aKoMyi7mh4CM8M5Nht7GYUd+TNADM+
	hZjx+jXm1csaYV++SR7aimtF9ovUIWoO1hO7QkN5KNL9U289GHPPH2LoKpPeaQe43FsXBKkn7BX
	R7C1qrSaybraygqPRv+Yo7zvw8BjFWZLyDsRvrEi2saN0Lt1gxsiQlc/sO90Kqa40gC27mg==
X-Received: by 2002:adf:f448:0:b0:33e:d65c:b493 with SMTP id f8-20020adff448000000b0033ed65cb493mr129596wrp.62.1710499401022;
        Fri, 15 Mar 2024 03:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL7oU7U/Z0lGKC7FlgrWPD3b6tu18IRtNermovqCqf62+MZsfaLnoVa9N8jnhrUhetWqC1cA==
X-Received: by 2002:adf:f448:0:b0:33e:d65c:b493 with SMTP id f8-20020adff448000000b0033ed65cb493mr129580wrp.62.1710499400614;
        Fri, 15 Mar 2024 03:43:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:7700:ef08:112b:278d:7d90? (p200300cbc7197700ef08112b278d7d90.dip0.t-ipconnect.de. [2003:cb:c719:7700:ef08:112b:278d:7d90])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056000081100b0033ec8c1c233sm2967767wrb.19.2024.03.15.03.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 03:43:20 -0700 (PDT)
Message-ID: <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
Date: Fri, 15 Mar 2024 11:43:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240311150058.1122862-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.24 16:00, Ryan Roberts wrote:
> Now that swap supports storing all mTHP sizes, avoid splitting large
> folios before swap-out. This benefits performance of the swap-out path
> by eliding split_folio_to_list(), which is expensive, and also sets us
> up for swapping in large folios in a future series.
> 
> If the folio is partially mapped, we continue to split it since we want
> to avoid the extra IO overhead and storage of writing out pages
> uneccessarily.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/vmscan.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cf7d4cf47f1a..0ebec99e04c6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   					if (!can_split_folio(folio, NULL))
>   						goto activate_locked;
>   					/*
> -					 * Split folios without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> +					 * Split partially mapped folios map
> +					 * right away. Chances are some or all
> +					 * of the tail pages can be freed
> +					 * without IO.
>   					 */
> -					if (!folio_entire_mapcount(folio) &&
> +					if (!list_empty(&folio->_deferred_list) &&
>   					    split_folio_to_list(folio,
>   								folio_list))
>   						goto activate_locked;

Not sure if we might have to annotate that with data_race().

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


