Return-Path: <linux-kernel+bounces-124396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6888916F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451891F2476D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253869DFE;
	Fri, 29 Mar 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpeopG1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405F524C6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708790; cv=none; b=ePd85MpldSKxJxR7YvH137E92YrDW129E/JW0pFUJ7mFf0rI3Dh86ZjhbETq+/qlqpXtYzb3AlnASmqPGnUh6hH0FMPWMwHqRombsSMcGOlSkrmaSMcc7Ax9E0szlYUhrtAJKyEgGa4Ujc2QJr9ttU4c8NJEpeguFQPEK5R4v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708790; c=relaxed/simple;
	bh=EYA/e5MN8OWgNNQG6YYYjkegqo7wLaqt+X6WVG+Adh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2fXC+6+JZnhwrPBBNsVS8iTwA9i2EPCUwFoPuHDSIycJ2WukZ/t5lQ++7XA45Y8zc1AvY+QL+45nWAleS4ZX+0D3QgEsga+kqrBfA/dATvrVNAFJUxAhNswOtHTMqllgHT7ajAY3qIsNPJLx/pu7/L1behtvKQdSFHI+K3OUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpeopG1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711708787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+SBSy/YPk6E2eU0jochnxmXNzXx71UIPutjWGi+iCQ=;
	b=DpeopG1zr6BYwq+IeKlJ08PvhsQrSFZnc9U402fC7LxH2APcrYQAV/uux31rk3isQl/dDd
	BNZgrwzO8pIkk9ZELcyifVeeh1ggngT38U+rkgqa04XyEZsAw+pNPWXaHFELGFiSkzR0aD
	pJawdjAC3ZP4DUlijt4fgZoK4M7vPFs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-ArFaUE2fOhagMMLh9Er2Bg-1; Fri, 29 Mar 2024 06:39:45 -0400
X-MC-Unique: ArFaUE2fOhagMMLh9Er2Bg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a090878480so1526410a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708785; x=1712313585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+SBSy/YPk6E2eU0jochnxmXNzXx71UIPutjWGi+iCQ=;
        b=GGIUwlV+DgphUGPLD5QRJy0N+dJ8K5AuVI1HrpiDUecUzz70EMn6u+fSBT0Rt3oSOg
         Mj2hu6V7kcrFNxPe6xCqRr668v5PJ8YBL2FItqAPbN9/7P4HWWi1r4B0qAmIImI+P0EF
         DnWKBiTT33OahCzuHFbDW8rblOjaTWl0Vyun1HHH5hIV+0uETAQuDmij1eucvSskg9zY
         m9v6I9ASwAVgv1Dr5ZfOK9A1bESkui2J4SmIXPwlUpNers5szWl9DpcNEGJEDuFqJqtT
         6b8tKYL5mTiIBkVhMVzuvGzllNkSzPASUBBFg3PQfLhtyvqUoL3ikbHH3uj2nKKiJxns
         psLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCMr/eTM/4FMYqB/eOakOJYtDBwdl5CSVZUuUvu5Ki4Yd2B0tRqErgvoeztOJ0xOZjitXF/0neQ5BdqJHZxqTu9E5tFwz4/usfbu5c
X-Gm-Message-State: AOJu0YxtYCKN8Roj99bd1LMy0FF8Vpe1U51hZd2ov9FoUz3xEou9DXWh
	uUkFJp+U4fYfPy3Wgk6xjAAy6RRFKKhAA6aBfkpLv0nKswnaDuLHcUOYmc7kWFLfUvua2F/z82U
	UsaEZgpHVc8KzjcRexN3dqz8KATJBeS6QT8jQnToT0WFNwNRD5IJnx1SMMFbsvJEIFSlwcgJrLk
	oJHCIjCbLTAbFjyjgKT7lXFKk+wJQBQHRWQAjb
X-Received: by 2002:a17:90b:3b8b:b0:2a0:4465:6f9d with SMTP id pc11-20020a17090b3b8b00b002a044656f9dmr7160433pjb.11.1711708784840;
        Fri, 29 Mar 2024 03:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWE93lwHV8697pqSDWSJniS982RbSgQYutHVk5cvBm/AEueSZwhvrkrPsW390PE4YWQk2IH1bpBY1zRJByXqs=
X-Received: by 2002:a17:90b:3b8b:b0:2a0:4465:6f9d with SMTP id
 pc11-20020a17090b3b8b00b002a044656f9dmr7160409pjb.11.1711708784389; Fri, 29
 Mar 2024 03:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com> <20240329051117-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240329051117-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 18:39:33 +0800
Message-ID: <CACGkMEsdjdMNqe2OaJcpKGPSs0+BCK-qq6i6QZmJSvt+M5p8QQ@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 27, 2024 at 05:08:57PM +0800, Jason Wang wrote:
> > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > From: Rong Wang <w_angrong@163.com>
> > > >
> > > > Once enable iommu domain for one device, the MSI
> > > > translation tables have to be there for software-managed MSI.
> > > > Otherwise, platform with software-managed MSI without an
> > > > irq bypass function, can not get a correct memory write event
> > > > from pcie, will not get irqs.
> > > > The solution is to obtain the MSI phy base address from
> > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > then translation tables will be created while request irq.
> > > >
> > > > Change log
> > > > ----------
> > > >
> > > > v1->v2:
> > > > - add resv iotlb to avoid overlap mapping.
> > > > v2->v3:
> > > > - there is no need to export the iommu symbol anymore.
> > > >
> > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > >
> > > There's in interest to keep extending vhost iotlb -
> > > we should just switch over to iommufd which supports
> > > this already.
> >
> > IOMMUFD is good but VFIO supports this before IOMMUFD.
>
> You mean VFIO migrated to IOMMUFD but of course they keep supporting
> their old UAPI?

I meant VFIO support software managed MSI before IOMMUFD.

> OK and point being?
>
> > This patch
> > makes vDPA run without a backporting of full IOMMUFD in the production
> > environment. I think it's worth.
>
> Where do we stop? saying no to features is the only tool maintainers
> have to make cleanups happen, otherwise people will just keep piling
> stuff up.

I think we should not have more features than VFIO without IOMMUFD.

Thanks

>
> > If you worry about the extension, we can just use the vhost iotlb
> > existing facility to do this.
> >
> > Thanks
> >
> > >
> > > > ---
> > > >  drivers/vhost/vdpa.c | 59 ++++++++++++++++++++++++++++++++++++++++=
+---
> > > >  1 file changed, 56 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index ba52d128aeb7..28b56b10372b 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> > > >       struct completion completion;
> > > >       struct vdpa_device *vdpa;
> > > >       struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> > > > +     struct vhost_iotlb resv_iotlb;
> > > >       struct device dev;
> > > >       struct cdev cdev;
> > > >       atomic_t opened;
> > > > @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa=
 *v)
> > > >  static int vhost_vdpa_reset(struct vhost_vdpa *v)
> > > >  {
> > > >       v->in_batch =3D 0;
> > > > +     vhost_iotlb_reset(&v->resv_iotlb);
> > > >       return _compat_vdpa_reset(v);
> > > >  }
> > > >
> > > > @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(=
struct vhost_vdpa *v,
> > > >           msg->iova + msg->size - 1 > v->range.last)
> > > >               return -EINVAL;
> > > >
> > > > +     if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> > > > +                                     msg->iova + msg->size - 1))
> > > > +             return -EINVAL;
> > > > +
> > > >       if (vhost_iotlb_itree_first(iotlb, msg->iova,
> > > >                                   msg->iova + msg->size - 1))
> > > >               return -EEXIST;
> > > >
> > > > +
> > > >       if (vdpa->use_va)
> > > >               return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->si=
ze,
> > > >                                        msg->uaddr, msg->perm);
> > > > @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(str=
uct kiocb *iocb,
> > > >       return vhost_chr_write_iter(dev, from);
> > > >  }
> > > >
> > > > +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domai=
n, struct device *dma_dev,
> > > > +     struct vhost_iotlb *resv_iotlb)
> > > > +{
> > > > +     struct list_head dev_resv_regions;
> > > > +     phys_addr_t resv_msi_base =3D 0;
> > > > +     struct iommu_resv_region *region;
> > > > +     int ret =3D 0;
> > > > +     bool with_sw_msi =3D false;
> > > > +     bool with_hw_msi =3D false;
> > > > +
> > > > +     INIT_LIST_HEAD(&dev_resv_regions);
> > > > +     iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> > > > +
> > > > +     list_for_each_entry(region, &dev_resv_regions, list) {
> > > > +             ret =3D vhost_iotlb_add_range_ctx(resv_iotlb, region-=
>start,
> > > > +                             region->start + region->length - 1,
> > > > +                             0, 0, NULL);
> > > > +             if (ret) {
> > > > +                     vhost_iotlb_reset(resv_iotlb);
> > > > +                     break;
> > > > +             }
> > > > +
> > > > +             if (region->type =3D=3D IOMMU_RESV_MSI)
> > > > +                     with_hw_msi =3D true;
> > > > +
> > > > +             if (region->type =3D=3D IOMMU_RESV_SW_MSI) {
> > > > +                     resv_msi_base =3D region->start;
> > > > +                     with_sw_msi =3D true;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (!ret && !with_hw_msi && with_sw_msi)
> > > > +             ret =3D iommu_get_msi_cookie(domain, resv_msi_base);
> > > > +
> > > > +     iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > > >  {
> > > >       struct vdpa_device *vdpa =3D v->vdpa;
> > > > @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct v=
host_vdpa *v)
> > > >
> > > >       ret =3D iommu_attach_device(v->domain, dma_dev);
> > > >       if (ret)
> > > > -             goto err_attach;
> > > > +             goto err_alloc_domain;
> > > >
> > > > -     return 0;
> > > > +     ret =3D vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->=
resv_iotlb);
> > > > +     if (ret)
> > > > +             goto err_attach_device;
> > > >
> > > > -err_attach:
> > > > +     return 0;
> > > > +err_attach_device:
> > > > +     iommu_detach_device(v->domain, dma_dev);
> > > > +err_alloc_domain:
> > > >       iommu_domain_free(v->domain);
> > > >       v->domain =3D NULL;
> > > >       return ret;
> > > > @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_devic=
e *vdpa)
> > > >               goto err;
> > > >       }
> > > >
> > > > +     vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> > > > +
> > > >       r =3D dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> > > >       if (r)
> > > >               goto err;
> > > > --
> > > > 2.27.0
> > > >
> > >
>


