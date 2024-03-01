Return-Path: <linux-kernel+bounces-88392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA886E0FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6597B21E37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27D6E61C;
	Fri,  1 Mar 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqtMsfNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA26E5E3;
	Fri,  1 Mar 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295769; cv=none; b=nzoJ+22PDZ5wkuPvCTs9grt4bho6iA6TNpFhdIy58U7dAOyjXOQCD9GNjIDWBbcWlkrJnUY3xFP9NXfNGOYmzYetju73/oZQM0o724BOilTZFV9sIzifCeNoXFgu6WuW7kEq2eB9Sz5kTQRS+sF4ShIlOSB6NvZkL3N1r9mkH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295769; c=relaxed/simple;
	bh=CRnowRjLCq+kORKKl47Vuo6OyiXmlws02WybHbJRUtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAml5Ac0dcXRDYR5E7LcJTaB+Pzhrcss4fXrznWDR/lX40yNOiqplrZOxWisWWRJamxHvxqcm1SCusPifzQQC/slEWBeeghNrdTvrASdNMSnbBiMbxcpmbPR1v5orF2JLmDJKD/+SAptLMYb5ZZ+5gL+GSGt6UvxWR74Xz9cer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqtMsfNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F1C433C7;
	Fri,  1 Mar 2024 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709295768;
	bh=CRnowRjLCq+kORKKl47Vuo6OyiXmlws02WybHbJRUtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aqtMsfNAR2OO6tIf5w0VRZoJVrzX3aqu9nDKPy/fQofWPzDN+jOA9/9O3QYIHx5fM
	 sR4xldaBJb+JkXylQffa4od2bwQlbZ2jqyyrE5oIpepMdLkr745POXouywD/2p6bDJ
	 ICjmx33b2GDko/jaK9PjXi1gRxUv1H8JmZ4alqPqacM1VOunD422KE9k+Cyi8+cPYE
	 11uEe1QAhwA/W9BdfpmZHeRUOHRD8zDDGLS3rblgQN2DEwMnce3O+D7bApEaxew78v
	 XmtjxTBNYohLRm5wk1g6D4RKH6irJE2tGlRbeAMWNGbWsg3Mm96tdR9SlQ0fNDUgAA
	 7eqikxGlZ4BQg==
Message-ID: <85c669ac-8592-46c7-9716-1e76f5aae220@kernel.org>
Date: Fri, 1 Mar 2024 04:22:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, Igor Pylypiv <ipylypiv@google.com>,
 Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, TJ Adams <tadamsjr@google.com>
References: <20240301013759.516817-1-ipylypiv@google.com>
 <20240301013759.516817-3-ipylypiv@google.com>
 <b10df0c1-5d8a-4c4d-b8bd-c0dbb53ea0d1@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b10df0c1-5d8a-4c4d-b8bd-c0dbb53ea0d1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/01 3:57, John Garry wrote:
> On 01/03/2024 01:37, Igor Pylypiv wrote:
>> Libata sysfs attributes cannot be used for libsas managed SATA devices
>> because the ata_port location is different for libsas.
>>
>> Defined sysfs attributes (visible for SATA devices only):
>> - /sys/block/*/device/sas_ncq_prio_enable
>> - /sys/block/*/device/sas_ncq_prio_supported

Please no ! I know that the Broadcom mpt3sas driver has this attribute named
sas_ncq_prio_*, but I really think that it was a very unfortunate choice as that
makes it different from the attribute for libata, which does not have the sas_
prefix. That means that an attribute controlling a *device* feature has 2
different name depending on the hba used for the device. That is super annoying
to deal with in user space... So please, let's name this ncq_prio_*, same as for
AHCI. SAS does have a concept of priority, but that is for data frames and has
nothing to do with the actual command being transported. So mixing up sas and
ncq in the same name is only confusing...

For the Broadcom mpt3sas driver, we can define a link to have that same name for
the attributes to have everything consistent.

> 
> it would be good to show the full path
> 
>>
>> The newly defined attributes will pass the correct ata_port to libata
>> helper functions.
>>
>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>> Reviewed-by: TJ Adams <tadamsjr@google.com>
>> ---
>>   drivers/scsi/libsas/sas_ata.c | 87 +++++++++++++++++++++++++++++++++++
>>   include/scsi/sas_ata.h        |  6 +++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>> index 12e2653846e3..e0b19eee09b5 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -964,3 +964,90 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>>   			       force_phy_id, &tmf_task);
>>   }
>>   EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
>> +
>> +static ssize_t sas_ncq_prio_supported_show(struct device *device,
>> +					   struct device_attribute *attr,
>> +					   char *buf)
>> +{
>> +	struct scsi_device *sdev = to_scsi_device(device);
>> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
>> +	int res;
>> +
>> +	// This attribute shall be visible for SATA devices only
> 
> Please don't use c99 comment style
> 
>> +	if (WARN_ON(!dev_is_sata(ddev)))
>> +		return -EINVAL;
>> +
>> +	res = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev);
>> +	if (res < 0)
>> +		return res;
>> +
>> +	return sysfs_emit(buf, "%u\n", res);
>> +}
>> +static DEVICE_ATTR_RO(sas_ncq_prio_supported);
>> +
>> +static ssize_t sas_ncq_prio_enable_show(struct device *device,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	struct scsi_device *sdev = to_scsi_device(device);
>> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
>> +	int res;
>> +
>> +	// This attribute shall be visible for SATA devices only
>> +	if (WARN_ON(!dev_is_sata(ddev)))
>> +		return -EINVAL;
>> +
>> +	res = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev);
>> +	if (res < 0)
>> +		return res;
>> +
>> +	return sysfs_emit(buf, "%u\n", res);
>> +}
>> +
>> +static ssize_t sas_ncq_prio_enable_store(struct device *device,
>> +					 struct device_attribute *attr,
>> +					 const char *buf, size_t len)
>> +{
>> +	struct scsi_device *sdev = to_scsi_device(device);
>> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
>> +	long input;
>> +	int res;
>> +
>> +	// This attribute shall be visible for SATA devices only
>> +	if (WARN_ON(!dev_is_sata(ddev)))
>> +		return -EINVAL;
>> +
>> +	res = kstrtol(buf, 10, &input);
> 
> I think that kstrtobool_from_user() could be used. But 
> kstrtobool_from_user() handles more than 0/1, so that would be a 
> different behaviour, so maybe better not to use.
> 
> I would also suggest factor out some of ata_ncq_prio_enable_store() with 
> this, but a public API which accepts char * would be a bit odd.

kstrtobool() is I think the standard way of parsing bool sysfs attributes.

> 
> 
>> +	if (res)
>> +		return res;
>> +	if ((input < 0) || (input > 1))
>> +		return -EINVAL;
>> +
>> +	return ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, input) ? : len;
> 
> Please don't use ternary operator like this. This seems more 
> straightforfward:
> 
> res = ata_ncq_prio_enable();
> if (res)
> 	return res;
> return len;
> 
>> +}
>> +static DEVICE_ATTR_RW(sas_ncq_prio_enable);
>> +
>> +static struct attribute *sas_ata_sdev_attrs[] = {
>> +	&dev_attr_sas_ncq_prio_supported.attr,
>> +	&dev_attr_sas_ncq_prio_enable.attr,
>> +	NULL
>> +};
>> +
>> +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
>> +				       struct attribute *attr, int i)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct scsi_device *sdev = to_scsi_device(dev);
>> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
>> +
>> +	if (!dev_is_sata(ddev))
>> +		return 0;
>> +
>> +	return attr->mode;
>> +}
>> +
>> +const struct attribute_group sas_ata_sdev_attr_group = {
>> +	.attrs = sas_ata_sdev_attrs,
>> +	.is_visible = sas_ata_attr_is_visible,
>> +};
>> +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
>> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
>> index 2f8c719840a6..cded782fdf33 100644
>> --- a/include/scsi/sas_ata.h
>> +++ b/include/scsi/sas_ata.h
>> @@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
>>   int sas_discover_sata(struct domain_device *dev);
>>   int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
>>   		    struct domain_device *child, int phy_id);
>> +
>> +extern const struct attribute_group sas_ata_sdev_attr_group;
>>   #else
>>   
>>   static inline void sas_ata_disabled_notice(void)
>> @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>>   	sas_ata_disabled_notice();
>>   	return -ENODEV;
>>   }
>> +
>> +static const struct attribute_group sas_ata_sdev_attr_group = {
>> +	.attrs = NULL,
>> +};
>>   #endif
>>   
>>   #endif /* _SAS_ATA_H_ */
> 

-- 
Damien Le Moal
Western Digital Research


