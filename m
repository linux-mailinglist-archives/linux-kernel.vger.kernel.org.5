Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A675A45F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGTC2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B92103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689820039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhX0KcPz6bpGMzzt6+Tw+HFeLg7cMeTIF/CHwLfDxqU=;
        b=BbApqAQ3eq8jRT4AFLuBmJJT/Ym3bmz5fqKVq7nptiwIPyhkXm/wh4KyRHcWVTPXMwR2eC
        2iu1CINyoxc79xNWibg0KE2bJNpmNmo4LiFQuUGfmFrblc8gA0fSpufbxJJHYY6P52sl92
        y1UsCrj7nnUZxuGGsyB+W+bsIPVVGzI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-c7fmM1GbN3GdXFHEEA3ojA-1; Wed, 19 Jul 2023 22:27:17 -0400
X-MC-Unique: c7fmM1GbN3GdXFHEEA3ojA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b708e49042so2388101fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689820036; x=1692412036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhX0KcPz6bpGMzzt6+Tw+HFeLg7cMeTIF/CHwLfDxqU=;
        b=Q1B7yA9QVqM32xCEpy4tqnZUtVK+o0IXGzvw/Ydh94OLn2woCJUAQlmxg0f63vEGWV
         R0XgqzA5xMymCI3U0TAIWK0+t7s664QFmzO+9Qy3Ik5WSVJsY298y6NpDPF7TAHTXyFL
         b/0nHZrICsKon+iF4T7EZxR+/uKRPO0hUvUQJijxz76WN1GctWFKkxy0PIc7BIYYj73X
         X9vuJhfNjrfKdKPIlRXlCz6mEJsPvh9YZ5Cfwj5wlOYiaJWd1IlADu2o8cHb7HUXjk7J
         fo3+gJrBquY6OSkPEeXRJ6pixGITs121yLNt+9UQ0LcsaLUmAOSg++MgMJNBX0kYomwh
         xgRg==
X-Gm-Message-State: ABy/qLY/8zB+0o7JOfuHJvDLeLRNbfM9VqeJJiShsk0Oi9w9IR/R/ah7
        1b4ESB2lJNNoE1yqjOT0TUgFx6lE71e6eDC8AOj5CwpnwAIuzDQXD/joAxtzR5M6S7BUeaajuCZ
        4gQ8YkhpdlV34NF1S/NGY6S7xzjyL0ORS+4/gWWMk
X-Received: by 2002:a2e:b70a:0:b0:2a7:adf7:1781 with SMTP id j10-20020a2eb70a000000b002a7adf71781mr1207369ljo.2.1689820036242;
        Wed, 19 Jul 2023 19:27:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG8VfnWGKux2XQqloHvmum/oTHRj7uk/Z8damP4dF1V13QVr/IDb3lqUNAF2zJ46P6L2CkZPMsB4+tjAqSbnQ=
X-Received: by 2002:a2e:b70a:0:b0:2a7:adf7:1781 with SMTP id
 j10-20020a2eb70a000000b002a7adf71781mr1207359ljo.2.1689820035929; Wed, 19 Jul
 2023 19:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230719154550.79536-1-feliu@nvidia.com>
In-Reply-To: <20230719154550.79536-1-feliu@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Jul 2023 10:27:04 +0800
Message-ID: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in probe
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:46=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
> The 'is_legacy' flag is used to differentiate between legacy vs modern
> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
> However, due to the shared memory of the union between struct
> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
> virtio_pci_modern_probe modifies the content of struct
> virtio_pci_modern_device, it affects the content of struct
> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
> device is probed, mark 'is_legacy' as true, when modern device is
> probed, keep 'is_legacy' as false.
>
> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure si=
ze")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 2 --
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index a6c86f916dbd..c2524a7207cf 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>
>         pci_set_master(pci_dev);
>
> -       vp_dev->is_legacy =3D vp_dev->ldev.ioaddr ? true : false;
> -
>         rc =3D register_virtio_device(&vp_dev->vdev);
>         reg_dev =3D vp_dev;
>         if (rc)
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_p=
ci_legacy.c
> index 2257f1b3d8ae..d9cbb02b35a1 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device =
*vp_dev)
>         vp_dev->config_vector =3D vp_config_vector;
>         vp_dev->setup_vq =3D setup_vq;
>         vp_dev->del_vq =3D del_vq;
> +       vp_dev->is_legacy =3D true;

This seems break force_legacy for modern device:

        if (force_legacy) {
                rc =3D virtio_pci_legacy_probe(vp_dev);
                /* Also try modern mode if we can't map BAR0 (no IO space).=
 */
                if (rc =3D=3D -ENODEV || rc =3D=3D -ENOMEM)
                        rc =3D virtio_pci_modern_probe(vp_dev);

Thanks

>
>         return 0;
>  }
> --
> 2.37.1 (Apple Git-137.1)
>

