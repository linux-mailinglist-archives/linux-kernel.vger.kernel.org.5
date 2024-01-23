Return-Path: <linux-kernel+bounces-34808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FD8387BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736F61C232AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730E524DA;
	Tue, 23 Jan 2024 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvDJGNe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F7524AB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993352; cv=none; b=qPrwuxNLphbcT1RbjEvRgJCOIHHCSGCfNRAiygQ6mgeTqzeJ7EziGsBWIp909k++gFWaSeg3tVHlHbArBCDOm36THf3CaEo+akHXY4Qe/4CFCwmu7XUFeUEOaxTFhBDh8vG1RkzZOt/mNv3a82SVeu4hzUWzd7QA+4BhE8MVK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993352; c=relaxed/simple;
	bh=PckbnojtQP7fIhmpNDhDIvlrNTBhrfSCfkOehTYrNes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkXiIlFaWueu2Xlmp7TM2VUcMYjTIXzBWBHlGi1rCVgbkcacN/B465WEAB+9wfpEs9Po1RE6Mxf+ItUFMJ8kbBeDV/5HylVSbCLkcijuWCm7vdZjhw2sa63cM4GcOWp2hirlr3E1DceAEYHSRzvqspZatyYMBPzwIcld8tq26bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvDJGNe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705993349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsV76N5FsHio9dpfWTXAdKJMHXRNJk86MphFy5Q6dbc=;
	b=bvDJGNe8MI3mwy7As2gg5POHC/APm2KRznWsrUMRq2YaQasac9tb/WGnegBSFqtXkCy5G+
	zNVmuxq070grCE1H6UWwIsiujeokngcYrvBUpagcNRm9SKl6iuoL2zkO3Ovt0i9NdBFAdS
	nHzDmL9NqDNMhuwmolVAqA4U7CR5AYU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-v209av_aMYqufANvaurR6g-1; Tue, 23 Jan 2024 02:02:27 -0500
X-MC-Unique: v209av_aMYqufANvaurR6g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3392c9e8001so930191f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705993346; x=1706598146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsV76N5FsHio9dpfWTXAdKJMHXRNJk86MphFy5Q6dbc=;
        b=EigWGpbU2YjwMpfBCYDgiSx4qJDtn54IbgENZgSTp2eFZloFFmCVoj7XcEB8CywPxW
         Y+hQDLas99d6usYqeVbt8lTbmXPt0Oy5z8BJvfoK+RY2hL7oY2XUeMuU7JC8AyL2kAD8
         zQVtyAkrfCX0HC3Inr5LTLKf4YJ5VrXLvA8Rhk1/S5wFr85yQUh5hFkH5tHVV3hkO+mb
         Pz4c+3fdsBNjTFIolskOu6Y/NmQqJnNv6DRDgEkxLhQZWu6RlFjXTsXVVLcJz2lGO/Of
         ehkyDlyFiLV33EQ8YbXiOigpCIKa0g8SsiylOrgjelxOdZKxBPcmPL7udg6dm/1Mo0fW
         TqrA==
X-Gm-Message-State: AOJu0YyjZ+aaWP4/dPGJ2Yn+EwmSUS1n69JJE9jK9/sW2Id/Zy20J9KQ
	bmolYdKW9pblsAfmrDaG7rQYx31fLNH4PUm7QrXwO3V7WNsKG1CtRB/0ATZnG/7UQaVctf6yv7S
	+1fzYFMevfma6geKK6DjWtdWNKoU3HQzIzmFjGPv+RHe41wADPAu/K3/AagpHIpD2C48G7A==
X-Received: by 2002:a5d:45c8:0:b0:339:2316:2dfd with SMTP id b8-20020a5d45c8000000b0033923162dfdmr2793876wrs.55.1705993345948;
        Mon, 22 Jan 2024 23:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKPCc/VKtZ0fB34YBJ8fKJhmwOhPLSe4PAnPOQ4TN+MbrkUQsJV7uRv9FqgcBj96Znj8l10A==
X-Received: by 2002:a5d:45c8:0:b0:339:2316:2dfd with SMTP id b8-20020a5d45c8000000b0033923162dfdmr2793868wrs.55.1705993345613;
        Mon, 22 Jan 2024 23:02:25 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id d6-20020adff846000000b0033725783839sm15422511wrq.110.2024.01.22.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:02:24 -0800 (PST)
Date: Tue, 23 Jan 2024 02:02:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
Message-ID: <20240123020132-mutt-send-email-mst@kernel.org>
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>

On Mon, Jan 22, 2024 at 06:22:56PM +0800, Liang Chen wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>  	}
>  }
>  
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
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
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	dev->ethtool_ops = &virtnet_ethtool_ops;
>  	SET_NETDEV_DEV(dev, &vdev->dev);
>  
> +	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +

How about making this assignment depend on 

xdp->rxq->dev->features & NETIF_F_RXHASH

?

>  	/* Do we support "hardware" checksums? */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
>  		/* This opens up the world of extra features. */
> -- 
> 2.40.1


