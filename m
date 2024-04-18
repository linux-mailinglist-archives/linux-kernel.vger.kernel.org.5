Return-Path: <linux-kernel+bounces-149657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804638A941E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB111F21A95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EF6EB5A;
	Thu, 18 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8y0JHyH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C43D984
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425664; cv=none; b=VvMoC+y/5m6roYPJw1UI9clS/n208bZbiUWzJAG2WeXEmvGa+p4yp57RamzvrxNDPBOrr64kU4Rx31XU/KLMl7zEITdqADftiwLAp2jcSpxL1UJOYND4Xg7zOp3MqXFlnC8CNBpSRTGhdIb12BxNzRmtVZ0d345+aVi/4OOU5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425664; c=relaxed/simple;
	bh=LGSnJpHQQgKcur6GW4YmxJyXuKfv3XVmRlZs4XKGzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlLrVc+3qF4IyhVVKSRInXnFtpdIcP1jjYIdfFdZf1mphKlqar7bbKSEvW8XWXwaiJI9ULF4LnjEzN0QNX8TfWxeGZ8Q/5sePLpagO1kRz2XczeIfGNmoeKpvjnn4CCmX4ZkP+HzAqSg6HAlHboksoVj0dy5DJbrfiG8oew5hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8y0JHyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713425661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydywqdvl5tGhn3V8ZvUI2ohm8v6gM+3x5JsmuXE5oQo=;
	b=F8y0JHyHmTktEmvsEcK7p4ru8w+OFVNuK8VcZBuCR+qfCfSxpH4KQ9RypK9uTG1Y24fPQ2
	LUTqU+StRGDKghvb2/7llVBffbvrppjnqHHrim/AGhjMkobh+lP4TSCG/XZVFan4eh4qCY
	jNTOlw19INMR/14hzMKNfbrN6yiwAzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-CpkWlOJNNB-_fK6TPVGeNg-1; Thu, 18 Apr 2024 03:34:19 -0400
X-MC-Unique: CpkWlOJNNB-_fK6TPVGeNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4183d08093bso3168115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425658; x=1714030458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydywqdvl5tGhn3V8ZvUI2ohm8v6gM+3x5JsmuXE5oQo=;
        b=e0U1Jv7qiYJWKLnj+6P6sHpsRUEweEgMKaCk2J3CyPjRa/LrVLDMjmh3zap4PpbwmX
         Z2y5XBUPYRt266ztlNJ7OHpi5qc5XBpZuHFOWP0o4tv3HILCqVrXMmUkTee9FnyhzwhT
         LGwAg+oTvN03fa11Xg92imlVYewlLttd67CjiaBbKPraKnVfowgvYOtZQoQGOqvP0X8V
         mdp1IokJGgfUEOyQBBrVlv9Q3dnWv6snH/ikEhuJLvYGN0wWpC7jfbw27m5vfipgNxR4
         qv8u/K1ARovmllK9sjyGKCFI3HbFfET3U+LsPFB7Hk8/zy982ldXO9LcDbVIjU4j4f+k
         HCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNtw+4y3iDdpah+G8wMu/UdHx7OVTboC72zy0MlfnF1Kfe9qAagPii1iHmGjCwf3oL5A/9nCu7gdnr+Qkxh3BPVPIUppyxMHqpNvUb
X-Gm-Message-State: AOJu0Yw+lSoO1q5Y0TwesMP40UiAbOf2uN1e1Xe+YMwFI3XNlp3BXTlE
	SSUFxUU3Gk5fvEw5by207UwW+uMGp3Hh/ARpO4cQrJIZ8Z6nNlxF11hbjYZgt1LgRfVVTnhUheX
	U4JgK5zvXVY0oi1cBBWizjtSVOrkJyXdz6Qm4Yop8cVKznVhxKfs7KsqSQTdGFg==
X-Received: by 2002:a05:600c:3111:b0:418:e561:d0b5 with SMTP id g17-20020a05600c311100b00418e561d0b5mr720671wmo.37.1713425657698;
        Thu, 18 Apr 2024 00:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvhWHg0a0NuVWZRqdc4rSWNDjVnJcCbbmdis1E8SLdKf95AgXARxMzDAd6QhFNcqERmy+EJQ==
X-Received: by 2002:a05:600c:3111:b0:418:e561:d0b5 with SMTP id g17-20020a05600c311100b00418e561d0b5mr720650wmo.37.1713425657100;
        Thu, 18 Apr 2024 00:34:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm1654720wmb.44.2024.04.18.00.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:34:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:34:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: David Stevens <stevensd@chromium.org>, Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] virtio: Add support for the virtio suspend feature
Message-ID: <20240418033313-mutt-send-email-mst@kernel.org>
References: <20240417085440.4036535-1-stevensd@chromium.org>
 <20240417085440.4036535-2-stevensd@chromium.org>
 <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>

On Thu, Apr 18, 2024 at 03:14:37PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 4/17/2024 4:54 PM, David Stevens wrote:
> > Add support for the VIRTIO_F_SUSPEND feature. When this feature is
> > negotiated, power management can use it to suspend virtio devices
> > instead of resorting to resetting the devices entirely.
> > 
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
> >   drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
> >   drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
> >   include/linux/virtio.h             |  2 ++
> >   include/uapi/linux/virtio_config.h | 10 +++++++++-
> >   5 files changed, 74 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index f4080692b351..cd11495a5098 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   #include <linux/virtio.h>
> > +#include <linux/delay.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/virtio_config.h>
> >   #include <linux/virtio_anchor.h>
> > @@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(virtio_device_restore);
> > +
> > +static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
> > +{
> > +	u8 status, target;
> > +
> > +	status = dev->config->get_status(dev);
> > +	if (enabled)
> > +		target = status | VIRTIO_CONFIG_S_SUSPEND;
> > +	else
> > +		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
> > +	dev->config->set_status(dev, target);
> I think it is better to verify whether the device SUSPEND bit is
> already set or clear, we can just return if status == target.
> 
> Thanks
> Zhu Lingshan
> > +
> > +	while ((status = dev->config->get_status(dev)) != target) {
> > +		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
> > +			return -EIO;
> > +		mdelay(10);

Bad device state (set by surprise removal) should also
be handled here I think.


> > +	}
> > +	return 0;
> > +}
> > +
> > +int virtio_device_suspend(struct virtio_device *dev)
> > +{
> > +	return virtio_device_set_suspend_bit(dev, true);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> > +
> > +int virtio_device_resume(struct virtio_device *dev)
> > +{
> > +	return virtio_device_set_suspend_bit(dev, false);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_resume);
> >   #endif
> >   static int virtio_init(void)
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b655fccaf773..4d542de05970 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
> >   	return virtio_device_restore(&vp_dev->vdev);
> >   }
> > -static bool vp_supports_pm_no_reset(struct device *dev)
> > +static int virtio_pci_suspend(struct device *dev)
> >   {
> >   	struct pci_dev *pci_dev = to_pci_dev(dev);
> > -	u16 pmcsr;
> > -
> > -	if (!pci_dev->pm_cap)
> > -		return false;
> > -
> > -	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > -		dev_err(dev, "Unable to query pmcsr");
> > -		return false;
> > -	}
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > -	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > -}
> > +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> > +		return virtio_device_suspend(&vp_dev->vdev);
> > -static int virtio_pci_suspend(struct device *dev)
> > -{
> > -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > +	return virtio_pci_freeze(dev);
> >   }
> >   static int virtio_pci_resume(struct device *dev)
> >   {
> > -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > +
> > +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> > +		return virtio_device_resume(&vp_dev->vdev);
> > +
> > +	return virtio_pci_restore(dev);
> >   }
> >   static const struct dev_pm_ops virtio_pci_pm_ops = {
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index f62b530aa3b5..ac8734526b8d 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
> >   	__virtqueue_break(admin_vq->info.vq);
> >   }
> > +static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
> > +{
> > +	u16 pmcsr;
> > +
> > +	if (!pci_dev->pm_cap)
> > +		return false;
> > +
> > +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > +		dev_err(&pci_dev->dev, "Unable to query pmcsr");
> > +		return false;
> > +	}
> > +
> > +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > +}
> > +
> >   static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >   {
> >   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > @@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >   	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
> >   		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> > +
> > +	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
> > +		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
> >   }
> >   static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b0201747a263..8e456b04114e 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
> >   #ifdef CONFIG_PM_SLEEP
> >   int virtio_device_freeze(struct virtio_device *dev);
> >   int virtio_device_restore(struct virtio_device *dev);
> > +int virtio_device_suspend(struct virtio_device *dev);
> > +int virtio_device_resume(struct virtio_device *dev);
> >   #endif
> >   void virtio_reset_device(struct virtio_device *dev);
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 2445f365bce7..4a6e2c28ea76 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -40,6 +40,8 @@
> >   #define VIRTIO_CONFIG_S_DRIVER_OK	4
> >   /* Driver has finished configuring features */
> >   #define VIRTIO_CONFIG_S_FEATURES_OK	8
> > +/* Driver has suspended the device */
> > +#define VIRTIO_CONFIG_S_SUSPEND		0x10
> >   /* Device entered invalid state, driver must reset it */
> >   #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
> >   /* We've given up on this device. */
> > @@ -52,7 +54,7 @@
> >    * rest are per-device feature bits.
> >    */
> >   #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		42
> > +#define VIRTIO_TRANSPORT_F_END		43
> >   #ifndef VIRTIO_CONFIG_NO_LEGACY
> >   /* Do we get callbacks when the ring is completely used, even if we've
> > @@ -120,4 +122,10 @@
> >    */
> >   #define VIRTIO_F_ADMIN_VQ		41
> > +/*
> > + * This feature indicates that the driver can suspend the device via the
> > + * suspend bit in the device status byte.
> > + */
> > +#define VIRTIO_F_SUSPEND		42
> > +
> >   #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */


