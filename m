Return-Path: <linux-kernel+bounces-131194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6E898442
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FDB28D053
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080E74E0A;
	Thu,  4 Apr 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXIe8veD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4A5C61D;
	Thu,  4 Apr 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223298; cv=none; b=O8I4urhnEP7qujBt8yBeTC8BWZwDWPVSGvYU//cRZh+rBMKajoVlBEjSnkTcLmYyhXW2x/FLJfeb4cnxlvUTofOS5bI2ZR+/3xkrOZAsGP+oPvhumOfeRCM2DNy6gOzg/104jwP4h9duLN657SoxWHyvgSJI7MH7l0kg6Pewh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223298; c=relaxed/simple;
	bh=+HqkqJU/rEQJga0hxV19uxQvWTIzQFumVdbgXcVwBnM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ArZ7sqRft8hxWYxN4Psia0SwlaBXl9kTDIL2RwWzW6tLvpk6DU5d1YzY7/pldos1cr4AUMm+1U8wjrCU3KBllKKZ39u63kdGEkYHuXYKXJimkLpFQoZ4VE0m/tl3HroYnMNvx/5CWok/9E+ieJ10Ax8GWkNiJau9ySRi63BsIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXIe8veD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712223298; x=1743759298;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+HqkqJU/rEQJga0hxV19uxQvWTIzQFumVdbgXcVwBnM=;
  b=jXIe8veDxiptW1ew5nsOLmP82BKAF0Tfs+bA3vRV9P9li9bLLjHGCWhL
   m9jWs4st7OhvIW5N5FGcQ1/g56GNLxaEQN3dMNGIZbfowThbWpxEKukO0
   AZTrkbYN/dkKvMfh9JS9JbTe+r/YJ0qcqOba0+uSc3+HWHu4114QbsVuO
   klcam3Q5DoozAM8VbO7QI2CjwQpmjRdfEEf9XGO81hxFxuQ5vtm5wnh/f
   9+p25ZldcfhV6yxaq+51Ite0I9d53kPxqNFf/P0Awuxdo+Xtp/S0kIAes
   pUHPK2jejJIOcrZge3dyAQ1NcNKN5L9muF/08uAJPHvTQW95fqExhiBZj
   g==;
X-CSE-ConnectionGUID: LgD7Tq2/T7CWjEZF0oB+SA==
X-CSE-MsgGUID: iaA9rPFSSlSrniCJ/IXwMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18941421"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18941421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:33:42 -0700
X-CSE-ConnectionGUID: gVs5fu7qR0qS/6hQoZBorg==
X-CSE-MsgGUID: 0psKKxpnST+cLR7S9Yb87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="49680440"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:33:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 4 Apr 2024 12:33:33 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>
cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <20240404001652.86207-2-luke@ljones.dev>
Message-ID: <590fea48-ac39-4db4-47c5-366a6814c9b3@linux.intel.com>
References: <20240404001652.86207-1-luke@ljones.dev> <20240404001652.86207-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2027781065-1712223213=:2725"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2027781065-1712223213=:2725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 4 Apr 2024, Luke D. Jones wrote:

> Support the 2024 mini-led backlight and adjust the related functions
> to select the relevant dev-id. Also add `available_mini_led_mode` to the
> platform sysfs since the available mini-led levels can be different.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
>  drivers/platform/x86/asus-wmi.c               | 96 +++++++++++++++++--
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 95 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Document=
ation/ABI/testing/sysfs-platform-asus-wmi
> index 8a7e25bde085..ef1ac1a20a71 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -126,6 +126,14 @@ Description:
>  =09=09Change the mini-LED mode:
>  =09=09=09* 0 - Single-zone,
>  =09=09=09* 1 - Multi-zone
> +=09=09=09* 2 - Multi-zone strong (available on newer generation mini-led=
)
> +
> +What:=09=09/sys/devices/platform/<platform>/available_mini_led_mode
> +Date:=09=09Apr 2024
> +KernelVersion:=096.10
> +Contact:=09"Luke Jones" <luke@ljones.dev>
> +Description:
> +=09=09List the available mini-led modes.
> =20
>  What:=09=09/sys/devices/platform/<platform>/ppt_pl1_spl
>  Date:=09=09Jun 2023
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 3f07bbf809ef..aa2a3b402e33 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -126,6 +126,17 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_SCREENPAD_BRIGHT_MAX 255
>  #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
> =20
> +#define ASUS_MINI_LED_MODE_MASK=09=090x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF=09=090x00
> +#define ASUS_MINI_LED_ON=09=090x01
> +/* New mode on some devices, define here to clarify remapping later */
> +#define ASUS_MINI_LED_STRONG_MODE=090x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK=09=090x00
> +#define ASUS_MINI_LED_2024_STRONG=090x01
> +#define ASUS_MINI_LED_2024_OFF=09=090x02
> +
>  /* Controls the power state of the USB0 hub on ROG Ally which input is o=
n */
>  #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
>  /* 300ms so far seems to produce a reliable result on AC and battery */
> @@ -288,7 +299,7 @@ struct asus_wmi {
>  =09bool battery_rsoc_available;
> =20
>  =09bool panel_overdrive_available;
> -=09bool mini_led_mode_available;
> +=09u32 mini_led_dev_id;
> =20
>  =09struct hotplug_slot hotplug_slot;
>  =09struct mutex hotplug_lock;
> @@ -2108,13 +2119,33 @@ static ssize_t mini_led_mode_show(struct device *=
dev,
>  =09=09=09=09   struct device_attribute *attr, char *buf)
>  {
>  =09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> -=09int result;
> +=09u32 value;
> +=09int err;
> =20
> -=09result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED=
_MODE);
> -=09if (result < 0)
> -=09=09return result;
> +=09err =3D asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
> +=09if (err < 0)
> +=09=09return err;
> +=09value =3D value & ASUS_MINI_LED_MODE_MASK;
> =20
> -=09return sysfs_emit(buf, "%d\n", result);
> +=09/*
> +=09 * Remap the mode values to match previous generation mini-led. The l=
ast gen
> +=09 * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3Doff (flipped).
> +=09 */
> +=09if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +=09=09switch (value) {
> +=09=09case ASUS_MINI_LED_2024_WEAK:
> +=09=09=09value =3D ASUS_MINI_LED_ON;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_STRONG:
> +=09=09=09value =3D ASUS_MINI_LED_STRONG_MODE;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_OFF:
> +=09=09=09value =3D ASUS_MINI_LED_OFF;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return sysfs_emit(buf, "%d\n", value);
>  }
> =20
>  static ssize_t mini_led_mode_store(struct device *dev,
> @@ -2130,11 +2161,32 @@ static ssize_t mini_led_mode_store(struct device =
*dev,
>  =09if (result)
>  =09=09return result;
> =20
> -=09if (mode > 1)
> +=09if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE &&
> +=09=09mode > ASUS_MINI_LED_ON)
> +=09=09return -EINVAL;
> +=09if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2 &&
> +=09=09mode > ASUS_MINI_LED_STRONG_MODE)

The if condition continations should not be indented to the same level as=
=20
its statement block because it confuses the reader. Hans might be able to=
=20
fix this while applying though so I'm not sure if it's necessary to send a=
=20
new version just because of this.

--=20
 i.
--8323328-2027781065-1712223213=:2725--

