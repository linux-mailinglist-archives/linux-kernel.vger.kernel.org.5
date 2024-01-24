Return-Path: <linux-kernel+bounces-36679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03183A4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78691F22D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952117BCC;
	Wed, 24 Jan 2024 09:08:39 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6017BB5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087319; cv=none; b=OgQ8msGA2jTfI/18L2OuR594D60EiGKbiIOfJaQDCXeqPJSi+nbH8aumzGr4LoAQmFtY8iw1Zn5zRAdyXGjKZ6dr2gYVXd2bppGxND3L1gQqOLcRqnB7woCLCg2OW0k8gFo8WupNzD2Xdxif5qMOb6EtA2cRvM5wOHXTKIjvewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087319; c=relaxed/simple;
	bh=JOj8r2f7qR44MX7gLA5NhPnoaPXH4cwBhdfccGRndaM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IycEQBPC8nVKpOhBYIx5wR3QP1k8Uokz32KRa8abU6B4HPzcnY8GZdYkyK5odwNdwIhA/eo+P2+yA30ygDEI4nh2F5SMC89x8fOuMBkteGccjcxENUlE0rpYGtQ94jGyQphfMmisM7GHL0hvYCFXckLwHb4PSheA2G3oYii/bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.G5-fL_1706087310;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.G5-fL_1706087310)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 17:08:31 +0800
Message-ID: <1706087207.116824-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] virtio_net: Preserve virtio header before XDP program execution
Date: Wed, 24 Jan 2024 17:06:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-2-liangchen.linux@gmail.com>
In-Reply-To: <20240124085721.54442-2-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 24 Jan 2024 16:57:19 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> The xdp program may overwrite the inline virtio header. To ensure the
> integrity of the virtio header, it is saved in a data structure that
> wraps both the xdp_buff and the header before running the xdp program.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..b56828804e5f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -349,6 +349,11 @@ struct virtio_net_common_hdr {
>  	};
>  };
>
> +struct virtnet_xdp_buff {
> +	struct xdp_buff xdp;
> +	struct virtio_net_common_hdr hdr;

Not all items of the hdr are useful, we can just save the useful items.

> +};
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
>  static bool is_xdp_frame(void *ptr)
> @@ -1199,9 +1204,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	unsigned int headroom = vi->hdr_len + header_offset;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>  	struct page *page = virt_to_head_page(buf);
> +	struct virtnet_xdp_buff virtnet_xdp;
>  	struct page *xdp_page;
> +	struct xdp_buff *xdp;
>  	unsigned int buflen;
> -	struct xdp_buff xdp;
>  	struct sk_buff *skb;
>  	unsigned int metasize = 0;
>  	u32 act;
> @@ -1233,17 +1239,23 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		page = xdp_page;
>  	}
>
> -	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> -	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> +	xdp = &virtnet_xdp.xdp;
> +	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> +	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
>  			 xdp_headroom, len, true);
>
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	/* Copy out the virtio header, as it may be overwritten by the
> +	 * xdp program.
> +	 */
> +	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);

Can we put this into virtnet_xdp_handler?

And just do that when the hash is negotiated.

> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>
>  	switch (act) {
>  	case XDP_PASS:
>  		/* Recalculate length in case bpf program changed it */
> -		len = xdp.data_end - xdp.data;
> -		metasize = xdp.data - xdp.data_meta;
> +		len = xdp->data_end - xdp->data;
> +		metasize = xdp->data - xdp->data_meta;
>  		break;
>
>  	case XDP_TX:
> @@ -1254,7 +1266,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		goto err_xdp;
>  	}
>
> -	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
>  	if (unlikely(!skb))
>  		goto err;
>
> @@ -1591,10 +1603,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>  	struct page *page = virt_to_head_page(buf);
>  	int offset = buf - page_address(page);
> +	struct virtnet_xdp_buff virtnet_xdp;
>  	unsigned int xdp_frags_truesz = 0;
>  	struct sk_buff *head_skb;
>  	unsigned int frame_sz;
> -	struct xdp_buff xdp;
> +	struct xdp_buff *xdp;
>  	void *data;
>  	u32 act;
>  	int err;
> @@ -1604,16 +1617,22 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	if (unlikely(!data))
>  		goto err_xdp;
>
> -	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> +	xdp = &virtnet_xdp.xdp;
> +	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
>  					 &num_buf, &xdp_frags_truesz, stats);
>  	if (unlikely(err))
>  		goto err_xdp;
>
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	/* Copy out the virtio header, as it may be overwritten by the
> +	 * xdp program.
> +	 */
> +	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>
>  	switch (act) {
>  	case XDP_PASS:
> -		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
>  		return head_skb;
> @@ -1626,7 +1645,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(xdp);
>
>  err_xdp:
>  	put_page(page);
> --
> 2.40.1
>

