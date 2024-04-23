Return-Path: <linux-kernel+bounces-154439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB78ADC16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F042D1F229BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B017C66;
	Tue, 23 Apr 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxG5MqLZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341FC17BDC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841819; cv=none; b=ZAvP65pv9dQ1+4kVNZFSkXmCpypVxSBLU/05lK0O7VFx4z2DBgrN6+eDF5/e8+DD9Zj6QxHyznFtjkhJ8Ut+1ZSMR/O0Pu/dALB8nchKhYBYDf8lWF8yIljSczfpK2bE73dDzK2J8DldRlZLt5+apfRMj/7LIyh0U1yIxab01rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841819; c=relaxed/simple;
	bh=wXNHc5PiarQzMsw9YBToa7rRkxIOn05fejmLy8UMDd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa+7AxsBla0hdkeoyFMZjGim7HOc2xxe6IBCufnfxLr4SZLhO9nKh3WEJvsKSAbb8lygMLeu0jo9QmNtBc4nFaJ14eok7wOkBqXEWocPtyxQQ1cQ+6gW9Azo+CIvAmgFSgKOiGB/WdLdCVIGo+9zRQo9x0NP+lpn1YYKRzaZfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxG5MqLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713841816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGOzBYTBEU4Vx1BmqOXWbqCplxuBx3Gn5FBEe57Uzsg=;
	b=cxG5MqLZBMRplCF0LQ/8x4NPcTYo+/88qtHWOZZLub0ZNAWc5a14rmJ7Qrq1yOVUY1bZ27
	l2Ikozb0b+iE9wX2Alp+Xua97Fto/ClSPvAUVjT1P219DSlaKtqz4r5MpxHROqakm7AA6D
	qgIYyagRx8PoP/qwcIWpxvH6iqt1G3o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-6gjRmXGgNlSYjjQui2DVTg-1; Mon, 22 Apr 2024 23:10:13 -0400
X-MC-Unique: 6gjRmXGgNlSYjjQui2DVTg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso6702897a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841811; x=1714446611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGOzBYTBEU4Vx1BmqOXWbqCplxuBx3Gn5FBEe57Uzsg=;
        b=qHEHcNpgI41V5teNu1xIEJpahFdYizXSoP4IflDJzwZmiATjrQEMnFxLar8QRTye1M
         QuUcfGQfgvJ5EW12BSIXAc196YeD2aog116+6aLFtKiV+8NfXf7yi7m4r4dsyGbJa7cF
         GpDQg1I23Tl5AmmKofJElE1ejm30mjUwBb4KaVkFSzn3rSefQaIYAnEPyoeWiQOQQ3h8
         nASV/QtS5qT8ffVmMKQJP+9h+06eOjVIYMitRJsftcdPbhLScq+X/moAr9C/ylHkC6JY
         tvTn14NFDhn3oLB7ydT34kfxMpVgCW/uKKhK3Pvvr+LgLTOg3FIzWzUk9g410dJhjPSF
         usXA==
X-Forwarded-Encrypted: i=1; AJvYcCUb0es8hnVn8JVUY2BNY+EGYmvr70jxQ8PSNtOQPuB5HpWSzrEjiwbuw9n7mRfmcYVXhawKVfISkwT4l60b43CzIKZE94EHd/cf5gAM
X-Gm-Message-State: AOJu0YwAeiXWmwZz8I5G3feKZSHZa9NOsHDFFurkzq/IB1mWxvttYMHl
	s558KVBGkrQT6u1aAtw1bRm06S0n/0G0cCiDYl75IH90ge5RbToqSYa4FYIRSj+6nKNS46u1TsJ
	cITDJPwpdFvSUxju2Y8FMwjw+/f3N2DdJF6JDl0or2ZOd2UldmZGb5COXJuV45t3qSroIVo0HIj
	etwuRsyWbqnrV9DBAfWI3F3jANLbv/0OXr5JJVpq2K4nqGBYM=
X-Received: by 2002:a17:90a:d990:b0:2ab:ca7d:658b with SMTP id d16-20020a17090ad99000b002abca7d658bmr10112319pjv.4.1713841811420;
        Mon, 22 Apr 2024 20:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWUZxEIFiEErm5ahPVsmlGOlQL1BmJvl5wL68pDzSmIyeZFBW5KI0sV7sfwyMQHO929OZbhQnJ8VHOn5ptBY=
X-Received: by 2002:a17:90a:d990:b0:2ab:ca7d:658b with SMTP id
 d16-20020a17090ad99000b002abca7d658bmr10112304pjv.4.1713841811015; Mon, 22
 Apr 2024 20:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422160348-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Apr 2024 11:09:59 +0800
Message-ID: <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > and vduse_alloc_reconnnect_info_mem
> > > > These functions allow vduse to allocate and free memory for reconne=
ction
> > > > information. The amount of memory allocated is vq_num pages.
> > > > Each VQS will map its own page where the reconnection information w=
ill be saved
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > >       int irq_effective_cpu;
> > > >       struct cpumask irq_affinity;
> > > >       struct kobject kobj;
> > > > +     unsigned long vdpa_reconnect_vaddr;
> > > >  };
> > > >
> > > >  struct vduse_dev;
> > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(st=
ruct vduse_virtqueue *vq)
> > > >
> > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > >  }
> > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > +{
> > > > +     unsigned long vaddr =3D 0;
> > > > +     struct vduse_virtqueue *vq;
> > > > +
> > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > +             vq =3D dev->vqs[i];
> > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > >
> > >
> > > I don't get why you insist on stealing kernel memory for something
> > > that is just used by userspace to store data for its own use.
> > > Userspace does not lack ways to persist data, for example,
> > > create a regular file anywhere in the filesystem.
> >
> > Good point. So the motivation here is to:
> >
> > 1) be self contained, no dependency for high speed persist data
> > storage like tmpfs
>
> No idea what this means.

I mean a regular file may slow down the datapath performance, so
usually the application will try to use tmpfs and other which is a
dependency for implementing the reconnection.

>
> > 2) standardize the format in uAPI which allows reconnection from
> > arbitrary userspace, unfortunately, such effort was removed in new
> > versions
>
> And I don't see why that has to live in the kernel tree either.

I can't find a better place, any idea?

Thanks

>
> > If the above doesn't make sense, we don't need to offer those pages by =
VDUSE.
> >
> > Thanks
> >
> >
> > >
> > >
> > >
> > > > +             if (vaddr =3D=3D 0)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > +{
> > > > +     struct vduse_virtqueue *vq;
> > > > +
> > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > +             vq =3D dev->vqs[i];
> > > > +
> > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > >
> > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > >                           unsigned long arg)
> > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > >               mutex_unlock(&dev->lock);
> > > >               return -EBUSY;
> > > >       }
> > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > +
> > > >       dev->connected =3D true;
> > > >       mutex_unlock(&dev->lock);
> > > >
> > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_de=
v_config *config,
> > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, config->vq_=
num);
> > > >       if (ret)
> > > >               goto err_vqs;
> > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > +     if (ret < 0)
> > > > +             goto err_mem;
> > > >
> > > >       __module_get(THIS_MODULE);
> > > >
> > > >       return 0;
> > > >  err_vqs:
> > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->m=
inor));
> > > > +err_mem:
> > > > +     vduse_free_reconnnect_info_mem(dev);
> > > >  err_dev:
> > > >       idr_remove(&vduse_idr, dev->minor);
> > > >  err_idr:
> > > > --
> > > > 2.43.0
> > >
>


