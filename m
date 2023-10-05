Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B37BA12F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbjJEOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbjJEOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A4A5DC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696515378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClDofcbj9vsYfkW4ByW2z4aNE9wUzj12hft8TEwg9yg=;
        b=WzG8q+Uu001VhNRi4hUI6MfpYg08oqPonra1BBLvKBuTStNlcxz3ISmoC6wCZigm8gQnHp
        UJsM7Lr1u7EY/YWR2tgRhQxSeGVjSsXW4lCjtebA9BoaNGP+qPa3NUnzJiqrwNoLV9vT/8
        le+bP6PUov7AnxVgTGMq7qypm7rG5qA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-Vijxw_ZAOCehVDSq0Pnvpw-1; Thu, 05 Oct 2023 06:15:07 -0400
X-MC-Unique: Vijxw_ZAOCehVDSq0Pnvpw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-59ee66806d7so10976797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500907; x=1697105707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClDofcbj9vsYfkW4ByW2z4aNE9wUzj12hft8TEwg9yg=;
        b=KwbLly89ElpuH8Dacy17niGD3puxLqRi5yOEhABBLYGGBZBY1novbe5GKYiBAHXpQn
         MERXPa8cuAjxYMXM7gJtrJw5U+QOoks0VavM6tj3lw3wZl8bpZstLiqrnHuB19qS9m0q
         SbQzeMV5TSkqIVfkJwhTECOYZaW5L7mR3QrR8/fDY3WDSLFyjsR54AIAxJ6eEZDT2pMk
         oJQ6xX8pf81sGPhdgphVTrVfAOZ3rbv875GDWZ4UcxFZ/MaCCs7qA62lTJAbqtJ1Z4E7
         ZE8XSUWXqahhSUL22a2C2j53quulDo6fQHXP1ttFE+5trSYR8z/QzqkH5bgfQQ7/wGVd
         edsQ==
X-Gm-Message-State: AOJu0YwoNeMrr8X9HL53HisOh5rGIdRL7Deo15hD789zNCP+ypnvmsQs
        7FNLMtV2SdwfRwFW+lhzr/de8s7Z7gl3eq0nK+TVRfVJS8YwxBk7g727prfRXH9ggtiQxORJO8P
        REwbFpFqm/3nhB8EVb3U1ZbagYoDGPt9ulImOjIC/
X-Received: by 2002:a81:8683:0:b0:589:8b55:fe09 with SMTP id w125-20020a818683000000b005898b55fe09mr4483866ywf.50.1696500907374;
        Thu, 05 Oct 2023 03:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9gJrhBi3ZcWHoi3L4zLNSc38QicHPHwJrzNd70JDsN++xuwI6pQ0kSifa28XL/vcC/ya2eRslFQc94XXld5A=
X-Received: by 2002:a81:8683:0:b0:589:8b55:fe09 with SMTP id
 w125-20020a818683000000b005898b55fe09mr4483849ywf.50.1696500907113; Thu, 05
 Oct 2023 03:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-17-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-17-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 5 Oct 2023 12:14:30 +0200
Message-ID: <CAJaqyWe2btM+8Hbnq9ROyh-bhQA5vVwNk9xgSHb_gFme9dJViw@mail.gmail.com>
Subject: Re: [PATCH vhost 15/16] vdpa/mlx5: Make iotlb helper functions more generic
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
> They will be used in a followup patch.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 3dee6d9bed6b..a4135c16b5bf 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -454,20 +454,20 @@ static void destroy_dma_mr(struct mlx5_vdpa_dev *mv=
dev, struct mlx5_vdpa_mr *mr)
>         mlx5_vdpa_destroy_mkey(mvdev, mr->mkey);
>  }
>
> -static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *sr=
c)
> +static int dup_iotlb(struct vhost_iotlb *iotlb, struct vhost_iotlb *src)

It would be great to move this patch to vhost/iotlb, especially
because it can be reused by vdpa_sim. But it can be done on top for
sure,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  {
>         struct vhost_iotlb_map *map;
>         u64 start =3D 0, last =3D ULLONG_MAX;
>         int err;
>
>         if (!src) {
> -               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, start, la=
st, start, VHOST_ACCESS_RW);
> +               err =3D vhost_iotlb_add_range(iotlb, start, last, start, =
VHOST_ACCESS_RW);
>                 return err;
>         }
>
>         for (map =3D vhost_iotlb_itree_first(src, start, last); map;
>                 map =3D vhost_iotlb_itree_next(map, start, last)) {
> -               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, map->star=
t, map->last,
> +               err =3D vhost_iotlb_add_range(iotlb, map->start, map->las=
t,
>                                             map->addr, map->perm);
>                 if (err)
>                         return err;
> @@ -475,9 +475,9 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, str=
uct vhost_iotlb *src)
>         return 0;
>  }
>
> -static void prune_iotlb(struct mlx5_vdpa_dev *mvdev)
> +static void prune_iotlb(struct vhost_iotlb *iotlb)
>  {
> -       vhost_iotlb_del_range(mvdev->cvq.iotlb, 0, ULLONG_MAX);
> +       vhost_iotlb_del_range(iotlb, 0, ULLONG_MAX);
>  }
>
>  static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdp=
a_mr *mr)
> @@ -544,7 +544,7 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_=
dev *mvdev)
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
>                 mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
>
> -       prune_iotlb(mvdev);
> +       prune_iotlb(mvdev->cvq.iotlb);
>  }
>
>  static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -596,8 +596,8 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *=
mvdev,
>
>         spin_lock(&mvdev->cvq.iommu_lock);
>
> -       prune_iotlb(mvdev);
> -       err =3D dup_iotlb(mvdev, iotlb);
> +       prune_iotlb(mvdev->cvq.iotlb);
> +       err =3D dup_iotlb(mvdev->cvq.iotlb, iotlb);
>
>         spin_unlock(&mvdev->cvq.iommu_lock);
>
> --
> 2.41.0
>

