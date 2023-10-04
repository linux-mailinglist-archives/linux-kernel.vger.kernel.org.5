Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81707B8B27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbjJDSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbjJDSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B898
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696445173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PD3RxeaUjj3r3M7laBa9+gCeX8NhdsPb4ZmCLqdoI54=;
        b=Kclb7RwSipVJQZsQ7pFkKJoJ4zRkI2J+zWv+RTwVPy2o1IihGPgmY0K7s4SllMQLvG7VmS
        iP4i9ME9wblxBNc1iSgcYBHgjztZpy2sM3j6oEmoDzzxfDQTk8viD54E3KOZYVgo3uWjJs
        jIeUHCQ4IXq0yCUZGyASeWHzAqFTeUU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643--1yteBiUM-CxvwokZWp_RQ-1; Wed, 04 Oct 2023 14:46:02 -0400
X-MC-Unique: -1yteBiUM-CxvwokZWp_RQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a21c283542so1276377b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445161; x=1697049961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD3RxeaUjj3r3M7laBa9+gCeX8NhdsPb4ZmCLqdoI54=;
        b=WnJOSS9dUsZu+mA3DrXcrB9+li/miSs45DcDLJ5V3sfOO+GgF3XmKrv/RMQjMjDcM9
         savshVWgG72Uxcv0eVcsqtx37ME8xDWMYRfN6kGn3qQdWf8OQKKv9ClOxL1DNlaig2Ks
         yVaYis4QgtLUntUotult4fNaXIm5oJGm1sVMYs/nWpFuAiAvc8fJGylOI423aDUysksJ
         oXFc/ARovACJHCygLiPqOdwgfeHeX2jiq5RVyisw06Ij8KOcPXr0dY/M1FNjZqMTxTGr
         8Uj/H1WxL6iEgAmrV3vWahH5wLr23Unyl3G0fY9k4g1gGY9QnoxQTLBty/LJC4ox/50K
         X8TA==
X-Gm-Message-State: AOJu0Yz+HE/DZtSxad9PedURCsH88jBVynth38Zafw6d0DQxBtkEoucb
        oz13nC3+onrmwgMIxaAEAC2Y4jnftXKgdixjpQ8jUqkqfJwTzwQ63bL8eZT8Zwos7EXai95whGg
        xgLwM5FvswAtGUtYowSuSrdheikTHJnYLEHy6CZ/f
X-Received: by 2002:a81:8742:0:b0:59f:6675:7771 with SMTP id x63-20020a818742000000b0059f66757771mr2983537ywf.35.1696445161621;
        Wed, 04 Oct 2023 11:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHklAHcVGq4eSlE9nvIGtGJnP0oRQTe4fC54xyRaO7eKLtCnGl25b0RK/CrQkp3DGJTf29bpgFiz0mDDbB2NmU=
X-Received: by 2002:a81:8742:0:b0:59f:6675:7771 with SMTP id
 x63-20020a818742000000b0059f66757771mr2983527ywf.35.1696445161336; Wed, 04
 Oct 2023 11:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-12-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-12-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:45:25 +0200
Message-ID: <CAJaqyWdOGC8E=UMWpR+5fhR5DG=6KD6Z9sQd151tbx=nC4-NDQ@mail.gmail.com>
Subject: Re: [PATCH vhost 10/16] vdpa/mlx5: Allow creation/deletion of any
 given mr struct
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
> This patch adapts the mr creation/deletion code to be able to work with
> any given mr struct pointer. All the APIs are adapted to take an extra
> parameter for the mr.
>
> mlx5_vdpa_create/delete_mr doesn't need a ASID parameter anymore. The
> check is done in the caller instead (mlx5_set_map).
>
> This change is needed for a followup patch which will introduce an
> additional mr for the vq descriptor data.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  8 +++--
>  drivers/vdpa/mlx5/core/mr.c        | 53 ++++++++++++++----------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 10 ++++--
>  3 files changed, 36 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index e1e6e7aba50e..01d4ee58ccb1 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -116,10 +116,12 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvd=
ev, u32 *mkey, u32 *in,
>  int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
>  int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_i=
otlb *iotlb,
>                              bool *change_map, unsigned int asid);
> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> -                       unsigned int asid);
> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> +                       struct mlx5_vdpa_mr *mr,
> +                       struct vhost_iotlb *iotlb);
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid=
);
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> +                         struct mlx5_vdpa_mr *mr);
>  int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
>                                 struct vhost_iotlb *iotlb,
>                                 unsigned int asid);
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 00dcce190a1f..6f29e8eaabb1 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -301,10 +301,13 @@ static void unmap_direct_mr(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_direct
>         sg_free_table(&mr->sg_head);
>  }
>
> -static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 =
size, u8 perm,
> +static int add_direct_chain(struct mlx5_vdpa_dev *mvdev,
> +                           struct mlx5_vdpa_mr *mr,
> +                           u64 start,
> +                           u64 size,
> +                           u8 perm,
>                             struct vhost_iotlb *iotlb)
>  {
> -       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         struct mlx5_vdpa_direct_mr *dmr;
>         struct mlx5_vdpa_direct_mr *n;
>         LIST_HEAD(tmp);
> @@ -354,9 +357,10 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mv=
dev, u64 start, u64 size, u8
>   * indirect memory key that provides access to the enitre address space =
given
>   * by iotlb.
>   */
> -static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotl=
b *iotlb)
> +static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
> +                         struct mlx5_vdpa_mr *mr,
> +                         struct vhost_iotlb *iotlb)
>  {
> -       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         struct mlx5_vdpa_direct_mr *dmr;
>         struct mlx5_vdpa_direct_mr *n;
>         struct vhost_iotlb_map *map;
> @@ -384,7 +388,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb
>                                                                        LO=
G_MAX_KLM_SIZE);
>                                         mr->num_klms +=3D nnuls;
>                                 }
> -                               err =3D add_direct_chain(mvdev, ps, pe - =
ps, pperm, iotlb);
> +                               err =3D add_direct_chain(mvdev, mr, ps, p=
e - ps, pperm, iotlb);
>                                 if (err)
>                                         goto err_chain;
>                         }
> @@ -393,7 +397,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb
>                         pperm =3D map->perm;
>                 }
>         }
> -       err =3D add_direct_chain(mvdev, ps, pe - ps, pperm, iotlb);
> +       err =3D add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
>         if (err)
>                 goto err_chain;
>
> @@ -489,13 +493,8 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mv=
dev, struct mlx5_vdpa_mr *mr
>         }
>  }
>
> -static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned =
int asid)
> +static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
>  {
> -       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> -
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> -               return;
> -
>         if (!mr->initialized)
>                 return;
>
> @@ -507,38 +506,33 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_=
dev *mvdev, unsigned int asid
>         mr->initialized =3D false;
>  }
>
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid=
)
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> +                         struct mlx5_vdpa_mr *mr)
>  {
> -       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> -
>         mutex_lock(&mr->mkey_mtx);
>
> -       _mlx5_vdpa_destroy_mr(mvdev, asid);
> +       _mlx5_vdpa_destroy_mr(mvdev, mr);
>
>         mutex_unlock(&mr->mkey_mtx);
>  }
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> -       mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]);
> +       mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
>         prune_iotlb(mvdev);
>  }
>
>  static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> -                               struct vhost_iotlb *iotlb,
> -                               unsigned int asid)
> +                               struct mlx5_vdpa_mr *mr,
> +                               struct vhost_iotlb *iotlb)
>  {
> -       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         int err;
>
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> -               return 0;
> -
>         if (mr->initialized)
>                 return 0;
>
>         if (iotlb)
> -               err =3D create_user_mr(mvdev, iotlb);
> +               err =3D create_user_mr(mvdev, mr, iotlb);
>         else
>                 err =3D create_dma_mr(mvdev, mr);
>
> @@ -550,13 +544,14 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_de=
v *mvdev,
>         return 0;
>  }
>
> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> -                       unsigned int asid)
> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> +                       struct mlx5_vdpa_mr *mr,
> +                       struct vhost_iotlb *iotlb)
>  {
>         int err;
>
>         mutex_lock(&mvdev->mr.mkey_mtx);
> -       err =3D _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
> +       err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
>         mutex_unlock(&mvdev->mr.mkey_mtx);
>         return err;
>  }
> @@ -574,7 +569,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mv=
dev, struct vhost_iotlb *io
>                 *change_map =3D true;
>         }
>         if (!*change_map)
> -               err =3D _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
> +               err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
>         mutex_unlock(&mr->mkey_mtx);
>
>         return err;
> @@ -603,7 +598,7 @@ int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvd=
ev)
>  {
>         int err;
>
> -       err =3D mlx5_vdpa_create_mr(mvdev, NULL, 0);
> +       err =3D mlx5_vdpa_create_mr(mvdev, &mvdev->mr, NULL);
>         if (err)
>                 return err;
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ab196c43694c..256fdd80c321 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2644,8 +2644,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>                 goto err_mr;
>
>         teardown_driver(ndev);
> -       mlx5_vdpa_destroy_mr(mvdev, asid);
> -       err =3D mlx5_vdpa_create_mr(mvdev, iotlb, asid);
> +       mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
> +       err =3D mlx5_vdpa_create_mr(mvdev, &mvdev->mr, iotlb);
>         if (err)
>                 goto err_mr;
>
> @@ -2660,7 +2660,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>         return 0;
>
>  err_setup:
> -       mlx5_vdpa_destroy_mr(mvdev, asid);
> +       mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
>  err_mr:
>         return err;
>  }
> @@ -2878,6 +2878,9 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>         bool change_map;
>         int err;
>
> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> +               goto end;
> +
>         err =3D mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map, asid)=
;
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
> @@ -2890,6 +2893,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>                         return err;
>         }
>
> +end:
>         return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
>  }
>
> --
> 2.41.0
>

