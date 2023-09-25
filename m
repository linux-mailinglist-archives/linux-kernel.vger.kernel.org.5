Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CD7AD140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIYHTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED47C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695626324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fcs7WDgaaor+yyoRDl34XzlrYWO5pL3qK+P9ELjfqAQ=;
        b=N3L4dxoJi9j6XQyltcV9Y/O0WIN5lRITku26agVWQlNQeo08oNiccMMy7Ny2sIUqTFLOPn
        FbH8ZUHwKbE/z7YxPSbOhuqwvAraZ423qyDuKEdHZhadefVils3pYpL/iirdSAp6lNxaQ/
        vW6XhpwCWJvH1PvGhrq1fL/3QVgVM0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-5kYqc4K-MNmzGW3f77vEWw-1; Mon, 25 Sep 2023 03:18:43 -0400
X-MC-Unique: 5kYqc4K-MNmzGW3f77vEWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3200597bfc5so4170790f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695626322; x=1696231122;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcs7WDgaaor+yyoRDl34XzlrYWO5pL3qK+P9ELjfqAQ=;
        b=sKVpA6uaRKxtzLl9O3hKGAxWePhHNSgnigV/GKa79kg31WD4mWT6G2up20JwYaYWm6
         stcvn+0zJ2QQRoHswjpL+VPrkm0SCev5MNZ0yhG2U6C2YssWLD61ukvqCMoX9bAX9BG7
         k9TX520F9iMAbvYmhY5AZFbSSQLjOFA0QQ1NYqwopOkbtn6Eoj6Nu8GFdBQK57ONqasT
         DYaqfD/J1Thubafi2EKBEZoy2jxzK9jBcYkfdMMFXDkZ9UjD4fSipbToObIpfi58L8E+
         HKdytIwo7DFKFGvtht1T18sK+6PC4h1SkXDu0gvfDqZr61/YTjhmoAR+xB9pR1eJYkvL
         KkIw==
X-Gm-Message-State: AOJu0YxPzxSHR5Kx6biHQ+Tf6cAKWZsQXW7CNg3+SPaLR05qqQocuE+0
        o1gWxPbdO3NAWRKe78/cN6oaMGblqJPgCwFMYHk/pAp/KY2qHpz2VXNj4+7Xfg6jn/JLJIHeg7t
        0dDR71SBlrBmICEaq5GVsbB2IA/BxH7gB
X-Received: by 2002:a05:6000:1042:b0:316:ee7f:f9bb with SMTP id c2-20020a056000104200b00316ee7ff9bbmr4957008wrx.65.1695626322200;
        Mon, 25 Sep 2023 00:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHNnV6BW/Dwz1YloekACrBUY61xghgDgRm46nbk5hePHmA1Qz0sMXucB3bceggj+tGoILiGA==
X-Received: by 2002:a05:6000:1042:b0:316:ee7f:f9bb with SMTP id c2-20020a056000104200b00316ee7ff9bbmr4956992wrx.65.1695626321798;
        Mon, 25 Sep 2023 00:18:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c736:2800:494a:6093:9096:6ae1? (p200300cbc7362800494a609390966ae1.dip0.t-ipconnect.de. [2003:cb:c736:2800:494a:6093:9096:6ae1])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4585000000b0031ad5470f89sm11001731wrq.18.2023.09.25.00.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:18:41 -0700 (PDT)
Message-ID: <fd2149bb-2c5f-222c-5134-ae251910b3cc@redhat.com>
Date:   Mon, 25 Sep 2023 09:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm/khugepaged: Convert
 __collapse_huge_page_isolate() to use folios
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-2-vishal.moola@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230922193639.10158-2-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 21:36, Vishal Moola (Oracle) wrote:
> This is in preparation for the removal of the khugepaged compound_pagelist.
> 
> Replaces 11 calls to compound_head() with 1, and removes 499 bytes of
> kernel text.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/khugepaged.c | 52 ++++++++++++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 88433cc25d8a..f46a7a7c489f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -541,7 +541,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   					struct collapse_control *cc,
>   					struct list_head *compound_pagelist)
>   {
> -	struct page *page = NULL;
> +	struct folio *folio = NULL;
>   	pte_t *_pte;
>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>   	bool writable = false;
> @@ -570,15 +570,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   			result = SCAN_PTE_UFFD_WP;
>   			goto out;
>   		}
> -		page = vm_normal_page(vma, address, pteval);
> -		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
> +		folio = vm_normal_folio(vma, address, pteval);
> +		if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
>   			result = SCAN_PAGE_NULL;
>   			goto out;
>   		}
>   
> -		VM_BUG_ON_PAGE(!PageAnon(page), page);
> +		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>   
> -		if (page_mapcount(page) > 1) {
> +		if (folio_estimated_sharers(folio) > 1) {

For a tail page of a PTE-mapped THP this is not the same.

The possible side effects this might have should be spelled out in the 
patch description.

-- 
Cheers,

David / dhildenb

