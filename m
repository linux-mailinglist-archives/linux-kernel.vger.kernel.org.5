Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08A75A1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGSW21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGSW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5362126
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689805607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRWr26/a3fW93qtfogg6jzmjztOmv2YuNrAH4tmN+jk=;
        b=gwAcUwK0THVyalMjP7ZGy4aKvIc7OoD9s73Ivzbv1KoBm2LaCej72DS0WDpNT49XpDaAXO
        bGnVooqmyjxzwhFDfLEVzsbtrp4pvE3XsUHlbeKcGK42reheDPg2Jy0IScBf2ohpFGLowh
        YhRALINxufYyc95bNVOhny7b+aQ+oWo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-eL2zextNO3OtDRkmx2bncw-1; Wed, 19 Jul 2023 18:26:45 -0400
X-MC-Unique: eL2zextNO3OtDRkmx2bncw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30932d15a30so97851f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805604; x=1692397604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRWr26/a3fW93qtfogg6jzmjztOmv2YuNrAH4tmN+jk=;
        b=JJZKw1P7i/r+SBpckXZnyIb7dzAxh2SfrtQaQNKBnwr5cpl4hSczbxgkQm1HXNnFGq
         EReGW/Z36QbdQnMlrPVGZNUkZERNT4hxfITUqkqFcgwgZzsNCjCReMVk90SIvbu8IeyQ
         IuUCXtW6fitu4XJtdcKd42IblGD83sN5w+ZgdRNT6Foc3heljhEk243FFfseQ47BQlvT
         FNXgn6nyvvkJrcN3ClMxyR4xuCGsidl2ZOd4P2sBBcsl5S5imT5pY4M0DhRvXLpfO/Cx
         O1Ww2KsgQfCZLtx0R4JhKh6/DguaEldCC0y5pyE7BIbiwImx1/aWsVLVQfypTHTGINYH
         z3Kw==
X-Gm-Message-State: ABy/qLY7p1n0m0aAdJ/zyvPpfxsevf24pxMlKPMzQGEuxrisUfSevARx
        HpO4RNWVGz2wgbaHwGaMoTH1qURoVvX98NA+9HuHOT2MplRuPSPx25HhzJK/SEGj8HTeursqxNw
        Jk9a+cEB3Ee1YO0fHfp04rUA/
X-Received: by 2002:a05:6000:1042:b0:315:adee:1297 with SMTP id c2-20020a056000104200b00315adee1297mr891986wrx.10.1689805604600;
        Wed, 19 Jul 2023 15:26:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvlUX8tU5JXgVBrbk/KZWgr/MLOWrxY/kV5bYVSTY8sYIDCMK2pUOuvQQKyWa5poxeJ9b+2A==
X-Received: by 2002:a05:6000:1042:b0:315:adee:1297 with SMTP id c2-20020a056000104200b00315adee1297mr891970wrx.10.1689805604145;
        Wed, 19 Jul 2023 15:26:44 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d5347000000b003143add4396sm6313184wrv.22.2023.07.19.15.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:26:43 -0700 (PDT)
Date:   Wed, 19 Jul 2023 18:26:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230719182112-mutt-send-email-mst@kernel.org>
References: <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
 <20230706020603-mutt-send-email-mst@kernel.org>
 <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:20:03PM -0700, Si-Wei Liu wrote:
> 
> 
> On 7/5/2023 11:07 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 05, 2023 at 05:07:11PM -0700, Shannon Nelson wrote:
> > > On 7/5/23 11:27 AM, Eugenio Perez Martin wrote:
> > > > On Wed, Jul 5, 2023 at 9:50 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Tue, Jul 4, 2023 at 11:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Tue, Jul 04, 2023 at 01:36:11PM +0200, Eugenio Perez Martin wrote:
> > > > > > > On Tue, Jul 4, 2023 at 12:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > > > > > > > > On Mon, Jul 3, 2023 at 4:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio Pérez wrote:
> > > > > > > > > > > With the current code it is accepted as long as userland send it.
> > > > > > > > > > > 
> > > > > > > > > > > Although userland should not set a feature flag that has not been
> > > > > > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code will not
> > > > > > > > > > > complain for it.
> > > > > > > > > > > 
> > > > > > > > > > > Since there is no specific reason for any parent to reject that backend
> > > > > > > > > > > feature bit when it has been proposed, let's control it at vdpa frontend
> > > > > > > > > > > level. Future patches may move this control to the parent driver.
> > > > > > > > > > > 
> > > > > > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
> > > > > > > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > > > > > Please do send v3. And again, I don't want to send "after driver ok" hack
> > > > > > > > > > upstream at all, I merged it in next just to give it some testing.
> > > > > > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > > > > > > 
> > > > > > > > > Current devices do not support that semantic.
> > > > > > > > Which devices specifically access the ring after DRIVER_OK but before
> > > > > > > > a kick?
> > > The PDS vdpa device can deal with a call to .set_vq_ready after DRIVER_OK is
> > > set.  And I'm told that our VQ activity should start without a kick.
> > > 
> > > Our vdpa device FW doesn't currently have support for VIRTIO_F_RING_RESET,
> > > but I believe it could be added without too much trouble.
> > > 
> > > sln
> > > 
> > OK it seems clear at least in the current version pds needs
> > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
> > However can we also code up the RING_RESET path as the default?
> What's the rationale of making RING_RESET path the default? Noted this is on
> a performance critical path (for live migration downtime), did we ever get
> consensus from every or most hardware vendors that RING_RESET has lower cost
> in terms of latency overall than ENABLE_AFTER_DRIVER_OK? I think (RING)RESET
> in general falls on the slow path for hardware, while I assume either
> RING_RESET or ENABLE_AFTER_DRIVER_OK doesn't matters much on software backed
> vdpa e.g. vp_vdpa. Maybe should make ENABLE_AFTER_DRIVER_OK as the default?
> 
> -Siwei

Coming from the spec RING_RESET has clearer semantics.
As long as we support it it is not critical which one
is the default though.


> > Then down the road vendors can choose what to do.
> > 
> > 
> > 
> > 
> > 
> > > > > > > Previous versions of the QEMU LM series did a spurious kick to start
> > > > > > > traffic at the LM destination [1]. When it was proposed, that spurious
> > > > > > > kick was removed from the series because to check for descriptors
> > > > > > > after driver_ok, even without a kick, was considered work of the
> > > > > > > parent driver.
> > > > > > > 
> > > > > > > I'm ok to go back to this spurious kick, but I'm not sure if the hw
> > > > > > > will read the ring before the kick actually. I can ask.
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > 
> > > > > > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg02775.html
> > > > > > Let's find out. We need to check for ENABLE_AFTER_DRIVER_OK too, no?
> > > > > My understanding is [1] assuming ACCESS_AFTER_KICK. This seems
> > > > > sub-optimal than assuming ENABLE_AFTER_DRIVER_OK.
> > > > > 
> > > > > But this reminds me one thing, as the thread is going too long, I
> > > > > wonder if we simply assume ENABLE_AFTER_DRIVER_OK if RING_RESET is
> > > > > supported?
> > > > > 
> > > > The problem with that is that the device needs to support all
> > > > RING_RESET, like to be able to change vq address etc after DRIVER_OK.
> > > > Not all HW support it.
> > > > 
> > > > We just need the subset of having the dataplane freezed until all CVQ
> > > > commands have been consumed. I'm sure current vDPA code already
> > > > supports it in some devices, like MLX and PSD.
> > > > 
> > > > Thanks!
> > > > 
> > > > > Thanks
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > > My plan was to convert
> > > > > > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > > > > > > > > was not explicit enough.
> > > > > > > > > 
> > > > > > > > > The only solution I can see to that is to trap & emulate in the vdpa
> > > > > > > > > (parent?) driver, as talked in virtio-comment. But that complicates
> > > > > > > > > the architecture:
> > > > > > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > > > > > * Store vq enable state separately, at
> > > > > > > > > vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> > > > > > > > > * Store the doorbell state separately, but do not configure it to the
> > > > > > > > > device directly.
> > > > > > > > > 
> > > > > > > > > But how to recover if the device cannot configure them at kick time,
> > > > > > > > > for example?
> > > > > > > > > 
> > > > > > > > > Maybe we can just fail if the parent driver does not support enabling
> > > > > > > > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > > > > > > > > 
> > > > > > > > > Thanks!
> > > > > > > > > 
> > > > > > > > > > > ---
> > > > > > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/git/mst
> > > > > > > > > > > commit. Please let me know if I should send a v3 of [1] instead.
> > > > > > > > > > > 
> > > > > > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@kernel.org/T/
> > > > > > > > > > > ---
> > > > > > > > > > >    drivers/vhost/vdpa.c | 7 +++++--
> > > > > > > > > > >    1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > > > >    {
> > > > > > > > > > >         struct vhost_vdpa *v = filep->private_data;
> > > > > > > > > > >         struct vhost_dev *d = &v->vdev;
> > > > > > > > > > > +     const struct vdpa_config_ops *ops = v->vdpa->config;
> > > > > > > > > > >         void __user *argp = (void __user *)arg;
> > > > > > > > > > >         u64 __user *featurep = argp;
> > > > > > > > > > > -     u64 features;
> > > > > > > > > > > +     u64 features, parent_features = 0;
> > > > > > > > > > >         long r = 0;
> > > > > > > > > > > 
> > > > > > > > > > >         if (cmd == VHOST_SET_BACKEND_FEATURES) {
> > > > > > > > > > >                 if (copy_from_user(&features, featurep, sizeof(features)))
> > > > > > > > > > >                         return -EFAULT;
> > > > > > > > > > > +             if (ops->get_backend_features)
> > > > > > > > > > > +                     parent_features = ops->get_backend_features(v->vdpa);
> > > > > > > > > > >                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > > > > > > > >                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > > > > > > > >                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > > > > > > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
> > > > > > > > > > > +                              parent_features))
> > > > > > > > > > >                         return -EOPNOTSUPP;
> > > > > > > > > > >                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > > > > > >                      !vhost_vdpa_can_suspend(v))
> > > > > > > > > > > --
> > > > > > > > > > > 2.39.3
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

