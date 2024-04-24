Return-Path: <linux-kernel+bounces-156661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F058B0671
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F31F23389
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89F158DD7;
	Wed, 24 Apr 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxmDbpyF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984E1E898
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952294; cv=none; b=CcH/UqgMmcxAxBe8bunXL1WoMiM9eK4J30LicMisISjCEcpRTaUS8xoVk9hHyiNDE/U8KVMvGzBpR5cR3fwzZJLcpCVw0kKZlEI9u8QdBvBrrneO0VIICzTBerupGZM6F34+MbLt7cZ7+ZMGtUzH+WLTrsIaqafDk+TDJIfYfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952294; c=relaxed/simple;
	bh=DEXpHeXxlKLGtBABA81i9UYmTJHW63GkAg+T90z+zW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQzek++a8AtgIk0PNGIlWj2bdjlG3FSArQRoPDATrk5zd1iOwJAobAXYtCOADShOBfxMvCbUBkcjX3LW87Nw9XWASjTzyPpXoDQioYp6o1Dknv8l9erqK9CRDjqkVnMcQtblgOdeowJaFcakvfipQPDPWFv3ifo22gIb5ODEp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxmDbpyF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713952292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv8cjYcXwwXBVKkdVfh0gXFti8JhCIGV3qOrwaSd90k=;
	b=JxmDbpyF0y9cTEbmLtUb0uBKA6pApFcG0rOpCA00scnp0aUZVKlkrV7G/mFoWf7o34EWyB
	bAGvSO4IlGmIs8k4BV4uhWqKVp2Ahr6VbTM75HLBHuwE5R3IQlpwY8Fi3LQg/hFwwMywAt
	1gTJBvKmokxe46LvvzWzHsi4Gesbjfw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-HG-uEvahMqaeM0DDyaWqow-1; Wed, 24 Apr 2024 05:51:30 -0400
X-MC-Unique: HG-uEvahMqaeM0DDyaWqow-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41a3369659eso3114765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952289; x=1714557089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv8cjYcXwwXBVKkdVfh0gXFti8JhCIGV3qOrwaSd90k=;
        b=me8qGwDV9vR0xMxXcKHrKVUFf2JC5BmT2mBRJr/+g6/5G3y200MP87XIqX9tHZKGKz
         XXn0pxcYojunW0Yq2suhCTy4DEdafOZDm/xabwWd6r8I15icgq3eIsHpXFgf8tfy0Pw1
         iE8Yos7hWEiBZ84DIi/XNyQlbIE+oUAd2t+kNOLrSbxG8qpsTmDra9NOJ1QLDYReqrGn
         myYuPaoH+cPvc1UrCblPwBf+twx2XbgcyzbM5my6KAqjdylkcG/Bb1V1hVaviYUQIft1
         KxOsTW0oGLjy2ATfwkRZDg1Z1sC5jVQzi7OT4WYBiYQEbAe9uWFCb63mLAyP3PRqK/dT
         27Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX/gvsSToXxAFiVyft1iBKoE2x6aqK8L27a21nH1Q4Edic94TBHengTMuYVWEokp/GSP+dYuPgT1r0vLeIGaFT1IIl1gskcBozYUdet
X-Gm-Message-State: AOJu0Yw282ET7uIq66pEOt7Lm0fQUhDK0kWD+paMXsqIhJ/qVrSMoenc
	yUOzPhZ8cQqMUH8w8pILXMChkXBnUhI3qpGRbJ6g0keBIdzrNUwC6wiU+jF/zn1S3KHLW2cd8Nl
	RMSBve+tu1V32JOMg8sVON5MVWHIiMIsHe2cTgUjptpjaO4b2WQhbuRI2Nz8JLw==
X-Received: by 2002:a05:600c:358a:b0:41a:410b:fe9e with SMTP id p10-20020a05600c358a00b0041a410bfe9emr1364081wmq.12.1713952288944;
        Wed, 24 Apr 2024 02:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8IqubQ4pRsFqO6DbDOa+rGyhzaTafu1jLoU5U7uacX0Oi4qm5g6J2rAWDSdfJ4KhyRZzAqw==
X-Received: by 2002:a05:600c:358a:b0:41a:410b:fe9e with SMTP id p10-20020a05600c358a00b0041a410bfe9emr1364061wmq.12.1713952288374;
        Wed, 24 Apr 2024 02:51:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c139400b0041906397ab7sm19477548wmf.3.2024.04.24.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:51:27 -0700 (PDT)
Date: Wed, 24 Apr 2024 05:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240424055108-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
 <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>

On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> On Tue, Apr 23, 2024 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 40 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
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
> > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > > > >
> > > > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > > > >  }
> > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +     unsigned long vaddr = 0;
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > > +             vq = dev->vqs[i];
> > > > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > > > >
> > > > > >
> > > > > > I don't get why you insist on stealing kernel memory for something
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

Why? Who ships these?


> >
> >
> > > >
> > > > > 2) standardize the format in uAPI which allows reconnection from
> > > > > arbitrary userspace, unfortunately, such effort was removed in new
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
> >
> > > >
> > > > > If the above doesn't make sense, we don't need to offer those pages by VDUSE.
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > +             if (vaddr == 0)
> > > > > > > +                     return -ENOMEM;
> > > > > > > +
> > > > > > > +             vq->vdpa_reconnect_vaddr = vaddr;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > +
> > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > +             vq = dev->vqs[i];
> > > > > > > +
> > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > +             vq->vdpa_reconnect_vaddr = 0;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > >
> > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > > > >                           unsigned long arg)
> > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
> > > > > > >               mutex_unlock(&dev->lock);
> > > > > > >               return -EBUSY;
> > > > > > >       }
> > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > +
> > > > > > >       dev->connected = true;
> > > > > > >       mutex_unlock(&dev->lock);
> > > > > > >
> > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > > > >       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> > > > > > >       if (ret)
> > > > > > >               goto err_vqs;
> > > > > > > +     ret = vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > +     if (ret < 0)
> > > > > > > +             goto err_mem;
> > > > > > >
> > > > > > >       __module_get(THIS_MODULE);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  err_vqs:
> > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
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


