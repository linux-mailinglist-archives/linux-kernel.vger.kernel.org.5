Return-Path: <linux-kernel+bounces-116951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B888A56D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53241C3B283
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156761C68B3;
	Mon, 25 Mar 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DMTG+/ph"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6E1514C4;
	Mon, 25 Mar 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366601; cv=none; b=fVftjRFnZqeIjc4Dlqe3rk/NK+7FJwN9USUSZzC3VotndKfFQIOasxiMDqeGDac8323SeBDMQ/SjWBmKtJXkLQXPh9CnkalTcgC796b09X2yykrQnhcsf5r5eQ8WWE9Nj3KwodbmZkJ4O141gYjEdB69tSioqXBnss0nBxFuvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366601; c=relaxed/simple;
	bh=Utx9BnJ1thOR5r2WzvjcoE1Knx8Dk2lV1G9j0DGv5WI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=iS4/TWY3WOI16ppvcS0fXhpKqXv/VT9oOn09jA/B/M9T/rfOIedyYXDgYhIa1KHt2LvUjQBY4c9HOQHOasoMxr/uwed6jT1w3r77JCDPU3YrQ5LAAPYI1yTSHVRvvexTTCZ8wTINijx6LfyOyINXlwWn5PhWXo+RIdgNDnllnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DMTG+/ph; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711366591; h=Message-ID:Subject:Date:From:To;
	bh=tWzoma9+YgEU3EhGSSB8r00Sws8k2xiQqkay3SxZld4=;
	b=DMTG+/ph680l+w96mCOi5M2WWAED0R6RyaXzfM/YE6cWM9GcdVcylmWMq90HswuX8eR0YQMdnyKIXlTLlCmPKZSlAKKJTDvlqbvmA+a3PEW500bM/iB0te1Tpc4FHNrDXIclh6d66tkTySWL1Qz1a8B1sa6KyLdWrJABpbsEXgk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3FiqZe_1711366589;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3FiqZe_1711366589)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 19:36:30 +0800
Message-ID: <1711366510.4360204-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Mon, 25 Mar 2024 19:35:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com,
 riel@surriel.com,
 stable@vger.kernel.org,
 qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Heng Qi" <hengqi@linux.alibaba.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
 <Zf1bofzE4x0wGEm+@gmail.com>
 <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
 <ZgFfUHQhMdAWixqB@gmail.com>
In-Reply-To: <ZgFfUHQhMdAWixqB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 25 Mar 2024 04:26:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> Hello Xuan,
>
> On Mon, Mar 25, 2024 at 01:57:53PM +0800, Xuan Zhuo wrote:
> > On Fri, 22 Mar 2024 03:21:21 -0700, Breno Leitao <leitao@debian.org> wrote:
> > > Hello Xuan,
> > >
> > > On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> > > > On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
> > >
> > > > > 4) Since the command above does not have a key, then the last
> > > > >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > > > >     sg_buf_size = vi->rss_key_size;
> > > >
> > > >
> > > >
> > > > 	if (vi->has_rss || vi->has_rss_hash_report) {
> > > > 		vi->rss_indir_table_size =
> > > > 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > > > 				rss_max_indirection_table_length));
> > > > 		vi->rss_key_size =
> > > > 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> > > >
> > > > 		vi->rss_hash_types_supported =
> > > > 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > > > 		vi->rss_hash_types_supported &=
> > > > 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > > > 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > > > 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> > > >
> > > > 		dev->hw_features |= NETIF_F_RXHASH;
> > > > 	}
> > > >
> > > >
> > > > vi->rss_key_size is initiated here, I wonder if there is something wrong?
> > >
> > > Not really, the code above is never executed (in my machines). This is
> > > because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.
> > >
> > > Looking further, vdev does not have the VIRTIO_NET_F_RSS and
> > > VIRTIO_NET_F_HASH_REPORT features.
> > >
> > > Also, when I run `ethtool -x`, I got:
> > >
> > > 	# ethtool  -x eth0
> > > 	RX flow hash indirection table for eth0 with 1 RX ring(s):
> > > 	Operation not supported
> > > 	RSS hash key:
> > > 	Operation not supported
> > > 	RSS hash function:
> > > 	    toeplitz: on
> > > 	    xor: off
> > > 	    crc32: off
> >
> >
> > The spec saies:
> > 	Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
> > 	supports only one pair of virtqueues, it MUST support at least one of
> > 	commands of VIRTIO_NET_CTRL_MQ class to configure reported hash
> > 	parameters:
> >
> > 	If the device offers VIRTIO_NET_F_RSS, it MUST support
> > 	VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per 5.1.6.5.7.1.
> >
> > 	Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
> > 	per 5.1.6.5.6.4.
> >
> >
> > So if we have not anyone of `vi->has_rss` and `vi->has_rss_hash_report`,
> > we should return from virtnet_set_rxfh directly.
>
> Makes sense. Although it is not clear to me how vi->has_rss_hash_report
> is related here, but, I am convinced that we shouldn't do any RSS
> operation if the device doesn't have the RSS feature, i.e, vi->has_rss
> is false.
>
> That said, I am thinking about something like this. How does it sound?
>
> 	diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> 	index 5a7700b103f8..8c1ad7361cf2 100644
> 	--- a/drivers/net/virtio_net.c
> 	+++ b/drivers/net/virtio_net.c
> 	@@ -3780,6 +3780,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> 		struct virtnet_info *vi = netdev_priv(dev);
> 		int i;
>
> 	+	if (!vi->has_rss)
> 	+		return -EOPNOTSUPP;
> 	+

Should we check has_rss_hash_report?

@Heng Qi

Could you help us?

Thanks.


> 		if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> 		    rxfh->hfunc != ETH_RSS_HASH_TOP)
> 			return -EOPNOTSUPP;
>
> Thanks!

