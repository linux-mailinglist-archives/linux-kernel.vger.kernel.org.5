Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30367CF28C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjJSI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjJSI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14683121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697704042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2G4zecJC1Uyre6wGpwpry6n4Bhoo+SM8dhVUO7iFTo=;
        b=T1G502qtnrXhF1292wAraD+9ZpEBO4lqY/Dytk5h8ndTjgD57UORACYjspteF6ehJr9fwq
        XHzFWz8dO+p08aOcS4hn0bEK4HVtyVgiOwGzfq5A4mbYlXZx2aB4Nk9PDWGxJhz9E0CZTr
        DArZSpkwkQtBFnMmusACza4oq0cam6k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-V4crxPMaMIuspnAZ0KFX5A-1; Thu, 19 Oct 2023 04:27:20 -0400
X-MC-Unique: V4crxPMaMIuspnAZ0KFX5A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507d2e150c2so222676e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697704039; x=1698308839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2G4zecJC1Uyre6wGpwpry6n4Bhoo+SM8dhVUO7iFTo=;
        b=Xs2pucn5yf/EY/niI4kBkjt6I2x9ottfQGQw0lraO+eRTIn/DVzKSko/XRDoFhivU6
         T4jwr4u3Z/gEbk0JFz38rKX8/V5B814cBwWajKuCkYW9Ygov/Td0XDeZNn3lfira0tlF
         bsZmjk1HJND9ugcOFq22+uJqneNHZtGX0I7Xs17ml2ueaK4UZ8WfWPZ5GrvqdHlu0jbZ
         19JR53s6S5ZxEZrOTXab7XhSdI7viSCpYz6ZlkreD/x2804VQmaiyh8hTW3VVdSmL3DW
         eH0KaxqtFdt7aGVeDwesuLxlG4Z4CJpU2xIRGouPOhxxjV+g/fvgsSZ8Hxy0RSYZIhGe
         tHbg==
X-Gm-Message-State: AOJu0YxsZ3Kjmelu8lSYmu9OVFwaHbU87QzDuJEqNhR+/F+dJ+AJ6DTG
        IbG6/snpMl4iZ2+U052Ps36uuvYbmCuAoQF6dJwAPxjmPxI3Xrgd/ofnc4hTf+iBpkjhTLsGcxS
        VC5vswxvqDD3vwGGPn2pVWADQnV2/hIMYV9o4SIwc3izacOZUc6gkwQ==
X-Received: by 2002:ac2:4c17:0:b0:507:99fe:3237 with SMTP id t23-20020ac24c17000000b0050799fe3237mr852927lfq.41.1697704038642;
        Thu, 19 Oct 2023 01:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYltgL5jwvRMZQtG+RQEZgUi1eaa7CjHchnZae03uEUn+E/AnVBRmiA8gqTIBp2WSWfjk7CL2Pclag1K2IY3w=
X-Received: by 2002:ac2:4c17:0:b0:507:99fe:3237 with SMTP id
 t23-20020ac24c17000000b0050799fe3237mr852906lfq.41.1697704038139; Thu, 19 Oct
 2023 01:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com> <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com> <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
 <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
In-Reply-To: <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 Oct 2023 16:27:06 +0800
Message-ID: <CACGkMEuTchn+QU1QFh98E3YfUJaUM6Vnm0ECtRbqMsA-uCR2uQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
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

On Thu, Oct 19, 2023 at 2:47=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/18/2023 7:53 PM, Jason Wang wrote:
> > On Wed, Oct 18, 2023 at 4:49=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 10/18/2023 12:00 AM, Jason Wang wrote:
> >>>> Unfortunately, it's a must to stick to ABI. I agree it's a mess but =
we
> >>>> don't have a better choice. Or we can fail the probe if userspace
> >>>> doesn't ack this feature.
> >>> Antoher idea we can just do the following in vhost_vdpa reset?
> >>>
> >>> config->reset()
> >>> if (IOTLB_PERSIST is not set) {
> >>>       config->reset_map()
> >>> }
> >>>
> >>> Then we don't have the burden to maintain them in the parent?
> >>>
> >>> Thanks
> >> Please see my earlier response in the other email, thanks.
> >>
> >> ----------------%<----------------%<----------------
> >>
> >> First, the ideal fix would be to leave this reset_vendor_mappings()
> >> emulation code on the individual driver itself, which already has the
> >> broken behavior.
> > So the point is, not about whether the existing behavior is "broken"
> > or not.
> Hold on, I thought earlier we all agreed upon that the existing behavior
> of vendor driver self-clearing maps during .reset violates the vhost
> iotlb abstraction and also breaks the .set_map/.dma_map API. This is
> 100% buggy driver implementation itself that we should discourage or
> eliminate as much as possible (that's part of the goal for this series),

I'm not saying it's not an issue, what I'm saying is, if the fix
breaks another userspace, it's a new bug in the kernel. See what Linus
said in [1]

"If a change results in user programs breaking, it's a bug in the kernel."

> but here you seem to go existentialism and suggests the very opposite
> that every .set_map/.dma_map driver implementation, regardless being the
> current or the new/upcoming, should unconditionally try to emulate the
> broken reset behavior for the sake of not breaking older userspace.

Such "emulation" is not done at the parent level. New parents just
need to implement reset_map() or not. everything could be done inside
vhost-vDPA as pseudo code that is shown above.

> Set
> aside the criteria and definition for how userspace can be broken, can
> we step back to the original question why we think it's broken, and what
> we can do to promote good driver implementation instead of discuss the
> implementation details?

I'm not sure I get the point of this question. I'm not saying we don't
need to fix, what I am saying is that such a fix must be done in a
negotiable way. And it's better if parents won't get any burden. It
can just decide to implement reset_map() or not.

> Reading the below response I found my major
> points are not heard even if written for quite a few times.

I try my best to not ignore any important things, but I can't promise
I will not miss any. I hope the above clarifies my points.

> It's not
> that I don't understand the importance of not breaking old userspace, I
> appreciate your questions and extra patience, however I do feel the
> "broken" part is very relevant to our discussion here.
> If it's broken (in the sense of vhost IOTLB API) that you agree, I think
> we should at least allow good driver implementations; and when you think
> about the possibility of those valid good driver cases
> (.set_map/.dma_map implementations that do not clear maps in .reset),
> you might be able to see why it's coded the way as it is now.
>
> >   It's about whether we could stick to the old behaviour without
> > too much cost. And I believe we could.
> >
> > And just to clarify here, reset_vendor_mappings() =3D config->reset_map=
()
> >
> >> But today there's no backend feature negotiation
> >> between vhost-vdpa and the parent driver. Do we want to send down the
> >> acked_backend_features to parent drivers?
> > There's no need to do that with the above code, or anything I missed he=
re?
> >
> > config->reset()
> > if (IOTLB_PERSIST is not set) {
> >        config->reset_map()
> > }
> Implementation issue: this implies reset_map() has to be there for every
> .set_map implementations, but vendor driver implementation for custom
> IOMMU could well implement DMA ops by itself instead of .reset_map. This
> won't work for every set_map driver (think about the vduse case).

Well let me do it once again, reset_map() is not mandated:

config->reset()
if (IOTLB_PERSIST is not set) {
    if (config->reset_map)
          config->reset_map()
}

Did you see any issue with VDUSE in this case?

>
> But this is not the the point I was making. I think if you agree this is
> purely buggy driver implementation of its own, we should try to isolate
> this buggy behavior to individual driver rather than overload vhost-vdpa
> or vdpa core's role to help implement the emulation of broken driver
> behavior.

As I pointed out, if it is not noticeable in the userspace, that's
fine but it's not.

> I don't get why .reset is special here, the abuse of .reset to
> manipulate mapping could also happen in other IOMMU unrelated driver
> entries like in .suspend, or in queue_reset.

Who can abuse reset here? It is totally under the control of
vhost-vDPA and it's not visible to uAPI. And we can fully control the
behaviour of vhost-vDPA.

> If someday userspace is
> found coded around similar buggy driver implementation in other driver
> ops, do we want to follow and duplicate the same emulation in vdpa core
> as the precedent is already set here around .reset?

I think so, have you seen the links I give you? If you want to go
through the one from Linus thread[1], you can see the one that unbreak
virtio-IOMMU[2]:

1) Someday, we spot invalidate with size 0 is a bug
2) We fix this bug by not allowing this
3) But virtio-IOMMU userspace find that size 0 actually clean all the
IOTLB so it depends on the behaviour
4) So the virtio-IOMMU userspace find it can't work after 2)
5) Then we recover the behaviour before 2) via [2]

Another example is the IOTLB_MSG_V2, V1 suffers from in-stable ABI in
32bit archs, most of the userspace survives since it never runs on
32bit archs. The fix is to introduce a V2 but we will stick to V1 by
default if V2 is not acknowledged by the userspace.

I think the above 2 examples are sufficient for us to understand the
case. If not, I can help to clarify more since I'm involved in those 2
fixes.

> The buggy driver can fail in a lot of other ways indefinitely during
> reset, if there's a buggy driver that's already broken the way as how it
> is and happens to survive with all userspace apps, we just don't care
> and let it be.

Without IOTLB_PRESIST it doesn't break. With IOTLB_PERSIST and if the
reset_map() is done unconditionally, it can break. That's my point.

> There's no way we can enumerate all those buggy behaviors
> in .reset_map itself, it's overloading that driver API too much.

If it is not noticeable by userspace, we can do any fix at will. But
it is not, we don't have another choice. Especially considering the
cost is rather low.

> >> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
> >> backend feature negotiation in parent driver, if vhost-vdpa has to
> >> provide the old-behaviour emulation for compatibility on driver's
> >> behalf, it needs to be done per-driver basis. There could be good
> >> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB i=
n
> >> .reset, and vendor specific IOMMU doesn't have to provide .reset_map,
> > Then we just don't offer IOTLB_PRESIST, isn't this by design?
> Think about the vduse case, it can work with DMA ops directly so doesn't
> have to implement .reset_map, unless for some specific good reason.
> Because it's a conforming and valid/good driver implementation, we may
> still allow it to advertise IOTLB_PERSIST to userspace.

I would like to know why this can't work in this case:

config->reset()
if (IOTLB_PERSIST is not set) {
    if (config->reset_map)
          config->reset_map()
}

> Which belongs to
> the 3rd bullet below:
>
> https://lore.kernel.org/virtualization/1696928580-7520-4-git-send-email-s=
i-wei.liu@oracle.com/
>
> There are 3 cases that backend may claim this feature bit on:
>
> - parent device that has to work with platform IOMMU
> - parent device with on-chip IOMMU that has the expected
>    .reset_map support in driver
> - parent device with vendor specific IOMMU implementation
>    that explicitly declares the specific backend feature
>
> >
> >> we
> >> should allow these good driver implementations rather than
> >> unconditionally stick to some specific problematic behavior for every
> >> other good driver.
> > Then you can force reset_map() with set_map() that is what I suggest
> > in another thread, no?
> This is exactly what I was afraid of that broken behavior emulation may
> become a dangerous slippery slope - in principle we should encourage
> good driver implementation, as they can work totally fine with older
> userspace. Why do they have to bother emulating broken behavior just
> because some other driver's misbehaving?

Please read the link [1], Linus has explained it.

> And what's the boundary for
> this hack, do drivers backed by platform IOMMU even have to emulate (if
> not why not, and is there substantial difference in between)?

The boundary is whether the behaviour change could be noticed but
userspace. And I've shown you it's not a burden with the pseudo codes.
If not, please explain why.

> After
> getting through all of this, do you still believe everything is just as
> easy and simple as what thought to be?

The truth is that bugs exist everywhere. We can't promise there's no
bug when developing an uAPI or subsystem. For kernel code, the bug
that touches uAPI might be fixed in a way that doesn't break existing
userspace. If you look at how downstream to maintain kABI, you will be
supersized furtherly.

>
> Btw, I thought I was expecting but still haven't got the clear answers
> to what was the goal to do all this, we spent a lot of time trying to
> unbreak userspace,

The code is pretty simple. But yes, the time spent on justifying it
might take some time. That's the community. People need time to
understand each other's points.

> but looks to me as if we were trying every possible
> way to break userspace

How could my suggestions break a userspace?

> or try to approximate to the same brokenness
> mlx5_vdpa may have caused to the userspace. What we will get eventually
> from these lengthy discussions?

Siwei, I'd really suggest you read the link I gave you. You may get
the answer. What's more, It doesn't cost too much then we know for
sure there would not be any issue, why not choose the hard way?

> On the other hand, if you think it from
> vhost-vdpa user perspective, you'll clearly see there's just a couple of
> ways to unbreak userspace from the internal broken map which is out of
> sync with vhost-vdpa iotlb after device reset.

Patches are more than welcomed.

> If this brokenness was
> something universally done from the vhost-vdpa layer itself, I'd feel
> it's more of a shared problem, but this is not the case I see it here.
> While the long standing mlx5_vdpa/vdpa_sim issue is 100% misuse of
> .reset op in a wrong way per IOMMU API definition. Why leaving this
> discrepancy to the individual driver is not even an option, I'm still
> not sure?

Sorry? I start with a switch in the driver, and then I try to avoid
that. And it seems you don't want a burden on the driver as well.
Where did you see I say we can't do that in the driver? What I
disagree with is to use a module parameter.

Even if I fail, it doesn't mean we can't do that in the driver code.
If you read the link[1] you can see the offending commit is a change
in uvcvideo driver.

Thanks

>
>
> Thanks,
> -Siwei
>
> >
> >> Then we need a set of device flags (backend_features
> >> bit again?) to indicate the specific driver needs upper layer's help o=
n
> >> old-behaviour emulation.
> >>
> >> Last but not least, I'm not sure how to properly emulate
> >> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has =
no
> >> .reset_map op implemented, or if .reset_map has a slightly different
> >> implementation than what it used to reset the iotlb in the .reset op,
> > See above, for reset_vendor_mappings() I meant config->reset_map() exac=
tly.
> >
> > Thanks
> >
> >> then this either becomes effectively dead code if no one ends up using=
,
> >> or the vhost-vdpa emulation is helpless and limited in scope, unable t=
o
> >> cover all the cases.
> >>
> >> ----------------%<----------------%<----------------
> >>
>

