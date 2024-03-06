Return-Path: <linux-kernel+bounces-93811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A02873505
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4064928A973
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595760B87;
	Wed,  6 Mar 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvsFxFGA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA07605C7;
	Wed,  6 Mar 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722499; cv=none; b=YGXpstILDSt/IaoaiesReDHaPj12eYFs0DEWAdK08ZgHfiDY2dGRhrHGIxqFsMOsCgnhHT790NzNYzU0JVCLqzWy18JulcGAnyUB2lCU2YO1QSQvQ0EBapTRdEmA8RvuxE1fdXtZtYqR7rDzMx//qiGGATWW4XIZVPpDwFR4O9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722499; c=relaxed/simple;
	bh=YD76MHec5dML9IBNBcREwvR+mmv0kGcOikse6uycZfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z31shZ9QPpuib+zsZ/pEec18wFk5ZbtKZDvPcJLoaSRfqth9TIcahMxZaNrWXl6b5CoWW+tqQ/6BrtaLq5BE4ZRyyFKqZtTHJ3pFZRdhsD6Lhb83ZX0WfXIAT5tJFjWhlTCwI9ug8gnKqZRRNj4UOHGzmNaFvZd4/3JC4jvHC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvsFxFGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6544EC433F1;
	Wed,  6 Mar 2024 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722498;
	bh=YD76MHec5dML9IBNBcREwvR+mmv0kGcOikse6uycZfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvsFxFGA2A344AqJMB4bRs6pg36ysD5qabRGt1hRUIvy0UxjsZJYzfnX+LZNmW/e2
	 anidCR0T9oW9CzOAdgUC7Eobo8eBdiQ17yZtfOnVcao2QLH4styBVBFWsaOitijb6W
	 uafUBuKnB21GJdLXc94AkEgQL7JMRIk5+eEKEdmIsOasnPZ7BNzk2Chmt97ygtW6VD
	 /bxfw3x81Y1S5YWtuTDEPb4HVtsotw+Uxf9wkSYiyWYzOqta33SPUM7p/zfdbQczZB
	 EibXXd2l26t/2Z8XKU3Y+gDG2qEt8PD8zfkD9ICMUo49r8eO0rgC/W17qtqoa7mpAX
	 PH1L/zpsoFzWQ==
Date: Wed, 6 Mar 2024 11:54:52 +0100
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
Subject: Re: [PATCH v7 2/7] scsi: libsas: Define NCQ Priority sysfs
 attributes for SATA devices
Message-ID: <ZehLfEjfOTs2wGZe@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-3-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-3-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:21PM -0800, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/sda/device/ncq_prio_enable
> - /sys/block/sda/device/ncq_prio_supported
> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
>  include/scsi/sas_ata.h        |  6 +++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 12e2653846e3..04b0bd9a4e01 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>  			       force_phy_id, &tmf_task);
>  }
>  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> +
> +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool supported;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;

Like Hannes commented, I don't believe this is needed.


> +
> +	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
> +	if (rc)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", supported);
> +}
> +

While this is a bit different depending on file, the most common way is to
have no blank link before the DEVICE_ATTR().


> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
> +
> +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool enabled;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
> +	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
> +	if (rc)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", enabled);
> +}
> +
> +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool enable;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
> +	rc = kstrtobool(buf, &enable);
> +	if (rc)
> +		return rc;
> +
> +	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +
> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> +	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> +
> +static struct attribute *sas_ata_sdev_attrs[] = {
> +	&dev_attr_ncq_prio_supported.attr,
> +	&dev_attr_ncq_prio_enable.attr,
> +	NULL
> +};
> +
> +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +
> +	if (!dev_is_sata(ddev))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +const struct attribute_group sas_ata_sdev_attr_group = {
> +	.attrs = sas_ata_sdev_attrs,
> +	.is_visible = sas_ata_attr_is_visible,
> +};
> +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> index 2f8c719840a6..92e27e7bf088 100644
> --- a/include/scsi/sas_ata.h
> +++ b/include/scsi/sas_ata.h
> @@ -39,6 +39,9 @@ int smp_ata_check_ready_type(struct ata_link *link);
>  int sas_discover_sata(struct domain_device *dev);
>  int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
>  		    struct domain_device *child, int phy_id);
> +
> +extern const struct attribute_group sas_ata_sdev_attr_group;
> +
>  #else
>  
>  static inline void sas_ata_disabled_notice(void)
> @@ -123,6 +126,9 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>  	sas_ata_disabled_notice();
>  	return -ENODEV;
>  }
> +
> +#define sas_ata_sdev_attr_group ((struct attribute_group) {})
> +
>  #endif
>  
>  #endif /* _SAS_ATA_H_ */
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

