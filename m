Return-Path: <linux-kernel+bounces-99886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB4D878EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BC284D10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41759177;
	Tue, 12 Mar 2024 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C82CKG4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878D59158;
	Tue, 12 Mar 2024 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224267; cv=none; b=OtKXU9u7DeQLFgTNXFeKk+x6U50hj/vIiwDROhznUgwSxSZ7Z5+5ZkQKFN+a8A8oQlkhZsxZA6ecDWQII6HdBGiYC9+qCxX5h9x5COmG4B7HkXUeJYRGuw1WtYQ2bj05JN2S5YqySFJ+aULSb16ZQHU6QtIhR9UdmuOcpLx/BS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224267; c=relaxed/simple;
	bh=znbBaTEbEI+Z5cnM0Hnz4KsrAD/L5QaS0SaW2VHvJNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf5VPGpXinTBi58qA9owvt0iCjn1mxm2gqAvImEAQRwiCKeLzhbFZPKju0HVWHxxYfphUhCGf4gxrOedz0vd8gUqm3tlpJx7wbhNg+ACzvTQvYtkkHXWmK8g3zaJUeixNU3CHU3ByYZhcH1z7HMBQbnSluftlzochNnyM2/STGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C82CKG4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE68C43390;
	Tue, 12 Mar 2024 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710224267;
	bh=znbBaTEbEI+Z5cnM0Hnz4KsrAD/L5QaS0SaW2VHvJNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C82CKG4KyJ1bkVzcf51gn8rG8uM3ciBuYTrB3W5OIOYqj1DPu1dyVRuzhVqjsvCrC
	 W+RSanIYSzt18E13YeDJIsK/Du9grpRiPriRwYnXpfSy7GYt+zXzkK4XW5p5d3YWjh
	 D6SpPe8SlvdYeVlJhp631Y1bxUnkR3PSUoBE+RHYJnNpBLlRVCPafbBPfJgaBwUpug
	 0mex3RV6/Zq5OA8yMkY5vVFbHb/d9oOywTBDbWzYLD4vFjyxxjGaVG+3SccpWUseWi
	 iJx9TwhdHetgntNyBC6nHEyrOZBbRFPZG+V/S+bsSgPX0xd9NbMMcPcFZkVHFiltld
	 O6kxx2z85v6TQ==
Message-ID: <35801735-1e6a-43ef-8687-06ff04d53619@kernel.org>
Date: Tue, 12 Mar 2024 15:17:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-2-ipylypiv@google.com> <ZeriaUWlhBqp4Q77@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZeriaUWlhBqp4Q77@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/08 19:03, Niklas Cassel wrote:
> On Thu, Mar 07, 2024 at 01:44:12PM -0800, Igor Pylypiv wrote:
>> Export libata NCQ Priority configuration helpers to be reused
>> for libsas managed SATA devices.
>>
>> Switched locking from spin_lock_irq() to spin_lock_irqsave().
>> In the future someone might call these helper functions when interrupts
>> are disabled. spin_unlock_irq() could lead to a premature re-enabling
>> of interrupts, whereas spin_unlock_irqrestore() restores the interrupt
>> state to its condition prior to the spin_lock_irqsave() call.
> 
> Seems like a mistake in the existing code, why would
> ata_ncq_prio_supported_show() and ata_ncq_prio_enable_show()
> use spin_lock_irq() ?
> 
> Seems like spin_lock() would be better.

Nope, you cannot do that. The port lock is taken from command completion
context/IRQ. So using spin_lock could lead to deadlocks.

> 
> For ata_ncq_prio_enable_store(), you probably want to
> spin_lock_irq() or spin_lock_irqsave().
> 
> 
> Anyway, like you said, as you are now creating helper functions:
> ata_ncq_prio_supported(), ata_ncq_prio_enabled(), ata_ncq_prio_enable()
> these function might no longer only be called from sysfs code,
> so it is probably a bad idea to let these functions use spin_lock_irq().
> 
> However, can't ata_ncq_prio_supported() and ata_ncq_prio_enabled()
> still use a simple spin_lock(), why would they need to disable irqs?
> 
> Damien, you are the author of ata_ncq_prio_supported_show(), thoughts?

See above. The spin lock irq-disabling variant is needed because the port lock
is taken from command completion context.

As for ata_ncq_prio_supported() and ata_ncq_prio_enabled() being called from
somewhere else than the sysfs context, I seriously doubt it, and if I see
someone doing it, I will most definitively say no. These functions are overkill
to use anywhere else but the sysfs store/show because in most other places we
likely already have the dev (no need for searching it) and in many instances
likely looking at the device flags with the port already locked. So these
functions in fact likely cannot be used...

Given that Igor rewrote/cleaned this up nicely, keeping the change to
spin_lock_irqsave() from the original spin_lock_irq() is fine to me. All good !

> 
> 
> Kind regards,
> Niklas
> 
>>
>> Acked-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Jason Yan <yanaijie@huawei.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>> ---
>>  drivers/ata/libata-sata.c | 160 +++++++++++++++++++++++++++++---------
>>  include/linux/libata.h    |   6 ++
>>  2 files changed, 128 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 0fb1934875f2..a8d773003d74 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -848,80 +848,143 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>>  	    ata_scsi_lpm_show, ata_scsi_lpm_store);
>>  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
>>  
>> -static ssize_t ata_ncq_prio_supported_show(struct device *device,
>> -					   struct device_attribute *attr,
>> -					   char *buf)
>> +/**
>> + *	ata_ncq_prio_supported - Check if device supports NCQ Priority
>> + *	@ap: ATA port of the target device
>> + *	@sdev: SCSI device
>> + *	@supported: Address of a boolean to store the result
>> + *
>> + *	Helper to check if device supports NCQ Priority feature.
>> + *
>> + *	Context: Any context. Takes and releases @ap->lock.
>> + *
>> + *	Return:
>> + *	* %0		- OK. Status is stored into @supported
>> + *	* %-ENODEV	- Failed to find the ATA device
>> + */
>> +int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
>> +			   bool *supported)
>>  {
>> -	struct scsi_device *sdev = to_scsi_device(device);
>> -	struct ata_port *ap = ata_shost_to_port(sdev->host);
>>  	struct ata_device *dev;
>> -	bool ncq_prio_supported;
>> +	unsigned long flags;
>>  	int rc = 0;
>>  
>> -	spin_lock_irq(ap->lock);
>> +	spin_lock_irqsave(ap->lock, flags);
>>  	dev = ata_scsi_find_dev(ap, sdev);
>>  	if (!dev)
>>  		rc = -ENODEV;
>>  	else
>> -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
>> -	spin_unlock_irq(ap->lock);
>> +		*supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
>> +	spin_unlock_irqrestore(ap->lock, flags);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
>> +
>> +static ssize_t ata_ncq_prio_supported_show(struct device *device,
>> +					   struct device_attribute *attr,
>> +					   char *buf)
>> +{
>> +	struct scsi_device *sdev = to_scsi_device(device);
>> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
>> +	bool supported;
>> +	int rc;
>> +
>> +	rc = ata_ncq_prio_supported(ap, sdev, &supported);
>> +	if (rc)
>> +		return rc;
>>  
>> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
>> +	return sysfs_emit(buf, "%d\n", supported);
>>  }
>>  
>>  DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
>>  EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
>>  
>> -static ssize_t ata_ncq_prio_enable_show(struct device *device,
>> -					struct device_attribute *attr,
>> -					char *buf)
>> +/**
>> + *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
>> + *	@ap: ATA port of the target device
>> + *	@sdev: SCSI device
>> + *	@enabled: Address of a boolean to store the result
>> + *
>> + *	Helper to check if NCQ Priority feature is enabled.
>> + *
>> + *	Context: Any context. Takes and releases @ap->lock.
>> + *
>> + *	Return:
>> + *	* %0		- OK. Status is stored into @enabled
>> + *	* %-ENODEV	- Failed to find the ATA device
>> + */
>> +int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
>> +			 bool *enabled)
>>  {
>> -	struct scsi_device *sdev = to_scsi_device(device);
>> -	struct ata_port *ap = ata_shost_to_port(sdev->host);
>>  	struct ata_device *dev;
>> -	bool ncq_prio_enable;
>> +	unsigned long flags;
>>  	int rc = 0;
>>  
>> -	spin_lock_irq(ap->lock);
>> +	spin_lock_irqsave(ap->lock, flags);
>>  	dev = ata_scsi_find_dev(ap, sdev);
>>  	if (!dev)
>>  		rc = -ENODEV;
>>  	else
>> -		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
>> -	spin_unlock_irq(ap->lock);
>> +		*enabled = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
>> +	spin_unlock_irqrestore(ap->lock, flags);
>>  
>> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
>> +	return rc;
>>  }
>> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
>>  
>> -static ssize_t ata_ncq_prio_enable_store(struct device *device,
>> -					 struct device_attribute *attr,
>> -					 const char *buf, size_t len)
>> +static ssize_t ata_ncq_prio_enable_show(struct device *device,
>> +					struct device_attribute *attr,
>> +					char *buf)
>>  {
>>  	struct scsi_device *sdev = to_scsi_device(device);
>> -	struct ata_port *ap;
>> -	struct ata_device *dev;
>> -	long int input;
>> -	int rc = 0;
>> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
>> +	bool enabled;
>> +	int rc;
>>  
>> -	rc = kstrtol(buf, 10, &input);
>> +	rc = ata_ncq_prio_enabled(ap, sdev, &enabled);
>>  	if (rc)
>>  		return rc;
>> -	if ((input < 0) || (input > 1))
>> -		return -EINVAL;
>>  
>> -	ap = ata_shost_to_port(sdev->host);
>> -	dev = ata_scsi_find_dev(ap, sdev);
>> -	if (unlikely(!dev))
>> -		return  -ENODEV;
>> +	return sysfs_emit(buf, "%d\n", enabled);
>> +}
>> +
>> +/**
>> + *	ata_ncq_prio_enable - Enable/disable NCQ Priority
>> + *	@ap: ATA port of the target device
>> + *	@sdev: SCSI device
>> + *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
>> + *
>> + *	Helper to enable/disable NCQ Priority feature.
>> + *
>> + *	Context: Any context. Takes and releases @ap->lock.
>> + *
>> + *	Return:
>> + *	* %0		- OK. Status is stored into @enabled
>> + *	* %-ENODEV	- Failed to find the ATA device
>> + *	* %-EINVAL	- NCQ Priority is not supported or CDL is enabled
>> + */
>> +int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
>> +			bool enable)
>> +{
>> +	struct ata_device *dev;
>> +	unsigned long flags;
>> +	int rc = 0;
>> +
>> +	spin_lock_irqsave(ap->lock, flags);
>>  
>> -	spin_lock_irq(ap->lock);
>> +	dev = ata_scsi_find_dev(ap, sdev);
>> +	if (!dev) {
>> +		rc = -ENODEV;
>> +		goto unlock;
>> +	}
>>  
>>  	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
>>  		rc = -EINVAL;
>>  		goto unlock;
>>  	}
>>  
>> -	if (input) {
>> +	if (enable) {
>>  		if (dev->flags & ATA_DFLAG_CDL_ENABLED) {
>>  			ata_dev_err(dev,
>>  				"CDL must be disabled to enable NCQ priority\n");
>> @@ -934,9 +997,30 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
>>  	}
>>  
>>  unlock:
>> -	spin_unlock_irq(ap->lock);
>> +	spin_unlock_irqrestore(ap->lock, flags);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enable);
>> +
>> +static ssize_t ata_ncq_prio_enable_store(struct device *device,
>> +					 struct device_attribute *attr,
>> +					 const char *buf, size_t len)
>> +{
>> +	struct scsi_device *sdev = to_scsi_device(device);
>> +	struct ata_port *ap = ata_shost_to_port(sdev->host);
>> +	bool enable;
>> +	int rc;
>> +
>> +	rc = kstrtobool(buf, &enable);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = ata_ncq_prio_enable(ap, sdev, enable);
>> +	if (rc)
>> +		return rc;
>>  
>> -	return rc ? rc : len;
>> +	return len;
>>  }
>>  
>>  DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 26d68115afb8..6dd9a4f9ca7c 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1157,6 +1157,12 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>  				       int queue_depth);
>>  extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>>  				  int queue_depth);
>> +extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev,
>> +				  bool *supported);
>> +extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev,
>> +				bool *enabled);
>> +extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
>> +			       bool enable);
>>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>>  extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>>  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
>> -- 
>> 2.44.0.278.ge034bb2e1d-goog
>>

-- 
Damien Le Moal
Western Digital Research


