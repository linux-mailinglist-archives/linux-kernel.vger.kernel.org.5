Return-Path: <linux-kernel+bounces-154721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFE8AE025
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D91F1C22738
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849277F499;
	Tue, 23 Apr 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2yz/MN/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBB7E59F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861774; cv=none; b=nvVZAxhtGpGdG3HosNRqruVwf8tSCNb7jUhnWw16nXzRDb5+S6F621TjvGBiudIkbEDpqoSQyv7oD6rmvvfTDg//kIDfY8S2IqGpbRgMrruBi3FKaeiB+XGJJQC3yTM1C9f2A10Mt1aK2zWnej4sNjz4Ff6wSKE8UKsoSftN4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861774; c=relaxed/simple;
	bh=2fDjVbeuUBzTnztgsVGjQmQS5y0ZjQkAUa5V+c2zvzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy5dj9gcb/+vyutnydan7ChWDOADVn2Vzk/gNDxrUT0LSiheIOXMZ6Etjb3RmGHX0NQueiZaCasDIpjFeH/EaI1IUk9f2VJa91Mk3nVUBTJDyuF2CG6FfuiIq3FhJodDIsLmOiN0jxxIfzuPCgsDqSOxCzmLGg3Ot9nugh51n5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2yz/MN/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713861771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ps+xzWTYxFd7OS06+PYtb6cxlk6Hy0GmNF9fJOn63Zo=;
	b=M2yz/MN/BSKrPw268Jf7EhhRdSS4cMuhmVL0fQLZbOO/u2iTnt/atuDC2iOdZVjhSoPh56
	huR0R8gnvCp67yIdf8fQyk8n6WWcGLGZTW48llYDRADx0YI9Q8Vb5ki2gSBfdy1ze+4BiN
	lIRgGy/EI891/AnxdWrKTz8G7T26TFw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-S-DiUoz_M6eoKY3JnEiBmg-1; Tue, 23 Apr 2024 04:42:50 -0400
X-MC-Unique: S-DiUoz_M6eoKY3JnEiBmg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3455cbdea2cso2518506f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861768; x=1714466568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps+xzWTYxFd7OS06+PYtb6cxlk6Hy0GmNF9fJOn63Zo=;
        b=WVWcugQwFRTC/SEOcYLZuf50zajMw69ImekRKxW+1OOdT8V4FrovrjP8cTaszpvHMU
         h74LXtyB0B9M4RaTkJdL89RmSe9HoCEcC0Z0u2FAm8FqZQ6/EyLcpCNaWRkRBtsKkY1A
         GnBPW4wlHmO3JhWtayVaYN2B5SnAQqvGsiY8C7D46x+xRAxQxVSu0rtEWMSy07zgJTdA
         5ZhrjB73rh31uVw82J/E6zaT7tgoRr7zMBDEyf+iIV9As7EpfzT+vx0x9X73jn3RkFgt
         3edOpWzSH4FdXz/tGNTCS7qMW3JD6qo79tG9B8jVSQw6kCRLUWHMe4b6bwldz8P0KCLB
         OI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE8BQsHggAV1AJhxVff+FsxtvEszVbN+Y/sv4FQwrFkidCBa6sIFIwUL3/5oOTiPJGCN4005UEdUGiwnwcTPGcc/6SN6T6EqVvALek
X-Gm-Message-State: AOJu0Yx7h7Duo32ABomD2gTceiocM4+6nV0QSr/6EXSfLY2PbJIZZmyA
	matHseM99kGN2iII8yxInwg6jl/r0OQlUGis7LMaf+BaIzV9HENfxcCRXRqWzIvvBYYVG4tYq1c
	17bzFC/x7Ova9vyX4l2tnWqz4dxYomh6TGdVazvV66u1roUD1oLSpdSJOzppEJlnPHnVr9Q==
X-Received: by 2002:adf:db47:0:b0:34b:6240:3467 with SMTP id f7-20020adfdb47000000b0034b62403467mr1428315wrj.3.1713861768546;
        Tue, 23 Apr 2024 01:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5lBC1PGR2u/FH3l6COzzBqmrDWV109EY8m+4UpFCe4iQbYF4ViweNueYxZykEpRxLbBYujg==
X-Received: by 2002:adf:db47:0:b0:34b:6240:3467 with SMTP id f7-20020adfdb47000000b0034b62403467mr1428290wrj.3.1713861767997;
        Tue, 23 Apr 2024 01:42:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00343826878e8sm13993177wrq.38.2024.04.23.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:47 -0700 (PDT)
Date: Tue, 23 Apr 2024 04:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240423043538-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>

On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > and vduse_alloc_reconnnect_info_mem
> > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > information. The amount of memory allocated is vq_num pages.
> > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > >  1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > >       int irq_effective_cpu;
> > > > >       struct cpumask irq_affinity;
> > > > >       struct kobject kobj;
> > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > >  };
> > > > >
> > > > >  struct vduse_dev;
> > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > >
> > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > >  }
> > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > +{
> > > > > +     unsigned long vaddr = 0;
> > > > > +     struct vduse_virtqueue *vq;
> > > > > +
> > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > +             vq = dev->vqs[i];
> > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > >
> > > >
> > > > I don't get why you insist on stealing kernel memory for something
> > > > that is just used by userspace to store data for its own use.
> > > > Userspace does not lack ways to persist data, for example,
> > > > create a regular file anywhere in the filesystem.
> > >
> > > Good point. So the motivation here is to:
> > >
> > > 1) be self contained, no dependency for high speed persist data
> > > storage like tmpfs
> >
> > No idea what this means.
> 
> I mean a regular file may slow down the datapath performance, so
> usually the application will try to use tmpfs and other which is a
> dependency for implementing the reconnection.

Are we worried about systems without tmpfs now?


> >
> > > 2) standardize the format in uAPI which allows reconnection from
> > > arbitrary userspace, unfortunately, such effort was removed in new
> > > versions
> >
> > And I don't see why that has to live in the kernel tree either.
> 
> I can't find a better place, any idea?
> 
> Thanks


Well anywhere on github really. with libvhost-user maybe?
It's harmless enough in Documentation
if you like but ties you to the kernel release cycle in a way that
is completely unnecessary.

> >
> > > If the above doesn't make sense, we don't need to offer those pages by VDUSE.
> > >
> > > Thanks
> > >
> > >
> > > >
> > > >
> > > >
> > > > > +             if (vaddr == 0)
> > > > > +                     return -ENOMEM;
> > > > > +
> > > > > +             vq->vdpa_reconnect_vaddr = vaddr;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > +{
> > > > > +     struct vduse_virtqueue *vq;
> > > > > +
> > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > +             vq = dev->vqs[i];
> > > > > +
> > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > +             vq->vdpa_reconnect_vaddr = 0;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > >
> > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > >                           unsigned long arg)
> > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > >               mutex_unlock(&dev->lock);
> > > > >               return -EBUSY;
> > > > >       }
> > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > +
> > > > >       dev->connected = true;
> > > > >       mutex_unlock(&dev->lock);
> > > > >
> > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > >       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> > > > >       if (ret)
> > > > >               goto err_vqs;
> > > > > +     ret = vduse_alloc_reconnnect_info_mem(dev);
> > > > > +     if (ret < 0)
> > > > > +             goto err_mem;
> > > > >
> > > > >       __module_get(THIS_MODULE);
> > > > >
> > > > >       return 0;
> > > > >  err_vqs:
> > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> > > > > +err_mem:
> > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > >  err_dev:
> > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > >  err_idr:
> > > > > --
> > > > > 2.43.0
> > > >
> >


