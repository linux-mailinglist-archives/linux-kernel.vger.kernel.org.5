Return-Path: <linux-kernel+bounces-156251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D58B0036
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BCB1F2154D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167E139CEB;
	Wed, 24 Apr 2024 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaSGFPhM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0785C59
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930718; cv=none; b=BpnuuebTuxFaBPztb/SlXuvfTeVy9MQHMT3KuLj6+scoMn/rXErhXZZVT4zhoW5b5e4dv+QJxEmPOL9VFVa9qKxWHRzreBJASxQMgVlFyHdkmjPRQuydB5LWBiALM4o2NhrH0l3hq7FnnlDsoD/dlvna8i19ai2bnsGT/xOPvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930718; c=relaxed/simple;
	bh=zmPXM0Dhe+4wAw7Mwb5P63k5qIFw0RYGHiHjcYr2Fj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkSM5J/ataA4gu5d99w+v7FEj9NKsg78u2QCu+2tefCEyYmGpu/+Dcsnam0DBU9AFdqksQ/bddcnkb6I6Bciqy+WwMwKXUntq7kmeefk8YVrxeOOPwZafhMKlmYjNL7JaYoTpVSaxNZ/1cYu+soMk9P1ehSEaqzBcmW6DLuUEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaSGFPhM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K18eP4qkjIilGjFsvIGytTcX6bpQkpwDgR45u8Gpsbs=;
	b=CaSGFPhMHFyKFNWsiyL2s7j74gIgKNinQQ51EmyCy4pn9wIO+DoOMtW/LtWXv1nZGgor0+
	w/wb7SGYT601NTiPKKE43t+NgagGZ0kMCnV+lcrLq6v1qeEC6BQ+eAm4EsOonfTGpBFUEb
	dQI84bM2Pkx2vNW3u5+aBlpamVntFPs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mP6ByzETM7ScRNYc60egWw-1; Tue, 23 Apr 2024 23:51:52 -0400
X-MC-Unique: mP6ByzETM7ScRNYc60egWw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso8122948a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930711; x=1714535511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K18eP4qkjIilGjFsvIGytTcX6bpQkpwDgR45u8Gpsbs=;
        b=Fpmt70Ql09B1RfIvpIp59JdqnRZrxJifg89N8kyZR6NCm8xfyUNboT4sBiYF6K89Y4
         3sMpuXalUCTpcXInmPBgtIUXW238heu66mGDd8eZVD040qcGj8t9jS6Ii1xlgfEmHmTl
         VjyQqukBBnPb3XuDPYs+yPKQn66vi5137H+Dudk/G46s52QHAwtVkeTnKVBHdev5N5Sw
         hD7DZ8tQvcy19s6pQP4JE42J9qTJCnrEo5ch7Wsel2HEKQs5VJMrbQgE6x4Tyn9SfiOs
         49j7BalTtGyxK04QdX8OisANQj7jVPGdzRSUPNiXeCFAkuNeOQ2gP9hsyfsHlRaba5en
         aV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWomv17wLLo+raeMn6t9l1acezaTtJbDvnrpq1GG+1mWWmsfDQD2DdOxplEBwUtgQahWQF/tdUTZw/yFFcwQfi2Rou0nK/7p9SMQBmk
X-Gm-Message-State: AOJu0YyW8YReRi2hgfBGSpYlj7GQH51bVxYXiTUWp23S+RvE6E95hRWY
	Vbw5hs22dMxVT9ghzHHIlTLYbP1RktBBt+39tFpj9rfegTE7MAXDYEuFWeJJkixhWNAF81GFy6b
	RAjgvgwgiD49tBSMrOo10+sNDkItduLo0utXKIwvP0ZTkO643fKtb4zlUklh8hf44GNuF2qz7LY
	v4Mr41zIkSeeF5pa0C/PFNgUQ2O6OngRepIDgwHpBoeLAT
X-Received: by 2002:a17:90a:e7c3:b0:2af:3bce:6e4c with SMTP id kb3-20020a17090ae7c300b002af3bce6e4cmr562459pjb.16.1713930711546;
        Tue, 23 Apr 2024 20:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG73KOoT1LBuVxyOPo7Rg5CbwjbEBomK/zP99mw2XwaHzrikEAJp80JbdakKr2x8fDAjRlTz9pqibGjVkpov5c=
X-Received: by 2002:a17:90a:e7c3:b0:2af:3bce:6e4c with SMTP id
 kb3-20020a17090ae7c300b002af3bce6e4cmr562449pjb.16.1713930711187; Tue, 23 Apr
 2024 20:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org> <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
In-Reply-To: <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:51:39 +0800
Message-ID: <CACGkMEsfCa=awV6WebT_jm1ng4uY4afj4KLML4bHdi5=iakZYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:15=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Apr 24, 2024 at 8:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > These functions allow vduse to allocate and free memory for=
 reconnection
> > > > > > > > information. The amount of memory allocated is vq_num pages=
.
> > > > > > > > Each VQS will map its own page where the reconnection infor=
mation will be saved
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > >       int irq_effective_cpu;
> > > > > > > >       struct cpumask irq_affinity;
> > > > > > > >       struct kobject kobj;
> > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct vduse_dev;
> > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effectiv=
e_cpu(struct vduse_virtqueue *vq)
> > > > > > > >
> > > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > > >  }
> > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_de=
v *dev)
> > > > > > > > +{
> > > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             /*page 0~ vq_num save the reconnect info for =
vq*/
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > > >
> > > > > > >
> > > > > > > I don't get why you insist on stealing kernel memory for some=
thing
> > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > create a regular file anywhere in the filesystem.
> > > > > >
> > > > > > Good point. So the motivation here is to:
> > > > > >
> > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > storage like tmpfs
> > > > >
> > > > > No idea what this means.
> > > >
> > > > I mean a regular file may slow down the datapath performance, so
> > > > usually the application will try to use tmpfs and other which is a
> > > > dependency for implementing the reconnection.
> > >
> > > Are we worried about systems without tmpfs now?
> >
> > Yes.
> >
> > >
> > >
> > > > >
> > > > > > 2) standardize the format in uAPI which allows reconnection fro=
m
> > > > > > arbitrary userspace, unfortunately, such effort was removed in =
new
> > > > > > versions
> > > > >
> > > > > And I don't see why that has to live in the kernel tree either.
> > > >
> > > > I can't find a better place, any idea?
> > > >
> > > > Thanks
> > >
> > >
> > > Well anywhere on github really. with libvhost-user maybe?
> > > It's harmless enough in Documentation
> > > if you like but ties you to the kernel release cycle in a way that
> > > is completely unnecessary.
> >
> > Ok.
> >
> > Thanks
> >
> Sure, got it. Do we need to withdraw all the series? maybe we can keep
> the patch for support ioctl to get status and configure?

We can leave the mmap part for future, the rest is still useful unless
I miss anything.

Thanks

>
> thanks
> cindy
>
> > >
> > > > >
> > > > > > If the above doesn't make sense, we don't need to offer those p=
ages by VDUSE.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +             if (vaddr =3D=3D 0)
> > > > > > > > +                     return -ENOMEM;
> > > > > > > > +
> > > > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev=
 *dev)
> > > > > > > > +{
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +
> > > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > >
> > > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned in=
t cmd,
> > > > > > > >                           unsigned long arg)
> > > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *na=
me)
> > > > > > > >               mutex_unlock(&dev->lock);
> > > > > > > >               return -EBUSY;
> > > > > > > >       }
> > > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > > +
> > > > > > > >       dev->connected =3D true;
> > > > > > > >       mutex_unlock(&dev->lock);
> > > > > > > >
> > > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct =
vduse_dev_config *config,
> > > > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, con=
fig->vq_num);
> > > > > > > >       if (ret)
> > > > > > > >               goto err_vqs;
> > > > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > > +     if (ret < 0)
> > > > > > > > +             goto err_mem;
> > > > > > > >
> > > > > > > >       __module_get(THIS_MODULE);
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > >  err_vqs:
> > > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major)=
, dev->minor));
> > > > > > > > +err_mem:
> > > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > >  err_dev:
> > > > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > > > >  err_idr:
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > >
> > > > >
> > >
> >
>


