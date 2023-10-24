Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B67D4706
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJXFqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJXFqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A210D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698126348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QC6NILim0O5ahmzo8j8vm0lOJqAczSGwvR/zz3gIWsM=;
        b=hC3u+FCBRr16cdSm20m4tm6u9zQJMeEegwCuNPUYUXz2MEYGvvXU1dS+QGudyC2IP31Ngf
        iZBG/QqjaCMNG89/Dp+OOgU9zDi/9ZBkxZsT2y+dgvr8AtoNS4QH2rg4cSqGfYLNRxYqFM
        jYIVvKPYwK2rKQF1Ph/pn01ZXKB91sE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-oCgG_DMbOLGgjgcdz7tqHw-1; Tue, 24 Oct 2023 01:45:47 -0400
X-MC-Unique: oCgG_DMbOLGgjgcdz7tqHw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507bd5f4b2dso4043843e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126345; x=1698731145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC6NILim0O5ahmzo8j8vm0lOJqAczSGwvR/zz3gIWsM=;
        b=JbwcKeyz/zZZTLZ2U1tCDnrG5/lohzDy8EcVcPuaSXk+RIYZIMDUaFm9vpZvsCdDHC
         3bL8cGe5lkPvUz6XGKrRtmLyasRZccmvgionW8foZ2hlQreDZd4pCXpDMSlwQr11lYm0
         9lVCjyThPDMbYmOIqNFVXWRza/PdzHCPsQvq2lGwVL7umJ5RlglH+KpqccWb9YpofX01
         FYNUoKGOE3r8stjPRxdcGIkuypxPwCxkl54OgYAFE87jpws5U9NOcCql0LjxBA+n3aT9
         RTH370fgrARCPihlZTXqCTYfib3CacumNmJ8PSgy5YEjyOfni1OMvZzGaQdzNZQ6BGFi
         /9oQ==
X-Gm-Message-State: AOJu0Yy8UFofnBfJBEpoBFk1Rif30NG+4q2xb7F1jU/eOXjmy8hF/OAS
        YTtTsOlyoDJ4Z8CbHaVNsruO7k2XmYuIQBzelA1fRDvYbgyREPowjf09cUFRSEE75EDM5rTYDAA
        2czg6KP4GjvHOzIfK+OVRH1Lk6bLDNcSVp4ZzQBuW
X-Received: by 2002:a19:740f:0:b0:503:afa:e79 with SMTP id v15-20020a19740f000000b005030afa0e79mr8123937lfe.5.1698126345698;
        Mon, 23 Oct 2023 22:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tubTNrrrRtvVlAu2ve/BiUFt/Pw4V7RB1Ey7CoVGxomUanQsXuQM8RkBUXTBbRneNrPqCjvxRF1p6x5LFe0=
X-Received: by 2002:a19:740f:0:b0:503:afa:e79 with SMTP id v15-20020a19740f000000b005030afa0e79mr8123931lfe.5.1698126345374;
 Mon, 23 Oct 2023 22:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com> <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 24 Oct 2023 13:45:34 +0800
Message-ID: <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older userspace
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Using .compat_reset op from the previous patch, the buggy .reset
> behaviour can be kept as-is on older userspace apps, which don't ack the
> IOTLB_PERSIST backend feature. As this compatibility quirk is limited to
> those drivers that used to be buggy in the past, it won't affect change
> the behaviour or affect ABI on the setups with API compliant driver.
>
> The separation of .compat_reset from the regular .reset allows
> vhost-vdpa able to know which driver had broken behaviour before, so it
> can apply the corresponding compatibility quirk to the individual driver
> whenever needed.  Compared to overloading the existing .reset with
> flags, .compat_reset won't cause any extra burden to the implementation
> of every compliant driver.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c         | 17 +++++++++++++----
>  drivers/virtio/virtio_vdpa.c |  2 +-
>  include/linux/vdpa.h         |  7 +++++--
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index acc7c74ba7d6..9ce40003793b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -227,13 +227,22 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_=
vdpa *v, u16 qid)
>         irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  }
>
> -static int vhost_vdpa_reset(struct vhost_vdpa *v)
> +static int _compat_vdpa_reset(struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
> +       u32 flags =3D 0;
>
> -       v->in_batch =3D 0;
> +       flags |=3D !vhost_backend_has_feature(v->vdev.vqs[0],
> +                                           VHOST_BACKEND_F_IOTLB_PERSIST=
) ?
> +                VDPA_RESET_F_CLEAN_MAP : 0;
> +
> +       return vdpa_reset(vdpa, flags);
> +}
>
> -       return vdpa_reset(vdpa);
> +static int vhost_vdpa_reset(struct vhost_vdpa *v)
> +{
> +       v->in_batch =3D 0;
> +       return _compat_vdpa_reset(v);
>  }
>
>  static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
> @@ -312,7 +321,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *=
v, u8 __user *statusp)
>                         vhost_vdpa_unsetup_vq_irq(v, i);
>
>         if (status =3D=3D 0) {
> -               ret =3D vdpa_reset(vdpa);
> +               ret =3D _compat_vdpa_reset(v);
>                 if (ret)
>                         return ret;
>         } else
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 06ce6d8c2e00..8d63e5923d24 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct virtio_device *v=
dev)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>
> -       vdpa_reset(vdpa);
> +       vdpa_reset(vdpa, 0);
>  }
>
>  static bool virtio_vdpa_notify(struct virtqueue *vq)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6b8cbf75712d..db15ac07f8a6 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -519,14 +519,17 @@ static inline struct device *vdpa_get_dma_dev(struc=
t vdpa_device *vdev)
>         return vdev->dma_dev;
>  }
>
> -static inline int vdpa_reset(struct vdpa_device *vdev)
> +static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
>  {
>         const struct vdpa_config_ops *ops =3D vdev->config;
>         int ret;
>
>         down_write(&vdev->cf_lock);
>         vdev->features_valid =3D false;
> -       ret =3D ops->reset(vdev);
> +       if (ops->compat_reset && flags)
> +               ret =3D ops->compat_reset(vdev, flags);
> +       else
> +               ret =3D ops->reset(vdev);

Instead of inventing a new API that carries the flags. Tweak the
existing one seems to be simpler and better?

As compat_reset(vdev, 0) =3D=3D reset(vdev)

Then you don't need the switch in the parent as well

+static int vdpasim_reset(struct vdpa_device *vdpa)
+{
+       return vdpasim_compat_reset(vdpa, 0);
+}

Thanks


>         up_write(&vdev->cf_lock);
>         return ret;
>  }
> --
> 2.39.3
>

