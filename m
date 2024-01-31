Return-Path: <linux-kernel+bounces-45695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D89E84343F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2435128C515
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43817570;
	Wed, 31 Jan 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuNiGah1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1C16416
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669648; cv=none; b=beGTPdIpB8oc2a3OvM1lR+CuRoNsWeqWbj6xclMnOFGQ6kpZAXB3G6uWlvWUs58Faryg15sOjFRIvKH+gWeX8QgctZ5MayHf683BloQcKpcD8zDKKSRbInPM+aQpCvJbAtg8I3CQtmYFS8joZb4ZADna19IZdyn9idPRKuVeY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669648; c=relaxed/simple;
	bh=DhqZ1Xes7Q5fSjGBvJ9VR5dGs+7Fh29piGCLBO/86+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD9vgFAw1zN7jQuCrkPK2BkxHLmwmrMC1OA89V4XA2ncaRgO4wxNvr4PGJfvzAcUgsd0QDFmkRcXm+BA9OxE1dkEb4VUjYKk1fog4TdrhNVwbyFEE8bOLvV6tIijZuAykHJrUL5F3etrhXcoORbZbkKA2yPV+6J1nXJO7Qexcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuNiGah1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a359446b57dso388412366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706669644; x=1707274444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNtJ0I6nkJv70Hy+MuZAp8tu3eHcGUGD/9KdwK5zAgw=;
        b=HuNiGah1AU9z+MeAA+Rr3Mtyfttn/Zlj1jZMFjLZndc0g3OJHnl4srDDdLHaZ1c9ju
         nEbanLoWH4QKhrOPZ2ZfEn17EIT/yjFF1uKbULgvptI/KksPtDIObqHlDqp232UTLnys
         d+kFFb7mgAUiKaSrHypDz2FQUIwskBpQIQP72EuEujxaJRR2l8IlcYT3TpIwjA3xABA+
         GZPhD74SnKej/p7wz74eIEkgXhhK0051ioISYUc2UzB0Cc9KVD9/0M5POs8oAm5W5iIe
         vAct46RxT2xKJLtPq7d6fy8BsS9692jhD4S9B4EJ9H4/0AS7qYxV3W9NDAqLYpuRsvNM
         pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669644; x=1707274444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNtJ0I6nkJv70Hy+MuZAp8tu3eHcGUGD/9KdwK5zAgw=;
        b=N5CScFfW+DDKJUWooFbID2cmfeZmNggAxnNSGOFiF6QYHf2C/Qw+tSBAEG6exupIw7
         6vJv+rqQLGxg2zIGT01aohRVz0suaUAY0aDJcZFm5upK/VAfMU2Ke1wg3/qd6XHDq8gg
         K+ljGcvpa6+frjgRYYER2LdtbDkTksx15vJZYLVZ84sLGaVR8i0nzgEr08Z+jA3cjadF
         rbb4LTgEI/jVTJQucNrzlyZEdxlHfEqGVtqur9lLMgelfo8cA1rBkdQjh6uO1RJeMeCC
         gdgCgHfBwUmp2fCNJhp6QSMd4puWzsdeMQa5t9vjL3MQCxBYVV8/RMpCbLB4BodZfKkv
         OR6w==
X-Gm-Message-State: AOJu0YzALhmx2GJ4O3nULNchivaFprIvRIS3ubcjDL28tnNmaIXaDAwH
	lN9eZ6FJPMRQsWRPhN7M99jgovwB18NDFD0cWK+9XDUSkMgXxD6D2M6yBu76NlprUVSVbiso1iW
	i9ycMV3/MStvt7IIrR67Nsa/l1GY=
X-Google-Smtp-Source: AGHT+IGrEhF7e7B2Lf/SYC7AOe8MwhO00CYHW2lTbWD6KaT8xzJJP3qLKGGCI9k5IoIGf3fsjGdxkRh84Xa++tYFppk=
X-Received: by 2002:a17:906:379a:b0:a35:9616:492b with SMTP id
 n26-20020a170906379a00b00a359616492bmr138820ejc.76.1706669644300; Tue, 30 Jan
 2024 18:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125101912.60346-1-liangchen.linux@gmail.com> <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 31 Jan 2024 10:53:52 +0800
Message-ID: <CAKhg4tL6O5c_MGbKx5u+V6MGgW+odTnLvwx=sLOv2b5S5Wy9WQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 18:19:12 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 86 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..0c845f2223da 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
> >       };
> >  };
> >
> > +struct virtnet_xdp_buff {
> > +     struct xdp_buff xdp;
> > +     u32 hash_value;
> > +     u16 hash_report;
> > +};
> > +
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >
> >  static bool is_xdp_frame(void *ptr)
> > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >       }
> >  }
> >
> > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_=
xdp,
> > +                                  struct net_device *dev,
> > +                                  struct virtio_net_hdr_v1_hash *hdr_h=
ash)
> > +{
> > +     if (dev->features & NETIF_F_RXHASH) {
> > +             virtnet_xdp->hash_value =3D __le32_to_cpu(hdr_hash->hash_=
value);
> > +             virtnet_xdp->hash_report =3D __le16_to_cpu(hdr_hash->hash=
_report);
>
> Could we put the __leXX_to_cpu to virtnet_xdp_rx_hash?

Sure. Thanks!

>
> Other looks good to me.
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Thanks.
>
>
> > +     }
> > +}
> > +
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> >                              struct net_device *dev,
> >                              unsigned int *xdp_xmit,
> > @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >       unsigned int headroom =3D vi->hdr_len + header_offset;
> >       struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
> >       struct page *page =3D virt_to_head_page(buf);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       struct page *xdp_page;
> > +     struct xdp_buff *xdp;
> >       unsigned int buflen;
> > -     struct xdp_buff xdp;
> >       struct sk_buff *skb;
> >       unsigned int metasize =3D 0;
> >       u32 act;
> > @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct=
 net_device *dev,
> >               page =3D xdp_page;
> >       }
> >
> > -     xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> > -     xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> > +     xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> >                        xdp_headroom, len, true);
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> >               /* Recalculate length in case bpf program changed it */
> > -             len =3D xdp.data_end - xdp.data;
> > -             metasize =3D xdp.data - xdp.data_meta;
> > +             len =3D xdp->data_end - xdp->data;
> > +             metasize =3D xdp->data - xdp->data_meta;
> >               break;
> >
> >       case XDP_TX:
> > @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >               goto err_xdp;
> >       }
> >
> > -     skb =3D virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> > +     skb =3D virtnet_build_skb(buf, buflen, xdp->data - buf, len);
> >       if (unlikely(!skb))
> >               goto err;
> >
> > @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       int num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >       struct page *page =3D virt_to_head_page(buf);
> >       int offset =3D buf - page_address(page);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       unsigned int xdp_frags_truesz =3D 0;
> >       struct sk_buff *head_skb;
> >       unsigned int frame_sz;
> > -     struct xdp_buff xdp;
> > +     struct xdp_buff *xdp;
> >       void *data;
> >       u32 act;
> >       int err;
> > @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       if (unlikely(!data))
> >               goto err_xdp;
> >
> > -     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, =
frame_sz,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, f=
rame_sz,
> >                                        &num_buf, &xdp_frags_truesz, sta=
ts);
> >       if (unlikely(err))
> >               goto err_xdp;
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> > -             head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
> > +             head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_fr=
ags_truesz);
> >               if (unlikely(!head_skb))
> >                       break;
> >               return head_skb;
> > @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               break;
> >       }
> >
> > -     put_xdp_frags(&xdp);
> > +     put_xdp_frags(xdp);
> >
> >  err_xdp:
> >       put_page(page);
> > @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct virtnet_xdp_buff *virtnet_xdp =3D (void *)_ctx;
> > +
> > +     if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     switch (virtnet_xdp->hash_report) {
> > +     case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_NONE:
> > +     default:
> > +             *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D virtnet_xdp->hash_value;
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >       int i, err =3D -ENOMEM;
> > @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)
> > --
> > 2.40.1
> >

