Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E470B7A96DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjIURGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjIURF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920372712
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/TUqywb80X2AZJMzYZES4VoyIivqwNd2hjQ6BBMthY=;
        b=YOJE9sV8PxGvPPpkI/XqmVy/Z9wPpQzP+HaEsAD0h3ruMNCqb0lk5wTUI76xeHrpW+xkVP
        kqz1dVgjzTo+qJw90Bt6q+i1I9ifTHyVKsSPHwEKQQgUD6G22cg97ubygrXwkMgVGCi2+M
        yHxwjfNvaSZcbAccHwzfY+409RAKtu4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-RtRHSJAlOg-4Eb9geg4wFA-1; Thu, 21 Sep 2023 00:23:07 -0400
X-MC-Unique: RtRHSJAlOg-4Eb9geg4wFA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5033420dd31so705012e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 21:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695270186; x=1695874986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/TUqywb80X2AZJMzYZES4VoyIivqwNd2hjQ6BBMthY=;
        b=fM8UZuVuQGggwSVqd8IJ1iWye80YpO5Wgvtd4kQ5d7c5sgJa1NhK/ZvkKj862AL1+k
         66Mhtpck6sAOR23T1abiRRNJf8K60roCLQfXNBLJ3dQWYZD9S3wh0FcPDXABdeG5kVF8
         vHY/em5CO47RTZ1HCDkVbuPVeJY8kGzXNG0IRVeS5xrQEz1kK6CfVugvJStwj0qbhfVx
         yHV/CPcy6991FRaj846LZ9ahBC57M9WlojLDnH0nwgYRmr6JnKCenwTB2g0IREjmu+jh
         5nh6VdXmBKJ4taFWTgCzgdWThSHBcfQ7mf2aSqe4qZAK1Caz2/HIJNt72wh0PrfXvijj
         2dbQ==
X-Gm-Message-State: AOJu0Yxj38AIdzR8l/pjpexGCpO2AmbVBaGtnQgbeJ1gRNB6zU8ZAuYp
        Un4KHiGS6dNo2iQL7cvVXP6R+YFFQ6TLWfHACoVrFvPPBz+lcI38Pbtd3dYnaFuVjEXWFh8kdGU
        lnLC2mRrz7Dk5LTGXAY49/Ti0AVMf0LXj6S+iGwCI
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id u7-20020a05651220c700b0050076960200mr3691365lfr.59.1695270185947;
        Wed, 20 Sep 2023 21:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGVyyX13pZa+3Ktq9xbUVd38RjeljW6H0syjIQrHGw1bASMEAYrUUNaIJURxjwOkNsl2CINr8g7Gw+zy70OM=
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id
 u7-20020a05651220c700b0050076960200mr3691353lfr.59.1695270185578; Wed, 20 Sep
 2023 21:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com> <20230919114242.2283646-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 21 Sep 2023 12:22:54 +0800
Message-ID: <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to virtio_pci_common_cfg
To:     Jiqian Chen <Jiqian.Chen@amd.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.com> w=
rote:
>
> When guest vm does S3, Qemu will reset and clear some things of virtio
> devices, but guest can't aware that, so that may cause some problems.
> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> resume, that function will destroy render resources of virtio-gpu. As
> a result, after guest resume, the display can't come back and we only
> saw a black screen. Due to guest can't re-create all the resources, so
> we need to let Qemu not to destroy them when S3.
>
> For above purpose, we need a mechanism that allows guests and QEMU to
> negotiate their reset behavior. So this patch add a new parameter
> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> devices can change their reset behavior on Qemu side according to
> freeze_mode. What's more, freeze_mode can be used for all virtio
> devices to affect the behavior of Qemu, not just virtio gpu device.

A simple question, why is this issue specific to pci?

Thanks


>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  transport-pci.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..2543536 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See=
 section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and vir=
tio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +
>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been ne=
gotiated.
>          The driver will use this value when driver sends available buffe=
r
> --
> 2.34.1
>

