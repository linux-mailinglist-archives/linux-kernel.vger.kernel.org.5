Return-Path: <linux-kernel+bounces-96268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E3875983
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B919C1F251DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E0C13B797;
	Thu,  7 Mar 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8wJCYJO"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC913B787
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847677; cv=none; b=OZ84BR0OHd9BZIleUeWQZHQ+MqWnSQGtopcH4p/Wx4AiDHfjaax7G4H6NdHv5TAma+h0HyJSvodL7rmqWtkOBsoZibcFQTwT5R6LimK61OUerw8d54gkvI32Kk4295//nLFf+Cnf4+5nr3OAVrEvtgRbIGs13G8qm4TdY5MviTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847677; c=relaxed/simple;
	bh=AuAc2CK2EOO9g2povWjdlio5JCZelbtkEEK1od/ZhIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoMmqmagYHKlkakNZElck+zSrusDokD3liNNg+qLHbZEtEHU3VVwZSjrPdFJjnkYC3g/0N5gR/XYHxefGjcCffG952LY1qcA9j34PcxIFh8Br4sC/9BYw7VTGWHz80oGGqWEvsUe+PfBM7SQzFl7tsKf2aLdAf8QCtGz/8tOKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8wJCYJO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1238578a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847675; x=1710452475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNy2VJH5CpaGrvMGBkqQq5PcHuzb7SoeYc5cwzK6s5w=;
        b=x8wJCYJO+XTNeO1SvhuAZ9C/mX2PmZLDUDG8nBMeQmIQ/8EoF4sltyFMl1Ug0bkm1H
         2XD5xF73QeAer7cP6VhXph6VPCGz/w1x1Z53nmLucic0kzvDISF+g0EBacxt0o2iqn6x
         D6ksDrCtz2Nn0jd0TGkfBWk3NZPRplzVnSfX3OIGbAs5XJIxP7xdhclhmRyDqTqmxdJ4
         62rck+99tUw9OZvWXH6fOp8UkXQqr/1lH24RCjbbjlMAua4eI+WnmHyro4zqtF/kU71G
         sBLo7yuJZwfmOjGyr1vSkhmOEssrrXCOb3zDwU9cq7N2s/OYBm21soWjzDY00KTvx4yi
         hzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847675; x=1710452475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNy2VJH5CpaGrvMGBkqQq5PcHuzb7SoeYc5cwzK6s5w=;
        b=LyTHFUfBSzEdO/SFRUwJR3X4Qbwyt1kkLBh5qbp0VxyyNsVhXVg0KmhsWYEn0EyuIk
         1KD0mvOmeONQjUH3BlCxnPW9LHfORvXxQFAY6afIyLGzwrI+NtoQjil43fqD83Bk1vyE
         PMm9v6BV9ThrTR6uyFjEwnmpWv4hrX4cHNQqIpSO23ck/nYhzWi0U9UOhlWLwLBnsYyx
         r+EyExoLOnTF3NHGIxd/j+0zFnbNWDsGz3J87b9/JjUYw4SFnfxGIyHmqGVg0KlHny3I
         OJncxA3fdGedQLKChaAi3VViaFS/vV3U86dq2I+acNUX0XsyVq/AxxHSf++wn2Eh7eGC
         D4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWWHoX6CxUOLXzXpnYCIy2sHoKgNHxWVB+dYtNwiyQ+GW8ydlpkSo5z1LLLqGosefR7CbPrbDm9j8CM1Sy2Efm4gOm5YLgMGLY7Y7ad
X-Gm-Message-State: AOJu0YyYvA7AGND229d1hAGKGG5KSiIylt0awQ4Eeg5WwjQSqEfO6/Zv
	TQyPJwaH4KH8VceTi908KAVtMerVjesZxJbFtd2tI5AFjYipSrBaggueQJTcCw==
X-Google-Smtp-Source: AGHT+IFYeP5MrFV7tURav/d5iTZdFmYSHw7mHHA5IS8gU9mntEqAINsbWoH+9Uhy1RIEl6sd5GARtA==
X-Received: by 2002:a17:90b:2356:b0:29b:ac56:eb62 with SMTP id ms22-20020a17090b235600b0029bac56eb62mr797027pjb.29.1709847674781;
        Thu, 07 Mar 2024 13:41:14 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a440d00b002961a383303sm2008139pjg.14.2024.03.07.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:41:14 -0800 (PST)
Date: Thu, 7 Mar 2024 13:41:09 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <Zeo0dVf-bT9i4P1N@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-3-ipylypiv@google.com>
 <ZehLfEjfOTs2wGZe@ryzen>
 <ZejD6mYBhYFQ5Xq8@google.com>
 <ZemOKZAWuIY1hcpU@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZemOKZAWuIY1hcpU@ryzen>

On Thu, Mar 07, 2024 at 10:51:37AM +0100, Niklas Cassel wrote:
> On Wed, Mar 06, 2024 at 11:28:42AM -0800, Igor Pylypiv wrote:
> > On Wed, Mar 06, 2024 at 11:54:52AM +0100, Niklas Cassel wrote:
> > > On Tue, Mar 05, 2024 at 05:22:21PM -0800, Igor Pylypiv wrote:
> > > > Libata sysfs attributes cannot be used for libsas managed SATA devices
> > > > because the ata_port location is different for libsas.
> > > > 
> > > > Defined sysfs attributes (visible for SATA devices only):
> > > > - /sys/block/sda/device/ncq_prio_enable
> > > > - /sys/block/sda/device/ncq_prio_supported
> > > > 
> > > > The newly defined attributes will pass the correct ata_port to libata
> > > > helper functions.
> > > > 
> > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > > ---
> > > >  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
> > > >  include/scsi/sas_ata.h        |  6 +++
> > > >  2 files changed, 100 insertions(+)
> > > > 
> > > > diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> > > > index 12e2653846e3..04b0bd9a4e01 100644
> > > > --- a/drivers/scsi/libsas/sas_ata.c
> > > > +++ b/drivers/scsi/libsas/sas_ata.c
> > > > @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
> > > >  			       force_phy_id, &tmf_task);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> > > > +
> > > > +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> > > > +					   struct device_attribute *attr,
> > > > +					   char *buf)
> > > > +{
> > > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > > +	bool supported;
> > > > +	int rc;
> > > > +
> > > > +	/* This attribute shall be visible for SATA devices only */
> > > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > > +		return -EINVAL;
> > > 
> > > Like Hannes commented, I don't believe this is needed.
> > > 
> > 
> > The intention for the check is to serve as a fail-safe in case 'is_visible()'
> > callback gets incorrectly modified and stops hiding the sysfs attributes
> > for non-SATA devices.
> > 
> > Just want to clarify should I remove the WARN_ON_ONCE and keep the fail-safe
> > check or should I get rid of the check completely and trust 'is_visible()'
> > to always hide the sysfs attributes for non-SATA devices?
> 
> I think that you can remove both the WARN_ON_ONCE and the
> if (!dev_is_sata()).
> 
> We usually don't keep code around "just in case someone modifies some
> other function sometime in the future".
> 
> 
> If someone changes is_visible() to remove the dev_is_sata() check,
> then they would introuce a bug. I don't see why anyone would change that,
> but if someone tried to remove that check from is_visible() anyway,
> I'm assuming that someone would catch it during code review.
> 

Ack, makes sense. I'll remove the checks in v8. Thanks!
> 
> > 
> > > 
> > > > +
> > > > +	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	return sysfs_emit(buf, "%d\n", supported);
> > > > +}
> > > > +
> > > 
> > > While this is a bit different depending on file, the most common way is to
> > > have no blank link before the DEVICE_ATTR().
> > >
> > 
> > In "[PATCH 1/3] ata: libata-sata: Factor out NCQ Priority configuration helpers"
> > Damien asked to keep the blank link before the DEVICE_ATTR() in libata-sata.c.
> > 
> > Non-prio sysfs attributes in libata-sata.c don't have blank lines
> > before DEVICE_ATTR() so I'm more inclined to remove the lines.
> > 
> > I'm fine with either of ways, just want to get a consensus and make it 
> > consistent for both libata-sata.c and sas_ata.c.
> 
> While it is a bit different depending on file, it is slightly more common
> to no have a extra blank line before DEVICE_ATTR():
> 
> $ git grep -B 1 DEVICE_ATTR | grep "}" | wc -l
> 2167
> 
> $ git grep -B 1 DEVICE_ATTR | grep -- "c-$" | wc -l
> 1725
> 
> But I'm fine to keep it like it is, especially if Damien already had expresed
> a preference.
>

Thank you Niklas. Let's keep the extra blank line as Damien suggested.

Thanks,
Igor

> 
> Kind regards,
> Niklas
>
> >  
> > > 
> > > > +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
> > > > +
> > > > +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> > > > +					struct device_attribute *attr,
> > > > +					char *buf)
> > > > +{
> > > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > > +	bool enabled;
> > > > +	int rc;
> > > > +
> > > > +	/* This attribute shall be visible for SATA devices only */
> > > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	return sysfs_emit(buf, "%d\n", enabled);
> > > > +}
> > > > +
> > > > +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> > > > +					 struct device_attribute *attr,
> > > > +					 const char *buf, size_t len)
> > > > +{
> > > > +	struct scsi_device *sdev = to_scsi_device(device);
> > > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > > +	bool enable;
> > > > +	int rc;
> > > > +
> > > > +	/* This attribute shall be visible for SATA devices only */
> > > > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	rc = kstrtobool(buf, &enable);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	return len;
> > > > +}
> > > > +
> > > > +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> > > > +	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> > > > +
> > > > +static struct attribute *sas_ata_sdev_attrs[] = {
> > > > +	&dev_attr_ncq_prio_supported.attr,
> > > > +	&dev_attr_ncq_prio_enable.attr,
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> > > > +				       struct attribute *attr, int i)
> > > > +{
> > > > +	struct device *dev = kobj_to_dev(kobj);
> > > > +	struct scsi_device *sdev = to_scsi_device(dev);
> > > > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > > > +
> > > > +	if (!dev_is_sata(ddev))
> > > > +		return 0;
> > > > +
> > > > +	return attr->mode;
> > > > +}
> > > > +
> > > > +const struct attribute_group sas_ata_sdev_attr_group = {
> > > > +	.attrs = sas_ata_sdev_attrs,
> > > > +	.is_visible = sas_ata_attr_is_visible,
> > > > +};
> > > > +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> > > > diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> > > > index 2f8c719840a6..92e27e7bf088 100644
> > > > --- a/include/scsi/sas_ata.h
> > > > +++ b/include/scsi/sas_ata.h
> > > > @@ -39,6 +39,9 @@ int smp_ata_check_ready_type(struct ata_link *link);
> > > >  int sas_discover_sata(struct domain_device *dev);
> > > >  int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
> > > >  		    struct domain_device *child, int phy_id);
> > > > +
> > > > +extern const struct attribute_group sas_ata_sdev_attr_group;
> > > > +
> > > >  #else
> > > >  
> > > >  static inline void sas_ata_disabled_notice(void)
> > > > @@ -123,6 +126,9 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
> > > >  	sas_ata_disabled_notice();
> > > >  	return -ENODEV;
> > > >  }
> > > > +
> > > > +#define sas_ata_sdev_attr_group ((struct attribute_group) {})
> > > > +
> > > >  #endif
> > > >  
> > > >  #endif /* _SAS_ATA_H_ */
> > > > -- 
> > > > 2.44.0.278.ge034bb2e1d-goog
> > > > 

