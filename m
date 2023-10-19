Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B37CEE40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJSCtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjJSCtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026411C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697683725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MK3lnNwJi63gyMUG1dSulN3ek4pfNyk8XQgv0G4E+Q=;
        b=NdZxl0RRN/USUxpvvcGnJJxfOIAca2UHVDkNEbeJI/TNcUH9j0mmdjp6Xb7fjsJAcgtDi9
        brsJLpsK1l6PEGYNvTNbxmwaQHGD+Wf8M9SZwfiSSJwLQKTQUmRNy1W+TF148YPlEC0otr
        gzhC4WUg3gLEe70H2MX6Xb0b9bbvUXk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-ZJMNK-wQP1Gw3eleDkDi2w-1; Wed, 18 Oct 2023 22:48:42 -0400
X-MC-Unique: ZJMNK-wQP1Gw3eleDkDi2w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50483ed1172so7349642e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697683721; x=1698288521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MK3lnNwJi63gyMUG1dSulN3ek4pfNyk8XQgv0G4E+Q=;
        b=MZCX3NWJwRBP/ET6Bbv1vEbrWNsRpsUvRdA3EfTYtof/zNJYOOTlQXdqIjnzHz5Pcs
         jzaOcQq3WeKtPw2cIRg/lVZfSdT3l1P7J21wdht1sJJYnenJpm/61NlenX+KV5x3JGQU
         zOifuKaltWYJk6SNdfGiWNJcf62fSyPqX9TRdXmkGjRB6i3gK3LcDVfOMlctujI/CzG/
         Sq/304CMz4QBkahxIZFKlcVJf+mJJNICHyKZo9NJ+11TfkdMthOvjTPLlzZRH1Op32Hw
         pkHaZB6Ws346o+D4uAWuLXQR6NI+Q0xYE7a0RboSeqU3wRlM2bTNp64/05ePMr7sAdd5
         AF4g==
X-Gm-Message-State: AOJu0Yy1DZI195XRnnkTRte5tawuF/Eepzwpi4YNR/Yb/Z+F598tFYR6
        yn+bmy92NsnPX309FbWySUnueMZzLGBE3BYhtV4tcmn9kXb+Lxfc2m6hy4+nRmhIHy7v3pwnfQw
        yOpmcd+skl7JuBXjFJeK7iTzhkP7arGK/XBUEvPVz
X-Received: by 2002:ac2:5e77:0:b0:500:ac71:f26a with SMTP id a23-20020ac25e77000000b00500ac71f26amr463954lfr.57.1697683720595;
        Wed, 18 Oct 2023 19:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeARAgRY18DjAKKjKOFpXBe4fT/FGG0mulfI787BzsUMtbGbbPpo5XyuremRlinmT+yffV+EkpOWnqDL832EU=
X-Received: by 2002:ac2:5e77:0:b0:500:ac71:f26a with SMTP id
 a23-20020ac25e77000000b00500ac71f26amr463944lfr.57.1697683720095; Wed, 18 Oct
 2023 19:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com> <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <9c74b299-98ec-46b3-bf21-972f9883ca84@oracle.com> <CAJaqyWc01_YgkhLRs961a-K1P+Zj4P+6qGN1t=eOFFwGvQ001A@mail.gmail.com>
 <35efd377-61f7-4cef-adf8-61e9269e4be9@oracle.com>
In-Reply-To: <35efd377-61f7-4cef-adf8-61e9269e4be9@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 Oct 2023 10:48:29 +0800
Message-ID: <CACGkMEsUbrd4d8f6P3WXdMZ-K9E0FQV0GC5Nh_jiBit_MSJk5g@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 7:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/18/2023 4:14 AM, Eugenio Perez Martin wrote:
> > On Wed, Oct 18, 2023 at 10:44=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>
> >>
> >> On 10/17/2023 10:27 PM, Jason Wang wrote:
> >>> On Wed, Oct 18, 2023 at 12:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>
> >>>> On 10/16/2023 7:35 PM, Jason Wang wrote:
> >>>>> On Tue, Oct 17, 2023 at 4:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> >>>>>>>> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@o=
racle.com> wrote:
> >>>>>>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
> >>>>>>>>>> On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu=
@oracle.com> wrote:
> >>>>>>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implement=
ation
> >>>>>>>>>>> may need to restore iotlb mapping to the initial or default s=
tate
> >>>>>>>>>>> using the .reset_map op, as it's desirable for some parent de=
vices
> >>>>>>>>>>> to solely manipulate mappings by its own, independent of virt=
io device
> >>>>>>>>>>> state. For instance, device reset does not cause mapping go a=
way on
> >>>>>>>>>>> such IOTLB model in need of persistent mapping. Before vhost-=
vdpa
> >>>>>>>>>>> is going away, give them a chance to reset iotlb back to the =
initial
> >>>>>>>>>>> state in vhost_vdpa_cleanup().
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>       drivers/vhost/vdpa.c | 16 ++++++++++++++++
> >>>>>>>>>>>       1 file changed, 16 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>>>>>>>>> index 851535f..a3f8160 100644
> >>>>>>>>>>> --- a/drivers/vhost/vdpa.c
> >>>>>>>>>>> +++ b/drivers/vhost/vdpa.c
> >>>>>>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_=
find_alloc_as(struct vhost_vdpa *v,
> >>>>>>>>>>>              return vhost_vdpa_alloc_as(v, asid);
> >>>>>>>>>>>       }
> >>>>>>>>>>>
> >>>>>>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 a=
sid)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> >>>>>>>>>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       if (ops->reset_map)
> >>>>>>>>>>> +               ops->reset_map(vdpa, asid);
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>>       static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u=
32 asid)
> >>>>>>>>>>>       {
> >>>>>>>>>>>              struct vhost_vdpa_as *as =3D asid_to_as(v, asid)=
;
> >>>>>>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct v=
host_vdpa *v, u32 asid)
> >>>>>>>>>>>
> >>>>>>>>>>>              hlist_del(&as->hash_link);
> >>>>>>>>>>>              vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL=
 - 1, asid);
> >>>>>>>>>>> +       /*
> >>>>>>>>>>> +        * Devices with vendor specific IOMMU may need to res=
tore
> >>>>>>>>>>> +        * iotlb to the initial or default state which is not=
 done
> >>>>>>>>>>> +        * through device reset, as the IOTLB mapping manipul=
ation
> >>>>>>>>>>> +        * could be decoupled from the virtio device life cyc=
le.
> >>>>>>>>>>> +        */
> >>>>>>>>>> Should we do this according to whether IOTLB_PRESIST is set?
> >>>>>>>>> Well, in theory this seems like so but it's unnecessary code ch=
ange
> >>>>>>>>> actually, as that is the way how vDPA parent behind platform IO=
MMU works
> >>>>>>>>> today, and userspace doesn't break as of today. :)
> >>>>>>>> Well, this is one question I've ever asked before. You have expl=
ained
> >>>>>>>> that one of the reason that we don't break userspace is that the=
y may
> >>>>>>>> couple IOTLB reset with vDPA reset as well. One example is the Q=
emu.
> >>>>>>>>
> >>>>>>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is =
not set
> >>>>>>>>> it doesn't necessarily mean the iotlb will definitely be destro=
yed
> >>>>>>>>> across reset (think about the platform IOMMU case), so userspac=
e today
> >>>>>>>>> is already tolerating enough with either good or bad IOMMU.
> >>>>> I'm confused, how to define tolerating here?
> >>>> Tolerating defined as QEMU has to proactively unmap before reset jus=
t to
> >>>> workaround the driver bug (on-chip maps out of sync), unconditionall=
y
> >>>> for platform or on-chip. While we all know it doesn't have to do so =
for
> >>>> platform IOMMU, though userspace has no means to distinguish. That s=
aid,
> >>>> userspace is sacrificing reset time performance on platform IOMMU se=
tup
> >>>> just for working around buggy implementation in the other setup.
> >>> Ok, so what you actually mean is that userspace can tolerate the "bug=
"
> >>> with the performance penalty.
> >> Right.
> >>>
> >>>>> For example, if it has tolerance, why bother?
> >>>> I'm not sure I get the question. But I think userspace is compromisi=
ng
> >>>> because of buggy implementation in a few drivers doesn't mean we sho=
uld
> >>>> uniformly enforce such behavior for all set_map/dma_map implementati=
ons.
> >>> This is not my point. I meant, we can fix we need a negotiation in
> >>> order to let some "buggy" old user space to survive from the changes.
> >> Userspace is no buggy today, how to define "buggy"? Userspace with
> >> tolerance could survive just fine no matter if this negotiation or bug=
gy
> >> driver behavior emulation is around or not. If any userspace doesn't
> >> tolerate, it can work still fine on good on-chip IOMMU or platform
> >> IOMMU, no matter if the negotiation is around or not.
> >>>>>>>> This code of
> >>>>>>>>> not checking IOTLB_PERSIST being set is intentional, there's no=
 point to
> >>>>>>>>> emulate bad IOMMU behavior even for older userspace (with impro=
per
> >>>>>>>>> emulation to be done it would result in even worse performance)=
.
> >>>>> I can easily imagine a case:
> >>>>>
> >>>>> The old Qemu that works only with a setup like mlx5_vdpa.
> >>>> Noted, seems to me there's no such case of a userspace implementatio=
n
> >>>> that only works with mlx5_vdpa or its friends, but doesn't work with=
 the
> >>>> others e.g. platform IOMMU, or well behaving on-chip IOMMU
> >>>> implementations.
> >>> It's not hard to think of a case where:
> >>>
> >>> 1) the environment has mlx5_vdpa only
> >>> 2) kernel doc can't have endless details, so when developing
> >>> application, the author notice IOTLB is cleared during reset
> >> I get it, but my question was that, even if the author had noticed IOT=
LB
> >> is cleared during reset, does he care or not to make IOTLB back workin=
g
> >> again? My point is that, if this old setup is supposed to "work" on
> >> mlx5_vdpa, then the developer must come up with sort of "quirk" to
> >> recover the IOTLB to make it back to working state again after the
> >> reset. It will be more justified to come up with the proper fix for
> >> compatibility/emulation only until we know what should be expected to
> >> work and through which possible means to making it back to work, rathe=
r
> >> than blindly emulate the buggy behavior solely based on a few driver's
> >> own implementation. I'm pretty sure there are multiple ways to impleme=
nt
> >> the buggy reset behavior in the driver, does it mean we have to emulat=
e
> >> various corrupted mapping states in the individual on-chip iommu itsel=
f?
> >> How is it able to help the developer user if we are able to replicate
> >> the same corrupted mapping state in the on-chip iommu after reset, any
> >> real-life user only cares about mapping being corrupted in the same wa=
y,
> >> rather than cares more about the quirk sequence or work around to get
> >> iotlb maps out of the broken state?
> >>
> >> Only if the userspace is like a test facility to expect some test case
> >> to fail on mlx5_vdpa after reset -- I assume that is not real-life use=
r
> >> at all.
> >>>> The Unmap+remap trick around vdpa reset works totally
> >>>> fine for platform IOMMU, except with sub-optimal performance. Other =
than
> >>>> this trick, I cannot easily think of other means or iotlb message
> >>>> sequence for userspace to recover the bogus state and make iotlb bac=
k to
> >>>> work again after reset.
> >>> Yes for sure, but we can't audit every user space, no?
> >> We don't have to, as userspace here has no bug at all. The bug exists =
in
> >> the driver not in userspace. Real life userspace app only cares about
> >> making things work not asserting something must be broken.
> >>>> Are we talking about hypnosis that has no real
> >>>> basis to exist in the real world?
> >>> Instead of trying to answer these hard questions, I would go another
> >>> way. That is, stick to the old behaviour when IOTLB_PRESISIT is not
> >>> set by the backend. This is much easier.
> >> Please be noted the old (broken) behavior can vary between different
> >> parent driver implementations. It's driver's specific own problem, if
> >> there are N ways to for driver to implement buggy .reset, do we have t=
o
> >> emulate N flavors of different vdpa reset behavior?
> >>
> >>>>>     If we do
> >>>>> this without a negotiation, IOTLB will not be clear but the Qemu wi=
ll
> >>>>> try to re-program the IOTLB after reset. Which will break?
> >>>>>
> >>>>> 1) stick the exact old behaviour with just one line of check
> >>>> It's not just one line of check here, the old behavior emulation has=
 to
> >>>> be done as Eugenio illustrated in the other email.
> >>> For vhost-vDPA it's just
> >>>
> >>> if (IOTLB_PERSIST is acked by userspace)
> >>>       reset_map()
> >>>
> >>> For parent, it's somehow similar:
> >>>
> >>> during .reset()
> >>>
> >>> if (IOTLB_PERSIST is not acked by userspace)
> >>>           reset_vendor_mappings()
> >>>
> >>> Anything I missed here?
> >> First, the ideal fix would be to leave this reset_vendor_mappings()
> >> emulation code on the individual driver itself, which already has the
> >> broken behavior. But today there's no backend feature negotiation
> >> between vhost-vdpa and the parent driver. Do we want to send down the
> >> acked_backend_features to parent drivers?
> >>
> > What if we add a module parameter to both mlx5 and vdpa_sim to keep
> > the old behavior? Let's call it clean_iotlb_on_reset for now.
> >
> > In my opinion we can leave it off by default, so these userspace apps
> > can get back to the previous behavior. It would be ideal if we set a
> > deprecation date for it though.
> >
> > This way new backends, whether they implement .set_map or not, will
> > have correct behavior.
> >
> > Would that work?
> Great idea, this definitely will work! With this module parameter,
> individual driver still keeps the possibility to revert to previous
> buggy behavior were to unbreak old userspace, code can be obsoleted
> independently per each driver's specific use case and need, and we don't
> necessarily overload vdpa core with too much unwarranted compatibility
> code. Thank you so much for the great suggestion,

I disagree, module parameters have been proved to be very hard for
management. And what I don't understand here is, once a module
parameter can work, why not just replace it with the checking of
IOTLB_PRESIST?

Thanks


> I will post a v3.
>
> Thanks,
> -Siwei
>
> >
> > Thanks!
> >
> >> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
> >> backend feature negotiation in parent driver, if vhost-vdpa has to
> >> provide the old-behaviour emulation for compatibility on driver's
> >> behalf, it needs to be done per-driver basis. There could be good
> >> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB i=
n
> >> .reset, and vendor specific IOMMU doesn't have to provide .reset_map, =
we
> >> should allow these good driver implementations rather than
> >> unconditionally stick to some specific problematic behavior for every
> >> other good driver. Then we need a set of device flags (backend_feature=
s
> >> bit again?) to indicate the specific driver needs upper layer's help o=
n
> >> old-behaviour emulation.
> >>
> >> Last but not least, I'm not sure how to properly emulate
> >> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has =
no
> >> .reset_map op implemented, or if .reset_map has a slightly different
> >> implementation than what it used to reset the iotlb in the .reset op,
> >> then this either becomes effectively dead code if no one ends up using=
,
> >> or the vhost-vdpa emulation is helpless and limited in scope, unable t=
o
> >> cover all the cases.
> >>
> >>
> >>>> In addition, the
> >>>> emulation has to limit to those buggy drivers as I don't feel this
> >>>> emulation should apply uniformly to all future set_map/dma_map
> >>>> implementations.
> >>> Unfortunately, it's a must to stick to ABI.
> >> How come this brokenness in mlx5_vdpa becomes ABI in any sort for futu=
re
> >> on-chip IOMMU drivers? They might not even exist yet. Even if it's
> >> concerning ABI it's limited to mlx5_vdpa and the existing drivers, rig=
ht?
> >>
> >>>    I agree it's a mess but we don't have a better choice.
> >> Well, it's your call, I can implement as you wish but the unwarranted
> >> code has to be maintained forever. Particularly without knowing if
> >> there's really such a use case in real life, and no one in future migh=
t
> >> dare to remove the code without knowing what it can be used for.
> >>
> >>> Or we can fail the probe if userspace
> >>> doesn't ack this feature.
> >> Fail probing is even worse choice that is introducing intrusive breaka=
ge
> >> to the userspace.
> >>>>> 2) audit all the possible cases to avoid a one line of code
> >>>>>
> >>>>> 1) seems much easier than 2)
> >>>> You see it's more than just one line of code, and I'm uncertain if t=
he
> >>>> additional complexity is warranted or necessary, particularly if add=
ed
> >>>> this piece of compatibility code will linger for quite a long time.
> >>> This is a must as long as it can be noticed by userspace. Doing
> >>> something conservative makes more sense to me.
> >>>
> >>>> Instead of adding hypothetical code change for no specific good reas=
on
> >>>> and no real use case,
> >>> It's not adding something new or new behaviours, it's just making the
> >>> IOTLB reset conditional based on vDPA reset.
> >>>
> >>>> I'd like to add the code when we find out a
> >>>> specific use case that may get impacted or already being affected,
> >>> It doesn't conflict with what you proposed here. Old behaviours have
> >>> their users, no?
> >> We don't know the use case how to make thing work instead of make thin=
g
> >> break, that is the problem. We have no way to test if old-behaviour
> >> preserving code really works as expected. If there's no such user in
> >> practice, it ends up with dead code no one dares to remove.
> >>>> then
> >>>> we will have good understanding how to code up the fix and emulate
> >>>> properly for compatibility, while not affecting other good implement=
ations.
> >>> The issue is, even if we can't find a userspace now. It doesn't mean
> >>> we can't have one in the future. Then it might be too late or too
> >>> tricky to fix them. We had a lot of lessons in the past.
> >> I am not sure the same situation "too late to fix" or "too tricky to
> >> fix" applies here. Usually this means there's some well established
> >> pattern for e.g. API, ABI or long standing de-factor behavior that can=
't
> >> be broken or adjust if trying to fix something up. But here we're
> >> guarded by a flag (IOTLB_PERSIST) and without it the behavior is total=
ly
> >> ruled by implementation.
> >>
> >> Regards,
> >> -Siwei
> >>
> >>> Thanks
> >>>
> >>>> Thanks,
> >>>> -Siwe/i/
> >>>>
> >>>>>>>> For two reasons:
> >>>>>>>>
> >>>>>>>> 1) backend features need acked by userspace this is by design
> >>>>>>>> 2) keep the odd behaviour seems to be more safe as we can't audi=
t
> >>>>>>>> every userspace program
> >>>>>>>>
> >>>>>>> The old behavior (without flag ack) cannot be trusted already, as=
:
> >>>>> Possibly but the point is to unbreak userspace no matter how weird =
the
> >>>>> behaviour we've ever had.
> >>>>>
> >>>>>>> * Devices using platform IOMMU (in other words, not implementing
> >>>>>>> neither .set_map nor .dma_map) does not unmap memory at virtio re=
set.
> >>>>>>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> >>>>>>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iot=
lb
> >>>>>>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the re=
set,
> >>>>>>> now all backends work the same as far as I know., which was (and =
is)
> >>>>>>> the way devices using the platform IOMMU works.
> >>>>>>>
> >>>>>>> The difference in behavior did not matter as QEMU unmaps all the
> >>>>>>> memory unregistering the memory listener at vhost_vdpa_dev_start(=
...,
> >>>>>>> started =3D false),
> >>>>>> Exactly. It's not just QEMU, but any (older) userspace manipulates
> >>>>>> mappings through the vhost-vdpa iotlb interface has to unmap all
> >>>>>> mappings to workaround the vdpa parent driver bug.
> >>>>> Just to clarify, from userspace, it's the (odd) behaviour of the cu=
rrent uAPI.
> >>>>>
> >>>>>> If they don't do
> >>>>>> explicit unmap, it would cause state inconsistency between vhost-v=
dpa
> >>>>>> and parent driver, then old mappings can't be restored, and new ma=
pping
> >>>>>> can be added to iotlb after vDPA reset. There's no point to preser=
ve
> >>>>>> this broken and inconsistent behavior between vhost-vdpa and paren=
t
> >>>>>> driver, as userspace doesn't care at all!
> >>>>> It's a userspace notice change so we can't fix it silently:
> >>>>>
> >>>>> https://lkml.org/lkml/2012/12/23/75
> >>>>>
> >>>>> Another example which is related to vhost-vDPA:
> >>>>>
> >>>>> https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@r=
edhat.com/T/
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>> but the backend acknowledging this feature flag
> >>>>>>> allows QEMU to make sure it is safe to skip this unmap & map in t=
he
> >>>>>>> case of vhost stop & start cycle.
> >>>>>>>
> >>>>>>> In that sense, this feature flag is actually a signal for userspa=
ce to
> >>>>>>> know that the bug has been solved.
> >>>>>> Right, I couldn't say it better than you do, thanks! The feature f=
lag is
> >>>>>> more of an unusual means to indicating kernel bug having been fixe=
d,
> >>>>>> rather than introduce a new feature or new kernel behavior ending =
up in
> >>>>>> change of userspace's expectation.
> >>>>>>
> >>>>>>> Not offering it indicates that
> >>>>>>> userspace cannot trust the kernel will retain the maps.
> >>>>>>>
> >>>>>>> Si-Wei or Dragos, please correct me if I've missed something. Fee=
l
> >>>>>>> free to use the text in case you find more clear in doc or patch =
log.
> >>>>>> Sure, will do, thank you! Will post v2 adding these to the log.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>>>>> I think
> >>>>>>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace=
 100%
> >>>>>>>>> certainty of persistent iotlb mapping not getting lost across v=
dpa reset.
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> -Siwei
> >>>>>>>>>
> >>>>>>>>> [1]
> >>>>>>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-=
be78152e47fd@oracle.com/
> >>>>>>>>> [2]
> >>>>>>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-=
bfe5473f1f2e@oracle.com/
> >>>>>>>>>>       Otherwise
> >>>>>>>>>> we may break old userspace.
> >>>>>>>>>>
> >>>>>>>>>> Thanks
> >>>>>>>>>>
> >>>>>>>>>>> +       vhost_vdpa_reset_map(v, asid);
> >>>>>>>>>>>              kfree(as);
> >>>>>>>>>>>
> >>>>>>>>>>>              return 0;
> >>>>>>>>>>> --
> >>>>>>>>>>> 1.8.3.1
> >>>>>>>>>>>
>

