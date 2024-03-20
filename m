Return-Path: <linux-kernel+bounces-108848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46E8810DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3740E1F21763
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F83DBA1;
	Wed, 20 Mar 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3sZNqBv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B133D541
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933802; cv=none; b=i1YOtGBGt+TC8hDAJEY9tTTC1rvEEsa74XKunAJTM8FrrrVolm3yUSWM/19aS+GwbJvrcpykGalgIw76vnmtxHIIg9L9KxkW1FyQnWaw00TNp1Pg4XdsEJIUOGG+w16ytXQT0donMwRjieRT5A/CNTWYr0bDeJqZDpPF74PbfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933802; c=relaxed/simple;
	bh=W0Rj3irASw2NxslYWVYI5NB5ArHB3r8ZhTvFTHJVUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwxGlZoZk7rLHfLCDN13vbNn4NwdZJKH/8AJq517qfa26ZJmKGPqIkok5G2ZCt5Wg1Gx2faxdFHfF8/h+ZG3Ac9bgqaTx/CnTRigk5GY254FzsQHQTfH7mpV99vM89+BTVrKVc4xVwW4NAJA75fO2FBGv19bH2IsHNaRFsZyi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3sZNqBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710933799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+QaA5zXpjzm/uii78z1xNkCbYk757CWz5S1pTNqPys=;
	b=T3sZNqBv1HpKtdN0vLu6BTm4+b+EMy8jrtlgk56Q6IHCyZNQCYmaKnxgyEAg9kqYhD2nDX
	KfpCtf/xr/WGf7tLZLpQ1L3UQPm0AeOYPUqOiMseRDKSZYUFvH4lni+e3pRxDQZLX7Iw2W
	h6Ic0eH76BuMHnAnbqi5ZUksDJU2XPg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-UKnIjBQSONGvXgVsIz5BSw-1; Wed, 20 Mar 2024 07:23:17 -0400
X-MC-Unique: UKnIjBQSONGvXgVsIz5BSw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a46b82df33cso218897766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710933796; x=1711538596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+QaA5zXpjzm/uii78z1xNkCbYk757CWz5S1pTNqPys=;
        b=LXXKPq3r207cqjFKwNlLE4XawV+yGj39/xeUuM26pIMIhybsmPDjVzPf1bq91vvwlE
         fTXnODGptlaqU11q4ytUiAg/Z789Fx1ugG03ywvL6QGfjf2FIKC1mhH5rSYKIbmZ+Y9H
         pCfAA+AfXShhLRFKeLezkScvdjL23xw8O5/vw+yGARWvD4iqTpGIdnyUC1Tc53yKit9l
         m2lsQSe36ViPgqHHnLmsAcuuJAKQYB5dpCyq1lrdZihk+VHOPxCRrW9zY4Qg5OJAo/3c
         VfS0RQ/G53neAoIBsqjTyuxaiRfudkVG47QZrDJm1mIRdQ0s28aMTHvIt9M4ppJRrjVm
         pl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuak4fZdfHsqlgjxM/5fFvpAgAaceLh0QS9YoqL9bfu1eXMnb2Pah3Nxeojb0He2ChZLICHXIZDpSxlXZr+dO/ejMHSiyqRrwah8M8
X-Gm-Message-State: AOJu0YyJVrvmThe2QMze54532IGiwHQVIBA/UgxBB/C7uulQ4LWatnuN
	Z/fyFZ68ymlx1rzcZLPOeIOoGqxRDXSXC/3S4W2a1rl288i8JhanHZMu6KyflTtslV0TC8q6sc3
	+nNO6r+wNnGxVkqC/hRoMrOHGocdsw41EzkpqWa0KGQQ3zn3cBP+zo7Ya88FkpA==
X-Received: by 2002:a17:906:7da:b0:a46:f564:ff80 with SMTP id m26-20020a17090607da00b00a46f564ff80mr1049394ejc.68.1710933796580;
        Wed, 20 Mar 2024 04:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT0EOe8PnERYg523sx6hptSmyO7kCDVHS3XFrgl/XwRmD2X+5W2dBiuHLjEgab/738ZCJ1QQ==
X-Received: by 2002:a17:906:7da:b0:a46:f564:ff80 with SMTP id m26-20020a17090607da00b00a46f564ff80mr1049378ejc.68.1710933796202;
        Wed, 20 Mar 2024 04:23:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b00a46f69a43a8sm565142ejr.184.2024.03.20.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:23:15 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:23:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Rong <w_angrong@163.com>
Cc: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <4tana2m46sjc6rkcrk7upy64v3tn7vrzploersngatmxf7b5mr@h5c3xmsa5xdd>
References: <20240320101912.28210-1-w_angrong@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240320101912.28210-1-w_angrong@163.com>

On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
>From: Rong Wang <w_angrong@163.com>
>
>Once enable iommu domain for one device, the MSI
>translation tables have to be there for software-managed MSI.
>Otherwise, platform with software-managed MSI without an
>irq bypass function, can not get a correct memory write event
>from pcie, will not get irqs.
>The solution is to obtain the MSI phy base address from
>iommu reserved region, and set it to iommu MSI cookie,
>then translation tables will be created while request irq.
>
>Change log
>----------
>
>v1->v2:
>- add resv iotlb to avoid overlap mapping.
>v2->v3:
>- there is no need to export the iommu symbol anymore.
>
>Signed-off-by: Rong Wang <w_angrong@163.com>
>---
> drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 56 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index ba52d128aeb7..28b56b10372b 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -49,6 +49,7 @@ struct vhost_vdpa {
> 	struct completion completion;
> 	struct vdpa_device *vdpa;
> 	struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
>+	struct vhost_iotlb resv_iotlb;
> 	struct device dev;
> 	struct cdev cdev;
> 	atomic_t opened;
>@@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
> static int vhost_vdpa_reset(struct vhost_vdpa *v)
> {
> 	v->in_batch = 0;
>+	vhost_iotlb_reset(&v->resv_iotlb);
> 	return _compat_vdpa_reset(v);
> }
>
>@@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> 	    msg->iova + msg->size - 1 > v->range.last)
> 		return -EINVAL;
>
>+	if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
>+					msg->iova + msg->size - 1))
>+		return -EINVAL;
>+
> 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
> 				    msg->iova + msg->size - 1))
> 		return -EEXIST;
>
>+

Unnecessary new line here.

> 	if (vdpa->use_va)
> 		return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
> 					 msg->uaddr, msg->perm);
>@@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
> 	return vhost_chr_write_iter(dev, from);
> }
>
>+static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
>+	struct vhost_iotlb *resv_iotlb)
>+{
>+	struct list_head dev_resv_regions;
>+	phys_addr_t resv_msi_base = 0;
>+	struct iommu_resv_region *region;
>+	int ret = 0;
>+	bool with_sw_msi = false;
>+	bool with_hw_msi = false;
>+
>+	INIT_LIST_HEAD(&dev_resv_regions);
>+	iommu_get_resv_regions(dma_dev, &dev_resv_regions);
>+
>+	list_for_each_entry(region, &dev_resv_regions, list) {
>+		ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
>+				region->start + region->length - 1,
>+				0, 0, NULL);
>+		if (ret) {
>+			vhost_iotlb_reset(resv_iotlb);
>+			break;
>+		}
>+
>+		if (region->type == IOMMU_RESV_MSI)
>+			with_hw_msi = true;
>+
>+		if (region->type == IOMMU_RESV_SW_MSI) {
>+			resv_msi_base = region->start;

Can it happen that there are multiple regions of the IOMMU_RESV_SW_MSI 
type?

In this case, is it correct to overwrite `resv_msi_base`?

>+			with_sw_msi = true;
>+		}
>+	}
>+
>+	if (!ret && !with_hw_msi && with_sw_msi)
>+		ret = iommu_get_msi_cookie(domain, resv_msi_base);

If `iommu_get_msi_cookie()` fails:
  - Should we avoid calling iommu_put_resv_regions()?
  - Should we also call `vhost_iotlb_reset(resv_iotlb)` like for the
    vhost_iotlb_add_range_ctx() failure ?

If it is the case, maybe it's better to add an error label where do the 
cleanup.

>+
>+	iommu_put_resv_regions(dma_dev, &dev_resv_regions);
>+
>+	return ret;
>+}
>+
> static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> {
> 	struct vdpa_device *vdpa = v->vdpa;
>@@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>
> 	ret = iommu_attach_device(v->domain, dma_dev);
> 	if (ret)
>-		goto err_attach;
>+		goto err_alloc_domain;
>
>-	return 0;
>+	ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
>+	if (ret)
>+		goto err_attach_device;
>
>-err_attach:
>+	return 0;

I suggest to add a new line here to separate the error path for the 
success path.

>+err_attach_device:
>+	iommu_detach_device(v->domain, dma_dev);
>+err_alloc_domain:
> 	iommu_domain_free(v->domain);
> 	v->domain = NULL;
> 	return ret;
>@@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> 		goto err;
> 	}
>
>+	vhost_iotlb_init(&v->resv_iotlb, 0, 0);
>+

IIUC the lifetime of v->resv_iotlb, we initialize it here in the 
vdpa_driver.probe() and we fill it during the `open` of the vhost-vdpa 
character device.

So, should we reset it in the `release` of the vhost-vdpa character 
device?

Thanks,
Stefano

> 	r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
> 	if (r)
> 		goto err;
>-- 
>2.27.0
>
>


