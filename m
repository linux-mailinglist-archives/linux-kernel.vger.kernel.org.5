Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38535766ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjG1KkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjG1Kjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E959CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690540543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOcaw/0qBs1pPL6pAEnr1BL8Snh0gAK7vHtXru4ReFI=;
        b=Mp6i+tWKHowr6O8EBcPtrZP8HXhjy7fNpLcdmaKsw6lGuvJeO/TN7fS7Cfkgw5tD2LoaX5
        Yx81O/b+Y8jOmFzaz0nwBNXubtOQi4O9RYIJhFBORgbVaGLlIXUfoF7boVZebfR3z3IHii
        BoM9EikcfqIN8CapwOKphO+zjm1oXvs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-v39PRSG4MWqI5GqZE-TN5A-1; Fri, 28 Jul 2023 06:35:41 -0400
X-MC-Unique: v39PRSG4MWqI5GqZE-TN5A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31444df0fafso1275166f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540541; x=1691145341;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOcaw/0qBs1pPL6pAEnr1BL8Snh0gAK7vHtXru4ReFI=;
        b=eYXhgK1ZUQa9q0ZrQO3X38vOElk17RTK7l4HjJDqOwbHVsyVQM17zRBW9Nvmij7S3y
         vW64/qojOmXUc27pLpJsVN7KShSsz+fuoyDUrB1yS8PiIccN2IPS+hUUOFzCWCRJ33aM
         UBlfwR/etCt48BtBQ4bJfyVb90Enwyfk0Bl/KOdXtlCmQ3nflQVacngznJU8Kb4yb0i5
         LGezbpCRAGXgRq4FAPao0nKKiOqbeJK1spX8CH+labMAe69jENb/SYQRHYtMEjZM60KD
         owdR6/7ef/8dQNCi6cmjBi+YCo5ngEQSKj79kN33O5IhuBhtuQsEk5GI39NF2xNrIf29
         6CHA==
X-Gm-Message-State: ABy/qLYks0HTeEdtgZEIobm0SOh9d45W9MALDjf12q4SF4QZ3gZgMptN
        FYHAST3PG+h8OrseGTSldSntR2XJ7+71NSrwdSPKDINB8fgEanNLEDSf+V/+mW19p2Y0opEFcRk
        5IbPB8gKvDquEORBmx+cDWP0S4cleOE9M
X-Received: by 2002:a5d:424f:0:b0:317:7c31:f3a7 with SMTP id s15-20020a5d424f000000b003177c31f3a7mr1510171wrr.17.1690540540784;
        Fri, 28 Jul 2023 03:35:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjjIUzyCArZTitz+9i+d3qhAkwJUs0xSjHxU4IyWnOBX1very2BprXi83soc4m7lHWi0Qymw==
X-Received: by 2002:a5d:424f:0:b0:317:7c31:f3a7 with SMTP id s15-20020a5d424f000000b003177c31f3a7mr1510156wrr.17.1690540540408;
        Fri, 28 Jul 2023 03:35:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0031437299fafsm4497581wrm.34.2023.07.28.03.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:35:40 -0700 (PDT)
Message-ID: <cd29967b-b07d-1eb7-0d28-2bd983f0c0ee@redhat.com>
Date:   Fri, 28 Jul 2023 12:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] mm/compaction: corret comment of cached migrate pfn
 update
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-6-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728171037.2219226-6-shikemeng@huaweicloud.com>
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
> Commit e380bebe47715 ("mm, compaction: keep migration source private to
> a single compaction instance") moved update of async and sync
> compact_cached_migrate_pfn from update_pageblock_skip to
> update_cached_migrate but left the comment behind.
> Move the relevant comment to correct this.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 09c36251c613..1eebb61a1f63 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -464,6 +464,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>   
>   	pfn = pageblock_end_pfn(pfn);
>   
> +	/* Update where async and sync compaction should restart */
>   	if (pfn > zone->compact_cached_migrate_pfn[0])
>   		zone->compact_cached_migrate_pfn[0] = pfn;
>   	if (cc->mode != MIGRATE_ASYNC &&
> @@ -485,7 +486,6 @@ static void update_pageblock_skip(struct compact_control *cc,
>   
>   	set_pageblock_skip(page);
>   
> -	/* Update where async and sync compaction should restart */
>   	if (pfn < zone->compact_cached_free_pfn)
>   		zone->compact_cached_free_pfn = pfn;
>   }

Again, no expert, but LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

