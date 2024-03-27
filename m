Return-Path: <linux-kernel+bounces-122190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09488F341
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A5329E98D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBA14D45B;
	Wed, 27 Mar 2024 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFNFZuFX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AED1DA4E;
	Wed, 27 Mar 2024 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582535; cv=none; b=AoqP5RbVKHBP4cgirzxCxqJtA/hUZG2jqLeUfKxomGvFbsgKDhCppnpDNgLBCcGaEx3CPGrE2RgNJD95q6wuHfzN0qIHF0e8yyb3JQN7CoWqWsCvWMQbRfL/tF9f/JF3Y0uREmGeGMrM7lqWI2HevcwwW+x9muQWsyFUUT8KOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582535; c=relaxed/simple;
	bh=nC6dfeB6wyfkKtUr3Puvtr22q26F+k+9UxHv9Fcdlzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJNs3pySM74cwrUmnJhbs1piI6ClFNdmKb3inig+tNkkcqTRnJqhBgHCAMRBHhfmZ1vP8cZkq/5mrIOidhSY+UyaQw4wOpIz0xcvic82dOH1a+mM3Cs5EwXnTMO494//XxaGzKS92CirXzBWKfTvooMQlW4b34f4Ks01cMQ/giQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFNFZuFX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711582534; x=1743118534;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nC6dfeB6wyfkKtUr3Puvtr22q26F+k+9UxHv9Fcdlzw=;
  b=eFNFZuFXinYNDY9A7lJV26j5yaevat37PA6dJWMK3dNF3ufpGjB/1gjh
   7UXMuNidWSpdTX6l021JW8crdUd1/00KvziJSXcspaEuuyRoFKNnKSSnK
   ljdOv5E1ED0FIU/rUO38gbHJuNDIGSsmn3GIU4PsGC7cZM9kLwrcWBIZs
   8ZmwIUvrKHCzb3ykbQk5o1N2671cbWjq/QKYujSN8sywodYWNHGwez+7w
   RT6hk8PCFu0pB6HJI71diK23kRMeW/YdFg9fF/TLbkCz8y/c9pTOtnZZj
   rbe8dd0FmC1z3Sn43Q+rHw7JseBknWeMn2MzmJGaBBI4akGGHLWDpYivE
   Q==;
X-CSE-ConnectionGUID: otfVMNieQX2vraOYePjjyQ==
X-CSE-MsgGUID: rjqn/g6aQYau/WgRzltt4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6828441"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6828441"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16532685"
Received: from soralee-mobl1.amr.corp.intel.com (HELO [10.255.228.178]) ([10.255.228.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:35:33 -0700
Message-ID: <3552cb41-88b2-41c0-b327-a1aefe508e14@linux.intel.com>
Date: Wed, 27 Mar 2024 16:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] platform/x86: add lenovo WMI camera button driver
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240327082737.336992-1-aichao@kylinos.cn>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240327082737.336992-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/27/24 1:27 AM, Ai Chao wrote:
> Add lenovo WMI camera button driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi

/s/notifyi/notification

> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v12: Remove useless parentheses and unneeded blank line.
> v11: Remove input_unregister_device.
> v10: Add lenovo_wmi_remove and mutex_destroy.
> v9: Add mutex for wmi notify.
> v8: Dev_deb convert to dev_err.
> v7: Add dev_dbg and remove unused dev in struct.
> v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>
>  drivers/platform/x86/Kconfig             |  12 +++
>  drivers/platform/x86/Makefile            |   1 +
>  drivers/platform/x86/lenovo-wmi-camera.c | 127 +++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7e9251fc3341..b8c806506423 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -996,6 +996,18 @@ config INSPUR_PLATFORM_PROFILE
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

/s/notify/notification

> +	  camera button is switched on/off.
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
> index 000000000000..0c0bedaf7407
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,127 @@
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
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> +
> +struct lenovo_wmi_priv {
> +	struct input_dev *idev;
> +	struct mutex notify_lock;	/* lenovo WMI camera button notify lock */
> +};
> +
> +enum {
> +	SW_CAMERA_OFF	= 0,
> +	SW_CAMERA_ON	= 1,
> +};
> +
> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +	unsigned int keycode;
> +	u8 camera_mode;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> +		return;
> +	}
> +
> +	if (obj->buffer.length != 1) {
> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
> +		return;
> +	}
> +
> +	/*
> +	 * obj->buffer.pointer[0] is camera mode:
> +	 *      0 camera close
> +	 *      1 camera open
> +	 */
> +	camera_mode = obj->buffer.pointer[0];
> +	if (camera_mode > SW_CAMERA_ON) {
> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
> +		return;
> +	}
> +
> +	mutex_lock(&priv->notify_lock);
> +
> +	keycode = camera_mode == SW_CAMERA_ON ?
> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE;
> +	input_report_key(priv->idev, keycode, 1);
> +	input_sync(priv->idev);
> +	input_report_key(priv->idev, keycode, 0);
> +	input_sync(priv->idev);
> +
> +	mutex_unlock(&priv->notify_lock);
> +}
> +
> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lenovo_wmi_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
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
> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE);
> +
> +	ret = input_register_device(priv->idev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&priv->notify_lock);
> +
> +	return 0;
> +}
> +
> +static void lenovo_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	mutex_destroy(&priv->notify_lock);
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_id_table[] = {
> +	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> +	{  }
> +};
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +
> +static struct wmi_driver lenovo_wmi_driver = {
> +	.driver = {
> +		.name = "lenovo-wmi-camera",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lenovo_wmi_id_table,
> +	.no_singleton = true,
> +	.probe = lenovo_wmi_probe,
> +	.notify = lenovo_wmi_notify,
> +	.remove = lenovo_wmi_remove,
> +};
> +module_wmi_driver(lenovo_wmi_driver);
> +
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo WMI Camera Button Driver");
> +MODULE_LICENSE("GPL");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


