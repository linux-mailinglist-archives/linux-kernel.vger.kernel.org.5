Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976957CFD16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbjJSOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346228AbjJSOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DD112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697726420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4u2h1HzTTABfYud16tqHR2RJ4RPLkgiL6UA8xD9u/Y=;
        b=MCgWJFBharvddE2OOKiJrZ3Gc0+fr17L002KV0/lBsnl3wxn82TQJ5xAylqH3JK0u9ety4
        bD3KT/w1Jx/hzFxCKeSMTG7QJhsbrZRGoARB2oOOkFLaYqES2pwCgapNtCbii1JyZWzvCv
        zc7dtq8Y35yJdlhrH0g7NBAI3oYkQw8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-b2I2h0h7PNStwNAX4H7uVQ-1; Thu, 19 Oct 2023 10:40:13 -0400
X-MC-Unique: b2I2h0h7PNStwNAX4H7uVQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7e4745acdso125790857b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726413; x=1698331213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4u2h1HzTTABfYud16tqHR2RJ4RPLkgiL6UA8xD9u/Y=;
        b=bERCl5JveU+hlpPFFQ6ykqPQOqxGJkRQR+prtu+82fOEJ3p9K8MREfOV+zvw629aV3
         HtPO234PHBQ4E26o96Dvq1bTurrsl0/Ol01rOSLSB30iPazsSXn0rU2+1mZj3hDWvPFS
         /slivxPU7gJFtlfwTUt/AQ29v3hYiZt3HEmXRE06V9+KylCYulSa7rZvBJ8WVXrnKFgp
         R7E6hj6SQMdB8xx5BdUEOp62maKsxvaPzUARfiCrUtZnIOeZy6K0OZdLKiA+u9hkGmXx
         endHtxd/rBtCUK8fAQAMRBaeS/CZh2K6Bf9v74lEEWtPkR+wetPAxZAtVNyosmLodu1N
         mD1g==
X-Gm-Message-State: AOJu0YyP6tV/46G6jJBZWObLIOUik9oO7YJw5y/o/qxkg/UJ4v1luBUc
        1PuKJsdvdl9Cb+8A0MmWZz9auOd265xWL+3+rWaf7dVY9IBW5O6T8TclAjHgipovVZbyXrQSfFh
        kbYLYP60JnYqrEpxLV18s1EEyzBSq/IiPz9ZNddtC
X-Received: by 2002:a0d:d5d0:0:b0:5a7:e3f9:a1fb with SMTP id x199-20020a0dd5d0000000b005a7e3f9a1fbmr2704412ywd.42.1697726412993;
        Thu, 19 Oct 2023 07:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE27M216kJSXFNt+uYHfOsuZep9tXyo5gAkiPaF3DMAF3OpBXuk+Q0yMxoc7EtSGgqI1/CqV4nqmO12quP6FA4=
X-Received: by 2002:a0d:d5d0:0:b0:5a7:e3f9:a1fb with SMTP id
 x199-20020a0dd5d0000000b005a7e3f9a1fbmr2704388ywd.42.1697726412574; Thu, 19
 Oct 2023 07:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com> <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com> <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
 <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com> <CACGkMEuTchn+QU1QFh98E3YfUJaUM6Vnm0ECtRbqMsA-uCR2uQ@mail.gmail.com>
In-Reply-To: <CACGkMEuTchn+QU1QFh98E3YfUJaUM6Vnm0ECtRbqMsA-uCR2uQ@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 19 Oct 2023 16:39:35 +0200
Message-ID: <CAJaqyWdMPVUd_zjd0nkQKvDmG2HPe5DBS-w5=mx4qSPCqtDJwg@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Jason Wang <jasowang@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 19, 2023 at 10:27=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Oct 19, 2023 at 2:47=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com=
> wrote:
> >
> >
> >
> > On 10/18/2023 7:53 PM, Jason Wang wrote:
> > > On Wed, Oct 18, 2023 at 4:49=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> > >>
> > >>
> > >> On 10/18/2023 12:00 AM, Jason Wang wrote:
> > >>>> Unfortunately, it's a must to stick to ABI. I agree it's a mess bu=
t we
> > >>>> don't have a better choice. Or we can fail the probe if userspace
> > >>>> doesn't ack this feature.
> > >>> Antoher idea we can just do the following in vhost_vdpa reset?
> > >>>
> > >>> config->reset()
> > >>> if (IOTLB_PERSIST is not set) {
> > >>>       config->reset_map()
> > >>> }
> > >>>
> > >>> Then we don't have the burden to maintain them in the parent?
> > >>>
> > >>> Thanks
> > >> Please see my earlier response in the other email, thanks.
> > >>
> > >> ----------------%<----------------%<----------------
> > >>
> > >> First, the ideal fix would be to leave this reset_vendor_mappings()
> > >> emulation code on the individual driver itself, which already has th=
e
> > >> broken behavior.
> > > So the point is, not about whether the existing behavior is "broken"
> > > or not.
> > Hold on, I thought earlier we all agreed upon that the existing behavio=
r
> > of vendor driver self-clearing maps during .reset violates the vhost
> > iotlb abstraction and also breaks the .set_map/.dma_map API. This is
> > 100% buggy driver implementation itself that we should discourage or
> > eliminate as much as possible (that's part of the goal for this series)=
,
>
> I'm not saying it's not an issue, what I'm saying is, if the fix
> breaks another userspace, it's a new bug in the kernel. See what Linus
> said in [1]
>
> "If a change results in user programs breaking, it's a bug in the kernel.=
"
>
> > but here you seem to go existentialism and suggests the very opposite
> > that every .set_map/.dma_map driver implementation, regardless being th=
e
> > current or the new/upcoming, should unconditionally try to emulate the
> > broken reset behavior for the sake of not breaking older userspace.
>
> Such "emulation" is not done at the parent level. New parents just
> need to implement reset_map() or not. everything could be done inside
> vhost-vDPA as pseudo code that is shown above.
>
> > Set
> > aside the criteria and definition for how userspace can be broken, can
> > we step back to the original question why we think it's broken, and wha=
t
> > we can do to promote good driver implementation instead of discuss the
> > implementation details?
>
> I'm not sure I get the point of this question. I'm not saying we don't
> need to fix, what I am saying is that such a fix must be done in a
> negotiable way. And it's better if parents won't get any burden. It
> can just decide to implement reset_map() or not.
>
> > Reading the below response I found my major
> > points are not heard even if written for quite a few times.
>
> I try my best to not ignore any important things, but I can't promise
> I will not miss any. I hope the above clarifies my points.
>
> > It's not
> > that I don't understand the importance of not breaking old userspace, I
> > appreciate your questions and extra patience, however I do feel the
> > "broken" part is very relevant to our discussion here.
> > If it's broken (in the sense of vhost IOTLB API) that you agree, I thin=
k
> > we should at least allow good driver implementations; and when you thin=
k
> > about the possibility of those valid good driver cases
> > (.set_map/.dma_map implementations that do not clear maps in .reset),
> > you might be able to see why it's coded the way as it is now.
> >
> > >   It's about whether we could stick to the old behaviour without
> > > too much cost. And I believe we could.
> > >
> > > And just to clarify here, reset_vendor_mappings() =3D config->reset_m=
ap()
> > >
> > >> But today there's no backend feature negotiation
> > >> between vhost-vdpa and the parent driver. Do we want to send down th=
e
> > >> acked_backend_features to parent drivers?
> > > There's no need to do that with the above code, or anything I missed =
here?
> > >
> > > config->reset()
> > > if (IOTLB_PERSIST is not set) {
> > >        config->reset_map()
> > > }
> > Implementation issue: this implies reset_map() has to be there for ever=
y
> > .set_map implementations, but vendor driver implementation for custom
> > IOMMU could well implement DMA ops by itself instead of .reset_map. Thi=
s
> > won't work for every set_map driver (think about the vduse case).
>
> Well let me do it once again, reset_map() is not mandated:
>
> config->reset()
> if (IOTLB_PERSIST is not set) {
>     if (config->reset_map)
>           config->reset_map()

To avoid new parent drivers to have this behavior if they need to
implement reset_map,

What if we add a new callback like "config->buggy_virtio_reset_map",
different from regular reset_map callback at cleanup? Only mlx5 and
vdpa_sim need to implement it, with a big warning, and new parent
drivers can trust they'll never have the old bad behavior.

> }
>
> Did you see any issue with VDUSE in this case?
>
> >
> > But this is not the the point I was making. I think if you agree this i=
s
> > purely buggy driver implementation of its own, we should try to isolate
> > this buggy behavior to individual driver rather than overload vhost-vdp=
a
> > or vdpa core's role to help implement the emulation of broken driver
> > behavior.
>
> As I pointed out, if it is not noticeable in the userspace, that's
> fine but it's not.
>
> > I don't get why .reset is special here, the abuse of .reset to
> > manipulate mapping could also happen in other IOMMU unrelated driver
> > entries like in .suspend, or in queue_reset.
>
> Who can abuse reset here? It is totally under the control of
> vhost-vDPA and it's not visible to uAPI. And we can fully control the
> behaviour of vhost-vDPA.
>
> > If someday userspace is
> > found coded around similar buggy driver implementation in other driver
> > ops, do we want to follow and duplicate the same emulation in vdpa core
> > as the precedent is already set here around .reset?
>
> I think so, have you seen the links I give you? If you want to go
> through the one from Linus thread[1], you can see the one that unbreak
> virtio-IOMMU[2]:
>
> 1) Someday, we spot invalidate with size 0 is a bug
> 2) We fix this bug by not allowing this
> 3) But virtio-IOMMU userspace find that size 0 actually clean all the
> IOTLB so it depends on the behaviour
> 4) So the virtio-IOMMU userspace find it can't work after 2)
> 5) Then we recover the behaviour before 2) via [2]
>
> Another example is the IOTLB_MSG_V2, V1 suffers from in-stable ABI in
> 32bit archs, most of the userspace survives since it never runs on
> 32bit archs. The fix is to introduce a V2 but we will stick to V1 by
> default if V2 is not acknowledged by the userspace.
>
> I think the above 2 examples are sufficient for us to understand the
> case. If not, I can help to clarify more since I'm involved in those 2
> fixes.
>
> > The buggy driver can fail in a lot of other ways indefinitely during
> > reset, if there's a buggy driver that's already broken the way as how i=
t
> > is and happens to survive with all userspace apps, we just don't care
> > and let it be.
>
> Without IOTLB_PRESIST it doesn't break. With IOTLB_PERSIST and if the
> reset_map() is done unconditionally, it can break. That's my point.
>
> > There's no way we can enumerate all those buggy behaviors
> > in .reset_map itself, it's overloading that driver API too much.
>
> If it is not noticeable by userspace, we can do any fix at will. But
> it is not, we don't have another choice. Especially considering the
> cost is rather low.
>
> > >> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
> > >> backend feature negotiation in parent driver, if vhost-vdpa has to
> > >> provide the old-behaviour emulation for compatibility on driver's
> > >> behalf, it needs to be done per-driver basis. There could be good
> > >> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB=
 in
> > >> .reset, and vendor specific IOMMU doesn't have to provide .reset_map=
,
> > > Then we just don't offer IOTLB_PRESIST, isn't this by design?
> > Think about the vduse case, it can work with DMA ops directly so doesn'=
t
> > have to implement .reset_map, unless for some specific good reason.
> > Because it's a conforming and valid/good driver implementation, we may
> > still allow it to advertise IOTLB_PERSIST to userspace.
>
> I would like to know why this can't work in this case:
>
> config->reset()
> if (IOTLB_PERSIST is not set) {
>     if (config->reset_map)
>           config->reset_map()
> }
>
> > Which belongs to
> > the 3rd bullet below:
> >
> > https://lore.kernel.org/virtualization/1696928580-7520-4-git-send-email=
-si-wei.liu@oracle.com/
> >
> > There are 3 cases that backend may claim this feature bit on:
> >
> > - parent device that has to work with platform IOMMU
> > - parent device with on-chip IOMMU that has the expected
> >    .reset_map support in driver
> > - parent device with vendor specific IOMMU implementation
> >    that explicitly declares the specific backend feature
> >
> > >
> > >> we
> > >> should allow these good driver implementations rather than
> > >> unconditionally stick to some specific problematic behavior for ever=
y
> > >> other good driver.
> > > Then you can force reset_map() with set_map() that is what I suggest
> > > in another thread, no?
> > This is exactly what I was afraid of that broken behavior emulation may
> > become a dangerous slippery slope - in principle we should encourage
> > good driver implementation, as they can work totally fine with older
> > userspace. Why do they have to bother emulating broken behavior just
> > because some other driver's misbehaving?
>
> Please read the link [1], Linus has explained it.
>
> > And what's the boundary for
> > this hack, do drivers backed by platform IOMMU even have to emulate (if
> > not why not, and is there substantial difference in between)?
>
> The boundary is whether the behaviour change could be noticed but
> userspace. And I've shown you it's not a burden with the pseudo codes.
> If not, please explain why.
>
> > After
> > getting through all of this, do you still believe everything is just as
> > easy and simple as what thought to be?
>
> The truth is that bugs exist everywhere. We can't promise there's no
> bug when developing an uAPI or subsystem. For kernel code, the bug
> that touches uAPI might be fixed in a way that doesn't break existing
> userspace. If you look at how downstream to maintain kABI, you will be
> supersized furtherly.
>
> >
> > Btw, I thought I was expecting but still haven't got the clear answers
> > to what was the goal to do all this, we spent a lot of time trying to
> > unbreak userspace,
>
> The code is pretty simple. But yes, the time spent on justifying it
> might take some time. That's the community. People need time to
> understand each other's points.
>
> > but looks to me as if we were trying every possible
> > way to break userspace
>
> How could my suggestions break a userspace?
>
> > or try to approximate to the same brokenness
> > mlx5_vdpa may have caused to the userspace. What we will get eventually
> > from these lengthy discussions?
>
> Siwei, I'd really suggest you read the link I gave you. You may get
> the answer. What's more, It doesn't cost too much then we know for
> sure there would not be any issue, why not choose the hard way?
>
> > On the other hand, if you think it from
> > vhost-vdpa user perspective, you'll clearly see there's just a couple o=
f
> > ways to unbreak userspace from the internal broken map which is out of
> > sync with vhost-vdpa iotlb after device reset.
>
> Patches are more than welcomed.
>
> > If this brokenness was
> > something universally done from the vhost-vdpa layer itself, I'd feel
> > it's more of a shared problem, but this is not the case I see it here.
> > While the long standing mlx5_vdpa/vdpa_sim issue is 100% misuse of
> > .reset op in a wrong way per IOMMU API definition. Why leaving this
> > discrepancy to the individual driver is not even an option, I'm still
> > not sure?
>
> Sorry? I start with a switch in the driver, and then I try to avoid
> that. And it seems you don't want a burden on the driver as well.
> Where did you see I say we can't do that in the driver? What I
> disagree with is to use a module parameter.
>
> Even if I fail, it doesn't mean we can't do that in the driver code.
> If you read the link[1] you can see the offending commit is a change
> in uvcvideo driver.
>
> Thanks
>
> >
> >
> > Thanks,
> > -Siwei
> >
> > >
> > >> Then we need a set of device flags (backend_features
> > >> bit again?) to indicate the specific driver needs upper layer's help=
 on
> > >> old-behaviour emulation.
> > >>
> > >> Last but not least, I'm not sure how to properly emulate
> > >> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver ha=
s no
> > >> .reset_map op implemented, or if .reset_map has a slightly different
> > >> implementation than what it used to reset the iotlb in the .reset op=
,
> > > See above, for reset_vendor_mappings() I meant config->reset_map() ex=
actly.
> > >
> > > Thanks
> > >
> > >> then this either becomes effectively dead code if no one ends up usi=
ng,
> > >> or the vhost-vdpa emulation is helpless and limited in scope, unable=
 to
> > >> cover all the cases.
> > >>
> > >> ----------------%<----------------%<----------------
> > >>
> >
>

