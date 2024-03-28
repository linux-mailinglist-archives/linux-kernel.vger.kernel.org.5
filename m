Return-Path: <linux-kernel+bounces-122301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0F88F4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A13E1C32785
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D633BBF5;
	Thu, 28 Mar 2024 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E5YEks9c"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E3BB25;
	Thu, 28 Mar 2024 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589847; cv=none; b=VxpkcvS2WvFCjq2iHv6yu4frzgJVRKUYM3YprKcLx/gmHkmWFqWY2n1TVuUvKpoP2ouhJB58qp8n6mtg8wTar9KDeG6itb9jkD2YosaWNnADNInPPVvJrYmv3PkcKa0zFhHjXx0DrV9hpXwgN9lpjwZCW7tu4ioAcZslALS7DYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589847; c=relaxed/simple;
	bh=ufJutT73Z+lUzAoxlRPNMe5+qxbNbjQJyVoWy3hjDaA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=untORWMF28MsvLiad0BeQB37CQdC0ihaWXQSx13c6ZLKDPDWw4ql2P7rxS2R83hiJ4e5Kk2S/xQcGKVjM64HX2/jF33UTccnD4Nqu1hGM23kJp2TbSX890VLw3C5dL+dgjkI8huwAKz5OeYvvXgOmOmJQs12NS145tpofQslgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E5YEks9c; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711589840; h=Message-ID:Subject:Date:From:To;
	bh=v7bS5t8QiDMoASYcN5lpCGZoaZnfviWiy8N1d5+w1eE=;
	b=E5YEks9cwDFMuVnGqCgjQ7pWOGumODwyeYQOIYyaKyjMo5MrjQ+PrelyXHspCf6Q71ciTUkpqF+D7qkrthraK5WmvZk+uhIuS3oNEsP1j09x52woHK0WtE5fR1GHZSrHV4wv6ylTT+X3gRc8pt+7enOp6OEVOqmUT8kKVn5tWkM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W3QICuj_1711589839;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3QICuj_1711589839)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 09:37:20 +0800
Message-ID: <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is not supported
Date: Thu, 28 Mar 2024 09:28:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Breno Leitao <leitao@debian.org>
Cc: rbc@meta.com,
 riel@surriel.com,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 hengqi@linux.alibaba.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
 <ZgQkXfMd6GIEndXm@gmail.com>
In-Reply-To: <ZgQkXfMd6GIEndXm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 27 Mar 2024 06:51:25 -0700, Breno Leitao <leitao@debian.org> wrote:
> Hello Xuan,
>
> On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
> > On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> > > Do not set virtnet_info->rss_indir_table_size if RSS is not available
> > > for the device.
> > >
> > > Currently, rss_indir_table_size is set if either has_rss or
> > > has_rss_hash_report is available, but, it should only be set if has_rss
> > > is set.
> > >
> > > On the virtnet_set_rxfh(), return an invalid command if the request has
> > > indirection table set, but virtnet does not support RSS.
> > >
> > > Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/virtio_net.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c22d1118a133..c640fdf28fc5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> > >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> > >  		return -EOPNOTSUPP;
> > >
> > > +	if (rxfh->indir && !vi->has_rss)
> > > +		return -EINVAL;
> > > +
> > >  	if (rxfh->indir) {
> >
> > Put !vi->has_rss here?
>
> I am not sure I understand the suggestion. Where do you suggest we have
> !vi->has_rss?
>
> If we got this far, we either have:
>
> a) rxfh->indir set and vi->has_rss is also set
> b) rxfh->indir not set. (vi->has_rss could be set or not).


This function does two tasks.
1. update indir table
2. update rss key

#1 only for has_rss
#2 for has_rss or has_rss_hash_report


So I would code:

	bool update = false

	if (rxfh->indir) {
		if (!vi->has_rss)
			return -EINVAL;

		for (i = 0; i < vi->rss_indir_table_size; ++i)
			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];

		update = true
	}

	if (rxfh->key) {
		if (!vi->has_rss && !vi->has_rss_hash_report)
			return -EINVAL;

		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
		update = true
	}


	if (update)
		virtnet_commit_rss_command(vi);

Thanks.


>
> Thanks for the review,
> Breno

