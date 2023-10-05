Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECCF7BA22E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjJEPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJEPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F56B6FC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696517049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVoRkgGhmUcJwfA+XnKJYzROkSlzRQyAzzwt0PEOhp4=;
        b=T86AB2aDNqhHxLQBkqWyg90tE+7hSClBrDCRfAa6ycXKXtMh/e68IEkNS+0CYRS2lDeWEM
        jdC7IuQNj1xOawQnSsV8mTC37NeiEKG9e/gXamSP3Mq4Gn4zKdLNDIybmDbWJYNJW0ZDdi
        WTOpqmnoze3Sd/TZyV/T9x17ZNzMHyw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-6a4xnvTCNvOorcmvNYJhFw-1; Thu, 05 Oct 2023 06:42:25 -0400
X-MC-Unique: 6a4xnvTCNvOorcmvNYJhFw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a22029070bso10567167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502544; x=1697107344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVoRkgGhmUcJwfA+XnKJYzROkSlzRQyAzzwt0PEOhp4=;
        b=RaOa3adBfX4CFPPnPwXcQxqZ9hc+MF/1tM7F12qesxKypFI4uSSuWybm8c9HdKrtin
         w8vdvnc66Y2UJe1LVh+xRiXeJLmWHb86SCy89wJ0m71nffn/69cW943YANxgg3zB2JjF
         Y1K0O34Rhwp0Z0YusMA11VBM+z8jdS/gFA0CEcQl1WwozHeSajntJM2YReS8UMHv3hge
         VTutBZY6UAMdxeLC8ysbOX4/cMQ7OjK8acQNgsPv5H3NWRMO/owpMhmrE4/nwnEauaXT
         QUxMr3kfzS9OT39/bzx0K1FO0fsWd0absda1dIWG+2MwMDV/BRD8MRYBViaf/rdODoJZ
         dYGA==
X-Gm-Message-State: AOJu0YwivmzLcGqV7dBhBWeNEtogvPvahVJ+EAZPjZVNDCF7WFBN0u0F
        kfOp5p1xuOj5EvguvZrL+TdtEPBvwcCMTDMMgwJvr+f67+RvpNMwr7h0nCHvFejEoCBSzgceQhL
        ZlNxc4Qfd+GePmzNxTu2mLKSdZQIoZl/6dKklmEsU
X-Received: by 2002:a81:840e:0:b0:589:ca07:c963 with SMTP id u14-20020a81840e000000b00589ca07c963mr5237161ywf.42.1696502544468;
        Thu, 05 Oct 2023 03:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbE0NNvKOgvHC7Av0Oy453lyO3cTTL4OgJznAYB4cPWRliMgoZbdPAxILUssafjugHMsSjdfsuwBx43rlAGK4=
X-Received: by 2002:a81:840e:0:b0:589:ca07:c963 with SMTP id
 u14-20020a81840e000000b00589ca07c963mr5237154ywf.42.1696502544213; Thu, 05
 Oct 2023 03:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-18-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-18-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 5 Oct 2023 12:41:48 +0200
Message-ID: <CAJaqyWe9iYnh_DwZbU4986bSAZ0C1=Y9Th6-vv_ZRTTYwQqhYA@mail.gmail.com>
Subject: Re: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID change
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     gal@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> For the following sequence:
> - cvq group is in ASID 0
> - .set_map(1, cvq_iotlb)
> - .set_group_asid(cvq_group, 1)
>
> ... the cvq mapping from ASID 0 will be used. This is not always correct
> behaviour.
>
> This patch adds support for the above mentioned flow by saving the iotlb
> on each .set_map and updating the cvq iotlb with it on a cvq group change=
.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
>  drivers/vdpa/mlx5/core/mr.c        | 26 ++++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  9 ++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index ae09296f4270..db988ced5a5d 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -32,6 +32,8 @@ struct mlx5_vdpa_mr {
>         unsigned long num_directs;
>         unsigned long num_klms;
>
> +       struct vhost_iotlb *iotlb;
> +
>         bool user_mr;
>  };
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index a4135c16b5bf..403c08271489 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -499,6 +499,8 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_de=
v *mvdev, struct mlx5_vdpa_
>                 destroy_user_mr(mvdev, mr);
>         else
>                 destroy_dma_mr(mvdev, mr);
> +
> +       vhost_iotlb_free(mr->iotlb);
>  }
>
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -558,6 +560,30 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev=
 *mvdev,
>         else
>                 err =3D create_dma_mr(mvdev, mr);
>
> +       if (err)
> +               return err;
> +
> +       mr->iotlb =3D vhost_iotlb_alloc(0, 0);
> +       if (!mr->iotlb) {
> +               err =3D -ENOMEM;
> +               goto err_mr;
> +       }
> +
> +       err =3D dup_iotlb(mr->iotlb, iotlb);
> +       if (err)
> +               goto err_iotlb;
> +
> +       return 0;
> +
> +err_iotlb:
> +       vhost_iotlb_free(mr->iotlb);
> +
> +err_mr:
> +       if (iotlb)
> +               destroy_user_mr(mvdev, mr);
> +       else
> +               destroy_dma_mr(mvdev, mr);
> +
>         return err;
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 46441e41892c..fc5d6b989a5a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3154,12 +3154,19 @@ static int mlx5_set_group_asid(struct vdpa_device=
 *vdev, u32 group,
>                                unsigned int asid)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +       int err =3D 0;
>
>         if (group >=3D MLX5_VDPA_NUMVQ_GROUPS || asid >=3D MLX5_VDPA_NUM_=
AS)
>                 return -EINVAL;
>
>         mvdev->group2asid[group] =3D asid;
> -       return 0;
> +
> +       mutex_lock(&mvdev->mr_mtx);
> +       if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mr[asid])
> +               err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mr[asid]=
->iotlb, asid);

Do we need to protect here in case userspace sets the same ASID twice?
mlx5_vdpa_update_cvq_iotlb shouldn't call dup_iotlb with the same src
and dst.

Apart from that:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +       mutex_unlock(&mvdev->mr_mtx);
> +
> +       return err;
>  }
>
>  static const struct vdpa_config_ops mlx5_vdpa_ops =3D {
> --
> 2.41.0
>

