Return-Path: <linux-kernel+bounces-111632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189E4886EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F661F224FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA730481AA;
	Fri, 22 Mar 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2mO2W2w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4733FB02;
	Fri, 22 Mar 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118378; cv=none; b=uTGe66Z7PogxA3tKU9iQmaxNZ6m0Jlc9mRISGz+wYy2lw9igP2CSUTul7Fb7yG8DPQ6krKUTSf3m9wK3M29KtCu+FleXCXh/GjvClxa7NkymAxRBo9xCT0tyqN2CLaiVVts9OpRnWmCnJr/uLrVFmYYDuvY/Jm+IS16p71XzqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118378; c=relaxed/simple;
	bh=a3YCJUrMo7CDH/5/zOS6zAymiu5i9hE+3myfHHf8+dw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qNpslWTpwE2ufynNSUfmI1+CTsCXEGSMcYrNlZ9NlxIaSWT5QKDrCVjvm32aG+j2JRitlqP5QTTa3Tpyn5tHCs4uFLqugk2bwRG6fooVb4U2OkUJGlkHbWyHWtAyjAXamMSQTZs7p4s4/PYM+57pcAjTHrPuZ2TJc6z31ECa0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2mO2W2w; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711118376; x=1742654376;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a3YCJUrMo7CDH/5/zOS6zAymiu5i9hE+3myfHHf8+dw=;
  b=k2mO2W2wANp+n5yfW3UdApJL4V3m1VTiNVM7xZ8FPCqW5DkGo03Hpkll
   BcnhCV6/6hVUcag0un0cuU9F88jbfOT/V18FnDb07NHcqqeWPXKWHGwIZ
   KaAPDzAjXs5KZNYHS5PkGDbrpZhfmrNsxNjb6eMLUgmBgCOCWTYeJy7a6
   /mM44RHFx81QKFnj7BzL1yIXl/h8/pzIKfWKWwBIvJOjcgDpEc4JHUU23
   wa/WnxfaXZtGwYZx5+wXtjh0SkxIoA51smCi8VgbrrlkiHp/sKVV1M4tH
   ngMxhrBnSlrYACEN7WW9ryjwy5yy4V9Ro8axR1CMSmeP9Ve4pzSan6Qay
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16716335"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16716335"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15592152"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:39:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 16:39:28 +0200 (EET)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: Ai Chao <aichao@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v11] platform/x86: add lenovo wmi camera button driver
In-Reply-To: <5e30a445-0a14-4242-9c1d-578a5b7cfcbe@linux.intel.com>
Message-ID: <f1421e47-a6b7-e8f1-49a0-28e3351b2450@linux.intel.com>
References: <20240322064750.267422-1-aichao@kylinos.cn> <5e30a445-0a14-4242-9c1d-578a5b7cfcbe@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Mar 2024, Kuppuswamy Sathyanarayanan wrote:
> On 3/21/24 11:47 PM, Ai Chao wrote:
> > Add lenovo generic wmi driver to support camera button.
> > The Camera button is a GPIO device. This driver receives ACPI notifyi
> > when the camera button is switched on/off. This driver is used in
> > Lenovo A70, it is a Computer integrated machine.
> >
> > Signed-off-by: Ai Chao <aichao@kylinos.cn>
> > ---
> > v11: remove input_unregister_device.
> > v10: Add lenovo_wmi_remove and mutex_destroy.
> > v9: Add mutex for wmi notify.
> > v8: Dev_deb convert to dev_err.
> > v7: Add dev_dbg and remove unused dev in struct.
> > v6: Modify SW_CAMERA_LENS_COVER to KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
> > v5: Remove camera button groups, modify KEY_CAMERA to SW_CAMERA_LENS_COVER.
> > v4: Remove lenovo_wmi_input_setup, move camera_mode into struct lenovo_wmi_priv.
> > v3: Remove lenovo_wmi_remove function.
> > v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> >
> >  drivers/platform/x86/Kconfig             |  12 +++
> >  drivers/platform/x86/Makefile            |   1 +
> >  drivers/platform/x86/lenovo-wmi-camera.c | 126 +++++++++++++++++++++++
> >  3 files changed, 139 insertions(+)
> >  create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index bdd302274b9a..9506a455b547 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
> >  	To compile this driver as a module, choose M here: the module
> >  	will be called inspur-platform-profile.
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
> >  source "drivers/platform/x86/x86-android-tablets/Kconfig"
> >  
> >  config FW_ATTR_CLASS
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index 1de432e8861e..217e94d7c877 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
> >  obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
> >  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
> >  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
> > +obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> >  
> >  # Intel
> >  obj-y				+= intel/
> > diff --git a/drivers/platform/x86/lenovo-wmi-camera.c b/drivers/platform/x86/lenovo-wmi-camera.c
> > new file mode 100644
> > index 000000000000..fda936e2f37c
> > --- /dev/null
> > +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> > @@ -0,0 +1,126 @@
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
> > +#include <linux/mutex.h>
> > +#include <linux/wmi.h>
> > +
> > +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> > +
> > +struct lenovo_wmi_priv {
> > +	struct input_dev *idev;
> > +	struct mutex notify_lock;	/* lenovo wmi camera button notify lock */
> > +};
> > +
> > +enum {
> > +	SW_CAMERA_OFF	= 0,
> > +	SW_CAMERA_ON	= 1,
> > +};
> > +
> > +static void lenovo_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
> > +{
> > +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +	unsigned int keycode;
> > +	u8 camera_mode;
> > +
> > +	if (obj->type != ACPI_TYPE_BUFFER) {
> > +		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> > +		return;
> > +	}
> > +
> > +	if (obj->buffer.length != 1) {
> > +		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
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
> > +	mutex_lock(&priv->notify_lock);
> > +
> > +	keycode = (camera_mode == SW_CAMERA_ON ?
> > +		   KEY_CAMERA_ACCESS_ENABLE : KEY_CAMERA_ACCESS_DISABLE);
> > +	input_report_key(priv->idev, keycode, 1);
> > +	input_sync(priv->idev);
> > +	input_report_key(priv->idev, keycode, 0);
> > +	input_sync(priv->idev);
> > +
> > +	mutex_unlock(&priv->notify_lock);
> > +}
> > +
> > +static int lenovo_wmi_probe(struct wmi_device *wdev, const void *context)
> > +{
> > +	struct lenovo_wmi_priv *priv;
> > +	int ret;
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
> > +	ret = input_register_device(priv->idev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&priv->notify_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void lenovo_wmi_remove(struct wmi_device *wdev)
> > +{
> > +	struct lenovo_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +
> > +	mutex_destroy(&priv->notify_lock);
> 
> Do you really need to call mutex_destroy() during the module unload?
> 
> I don't think kernel allocates any memory during mutex_init() that needs
> be freed.

Is all debug code going to be happy if it's not called?

-- 
 i.


