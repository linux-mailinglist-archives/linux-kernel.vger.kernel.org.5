Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58551766168
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG1Bky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjG1Bkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F73584
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690508403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pN/ym8BrU7SB9ZbfxQKn7T8k7nbmNNGc1emjzZf6u4=;
        b=HNZylASWe3lEHios/txMzHXeeEywoNN1ADN1ubZd1t6WDaNq7bv0qMXzbJpFPAO2Zt1HtM
        0v8A0SALaVj2taGgmYqrKssxmT5Wk+8AVmtlMocfEwdplae8SqU+87AWfLs9V+EdLdqB8n
        FJGon2cifY2AGvvU7IGsaoJdVEHPjPQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-_TcHLkyRMTaiE8HnLIRsCw-1; Thu, 27 Jul 2023 21:40:01 -0400
X-MC-Unique: _TcHLkyRMTaiE8HnLIRsCw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so3095621fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508400; x=1691113200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pN/ym8BrU7SB9ZbfxQKn7T8k7nbmNNGc1emjzZf6u4=;
        b=SJ2cy9dNma38SnV4YKJ1jd7wuUq73SmKCZi97XEPLUvdiufndKF8Onlv+b58jwajEv
         JPHEsWjeHjPKA8pwwu3yGLIiAaajWxzqij/Pr7N37YDvgZwod5ALHkhDxzcecpZAuIN7
         f2j2EiPLGFrQwORaNeHtewiH4kgmNxVo0GGJk5hOsykMwsfVyVr9OxMPOd5wnS7dsnUL
         Qi6/FqzVDZBadan3hP2Q/KRFGs/Ug18BPkq8jE4QMc/VSV4PnCpKqh5yYSoaSEHYQ5cT
         cG+snMzHomPdzcnu3Bo/poFi7YRauffSkQyE9rcjiUgdKlXvvcIS2DYRB0Dz41wEdxsA
         7WFA==
X-Gm-Message-State: ABy/qLaI3aFKEHUa3J9RUpXPNPUlbFO1A189C48+Vhuu+sxR3sfegeVf
        O7oZPOlVvFUkn7HMWbURnh9o4MrK+Gjo1XdIj0ksIWDfJVqQV+zvSfLISvw6kfedSNUlbeWmB4V
        67pdRdVoemAjy25xuvnPaP3CqMYTCIPEqnxklnCGr
X-Received: by 2002:a2e:a209:0:b0:2b6:d137:b61c with SMTP id h9-20020a2ea209000000b002b6d137b61cmr441080ljm.39.1690508400572;
        Thu, 27 Jul 2023 18:40:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGab46NQRatFjFpsN54F27KgE8MufnbMbfw9gfYF6c93BHJSpvkz53N2RdBZe8GLRXOISNFHSGw4FAtqFK+QmU=
X-Received: by 2002:a2e:a209:0:b0:2b6:d137:b61c with SMTP id
 h9-20020a2ea209000000b002b6d137b61cmr441072ljm.39.1690508400375; Thu, 27 Jul
 2023 18:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727172354.68243-2-dtatulea@nvidia.com>
In-Reply-To: <20230727172354.68243-2-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 28 Jul 2023 09:39:49 +0800
Message-ID: <CACGkMEt5+O1Q1=SvPpD5kwhEnoLNva73Uew0vaWBVXW3xE-o0Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Correct default number of queues when MQ is on
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:25=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The standard specifies that the initial number of queues is the
> default, which is 1 (1 tx, 1 rx).
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 9138ef2fb2c8..6b6eb69a8a90 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2517,7 +2517,15 @@ static int mlx5_vdpa_set_driver_features(struct vd=
pa_device *vdev, u64 features)
>         else
>                 ndev->rqt_size =3D 1;
>
> -       ndev->cur_num_vqs =3D 2 * ndev->rqt_size;
> +       /* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, =
section
> +        * 5.1.6.5.5 "Device operation in multiqueue mode":
> +        *
> +        * Multiqueue is disabled by default.
> +        * The driver enables multiqueue by sending a command using class
> +        * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
> +        * operation, as follows: ...
> +        */
> +       ndev->cur_num_vqs =3D 2;
>
>         update_cvq_info(mvdev);
>         return err;
> --
> 2.41.0
>

