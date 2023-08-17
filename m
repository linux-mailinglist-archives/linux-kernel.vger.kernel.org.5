Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2F77FAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353207AbjHQPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353200AbjHQP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897CC19A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692286142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6tOxWkEr6xxGE9FShiuPz6AH7WK7YQa2zSy2aZfNlI=;
        b=FgUh1TqITPgm3uzPCgAgMqSuLfjiunY1nbEYlB4ZK8s8U7OSOeE/SnDuekPJHLo2opXl+1
        XMhmqDx/v+NYmrTBGFfXtFKM5WdgdZagZERPHCl5aq/6RGDMDHFCmEjiIZagAfX2p5r0pG
        kzdYkD6ba06e1h4i+iZxZUVV7/MvHNE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-L0w5Vs9qNIKsAbPdtV2J_A-1; Thu, 17 Aug 2023 11:29:01 -0400
X-MC-Unique: L0w5Vs9qNIKsAbPdtV2J_A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-589b0bbc290so94226577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286141; x=1692890941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6tOxWkEr6xxGE9FShiuPz6AH7WK7YQa2zSy2aZfNlI=;
        b=V7QEhbFRRI8I6Yu5b5FYuMOYrK0HWqHu9TDPo1eYDQcRPCpJ+2yK6QHxVd6gez1xHk
         uasywf/tQokz+hcfvuTa6sGG8qXHwFPih0nz9HAiEpQfh/PCNSFNi7WDCgWnMYli/qHf
         dJ/T4rvUqSZuI+7eLUH+7TVeO+Z+Dha7hR5EjrvYVpFpqsVT+Yl3kGc+BYegt5m4kHJQ
         rXmM/qslnkt2vJmK0fLJsfD8p8/qaTyp7tN36CPAZvj1D1kSsjQxyDILau/p6Yw8QTnE
         6khHWfAcHQAM+IhQB5nTjXf/ICdtRewS0C8ma7ZQkQ0a+iPFKelsYOA0ICYjBt/Kn6in
         OdRw==
X-Gm-Message-State: AOJu0Yz9NattfIqp4StV65haXWuogRRjN7qaJ78/T4xuytbm8iiuRvsi
        3DE9Q1wW89AppAiHS0avviwKfjZhE8bP2BlhRkf1o3l4DNrjLgfu8T/EhKbemiylKALX3cvB3s9
        i5eCxs7c/Up+DdQyaCrarGl//ygoH0vkLZ4QO4wOA
X-Received: by 2002:a25:d795:0:b0:d0b:fe82:8b99 with SMTP id o143-20020a25d795000000b00d0bfe828b99mr5313048ybg.44.1692286140820;
        Thu, 17 Aug 2023 08:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYBgr8/FUdvt7/KtIc5+hLYwb/pUCxWEwcCzIdyb8uhH1/nrA0AasVhPEcFWVosTnGv1WaxD1t8lHFmCa7R/s=
X-Received: by 2002:a25:d795:0:b0:d0b:fe82:8b99 with SMTP id
 o143-20020a25d795000000b00d0bfe828b99mr5313037ybg.44.1692286140562; Thu, 17
 Aug 2023 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com> <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com> <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
 <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
In-Reply-To: <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 17 Aug 2023 17:28:24 +0200
Message-ID: <CAJaqyWeC=G7fbgvmyCicnuGLYD84G5+b37tVA1KqzrSHO_AGDw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, gal@nvidia.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
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

On Thu, Aug 17, 2023 at 2:05=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/15/2023 6:55 PM, Jason Wang wrote:
> > On Wed, Aug 16, 2023 at 3:49=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 8/14/2023 7:21 PM, Jason Wang wrote:
> >>> On Tue, Aug 15, 2023 at 9:46=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>> ---
> >>>>    include/linux/vdpa.h | 7 +++++++
> >>>>    1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >>>> index db1b0ea..3a3878d 100644
> >>>> --- a/include/linux/vdpa.h
> >>>> +++ b/include/linux/vdpa.h
> >>>> @@ -314,6 +314,12 @@ struct vdpa_map_file {
> >>>>     *                             @iova: iova to be unmapped
> >>>>     *                             @size: size of the area
> >>>>     *                             Returns integer: success (0) or er=
ror (< 0)
> >>>> + * @reset_map:                 Reset device memory mapping (optiona=
l)
> >>>> + *                             Needed for device that using device
> >>>> + *                             specific DMA translation (on-chip IO=
MMU)
> >>> This exposes the device internal to the upper layer which is not opti=
mal.
> >> Not sure what does it mean by "device internal", but this op callback
> >> just follows existing convention to describe what vdpa parent this API
> >> targets.
> > I meant the bus tries to hide the differences among vendors. So it
> > needs to hide on-chip IOMMU stuff to the upper layer.
> >
> > We can expose two dimensional IO mappings models but it looks like
> > over engineering for this issue. More below.
> >
> >>    * @set_map:                    Set device memory mapping (optional)
> >>    *                              Needed for device that using device
> >>    *                              specific DMA translation (on-chip IO=
MMU)
> >> :
> >> :
> >>    * @dma_map:                    Map an area of PA to IOVA (optional)
> >>    *                              Needed for device that using device
> >>    *                              specific DMA translation (on-chip IO=
MMU)
> >>    *                              and preferring incremental map.
> >> :
> >> :
> >>    * @dma_unmap:                  Unmap an area of IOVA (optional but
> >>    *                              must be implemented with dma_map)
> >>    *                              Needed for device that using device
> >>    *                              specific DMA translation (on-chip IO=
MMU)
> >>    *                              and preferring incremental unmap.
> >>
> >>
> >>> Btw, what's the difference between this and a simple
> >>>
> >>> set_map(NULL)?
> >> I don't think parent drivers support this today - they can accept
> >> non-NULL iotlb containing empty map entry, but not a NULL iotlb. The
> >> behavior is undefined or it even causes panic when a NULL iotlb is
> >> passed in.
> > We can do this simple change if it can work.
> If we go with setting up 1:1 DMA mapping at virtio-vdpa .probe() and
> tearing it down at .release(), perhaps set_map(NULL) is not sufficient.
> >
> >>   Further this doesn't work with .dma_map parent drivers.
> > Probably, but I'd remove dma_map as it doesn't have any real users
> > except for the simulator.
> OK, at a point there was suggestion to get this incremental API extended
> to support batching to be in par with or even replace .set_map, not sure
> if it's too soon to conclude. But I'm okay with the removal if need be.

Yes, I think the right move in the long run is to delegate the
batching to the parent driver. This allows drivers like mlx to add
memory (like hotplugged memory) without the need of tearing down all
the old maps.

Having said that, maybe we can work on top if we need to remove
.dma_map for now.

> >
> >> The reason why a new op is needed or better is because it allows
> >> userspace to tell apart different reset behavior from the older kernel
> >> (via the F_IOTLB_PERSIST feature bit in patch 4), while this behavior
> >> could vary between parent drivers.
> > I'm ok with a new feature flag, but we need to first seek a way to
> > reuse the existing API.
> A feature flag is needed anyway. I'm fine with reusing but guess I'd
> want to converge on the direction first.
>
> Thanks,
> -Siwei
> >
> > Thanks
> >
> >> Regards,
> >> -Siwei
> >>
> >>> Thanks
> >>>
> >>>> + *                             @vdev: vdpa device
> >>>> + *                             @asid: address space identifier
> >>>> + *                             Returns integer: success (0) or erro=
r (< 0)
> >>>>     * @get_vq_dma_dev:            Get the dma device for a specific
> >>>>     *                             virtqueue (optional)
> >>>>     *                             @vdev: vdpa device
> >>>> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
> >>>>                          u64 iova, u64 size, u64 pa, u32 perm, void =
*opaque);
> >>>>           int (*dma_unmap)(struct vdpa_device *vdev, unsigned int as=
id,
> >>>>                            u64 iova, u64 size);
> >>>> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid=
);
> >>>>           int (*set_group_asid)(struct vdpa_device *vdev, unsigned i=
nt group,
> >>>>                                 unsigned int asid);
> >>>>           struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev,=
 u16 idx);
> >>>> --
> >>>> 1.8.3.1
> >>>>
>

