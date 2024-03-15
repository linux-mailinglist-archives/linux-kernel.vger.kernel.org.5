Return-Path: <linux-kernel+bounces-104756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA187D322
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588621F2451A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA024CB41;
	Fri, 15 Mar 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMwYDhV/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B94F5FB;
	Fri, 15 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525271; cv=none; b=qK3QZjXWccmOIsWafk7+a2zN2dqM/7FUF1HSSV34lXKsv9ljB4Z1GXfpcGOacsTZFfGZihhfqqazPeg1BvXIJfXj2bT4+kJ87ZvmWNMR8fkt/e5eIcE1+JfUn1Hfl9lHEQshGUDlFoY1g7QrCU+uO8PFX+HYXj6DHk4fFl8MZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525271; c=relaxed/simple;
	bh=cYtbGGNdkp3Y0zhQ7JdIGLSxduoTIhVA5FEWkdE3034=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j8ZvURPSLLPjWG0sSsZF63frqrC7OAJnojB4XA0kNIpLgAyIGd01eI2rzM9yX2PC1v+J9/KwZ6xGKhzXUdBqH4DH8/IoGjFPlm83/unn4IxYL1o+Eamuyr+9KvXDYM3t/pmE2axPOyaqf44fGJ2Rctfezw4uSgj62KYLVjkpFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMwYDhV/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710525270; x=1742061270;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cYtbGGNdkp3Y0zhQ7JdIGLSxduoTIhVA5FEWkdE3034=;
  b=cMwYDhV/88Id9xPDCXpE+rvef3vHiWW8kmp+q7Bp/mh1Z/fHkM/MlVed
   35WCIob15DCFZZ66QDWHBgqVDOenPu7fIdNcrUTTmIvli1w+fslVsz1sJ
   aC2sV9TDl7fFNLP8WUcAqlhrGqWebYR6eeOOVNvxyYj2bvPYhYMXan/Sh
   s2CuGvIjPlwVEJl+ivf1JrkJg+V7MdBZ0vwTvJozTuJ0H71aHidxfnwKB
   Wi1IExNB/oW8+OM4ZLk9cBaqI/B3epntRJg9fv7douDlS9OoTVvxwEQZE
   65/CLT5F9ewxxK6Actks75YyEucHVVxwujbC1OEYhVLVbhNLTctJcaWHj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="9187333"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="9187333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43798829"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:54:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Mar 2024 19:54:22 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Ai Chao <aichao@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v8] platform/x86: add lenovo wmi camera button driver
In-Reply-To: <a2db8f76-d0c3-402e-9fb0-13f36c848607@gmx.de>
Message-ID: <c3dba443-89d5-96cb-3e40-a4e3ab87002e@linux.intel.com>
References: <20240314050319.171816-1-aichao@kylinos.cn> <d7c2de21-50f9-4602-abd0-b83ecbc3f42f@gmx.de> <62b54638-92eb-52e1-d4ad-074963771157@linux.intel.com> <a2db8f76-d0c3-402e-9fb0-13f36c848607@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1081807944-1710525262=:1018"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1081807944-1710525262=:1018
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Mar 2024, Armin Wolf wrote:
> Am 15.03.24 um 12:51 schrieb Ilpo J=C3=A4rvinen:
> > On Thu, 14 Mar 2024, Armin Wolf wrote:
> > > Am 14.03.24 um 06:03 schrieb Ai Chao:
> > >=20
> > > > Add lenovo generic wmi driver to support camera button.
> > > > The Camera button is a GPIO device. This driver receives ACPI notif=
yi
> > > > when the camera button is switched on/off. This driver is used in
> > > > Lenovo A70, it is a Computer integrated machine.
> > > >=20
> > > > Signed-off-by: Ai Chao <aichao@kylinos.cn>
> > > > ---
> > > > v8: Dev_deb convert to dev_err.
> > > > v7: Add dev_dbg and remove unused dev in struct.
> > > > v6: Modify SW_CAMERA_LENS_COVER to
> > > > KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE.
> > > > v5: Remove camera button groups, modify KEY_CAMERA to
> > > > SW_CAMERA_LENS_COVER.
> > > > v4: Remove lenovo_wmi_input_setup, move camera_mode into struct
> > > > lenovo_wmi_priv.
> > > > v3: Remove lenovo_wmi_remove function.
> > > > v2: Adjust GPL v2 to GPL, adjust sprintf to sysfs_emit.
> > > >=20
> > > >    drivers/platform/x86/Kconfig             |  12 +++
> > > >    drivers/platform/x86/Makefile            |   1 +
> > > >    drivers/platform/x86/lenovo-wmi-camera.c | 108
> > > > +++++++++++++++++++++++
> > > >    3 files changed, 121 insertions(+)
> > > >    create mode 100644 drivers/platform/x86/lenovo-wmi-camera.c
> > > >=20
> > > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kc=
onfig
> > > > index bdd302274b9a..9506a455b547 100644
> > > > --- a/drivers/platform/x86/Kconfig
> > > > +++ b/drivers/platform/x86/Kconfig
> > > > @@ -1001,6 +1001,18 @@ config INSPUR_PLATFORM_PROFILE
> > > >    =09To compile this driver as a module, choose M here: the module
> > > >    =09will be called inspur-platform-profile.
> > > >=20
> > > > +config LENOVO_WMI_CAMERA
> > > > +=09tristate "Lenovo WMI Camera Button driver"
> > > > +=09depends on ACPI_WMI
> > > > +=09depends on INPUT
> > > > +=09help
> > > > +=09  This driver provides support for Lenovo camera button. The Ca=
mera
> > > > +=09  button is a GPIO device. This driver receives ACPI notify whe=
n the
> > > > +=09  camera button is switched on/off.
> > > > +
> > > > +=09  To compile this driver as a module, choose M here: the module
> > > > +=09  will be called lenovo-wmi-camera.
> > > > +
> > > >    source "drivers/platform/x86/x86-android-tablets/Kconfig"
> > > >=20
> > > >    config FW_ATTR_CLASS
> > > > diff --git a/drivers/platform/x86/Makefile
> > > > b/drivers/platform/x86/Makefile
> > > > index 1de432e8861e..217e94d7c877 100644
> > > > --- a/drivers/platform/x86/Makefile
> > > > +++ b/drivers/platform/x86/Makefile
> > > > @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_HDAPS)=09+=3D hdaps.o
> > > >    obj-$(CONFIG_THINKPAD_ACPI)=09+=3D thinkpad_acpi.o
> > > >    obj-$(CONFIG_THINKPAD_LMI)=09+=3D think-lmi.o
> > > >    obj-$(CONFIG_YOGABOOK)=09=09+=3D lenovo-yogabook.o
> > > > +obj-$(CONFIG_LENOVO_WMI_CAMERA)=09+=3D lenovo-wmi-camera.o
> > > >=20
> > > >    # Intel
> > > >    obj-y=09=09=09=09+=3D intel/
> > > > diff --git a/drivers/platform/x86/lenovo-wmi-camera.c
> > > > b/drivers/platform/x86/lenovo-wmi-camera.c
> > > > new file mode 100644
> > > > index 000000000000..f83e3ccd9189
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/lenovo-wmi-camera.c
> > > > @@ -0,0 +1,108 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Lenovo WMI Camera Button Driver
> > > > + *
> > > > + * Author: Ai Chao <aichao@kylinos.cn>
> > > > + * Copyright (C) 2024 KylinSoft Corporation.
> > > > + */
> > > > +
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/wmi.h>
> > > > +
> > > > +#define WMI_LENOVO_CAMERABUTTON_EVENT_GUID
> > > > "50C76F1F-D8E4-D895-0A3D-62F4EA400013"
> > > > +
> > > > +struct lenovo_wmi_priv {
> > > > +=09struct input_dev *idev;
> > > > +};
> > > > +
> > > > +enum {
> > > > +=09SW_CAMERA_OFF=09=3D 0,
> > > > +=09SW_CAMERA_ON=09=3D 1,
> > > > +};
> > > > +
> > > > +static void lenovo_wmi_notify(struct wmi_device *wdev, union
> > > > acpi_object
> > > > *obj)
> > > > +{
> > > > +=09struct lenovo_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> > > > +=09u8 camera_mode;
> > > > +
> > > > +=09if (obj->type !=3D ACPI_TYPE_BUFFER) {
> > > > +=09=09dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
> > > > +=09=09return;
> > > > +=09}
> > > > +
> > > > +=09if (obj->buffer.length !=3D 1) {
> > > > +=09=09dev_err(&wdev->dev, "Invalid buffer length %u\n",
> > > > obj->buffer.length);
> > > > +=09=09return;
> > > > +=09}
> > > > +
> > > > +=09/* obj->buffer.pointer[0] is camera mode:
> > > > +=09 *      0 camera close
> > > > +=09 *      1 camera open
> > > > +=09 */
> > > > +=09camera_mode =3D obj->buffer.pointer[0];
> > > > +=09if (camera_mode > SW_CAMERA_ON) {
> > > > +=09=09dev_err(&wdev->dev, "Unknown camera mode %u\n", camera_mode)=
;
> > > > +=09=09return;
> > > > +=09}
> > > > +
> > > > +=09if (camera_mode =3D=3D SW_CAMERA_ON) {
> > > > +=09=09input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 1);
> > > > +=09=09input_sync(priv->idev);
> > > > +=09=09input_report_key(priv->idev, KEY_CAMERA_ACCESS_ENABLE, 0);
> > > > +=09} else {
> > > > +=09=09input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 1);
> > > > +=09=09input_sync(priv->idev);
> > > > +=09=09input_report_key(priv->idev, KEY_CAMERA_ACCESS_DISABLE, 0);
> > > > +=09}
> > While not exactly wrong the if seems unnecessary, you could do:
> >=20
> > =09unsigned int keycode;
> >=20
> > =09...
> >=20
> > =09keycode =3D camera_mode =3D=3D SW_CAMERA_ON ? KEY_CAMERA_ACCESS_ENAB=
LE :
> > =09=09=09=09=09=09KEY_CAMERA_ACCESS_DISABLE;
> >=20
> > =09input_report_key(priv->idev, keycode, 1);
> > =09input_sync(priv->idev);
> > =09input_report_key(priv->idev, keycode, 0);
> > > > +=09input_sync(priv->idev);
> > > > +}
> > Armin,
> >=20
> > I tried to figure out the concurrency rules for the WMI notify handler =
but
> > came up basically nothing. I suppose it boils down on ACPI notify handl=
ing
> > and I couldn't find useful documentation about that either. :-/
> >=20
> > Could you perhaps add this information into WMI documentation?
>=20
> As far as i know, the ACPI notify handlers can be scheduled concurrently =
on
> all CPUs,
> see https://lore.kernel.org/all/7617703.EvYhyI6sBW@kreacher/ for details.

Hi,

I meant this from the point of view whether the same notify handler can=20
only have one instance active at a time because otherwise one would=20
need locking to protect e.g. that input injection sequence.

> I will add a short note about this to the WMI driver guide which i plan t=
o
> upstream soon (after the EC handler stuff is finished).

Thanks.

--=20
 i.

--8323328-1081807944-1710525262=:1018--

