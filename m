Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B3B7D9A85
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjJ0Nz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0NzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0BC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698414878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hy9ASv0VMyxyTx5ycKNQ4ht5ekQ9TAA9ltCXTwU9SXk=;
        b=BgxSZCFPNEtE9R+mYoxtdohvTe6D8iT0C4Ldi6CjlFz8Yn/y8Ww/LEeCvK78muuABq2og3
        8kGyqPO8ZxxTpYpDEK1ovety4ZWxaTnud/vc9JFcEqsB/EyC3hWebgypIoi3oVOMeG9e3W
        iXzHem1IWTzXYVVwwzXGCoJpVzxW/aI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-dafNZVbNPHqSGfpxgjHWPg-1; Fri, 27 Oct 2023 09:54:27 -0400
X-MC-Unique: dafNZVbNPHqSGfpxgjHWPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32dd782e2d1so1162690f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414866; x=1699019666;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy9ASv0VMyxyTx5ycKNQ4ht5ekQ9TAA9ltCXTwU9SXk=;
        b=gkFcZUkz5xAL+SK/ZA80mPN9vIGG2gAhyL8QUNkyOKUZYKZS2c23Kq2xKnDShNlJMI
         q4Yc4Zyw/UaAi5Ngxss+Yihn6cqaNorHp7X8Sb1227x8GytSN0TeEbhzIFh2yQpaHh/y
         hyTzSo1MvwO/cT7hnsOaYsq5FzT/bvWVX+3auRBhH0OVD+sLtXmYEoMJVg5PRLllSe13
         Zcy02U9Lmwgt6zprdsWLHAOWNLFbHRiwSPmgXKr+mUyYYcrplhfNA7LFk+j8NzpE1gFK
         2nrOBmfllm51XIQ3byoCTVopISHm6Hy0p2jrYeo7XhkPtky601M1tU/R48ZBtojXMz/J
         lgOg==
X-Gm-Message-State: AOJu0YxiUIgaJ/GQOWy3zxEtm3OLzdejyebNOG4x0c1447VxCOMGKv8S
        QUsbdQ982Z1Fr9bVwWIGkhbVqRqI98cAtXPHOBp7k1S6CmG58AR8r3Jne5CWbNGJhg6TsLVFG78
        zbUyJN/hFkSREc0i9hKYwkMK9
X-Received: by 2002:a5d:570f:0:b0:32d:9787:53b6 with SMTP id a15-20020a5d570f000000b0032d978753b6mr2014569wrv.44.1698414866366;
        Fri, 27 Oct 2023 06:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl7zeZVnx8FGwUy89ZC/egYT6gDW91Ny/6sL/sc2pDc2DN5LKEUrZN7EVytLFPLbxDX8BVfg==
X-Received: by 2002:a5d:570f:0:b0:32d:9787:53b6 with SMTP id a15-20020a5d570f000000b0032d978753b6mr2014557wrv.44.1698414865993;
        Fri, 27 Oct 2023 06:54:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c000:811f:68f2:1ecb:4e2d? (p200300cbc71ac000811f68f21ecb4e2d.dip0.t-ipconnect.de. [2003:cb:c71a:c000:811f:68f2:1ecb:4e2d])
        by smtp.gmail.com with ESMTPSA id h22-20020adfa4d6000000b0032dc74c093dsm1810443wrb.103.2023.10.27.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:54:25 -0700 (PDT)
Message-ID: <43181f18-7cae-4736-8e47-adc23ab62a6e@redhat.com>
Date:   Fri, 27 Oct 2023 15:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: page_alloc: check the order of compound page even
 when the order is zero
Content-Language: en-US
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <CGME20231023084301epcas2p2de7cdc5cb6795d409a183aae43ce8c13@epcas2p2.samsung.com>
 <20231023083217.1866451-1-hyesoo.yu@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231023083217.1866451-1-hyesoo.yu@samsung.com>
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

On 23.10.23 10:32, Hyesoo Yu wrote:
> For compound pages, the head sets the PG_head flag and
> the tail sets the compound_head to indicate the head page.
> If a user allocates a compound page and frees it with a different
> order, the compound page information will not be properly
> initialized. To detect this problem, compound_order(page) and
> the order argument are compared, but this is not checked
> when the order argument is zero. That error should be checked
> regardless of the order.
> 
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> ---
>   mm/page_alloc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 95546f376302..fc92ac93c7c8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1078,6 +1078,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   	int bad = 0;
>   	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
>   	bool init = want_init_on_free();
> +	bool compound = PageCompound(page);
>   
>   	VM_BUG_ON_PAGE(PageTail(page), page);
>   
> @@ -1096,16 +1097,15 @@ static __always_inline bool free_pages_prepare(struct page *page,
>   		return false;
>   	}
>   
> +	VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
> +
>   	/*
>   	 * Check tail pages before head page information is cleared to
>   	 * avoid checking PageCompound for order-0 pages.
>   	 */
>   	if (unlikely(order)) {
> -		bool compound = PageCompound(page);
>   		int i;
>   
> -		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
> -
>   		if (compound)
>   			page[1].flags &= ~PAGE_FLAGS_SECOND;
>   		for (i = 1; i < (1 << order); i++) {

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

