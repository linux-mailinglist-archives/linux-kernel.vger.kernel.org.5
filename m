Return-Path: <linux-kernel+bounces-149637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6E8A93CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA22F282346
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E823B1AE;
	Thu, 18 Apr 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJosTpqk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8342D057
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424486; cv=none; b=KBUriiK9lV3zpdyu2qi7RS1WPnaiY3sBkKrNWCs0pcgjkYfpGK6uwimZpTNZrQ9kk0mcPGqdl2gfsLd9i95+d2WAijZ6J6z3h7fuyMytYcwSRmKsWrASwmdyP3xSxdG/12mWqVUJkeV+Sw0v12UDCYZryENVyNMuwmPlnfnHLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424486; c=relaxed/simple;
	bh=cbIMRI+x+AE/hoz/da/ZJt9M4223DOG5M56T+jFdBnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVDvI4JqC3+N97Bn7HZzRQ+eseOHLAxtFW7Z7rEsMZ6xO2c6dm47JjwkqkpE1+be5HIe5ut8T4lVn+hz6EclJkECyBU4GMo5YUoh/vXMS6Tk5xrQujA47wmhPJ5mLvuAFe/uRBCE0EMgAVZrDWfBF1K6CV+fBnEscRqUeYPIRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJosTpqk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713424485; x=1744960485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbIMRI+x+AE/hoz/da/ZJt9M4223DOG5M56T+jFdBnM=;
  b=OJosTpqk6YrReME4cso2VEQ7u1uUfUsXmt2FEU/8pRSd3QJ+LbNdbNLm
   F9aUpmdghqcxZR1Ih4pejfm2kutSPnJSqsS1qcB0kcRt7CyHcYMcb+s09
   jg/fgxD445gMAVKAa2M/CjSc4zF/kbYDgqXCAI+jwEHf3Ei50G9d8kFsP
   AmyHyAdeOsJczKGb3HuZ0JwqT7mja4MC0Xe8FS/qgLxDgvaT/cKPV3mSF
   NRNDz479G1KYwm37hrZweT2VIPICztrtZxnskmGzC3IzeDZLS4vS9pV7o
   J8de7avA7ynjfw+Lf13hGinqRWL8dRfzRzkKZCco4+/AvjA7YmOIGeMen
   w==;
X-CSE-ConnectionGUID: zWJY09IlQNO3oZtn87uCTg==
X-CSE-MsgGUID: j2B+dNacSSqnp7lbkPPLkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8787062"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8787062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:14:44 -0700
X-CSE-ConnectionGUID: 2+sjzn6+TUy9wxZxV5tZKw==
X-CSE-MsgGUID: ZyqcBl9rQ+CnlU9ZiIIxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23492978"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.226.64]) ([10.124.226.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 00:14:40 -0700
Message-ID: <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>
Date: Thu, 18 Apr 2024 15:14:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio: Add support for the virtio suspend feature
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>, virtio-dev@lists.oasis-open.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20240417085440.4036535-1-stevensd@chromium.org>
 <20240417085440.4036535-2-stevensd@chromium.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240417085440.4036535-2-stevensd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/2024 4:54 PM, David Stevens wrote:
> Add support for the VIRTIO_F_SUSPEND feature. When this feature is
> negotiated, power management can use it to suspend virtio devices
> instead of resorting to resetting the devices entirely.
>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
>   drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
>   drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
>   include/linux/virtio.h             |  2 ++
>   include/uapi/linux/virtio_config.h | 10 +++++++++-
>   5 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index f4080692b351..cd11495a5098 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include <linux/virtio.h>
> +#include <linux/delay.h>
>   #include <linux/spinlock.h>
>   #include <linux/virtio_config.h>
>   #include <linux/virtio_anchor.h>
> @@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(virtio_device_restore);
> +
> +static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
> +{
> +	u8 status, target;
> +
> +	status = dev->config->get_status(dev);
> +	if (enabled)
> +		target = status | VIRTIO_CONFIG_S_SUSPEND;
> +	else
> +		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
> +	dev->config->set_status(dev, target);
I think it is better to verify whether the device SUSPEND bit is
already set or clear, we can just return if status == target.

Thanks
Zhu Lingshan
> +
> +	while ((status = dev->config->get_status(dev)) != target) {
> +		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
> +			return -EIO;
> +		mdelay(10);
> +	}
> +	return 0;
> +}
> +
> +int virtio_device_suspend(struct virtio_device *dev)
> +{
> +	return virtio_device_set_suspend_bit(dev, true);
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> +
> +int virtio_device_resume(struct virtio_device *dev)
> +{
> +	return virtio_device_set_suspend_bit(dev, false);
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume);
>   #endif
>   
>   static int virtio_init(void)
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b655fccaf773..4d542de05970 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
>   	return virtio_device_restore(&vp_dev->vdev);
>   }
>   
> -static bool vp_supports_pm_no_reset(struct device *dev)
> +static int virtio_pci_suspend(struct device *dev)
>   {
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	u16 pmcsr;
> -
> -	if (!pci_dev->pm_cap)
> -		return false;
> -
> -	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> -		dev_err(dev, "Unable to query pmcsr");
> -		return false;
> -	}
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>   
> -	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> -}
> +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> +		return virtio_device_suspend(&vp_dev->vdev);
>   
> -static int virtio_pci_suspend(struct device *dev)
> -{
> -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +	return virtio_pci_freeze(dev);
>   }
>   
>   static int virtio_pci_resume(struct device *dev)
>   {
> -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> +
> +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> +		return virtio_device_resume(&vp_dev->vdev);
> +
> +	return virtio_pci_restore(dev);
>   }
>   
>   static const struct dev_pm_ops virtio_pci_pm_ops = {
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index f62b530aa3b5..ac8734526b8d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
>   	__virtqueue_break(admin_vq->info.vq);
>   }
>   
> +static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
> +{
> +	u16 pmcsr;
> +
> +	if (!pci_dev->pm_cap)
> +		return false;
> +
> +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +		dev_err(&pci_dev->dev, "Unable to query pmcsr");
> +		return false;
> +	}
> +
> +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
>   static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>   
>   	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
>   		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> +
> +	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
> +		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
>   }
>   
>   static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b0201747a263..8e456b04114e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
>   #ifdef CONFIG_PM_SLEEP
>   int virtio_device_freeze(struct virtio_device *dev);
>   int virtio_device_restore(struct virtio_device *dev);
> +int virtio_device_suspend(struct virtio_device *dev);
> +int virtio_device_resume(struct virtio_device *dev);
>   #endif
>   void virtio_reset_device(struct virtio_device *dev);
>   
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 2445f365bce7..4a6e2c28ea76 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -40,6 +40,8 @@
>   #define VIRTIO_CONFIG_S_DRIVER_OK	4
>   /* Driver has finished configuring features */
>   #define VIRTIO_CONFIG_S_FEATURES_OK	8
> +/* Driver has suspended the device */
> +#define VIRTIO_CONFIG_S_SUSPEND		0x10
>   /* Device entered invalid state, driver must reset it */
>   #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
>   /* We've given up on this device. */
> @@ -52,7 +54,7 @@
>    * rest are per-device feature bits.
>    */
>   #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		42
> +#define VIRTIO_TRANSPORT_F_END		43
>   
>   #ifndef VIRTIO_CONFIG_NO_LEGACY
>   /* Do we get callbacks when the ring is completely used, even if we've
> @@ -120,4 +122,10 @@
>    */
>   #define VIRTIO_F_ADMIN_VQ		41
>   
> +/*
> + * This feature indicates that the driver can suspend the device via the
> + * suspend bit in the device status byte.
> + */
> +#define VIRTIO_F_SUSPEND		42
> +
>   #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */


