Return-Path: <linux-kernel+bounces-73314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF685C0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB181F218EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C488763F6;
	Tue, 20 Feb 2024 16:12:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AB768FA;
	Tue, 20 Feb 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445560; cv=none; b=Aohs+BqGzUSwtPO0qXZkTN7uFrCZiSjKUl39rI5u1ie0cgP25l3Sv7ksdWG+orBMQF08rQDXp8PiN6CS48Xc5g9fRtsAjq+VQG86X7Dd/WwJN8yGFp5jp48d39xpx2yteburfhWICqOnHMShV2RIDLQoTeEToHKE5QfLD79vcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445560; c=relaxed/simple;
	bh=WZwcnRFd8AxpgMn/ncUH7HuyNVf1CJoD2fIOANFeZdk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAE2XePKwjdm8jTqf2SuZMcjLPq6SBGDyTE7JYUpA1mxtsb8m8R3Qgtf5aEqS/rhPXydnj7DYWveMs2VxtVDSpZLH9hlSLXu7NF62sCTQdphXjPicnBlxZ2SPemmLyxkV4LUQ8buSs0gSkc586KIYQm5IegNSSb3ONZ1wthic+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfPTZ58hwz6K635;
	Wed, 21 Feb 2024 00:08:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9642140B54;
	Wed, 21 Feb 2024 00:12:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 16:12:33 +0000
Date: Tue, 20 Feb 2024 16:12:32 +0000
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
Subject: Re: [RFC PATCH v6 12/12] memory: RAS2: Add memory RAS2 driver
Message-ID: <20240220161232.00000496@Huawei.com>
In-Reply-To: <20240215111455.1462-13-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-13-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:54 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Memory RAS2 driver binds to the platform device add by the ACPI RAS2
> driver.
> Driver registers the PCC channel for communicating with the ACPI compliant
> platform that contains RAS2 command support in the hardware.
>=20
> Add interface functions to support configuring the parameters of HW patrol
> scrubs in the system, which exposed to the kernel via the RAS2 and PCC,
> using the RAS2 commands.
>=20
> Add support for RAS2 platform devices to register with scrub subsystem
> driver. This enables user to configure the parameters of HW patrol scrubs,
> which exposed to the kernel via the RAS2 table, through the scrub sysfs
> attributes.
>=20
> Open Question:
> Sysfs scrub control attribute "enable_background_scrub" is added for RAS2,
> based on the feedback from Bill Schwartz <wschwartz@amperecomputing.com
> on v4 to enable/disable the background_scrubbing in the platform as defin=
ed in the
> =E2=80=9CConfigure Scrub Parameters [INPUT]=E2=80=9C field  in RAS2 Table=
 5.87: Parameter Block
> Structure for PATROL_SCRUB.
> Is it a right approach to support "enable_background_scrub" in the sysfs
> scrub control?

Does anyone know what this means?  IIUC patrol scrub is always background...

>=20
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

A few minor comments inline.  Rushed review as out of time for today though
so may have missed stuff.

> diff --git a/drivers/memory/rasf_common.c b/drivers/memory/rasf_common.c
> new file mode 100644
> index 000000000000..85f67308698d
> --- /dev/null
> +++ b/drivers/memory/rasf_common.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * rasf_common.c - Common functions for memory RASF driver
> + *
> + * Copyright (c) 2023 HiSilicon Limited.
> + *
> + * This driver implements call back functions for the scrub
> + * configure driver to configure the parameters of the hw patrol
> + * scrubbers in the system, which exposed via the ACPI RASF/RAS2
> + * table and PCC.
> + */
> +
> +#define pr_fmt(fmt)     "MEMORY RASF COMMON: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

of.h Shouldn't be here in an ACPI driver!

> +#include <linux/platform_device.h>
> +
> +#include <acpi/rasf_acpi.h>
> +#include <memory/rasf.h>
> +
> +static int enable_write(struct rasf_context *rasf_ctx, long val)
> +{
> +	int ret;
> +	bool enable =3D val;
> +
> +	ret =3D rasf_ctx->ops->enable_scrub(rasf_ctx, enable);
> +	if (ret) {
> +		pr_err("enable patrol scrub fail, enable=3D%d ret=3D%d\n",
> +		       enable, ret);

dev_err(rasf_ctx->dev,...

> +		return ret;
> +	}
> +
> +	return 0;
> +}

> +
> +/**
> + * rasf_hw_scrub_is_visible() - Callback to return attribute visibility
> + * @drv_data: Pointer to driver-private data structure passed
> + *	      as argument to devm_scrub_device_register().
> + * @attr_id: Scrub attribute
> + * @region_id: ID of the memory region
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +umode_t rasf_hw_scrub_is_visible(struct device *dev, u32 attr_id, int re=
gion_id)
> +{
> +	switch (attr_id) {
> +	case scrub_rate_available:
> +		return 0444;
> +	case scrub_enable:
> +	case scrub_enable_background_scrub:
> +		return 0200;
> +	case scrub_addr_base:
> +	case scrub_addr_size:
> +	case scrub_rate:
> +		return 0644;

As before, I'd prefer to see this passed the current permissions then just
return those rather than encoding them here and in the attributes where they
may end up out of sync

> +	default:
> +		return 0;
> +	}
> +}

> +
> +/**
> + * rasf_hw_scrub_read_strings() - Read callback for string attributes
> + * @device: Pointer to scrub device
> + * @attr_id: Scrub attribute
> + * @region_id: ID of the memory region
> + * @buf: Pointer to the buffer for copying returned string
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int rasf_hw_scrub_read_strings(struct device *device, u32 attr_id, int r=
egion_id,
> +			       char *buf)

dev maybe instead of device.  Shorter lines and it's very common shorthand.

> +{
> +	struct rasf_context *rasf_ctx;
> +
> +	rasf_ctx =3D dev_get_drvdata(device);

	struct rasf_context *rasf_ctx =3D dev_get_drvdata(dev);
Same throughout.
> +
> +	switch (attr_id) {
> +	case scrub_rate_available:
> +		return rate_available_read(rasf_ctx, buf);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}



