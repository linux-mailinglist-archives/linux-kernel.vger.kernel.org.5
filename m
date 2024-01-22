Return-Path: <linux-kernel+bounces-32783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992BA836008
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B328A4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47783A1DB;
	Mon, 22 Jan 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlnEHFP5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB021362
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920485; cv=none; b=m5jOptErBo/KDyZVxReeDnS/MnwqOhEOYxft/lTrNiKrHK81uePj0kzBcM3MQwQlH63s1rrtV3Ew/H69kNeEzIXHxPihdnvPXIUo2DyAV3hY0e5koD0LzYZTV366OTQpVjo1UVhd04+bMvICAcbFmSRdjzDyT80o0BFIy6jDEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920485; c=relaxed/simple;
	bh=UMEPrzsFfMwcLb6gpEQxDtl8Y3dVJdxWPuxxS76bS/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/+FAgqPb/NfOo+wLh4ibOfhZ5tKmKAcIbxphpahMRQw5nEIYR05GSX/3F/Bk+3xAgideJn27Ex2evOCUPnQON0evzKHMt3crvJ10EAHT0x43yJQqZI49jeXF/2WzyaXeFh2lkN/CNwD9tpXr3Kk0aHie0Ji5EKCqSs2KhFzSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlnEHFP5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705920482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAQacrX86fqUD9K4Yvf7W+7v6QcN6oGZap2bo4/kXUo=;
	b=IlnEHFP5obKsWJLjfj6TjV1OmZg5Dq4lx8slAphgF8HPCWMR98o3glL5hZdNEuM/K7SlDB
	LLEFA95XYkpeB2JDvlDAxwV7VYttDDVwxJtWp1YtU4IdH+CsTE9v2B4u4JDHX4SPFt1Ohe
	AP9RhuwOcn0Gc6ZQlaMMDeI42r6N8QE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Rtdmxc_aPIiYyu3HbYW08g-1; Mon, 22 Jan 2024 05:47:59 -0500
X-MC-Unique: Rtdmxc_aPIiYyu3HbYW08g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5ffc7ce3343so15606737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920479; x=1706525279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAQacrX86fqUD9K4Yvf7W+7v6QcN6oGZap2bo4/kXUo=;
        b=p6a/UsFny0u4zowilHMt/o+HueI2wSdM/F1r+GZhkMwsX9QGbmAaYOuI+A2yTCxwSN
         ghcNpqjA31Qmn736gT+rGxsPNiDPzSriCr0JMs+gA21iTC02AE7phYYFobrHJeENdxPL
         uPC+oebLmeqJ7C30Q0G/Kjw7JWjaBaTpe4BBoq+tLfsKSWuc1zlowZKVODVrk5QiivSH
         M3j7JGUko5lViWCpx3YV9tOk64JkSaYns9vqqMkEzmpqi1SlFXqTdDPXzNoqEEQ/BYq/
         7IBEnqLinhUPYOWdUEqdY8pR4iIK6F/1noF+imOyMLHzjJkp09ZRFOEIt++JfkhNdYcq
         2xFQ==
X-Gm-Message-State: AOJu0YzIaqp/9FZCqIW90yEFodSgT/SlTlv3gxEl72RJ+iRiFCaeJk0W
	OfouCDZqQjohmeh657HQI1aJqCUvvRwFimA6fgbraDXYJVlX0ucPAVjuywoH/wWI5VYpu5Ar+he
	R30heca8oFBfVMSivh4A1SVlSsFjJ3tnkf2ofLU4jK7/fuKMhMvF7712zL27o8BH77uIm7lGDsw
	3exovNQQx0PZBH6jdMKsu29OY8xh9lQRt6P4SI
X-Received: by 2002:a0d:dbd5:0:b0:5ff:956d:8b7f with SMTP id d204-20020a0ddbd5000000b005ff956d8b7fmr3052786ywe.10.1705920479006;
        Mon, 22 Jan 2024 02:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL9kWBkFrWysbj41gcH1s65ao+SK2QQzY/6YTjr57S5jDjOuIcHyA9BD2Aa+0IG0Ml8khImO/AtDyOFc4vg/0=
X-Received: by 2002:a0d:dbd5:0:b0:5ff:956d:8b7f with SMTP id
 d204-20020a0ddbd5000000b005ff956d8b7fmr3052778ywe.10.1705920478772; Mon, 22
 Jan 2024 02:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com> <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
In-Reply-To: <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Jan 2024 11:47:22 +0100
Message-ID: <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:22=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
> >vdpasim_do_reset sets running to true, which is wrong, as it allows
> >vdpasim_kick_vq to post work requests before the device has been
> >configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_O=
K
> >is set.
> >
> >Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
> >Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vd=
pa_sim.c
> >index be2925d0d283..6304cb0b4770 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim=
, u32 flags)
> >               }
> >       }
> >
> >-      vdpasim->running =3D true;
> >+      vdpasim->running =3D false;
> >       spin_unlock(&vdpasim->iommu_lock);
> >
> >       vdpasim->features =3D 0;
> >@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *v=
dpa, u8 status)
> >
> >       mutex_lock(&vdpasim->mutex);
> >       vdpasim->status =3D status;
> >+      vdpasim->running =3D (status & VIRTIO_CONFIG_S_FEATURES_OK) !=3D =
0;
> >       mutex_unlock(&vdpasim->mutex);
>
> Should we do something similar also in vdpasim_resume() ?
>
> I mean something like this:
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..55e4633d5442 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>          int i;
>
>          mutex_lock(&vdpasim->mutex);
> -       vdpasim->running =3D true;
> +       vdpasim->running =3D (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_=
OK) !=3D 0;
>
>          if (vdpasim->pending_kick) {
>                  /* Process pending descriptors */
>
> Thanks,
> Stefano
>

The suspend and resume operation should not be called before
DRIVER_OK, so maybe we should add that protection at
drivers/vhost/vdpa.c actually?

Thanks!


