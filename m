Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BF17EB2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjKNOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKNOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C2CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699972992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5SJ3Nn0MswLm+ieIv5vpfuxn2m1fYyMn2DeOZf4gqog=;
        b=hlhfWas79odF8UPQs698kd591fZgMfG69ugAP/Q/9z9wT9WodgUA83FlloEBVUxnu5O9LY
        852/znQsx7oXo52zUuyZkoYdjsHBQ98f/gz/2xo6RGQqoW8R2hVcMBU1qPHP85rQFrwopm
        RcAjmwoV/qLCYVSTmUexZZtvA9/B6/s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-N1ibWDSvN9SeCUcdFD88Nw-1; Tue, 14 Nov 2023 09:43:10 -0500
X-MC-Unique: N1ibWDSvN9SeCUcdFD88Nw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32da7983d20so2991654f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972989; x=1700577789;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SJ3Nn0MswLm+ieIv5vpfuxn2m1fYyMn2DeOZf4gqog=;
        b=AOY0WaMBoMFXxXZBC6eXJP0/ff+bhJkS5XwuIh2exkQurgJlJG6eD1l9pRcQGs7TQd
         m9CQl/wEGkTMLPniqmrOH+jiHfR24DqlLIeobBOq228ug15Zcu2WHNWUeVorv2bGrifV
         OlwGrqM1M9bgYooBwfuN3Ch+pB8Kk1xvgKw/qLWufm4RRIvrR1yNxCbHI+qPOz+jHq68
         l0ACvdsTChlZh/rJGkf4mUi4IVFGv1x7Zqu644x7wgzzeQTtFQ/ntYj4jpylnaPDHyZv
         SboemsZAdRmXjyYqqmrAknFlTWcqQllug+QxaHRb5nxzPVeq0ENLZNiCDhbKeR1SVFQ7
         v8og==
X-Gm-Message-State: AOJu0YwL3NTWbJOCPj6PgKuIV4BsD+z7kUflEExFdSiFJxwD78Ugfnm7
        A/x+TSV3FTZlydIzKCleLbygBIWdxyCZcjnfGZN4lrJhwIrW1kITcGebpZdbrijpVE7SPKRJbue
        nT2D9g33UJlIvcn3P8XeeHLFU
X-Received: by 2002:a5d:584f:0:b0:32d:dd68:e83 with SMTP id i15-20020a5d584f000000b0032ddd680e83mr2299583wrf.21.1699972988837;
        Tue, 14 Nov 2023 06:43:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUdIYQpNwmcCSJgMhBTuzh3dWmnDfaflXDgDaBkJU4XDK4doSNxIGSMy3RT+SFNRd7KB/feg==
X-Received: by 2002:a5d:584f:0:b0:32d:dd68:e83 with SMTP id i15-20020a5d584f000000b0032ddd680e83mr2299530wrf.21.1699972987458;
        Tue, 14 Nov 2023 06:43:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd? (p200300cbc73e890002d8c9f0f3fbd4fd.dip0.t-ipconnect.de. [2003:cb:c73e:8900:2d8:c9f0:f3fb:d4fd])
        by smtp.gmail.com with ESMTPSA id he9-20020a05600c540900b0040a48430837sm13332637wmb.13.2023.11.14.06.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:43:07 -0800 (PST)
Message-ID: <b4a11840-0118-44af-9397-30b5bcdd6552@redhat.com>
Date:   Tue, 14 Nov 2023 15:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, jiang.xuexin@zte.com.cn,
        wang.yong12@zte.com.cn
References: <202311142036302357580@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202311142036302357580@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.23 13:36, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Background
> ==========
> When trying to merge two pages, it may fail because the two pages
> belongs to the same compound page and split_huge_page fails due to
> the incorrect reference to the page. To solve the problem, the commit
> 77da2ba0648a4 ("mm/ksm: fix interaction with THP") tries to split the
> compound page after try_to_merge_two_pages() fails and put_page in
> that case. However it is too early to calculate of the variable 'split' which
> indicates whether the two pages belongs to the same compound page.
> 
> What to do
> ==========
> If try_to_merge_two_pages() succeeds, there is no need to check whether
> to splitting compound pages. So we delay the check of splitting compound
> pages until try_to_merge_two_pages() fails, which can improve the
> processing efficiency of cmp_and_merge_page() a little.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   mm/ksm.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 7efcc68ccc6e..c952fe5d9e43 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   	tree_rmap_item =
>   		unstable_tree_search_insert(rmap_item, page, &tree_page);
>   	if (tree_rmap_item) {
> -		bool split;
> -
>   		kpage = try_to_merge_two_pages(rmap_item, page,
>   						tree_rmap_item, tree_page);
> -		/*
> -		 * If both pages we tried to merge belong to the same compound
> -		 * page, then we actually ended up increasing the reference
> -		 * count of the same compound page twice, and split_huge_page
> -		 * failed.
> -		 * Here we set a flag if that happened, and we use it later to
> -		 * try split_huge_page again. Since we call put_page right
> -		 * afterwards, the reference count will be correct and
> -		 * split_huge_page should succeed.
> -		 */

I'm curious, why can't we detect that ahead of time and keep only a 
single reference? Why do we need the backup code? Anything I am missing?

> -		split = PageTransCompound(page)
> -			&& compound_head(page) == compound_head(tree_page);
> -		put_page(tree_page);
>   		if (kpage) {
> +			put_page(tree_page);
>   			/*
>   			 * The pages were successfully merged: insert new
>   			 * node in the stable tree and add both rmap_items.
> @@ -2271,7 +2257,25 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   				break_cow(tree_rmap_item);
>   				break_cow(rmap_item);
>   			}
> -		} else if (split) {
> +		} else {
> +			bool split;
> +			/*
> +			 * If both pages we tried to merge belong to the same compound
> +			 * page, then we actually ended up increasing the reference
> +			 * count of the same compound page twice, and split_huge_page
> +			 * failed.
> +			 * Here we set a flag if that happened, and we use it later to
> +			 * try split_huge_page again. Since we call put_page right
> +			 * afterwards, the reference count will be correct and
> +			 * split_huge_page should succeed.
> +			 */
> +
> +			split = PageTransCompound(page)
> +				&& compound_head(page) == compound_head(tree_page);

Would

split = page_folio(page) == page_folio(tree_page);

do the trick? No need to mess with compound pages.

-- 
Cheers,

David / dhildenb

