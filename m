Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6C766AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjG1KhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjG1KhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1D4EC9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690540394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loKHor4heQF4evwuaE0DPh9ksKzfUuyvJ2BFPrdMAY0=;
        b=KiSmiZySPfT2TPGfUlA7eFqLssYzDCn/WOaJquilEibas/B21z81jq/9o2wqePVrhk5l/M
        g6EBv2MMeri2prGJxedFvMSXCtG+rkfClDF3DKdJS2QoAxHhScATzN27F9gJQQtRRZV0LR
        Zs61ZMt002FUMXdeW7FRhmoZysct4EE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-G3IKizU6P_CR-kHZn4TCQA-1; Fri, 28 Jul 2023 06:33:13 -0400
X-MC-Unique: G3IKizU6P_CR-kHZn4TCQA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc0855dcc5so11035665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540392; x=1691145192;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loKHor4heQF4evwuaE0DPh9ksKzfUuyvJ2BFPrdMAY0=;
        b=GzfiVEbZrKVFAManERorI3IHA4zS6fIm2i+/cjK9Yu80HBA4DvXNQLqA1nrU0lolSR
         I6jWjg3jOc2dkIp3bvI2pbv4ti1LNifo/X5Fg2cfAA6LVQ3J7gMkqRhGBOmEVo5kgNJr
         EhTv8W1ZI4Z1xw85TDC0cIfaY65oZkg2bo0pxsK9D1E9VawgFdu4q+W6+QV5MuTAjmyq
         S8Uqpg4pazryFgbWo820Fn4JuwREToQSXbjfH12aGgaWieT61LeTMA4rjvTDlt/mg0d2
         tpY+lG9VP4ketf/ZV8Vn/ZOj60aLHEM032u/VWcZnGXNZwegEDpxOZksalSg+wybUWIt
         eXsA==
X-Gm-Message-State: ABy/qLYLGxDn1x7Q9tfFE9b8tcL5Q6DQrAwxx8pIuOp3GJ/tlzP/v/K9
        /71PesWDP7PH0mR6Dnii0V5bSbqSLU+R0EBUMK+JCltPnoeQ2CIWuBOCXL7cBogcJbEb6bUaXZm
        AO95Qqw9dxuGUQZeJDULdkcxa
X-Received: by 2002:a7b:c459:0:b0:3f9:b955:5584 with SMTP id l25-20020a7bc459000000b003f9b9555584mr1406939wmi.34.1690540391945;
        Fri, 28 Jul 2023 03:33:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJIicurWmbYq2RRi0Fxc2aMXkMrUFIvxVHBN5OO35hHxmTsx8C9A4ChJuPJy6FLq/qOmhJXw==
X-Received: by 2002:a7b:c459:0:b0:3f9:b955:5584 with SMTP id l25-20020a7bc459000000b003f9b9555584mr1406928wmi.34.1690540391603;
        Fri, 28 Jul 2023 03:33:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id v16-20020a1cf710000000b003fc080acf68sm6688003wmh.34.2023.07.28.03.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:33:11 -0700 (PDT)
Message-ID: <06d566cc-fa03-f68f-e0a4-236567ae5684@redhat.com>
Date:   Fri, 28 Jul 2023 12:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] mm/compaction: only set skip flag if
 cc->no_set_skip_hint is false
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-9-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728171037.2219226-9-shikemeng@huaweicloud.com>
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
> Keep the same logic as update_pageblock_skip, only set skip if
> no_set_skip_hint is false which is more reasonable.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 188d610eb3b6..6841c0496223 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1418,7 +1418,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>   
>   	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (start_pfn == end_pfn)
> +	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
>   		set_pageblock_skip(page);
>   }
>   

LGTM, although I am not an expert on that code.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

