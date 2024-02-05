Return-Path: <linux-kernel+bounces-54026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32C84A964
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C471F2B864
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF82487B8;
	Mon,  5 Feb 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuAUC08c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDC39FFA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172581; cv=none; b=u6xYo+rPC1ZBiSZi4S4+iRCxyQxxfmSuefg1SNtoFLEF/swgRsV9o7kqE3BP9B0182H7RtFwOeba9hxzaD9P1tWHVXJgzUqUAw4FNthIvMBM7XuR/sxrQVt41O9Tacl83dt/YmqMZvKn6GtetGFbpG+K89EjAqUdPY6HYB5gCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172581; c=relaxed/simple;
	bh=0Rc19taVqoEL+fr76M5uJ5PeU7EsyBOFPYCJBSWF/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7yafS+RiN47MxSc2ldsK9y6VcfW+GEcShJMifPoyK2C8jNaukhSk7EHINI3efYVin4Kcs0eEEPtB37cBZEhrnUi65V/mcPghTAV7sGgW/AZgkQxPPQ5+Mr2KvSckDOv1z+it68FLd1T0lYQ2gYhII9SgQ0LQrCsxazyb9s6HiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuAUC08c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707172578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCSfAOOryqV/bEU3iHiscXmU0TVYZm57g6s15luD5e8=;
	b=BuAUC08cGI/y2jM/xZQVrfQiQMR/3zR5EIIpjN1AfeNXmN5AFWGeMDIT/gzLRpXBhMaYaf
	Mu15PxbbNYyP3SNLRLiU129tkjGs2o1/Y2I+eKHZusawxTl/3m1JPMMcdbhZuKKHjqLbMK
	Df5SJoKY47gadBn0jABcq1tom+SXAU0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-g_B93yV7Ob2x1zkICfxtog-1; Mon, 05 Feb 2024 17:36:17 -0500
X-MC-Unique: g_B93yV7Ob2x1zkICfxtog-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363d169c770so951065ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172576; x=1707777376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCSfAOOryqV/bEU3iHiscXmU0TVYZm57g6s15luD5e8=;
        b=qt44xrmkYtp+VQ/gULEhuVgB+KBT7LpTW0LxSGuwWSJfpIQlu+HLzbePUyXsV8G387
         BNGCVD6NrQzk8hQOI6u0iV65nAbY0ZuoBuWH4rU9djpoz995dzAr68cu5j/gHqLWJ3oV
         VIhstFo2qZfjEVXbck1bDfYAxTqaKNo3P7gZubwyX14FreTbnyod+hcIOkfT/Zpg+HDP
         wVTqlmBJA+Oexzd+j3/YyfEbPOahQKCd0foZWlckD56DrJiGv6kMGRWGALPNqRFKvbl2
         fQauOISwZ6UVJ61j3DHsBYp9ydUjzHvjNDkKd9ru0Qjsty5clTPnTssth7sTI/68bG1X
         0z7w==
X-Gm-Message-State: AOJu0YxoCtpwk5iYlmQ5OUwxQPM+xDhy+tlIOMWe2RC9qRS0fSRE7fz0
	Git4P3dX6y27km4fwt1qi/oUs3oFpPHAobuRlXyVeg96vsmfbQCNQeQ59jNl7Wvk2xorwN7paRk
	7XFowVmsXCKzIDyDpK7UvY0HO6OVXJG6Bogab3Pl2DZwQHWfW1sbB9nEO9hB13Q==
X-Received: by 2002:a92:ca09:0:b0:363:b273:6188 with SMTP id j9-20020a92ca09000000b00363b2736188mr1379227ils.25.1707172576300;
        Mon, 05 Feb 2024 14:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDRJ2wRQ6mb9LEZNNTYnd1tdnaAf1CuV9tLvnE1o/wTrUFoVuyirIHmad02k23U5PyFHV8Dw==
X-Received: by 2002:a92:ca09:0:b0:363:b273:6188 with SMTP id j9-20020a92ca09000000b00363b2736188mr1379212ils.25.1707172576067;
        Mon, 05 Feb 2024 14:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0wysrCWOn6LzNDt65yaHZl424qlR5Qe1CSVEXNYRz9HNlnBc+A+wboQu8Xkz93glnsbnBDVUQh9IOP53QcRy7royM4vzABjKCjrmn4ouD/1LoOF+kEFNqB5AHToO56hw5Kdf+WQddJpeS6l9n9ejxGEO/xK1lmrCUj+EXBbfdGvqeLxYDZhngZYBVyb8EOLcYoYglskE3xx2XHKFxUQdi1S08K9zpKvfVs17T8/chhgO/PXYbEpzTZjfvgSF5T69zLXOxCw/zke2LEN4tilySNgRSHp9ICzSqwoE+U++ncc7IukscB5tgMuMYisTtS2laam12vg==
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 25-20020a0566380a5900b00471374f17a3sm190892jap.136.2024.02.05.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:36:15 -0800 (PST)
Date: Mon, 5 Feb 2024 15:35:26 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: jgg@nvidia.com, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 kvm@vger.kernel.org, dave.jiang@intel.com, ashok.raj@intel.com,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 12/17] vfio/pci: Remove msi term from generic code
Message-ID: <20240205153526.462e32b0.alex.williamson@redhat.com>
In-Reply-To: <0550572e64505df6ecff0b08f1eca869a79f6acf.1706849424.git.reinette.chatre@intel.com>
References: <cover.1706849424.git.reinette.chatre@intel.com>
	<0550572e64505df6ecff0b08f1eca869a79f6acf.1706849424.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 20:57:06 -0800
Reinette Chatre <reinette.chatre@intel.com> wrote:

> vfio_msi_set_vector_signal() and by extension vfio_msi_set_block()
> are no longer specific to MSI and MSI-X interrupts.
> 
> Change the name of these functions in preparation for them
> to be used for management of INTx interrupts.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 07dc388c4513..7f9dc81cb97f 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -557,7 +557,7 @@ static struct vfio_pci_intr_ops intr_ops[] = {
>  	},
>  };
>  
> -static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> +static int vfio_irq_set_vector_signal(struct vfio_pci_core_device *vdev,
>  				      unsigned int vector, int fd,
>  				      unsigned int index)
>  {
> @@ -617,7 +617,7 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> -static int vfio_msi_set_block(struct vfio_pci_core_device *vdev,
> +static int vfio_irq_set_block(struct vfio_pci_core_device *vdev,
>  			      unsigned int start, unsigned int count,
>  			      int32_t *fds, unsigned int index)
>  {
> @@ -626,12 +626,12 @@ static int vfio_msi_set_block(struct vfio_pci_core_device *vdev,
>  
>  	for (i = 0, j = start; i < count && !ret; i++, j++) {
>  		int fd = fds ? fds[i] : -1;
> -		ret = vfio_msi_set_vector_signal(vdev, j, fd, index);
> +		ret = vfio_irq_set_vector_signal(vdev, j, fd, index);
>  	}
>  
>  	if (ret) {
>  		for (i = start; i < j; i++)
> -			vfio_msi_set_vector_signal(vdev, i, -1, index);
> +			vfio_irq_set_vector_signal(vdev, i, -1, index);
>  	}
>  
>  	return ret;
> @@ -648,7 +648,7 @@ static void vfio_msi_disable(struct vfio_pci_core_device *vdev,
>  	xa_for_each(&vdev->ctx, i, ctx) {
>  		vfio_virqfd_disable(&ctx->unmask);
>  		vfio_virqfd_disable(&ctx->mask);
> -		vfio_msi_set_vector_signal(vdev, i, -1, index);
> +		vfio_irq_set_vector_signal(vdev, i, -1, index);
>  		vfio_irq_ctx_free(vdev, ctx, i);
>  	}
>  
> @@ -786,14 +786,14 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>  		int ret;
>  
>  		if (vdev->irq_type == index)

It's unfortunate that the one place in the code that doesn't use
irq_is() is the one that turns into the central callout function, maybe
we can fix it along the way.  Thanks,

Alex


> -			return vfio_msi_set_block(vdev, start, count,
> +			return vfio_irq_set_block(vdev, start, count,
>  						  fds, index);
>  
>  		ret = vfio_msi_enable(vdev, start + count, index);
>  		if (ret)
>  			return ret;
>  
> -		ret = vfio_msi_set_block(vdev, start, count, fds, index);
> +		ret = vfio_irq_set_block(vdev, start, count, fds, index);
>  		if (ret)
>  			vfio_msi_disable(vdev, index);
>  


