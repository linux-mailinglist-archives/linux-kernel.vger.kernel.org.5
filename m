Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710977C5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjHOCWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHOCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88FE65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692066117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c8Mf6SJdHrVFgrHSuwN7VWvzQVHaWatOcZXjdyX1ds0=;
        b=H6Qb14SDmSlQk3+UU/wf2KC7hT71vLnqxHk6mgfczIlAYJMy2miYqO7t6NPZiu3+zQ/lGw
        rAPLoFrQobmPgxc3blbuT/m20purXnUUI4kU/V19BxV0D1Ul9+/ebSyqjXGQw/kmmZPUoJ
        O7b4GpKlQ4qEvGp34os5WvmxbJVpo7c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-u5LlbCv2MpiJPVgcT5x6EQ-1; Mon, 14 Aug 2023 22:21:55 -0400
X-MC-Unique: u5LlbCv2MpiJPVgcT5x6EQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9bf493456so47982491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066113; x=1692670913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8Mf6SJdHrVFgrHSuwN7VWvzQVHaWatOcZXjdyX1ds0=;
        b=B0Ph2f26zzCbSPeHPjJnrR3JUzH+4PtC43iMK5AoSxi8txW9no70CtCnrBHVb2lGZt
         PX4kCQS8cPDH9xKzg5TDR3AESe987/LZWMK4B70nNrYEJ2v6xyz2kM4UsciJSeFvzfFN
         BlnbFshBI6uIGdUcga31aJNpXxzzdK0dZquXOk2YCoSb2CXh6WPZBiUM0LlFoixFfaHi
         sSESj0VZcJidgfHaHFZQQVWA9lz2h8LopECbaVaO9hg10ydrL4EkWOtICH5gpEp/ZQm6
         lFAhY5aU9uiwXjw7BEU5XJdo961iWXsIB7OTe9E75rCaFmundR2pl2U1mg4xIZmF5tO2
         ZhQA==
X-Gm-Message-State: AOJu0Yzv9cOP1CG3IwaJ6q62TnFxDhFOlyZIR6KqEzSNMl5z83IbKrvC
        BgkfQE5vnW8jQ0lKQN0BoVNW9y753/YWcuwCYs8dXwKQWlc5Ksz3qGYHfqXonpSozf0Z6CL94Hp
        V9B+M9oT0vkySiY0m4zoUneDCVCtlsQHqdKEHHLwQ
X-Received: by 2002:a2e:874a:0:b0:2ba:3eac:bece with SMTP id q10-20020a2e874a000000b002ba3eacbecemr7235380ljj.49.1692066113595;
        Mon, 14 Aug 2023 19:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFPM+Uyg4zQmIFAr0Gb+dF/9C1kz2mM3ka9Q1CxZ53dK/3gSYuO/vmcyZ0ZRwyR2cjgf2/GprDQT/zgDHZZ8=
X-Received: by 2002:a2e:874a:0:b0:2ba:3eac:bece with SMTP id
 q10-20020a2e874a000000b002ba3eacbecemr7235374ljj.49.1692066113253; Mon, 14
 Aug 2023 19:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Aug 2023 10:21:42 +0800
Message-ID: <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
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

On Tue, Aug 15, 2023 at 9:46=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/linux/vdpa.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index db1b0ea..3a3878d 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -314,6 +314,12 @@ struct vdpa_map_file {
>   *                             @iova: iova to be unmapped
>   *                             @size: size of the area
>   *                             Returns integer: success (0) or error (< =
0)
> + * @reset_map:                 Reset device memory mapping (optional)
> + *                             Needed for device that using device
> + *                             specific DMA translation (on-chip IOMMU)

This exposes the device internal to the upper layer which is not optimal.

Btw, what's the difference between this and a simple

set_map(NULL)?

Thanks

> + *                             @vdev: vdpa device
> + *                             @asid: address space identifier
> + *                             Returns integer: success (0) or error (< =
0)
>   * @get_vq_dma_dev:            Get the dma device for a specific
>   *                             virtqueue (optional)
>   *                             @vdev: vdpa device
> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
>                        u64 iova, u64 size, u64 pa, u32 perm, void *opaque=
);
>         int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>                          u64 iova, u64 size);
> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
>         struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 id=
x);
> --
> 1.8.3.1
>

