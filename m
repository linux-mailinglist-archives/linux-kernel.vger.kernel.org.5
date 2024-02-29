Return-Path: <linux-kernel+bounces-86192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC686C141
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6A01F21471
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021F3D388;
	Thu, 29 Feb 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijlTkJMd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3F4438E;
	Thu, 29 Feb 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189192; cv=none; b=HCe7e9LAlJPRzhH9e1HhXej36ZH+2/hNR5x2zupAS+WfLaFbC/ELRBZdMW1ApmnXDGt4ORvjDDLlqzdqnLrT7QAzqGjmiEIJcQ9QU+7arAJRIznQMevtiv88zJnTGcaBNSmoeYmvyxKnImLQRWyxkThrvfBh1Md0o27yLyvo0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189192; c=relaxed/simple;
	bh=wLx74cxDos7PYxlETX7eEY2HrA5tgmRwY2rfBPbGBKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JoNvCL+ODPuPBFcjOovMMpGt7YeDbacerCKZuBHR8i5Ntq14jo25147vgvzgIm2AlGSXM2hIHvEtiV35kpNWPt5eLwKGTEUcVQmn5AfiqwHYFNT2v6PemT7yVuV94IRey4AVN5UFCTH/XJMSZfDTSpRY3wmwuWbC52U5CZf6o/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijlTkJMd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709189191; x=1740725191;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wLx74cxDos7PYxlETX7eEY2HrA5tgmRwY2rfBPbGBKY=;
  b=ijlTkJMdCXXDTweWCRLMWaulA24FhzPsV2AfZ4JIO4DIKTKhZ4OGQvcH
   2SxllLDZXuwzmU7qlPa+mdCu/wVntVy5eqzGo8wY4F4kmmWHStxMCNMVK
   wq39TTM7KAY9CRNQ6aJCmZi8J16sMEqnG+BXJWQld8fNbcpA5AWgLxQbg
   fiEnUFLYdmLkh+6mdqQAZGTsNTknHdslCSfy6dUzYtiu06nh9cGLAAO9g
   3fYkMarkWnkWjSRW4DKlD3FJvV2SegxNPtq1ZwWhpciSTd3jskTHb5BX5
   2HMsmwafnBePzq2810KLUAEr8lvC8xyB7OTA391GEDfgoC/VpEfpfryqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3486504"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3486504"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12373836"
Received: from smitpat1-mobl.amr.corp.intel.com (HELO [10.209.30.182]) ([10.209.30.182])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:46:30 -0800
Message-ID: <a7b70317-7734-4e36-b79a-7cfeaf664f3b@linux.intel.com>
Date: Wed, 28 Feb 2024 22:46:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: add lenovo generic wmi driver
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240229051621.12341-1-aichao@kylinos.cn>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240229051621.12341-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/24 9:16 PM, Ai Chao wrote:
> Add lenovo generic wmi driver to support camera button.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/platform/x86/Kconfig      |  10 +++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/lenovo-wmi.c | 121 ++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..fbbb8fb843d7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1001,6 +1001,16 @@ config INSPUR_PLATFORM_PROFILE
>  	To compile this driver as a module, choose M here: the module
>  	will be called inspur-platform-profile.
>  
> +config LENOVO_WMI
> +	tristate "Lenovo Geneirc WMI driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	This driver provides support for Lenovo WMI driver.
> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called lenovo-wmi.
> +
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>  
>  config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1de432e8861e..d51086552192 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
> +obj-$(CONFIG_LENOVO_WMI)	+= lenovo-wmi.o
>  
>  # Intel
>  obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/lenovo-wmi.c
> new file mode 100644
> index 000000000000..e8b1c401b53e
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Lenovo Generic WMI Driver
> + *
> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
2024 ?
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> +
> +static u8 camera_mode;
> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +};
> +
> +static ssize_t camerabutton_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%u\n", camera_mode);
> +}
> +
> +DEVICE_ATTR_RO(camerabutton);
> +
> +static struct attribute *lenovo_wmi_attrs[] = {
> +	&dev_attr_camerabutton.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group lenovo_wmi_group = {
> +	.attrs = lenovo_wmi_attrs,
> +};
> +
> +const struct attribute_group *lenovo_wmi_groups[] = {
> +	&lenovo_wmi_group,
> +	NULL,
> +};
> +
> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	if (obj->type == ACPI_TYPE_BUFFER) {
> +		camera_mode = obj->buffer.pointer[0];
> +		input_report_key(priv->idev, KEY_CAMERA, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA, 0);
> +		input_sync(priv->idev);
> +	} else {
> +		dev_info(&wdev->dev, "Bad response type %d\n", obj->type);
Does it needs to be dev_info? I don't think this affects the driver functionality, right?

May be dev_dbg() is better here?
> +	}
> +}
> +
> +static int lenovo_wmi_input_setup(struct wmi_device *wdev)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	priv->idev = devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name = "Lenovo WMI Camera Button";
> +	priv->idev->phys = "wmi/input0";
> +	priv->idev->id.bustype = BUS_HOST;
> +	priv->idev->dev.parent = &wdev->dev;
> +	priv->idev->evbit[0] = BIT_MASK(EV_KEY);
> +	priv->idev->keybit[BIT_WORD(KEY_CAMERA)] = BIT_MASK(KEY_CAMERA);
> +
> +	return input_register_device(priv->idev);
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lenovo_wmi_priv *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(struct lenovo_wmi_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	err = lenovo_wmi_input_setup(wdev);
> +	return err;
> +}
> +
> +static void lenovo_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	input_unregister_device(priv->idev);

Since you use devm_input_allocate_device() for allocation, you don't need to explicitly unregister the device.
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] = {
> +	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver lenovo_wmi_driver = {
> +	.driver = {
> +		.name = "lenovo-wmi",
> +		.dev_groups = lenovo_wmi_groups,
> +	},
> +	.id_table = lenovo_wmi_id_table,
> +	.probe = lenovo_wmi_probe,
> +	.notify = lenovo_wmi_notify,
> +	.remove = lenovo_wmi_remove,
> +};
> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
> +MODULE_LICENSE("GPL v2");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


