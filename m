Return-Path: <linux-kernel+bounces-38047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2F83BA38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB151C21A20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3BB10A21;
	Thu, 25 Jan 2024 06:42:45 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6910A05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164964; cv=none; b=RqzZtyiYtycShLyc2an8AmKIf1iRrUnD6BO49oP6ptvFr8sTBKUy9I5edc95G42p3ulMjYb6DSWOdi/KNGzyKXeNl2JogguSHncN00G50QRTPqAw1lca6aOm24nOgUUQKpycFNBoV5/NsCyoj1WEy9w9X35bRnR8IV77ZGKJpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164964; c=relaxed/simple;
	bh=+86979wnmR0184qkPBemQbKYuEHHghGldD80/Kqy9xE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=EuzPBS8mfQxXe4isAK4jbUjlutHmpxgjB4+SR1YfZaZkRJC0JhxSe0bYLSLYCQaYafBtOu6U4KeM/inLTvhPs4/Va4l2NlAATeEnN/+IYccth+TDAMLPNTJSpLWtHdnmPAdy3VO1fZdOsUqoQw4iL/kRxZj/rdI3vymZL5KZJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.JJXUj_1706164951;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.JJXUj_1706164951)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 14:42:32 +0800
Message-ID: <1706164863.507014-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
Date: Thu, 25 Jan 2024 14:41:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Liang Chen <liangchen.linux@gmail.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 mst@redhat.com,
 hengqi@linux.alibaba.com
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com>
 <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvQTXmyAeUeWxgxgMPJ3VQJWH1DRnt__Yb0ifnSyuZ7Cw@mail.gmail.com>
In-Reply-To: <CACGkMEvQTXmyAeUeWxgxgMPJ3VQJWH1DRnt__Yb0ifnSyuZ7Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 25 Jan 2024 11:48:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 24, 2024 at 5:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
com> wrote:
> >
> > On Wed, 24 Jan 2024 16:57:20 +0800, Liang Chen <liangchen.linux@gmail.c=
om> wrote:
> > > For the XDP_PASS scenario of the XDP path, the skb constructed with
> > > xdp_buff does not include the virtio header. Adding the virtio header
> > > information back when creating the skb.
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > ---
> > >  drivers/net/virtio_net.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index b56828804e5f..2de46eb4c661 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct=
 net_device *dev,
> > >       if (unlikely(!skb))
> > >               goto err;
> > >
> > > +     /* Store the original virtio header for subsequent use by the d=
river. */
> > > +     memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);
> >
> > About this, a spec is waiting for voting.
> >
>
> A pointer?

Sorry.

http://lore.kernel.org/all/1704263702-50528-1-git-send-email-hengqi@linux.a=
libaba.com


>
> > This may change the logic of the csum offset and so on.
>
>  Btw, doesn't it need a new feature bit?

Yes.

But this patch set should not include this.
We may do the similar thing, but the commit log will
include more info about the spec.

Thanks.


>
> Thanks
>
> >
> > Please not do this.
> >
> > Thanks.
> >
> >
> > > +
> > >       if (metasize)
> > >               skb_metadata_set(skb, metasize);
> > >
> > > @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> > >               head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_=
frags_truesz);
> > >               if (unlikely(!head_skb))
> > >                       break;
> > > +             /* Store the original virtio header for subsequent use =
by the driver. */
> > > +             memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr,=
 vi->hdr_len);
> > > +
> > >               return head_skb;
> > >
> > >       case XDP_TX:
> > > --
> > > 2.40.1
> > >
> >
>

