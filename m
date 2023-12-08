Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0C80AB65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjLHR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjLHR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:56:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF527198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:56:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A69DC433C8;
        Fri,  8 Dec 2023 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702058200;
        bh=9xxAbGXzLKVinje/1qrTMCGO6En/seWuAJ9zKs2OvRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KktLrsaHMqHuSdviPwgKD8eaGdxnuIIA4B6K6LyNeKKK7EhZ2jsE5y2g0PbAlQLer
         5AZD+X8hVBf/pb6iCzYpjpO1mYT0e5phnU3CUE6Ye44qGWVDkbiSW1wIJ01RKfpqH1
         aIsWiOCHUl+yjhU69kpDY6WMx48AuAE3yhIXC1chevQQLoEBFmjqiEysAoA2jweMb9
         EmhyG8e1p62psBESzHBntY1HPYMm/o6U/cZsY2Jw/gG5H1OkQdrGgZc5bezgme0n3P
         vdBkZN5APkNeAlIxu6r+1QD1FytYmVy1OGPCUGxcdSSgAwFdHKWNbrN/KOExS72/Km
         KOcx35phxF+6w==
Message-ID: <462da4bf-34f8-40c4-8772-9850b3127baf@kernel.org>
Date:   Fri, 8 Dec 2023 10:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 07/16] netdev: netdevice devmem allocator
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-8-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208005250.2910004-8-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 5:52 PM, Mina Almasry wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b8c8be5a912e..30667e4c3b95 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2120,6 +2120,41 @@ static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
>  	return err;
>  }
>  
> +struct page_pool_iov *netdev_alloc_dmabuf(struct netdev_dmabuf_binding *binding)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner;
> +	struct page_pool_iov *ppiov;
> +	unsigned long dma_addr;
> +	ssize_t offset;
> +	ssize_t index;
> +
> +	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,

Any reason not to allow allocation sizes other than PAGE_SIZE? e.g.,
2048 for smaller MTUs or 8192 for larger ones. It can be a property of
page_pool and constant across allocations vs allowing different size for
each allocation.
