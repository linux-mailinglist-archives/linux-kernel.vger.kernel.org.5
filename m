Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC577B8AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbjJDSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbjJDSlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE12A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696444828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWccVzowjeF8W3oTWholB4i/UFaz+KWEgVbFZJxBR88=;
        b=V7JV1AOag+sD3j7f1/AXc1ybuJHeX9B97dsmso3Dl8NOqzAtNGcH/6TPmLDwt3DxxAOi48
        eS/9eyayoh9CUttn4H08E0byo6OCtH/oDY9m8UH5yU53HRir5zv+G8rn850zAQVNF1QXWY
        CIzxFxuq7GI7e3rRBrWMSWMkSsSDeZk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-7DBPtIjBPG-X-MNrr0aMDA-1; Wed, 04 Oct 2023 14:40:22 -0400
X-MC-Unique: 7DBPtIjBPG-X-MNrr0aMDA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a21e8ee1b7so10632467b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444822; x=1697049622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWccVzowjeF8W3oTWholB4i/UFaz+KWEgVbFZJxBR88=;
        b=WqH5kkXe3/II6lS7LILRTY1ad2rrWfcLH9fgTCUWWQOXq/82gYO0QEV36bTW07aeNm
         Ziq5B2vuTJmKrzLwFYYB4s/MqcLP0mL7IDGLjCIddCc3eV/yP39gLyj7OwHl+Jn42wEN
         rmtAL2b2QSrDrLycywQ4WCvHwIkxvjlwW58k3DzcHWB5oPRovjVstsO7iTDfGNG9junL
         NNGKxfi8UaREhUgrjHJni6GvGDMiaKPqsoO+BnAYmkOVB2CQCxzcR/byL5/FMv3xnwub
         21da8bvyBxxSPEo+DYlfzmnYdrbbn/6N74xnetZKXlHBf1tZiN/VxBMKEZaOv407GDCL
         SjRQ==
X-Gm-Message-State: AOJu0YxhXxlGFj+ulXaPPhrmBZG+rNOFDtQQjNIBnfnMBeUFaRQq3J4D
        ofZJfXXAIFC+OCi/SDlYPX51nHopp3OrXaSA8+WgoNUsvmYqg8DI4YbEBMepjO7j17dRgbvUYmy
        4i/74LQ3d2BwIHlvgQXvrzqrYVOffSbP0h32vuZDt
X-Received: by 2002:a0d:df41:0:b0:5a5:575:e944 with SMTP id i62-20020a0ddf41000000b005a50575e944mr433477ywe.4.1696444821999;
        Wed, 04 Oct 2023 11:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDJbjK1uZhC3eKqhTuaWuPmerffrDYRpSVzNLVBxpiazRhzG57UpvjtpbbBLuF6dSV+LY9Aa00smhi7Iw27xE=
X-Received: by 2002:a0d:df41:0:b0:5a5:575:e944 with SMTP id
 i62-20020a0ddf41000000b005a50575e944mr433459ywe.4.1696444821702; Wed, 04 Oct
 2023 11:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-8-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-8-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:39:45 +0200
Message-ID: <CAJaqyWdFFHD=3vy+e__gRGp2enG6tku_KKEDa42djsv9XP5nVQ@mail.gmail.com>
Subject: Re: [PATCH vhost 06/16] vdpa/mlx5: Decouple cvq iotlb handling from
 hw mapping code
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The handling of the cvq iotlb is currently coupled with the creation
> and destruction of the hardware mkeys (mr).
>
> This patch moves cvq iotlb handling into its own function and shifts it
> to a scope that is not related to mr handling. As cvq handling is just a
> prune_iotlb + dup_iotlb cycle, put it all in the same "update" function.
> Finally, the destruction path is handled by directly pruning the iotlb.
>
> After this move is done the ASID mr code can be collapsed into a single
> function.
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  3 ++
>  drivers/vdpa/mlx5/core/mr.c        | 57 +++++++++++-------------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  7 ++--
>  3 files changed, 28 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 3748f027cfe9..554899a80241 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -120,6 +120,9 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, =
struct vhost_iotlb *iotlb,
>                         unsigned int asid);
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
>  void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int=
 asid);
> +int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb,
> +                               unsigned int asid);
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
>
>  #define mlx5_vdpa_warn(__dev, format, ...)                              =
                           \
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 7bd0883b8b25..fcb6ae32e9ed 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -489,14 +489,6 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mv=
dev, struct mlx5_vdpa_mr *mr
>         }
>  }
>
> -static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
> -{
> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> -               return;
> -
> -       prune_iotlb(mvdev);
> -}
> -
>  static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> @@ -522,25 +514,14 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev=
 *mvdev, unsigned int asid)
>         mutex_lock(&mr->mkey_mtx);
>
>         _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> -       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
>
>         mutex_unlock(&mr->mkey_mtx);
>  }
>
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>  {
> -       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_=
GROUP]);
>         mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATA=
VQ_GROUP]);
> -}
> -
> -static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> -                                   struct vhost_iotlb *iotlb,
> -                                   unsigned int asid)
> -{
> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> -               return 0;
> -
> -       return dup_iotlb(mvdev, iotlb);
> +       prune_iotlb(mvdev);
>  }
>
>  static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -572,22 +553,7 @@ static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa=
_dev *mvdev,
>  static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>                                 struct vhost_iotlb *iotlb, unsigned int a=
sid)
>  {
> -       int err;
> -
> -       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> -       if (err)
> -               return err;
> -
> -       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> -       if (err)
> -               goto out_err;
> -
> -       return 0;
> -
> -out_err:
> -       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> -
> -       return err;
> +       return _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
>  }
>
>  int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> @@ -620,7 +586,24 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *m=
vdev, struct vhost_iotlb *io
>         return err;
>  }
>
> +int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb,
> +                               unsigned int asid)
> +{
> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> +               return 0;
> +
> +       prune_iotlb(mvdev);
> +       return dup_iotlb(mvdev, iotlb);
> +}
> +
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
>  {
> -       return mlx5_vdpa_create_mr(mvdev, NULL, 0);
> +       int err;
> +
> +       err =3D mlx5_vdpa_create_mr(mvdev, NULL, 0);
> +       if (err)
> +               return err;
> +
> +       return mlx5_vdpa_update_cvq_iotlb(mvdev, NULL, 0);
>  }
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 65b6a54ad344..aa4896662699 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2884,10 +2884,13 @@ static int set_map_data(struct mlx5_vdpa_dev *mvd=
ev, struct vhost_iotlb *iotlb,
>                 return err;
>         }
>
> -       if (change_map)
> +       if (change_map) {
>                 err =3D mlx5_vdpa_change_map(mvdev, iotlb, asid);
> +               if (err)
> +                       return err;
> +       }
>
> -       return err;
> +       return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
>  }
>
>  static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid=
,
> --
> 2.41.0
>

