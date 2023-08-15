Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FE77C518
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjHOB3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjHOB3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41553171B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692062913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VE6mob003STEOzTU2eNJ6jYzNMv9F/ENb7pqQWeZKlY=;
        b=eQ+eT+HIUTyznN2zvxmDsbgKwTteETX35dmIhnQzrG2LQdl1ZwuFChg5a39JzpLaQXYxUT
        qY85F6BqB7eClZWkRlvcSbV2Eg7gj71s0iTmrsyd4nWu367F+iyVe43Avd6uydS7XbX121
        PkoCy2l69vXuYB3qpicRO+RRK2i5FEs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Kdw5vQhLOdGekyfsRn3s0A-1; Mon, 14 Aug 2023 21:28:31 -0400
X-MC-Unique: Kdw5vQhLOdGekyfsRn3s0A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9c22c3d68so28431731fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692062910; x=1692667710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE6mob003STEOzTU2eNJ6jYzNMv9F/ENb7pqQWeZKlY=;
        b=J4QqasrrNZC1/q3q5cD+3rrw2k77Buf41iHs6gP5c8fqeqWn/4HwXj1TeK7oZ7JHdC
         StRT2FWSIL4UensfdJh+zskEGb4KvzdXPzl4HthaoV2C0jmcG/oCHcvYc4d9OvuEfO6P
         LTTv95uzbKMqnhue+IJkElA061QKKEjlvFfyG0W0qDs0LrY3FdQgM8Ru3MXpSdTQ1Bte
         EzSNADpCR2epbzdivelS6xfOIFhL/mnmFmMeB9NDX888LzfJNiSW62Y5SX9FFnmUl0+d
         BnznKTSDFIj0Tifn4R45Vgtg6IcMotZzM6kD+n252fXP2W1ujEkpawd2JOGHfjyynKq6
         xZvw==
X-Gm-Message-State: AOJu0YyTR7yQ+1NIGcNV5KsIdSIEoFp7e/0rcxFnfFVq58Ni77Xlzoc5
        X1Uayp3zL1UcS6QI7vESk5NLRSgLBSZctrrwA395qpBmFd106sY5II0P7elVDOURYh6uxoclK/7
        L+uyektanLoq45fr5aPe4UbpBv6vdVjKXad4paPTE
X-Received: by 2002:a05:651c:324:b0:2b9:b1fb:5ff4 with SMTP id b4-20020a05651c032400b002b9b1fb5ff4mr152368ljp.21.1692062910255;
        Mon, 14 Aug 2023 18:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvWOWCxpqCNTpDtqy6UKDkdmXaQ46MPGRiK9GSWe2FregOL7ihD6zQjbmg/VMrJzLvEcpXYAbNdb191YrWGa4=
X-Received: by 2002:a05:651c:324:b0:2b9:b1fb:5ff4 with SMTP id
 b4-20020a05651c032400b002b9b1fb5ff4mr152360ljp.21.1692062909897; Mon, 14 Aug
 2023 18:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com> <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
 <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com>
 <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
 <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com> <8316b7a41f80d9a0b03795e33201be02b3be756e.camel@nvidia.com>
In-Reply-To: <8316b7a41f80d9a0b03795e33201be02b3be756e.camel@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Aug 2023 09:28:18 +0800
Message-ID: <CACGkMEsGfbOK-SX-xv2Re5PrPt343UdvgxU+etvXBTmQEjhwSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
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

On Mon, Aug 14, 2023 at 10:15=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Wed, 2023-08-09 at 09:42 +0800, Jason Wang wrote:
> > On Tue, Aug 8, 2023 at 3:24=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Tue, 2023-08-08 at 10:57 +0800, Jason Wang wrote:
> > > > On Thu, Aug 3, 2023 at 7:40=E2=80=AFPM Dragos Tatulea <dtatulea@nvi=
dia.com> wrote:
> > > > >
> > > > > On Thu, 2023-08-03 at 16:03 +0800, Jason Wang wrote:
> > > > > > On Thu, Aug 3, 2023 at 1:13=E2=80=AFAM Dragos Tatulea <dtatulea=
@nvidia.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > The mr->initialized flag is shared between the control vq and=
 data
> > > > > > > vq
> > > > > > > part of the mr init/uninit. But if the control vq and data vq=
 get
> > > > > > > placed
> > > > > > > in different ASIDs, it can happen that initializing the contr=
ol vq
> > > > > > > will
> > > > > > > prevent the data vq mr from being initialized.
> > > > > > >
> > > > > > > This patch consolidates the control and data vq init parts in=
to
> > > > > > > their
> > > > > > > own init functions. The mr->initialized will now be used for =
the
> > > > > > > data vq
> > > > > > > only. The control vq currently doesn't need a flag.
> > > > > > >
> > > > > > > The uninitializing part is also taken care of: mlx5_vdpa_dest=
roy_mr
> > > > > > > got
> > > > > > > split into data and control vq functions which are now also A=
SID
> > > > > > > aware.
> > > > > > >
> > > > > > > Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address sp=
aces
> > > > > > > for
> > > > > > > control and data")
> > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> > > > > > >  drivers/vdpa/mlx5/core/mr.c        | 97 ++++++++++++++++++++=
+------
> > > > > > > ---
> > > > > > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > index 25fc4120b618..a0420be5059f 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > @@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
> > > > > > >         struct list_head head;
> > > > > > >         unsigned long num_directs;
> > > > > > >         unsigned long num_klms;
> > > > > > > +       /* state of dvq mr */
> > > > > > >         bool initialized;
> > > > > > >
> > > > > > >         /* serialize mkey creation and destruction */
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/mr.c
> > > > > > > b/drivers/vdpa/mlx5/core/mr.c
> > > > > > > index 03e543229791..4ae14a248a4b 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > > > > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > > > > > @@ -489,60 +489,103 @@ static void destroy_user_mr(struct
> > > > > > > mlx5_vdpa_dev
> > > > > > > *mvdev, struct mlx5_vdpa_mr *mr
> > > > > > >         }
> > > > > > >  }
> > > > > > >
> > > > > > > -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > > > +static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *=
mvdev,
> > > > > > > unsigned
> > > > > > > int asid)
> > > > > > > +{
> > > > > > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       prune_iotlb(mvdev);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *=
mvdev,
> > > > > > > unsigned
> > > > > > > int asid)
> > > > > > >  {
> > > > > > >         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > > > > > >
> > > > > > > -       mutex_lock(&mr->mkey_mtx);
> > > > > > > +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] !=3D as=
id)
> > > > > > > +               return;
> > > > > > > +
> > > > > > >         if (!mr->initialized)
> > > > > > > -               goto out;
> > > > > > > +               return;
> > > > > > >
> > > > > > > -       prune_iotlb(mvdev);
> > > > > > >         if (mr->user_mr)
> > > > > > >                 destroy_user_mr(mvdev, mr);
> > > > > > >         else
> > > > > > >                 destroy_dma_mr(mvdev, mr);
> > > > > > >
> > > > > > >         mr->initialized =3D false;
> > > > > > > -out:
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *=
mvdev,
> > > > > > > unsigned
> > > > > > > int asid)
> > > > > > > +{
> > > > > > > +       struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> > > > > > > +
> > > > > > > +       mutex_lock(&mr->mkey_mtx);
> > > > > > > +
> > > > > > > +       _mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
> > > > > > > +       _mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
> > > > > > > +
> > > > > > >         mutex_unlock(&mr->mkey_mtx);
> > > > > > >  }
> > > > > > >
> > > > > > > -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> > > > > > > -                               struct vhost_iotlb *iotlb, un=
signed
> > > > > > > int
> > > > > > > asid)
> > > > > > > +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > > > +{
> > > > > > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > > > > > > group2asid[MLX5_VDPA_CVQ_GROUP]);
> > > > > > > +       mlx5_vdpa_destroy_mr_asid(mvdev, mvdev-
> > > > > > > > group2asid[MLX5_VDPA_DATAVQ_GROUP]);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mv=
dev,
> > > > > > > +                                   struct vhost_iotlb *iotlb=
,
> > > > > > > +                                   unsigned int asid)
> > > > > > > +{
> > > > > > > +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       return dup_iotlb(mvdev, iotlb);
> > > > > >
> > > > > > This worries me as conceptually, there should be no difference =
between
> > > > > > dvq mr and cvq mr. The virtqueue should be loosely coupled with=
 mr.
> > > > > >
> > > > > Are you worried by the changes in this patch or about the possibi=
lity of
> > > > > having
> > > > >
> > > > > The reason for this change is that I noticed if you create one mr=
 in one
> > > > > asid
> > > > > you could be blocked out from creating another one in a different=
 asid
> > > > > due
> > > > > to
> > > > > mr->initialized being true. To me that seemed problematic. Is it =
not?
> > > >
> > > > My feeling is that mr.c should be device agnostic. It needs to know
> > > > nothing about the device details to work. But this patch seems to
> > > > break the layer.
> > > >
> > > But the same logic was there before (with the exception of cvq not ha=
ving an
> > > init flag anymore). So what am I missing here?
> >
> > Nothing, I think you're right.
> >
> > I think we can have this patch go first and tweak on top by moving CVQ
> > aware logic into the net specific codes.
> >
> Is this anything more than a re-org?

No.

> My plan is to move the cvq mr part from
> mlx5_vdpa_dev into mlx5_vdpa_net. Is there anything else that you were ex=
pecting
> here?
>

That's fine.

Thanks

> Thanks,
> Dragos

