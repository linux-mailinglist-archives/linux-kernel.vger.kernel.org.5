Return-Path: <linux-kernel+bounces-136261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D889D209
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A351C23DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7621773A;
	Tue,  9 Apr 2024 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw7orvO7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FD138E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712641247; cv=none; b=nrvowHUBLXhh2rmpoFIDO0oeL0fkhkY/VJ4hMCqecD1MQkG9rk52h2P3QVil525aYOd4wwzCSjuah/AkAAFSgRpnmw28kDImb1zUl4wC6nvOa6dLk5x+akao3ALK0iDyxbfcmhX20+2CiYymOXb8/pxJafVyz3l4OpzDAG3oiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712641247; c=relaxed/simple;
	bh=cKx/XEApGcdgkkBoYHguipdiISKD6oH161Z5fFjIQ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlsYdllXmQ+bBcJds6n048PSuU3+EfhbovvIuXwZZ2nIIlM5ykEg3dcUZmh73aEQIAccaFuhICs6dPYcjuT20zlXo+MUUT9rp9Ky0511/0EJQndEvyIFRg8aI0O2k4XPh4YsunGclCHssz9rVuS4AnNoBdGc7GDyNCUwG3HjKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw7orvO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712641244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP+SQe4NJzDMBR5/uL7vUmv1IMo2/chbDROQYoC6bdg=;
	b=gw7orvO7iYgFjY77mnB4wSJnkoXIyHayRVfwc/K8hWdqG9yPo2jh1Cq0mxdA854tCT8VfE
	A+fsRzkcAl8WO/qR4X9D8wDcqTNSXXwvqPj9MXNVymANonpj+mRjSocSia+NOZkabTjMp0
	OxoXB1mrpp+wddyvz2f+tdFnAsTW2G8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-xY3OOtl-PwGcCQy6nKLGyw-1; Tue, 09 Apr 2024 01:40:42 -0400
X-MC-Unique: xY3OOtl-PwGcCQy6nKLGyw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c94d98afso49095491fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 22:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712641241; x=1713246041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP+SQe4NJzDMBR5/uL7vUmv1IMo2/chbDROQYoC6bdg=;
        b=NGLt1Zc5AxVg9TtytG0751s7tadWWaPzQNzlvBVbrhrsGSKkZFo3el3I/2roifhqhg
         wQlz1WgEH+IC728wPmz9/iNLaVn4J/wykCueXIvDeewpD3S52ykq8N/0f77FkEqhhkq5
         0OkJZDjLFKx4vvVu88lOfXcvTQU1j/jxv89svz/HDCSlCqhk5yNy8soqLCUa5p+Hx76T
         bfmdVpeOJD59dWjbBCttURvjQbw1hdXYuHTebtm9aKcWA9iPJspawTjqyjBRifZIh+u/
         AIdHSXsrOcD6Vj6BRXVRzNSUJ/tAkxsiyd9EuRJVaxafqjNemIiayb6YRNNcigqyP8xi
         il1g==
X-Forwarded-Encrypted: i=1; AJvYcCVMFRQlzBtDOiZox1MQLmjxSV7vtPL72yFMnAqcX6cXRu3FL0RxRxay2kLEAcSWXM0PyNnJQ9ZGlSC5dTfH4sElozr/33yIuqHeWDxs
X-Gm-Message-State: AOJu0Yw+FCIxc31mHzoBr4yGi1Vkc5pRAJHZYkkRC2VEhRMlfLqUyIcN
	JRgVjC8L8oad5PRu3bZG3gzOnjFPMqCmPO4mt4UtRXX+zTsG/GhcBYvzQHjRVNTLm+DUaeX6tPP
	wQx2HOjyjzL0zby2heJ9x4PBdzVpyBVE/FcadBw4ma7FAA2WO+K9nInU2cZrjNw==
X-Received: by 2002:a2e:9f0c:0:b0:2d4:3d86:54e2 with SMTP id u12-20020a2e9f0c000000b002d43d8654e2mr6914066ljk.27.1712641240911;
        Mon, 08 Apr 2024 22:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+qn0i6whv8AwTjlwkCerpWrTLCi6WhpXkJ62FFmQBBsOuWv8O1bHDdwijM/xD7mQUbvhuFA==
X-Received: by 2002:a2e:9f0c:0:b0:2d4:3d86:54e2 with SMTP id u12-20020a2e9f0c000000b002d43d8654e2mr6914058ljk.27.1712641240359;
        Mon, 08 Apr 2024 22:40:40 -0700 (PDT)
Received: from redhat.com ([2.52.134.26])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b00343daeddcb2sm10614463wrs.45.2024.04.08.22.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 22:40:39 -0700 (PDT)
Date: Tue, 9 Apr 2024 01:40:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vp_vdpa: fix the method of calculating vectors
Message-ID: <20240409013020-mutt-send-email-mst@kernel.org>
References: <20240408035346-mutt-send-email-mst@kernel.org>
 <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409014935.944-1-yuxue.liu@jaguarmicro.com>

better subject:

 vp_vdpa: don't allocate unused msix vectors

to make it clear it's not a bugfix.




more comments below, but most importantly this
looks like it adds a bug.

On Tue, Apr 09, 2024 at 09:49:35AM +0800, lyx634449800 wrote:
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
> sends interrupts to the host os. Because of this unnecessary
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
> Signed-off-by: lyx634449800 <yuxue.liu@jaguarmicro.com>


Bad S.O.B format. Should be

Signed-off-by: Real Name <email>


> ---
> 
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 +++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index df5f4a3bccb5..cd3aeb3b8f21 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,22 +160,31 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	struct pci_dev *pdev = mdev->pci_dev;
>  	int i, ret, irq;
>  	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int msix_vec, allocated_vectors = 0;


I would actually call allocated_vectors -> vectors, make the patch
smaller.

>  
> -	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> -	if (ret != vectors) {
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback)
> +			allocated_vectors++;
> +	}
> +	allocated_vectors = allocated_vectors + 1;

better: 
	allocated_vectors++; /* extra one for config */

> +
> +	ret = pci_alloc_irq_vectors(pdev, allocated_vectors, allocated_vectors,
> +								PCI_IRQ_MSIX);
> +	if (ret != allocated_vectors) {
>  		dev_err(&pdev->dev,
>  			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
> -			vectors, ret);
> +			allocated_vectors, ret);
>  		return ret;
>  	}
> -
> -	vp_vdpa->vectors = vectors;
> +	vp_vdpa->vectors = allocated_vectors;
>  
>  	for (i = 0; i < queues; i++) {
> +		if (!vp_vdpa->vring[i].cb.callback)
> +			continue;
> +
>  		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>  			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -		irq = pci_irq_vector(pdev, i);
> +		irq = pci_irq_vector(pdev, msix_vec);

using uninitialized msix_vec here?

I would expect compiler to warn about it.


pay attention to compiler warnings pls.


>  		ret = devm_request_irq(&pdev->dev, irq,
>  				       vp_vdpa_vq_handler,
>  				       0, vp_vdpa->vring[i].msix_name,
> @@ -185,23 +194,23 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
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
> -		 pci_name(pdev));
> -	irq = pci_irq_vector(pdev, queues);
> +			pci_name(pdev));


don't move pci_name - don't make unrelated code changes.

> +	irq = pci_irq_vector(pdev, msix_vec);
>  	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>  			       vp_vdpa->msix_name, vp_vdpa);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> -			"vp_vdpa: fail to request irq for vq %d\n", i);
> +			"vp_vdpa: fail to request irq for config\n");

I would report ret here too.

>  			goto err;
>  	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>  	vp_vdpa->config_irq = irq;
> -

don't make unrelated code changes.


>  	return 0;
>  err:
>  	vp_vdpa_free_irq(vp_vdpa);
> -- 
> 2.43.0


