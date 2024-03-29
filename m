Return-Path: <linux-kernel+bounces-124399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C788916FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39261C23389
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93FE69DFA;
	Fri, 29 Mar 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXeM10M3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CE54F92
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708957; cv=none; b=JjoPMrBzlqaeyhFmAnZ6J4NSln3VhUdGqJHxsGbIkEoYfj9WbU/mSN+6d7yN8YZXWzrayV5j+gay9cqkQzFcqjkiTvZ+cqMLTl0A6p+Yf1YQ7QuiYVK6WRyEb4KNh3wq4OGJNqCD224TRLjvHI0VUI9fiQu8Mb0gzOdSvvH/HDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708957; c=relaxed/simple;
	bh=mIj010owU9PuQikt2g/FIFn0Qnf6dgaW9TGvccazZUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZhVFfBJb1/H7S2D+uCsss7tdXN+wzNWGwBv/U82TFyqegQKBPnyS5hNk3RHYUh+KBYTV6J9D2vLfKY5I/Ha29o4IP976/GLGP7nlrZC1HFYEUJj6YTCa11EQQKyUV5LKDy+/ZnEZB8onup+AmXEV6TZYrbrhtIY4YnKb6y/1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXeM10M3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711708955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNeKZIFvpJh5aeL4SOwRxF8AfLCnIBk83X3RDyYsLzs=;
	b=IXeM10M30Zn+7wMVqE4HwIqwbCVVkBEV1Fi9zaF4FqC91OUOxopenJ/Dj8ZYM4mLKD4yZZ
	Xei47Om6vxHLdIMk6pzallfw6YiK3Igs/uUI9/EBG1I2FugCaEw7sloAzCbRIkQ9lRRAKv
	UEuBPf9T0XVRDGnF4Rj1U6jCNkSPCq0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-AO-nTYh3OMq9cJGef6nj1Q-1; Fri, 29 Mar 2024 06:42:34 -0400
X-MC-Unique: AO-nTYh3OMq9cJGef6nj1Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a473f5a84aaso147768966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708952; x=1712313752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNeKZIFvpJh5aeL4SOwRxF8AfLCnIBk83X3RDyYsLzs=;
        b=AiMZzY5i6jH9LwlBNStlSUNFA6YvfI7mrL1lDXEyDP4e6P51ONxablUei5lC9Mkjkq
         Hh7PVoQY+1V71Q2dN8wh38gt0eEClPSIgAYc9XScMXrbXFB1KsvBVyFE2DQ7inW+iNnH
         8YvIFvoYBLXg7kTlpVASGE5tkAYMAzCfDI6b/RE1+2eFyD1X7cAnpDoU0sbEOtXD6I2f
         6mvwT++ENbGm26vvukn0Q4tV4dCeFF/Gae9/u2bXcrc4TAmiJyUZNS+rMV5JD8NvYojj
         ON6a93lzD2AfboFVHSOUgKz91BsSdJeeq/HiGmMiEWxCtljW9Bi3b+72bthAXO9S37Qb
         dIvw==
X-Forwarded-Encrypted: i=1; AJvYcCW2ogyxN7FjknBZrEm0sA6knkK8rY76NObzU7dSqO0a+06gpB87UF9ag84iG8l4n7eV/50kB4e3rYZpd8wJYXV9svdtp1hJLaixkyhH
X-Gm-Message-State: AOJu0YwxaHVg1axv3Ndzm7zLN0QcG9u8MTfkjk8SLNwMc7j7q4FYa7fh
	iOBnzbJYrlHcM/eCcXKtXVUqQaYRGmgwJasD248UHPP149GVkvi8Npp9sSHexYKGdLN/JcAXO5u
	4CiK7HlFpEgogxh7stE7B5lSMo6vufBul6UtKgNWdr0+ePouwj2wLjYF0d0qEk1PX8b8Rhw==
X-Received: by 2002:a05:6402:26d6:b0:56c:2bed:2d10 with SMTP id x22-20020a05640226d600b0056c2bed2d10mr1447920edd.3.1711708952358;
        Fri, 29 Mar 2024 03:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZE1cdVjFraVRMoO3oMnNjRAX3EJwEES4/uWDrZm6fOp6LeNhJrEQXL2sYzxKNuW7RRCLOYg==
X-Received: by 2002:a05:6402:26d6:b0:56c:2bed:2d10 with SMTP id x22-20020a05640226d600b0056c2bed2d10mr1447902edd.3.1711708951904;
        Fri, 29 Mar 2024 03:42:31 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id g5-20020a056402428500b0056c3013485csm1857383edc.69.2024.03.29.03.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:42:31 -0700 (PDT)
Date: Fri, 29 Mar 2024 06:42:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20240329064114-mutt-send-email-mst@kernel.org>
References: <20240320101912.28210-1-w_angrong@163.com>
 <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <20240329051117-mutt-send-email-mst@kernel.org>
 <CACGkMEsdjdMNqe2OaJcpKGPSs0+BCK-qq6i6QZmJSvt+M5p8QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsdjdMNqe2OaJcpKGPSs0+BCK-qq6i6QZmJSvt+M5p8QQ@mail.gmail.com>

On Fri, Mar 29, 2024 at 06:39:33PM +0800, Jason Wang wrote:
> On Fri, Mar 29, 2024 at 5:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 05:08:57PM +0800, Jason Wang wrote:
> > > On Thu, Mar 21, 2024 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > From: Rong Wang <w_angrong@163.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > > >
> > > > > Change log
> > > > > ----------
> > > > >
> > > > > v1->v2:
> > > > > - add resv iotlb to avoid overlap mapping.
> > > > > v2->v3:
> > > > > - there is no need to export the iommu symbol anymore.
> > > > >
> > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > >
> > > > There's in interest to keep extending vhost iotlb -
> > > > we should just switch over to iommufd which supports
> > > > this already.
> > >
> > > IOMMUFD is good but VFIO supports this before IOMMUFD.
> >
> > You mean VFIO migrated to IOMMUFD but of course they keep supporting
> > their old UAPI?
> 
> I meant VFIO support software managed MSI before IOMMUFD.

And then they switched over and stopped adding new IOMMU
related features. And so should vdpa?


> > OK and point being?
> >
> > > This patch
> > > makes vDPA run without a backporting of full IOMMUFD in the production
> > > environment. I think it's worth.
> >
> > Where do we stop? saying no to features is the only tool maintainers
> > have to make cleanups happen, otherwise people will just keep piling
> > stuff up.
> 
> I think we should not have more features than VFIO without IOMMUFD.
> 
> Thanks
> 
> >
> > > If you worry about the extension, we can just use the vhost iotlb
> > > existing facility to do this.
> > >
> > > Thanks
> > >
> > > >
> > > > > ---
> > > > >  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 56 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > index ba52d128aeb7..28b56b10372b 100644
> > > > > --- a/drivers/vhost/vdpa.c
> > > > > +++ b/drivers/vhost/vdpa.c
> > > > > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> > > > >       struct completion completion;
> > > > >       struct vdpa_device *vdpa;
> > > > >       struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> > > > > +     struct vhost_iotlb resv_iotlb;
> > > > >       struct device dev;
> > > > >       struct cdev cdev;
> > > > >       atomic_t opened;
> > > > > @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
> > > > >  static int vhost_vdpa_reset(struct vhost_vdpa *v)
> > > > >  {
> > > > >       v->in_batch = 0;
> > > > > +     vhost_iotlb_reset(&v->resv_iotlb);
> > > > >       return _compat_vdpa_reset(v);
> > > > >  }
> > > > >
> > > > > @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > > > >           msg->iova + msg->size - 1 > v->range.last)
> > > > >               return -EINVAL;
> > > > >
> > > > > +     if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> > > > > +                                     msg->iova + msg->size - 1))
> > > > > +             return -EINVAL;
> > > > > +
> > > > >       if (vhost_iotlb_itree_first(iotlb, msg->iova,
> > > > >                                   msg->iova + msg->size - 1))
> > > > >               return -EEXIST;
> > > > >
> > > > > +
> > > > >       if (vdpa->use_va)
> > > > >               return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
> > > > >                                        msg->uaddr, msg->perm);
> > > > > @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
> > > > >       return vhost_chr_write_iter(dev, from);
> > > > >  }
> > > > >
> > > > > +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
> > > > > +     struct vhost_iotlb *resv_iotlb)
> > > > > +{
> > > > > +     struct list_head dev_resv_regions;
> > > > > +     phys_addr_t resv_msi_base = 0;
> > > > > +     struct iommu_resv_region *region;
> > > > > +     int ret = 0;
> > > > > +     bool with_sw_msi = false;
> > > > > +     bool with_hw_msi = false;
> > > > > +
> > > > > +     INIT_LIST_HEAD(&dev_resv_regions);
> > > > > +     iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> > > > > +
> > > > > +     list_for_each_entry(region, &dev_resv_regions, list) {
> > > > > +             ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
> > > > > +                             region->start + region->length - 1,
> > > > > +                             0, 0, NULL);
> > > > > +             if (ret) {
> > > > > +                     vhost_iotlb_reset(resv_iotlb);
> > > > > +                     break;
> > > > > +             }
> > > > > +
> > > > > +             if (region->type == IOMMU_RESV_MSI)
> > > > > +                     with_hw_msi = true;
> > > > > +
> > > > > +             if (region->type == IOMMU_RESV_SW_MSI) {
> > > > > +                     resv_msi_base = region->start;
> > > > > +                     with_sw_msi = true;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (!ret && !with_hw_msi && with_sw_msi)
> > > > > +             ret = iommu_get_msi_cookie(domain, resv_msi_base);
> > > > > +
> > > > > +     iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > >  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > > > >  {
> > > > >       struct vdpa_device *vdpa = v->vdpa;
> > > > > @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > > > >
> > > > >       ret = iommu_attach_device(v->domain, dma_dev);
> > > > >       if (ret)
> > > > > -             goto err_attach;
> > > > > +             goto err_alloc_domain;
> > > > >
> > > > > -     return 0;
> > > > > +     ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
> > > > > +     if (ret)
> > > > > +             goto err_attach_device;
> > > > >
> > > > > -err_attach:
> > > > > +     return 0;
> > > > > +err_attach_device:
> > > > > +     iommu_detach_device(v->domain, dma_dev);
> > > > > +err_alloc_domain:
> > > > >       iommu_domain_free(v->domain);
> > > > >       v->domain = NULL;
> > > > >       return ret;
> > > > > @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> > > > >               goto err;
> > > > >       }
> > > > >
> > > > > +     vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> > > > > +
> > > > >       r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> > > > >       if (r)
> > > > >               goto err;
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> >


