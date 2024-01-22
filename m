Return-Path: <linux-kernel+bounces-32872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB7836132
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F17286059
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919F3DB93;
	Mon, 22 Jan 2024 11:10:50 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5853D99B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921849; cv=none; b=nWJbrqsxEMZjJO18/v7nCB4pkV2EbUxTKPJ0thbgo1kfDzm4C/jCcPbZIIuxA2JoSoYQQCG8p5ZZ7J84WJNAeKiJ8DKbC56p8fVXZ0wOKTK+tBLV7RU60yA/jlhKuJN7vMdqE7copcbAzRy8+YmJaevs0t7IIYl/FeXNOR60nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921849; c=relaxed/simple;
	bh=cuK6dlsAqqCyuHKmfg4fbsKC82Budl4OWQwU5QWb5N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEgrfGzOSc3ZfPk3or9OT2PeWyklCgI3MLa/dsRy09uh3UiPfXKI4emFCYlQ2HKKgPmWcF4qWxaIlJGZiuhN1XIio0oQsTT3sV+Dw0O/GXojBSEr64ng2wv7zjhJIwiRrAVZkAkh0EDt8B5pjwQEXbR7OexgYamyQ0+d7F0gPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.7NcCV_1705921837;
Received: from 30.221.149.111(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W.7NcCV_1705921837)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 19:10:38 +0800
Message-ID: <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
Date: Mon, 22 Jan 2024 19:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Liang Chen,

在 2024/1/22 下午6:22, Liang Chen 写道:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>   drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>   	}
>   }
>   
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))

I think 'vi->has_rss_hash_report' should be used here.
NETIF_F_RXHASH cannot guarantee that the hash report feature is negotiated,
and accessing hash_report and hash_value is unsafe at this time.

> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);

If the virtio-net-hdr is overrided by the XDP prog, how can this be done 
correctly and as expected?

Thanks,
Heng

> +
> +	switch (__le16_to_cpu(hdr_hash->hash_report)) {
> +		case VIRTIO_NET_HASH_REPORT_TCPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv4:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_NONE:
> +		default:
> +			*rss_type = XDP_RSS_TYPE_NONE;
> +	}
> +
> +	*hash = __le32_to_cpu(hdr_hash->hash_value);
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
> @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	dev->ethtool_ops = &virtnet_ethtool_ops;
>   	SET_NETDEV_DEV(dev, &vdev->dev);
>   
> +	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +
>   	/* Do we support "hardware" checksums? */
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
>   		/* This opens up the world of extra features. */


