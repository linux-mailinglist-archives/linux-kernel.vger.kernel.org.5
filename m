Return-Path: <linux-kernel+bounces-126366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501498935BA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52311F21535
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA88147C86;
	Sun, 31 Mar 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwEQXYEG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974546FCC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711916445; cv=none; b=PIlODYnJ8qXdKLEDuHR6fidyIrD0XnDjr2Y3WTZ9n50xjOdbcSMReBfpDADPEqZbcPMtSkQolpoUb9FBcccHEpCwr0q3fZMoekHSWD8nzs8LZ68DpJuKCz/BD4PiuV0tgyoTSHzYhXypaqOzpNRDuLneVSgLQuBP1QhjZqqMb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711916445; c=relaxed/simple;
	bh=pw6ynhZlliocTZxNsLu4uszjDWeDXBnouTCCdjYhWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMCrEiIr4QBp0ldTcMWa49pJwwdC6MuVQyhcS9V/W2RgNlKIfxshPlWxHOeTzCsAupKx18CKO7PaXAllMKjSHYB8O2Ri9hQDUDTmBC1u1Cmu2v2CZ0iGj7Dy9p8Bz5asx8q1LruclycSoQRa2qqbQNZjMhz0jyD9zhehy2/fpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwEQXYEG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711916441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRRVj/JjKizxzXFDRSo3l/T54pHZqeXumE93BFWpnkg=;
	b=dwEQXYEGH0YB+fDeXVH7gGwKA45ulahfDCZOP+GVq4aXoIU5LRKQjIbpWK9hOlcuVe/7K6
	+Z37tFSU8ZviF/ivDUMyT7f8BkENemiKi6ER5lE2fIOWq+SrVBcFIE/7doOkAmZjVTvIMW
	AJ7uHenA7DeA/NRGcLTcCXQR20z5nVo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Yc8YtgsfPwm1B0zAiE6I5Q-1; Sun, 31 Mar 2024 16:20:39 -0400
X-MC-Unique: Yc8YtgsfPwm1B0zAiE6I5Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4488afb812so212075166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711916438; x=1712521238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRRVj/JjKizxzXFDRSo3l/T54pHZqeXumE93BFWpnkg=;
        b=EhCb1ruCURDOwR9yhWe+nhOmIdE4QvLX/6kMIkGbjoIBCm/xbpIqLBaBlDZF1J+9lJ
         VkoaaenMDIy4L2r+HZvBPBKkSjQqC14rNzAv1J3snDQ0tobJVGFp+Endcklds7RU1fI6
         2MZCYpBKXWuKbxCsqcdQ9yAL4ID/QKi65skn9NqMz8wUGHEvAWtOluVLdBBHyHTzp+O9
         dFwEniNw8wKZWflbPtwctNmB5JdhgLGqibppAWc1Ct1fwfEtK2t7hWjSqFrzXw6Zcu+j
         jsp4T8anrMhwNJGHcWgdBuZBjGXAlrMS2elLQojsOxILarlu/bdaGjnZw/NDQBoyj8pE
         Ja2w==
X-Forwarded-Encrypted: i=1; AJvYcCXjbyFKWZViwOWN36xQlsiUf/EQ2XQn43JNQZQVi43rYKXUltNa0llaU1gTvPaNRKoqMGTYSUiHhxDxu6+WY1dzwhUAyqEFqBIGf893
X-Gm-Message-State: AOJu0YzuF8flDOBruPRDHU8ba5YXq8hx4c9W6d0qtDiStMYH6uxC0dWG
	HxImann83Yt2pK12aQ1eeLsHJ3AmLeLm3m/vv0Z/pMTLaZO7Q4ML3ABDRhFS0sEbXGsb7VnraBL
	QHgSPDspDwrdlcy0hviUVQ6Cc5Xa+tqMvBvx/NUqAz3njoxu1/8hfUvowr3ZE1Q==
X-Received: by 2002:a17:907:3181:b0:a4e:663a:3cf4 with SMTP id xe1-20020a170907318100b00a4e663a3cf4mr1328713ejb.6.1711916438433;
        Sun, 31 Mar 2024 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpknzv8VBlqoGJZhO+j/gEtYVNu8noUyOMoh3rGDewOFPJPPTVRdkL5QIIU1wPMo3a8degxA==
X-Received: by 2002:a17:907:3181:b0:a4e:663a:3cf4 with SMTP id xe1-20020a170907318100b00a4e663a3cf4mr1328694ejb.6.1711916437852;
        Sun, 31 Mar 2024 13:20:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:9c27:9486:684f:de6:8ab8])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906b28200b00a4655976025sm4495364ejz.82.2024.03.31.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 13:20:37 -0700 (PDT)
Date: Sun, 31 Mar 2024 16:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
	riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <20240331160618-mutt-send-email-mst@kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329171641.366520-1-leitao@debian.org>

On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
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

net has its own stable process, don't CC stable on net patches.


> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
> 
> V2:
>   * Moved from creating a valid packet, by rejecting the request
>     completely
> V3:
>   * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>     the rejection path.
> 
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..c4a21ec51adf 100644
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
> @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
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
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EOPNOTSUPP;


What's the logic here? Is it || or &&? A comment can't hurt.

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
> @@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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


