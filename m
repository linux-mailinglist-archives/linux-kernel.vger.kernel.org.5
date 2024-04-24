Return-Path: <linux-kernel+bounces-156202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F88AFF52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4951A281E05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6613340B;
	Wed, 24 Apr 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a86s0p4J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487329429
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928544; cv=none; b=a64e6w8T2QHCD7blPkCVtQNc1OhYFpFYsSrz7gjlV3yg7+KHe8G3WvAkKryw7EtDOwJ4qZ53x2sTJwCL3Md4NP4pCQ2tRd4yHJr3qOh5aITL74ybyJ9lT/ox1fYoae1gXbaZyqiyQ1OZMkkrLbpciMhddF9A/ViCMksbXLNmhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928544; c=relaxed/simple;
	bh=NGmbSMkF+xL8LH8gNNiByBDOn1Ho7TAhVQP5ngZJ200=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td9UERZQ0MHs632yR32ULWXKimjC3N5VV+KlGAN393PPtmle5KOe7TPFW795n4zkDAJuwAnBpoJ+6LZeQsO4aC3MkO9x0H27iXTEM83iEJwApq+OfqnJtDXXa3Yz5RsVvm0Fudo/ysQv2M2NL28yox26ULJLtrMBYndOKsl608M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a86s0p4J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713928541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJEFMAfNT/VB4mDk82qfL5Q4Ip01msm7cEvY6vFaAL0=;
	b=a86s0p4JGexXbdUnXpjc4JHKBhq0BVIVRc8AO60VhU1RjHdTMOXkrLe10F+nMBvsyWRWOk
	A5ygN2jHcyLLujFDL3nUHioT7akTUG7SPyuVELSHLhnPuhck6ZqgAd9z79Zhre0ggTCxLq
	pZvA7HVdIhSpuM9xp/qX3HLsuiH+/8A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ULmHo1WaPX-NGlTuXRLnUQ-1; Tue, 23 Apr 2024 23:15:38 -0400
X-MC-Unique: ULmHo1WaPX-NGlTuXRLnUQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a46852c2239so419584566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713928537; x=1714533337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJEFMAfNT/VB4mDk82qfL5Q4Ip01msm7cEvY6vFaAL0=;
        b=wVOtZYjv0H5HnyMo/J90+6/gXkSgE0nMWt6Fw8BR+ZJ5rDSXWUJlUSc+0pM/kEuOYs
         lkrNZpyxSPF1jTerN3/EywG7E6TuRvQYP+aj/0OD3i4qC+gfRayOUe3561KoSVuwaCR0
         /2b9C+v4l2SAZb5ruFh7MXiyMzru1rQkXxohUMHbtLiL0tjpZqHAvqpcUjrMZba9i3Zv
         WMP5A0/Ef1oKOHRXunofIut3vtrtDMoyumKrIew+L26JiDQtm+k6mExWWDw6/8UkjbJ/
         5qQTlZeLjvyHviZjhzWLmYrmYVwwDFN+Msjn22epQoMrAYdXK083TUUNFaWw4lin/QZN
         KmWA==
X-Forwarded-Encrypted: i=1; AJvYcCVuW2U885y/5yNMz7THuEoLqOpfn3l+mnnUGRCUg0imzbLA2xYPHqzA6sAGm3jK6wl+WXWOEPaGydqUGqRjK5lFSqXYz4kRrPcrOLEE
X-Gm-Message-State: AOJu0YwdTXUJOBJ85yj1GO7LV2Oqo0SyZp7NvmdjlZh5znFpY0fN+hNJ
	z46PLFr8o3Ew4bnIKb7lOAVvjUvf71bjUQrZsLZ+99sg6YsYk9hrUPZI0f7ONuzg31Ugywtafzx
	yKF4Z+klvRdnNWVWnH5cMk8edIiv9t5L1f6Op8v9lphlhpLYqdU/voknN+pwyDefrAFGPdANbgy
	C8ynNuoAooVxcpncgQR2uwQsoFqN9TznbbuMAk
X-Received: by 2002:a17:906:7742:b0:a55:be6d:b9f8 with SMTP id o2-20020a170906774200b00a55be6db9f8mr679668ejn.10.1713928536834;
        Tue, 23 Apr 2024 20:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCWGb5O13pyxly439eZL1uccGa42ATOngPW0NRGAwmb9r4pF1qLk8akyMToctAr5gVztjZPrVAmm9SvVGPQaU=
X-Received: by 2002:a17:906:7742:b0:a55:be6d:b9f8 with SMTP id
 o2-20020a170906774200b00a55be6db9f8mr679665ejn.10.1713928536512; Tue, 23 Apr
 2024 20:15:36 -0700 (PDT)
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
In-Reply-To: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Apr 2024 11:14:59 +0800
Message-ID: <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > These functions allow vduse to allocate and free memory for r=
econnection
> > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > Each VQS will map its own page where the reconnection informa=
tion will be saved
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 40 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > >       int irq_effective_cpu;
> > > > > > >       struct cpumask irq_affinity;
> > > > > > >       struct kobject kobj;
> > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct vduse_dev;
> > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_=
cpu(struct vduse_virtqueue *vq)
> > > > > > >
> > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > >  }
> > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev =
*dev)
> > > > > > > +{
> > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > +             /*page 0~ vq_num save the reconnect info for vq=
*/
> > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > >
> > > > > >
> > > > > > I don't get why you insist on stealing kernel memory for someth=
ing
> > > > > > that is just used by userspace to store data for its own use.
> > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > create a regular file anywhere in the filesystem.
> > > > >
> > > > > Good point. So the motivation here is to:
> > > > >
> > > > > 1) be self contained, no dependency for high speed persist data
> > > > > storage like tmpfs
> > > >
> > > > No idea what this means.
> > >
> > > I mean a regular file may slow down the datapath performance, so
> > > usually the application will try to use tmpfs and other which is a
> > > dependency for implementing the reconnection.
> >
> > Are we worried about systems without tmpfs now?
>
> Yes.
>
> >
> >
> > > >
> > > > > 2) standardize the format in uAPI which allows reconnection from
> > > > > arbitrary userspace, unfortunately, such effort was removed in ne=
w
> > > > > versions
> > > >
> > > > And I don't see why that has to live in the kernel tree either.
> > >
> > > I can't find a better place, any idea?
> > >
> > > Thanks
> >
> >
> > Well anywhere on github really. with libvhost-user maybe?
> > It's harmless enough in Documentation
> > if you like but ties you to the kernel release cycle in a way that
> > is completely unnecessary.
>
> Ok.
>
> Thanks
>
Sure, got it. Do we need to withdraw all the series? maybe we can keep
the patch for support ioctl to get status and configure?

thanks
cindy

> >
> > > >
> > > > > If the above doesn't make sense, we don't need to offer those pag=
es by VDUSE.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > +             if (vaddr =3D=3D 0)
> > > > > > > +                     return -ENOMEM;
> > > > > > > +
> > > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *=
dev)
> > > > > > > +{
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > +
> > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > >
> > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int =
cmd,
> > > > > > >                           unsigned long arg)
> > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name=
)
> > > > > > >               mutex_unlock(&dev->lock);
> > > > > > >               return -EBUSY;
> > > > > > >       }
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > +
> > > > > > >       dev->connected =3D true;
> > > > > > >       mutex_unlock(&dev->lock);
> > > > > > >
> > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vd=
use_dev_config *config,
> > > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, confi=
g->vq_num);
> > > > > > >       if (ret)
> > > > > > >               goto err_vqs;
> > > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > +     if (ret < 0)
> > > > > > > +             goto err_mem;
> > > > > > >
> > > > > > >       __module_get(THIS_MODULE);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  err_vqs:
> > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), =
dev->minor));
> > > > > > > +err_mem:
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > >  err_dev:
> > > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > > >  err_idr:
> > > > > > > --
> > > > > > > 2.43.0
> > > > > >
> > > >
> >
>


