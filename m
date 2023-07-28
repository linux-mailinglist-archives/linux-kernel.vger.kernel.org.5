Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C98766AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjG1Kev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjG1KeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792A1717
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690540244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeRW9S4IraEiSRP3XajTqTj5LA28qNkl4E7pfpLeXl0=;
        b=A9KWY2BkG73+EJdQju5kWrKxJv/dhFMseBlXdzjsvsmSzilYS9ry+MooLqX1eJVIj6MQ7V
        NiplxJz3cxfhermXEp6j66U0aHhi3Z6IZLiH12aVxv1zA0G/g/YkI4IC4HhcaRR0FNB6p9
        f7JEaOrI/rTvXoqPBKHNdEyXyymPaMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-_0IuFokUPVeYTIsrMqApng-1; Fri, 28 Jul 2023 06:30:43 -0400
X-MC-Unique: _0IuFokUPVeYTIsrMqApng-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fd2dec82a6so11475505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540242; x=1691145042;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeRW9S4IraEiSRP3XajTqTj5LA28qNkl4E7pfpLeXl0=;
        b=hLRAW2owEDVl9BVjl81zRiLTarM6Ou5hQbBYOl5HJO8N8/H1hZyQChMzeuEA5ht7aX
         4oVQl3whtARq6WSUvQKKob2uM1/gim8+Vrw9EMaC78SPOcJqxrx3vbEE0MLt0pkjFnYi
         lu8OPNYjbv+30kRDOJUYR8dTiS4ZJvHhusw44IVKnriUHYrKJ9WX9QIghA4iXGpF732a
         zNwPJETRPga5M0Tbu/2wMI70xt/1hUED4o1c2dWHjMn0bhwYUb6bjzvrdlPEcD1InsWy
         B0w15887qRQZOsq0ozKpzN62vi8Zz0Nqqg1AU+pbCLe6oEyaZuykC0cBxLY8U+5rGJHc
         gfig==
X-Gm-Message-State: ABy/qLYuDKV78M/QMMDy4pBA5rM486UKa1+ZNwF+pfJtVF+C3FWXYpSE
        Jhiry6EHQ6590Hh2cD98ha4rwLsOOnh1FPerZPhkouuH1LeVZ+sVX86Yf/8Eq8jgOZ70wdY3Ukp
        mDCttrIDj+uTG3ahFVwLXUo3T
X-Received: by 2002:a7b:cb8d:0:b0:3fb:b832:d79a with SMTP id m13-20020a7bcb8d000000b003fbb832d79amr1378733wmi.38.1690540242292;
        Fri, 28 Jul 2023 03:30:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEoXD6cie/e0g+FZfl/wau6ivG28fFLQHzaxWPXoeYCcCxN2yY836fF7KtjbhYj0CWvH+LoLg==
X-Received: by 2002:a7b:cb8d:0:b0:3fb:b832:d79a with SMTP id m13-20020a7bcb8d000000b003fbb832d79amr1378719wmi.38.1690540241930;
        Fri, 28 Jul 2023 03:30:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c20d100b003fba6709c68sm3816733wmm.47.2023.07.28.03.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:30:41 -0700 (PDT)
Message-ID: <8c9977ea-a6d5-893b-cb00-66e6007d0935@redhat.com>
Date:   Fri, 28 Jul 2023 12:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] mm/compaction: remove unnecessary return for void
 function
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-8-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728171037.2219226-8-shikemeng@huaweicloud.com>
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

On 28.07.23 19:10, Kemeng Shi wrote:
> Remove unnecessary return for void function
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 6052cb519de1..188d610eb3b6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1420,8 +1420,6 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	/* Skip this pageblock in the future as it's full or nearly full */
>   	if (start_pfn == end_pfn)
>   		set_pageblock_skip(page);
> -
> -	return;
>   }
>   
>   /* Search orders in round-robin fashion */
> @@ -2863,7 +2861,7 @@ int compaction_register_node(struct node *node)
>   
>   void compaction_unregister_node(struct node *node)
>   {
> -	return device_remove_file(&node->dev, &dev_attr_compact);
> +	device_remove_file(&node->dev, &dev_attr_compact);
>   }
>   #endif /* CONFIG_SYSFS && CONFIG_NUMA */
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

