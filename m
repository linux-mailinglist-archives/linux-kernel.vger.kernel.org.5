Return-Path: <linux-kernel+bounces-95251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5B874B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABB4B20E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9F84FD4;
	Thu,  7 Mar 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAVHRoQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97CB657DA;
	Thu,  7 Mar 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805104; cv=none; b=bjn5YwCHjY1Jgbe4TnCV8POtavat33ddtgxQIYJ54zlCFxRqyeGmE2Svc3y14GrWjOoltq3UVtT7Zf6HhhuLiy4dO8SsefW1VNE9jI8dgkLjrO4Az6v/KPXMZ+7bq5ZCayh8Ei6EFR+l1Wf/mWtnquhjU2gh8q5dn1x6WKdncYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805104; c=relaxed/simple;
	bh=y7Pe3kpgR5LWvQjFduDfVc1YDpdUKIE9eaLUuNrkxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT/+gFnEbZRNuikyp3hTXRbqhAJ4XaIH4NCoTNVb+ziNqqfrhb0OvFHlnQlWfrin3gUBAYQn0NhpgS3fH2RKhuhcblMlqjZ8v5BtOp5WJNaRtHwk926gsqVaNKqSyevTCacTRJ66NCAvBeh797scStAYVHMdC9F7gBP31gnKNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAVHRoQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03442C433F1;
	Thu,  7 Mar 2024 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805104;
	bh=y7Pe3kpgR5LWvQjFduDfVc1YDpdUKIE9eaLUuNrkxFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAVHRoQHjkUZ8vmfJkPg3Qjg/heJ7XlDwXRUEk7miFRh+Q1LacQifmD6s3npdie7J
	 J9CxdcmmrK7Oba/7ZTAEJ32CTHOKWn+EQWRPXNozDI7F/7ERwBiwHg6KaEq2C8Tiwa
	 ncAXbRKC3M1UYSIN7d7nc0zIEhbacM6r3/MtuhpiZs9rlWcQcHD2d7NFGxsR7kM9vD
	 WyI0HDOHkgCx35kAKA76rUjtEupdfqe3dYXzsa3x8WpnyU/Y9qEbhEndyWjCIWuGvt
	 w1NFxP+s7CO18yWRzCfO64a1K1ZrlM3s6/VtdtZmqkNentspZduQMIzi8LlctQSBQx
	 FVY8lRiBfEDyg==
Date: Thu, 7 Mar 2024 10:51:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] scsi: libsas: Define NCQ Priority sysfs
 attributes for SATA devices
Message-ID: <ZemOKZAWuIY1hcpU@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-3-ipylypiv@google.com>
 <ZehLfEjfOTs2wGZe@ryzen>
 <ZejD6mYBhYFQ5Xq8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejD6mYBhYFQ5Xq8@google.com>

On Wed, Mar 06, 2024 at 11:28:42AM -0800, Igor Pylypiv wrote:
> On Wed, Mar 06, 2024 at 11:54:52AM +0100, Niklas Cassel wrote:
> > On Tue, Mar 05, 2024 at 05:22:21PM -0800, Igor Pylypiv wrote:
> > > Libata sysfs attributes cannot be used for libsas managed SATA devices
> > > because the ata_port location is different for libsas.
> > > 
> > > Defined sysfs attributes (visible for SATA devices only):
> > > - /sys/block/sda/device/ncq_prio_enable
> > > - /sys/block/sda/device/ncq_prio_supported
> > > 
> > > The newly defined attributes will pass the correct ata_port to libata
> > > helper functions.
> > > 
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > ---
> > >  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
> > >  include/scsi/sas_ata.h        |  6 +++
> > >  2 files changed, 100 insertions(+)
> > > 
> > > diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> > > index 12e2653846e3..04b0bd9a4e01 100644
> > > --- a/drivers/scsi/libsas/sas_ata.c
> > > +++ b/drivers/scsi/libsas/sas_ata.c
> > > @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
> > >  			       force_phy_id, &tmf_task);
> > >  }
> > >  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> > > +
> > > +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> > > +					   struct device_attribute *attr,
> > > +					   char *buf)
> > > +{
> > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > +	bool supported;
> > > +	int rc;
> > > +
> > > +	/* This attribute shall be visible for SATA devices only */
> > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > +		return -EINVAL;
> > 
> > Like Hannes commented, I don't believe this is needed.
> > 
> 
> The intention for the check is to serve as a fail-safe in case 'is_visible()'
> callback gets incorrectly modified and stops hiding the sysfs attributes
> for non-SATA devices.
> 
> Just want to clarify should I remove the WARN_ON_ONCE and keep the fail-safe
> check or should I get rid of the check completely and trust 'is_visible()'
> to always hide the sysfs attributes for non-SATA devices?

I think that you can remove both the WARN_ON_ONCE and the
if (!dev_is_sata()).

We usually don't keep code around "just in case someone modifies some
other function sometime in the future".


If someone changes is_visible() to remove the dev_is_sata() check,
then they would introuce a bug. I don't see why anyone would change that,
but if someone tried to remove that check from is_visible() anyway,
I'm assuming that someone would catch it during code review.


> 
> > 
> > > +
> > > +	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	return sysfs_emit(buf, "%d\n", supported);
> > > +}
> > > +
> > 
> > While this is a bit different depending on file, the most common way is to
> > have no blank link before the DEVICE_ATTR().
> >
> 
> In "[PATCH 1/3] ata: libata-sata: Factor out NCQ Priority configuration helpers"
> Damien asked to keep the blank link before the DEVICE_ATTR() in libata-sata.c.
> 
> Non-prio sysfs attributes in libata-sata.c don't have blank lines
> before DEVICE_ATTR() so I'm more inclined to remove the lines.
> 
> I'm fine with either of ways, just want to get a consensus and make it 
> consistent for both libata-sata.c and sas_ata.c.

While it is a bit different depending on file, it is slightly more common
to no have a extra blank line before DEVICE_ATTR():

$ git grep -B 1 DEVICE_ATTR | grep "}" | wc -l
2167

$ git grep -B 1 DEVICE_ATTR | grep -- "c-$" | wc -l
1725

But I'm fine to keep it like it is, especially if Damien already had expresed
a preference.


Kind regards,
Niklas

>  
> > 
> > > +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
> > > +
> > > +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> > > +					struct device_attribute *attr,
> > > +					char *buf)
> > > +{
> > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > +	bool enabled;
> > > +	int rc;
> > > +
> > > +	/* This attribute shall be visible for SATA devices only */
> > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > +		return -EINVAL;
> > > +
> > > +	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	return sysfs_emit(buf, "%d\n", enabled);
> > > +}
> > > +
> > > +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> > > +					 struct device_attribute *attr,
> > > +					 const char *buf, size_t len)
> > > +{
> > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > +	bool enable;
> > > +	int rc;
> > > +
> > > +	/* This attribute shall be visible for SATA devices only */
> > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > +		return -EINVAL;
> > > +
> > > +	rc = kstrtobool(buf, &enable);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> > > +	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> > > +
> > > +static struct attribute *sas_ata_sdev_attrs[] = {
> > > +	&dev_attr_ncq_prio_supported.attr,
> > > +	&dev_attr_ncq_prio_enable.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> > > +				       struct attribute *attr, int i)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct scsi_device *sdev = to_scsi_device(dev);
> > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > +
> > > +	if (!dev_is_sata(ddev))
> > > +		return 0;
> > > +
> > > +	return attr->mode;
> > > +}
> > > +
> > > +const struct attribute_group sas_ata_sdev_attr_group = {
> > > +	.attrs = sas_ata_sdev_attrs,
> > > +	.is_visible = sas_ata_attr_is_visible,
> > > +};
> > > +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> > > diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> > > index 2f8c719840a6..92e27e7bf088 100644
> > > --- a/include/scsi/sas_ata.h
> > > +++ b/include/scsi/sas_ata.h
> > > @@ -39,6 +39,9 @@ int smp_ata_check_ready_type(struct ata_link *link);
> > >  int sas_discover_sata(struct domain_device *dev);
> > >  int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
> > >  		    struct domain_device *child, int phy_id);
> > > +
> > > +extern const struct attribute_group sas_ata_sdev_attr_group;
> > > +
> > >  #else
> > >  
> > >  static inline void sas_ata_disabled_notice(void)
> > > @@ -123,6 +126,9 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
> > >  	sas_ata_disabled_notice();
> > >  	return -ENODEV;
> > >  }
> > > +
> > > +#define sas_ata_sdev_attr_group ((struct attribute_group) {})
> > > +
> > >  #endif
> > >  
> > >  #endif /* _SAS_ATA_H_ */
> > > -- 
> > > 2.44.0.278.ge034bb2e1d-goog
> > > 

