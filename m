Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043167B8AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbjJDSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbjJDSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61DC9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696444927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQfX2NwzFz/kFrkiCQ2oGb1YhIRD6fkpICdtjsb36QM=;
        b=P3Z8EQmWP5PwkX59hKxZZzxrLLcX/y8MIK6yvJziWth+cR6chLnzPw+GMzrkruSAx5DKTP
        wJtTsZol+GnxY0KTPJh+ukqkvq7+RxeiE1gsPIV3RQcg/cPTDA+Tneu9DWwI32kHonltjH
        vffUhuSgqeDPMVWhWeX2n3ZevCtYNwk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-VdYCekokNGeXBtFGrew2iw-1; Wed, 04 Oct 2023 14:42:05 -0400
X-MC-Unique: VdYCekokNGeXBtFGrew2iw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a20c7295bbso1779437b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696444925; x=1697049725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQfX2NwzFz/kFrkiCQ2oGb1YhIRD6fkpICdtjsb36QM=;
        b=JrXgEp66l2t6ETm5cV1XmOBamuowuCjRchT1yHVk86s+wIFcXZOUnmDdVIcVaZVG0m
         3k8pkeO5Zti4zjTjPJZr/0AP19nQLMNm4dOw9LgQYp/zsc+Ad6Ox4wAOu14MUqI/a+4P
         A1eUen5RLtROU2vK1U1hpsvSKkKN2lMfWafNkZ7aro0bqvlU5p4mp8zlJLEgCPbv2/E0
         ncv+nFHPZf6QRHf+M3Pb0RpYi1MVPp7n5aX3vf+n5fw6DYYeTztcanTWymmbDTsXrx1+
         RNQClzDFROY6yYJ1nRsQqToS4VHGks4Yz2S5FzPARoTIVnL9g+5dNtuL88Q8GtvyaI4w
         qteA==
X-Gm-Message-State: AOJu0Yw6pE2UBnP4gH3YfUwffbaxaQgEcQQmTk8TOJUavKCnqq4eRcIK
        Lbma8oQ4pmWHXDUH2nCPxgNk4cEJvFHa9h9BvL5aLENzflmCMGhWxMrThySAZ3izPaDnoAVeZSn
        +L665abiXdk6IfFclihJkjpNNAev3h3OX5qQChkgr
X-Received: by 2002:a0d:d893:0:b0:59f:d01:779f with SMTP id a141-20020a0dd893000000b0059f0d01779fmr512481ywe.23.1696444925205;
        Wed, 04 Oct 2023 11:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa8icbOwgxbjPqzAzJIEZFRkYHs2POESQkzR8pEV3Ci1LCad+p00zVpUWB6wKUeCVC17Dv6rMORMEVt826WGo=
X-Received: by 2002:a0d:d893:0:b0:59f:d01:779f with SMTP id
 a141-20020a0dd893000000b0059f0d01779fmr512467ywe.23.1696444924943; Wed, 04
 Oct 2023 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-11-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-11-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 4 Oct 2023 20:41:29 +0200
Message-ID: <CAJaqyWdLTO8ie66zRbjEpCr61icJ9n1c8bWzQ_sZXkQ5kpgHDQ@mail.gmail.com>
Subject: Re: [PATCH vhost 09/16] vdpa/mlx5: Rename mr destroy functions
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
> Make mlx5_destroy_mr symmetric to mlx5_create_mr.
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++--
>  drivers/vdpa/mlx5/core/mr.c        |  6 +++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 554899a80241..e1e6e7aba50e 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -118,8 +118,8 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mv=
dev, struct vhost_iotlb *io
>                              bool *change_map, unsigned int asid);
>  int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
>                         unsigned int asid);
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
> -void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int=
 asid);
> +void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid=
);
>  int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
>                                 struct vhost_iotlb *iotlb,
>                                 unsigned int asid);
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index fde00497f4ad..00dcce190a1f 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -507,7 +507,7 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_de=
v *mvdev, unsigned int asid
>         mr->initialized =3D false;
>  }
>
> -void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int=
 asid)
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid=
)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>
> @@ -518,9 +518,9 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *=
mvdev, unsigned int asid)
>         mutex_unlock(&mr->mkey_mtx);
>  }
>
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> +void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> -       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATA=
VQ_GROUP]);
> +       mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]);
>         prune_iotlb(mvdev);
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index aa4896662699..ab196c43694c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2644,7 +2644,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>                 goto err_mr;
>
>         teardown_driver(ndev);
> -       mlx5_vdpa_destroy_mr_asid(mvdev, asid);
> +       mlx5_vdpa_destroy_mr(mvdev, asid);
>         err =3D mlx5_vdpa_create_mr(mvdev, iotlb, asid);
>         if (err)
>                 goto err_mr;
> @@ -2660,7 +2660,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>         return 0;
>
>  err_setup:
> -       mlx5_vdpa_destroy_mr_asid(mvdev, asid);
> +       mlx5_vdpa_destroy_mr(mvdev, asid);
>  err_mr:
>         return err;
>  }
> @@ -2797,7 +2797,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>  err_driver:
>         unregister_link_notifier(ndev);
>  err_setup:
> -       mlx5_vdpa_destroy_mr(&ndev->mvdev);
> +       mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
>  err_clear:
>         up_write(&ndev->reslock);
> @@ -2824,7 +2824,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>         unregister_link_notifier(ndev);
>         teardown_driver(ndev);
>         clear_vqs_ready(ndev);
> -       mlx5_vdpa_destroy_mr(&ndev->mvdev);
> +       mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         ndev->mvdev.status =3D 0;
>         ndev->mvdev.suspended =3D false;
>         ndev->cur_num_vqs =3D 0;
> @@ -2944,7 +2944,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
>         free_resources(ndev);
> -       mlx5_vdpa_destroy_mr(mvdev);
> +       mlx5_vdpa_destroy_mr_resources(mvdev);
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> @@ -3474,7 +3474,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  err_res2:
>         free_resources(ndev);
>  err_mr:
> -       mlx5_vdpa_destroy_mr(mvdev);
> +       mlx5_vdpa_destroy_mr_resources(mvdev);
>  err_res:
>         mlx5_vdpa_free_resources(&ndev->mvdev);
>  err_mpfs:
> --
> 2.41.0
>

