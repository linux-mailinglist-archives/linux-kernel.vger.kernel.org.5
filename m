Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550277B853E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbjJDQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbjJDQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D3FB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696436864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeOIY+TMASmn87xWV8+r7N8mCnLxXs+pOXJs1mPVrBE=;
        b=bhLa11pNCYZxn8lWK9a2vAfRFNHkyNy4EDfOfQ8Cpxrhh0pf9zCHXsvQ/xhmlciCuauWw1
        jOvDReGNZmGvd9N1aQkhibjkjeRQK9YWkvrQVspkBt6pUfvR6sDiBXys7KdelBdEGaeOXw
        u78SBESWGd5jtgiRyvpQCsVDkgxQyl8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-BwFdtP73PduARcASkKtT2w-1; Wed, 04 Oct 2023 12:27:42 -0400
X-MC-Unique: BwFdtP73PduARcASkKtT2w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3231f43fc5eso24931f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436860; x=1697041660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeOIY+TMASmn87xWV8+r7N8mCnLxXs+pOXJs1mPVrBE=;
        b=QU7rhN1fjVZTXRaueNVE1nS6zQ4aXykag3pxHMeyCApdl+jRKxROf3Zc7QqRxJHSoA
         TQWCBxEc0Yli5oI1HgsyoRcd57AnXbNLmm4sO0UWLqlg9H9iRJK4jNQZXH03UWj9dPaN
         5mGxs7VYgbOsYPHkpHPUiUWD9UJqNzbGBpYd/lcWcMzN/0YsEXS1+Q4EApgUWVi9EJ/3
         fI6v3cZBx82OeFUJPkC5cH0Eu4Utyemk98F9yadNaamBWMjf2MN8GlbyM+rOMhkdai7P
         F/GMXbrqhZygCaM4hYiqgwj6J9Urb346rmaYZDLpJTx+PLDGXDvYoKHyRzSXiULIeRxl
         QVrA==
X-Gm-Message-State: AOJu0YyTtkgrkwu8Er+bLmkg1Gc3c0rYrFInRLQw7cQGbMWqaEBYMdo7
        9nsmZkU5CfAWtSDT1Fb+2K/vcdpXETNyHora87gBSrR7qG5ppkc/Dy03rz/1w1m3koUWR9PA8/N
        hFmlRBm/mYsei8EqaA7prP/vXZWFQUjdz
X-Received: by 2002:adf:f08f:0:b0:318:f7a:e3c8 with SMTP id n15-20020adff08f000000b003180f7ae3c8mr2966660wro.57.1696436860469;
        Wed, 04 Oct 2023 09:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXRDIEuP3VkHPBdR8hK4Narzkji4gpOpXS4wQ4PXY81B0mBGZkcbuxvanEiTrfGdMm7v67A==
X-Received: by 2002:adf:f08f:0:b0:318:f7a:e3c8 with SMTP id n15-20020adff08f000000b003180f7ae3c8mr2966646wro.57.1696436860215;
        Wed, 04 Oct 2023 09:27:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4cc6000000b00325c7295450sm4385094wrt.3.2023.10.04.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:27:39 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:27:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, linux-kernel@vger.kernel.org,
        Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20231004122716-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWf7DzJMEUT0NcPeDLQyPkthEJZydnSSPztoCxF6PWEu1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:56:53PM +0200, Eugenio Perez Martin wrote:
> On Tue, Jul 4, 2023 at 12:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> > >
> > >
> > > On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio Pérez wrote:
> > > > > Offer this backend feature as mlx5 is compatible with it. It allows it
> > > > > to do live migration with CVQ, dynamically switching between passthrough
> > > > > and shadow virtqueue.
> > > > >
> > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > Same comment.
> > > to which?
> > >
> > > -Siwei
> >
> > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit to it
> > as a kernel/userspace ABI: what if one wants to start rings in some
> > other specific order?
> > As was discussed on list, a better promise is not to access ring
> > until the 1st kick. vdpa can then do a kick when it wants
> > the device to start accessing rings.
> >
> 
> Friendly ping about this series,
> 
> Now that VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK has been merged for
> vdpa_sim, does it make sense for mlx too?
> 
> Thanks!

For sure. I was just busy with a qemu pull, will handle this next.

> > > >
> > > > > ---
> > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > > > >   1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   #include <uapi/linux/virtio_net.h>
> > > > >   #include <uapi/linux/virtio_ids.h>
> > > > >   #include <uapi/linux/vdpa.h>
> > > > > +#include <uapi/linux/vhost_types.h>
> > > > >   #include <linux/virtio_config.h>
> > > > >   #include <linux/auxiliary_bus.h>
> > > > >   #include <linux/mlx5/cq.h>
> > > > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
> > > > >                   flush_workqueue(ndev->mvdev.wq);
> > > > >   }
> > > > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
> > > > > +{
> > > > > + return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > > > +}
> > > > > +
> > > > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > > > >   {
> > > > >           struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >           .get_vq_align = mlx5_vdpa_get_vq_align,
> > > > >           .get_vq_group = mlx5_vdpa_get_vq_group,
> > > > >           .get_device_features = mlx5_vdpa_get_device_features,
> > > > > + .get_backend_features = mlx5_vdpa_get_backend_features,
> > > > >           .set_driver_features = mlx5_vdpa_set_driver_features,
> > > > >           .get_driver_features = mlx5_vdpa_get_driver_features,
> > > > >           .set_config_cb = mlx5_vdpa_set_config_cb,
> > > > > --
> > > > > 2.39.3
> >

