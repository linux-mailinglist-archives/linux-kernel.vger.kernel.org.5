Return-Path: <linux-kernel+bounces-92496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F47872132
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B528788A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556286AC8;
	Tue,  5 Mar 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDj2ym1z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140886639;
	Tue,  5 Mar 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647948; cv=none; b=s+ys0Jq5HP99ESFFNpe34n4X4maDjImJko8I7V7UdXEf51Y3f+H+gOxCYfwtkdrk4M1zHs6FV04wP6oPGp4BC+j8+d/1QoE9Ib6ve67W25jDx/LFcxj+uQjc6jVgpa9zB6FnmEn1l6jRj2iho4G59wbLhUZMVR3Xmi6IZSa4pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647948; c=relaxed/simple;
	bh=EciynFnNmoUiadRqutQxONUx6zEFXfFvexv7F9i/3iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WnKkwFe0ZsyeNc1kwxjLpp25pfSPEKCDa/YMJpG/18jbpjp1gfYLlOG7z6p3rr91F0jo/YpasC4VJpKGUPbRnJdq6SixkojFlv2E1Ginfo3ZNBNOtTMeuxBAfutkr085qOV2em/paIMiYqbl9XWAGsyDd/dpXWn84SFONQqtiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDj2ym1z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709647947; x=1741183947;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=EciynFnNmoUiadRqutQxONUx6zEFXfFvexv7F9i/3iw=;
  b=KDj2ym1zVXyTGItG+AikvgHro0FXkK4cfy7hOZzZ/fTGPq+LVWp2WMp0
   SgMVM5CwcI5m5yK9WxmFOMDoIamMNAaJA2ROnFpKvjNeV7icqaolclrA5
   JIZ7eFMGNwo49vf0C71w+hH3Zqpe4/6LO4K6V7tSb8o8JmP/k3OzemZ4U
   3joPIIQWXpxS57acJYZ0pFHLXAxtm/EmkLcl8IfD1o9OKVFwCYNmMjhZM
   9D59ETRBGi4LE0khjHVNqpgAmJtgRRJ9/dol3ivEuthkb/W+Q0l15lm/A
   1gAnYIbaojh6qzCOO0Hjzk1y6URBRLgvydw3ff0URQ7+4YlsL1BYBIZTT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21658967"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21658967"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9815474"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:12:26 -0800
Message-ID: <4546eb10-0a97-4df7-b0d1-4e76f5121f35@linux.intel.com>
Date: Tue, 5 Mar 2024 06:12:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240305121315.1744363-1-aichao@kylinos.cn>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240305121315.1744363-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 4:13 AM, Ai Chao wrote:
> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi

/s/notifyi/notification/

>  when the button pressed.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---

Other than this, it looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>
>  drivers/platform/x86/Kconfig             |  12 +++
>  drivers/platform/x86/Makefile            |   1 +
>  drivers/platform/x86/lenovo-wmi-camera.c | 118 +++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..079f5aa5910c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>  	To compile this driver as a module, choose M here: the module
>  	will be called inspur-platform-profile.
>  
> +config LENOVO_WMI_CAMERA
> +	tristate "Lenovo WMI Camera Button driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  This driver provides support for Lenovo camera button. The Camera
> +	  button is a GPIO device. This driver receives ACPI notify when the
> +	  button pressed.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called lenovo-wmi-camera.
> +
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>  
>  config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1de432e8861e..217e94d7c877 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
>  
>  # Intel
>  obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform/x86/lenovo-wmi-camera.c
> new file mode 100644
> index 000000000000..77084266829c
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lenovo WMI Camera Button Driver
> + *
> + * Author: Ai Chao <aichao@kylinos.cn>
> + * Copyright (C) 2024 KylinSoft Corporation.
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
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +	struct device *dev;
> +	u8 camera_mode;
> +};
> +
> +enum {
> +	CAMERA_BUTTON_PRESSED = 1,
> +};
> +
> +static ssize_t camerabutton_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", priv->camera_mode);
> +}
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
> +	if (obj->type == ACPI_TYPE_BUFFER &&
> +	    obj->buffer.pointer[0] <= CAMERA_BUTTON_PRESSED) {
> +		/* Camera mode:
> +		 *      0 camera close
> +		 *      1 camera open
> +		 */
> +		priv->camera_mode = obj->buffer.pointer[0];
> +
> +		input_report_key(priv->idev, KEY_CAMERA, 1);
> +		input_sync(priv->idev);
> +		input_report_key(priv->idev, KEY_CAMERA, 0);
> +		input_sync(priv->idev);
> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);
> +	}
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lenovo_wmi_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	priv->idev = devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name = "Lenovo WMI Camera Button";
> +	priv->idev->phys = "wmi/input0";
> +	priv->idev->id.bustype = BUS_HOST;
> +	priv->idev->dev.parent = &wdev->dev;
> +	set_bit(EV_KEY, priv->idev->evbit);
> +	set_bit(KEY_CAMERA, priv->idev->keybit);
> +
> +	return input_register_device(priv->idev);
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] = {
> +	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver lenovo_wmi_driver = {
> +	.driver = {
> +		.name = "lenovo-wmi-camera",
> +		.dev_groups = lenovo_wmi_groups,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lenovo_wmi_id_table,
> +	.no_singleton = false,
> +	.probe = lenovo_wmi_probe,
> +	.notify = lenovo_wmi_notify,
> +};
> +
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");
> +MODULE_LICENSE("GPL");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


