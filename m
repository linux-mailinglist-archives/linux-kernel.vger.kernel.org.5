Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7887D5F70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJYBRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F899
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698196576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jUxLPVqEyy0fSEb+M8GkdqTmhs4mSjWm/V02VT7Yo0=;
        b=A43H5Wlyn1FyKWmULk0WPuIUK/MTGonDbYAp+jZtKa/t9W8n+a/aI6lNmo36b1JvFX9PcU
        LWYmXxOzA8jt4JYAuA/PVXLj80XQdVAQa1NXP0GV4CYYm/HJk9IB/T5z+E//UDcoNZUJ42
        sxTNabd4Qqu5Z+THapR25iLvZ+zrZJw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-AiD6ArYFOVCnPehRJV0GlQ-1; Tue, 24 Oct 2023 21:16:05 -0400
X-MC-Unique: AiD6ArYFOVCnPehRJV0GlQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c51ca27f71so43055691fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698196563; x=1698801363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jUxLPVqEyy0fSEb+M8GkdqTmhs4mSjWm/V02VT7Yo0=;
        b=glYgQGOo35a/R9DIvFK2hKaHtXR5sE2Cee0e3cfhLkpoICXwI8/0klUctKxwNRmxoA
         lSqbhBIyfVCifaQZGTDDhWN3qy66JLqe3Y+SpgEfIXVsrs5eQkfPv4arIWQEdeSLvciy
         Ou2lM/GVH7zAy9ZDB9k/E2XJhOL3/yKf7bxO2iyP0I3X7BzYrn1KC4PJWZhdlnlACWzV
         Bp2Z0Kqnbi1lVtry7ATt5K3UsOfHZnPL10A2Y1Ftq2nj9B5/O/qfmP7e1rS4KC7ge48v
         FusEhlLa7UW+//0tOIU6yOcGzukd6HEHkKa0HIzV3HFpP/J6GyaVI0RqjnOeZun64rQw
         tU9w==
X-Gm-Message-State: AOJu0YznKQaRZ4U1W7X13pIhEaS/wLQ+OGuX5b7jtSFS23Gh3SA9DA3o
        Ia0rRlwDt0J29NkszdWMMBGBMpAkjDxVkvKhYpsxycdetDT8Iwc4uNp9VrN3CDpqoliUg/9LKsY
        Fwi4zUogjPBTq94RM3sPLjk9DIeZzP5bHi4+ccD6w
X-Received: by 2002:ac2:4ac7:0:b0:503:1bb0:a658 with SMTP id m7-20020ac24ac7000000b005031bb0a658mr9946578lfp.32.1698196563755;
        Tue, 24 Oct 2023 18:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExm9Uf2zsy/hZpGxWLnOCxtCose/TBcuAkczdQUH0lDOPqoFYvLt0aSeiH4mtO8PF5JKM0yYpPP5oCZtx+v84=
X-Received: by 2002:ac2:4ac7:0:b0:503:1bb0:a658 with SMTP id
 m7-20020ac24ac7000000b005031bb0a658mr9946570lfp.32.1698196563385; Tue, 24 Oct
 2023 18:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com> <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
 <0ad99060-119b-4465-b611-868f693aea02@oracle.com> <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
In-Reply-To: <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 25 Oct 2023 09:15:52 +0800
Message-ID: <CACGkMEtXOzqP_FY_UmmZZoDnOBg4MXS-EoE-vKC_=MM3cgKnmQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older userspace
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:25=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 10/24/2023 9:21 AM, Si-Wei Liu wrote:
> >
> >
> > On 10/23/2023 10:45 PM, Jason Wang wrote:
> >> On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.=
com>
> >> wrote:
> >>> Using .compat_reset op from the previous patch, the buggy .reset
> >>> behaviour can be kept as-is on older userspace apps, which don't ack
> >>> the
> >>> IOTLB_PERSIST backend feature. As this compatibility quirk is
> >>> limited to
> >>> those drivers that used to be buggy in the past, it won't affect chan=
ge
> >>> the behaviour or affect ABI on the setups with API compliant driver.
> >>>
> >>> The separation of .compat_reset from the regular .reset allows
> >>> vhost-vdpa able to know which driver had broken behaviour before, so =
it
> >>> can apply the corresponding compatibility quirk to the individual
> >>> driver
> >>> whenever needed.  Compared to overloading the existing .reset with
> >>> flags, .compat_reset won't cause any extra burden to the implementati=
on
> >>> of every compliant driver.
> >>>
> >>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>> ---
> >>>   drivers/vhost/vdpa.c         | 17 +++++++++++++----
> >>>   drivers/virtio/virtio_vdpa.c |  2 +-
> >>>   include/linux/vdpa.h         |  7 +++++--
> >>>   3 files changed, 19 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>> index acc7c74ba7d6..9ce40003793b 100644
> >>> --- a/drivers/vhost/vdpa.c
> >>> +++ b/drivers/vhost/vdpa.c
> >>> @@ -227,13 +227,22 @@ static void vhost_vdpa_unsetup_vq_irq(struct
> >>> vhost_vdpa *v, u16 qid)
> >>> irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >>>   }
> >>>
> >>> -static int vhost_vdpa_reset(struct vhost_vdpa *v)
> >>> +static int _compat_vdpa_reset(struct vhost_vdpa *v)
> >>>   {
> >>>          struct vdpa_device *vdpa =3D v->vdpa;
> >>> +       u32 flags =3D 0;
> >>>
> >>> -       v->in_batch =3D 0;
> >>> +       flags |=3D !vhost_backend_has_feature(v->vdev.vqs[0],
> >>> + VHOST_BACKEND_F_IOTLB_PERSIST) ?
> >>> +                VDPA_RESET_F_CLEAN_MAP : 0;
> >>> +
> >>> +       return vdpa_reset(vdpa, flags);
> >>> +}
> >>>
> >>> -       return vdpa_reset(vdpa);
> >>> +static int vhost_vdpa_reset(struct vhost_vdpa *v)
> >>> +{
> >>> +       v->in_batch =3D 0;
> >>> +       return _compat_vdpa_reset(v);
> >>>   }
> >>>
> >>>   static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
> >>> @@ -312,7 +321,7 @@ static long vhost_vdpa_set_status(struct
> >>> vhost_vdpa *v, u8 __user *statusp)
> >>>                          vhost_vdpa_unsetup_vq_irq(v, i);
> >>>
> >>>          if (status =3D=3D 0) {
> >>> -               ret =3D vdpa_reset(vdpa);
> >>> +               ret =3D _compat_vdpa_reset(v);
> >>>                  if (ret)
> >>>                          return ret;
> >>>          } else
> >>> diff --git a/drivers/virtio/virtio_vdpa.c
> >>> b/drivers/virtio/virtio_vdpa.c
> >>> index 06ce6d8c2e00..8d63e5923d24 100644
> >>> --- a/drivers/virtio/virtio_vdpa.c
> >>> +++ b/drivers/virtio/virtio_vdpa.c
> >>> @@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct
> >>> virtio_device *vdev)
> >>>   {
> >>>          struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> >>>
> >>> -       vdpa_reset(vdpa);
> >>> +       vdpa_reset(vdpa, 0);
> >>>   }
> >>>
> >>>   static bool virtio_vdpa_notify(struct virtqueue *vq)
> >>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >>> index 6b8cbf75712d..db15ac07f8a6 100644
> >>> --- a/include/linux/vdpa.h
> >>> +++ b/include/linux/vdpa.h
> >>> @@ -519,14 +519,17 @@ static inline struct device
> >>> *vdpa_get_dma_dev(struct vdpa_device *vdev)
> >>>          return vdev->dma_dev;
> >>>   }
> >>>
> >>> -static inline int vdpa_reset(struct vdpa_device *vdev)
> >>> +static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
> >>>   {
> >>>          const struct vdpa_config_ops *ops =3D vdev->config;
> >>>          int ret;
> >>>
> >>>          down_write(&vdev->cf_lock);
> >>>          vdev->features_valid =3D false;
> >>> -       ret =3D ops->reset(vdev);
> >>> +       if (ops->compat_reset && flags)
> >>> +               ret =3D ops->compat_reset(vdev, flags);
> >>> +       else
> >>> +               ret =3D ops->reset(vdev);
> >> Instead of inventing a new API that carries the flags. Tweak the
> >> existing one seems to be simpler and better?
> > Well, as indicated in the commit message, this allows vhost-vdpa be
> > able to know which driver had broken behavior before, so it
> > can apply the corresponding compatibility quirk to the individual
> > driver when it's really necessary. If sending all flags
> > unconditionally down to every driver,

It depends on whether IOTLB_PERSIST is set.

> it's hard for driver writers to
> > distinguish which are compatibility quirks that they can safely ignore
> > and which are feature flags that are encouraged to implement. In that
> > sense, gating features from being polluted by compatibility quirks
> > with an implicit op
> s/implicit/explicit/
> > would be better.

Both of us have the points, we can listen to Michael or Eugenio for sure.

Thanks

> >
> > Regards,
> > -Siwei
> >>
> >> As compat_reset(vdev, 0) =3D=3D reset(vdev)
> >>
> >> Then you don't need the switch in the parent as well
> >>
> >> +static int vdpasim_reset(struct vdpa_device *vdpa)
> >> +{
> >> +       return vdpasim_compat_reset(vdpa, 0);
> >> +}
> >>
> >> Thanks
> >>
> >>
> >>> up_write(&vdev->cf_lock);
> >>>          return ret;
> >>>   }
> >>> --
> >>> 2.39.3
> >>>
> >
>

