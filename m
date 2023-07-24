Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741EC75F61E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGXMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGXMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC751BF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690201053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rw38L/Q8Z4s8bYibZZQKRAeS223PBas54MnJkEMI578=;
        b=EMrV+S9kXPzaiun9CW4tY8MEIJ8Z+eAJM75OFlPclmPmVS6vvKZ7UsOX/j15FUhdmEb/GG
        m1RNE6YwB7fAq+0Bbud41PgM5bZJeYxVA7gt0KEBmSZAF/UvOprdVwr/BgrhosINSAzNWc
        ENOvIh0GcEizNWycCUk5PtIzn/Cx9qc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-xQRTI1wTMQuC2bZfzDPW_g-1; Mon, 24 Jul 2023 08:17:32 -0400
X-MC-Unique: xQRTI1wTMQuC2bZfzDPW_g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso2088412f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690201051; x=1690805851;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw38L/Q8Z4s8bYibZZQKRAeS223PBas54MnJkEMI578=;
        b=J6RivClykvLSKwtlBRkFYag/J4j4lFMf+36MH0K5Tiiit6Lyg4pOPACqjyG8r5X0jl
         VxVnEYhk4wGeQP43pDouvMjj5yi3YgiTvwrTgC3oCcof2igwW6SEPqzbRYUloyLX9sXk
         ewLyzL7ytS2npLY8pYnw1Na9SwLd32+eV1EE/FJv2sAUw2IapjLXlnwD3GE0Vq6TaTQ6
         L1SSwqY0Xh55ABlhA10ns4AJE+d67prGz1WeWrBeB3h5EKk3ld0NORV05Zsy5P/ZWxG6
         6nBY2bq2MMfNp6yjTSH9OLO1xPRaq7ciGlX8cIo5QFKZ+2esDK09jdr+Nba+vpU9nDZF
         x8rQ==
X-Gm-Message-State: ABy/qLaRuQhk7Dme6BmpBtu1zqCbKGxG87M1n8/XAY7EE5QeN1NkJlzE
        cN6ZEdDHMyZ7xQOhVIUY3+OG3h0DZG5e2GTvQelPykf2de+IDGu1NBTlRzxbVgrOLpUauKavXku
        ULmVBj8TPiEBec6ccK5ihqFMW
X-Received: by 2002:a5d:61c5:0:b0:30f:af19:81f3 with SMTP id q5-20020a5d61c5000000b0030faf1981f3mr6477781wrv.41.1690201050954;
        Mon, 24 Jul 2023 05:17:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYkw/lGxF1vjEi65r5E6yxlhuiVPGxjyLJAPmxRiUwT8XJoqElxkVFhxzMFJGpNUQbu+34jA==
X-Received: by 2002:a5d:61c5:0:b0:30f:af19:81f3 with SMTP id q5-20020a5d61c5000000b0030faf1981f3mr6477770wrv.41.1690201050535;
        Mon, 24 Jul 2023 05:17:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77? (p200300cbc73dbb0091a50d1c3a7e4c77.dip0.t-ipconnect.de. [2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77])
        by smtp.gmail.com with ESMTPSA id o26-20020a5d58da000000b0030ae499da59sm12758358wrf.111.2023.07.24.05.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:17:30 -0700 (PDT)
Message-ID: <754fa87f-48a1-b086-c258-6f74375dec29@redhat.com>
Date:   Mon, 24 Jul 2023 14:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] mm/compaction: avoid unneeded pageblock_end_pfn
 when no_set_skip_hint is set
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com
References: <20230721150957.2058634-1-shikemeng@huawei.com>
 <20230721150957.2058634-3-shikemeng@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721150957.2058634-3-shikemeng@huawei.com>
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

On 21.07.23 17:09, Kemeng Shi wrote:
> Move pageblock_end_pfn after no_set_skip_hint check to avoid unneeded
> pageblock_end_pfn if no_set_skip_hint is set.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c0d8d08fc163..9b7a0a69e19f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -458,12 +458,12 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>   {
>   	struct zone *zone = cc->zone;
>   
> -	pfn = pageblock_end_pfn(pfn);
> -
>   	/* Set for isolation rather than compaction */
>   	if (cc->no_set_skip_hint)
>   		return;
>   
> +	pfn = pageblock_end_pfn(pfn);
> +
>   	if (pfn > zone->compact_cached_migrate_pfn[0])
>   		zone->compact_cached_migrate_pfn[0] = pfn;
>   	if (cc->mode != MIGRATE_ASYNC &&

I'm pretty sure the compiler can to optimize this -- there should not be 
any function call involved, so the compiler can reorder as it pleases.

Anyhow, change itself looks good.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

