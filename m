Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9F761DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGYPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjGYPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B0210A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690300500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rv8S/zcV2N2vUpm00btAH6Fups+Kl/lJF0ckKEFzR6Q=;
        b=iTIJQQ8CYZ9XWonnVQUJ4GDYasUndACfzv6UCRybIYXa+k0kVNPyhTZjZft9xOomI/HzKo
        YCHqMV0lukII6OIwpDfhhyX2ji7bDiVJ7KhxAYlXJtE/k1aSs4dvu2T75JP2npTrW6M2e6
        MK0v9mJdQooSN/5cF3+GfiEHoVtWf8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575--b2BywuCOeCapNrGyzqyfA-1; Tue, 25 Jul 2023 11:54:57 -0400
X-MC-Unique: -b2BywuCOeCapNrGyzqyfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fb40ec952bso28525175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300491; x=1690905291;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rv8S/zcV2N2vUpm00btAH6Fups+Kl/lJF0ckKEFzR6Q=;
        b=WAaMl0LKfmQVP+Vp0AZNv/YO1xG/OQOeAFaEg36GnkMZp4ba1vSge/g1hKmDVk9JBG
         LuzxvhHFOj4RjKSXzyLT4j68IFZ35cEq+rc0VySI9tTy+gQ+0TbB8e7cpxUiY8vMvAen
         lmV34y9GQibFO/lpLOcsRg+ZktxEOB6dYUzenGnKiSqLg8jjVVZG6EBoGgvdrOJGMD1M
         uqoPBan9kPxzSrTJ22BWcYRKQDU9f75q0EliCINzCuCCuzqcAMIo/tkM7KxIFrqIesSc
         rEPnMx6HjrqXrforJUCxjYkZ5xJiZ44DU0a5kWZmL31DoKC+SRDjhlHWPAEcLII1XS8u
         +Dqw==
X-Gm-Message-State: ABy/qLYFqeIdurZmbG9ikYD4kfsQFqwIZg9XS3vQD8HCWXKhFHOTRsW0
        FhKtjFXurnXuIElLdhzc0lFFZLkfectLz5TkAf3cFgaRrwuq3+DGqyU/0E7hZg7tdgF+gQzgOdw
        IZvEDdrxGXbRTMi+IkOqjkg+S
X-Received: by 2002:a05:600c:204:b0:3fc:1f8:41f1 with SMTP id 4-20020a05600c020400b003fc01f841f1mr10441618wmi.1.1690300490881;
        Tue, 25 Jul 2023 08:54:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHV9+assCuUkXwLKP3VEOwgoPJMwz3cWjDuEtCd3lwJvIdKbf3yEjz1rrsAQPkcMtE1lpFUag==
X-Received: by 2002:a05:600c:204:b0:3fc:1f8:41f1 with SMTP id 4-20020a05600c020400b003fc01f841f1mr10441608wmi.1.1690300490541;
        Tue, 25 Jul 2023 08:54:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:e900:3b0d:87a6:2953:20d1? (p200300cbc73fe9003b0d87a6295320d1.dip0.t-ipconnect.de. [2003:cb:c73f:e900:3b0d:87a6:2953:20d1])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fc02e8ea68sm16557959wmk.13.2023.07.25.08.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:54:50 -0700 (PDT)
Message-ID: <3af0795f-2ba8-2033-8b4e-e6fa889767aa@redhat.com>
Date:   Tue, 25 Jul 2023 17:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mprotect: fix obsolete function name in
 change_pte_range()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230723033114.3224409-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230723033114.3224409-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.23 05:31, Miaohe Lin wrote:
> Since commit 79a1971c5f14 ("mm: move the copy_one_pte() pte_present check
> into the caller"), the explanation of preserving soft-dirtiness is moved
> into copy_nonpresent_pte(). Update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/mprotect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 5c3112d92466..3f36c88a238e 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -213,7 +213,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>   			} else if (is_writable_device_private_entry(entry)) {
>   				/*
>   				 * We do not preserve soft-dirtiness. See
> -				 * copy_one_pte() for explanation.
> +				 * copy_nonpresent_pte() for explanation.
>   				 */
>   				entry = make_readable_device_private_entry(
>   							swp_offset(entry));

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

