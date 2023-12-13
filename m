Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A781093F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbjLMEw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbjLMEww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE581AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702443178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAdbgfQ0YuZV7i44ECJUKgzL+mbD9IwwoDZYX761XnQ=;
        b=OZqw1IWu56QaLdLHESZ3cP3XzEtLDNyZizUMJI+cyISzrU5FdFKOnrVxi6PobapNhL02A/
        bk2rwYF9GHoBjpOABB4z7XcgZNDdGGW0QfmnZlyBF2ZH5JQ0iFJk5yEp4Wnmo5jueO/yaX
        xl7M5gR4NbKe13TPCt3bcWn6QBF2ZFo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-PS8XuFyaMD2B7vLqVFoYzA-1; Tue, 12 Dec 2023 23:52:51 -0500
X-MC-Unique: PS8XuFyaMD2B7vLqVFoYzA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d11a85f90so8067288eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702443171; x=1703047971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAdbgfQ0YuZV7i44ECJUKgzL+mbD9IwwoDZYX761XnQ=;
        b=sGcjLU7Xd+OrZjAnDFDyNyNFhefng02DOG8tCqOI7zxx9WlJbefsl6Q7UIEwIJLvdO
         TTdgbIPqoq8zHEEOkkY3KjAfNGvmil7NuNsVct6KAoCwwMNPKF9he9Vu8NH6ZTv3tqAH
         Iu1+DdfJ5natZDVet8Dm2Gd7SbpHMofeY7szNCjOaUEByRwQC7Q3ozjjicY2/o3EEbg2
         4hs052njcOF4U0Q9tokkRHeqZhqYiNOzMJo8fu1CncFUtQ1ve0XRaQsOaMpOnW+jvLrA
         wDLf96H2jH7sKt1xolmyybwXIF4KuKuktjl09MfVe7Nbcwinsh3auW4OC27L+2op00+C
         DSkw==
X-Gm-Message-State: AOJu0YweBTKyIzUwpajwd+idaL3zZU53BpqQiHqU5YQJpwotIf42h2GM
        hkafKqk+0Gh1y8ifnNnMI5jZ2w2YJ74UD7BQOaqnZjnzNCd0kqY5eDKskQ7fZhxR6IPJr8Y5vim
        FIApxal61Eatbl3WhXcYfi9dDpbIghCPAB7VMbzYW
X-Received: by 2002:a05:6358:d3a0:b0:170:678:cb49 with SMTP id mp32-20020a056358d3a000b001700678cb49mr8194750rwb.26.1702443171188;
        Tue, 12 Dec 2023 20:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0buKfWzxWPThUdmlqXSXHZqhajudkEjo3BQXuLk358qKXlhNq9vU1NFeJV5laPGU8AcCftT6g3/50CeQJ8Do=
X-Received: by 2002:a05:6358:d3a0:b0:170:678:cb49 with SMTP id
 mp32-20020a056358d3a000b001700678cb49mr8194734rwb.26.1702443170887; Tue, 12
 Dec 2023 20:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com> <20231212131712.1816324-3-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-3-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 13 Dec 2023 12:52:39 +0800
Message-ID: <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] vduse: Temporarily disable control queue features
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 9:17=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's disable control virtqueue and features that depend on
> it.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

I wonder if it's better to fail instead of a mask as a start.

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0486ff672408..fe4b5c8203fd 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -28,6 +28,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -46,6 +47,30 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_VALID_FEATURES_MASK           \
> +       (BIT_ULL(VIRTIO_NET_F_CSUM) |           \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
> +        BIT_ULL(VIRTIO_NET_F_MTU) |            \
> +        BIT_ULL(VIRTIO_NET_F_MAC) |            \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
> +        BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
> +        BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
> +        BIT_ULL(VIRTIO_NET_F_STATUS) |         \
> +        BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
> +        BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
> +        BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
> +        BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
> +        BIT_ULL(VIRTIO_F_VERSION_1) |          \
> +        BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
> +        BIT_ULL(VIRTIO_F_RING_PACKED) |        \
> +        BIT_ULL(VIRTIO_F_IN_ORDER))
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1782,6 +1807,16 @@ static struct attribute *vduse_dev_attrs[] =3D {
>
>  ATTRIBUTE_GROUPS(vduse_dev);
>
> +static void vduse_dev_features_filter(struct vduse_dev_config *config)
> +{
> +       /*
> +        * Temporarily filter out virtio-net's control virtqueue and feat=
ures
> +        * that depend on it while CVQ is being made more robust for VDUS=
E.
> +        */
> +       if (config->device_id =3D=3D VIRTIO_ID_NET)
> +               config->features &=3D VDUSE_NET_VALID_FEATURES_MASK;
> +}
> +
>  static int vduse_create_dev(struct vduse_dev_config *config,
>                             void *config_buf, u64 api_version)
>  {
> @@ -1797,6 +1832,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         if (!dev)
>                 goto err;
>
> +       vduse_dev_features_filter(config);
> +
>         dev->api_version =3D api_version;
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
> --
> 2.43.0
>

