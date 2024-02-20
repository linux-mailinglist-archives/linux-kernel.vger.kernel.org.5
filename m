Return-Path: <linux-kernel+bounces-73032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5185BC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB18C285E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87DE6A036;
	Tue, 20 Feb 2024 12:39:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADF657C4;
	Tue, 20 Feb 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432770; cv=none; b=XIibA1GNrdBHddIkWPxvAcFNz96bUfke10UkNkuAgWz4AQ8f0fzd+2HDih+r42gThGNnYGkWRXKep4UlQMoD30NYueCeaP+5vffGsD7UdPrx8VyEYobOCOzJZl8w8AeoxyeTsc2IceKyKtiXoo2S9J7dOIbWBBPsMKlJYWrIlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432770; c=relaxed/simple;
	bh=N34O3pudop+pKbhAnYHcokmzPaG4OYBsYjjNSgGGsCs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLTcvFU72qfRKmKKYkTzYJX3lsUoKAPi9GQWX5fAJRGVS2mzgmW4Uy8nRUJhq8R+dyVJce2XjvwK7FElPlEFryUdMGybZ/AGOTU/erccLaHLMbIx+MdII348mXdesgToK6fdJbkbh+P6Keg7bGbGkOIZtYR9CVynueMzZ1O3ltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfJm54fYvz67l0C;
	Tue, 20 Feb 2024 20:35:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F78F14163B;
	Tue, 20 Feb 2024 20:39:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 12:39:23 +0000
Date: Tue, 20 Feb 2024 12:39:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 06/12] memory: scrub: Add scrub subsystem driver
 supports configuring memory scrubs in the system
Message-ID: <20240220123922.00007142@Huawei.com>
In-Reply-To: <20240215111455.1462-7-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-7-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add scrub driver supports configuring the memory scrubs in the system.
> The scrub driver provides the interface for registering the scrub devices
> and supports configuring memory scrubs in the system.
> Driver exposes the sysfs scrub control attributes to the user in
> /sys/class/scrub/scrubX/regionN/
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

A few minor things inline.  Given I reviewed this internally I don't
have that much to add!

Jonathan

> ---
>  .../ABI/testing/sysfs-class-scrub-configure   |  91 +++++
>  drivers/memory/Kconfig                        |   1 +
>  drivers/memory/Makefile                       |   1 +
>  drivers/memory/scrub/Kconfig                  |  11 +
>  drivers/memory/scrub/Makefile                 |   6 +
>  drivers/memory/scrub/memory-scrub.c           | 367 ++++++++++++++++++
>  include/memory/memory-scrub.h                 |  78 ++++
>  7 files changed, 555 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
>  create mode 100644 drivers/memory/scrub/Kconfig
>  create mode 100644 drivers/memory/scrub/Makefile
>  create mode 100755 drivers/memory/scrub/memory-scrub.c
>  create mode 100755 include/memory/memory-scrub.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Documentation/ABI/testing/sysfs-class-scrub-configure
> new file mode 100644
> index 000000000000..d2d422b667cf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure

> +What:		/sys/class/scrub/scrubX/regionN/rate_available
> +Date:		January 2024
> +KernelVersion:	6.8
> +Contact:	linux-kernel@vger.kernel.org
> +Description:
> +		(RO) Supported range for the scrub rate)
> +		by the scrubber for a memory region.
> +		The unit of the scrub rate vary depends on the scrub.
Not good to have a unit that is dependent on scrub. We need to figure
out how to either define that, or provide an interface to expose it
to userspace and make it a userspace tool problem.



> diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
> new file mode 100755
> index 000000000000..a160b7a047e4
> --- /dev/null

> +SCRUB_ATTR_RW(addr_base);
> +SCRUB_ATTR_RW(addr_size);
> +SCRUB_ATTR_RW(enable);
> +SCRUB_ATTR_RW(enable_background_scrub);
> +SCRUB_ATTR_RW(rate);
> +SCRUB_ATTR_RO(rate_available);
> +
> +static struct attribute *scrub_attrs[] = {
> +	&dev_attr_addr_base.attr,
> +	&dev_attr_addr_size.attr,
> +	&dev_attr_enable.attr,
> +	&dev_attr_enable_background_scrub.attr,
> +	&dev_attr_rate.attr,
> +	&dev_attr_rate_available.attr,
> +	NULL,
no comma
> +};
> +
> +static struct device *
> +scrub_device_register(struct device *dev, const char *name, void *drvdata,
> +		      const struct scrub_ops *ops,
> +		      int region_id,
> +		      struct attribute_group *attr_group)
> +{
> +	struct scrub_device *scrub_dev;
> +	struct device *hdev;
> +	int err;
> +
> +	scrub_dev = kzalloc(sizeof(*scrub_dev), GFP_KERNEL);
> +	if (!scrub_dev)
> +		return ERR_PTR(-ENOMEM);
> +	hdev = &scrub_dev->dev;
> +
> +	scrub_dev->id = ida_alloc(&scrub_ida, GFP_KERNEL);
> +	if (scrub_dev->id < 0) {
> +		kfree(scrub_dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	snprintf((char *)scrub_dev->region_name, SCRUB_MAX_SYSFS_ATTR_NAME_LENGTH,
> +		 "region%d", region_id);
> +	if (attr_group) {

I'd like a comment on this. Not immediately obvious what this parameter is to me,
or when we would and wouldn't have one.

> +		attr_group->name = (char *)scrub_dev->region_name;
> +		scrub_dev->groups[0] = attr_group;
> +		scrub_dev->region_id = region_id;
> +	} else {
> +		scrub_dev->group.name = (char *)scrub_dev->region_name;

In both paths, drop out of if / else

> +		scrub_dev->group.attrs = scrub_attrs;
> +		scrub_dev->group.is_visible = scrub_attr_visible;
> +		scrub_dev->groups[0] = &scrub_dev->group;
> +		scrub_dev->ops = ops;
> +		scrub_dev->region_id = region_id;
Set in both paths, so drop out of the if / else;
> +	}
> +
> +	hdev->groups = scrub_dev->groups;
> +	hdev->class = &scrub_class;
> +	hdev->parent = dev;
> +	dev_set_drvdata(hdev, drvdata);
> +	dev_set_name(hdev, SCRUB_ID_FORMAT, scrub_dev->id);
> +	snprintf(scrub_dev->name, SCRUB_DEV_MAX_NAME_LENGTH, "%s", name);
> +	err = device_register(hdev);
> +	if (err) {
> +		put_device(hdev);
> +		return ERR_PTR(err);
> +	}
> +
> +	return hdev;
> +}
> +
> +static void devm_scrub_release(void *dev)
> +{
> +	struct device *hdev = dev;
> +
> +	device_unregister(hdev);

Trivial but local variable doesn't really add anything.
	deivce_unregister(dev);
is pretty clear on types!

> +}



> diff --git a/include/memory/memory-scrub.h b/include/memory/memory-scrub.h
> new file mode 100755
> index 000000000000..3d7054e98b9a
> --- /dev/null
> +++ b/include/memory/memory-scrub.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Memory scrub controller driver support to configure
> + * the controls of the memory scrub and enable.
> + *
> + * Copyright (c) 2023 HiSilicon Limited.
> + */
> +
> +#ifndef __MEMORY_SCRUB_H
> +#define __MEMORY_SCRUB_H
> +
> +#include <linux/types.h>
> +
> +enum scrub_types {
> +	scrub_common,
> +	scrub_max,
No comma on a terminating entry like this.
> +};


