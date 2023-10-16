Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B17C9EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjJPFbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjJPFbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D9E6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697434226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1C2WXsdOvEFkNHl/IhfFcAYtP0vCH8zsN+6evhNM07I=;
        b=YzQQr/6pPyugtQqVNxhhoD2ByU9LObvTDMWozoUg+31bF1FxHqJLmF/9AHvBEgGf5a8QHu
        il6cXAwey8d5+YaXp/ileTsVOxPOrkMAMWhiMQyJMrVGdW+uhk/bVG38QGzoFcK8iTDdl8
        1l0ifecnfk9NchPOebHASzEyDpEOl18=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-RnPVrS36PAaNQ34Wv-2Hmw-1; Mon, 16 Oct 2023 01:30:20 -0400
X-MC-Unique: RnPVrS36PAaNQ34Wv-2Hmw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c520e0a9a7so5847591fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697434218; x=1698039018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C2WXsdOvEFkNHl/IhfFcAYtP0vCH8zsN+6evhNM07I=;
        b=XfQ1Sy4Y6isTKm5LJLXYFaelhPIKxToKqmQL97aN+F2LN4GcM13UVD3h4HoUGCPgLE
         EO9XmKqQXyXJPJxC+l96lVeUufhHlIVOUCCC4FcXTB9plthhO1R0kDck9Xl0BlyrtAvN
         EnXw4ZP5fnGhEcfQDqVzocyofAAKvp+CgOo2OzCcALz3+oaxLaBBshn4lFQzeT6GSoJX
         hmIp2IXmVae3AXVOgLxmB/jby99qXy2CMqM9I6ZPw0vUkiWDPk5IVn18wDP+dTnELZEo
         gUDlWCUPT2sn5cWKlnucmOI8CSJ54pBI1I83Ub50KXCEswd26uY/Wbrfu8oToFwaBrjJ
         ocGQ==
X-Gm-Message-State: AOJu0YyyI6WiAedkELqGqbeLN+7rXC+XGS91E72cOzpJf2pOAvbUgjQ5
        boMcQuU8MTW/Cd2YiB1aV68JOM4c0rjQZ/hwfYTAUbAa5urB1N0dqZB53IrB3FQjcMQoU45sk/r
        CcvYeRRmdeFaPPWPZdtorluWu8bx5RN8BrtAelyDH
X-Received: by 2002:a2e:850f:0:b0:2c5:2103:604b with SMTP id j15-20020a2e850f000000b002c52103604bmr1773605lji.2.1697434218617;
        Sun, 15 Oct 2023 22:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRBikMoE5QFf7VlNg+iTYDUs31qOow+BkmsjVhIQbfuhtzvOIE+ECRPPPCCN0d/sXlFyh85ZZGVE/CxzHrr/E=
X-Received: by 2002:a2e:850f:0:b0:2c5:2103:604b with SMTP id
 j15-20020a2e850f000000b002c52103604bmr1773588lji.2.1697434218254; Sun, 15 Oct
 2023 22:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com> <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
 <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
In-Reply-To: <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 16 Oct 2023 13:30:07 +0800
Message-ID: <CACGkMEvC3BsApy1XR0mVAOmy4sdon=Mk02=pkgm4BPs_98NP3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/12/2023 7:49 PM, Jason Wang wrote:
> > On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Device specific IOMMU parent driver who wishes to see mapping to be
> >> decoupled from virtio or vdpa device life cycle (device reset) can use
> >> it to restore memory mapping in the device IOMMU to the initial or
> >> default state. The reset of mapping is done per address space basis.
> >>
> >> The reason why a separate .reset_map op is introduced is because this
> >> allows a simple on-chip IOMMU model without exposing too much device
> >> implementation details to the upper vdpa layer. The .dma_map/unmap or
> >> .set_map driver API is meant to be used to manipulate the IOTLB mappin=
gs,
> >> and has been abstracted in a way similar to how a real IOMMU device ma=
ps
> >> or unmaps pages for certain memory ranges. However, apart from this th=
ere
> >> also exists other mapping needs, in which case 1:1 passthrough mapping
> >> has to be used by other users (read virtio-vdpa). To ease parent/vendo=
r
> >> driver implementation and to avoid abusing DMA ops in an unexpacted wa=
y,
> >> these on-chip IOMMU devices can start with 1:1 passthrough mapping mod=
e
> >> initially at the he time of creation. Then the .reset_map op can be us=
ed
> >> to switch iotlb back to this initial state without having to expose a
> >> complex two-dimensional IOMMU device model.
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   include/linux/vdpa.h | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> index d376309..26ae6ae 100644
> >> --- a/include/linux/vdpa.h
> >> +++ b/include/linux/vdpa.h
> >> @@ -327,6 +327,15 @@ struct vdpa_map_file {
> >>    *                             @iova: iova to be unmapped
> >>    *                             @size: size of the area
> >>    *                             Returns integer: success (0) or error=
 (< 0)
> >> + * @reset_map:                 Reset device memory mapping to the def=
ault
> >> + *                             state (optional)
> > I think we need to mention that this is a must for parents that use set=
_map()?
> It's not a must IMO, some .set_map() user for e.g. VDUSE or vdpa-sim-blk
> can deliberately choose to implement .reset_map() depending on its own
> need. Those user_va software devices mostly don't care about mapping
> cost during reset, as they don't have to pin kernel memory in general.
> It's just whether or not they care about mapping being decoupled from
> device reset at all.

Ok, let's document this in the changelog at least.

Thanks

>
> And the exact implementation requirement of this interface has been
> documented right below.
>
> -Siwei
> >
> > Other than this:
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
> >
> >> + *                             Needed for devices that are using devi=
ce
> >> + *                             specific DMA translation and prefer ma=
pping
> >> + *                             to be decoupled from the virtio life c=
ycle,
> >> + *                             i.e. device .reset op does not reset m=
apping
> >> + *                             @vdev: vdpa device
> >> + *                             @asid: address space identifier
> >> + *                             Returns integer: success (0) or error =
(< 0)
> >>    * @get_vq_dma_dev:            Get the dma device for a specific
> >>    *                             virtqueue (optional)
> >>    *                             @vdev: vdpa device
> >> @@ -405,6 +414,7 @@ struct vdpa_config_ops {
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

