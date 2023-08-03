Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1005176E5C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjHCKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjHCKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9619B0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691058731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mpOFt6DwhElVJyrcZIFOK1JPk0QjZkqr5X+3q48fZo=;
        b=DpMz9MrJCYXi3A/6HYJwOgsZwljg/r2iEiZd9ExW5OqmFXIT0fq7k/JBa60h4M+Uu40YDO
        q3/S7nkd+5QtFLsYBpL5alOfxIIs1dE2m70aGO0gM5//G85m3o5PleT8iIYR3x7M9UatH1
        oEW5gdytcTNl35LChV2hK2LA7zCtYKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-m89x46gsMkWTs9oHH8PlZQ-1; Thu, 03 Aug 2023 06:32:09 -0400
X-MC-Unique: m89x46gsMkWTs9oHH8PlZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc08d6a40cso5390685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058729; x=1691663529;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mpOFt6DwhElVJyrcZIFOK1JPk0QjZkqr5X+3q48fZo=;
        b=XbpI9zmkSFeNi2fQJlR2osWsS+gqxPkH9iyLJdqJXgYcOdtRNJdo+7+LiXodxVXQ61
         lFMTcPgiIrVF02rWoLxsveo4FmqVwcj4bevBjHGvzVD3KV17rEKjnTMMWAr8JIvaBEym
         kCigK+ym/HlbvZqmYcGCFA4WPfC73v6xfekRwvRyMOjW5H10N5arjOKHDrPw/LlEgUew
         jhPdpC2sEKZmyYRAsyttD7F2MBJrUAErOxidT9uG1MACHF0+gpuOVa4IRMY9e/InFqSL
         ySeSdDYzAtqM4WtIp8S0UoCW7pyEk9IR6PUOltDTvnVLPAPUWqQ5TzC9g3HoY6uWnIkR
         k59w==
X-Gm-Message-State: ABy/qLY3lwHJFMKnwLmFM1kzpfzwbhoCwYpAGN+X9QG9nxjDCplPcx3t
        fD7WWDPiZNeLGadSpmaGfw6JT3vvuznacowzNo+JLX2luT2Bf3UrWEs8g7sL0gjTIw9VQDOxvIx
        wYzc3cRrAUrdrEfQ9ZEw8U/jtqB/9PNUW
X-Received: by 2002:a5d:4b8d:0:b0:317:55c:4936 with SMTP id b13-20020a5d4b8d000000b00317055c4936mr6871054wrt.9.1691058728824;
        Thu, 03 Aug 2023 03:32:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG49T1nyit3vXKn7yaANm9DiIsaFZrp1EUVZuc0VDEsx/hzEaO8+7aKSUxmvJe31CvcaKBiiw==
X-Received: by 2002:a5d:4b8d:0:b0:317:55c:4936 with SMTP id b13-20020a5d4b8d000000b00317055c4936mr6871038wrt.9.1691058728483;
        Thu, 03 Aug 2023 03:32:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b0031779e82414sm21429294wru.79.2023.08.03.03.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 03:32:08 -0700 (PDT)
Message-ID: <63c8cb4c-84c8-6c55-8876-ba1638788804@redhat.com>
Date:   Thu, 3 Aug 2023 12:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] mm/compaction: remove unnecessary "else continue"
 at end of loop in isolate_freepages_block
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net
References: <20230803094901.2915942-1-shikemeng@huaweicloud.com>
 <20230803094901.2915942-5-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230803094901.2915942-5-shikemeng@huaweicloud.com>
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

On 03.08.23 11:49, Kemeng Shi wrote:
> There is no behavior change to remove "else continue" code at end of scan loop.
> Just remove it to make code cleaner.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/compaction.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cb1dd5c5bf3f..006fc35bffa1 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -666,8 +666,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   isolate_fail:
>   		if (strict)
>   			break;
> -		else
> -			continue;
>   
>   	}
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

