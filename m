Return-Path: <linux-kernel+bounces-120214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E623F88D487
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D54C1C242C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4321104;
	Wed, 27 Mar 2024 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q+w9NU5B"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229120334;
	Wed, 27 Mar 2024 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506491; cv=none; b=puEfXgFJ5CrourBhZzOvQq96B4WYE4RNKtO6kFa8C01TWKreLItMv82DtudK6Ks7PZhP7M8xm6DY4NtjLLXFmNPzryFkz0iDkpMGFAUZ5w6Lg1kzbvZt9mHcawD9XDFxIGCBWUE2XNAA0Vu8QQbkD++i8ZCGHpC/xkWyfELgXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506491; c=relaxed/simple;
	bh=suO/hxHkYIiR7aN5fNMxxIMiIKDf7s7yifppD3JVj0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGJDyie/1XsRB9X7ERTb0oh8kx6aTRyov8ZGu6qI0r7vUuNKW30FhT2UZBJVbaZOu95Mgodp3NC+juyjpSLRlF7++11X4pckBi3XqOiExVK+nfjomDdXQVreAywmd53x7dp3n5HomTbCKgLyfEJ5w7K0dRmnn6zbCiU7dnxgF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q+w9NU5B; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711506481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/zfwjKKsw5HeZkRsJXEcqJbxo+5sK1+snEjBOm3OoIY=;
	b=Q+w9NU5B9Krkmfa+4MMlen2FiZBR713PSX35fsyzFuwIKo2HqxHWA5BAQbbu9P6W4MxsHifoknxTn+YvUCRRSrQIqG+z3tvtgHaU26PYKkfpRqDQVmSpCtNMrsoHk8c+V+p1oZRwVFRaL8fDKoiq4LWXvgnGT4kuDegQPanhGWs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3Mvu.x_1711506478;
Received: from 30.221.148.214(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3Mvu.x_1711506478)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 10:27:59 +0800
Message-ID: <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
Date: Wed, 27 Mar 2024 10:27:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
To: Breno Leitao <leitao@debian.org>, xuanzhuo@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240326151911.2155689-1-leitao@debian.org>
 <20240326151911.2155689-2-leitao@debian.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240326151911.2155689-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 下午11:19, Breno Leitao 写道:
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
>   drivers/net/virtio_net.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c640fdf28fc5..e6b0eaf08ac2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	int i;
>   
> +	if (!vi->has_rss && !vi->has_rss_hash_report)
> +		return -EOPNOTSUPP;
> +

Why not make the second patch as the first, this seems to work better.
Or squash them into one patch.

Apart from these and Xuan's comments.

For series:

         Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Regards,
Heng

>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>   	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>   		return -EOPNOTSUPP;


