Return-Path: <linux-kernel+bounces-36686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8483A502
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE11B2A5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7217C6D;
	Wed, 24 Jan 2024 09:16:37 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0C17C65
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087797; cv=none; b=DL5+FbH5rL3Z8X8aHOfmKs7OdtrkFfotx54uXrh/e/XV0QC2IEaf2zG6ldQ+IrQKhv+gYlhmblic39m709lZjpBW1/1AMqdZqdAfIeuBs8HfwLYD6Ng9BdEBl97lh6MV0WrUBp3l2d2sx44b1+XEgleo609+wt6CS6kpt1qddqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087797; c=relaxed/simple;
	bh=Gw027f+IjQyyQbAt7FOQ+4RHmj+3PaRU6TIsxKZu6kY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DMQzyQRTFB46+Fd3ZeJOjJ1W/qzV9SBnlPqSFRsR5UsANUcwu3efXt5m7vWaY6VJ6ocThQE8SEwgLBt5uKSTExZdT3RosPjh1u8fYNQNqEzcQocR7hz/AxK7Xm6zqmbvIGAkh66PdMWshy6UHJR/HiWPYJMkoHRsoukrXQ62fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.G52BL_1706087790;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.G52BL_1706087790)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 17:16:31 +0800
Message-ID: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
Date: Wed, 24 Jan 2024 17:14:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com>
In-Reply-To: <20240124085721.54442-3-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 24 Jan 2024 16:57:20 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> For the XDP_PASS scenario of the XDP path, the skb constructed with
> xdp_buff does not include the virtio header. Adding the virtio header
> information back when creating the skb.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b56828804e5f..2de46eb4c661 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	if (unlikely(!skb))
>  		goto err;
>
> +	/* Store the original virtio header for subsequent use by the driver. */
> +	memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);

About this, a spec is waiting for voting.

This may change the logic of the csum offset and so on.

Please not do this.

Thanks.


> +
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>
> @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
> +		/* Store the original virtio header for subsequent use by the driver. */
> +		memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, vi->hdr_len);
> +
>  		return head_skb;
>
>  	case XDP_TX:
> --
> 2.40.1
>

