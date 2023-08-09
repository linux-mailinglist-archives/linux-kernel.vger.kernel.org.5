Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121B775345
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHIGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFB133
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691563940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9tBKjtSpHHxl1AkJItNSn8/QbHaCRugiDNJmq9KStE=;
        b=STjsES0mWLxukY8/uxEQerrovD6OiU7qNWxTQlC5S4/lLfWyQfHk+vz+/7kxxz1+QL5+3F
        OEjDu32SuR/lEVJW1YKuKx5janshTUylh1VSV0DFXIpXZzaY8HMQZ9INAWlLOO1PqwiS1M
        N+jIy1OX46devdSaqrWWtvarNlOcRqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-8MFAG3VQPsCvAupX-QI8hQ-1; Wed, 09 Aug 2023 02:52:19 -0400
X-MC-Unique: 8MFAG3VQPsCvAupX-QI8hQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9e8abe56bso62774441fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563937; x=1692168737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9tBKjtSpHHxl1AkJItNSn8/QbHaCRugiDNJmq9KStE=;
        b=R2xZ6Z4XCEhT/q0/pgkWUcHgj5PSGTfovt7IduV/k5z5rG6OZALhXSMPvpwG0bBLoE
         I9wxH9CzZyvGvVjrRRVZ9fPAAsps1Rk0XmRfwsXcfLFekqXo7lMBZTqsw71QdNzbHe0i
         vuOYVOUpVuOYFGy3er30pS+39ghFO2OENFQarkriktwVz9lac5CZzmuluuTHSFtRat5A
         Z++sFQg2OqVrsGj5ENcGWPtBhA5P7B52RWKMdymkiJf3RCPbzgQDPISRJUteIYndua+x
         SuEeYx2Y3jM/vLlfvMgbKt5i5LbnjrnPUsWnV60el8pplVJj9wmSD89CEl8o7UjqX06s
         WwiA==
X-Gm-Message-State: AOJu0YySHVeX250PqIWqSCiTbF3VyC79lk060BfqMpjoJYOVv4lJL+3z
        ozs/wP6V26w1IiQ1Bbmu2H77fGOpMEhg5vgkHL//ImblavmPx3XMLTtAZPy/d/rQINUQDP7YNCj
        3vtWZqgoSq79zw/wRpk8WcYEwwTKKWQtjNqXrhIz96+ZwxWpHJZs=
X-Received: by 2002:a2e:b055:0:b0:2b9:ebbd:be6f with SMTP id d21-20020a2eb055000000b002b9ebbdbe6fmr1239069ljl.3.1691563937117;
        Tue, 08 Aug 2023 23:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKpDceiJHQBJU5WgQmZzR9PdrJUuJMy1JHeEdyh0AN7FTw+aB7zgc6/GQYklVtXxFRc/dmrfvgDlnyaUDTWt0=
X-Received: by 2002:a2e:b055:0:b0:2b9:ebbd:be6f with SMTP id
 d21-20020a2eb055000000b002b9ebbdbe6fmr1239050ljl.3.1691563936750; Tue, 08 Aug
 2023 23:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com> <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
In-Reply-To: <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Aug 2023 14:52:05 +0800
Message-ID: <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 6:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 8/7/2023 8:00 PM, Jason Wang wrote:
> > On Fri, Aug 4, 2023 at 1:58=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >>
> >>
> >> On 8/3/2023 1:03 AM, Jason Wang wrote:
> >>> On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> >>>> The mr->initialized flag is shared between the control vq and data v=
q
> >>>> part of the mr init/uninit. But if the control vq and data vq get pl=
aced
> >>>> in different ASIDs, it can happen that initializing the control vq w=
ill
> >>>> prevent the data vq mr from being initialized.
> >>>>
> >>>> This patch consolidates the control and data vq init parts into thei=
r
> >>>> own init functions. The mr->initialized will now be used for the dat=
a vq
> >>>> only. The control vq currently doesn't need a flag.
> >>>>
> >>>> The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr =
got
> >>>> split into data and control vq functions which are now also ASID awa=
re.
> >>>>
> >>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces fo=
r control and data")
> >>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >>>> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
> >>>> ---
> >>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >>>>    drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++----=
-----
> >>>>    2 files changed, 71 insertions(+), 27 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/=
core/mlx5_vdpa.h
> >>>> index 25fc4120b618..a0420be5059f 100644
> >>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>>> @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> >>>>           struct list_head head;
> >>>>           unsigned long num_directs;
> >>>>           unsigned long num_klms;
> >>>> +       /* state of dvq mr */
> >>>>           bool initialized;
> >>>>
> >>>>           /* serialize mkey creation and destruction */
> >>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr=
.c
> >>>> index 03e543229791..4ae14a248a4b 100644
> >>>> --- a/drivers/vdpa/mlx5/core/mr.c
> >>>> +++ b/drivers/vdpa/mlx5/core/mr.c
> >>>> @@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_=
dev *mvdev, struct mlx5_vdpa_mr *mr
> >>>>           }
> >>>>    }
> >>>>
> >>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>> +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, =
unsigned int asid)
> >>>> +{
> >>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>> +               return;
> >>>> +
> >>>> +       prune_iotlb(mvdev);
> >>>> +}
> >>>> +
> >>>> +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, =
unsigned int asid)
> >>>>    {
> >>>>           struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>
> >>>> -       mutex_lock(&mr->mkey_mtx);
> >>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>> +               return;
> >>>> +
> >>>>           if (!mr->initialized)
> >>>> -               goto out;
> >>>> +               return;
> >>>>
> >>>> -       prune_iotlb(mvdev);
> >>>>           if (mr->user_mr)
> >>>>                   destroy_user_mr(mvdev, mr);
> >>>>           else
> >>>>                   destroy_dma_mr(mvdev, mr);
> >>>>
> >>>>           mr->initialized =3D false;
> >>>> -out:
> >>>> +}
> >>>> +
> >>>> +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, =
unsigned int asid)
> >>>> +{
> >>>> +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>> +
> >>>> +       mutex_lock(&mr->mkey_mtx);
> >>>> +
> >>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>> +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> >>>> +
> >>>>           mutex_unlock(&mr->mkey_mtx);
> >>>>    }
> >>>>
> >>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>> -                               struct vhost_iotlb *iotlb, unsigned =
int asid)
> >>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>>> +{
> >>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA=
_CVQ_GROUP]);
> >>>> +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA=
_DATAVQ_GROUP]);
> >>>> +}
> >>>> +
> >>>> +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
> >>>> +                                   struct vhost_iotlb *iotlb,
> >>>> +                                   unsigned int asid)
> >>>> +{
> >>>> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> >>>> +               return 0;
> >>>> +
> >>>> +       return dup_iotlb(mvdev, iotlb);
> >>> This worries me as conceptually, there should be no difference betwee=
n
> >>> dvq mr and cvq mr. The virtqueue should be loosely coupled with mr.
> >>>
> >>> One example is that, if we only do dup_iotlb() but not try to create
> >>> dma mr here, we will break virtio-vdpa:
> >> For this case, I guess we may need another way to support virtio-vdpa
> >> 1:1 mapping rather than overloading virtio device reset semantics, see=
:
> >>
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>
> >>   > Conceptually, the address mapping is not a part of the abstraction=
 for
> >>   > a virtio device now. So resetting the memory mapping during virtio
> >>   > device reset seems wrong.
> >>
> >> where we want to keep memory mapping intact across virtio device reset
> >> for best live migration latency/downtime. I wonder would it work to
> >> reset the mapping in vhost-vdpa life cycle out of virtio reset, say
> >> introduce a .reset_map() op to restore 1:1 mapping within
> >> vhost_vdpa_remove_as() right after vhost_vdpa_iotlb_unmap()? Then we c=
an
> >> move the iotlb reset logic to there without worry breaking virtio-vdpa=
.
> > It looks to me we don't need a new ops. We can simply do set_map()
> > twice
> What does it mean, first set_map(0, -1ULL) with zero iotlb entry passed
> in to destroy all iotlb mappings previously added, and second set_map(0,
> -1ULL) to restore 1:1 DMA MR? But userspace (maybe a buggy one but
> doesn't do harm) apart from vhost-vdpa itself can do unmap twice anyway,
> this is supported today I think. Why there'll be such obscure
> distinction, or what's the benefit to treat second .set_map() as
> recreating 1:1 mapping?

Ok, I think I miss some context. I agree that it's better to decouple
memory mappings from the virtio reset. It helps to reduce the
unnecessary memory transactions. It might require a new feature flag.

Regarding the method of restoring to 1:1 DMA MR, it might be dangerous
for (buggy) vhost-vDPA devices. Since its userspace doesn't set up any
mapping it can explore the kernel with that via CVQ?

Thanks

>
> >   or do you mean it would be faster?
> I think with .reset_map() we at least can avoid indefinite latency
> hiccup from destroying and recreating 1:1 mapping with the unwarranted
> 2rd unmap call. And .reset_map() should work with both .dma_map() and
> .set_map() APIs with clear semantics.
>
> Regards,
> -Siwei
> >
> > Thanks
> >
> >> Thanks,
> >> -Siwei
> >>
> >>> commit 6f5312f801836e6af9bcbb0bdb44dc423e129206
> >>> Author: Eli Cohen <elic@nvidia.com>
> >>> Date:   Wed Jun 2 11:58:54 2021 +0300
> >>>
> >>>       vdpa/mlx5: Add support for running with virtio_vdpa
> >>>
> >>>       In order to support running vdpa using vritio_vdpa driver, we n=
eed  to
> >>>       create a different kind of MR, one that has 1:1 mapping, since =
the
> >>>       addresses referring to virtqueues are dma addresses.
> >>>
> >>>       We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmwa=
re
> >>>       supports the general capability umem_uid_0. The reason for that=
 is that
> >>>       1:1 MRs must be created with uid =3D=3D 0 while virtqueue objec=
ts can be
> >>>       created with uid =3D=3D 0 only when the firmware capability is =
on.
> >>>
> >>>       If the set_map() callback is called with new translations provi=
ded
> >>>       through iotlb, the driver will destroy the 1:1 MR and create a =
regular
> >>>       one.
> >>>
> >>>       Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>>       Link: https://lore.kernel.org/r/20210602085854.62690-1-elic@nvi=
dia.com
> >>>       Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>       Acked-by: Jason Wang <jasowang@redhat.com>
> >>>
> >>> Thanks
> >>>
> >>>
> >>>> +}
> >>>> +
> >>>> +static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
> >>>> +                                   struct vhost_iotlb *iotlb,
> >>>> +                                   unsigned int asid)
> >>>>    {
> >>>>           struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>>           int err;
> >>>>
> >>>> -       if (mr->initialized)
> >>>> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D asid)
> >>>>                   return 0;
> >>>>
> >>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> >>>> -               if (iotlb)
> >>>> -                       err =3D create_user_mr(mvdev, iotlb);
> >>>> -               else
> >>>> -                       err =3D create_dma_mr(mvdev, mr);
> >>>> +       if (mr->initialized)
> >>>> +               return 0;
> >>>>
> >>>> -               if (err)
> >>>> -                       return err;
> >>>> -       }
> >>>> +       if (iotlb)
> >>>> +               err =3D create_user_mr(mvdev, iotlb);
> >>>> +       else
> >>>> +               err =3D create_dma_mr(mvdev, mr);
> >>>>
> >>>> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) {
> >>>> -               err =3D dup_iotlb(mvdev, iotlb);
> >>>> -               if (err)
> >>>> -                       goto out_err;
> >>>> -       }
> >>>> +       if (err)
> >>>> +               return err;
> >>>>
> >>>>           mr->initialized =3D true;
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> >>>> +                               struct vhost_iotlb *iotlb, unsigned =
int asid)
> >>>> +{
> >>>> +       int err;
> >>>> +
> >>>> +       err =3D _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
> >>>> +       if (err)
> >>>> +               return err;
> >>>> +
> >>>> +       err =3D _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
> >>>> +       if (err)
> >>>> +               goto out_err;
> >>>> +
> >>>>           return 0;
> >>>>
> >>>>    out_err:
> >>>> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> >>>> -               if (iotlb)
> >>>> -                       destroy_user_mr(mvdev, mr);
> >>>> -               else
> >>>> -                       destroy_dma_mr(mvdev, mr);
> >>>> -       }
> >>>> +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> >>>>
> >>>>           return err;
> >>>>    }
> >>>> --
> >>>> 2.41.0
> >>>>
> >>> _______________________________________________
> >>> Virtualization mailing list
> >>> Virtualization@lists.linux-foundation.org
> >>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

