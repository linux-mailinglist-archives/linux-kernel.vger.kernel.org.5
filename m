Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7F80F68D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbjLLTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCBCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702408977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXopr8ue2K1cVGD2mD+ppNHToF8ZtCpiGeLOAu9qGlU=;
        b=UGCNKBD8Hm8dQsYP6pQWWU+a+fE3Z3U7dIaYR6R+Oigxce1F+cZy0PBsO563Ykr9P08Fcf
        G9DH6QlX9CnHB5efOcLqvCwnkWpfop4dOfYcEuwB1VeLh3y/BEhp2PgqTnmTefcXxBAkfz
        s8LtuxZ/79zAFdlB8ak2qz0/yhIjoXY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-i9IZWEoEPrqeeO5aJp2RHw-1; Tue, 12 Dec 2023 14:22:56 -0500
X-MC-Unique: i9IZWEoEPrqeeO5aJp2RHw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5de8e375768so54904487b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408975; x=1703013775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXopr8ue2K1cVGD2mD+ppNHToF8ZtCpiGeLOAu9qGlU=;
        b=HS/SCekrE4XC9+OuZFaQBT/vVmD7ggsYTyyQdyufg6LrSfz3JyhvhGRkFHo8oZgnvm
         rGGiQb1G1czMG25c7WP6aqmtCLup9+sd+BIVB8rDzHvv3xpAGwhNOwCFCmRH37mipn2e
         XM7DZAGW4Qwh6biuR7nmqlliqmh8ASDa7reLwE47ITXJ+63u2LnA4MFcIZ8zIaFLjDbV
         pdl9ABWcttaXbUlBpl+2KdmdZxUJLJmlr7iagdAPZhpgcttkE5hH8DWJ3bLIHw+ZzsUC
         11yiXGLULtGTknrq5p/zXvqnhAlHa8rfKuDkTghs7T4THg9flrIIYC6xx5AW+PYeJXfB
         WqPA==
X-Gm-Message-State: AOJu0Yyq4W+XvaAZNkjiuf1ioU+tdesdf7VKjfWQ+Y9KNsJzBn10p6n1
        ANYQnYGugUKFFarSPZDb8gxE7uHQQb0qC0inVRK9F++C3aIG6WNHkgku+g84or5E0jPmasqAZt4
        etIDSZ2uu65ubstHvHULi1VdO84aCgZNvU1Pf3gCB
X-Received: by 2002:a81:df0b:0:b0:5c7:47f:59e8 with SMTP id c11-20020a81df0b000000b005c7047f59e8mr5940291ywn.42.1702408975691;
        Tue, 12 Dec 2023 11:22:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI4DdCCjsgiWNQwBvsJQ5lMA58uV0BznVcQ8eTOzDL0scgZ05CCCu/TFJUcNbpGUK3iBmS2/pwIeY0tEJYZvg=
X-Received: by 2002:a81:df0b:0:b0:5c7:47f:59e8 with SMTP id
 c11-20020a81df0b000000b005c7047f59e8mr5940281ywn.42.1702408975363; Tue, 12
 Dec 2023 11:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-7-dtatulea@nvidia.com>
In-Reply-To: <20231205104609.876194-7-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 12 Dec 2023 20:22:19 +0100
Message-ID: <CAJaqyWdcCvt=QeAGBVEkPHmj9i29KJfjwuYMETLUBgDY7dLSug@mail.gmail.com>
Subject: Re: [PATCH vhost v2 6/8] vdpa/mlx5: Use vq suspend/resume during .set_map
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 11:47=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Instead of tearing down and setting up vq resources, use vq
> suspend/resume during .set_map to speed things up a bit.
>
> The vq mr is updated with the new mapping while the vqs are suspended.
>
> If the device doesn't support resumable vqs, do the old teardown and
> setup dance.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I didn't ack it, but I'm ok with it, so:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 46 ++++++++++++++++++++++++------
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  1 +
>  2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d6c8506cec8f..6a21223d97a8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1206,6 +1206,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] =3D {};
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         bool state_change =3D false;
>         void *obj_context;
>         void *cmd_hdr;
> @@ -1255,6 +1256,24 @@ static int modify_virtqueue(struct mlx5_vdpa_net *=
ndev,
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_I=
DX)
>                 MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
>
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> +               struct mlx5_vdpa_mr *mr =3D mvdev->mr[mvdev->group2asid[M=
LX5_VDPA_DATAVQ_GROUP]];
> +
> +               if (mr)
> +                       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, mr->mke=
y);
> +               else
> +                       mvq->modified_fields &=3D ~MLX5_VIRTQ_MODIFY_MASK=
_VIRTIO_Q_MKEY;
> +       }
> +
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> +               struct mlx5_vdpa_mr *mr =3D mvdev->mr[mvdev->group2asid[M=
LX5_VDPA_DATAVQ_DESC_GROUP]];
> +
> +               if (mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported))
> +                       MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, mr->m=
key);
> +               else
> +                       mvq->modified_fields &=3D ~MLX5_VIRTQ_MODIFY_MASK=
_DESC_GROUP_MKEY;
> +       }
> +
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
>         if (err)
> @@ -2784,24 +2803,35 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_=
dev *mvdev,
>                                 unsigned int asid)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool teardown =3D !is_resumable(ndev);
>         int err;
>
>         suspend_vqs(ndev);
> -       err =3D save_channels_info(ndev);
> -       if (err)
> -               return err;
> +       if (teardown) {
> +               err =3D save_channels_info(ndev);
> +               if (err)
> +                       return err;
>
> -       teardown_driver(ndev);
> +               teardown_driver(ndev);
> +       }
>
>         mlx5_vdpa_update_mr(mvdev, new_mr, asid);
>
> +       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
> +               ndev->vqs[i].modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY |
> +                                               MLX5_VIRTQ_MODIFY_MASK_DE=
SC_GROUP_MKEY;
> +
>         if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspen=
ded)
>                 return 0;
>
> -       restore_channels_info(ndev);
> -       err =3D setup_driver(mvdev);
> -       if (err)
> -               return err;
> +       if (teardown) {
> +               restore_channels_info(ndev);
> +               err =3D setup_driver(mvdev);
> +               if (err)
> +                       return err;
> +       }
> +
> +       resume_vqs(ndev);
>
>         return 0;
>  }
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5=
_ifc_vdpa.h
> index 32e712106e68..40371c916cf9 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -148,6 +148,7 @@ enum {
>         MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =3D (u64)1 << 6,
>         MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX       =3D (u64)1 << 7,
>         MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX        =3D (u64)1 << 8,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY            =3D (u64)1 << 11,
>         MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 << 14,
>  };
>
> --
> 2.42.0
>

