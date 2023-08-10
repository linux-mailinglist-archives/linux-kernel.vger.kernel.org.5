Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0A776E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHJDLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHJDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D68B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691637054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6b4imJMzFPIs/3Uhx5s4rgrd665V1zcOzbbxI/KCtM=;
        b=P/qHhRWd7x7gn9xMDjPg7ds64KONBo5+8fQH6T44HWr96cENtxJSv/R6oLV0cunSGz5cCM
        oma21lI88zLPGr4XUL+fPwhV/m1aOEwcLE3Q/+3fB5u/nXED8KPOXc+Mv2CZB6deIylFOx
        MHOsbgE8ZoVPM6K2+oYJtYHfcIjjisw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-_60du2L9Ozy9gdEYK0QbGQ-1; Wed, 09 Aug 2023 23:10:52 -0400
X-MC-Unique: _60du2L9Ozy9gdEYK0QbGQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso4816631fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 20:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691637051; x=1692241851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6b4imJMzFPIs/3Uhx5s4rgrd665V1zcOzbbxI/KCtM=;
        b=C9qvsJJzA4kr3UCffGVSLnbcp8FnwLRs5Uz2VGnUo3DTF75/EbiIoAyY1HomPr4ARW
         0FAWtRlKK5T83SWTuzlfyIa5lWgKkYFtiECWyHH2m2Yjno9yRq83lZA3Stth3Fra78e4
         sC1at7N54k79RQhwdfDX248IpOhjwTJrbZSjyu+HbUUkheIVqNJOItGvlj+KtCO4wRNZ
         RhUi7g52KYl+MWM2e5GvBKYtCQN15D3WtjG+54fNOQhBJy1xV4sX6h4VbQ4iKaypTq8k
         X1t2IoiK16gFVhSLRJemjsbuPLanCcCUPig647aASsxINzTWT1KepJKwsg+16aTUdhz0
         2cGw==
X-Gm-Message-State: AOJu0YwN99OCPHMRSLdtiIvx/Z+EPc21Eqer8hky64J3wa27pLr4g7Sk
        jcteD+0fxqM3p5RULcBY5zunQhT8hBFLrqqH8P9PaFyMJZnx1pGEc973jLGQD4Of9Z5kuI7tkah
        D86hiVWpJLv5VOF7A/KTK/CAuOG+0WqgWAvn2Y7rg
X-Received: by 2002:a2e:7812:0:b0:2b7:339c:f791 with SMTP id t18-20020a2e7812000000b002b7339cf791mr788440ljc.25.1691637050798;
        Wed, 09 Aug 2023 20:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFimAya0041rReObTXK5v0BVPAGadjsPSqfBfnmyPcSd6QH7MlT+YqUUiQKkxtXai8VKl4Fu9nww3tmwJ9W728=
X-Received: by 2002:a2e:7812:0:b0:2b7:339c:f791 with SMTP id
 t18-20020a2e7812000000b002b7339cf791mr788432ljc.25.1691637050440; Wed, 09 Aug
 2023 20:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com> <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com> <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
 <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
In-Reply-To: <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Aug 2023 11:10:39 +0800
Message-ID: <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

On Thu, Aug 10, 2023 at 8:40=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/8/2023 11:52 PM, Jason Wang wrote:
> > On Wed, Aug 9, 2023 at 6:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >>
> >>
> >> On 8/7/2023 8:00 PM, Jason Wang wrote:
> >>> On Fri, Aug 4, 2023 at 1:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>>>
> >>>> On 8/3/2023 1:03 AM, Jason Wang wrote:
> >>>>> On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvi=
dia.com> wrote:
> >>>>>> The mr->initialized flag is shared between the control vq and data=
 vq
> >>>>>> part of the mr init/uninit. But if the control vq and data vq get =
placed
> >>>>>> in different ASIDs, it can happen that initializing the control vq=
 will
> >>>>>> prevent the data vq mr from being initialized.
> >>>>>>
> >>>>>> This patch consolidates the control and data vq init parts into th=
eir
> >>>>>> own init functions. The mr->initialized will now be used for the d=
ata vq
> >>>>>> only. The control vq currently doesn't need a flag.
> >>>>>>
> >>>>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_m=
r got
> >>>>>> split into data and control vq functions which are now also ASID a=
ware.
> >>>>>>
> >>>>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces =
for control and data")
> >>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
> >>>>>> ---
> >>>>>>     drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >>>>>>     drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++-=
--------
> >>>>>>     2 files changed, 71 insertions(+), 27 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx=
5/core/mlx5_vdpa.h
> >>>>>> index 25fc4120b618..a0420be5059f 100644
> >>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> >>>>>>            struct list_head head;
> >>>>>>            unsigned long num_directs;
> >>>>>>            unsigned long num_klms;
> >>>>>> +       /* state of dvq mr */
> >>>>>>            bool initialized;
> >>>>>>
> >>>>>>            /* serialize mkey creation and destruction */
> >>>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/=
mr.c
> >>>>>> index 03e543229791..4ae14a248a4b 100644
> >>>>>> --- a/drivers/vdpa/mlx5/core/mr.c
> >>>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
> >>>>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdp=
a_dev *mvdev, struct mlx5_vdpa_mr *mr
> >>>>>>            }
> >>>>>>     }
> >>>>>>
> >>>>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev=
, unsigned int asid)
> >>>>>> +{
> >>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       prune_iotlb(mvdev);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev=
, unsigned int asid)
> >>>>>>     {
> >>>>>>            struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>>
> >>>>>> -       mutex_lock(&mr->mkey_mtx);
> >>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>>>> +               return;
> >>>>>> +
> >>>>>>            if (!mr->initialized)
> >>>>>> -               goto out;
> >>>>>> +               return;
> >>>>>>
> >>>>>> -       prune_iotlb(mvdev);
> >>>>>>            if (mr->user_mr)
> >>>>>>                    destroy_user_mr(mvdev, mr);
> >>>>>>            else
> >>>>>>                    destroy_dma_mr(mvdev, mr);
> >>>>>>
> >>>>>>            mr->initialized =3D false;
> >>>>>> -out:
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev=
, unsigned int asid)
> >>>>>> +{
> >>>>>> +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>> +
> >>>>>> +       mutex_lock(&mr->mkey_mtx);
> >>>>>> +
> >>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> >>>>>> +
> >>>>>>            mutex_unlock(&mr->mkey_mtx);
> >>>>>>     }
> >>>>>>
> >>>>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>> -                               struct vhost_iotlb *iotlb, unsigne=
d int asid)
> >>>>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>>>> +{
> >>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VD=
PA_CVQ_GROUP]);
> >>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VD=
PA_DATAVQ_GROUP]);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>> +                                   struct vhost_iotlb *iotlb,
> >>>>>> +                                   unsigned int asid)
> >>>>>> +{
> >>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>>>> +               return 0;
> >>>>>> +
> >>>>>> +       return dup_iotlb(mvdev, iotlb);
> >>>>> This worries me as conceptually, there should be no difference betw=
een
> >>>>> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
> >>>>>
> >>>>> One example is that, if we only do dup_iotlb() but not try to creat=
e
> >>>>> dma mr here, we will break virtio-vdpa:
> >>>> For this case, I guess we may need another way to support virtio-vdp=
a
> >>>> 1:1 mapping rather than overloading virtio device reset semantics, s=
ee:
> >>>>
> >>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>>>
> >>>>    > Conceptually, the address mapping is not a part of the abstract=
ion for
> >>>>    > a virtio device now. So resetting the memory mapping during vir=
tio
> >>>>    > device reset seems wrong.
> >>>>
> >>>> where we want to keep memory mapping intact across virtio device res=
et
> >>>> for best live migration latency/downtime. I wonder would it work to
> >>>> reset the mapping in vhost-vdpa life cycle out of virtio reset, say
> >>>> introduce a .reset_map() op to restore 1:1 mapping within
> >>>> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we=
 can
> >>>> move the iotlb reset logic to there without worry breaking virtio-vd=
pa.
> >>> It looks to me we don't need a new ops. We can simply do set_map()
> >>> twice
> >> What does it mean, first set_map(0, -1ULL) with zero iotlb entry passe=
d
> >> in to destroy all iotlb mappings previously added, and second set_map(=
0,
> >> -1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but
> >> doesn't do harm) apart from vhost-vdpa itself can do unmap twice anywa=
y,
> >> this is supported today I think. Why there'll be such obscure
> >> distinction, or what's the benefit to treat second .set_map() as
> >> recreating 1:1 mapping?
> > Ok, I think I miss some context. I agree that it's better to decouple
> > memory mappings from the virtio reset. It helps to reduce the
> > unnecessary memory transactions. It might require a new feature flag.
> This I agreed. AFAICT QEMU would need to check this new feature flag to
> make sure memory mappings are kept intact across reset, otherwise for
> the sake of avoid breaking older kernels it has to recreate all the
> mappings after reset like how it is done today.
>
> > Regarding the method of restoring to 1:1 DMA MR, it might be dangerous
> > for (buggy) vhost-vDPA devices. Since its userspace doesn't set up any
> > mapping it can explore the kernel with that via CVQ?
> Not sure I understand this proposal. The 1:1 DMA MR is first created at
> vdpa device add, and gets destroyed implicitly when the first .set_map
> or .dma_map call is made, which is only possible after the vhost-vdpa
> module is loaded and bound to vdpa devices.

So what happens if there's a buggy userspace that doesn't do any IOTLB setu=
p?

Thanks

> Naturally the DMA MR should
> be restored to how it was before when vhost-vdpa module is unloaded, or
> if anything the 1:1 DMA MR creation can be deferred to until virtio-vdpa
> is probed and bound to devices. Today vhost_vdpa_remove_as() as part of
> the vhost-vdpa unload code path already gets all mappings purged through
> vhost_vdpa_iotlb_unmap(0, -1ULL), and it should be pretty safe to
> restore DMA MR via .reset_map() right after. Not sure what's the concern
> here with buggy vhost-vdpa device?
>
> Noted when vhost-vdpa is being unloaded there's even no chance to probe
> kernel through CVQ, as the virtio feature is not even negotiated at that
> point. And it is even trickier to wait for CVQ response from device
> indefinitely when trying to unload a module.
>
> Regards,
> -Siwei
> >
> > Thanks
> >
> >>>    or do you mean it would be faster?
> >> I think with .reset_map() we at least can avoid indefinite latency
> >> hiccup from destroying and recreating 1:1 mapping with the unwarranted
> >> 2rd unmap call. And .reset_map() should work with both .dma_map() and
> >> .set_map() APIs with clear semantics.
> >>
> >> Regards,
> >> -Siwei
> >>> Thanks
> >>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
> >>>>> Author: Eli Cohen <elic@nvidia.com>
> >>>>> Date:   Wed Jun 2 11:58:54 2021 +0300
> >>>>>
> >>>>>        vdpa/mlx5: Add support for running with virtio_vdpa
> >>>>>
> >>>>>        In order to support running vdpa using vritio_vdpa driver, w=
e need  to
> >>>>>        create a different kind of MR, one that has 1:1 mapping, sin=
ce the
> >>>>>        addresses referring to virtqueues are dma addresses.
> >>>>>
> >>>>>        We create the 1:1 MR in mlx5_vdpa_dev_add() only in case fir=
mware
> >>>>>        supports the general capability umem_uid_0. The reason for t=
hat is that
> >>>>>        1:1 MRs must be created with uid =3D=3D 0 while virtqueue ob=
jects can be
> >>>>>        created with uid =3D=3D 0 only when the firmware capability =
is on.
> >>>>>
> >>>>>        If the set_map() callback is called with new translations pr=
ovided
> >>>>>        through iotlb, the driver will destroy the 1:1 MR and create=
 a regular
> >>>>>        one.
> >>>>>
> >>>>>        Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>>>>        Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@=
nvidia.com
> >>>>>        Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>>        Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>> +                                   struct vhost_iotlb *iotlb,
> >>>>>> +                                   unsigned int asid)
> >>>>>>     {
> >>>>>>            struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>>            int err;
> >>>>>>
> >>>>>> -       if (mr->initialized)
> >>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>>>>                    return 0;
> >>>>>>
> >>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid)=
 {
> >>>>>> -               if (iotlb)
> >>>>>> -                       err =3D create_user_mr(mvdev, iotlb);
> >>>>>> -               else
> >>>>>> -                       err =3D create_dma_mr(mvdev, mr);
> >>>>>> +       if (mr->initialized)
> >>>>>> +               return 0;
> >>>>>>
> >>>>>> -               if (err)
> >>>>>> -                       return err;
> >>>>>> -       }
> >>>>>> +       if (iotlb)
> >>>>>> +               err =3D create_user_mr(mvdev, iotlb);
> >>>>>> +       else
> >>>>>> +               err =3D create_dma_mr(mvdev, mr);
> >>>>>>
> >>>>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) {
> >>>>>> -               err =3D dup_iotlb(mvdev, iotlb);
> >>>>>> -               if (err)
> >>>>>> -                       goto out_err;
> >>>>>> -       }
> >>>>>> +       if (err)
> >>>>>> +               return err;
> >>>>>>
> >>>>>>            mr->initialized =3D true;
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>> +                               struct vhost_iotlb *iotlb, unsigne=
d int asid)
> >>>>>> +{
> >>>>>> +       int err;
> >>>>>> +
> >>>>>> +       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> >>>>>> +       if (err)
> >>>>>> +               return err;
> >>>>>> +
> >>>>>> +       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> >>>>>> +       if (err)
> >>>>>> +               goto out_err;
> >>>>>> +
> >>>>>>            return 0;
> >>>>>>
> >>>>>>     out_err:
> >>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid)=
 {
> >>>>>> -               if (iotlb)
> >>>>>> -                       destroy_user_mr(mvdev, mr);
> >>>>>> -               else
> >>>>>> -                       destroy_dma_mr(mvdev, mr);
> >>>>>> -       }
> >>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>>>>
> >>>>>>            return err;
> >>>>>>     }
> >>>>>> --
> >>>>>> 2.41.0
> >>>>>>
> >>>>> _______________________________________________
> >>>>> Virtualization mailing list
> >>>>> Virtualization@lists.linux-foundation.org
> >>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

