Return-Path: <linux-kernel+bounces-98590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26C877C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7111C20E74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376E14291;
	Mon, 11 Mar 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFNOEvD2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC12B9B0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148482; cv=none; b=FC6GxrgPzobg5N+ulPVjnl6R3KsrTZtxEikytQ6/yG6nfuqKmo4JfmUDekgx7CixDG7olr4nJs/px9VIg5OA/KfX+JpaXFzJLcrVHcugvHmvtiyafn9pmYNyvGbx+nooyjH6Oo2fTsjoWPJBkC8zhuUVmWATc+oKAMLfIBiNbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148482; c=relaxed/simple;
	bh=GKXb8uyTmcX+BoM9FWSbMbug4mOmav/ZtgYdiStOX8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUzW1aNeyrWRk5utW4dBZmM8XDMFZDlrgX6WT4z328sjYqhG2n4z5PnejpYR4OaM+LsXnigPBzLRadr7f5ScikBDw7Dg+BonPw/PcyU9mYg35MTdv2zfExmG70BjjJqXido0uloHCEF9YrXGoFDMfeSQbX5rDSJS0pdPnrl0mMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFNOEvD2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710148479;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTy099VqA5Yt0EUdnyLsR3RmVIsDYGIfwYRs4grpYk4=;
	b=PFNOEvD2JIsJEF7NFgfr/EAbedM3VL3l8hkpZBGXX5ofva1eMoWwYLySyk+0R8C0ryb+nq
	0V3QerDonp4oC8oc+IIsWQNgHyAdPI/tAvoPatlWi4AHEkqLR0vUxIXG0nL0ZPRHx/vvEG
	TK/VpAcndRTxnnpkIekfHeGVMFvdIpY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-7qR0KA1bNZyXNBDBRwcKVw-1; Mon, 11 Mar 2024 05:14:37 -0400
X-MC-Unique: 7qR0KA1bNZyXNBDBRwcKVw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412d1f1ee7cso20672985e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148476; x=1710753276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTy099VqA5Yt0EUdnyLsR3RmVIsDYGIfwYRs4grpYk4=;
        b=NVSQHksn1HII+hee8ghtvu1iXwueXhQlH/oUBJ3KbveCOmyYOvg9T7kTinztVbtduH
         5wzqQ1E/otCt5QJz25mJntFkv3wgS5Gw55RB0RgSR644MtGD/kD8itdEIbzS5HbaoAjp
         to5KM8Ob1h0AIAJ+du9lNQP5OcOv6LNPKLhtYJj64mIL6G5S1OqpPa+lbOw0//KDdT1D
         eW6B2fD9fQaD5tJf0L8MudMvM8ZNUcY1+hXPofiHZy12BkUqVQwsfBeB/6bm6TIge6mo
         6rGp1E+G9NmJiAtxyl8E8RrI2U5xBuQZPLW22vl5/i3HSPDlFaGTJ2Y9c+Fk8PU26L7X
         haaw==
X-Forwarded-Encrypted: i=1; AJvYcCUzA8/p5rPmtjH+TELs1Eb2JiqeGeFRFzvkT3D9J9BXHUlLVnww6fjKbTUeY88xDj1E+zVXVE20XZiJwuL5Va5cXQ6XBS+BcmxmNyKU
X-Gm-Message-State: AOJu0YzI9UNT/hSBB8p+fDYibGx/CgX3uCJmgKTzVxMAHPj8RrWOYNwM
	3nN/PDrBjf2jJLsWQWuNG8Jt5X9tc4SAmKlrGm7p4jSzo7ZP/mrsFKPGuAJOo18G4Xzh7GT0vRM
	qa12ggmxwQpm1MfApfA/VuW3wmkFzb1ESqsbFX4yLeNUb+yfaElDIgMte2gLG/A==
X-Received: by 2002:a05:600c:35c8:b0:412:f481:e38b with SMTP id r8-20020a05600c35c800b00412f481e38bmr4730520wmq.30.1710148475871;
        Mon, 11 Mar 2024 02:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHejfzMsvYA/m0zkMfBeSAVYajGwbqM2gdt7nx0CBADchCylS+VWyZ4B2x0VYvIdXoWqEfQvA==
X-Received: by 2002:a05:600c:35c8:b0:412:f481:e38b with SMTP id r8-20020a05600c35c800b00412f481e38bmr4730508wmq.30.1710148475553;
        Mon, 11 Mar 2024 02:14:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm14934328wmq.21.2024.03.11.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:14:34 -0700 (PDT)
Message-ID: <2e2ec36a-3d48-48f0-8019-f1c1b320a477@redhat.com>
Date: Mon, 11 Mar 2024 10:14:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 2/7] vfio/pci: Lock external INTx masking ops
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com, stable@vger.kernel.org
References: <20240308230557.805580-1-alex.williamson@redhat.com>
 <20240308230557.805580-3-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240308230557.805580-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/9/24 00:05, Alex Williamson wrote:
> Mask operations through config space changes to DisINTx may race INTx
> configuration changes via ioctl.  Create wrappers that add locking for
> paths outside of the core interrupt code.
>
> In particular, irq_type is updated holding igate, therefore testing
> is_intx() requires holding igate.  For example clearing DisINTx from
> config space can otherwise race changes of the interrupt configuration.
>
> This aligns interfaces which may trigger the INTx eventfd into two
> camps, one side serialized by igate and the other only enabled while
> INTx is configured.  A subsequent patch introduces synchronization for
> the latter flows.
>
> Cc: stable@vger.kernel.org
> Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 34 +++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 136101179fcb..75c85eec21b3 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -99,13 +99,15 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
>  }
>  
>  /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
> -bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> +static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_irq_ctx *ctx;
>  	unsigned long flags;
>  	bool masked_changed = false;
>  
> +	lockdep_assert_held(&vdev->igate);
> +
>  	spin_lock_irqsave(&vdev->irqlock, flags);
>  
>  	/*
> @@ -143,6 +145,17 @@ bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
>  	return masked_changed;
>  }
>  
> +bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> +{
> +	bool mask_changed;
> +
> +	mutex_lock(&vdev->igate);
> +	mask_changed = __vfio_pci_intx_mask(vdev);
> +	mutex_unlock(&vdev->igate);
> +
> +	return mask_changed;
> +}
> +
>  /*
>   * If this is triggered by an eventfd, we can't call eventfd_signal
>   * or else we'll deadlock on the eventfd wait queue.  Return >0 when
> @@ -194,12 +207,21 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
>  	return ret;
>  }
>  
> -void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
> +static void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
>  {
> +	lockdep_assert_held(&vdev->igate);
> +
>  	if (vfio_pci_intx_unmask_handler(vdev, NULL) > 0)
>  		vfio_send_intx_eventfd(vdev, NULL);
>  }
>  
> +void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
> +{
> +	mutex_lock(&vdev->igate);
> +	__vfio_pci_intx_unmask(vdev);
> +	mutex_unlock(&vdev->igate);
> +}
> +
>  static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
>  {
>  	struct vfio_pci_core_device *vdev = dev_id;
> @@ -563,11 +585,11 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_core_device *vdev,
>  		return -EINVAL;
>  
>  	if (flags & VFIO_IRQ_SET_DATA_NONE) {
> -		vfio_pci_intx_unmask(vdev);
> +		__vfio_pci_intx_unmask(vdev);
>  	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>  		uint8_t unmask = *(uint8_t *)data;
>  		if (unmask)
> -			vfio_pci_intx_unmask(vdev);
> +			__vfio_pci_intx_unmask(vdev);
>  	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
>  		struct vfio_pci_irq_ctx *ctx = vfio_irq_ctx_get(vdev, 0);
>  		int32_t fd = *(int32_t *)data;
> @@ -594,11 +616,11 @@ static int vfio_pci_set_intx_mask(struct vfio_pci_core_device *vdev,
>  		return -EINVAL;
>  
>  	if (flags & VFIO_IRQ_SET_DATA_NONE) {
> -		vfio_pci_intx_mask(vdev);
> +		__vfio_pci_intx_mask(vdev);
>  	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>  		uint8_t mask = *(uint8_t *)data;
>  		if (mask)
> -			vfio_pci_intx_mask(vdev);
> +			__vfio_pci_intx_mask(vdev);
>  	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
>  		return -ENOTTY; /* XXX implement me */
>  	}


