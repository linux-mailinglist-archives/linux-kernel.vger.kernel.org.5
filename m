Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C027A18D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjIOIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C532D2D51
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694766525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcGHkHEkl2F+HrrCmBnGlpMxClskGfx3G9ZgUgAvCEo=;
        b=IYrcxiSUPT4slav0QS1PxHTK2eAbqe62iSu+mjTk2BEwgCB3nti83wKPNoNtUCKh+GRDeW
        /lrQ/fvJ/G0U0quP0z5Pf6umBS2SbjWI724WRfRKkRWaRuJKj2SZbgPxM90OtU37x8/tLz
        MMED9Dhn9vK3/2oCgTPqV25thxNjCBw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-UL51ZWM_PomKwA57dc_ZPA-1; Fri, 15 Sep 2023 04:28:44 -0400
X-MC-Unique: UL51ZWM_PomKwA57dc_ZPA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be51691dd5so22999301fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766523; x=1695371323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcGHkHEkl2F+HrrCmBnGlpMxClskGfx3G9ZgUgAvCEo=;
        b=v+kQj9x0HmeNOxSAkloAxwECd53BST4UoJ9R0g5xZyEsJ/4YsNyKauBSflJN9OQeu6
         1Fu1oTj5fF0sASKynLvon1AJDhmc1xonvIKWai/LJ2e2vb2fd3a1nSpqR2xPJtfOldwX
         dpdJyqw/qcqfMv+dkD57KLmfwLXCFLE2z6/M+WFxa62/UkS+vKNwAOW0bQPuSL90A4tW
         /TfqDWm1Sx5YNO9HD0TgMpxS6Q/yZVJne1diL1ADdKVtBpVATmIhdIn0rvc9Eocw1h7g
         t2RreDRPpjT9iu9TJoPHS94BC2fWOjK0v/OTF7uvU3uFqeK5TZ21gBSoRVgZ5N+waDsI
         GQYw==
X-Gm-Message-State: AOJu0Yxq54IiKoQVkkKmqR35VXf5eoxxQgh4IpRv/3yq0vDsVbVtKqR/
        37M4Oa72z+DuAmZps2bNDroyVPO/tgZAD+UboL4udtKKKRU9I+IKNc6XnNlT5oWzCXKQjUrvIEl
        5NyDb3vWgE6ejwIZCuzjfBN22
X-Received: by 2002:ac2:5e68:0:b0:502:a56b:65f7 with SMTP id a8-20020ac25e68000000b00502a56b65f7mr809378lfr.16.1694766522966;
        Fri, 15 Sep 2023 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXe9WijGF+xd6sNUS8Btxyd7ZjXZH/hd49roTE/EzbjLuB9jzTKiTfy80O32sXsGz2tMVrcw==
X-Received: by 2002:ac2:5e68:0:b0:502:a56b:65f7 with SMTP id a8-20020ac25e68000000b00502a56b65f7mr809354lfr.16.1694766522621;
        Fri, 15 Sep 2023 01:28:42 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f86d3e52c0sm557925lfm.4.2023.09.15.01.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 01:28:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
Date:   Fri, 15 Sep 2023 10:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com>
Content-Language: en-US
In-Reply-To: <20230912083126.65484-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

This looks reasonable, but given you are changing struct-page
(include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
Also Cc Wilcox.

I think it was Ilias and Duyck that validated the assumptions, last time
this patch was discussed. Thus I want to see their review before this is
applied.

-Jesper

On 12/09/2023 10.31, Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using frag API.
> 
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aliged
> buffer, see [2].
> 
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
> 
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.
> 
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>   include/linux/mm_types.h        | 13 +------------
>   include/net/page_pool/helpers.h | 20 ++++++++++++++------
>   net/core/page_pool.c            | 14 +++++++++-----
>   3 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..74b49c4c7a52 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,18 +125,7 @@ struct page {
>   			struct page_pool *pp;
>   			unsigned long _pp_mapping_pad;
>   			unsigned long dma_addr;
> -			union {
> -				/**
> -				 * dma_addr_upper: might require a 64-bit
> -				 * value on 32-bit architectures.
> -				 */
> -				unsigned long dma_addr_upper;
> -				/**
> -				 * For frag page support, not supported in
> -				 * 32-bit architectures with 64-bit DMA.
> -				 */
> -				atomic_long_t pp_frag_count;
> -			};
> +			atomic_long_t pp_frag_count;
>   		};
>   		struct {	/* Tail pages of compound page */
>   			unsigned long compound_head;	/* Bit zero is set */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..8e1c85de4995 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -197,7 +197,7 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>   	page_pool_put_full_page(pool, page, true);
>   }
>   
> -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
> +#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
>   		(sizeof(dma_addr_t) > sizeof(unsigned long))
>   
>   /**
> @@ -211,17 +211,25 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>   {
>   	dma_addr_t ret = page->dma_addr;
>   
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> +		ret <<= PAGE_SHIFT;
>   
>   	return ret;
>   }
>   
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>   {
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> +		page->dma_addr = addr >> PAGE_SHIFT;
> +
> +		/* We assume page alignment to shave off bottom bits,
> +		 * if this "compression" doesn't work we need to drop.
> +		 */
> +		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> +	}
> +
>   	page->dma_addr = addr;
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		page->dma_addr_upper = upper_32_bits(addr);
> +	return false;
>   }
>   
>   static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..8a9868ea5067 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>   		 */
>   	}
>   
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> -		return -EINVAL;
> -
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>   	if (!pool->recycle_stats)
> @@ -359,12 +355,20 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>   	if (dma_mapping_error(pool->p.dev, dma))
>   		return false;
>   
> -	page_pool_set_dma_addr(page, dma);
> +	if (page_pool_set_dma_addr(page, dma))
> +		goto unmap_failed;
>   
>   	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>   		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>   
>   	return true;
> +
> +unmap_failed:
> +	WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
> +	dma_unmap_page_attrs(pool->p.dev, dma,
> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +	return false;
>   }
>   
>   static void page_pool_set_pp_info(struct page_pool *pool,

