Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330F7D7CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjJZGRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFD115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698301023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSoYwXwDaWvend7uoRzR2H59PFDteSQmgU5j/n0TQOM=;
        b=AmuRRPfFscGf41bamjUrWGYAC42aNnjJMbtPBkCySPikpHRiInAZwvIZ6XYs5m6FsIC66r
        P/5GbGQOe26A60+zlnJFdOKCXGswx9gkQCmuxaR6CRhzvb0lVys5Y9q3Z+Bo3Mh70ljCxz
        GVh7At+DJQNzbatjQ1Af90GAADFl7y0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-KepQb69YO86Dms584fSZlQ-1; Thu, 26 Oct 2023 02:17:02 -0400
X-MC-Unique: KepQb69YO86Dms584fSZlQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53e3120ae44so344450a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301020; x=1698905820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSoYwXwDaWvend7uoRzR2H59PFDteSQmgU5j/n0TQOM=;
        b=GrShcF7YaVaFESNL818y9nRybEzlnBnE6Zbo+iACeiJaje+vOBhwnMGGTGa8s0pwto
         8M3xjzxy5j955FnHaACaCyWdxXyF5WKNqecvLhG1iSHgsMTcmGJVTPATBwsUvllL8C6s
         MQiuqO9cEjkOKsLeU74H9W4XbPZ5kzFusmbFORcoBbqkfysLsGp36AQiWxm1Obxsu37S
         LTwfZggbm9GsFw12BUsUgHE84EfaDKJVCESEkKbaFiF1QsQkVssKa8dkiPPvq3ZZW/x1
         SmI8t9D3BhWEvycSEQhfEjxTxdGZy8vP4BqqIsJ6p8sQBwb8wp1/tzlIDAqFZqIiD6ZM
         wu6A==
X-Gm-Message-State: AOJu0YymyS8CKNT/6gP6WzWqVEuyAZO7R8C6BjvRBy5VXGF6Zl9Qzuo4
        kx9nKZuetu5UNXhehKOXBX5ULgAPn4RgcgK13ma2uYERtIMKMS1NVzJLyKaAeUgZGUx++KS03qm
        ufvCYe9NbNfBxXDKLUOv/lHKt4tlmbKcTRzNyl7s9j5Z7k7uMCP6NrQ==
X-Received: by 2002:a50:d593:0:b0:53d:a0c9:dbd4 with SMTP id v19-20020a50d593000000b0053da0c9dbd4mr10983783edi.21.1698301020423;
        Wed, 25 Oct 2023 23:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFahLz1d9LhDDVN+HZZe/qNdDEAUM0PemAYlIsUj222A3gsrJhkoTEkQU5ghdLjS2dFH7ojJ2yilvFSGpH2xJk=
X-Received: by 2002:a50:d593:0:b0:53d:a0c9:dbd4 with SMTP id
 v19-20020a50d593000000b0053da0c9dbd4mr10983770edi.21.1698301020129; Wed, 25
 Oct 2023 23:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
 <4d03661b-4289-46e7-8760-32a186783b73@oracle.com> <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
 <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com> <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
 <d3f13f97-d5ae-4bf9-be9e-aed021fd7a7e@oracle.com>
In-Reply-To: <d3f13f97-d5ae-4bf9-be9e-aed021fd7a7e@oracle.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Thu, 26 Oct 2023 14:16:23 +0800
Message-ID: <CAPpAL=wr1YJh6rVB7mWzx+WZOa=2b4Kfrd1ZGhkvTnipRAPDdA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device reset
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        eperezma@redhat.com, sgarzare@redhat.com, dtatulea@nvidia.com,
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

On Thu, Oct 26, 2023 at 7:32=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Hi Yang Lei,
>
> Thanks for testing my patches and reporting! As for the issue, could you
> please try what I posted in:
>
> https://lore.kernel.org/virtualization/1698275594-19204-1-git-send-email-=
si-wei.liu@oracle.com/
>
HI Si-Wei
> and let me know how it goes? Thank you very much!

This problem has gone after applying this patch [1].
[1] https://lore.kernel.org/virtualization/1698275594-19204-1-git-send-emai=
l-si-wei.liu@oracle.com/

Thanks
Lei
>
> Thanks,
> -Siwei
>
> On 10/25/2023 2:41 AM, Lei Yang wrote:
> > On Wed, Oct 25, 2023 at 1:27=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> > Hello Si-Wei
> >> Thanks a lot for testing! Please be aware that there's a follow-up fix
> >> for a potential oops in this v4 series:
> >>
> > The first, when I did not apply this patch [1], I will also hit this
> > patch mentioned problem. After I applied this patch, this problem will
> > no longer to hit again. But I hit another issues, about the error
> > messages please review the attached file.
> > [1] https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-=
email-si-wei.liu@oracle.com/
> >
> > My test steps:
> > git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > cd  linux/
> > b4 am 1697880319-4937-1-git-send-email-si-wei.liu@oracle.com
> > b4 am 20231018171456.1624030-2-dtatulea@nvidia.com
> > b4 am 1698102863-21122-1-git-send-email-si-wei.liu@oracle.com
> > git am ./v4_20231018_dtatulea_vdpa_add_support_for_vq_descriptor_mappin=
gs.mbx
> > git am ./v4_20231021_si_wei_liu_vdpa_decouple_reset_of_iotlb_mapping_fr=
om_device_reset.mbx
> > git am ./20231023_si_wei_liu_vhost_vdpa_fix_null_pointer_deref_in__comp=
at_vdpa_reset.mbx
> > cp /boot/config-5.14.0-377.el9.x86_64 .config
> > make -j 32
> > make modules_install
> > make install
> >
> > Thanks
> >
> > Lei
> >> https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-ema=
il-si-wei.liu@oracle.com/
> >>
> >> Would be nice to have it applied for any tests.
> >>
> >> Thanks,
> >> -Siwei
> >>
> >> On 10/23/2023 11:51 PM, Lei Yang wrote:
> >>> QE tested this series v4 with regression testing on real nic, there i=
s
> >>> no new regression bug.
> >>>
> >>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>
> >>> On Tue, Oct 24, 2023 at 6:02=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 10/22/2023 8:51 PM, Jason Wang wrote:
> >>>>> Hi Si-Wei:
> >>>>>
> >>>>> On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> In order to reduce needlessly high setup and teardown cost
> >>>>>> of iotlb mapping during live migration, it's crucial to
> >>>>>> decouple the vhost-vdpa iotlb abstraction from the virtio
> >>>>>> device life cycle, i.e. iotlb mappings should be left
> >>>>>> intact across virtio device reset [1]. For it to work, the
> >>>>>> on-chip IOMMU parent device could implement a separate
> >>>>>> .reset_map() operation callback to restore 1:1 DMA mapping
> >>>>>> without having to resort to the .reset() callback, the
> >>>>>> latter of which is mainly used to reset virtio device state.
> >>>>>> This new .reset_map() callback will be invoked only before
> >>>>>> the vhost-vdpa driver is to be removed and detached from
> >>>>>> the vdpa bus, such that other vdpa bus drivers, e.g.
> >>>>>> virtio-vdpa, can start with 1:1 DMA mapping when they
> >>>>>> are attached. For the context, those on-chip IOMMU parent
> >>>>>> devices, create the 1:1 DMA mapping at vdpa device creation,
> >>>>>> and they would implicitly destroy the 1:1 mapping when
> >>>>>> the first .set_map or .dma_map callback is invoked.
> >>>>>>
> >>>>>> This patchset is rebased on top of the latest vhost tree.
> >>>>>>
> >>>>>> [1] Reducing vdpa migration downtime because of memory pin / maps
> >>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>>>>>
> >>>>>> ---
> >>>>>> v4:
> >>>>>> - Rework compatibility using new .compat_reset driver op
> >>>>> I still think having a set_backend_feature()
> >>>> This will overload backend features with the role of carrying over
> >>>> compatibility quirks, which I tried to avoid from. While I think the
> >>>> .compat_reset from the v4 code just works with the backend features
> >>>> acknowledgement (and maybe others as well) to determine, but not
> >>>> directly tie it to backend features itself. These two have different
> >>>> implications in terms of requirement, scope and maintaining/deprecat=
ion,
> >>>> better to cope with compat quirks in explicit and driver visible way=
.
> >>>>
> >>>>>     or reset_map(clean=3Dtrue) might be better.
> >>>> An explicit op might be marginally better in driver writer's point o=
f
> >>>> view. Compliant driver doesn't have to bother asserting clean_map ne=
ver
> >>>> be true so their code would never bother dealing with this case, as
> >>>> explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map
> >>>> during reset for older userspace":
> >>>>
> >>>> "
> >>>>        The separation of .compat_reset from the regular .reset allow=
s
> >>>>        vhost-vdpa able to know which driver had broken behavior befo=
re, so it
> >>>>        can apply the corresponding compatibility quirk to the indivi=
dual
> >>>> driver
> >>>>        whenever needed.  Compared to overloading the existing .reset=
 with
> >>>>        flags, .compat_reset won't cause any extra burden to the impl=
ementation
> >>>>        of every compliant driver.
> >>>> "
> >>>>
> >>>>>     As it tries hard to not introduce new stuff on the bus.
> >>>> Honestly I don't see substantial difference between these other than=
 the
> >>>> color. There's no single best solution that stands out among the 3. =
And
> >>>> I assume you already noticed it from all the above 3 approaches will
> >>>> have to go with backend features negotiation, that the 1st vdpa rese=
t
> >>>> before backend feature negotiation will use the compliant version of
> >>>> .reset that doesn't clean up the map. While I don't think this nuanc=
e
> >>>> matters much to existing older userspace apps, as the maps should
> >>>> already get cleaned by previous process in vhost_vdpa_cleanup(), but=
 if
> >>>> bug-for-bug behavioral compatibility is what you want, module parame=
ter
> >>>> will be the single best answer.
> >>>>
> >>>> Regards,
> >>>> -Siwei
> >>>>
> >>>>> But we can listen to others for sure.
> >>>>>
> >>>>> Thanks
> >>>>>
>

