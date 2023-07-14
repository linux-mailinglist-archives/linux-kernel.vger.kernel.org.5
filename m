Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6517542AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjGNSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjGNSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDD1BEB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689359864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlt/C80WJuZUiszaR3tLxgEwAcnLKDklXFhvNucHvpc=;
        b=e49QXlrMb0tfoxyEnpH4oPJJ5ym2S8cCq8vnTfjr65YH/Mx27wxACXmxvWpoVoggi65mkI
        85S4GdF5SZ2rsSqcUwC1bje1IlrrCw2Q4tWw6lq4DCKRDy8IwcSWyPtiXZrswROG41X1Or
        k/ZYRJ7P7u2+0Jf0YNKswmryLPoO7/w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-uGfc9TreNkKbcsiWk88FbA-1; Fri, 14 Jul 2023 14:37:43 -0400
X-MC-Unique: uGfc9TreNkKbcsiWk88FbA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b698377ed7so21805441fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359862; x=1691951862;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlt/C80WJuZUiszaR3tLxgEwAcnLKDklXFhvNucHvpc=;
        b=TvfI5FgcJfquhDJIfIy5JmbTjP/U66ROTwdYLtfDWyWDQPmR4xUmkL3kovQyfUXo5h
         hZ3dKbWKzi/U/dP11jRAXyaCRfskE8ZGaf+VLrZrwbEfuvFAWUpr33/OTNKzCJc2T0f1
         Y4S5YvaHVFxOWCrdHakp3xE7X/ObekwZZC1c7SVEZ+VuwCjiHjIyr85r5f8eStK2yoNz
         ixAZ2cuVmrGxGpngOzYWSDGboKvY/DMgbH5P8m3vMhAgP5PjBgMQC/ymFYRaQoWQRaK0
         78A+3+w8ibR958lkS2S9HcgbanYA6Hb+UmglvtRJNbbu2plIWscn7aExXS2Wd+ewinTB
         FZPw==
X-Gm-Message-State: ABy/qLb6qyH++vgO2Iere5pcuIAvVtlvP2u1SornnpXZqFWj+WBNnKM4
        Ujk+oXta5YNotHZv9vdbvd5tD8BpeN3LomDvf0ROmgWpI8bHA+cVCKMBk8KQOFvd/07Rqc/skEG
        C/hewJW9XGv2/QPKdrNh4wo03
X-Received: by 2002:a2e:9053:0:b0:2b5:9e51:2912 with SMTP id n19-20020a2e9053000000b002b59e512912mr4824484ljg.24.1689359861978;
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0DcrmoWUD7erkzbvOJvy1v8KA2m34srzCw022IBv7s40Nq/DYobabu5nOWd5bEX1/OOSj6A==
X-Received: by 2002:a2e:9053:0:b0:2b5:9e51:2912 with SMTP id n19-20020a2e9053000000b002b59e512912mr4824471ljg.24.1689359861658;
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906038800b009893650453fsm5726448eja.173.2023.07.14.11.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:37:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
Date:   Fri, 14 Jul 2023 20:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com>
In-Reply-To: <20230714170853.866018-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2023 19.08, Alexander Lobakin wrote:
> On x86_64, frag_* fields of struct page_pool are scattered across two
> cachelines despite the summary size of 24 bytes. The last field,
> ::frag_users, is pushed out to the next one, sharing it with
> ::alloc_stats.
> All three fields are used in pretty much the same places. There are some
> holes and cold members to move around. Move frag_* one block up, placing
> them right after &page_pool_params perfectly at the beginning of CL2.
> This doesn't do any meaningful to the second block, as those are some
> destroy-path cold structures, and doesn't do anything to ::alloc_stats,
> which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
> into 1 cacheline).
> On my setup, this yields 1-2% of Mpps when using PP frags actively.
> When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
> plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
> CL, so there should be at least no regressions from the actual change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/net/page_pool.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 829dc1f8ba6b..212d72b5cfec 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -130,16 +130,16 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
>   struct page_pool {
>   	struct page_pool_params p;
>   
> +	long frag_users;
> +	struct page *frag_page;
> +	unsigned int frag_offset;
> +	u32 pages_state_hold_cnt;

I think this is okay, but I want to highlight that:
  - pages_state_hold_cnt and pages_state_release_cnt
need to be kept on separate cache-lines.


> +
>   	struct delayed_work release_dw;
>   	void (*disconnect)(void *);
>   	unsigned long defer_start;
>   	unsigned long defer_warn;
>   
> -	u32 pages_state_hold_cnt;
> -	unsigned int frag_offset;
> -	struct page *frag_page;
> -	long frag_users;
> -
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	/* these stats are incremented while in softirq context */
>   	struct page_pool_alloc_stats alloc_stats;

