Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0767A6303
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjISMcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjISMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F62118
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695126679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foEuGHpN02cZZRHgVG6c0QInXgm/KQsAjoIQJjUhPEM=;
        b=QDHQIaWsLEkA72StMWFfVv9M9F9esSpISeNexSjFq3zaczK6vWajsTXUsTEsElM5jEafFG
        a9KZv7It4Yzt1+hYoSF1zFQ3JbRHacdOn2gK8mdndpj7B5zHytNPMvgdDz2oOiibxD1C+v
        C7BZyqzIfBJl1RjTyHWyaaTEXt5hNPg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-t2GtUS2kPNy29sG7ufwi8g-1; Tue, 19 Sep 2023 08:31:18 -0400
X-MC-Unique: t2GtUS2kPNy29sG7ufwi8g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9e3f703dfso410298866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126677; x=1695731477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foEuGHpN02cZZRHgVG6c0QInXgm/KQsAjoIQJjUhPEM=;
        b=orfQ5sryyZ1yjO2LiW20sym49qwuzVt6MxYa6vpEqb1iNjKcvURB44sgLUgA/cbKVB
         ELq1qRmU0RxnzNnSjyQiBIgHFlroi9TSsZn12uvjWvzB4XhumpK8szz8wqS3fEBPMNBB
         U5TGuw/xS/2s/9WhygZErynvLFSPHSNmuxyOdkhtp0tEHBL1JCn35EfryIGPNSN5eDL6
         R8EUEdQsPoFZTwxxiWjhRMmd7cDJuRj41YMf9H4HQsiLShJyRcF8i2d9CHWD26f/FqTc
         /d47jM5HTnnQcYVe36Vlh6+qThuHIUW4070FZxe7i4EmlxDVE5GGZbJfDMmfWo9zzXPF
         dxSA==
X-Gm-Message-State: AOJu0Yy2SULhpTjhKuBE02fcTYIoJVZ93yq1fpkpeGS5B4kRrwX0HA7L
        koOjxgEj9+6kgQQeBglPRHis22HxHvBaMPVZ4GAsF2s/Y4YJarQkhTdSHt+x5MKjn1L4xuk3EvY
        aox6DuJnWH8aLyjaIvCupQiMH
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id jy2-20020a170907762200b009a1e9943444mr9781247ejc.3.1695126677427;
        Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3B61aTdbbapBWgqBDzul7TRECZ9JfP3c02/1NZo6uc1VdIFZ3t0h1Xm1oeTneoLXE2/ODQ==
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id jy2-20020a170907762200b009a1e9943444mr9781216ejc.3.1695126677126;
        Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
Received: from redhat.com ([2.52.26.122])
        by smtp.gmail.com with ESMTPSA id e7-20020a1709067e0700b0099bd0b5a2bcsm7759563ejr.101.2023.09.19.05.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:31:16 -0700 (PDT)
Date:   Tue, 19 Sep 2023 08:31:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jiqian Chen <Jiqian.Chen@amd.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Message-ID: <20230919082802-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
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
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>

we can't add fields in the middle of the structure like this -
offset of queue_notif_config_data and queue_reset changes.

  
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +

we need to specify these values then.

we also need
- feature bit to detect support for S3
- conformance statements documenting behavious under S3


>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>          The driver will use this value when driver sends available buffer
> -- 
> 2.34.1

