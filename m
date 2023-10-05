Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE787BA15C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjJEOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbjJEOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E376EAF99
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696515528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMuXK2Ra4fxZHmCwsBqtoYWPRKldmSYY2e45OESWayw=;
        b=ItPpjDTGU1cGFNxwUJTNVoKbpejWzgpDOmxMbdZdPssL7l5YMjdvPDyKrME7F1imYV53vs
        tl1u8E6Cbq4NMmGrbhPqGPJdwAXQ3I1DK1jNZqQ1WsOOzfRhRrt92BniAljp/vUewp6K7o
        6X068eXMpysDreJnfdcTL/i9petUdxs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-YxDBpCFVNhOJZiJYTllIXA-1; Thu, 05 Oct 2023 10:18:47 -0400
X-MC-Unique: YxDBpCFVNhOJZiJYTllIXA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-59bdb9fe821so15169367b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696515526; x=1697120326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMuXK2Ra4fxZHmCwsBqtoYWPRKldmSYY2e45OESWayw=;
        b=CZg64wplYs2ruS4dytPqAWxkBo+myOpD7zwkDjKusZDoUWubl+/oVjxAk5Dnj9VGDk
         KmEzNWfp4qJu8JzAf06Wfdw7YkfEHNpGxoNtkTreDbEYi0odaGGOTzyOCkkuRujUuJKC
         1jubzHd1omthMiAFaor+0s+uavk80Ah4kyMYTx2PrLlphz4nwM+Bjabf0lxolFDS2+m3
         ljZnlXAwDQvFOxEtv5xCFCJQ4tyHYx/0i+wOGGng/rXtdTIEL4N5WF/avbsiexOcS1YQ
         /KY0wiLW3J3+UPkynEBxbMIWI8BaRSPRklj+D3shUNSuWX0E+Mplk2UDT6ropLMWLDY7
         4kww==
X-Gm-Message-State: AOJu0YzWnKnxhq1rRWDiUkzZlWe5P/y47dyRwmZTWP1YIGoSXMD+WeNN
        n2FjfNfQY6ZTgjYLzKWmqvWVvfZnPvjI5L12I18jfs9J/Rz235JSNzRo5lSMNgkBcITuwqrfcrW
        bQuw/MPF4beFxImXBCuC4ZiSumRiVL+z3ZrMy2cQW
X-Received: by 2002:a81:49d8:0:b0:55a:574f:327c with SMTP id w207-20020a8149d8000000b0055a574f327cmr6428695ywa.13.1696515526475;
        Thu, 05 Oct 2023 07:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcjN/Dms9Ppwnv/WEIeR/Wj89K33YqgoYkJYYgxdZFKoAqW2buEkkDcRnw9BWgJ3vIZ/0oFeGgXdFdnPqjusU=
X-Received: by 2002:a81:49d8:0:b0:55a:574f:327c with SMTP id
 w207-20020a8149d8000000b0055a574f327cmr6428677ywa.13.1696515526241; Thu, 05
 Oct 2023 07:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-18-dtatulea@nvidia.com>
 <CAJaqyWe9iYnh_DwZbU4986bSAZ0C1=Y9Th6-vv_ZRTTYwQqhYA@mail.gmail.com> <b6f90921bc239fc0e1fc04dc62e4376fcd622376.camel@nvidia.com>
In-Reply-To: <b6f90921bc239fc0e1fc04dc62e4376fcd622376.camel@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 5 Oct 2023 16:18:10 +0200
Message-ID: <CAJaqyWdwgLOZUuw0PkKE-5ZX9Z3x98+5FZjzOCY_oOZg-jnmwA@mail.gmail.com>
Subject: Re: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID change
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
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

On Thu, Oct 5, 2023 at 3:12=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Thu, 2023-10-05 at 12:41 +0200, Eugenio Perez Martin wrote:
> > On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > For the following sequence:
> > > - cvq group is in ASID 0
> > > - .set_map(1, cvq_iotlb)
> > > - .set_group_asid(cvq_group, 1)
> > >
> > > ... the cvq mapping from ASID 0 will be used. This is not always corr=
ect
> > > behaviour.
> > >
> > > This patch adds support for the above mentioned flow by saving the io=
tlb
> > > on each .set_map and updating the cvq iotlb with it on a cvq group ch=
ange.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
> > >  drivers/vdpa/mlx5/core/mr.c        | 26 ++++++++++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  9 ++++++++-
> > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > index ae09296f4270..db988ced5a5d 100644
> > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > @@ -32,6 +32,8 @@ struct mlx5_vdpa_mr {
> > >         unsigned long num_directs;
> > >         unsigned long num_klms;
> > >
> > > +       struct vhost_iotlb *iotlb;
> > > +
> > >         bool user_mr;
> > >  };
> > >
> > > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.=
c
> > > index a4135c16b5bf..403c08271489 100644
> > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > @@ -499,6 +499,8 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdp=
a_dev
> > > *mvdev, struct mlx5_vdpa_
> > >                 destroy_user_mr(mvdev, mr);
> > >         else
> > >                 destroy_dma_mr(mvdev, mr);
> > > +
> > > +       vhost_iotlb_free(mr->iotlb);
> > >  }
> > >
> > >  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
> > > @@ -558,6 +560,30 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa=
_dev
> > > *mvdev,
> > >         else
> > >                 err =3D create_dma_mr(mvdev, mr);
> > >
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       mr->iotlb =3D vhost_iotlb_alloc(0, 0);
> > > +       if (!mr->iotlb) {
> > > +               err =3D -ENOMEM;
> > > +               goto err_mr;
> > > +       }
> > > +
> > > +       err =3D dup_iotlb(mr->iotlb, iotlb);
> > > +       if (err)
> > > +               goto err_iotlb;
> > > +
> > > +       return 0;
> > > +
> > > +err_iotlb:
> > > +       vhost_iotlb_free(mr->iotlb);
> > > +
> > > +err_mr:
> > > +       if (iotlb)
> > > +               destroy_user_mr(mvdev, mr);
> > > +       else
> > > +               destroy_dma_mr(mvdev, mr);
> > > +
> > >         return err;
> > >  }
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 46441e41892c..fc5d6b989a5a 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3154,12 +3154,19 @@ static int mlx5_set_group_asid(struct vdpa_de=
vice
> > > *vdev, u32 group,
> > >                                unsigned int asid)
> > >  {
> > >         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > +       int err =3D 0;
> > >
> > >         if (group >=3D MLX5_VDPA_NUMVQ_GROUPS || asid >=3D MLX5_VDPA_=
NUM_AS)
> > >                 return -EINVAL;
> > >
> > >         mvdev->group2asid[group] =3D asid;
> > > -       return 0;
> > > +
> > > +       mutex_lock(&mvdev->mr_mtx);
> > > +       if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mr[asid])
> > > +               err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mr[a=
sid]-
> > > >iotlb, asid);
> >
> > Do we need to protect here in case userspace sets the same ASID twice?
> > mlx5_vdpa_update_cvq_iotlb shouldn't call dup_iotlb with the same src
> > and dst.
>
> Why would src and dst be identical? Doesn't dup_iotlb create a copy of sr=
c?
>

Just in case we're not on the same page, my point is that (malicious?)
userspace is able to trigger it with this patch.

> That being said, there should be a check in dup_iotlb for dst =3D=3D src.=
 Not sure
> if this is an error or success though...
>

I think it should be a no-op, whatever level it is checked.

Thanks!

> Thanks,
> Dragos
> -
> > Apart from that:
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > > +       mutex_unlock(&mvdev->mr_mtx);
> > > +
> > > +       return err;
> > >  }
> > >
> > >  static const struct vdpa_config_ops mlx5_vdpa_ops =3D {
> > > --
> > > 2.41.0
> > >
> >
>

