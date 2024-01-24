Return-Path: <linux-kernel+bounces-36498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9783A1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BFD1F2A82B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B0F9C1;
	Wed, 24 Jan 2024 06:06:10 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40424E57A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076370; cv=none; b=OgEM1rRJutx7XX3pfCzF6s5G/crYH3vE4vjztPLYUwM+mNzwvRkSiucrBSlvw2aUlIQN7ipDESE1CZR/Y2zcqQmkjeP8Fjj1wYvJw1ttb7gTDgD6wJf3zDani4dccmve7poLYp/Eb8D9vAyCeZHIHV+bqTQ0P16HqUK0Yz4zV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076370; c=relaxed/simple;
	bh=yVInM+tXrY5OJzT0NyfKM7ozZ8TrMZhVwmPsJ7bUilI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=KFJvnncLmXK2O8mE90U5L1f91HtHF2dw7P4ibv1+1rCHlNgwk1KzjEI301avfoT4eezK0zOBuqub6woF3cpbH1SARA/r0DQELgv04bpQ6d2/7OETdI1ykGBrT1AE2dGwVFbpQuXlKbJxpbRSbuiJlou8NHxQQdUZXDHBbpR3RdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.FDuvi_1706076358;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.FDuvi_1706076358)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 14:05:58 +0800
Message-ID: <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
Date: Wed, 24 Jan 2024 14:05:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
 <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
 <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
In-Reply-To: <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 24 Jan 2024 10:04:51 +0800, Liang Chen <liangchen.linux@gmail.com> =
wrote:
> On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Hi Liang Chen,
> >
> > =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=81=
=93:
> > > The RSS hash report is a feature that's part of the virtio specificat=
ion.
> > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vh=
ost
> > > (still a work in progress as per [1]) support this feature. While the
> > > capability to obtain the RSS hash has been enabled in the normal path,
> > > it's currently missing in the XDP path. Therefore, we are introducing=
 XDP
> > > hints through kfuncs to allow XDP programs to access the RSS hash.
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > ---
> > >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 56 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index d7ce4a1011ea..1463a4709e3c 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct vir=
tnet_info *vi, const int mtu)
> > >       }
> > >   }
> > >
> > > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > > +                        enum xdp_rss_hash_type *rss_type)
> > > +{
> > > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > > +     struct virtnet_info *vi;
> > > +
> > > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> >
> > I think 'vi->has_rss_hash_report' should be used here.
> > NETIF_F_RXHASH cannot guarantee that the hash report feature is negotia=
ted,
> > and accessing hash_report and hash_value is unsafe at this time.
> >
>
> My understanding is that rxhash in dev->features is turned on only if
> the corresponding hw feature is set. We will double check on this.
>
> > > +             return -ENODATA;
> > > +
> > > +     vi =3D netdev_priv(xdp->rxq->dev);
> > > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
> >
> > If the virtio-net-hdr is overrided by the XDP prog, how can this be done
> > correctly and as expected?
> >
>
> Yeah, thanks for bringing up this concern. We are actively working on
> a fix of this issue(possibly with a wrapper structure of xdp_buff).

Are there some places to save the hash before run xdp?

Thanks.


>
> Thanks,
> Liang
>
> > Thanks,
> > Heng
> >
> > > +
> > > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > > +                     break;
> > > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > > +             default:
> > > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > > +     }
> > > +
> > > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > > +};
> > > +
> > >   static int virtnet_probe(struct virtio_device *vdev)
> > >   {
> > >       int i, err =3D -ENOMEM;
> > > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> > >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> > >       SET_NETDEV_DEV(dev, &vdev->dev);
> > >
> > > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > > +
> > >       /* Do we support "hardware" checksums? */
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> > >               /* This opens up the world of extra features. */
> >
>

