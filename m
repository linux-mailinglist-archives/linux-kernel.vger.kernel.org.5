Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2227DEDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjKBIQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjKBIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F61185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698912935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFKsEKzMqdTXmNEgyPABTN8mI4iPSC4G65mkKZOmYsc=;
        b=ILHQZG9M3+IU50FCjxpZJ/EureKiuYvRz07c9byZbFMhlZQ1UkfubEoK8/6AFT3VSg5pAt
        aNsKEIQDYewx9sEVUA6C2QWG7ZqX5QszuhIHfPNdkcl3q+vj/K34YHcSWI/Ek7HpVDtACn
        GK53auKinIK7Fi2FRxCjV2T5dgnE/54=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-AxoSXHcSOe2aI33t0wgzrQ-1; Thu, 02 Nov 2023 04:15:33 -0400
X-MC-Unique: AxoSXHcSOe2aI33t0wgzrQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079a3362afso535324e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912931; x=1699517731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFKsEKzMqdTXmNEgyPABTN8mI4iPSC4G65mkKZOmYsc=;
        b=Qz890p7fX5uxCqHCRiOURKI9tgroagm+66NfXjQ/GEiIQ+owPS5VUOYIaj0tm8XfyZ
         kxo7nB8qppiQOCvgDCjjtltFGuA5BxUz78HT0ZFTF6R5XtZGsTGr3leI23yFAXqN33LS
         /wq3CsXgrYtwNSjePe531CChtZFnkqCI8hv0hVFwg/RmupR3nuu8d0b6fsqCnHzQf/MJ
         x3/x9yOUkuVTLU3kHCmbeCh/J/Fj5PW4cb5TRdrijlQJ4Y/TeJi2WucKOGXPpLSFE7vg
         rHUzM0p0baiJkReSr9IW5hZV59S0wGdsSIjjAUF6GyODVD8oZtks9hP48g+S6JlQwpO2
         1Ydw==
X-Gm-Message-State: AOJu0Yz0rGGtH86W7jpBXb9/I+2Nn3763Y7kbwMZpHlJcOowqSK/SR7B
        Zx9NbkWLziwNXYy2UW4bz0x60x7xq4z+Lz5hs5tzeR2OwDYkBPxQmTbIYhrNKlT1ghtsj4M7RLM
        CLhctpciYrEWOxoo26lQCZpXyOS+6i6lyss74fshGF/sEW+fwA4A=
X-Received: by 2002:ac2:55a2:0:b0:507:cb61:2054 with SMTP id y2-20020ac255a2000000b00507cb612054mr13495805lfg.49.1698912931097;
        Thu, 02 Nov 2023 01:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu2lBr+3T/yTKhgfdnjCHFVsV0eOqpx+dZym2wOWoCb8h510cr3//uegK3kk4tjv5jBm3SajFxi+kqSt7qldg=
X-Received: by 2002:ac2:55a2:0:b0:507:cb61:2054 with SMTP id
 y2-20020ac255a2000000b00507cb612054mr13495793lfg.49.1698912930773; Thu, 02
 Nov 2023 01:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <1698854083-136016-1-git-send-email-steven.sistare@oracle.com> <CAJaqyWfpgQcYbvRgYkvVAq5SiFVVJdWF9PLfOnvd7ipGcjYghA@mail.gmail.com>
In-Reply-To: <CAJaqyWfpgQcYbvRgYkvVAq5SiFVVJdWF9PLfOnvd7ipGcjYghA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 2 Nov 2023 16:15:18 +0800
Message-ID: <CACGkMEsNcuQNt+9od6D+O_RbxKcpG8U14zBSibRYz91SXiwZ7A@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa/mlx5: preserve CVQ vringh index
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Steve Sistare <steven.sistare@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:10=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Nov 1, 2023 at 4:55=E2=80=AFPM Steve Sistare <steven.sistare@orac=
le.com> wrote:
> >
> > mlx5_vdpa does not preserve userland's view of vring base for the contr=
ol
> > queue in the following sequence:
> >
> > ioctl VHOST_SET_VRING_BASE
> > ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
> >   mlx5_vdpa_set_status()
> >     setup_cvq_vring()
> >       vringh_init_iotlb()
> >         vringh_init_kern()
> >           vrh->last_avail_idx =3D 0;
> > ioctl VHOST_GET_VRING_BASE
> >
> > To fix, restore the value of cvq->vring.last_avail_idx after calling
> > vringh_init_iotlb.
> >
>
> Fixes tag missing?

+1

>
> Apart from that,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

With the fix tag added.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 946488b8989f..ca972af3c89a 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev=
 *mvdev)
> >         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> >         int err =3D 0;
> >
> > -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> > +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> > +               u16 idx =3D cvq->vring.last_avail_idx;
> > +
> >                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_fe=
atures,
> >                                         MLX5_CVQ_MAX_ENT, false,
> >                                         (struct vring_desc *)(uintptr_t=
)cvq->desc_addr,
> >                                         (struct vring_avail *)(uintptr_=
t)cvq->driver_addr,
> >                                         (struct vring_used *)(uintptr_t=
)cvq->device_addr);
> >
> > +               if (!err)
> > +                       cvq->vring.last_avail_idx =3D cvq->vring.last_u=
sed_idx =3D idx;
> > +       }
> >         return err;
> >  }
> >
> > --
> > 2.39.3
> >
>

