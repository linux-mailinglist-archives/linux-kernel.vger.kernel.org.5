Return-Path: <linux-kernel+bounces-156062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9468AFD69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AAC284119
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE214A23;
	Wed, 24 Apr 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUD0FRpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157844A32
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919466; cv=none; b=Yh47dc+ooKT99OeFEmlv4N4SfsNnkDEmUTM+e67b0sqEI+gZXJb8TdwjPvV1ZU9ap/Z2KBn7ucaVZC23Wq2HpHUHvDHf8BAYrkO9KIG9lf8hgI7Qt2RfLz8NRrp/lVM/kVw74yDS9QUeodliT/c/6aR9NmKE9paYbDhuBQ3j1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919466; c=relaxed/simple;
	bh=Vec3AELdicTqN0afSgEb3GoinhUyJSmXLRWU37K2U8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0GD+3pOQN6QjF8+OJ+DJcKnngHHYf1OVXXfRiYNaV7Q3Udayt4AkEe1OSBkxzQDIHrNuG7mO7cnwmJzUxo1HKur2VTGJ2kvkdNdb1sDT9auohiD9XoiD6KQw61jjYWSjFAPA6kKhCNyV2n+/OG02FP6PCQLb9JN2sDixyel3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUD0FRpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713919464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sqcm0DKufT9EZxiM+0OzeY88Sk4DHeOhk+mWIf/p4wo=;
	b=CUD0FRpOBREHVvKTziLOVF0fwiZLSGMs2gG/8/+vxPUSda6frTNjaBGyp9Qmx2EjRYHCCN
	l5n1/zhp1pYIOoUG7MOldhfv/NF5dwjq3HKT3/A3zqLprOizHC1NWFWvmflnC9B0e3U6Ez
	ZesGc6ELp/cLhZ/B5MdaQUN0ivbV/ig=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-yaYLQIXhNlG86H2NRqmhDw-1; Tue, 23 Apr 2024 20:44:22 -0400
X-MC-Unique: yaYLQIXhNlG86H2NRqmhDw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2c2b0d82aso7091884a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713919461; x=1714524261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqcm0DKufT9EZxiM+0OzeY88Sk4DHeOhk+mWIf/p4wo=;
        b=HiQ11rTvjtY4ayUhjZYadmkyWW4XRrZnuQ89fzFXOlw9xx4OTgryhdtd4uJjEcyimG
         aIe2kMG8Yd2vOW+4PYhZB3keJb31vXb2hcn0aEYWRwM4E6qvLr6o5Q8UK9yM7BPVyzDz
         0M+TZqbLS4rtsxMpSZG6d/dsTsjJPHzSX+q+KSqQXkY1ETCBm0RrY3ACoqHAlO6TX92l
         lmq6vM18XZgidQaz0WDCQidQrGrd7oPUOoE7nsptn8r9mWM2M+uN84Jgcr4ynZyK/+2I
         zu1rwk4g4fWDU4SYwpvmKujRZlH+LYTNLEv/4V0cckBPHMmyDhqPNeGF8KtR9mlD4gNF
         ujag==
X-Forwarded-Encrypted: i=1; AJvYcCXZtnEyNNm1sGI0KnLGleoZejHDNQZoJ6LB/n95vJx4LcCV1sCqbuUVqRaV1FtmxnJ1FU2BUPI8XKutt6vFHJa8T9Ki3diRXJ6Kmwps
X-Gm-Message-State: AOJu0Yz9X2wtWaKOtJWcGc2+aDIZARBx4KpaHU/VyzZqtVdIV0yoklxl
	P+xPGpMzQwdwLeV1s1WHk8zdkskIDk2eHKokAzDSL06Wx7WLA/EMLMO0XK8oYnr6/DGpIApyeB5
	abBtg9EhKyvq47RRWodRfQdTboY/BDVksxei61VMlXZAPvCmKsjwqYSwq47DUZnqIOS2ZjVarlg
	5BzUTMBVtfZxWK3n5wZ6y5R6QVd+ISKE6U2ZwE
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id gi3-20020a17090b110300b002a3be59e969mr862693pjb.47.1713919461460;
        Tue, 23 Apr 2024 17:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Gh2nYGbLqjL1EPBd4oIGhOxCQSJxaQwomV1RaYRhZ6h2DmJHdl+zUN+m5ZFLbiPKeZu77uBcGISXFd7KILg=
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id
 gi3-20020a17090b110300b002a3be59e969mr862684pjb.47.1713919461083; Tue, 23 Apr
 2024 17:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240423043538-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 08:44:10 +0800
Message-ID: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > These functions allow vduse to allocate and free memory for rec=
onnection
> > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > Each VQS will map its own page where the reconnection informati=
on will be saved
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 40 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > >       int irq_effective_cpu;
> > > > > >       struct cpumask irq_affinity;
> > > > > >       struct kobject kobj;
> > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > >  };
> > > > > >
> > > > > >  struct vduse_dev;
> > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cp=
u(struct vduse_virtqueue *vq)
> > > > > >
> > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > >  }
> > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *d=
ev)
> > > > > > +{
> > > > > > +     unsigned long vaddr =3D 0;
> > > > > > +     struct vduse_virtqueue *vq;
> > > > > > +
> > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > +             vq =3D dev->vqs[i];
> > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > >
> > > > >
> > > > > I don't get why you insist on stealing kernel memory for somethin=
g
> > > > > that is just used by userspace to store data for its own use.
> > > > > Userspace does not lack ways to persist data, for example,
> > > > > create a regular file anywhere in the filesystem.
> > > >
> > > > Good point. So the motivation here is to:
> > > >
> > > > 1) be self contained, no dependency for high speed persist data
> > > > storage like tmpfs
> > >
> > > No idea what this means.
> >
> > I mean a regular file may slow down the datapath performance, so
> > usually the application will try to use tmpfs and other which is a
> > dependency for implementing the reconnection.
>
> Are we worried about systems without tmpfs now?

Yes.

>
>
> > >
> > > > 2) standardize the format in uAPI which allows reconnection from
> > > > arbitrary userspace, unfortunately, such effort was removed in new
> > > > versions
> > >
> > > And I don't see why that has to live in the kernel tree either.
> >
> > I can't find a better place, any idea?
> >
> > Thanks
>
>
> Well anywhere on github really. with libvhost-user maybe?
> It's harmless enough in Documentation
> if you like but ties you to the kernel release cycle in a way that
> is completely unnecessary.

Ok.

Thanks

>
> > >
> > > > If the above doesn't make sense, we don't need to offer those pages=
 by VDUSE.
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > +             if (vaddr =3D=3D 0)
> > > > > > +                     return -ENOMEM;
> > > > > > +
> > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *de=
v)
> > > > > > +{
> > > > > > +     struct vduse_virtqueue *vq;
> > > > > > +
> > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > +             vq =3D dev->vqs[i];
> > > > > > +
> > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > >
> > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cm=
d,
> > > > > >                           unsigned long arg)
> > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > > >               mutex_unlock(&dev->lock);
> > > > > >               return -EBUSY;
> > > > > >       }
> > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > +
> > > > > >       dev->connected =3D true;
> > > > > >       mutex_unlock(&dev->lock);
> > > > > >
> > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vdus=
e_dev_config *config,
> > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config-=
>vq_num);
> > > > > >       if (ret)
> > > > > >               goto err_vqs;
> > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > +     if (ret < 0)
> > > > > > +             goto err_mem;
> > > > > >
> > > > > >       __module_get(THIS_MODULE);
> > > > > >
> > > > > >       return 0;
> > > > > >  err_vqs:
> > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), de=
v->minor));
> > > > > > +err_mem:
> > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > >  err_dev:
> > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > >  err_idr:
> > > > > > --
> > > > > > 2.43.0
> > > > >
> > >
>


