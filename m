Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4B80F581
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376600AbjLLS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDBBBC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702405640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I/WhQuPQ9xKjL/QBC35QAnSnzeBaWbmyN2v17V0JOE=;
        b=iMZ4524rgzj2G9TQ8G+EmHx963qgeIPUBQH2GtjkQzJriU9GYcUwa/333+QK++SgUpIbFW
        QDLEvkfFPLFIGpvvpbuDWSjmDiFPnZfcFl39v3jw2IGzJb9GP0OokUfxTgUOY0bmTXphFf
        8R+JZKKNNGVlTi0qR7t1JQCN1Pzh+/Y=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-uCZdfdSJNRuE_r9aIcRKKQ-1; Tue, 12 Dec 2023 13:27:19 -0500
X-MC-Unique: uCZdfdSJNRuE_r9aIcRKKQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-590b580ae39so4707586eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405638; x=1703010438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I/WhQuPQ9xKjL/QBC35QAnSnzeBaWbmyN2v17V0JOE=;
        b=PFqs6p4rcN/hILy8c21QyEB60qX9x7g2fFQpTsccIzbLlQ0ZaXrw67uoXP2dbExbV7
         X7VVu50PcJpRDhsBGU1HZauDZw55xLXq//vbikfyK3hr5A+iLL8FBoRmstnxGFqgJ/Z5
         ttAn8bqJaHqT1mCsjE2w0QGGExu5DnkTBMRaOoFQRIJn2JCdssVY8CyRlIY8j7TX53L5
         9t+eNjuzRcyKOczYbqP0IY/72DZdpPXbFaYNHm4XlMbSSRWjbjOeVhwTel1a28gVhcql
         /USfnAc+6EXhZFhqos2FqTD1V0F5q8Dc0xEYFrhsaa1k8MVCLFAhvxaJwBwPq1ccH+pL
         BgcA==
X-Gm-Message-State: AOJu0YzsgqiB1aErjvo11+A6qoXFFus6xSzjsoyGNJ509jMneTI0wL8G
        MUDv1jXIhDhkY875WKJd0DafhgAmZnpgqnfqmcBJYm1FwvRRmWsJyHGv0IzxUymVcIj2MJxWzeo
        uJv8hKI1Km9eJVHw5tTyGJ5Ei4g26sCPbt58AJhQi
X-Received: by 2002:a05:6870:7247:b0:1ff:8a1:3a7b with SMTP id y7-20020a056870724700b001ff08a13a7bmr8108091oaf.79.1702405637161;
        Tue, 12 Dec 2023 10:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEloJeZ3a0OZHp0Ze9feyHcq9XcVgdLpOrobqWfSDxMy222VbNJv5X0qTa2Of/QZg6ORvvPNWfH6KuDpS4ajtk=
X-Received: by 2002:a05:6870:7247:b0:1ff:8a1:3a7b with SMTP id
 y7-20020a056870724700b001ff08a13a7bmr8108037oaf.79.1702405635418; Tue, 12 Dec
 2023 10:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-8-dtatulea@nvidia.com>
In-Reply-To: <20231205104609.876194-8-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 12 Dec 2023 19:26:39 +0100
Message-ID: <CAJaqyWe=qP_DOHdETYSBSLtNsxdQOPh6FBS+YBSCwownOv4rfA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 7/8] vdpa/mlx5: Introduce reference counting to mrs
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
> Deleting the old mr during mr update (.set_map) and then modifying the
> vqs with the new mr is not a good flow for firmware. The firmware
> expects that mkeys are deleted after there are no more vqs referencing
> them.
>
> Introduce reference counting for mrs to fix this. It is the only way to
> make sure that mkeys are not in use by vqs.
>
> An mr reference is taken when the mr is associated to the mr asid table
> and when the mr is linked to the vq on create/modify. The reference is
> released when the mkey is unlinked from the vq (trough modify/destroy)
> and from the mr asid table.
>
> To make things consistent, get rid of mlx5_vdpa_destroy_mr and use
> get/put semantics everywhere.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  8 +++--
>  drivers/vdpa/mlx5/core/mr.c        | 50 ++++++++++++++++++++----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 45 ++++++++++++++++++++++-----
>  3 files changed, 78 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 84547d998bcf..1a0d27b6e09a 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -35,6 +35,8 @@ struct mlx5_vdpa_mr {
>         struct vhost_iotlb *iotlb;
>
>         bool user_mr;
> +
> +       refcount_t refcount;
>  };
>
>  struct mlx5_vdpa_resources {
> @@ -118,8 +120,10 @@ int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvd=
ev, u32 mkey);
>  struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>                                          struct vhost_iotlb *iotlb);
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> -                         struct mlx5_vdpa_mr *mr);
> +void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> +                     struct mlx5_vdpa_mr *mr);
> +void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> +                     struct mlx5_vdpa_mr *mr);
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
>                          struct mlx5_vdpa_mr *mr,
>                          unsigned int asid);
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 2197c46e563a..c7dc8914354a 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -498,32 +498,52 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *mr
>
>  static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
>  {
> +       if (WARN_ON(!mr))
> +               return;
> +
>         if (mr->user_mr)
>                 destroy_user_mr(mvdev, mr);
>         else
>                 destroy_dma_mr(mvdev, mr);
>
>         vhost_iotlb_free(mr->iotlb);
> +
> +       kfree(mr);
>  }
>
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> -                         struct mlx5_vdpa_mr *mr)
> +static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> +                             struct mlx5_vdpa_mr *mr)
>  {
>         if (!mr)
>                 return;
>
> +       if (refcount_dec_and_test(&mr->refcount))
> +               _mlx5_vdpa_destroy_mr(mvdev, mr);
> +}
> +
> +void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> +                     struct mlx5_vdpa_mr *mr)
> +{
>         mutex_lock(&mvdev->mr_mtx);
> +       _mlx5_vdpa_put_mr(mvdev, mr);
> +       mutex_unlock(&mvdev->mr_mtx);
> +}
>
> -       _mlx5_vdpa_destroy_mr(mvdev, mr);
> +static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> +                             struct mlx5_vdpa_mr *mr)
> +{
> +       if (!mr)
> +               return;
>
> -       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> -               if (mvdev->mr[i] =3D=3D mr)
> -                       mvdev->mr[i] =3D NULL;
> -       }
> +       refcount_inc(&mr->refcount);
> +}
>
> +void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> +                     struct mlx5_vdpa_mr *mr)
> +{
> +       mutex_lock(&mvdev->mr_mtx);
> +       _mlx5_vdpa_get_mr(mvdev, mr);
>         mutex_unlock(&mvdev->mr_mtx);
> -
> -       kfree(mr);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -534,20 +554,16 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvde=
v,
>
>         mutex_lock(&mvdev->mr_mtx);
>
> +       _mlx5_vdpa_put_mr(mvdev, old_mr);
>         mvdev->mr[asid] =3D new_mr;
> -       if (old_mr) {
> -               _mlx5_vdpa_destroy_mr(mvdev, old_mr);
> -               kfree(old_mr);
> -       }
>
>         mutex_unlock(&mvdev->mr_mtx);
> -
>  }
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
> -               mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +               mlx5_vdpa_update_mr(mvdev, NULL, i);
>
>         prune_iotlb(mvdev->cvq.iotlb);
>  }
> @@ -607,6 +623,8 @@ struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_=
vdpa_dev *mvdev,
>         if (err)
>                 goto out_err;
>
> +       refcount_set(&mr->refcount, 1);
> +
>         return mr;
>
>  out_err:
> @@ -651,7 +669,7 @@ int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, u=
nsigned int asid)
>         if (asid >=3D MLX5_VDPA_NUM_AS)
>                 return -EINVAL;
>
> -       mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[asid]);
> +       mlx5_vdpa_update_mr(mvdev, NULL, asid);
>
>         if (asid =3D=3D 0 && MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 if (mlx5_vdpa_create_dma_mr(mvdev))
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 6a21223d97a8..133cbb66dcfe 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -123,6 +123,9 @@ struct mlx5_vdpa_virtqueue {
>
>         u64 modified_fields;
>
> +       struct mlx5_vdpa_mr *vq_mr;
> +       struct mlx5_vdpa_mr *desc_mr;
> +
>         struct msi_map map;
>
>         /* keep last in the struct */
> @@ -946,6 +949,14 @@ static int create_virtqueue(struct mlx5_vdpa_net *nd=
ev, struct mlx5_vdpa_virtque
>         kfree(in);
>         mvq->virtq_id =3D MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>
> +       mlx5_vdpa_get_mr(mvdev, vq_mr);
> +       mvq->vq_mr =3D vq_mr;
> +
> +       if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported)) {
> +               mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
> +               mvq->desc_mr =3D vq_desc_mr;
> +       }
> +
>         return 0;
>
>  err_cmd:
> @@ -972,6 +983,12 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *=
ndev, struct mlx5_vdpa_virtq
>         }
>         mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         umems_destroy(ndev, mvq);
> +
> +       mlx5_vdpa_put_mr(&ndev->mvdev, mvq->vq_mr);
> +       mvq->vq_mr =3D NULL;
> +
> +       mlx5_vdpa_put_mr(&ndev->mvdev, mvq->desc_mr);
> +       mvq->desc_mr =3D NULL;
>  }
>
>  static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)
> @@ -1207,6 +1224,8 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>         int inlen =3D MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] =3D {};
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> +       struct mlx5_vdpa_mr *desc_mr =3D NULL;
> +       struct mlx5_vdpa_mr *vq_mr =3D NULL;
>         bool state_change =3D false;
>         void *obj_context;
>         void *cmd_hdr;
> @@ -1257,19 +1276,19 @@ static int modify_virtqueue(struct mlx5_vdpa_net =
*ndev,
>                 MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> -               struct mlx5_vdpa_mr *mr =3D mvdev->mr[mvdev->group2asid[M=
LX5_VDPA_DATAVQ_GROUP]];
> +               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
>
> -               if (mr)
> -                       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, mr->mke=
y);
> +               if (vq_mr)
> +                       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->=
mkey);
>                 else
>                         mvq->modified_fields &=3D ~MLX5_VIRTQ_MODIFY_MASK=
_VIRTIO_Q_MKEY;
>         }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> -               struct mlx5_vdpa_mr *mr =3D mvdev->mr[mvdev->group2asid[M=
LX5_VDPA_DATAVQ_DESC_GROUP]];
> +               desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_=
DESC_GROUP]];
>
> -               if (mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported))
> -                       MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, mr->m=
key);
> +               if (desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, d=
esc_group_mkey_supported))
> +                       MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, desc_=
mr->mkey);
>                 else
>                         mvq->modified_fields &=3D ~MLX5_VIRTQ_MODIFY_MASK=
_DESC_GROUP_MKEY;
>         }
> @@ -1282,6 +1301,18 @@ static int modify_virtqueue(struct mlx5_vdpa_net *=
ndev,
>         if (state_change)
>                 mvq->fw_state =3D state;
>
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> +               mlx5_vdpa_put_mr(mvdev, mvq->vq_mr);
> +               mlx5_vdpa_get_mr(mvdev, vq_mr);
> +               mvq->vq_mr =3D vq_mr;
> +       }
> +
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> +               mlx5_vdpa_put_mr(mvdev, mvq->desc_mr);
> +               mlx5_vdpa_get_mr(mvdev, desc_mr);
> +               mvq->desc_mr =3D desc_mr;
> +       }
> +
>         mvq->modified_fields =3D 0;
>
>  done:
> @@ -3095,7 +3126,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>         return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
>
>  out_err:
> -       mlx5_vdpa_destroy_mr(mvdev, new_mr);
> +       mlx5_vdpa_put_mr(mvdev, new_mr);
>         return err;
>  }
>
> --
> 2.42.0
>

