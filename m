Return-Path: <linux-kernel+bounces-134249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618789AF7E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAEA282E1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67901173F;
	Sun,  7 Apr 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FQfjlvnL"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5612B83;
	Sun,  7 Apr 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477583; cv=none; b=qK7/3/k864epQzLWcnoAb+tsS5upNcjbbGJy9Smkn04M1jNKIr6LK8Vm5AeyEuSfcWRyK+njtO4Un2xnbibHmuDyajTbUUDebg+l4GUaeGEjGeKV6U6HiFQTYW+/O0XElpI2psYkdsuctrZ+4huhWq3pRMM8Pr7FWLKwOxx+sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477583; c=relaxed/simple;
	bh=fgvBYr5qb0CRValf4l8NVrLApElBgdEGuMbFLvYJTZM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=i+M5vGC7KcqNLvPI7R4n+AZtJ+mjlQf7Xwm1sofemCeE8twtLlxX+Hom1H2D8VMjhR7VIQipB6FdEoAnKtFbKyeDw3exTgBfZCACSTx7uZSw01nx14LXDMXbkWZgU2DPH9itvjhMqNc0pmBh0X89o0g70P5DQzcA9bQjfzNQ+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FQfjlvnL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712477578; h=Message-ID:Subject:Date:From:To;
	bh=Jyrgw+fdsx70sA5rZNTdVtftvjSvV7dvUm0DDwjdLJw=;
	b=FQfjlvnLyb9rS6Jf0JpTxFfCIl9PAdi0OpCW8/hNhAl/XzkjpfV6eHFjrsmntHnqkorBfrBj6N7Z9hfvFFId451b9EAJr0yGenfuy9yMUkrBC4MqAAq1j9aFe5jR/KFOsnZBR/mC3bFx6FwOusWePbCkflxkqcHaJZXEAPZF0vM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4.rUrS_1712477576;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4.rUrS_1712477576)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 16:12:57 +0800
Message-ID: <1712477565.823871-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v4] virtio_net: Do not send RSS key if it is not supported
Date: Sun, 7 Apr 2024 16:12:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com,
 riel@surriel.com,
 stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 hengqi@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20240403154313.1331319-1-leitao@debian.org>
In-Reply-To: <20240403154313.1331319-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed,  3 Apr 2024 08:43:12 -0700, Breno Leitao <leitao@debian.org> wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
>     # ethtool -X eth0  hfunc toeplitz
>
> This is how the problem happens:
>
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
>
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
>
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
> scatter-gather
>
> 4) Since the command above does not have a key, then the last
> scatter-gatter entry will be zeroed, since rss_key_size == 0.
> sg_buf_size = vi->rss_key_size;
>
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> with zero length, and do the following in virtqueue_map_desc() (QEMU
> function):
>
>   if (!sz) {
>       virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
>     vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> 	     !virtqueue_is_broken(vi->cvq))
> 	      cpu_relax();
>
> 10) None of the following functions above is true, thus, the kernel
> loops here forever. Keeping in mind that virtqueue_is_broken() does
> not look at the qemu `vdev->broken`, so, it never realizes that the
> vitio is broken at QEMU side.
>
> Fix it by not sending RSS commands if the feature is not available in
> the device.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> Changelog:
>
> V2:
>   * Moved from creating a valid packet, by rejecting the request
>     completely.
> V3:
>   * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>     the rejection path.
> V4:
>   * Added a comment in an "if" clause, as suggested by Michael S. Tsirkin.
>
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..115c3c5414f2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	bool update = false;
>  	int i;
>
>  	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> @@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  		return -EOPNOTSUPP;
>
>  	if (rxfh->indir) {
> +		if (!vi->has_rss)
> +			return -EOPNOTSUPP;
> +
>  		for (i = 0; i < vi->rss_indir_table_size; ++i)
>  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> +		update = true;
>  	}
> -	if (rxfh->key)
> +
> +	if (rxfh->key) {
> +		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
> +		 * device provides hash calculation capabilities, that is,
> +		 * hash_key is configured.
> +		 */
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EOPNOTSUPP;
> +
>  		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> +		update = true;
> +	}
>
> -	virtnet_commit_rss_command(vi);
> +	if (update)
> +		virtnet_commit_rss_command(vi);
>
>  	return 0;
>  }
> @@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>  		vi->has_rss = true;
>
> -	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_indir_table_size =
>  			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>  				rss_max_indirection_table_length));
> +	}
> +
> +	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>
> --
> 2.43.0
>

