Return-Path: <linux-kernel+bounces-54029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618184A96B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BF91F24B29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FF4F605;
	Mon,  5 Feb 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoiXAxuy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7B4D5BF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172587; cv=none; b=jw8t0RYwNlosp0mfl02zB3t0oV2nPO1Bs8BkC18N6vq4PQgv5udXY+yrp1k3oZwEaiuReEvAS0RPBJthAbzZ/wrgBekRvYKgryqHMWZGGA21y9agpQv45/o3QMzdIPwuooywWoenAWqLHLi9br7TlENl+OcVnXlVZG5Rmw7TTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172587; c=relaxed/simple;
	bh=EqQ9MenzjCrFTlHTtt0bcFYKQybhQjUuz9ueBRPlcMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6N9XMm6KZfzb2jRsPYB16/L1gIuURuTaAvpcse1xbURV6W6ClNbOWpT9AcUKdCbKgyobIXFLT8Qefq56kEE1yKu5uXA00PG/SmYT+61CahH8rnyF/mMB3p5qOThoz3DAvwu9TOUtNsBal4KGlocOODVyMQkFI0m0HjS9NnBfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoiXAxuy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707172584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5+sRNSSKmOzqMPOlpF55UvsCPipUMWShM7Hzevo2EA=;
	b=OoiXAxuykxMShsE3e9D5x5sOWc+psHYpogwN5D0TPmfWn/FXXz1S9NPLxhRCDqLXOdPJIg
	Sy+4Bf2XiF0N12nGENUBbnA/h0hIGSyBHUyzz+Njht7xijO/NXwXXpfaRe1ZSzlEM6Meax
	4egV1g7te1ATip/6zIaWWD8SzwS8BpY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-llLwqTcAM2SPfpEWebzrNA-1; Mon, 05 Feb 2024 17:36:23 -0500
X-MC-Unique: llLwqTcAM2SPfpEWebzrNA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfeae6a263so364284839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172582; x=1707777382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5+sRNSSKmOzqMPOlpF55UvsCPipUMWShM7Hzevo2EA=;
        b=myA1SbBprPbpN2K26ixkgaojmq/b+fkZg83uxpBoaOCx/DZ+aoxDg0SmLcOvB3IvyB
         undqTAwtc8D0NJNXtfeN3LMvFnivWlNWjzD8RxYMn0YJII284/vFG3wRj0M7g08XVvhj
         I298xudgAItJJy6xlEcJKv5Dc19Wj9JhvTdf5QCjRHyZpoc4c1R006nVjGGdjJaZoKLK
         8vPExCv4uDM5z5aPtvnIOAN2Qk1yAcL9QdD3X6fnupQnVxeXnzZ31FW1qFYOBsDrYy/V
         jfwFMJPr3bWxyGDPEeovq+V2aYNV7M8W1nfu1aMWP2n5O+yVs7R1zZ4eCM/ZvlJgNfrG
         eSNQ==
X-Gm-Message-State: AOJu0Yw4W1ZywHoBn+Yp/IUbU00QuiFXm5T0ApcbBVahwyCzpq6RE/77
	IIuRORU9ja5Ga9dyl4tCVjSRUZnlY8WknpTZQPHal4p/D4xFPKa2gH1zHZ1IC/OEpmamW8hSKPV
	muBypZOSmLR55xEyMaAkiY+3aEbBq43UcnJroG9MJMgaO1reI8coZvWiCUVUs+A==
X-Received: by 2002:a5d:9ed5:0:b0:7c3:eda5:f418 with SMTP id a21-20020a5d9ed5000000b007c3eda5f418mr344372ioe.14.1707172582321;
        Mon, 05 Feb 2024 14:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5U6k02BKkprA4o5OQRn+FJZMOQRMF0m1ybF8f+k4uAvd6hCGcrIjSdFZFC9usmZJWumiCCw==
X-Received: by 2002:a5d:9ed5:0:b0:7c3:eda5:f418 with SMTP id a21-20020a5d9ed5000000b007c3eda5f418mr344350ioe.14.1707172581994;
        Mon, 05 Feb 2024 14:36:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGvJ2rExnLiSMqoPJCwTunOmYd+ODfGHJNEKxV2xhiAP3Rj0ZWrTgIC0Vxq+hjhi6+dqSlFllpvMlFAehMa+dHTANDCY7RR7b6pz19AXvxwJKuBxWGM2A9eOW1GL8EhGqKk8MO5dCXmVdWB4gQsUKk57V3aYCg6PPfCdEEPbQy689ftwI8CuhvcwAuFRxg5ccnLfjvYzd3vmVBDRKs1I+txlkQtU6SnNQpEFX/mAjuoywyChrwRzx7ew7biFU1I0cN4OScrqJhoIl7V1GritLLoAQQAmEofTQbvjWXeeYinnIAawGLgZ6LMlE4hJB5deztemhV8A==
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 25-20020a0566380a5900b00471374f17a3sm190892jap.136.2024.02.05.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:36:20 -0800 (PST)
Date: Mon, 5 Feb 2024 15:35:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: jgg@nvidia.com, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 kvm@vger.kernel.org, dave.jiang@intel.com, ashok.raj@intel.com,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 15/17] vfio/pci: Let enable and disable of interrupt
 types use same signature
Message-ID: <20240205153542.0883e2ff.alex.williamson@redhat.com>
In-Reply-To: <bf87e46c249941ebbfacb20ee9ff92e8efd2a595.1706849424.git.reinette.chatre@intel.com>
References: <cover.1706849424.git.reinette.chatre@intel.com>
	<bf87e46c249941ebbfacb20ee9ff92e8efd2a595.1706849424.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 20:57:09 -0800
Reinette Chatre <reinette.chatre@intel.com> wrote:

> vfio_pci_set_intx_trigger() and vfio_pci_set_msi_trigger() have
> flows that can be shared.
> 
> For INTx, MSI, and MSI-X interrupt management to share the
> same enable/disable flow the interrupt specific enable and
> disable functions should have the same signatures.
> 
> Let vfio_intx_enable() and vfio_msi_enable() use the same
> parameters by passing "start" and "count" to these functions
> instead of letting the (what will eventually be) common code
> interpret these values.
> 
> Providing "start" and "count" to vfio_intx_enable()
> enables the INTx specific check of these parameters to move into
> the INTx specific vfio_intx_enable(). Similarly, providing "start"
> and "count" to vfio_msi_enable() enables the MSI/MSI-X specific
> code to initialize number of vectors needed.
> 
> The shared MSI/MSI-X code needs the interrupt index. Provide
> the interrupt index (clearly marked as unused) to the INTx code
> to use the same signatures.
> 
> With interrupt type specific code using the same parameters it
> is possible to have common code that calls the enable/disable
> code for different interrupt types.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 37065623d286..9217fea3f636 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -257,13 +257,18 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
> +static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
> +			    unsigned int start, unsigned int count,
> +			    unsigned int __always_unused index)
>  {
>  	struct vfio_pci_irq_ctx *ctx;
>  
>  	if (!is_irq_none(vdev))
>  		return -EINVAL;
>  
> +	if (start != 0 || count != 1)
> +		return -EINVAL;
> +
>  	if (!vdev->pdev->irq)
>  		return -ENODEV;
>  
> @@ -332,7 +337,8 @@ static char *vfio_intx_device_name(struct vfio_pci_core_device *vdev,
>  	return kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
>  }
>  
> -static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
> +static void vfio_intx_disable(struct vfio_pci_core_device *vdev,
> +			      unsigned int __always_unused index)
>  {
>  	struct vfio_pci_irq_ctx *ctx;
>  
> @@ -358,17 +364,20 @@ static irqreturn_t vfio_msihandler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int vfio_msi_enable(struct vfio_pci_core_device *vdev, int nvec,
> +static int vfio_msi_enable(struct vfio_pci_core_device *vdev,
> +			   unsigned int start, unsigned int count,
>  			   unsigned int index)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	unsigned int flag;
> -	int ret;
> +	int ret, nvec;
>  	u16 cmd;
>  
>  	if (!is_irq_none(vdev))
>  		return -EINVAL;
>  
> +	nvec = start + count;
> +
>  	flag = (index == VFIO_PCI_MSIX_IRQ_INDEX) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>  
>  	/* return the number of supported vectors if we can't get all: */
> @@ -701,11 +710,11 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
>  	unsigned int i;
>  
>  	if (is_intx(vdev) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
> -		vfio_intx_disable(vdev);
> +		vfio_intx_disable(vdev, index);
>  		return 0;
>  	}
>  
> -	if (!(is_intx(vdev) || is_irq_none(vdev)) || start != 0 || count != 1)
> +	if (!(is_intx(vdev) || is_irq_none(vdev)))
>  		return -EINVAL;
>  
>  	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
> @@ -715,13 +724,13 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
>  		if (is_intx(vdev))
>  			return vfio_irq_set_block(vdev, start, count, fds, index);
>  
> -		ret = vfio_intx_enable(vdev);
> +		ret = vfio_intx_enable(vdev, start, count, index);

Please trace what happens when a user calls SET_IRQS to setup a trigger
eventfd with start = 0, count = 1, followed by any other combination of
start and count values once is_intx() is true.  vfio_intx_enable()
cannot be the only place we bounds check the user, all of the INTx
callbacks should be an error or nop if vector != 0.  Thanks,

Alex

>  		if (ret)
>  			return ret;
>  
>  		ret = vfio_irq_set_block(vdev, start, count, fds, index);
>  		if (ret)
> -			vfio_intx_disable(vdev);
> +			vfio_intx_disable(vdev, index);
>  
>  		return ret;
>  	}
> @@ -771,7 +780,7 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>  			return vfio_irq_set_block(vdev, start, count,
>  						  fds, index);
>  
> -		ret = vfio_msi_enable(vdev, start + count, index);
> +		ret = vfio_msi_enable(vdev, start, count, index);
>  		if (ret)
>  			return ret;
>  


