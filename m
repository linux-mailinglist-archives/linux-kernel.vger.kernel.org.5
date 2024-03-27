Return-Path: <linux-kernel+bounces-120180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53A88D3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DA52C16D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69B1F60A;
	Wed, 27 Mar 2024 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qipBKAvA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D761B7E9;
	Wed, 27 Mar 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503492; cv=none; b=hpLnBmbSC7Dq8CkDodNVbj3JDVtzXZdM6gG4mIfKNF6boe/vngPxQbeVDOeIdYGjzKWg/nfB0wXyZrG9dsGffTAGtPWS0AGvBakZyXeNN6v8maY3oDMyGtJZVfWQ5PCubAlDtdh64rIx3iGP+yPbl9LUM40CTSptnbFWrWM3JqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503492; c=relaxed/simple;
	bh=6qAmt+xdA2QOcCOcEi6dB8mBsdItFfMjVsA3nuCRwiU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=FeTnDw3i2JOD7uAT/JB5hupeseRvS4lH9N9MT+uFpVR6WJLIonsiBpquF/eOQ0CnzLOtCMBXhAuyVWa6dmgigI/Pkm95oVwHpo8DXwUlP0M9qcgJHhrKPX0OemThnuuQMPljrLQz2WAjHKDY9sCIuWdxWXyvCtvsLI9bD529B3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qipBKAvA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711503481; h=Message-ID:Subject:Date:From:To;
	bh=xSV0Dmq1/beES1CrMcd6dQoXETDRC4jlecw03aBarYs=;
	b=qipBKAvAOeq6M0q+nrL3Y6PjYTzqODbRaVKZyNrfi7pMnNBQapugNcZaHbJmlTLe1U8n6rsgvu08vel8BcbxSdjpOm8e51K+ErBIAz9FeIxZR+Itkt7sa1awBaDIyvDqLcvMz2/NXbayzJ3coBHMBvXzKzhrp0ihChKH9K6YWp8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W3Mnh-R_1711503480;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3Mnh-R_1711503480)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 09:38:01 +0800
Message-ID: <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is not supported
Date: Wed, 27 Mar 2024 09:37:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com,
 riel@surriel.com,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 hengqi@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240326151911.2155689-1-leitao@debian.org>
In-Reply-To: <20240326151911.2155689-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> Do not set virtnet_info->rss_indir_table_size if RSS is not available
> for the device.
>
> Currently, rss_indir_table_size is set if either has_rss or
> has_rss_hash_report is available, but, it should only be set if has_rss
> is set.
>
> On the virtnet_set_rxfh(), return an invalid command if the request has
> indirection table set, but virtnet does not support RSS.
>
> Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/virtio_net.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..c640fdf28fc5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
>
> +	if (rxfh->indir && !vi->has_rss)
> +		return -EINVAL;
> +
>  	if (rxfh->indir) {

Put !vi->has_rss here?

Thanks.


>  		for (i = 0; i < vi->rss_indir_table_size; ++i)
>  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> @@ -4729,13 +4732,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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

