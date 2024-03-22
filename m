Return-Path: <linux-kernel+bounces-111799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CE88711D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32E1283D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680C5D720;
	Fri, 22 Mar 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKzaoAzA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6C54FB0;
	Fri, 22 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126038; cv=none; b=ZeQHmUNYugGdRPLAevgvy19+0mnTv48vZRsm+WUD2jIXpWa/72/LQRhY+ade3ldMMB0hYeqkhXzHCPfuhQqVZGNyEu/fmYKcp5NPinE2qNM2FVFJFkQS1cFKOybatZZTlpha476EGycLSfaSXyndnjVP6fPYH20QVgQoMDJd9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126038; c=relaxed/simple;
	bh=2CZHEstLXG1DMqTlSHtgE/KBvKBMnEXKVMqVf1QdFS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0Z7LU2lFhX6PozcFBfMb2cVL2KWWeYPPtp18Zb712PGXTZ7VPqyu381JqmRQRwjnymC+YISKSm5LjBb0uRuivy/qIQ62cRoHNqRTpNH4JdzRvVczFxDhf7sp6fVfuReabgOY6v2EHTcUsfaNlWO2WlcqQg8c2c7O+KFO9Q63Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKzaoAzA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711126036; x=1742662036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2CZHEstLXG1DMqTlSHtgE/KBvKBMnEXKVMqVf1QdFS8=;
  b=JKzaoAzAr3ua3D1c0aXXzTvhqa4xut96SLMdLREQzwupHlQlUVlZuoYo
   mQ8A9xfKCrOHn8Tj5y0AcoE8Yg506idJyTle8SMTnhes9wWvG0Tq+Lqvu
   o6eepab3J7aG539JNPADmQI/6FiuAka9Yrg1dUaiXc/sX4i7+nquiRTt/
   hf8ibvwwMTKQCphadooXmoygAkZS6dqIrCmFePLZE0eRCSBfeImlzcnSG
   tU636GS3X++7mh/2ZWA1vWz+aqXF3LhY1CaWDqc2u57KgoTgiI0Plm64s
   4lV2os0Mc9P/6DBB+6dvBY63RyMML1xf6cy6ydYMP5VP5Vv7PSuNSWSrz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16911042"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16911042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19641786"
Received: from sgreig-mobl1.amr.corp.intel.com (HELO [10.209.63.173]) ([10.209.63.173])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:47:14 -0700
Message-ID: <7705e36f-829b-4661-9399-496905b3d161@linux.intel.com>
Date: Fri, 22 Mar 2024 09:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ai Chao <aichao@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <20240322064750.267422-1-aichao@kylinos.cn>
 <5e30a445-0a14-4242-9c1d-578a5b7cfcbe@linux.intel.com>
 <f1421e47-a6b7-e8f1-49a0-28e3351b2450@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f1421e47-a6b7-e8f1-49a0-28e3351b2450@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/22/24 7:39 AM, Ilpo Järvinen wrote:
> On Fri, 22 Mar 2024, Kuppuswamy Sathyanarayanan wrote:
>> On 3/21/24 11:47 PM, Ai Chao wrote:
>>> Add lenovo generic wmi driver to support camera button.
>>> The Camera button is a GPIO device. This driver receives ACPI notifyi
>>> when the camera button is switched on/off. This driver is used in
>>> Lenovo A70, it is a Computer integrated machine.
>>>
>>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>>> ---
>>> v11: remove input_unregister_device.
>>> v10: Add lenovo_wmi_remove and mutex_destroy.
>>> v9: Add mutex for wmi notify.
>>> v8: Dev_deb convert to dev_err.
>>> v7: Add dev_dbg and remove unused dev in struct.
>>> v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
>>> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
>>> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
>>> v3: Remove lenovo_wmi_remove function.
>>> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
>>>
>>>  drivers/platform/x86/Kconfig             |  12 +++
>>>  drivers/platform/x86/Makefile            |   1 +
>>>  drivers/platform/x86/lenovo-wmi-camera.c | 126 +++++++++++++++++++++++
>>>  3 files changed, 139 insertions(+)
>>>  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>> index bdd302274b9a..9506a455b547 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
>>>  	To compile this driver as a module, choose M here: the module
>>>  	will be called inspur-platform-profile.
>>>  
>>> +config LENOVO_WMI_CAMERA
>>> +	tristate "Lenovo WMI Camera Button driver"
>>> +	depends on ACPI_WMI
>>> +	depends on INPUT
>>> +	help
>>> +	  This driver provides support for Lenovo camera button. The Camera
>>> +	  button is a GPIO device. This driver receives ACPI notify when the
>>> +	  camera button is switched on/off.
>>> +
>>> +	  To compile this driver as a module, choose M here: the module
>>> +	  will be called lenovo-wmi-camera.
>>> +
>>>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>>  
>>>  config FW_ATTR_CLASS
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>> index 1de432e8861e..217e94d7c877 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>>>  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>>>  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>>>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>>> +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
>>>  
>>>  # Intel
>>>  obj-y				+= intel/
>>> diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform/x86/lenovo-wmi-camera.c
>>> new file mode 100644
>>> index 000000000000..fda936e2f37c
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
>>> @@ -0,0 +1,126 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Lenovo WMI Camera Button Driver
>>> + *
>>> + * Author: Ai Chao <aichao@kylinos.cn>
>>> + * Copyright (C) 2024 KylinSoft Corporation.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/device.h>
>>> +#include <linux/input.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/wmi.h>
>>> +
>>> +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
>>> +
>>> +struct lenovo_wmi_priv {
>>> +	struct input_dev *idev;
>>> +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */
>>> +};
>>> +
>>> +enum {
>>> +	SW_CAMERA_OFF	= 0,
>>> +	SW_CAMERA_ON	= 1,
>>> +};
>>> +
>>> +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
>>> +{
>>> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>> +	unsigned int keycode;
>>> +	u8 camera_mode;
>>> +
>>> +	if (obj->type != ACPI_TYPE_BUFFER) {
>>> +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
>>> +		return;
>>> +	}
>>> +
>>> +	if (obj->buffer.length != 1) {
>>> +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
>>> +		return;
>>> +	}
>>> +
>>> +	/* obj->buffer.pointer[0] is camera mode:
>>> +	 *      0 camera close
>>> +	 *      1 camera open
>>> +	 */
>>> +	camera_mode = obj->buffer.pointer[0];
>>> +	if (camera_mode > SW_CAMERA_ON) {
>>> +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
>>> +		return;
>>> +	}
>>> +
>>> +	mutex_lock(&priv->notify_lock);
>>> +
>>> +	keycode = (camera_mode == SW_CAMERA_ON ?
>>> +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
>>> +	input_report_key(priv->idev, keycode, 1);
>>> +	input_sync(priv->idev);
>>> +	input_report_key(priv->idev, keycode, 0);
>>> +	input_sync(priv->idev);
>>> +
>>> +	mutex_unlock(&priv->notify_lock);
>>> +}
>>> +
>>> +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
>>> +{
>>> +	struct lenovo_wmi_priv *priv;
>>> +	int ret;
>>> +
>>> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_set_drvdata(&wdev->dev, priv);
>>> +
>>> +	priv->idev = devm_input_allocate_device(&wdev->dev);
>>> +	if (!priv->idev)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->idev->name = "Lenovo WMI Camera Button";
>>> +	priv->idev->phys = "wmi/input0";
>>> +	priv->idev->id.bustype = BUS_HOST;
>>> +	priv->idev->dev.parent = &wdev->dev;
>>> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
>>> +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE);
>>> +
>>> +	ret = input_register_device(priv->idev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mutex_init(&priv->notify_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void lenovo_wmi_remove(struct wmi_device *wdev)
>>> +{
>>> +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>> +
>>> +	mutex_destroy(&priv->notify_lock);
>> Do you really need to call mutex_destroy() during the module unload?
>>
>> I don't think kernel allocates any memory during mutex_init() that needs
>> be freed.
> Is all debug code going to be happy if it's not called?
>
I am not aware of any issue. Do you have any details about it?

From the comments, it looks like mutex_destroy() is used to mark a
mutex unusable. Not sure why we need to mark a device priv lock
unusable during the unload process.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


