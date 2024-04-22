Return-Path: <linux-kernel+bounces-153320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2298D8ACC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6A31F220B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79252146D5F;
	Mon, 22 Apr 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh8ke4+6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434F146D61
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787723; cv=none; b=JDkW5LqS7lLOebXDtMYfkh+S/rrRcAYXFclSCUAdg+0USR7Luql2o82YbBNU4W7dS8r6ijQs7HPcnd3aXvwlUVaVfio78BW6YMMJtIyH+o0yqH6eqZOZCcmly8jm9c/UASx+KEFUe6qW/QmM4zxpuBP3zhV8P2PcF+K7DyA7vF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787723; c=relaxed/simple;
	bh=my+P67LFzQSKQvstytruFE1AYZFQMHNKysY/jRMRvdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTDiKUxooEgn34mNH9nKaRMGmMODxrQ7JyjgnCclc1HveMBxbQA4Wiir7EShBBAJnEGp+qoN8qFi4QEbPJB+ulwQvDB4socayneBhpo09BqGJE3iLK2bPw1fGe7S7svmYIzseBE9AQrdBKF4Jc/5OD66kcJUWKYQzCso18AtVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh8ke4+6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713787721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kOf0Ccw9EW1YPuXrZV1wz4F+Kl3dauR1DbyA65i60M=;
	b=Fh8ke4+6Hn2bpuYoZBRsCPJfer1cm3ABWQgITi+ve7W75kxBjCR3attnNc7y7TFjvsEFa/
	b2+AV78MFUk7JMg2ude+1FVrytZuOlSe/hpT89/VNvcm7Mg56SxDJRlpnQGZV81d/Ixyhu
	PkycVYMqRIpU245MomP6VwvGYYrnT+k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-blq_O8e0NIOtboKCzUcHVQ-1; Mon, 22 Apr 2024 08:08:39 -0400
X-MC-Unique: blq_O8e0NIOtboKCzUcHVQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c83064821dso599984b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787719; x=1714392519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kOf0Ccw9EW1YPuXrZV1wz4F+Kl3dauR1DbyA65i60M=;
        b=rQpKx7NoqnQyHhfecD481DreEntvtxRSUPv+xSRLS59ha3bLcNWNIpkSUQfqe0Qx25
         xwENJ9wMnQLkflTM+8iBc/5b3I9O81b9yn213F+ErbiAkNtnTNx1Ppsw43LhEsux7+K1
         kj+AC8AJuqHoD4+kfQABm/h4LmQMrSdclCzsY9LZ20hHtb8ym1UnNk7+L/PYwVKoULPM
         esyb8NgCJj52tDPIKJeg9maHCRhFM/TxF1keEZ0F1m9sEri0kijV0Q2MYetAH5LrpGB7
         rxf5P+VAnTBY/4uR36QuNJWFzNPkRTQGP6n6sxGWg3XvIjFxVXbAyZyT/4dw0QiiOkTa
         EgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHP8KQ64W7sjAfBsifwoSLoiLBowIS3MjQucbMQs+k+t3oztDlPrcPuowye6HczG5l96JumFbVhyHbjBzxMkR7rrRj4u8nIK7Hmc3
X-Gm-Message-State: AOJu0YzlG/hwibVEBBNy/viXdM59dXPQAiPaCZSnw1jnA4L3Arjvtc9N
	wWjwC+yHFS2Z86lvPn7OXyvdFfiDLVIFl0EL2PAgGZJ2AbVWG42Icpo+cnUPgoxYEKEjai4JaDQ
	VeBm9t1MXqoZVOLYvcKNbtA/tcTh5YfSx8QKD/j+ZeD2pRQzfIKV3DbhfYlxhuQ==
X-Received: by 2002:aca:2210:0:b0:3c7:443f:1ae7 with SMTP id b16-20020aca2210000000b003c7443f1ae7mr9597661oic.58.1713787718662;
        Mon, 22 Apr 2024 05:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gCDRlrbhQbqvB0C+CF6O/3Btd8kPG9ni9Vxg0Rzo5XITY6GWOxgO3ytISR3UPYyrxLEhkg==
X-Received: by 2002:aca:2210:0:b0:3c7:443f:1ae7 with SMTP id b16-20020aca2210000000b003c7443f1ae7mr9597629oic.58.1713787718051;
        Mon, 22 Apr 2024 05:08:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm4182387qtb.65.2024.04.22.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:08:37 -0700 (PDT)
Date: Mon, 22 Apr 2024 08:08:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	linux-kernel@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
Message-ID: <20240422080729-mutt-send-email-mst@kernel.org>
References: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
 <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>

On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware msi or msix resources as well as system
> IRQ resources.
> 
> When conducting performance testing using testpmd in the
> guest os, it was found that the performance was lower compared
> to directly using vfio-pci to passthrough the device
> 
> In scenarios where the virtio device in the guest os does
> not utilize interrupts, the vdpa driver still configures
> the hardware's msix vector. Therefore, the hardware still
> sends interrupts to the host os.

I just have a question on this part. How come hardware
sends interrupts does not guest driver disable them?

> Because of this unnecessary
> action by the hardware, hardware performance decreases, and
> it also affects the performance of the host os.
> 
> Before modification:(interrupt mode)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> 
> After modification:(interrupt mode)
>  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
>  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
>  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
> 
> Before modification:(virtio pmd mode for guest os)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> 
> After modification:(virtio pmd mode for guest os)
>  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
> 
> To verify the use of the virtio PMD mode in the guest operating
> system, the following patch needs to be applied to QEMU:
> https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.com
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> V5: modify the description of the printout when an exception occurs
> V4: update the title and assign values to uninitialized variables
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index df5f4a3bccb5..8de0224e9ec2 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	struct pci_dev *pdev = mdev->pci_dev;
>  	int i, ret, irq;
>  	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int vectors = 1;
> +	int msix_vec = 0;
> +
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback)
> +			vectors++;
> +	}
>  
>  	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>  	if (ret != vectors) {
> @@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	vp_vdpa->vectors = vectors;
>  
>  	for (i = 0; i < queues; i++) {
> +		if (!vp_vdpa->vring[i].cb.callback)
> +			continue;
> +
>  		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>  			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -		irq = pci_irq_vector(pdev, i);
> +		irq = pci_irq_vector(pdev, msix_vec);
>  		ret = devm_request_irq(&pdev->dev, irq,
>  				       vp_vdpa_vq_handler,
>  				       0, vp_vdpa->vring[i].msix_name,
> @@ -185,21 +194,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  				"vp_vdpa: fail to request irq for vq %d\n", i);
>  			goto err;
>  		}
> -		vp_modern_queue_vector(mdev, i, i);
> +		vp_modern_queue_vector(mdev, i, msix_vec);
>  		vp_vdpa->vring[i].irq = irq;
> +		msix_vec++;
>  	}
>  
>  	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
>  		 pci_name(pdev));
> -	irq = pci_irq_vector(pdev, queues);
> +	irq = pci_irq_vector(pdev, msix_vec);
>  	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>  			       vp_vdpa->msix_name, vp_vdpa);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> -			"vp_vdpa: fail to request irq for vq %d\n", i);
> +			"vp_vdpa: fail to request irq for config: %d\n", ret);
>  			goto err;
>  	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>  	vp_vdpa->config_irq = irq;
>  
>  	return 0;
> -- 
> 2.43.0


