Return-Path: <linux-kernel+bounces-136564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B389D58F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ACF1C20CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61D8121F;
	Tue,  9 Apr 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnQM1oiJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB880639
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654800; cv=none; b=c9JhirDl2eyPvEKUZggMZ268aI1tXm1uGBvqa0uHLhtwaBdBisK4BfwimAgAf9bnZStEy3zRzkN7JMEvJWCp5lsvVH4aKsxdUWL2kXHiC/Zy06Xe/4dnjNKrZGTuMLiGklPMyeaydxSYfI4NoRixS4i/Qh1MV+op24Wme6ndkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654800; c=relaxed/simple;
	bh=2xK4JelW7xEC42tks8RDQapFm0yaTizZ83QN0+gxZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sucXajIV/DXGThhYdmXIUxjcEUAZ18rSVGw78cRPxZqqGMBaYZb5Mtp4bS4LP542ZR+ZlB2EC3lmloGSBEfosIw62FU0uJs/pkSw+OqZg4JDyosT+Ahwgd965aOK67GhRcAFYN/Ud+J5nAaC936uC5AmjoXgl+LVlpux6/mQ6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnQM1oiJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712654798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc//wax2hX4/BQY3oadYK76HM6tSGDChyGMX8cGz7Ug=;
	b=JnQM1oiJuTKD/malwf8GVqunBGZC6o21wPMW5rNbxDQq9dXJPSYwnEkybQSOGVXoNhoAjm
	ogJPKDNXTkzgYR3ZsEi46n2eubz2ONt1n5hNKESCnLYwnLJ9UeYhL79X65tfOi3MZESfXw
	l4XihnveRb/kkfxGMmA+v47m4GtMWus=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-GxrCfoa8NNSwhdUzn76IfQ-1; Tue, 09 Apr 2024 05:26:36 -0400
X-MC-Unique: GxrCfoa8NNSwhdUzn76IfQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b97efbb8so306220366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654794; x=1713259594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc//wax2hX4/BQY3oadYK76HM6tSGDChyGMX8cGz7Ug=;
        b=gFVLzITiD3B86I0DpyNVdc6TkaHguFkMNBbOL2lf8DK+XXuojR5V1E5WwAjWtAX+1U
         iATy6tjxfqAx7OpHHiAf8Jc8rZhCX71BQVOveeAJdGdAjH9O8u8GCCLrnJCfEtG3u+tW
         9SxaRg654rRlRB//VValKREeTp1uqH0/WktrL0ydgaOHbISAVi9fqvZV8YdvoqHX931o
         AmQatG8pqYObrminCIgajk6E1hvnZaMisQVWNlTi/8D7h/AHGnu0+Eu4WywddHZemgLy
         wV+IDSaM1Nf6vwznXc8Z9jbdnnj/3BzWYIsEgbg5tWHBN3hg1TuTphMem0gB52lYaWj+
         wUKw==
X-Forwarded-Encrypted: i=1; AJvYcCV3FxxtFFaR5q7wRQNNYq1cQ1+JqXvpI4Ks4mFWTvZ9/z0cFC9kLB/Tk8E1D2kKt7CsHLLMAIhr/xTZGcW4urNCCHmbgdzXEPHB2eoO
X-Gm-Message-State: AOJu0YxwlVMMkV4rDaF8nxfwGLAHFCm/mD4wKII8oI6Pwd69VJ5YjZu7
	RAxJgMumRuo/a174aocSPz/oWiHjlW3uNpuMZaWJiden/tEApBjuNYKNEtEgEbSHZIEH4Zrn9k4
	kqDe9b416BbkDDvhFBEIBBsr4UCplpSCUwS3Pu4b2WAS7u3zCHVldNsu2e1QVHQ==
X-Received: by 2002:a17:906:f207:b0:a4e:a2b3:f28d with SMTP id gt7-20020a170906f20700b00a4ea2b3f28dmr1525198ejb.13.1712654793744;
        Tue, 09 Apr 2024 02:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGylzl3k7uR2BGvGqDqmV6B58FOMhKonAbXh46IYEltes0FJ7UDZ9Uis61psvyp1qKlbn6Wqw==
X-Received: by 2002:a17:906:f207:b0:a4e:a2b3:f28d with SMTP id gt7-20020a170906f20700b00a4ea2b3f28dmr1525184ejb.13.1712654793136;
        Tue, 09 Apr 2024 02:26:33 -0700 (PDT)
Received: from redhat.com ([2.52.134.26])
        by smtp.gmail.com with ESMTPSA id xi1-20020a170906dac100b00a51d3785c7bsm2583857ejb.196.2024.04.09.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:26:32 -0700 (PDT)
Date: Tue, 9 Apr 2024 05:26:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vp_vdpa: don't allocate unused msix vectors
Message-ID: <20240409052233-mutt-send-email-mst@kernel.org>
References: <20240409013020-mutt-send-email-mst@kernel.org>
 <20240409085818.1242-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409085818.1242-1-yuxue.liu@jaguarmicro.com>

Good and clear subject, I like it.

On Tue, Apr 09, 2024 at 04:58:18PM +0800, lyx634449800 wrote:
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
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Much better, thanks!
A couple of small tweaks to polish it up and it'll be ready.

> ---
> V4: Update the title and assign values to uninitialized variables
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index df5f4a3bccb5..74bc8adfc7e8 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,7 +160,14 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>  	struct pci_dev *pdev = mdev->pci_dev;
>  	int i, ret, irq;
>  	int queues = vp_vdpa->queues;
> -	int vectors = queues + 1;
> +	int vectors = 0;
> +	int msix_vec = 0;
> +
> +	for (i = 0; i < queues; i++) {
> +		if (vp_vdpa->vring[i].cb.callback)
> +			vectors++;
> +	}
> +	vectors++;


Actually even easier: int vectors = 1; and then we do not need
this last line.
Sorry I only noticed now.

>  
>  	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>  	if (ret != vectors) {
> @@ -173,9 +180,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
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
> @@ -185,21 +195,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
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
> +			"vp_vdpa: fail to request irq for config, ret %d\n", ret);

As long as we are here let's fix the grammar, and there's no need to
say "ret":
			"vp_vdpa: failed to request irq for config: %d\n", ret);


>  			goto err;
>  	}
> -	vp_modern_config_vector(mdev, queues);
> +	vp_modern_config_vector(mdev, msix_vec);
>  	vp_vdpa->config_irq = irq;
>  
>  	return 0;
> -- 
> 2.43.0


