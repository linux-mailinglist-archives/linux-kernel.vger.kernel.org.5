Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04D7A169D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjIOG42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjIOG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C222A2708
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694760912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HShZr8WZAcOFv96ZYRXyE10lt4rZkRojb7JS1wDFwg=;
        b=gX5VR43G1GAG9ZCMVTBIMSNO+ytvnE7ViXSZs+DRH/Pc55b+D6961r3EMKltCAIjOQ5Iip
        AQfEDEuITQII1vg4/K0joRUuXz35wTpaBxA9sglkPWW6A/De3/gq5t+bzhcheGgCp3kzf4
        poJcbfQDv6Rt3fRotuXTX6/7V+FD5wE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-xIfDFrLbM0WNcOY2e9g7RQ-1; Fri, 15 Sep 2023 02:55:10 -0400
X-MC-Unique: xIfDFrLbM0WNcOY2e9g7RQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5009121067cso2128293e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760909; x=1695365709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HShZr8WZAcOFv96ZYRXyE10lt4rZkRojb7JS1wDFwg=;
        b=PWr01elMBBc0nU+L5YRfATN85lesAaqYKXy0G5dVDrhafGZAUkrCUG52VTGqqSal+X
         b26sii6OCOVxLCkJvyMb3oJh7Se3tUfAHiBDzC13g6+MViluu5DWDuYyXc++iwh0tpei
         8R4wuqQnRyQsYPsLaKzk+xKkoEHMdM7gX433Y4i7YLQBYB8JhH5cN16EwbpO5jFsHsm3
         mvic77HB8SBt/R/ZWQbNUDAYG8Wc9myJ20aLsJSTMDyBtHSkkId1sfRbUjxf5uQGEGVJ
         PBbUS/HL4KoV1uptmaH26cpuFC8WkIsF4ob/WUdqkU/IPj8cCb2t9Z5xYi18ZPhLAzFf
         c7QQ==
X-Gm-Message-State: AOJu0Yx4Tn0rWTKbmtpmjiS42D+mpGedUmqOaXNLd3n8XSkL8cS11Rxl
        JDo9memBfobBKY6JytMf8RGxU9FFSFQlMbKejkPa3l3lKbGNlF1LaWRo7GdH4ELXv2EObRps/y2
        IFXCvq1wPNSbT6WXsUoMP8zkT5EbZjaMhrwp/u+q0
X-Received: by 2002:a05:6512:539:b0:4ff:a25b:bca1 with SMTP id o25-20020a056512053900b004ffa25bbca1mr644178lfc.33.1694760908896;
        Thu, 14 Sep 2023 23:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeELldMxnOhRlb4+WRmIeNCxjyPnSW1K3CuLG2wJF+pe+C7IWcZIM+xDb7X7fDmVIC/VIS638CajnbteLXSh0=
X-Received: by 2002:a05:6512:539:b0:4ff:a25b:bca1 with SMTP id
 o25-20020a056512053900b004ffa25bbca1mr644163lfc.33.1694760908532; Thu, 14 Sep
 2023 23:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230831155702.1080754-1-dtatulea@nvidia.com>
In-Reply-To: <20230831155702.1080754-1-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 15 Sep 2023 14:54:57 +0800
Message-ID: <CACGkMEsgZig_Ek+ZsEr3hhBznZb_d733QK+0BVoe_WMLsKd+Pg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Fix firmware error on creation of 1k VQs
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@mellanox.com>,
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

On Thu, Aug 31, 2023 at 11:58=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> A firmware error is triggered when configuring a 9k MTU on the PF after
> switching to switchdev mode and then using a vdpa device with larger
> (1k) rings:
> mlx5_cmd_out_err: CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status=
 bad resource(0x5), syndrome (0xf6db90), err(-22)
>
> This is due to the fact that the hw VQ size parameters are computed
> based on the umem_1/2/3_buffer_param_a/b capabilities and all
> device capabilities are read only when the driver is moved to switchdev m=
ode.
>
> The problematic configuration flow looks like this:
> 1) Create VF
> 2) Unbind VF
> 3) Switch PF to switchdev mode.
> 4) Bind VF
> 5) Set PF MTU to 9k
> 6) create vDPA device
> 7) Start VM with vDPA device and 1K queue size
>
> Note that setting the MTU before step 3) doesn't trigger this issue.
>
> This patch reads the forementioned umem parameters at the latest point
> possible before the VQs of the device are created.
>
> v2:
> - Allocate output with kmalloc to reduce stack frame size.
> - Removed stable from cc.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devic=
es")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 63 ++++++++++++++++++++++++++-----
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
>  2 files changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 40a03b08d7cf..ef5907b1d513 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -625,30 +625,70 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, =
u16 idx)
>         mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
>  }
>
> +static int read_umem_params(struct mlx5_vdpa_net *ndev)
> +{
> +       u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] =3D {};
> +       u16 opmod =3D (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET=
_CUR & 0x01);
> +       struct mlx5_core_dev *mdev =3D ndev->mvdev.mdev;
> +       int out_size;
> +       void *caps;
> +       void *out;
> +       int err;
> +
> +       out_size =3D MLX5_ST_SZ_BYTES(query_hca_cap_out);
> +       out =3D kzalloc(out_size, GFP_KERNEL);
> +       if (!out)
> +               return -ENOMEM;
> +
> +       MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP)=
;
> +       MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
> +       err =3D mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
> +       if (err) {
> +               mlx5_vdpa_warn(&ndev->mvdev,
> +                       "Failed reading vdpa umem capabilities with err %=
d\n", err);
> +               goto out;
> +       }
> +
> +       caps =3D  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
> +
> +       ndev->umem_1_buffer_param_a =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_1_buffer_param_a);
> +       ndev->umem_1_buffer_param_b =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_1_buffer_param_b);
> +
> +       ndev->umem_2_buffer_param_a =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_2_buffer_param_a);
> +       ndev->umem_2_buffer_param_b =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_2_buffer_param_b);
> +
> +       ndev->umem_3_buffer_param_a =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_3_buffer_param_a);
> +       ndev->umem_3_buffer_param_b =3D MLX5_GET(virtio_emulation_cap, ca=
ps, umem_3_buffer_param_b);
> +
> +out:
> +       kfree(out);
> +       return 0;
> +}
> +
>  static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_v=
irtqueue *mvq, int num,
>                           struct mlx5_vdpa_umem **umemp)
>  {
> -       struct mlx5_core_dev *mdev =3D ndev->mvdev.mdev;
> -       int p_a;
> -       int p_b;
> +       u32 p_a;
> +       u32 p_b;
>
>         switch (num) {
>         case 1:
> -               p_a =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_p=
aram_a);
> -               p_b =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_p=
aram_b);
> +               p_a =3D ndev->umem_1_buffer_param_a;
> +               p_b =3D ndev->umem_1_buffer_param_b;
>                 *umemp =3D &mvq->umem1;
>                 break;
>         case 2:
> -               p_a =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_p=
aram_a);
> -               p_b =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_p=
aram_b);
> +               p_a =3D ndev->umem_2_buffer_param_a;
> +               p_b =3D ndev->umem_2_buffer_param_b;
>                 *umemp =3D &mvq->umem2;
>                 break;
>         case 3:
> -               p_a =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_p=
aram_a);
> -               p_b =3D MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_p=
aram_b);
> +               p_a =3D ndev->umem_3_buffer_param_a;
> +               p_b =3D ndev->umem_3_buffer_param_b;
>                 *umemp =3D &mvq->umem3;
>                 break;
>         }
> +
>         (*umemp)->size =3D p_a * mvq->num_ent + p_b;
>  }
>
> @@ -2679,6 +2719,11 @@ static int setup_driver(struct mlx5_vdpa_dev *mvde=
v)
>                 goto out;
>         }
>         mlx5_vdpa_add_debugfs(ndev);
> +
> +       err =3D read_umem_params(ndev);
> +       if (err)
> +               goto err_setup;
> +
>         err =3D setup_virtqueues(mvdev);
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index 36c44d9fdd16..65ebbba20662 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -65,6 +65,15 @@ struct mlx5_vdpa_net {
>         struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
>         struct mlx5_vdpa_irq_pool irqp;
>         struct dentry *debugfs;
> +
> +       u32 umem_1_buffer_param_a;
> +       u32 umem_1_buffer_param_b;
> +
> +       u32 umem_2_buffer_param_a;
> +       u32 umem_2_buffer_param_b;
> +
> +       u32 umem_3_buffer_param_a;
> +       u32 umem_3_buffer_param_b;
>  };
>
>  struct mlx5_vdpa_counter {
> --
> 2.41.0
>

