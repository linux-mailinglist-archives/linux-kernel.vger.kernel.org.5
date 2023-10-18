Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A07CD4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbjJRHBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbjJRHBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC02B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697612458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfDvYOJwDxDy9viA9umY5avLSJDihUvL3MwOASZMIJk=;
        b=XoLtpyjWtt8/gAEuvc3kIZXq8ePQaoj4Pj2pzA+yKDHzmE0nlyvRAvwbqfAeBagkultAYb
        tGTJ0NfugwwinACvC9Jt38WHJHVV84PbGQJwJoihae9bTrSslCBZPkhiIiVLnHS5Aiy6pF
        UiANN+MAFyBWYcfIpX6GLGn0JhgMO50=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-N9mGrppPM7u1--YmHH3-gw-1; Wed, 18 Oct 2023 03:00:57 -0400
X-MC-Unique: N9mGrppPM7u1--YmHH3-gw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50318e9067eso6192266e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612456; x=1698217256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfDvYOJwDxDy9viA9umY5avLSJDihUvL3MwOASZMIJk=;
        b=F/dp8oYta7oTvUri5JKUBGifMOPD1D8Y22KCBV/ah4zcITLyXWmigAAFmCek0qd7OQ
         aNh9FRLGuDU8trD9I/fb7p86iNdFrwiV6oV5Ng4HrRUYYgnNTKKjPDp3FbEnFN58wVag
         3cYkV7vcZtqUERGH7BMA0baa8LFfK+NpTWWz2NVgVcbtl/9vBH3FVY3Hofl0Fun0L8lX
         RdwosA8w+NsLsOiGhkcCg6n16Ebwg3paixlwu8FJduyfep6FfhOvCd+DWMT/JcLqCyNJ
         o0EdKnsF30RLtl73BaMyt97h+41L4nExWUafVVVtlHFh7/A/MCQ4DSUotvgtMjMnNing
         TTNg==
X-Gm-Message-State: AOJu0Yx0XaADfr/isivH/d2EnK//xAxUkhqTMZHDIa6zTO4QEpGmcYaT
        n+/KoLPMJOBZDmI8Py+y1Rrw3ErWnHCwTSnwYklhmcBEn89WuBwQ/a3wMo9HqoIlYq/ke0DMBYm
        BIZ3YOtpPTSP18CbhW/6R4hUBckn99CPpz0nRdv/r
X-Received: by 2002:ac2:544c:0:b0:504:7f2e:9391 with SMTP id d12-20020ac2544c000000b005047f2e9391mr3445319lfn.34.1697612455710;
        Wed, 18 Oct 2023 00:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0dxRpgoSgEJhNjB2QO0EB77b/QCdK7/tbpbIudWUwxIeXp0l8Q4i9f4Tjjg6gU/gMkXX/G5B+QAtfXdr/dWo=
X-Received: by 2002:ac2:544c:0:b0:504:7f2e:9391 with SMTP id
 d12-20020ac2544c000000b005047f2e9391mr3445294lfn.34.1697612455289; Wed, 18
 Oct 2023 00:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com> <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
In-Reply-To: <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 15:00:44 +0800
Message-ID: <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 1:27=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Oct 18, 2023 at 12:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >
> >
> >
> > On 10/16/2023 7:35 PM, Jason Wang wrote:
> > > On Tue, Oct 17, 2023 at 4:30=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> > >>
> > >>
> > >> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> > >>> On Mon, Oct 16, 2023 at 8:33=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > >>>> On Fri, Oct 13, 2023 at 3:36=E2=80=AFPM Si-Wei Liu <si-wei.liu@ora=
cle.com> wrote:
> > >>>>>
> > >>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
> > >>>>>> On Tue, Oct 10, 2023 at 5:05=E2=80=AFPM Si-Wei Liu <si-wei.liu@o=
racle.com> wrote:
> > >>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementat=
ion
> > >>>>>>> may need to restore iotlb mapping to the initial or default sta=
te
> > >>>>>>> using the .reset_map op, as it's desirable for some parent devi=
ces
> > >>>>>>> to solely manipulate mappings by its own, independent of virtio=
 device
> > >>>>>>> state. For instance, device reset does not cause mapping go awa=
y on
> > >>>>>>> such IOTLB model in need of persistent mapping. Before vhost-vd=
pa
> > >>>>>>> is going away, give them a chance to reset iotlb back to the in=
itial
> > >>>>>>> state in vhost_vdpa_cleanup().
> > >>>>>>>
> > >>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > >>>>>>> ---
> > >>>>>>>     drivers/vhost/vdpa.c | 16 ++++++++++++++++
> > >>>>>>>     1 file changed, 16 insertions(+)
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > >>>>>>> index 851535f..a3f8160 100644
> > >>>>>>> --- a/drivers/vhost/vdpa.c
> > >>>>>>> +++ b/drivers/vhost/vdpa.c
> > >>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_fi=
nd_alloc_as(struct vhost_vdpa *v,
> > >>>>>>>            return vhost_vdpa_alloc_as(v, asid);
> > >>>>>>>     }
> > >>>>>>>
> > >>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asi=
d)
> > >>>>>>> +{
> > >>>>>>> +       struct vdpa_device *vdpa =3D v->vdpa;
> > >>>>>>> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> > >>>>>>> +
> > >>>>>>> +       if (ops->reset_map)
> > >>>>>>> +               ops->reset_map(vdpa, asid);
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>>     static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 a=
sid)
> > >>>>>>>     {
> > >>>>>>>            struct vhost_vdpa_as *as =3D asid_to_as(v, asid);
> > >>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vho=
st_vdpa *v, u32 asid)
> > >>>>>>>
> > >>>>>>>            hlist_del(&as->hash_link);
> > >>>>>>>            vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1=
, asid);
> > >>>>>>> +       /*
> > >>>>>>> +        * Devices with vendor specific IOMMU may need to resto=
re
> > >>>>>>> +        * iotlb to the initial or default state which is not d=
one
> > >>>>>>> +        * through device reset, as the IOTLB mapping manipulat=
ion
> > >>>>>>> +        * could be decoupled from the virtio device life cycle=
.
> > >>>>>>> +        */
> > >>>>>> Should we do this according to whether IOTLB_PRESIST is set?
> > >>>>> Well, in theory this seems like so but it's unnecessary code chan=
ge
> > >>>>> actually, as that is the way how vDPA parent behind platform IOMM=
U works
> > >>>>> today, and userspace doesn't break as of today. :)
> > >>>> Well, this is one question I've ever asked before. You have explai=
ned
> > >>>> that one of the reason that we don't break userspace is that they =
may
> > >>>> couple IOTLB reset with vDPA reset as well. One example is the Qem=
u.
> > >>>>
> > >>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is no=
t set
> > >>>>> it doesn't necessarily mean the iotlb will definitely be destroye=
d
> > >>>>> across reset (think about the platform IOMMU case), so userspace =
today
> > >>>>> is already tolerating enough with either good or bad IOMMU.
> > > I'm confused, how to define tolerating here?
> >
> > Tolerating defined as QEMU has to proactively unmap before reset just t=
o
> > workaround the driver bug (on-chip maps out of sync), unconditionally
> > for platform or on-chip. While we all know it doesn't have to do so for
> > platform IOMMU, though userspace has no means to distinguish. That said=
,
> > userspace is sacrificing reset time performance on platform IOMMU setup
> > just for working around buggy implementation in the other setup.
>
> Ok, so what you actually mean is that userspace can tolerate the "bug"
> with the performance penalty.
>
>
> >
> > > For example, if it has tolerance, why bother?
> > I'm not sure I get the question. But I think userspace is compromising
> > because of buggy implementation in a few drivers doesn't mean we should
> > uniformly enforce such behavior for all set_map/dma_map implementations=
.
>
> This is not my point. I meant, we can fix we need a negotiation in
> order to let some "buggy" old user space to survive from the changes.
>
> >
> > >
> > >>>> This code of
> > >>>>> not checking IOTLB_PERSIST being set is intentional, there's no p=
oint to
> > >>>>> emulate bad IOMMU behavior even for older userspace (with imprope=
r
> > >>>>> emulation to be done it would result in even worse performance).
> > > I can easily imagine a case:
> > >
> > > The old Qemu that works only with a setup like mlx5_vdpa.
> > Noted, seems to me there's no such case of a userspace implementation
> > that only works with mlx5_vdpa or its friends, but doesn't work with th=
e
> > others e.g. platform IOMMU, or well behaving on-chip IOMMU
> > implementations.
>
> It's not hard to think of a case where:
>
> 1) the environment has mlx5_vdpa only
> 2) kernel doc can't have endless details, so when developing
> application, the author notice IOTLB is cleared during reset
>
> > The Unmap+remap trick around vdpa reset works totally
> > fine for platform IOMMU, except with sub-optimal performance. Other tha=
n
> > this trick, I cannot easily think of other means or iotlb message
> > sequence for userspace to recover the bogus state and make iotlb back t=
o
> > work again after reset.
>
> Yes for sure, but we can't audit every user space, no?
>
> > Are we talking about hypnosis that has no real
> > basis to exist in the real world?
>
> Instead of trying to answer these hard questions, I would go another
> way. That is, stick to the old behaviour when IOTLB_PRESISIT is not
> set by the backend. This is much easier.
>
> >
> > >   If we do
> > > this without a negotiation, IOTLB will not be clear but the Qemu will
> > > try to re-program the IOTLB after reset. Which will break?
> > >
> > > 1) stick the exact old behaviour with just one line of check
> > It's not just one line of check here, the old behavior emulation has to
> > be done as Eugenio illustrated in the other email.
>
> For vhost-vDPA it's just
>
> if (IOTLB_PERSIST is acked by userspace)
>     reset_map()
>
> For parent, it's somehow similar:
>
> during .reset()
>
> if (IOTLB_PERSIST is not acked by userspace)
>         reset_vendor_mappings()
>
> Anything I missed here?
>
> > In addition, the
> > emulation has to limit to those buggy drivers as I don't feel this
> > emulation should apply uniformly to all future set_map/dma_map
> > implementations.
>
> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
> don't have a better choice. Or we can fail the probe if userspace
> doesn't ack this feature.

Antoher idea we can just do the following in vhost_vdpa reset?

config->reset()
if (IOTLB_PERSIST is not set) {
    config->reset_map()
}

Then we don't have the burden to maintain them in the parent?

Thanks

>
> > > 2) audit all the possible cases to avoid a one line of code
> > >
> > > 1) seems much easier than 2)
> > You see it's more than just one line of code, and I'm uncertain if the
> > additional complexity is warranted or necessary, particularly if added
> > this piece of compatibility code will linger for quite a long time.
>
> This is a must as long as it can be noticed by userspace. Doing
> something conservative makes more sense to me.
>
> > Instead of adding hypothetical code change for no specific good reason
> > and no real use case,
>
> It's not adding something new or new behaviours, it's just making the
> IOTLB reset conditional based on vDPA reset.
>
> > I'd like to add the code when we find out a
> > specific use case that may get impacted or already being affected,
>
> It doesn't conflict with what you proposed here. Old behaviours have
> their users, no?
>
> > then
> > we will have good understanding how to code up the fix and emulate
> > properly for compatibility, while not affecting other good implementati=
ons.
>
> The issue is, even if we can't find a userspace now. It doesn't mean
> we can't have one in the future. Then it might be too late or too
> tricky to fix them. We had a lot of lessons in the past.
>
> Thanks
>
> >
> > Thanks,
> > -Siwe/i/
> >
> > >
> > >>>> For two reasons:
> > >>>>
> > >>>> 1) backend features need acked by userspace this is by design
> > >>>> 2) keep the odd behaviour seems to be more safe as we can't audit
> > >>>> every userspace program
> > >>>>
> > >>> The old behavior (without flag ack) cannot be trusted already, as:
> > > Possibly but the point is to unbreak userspace no matter how weird th=
e
> > > behaviour we've ever had.
> > >
> > >>> * Devices using platform IOMMU (in other words, not implementing
> > >>> neither .set_map nor .dma_map) does not unmap memory at virtio rese=
t.
> > >>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> > >>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
> > >>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the rese=
t,
> > >>> now all backends work the same as far as I know., which was (and is=
)
> > >>> the way devices using the platform IOMMU works.
> > >>>
> > >>> The difference in behavior did not matter as QEMU unmaps all the
> > >>> memory unregistering the memory listener at vhost_vdpa_dev_start(..=
.,
> > >>> started =3D false),
> > >> Exactly. It's not just QEMU, but any (older) userspace manipulates
> > >> mappings through the vhost-vdpa iotlb interface has to unmap all
> > >> mappings to workaround the vdpa parent driver bug.
> > > Just to clarify, from userspace, it's the (odd) behaviour of the curr=
ent uAPI.
> > >
> > >> If they don't do
> > >> explicit unmap, it would cause state inconsistency between vhost-vdp=
a
> > >> and parent driver, then old mappings can't be restored, and new mapp=
ing
> > >> can be added to iotlb after vDPA reset. There's no point to preserve
> > >> this broken and inconsistent behavior between vhost-vdpa and parent
> > >> driver, as userspace doesn't care at all!
> > > It's a userspace notice change so we can't fix it silently:
> > >
> > > https://lkml.org/lkml/2012/12/23/75
> > >
> > > Another example which is related to vhost-vDPA:
> > >
> > > https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@red=
hat.com/T/
> > >
> > > Thanks
> > >
> > >>> but the backend acknowledging this feature flag
> > >>> allows QEMU to make sure it is safe to skip this unmap & map in the
> > >>> case of vhost stop & start cycle.
> > >>>
> > >>> In that sense, this feature flag is actually a signal for userspace=
 to
> > >>> know that the bug has been solved.
> > >> Right, I couldn't say it better than you do, thanks! The feature fla=
g is
> > >> more of an unusual means to indicating kernel bug having been fixed,
> > >> rather than introduce a new feature or new kernel behavior ending up=
 in
> > >> change of userspace's expectation.
> > >>
> > >>> Not offering it indicates that
> > >>> userspace cannot trust the kernel will retain the maps.
> > >>>
> > >>> Si-Wei or Dragos, please correct me if I've missed something. Feel
> > >>> free to use the text in case you find more clear in doc or patch lo=
g.
> > >> Sure, will do, thank you! Will post v2 adding these to the log.
> > >>
> > >> Thanks,
> > >> -Siwei
> > >>
> > >>
> > >>
> > >>> Thanks!
> > >>>
> > >>>> Thanks
> > >>>>
> > >>>>> I think
> > >>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 1=
00%
> > >>>>> certainty of persistent iotlb mapping not getting lost across vdp=
a reset.
> > >>>>>
> > >>>>> Thanks,
> > >>>>> -Siwei
> > >>>>>
> > >>>>> [1]
> > >>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be=
78152e47fd@oracle.com/
> > >>>>> [2]
> > >>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bf=
e5473f1f2e@oracle.com/
> > >>>>>>     Otherwise
> > >>>>>> we may break old userspace.
> > >>>>>>
> > >>>>>> Thanks
> > >>>>>>
> > >>>>>>> +       vhost_vdpa_reset_map(v, asid);
> > >>>>>>>            kfree(as);
> > >>>>>>>
> > >>>>>>>            return 0;
> > >>>>>>> --
> > >>>>>>> 1.8.3.1
> > >>>>>>>
> >

