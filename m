Return-Path: <linux-kernel+bounces-54027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2ED84A966
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540F2292958
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A64CB47;
	Mon,  5 Feb 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5b/pDaj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C01EB49
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172583; cv=none; b=NAbPERsnzdjPz39xcz3jXATwRTy9Kv8ADl272wgLOS2wHWEBaD8ZL27ffQipprEfoSbZz/Dfa91fWThkx9V08ECJit6pJfoSJqChdtxqlq9u+3LJxLH8C5BQL2ycLlHjNdOiYtrW83ytTjY8suFiIf6ZP5W1lZbnMk4T48GExNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172583; c=relaxed/simple;
	bh=6JYagHXucKlYsOfkuiAxIPDNGFx7tF1xUhXMyUU4rMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0o1qUf/qEjRgXsgc3jF6k0MZF5IVDym3FtgkaGvKtXnlaMb+oR4Qc/AgtA8go2FDVBTVS5rW/hYMkrZoANXlNUQdgS+yRmcknq5zBj6WAIG8GF78dDv8w1p/x+T07yKSAVT48Uuhlx6VYvC8flKLerLkLzrGr3PIM6TyUUxEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5b/pDaj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707172580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCym5d923wld6vPREpAl+FehvI78rNNZCzX1noGHDH4=;
	b=T5b/pDaj3u79sja7Y3geLptd5llb1WF7WIiHP9pEY812vXW1YA+9ZjL/MwXY1HNVLVdfGs
	c7HzO2P9vmFXhEyhH1+qdEcD7NlvyZc1CZMIqkEYuzEu3NCOOvfxcKN34Ea57Z6I77UZTo
	hGwiEFnZoJnMTE4aezOplgjXw2dUpOg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-kZFrhZ_AND6CGxkFHUobXw-1; Mon, 05 Feb 2024 17:36:18 -0500
X-MC-Unique: kZFrhZ_AND6CGxkFHUobXw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c0257e507cso429544139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172578; x=1707777378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCym5d923wld6vPREpAl+FehvI78rNNZCzX1noGHDH4=;
        b=e01n/w6z60WFrwIiXezBwZLVFK3vNHGG0BR6tieX2oZMepc8060i1lICbtka9E3TPy
         PZRHrSnmZfMQbzOTdJSQql3wNgV2FZNr93+73ZSc2x5MOOFNZJee1QjYvSrKZlfhbLKU
         dhySSYHoLnwZdifuJQ/vADeFa7wawesdqEWOby7E2+Dxzm+PK0jjZtO3iLeGD3qj2Jit
         Win5M2qxCexuCbZTzFzLI7x8dXdo2jR4iIHJoWgaQjNmn4WhcPeum11t1nIlKWzz9CgP
         8sW5VcMNuTiVOkd0lVeQdMwZ/3Qn7jqjl1vlYIrAL6+SnJiSPOdEneLIhX4seGgLdNm8
         umgQ==
X-Gm-Message-State: AOJu0Yx7VUvd/tJjBJydkqFHU4aX8FZg/Lm/7HJPpLgqXG1AAYxeSL+I
	dwYyqp/uX2iqJtIVTpO7LvkC1X8ZFor50pdKSGtmLxgG46n6nHsBt0Xa4R+SGPhXxJWsnKfrIkN
	qrQ1IQJcMFZIsbeVpdcS8//f+nu7W1qAkXRS4PCyVpdyQMQY5GIkN+9gZ7hnDAA==
X-Received: by 2002:a6b:7f07:0:b0:7bf:43ad:21fd with SMTP id l7-20020a6b7f07000000b007bf43ad21fdmr1209909ioq.6.1707172578231;
        Mon, 05 Feb 2024 14:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsZIwpeJmX5wltmo8bIJUYiKJXCkn2m4BRBUWMIcpK2JxVH5ZBr29yltiYvtI9nmV8wwwaHg==
X-Received: by 2002:a6b:7f07:0:b0:7bf:43ad:21fd with SMTP id l7-20020a6b7f07000000b007bf43ad21fdmr1209897ioq.6.1707172577877;
        Mon, 05 Feb 2024 14:36:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU593A73UFQGGLvs1DwDL0axmGCz5389jvfk7tN7BWwlbTyBW8ilY+F92ulx9r3NWV6yKaRdLmwAVmAtQN1tcq+My42jjwkZxiKloCraJDJjo3vdb5s6SLcL8XC6HSO2a40y6YESYQ16qKd3Gufk6nDyZ2e91XAETsu9ZlTD2ddvKg2+gdlCi7W3HPbI6zODrvcmiLwS4ZpVH2NulBcESlh1ktBVpm7wxhmw7yc4vXsmgRJ1tzNuA5aSQNJ7r7wiwsx+D9+g7AmljP4S3fgbyQrtQjh4BU/H6zRGLKvte+bmWZJ5wxLFYV1ZKIBwsl64KSxaKwwgw==
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 25-20020a0566380a5900b00471374f17a3sm190892jap.136.2024.02.05.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:36:16 -0800 (PST)
Date: Mon, 5 Feb 2024 15:35:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: jgg@nvidia.com, yishaih@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
 kvm@vger.kernel.org, dave.jiang@intel.com, ashok.raj@intel.com,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 17/17] vfio/pci: Remove duplicate interrupt management
 flow
Message-ID: <20240205153551.429d9d76.alex.williamson@redhat.com>
In-Reply-To: <6ec901daffab4170d9740c7d066becd079925d53.1706849424.git.reinette.chatre@intel.com>
References: <cover.1706849424.git.reinette.chatre@intel.com>
	<6ec901daffab4170d9740c7d066becd079925d53.1706849424.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 20:57:11 -0800
Reinette Chatre <reinette.chatre@intel.com> wrote:

> vfio_pci_set_intx_trigger() and vfio_pci_set_trigger() have the
> same flow that calls interrupt type (INTx, MSI, MSI-X) specific
> functions.
> 
> Create callbacks for the interrupt type specific code that
> can be called by the shared code so that only one of these functions
> are needed. Rename the final generic function shared by all
> interrupt types vfio_pci_set_trigger().
> 
> Relocate the "IOCTL support" marker to correctly mark the
> now generic code.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 104 ++++++++++--------------------
>  1 file changed, 35 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index daa84a317f40..a5b337cfae60 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -32,6 +32,12 @@ struct vfio_pci_irq_ctx {
>  };
>  
>  struct vfio_pci_intr_ops {
> +	int (*enable)(struct vfio_pci_core_device *vdev, unsigned int start,
> +		      unsigned int count, unsigned int index);
> +	void (*disable)(struct vfio_pci_core_device *vdev,
> +			unsigned int index);
> +	void (*send_eventfd)(struct vfio_pci_core_device *vdev,
> +			     struct vfio_pci_irq_ctx *ctx);
>  	int (*request_interrupt)(struct vfio_pci_core_device *vdev,
>  				 struct vfio_pci_irq_ctx *ctx,
>  				 unsigned int vector, unsigned int index);
> @@ -356,6 +362,12 @@ static void vfio_intx_disable(struct vfio_pci_core_device *vdev,
>  /*
>   * MSI/MSI-X
>   */
> +static void vfio_send_msi_eventfd(struct vfio_pci_core_device *vdev,
> +				  struct vfio_pci_irq_ctx *ctx)
> +{
> +	eventfd_signal(ctx->trigger);
> +}
> +
>  static irqreturn_t vfio_msihandler(int irq, void *arg)
>  {
>  	struct eventfd_ctx *trigger = arg;
> @@ -544,13 +556,22 @@ static void vfio_msi_unregister_producer(struct vfio_pci_irq_ctx *ctx)
>  	irq_bypass_unregister_producer(&ctx->producer);
>  }
>  
> +/*
> + * IOCTL support
> + */
>  static struct vfio_pci_intr_ops intr_ops[] = {
>  	[VFIO_PCI_INTX_IRQ_INDEX] = {
> +		.enable = vfio_intx_enable,
> +		.disable = vfio_intx_disable,
> +		.send_eventfd = vfio_send_intx_eventfd_ctx,
>  		.request_interrupt = vfio_intx_request_interrupt,
>  		.free_interrupt = vfio_intx_free_interrupt,
>  		.device_name = vfio_intx_device_name,
>  	},
>  	[VFIO_PCI_MSI_IRQ_INDEX] = {
> +		.enable = vfio_msi_enable,
> +		.disable = vfio_msi_disable,
> +		.send_eventfd = vfio_send_msi_eventfd,
>  		.request_interrupt = vfio_msi_request_interrupt,
>  		.free_interrupt = vfio_msi_free_interrupt,
>  		.device_name = vfio_msi_device_name,
> @@ -558,6 +579,9 @@ static struct vfio_pci_intr_ops intr_ops[] = {
>  		.unregister_producer = vfio_msi_unregister_producer,
>  	},
>  	[VFIO_PCI_MSIX_IRQ_INDEX] = {
> +		.enable = vfio_msi_enable,
> +		.disable = vfio_msi_disable,
> +		.send_eventfd = vfio_send_msi_eventfd,
>  		.request_interrupt = vfio_msi_request_interrupt,
>  		.free_interrupt = vfio_msi_free_interrupt,
>  		.device_name = vfio_msi_device_name,
> @@ -646,9 +670,6 @@ static int vfio_irq_set_block(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> -/*
> - * IOCTL support
> - */
>  static int vfio_pci_set_intx_unmask(struct vfio_pci_core_device *vdev,
>  				    unsigned int index, unsigned int start,
>  				    unsigned int count, uint32_t flags,
> @@ -701,71 +722,16 @@ static int vfio_pci_set_intx_mask(struct vfio_pci_core_device *vdev,
>  	return 0;
>  }
>  
> -static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
> -				     unsigned int index, unsigned int start,
> -				     unsigned int count, uint32_t flags,
> -				     void *data)
> -{
> -	struct vfio_pci_irq_ctx *ctx;
> -	unsigned int i;
> -
> -	if (is_intx(vdev) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
> -		vfio_intx_disable(vdev, index);
> -		return 0;
> -	}
> -
> -	if (!(is_intx(vdev) || is_irq_none(vdev)))
> -		return -EINVAL;
> -
> -	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
> -		int32_t *fds = data;
> -		int ret;
> -
> -		if (is_intx(vdev))
> -			return vfio_irq_set_block(vdev, start, count, fds, index);
> -
> -		ret = vfio_intx_enable(vdev, start, count, index);
> -		if (ret)
> -			return ret;
> -
> -		ret = vfio_irq_set_block(vdev, start, count, fds, index);
> -		if (ret)
> -			vfio_intx_disable(vdev, index);
> -
> -		return ret;
> -	}
> -
> -	if (!is_intx(vdev))
> -		return -EINVAL;
> -
> -	/* temporary */
> -	for (i = start; i < start + count; i++) {
> -		ctx = vfio_irq_ctx_get(vdev, i);
> -		if (!ctx || !ctx->trigger)
> -			continue;
> -		if (flags & VFIO_IRQ_SET_DATA_NONE) {
> -			vfio_send_intx_eventfd_ctx(vdev, ctx);
> -		} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
> -			uint8_t *bools = data;
> -
> -			if (bools[i - start])
> -				vfio_send_intx_eventfd_ctx(vdev, ctx);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
> -				    unsigned int index, unsigned int start,
> -				    unsigned int count, uint32_t flags,
> -				    void *data)
> +static int vfio_pci_set_trigger(struct vfio_pci_core_device *vdev,
> +				unsigned int index, unsigned int start,
> +				unsigned int count, uint32_t flags,
> +				void *data)
>  {
>  	struct vfio_pci_irq_ctx *ctx;
>  	unsigned int i;
>  
>  	if (irq_is(vdev, index) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
> -		vfio_msi_disable(vdev, index);
> +		intr_ops[index].disable(vdev, index);
>  		return 0;
>  	}
>  
> @@ -780,13 +746,13 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>  			return vfio_irq_set_block(vdev, start, count,
>  						  fds, index);
>  
> -		ret = vfio_msi_enable(vdev, start, count, index);
> +		ret = intr_ops[index].enable(vdev, start, count, index);
>  		if (ret)
>  			return ret;
>  
>  		ret = vfio_irq_set_block(vdev, start, count, fds, index);
>  		if (ret)
> -			vfio_msi_disable(vdev, index);
> +			intr_ops[index].disable(vdev, index);
>  
>  		return ret;
>  	}
> @@ -799,11 +765,11 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
>  		if (!ctx || !ctx->trigger)
>  			continue;
>  		if (flags & VFIO_IRQ_SET_DATA_NONE) {
> -			eventfd_signal(ctx->trigger);
> +			intr_ops[index].send_eventfd(vdev, ctx);
>  		} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>  			uint8_t *bools = data;

Nit, an opportunity to add the missing new line between variable
declaration and code here.  Thanks,

Alex

>  			if (bools[i - start])
> -				eventfd_signal(ctx->trigger);
> +				intr_ops[index].send_eventfd(vdev, ctx);
>  		}
>  	}
>  	return 0;
> @@ -912,7 +878,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
>  			func = vfio_pci_set_intx_unmask;
>  			break;
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> -			func = vfio_pci_set_intx_trigger;
> +			func = vfio_pci_set_trigger;
>  			break;
>  		}
>  		break;
> @@ -924,7 +890,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
>  			/* XXX Need masking support exported */
>  			break;
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> -			func = vfio_pci_set_msi_trigger;
> +			func = vfio_pci_set_trigger;
>  			break;
>  		}
>  		break;


