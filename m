Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA47AE3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIZDMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIZDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FDDA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695697902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBsDTuplom88hCQIlxCCgcKGJXWlSC24YB3TjkgTh+4=;
        b=Fz5KTfPwwf+DM1nhbwUvTDN6Lp+0p51TdVnZWN80C+b+A+gyv9589nIGH0HfSTXfKqIAph
        I5HhTDuUHG+qv1+wgH/iHVBSpL3uBEh+EKINSNV0/zlO/QigE+RSU65nf/Q2F7RBPgUeCT
        LF27RD/u9ZBt/UgorUofEAaN4fr1qxg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ZiJ-p04IP-mnxp3FbnBHLw-1; Mon, 25 Sep 2023 23:11:40 -0400
X-MC-Unique: ZiJ-p04IP-mnxp3FbnBHLw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5041ae34ce4so10584285e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697899; x=1696302699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBsDTuplom88hCQIlxCCgcKGJXWlSC24YB3TjkgTh+4=;
        b=xVVYzsBgSBQgX+v45xSwCNGQhsD4ibOrOCVNtQYkfkDU+uc8te0DVPHjF3wGTd6P+d
         S8RWoWFDqvDJuzb1e+QGHgWAlUi5LHMCmxxLleFrqjWkO2G//UR/sRzH5d+GLXQ4Pgp6
         7FoVKqeb5S7n5JVYR9SUe4BcgbzVVDkI6PHVnS5YzaNXV11dzsMEEUeJv7jdzE5UEAxT
         /2CLESiid7xrgqYBzbTRBbBNNzvPIMIAot7ZF4d/BouZYV44iIilEcRsfIILSuQ73ihg
         szOYFM1oYHrBDyUtUpGIZhuvzf+ipdqEUfUv+jdHYAdbzV10Lbnb/SZHzkapkokCHSxu
         4dFg==
X-Gm-Message-State: AOJu0YyG1L7ecCcQZnSJ3uWjR67yRJzysP6yl985bG8E0rEl7d5Wf8xS
        goEQ1jqXo5BXuT6mHIxNfqrKdfoz0qoKsx6rNGF0X14u5Of+8na2ymhdn13twvcmqflSF7KsnrQ
        IfF4lpK6hPPM+wFaSmznfB1hYeHxQJlS/ctv7798Z
X-Received: by 2002:a05:6512:3e05:b0:504:2730:40cc with SMTP id i5-20020a0565123e0500b00504273040ccmr8911194lfv.49.1695697899487;
        Mon, 25 Sep 2023 20:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBQbSSgxiCAy9e7onyFmLeQjkVxkYaQmAu8X+NVidEWYPOjlAADezTJxFA+1jgzt9fmsEBXQrsZci7djKN2A=
X-Received: by 2002:a05:6512:3e05:b0:504:2730:40cc with SMTP id
 i5-20020a0565123e0500b00504273040ccmr8911175lfv.49.1695697899185; Mon, 25 Sep
 2023 20:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com> <20230912130132.561193-5-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-5-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 11:11:28 +0800
Message-ID: <CACGkMEsbCwBuES7G+Gam4gpLEbJJZinp8ZhAQkLLBrtLMBbbxQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] vdpa/mlx5: Create helper function for dma mappings
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:02=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Necessary for upcoming cvq separation from mr allocation.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>  drivers/vdpa/mlx5/core/mr.c        | 5 +++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 4 ++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index ca56242972b3..3748f027cfe9 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -120,6 +120,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, =
struct vhost_iotlb *iotlb,
>                         unsigned int asid);
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
>  void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int=
 asid);
> +int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
>
>  #define mlx5_vdpa_warn(__dev, format, ...)                              =
                           \
>         dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format=
, __func__, __LINE__,     \
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 5a1971fcd87b..7bd0883b8b25 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -619,3 +619,8 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mv=
dev, struct vhost_iotlb *io
>
>         return err;
>  }
> +
> +int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
> +{
> +       return mlx5_vdpa_create_mr(mvdev, NULL, 0);
> +}
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 37be945a0230..d34c19b4e139 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2836,7 +2836,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>         ++mvdev->generation;
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> -               if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
> +               if (mlx5_vdpa_create_dma_mr(mvdev))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
>         }
>         up_write(&ndev->reslock);
> @@ -3441,7 +3441,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 goto err_mpfs;
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> -               err =3D mlx5_vdpa_create_mr(mvdev, NULL, 0);
> +               err =3D mlx5_vdpa_create_dma_mr(mvdev);
>                 if (err)
>                         goto err_res;
>         }
> --
> 2.41.0
>

