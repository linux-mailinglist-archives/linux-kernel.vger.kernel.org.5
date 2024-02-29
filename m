Return-Path: <linux-kernel+bounces-86718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B586C992
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F381C21A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1487E562;
	Thu, 29 Feb 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElfHR17R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1C7D416;
	Thu, 29 Feb 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211395; cv=none; b=XVQNaF0RtgnqJcreOOdy+BDTJc2Yx/D3Uk/uFfWmfTPKa3g5K/DHvfaK+fopUW15iBfGeh2hI5On5IIXtYLXYTdB0VkoXSYmp0k3AwTpfzZTITh/eYg7qnlHTkXtO4/Yt5thyUw0f7pxer0VZmfo0kHIwqMsCNjMUO2jWXB2tQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211395; c=relaxed/simple;
	bh=pgsvPNUAxL+aM5+vr4VnC2UxbIowObaRoVXvXN5548o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xbpm0aunLuIaDQakEovoEu4EyfLabb0gBxHFQdnMO8B2LoNLfnSUuIZiPr8r7kgRwdFCTD0GMo8JQRbAsiMNjoWPNlZhHOXKGY+UsJkoiqNVAyyRPIzmyNg6j2gQ4zm3hri13QVGmU3HLycuFtZncgCsnCTF6k7J85j8Xd813po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElfHR17R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709211394; x=1740747394;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pgsvPNUAxL+aM5+vr4VnC2UxbIowObaRoVXvXN5548o=;
  b=ElfHR17RW4GRvUyv9lQmAf0EN6ERyF2n9wigKPZhdCz6o8xmgo3ZNB/n
   kFGAiVEwkiXTtopXtJWC8EJiHI4qmPMkgTp5I+VpkBasRAZIkXHIaoJw/
   1y3KPG8s4dBqvP/PgCkrxJRS2dlC8bm4KkAaS5XcUc3AIzJCwVEoXv/CL
   QE+rGjnELre7W5jx1YsJcyRvmI5lIh81ucwPeWiOlefSmkXn1uKmAjR/6
   bqUx5SNjJeCfEUb4bcIjmhHi0M/ymq7oII16tWx4GMxozlEWK+CJB/wPf
   p5UVHHC4E9LFTjvlK6TXcszZKw46fX2eBEWZ2yvp/m2P/CR/hul3+UnPx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4258242"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="4258242"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38851967"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:56:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Feb 2024 14:56:26 +0200 (EET)
To: Ai Chao <aichao@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: add lenovo generic wmi driver
In-Reply-To: <20240229051621.12341-1-aichao@kylinos.cn>
Message-ID: <5ec35cea-ae5f-de50-41ce-08276f053a51@linux.intel.com>
References: <20240229051621.12341-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Feb 2024, Ai Chao wrote:

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

sysfs_emit()

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

"GPL" is enough for MODULE_LICENSE, more specific information is given 
only within the SPDX header.

-- 
 i.


