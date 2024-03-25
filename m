Return-Path: <linux-kernel+bounces-116565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AB88A0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD112C5D07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A41129E7C;
	Mon, 25 Mar 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hoKZ9qlo"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52025677D;
	Mon, 25 Mar 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346417; cv=none; b=fuuHpxgL9CKNNBG/wvyVGMabTJ5SMNYLtYPqDmXayv+5+fUk8QLM62x/haDGzevpPG5MZlxp+uxeVoy/xIzsLdXV+3xADIt1hUTURCj1ulQSLTQewPxyblIZLfd8sk8c3E29YEPblZiH/cgKld6p5fWMjG2Br/++VobRUbhDTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346417; c=relaxed/simple;
	bh=pkhfJ+Q1nAAONeQTS6q9Z+AlngVVouzqkHVOLqRn46s=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=BYGgJHR914tqOlVbJx5CtWVmBwhwGduQU3Ldqm0RiipfuixVfDwHEOwppSUstgcoQo18FwMdfO4EyKJIWbPRcYm+zytjM/92URTTvnHrIw3jXPdQKRVoSJCe1IADuzJjPH4x9bkilKJVXtFXdqQh1aCI18JKzI/2LDEZtRcvWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hoKZ9qlo; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711346413; h=Message-ID:Subject:Date:From:To;
	bh=JNL9A38afeP0aEJfOCNG1LEpvhSBCwkDLxX/IRTOtms=;
	b=hoKZ9qloGzGZjW1UBci6ghhqAiZ7vJiUqa14wLENKkRafNZ2JPuv6rSD2nGsfG5wggAzlNZyb/w05dbs7TMfmeWOKEHBlZQalGC5+EVqjWo1DuxSHZB2ksP/Gps3DVbQv59Mx43/yRO8enSvZF/sg6UKV4N6eB+tMMe3JRmxDIg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W39kIMB_1711346410;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W39kIMB_1711346410)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 14:00:11 +0800
Message-ID: <1711346273.5079622-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Mon, 25 Mar 2024 13:57:53 +0800
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
 Andrew Melnychenko <andrew@daynix.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
 <Zf1bofzE4x0wGEm+@gmail.com>
In-Reply-To: <Zf1bofzE4x0wGEm+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Mar 2024 03:21:21 -0700, Breno Leitao <leitao@debian.org> wrote:
> Hello Xuan,
>
> On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> > On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:
>
> > > 4) Since the command above does not have a key, then the last
> > >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > >     sg_buf_size = vi->rss_key_size;
> >
> >
> >
> > 	if (vi->has_rss || vi->has_rss_hash_report) {
> > 		vi->rss_indir_table_size =
> > 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > 				rss_max_indirection_table_length));
> > 		vi->rss_key_size =
> > 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> >
> > 		vi->rss_hash_types_supported =
> > 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > 		vi->rss_hash_types_supported &=
> > 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> > 		dev->hw_features |= NETIF_F_RXHASH;
> > 	}
> >
> >
> > vi->rss_key_size is initiated here, I wonder if there is something wrong?
>
> Not really, the code above is never executed (in my machines). This is
> because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.
>
> Looking further, vdev does not have the VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT features.
>
> Also, when I run `ethtool -x`, I got:
>
> 	# ethtool  -x eth0
> 	RX flow hash indirection table for eth0 with 1 RX ring(s):
> 	Operation not supported
> 	RSS hash key:
> 	Operation not supported
> 	RSS hash function:
> 	    toeplitz: on
> 	    xor: off
> 	    crc32: off


The spec saies:
	Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it
	supports only one pair of virtqueues, it MUST support at least one of
	commands of VIRTIO_NET_CTRL_MQ class to configure reported hash
	parameters:

	If the device offers VIRTIO_NET_F_RSS, it MUST support
	VIRTIO_NET_CTRL_MQ_RSS_CONFIG command per 5.1.6.5.7.1.

	Otherwise the device MUST support VIRTIO_NET_CTRL_MQ_HASH_CONFIG command
	per 5.1.6.5.6.4.


So if we have not anyone of `vi->has_rss` and `vi->has_rss_hash_report`,
we should return from virtnet_set_rxfh directly.

Thanks.

