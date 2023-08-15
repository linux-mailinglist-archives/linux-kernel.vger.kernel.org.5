Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648E77CB55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjHOKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjHOKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5D10F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A67660ACF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EEBC433C7;
        Tue, 15 Aug 2023 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692096682;
        bh=UMa1X1yBNn4YXZgBkkVVa8vD2q7hRE7GwCvqTCyu7RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHP6LmF+rwNJkpEv+AfM95Wflz69IWEain7wk53W5hv0B/CRFZMYLJDCJ7iSql6kn
         MQNrRCPzAl9WCHvQOl7oJkrzRTM7FxWVlIU65l5Caw5IGKW04T4bgcqamhJ819GpJg
         9HxLJuMURlQdv9sxcjhGycJtqxugV+EYLaDOiZNuRVOqR615Tu6ea6YFfoMC5bywVU
         csdbthwV28HMLVGDykSCUCMFjLPePet5BNBwIh7DA/R0B8l6NPM4gdpwkgUWo2FGFk
         Nzeh0Sud9+812CncfAEhuvPHy8Ihp5zFcLdubE71UScBRI26dskTCzhJRC7SCREQka
         mnLcDumiPv4yQ==
Date:   Tue, 15 Aug 2023 12:51:18 +0200
From:   Simon Horman <horms@kernel.org>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
Message-ID: <ZNtYpohWyjnb883M@vergenet.net>
References: <20230814171845.65930-1-feliu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814171845.65930-1-feliu@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:18:45PM -0400, Feng Liu wrote:

+ "David S. Miller" <davem@davemloft.net>
  Eric Dumazet <edumazet@google.com>
  Jakub Kicinski <kuba@kernel.org>
  Paolo Abeni <pabeni@redhat.com>

> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
> 
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
> 
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> 		struct receive_queue *rq,
> 		struct page *page, unsigned int offset,
> 		unsigned int len, unsigned int truesize,
> 		unsigned int headroom)
> {
> [...]
> 	struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
> 	hdr_len = vi->hdr_len;
> [...]
> ok:
> 	hdr = skb_vnet_hdr(skb);
> 	memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
> 
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct virtio_net_hdr_mrg_rxbuf.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

I'm unsure if this is 'net' material.

> ---
>  drivers/net/virtio_net.c        | 29 ++++++++++++++++-------------
>  include/uapi/linux/virtio_net.h |  7 +++++++
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..6ce0fbcabda9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -344,9 +344,10 @@ static int rxq2vq(int rxq)
>  	return rxq * 2;
>  }
>  
> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> +static inline struct virtio_net_common_hdr *
> +skb_vnet_common_hdr(struct sk_buff *skb)
>  {
> -	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> +	return (struct virtio_net_common_hdr *)skb->cb;
>  }
>  
>  /*
> @@ -469,7 +470,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  				   unsigned int headroom)
>  {
>  	struct sk_buff *skb;
> -	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct virtio_net_common_hdr *hdr;
>  	unsigned int copy, hdr_len, hdr_padded_len;
>  	struct page *page_to_free = NULL;
>  	int tailroom, shinfo_size;
> @@ -554,7 +555,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		give_pages(rq, page);
>  
>  ok:
> -	hdr = skb_vnet_hdr(skb);
> +	hdr = skb_vnet_common_hdr(skb);
>  	memcpy(hdr, hdr_p, hdr_len);
>  	if (page_to_free)
>  		put_page(page_to_free);
> @@ -966,7 +967,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>  		return NULL;
>  
>  	buf += header_offset;
> -	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +	memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>  
>  	return skb;
>  }
> @@ -1577,7 +1578,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  {
>  	struct net_device *dev = vi->dev;
>  	struct sk_buff *skb;
> -	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct virtio_net_common_hdr *common_hdr;
> +	struct virtio_net_hdr_mrg_rxbuf	*mrg_hdr;
>  
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1597,18 +1599,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!skb))
>  		return;
>  
> -	hdr = skb_vnet_hdr(skb);
> +	common_hdr = skb_vnet_common_hdr(skb);
>  	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> +		virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
>  
> -	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +	mrg_hdr = &common_hdr->mrg_hdr;
> +	if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  
> -	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> +	if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
>  				  virtio_is_little_endian(vi->vdev))) {
>  		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> -				     dev->name, hdr->hdr.gso_type,
> -				     hdr->hdr.gso_size);
> +				     dev->name, mrg_hdr->hdr.gso_type,
> +				     mrg_hdr->hdr.gso_size);
>  		goto frame_err;
>  	}
>  
> @@ -2105,7 +2108,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	if (can_push)
>  		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>  	else
> -		hdr = skb_vnet_hdr(skb);
> +		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
>  
>  	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>  				    virtio_is_little_endian(vi->vdev), false,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 12c1c9699935..db40f93ae8b3 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -201,6 +201,13 @@ struct virtio_net_hdr_mrg_rxbuf {
>  	struct virtio_net_hdr hdr;
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
> +
> +struct virtio_net_common_hdr {
> +	union {
> +		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> +		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> +	};
> +};

Does this belong in the UAPI?
I would have assumed it's a Kernel implementation detail.

>  #endif /* ...VIRTIO_NET_NO_LEGACY */
>  
>  /*
> -- 
> 2.37.1 (Apple Git-137.1)
> 
> 
