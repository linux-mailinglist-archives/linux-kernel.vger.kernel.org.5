Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B50788184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbjHYIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbjHYIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3961FDA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692950629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MxIZZ4mXfirEQxPRIwxDlbt+KbgvYe7pzgQ6nQuMXM=;
        b=NWTMLXRWP+Y/5d4WCd5mvMFtdhTnyOY08LbeiVF956cAoL7iFq2Dp7pM9pdK0ZRPk2WkZH
        J+0suFEBXh2QJ1XUXFZEbTzwRBLUgif9fqp366+W2C8c4jQx6k0c9OottRpGNKrNlEomZb
        Tr87KgP4oGz9LGi/rA52wXXAoQpmL4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-146L-j9gNNm4IkQD858E-w-1; Fri, 25 Aug 2023 04:03:47 -0400
X-MC-Unique: 146L-j9gNNm4IkQD858E-w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31aecb86dacso482733f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692950626; x=1693555426;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MxIZZ4mXfirEQxPRIwxDlbt+KbgvYe7pzgQ6nQuMXM=;
        b=iWGJ0/a7bUAfKllKAXN2GL7ZryZ5Xd/cV6Ori+2h/JGfuDQ3rD7T6b8mXCKDHeY3bw
         8peeOyDzv2fJTFwQuwmG6qIBWm7C/0S6BL+zZMnKDFZSAK4Q0pR/0pFLJ0I8A7fPedgl
         PrzKnC8IRsG3rrcXimpUCKxBkn90OF0s2g3GyQXCRjgTyoaABlDw3gLTQVHnsKdN6Y/z
         JwuQzybofz3Kb1oaKGL8OAu2vKKXVJi3Fxe8TvvFXxIRwMItWqHB9++AVOyihZz5Jj1O
         aF5FeC5/zhosRs3guQ0pbgZ0WH0WZdMAq87PRtXi8L0e4/vr5a83w05AcAH8XYVX8sos
         3kMA==
X-Gm-Message-State: AOJu0YxwccolmrOuOz6rq5Ev8a44gSZCCPBB2p7BJftbfwAedTvSalGX
        dZxAIL8aFafB3YZAgEH8Nf6oSLC+mrGXjmjmcQxJWjTPasGh33H1x6zqWzXojRTEKG0MZLWicck
        iGLwM8bMJiwqiZZctvIyFzXXU
X-Received: by 2002:adf:f3cd:0:b0:313:e9f6:3378 with SMTP id g13-20020adff3cd000000b00313e9f63378mr12914612wrp.4.1692950626182;
        Fri, 25 Aug 2023 01:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp77WBmoQU7jbIBWKspqG9dAlzLpg5JTV9tJC+oX4MTnlZBIoLiOJSXLCsVRo5z+lM1xyTlQ==
X-Received: by 2002:adf:f3cd:0:b0:313:e9f6:3378 with SMTP id g13-20020adff3cd000000b00313e9f63378mr12914599wrp.4.1692950625838;
        Fri, 25 Aug 2023 01:03:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d684f000000b003180027d67asm1464874wrw.19.2023.08.25.01.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 01:03:45 -0700 (PDT)
Message-ID: <56300927-4b81-8acc-58d3-4cbe0f1d60f1@redhat.com>
Date:   Fri, 25 Aug 2023 10:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm/vmscan: Use folio_migratetype() instead of
 get_pageblock_migratetype()
Content-Language: en-US
To:     Vern Hao <haoxing990@gmail.com>, akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vern Hao <vernhao@tencent.com>
References: <20230825075735.52436-1-user@VERNHAO-MC1>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230825075735.52436-1-user@VERNHAO-MC1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 09:57, Vern Hao wrote:
> From: Vern Hao <vernhao@tencent.com>
> 
> In skip_cma(), we can use folio_migratetype() to replace get_pageblock_migratetype().
> 
> Signed-off-by: Vern Hao <vernhao@tencent.com>
> ---
> v1 -> v2
> 	- remove "Fixs:xxx" as David Hildenbrand suggestion.
> 
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2b5d61eeb039..850811bb5699 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2271,7 +2271,7 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
>   {
>   	return !current_is_kswapd() &&
>   			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
> -			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;
> +			folio_migratetype(folio) == MIGRATE_CMA;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

