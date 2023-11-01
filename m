Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516E7DDA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbjKAAjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjKAAjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336A2107
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698799109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVmhpIbbAED27w6cogZcQtjsKWbHbF+MiZXcAMDs3b8=;
        b=DHQxtzX00C43K8lgWaV9oBtsYzi/ad6CfDfVXCbBRd9PqXW3JBw8I12jCuCfGh/D4syJD/
        75PFiEpa044NX3BRYYu0jKYFci3kobK5VVDJmTmbOEdVvizOqn0xiH5dKKfF48ZjE7d9En
        5OPcHff/W3gvWlc1kbQX1TqXt5TmdbY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-q4ChtN6NPcG3TiwawueYQQ-1; Tue, 31 Oct 2023 20:38:18 -0400
X-MC-Unique: q4ChtN6NPcG3TiwawueYQQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso7609003e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698799096; x=1699403896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVmhpIbbAED27w6cogZcQtjsKWbHbF+MiZXcAMDs3b8=;
        b=Tm5Qq4kO/UfhKMaTqbQAQn0f/U+JE71g9uXMInLh0fGiAHLMyw9MSegv9QzhBCDTBE
         TzSWDs02ncsmyh8BPU0r/Ezf1x9IG2zzIizgBLJV39aGPc0XA1ez0Hi4dqKKOiUnUxeC
         TG9ptQ7HleWfNqwy9FmdNkYs9Qhcz7oLHubEbrPLyxOcAf004FXpizkGKbduXbbAaPKp
         6YlHM21QNW0CZZMpeksPVJaELwadetoq3n2k1xr+r8v0CHRoAwyRfjElAmqJn6R4/TNg
         0fcSsGy+YJWF2ioHF4k1q4m5K2HeiBmnhLzexBkB8Abu0XwHQT9P/8LKZyNEJqTNx20z
         EOuQ==
X-Gm-Message-State: AOJu0YyrueR5nhlToLelNEaypn53PEVURAms48xJqme817IpB+6/PpMq
        P0PiqidQh/u291G/MxBGGqPeP83mdcRYDInxmS/sC+PvodzkHodHtDBw8eEgOk6R6TS0s09OPBk
        /Gej3CFmiHPwPJJgaEKH2hw/g3VE7GvbdUQCeUE1t
X-Received: by 2002:ac2:5d31:0:b0:508:1227:5a10 with SMTP id i17-20020ac25d31000000b0050812275a10mr8510925lfb.23.1698799096728;
        Tue, 31 Oct 2023 17:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELnbiKGw2gzG8mmlQVxm+S0ABUPG3MLsIsFSN626UDcnC/raa4pedrJ5yX266tK9gGw2tsUAPI3qr4SXA4FRg=
X-Received: by 2002:ac2:5d31:0:b0:508:1227:5a10 with SMTP id
 i17-20020ac25d31000000b0050812275a10mr8510914lfb.23.1698799096383; Tue, 31
 Oct 2023 17:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
In-Reply-To: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 1 Nov 2023 08:38:05 +0800
Message-ID: <CACGkMEt0OV=y+MRvSVQcLJqOSfrqQNR=aMWfcFgFbZ9QODzeTQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: move structure to a header
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 12:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> These are guest/host interfaces so belong in the header
> where e.g. qemu will know to find them.
> Note: we added a new structure as opposed to extending existing one
> because someone might be relying on the size of the existing structure
> staying unchanged.  Add a warning to avoid using sizeof.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
>  include/linux/virtio_pci_modern.h      |  7 -------
>  include/uapi/linux/virtio_pci.h        | 11 +++++++++++
>  3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virt=
io_pci_modern_dev.c
> index e2a1fe7bb66c..7de8b1ebabac 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -294,9 +294,10 @@ int vp_modern_probe(struct virtio_pci_modern_device =
*mdev)
>
>         err =3D -EINVAL;
>         mdev->common =3D vp_modern_map_capability(mdev, common,
> -                                     sizeof(struct virtio_pci_common_cfg=
), 4,
> -                                     0, sizeof(struct virtio_pci_modern_=
common_cfg),
> -                                     &mdev->common_len, NULL);
> +                             sizeof(struct virtio_pci_common_cfg), 4, 0,
> +                             offsetofend(struct virtio_pci_modern_common=
_cfg,
> +                                         queue_reset),
> +                             &mdev->common_len, NULL);
>         if (!mdev->common)
>                 goto err_map_common;
>         mdev->isr =3D vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci=
_modern.h
> index d0f2797420f7..a09e13a577a9 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -5,13 +5,6 @@
>  #include <linux/pci.h>
>  #include <linux/virtio_pci.h>
>
> -struct virtio_pci_modern_common_cfg {
> -       struct virtio_pci_common_cfg cfg;
> -
> -       __le16 queue_notify_data;       /* read-write */
> -       __le16 queue_reset;             /* read-write */
> -};
> -
>  /**
>   * struct virtio_pci_modern_device - info for modern PCI virtio
>   * @pci_dev:       Ptr to the PCI device struct
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index f703afc7ad31..44f4dd2add18 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,17 @@ struct virtio_pci_common_cfg {
>         __le32 queue_used_hi;           /* read-write */
>  };
>
> +/*
> + * Warning: do not use sizeof on this: use offsetofend for
> + * specific fields you need.
> + */
> +struct virtio_pci_modern_common_cfg {
> +       struct virtio_pci_common_cfg cfg;
> +
> +       __le16 queue_notify_data;       /* read-write */
> +       __le16 queue_reset;             /* read-write */
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>  struct virtio_pci_cfg_cap {
>         struct virtio_pci_cap cap;
> --
> MST
>

