Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C3800E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379345AbjLAPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379307AbjLAPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36A91
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701443962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXm7ORGqBZRQibD2CXBq2iXnUxr20ROajaE6s0OsD8s=;
        b=aMYR9A4jY9PDP3NFrrk4G6TV922cESTNuZaSwkLtWtk4jtstu9mWBbZodXjkRrOTq+fa37
        1RfPsyp9viRS/NiqCCSGHfjDgDTX5PeY4feIwvFWQqO/N17wzszQXhoeQVllgHQd19JMct
        7CYVsZqAyRAGMwhiRSWxM0STXUotj4w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-t0I11RqgMy6UtQljs1pW7g-1; Fri, 01 Dec 2023 10:19:21 -0500
X-MC-Unique: t0I11RqgMy6UtQljs1pW7g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5caf61210e3so33333137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443960; x=1702048760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXm7ORGqBZRQibD2CXBq2iXnUxr20ROajaE6s0OsD8s=;
        b=nqU/mslpDNQXvqJhRdUrl7F7ZakZrK/a2jMqFBYIyRPxXKXa8mlRePBN1Xhs9tL+DH
         b+71Bz6OWUssJLvPmMWVj3b56uC+h2poSCPL27G+knTyOYRlan3ageE2roFae/VsER6B
         EJQgI1DonB2pip3cw5pcYMWV68oXY+vIXYaP6MCrKpsOlViqgOW82UfxrXiP1BywT3Hq
         9D/6uEhJeE2qzt9yO+PyJYPcbJCF4LLb3hqCJ6ksr70J6ek3c54oQ1D+pHmrxyMkhNag
         5kHT00QMmA+5tJ2TMO5J7rBGgshPFaZe0UTQhhM2I7ySaTpcJimeoBfp0dWCD/cTMxjT
         LrCA==
X-Gm-Message-State: AOJu0YwDBv4qIZ8RQbVJ6XaapCoMkvfy127XVC+AILmDkYBJpar/uvLh
        CZxp5DL+T3o1Ut3IwAWfrerfP1Svs5DdNQcuA2DfAYvuxPT0mrEV1wqjrrtbEj3pThJnCmZ3LRT
        7d7er4OjX63LwtUHryqpCNXAb/RYaASBCa1dFS02g
X-Received: by 2002:a0d:db0f:0:b0:5d6:b412:19dc with SMTP id d15-20020a0ddb0f000000b005d6b41219dcmr1122969ywe.8.1701443960725;
        Fri, 01 Dec 2023 07:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6lDZLBFR1eE1535WBabPzL29pPwJmipsUSBju2+viJweB3LEtTtxcMwvU+ISfzmVUVeodvROTWBtiXJgwI/Y=
X-Received: by 2002:a0d:db0f:0:b0:5d6:b412:19dc with SMTP id
 d15-20020a0ddb0f000000b005d6b41219dcmr1122957ywe.8.1701443960471; Fri, 01 Dec
 2023 07:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-7-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-7-dtatulea@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 1 Dec 2023 16:18:44 +0100
Message-ID: <CAJaqyWc1msHWR_5BrFM2F3JBcLriNLhE43Zh-LOz490Xzrz5ng@mail.gmail.com>
Subject: Re: [PATCH vhost 6/7] vdpa/mlx5: Mark vq state for modification in hw vq
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gal Pressman <galp@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:50=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> .set_vq_state will set the indices and mark the fields to be modified in
> the hw vq.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 8 ++++++++
>  include/linux/mlx5/mlx5_ifc_vdpa.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 2277daf4814f..6325aef045e2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1249,6 +1249,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *=
ndev,
>                 MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
>         }
>
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_=
IDX)
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_available_i=
ndex, mvq->avail_idx);
> +
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_I=
DX)
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
> +
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
>         if (err)
> @@ -2328,6 +2334,8 @@ static int mlx5_vdpa_set_vq_state(struct vdpa_devic=
e *vdev, u16 idx,
>
>         mvq->used_idx =3D state->split.avail_index;
>         mvq->avail_idx =3D state->split.avail_index;
> +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_I=
DX |
> +                               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX;
>         return 0;
>  }
>
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5=
_ifc_vdpa.h
> index 9594ac405740..32e712106e68 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -146,6 +146,8 @@ enum {
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u64)1 << 3,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u64)1 << 4,
>         MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =3D (u64)1 << 6,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX       =3D (u64)1 << 7,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX        =3D (u64)1 << 8,
>         MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 << 14,
>  };
>
> --
> 2.42.0
>

