Return-Path: <linux-kernel+bounces-36295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFE839E85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81514284502
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95E417F6;
	Wed, 24 Jan 2024 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbiV+kWc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077717CB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061907; cv=none; b=lv6JrvfXCjb8edK2kVkUL35YzZWQx/97frv2DvJQEOn7bxJpiQ9gXHCnvRfqCCu/B88cNb4kLgKbs5S0BWGTosSt/71INv7aDVNRMwhpFtpKU80YIZ06cdQndI8Us1TvsP2z4JFd2Fp2rsjR0jAOa4KSIeBPTod5gPmuMv7dTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061907; c=relaxed/simple;
	bh=r1PJI/1kQSGO0bzUHL8vHtByzkwdMZSWVNQZCiZTVgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/4Aj+vcfJLg1uzOjrD0lKyt7zKNC19MRh0COc0hJ614XdHlYkfK2ILQPhenPkih1Gh+uui/l79sbrTfvbam3yiR9z+Hh0BHsT4SYA9tij46iRXHOq/ewI5Vra+t6CanPwhs9fh1vaDN8HkJuqjXDBU+x8dXcIAlvBdxYhiv2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbiV+kWc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so532030666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706061903; x=1706666703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz18PLpP6eIAAHQsjlKzV2SEMfvKNheWYiqzzwRjC/4=;
        b=DbiV+kWcboLwbUBUF24bSLdKvYP+WXCyO3dAGQlCcQHTaTawAYow6z79Xau4UfnhI5
         hkrfzEuguDA7D1XqBS8iQkMblBZwBdL3fKtmF/ecjZjPa0pCsIQ6KQ45Z/MHPgyQAM9h
         htZvlnbAcJGJrV6l3QjNYtLQwMHO/RH2DrnBJorciuxhdELjyoBMJ2C4fhC7ftbdTtfe
         VVEYCi/8D+dR6ax3DLdxweEBfE2h4e2HNGgYyFOV6E60zJNiAxVoi8DSBmhmy9QtqEFu
         mdA3CGUQPVLmKkyzWhOvCRXs342GTJUJtodcv5wdDfI1Di92xtNMj8tmZOqHNr2Ksl1k
         lOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706061903; x=1706666703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz18PLpP6eIAAHQsjlKzV2SEMfvKNheWYiqzzwRjC/4=;
        b=ik3yjhtuY7EoeLfEDTqQ7mZeS9pE6SiebZCAmK84b8cXeVrgkgIhInsOt4ZDl/jemB
         c6U5mqSRiBpwQg3YL41DAR2IC5vr3z9xhKADxQbFyJpsxv4nbVAtXtd2JiNTLuL3vPFa
         GcvpWZxaD7rNMs/x5zl35DyXhagi0QWGIfJ+THFAU6zJWpNXMUDqPK4Ma3zuohElq5aC
         xUUyiuDu4PLjE3zpCZgAA6a1T18DHX1aHsND8PycDJGcdsVcSouLyqjsxzb23NDjyFsl
         s3x8B1vaiJk/fz1sS3RKRnI+hn7gQmKIaIbnd2d4tVnRBHNjTlb7Xf+vWGdPHI7VpLxY
         Vigw==
X-Gm-Message-State: AOJu0Yzxkmo8KQgTSxoZ2fblVM1z7ZG5YJ5GMXktuIYQ3slTeJbf0gP0
	8JnJzEYk3wVd6COIsYkX5A+canDDZ0z0NuEcUl8jxDYOV9b6mcFUBUMKMnTwM0QPvz6Rl+0sqWW
	Mqs+PYnU1T+jX0Tks4iQTz3xXvXY=
X-Google-Smtp-Source: AGHT+IEC/iEHtF88l+XDyVk0+7TQNGzjDlH8ORcmDLo/Kp6VakT3Mpq6n1fu1GQ233zIm6C5vEBrmGtEYeUcZmiRLBw=
X-Received: by 2002:a17:906:c182:b0:a30:d64c:b718 with SMTP id
 g2-20020a170906c18200b00a30d64cb718mr366577ejz.12.1706061903232; Tue, 23 Jan
 2024 18:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
In-Reply-To: <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 10:04:51 +0800
Message-ID: <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Hi Liang Chen,
>
> =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=81=93=
:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                        enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
>
> I think 'vi->has_rss_hash_report' should be used here.
> NETIF_F_RXHASH cannot guarantee that the hash report feature is negotiate=
d,
> and accessing hash_report and hash_value is unsafe at this time.
>

My understanding is that rxhash in dev->features is turned on only if
the corresponding hw feature is set. We will double check on this.

> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
>
> If the virtio-net-hdr is overrided by the XDP prog, how can this be done
> correctly and as expected?
>

Yeah, thanks for bringing up this concern. We are actively working on
a fix of this issue(possibly with a wrapper structure of xdp_buff).

Thanks,
Liang

> Thanks,
> Heng
>
> > +
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > +             default:
> > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >   static int virtnet_probe(struct virtio_device *vdev)
> >   {
> >       int i, err =3D -ENOMEM;
> > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> >       SET_NETDEV_DEV(dev, &vdev->dev);
> >
> > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > +
> >       /* Do we support "hardware" checksums? */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> >               /* This opens up the world of extra features. */
>

