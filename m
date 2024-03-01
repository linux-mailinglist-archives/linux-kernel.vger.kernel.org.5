Return-Path: <linux-kernel+bounces-88390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40A86E0F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B051F2506D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049ED6E5FA;
	Fri,  1 Mar 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImKzAOVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F96D1C7;
	Fri,  1 Mar 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295408; cv=none; b=RFPUc0/izwI7HPU8g5zV30vXs/ZQMwLmjK4e4HFS2NVtkBO+D/cHcdyp1t+K0Pmf7jalvh92wjNhFFY8oSZoFLfbt6QJiSK9KxinrbYOtMh8wXTJ0zpRE85aV0LWsMe3md1f58JL2Z9VPZB5/6CPIye+oZPkEv9a6ff/P9/oIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295408; c=relaxed/simple;
	bh=GKYWqQGyp31n2OomMV99ZV0lR/PHwWeB4y/INC3xn58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edjh4icL5DCnwVSpDhkqbvTvs6V/igcWNErWoQBq1CgoY4qPUgek6ppDItvFuujpw+sO36HGwf81p4SAcuzBsE6CUeBdqF07kNAoO6Vl8BjAFh75H03oEZ36LzLn4ZZf0QNukS8w9c4OyRl03dEbn6VUvTrrIR3AuNUbK5Tf3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImKzAOVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB21C433F1;
	Fri,  1 Mar 2024 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709295407;
	bh=GKYWqQGyp31n2OomMV99ZV0lR/PHwWeB4y/INC3xn58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ImKzAOVvHcHE8FNJaTIqRj2wZf7cPGiZI/NQb84uEXiGlhAPgp+t/2gWhcw/2tdyy
	 21jK9xuajmFuyZ4xXXrj7iDjgdyFB+p+hqNl0LimsIymT5xVAR8dp3JuMKH3btD/p2
	 Wgdg/spwTZEcL9KvOEkBwF4/Cdubb0DcvwolUBE3xa9IGDkE9wC+Q+noRA8+G9SjY5
	 7dyXsSIHnPSzbdvmMrVQasE7cC/UkDqR0qYrRRSqtXw0GQxg8V5fBUvZINrWXxeYi6
	 NlEcywAHAjmsuEiHqvzntTc4HmhFGtm7UCFdaqUh7x6D+frJzqMLOZsaISkkVS6BvF
	 /90oqUhZFVNiQ==
Message-ID: <cee98fdf-d285-44da-8bcb-9d9150a19e5e@kernel.org>
Date: Fri, 1 Mar 2024 04:16:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, TJ Adams <tadamsjr@google.com>
References: <20240301013759.516817-1-ipylypiv@google.com>
 <20240301013759.516817-2-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240301013759.516817-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/29 17:37, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Reviewed-by: TJ Adams <tadamsjr@google.com>

Please drop this tag as the email signaling the review was not sent to the
list/in-reply to this email. The name of the reviewer should also be fully
spelled out. Same comment for the other 2 patches as they also have this review tag.

> ---
>  drivers/ata/libata-sata.c | 130 +++++++++++++++++++++++++-------------
>  include/linux/libata.h    |   4 ++
>  2 files changed, 90 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..9c6c69d7feab 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -848,80 +848,104 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>  	    ata_scsi_lpm_show, ata_scsi_lpm_store);
>  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
>  
> +/**
> + *	ata_ncq_prio_supported - Check if device supports NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *
> + *	Helper to check if device supports NCQ Priority feature,
> + *	usable with both libsas and libata.
> + */
> +int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev)
> +{
> +	struct ata_device *dev;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +	dev = ata_scsi_find_dev(ap, sdev);
> +	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO) : -ENODEV;

Please expand this to make it more readable:

	if (!dev)
		rc = -ENODEV;
	else
		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO);

> +	spin_unlock_irqrestore(ap->lock, flags);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
> +
>  static ssize_t ata_ncq_prio_supported_show(struct device *device,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
>  	struct scsi_device *sdev = to_scsi_device(device);
>  	struct ata_port *ap = ata_shost_to_port(sdev->host);
> -	struct ata_device *dev;
> -	bool ncq_prio_supported;
> -	int rc = 0;
> -
> -	spin_lock_irq(ap->lock);
> -	dev = ata_scsi_find_dev(ap, sdev);
> -	if (!dev)
> -		rc = -ENODEV;
> -	else
> -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> -	spin_unlock_irq(ap->lock);
> +	int rc = ata_ncq_prio_supported(ap, sdev);
>  
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> +	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);

Same here, please expand:

	if (rc < 0)
		return rc;
	return sysfs_emit(buf, "%d\n", rc);

And please not the change %u -> %d

>  }
> -

whiteline change. Please keep the white line.

>  DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
>  EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
>  
> +/**
> + *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *
> + *	Helper to check if NCQ Priority feature is enabled,
> + *	usable with both libsas and libata.
> + */
> +int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev)
> +{
> +	struct ata_device *dev;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +	dev = ata_scsi_find_dev(ap, sdev);
> +	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) : -ENODEV;

same comment as above. Please expand.

> +	spin_unlock_irqrestore(ap->lock, flags);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
> +
>  static ssize_t ata_ncq_prio_enable_show(struct device *device,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
>  	struct scsi_device *sdev = to_scsi_device(device);
>  	struct ata_port *ap = ata_shost_to_port(sdev->host);
> -	struct ata_device *dev;
> -	bool ncq_prio_enable;
> -	int rc = 0;
> -
> -	spin_lock_irq(ap->lock);
> -	dev = ata_scsi_find_dev(ap, sdev);
> -	if (!dev)
> -		rc = -ENODEV;
> -	else
> -		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> -	spin_unlock_irq(ap->lock);
> +	int rc = ata_ncq_prio_enabled(ap, sdev);
>  
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
> +	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);

same comment as above.

>  }
>  
> -static ssize_t ata_ncq_prio_enable_store(struct device *device,
> -					 struct device_attribute *attr,
> -					 const char *buf, size_t len)
> +/**
> + *	ata_ncq_prio_enable - Enable/disable NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
> + *
> + *	Helper to enable/disable NCQ Priority feature, usable with both
> + *	libsas and libata.
> + */
> +int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> +			bool enable)
>  {
> -	struct scsi_device *sdev = to_scsi_device(device);
> -	struct ata_port *ap;
>  	struct ata_device *dev;
> -	long int input;
> +	unsigned long flags;
>  	int rc = 0;
>  
> -	rc = kstrtol(buf, 10, &input);
> -	if (rc)
> -		return rc;
> -	if ((input < 0) || (input > 1))
> -		return -EINVAL;
> +	spin_lock_irqsave(ap->lock, flags);

Any reason to not use spin_lock_irq() ?

>  
> -	ap = ata_shost_to_port(sdev->host);
>  	dev = ata_scsi_find_dev(ap, sdev);
> -	if (unlikely(!dev))
> -		return  -ENODEV;
> -
> -	spin_lock_irq(ap->lock);
> +	if (unlikely(!dev)) {
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
> @@ -934,9 +958,27 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
>  	}
>  
>  unlock:
> -	spin_unlock_irq(ap->lock);
> +	spin_unlock_irqrestore(ap->lock, flags);
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
> +	long input;
> +	int rc = 0;
> +
> +	rc = kstrtol(buf, 10, &input);

Please use kstrtobool().

> +	if (rc)
> +		return rc;
> +	if ((input < 0) || (input > 1))
> +		return -EINVAL;
>  
> -	return rc ? rc : len;
> +	return ata_ncq_prio_enable(ap, sdev, input) ? : len;
>  }
>  
>  DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 26d68115afb8..f3ff2bf3ec6b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1157,6 +1157,10 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>  				       int queue_depth);
>  extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>  				  int queue_depth);
> +extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev);
> +extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev);
> +extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> +			       bool enable);
>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>  extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);

-- 
Damien Le Moal
Western Digital Research


