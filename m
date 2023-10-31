Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF7DC3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjJaB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEDEE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698715523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o31v5GZG9TcPdikJNjmUFZp5YmRhl08i97z1mloYIzw=;
        b=AxLSqds0DosISLMqayf9eg1MA0UKuBoIHCvNI2rjgWzOF4d0x2xo/g2ULCQF+pNuUpPAgQ
        fVwZr26rOIyFbY4JFAL5DAhO1soaZcwerlEhueSN5HqAe3E72whkqJuPL7RNAQ9PB/h6jK
        +pCeOjM249p3NKcSEA8xYq82NIyxuGY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-oUEMAyC0NPmBTimakqKP0w-1; Mon, 30 Oct 2023 21:25:21 -0400
X-MC-Unique: oUEMAyC0NPmBTimakqKP0w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50798a25ebaso3135532e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698715520; x=1699320320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o31v5GZG9TcPdikJNjmUFZp5YmRhl08i97z1mloYIzw=;
        b=beLhcW/LE1WQP3mFcrxM6jMl/kekGRa9Q6Rbia7H6XoGxbcpc0sMLsD7raydYazHrb
         q67dyTPzwTTZiEQSIRElBkUVEv0oaALJtFdseaoyKyqlEORarSrUfCXVDlfUVmpG5y1r
         ub6fJ3q0wjtwlGb3wSIdrCke4SIZtZd0XChtl4gzUePFD1xov+jAxDCjjogdfiAXrpKW
         7eENPmnrfy6r40jOViYmamSTbWpxN2VGSvr1ShvwUzVHABC1pagemAzmN5JunCWc8/b3
         LzuZay0fR0hGEQgZre6hDUoh1f/NCKh9SBL4Wl5v8X2oMnN6DqAaNh7SkffgQw9TJbzb
         Ie4A==
X-Gm-Message-State: AOJu0Yx2InFRSyDRb+f7yaKTklxFMG9eP963TyBRVhm31jlnuGNl6L6i
        wolQc0Zb9WJj6wsZQB46RomnCUuIQCKQqZKFGhT893RJ+x2xIJsCFbBoEu2v2hLYZvl1DrZDcbF
        6dnIffCXgctgR4WEp7ULkCn3gGs6Fy6S2myITunON
X-Received: by 2002:a19:a40f:0:b0:509:1eca:4ae2 with SMTP id q15-20020a19a40f000000b005091eca4ae2mr360830lfc.16.1698715519646;
        Mon, 30 Oct 2023 18:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeai5LJ8RYz/4lU5unyi1wyO3RJWvByf6J/J2Epj9d2rm9T2A3D6AJvt2Snb2kBIb7yUnQ+HV7FU3UcPY9IkU=
X-Received: by 2002:a19:a40f:0:b0:509:1eca:4ae2 with SMTP id
 q15-20020a19a40f000000b005091eca4ae2mr360825lfc.16.1698715519287; Mon, 30 Oct
 2023 18:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com> <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
In-Reply-To: <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 31 Oct 2023 09:25:07 +0800
Message-ID: <CACGkMEvo5-Pj2WUWiJ5RoESA3h7hN6eOErGiNO0DYRnBS5aPhg@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:06=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 10/27/2023 2:31 AM, Jason Wang wrote:
> > On Fri, Oct 27, 2023 at 4:07=E2=80=AFAM Steve Sistare <steven.sistare@o=
racle.com> wrote:
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
> >
> > Btw, vringh_set_base_iotlb() deserves an independent patch and it
> > seems it is not specific to IOTLB,
>
> Agreed on both.  I initially submitted the smallest change needed to show=
 the problem.
>
> so we probably need an indirection
> > to have vringh_set_base() first.
>
> Not sure what you mean.  I have defined:
>
>     static inline int __vringh_set_base() ...
>
>     int vringh_set_base_iotlb()
>         return __vringh_set_base(vrh, idx, putu16_iotlb);
>
> to which I would add:
>
>     int vringh_set_base_user()
>         return __vringh_set_base(vrh, idx, putu16_user);
>
>     int vringh_set_base_kern()
>         return __vringh_set_base(vrh, idx, putu16_kern;
>
> all in the same patch.
>
> The call site in mlx5_vnet.c would be a 2nd patch.

Right, so we just need to split it.

>
> - Steve
>
> > Or I wonder if it's better to just introduce a new parameter to
> > vringh_init_iotlb()...
>
> I considered that, but IMO the parameter list there is already large, and=
 it would
> be strange to add a parameter for the initial value of avail, but not for=
 used, and
> no one needs the latter.

Fine.

Thanks

>
> - Steve
>
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
> >> +    vrh->last_avail_idx =3D vrh->last_used_idx =3D idx;
> >> +    return 0;
> >> +}
> >> +
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

