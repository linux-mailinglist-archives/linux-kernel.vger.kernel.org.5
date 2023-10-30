Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CCB7DBC72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjJ3POG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjJ3POE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACFC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698678796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqhHvkxz2M3gWjoEU6H5EuCj6+A9vLSSzAJNkkzQU6w=;
        b=TfwWhQslVFcC3sOGID6dcb9y9SFDy/gnZ2CgesroE7QeSNkgwgrOg9ucVB4I7dhN86Hdpi
        NWfLJyn61blGSE+KMAaYiELsly+BJm5seMbP+srTsjx2IIIg1CA6greseJitd/YSxX6siS
        XvPAVI+0QIvvdso+q2HAhbxfgSA9MpU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-ftqvXhQ3MveGtEOc-mD02A-1; Mon, 30 Oct 2023 11:13:14 -0400
X-MC-Unique: ftqvXhQ3MveGtEOc-mD02A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5af9b0850fdso36907497b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678793; x=1699283593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqhHvkxz2M3gWjoEU6H5EuCj6+A9vLSSzAJNkkzQU6w=;
        b=n9On7yhBhRQKCWtDlcaB2Aod1JAmlPgDrtbXlBdSV5ivGqkgFv6aAMzdWcw/Py17IH
         l/kLq5Mf1QiIaaEwFE6m1XW+EBI81iFFRJNNqnidmi4mLhsOnCidac0I4w1U75R0egNS
         DZzjyPoV9w/K2a0UODrNrkc9QCsDxdAkOwb3FnXu2dq7gRRUulezMNGbwedkUSe1HuA6
         rPK/eeyAcHy55ckb3k0z7SxAuFrZJHO/pTeVFm4YFBAEPWQG9eHfXMqqx/yW/tQXMH5K
         mWp7QahexST7Dnp898HMthRzcxilmSM6XlQYuaF0Uya+J6l6kUjkGKqfAGjHfxV70oru
         8EcQ==
X-Gm-Message-State: AOJu0Yy6U2pARga+kFZL13WunwJmFqyeDMPCqAR2XzmbwyjT1Y1JpGcQ
        wpyrIvYZ6XIXNEkCXCvKsxRxIkjdBWiwJlKi+GTlIiFknG+CzyruQuNFdCnmEUAO8LfM3k1ph7f
        XVQVFm8w0nKAUMiRK/8X80lG9Y8ida4qk5zBIpj2d
X-Received: by 2002:a81:c645:0:b0:59a:f131:50fa with SMTP id q5-20020a81c645000000b0059af13150famr8908940ywj.47.1698678793588;
        Mon, 30 Oct 2023 08:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8cagaVuRD2uSX1dWbSnBRneMUnh/waBGaPbXNrsgtq6V0qCCz1BymrTFgG+Jx9BdLD5vLUGUG7Gx9e5ChMvk=
X-Received: by 2002:a81:c645:0:b0:59a:f131:50fa with SMTP id
 q5-20020a81c645000000b0059af13150famr8908930ywj.47.1698678793337; Mon, 30 Oct
 2023 08:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 30 Oct 2023 16:12:36 +0100
Message-ID: <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To:     Steve Sistare <steven.sistare@oracle.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:09=E2=80=AFPM Steve Sistare
<steven.sistare@oracle.com> wrote:
>
> mlx5_vdpa does not preserve userland's view of vring base for the control
> queue in the following sequence:
>
> ioctl VHOST_SET_VRING_BASE
> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>   mlx5_vdpa_set_status()
>     setup_cvq_vring()
>       vringh_init_iotlb()
>         vringh_init_kern()
>           vrh->last_avail_idx =3D 0;
> ioctl VHOST_GET_VRING_BASE
>
> To fix, restore the value of cvq->vring.last_avail_idx after calling
> vringh_init_iotlb.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
>  drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
>  include/linux/vringh.h            |  2 ++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 946488b8989f..f64758143115 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
>         int err =3D 0;
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> +               u16 last_avail_idx =3D cvq->vring.last_avail_idx;
> +
>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
>                                         MLX5_CVQ_MAX_ENT, false,
>                                         (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
>                                         (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
>                                         (struct vring_used *)(uintptr_t)c=
vq->device_addr);
>
> +               if (!err)
> +                       vringh_set_base_iotlb(&cvq->vring, last_avail_idx=
);
> +       }
>         return err;
>  }
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 7b8fd977f71c..799762c83007 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vr=
ingh *vrh,
>         }
>  }
>
> +static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
> +                           int (*putu16)(const struct vringh *vrh,
> +                               __virtio16 *p, u16 val))
> +{
> +    int ret;
> +
> +    ret =3D putu16(vrh, &vrh->vring.avail->idx, idx);
> +    if (ret)
> +        return ret;
> +
> +    ret =3D putu16(vrh, &vrh->vring.used->idx, idx);
> +    if (ret)
> +        return ret;
> +

I don't think VMM should be able to modify the guest's vring memory.
For vringh it should be enough with the next line, no need for
previous.

If I'm not wrong this was solved in the simulator by [1] and [2]. Am I
missing something?

Thanks!

[1] https://lkml.org/lkml/2023/1/18/1045
[2] https://www.spinics.net/lists/kernel/msg4705724.html

> +    vrh->last_avail_idx =3D vrh->last_used_idx =3D idx;
> +    return 0;
> +}
> +
>  /* Userspace access helpers: in this case, addresses are really userspac=
e. */
>  static inline int getu16_user(const struct vringh *vrh, u16 *val, const =
__virtio16 *p)
>  {
> @@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct v=
host_iotlb *iotlb,
>  }
>  EXPORT_SYMBOL(vringh_set_iotlb);
>
> +/**
> + * vringh_set_base_iotlb - set avail_idx and used_idx
> + * @vrh: the vring
> + * @idx: the value to set
> + */
> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
> +{
> +    return __vringh_set_base(vrh, idx, putu16_iotlb);
> +}
> +EXPORT_SYMBOL(vringh_set_base_iotlb);
> +
> +
>  /**
>   * vringh_getdesc_iotlb - get next available descriptor from ring with
>   * IOTLB.
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index c3a8117dabe8..e9b8af4e6a5e 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 feat=
ures,
>                          struct vring_avail *avail,
>                          struct vring_used *used);
>
> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
> +
>  int vringh_getdesc_iotlb(struct vringh *vrh,
>                          struct vringh_kiov *riov,
>                          struct vringh_kiov *wiov,
> --
> 2.39.3
>

