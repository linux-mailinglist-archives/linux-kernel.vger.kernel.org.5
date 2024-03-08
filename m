Return-Path: <linux-kernel+bounces-96688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AC876002
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4742B1F216FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3B52F95;
	Fri,  8 Mar 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyBmVid6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83519535C8;
	Fri,  8 Mar 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887491; cv=none; b=oaZLhLvpVmYYD95cX3di8KtFfXq3WePwq7vXNibl21u7NODIWMcb4ogdCtEus6FieqN+KOwmocv7gAKXQUko2Y3yMm6vmybVEmyQgkeRedXAu1Q75xOq/4LFEJcNqwLpBSLJ3aj8a8sxcyAA8KwS9kU9eYYa+F6Y4lWHP9FlGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887491; c=relaxed/simple;
	bh=MqTFq+pTP6o+klH+NTFFyqhWNYws6ibOnKBQpzbhvN8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i9lmVeuSROqm0Eux1GWan81ogPhrsilLAyWiZeX5632xVpbNy1SbaheGPxJjk+GEKkKqcZGgNAFIMHA0nGdLlKIU7bkJd4SmQHch6AmaFTaKzHUJDwgautLq8OYT4rC5Cd4HpwxSS/4GvZLzpdWP8RlTlQr/ti558m+rWuDLD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyBmVid6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709887488; x=1741423488;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MqTFq+pTP6o+klH+NTFFyqhWNYws6ibOnKBQpzbhvN8=;
  b=WyBmVid6ochK6u4gGi0aDoUSU2pPd+zVJbR1bZnfWuTBax7yr+NQ5dqQ
   KHuwqLaXkonYTdsdyrYCtRTvZDL9pGtrh1V5QQmME5LsmRxFT+0GDunrH
   Tlufc3wspNDqJtw/aQB+UnnE6xDQTvVzPGjIsKjiOuKPOMgmNZBA9rTxf
   uOeMfSGsUKUbaLQxR7DgFBu8LJheZtgAorFbE8UfUpQRFAAJXf3qFllsA
   OEyc9ZMfS1VaooSdA4IY2RfMD1cmSYMGxx+PP4GCr9y0PkU3ljPemIhOy
   RPk3TaM+RWipW+be2cH8Tka5TE+ofbA9H1SwHGZUkJI3SQCxjjJ6ufPnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="16005609"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="16005609"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10810386"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:44:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 10:44:41 +0200 (EET)
To: Ai Chao <aichao@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: add lenovo wmi camera button driver
In-Reply-To: <20240307085939.668881-1-aichao@kylinos.cn>
Message-ID: <13940666-caab-8bde-d76e-231de9ee4f5c@linux.intel.com>
References: <20240307085939.668881-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Mar 2024, Ai Chao wrote:

> Add lenovo generic wmi driver to support camera button.
> The Camera button is a GPIO device. This driver receives ACPI notifyi
> when the camera button is switched on/off. This driver is used in
> Lenovo A70, it is a Computer integrated machine.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
> v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
> v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
> v3: Remove lenovo_wmi_remove function.
> v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> 
>  drivers/platform/x86/Kconfig             | 12 ++++
>  drivers/platform/x86/Makefile            |  1 +
>  drivers/platform/x86/lenovo-wmi-camera.c | 89 ++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..9506a455b547 100644
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
> index 000000000000..571d67ade8ac
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> @@ -0,0 +1,89 @@
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
> +
> +	if (obj->type == ACPI_TYPE_BUFFER &&
> +	    obj->buffer.pointer[0] <= SW_CAMERA_ON) {
> +		/* obj->buffer.pointer[0] is camera mode:
> +		 *      0 camera close
> +		 *      1 camera open
> +		 */
> +		input_report_switch(priv->idev, SW_CAMERA_LENS_COVER,
> +				    obj->buffer.pointer[0]);
> +		input_sync(priv->idev);
> +	} else {
> +		dev_dbg(&wdev->dev, "Bad response type %d\n", obj->type);

This message seems to assume camera mode is on the valid range. Wouldn't 
it be useful from debugging point of view to show also the camera mode 
value?

-- 
 i.


