Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAB7DBFE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJ3SaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjJ3SaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D5C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698690574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yn5bEsH9hOioNoGmXsOxQsfDpuqIq14dOr/Md8od0yY=;
        b=FEvcu+aw37qWFuXp9M2E/iOy4HDDFiJE3lONLo5RKWN0MIhrlGOewYWpX65Sjiiq5+aVSy
        mILuylYzGX/YpIqzbW/M+Xvbsu4H0zcB0Bb1SKiksZushN3l1kwt5AhJQkG3D/dmXcFo6F
        RpyoZPQZKKbgNHrs4iBTY7PGNsConLs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-4TDtPzbbMI6fk-hSIFku_A-1; Mon, 30 Oct 2023 14:29:33 -0400
X-MC-Unique: 4TDtPzbbMI6fk-hSIFku_A-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5b0c27d504fso13571047b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698690573; x=1699295373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn5bEsH9hOioNoGmXsOxQsfDpuqIq14dOr/Md8od0yY=;
        b=a/J4opOYc6nhaiDL3IUCywcZipaetWPrzYncEftE1CVrsXj5yS5l/eAQ4dBoa/9MnX
         N4/APX9BfAeIlvdufRAMeWhu9lC2038MJHeIe+vbXqB2Xuhu6mJsU2ueIfA/dPIBs3+s
         P3wKkm0ZIVbpdSGIp5nWc3UHCVoW3cfHtay4vaeGPOx967X9+QNde8nNPLEgm05874+Q
         DGZA0i3F+POrPg12OwLEGi21D2x5RHfUBVnU9fFB3D7TXsvsJ7PvyT/4zZ5FuobhzS6b
         M9pUlO99SxcizVzYqssm2ExB8cJrjqqh37zDBCIdKHPi/sIGvGf0mWarsLEWESOp+kXD
         5zyw==
X-Gm-Message-State: AOJu0YxxKzru0zCILHw0+msqF4VXO6C1InA+ashrIQ7mj12GhNl9DTWz
        YSlkTrNwVUvynyfbjpfUQrlV4+ZXlzHzHwugr/S+I5h+9F0v50GuZtxeIFQuINSMbfsjaU99lJM
        VpHFqZ4sjbqm1e/YZPGf/h/oKcuS+ye6DMQ4TAe4B
X-Received: by 2002:a81:a983:0:b0:5b0:4055:73dc with SMTP id g125-20020a81a983000000b005b0405573dcmr397794ywh.14.1698690572716;
        Mon, 30 Oct 2023 11:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHwZHvblWDFfPKVMswhwr8dSFq2aB6UHcY+CmtK5BoOycrUaKSqR587AHdlzix89m1z5RjFpcSltcH24h0MPM=
X-Received: by 2002:a81:a983:0:b0:5b0:4055:73dc with SMTP id
 g125-20020a81a983000000b005b0405573dcmr397787ywh.14.1698690572436; Mon, 30
 Oct 2023 11:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com> <6fec5512-66fb-4d94-b225-1351e6d5e8cb@oracle.com>
In-Reply-To: <6fec5512-66fb-4d94-b225-1351e6d5e8cb@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 30 Oct 2023 19:28:56 +0100
Message-ID: <CAJaqyWd5eJ1zstxTfkvYct1A0t0HE0JVmcJg-U-PZLZSwTpnxA@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 6:56=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 10/30/2023 11:12 AM, Eugenio Perez Martin wrote:
> > On Thu, Oct 26, 2023 at 10:09=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> mlx5_vdpa does not preserve userland's view of vring base for the cont=
rol
> >> queue in the following sequence:
> >>
> >> ioctl VHOST_SET_VRING_BASE
> >> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
> >>   mlx5_vdpa_set_status()
> >>     setup_cvq_vring()
> >>       vringh_init_iotlb()
> >>         vringh_init_kern()
> >>           vrh->last_avail_idx =3D 0;
> >> ioctl VHOST_GET_VRING_BASE
> >>
> >> To fix, restore the value of cvq->vring.last_avail_idx after calling
> >> vringh_init_iotlb.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
> >>  drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
> >>  include/linux/vringh.h            |  2 ++
> >>  3 files changed, 38 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net=
/mlx5_vnet.c
> >> index 946488b8989f..f64758143115 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_de=
v *mvdev)
> >>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> >>         int err =3D 0;
> >>
> >> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> >> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> >> +               u16 last_avail_idx =3D cvq->vring.last_avail_idx;
> >> +
> >>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_f=
eatures,
> >>                                         MLX5_CVQ_MAX_ENT, false,
> >>                                         (struct vring_desc *)(uintptr_=
t)cvq->desc_addr,
> >>                                         (struct vring_avail *)(uintptr=
_t)cvq->driver_addr,
> >>                                         (struct vring_used *)(uintptr_=
t)cvq->device_addr);
> >>
> >> +               if (!err)
> >> +                       vringh_set_base_iotlb(&cvq->vring, last_avail_=
idx);
> >> +       }
> >>         return err;
> >>  }
> >>
> >> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> >> index 7b8fd977f71c..799762c83007 100644
> >> --- a/drivers/vhost/vringh.c
> >> +++ b/drivers/vhost/vringh.c
> >> @@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct=
 vringh *vrh,
> >>         }
> >>  }
> >>
> >> +static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
> >> +                           int (*putu16)(const struct vringh *vrh,
> >> +                               __virtio16 *p, u16 val))
> >> +{
> >> +    int ret;
> >> +
> >> +    ret =3D putu16(vrh, &vrh->vring.avail->idx, idx);
> >> +    if (ret)
> >> +        return ret;
> >> +
> >> +    ret =3D putu16(vrh, &vrh->vring.used->idx, idx);
> >> +    if (ret)
> >> +        return ret;
> >> +
> >
> > I don't think VMM should be able to modify the guest's vring memory.
> > For vringh it should be enough with the next line, no need for
> > previous.
> >
> > If I'm not wrong this was solved in the simulator by [1] and [2]. Am I
> > missing something?
> >
> > Thanks!
> >
> > [1] https://lkml.org/lkml/2023/1/18/1045
> > [2] https://www.spinics.net/lists/kernel/msg4705724.html
> >
> >> +    vrh->last_avail_idx =3D vrh->last_used_idx =3D idx;
> >> +    return 0;
> >> +}
> >> +
>
> OK, that makes sense.  I just verified that the idx I pass to vringh_set_=
base_iotlb
> does indeed match vrh->vring.avail->idx and vrh->vring.used->idx.
>
> With no need to putu16, the fix could be confined to a few lines in the m=
lx5 driver:
>
> setup_cvq_vring(struct mlx5_vdpa_dev *mvdev) {
>     idx =3D cvq->vring.last_avail_idx;
>     vringh_init_iotlb(&cvq->vring, ...);
>     cvq->vring.last_avail_idx =3D  cvq->vring.last_used_idx =3D idx;
> }
>
> However, I wonder if re-syncing with the guest values would be a more rob=
ust fix:
>
> setup_cvq_vring(struct mlx5_vdpa_dev *mvdev) {
>     vringh_init_iotlb(&cvq->vring, ...);
>     vringh_sync_iotlb(&cvq->vring);
> }
>
> vringh_sync_iotlb(struct vringh *vrh) {
>     getu16_iotlb(vrh, &vrh->last_avail_idx, &vrh->vring.avail->idx);

This is not valid. For example in the case of the net RX queue. The
guest fills it periodically with rx buffers, but the next index to use
is not avail_index but the index that vhost handles internally.

If any, it *could* be valid to restore both of them from used_idx,
since we trust the source to sync with the used ring. But this will
not be valid once we migrate inflight descriptors too. If parent
drivers start just restoring used idx for both, we will need to
complicate behavior of the feature flag that indicates the vDPA device
supports in-flight.

>     getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
> }
>
> - Steve
>
> >>  /* Userspace access helpers: in this case, addresses are really users=
pace. */
> >>  static inline int getu16_user(const struct vringh *vrh, u16 *val, con=
st __virtio16 *p)
> >>  {
> >> @@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struc=
t vhost_iotlb *iotlb,
> >>  }
> >>  EXPORT_SYMBOL(vringh_set_iotlb);
> >>
> >> +/**
> >> + * vringh_set_base_iotlb - set avail_idx and used_idx
> >> + * @vrh: the vring
> >> + * @idx: the value to set
> >> + */
> >> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
> >> +{
> >> +    return __vringh_set_base(vrh, idx, putu16_iotlb);
> >> +}
> >> +EXPORT_SYMBOL(vringh_set_base_iotlb);
> >> +
> >> +
> >>  /**
> >>   * vringh_getdesc_iotlb - get next available descriptor from ring wit=
h
> >>   * IOTLB.
> >> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> >> index c3a8117dabe8..e9b8af4e6a5e 100644
> >> --- a/include/linux/vringh.h
> >> +++ b/include/linux/vringh.h
> >> @@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 f=
eatures,
> >>                          struct vring_avail *avail,
> >>                          struct vring_used *used);
> >>
> >> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
> >> +
> >>  int vringh_getdesc_iotlb(struct vringh *vrh,
> >>                          struct vringh_kiov *riov,
> >>                          struct vringh_kiov *wiov,
> >> --
> >> 2.39.3
> >>
> >
>

