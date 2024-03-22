Return-Path: <linux-kernel+bounces-110868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF38864FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3166A1F238F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984D4436;
	Fri, 22 Mar 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gQwzMsof"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840F10FA;
	Fri, 22 Mar 2024 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072974; cv=none; b=O6XRMgPvL9kIcHCKRq+hcCKntsMF7IT8zTdwpL2etp0OoAFbjBBa/sC04eLiOLyxjpjnZBkoOPlQE4IVlBl2fJgFzR1FAs4LCCQQrwBgH+1I2a7JMyV8Ae7WVErS/0AJv33Zuh2USYxlCgqmHyKU8dFI7L7JsQJCLo02l8PhgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072974; c=relaxed/simple;
	bh=2194g1paJ8iOlnAMy9lsEIbmtlsUjcd9QLT2ghW2vt0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Llu6YRMu7MqpUyEiDP295XQ1JboRzHnnp4cfjApPpklKwsyXYVc6C1jDKFE2yo6LtVTFmsg60BvcVarQ9AOJMMGd9lkUjjdV7wfbyZLGIMjk13Ce3c1cRRHWIqlBGcVSWpPnMMzKRH2IC2aLVHN+c2t3YQxrYuAGlB+OW3+cIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gQwzMsof; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711072963; h=Message-ID:Subject:Date:From:To;
	bh=u+tMN1LwSbe9n5PNdUk4hVRTCTGRyukBQQgHRB/HjG0=;
	b=gQwzMsofuI6CHMGWSTO531VoxSI5eOv5f331uYnnSS5YZbC8kLpar/xGRyliLgo/gIFs/RCQKtPF3R2SV+QKiSGi+udv4so3BxsAhMf3zKzI1o8CRFjVJsqMed5XqdLa0v6DlSC4cxWbpxYCa3OM1aLU4AK50HGJT62dxB/d58A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W3077TT_1711072960;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3077TT_1711072960)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 10:02:41 +0800
Message-ID: <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Fri, 22 Mar 2024 10:00:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com,
 riel@surriel.com,
 stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20240321165431.3517868-1-leitao@debian.org>
In-Reply-To: <20240321165431.3517868-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
> 	# ethtool -X eth0  hfunc toeplitz
>
> This is how the problem happens:
>
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
>    scatter-gather
>
> 4) Since the command above does not have a key, then the last
>    scatter-gatter entry will be zeroed, since rss_key_size == 0.
>     sg_buf_size = vi->rss_key_size;



	if (vi->has_rss || vi->has_rss_hash_report) {
		vi->rss_indir_table_size =
			virtio_cread16(vdev, offsetof(struct virtio_net_config,
				rss_max_indirection_table_length));
		vi->rss_key_size =
			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));

		vi->rss_hash_types_supported =
		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
		vi->rss_hash_types_supported &=
				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);

		dev->hw_features |= NETIF_F_RXHASH;
	}


vi->rss_key_size is initiated here, I wonder if there is something wrong?

Thanks.


>
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
>    with zero length, and do the following in virtqueue_map_desc() (QEMU
>    function):
>
>       if (!sz) {
>           virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
> 	vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
>    virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>                  !virtqueue_is_broken(vi->cvq))
>                   cpu_relax();
>
> 10) None of the following functions above is true, thus, the kernel
>     loops here forever. Keeping in mind that virtqueue_is_broken() does
>     not look at the qemu `vdev->broken`, so, it never realizes that the
>     vitio is broken at QEMU side.
>
> Fix it by not sending the key scatter-gatter key if it is not set.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> ---
>  drivers/net/virtio_net.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..5a7700b103f8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3041,11 +3041,16 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  {
>  	struct net_device *dev = vi->dev;
> +	int has_key = vi->rss_key_size;
>  	struct scatterlist sgs[4];
>  	unsigned int sg_buf_size;
> +	int nents = 3;
> +
> +	if (has_key)
> +		nents += 1;
>
>  	/* prepare sgs */
> -	sg_init_table(sgs, 4);
> +	sg_init_table(sgs, nents);
>
>  	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
>  	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
> @@ -3057,8 +3062,13 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>  	sg_set_buf(&sgs[2], &vi->ctrl->rss.max_tx_vq, sg_buf_size);
>
> -	sg_buf_size = vi->rss_key_size;
> -	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> +	if (has_key) {
> +		/* Only populate if key is available, otherwise
> +		 * populating a buffer with zero size breaks virtio
> +		 */
> +		sg_buf_size = vi->rss_key_size;
> +		sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
> +	}
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>  				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> --
> 2.43.0
>

