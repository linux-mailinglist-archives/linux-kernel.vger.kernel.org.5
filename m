Return-Path: <linux-kernel+bounces-96788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF9876173
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E491C21BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE85381E;
	Fri,  8 Mar 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkBLp1u9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E2535BB;
	Fri,  8 Mar 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892207; cv=none; b=cVyHtVBl6eH2e3ls1mkzRvqymb00RpI62XYLjke+xoG9b+8vygPba5Yf4hFf2vRFjJhe7kaKE2/njcoQN3eRqsX+djxliXS7ixrIMFbMsu7A7jC4Q9aIItkTetp5CGjpDA/VvMFRfFrcEijoKHhX15St9ss+lSN+GaHgUkV4Ssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892207; c=relaxed/simple;
	bh=65Hpx5JIW0/sdEBHDzxgel2VWxWRHjj1o6Q6Y0x3Qe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3OcwD77C8g7VYebUHwZeXUdX77aaVzKPUgnMHzXItibwQR4jk5nA4IGFSW0C2+cGtTrI6jtkSIUW/IiazbWQGanbi6yv0Jk8k6l+LrQKVO5tm0v6emw5E+GK7g6ZkfQOjcflQHSc2IVgtZi33wuMKqobbR67aigrWNBJy0N8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkBLp1u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CC5C433F1;
	Fri,  8 Mar 2024 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892207;
	bh=65Hpx5JIW0/sdEBHDzxgel2VWxWRHjj1o6Q6Y0x3Qe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkBLp1u9jma3TBc2wNk8G+UFC+eLDqBs98Kro5vBczHQUaD5Vaa8yliIQD9e6rI0L
	 hA20C6OP0T/4riWO69A9AogPR2B28sQuo5e6c0Jk+oRIqUK5fgwBqhdB+qnY3hfM+3
	 1rVLrm4C+M2rAXogZivmzjkSdA8cj+A2X5l/kEOpTq5zaKVDGPnsCidPy5jpJIYSxq
	 Y83rghRJXWMqerU1fOSjNHOr3VITk724mPr4mINuCddXdnsTlhw3300yaz8yF7t8nY
	 Fb+xmtfloH6uYejJ+fVqQatAF2vAwvioLT9WopD5ByOwWsZitvUkAR6YDzFcczWvlP
	 n7avj9wUdZEiw==
Date: Fri, 8 Mar 2024 11:03:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Message-ID: <ZeriaUWlhBqp4Q77@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214418.3812290-2-ipylypiv@google.com>

On Thu, Mar 07, 2024 at 01:44:12PM -0800, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Switched locking from spin_lock_irq() to spin_lock_irqsave().
> In the future someone might call these helper functions when interrupts
> are disabled. spin_unlock_irq() could lead to a premature re-enabling
> of interrupts, whereas spin_unlock_irqrestore() restores the interrupt
> state to its condition prior to the spin_lock_irqsave() call.

Seems like a mistake in the existing code, why would
ata_ncq_prio_supported_show() and ata_ncq_prio_enable_show()
use spin_lock_irq() ?

Seems like spin_lock() would be better.

For ata_ncq_prio_enable_store(), you probably want to
spin_lock_irq() or spin_lock_irqsave().


Anyway, like you said, as you are now creating helper functions:
ata_ncq_prio_supported(), ata_ncq_prio_enabled(), ata_ncq_prio_enable()
these function might no longer only be called from sysfs code,
so it is probably a bad idea to let these functions use spin_lock_irq().

However, can't ata_ncq_prio_supported() and ata_ncq_prio_enabled()
still use a simple spin_lock(), why would they need to disable irqs?

Damien, you are the author of ata_ncq_prio_supported_show(), thoughts?


Kind regards,
Niklas

> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-sata.c | 160 +++++++++++++++++++++++++++++---------
>  include/linux/libata.h    |   6 ++
>  2 files changed, 128 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..a8d773003d74 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -848,80 +848,143 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>  	    ata_scsi_lpm_show, ata_scsi_lpm_store);
>  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
>  
> -static ssize_t ata_ncq_prio_supported_show(struct device *device,
> -					   struct device_attribute *attr,
> -					   char *buf)
> +/**
> + *	ata_ncq_prio_supported - Check if device supports NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *	@supported: Address of a boolean to store the result
> + *
> + *	Helper to check if device supports NCQ Priority feature.
> + *
> + *	Context: Any context. Takes and releases @ap->lock.
> + *
> + *	Return:
> + *	* %0		- OK. Status is stored into @supported
> + *	* %-ENODEV	- Failed to find the ATA device
> + */
> +int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
> +			   bool *supported)
>  {
> -	struct scsi_device *sdev = to_scsi_device(device);
> -	struct ata_port *ap = ata_shost_to_port(sdev->host);
>  	struct ata_device *dev;
> -	bool ncq_prio_supported;
> +	unsigned long flags;
>  	int rc = 0;
>  
> -	spin_lock_irq(ap->lock);
> +	spin_lock_irqsave(ap->lock, flags);
>  	dev = ata_scsi_find_dev(ap, sdev);
>  	if (!dev)
>  		rc = -ENODEV;
>  	else
> -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> -	spin_unlock_irq(ap->lock);
> +		*supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> +	spin_unlock_irqrestore(ap->lock, flags);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
> +
> +static ssize_t ata_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
> +	bool supported;
> +	int rc;
> +
> +	rc = ata_ncq_prio_supported(ap, sdev, &supported);
> +	if (rc)
> +		return rc;
>  
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> +	return sysfs_emit(buf, "%d\n", supported);
>  }
>  
>  DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
>  EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
>  
> -static ssize_t ata_ncq_prio_enable_show(struct device *device,
> -					struct device_attribute *attr,
> -					char *buf)
> +/**
> + *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *	@enabled: Address of a boolean to store the result
> + *
> + *	Helper to check if NCQ Priority feature is enabled.
> + *
> + *	Context: Any context. Takes and releases @ap->lock.
> + *
> + *	Return:
> + *	* %0		- OK. Status is stored into @enabled
> + *	* %-ENODEV	- Failed to find the ATA device
> + */
> +int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
> +			 bool *enabled)
>  {
> -	struct scsi_device *sdev = to_scsi_device(device);
> -	struct ata_port *ap = ata_shost_to_port(sdev->host);
>  	struct ata_device *dev;
> -	bool ncq_prio_enable;
> +	unsigned long flags;
>  	int rc = 0;
>  
> -	spin_lock_irq(ap->lock);
> +	spin_lock_irqsave(ap->lock, flags);
>  	dev = ata_scsi_find_dev(ap, sdev);
>  	if (!dev)
>  		rc = -ENODEV;
>  	else
> -		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> -	spin_unlock_irq(ap->lock);
> +		*enabled = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> +	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
> +	return rc;
>  }
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
>  
> -static ssize_t ata_ncq_prio_enable_store(struct device *device,
> -					 struct device_attribute *attr,
> -					 const char *buf, size_t len)
> +static ssize_t ata_ncq_prio_enable_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
>  {
>  	struct scsi_device *sdev = to_scsi_device(device);
> -	struct ata_port *ap;
> -	struct ata_device *dev;
> -	long int input;
> -	int rc = 0;
> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
> +	bool enabled;
> +	int rc;
>  
> -	rc = kstrtol(buf, 10, &input);
> +	rc = ata_ncq_prio_enabled(ap, sdev, &enabled);
>  	if (rc)
>  		return rc;
> -	if ((input < 0) || (input > 1))
> -		return -EINVAL;
>  
> -	ap = ata_shost_to_port(sdev->host);
> -	dev = ata_scsi_find_dev(ap, sdev);
> -	if (unlikely(!dev))
> -		return  -ENODEV;
> +	return sysfs_emit(buf, "%d\n", enabled);
> +}
> +
> +/**
> + *	ata_ncq_prio_enable - Enable/disable NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
> + *
> + *	Helper to enable/disable NCQ Priority feature.
> + *
> + *	Context: Any context. Takes and releases @ap->lock.
> + *
> + *	Return:
> + *	* %0		- OK. Status is stored into @enabled
> + *	* %-ENODEV	- Failed to find the ATA device
> + *	* %-EINVAL	- NCQ Priority is not supported or CDL is enabled
> + */
> +int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> +			bool enable)
> +{
> +	struct ata_device *dev;
> +	unsigned long flags;
> +	int rc = 0;
> +
> +	spin_lock_irqsave(ap->lock, flags);
>  
> -	spin_lock_irq(ap->lock);
> +	dev = ata_scsi_find_dev(ap, sdev);
> +	if (!dev) {
> +		rc = -ENODEV;
> +		goto unlock;
> +	}
>  
>  	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
>  		rc = -EINVAL;
>  		goto unlock;
>  	}
>  
> -	if (input) {
> +	if (enable) {
>  		if (dev->flags & ATA_DFLAG_CDL_ENABLED) {
>  			ata_dev_err(dev,
>  				"CDL must be disabled to enable NCQ priority\n");
> @@ -934,9 +997,30 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
>  	}
>  
>  unlock:
> -	spin_unlock_irq(ap->lock);
> +	spin_unlock_irqrestore(ap->lock, flags);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enable);
> +
> +static ssize_t ata_ncq_prio_enable_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
> +	bool enable;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &enable);
> +	if (rc)
> +		return rc;
> +
> +	rc = ata_ncq_prio_enable(ap, sdev, enable);
> +	if (rc)
> +		return rc;
>  
> -	return rc ? rc : len;
> +	return len;
>  }
>  
>  DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 26d68115afb8..6dd9a4f9ca7c 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1157,6 +1157,12 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>  				       int queue_depth);
>  extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>  				  int queue_depth);
> +extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
> +				  bool *supported);
> +extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
> +				bool *enabled);
> +extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> +			       bool enable);
>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>  extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

