Return-Path: <linux-kernel+bounces-104373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59987CCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6C31F22670
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2A1BC5B;
	Fri, 15 Mar 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKDpKMeg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47E1BC4D;
	Fri, 15 Mar 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503526; cv=none; b=sSuIUVoyUcV5fPbfXs7l1BsG2GcCDqaNmcYprm8Mdf2JSxasw8yRJYLgn9KbgSXAYXUsKdhsxkWvcGoh2Zb5UdDxMQO8s2GEE4LeaDh9IilV4lI9wKOXLKj6QKt4ZvZYRpeujMzuqEM0whhVghNM2sk/HHt+OSOQAyitqKMqSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503526; c=relaxed/simple;
	bh=MalpUJCGMtXkM7cvXquJW764LpDyjJ0+4p2n0n/oTu4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TS8/XqyAM68WzIlxP8jhxGWZqBfrC35W4wr41dkXtbVAxR+1S2JrPj3ihW0EpvIUQy2SN7MBmAbMSi1+iQ7hM5AO838bf2pO4Ds9G53/7NqugNtHanfxrucK0iqkEZSFYgbErqHooUCoJP+ReFzMLI+vu7Hw5kbW9Ur/nUJ8OM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKDpKMeg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710503525; x=1742039525;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MalpUJCGMtXkM7cvXquJW764LpDyjJ0+4p2n0n/oTu4=;
  b=CKDpKMegDUoWoKU6pylZ/uVkaPUkQxBp2xHQNK62rVYRsjJcd8zU6ELR
   5Ki1KVkCiAjt29KuUZmherld3qVT89jLsTrCZldpiKX5PCJCGDA/ypsNe
   +EG3FnCMVZzBb0hsOG15wAe1jKmz6wgI1bm2mAR8NAZwQtqDSlb+uXCFR
   o3RiAL0tI8sGo2vLdG+Us3NtARyOqAbb80IhkF0VTeUKDn60Tq8kl3wOM
   TdlZEEmLN3XAXMWSd8G3bj+N21CRxZCMDAfoHc4q1efNKBJQTtlvMRNgJ
   Ancil0H5aSu+/zAIhhC9Kz0CSE3DKo1v6NfxLaXlUa2COxJVZDswG8PVO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="8306185"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="8306185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35772016"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:52:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Mar 2024 13:51:55 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>, Ai Chao <aichao@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8] platform/x86: add lenovo wmi camera button driver
In-Reply-To: <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de>
Message-ID: <62b54638-92eb-52e1-d4ad-074963771157@linux.intel.com>
References: <20240314050319.171816-1-aichao@kylinos.cn> <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 Mar 2024, Armin Wolf wrote:

> Am 14.03.24 um 06:03 schrieb Ai Chao:
> 
> > Add lenovo generic wmi driver to support camera button.
> > The Camera button is a GPIO device. This driver receives ACPI notifyi
> > when the camera button is switched on/off. This driver is used in
> > Lenovo A70, it is a Computer integrated machine.
> > 
> > Signed-off-by: Ai Chao <aichao@kylinos.cn>
> > ---
> > v8: Dev_deb convert to dev_err.
> > v7: Add dev_dbg and remove unused dev in struct.
> > v6: Modify SW_CAMERA_LENS_COVER to
> > KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
> > v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
> > v4: Remove lenovo_wmi_input_setup, move camera_mode into struct
> > lenovo_wmi_priv.
> > v3: Remove lenovo_wmi_remove function.
> > v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> > 
> >   drivers/platform/x86/Kconfig             |  12 +++
> >   drivers/platform/x86/Makefile            |   1 +
> >   drivers/platform/x86/lenovo-wmi-camera.c | 108 +++++++++++++++++++++++
> >   3 files changed, 121 insertions(+)
> >   create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
> > 
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index bdd302274b9a..9506a455b547 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
> >   	To compile this driver as a module, choose M here: the module
> >   	will be called inspur-platform-profile.
> > 
> > +config LENOVO_WMI_CAMERA
> > +	tristate "Lenovo WMI Camera Button driver"
> > +	depends on ACPI_WMI
> > +	depends on INPUT
> > +	help
> > +	  This driver provides support for Lenovo camera button. The Camera
> > +	  button is a GPIO device. This driver receives ACPI notify when the
> > +	  camera button is switched on/off.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called lenovo-wmi-camera.
> > +
> >   source "drivers/platform/x86/x86-android-tablets/Kconfig"
> > 
> >   config FW_ATTR_CLASS
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index 1de432e8861e..217e94d7c877 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
> >   obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
> >   obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
> >   obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
> > +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> > 
> >   # Intel
> >   obj-y				+= intel/
> > diff --git a/drivers/platform/x86/lenovo-wmi-camera.c
> > b/drivers/platform/x86/lenovo-wmi-camera.c
> > new file mode 100644
> > index 000000000000..f83e3ccd9189
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Lenovo WMI Camera Button Driver
> > + *
> > + * Author: Ai Chao <aichao@kylinos.cn>
> > + * Copyright (C) 2024 KylinSoft Corporation.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/module.h>
> > +#include <linux/wmi.h>
> > +
> > +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID
> > "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> > +
> > +struct lenovo_wmi_priv {
> > +	struct input_dev *idev;
> > +};
> > +
> > +enum {
> > +	SW_CAMERA_OFF	= 0,
> > +	SW_CAMERA_ON	= 1,
> > +};
> > +
> > +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object
> > *obj)
> > +{
> > +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +	u8 camera_mode;
> > +
> > +	if (obj->type != ACPI_TYPE_BUFFER) {
> > +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> > +		return;
> > +	}
> > +
> > +	if (obj->buffer.length != 1) {
> > +		dev_err(&wdev->dev, "Invalid buffer length %u\n",
> > obj->buffer.length);
> > +		return;
> > +	}
> > +
> > +	/* obj->buffer.pointer[0] is camera mode:
> > +	 *      0 camera close
> > +	 *      1 camera open
> > +	 */
> > +	camera_mode = obj->buffer.pointer[0];
> > +	if (camera_mode > SW_CAMERA_ON) {
> > +		dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode);
> > +		return;
> > +	}
> > +
> > +	if (camera_mode == SW_CAMERA_ON) {
> > +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
> > +		input_sync(priv->idev);
> > +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
> > +	} else {
> > +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
> > +		input_sync(priv->idev);
> > +		input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
> > +	}

While not exactly wrong the if seems unnecessary, you could do:

	unsigned int keycode;

	...

	keycode = camera_mode == SW_CAMERA_ON ? KEY_CAMERA_ACCESS_ENABLE :
						KEY_CAMERA_ACCESS_DISABLE;

	input_report_key(priv->idev, keycode, 1);
	input_sync(priv->idev);
	input_report_key(priv->idev, keycode, 0);
> > +	input_sync(priv->idev);
> > +}

Armin,

I tried to figure out the concurrency rules for the WMI notify handler but 
came up basically nothing. I suppose it boils down on ACPI notify handling 
and I couldn't find useful documentation about that either. :-/

Could you perhaps add this information into WMI documentation?

-- 
 i.

> > +
> > +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> > +{
> > +	struct lenovo_wmi_priv *priv;
> > +
> > +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&wdev->dev, priv);
> > +
> > +	priv->idev = devm_input_allocate_device(&wdev->dev);
> > +	if (!priv->idev)
> > +		return -ENOMEM;
> > +
> > +	priv->idev->name = "Lenovo WMI Camera Button";
> > +	priv->idev->phys = "wmi/input0";
> > +	priv->idev->id.bustype = BUS_HOST;
> > +	priv->idev->dev.parent = &wdev->dev;
> > +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_ENABLE);
> > +	input_set_capability(priv->idev, EV_KEY, KEY_CAMERA_ACCESS_DISABLE);
> > +
> > +	return input_register_device(priv->idev);
> > +}
> > +
> > +static const struct wmi_device_id lenovo_wmi_id_table[] = {
> > +	{ .guid_string = WMI_LENOVO_CAMERABUTTON_EVENT_GUID },
> > +	{  }
> > +};
> > +
> > +static struct wmi_driver lenovo_wmi_driver = {
> > +	.driver = {
> > +		.name = "lenovo-wmi-camera",
> > +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +	.id_table = lenovo_wmi_id_table,
> > +	.no_singleton = true,
> > +	.probe = lenovo_wmi_probe,
> > +	.notify = lenovo_wmi_notify,
> > +};
> > +
> > +module_wmi_driver(lenovo_wmi_driver);
> > +
> > +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> > +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> > +MODULE_DESCRIPTION("Lenovo WMI Camera Button Driver");
> > +MODULE_LICENSE("GPL");
> 
> Looks good to me.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> 

