Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA777AFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHNDAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjHNDAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D65A2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691981971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Wsqg0CJ+ZJensLrSIYeU6hyG6UFSARJh1M0Jrin2SA=;
        b=CXWDnybbCdJiBdWxQotSS6vaZ++0xPfAzYJyygrTVJtN+nzT/f5ZIUx7Z6u8ZP9bHq8Kpg
        47N3Iw22afVIFJZDkyDJ4FHx+j3IDqbA7j29Wz51D6gqIsilV+uKR74m1LfPlSKT5NPpg5
        k7i4Wehp68NiVU3lycuhks6oRdJzJgA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-owVQoit2Ou6RAr9y0QG18Q-1; Sun, 13 Aug 2023 22:59:29 -0400
X-MC-Unique: owVQoit2Ou6RAr9y0QG18Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe0fe8dfe0so2713965e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691981968; x=1692586768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wsqg0CJ+ZJensLrSIYeU6hyG6UFSARJh1M0Jrin2SA=;
        b=kQb6W+MPD6iErY3w0uNPlo4qVh02Ek2LaqERkxGkp9sK/AegLdnlWPPgWRwt6E/uwz
         B+yjLfv7osMphGZO9V9uVvSTMl+hYfuxLIuyITsGYNM+jto6ZqQzNfUAzmPQbbQ+gonr
         yUFwyMkTANTSKWJTKKqRVAXF1nFBk2wa/XiBn9NjEw11xpe6Ur1GtWCy7YxJPYvGgcxl
         o3CDHi8CliGvBbffJ0CO3qjtxhdN6YnBYPsZLdrD0MrfxMfkwA58fXwIYXqTFpgxJSW/
         GjcTlnKbpa48R+H8jyXpnvvXqKDeFrwa+I9+eJJsNGQyjomKCHk9sFfDTssDwtG0CoNG
         luRw==
X-Gm-Message-State: AOJu0YwK6+8wleQVxARNKBLAUttal8LIuyLs41JI96ukGoxnRVGnCseS
        57rURGw/qZAIZqjRKTNYhaP936HaBRalpp+yLx3qxFVOaWVqh2Lz1NHO9rhztBj+rGRODFjKl3X
        N/3Gx3fPSIc43YhtfKa7TsjIQ9xi33BZy07WK5Nlb
X-Received: by 2002:a05:6512:3d06:b0:4f8:586a:d6ca with SMTP id d6-20020a0565123d0600b004f8586ad6camr4408714lfv.9.1691981967936;
        Sun, 13 Aug 2023 19:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjcx33B7vpXw58qhS25NGNKHWnjU7nIYj0+Hzmfv9T2BnS3HFw7SV6Vxz/RHYBqRJDXlcdBG2B/USfMmubok=
X-Received: by 2002:a05:6512:3d06:b0:4f8:586a:d6ca with SMTP id
 d6-20020a0565123d0600b004f8586ad6camr4408707lfv.9.1691981967670; Sun, 13 Aug
 2023 19:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com> <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com> <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
 <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com> <CACGkMEtWsBRtW3DNQudcWJEtRb7isG-yRvvL3kL2L7k_=TgkZQ@mail.gmail.com>
 <325aaca0-ccdf-1843-4ab8-03bc94d3ea98@oracle.com>
In-Reply-To: <325aaca0-ccdf-1843-4ab8-03bc94d3ea98@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Aug 2023 10:59:16 +0800
Message-ID: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 6:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 8/9/2023 8:10 PM, Jason Wang wrote:
> > On Thu, Aug 10, 2023 at 8:40=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 8/8/2023 11:52 PM, Jason Wang wrote:
> >>> On Wed, Aug 9, 2023 at 6:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.=
com> wrote:
> >>>>
> >>>> On 8/7/2023 8:00 PM, Jason Wang wrote:
> >>>>> On Fri, Aug 4, 2023 at 1:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>>> On 8/3/2023 1:03 AM, Jason Wang wrote:
> >>>>>>> On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@n=
vidia.com> wrote:
> >>>>>>>> The mr->initialized flag is shared between the control vq and da=
ta vq
> >>>>>>>> part of the mr init/uninit. But if the control vq and data vq ge=
t placed
> >>>>>>>> in different ASIDs, it can happen that initializing the control =
vq will
> >>>>>>>> prevent the data vq mr from being initialized.
> >>>>>>>>
> >>>>>>>> This patch consolidates the control and data vq init parts into =
their
> >>>>>>>> own init functions. The mr->initialized will now be used for the=
 data vq
> >>>>>>>> only. The control vq currently doesn't need a flag.
> >>>>>>>>
> >>>>>>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy=
_mr got
> >>>>>>>> split into data and control vq functions which are now also ASID=
 aware.
> >>>>>>>>
> >>>>>>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address space=
s for control and data")
> >>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>>>>>> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >>>>>>>>      drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++=
++---------
> >>>>>>>>      2 files changed, 71 insertions(+), 27 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/m=
lx5/core/mlx5_vdpa.h
> >>>>>>>> index 25fc4120b618..a0420be5059f 100644
> >>>>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>>>>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> >>>>>>>>             struct list_head head;
> >>>>>>>>             unsigned long num_directs;
> >>>>>>>>             unsigned long num_klms;
> >>>>>>>> +       /* state of dvq mr */
> >>>>>>>>             bool initialized;
> >>>>>>>>
> >>>>>>>>             /* serialize mkey creation and destruction */
> >>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/cor=
e/mr.c
> >>>>>>>> index 03e543229791..4ae14a248a4b 100644
> >>>>>>>> --- a/drivers/vdpa/mlx5/core/mr.c
> >>>>>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
> >>>>>>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_v=
dpa_dev *mvdev, struct mlx5_vdpa_mr *mr
> >>>>>>>>             }
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>>>>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvd=
ev, unsigned int asid)
> >>>>>>>> +{
> >>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>> +       prune_iotlb(mvdev);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvd=
ev, unsigned int asid)
> >>>>>>>>      {
> >>>>>>>>             struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>>>>
> >>>>>>>> -       mutex_lock(&mr->mkey_mtx);
> >>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>>             if (!mr->initialized)
> >>>>>>>> -               goto out;
> >>>>>>>> +               return;
> >>>>>>>>
> >>>>>>>> -       prune_iotlb(mvdev);
> >>>>>>>>             if (mr->user_mr)
> >>>>>>>>                     destroy_user_mr(mvdev, mr);
> >>>>>>>>             else
> >>>>>>>>                     destroy_dma_mr(mvdev, mr);
> >>>>>>>>
> >>>>>>>>             mr->initialized =3D false;
> >>>>>>>> -out:
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvd=
ev, unsigned int asid)
> >>>>>>>> +{
> >>>>>>>> +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>>>> +
> >>>>>>>> +       mutex_lock(&mr->mkey_mtx);
> >>>>>>>> +
> >>>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>>>>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> >>>>>>>> +
> >>>>>>>>             mutex_unlock(&mr->mkey_mtx);
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>>>> -                               struct vhost_iotlb *iotlb, unsig=
ned int asid)
> >>>>>>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>>>>>> +{
> >>>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_=
VDPA_CVQ_GROUP]);
> >>>>>>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_=
VDPA_DATAVQ_GROUP]);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev=
,
> >>>>>>>> +                                   struct vhost_iotlb *iotlb,
> >>>>>>>> +                                   unsigned int asid)
> >>>>>>>> +{
> >>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>>>>>> +               return 0;
> >>>>>>>> +
> >>>>>>>> +       return dup_iotlb(mvdev, iotlb);
> >>>>>>> This worries me as conceptually, there should be no difference be=
tween
> >>>>>>> dvq mr and cvq mr. The virtqueue should be loosely coupled with m=
r.
> >>>>>>>
> >>>>>>> One example is that, if we only do dup_iotlb() but not try to cre=
ate
> >>>>>>> dma mr here, we will break virtio-vdpa:
> >>>>>> For this case, I guess we may need another way to support virtio-v=
dpa
> >>>>>> 1:1 mapping rather than overloading virtio device reset semantics,=
 see:
> >>>>>>
> >>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>>>>>
> >>>>>>     > Conceptually, the address mapping is not a part of the abstr=
action for
> >>>>>>     > a virtio device now. So resetting the memory mapping during =
virtio
> >>>>>>     > device reset seems wrong.
> >>>>>>
> >>>>>> where we want to keep memory mapping intact across virtio device r=
eset
> >>>>>> for best live migration latency/downtime. I wonder would it work t=
o
> >>>>>> reset the mapping in vhost-vdpa life cycle out of virtio reset, sa=
y
> >>>>>> introduce a .reset_map() op to restore 1:1 mapping within
> >>>>>> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then =
we can
> >>>>>> move the iotlb reset logic to there without worry breaking virtio-=
vdpa.
> >>>>> It looks to me we don't need a new ops. We can simply do set_map()
> >>>>> twice
> >>>> What does it mean, first set_map(0, -1ULL) with zero iotlb entry pas=
sed
> >>>> in to destroy all iotlb mappings previously added, and second set_ma=
p(0,
> >>>> -1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but
> >>>> doesn't do harm) apart from vhost-vdpa itself can do unmap twice any=
way,
> >>>> this is supported today I think. Why there'll be such obscure
> >>>> distinction, or what's the benefit to treat second .set_map() as
> >>>> recreating 1:1 mapping?
> >>> Ok, I think I miss some context. I agree that it's better to decouple
> >>> memory mappings from the virtio reset. It helps to reduce the
> >>> unnecessary memory transactions. It might require a new feature flag.
> >> This I agreed. AFAICT QEMU would need to check this new feature flag t=
o
> >> make sure memory mappings are kept intact across reset, otherwise for
> >> the sake of avoid breaking older kernels it has to recreate all the
> >> mappings after reset like how it is done today.
> >>
> >>> Regarding the method of restoring to 1:1 DMA MR, it might be dangerou=
s
> >>> for (buggy) vhost-vDPA devices. Since its userspace doesn't set up an=
y
> >>> mapping it can explore the kernel with that via CVQ?
> >> Not sure I understand this proposal. The 1:1 DMA MR is first created a=
t
> >> vdpa device add, and gets destroyed implicitly when the first .set_map
> >> or .dma_map call is made, which is only possible after the vhost-vdpa
> >> module is loaded and bound to vdpa devices.
> > So what happens if there's a buggy userspace that doesn't do any IOTLB =
setup?
> Then parent driver doesn't do anything in .reset_map() - as the DMA MR
> is still there. Parent driver should be able to tell apart if DMA MR has
> been destroyed or not by checking the internal state.

Would you mind posting a patch to demonstrate this?

Thanks

>
> -Siwei
>
> >
> > Thanks
> >
> >> Naturally the DMA MR should
> >> be restored to how it was before when vhost-vdpa module is unloaded, o=
r
> >> if anything the 1:1 DMA MR creation can be deferred to until virtio-vd=
pa
> >> is probed and bound to devices. Today vhost_vdpa_remove_as() as part o=
f
> >> the vhost-vdpa unload code path already gets all mappings purged throu=
gh
> >> vhost_vdpa_iotlb_unmap(0, -1ULL), and it should be pretty safe to
> >> restore DMA MR via .reset_map() right after. Not sure what's the conce=
rn
> >> here with buggy vhost-vdpa device?
> >>
> >> Noted when vhost-vdpa is being unloaded there's even no chance to prob=
e
> >> kernel through CVQ, as the virtio feature is not even negotiated at th=
at
> >> point. And it is even trickier to wait for CVQ response from device
> >> indefinitely when trying to unload a module.
> >>
> >> Regards,
> >> -Siwei
> >>> Thanks
> >>>
> >>>>>     or do you mean it would be faster?
> >>>> I think with .reset_map() we at least can avoid indefinite latency
> >>>> hiccup from destroying and recreating 1:1 mapping with the unwarrant=
ed
> >>>> 2rd unmap call. And .reset_map() should work with both .dma_map() an=
d
> >>>> .set_map() APIs with clear semantics.
> >>>>
> >>>> Regards,
> >>>> -Siwei
> >>>>> Thanks
> >>>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
> >>>>>>> Author: Eli Cohen <elic@nvidia.com>
> >>>>>>> Date:   Wed Jun 2 11:58:54 2021 +0300
> >>>>>>>
> >>>>>>>         vdpa/mlx5: Add support for running with virtio_vdpa
> >>>>>>>
> >>>>>>>         In order to support running vdpa using vritio_vdpa driver=
, we need  to
> >>>>>>>         create a different kind of MR, one that has 1:1 mapping, =
since the
> >>>>>>>         addresses referring to virtqueues are dma addresses.
> >>>>>>>
> >>>>>>>         We create the 1:1 MR in mlx5_vdpa_dev_add() only in case =
firmware
> >>>>>>>         supports the general capability umem_uid_0. The reason fo=
r that is that
> >>>>>>>         1:1 MRs must be created with uid =3D=3D 0 while virtqueue=
 objects can be
> >>>>>>>         created with uid =3D=3D 0 only when the firmware capabili=
ty is on.
> >>>>>>>
> >>>>>>>         If the set_map() callback is called with new translations=
 provided
> >>>>>>>         through iotlb, the driver will destroy the 1:1 MR and cre=
ate a regular
> >>>>>>>         one.
> >>>>>>>
> >>>>>>>         Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>>>>>>         Link: https://lore.kernel.org/r/20210602085854.62690-1-el=
ic@nvidia.com
> >>>>>>>         Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>>>>         Acked-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev=
,
> >>>>>>>> +                                   struct vhost_iotlb *iotlb,
> >>>>>>>> +                                   unsigned int asid)
> >>>>>>>>      {
> >>>>>>>>             struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>>>>>             int err;
> >>>>>>>>
> >>>>>>>> -       if (mr->initialized)
> >>>>>>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>>>>>>                     return 0;
> >>>>>>>>
> >>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asi=
d) {
> >>>>>>>> -               if (iotlb)
> >>>>>>>> -                       err =3D create_user_mr(mvdev, iotlb);
> >>>>>>>> -               else
> >>>>>>>> -                       err =3D create_dma_mr(mvdev, mr);
> >>>>>>>> +       if (mr->initialized)
> >>>>>>>> +               return 0;
> >>>>>>>>
> >>>>>>>> -               if (err)
> >>>>>>>> -                       return err;
> >>>>>>>> -       }
> >>>>>>>> +       if (iotlb)
> >>>>>>>> +               err =3D create_user_mr(mvdev, iotlb);
> >>>>>>>> +       else
> >>>>>>>> +               err =3D create_dma_mr(mvdev, mr);
> >>>>>>>>
> >>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) =
{
> >>>>>>>> -               err =3D dup_iotlb(mvdev, iotlb);
> >>>>>>>> -               if (err)
> >>>>>>>> -                       goto out_err;
> >>>>>>>> -       }
> >>>>>>>> +       if (err)
> >>>>>>>> +               return err;
> >>>>>>>>
> >>>>>>>>             mr->initialized =3D true;
> >>>>>>>> +
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>>>>>> +                               struct vhost_iotlb *iotlb, unsig=
ned int asid)
> >>>>>>>> +{
> >>>>>>>> +       int err;
> >>>>>>>> +
> >>>>>>>> +       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> >>>>>>>> +       if (err)
> >>>>>>>> +               return err;
> >>>>>>>> +
> >>>>>>>> +       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> >>>>>>>> +       if (err)
> >>>>>>>> +               goto out_err;
> >>>>>>>> +
> >>>>>>>>             return 0;
> >>>>>>>>
> >>>>>>>>      out_err:
> >>>>>>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asi=
d) {
> >>>>>>>> -               if (iotlb)
> >>>>>>>> -                       destroy_user_mr(mvdev, mr);
> >>>>>>>> -               else
> >>>>>>>> -                       destroy_dma_mr(mvdev, mr);
> >>>>>>>> -       }
> >>>>>>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>>>>>>
> >>>>>>>>             return err;
> >>>>>>>>      }
> >>>>>>>> --
> >>>>>>>> 2.41.0
> >>>>>>>>
> >>>>>>> _______________________________________________
> >>>>>>> Virtualization mailing list
> >>>>>>> Virtualization@lists.linux-foundation.org
> >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

