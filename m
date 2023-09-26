Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768D47AE439
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjIZDez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIZDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910EDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695699240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VemcH0Pxc7gzhy8cLvwCxUH2+uz/mp+txw8hIJIiBPM=;
        b=IJj32r9wU3CCU8E+GIZ9uT6BBbnh1rkqi6MpvSEbhGrqCMpt7Toee/PaxsuNI+9R81tSpB
        bWPsjqJkDbGzWs1F78QIhkO9Tq1LdR+4I7EdeG+ImNZVvaVRU1im1VVOGpvGmyapoobR8U
        SyKjhljrfVL2dSL5nZad1bnj3HcAFoU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-5Vck-DXDPlWS-GoGrV7D1Q-1; Mon, 25 Sep 2023 23:33:58 -0400
X-MC-Unique: 5Vck-DXDPlWS-GoGrV7D1Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5043c463bf9so8904711e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695699237; x=1696304037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VemcH0Pxc7gzhy8cLvwCxUH2+uz/mp+txw8hIJIiBPM=;
        b=fS/DDlWNFbSee8bdkffHC6o+Tfsv4zbMlXUuuw43c/5IbEI3OogygGvpvKWHMRXq3I
         8ixy5UoINpGD7eMyk5S0UjLbDIOowN7GVSV/+ZQUbFQpw1Ts0SwGWJ+b7r1KfcokQ38e
         Iu0EEweR80zBobSuxCyeGkB3TAxUh/po7F/lxONotZrprD7a1VH4jai4tintSAGpF757
         e1BM3WAd54u+AY4vmVPs6mlIV9CyyEEY5wOtZLa+A0Bu1f8dxXlFobpXRDEhAb61f9rs
         j0nldrF47skg1PkanC/Eg0o+tYc1irEFlv68GJ99m3W/VV+W87mdlcB0nQHtRibilIKE
         NpQQ==
X-Gm-Message-State: AOJu0YwR0E/X9Ut4XzSPVxCndQJU9TXToukAKl3aqDYzfi8tOdmzs+Hj
        noiGn3wwyvf/cujwjUxB9nG4CtTKZBZAP//4T32SJ0Nm/ozoGDnBLomwll3J4mGAhnm+wz/+hrC
        40TUFjm7l1qM9KOXZqc4TPeiM3rO9ojcSPWUaAdVRgnbq5YjRlFozhg==
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id k42-20020a0565123daa00b005031adfb4d5mr8636661lfv.52.1695699236795;
        Mon, 25 Sep 2023 20:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxKhnIjCY2u75vQcX2wF3cjPA5sZgxKb74ILugVtiuipD5V5dNcKckwfV7TbxCYM65s77akemf8UqWtEbv3E=
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8636648lfv.52.1695699236445; Mon, 25
 Sep 2023 20:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com> <20230912130132.561193-8-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-8-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 11:33:45 +0800
Message-ID: <CACGkMEuC+TrrZ-=63XpFySzcvHYD+0YyJxF9ckx7ZSJqSS0JOw@mail.gmail.com>
Subject: Re: [PATCH 07/16] vdpa/mlx5: Collapse "dvq" mr add/delete functions
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:02=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Now that the cvq code is out of mlx5_vdpa_create/destroy_mr, the "dvq"
> functions can be folded into their callers.
>
> Having "dvq" in the naming will no longer be accurate in the downstream
> patches.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/core/mr.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 587300e7c18e..fde00497f4ad 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -489,7 +489,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvd=
ev, struct mlx5_vdpa_mr *mr
>         }
>  }
>
> -static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsig=
ned int asid)
> +static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned =
int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>
> @@ -513,7 +513,7 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *=
mvdev, unsigned int asid)
>
>         mutex_lock(&mr->mkey_mtx);
>
> -       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> +       _mlx5_vdpa_destroy_mr(mvdev, asid);
>
>         mutex_unlock(&mr->mkey_mtx);
>  }
> @@ -524,9 +524,9 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev=
)
>         prune_iotlb(mvdev);
>  }
>
> -static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> -                                   struct vhost_iotlb *iotlb,
> -                                   unsigned int asid)
> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb,
> +                               unsigned int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         int err;
> @@ -550,12 +550,6 @@ static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa=
_dev *mvdev,
>         return 0;
>  }
>
> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> -                               struct vhost_iotlb *iotlb, unsigned int a=
sid)
> -{
> -       return _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> -}
> -
>  int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
>                         unsigned int asid)
>  {
> --
> 2.41.0
>

