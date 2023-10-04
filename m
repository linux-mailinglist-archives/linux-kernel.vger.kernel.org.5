Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C287B8B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbjJDSrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjJDSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109AC4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696445207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu7Adfi+wQnG7tfVEgDQ9vAoZp+2N/oHsk4FrBvyfe8=;
        b=LOByYhrSYyNZmHm/NDgGx2VR8BiAtqdIdsJz0Xjc0k2zbQOaAr1QRGRXPLWxcUfUdMDvGB
        0eMqObvv0yGI3qn760IGymXmOF+51H3vBqm27ilfL3rpw4ihfLC0ytjIpJmmyLa5aP1J1g
        q4BO5JHqkn2emH7ZGAaMeCwpTQOZgJ4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-q7pG3o3INZy8eSg9JSigRg-1; Wed, 04 Oct 2023 14:46:45 -0400
X-MC-Unique: q7pG3o3INZy8eSg9JSigRg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a507eb61a6so1104137b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445205; x=1697050005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu7Adfi+wQnG7tfVEgDQ9vAoZp+2N/oHsk4FrBvyfe8=;
        b=IXfCquY5VNyC4ulDhl00Cy6jfzmFZDGRkuoatuxo0Cq94ww2ZAoIEy7PJye1GnrR6g
         LhVPn0Dfs+u1YOK2ac/wqekSJW4BM0wIYNUVdgeCE++ViL+Cb/VFIeM3Is0CYayHl0yS
         oGAOO72z2V+pMJlcbxE8fhRJgiOGsaG/5AqJ5YVd86l5mqjqsgA8Js/TY/pFV0UamtIU
         wn8pD+qjfP1WT/6uY8Jxzko+MYt0lwzvnwVKxf5QHMB6T/OGGUTiSGgtn54LPzyyiLFV
         zqu++DP5PFEFkPDfzLzOyBBJdVSz94OarYg4uU4F3wnWpzeoWOiFsoLSg63lYwEura8X
         OZhg==
X-Gm-Message-State: AOJu0YytI6xgkq8hbueQt/cBvV/JL5/6IjrGMAZxY2dRaP9pR9be8S4g
        yv2bju+fVVYNl2X3Pv7xLq/U2J+j3qM/zNnRjmsd6GZPPzB2lx3Sc+hUM3O1QnJAWnomze9os/9
        sM7tVTG0RPB2/1SHXxqFUQnPHv+c8CRkE9I24hw6+hyeKKop4lAw=
X-Received: by 2002:a0d:cf01:0:b0:59b:54b5:7d66 with SMTP id r1-20020a0dcf01000000b0059b54b57d66mr3403517ywd.34.1696445205331;
        Wed, 04 Oct 2023 11:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElJ6sW06IZ+dWxwgtzClPHsJplFgYYoQYMfzzLLYu1PLRtqJbKxKBg3eFD5/Sl8KrkCOSEvk2iNEBDCqB+GNI=
X-Received: by 2002:a0d:cf01:0:b0:59b:54b5:7d66 with SMTP id
 r1-20020a0dcf01000000b0059b54b57d66mr3403497ywd.34.1696445205078; Wed, 04 Oct
 2023 11:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-13-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-13-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:46:09 +0200
Message-ID: <CAJaqyWdJ229FnDLafQ0tA-JrPGivFX00TpjCemiOUX4X1gU2tg@mail.gmail.com>
Subject: Re: [PATCH vhost 11/16] vdpa/mlx5: Move mr mutex out of mr struct
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
> The mutex is named like it is supposed to protect only the mkey but in
> reality it is a global lock for all mr resources.
>
> Shift the mutex to it's rightful location (struct mlx5_vdpa_dev) and
> give it a more appropriate name.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++--
>  drivers/vdpa/mlx5/core/mr.c        | 13 +++++++------
>  drivers/vdpa/mlx5/core/resources.c |  6 +++---
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 01d4ee58ccb1..9c6ac42c21e1 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -34,8 +34,6 @@ struct mlx5_vdpa_mr {
>         /* state of dvq mr */
>         bool initialized;
>
> -       /* serialize mkey creation and destruction */
> -       struct mutex mkey_mtx;
>         bool user_mr;
>  };
>
> @@ -94,6 +92,8 @@ struct mlx5_vdpa_dev {
>         u32 generation;
>
>         struct mlx5_vdpa_mr mr;
> +       /* serialize mr access */
> +       struct mutex mr_mtx;
>         struct mlx5_control_vq cvq;
>         struct workqueue_struct *wq;
>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 6f29e8eaabb1..abd6a6fb122f 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -509,11 +509,11 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_=
dev *mvdev, struct mlx5_vdpa_
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
>                           struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mr->mkey_mtx);
> +       mutex_lock(&mvdev->mr_mtx);
>
>         _mlx5_vdpa_destroy_mr(mvdev, mr);
>
> -       mutex_unlock(&mr->mkey_mtx);
> +       mutex_unlock(&mvdev->mr_mtx);
>  }
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
> @@ -550,9 +550,10 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>  {
>         int err;
>
> -       mutex_lock(&mvdev->mr.mkey_mtx);
> +       mutex_lock(&mvdev->mr_mtx);
>         err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
> -       mutex_unlock(&mvdev->mr.mkey_mtx);
> +       mutex_unlock(&mvdev->mr_mtx);
> +
>         return err;
>  }
>
> @@ -563,14 +564,14 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *=
mvdev, struct vhost_iotlb *io
>         int err =3D 0;
>
>         *change_map =3D false;
> -       mutex_lock(&mr->mkey_mtx);
> +       mutex_lock(&mvdev->mr_mtx);
>         if (mr->initialized) {
>                 mlx5_vdpa_info(mvdev, "memory map update\n");
>                 *change_map =3D true;
>         }
>         if (!*change_map)
>                 err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
> -       mutex_unlock(&mr->mkey_mtx);
> +       mutex_unlock(&mvdev->mr_mtx);
>
>         return err;
>  }
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index d5a59c9035fb..5c5a41b64bfc 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -256,7 +256,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>                 mlx5_vdpa_warn(mvdev, "resources already allocated\n");
>                 return -EINVAL;
>         }
> -       mutex_init(&mvdev->mr.mkey_mtx);
> +       mutex_init(&mvdev->mr_mtx);
>         res->uar =3D mlx5_get_uars_page(mdev);
>         if (IS_ERR(res->uar)) {
>                 err =3D PTR_ERR(res->uar);
> @@ -301,7 +301,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>  err_uctx:
>         mlx5_put_uars_page(mdev, res->uar);
>  err_uars:
> -       mutex_destroy(&mvdev->mr.mkey_mtx);
> +       mutex_destroy(&mvdev->mr_mtx);
>         return err;
>  }
>
> @@ -318,6 +318,6 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *m=
vdev)
>         dealloc_pd(mvdev, res->pdn, res->uid);
>         destroy_uctx(mvdev, res->uid);
>         mlx5_put_uars_page(mvdev->mdev, res->uar);
> -       mutex_destroy(&mvdev->mr.mkey_mtx);
> +       mutex_destroy(&mvdev->mr_mtx);
>         res->valid =3D false;
>  }
> --
> 2.41.0
>

