Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6326877D7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjHPB4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbjHPB4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7671FE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692150947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjCnX6u/94BO9ruB6wVa3OuMbd0IF6Vevmu7R7ayNtA=;
        b=CmGNH5XR+CjglSFIzgBlQWHanRA3yyk++YcEaFv/K/88QGbQGXfyKz0SrYJmy4oyMEkpxQ
        0OmhICaj6wK0cjGy0IABC++0DpI7IxarQPrwqMY+jfpl5pLkeSTyN6doQu3ZCCgmG7tcZe
        YHffjrkYs0L/WJKOIwLwYirJsykMFzo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-R9rdAaO3OZK8gf0F-aylCQ-1; Tue, 15 Aug 2023 21:55:45 -0400
X-MC-Unique: R9rdAaO3OZK8gf0F-aylCQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bb99d9c60eso352481fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692150944; x=1692755744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjCnX6u/94BO9ruB6wVa3OuMbd0IF6Vevmu7R7ayNtA=;
        b=ClEJlFocKNjWKpix03Ie07vH0Fwr3g39BibuCpJlZ9sDnBSWkWGArgItIbgUOh+U90
         yBLIU/rYe/Wp8g1pLJAvvo0FoBiMlH+mcIy2KQLN5zvQ3sBRYeHz1aNzpj0d9b14mz3J
         TSQIh4vVrV/toR4VmP6q+kndc+HZjsqO7zRQZEyVEFgMX/6idUnbu5m6EyY23CR9EdhK
         xY0se5vvyGCjjeVKmkVjCnKtZblnXnsTpZKMCeCc/ivo78tDhNYY0jB5IXpmMA6YTxCo
         ixuLwMs8mrSuumh3DU49xte3xDCsryboTxdu2WPmMcuQ2jQ0iGFqunmlwOUx2+JIoCkq
         b8Xw==
X-Gm-Message-State: AOJu0YzY/FQtdyYVYIRDafPbPmGZGyUChiJd0v9TtuCJq0TFy3Br3MVf
        bGANEz0PV9m7B2rpXr5AqQwbAuFlSeHAfrYWCFX8PXfUCrdMWefao4ZQPbzfYwMHh41SIyPh84N
        7aqbCOcZNy2a/Nvip3f0626auvtetFTPefAEg5X14
X-Received: by 2002:a2e:8893:0:b0:2b6:ecdd:16cf with SMTP id k19-20020a2e8893000000b002b6ecdd16cfmr343153lji.40.1692150944455;
        Tue, 15 Aug 2023 18:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoZBozE1L5tA3akyJZBoyIVXtNrtJWNiy9lqfH1Q5JzFdXd6h+mpIYWberUMRzAaIxH8CHfrGhLOuZhH/eXRY=
X-Received: by 2002:a2e:8893:0:b0:2b6:ecdd:16cf with SMTP id
 k19-20020a2e8893000000b002b6ecdd16cfmr343146lji.40.1692150944163; Tue, 15 Aug
 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com> <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
In-Reply-To: <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Aug 2023 09:55:33 +0800
Message-ID: <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 3:49=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/14/2023 7:21 PM, Jason Wang wrote:
> > On Tue, Aug 15, 2023 at 9:46=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   include/linux/vdpa.h | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> index db1b0ea..3a3878d 100644
> >> --- a/include/linux/vdpa.h
> >> +++ b/include/linux/vdpa.h
> >> @@ -314,6 +314,12 @@ struct vdpa_map_file {
> >>    *                             @iova: iova to be unmapped
> >>    *                             @size: size of the area
> >>    *                             Returns integer: success (0) or error=
 (< 0)
> >> + * @reset_map:                 Reset device memory mapping (optional)
> >> + *                             Needed for device that using device
> >> + *                             specific DMA translation (on-chip IOMM=
U)
> > This exposes the device internal to the upper layer which is not optima=
l.
> Not sure what does it mean by "device internal", but this op callback
> just follows existing convention to describe what vdpa parent this API
> targets.

I meant the bus tries to hide the differences among vendors. So it
needs to hide on-chip IOMMU stuff to the upper layer.

We can expose two dimensional IO mappings models but it looks like
over engineering for this issue. More below.

>
>   * @set_map:                    Set device memory mapping (optional)
>   *                              Needed for device that using device
>   *                              specific DMA translation (on-chip IOMMU)
> :
> :
>   * @dma_map:                    Map an area of PA to IOVA (optional)
>   *                              Needed for device that using device
>   *                              specific DMA translation (on-chip IOMMU)
>   *                              and preferring incremental map.
> :
> :
>   * @dma_unmap:                  Unmap an area of IOVA (optional but
>   *                              must be implemented with dma_map)
>   *                              Needed for device that using device
>   *                              specific DMA translation (on-chip IOMMU)
>   *                              and preferring incremental unmap.
>
>
> > Btw, what's the difference between this and a simple
> >
> > set_map(NULL)?
> I don't think parent drivers support this today - they can accept
> non-NULL iotlb containing empty map entry, but not a NULL iotlb. The
> behavior is undefined or it even causes panic when a NULL iotlb is
> passed in.

We can do this simple change if it can work.

>  Further this doesn't work with .dma_map parent drivers.

Probably, but I'd remove dma_map as it doesn't have any real users
except for the simulator.

>
> The reason why a new op is needed or better is because it allows
> userspace to tell apart different reset behavior from the older kernel
> (via the F_IOTLB_PERSIST feature bit in patch 4), while this behavior
> could vary between parent drivers.

I'm ok with a new feature flag, but we need to first seek a way to
reuse the existing API.

Thanks

>
> Regards,
> -Siwei
>
> >
> > Thanks
> >
> >> + *                             @vdev: vdpa device
> >> + *                             @asid: address space identifier
> >> + *                             Returns integer: success (0) or error =
(< 0)
> >>    * @get_vq_dma_dev:            Get the dma device for a specific
> >>    *                             virtqueue (optional)
> >>    *                             @vdev: vdpa device
> >> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
> >>                         u64 iova, u64 size, u64 pa, u32 perm, void *op=
aque);
> >>          int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
> >>                           u64 iova, u64 size);
> >> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
> >>          int (*set_group_asid)(struct vdpa_device *vdev, unsigned int =
group,
> >>                                unsigned int asid);
> >>          struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u1=
6 idx);
> >> --
> >> 1.8.3.1
> >>
>

