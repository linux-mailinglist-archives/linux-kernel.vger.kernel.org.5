Return-Path: <linux-kernel+bounces-149373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAFD8A9038
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB6B1F21C37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D77611B;
	Thu, 18 Apr 2024 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHgcpHSF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DC4A3C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401889; cv=none; b=Cr5Nq3w5ReR1y8iTO5ZEDxYu5ozKuph629JqCzHqJ4Qm0r7Xnbyj7++5VUzAR+dlEcVZHp8qrAecdrp8dLhsCutKwzasfNKHiECSddcrnh+OdO+xp9DLPCZgkwMZeB4JGFE6Ckgons+R57saqeHGmngI7pCi/Zr77RVa0Tmb1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401889; c=relaxed/simple;
	bh=i7orZlqUt3DNSMN5clgSBt2A1xUqK233W6Rhf+3quPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzf6bq9cLTbZukVBalfgO54fNgxmwiNmRUFEG0Ln3cneSwc63AC7jyOirywMZ7Yty27XOqj7W05/0uuThDaZkhNvkQUmXSbFv/H4/p7o+16tWhbGa04vmROUzkol2lX0roS6k+TFhIJLlNOHVA7BtsIEKCXPvVsNuz8SUeWyliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHgcpHSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713401886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEz8Ba2N42uxVER1hKipg4PtiWGzIt9uN4hOueYNQ8I=;
	b=eHgcpHSFtM8GTHpdzylX7kZXzZ6aor3aOcCSr/e74S4Gr8gUa1b3V0dMqSNkw2mL6IBgmw
	TeCArgR0xJZNl5XZCVFRqytXW0HcR+/EMQ2BC1f+9Q2+4W50py10cpz7kRdiVbdmx0c8CM
	SK4olIWCQV4wjyvjdRJK/sm6K7GIRYs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-5ti5inVZMhqVnLIyPJDkEw-1; Wed, 17 Apr 2024 20:58:04 -0400
X-MC-Unique: 5ti5inVZMhqVnLIyPJDkEw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6efef492e79so580619b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713401883; x=1714006683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEz8Ba2N42uxVER1hKipg4PtiWGzIt9uN4hOueYNQ8I=;
        b=EpbWMv542JVaklhKS5U/9mfwxAxXxwzgiyWtYHmkBkTomfIis76cCQfjznStnAB3ba
         grtJiSIHdtTLGvZtO9y6zzBfcVx6TdVGJL5h0JQrVK1oWvM7gINPax78rdSGx0G9qsyy
         FcHuhHlijwFKBMtowsYzqwbHLvxY6qXI044w33iNETnEpj5Ki+nDx/oCQ1auwFIzSdKF
         qT8+1lO5B32FskR0USg4lGgjitunOsbEDD1jJvZWPZ2N5Am3GgbVDykBwJ60kE2R+w95
         RasVwjMF7TWhIemypnPntHixPDXAI+83yU8D4gsiBP5qnzdDEGbxCMQNr/p6ef8WmX3Y
         ek0g==
X-Forwarded-Encrypted: i=1; AJvYcCWazydm3kc+idE5rPYg2v4kbJpE4immvBAAOcpQx8uNmULjmAej9JJ+a/tHyL/3ss5YtZIiQjSOo+xpZFVWXCUpKW61bYIZChvXWQ9S
X-Gm-Message-State: AOJu0YyKEqjRN5P43BDs+ytjO14ajAXMfRjrYxcckR4TmF88M8WHSZv1
	WVarcPZAgoZg3YjygDaAqQXL8+xpVFUhkTOLIRGX3efdkb3cEnBUQatwuVdY+FPGCdf+48TCkLQ
	OebBCjqBOKMZidpkpD2IGjjyTWwu9qNvklmTICRUhCqxB6HgOnbMLXzhVE5+1WvSzer8ySl6rvq
	h6OjmkRk5ZkaV27u71nOGXnm07DAVXus4xRAcr
X-Received: by 2002:a05:6a20:3cab:b0:1a9:9c20:6ca with SMTP id b43-20020a056a203cab00b001a99c2006camr1823513pzj.23.1713401883405;
        Wed, 17 Apr 2024 17:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgl758j2Btq3Dlb+sVtrCdaXysTD7w9b6JpUV2zn8FSoCMJ7LB4NF/74mUQsuz8dZ9ERKdhaDsbJaNLzhs5RU=
X-Received: by 2002:a05:6a20:3cab:b0:1a9:9c20:6ca with SMTP id
 b43-20020a056a203cab00b001a99c2006camr1823500pzj.23.1713401883114; Wed, 17
 Apr 2024 17:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240417052723-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:57:51 +0800
Message-ID: <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > These functions allow vduse to allocate and free memory for reconnectio=
n
> > information. The amount of memory allocated is vq_num pages.
> > Each VQS will map its own page where the reconnection information will =
be saved
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ef3c9681941e..2da659d5f4a8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> >       int irq_effective_cpu;
> >       struct cpumask irq_affinity;
> >       struct kobject kobj;
> > +     unsigned long vdpa_reconnect_vaddr;
> >  };
> >
> >  struct vduse_dev;
> > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct=
 vduse_virtqueue *vq)
> >
> >       vq->irq_effective_cpu =3D curr_cpu;
> >  }
> > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +     unsigned long vaddr =3D 0;
> > +     struct vduse_virtqueue *vq;
> > +
> > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > +             /*page 0~ vq_num save the reconnect info for vq*/
> > +             vq =3D dev->vqs[i];
> > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
>
>
> I don't get why you insist on stealing kernel memory for something
> that is just used by userspace to store data for its own use.
> Userspace does not lack ways to persist data, for example,
> create a regular file anywhere in the filesystem.

Good point. So the motivation here is to:

1) be self contained, no dependency for high speed persist data
storage like tmpfs
2) standardize the format in uAPI which allows reconnection from
arbitrary userspace, unfortunately, such effort was removed in new
versions

If the above doesn't make sense, we don't need to offer those pages by VDUS=
E.

Thanks


>
>
>
> > +             if (vaddr =3D=3D 0)
> > +                     return -ENOMEM;
> > +
> > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +     struct vduse_virtqueue *vq;
> > +
> > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > +             vq =3D dev->vqs[i];
> > +
> > +             if (vq->vdpa_reconnect_vaddr)
> > +                     free_page(vq->vdpa_reconnect_vaddr);
> > +             vq->vdpa_reconnect_vaddr =3D 0;
> > +     }
> > +
> > +     return 0;
> > +}
> >
> >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> >               mutex_unlock(&dev->lock);
> >               return -EBUSY;
> >       }
> > +     vduse_free_reconnnect_info_mem(dev);
> > +
> >       dev->connected =3D true;
> >       mutex_unlock(&dev->lock);
> >
> > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config->vq_num)=
;
> >       if (ret)
> >               goto err_vqs;
> > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > +     if (ret < 0)
> > +             goto err_mem;
> >
> >       __module_get(THIS_MODULE);
> >
> >       return 0;
> >  err_vqs:
> >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor=
));
> > +err_mem:
> > +     vduse_free_reconnnect_info_mem(dev);
> >  err_dev:
> >       idr_remove(&vduse_idr, dev->minor);
> >  err_idr:
> > --
> > 2.43.0
>


