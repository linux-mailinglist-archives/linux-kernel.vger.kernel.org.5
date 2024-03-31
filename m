Return-Path: <linux-kernel+bounces-126068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE68931AD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E410281DE4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF6144D0A;
	Sun, 31 Mar 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fn2rK449"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9222EB08;
	Sun, 31 Mar 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711891389; cv=none; b=LPxdNPTQYubClB+XrBga/fM3q6b52sArWKdtMvUMFTuO3Tej33gYNZiFiv4pnAPcmdwPBP2hWK7cBgt3+48fRjN3K+neN9F9zziSj7LdkEs9bmmBevxCnTwoq5Mm35gxgltZGga6VgLzqkVQXdQi8YASKsCaN9S+SYOG6Tc69no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711891389; c=relaxed/simple;
	bh=0JdnalII33ICqSebxleFo2xxjuuYod6bhO/Ywq4s8/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoqUlETmyZI73zoxV6OcludGi++MNrPXCy3rOOm5RDyI93jqu2eeAsi5vw7e+/yy7SxC/RSgvkcRQLwDh8NBTBMe5ERbg8cDzWdICLXXYX2pZJyxyhc4gJgx/BfUmjK3u5M1OEzpHIKpf1MmpkN6LChuLD1AdlAnX7CefSDV0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fn2rK449; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711891378; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DNVFJe7fzXJ46hFedS/yET7Jx+L9l6utZ/e9Xt9A6X8=;
	b=fn2rK449UwxAktwc06z/gHLkd7nxrhpX7uWiykXzVdT27RatS3BoIPlE5eLtg6xVpZ4vhBovaNpCHm5sBSnjugXpmKstOdcgg8XnbUlUPScpMFRS5/wRJtR0TMJgr9R1dn/nzhr7qwc8K5EOPw/egpB6h/ifdb36uJXH57tgDSM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3bgCBV_1711891376;
Received: from 30.121.31.164(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3bgCBV_1711891376)
          by smtp.aliyun-inc.com;
          Sun, 31 Mar 2024 21:22:57 +0800
Message-ID: <8b6f03a9-1afb-42ef-82aa-7eaf7517133c@linux.alibaba.com>
Date: Sun, 31 Mar 2024 21:22:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20240329171641.366520-1-leitao@debian.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240329171641.366520-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/30 上午1:16, Breno Leitao 写道:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
>
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
>
>      # ethtool -X eth0  hfunc toeplitz
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
>    if (!sz) {
>        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
>
> 6) virtio_error() (also QEMU function) set the device as broken
>
>      vdev->broken = true;
>
> 7) Qemu bails out, and do not repond this crazy kernel.
>
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
>
> 9) The kernel is waiting doing the following :
>
>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
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
> ---
> Changelog:
>
> V2:
>    * Moved from creating a valid packet, by rejecting the request
>      completely
> V3:
>    * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>      the rejection path.
>
> ---
>   drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..c4a21ec51adf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>   			    struct netlink_ext_ack *extack)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> +	bool update = false;
>   	int i;
>   
>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
>   		return -EOPNOTSUPP;
>   
>   	if (rxfh->indir) {
> +		if (!vi->has_rss)
> +			return -EOPNOTSUPP;
> +
>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>   			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> +		update = true;
>   	}
> -	if (rxfh->key)
> +
> +	if (rxfh->key) {
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EOPNOTSUPP;
> +
>   		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> +		update = true;
> +	}
>   
> -	virtnet_commit_rss_command(vi);
> +	if (update)
> +		virtnet_commit_rss_command(vi);
>   
>   	return 0;
>   }
> @@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>   		vi->has_rss_hash_report = true;
>   
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>   		vi->has_rss = true;
>   
> -	if (vi->has_rss || vi->has_rss_hash_report) {
>   		vi->rss_indir_table_size =
>   			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>   				rss_max_indirection_table_length));
> +	}
> +
> +	if (vi->has_rss || vi->has_rss_hash_report) {
>   		vi->rss_key_size =
>   			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>   

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks.




