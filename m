Return-Path: <linux-kernel+bounces-93810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DE873500
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F52289FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538E60894;
	Wed,  6 Mar 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFWIOYaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E46605C7;
	Wed,  6 Mar 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722485; cv=none; b=avLqAf0UqbGgPSnx0/jhJzFlTt56fhZveqEjXlZMTzkw1u4tj/qAHiQbQ1QnMfyS/p9aA8ivdN9TNZW65rzOrPS+IW496nFd9+/l2W4HucyyHbEKHTma9lR1gbMNwNMRAG02qdLFHvoL0QhwgeA2oqCH3kdmKt99LmUNWDNZFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722485; c=relaxed/simple;
	bh=gxCZ0NBictOxN2ojmP/tuNrrR8hzecTmu5Fm/LembOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhgpdHiobr14GRFKZzBfx1kvjiQv9cY4CaWbSKUJDv5U4MqSrAKYlfFNbhin8Z7BmbDploLTrHpg0LBqmxuHwJnkyg/K14wskc748JwTjdMoKsntjKL5S9qAKH586qnNKwU4/RxCZTV46ygMHGYMWoikmJC1CsRCmlATT9gGIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFWIOYaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD8CC433F1;
	Wed,  6 Mar 2024 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722484;
	bh=gxCZ0NBictOxN2ojmP/tuNrrR8hzecTmu5Fm/LembOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFWIOYaq6+mAcEH0wKikIlUbcFMMRgUfnxAIR0YXzYtAgS/JUyCSTta1iEUSsHI4I
	 84mzuCR48Z0tAW52m1xHquYVwM1PjwhATvrmM3WAbEecME+pZxgVVUj5DTuAxj37Bh
	 Nw6mHe4Onc0m/JY0oT+8T4sHg9zh4R3mPapUxKPtH/cRydZbwCc4o6GKOWm4rF9kyO
	 /ri2+09Irncnb8sD0EwPiXs3NEX/sKMLa4t1dzjXsLQBzLFcTXylEZRVPPKzt/G/Jl
	 fXOf76fYcI8iBT9X/be65tcYFVmGCa3yRhYxESb8TXgtn4/XyJNJgF9G8zPkli1Vds
	 aXd+h6lkvm3oQ==
Date: Wed, 6 Mar 2024 11:54:38 +0100
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
Subject: Re: [PATCH v7 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Message-ID: <ZehLbvoUp9mYI3LL@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-2-ipylypiv@google.com>

Hello Igor,

On Tue, Mar 05, 2024 at 05:22:20PM -0800, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-sata.c | 140 +++++++++++++++++++++++++++-----------
>  include/linux/libata.h    |   6 ++
>  2 files changed, 107 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..f00dd02dc6f8 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -848,80 +848,122 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
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

This kdoc is missing a "Return:", see:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
(Same comment for other functions.)


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

You should mention why you are changing this from a spin_lock_irq() to a
spin_lock_irqsave() in the commit message.


>  	dev = ata_scsi_find_dev(ap, sdev);
>  	if (!dev)
>  		rc = -ENODEV;
>  	else
> -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> -	spin_unlock_irq(ap->lock);
> +		*supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> +	spin_unlock_irqrestore(ap->lock, flags);
> +	return rc;

You removed the blank link between spin_unlock and return,
please keep this empty line.
(Same comment for other functions.)


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
>  
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> +	rc = ata_ncq_prio_supported(ap, sdev, &supported);
> +	if (rc)
> +		return rc;
> +
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
> -
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
> +		*enabled = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> +	spin_unlock_irqrestore(ap->lock, flags);
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
> @@ -934,9 +976,29 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
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

