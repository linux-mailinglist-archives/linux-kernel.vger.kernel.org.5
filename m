Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2656C77C888
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHOH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjHOH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2AC1736
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692084407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUWIHiBbbg8YEf4lfImtTBAg3A+t8ntUP0gis/hwLeU=;
        b=bKf9hYuLNZEitOj/TgCySpjut3z3t31YMzRahONnf1cmkcVbpvFxzDnW503pZtc/53lD4A
        QKdOW3/SZeThJjRCxld6VzYTEodlOSnoiYTp9qfnWxKfyMRo9TcjfL5CQa8XnOapXNVsEf
        Iar7hhs4FP4/8yve1omGQzsmhE7IM8c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-b2fHN4YFOdqEcBir0oobeA-1; Tue, 15 Aug 2023 03:26:46 -0400
X-MC-Unique: b2fHN4YFOdqEcBir0oobeA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-317c8fbbd4fso3264917f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692084405; x=1692689205;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUWIHiBbbg8YEf4lfImtTBAg3A+t8ntUP0gis/hwLeU=;
        b=cQ/wE3pUe8grnKtrG4NUZs0uROQo2wROiSycBjwQZN0BQDb3lxL2ScufA9Z2xNw5me
         Sllxji6lVRvoIvzZyNaQtDxoz7KrLp+5erQ7Kum9wA97YKx5tLXLJvrkfimHmYv+E9wr
         oC4ED+uErJZugMC9F5lINWakRJLITOuWlJY4m1dOAWbJ53dkbnMjUGSFa7cz3SOGS5oi
         zfTzc4N0V0kjvHBbkSpOsWHtaFTiqpTD93f8rvgJuS1Syu/kh9G2D7CmQHLqVx+2F/vx
         pj8YtsVpKTnBH17HPmO/O8jgs6XeB+UQ6p40hvfdBzzdu5TQY9nFE8H9MpGvJEgBg6oH
         5UHg==
X-Gm-Message-State: AOJu0YwjVq+xG/T8KxFzULVaV4Tgwq57UtKvDgf03RImVaZd/3WV+mPT
        XjR9w476+2W8tomwZ1fR0VpIteUGTWuVLyg6LX87DVNIePIZvxWkm87qgd8JjL+DTUZHnvAY3bD
        s5M2IjToZ5AAbsvI7QSTCz4kM
X-Received: by 2002:a5d:4451:0:b0:317:5722:a41b with SMTP id x17-20020a5d4451000000b003175722a41bmr9192180wrr.7.1692084405065;
        Tue, 15 Aug 2023 00:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELZPctW5W6HhR2f2xem6d43Ke7qyqoAtwSgO+EgNXc13wZJlKzKbg9ggB81IqopVUexwLz6w==
X-Received: by 2002:a5d:4451:0:b0:317:5722:a41b with SMTP id x17-20020a5d4451000000b003175722a41bmr9192167wrr.7.1692084404711;
        Tue, 15 Aug 2023 00:26:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b003142ea7a661sm16991148wrr.21.2023.08.15.00.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:26:44 -0700 (PDT)
Message-ID: <b805cabc-f235-417b-04f5-6602f9c50c36@redhat.com>
Date:   Tue, 15 Aug 2023 09:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] mm/ksm: add pages scanned metric
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
References: <20230811193655.2518943-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230811193655.2518943-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 21:36, Stefan Roesch wrote:
> ksm currently maintains several statistics, which let you determine how
> successful KSM is at sharing pages. However it does not contain a metric
> to determine how much work it does.
> 
> This commit adds the pages scanned metric. This allows the administrator
> to determine how many pages have been scanned over a period of time.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/admin-guide/mm/ksm.rst |  2 ++
>   mm/ksm.c                             | 16 +++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 5c5be7bd84b8..776f244bdae4 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -159,6 +159,8 @@ The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>   
>   general_profit
>           how effective is KSM. The calculation is explained below.
> +pages_scanned
> +        how many pages are being scanned for ksm
>   pages_shared
>           how many shared pages are being used
>   pages_sharing
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 6b7b8928fb96..8d6aee05421d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -242,6 +242,9 @@ static struct kmem_cache *rmap_item_cache;
>   static struct kmem_cache *stable_node_cache;
>   static struct kmem_cache *mm_slot_cache;
>   
> +/* The number of pages scanned */
> +static unsigned long ksm_pages_scanned;
> +

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

