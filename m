Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD447B8AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjJDSmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjJDSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE9AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696444906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lZ2egGQBbcF97lVQuFyfsiPDnlusrcGkCa8ORctDxs=;
        b=bsUbZUYgONSlD37ArelTxDjanAMcjDC7wFXQT3tTx2ejj0wpSornxRPzu4HKUVRPplijQw
        Xmn9cmXlRAlYnb+2j8OdhnElCZK8tSx4vLVD5EICXdezQFWer1NRt8srSIe1ngt8bvMhBH
        HY/20535sDZvwDP9OZzcHUu1fGbTF7w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-5kAbfJj3P9yuyydjcHh5vg-1; Wed, 04 Oct 2023 14:41:44 -0400
X-MC-Unique: 5kAbfJj3P9yuyydjcHh5vg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-59f4f2b6de8so1385647b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444904; x=1697049704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lZ2egGQBbcF97lVQuFyfsiPDnlusrcGkCa8ORctDxs=;
        b=AC0SFDCJP6y4SAuCwJH1HkHWuiSTADMmH2GO2hyDcDn9J4sGkRO79njbagzeA0B0is
         fbB5LhH4WXWOiBijHqqAbBX5INKLfJJky8DiSGoelt7xy3BUTB5KHUkKyc8PyYyObpD5
         VzjvK3oZBaGqJspOIbD3SKlRBdvYm+C4L4RFPXoK2MikkUWDBVzFCGPN2mMRT2upGHvC
         QWdAmqOp9jwIiE4l/7zTPTCVhFnq7oAlNOWlRa2+uJgCuFQzcR8yNSzNlFutiAQaGiL0
         /zkJ6C2A+wMNpQwrv+4Shsdbi0HsMf+CBaOnkCYfjC/daHSZzkwjQgS+JtxC/eWaJZJl
         narw==
X-Gm-Message-State: AOJu0YwXj1OB7cAqThTXvvZZPDORqPi1yG3zOlBXLZMzlrgf9xgmZCAr
        /rFEib2nZJgH0Ioe/YGTtYPG7OV6ytqi6fbcE/4lOUHHOVRalctw17KER6bgNkLBSU3oMO/zs4V
        SrSN10HHo1R9OxRl6UZzSd21n12QkDv6BoAIlJV4w
X-Received: by 2002:a0d:dc81:0:b0:589:e7c1:96f2 with SMTP id f123-20020a0ddc81000000b00589e7c196f2mr3424844ywe.46.1696444904308;
        Wed, 04 Oct 2023 11:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxS9zwA0GdQGmLVscqb5Ba3h01njQeJpCNnDcvKpe7SmDYwH55bsnzSh01dmXF63wHa287Zx9v8Y0j6ldXVo=
X-Received: by 2002:a0d:dc81:0:b0:589:e7c1:96f2 with SMTP id
 f123-20020a0ddc81000000b00589e7c196f2mr3424834ywe.46.1696444904064; Wed, 04
 Oct 2023 11:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-10-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-10-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:41:08 +0200
Message-ID: <CAJaqyWc7riwHv0KeEtE4c24RYFEwzYoE-eAtMw+AHzizgCb7Ng@mail.gmail.com>
Subject: Re: [PATCH vhost 08/16] vdpa/mlx5: Collapse "dvq" mr add/delete functions
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
> Now that the cvq code is out of mlx5_vdpa_create/destroy_mr, the "dvq"
> functions can be folded into their callers.
>
> Having "dvq" in the naming will no longer be accurate in the downstream
> patches.
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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

