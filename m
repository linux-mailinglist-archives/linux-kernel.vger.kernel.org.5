Return-Path: <linux-kernel+bounces-83060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDF868DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1D0B2781C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50CF1386B2;
	Tue, 27 Feb 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvcU13pF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28186F9D6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031028; cv=none; b=OkuVWOQR3n4um4uT1FhlimI8pmSgYgxEB5E2t6f0qTILjJ6G6claV7NVjieeaWgI7PvZrjLrrqrMdqIyOQf2VDpsfPWVDYcsb2qYOwyw4CBcMZdTiQSMXoAW0jY0yFUKEns2wHEnLxxahW4aI7NAbIxiiVMFusBXvM2HPGJTvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031028; c=relaxed/simple;
	bh=pFHY20CA+e9mEOAvOt8zJC8Qf6w27tcDfgr5WbY4wUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA2OL+HnUsyg3q4HpgK2gR7a66B8aYlnBFM3VVA3eD9iJQ1G0aXcL0Bcm8qsFTkeV+/aSqD3he8liGopf8BNXihZIMi0DkxGlN3X8Qmmx/KeDh/qCKrOq9yz1MPytzvhAE5JjGGNZv3JcIQaH8xKvKGKp5WwurEpS04EkDc8MTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvcU13pF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709031025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cN5XW9CUdGcYyNlH2Pi+8rFm+PkW6zNYvr9vLY8Pc/4=;
	b=TvcU13pFSoJYlZa9hmWW1dM9HfhJ5bT2vqvSLhg3EWrsm6Lh3ucSwUwrbAot3F6kXKxZhZ
	h4e7zvOBKLTmzhLz/f+yNkLsV0yjinlZB8v3RkZNgS5/SaQgrgp4ZAvD8HNi7oWlapVe+b
	zfFoN/r+ZiYKMHoE9GJY8cC1EtrICi0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-RZEwg6vNN6-fsHw4b6u2OQ-1; Tue, 27 Feb 2024 05:50:23 -0500
X-MC-Unique: RZEwg6vNN6-fsHw4b6u2OQ-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso5743296276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031023; x=1709635823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN5XW9CUdGcYyNlH2Pi+8rFm+PkW6zNYvr9vLY8Pc/4=;
        b=B45pWJZTb8q/kl8mWmVCZ95ZkbNTkBz274OREUo2u7fgaOgMJcXG/Wa+JjeyG0tI1o
         uWysXLZ89OKLzmAu1XwgYfQ9SqlzSfCFXh5IFtZRcFWTXL1baiHZiwDhG71HF6Mm12nE
         dJQye1r0susnEtgXHtpab/6Dg7hj2fSDA6ciLQlaNfLsZthUDSrY947wrHOXwPrwFEci
         Rk0DJOlaI98Ox/Sd5Xlov2jOCa+L9QiUxC45TBmloDGLf+ApSY5foOZrSIM9jrhsTU0v
         oOUKCbXy6tH5V3rpiK5EaXLcZZ9YRIKI0wyRojYQzquP55/OtxXtv6wt4F2dKLpJ60/a
         76Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWvr+9neZf/B0e//V/GoeHWoF6D0pnEA/4V8MhvSwLKU3o3fzK0DL65rEoLfe40gp1SZ8pBd8fQSWZfOZQ5yAmAuyzTO342xttD4sZl
X-Gm-Message-State: AOJu0YyteuFi7rb2AzLPVwTL7+FCwgWxi4ZSEInbxxS6LuWd9lcTYo00
	6fC4HOQnPx/QcjPLU+eEovywIWuRFfpd1cHpMIhyTw+MO48+f/eDG49qIfo14CGMWFHO0LYy7G9
	dQm0L/eYHTKD57exXZbkRKbBNVX7HKby7pfNs5cF/c9cseWsimIbkPafrJRR8qYy71Rwzp3cDRb
	c0sHG1a4z/srxwsIdLmJDSJwGNs0+hgOiddoKo
X-Received: by 2002:a25:b226:0:b0:dcc:1449:71ea with SMTP id i38-20020a25b226000000b00dcc144971eamr1605453ybj.50.1709031022974;
        Tue, 27 Feb 2024 02:50:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOzuO5/7OdS8Y9+YIReLWHG1+QhlUYSZo85aLKKuXBLbo/FYogFv1f2uZ0/lkEtHpKlKfTB6cGLuQsoZn0ph4=
X-Received: by 2002:a25:b226:0:b0:dcc:1449:71ea with SMTP id
 i38-20020a25b226000000b00dcc144971eamr1605440ybj.50.1709031022659; Tue, 27
 Feb 2024 02:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216142502.78095-1-jonah.palmer@oracle.com> <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
In-Reply-To: <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 27 Feb 2024 11:49:46 +0100
Message-ID: <CAJaqyWe4V23-Koadp3dQhmfmZyDP9dhS56s1ObwJgb+Veb+Twg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Allow CVQ size changes
To: Lei Yang <leiyang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, si-wei.liu@oracle.com, 
	virtualization@lists.linux-foundation.org, dtatulea@nvidia.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:09=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> QE tested this patch's V2, qemu no longer print error messages
> "qemu-system-x86_64: Insufficient written data (0)" after
> enable/disable multi queues multi times inside guest. Both "x-svq=3Don
> '' and without it are all test pass.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
>
> On Fri, Feb 16, 2024 at 10:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >
> > The MLX driver was not updating its control virtqueue size at set_vq_nu=
m
> > and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> > setup_cvq_vring.
> >
> > Qemu would try to set the size to 64 by default, however, because the
> > CVQ size always was initialized to 16, an error would be thrown when
> > sending >16 control messages (as used-ring entry 17 is initialized to 0=
).
> > For example, starting a guest with x-svq=3Don and then executing the
> > following command would produce the error below:
> >
> >  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
> >
> >  qemu-system-x86_64: Insufficient written data (0)
> >  [  435.331223] virtio_net virtio0: Failed to set mac address by vq com=
mand.
> >  SIOCSIFHWADDR: Invalid argument
> >

Also,

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting=
")

> > Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 778821bab7d9..ecfc16151d61 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -151,8 +151,6 @@ static void teardown_driver(struct mlx5_vdpa_net *n=
dev);
> >
> >  static bool mlx5_vdpa_debug;
> >
> > -#define MLX5_CVQ_MAX_ENT 16
> > -
> >  #define MLX5_LOG_VIO_FLAG(_feature)                                   =
                             \
> >         do {                                                           =
                            \
> >                 if (features & BIT_ULL(_feature))                      =
                            \
> > @@ -2276,9 +2274,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_dev=
ice *vdev, u16 idx, u32 num)
> >         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >         struct mlx5_vdpa_virtqueue *mvq;
> >
> > -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> > +       if (!is_index_valid(mvdev, idx))
> >                 return;
> >
> > +        if (is_ctrl_vq_idx(mvdev, idx)) {
> > +                struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> > +
> > +                cvq->vring.vring.num =3D num;
> > +                return;
> > +        }
> > +
> >         mvq =3D &ndev->vqs[idx];
> >         mvq->num_ent =3D num;
> >  }
> > @@ -2963,7 +2968,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
> >                 u16 idx =3D cvq->vring.last_avail_idx;
> >
> >                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_fe=
atures,
> > -                                       MLX5_CVQ_MAX_ENT, false,
> > +                                       cvq->vring.vring.num, false,
> >                                         (struct vring_desc *)(uintptr_t=
)cvq->desc_addr,
> >                                         (struct vring_avail *)(uintptr_=
t)cvq->driver_addr,
> >                                         (struct vring_used *)(uintptr_t=
)cvq->device_addr);
> > --
> > 2.39.3
> >
>

There is another related issue in both mlx and vdpa_sim, although I
think it does not cause any direct bug. They both return a hardcoded
256 in .get_vq_num_max, although they both accept bigger sizes with
set_vq_num.

QEMU just never calls .get_vq_num_max, so it does not forward this
maximum to the guest.

To be aligned with the VirtIO standard it should return the actual
maximum, which I think is only bounded by the uint16_t maximum in the
packed case and the half in the case of split, due to the requisite of
being a power of 2. This is a very big value however, so I think the
right solution is to allow to specify this maximum on vdpa command
line tool.

Moreover, the virtio standard allows the device to set different max Q
size values per virtqueue, something that the vdpa ops does not allow
as it cannot tell between queues, is a per device vdpa_op.

Having said that, maybe it is not worth all the trouble, as it has not
been reported to cause any issue?

Thanks!


