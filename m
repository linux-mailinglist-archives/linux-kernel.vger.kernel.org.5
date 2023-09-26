Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413627AE435
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjIZDeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B6C9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695699200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJajdCncSMr7ZiqVnyceQ22WaLa+UzWhCY/lPANEMZs=;
        b=Uts2QJIUEu7opgPoemUJeHq6bmkEVxldeT+/2p9EKDoKwgpYDcAtJBzXQsqxdR0obOKVg8
        o+lq2VBIfXhtmKXvcZqXQ4HY3JbwR8K8uBc1dZwMldbsLXUSfGAqVz0nl9c6z4vcAkqUEh
        S/i+P4w3DB545zOUMTgGIhFDgHlMLfs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-1ANg1V-HOZSArsdLendE5A-1; Mon, 25 Sep 2023 23:33:18 -0400
X-MC-Unique: 1ANg1V-HOZSArsdLendE5A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5043c0cbb62so8937616e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695699197; x=1696303997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJajdCncSMr7ZiqVnyceQ22WaLa+UzWhCY/lPANEMZs=;
        b=TUUWRMK1zHvP8nQTJfznL1mLC3PofXD80mL3H/WuQW0Loomt/M09v0sQv6fC9Ris28
         POMumHfwB+2fD4UL/Urx/pM6F0kBL712NBlEM1enYLzlZtFxrRVXsCsevIesHFftgZMm
         6bMN3IiIR6XaS/JRqCLt78Tur6MYtIOTiSaBjlBEtAnRnLXHe8UdY1/ukA6sXSjc2V/M
         zaWrDKjvAwh4ZYuewKzjB6WLx6QNduIge60nRm5+BVu7eWnzHVncWPMvSt5l3PO2Nx8w
         OPuPIf0qFnUUqEw/6aplSjjHvA/V07jvqJ6dj9ECT2r8xM9KMdFtRBR2idbnCdQJRhK7
         +iZg==
X-Gm-Message-State: AOJu0Yy2pRZz+sILWiWU6KVBxgCZNR4KlXVygqkkVTceyMTyhQ3Q89nX
        geQCS8ZHmyNfi35IaOD7tdgHumxaY9IUAuMcoLqWiCGBbMcACBSWaamj+kN2vjzpcKkHJQqSLNz
        X0MSCQ8eflde2l/6xe3ZGzAZ7d2V3SJ3TzFlWxa3u
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id m2-20020a056512358200b004fb76751c16mr6143404lfr.49.1695699197428;
        Mon, 25 Sep 2023 20:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IUSLrpbg7ATZw7UjipL9J+f0jI6j6UhxJvO4Obqb5zgvMY53uGnraEAY/6btCcjutBxYmcv45efC8Qi2mZI=
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id
 m2-20020a056512358200b004fb76751c16mr6143395lfr.49.1695699197146; Mon, 25 Sep
 2023 20:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com> <20230912130132.561193-7-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-7-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 11:33:06 +0800
Message-ID: <CACGkMEsXQQoQ3eg6XxcS6FLZ3qgZ9phBR714r8OYqKs1Z26sCw@mail.gmail.com>
Subject: Re: [PATCH 06/16] vdpa/mlx5: Take cvq iotlb lock during refresh
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 9:02=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The reslock is taken while refresh is called but iommu_lock is more
> specific to this resource. So take the iommu_lock during cvq iotlb
> refresh.
>
> Based on Eugenio's patch [0].
>
> [0] https://lore.kernel.org/lkml/20230112142218.725622-4-eperezma@redhat.=
com/
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/core/mr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index fcb6ae32e9ed..587300e7c18e 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -590,11 +590,19 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev=
 *mvdev,
>                                 struct vhost_iotlb *iotlb,
>                                 unsigned int asid)
>  {
> +       int err;
> +
>         if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
>                 return 0;
>
> +       spin_lock(&mvdev->cvq.iommu_lock);
> +
>         prune_iotlb(mvdev);
> -       return dup_iotlb(mvdev, iotlb);
> +       err =3D dup_iotlb(mvdev, iotlb);
> +
> +       spin_unlock(&mvdev->cvq.iommu_lock);
> +
> +       return err;
>  }
>
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
> --
> 2.41.0
>

