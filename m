Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9917B8002
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbjJDM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbjJDM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06BE3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696424252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7u0qRNgbqDEiWsnicM0bjmnfQ0yrBqbgKexDYpUvT5Q=;
        b=Iy4AXkas2R3IKWnzaM/gZUx7+jtBcKXOhw1p6TUfXRdn8n+k4auowGvAvexNFdn3OZVboG
        6ssnWg4Gm6b5GXzG2CNBvvJQRgwpf04E4yJoPkGAyufhBSqSz0jway+5l88QxtFk8mGE4c
        0BgMBT603hp6O5vatSCvyrWuSU2tiCA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-cCO3SecwP3m4qlbPrUYpOA-1; Wed, 04 Oct 2023 08:57:31 -0400
X-MC-Unique: cCO3SecwP3m4qlbPrUYpOA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a23fed55d7so30995757b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424250; x=1697029050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u0qRNgbqDEiWsnicM0bjmnfQ0yrBqbgKexDYpUvT5Q=;
        b=QQ3kupU9CKemiyHFEXBuf7fOxagRayYT1FMtd8991g8nUK7S9EmnIlMvrOAosIqVqG
         1dkoNuzo70N75Ky7rLwHnr13TC7AVueiXiHGJf/Z7qW1eoiQ/Jzd+aFGyZqEpQzmnpHY
         w2cspiuzvb7fymqi29iIiq96MddRiH8N82GUfXUakqVnFdcX7Sv/Vyn9Ky/3jXcNgc8V
         KoFyx/azmtX+0C5BfpwmHFgfXCZ7gJzEPlI0r9O4hMVkNC7+2Bu0eLeaUPcwmqvcKx+0
         dSS7Xc/stnM4j8HMTESTHbyHngT5khCIVRInzQnjuCnqTn2xDs77FMKiiOHFNfbl2iwv
         RzWA==
X-Gm-Message-State: AOJu0Yy11paR64VUxnxlrgcifEJrzTuPc+3jK1dhmDyBG8KkDdAzO9E+
        zitrG569HHM2hV363a5jBkR/K0p06qoWm3r2tuVfNwzDVs/ioAUEvW+DtRBTy5iDerrJGu3tNu8
        zdKNKWBZzxuTyPTH25sB7AkwrlIUvUbVAFK/jiPj/CuvoO9AgWFE=
X-Received: by 2002:a0d:dec7:0:b0:59e:9a44:9db9 with SMTP id h190-20020a0ddec7000000b0059e9a449db9mr2244801ywe.26.1696424250428;
        Wed, 04 Oct 2023 05:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMFxsYT9s+vpgZJb+3Q0dlaA/iuuNpoTQN5CbQqCAJnRaUBSjbJ8kbjqosXHzAvnO7mdaYCpUMdKiPNgBfFlE=
X-Received: by 2002:a0d:dec7:0:b0:59e:9a44:9db9 with SMTP id
 h190-20020a0ddec7000000b0059e9a449db9mr2244764ywe.26.1696424249524; Wed, 04
 Oct 2023 05:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com> <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com> <20230704061356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704061356-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 14:56:53 +0200
Message-ID: <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, linux-kernel@vger.kernel.org,
        Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 12:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> >
> >
> > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=C3=A9rez wrote:
> > > > Offer this backend feature as mlx5 is compatible with it. It allows=
 it
> > > > to do live migration with CVQ, dynamically switching between passth=
rough
> > > > and shadow virtqueue.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Same comment.
> > to which?
> >
> > -Siwei
>
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit=
 to it
> as a kernel/userspace ABI: what if one wants to start rings in some
> other specific order?
> As was discussed on list, a better promise is not to access ring
> until the 1st kick. vdpa can then do a kick when it wants
> the device to start accessing rings.
>

Friendly ping about this series,

Now that VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK has been merged for
vdpa_sim, does it make sense for mlx too?

Thanks!

> > >
> > > > ---
> > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/=
net/mlx5_vnet.c
> > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -7,6 +7,7 @@
> > > >   #include <uapi/linux/virtio_net.h>
> > > >   #include <uapi/linux/virtio_ids.h>
> > > >   #include <uapi/linux/vdpa.h>
> > > > +#include <uapi/linux/vhost_types.h>
> > > >   #include <linux/virtio_config.h>
> > > >   #include <linux/auxiliary_bus.h>
> > > >   #include <linux/mlx5/cq.h>
> > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct =
mlx5_vdpa_net *ndev)
> > > >                   flush_workqueue(ndev->mvdev.wq);
> > > >   }
> > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device=
 *vdpa)
> > > > +{
> > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > +}
> > > > +
> > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev=
, u64 features)
> > > >   {
> > > >           struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa=
_ops =3D {
> > > >           .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > > >           .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > >           .get_device_features =3D mlx5_vdpa_get_device_features,
> > > > + .get_backend_features =3D mlx5_vdpa_get_backend_features,
> > > >           .set_driver_features =3D mlx5_vdpa_set_driver_features,
> > > >           .get_driver_features =3D mlx5_vdpa_get_driver_features,
> > > >           .set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > > --
> > > > 2.39.3
>

