Return-Path: <linux-kernel+bounces-109711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262F881CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AF3283006
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885951C2C;
	Thu, 21 Mar 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HelO+Art"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2594B5CD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004414; cv=none; b=qTyJlnSETlmDGdjWzDsTcGtzJMuQzAuTm+7cs2fOIjrn75s3gD51cCtPYFn25HMAUu08VVc5XcYkHtFk/hgqcLfizgN4nMrJfjil/T6t6ztleb3CbK8G0MQ8APaX/o70jiQWLZpyOhSwu6z5rkWQBWEP2gF/qe38diR5D/PFdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004414; c=relaxed/simple;
	bh=/dV8kAVJvxVkeXgjEYhJAGh1uoB6v822Xd47BHn3D/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ2qrBHLptKb8NOFL5StH72QOJEl2uvTJ56SZQdkBL5YSWn7/973cZzXuizAXW9Ba009VQ7P6WPDwPVoxhYWjdJOT4HEZDDdRYy87HoIJiiX11Q3z8EkuWQO+0Ms6JVIAlcnhfXzYZvulRY+/9K+8IuTAdOyzwCJ3/ynW2tve6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HelO+Art; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711004406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiLMG91/ZYsAp3ADrbGjMnR5IlarlL2xIOgSgYVGlHg=;
	b=HelO+ArtYjQ5AJRTGWgwvsqf79UTtownl8S3GvlMUWNKDWC9z0q9m+poUH3nTePC7fVlP2
	b9cXjCjTdUAEB3fiFqdQCp6rqVp1+LbOu4OVJ69OBn8sZmqY2ES6ReVr0uKGRplQVuNrob
	JbmA9ktl+dddnabHmLfuAjAE5SyAXf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-MAKUW2JVN_uu_Wo4_aQWjQ-1; Thu, 21 Mar 2024 03:00:04 -0400
X-MC-Unique: MAKUW2JVN_uu_Wo4_aQWjQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140dd880b2so3477955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004403; x=1711609203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiLMG91/ZYsAp3ADrbGjMnR5IlarlL2xIOgSgYVGlHg=;
        b=J6HcwjRHja+UlZwhDZliyBeFp4j5/3GdiLqTtFygv3k852no4rULfDxWcyZTGWHGBJ
         bLNCjFBad9kxmmoZ2UZjRTfsCzc42r4KITerlIzmuRUMueKhhRscO5tROmnHOmKL1QZg
         PVhA4Yy9R7oDxr5lEbgQQF/o8gQ04B4QaHDi2Q50I4dmiCBUf2MeJq6nxrxw3LLoDK87
         ZpvhpAcCSYmX+sFH0UeRvI5oWyc+qdiPhFdN2Tmw2INF1vJClrywuMqRGRiZuH0GmYE9
         53zxrCYmWi6EO4+gXK6TwF04IlQizv6j2QBiScp2ENKML36TL2jTa3i27o3Bcow2DiTP
         /xkg==
X-Forwarded-Encrypted: i=1; AJvYcCUnIu5i9juCZaYT/4LajRw4ACe5aPXLx03fcjFpE2I8w/ePXQO9pMl1STaKNXo7+bGCRXupgix2G5y41E/B+mFrpNGDGeDcE4rIFls1
X-Gm-Message-State: AOJu0YzgKrZefecOWCiZtqbu3gUavSalj9bzwjJJ6/DY0HT9RRwCYUkA
	hwGZEqoEnR3LpldyDOzqH9C31LkkySIxe4hqxnyP/7+zwdRcuuEz9cmn5l8n1Mi19ou6JHvbGwE
	VTF9io4uWB+isFmTUuoHLRaF1oU7BX0yVKj6hFm6Qi3lK22Ys+sah4fe7pwVlCw==
X-Received: by 2002:a05:600c:1f85:b0:414:24b:2f4e with SMTP id je5-20020a05600c1f8500b00414024b2f4emr12227062wmb.39.1711004403604;
        Thu, 21 Mar 2024 00:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBxzRjBMdjM+R6C9qs+k6iwG//ttUvCtJ1CvTNjqyz/vKy9cl5mGuY64fq0U+xX2WN0gR1mg==
X-Received: by 2002:a05:600c:1f85:b0:414:24b:2f4e with SMTP id je5-20020a05600c1f8500b00414024b2f4emr12227040wmb.39.1711004403049;
        Thu, 21 Mar 2024 00:00:03 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id az23-20020adfe197000000b0033e9d9f891csm9791248wrb.58.2024.03.21.00.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:00:02 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:59:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wang Rong <w_angrong@163.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20240321025920-mutt-send-email-mst@kernel.org>
References: <20240320101912.28210-1-w_angrong@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320101912.28210-1-w_angrong@163.com>

On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> From: Rong Wang <w_angrong@163.com>
> 
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.
> 
> Change log
> ----------
> 
> v1->v2:
> - add resv iotlb to avoid overlap mapping.
> v2->v3:
> - there is no need to export the iommu symbol anymore.
> 
> Signed-off-by: Rong Wang <w_angrong@163.com>

There's in interest to keep extending vhost iotlb -
we should just switch over to iommufd which supports
this already.

> ---
>  drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ba52d128aeb7..28b56b10372b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -49,6 +49,7 @@ struct vhost_vdpa {
>  	struct completion completion;
>  	struct vdpa_device *vdpa;
>  	struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
> +	struct vhost_iotlb resv_iotlb;
>  	struct device dev;
>  	struct cdev cdev;
>  	atomic_t opened;
> @@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
>  static int vhost_vdpa_reset(struct vhost_vdpa *v)
>  {
>  	v->in_batch = 0;
> +	vhost_iotlb_reset(&v->resv_iotlb);
>  	return _compat_vdpa_reset(v);
>  }
>  
> @@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	    msg->iova + msg->size - 1 > v->range.last)
>  		return -EINVAL;
>  
> +	if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
> +					msg->iova + msg->size - 1))
> +		return -EINVAL;
> +
>  	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>  				    msg->iova + msg->size - 1))
>  		return -EEXIST;
>  
> +
>  	if (vdpa->use_va)
>  		return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
>  					 msg->uaddr, msg->perm);
> @@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
>  	return vhost_chr_write_iter(dev, from);
>  }
>  
> +static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
> +	struct vhost_iotlb *resv_iotlb)
> +{
> +	struct list_head dev_resv_regions;
> +	phys_addr_t resv_msi_base = 0;
> +	struct iommu_resv_region *region;
> +	int ret = 0;
> +	bool with_sw_msi = false;
> +	bool with_hw_msi = false;
> +
> +	INIT_LIST_HEAD(&dev_resv_regions);
> +	iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +	list_for_each_entry(region, &dev_resv_regions, list) {
> +		ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
> +				region->start + region->length - 1,
> +				0, 0, NULL);
> +		if (ret) {
> +			vhost_iotlb_reset(resv_iotlb);
> +			break;
> +		}
> +
> +		if (region->type == IOMMU_RESV_MSI)
> +			with_hw_msi = true;
> +
> +		if (region->type == IOMMU_RESV_SW_MSI) {
> +			resv_msi_base = region->start;
> +			with_sw_msi = true;
> +		}
> +	}
> +
> +	if (!ret && !with_hw_msi && with_sw_msi)
> +		ret = iommu_get_msi_cookie(domain, resv_msi_base);
> +
> +	iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> +
> +	return ret;
> +}
> +
>  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
> @@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  
>  	ret = iommu_attach_device(v->domain, dma_dev);
>  	if (ret)
> -		goto err_attach;
> +		goto err_alloc_domain;
>  
> -	return 0;
> +	ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
> +	if (ret)
> +		goto err_attach_device;
>  
> -err_attach:
> +	return 0;
> +err_attach_device:
> +	iommu_detach_device(v->domain, dma_dev);
> +err_alloc_domain:
>  	iommu_domain_free(v->domain);
>  	v->domain = NULL;
>  	return ret;
> @@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  		goto err;
>  	}
>  
> +	vhost_iotlb_init(&v->resv_iotlb, 0, 0);
> +
>  	r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
>  	if (r)
>  		goto err;
> -- 
> 2.27.0
> 


