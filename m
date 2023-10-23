Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF67D2AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJWHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84178EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698044713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=oWpylSicIHc7hcbSOmy66rKUIluq26z4Qn2WizKISk4=;
        b=G0CfwoMXFrV4VdS5/AppFz1AX3zTuIJaSjuijT5PTPW53NZjhiFuwHdugeJrNJvexxHQGI
        AMTa56gHt9YHwLkM4gzMJpCV0MIh6HAFLfdFgH79AuTWF5bwP0sNLTWtdPtN969JMlfxxa
        RCBLYTKRKTePUYA47lxiUW1ZD+X4eFo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Kqn_Jc7jOQm1RqGg_K6zig-1; Mon, 23 Oct 2023 03:05:12 -0400
X-MC-Unique: Kqn_Jc7jOQm1RqGg_K6zig-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40855a91314so11058695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698044711; x=1698649511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWpylSicIHc7hcbSOmy66rKUIluq26z4Qn2WizKISk4=;
        b=gE+Jevjei6wLEb1AjrFvce+lwT7RAXiCHtuZJKWLNI9gGBGuqzRurGLP5tN/Q3ahNn
         jJgpqPgzXMRCnBoYB/H8C/iPD8nOel+UhHwLjSU6hd1pFNsUpKy6/Asukw9dWX/n8a0u
         SLukNuoZuXH52hmZYORoSkp4Kp0w3nnrt5EgMmKxpHcMLHlnQ8rCraTqfE609/RYGtTf
         U+7TW2VYePg6agysX7xavlQ/ZHOvPR8UO+4fLXLmlpw6j7rPh3ERAYrcEo+08BNEak40
         pHAoq6aU7orGM6ey81PRKsPHiXu6+QhBhq2V6YntPCvv5G7FKNAyg1JS517N4lymEwlI
         fJXA==
X-Gm-Message-State: AOJu0YwabqyCaRlLbC9xatPeBP9m70JpRTctwFX+Vl3+2WLeTfjm4fX/
        qh/9OSz8aLcDRLgKwabDBwl8gzzWkdrHEYqU0oWyD4oveNpQt3o4QlYtBqy6c23B3XHsogUY8b2
        EpkyFP5wOBYLX6xO8PeoUvaHy
X-Received: by 2002:a05:600c:2b10:b0:407:73fc:6818 with SMTP id y16-20020a05600c2b1000b0040773fc6818mr11123728wme.2.1698044710876;
        Mon, 23 Oct 2023 00:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU97bJFCzTaX/NWREVbwAA6qqWQ9i0xT7lseWdSBhsb+qNLBHElkeFAqIEJ7l6y7DLpKX0dw==
X-Received: by 2002:a05:600c:2b10:b0:407:73fc:6818 with SMTP id y16-20020a05600c2b1000b0040773fc6818mr11123688wme.2.1698044710296;
        Mon, 23 Oct 2023 00:05:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:1900:b6ea:5b9:62c0:34e? (p200300cbc7381900b6ea05b962c0034e.dip0.t-ipconnect.de. [2003:cb:c738:1900:b6ea:5b9:62c0:34e])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b00327de0173f6sm7059882wrj.115.2023.10.23.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:05:09 -0700 (PDT)
Message-ID: <5193bc92-a2f5-496d-9625-af6c7be95d99@redhat.com>
Date:   Mon, 23 Oct 2023 09:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm/khugepaged: Convert is_refcount_suitable() to
 use folios
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20231020183331.10770-1-vishal.moola@gmail.com>
 <20231020183331.10770-4-vishal.moola@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231020183331.10770-4-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.23 20:33, Vishal Moola (Oracle) wrote:
> Both callers of is_refcount_suitable() have been converted to use
> folios, so convert it to take in a folio. Both callers only operate on
> head pages of folios so mapcount/refcount conversions here are trivial.
> 
> Removes 3 calls to compound head, and removes 315 bytes of kernel text.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/khugepaged.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c4b5af43371..9efd8ff68f06 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -524,15 +524,15 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   	}
>   }
>   
> -static bool is_refcount_suitable(struct page *page)
> +static bool is_refcount_suitable(struct folio *folio)
>   {
>   	int expected_refcount;
>   
> -	expected_refcount = total_mapcount(page);
> -	if (PageSwapCache(page))
> -		expected_refcount += compound_nr(page);
> +	expected_refcount = folio_mapcount(folio);
> +	if (folio_test_swapcache(folio))
> +		expected_refcount += folio_nr_pages(folio);
>   
> -	return page_count(page) == expected_refcount;
> +	return folio_ref_count(folio) == expected_refcount;
>   }
>   
>   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> @@ -625,7 +625,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		 * but not from this process. The other process cannot write to
>   		 * the page, only trigger CoW.
>   		 */
> -		if (!is_refcount_suitable(&folio->page)) {
> +		if (!is_refcount_suitable(folio)) {
>   			folio_unlock(folio);
>   			result = SCAN_PAGE_COUNT;
>   			goto out;
> @@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   		 * has excessive GUP pins (i.e. 512).  Anyway the same check
>   		 * will be done again later the risk seems low.
>   		 */
> -		if (!is_refcount_suitable(&folio->page)) {
> +		if (!is_refcount_suitable(folio)) {
>   			result = SCAN_PAGE_COUNT;
>   			goto out_unmap;
>   		}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

