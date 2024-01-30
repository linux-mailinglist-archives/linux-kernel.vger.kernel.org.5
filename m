Return-Path: <linux-kernel+bounces-44555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B09842425
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CCB2B7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349167E69;
	Tue, 30 Jan 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hsIs+yNn"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C367747
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615597; cv=none; b=InHq7PKKKvbtbyVZax+KBNRC+2JDo2q5a3aZurfJOg8ygkA/8lxdsc217MMGBtStin8MZR8ug58VITXa5K1JwzQnJTbOD5MHToEBSxc8dhCGxTPheOKSNAQgG06HrZnCV/vrf5s60uc2W65fDmqo7ipWkk42sXQB3peVwJIzU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615597; c=relaxed/simple;
	bh=JztyLydpOvMohc+UwTatWh0c53pEslI4RUN5TBcmW2Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=cvpvyMlPdRD3IvxllWyu8PNJ5uYbGucxkDzKPH+6XaQHLXkSQ0sMnGM0hxf6TfRQdze8RWGy1FDrD1HTJP7RSLu6pZmSoKW0RfhMzM/LcL3zEl/adkkZ0u66zAtV9dw0xuqQuy4Df8KMUhCmVENwiciLAK8IgzJx5TGte5O2OVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hsIs+yNn; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706615591; h=Message-ID:Subject:Date:From:To;
	bh=q2JRxgqAQrdi04QI4nuksa65Pz4ECDDuDGAQKGPG6hQ=;
	b=hsIs+yNn6uLQ7+56aeexzSeNIUhjrdDdck86lHcsyD8H38I67WgXjvJ6bDfqtlTQuD1yat2Mjwneu6dzgmgi0i7N/3bmueQV8awQBwYy1jDPT9aQKG93HC33Xt1IQk0pVVrGZjrZZncFNAvA6KGTG8TYA9/+QrDtS/qhrMcASfs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.g5LPL_1706615590;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g5LPL_1706615590)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:53:11 +0800
Message-ID: <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio_net: Support RX hash XDP hint
Date: Tue, 30 Jan 2024 19:52:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240125101912.60346-1-liangchen.linux@gmail.com>
In-Reply-To: <20240125101912.60346-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 25 Jan 2024 18:19:12 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 86 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..0c845f2223da 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
>  	};
>  };
>
> +struct virtnet_xdp_buff {
> +	struct xdp_buff xdp;
> +	u32 hash_value;
> +	u16 hash_report;
> +};
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
>  static bool is_xdp_frame(void *ptr)
> @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  	}
>  }
>
> +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
> +				     struct net_device *dev,
> +				     struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +	if (dev->features & NETIF_F_RXHASH) {
> +		virtnet_xdp->hash_value = __le32_to_cpu(hdr_hash->hash_value);
> +		virtnet_xdp->hash_report = __le16_to_cpu(hdr_hash->hash_report);

Could we put the __leXX_to_cpu to virtnet_xdp_rx_hash?

Other looks good to me.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.


> +	}
> +}
> +
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct net_device *dev,
>  			       unsigned int *xdp_xmit,
> @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
> @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
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
> @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		goto err_xdp;
>  	}
>
> -	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
>  	if (unlikely(!skb))
>  		goto err;
>
> @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
> @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
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
> @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(xdp);
>
>  err_xdp:
>  	put_page(page);
> @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>  	}
>  }
>
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
> +
> +	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	switch (virtnet_xdp->hash_report) {
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_NONE:
> +	default:
> +		*rss_type = XDP_RSS_TYPE_NONE;
> +	}
> +
> +	*hash = virtnet_xdp->hash_value;
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>
>  		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>  	}
>
>  	if (vi->has_rss_hash_report)
> --
> 2.40.1
>

