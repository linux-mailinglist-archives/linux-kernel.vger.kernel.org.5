Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB847B8D11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbjJDS5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbjJDSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDA100
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696445644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4z0LQ27WHjxD8ZA2Cp+WpAJ11PshuGV+qy5mka3Mty8=;
        b=iRkr6flu9ZxRWJyqTe8dSwR9lldGfCDYs4TPesAsQdjqMDCGOO9qGT32pmL+Z/y30lJY6V
        5c0loc9bITeHbLwmGLjpDP+4ibzvXwWLik5Xfo2wIqbW9eTpEnB8g+mVf9FK7iOb8NGzw/
        pcMP0d/fG1s2+vyfRtjupTAg8aGBeow=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-pJzmtv57P9eFqi-YTlEtrg-1; Wed, 04 Oct 2023 14:54:03 -0400
X-MC-Unique: pJzmtv57P9eFqi-YTlEtrg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a1df5b7830so2525327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445643; x=1697050443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z0LQ27WHjxD8ZA2Cp+WpAJ11PshuGV+qy5mka3Mty8=;
        b=KZhETLu0fNHp61+KuSaj9+MIzCefemMFfp9e++G7EUfHOBwDKF68B38jE8+0/vaeaA
         2IWBeEFtEHNKgMOTCpjwAmRJkQqhk4hUkZeh+EXssdmpqpcOAcOVklyS97UY4po/1XFG
         MOy7SsLMa+Q9IvchFSdvJYYD9Ibb7V27pSWQIHNISJwZ1gE31omdi1qGlJ65oQa/CpUC
         KP3uatawOKOUV6tmIhu/nOCF0vY9QnFlsy2JeM5wOZYdA0A5PGK6GWQQfLw6kf0iXpeH
         XfPdqHhCtGBpgxe+4N5mmoY1xPShjqMi0a7CyLc3EZ6VUHkxKs4MhbAtauVIrCS8Dd4b
         Resw==
X-Gm-Message-State: AOJu0YygcMJaJeUNzW3pWo8Pbd3WYgE+PnlKpRAbnIiwNDbd2kGZgW3Y
        3s3a3nsZCY7j6obiLRnrqTkBbNP2WIQQEbg43wsxVZL/ZkrZiuX9LQqhWovcdXqs6dhlTgRc2da
        bFMKVXU44LddxZV+rKKW1MTLdva76u/9ABgZbbO02
X-Received: by 2002:a0d:e814:0:b0:59f:4cb1:594d with SMTP id r20-20020a0de814000000b0059f4cb1594dmr3393299ywe.3.1696445643011;
        Wed, 04 Oct 2023 11:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3oLMEVVTbNA05gdLwRyENSA9tIYSFn4tutco4oDaodqN5E4q1ba+qZNnbBxWyVQbKHther3I4pTYkKf0W7Xc=
X-Received: by 2002:a0d:e814:0:b0:59f:4cb1:594d with SMTP id
 r20-20020a0de814000000b0059f4cb1594dmr3393287ywe.3.1696445642754; Wed, 04 Oct
 2023 11:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-15-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-15-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:53:26 +0200
Message-ID: <CAJaqyWfgzUYZdib2TtuJBB7qNBCoiqdHGii6w-M7m+bm8tXVhw@mail.gmail.com>
Subject: Re: [PATCH vhost 13/16] vdpa/mlx5: Introduce mr for vq descriptor
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     gal@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
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

On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Introduce the vq descriptor group and ASID 1. Until now .set_map on ASID

s/ASID/vq group/?

> 1 was only updating the cvq iotlb. From now on it also creates a mkey
> for it. The current patch doesn't use it but follow-up patches will
> add hardware support for mapping the vq descriptors.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +++--
>  drivers/vdpa/mlx5/core/mr.c        | 14 +++++++++-----
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 20 +++++++++++++-------
>  3 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index bbe4335106bd..ae09296f4270 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -70,11 +70,12 @@ struct mlx5_vdpa_wq_ent {
>  enum {
>         MLX5_VDPA_DATAVQ_GROUP,
>         MLX5_VDPA_CVQ_GROUP,
> +       MLX5_VDPA_DATAVQ_DESC_GROUP,
>         MLX5_VDPA_NUMVQ_GROUPS
>  };
>
>  enum {
> -       MLX5_VDPA_NUM_AS =3D MLX5_VDPA_NUMVQ_GROUPS
> +       MLX5_VDPA_NUM_AS =3D 2
>  };
>
>  struct mlx5_vdpa_dev {
> @@ -89,7 +90,7 @@ struct mlx5_vdpa_dev {
>         u16 max_idx;
>         u32 generation;
>
> -       struct mlx5_vdpa_mr *mr;
> +       struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];

I'm wondering if it makes sense to squash all of this patch with the
previous one, as I think *mr[MLX5_VDPA_NUM_AS] makes way more sense
than just *mr.

Whatever you choose, for both patches:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>         /* serialize mr access */
>         struct mutex mr_mtx;
>         struct mlx5_control_vq cvq;
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 00eff5a07152..3dee6d9bed6b 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -511,8 +511,10 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvde=
v,
>
>         _mlx5_vdpa_destroy_mr(mvdev, mr);
>
> -       if (mvdev->mr =3D=3D mr)
> -               mvdev->mr =3D NULL;
> +       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> +               if (mvdev->mr[i] =3D=3D mr)
> +                       mvdev->mr[i] =3D NULL;
> +       }
>
>         mutex_unlock(&mvdev->mr_mtx);
>
> @@ -523,11 +525,11 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvde=
v,
>                          struct mlx5_vdpa_mr *new_mr,
>                          unsigned int asid)
>  {
> -       struct mlx5_vdpa_mr *old_mr =3D mvdev->mr;
> +       struct mlx5_vdpa_mr *old_mr =3D mvdev->mr[asid];
>
>         mutex_lock(&mvdev->mr_mtx);
>
> -       mvdev->mr =3D new_mr;
> +       mvdev->mr[asid] =3D new_mr;
>         if (old_mr) {
>                 _mlx5_vdpa_destroy_mr(mvdev, old_mr);
>                 kfree(old_mr);
> @@ -539,7 +541,9 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> -       mlx5_vdpa_destroy_mr(mvdev, mvdev->mr);
> +       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
> +               mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +
>         prune_iotlb(mvdev);
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 4a87f9119fca..25bd2c324f5b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -821,6 +821,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] =3D {};
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> +       struct mlx5_vdpa_mr *vq_mr;
>         void *obj_context;
>         u16 mlx_features;
>         void *cmd_hdr;
> @@ -873,7 +875,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>         MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
>         MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
>         MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> -       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, ndev->mvdev.mr->mkey);
> +       vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
> +       if (vq_mr)
> +               MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
>         MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>         MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
>         MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> @@ -2633,7 +2637,8 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>  }
>
>  static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
> -                               struct mlx5_vdpa_mr *new_mr, unsigned int=
 asid)
> +                               struct mlx5_vdpa_mr *new_mr,
> +                               unsigned int asid)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
> @@ -2652,8 +2657,10 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_d=
ev *mvdev,
>
>         restore_channels_info(ndev);
>         err =3D setup_driver(mvdev);
> +       if (err)
> +               return err;
>
> -       return err;
> +       return 0;
>  }
>
>  /* reslock must be held for this function */
> @@ -2869,8 +2876,8 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>         struct mlx5_vdpa_mr *new_mr;
>         int err;
>
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> -               goto end;
> +       if (asid >=3D MLX5_VDPA_NUM_AS)
> +               return -EINVAL;
>
>         new_mr =3D mlx5_vdpa_create_mr(mvdev, iotlb);
>         if (IS_ERR(new_mr)) {
> @@ -2879,7 +2886,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>                 return err;
>         }
>
> -       if (!mvdev->mr) {
> +       if (!mvdev->mr[asid]) {
>                 mlx5_vdpa_update_mr(mvdev, new_mr, asid);
>         } else {
>                 err =3D mlx5_vdpa_change_map(mvdev, new_mr, asid);
> @@ -2889,7 +2896,6 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>                 }
>         }
>
> -end:
>         return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
>
>  out_err:
> --
> 2.41.0
>

