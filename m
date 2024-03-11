Return-Path: <linux-kernel+bounces-98754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489F877EED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC861F21514
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE693A1CD;
	Mon, 11 Mar 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPxn+F6Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4338DED;
	Mon, 11 Mar 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156165; cv=none; b=Zlrn4nxn5WbgENtrP7sGSd7/yV0mn7LR34x0JGZxqOFOxibYhB02b87+uErbsSo6eecPVv/0U+Ekna5Vj+km0hatde3/XF/6qXEy8hZtRGGfztpKZfkIvMZt+FO1cGPgWZQzG/a2/EYZyy107qkBYgsrrjvPvI0rGlm0ks7AuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156165; c=relaxed/simple;
	bh=bzriNqhRxAw42UiGUSxczR0T+CSLZBMYiugAD4TlN7o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sGqVc0lYvAl60+pnx369NCI0XbU185XdClTWtw/eAUdUfOAefl4J+oM3Vc7C2+7SyyYEL5Gutf4MxzPXuoeTyguKn4D1HjAl/5w/9hLgpuedt0VhoId9crPV0pM2/1asxW4LPDJwYaUwjOZtG6M3Vw/VDNXtBdNRJdvC/9DYidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPxn+F6Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710156164; x=1741692164;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bzriNqhRxAw42UiGUSxczR0T+CSLZBMYiugAD4TlN7o=;
  b=PPxn+F6Qq0Z3/7vNcOHXOsD+woAZCDMaXEWSyYzb1ifgAhO0Xs8IjgMI
   XXXMDB/kWhlTkl3LImvr6Zjit6j5sBikGQhnU7S7u9+6aSGSFFBIGmumc
   rdAnBYTUu7DzL4X4NQSc1YW+IX7J+5z4ibDqN0I7lnFSkttD/yxBschMn
   pMxTP6KXKgCWniFxWq2t5NKkO4aR+4eLWlwkCw1teuMBSCuWMLfUe5lmj
   cgo+1s/+KxjMIm+3RPCRuMpgE/GFe0EITPQajrHpGRvpmQY0xr7I2gq7H
   2N/mfKQerHjDZsfEmmCWmPn1CdlfDW60x+NZ6A/SDAcZZcg9EmDQIjvS7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4734408"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4734408"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11023859"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:22:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 13:22:35 +0200 (EET)
To: mustafa <mustafa.eskieksi@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, jdelvare@suse.com, linux@roeck-us.net, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, pavel@ucw.cz, lee@kernel.org, 
    linux-leds@vger.kernel.org, rishitbansal0@gmail.com
Subject: Re: [PATCH v3 1/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
In-Reply-To: <20240310181429.59451-2-mustafa.eskieksi@gmail.com>
Message-ID: <8e46e7cc-eb3d-390d-f411-8a15b0d8d22c@linux.intel.com>
References: <20240310181429.59451-1-mustafa.eskieksi@gmail.com> <20240310181429.59451-2-mustafa.eskieksi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-888064519-1710155751=:1142"
Content-ID: <a4660b43-91d8-fc1f-1ee3-eb0920241715@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-888064519-1710155751=:1142
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <35a12ae5-79fc-122d-7f19-32626661a30a@linux.intel.com>

On Sun, 10 Mar 2024, mustafa wrote:

> From: Mustafa Ek=BAi <mustafa.eskieksi@gmail.com>
>=20
> This wmi driver supports Casper Excalibur laptops' changing keyboard
> backlight, reading fan speeds and changing power profiles. Multicolor
> led device is used for backlight, platform_profile for power management
> and hwmon for fan speeds. It supports both old (10th gen or older) and
> new (11th gen or newer) laptops. It uses x86_match_cpu to check if the
> laptop is old or new.
> This driver's Multicolor keyboard backlight API is very similar to Rishit
> Bansal's proposed API.
>=20
> Signed-off-by: Mustafa Ek=BAi <mustafa.eskieksi@gmail.com>
> ---
> Changes in v3:
>  - Replaced led_control attribute with multicolor led interface.
>  - Added struct led_cache, instead of storing only last color change.
>  - Added dmi list to prevent registering platform_profile driver in model=
s
>    that doesn't have this feature.
>  - Added a x86_cpu_id to differentiate older laptops that are reporting
>    fan speeds in big-endian. Also newer laptops have a different power
>    profile scheme. I'm using x86_cpu_id because they don't have a
>    difference in model names, only in cpu generations (the official drive=
r
>    download page makes you select your cpu's generation too).
>  - Removed hwmon_pwm device in favor of platform_profile driver. It
>    indirectly affects fans' speed but they also affect frequency and
>    power consumption as well.
>  - Replaced handwritten masks with GENMASK equivalents.
>  - Replaced led_classdev_register with
>    devm_led_classdev_multicolor_register. This should solve the bug
>    where led_classdev remains registered even if casper_wmi_probe
>    returns -ENODEV.
>  - Removed select NEW_LEDS and LEDS_CLASS, because it creates recursive
>    dependencies.
>  - And some minor changes.
> Changes in v2:
>  - Added masks for
>  - Changed casper_set and casper_query returns Linux error code rather th=
an
>    acpi_status.
>  - replaced complicated bit operations with FIELD_GET.
>  - Fixed some indentation and spacing.
>  - Broke fan speeds further.
>  - Moved module metadata to the end of the file.
> ---
>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 +
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 639 ++++++++++++++++++++++++++++++
>  4 files changed, 660 insertions(+)
>  create mode 100644 drivers/platform/x86/casper-wmi.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aabf1c15bb..e4cb770c990 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4724,6 +4724,12 @@ S:=09Maintained
>  W:=09https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
>  F:=09drivers/net/wireless/ath/carl9170/
> =20
> +CASPER EXCALIBUR WMI DRIVER
> +M:=09Mustafa Ek=BAi <mustafa.eskieksi@gmail.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +F:=09drivers/platform/x86/casper-wmi.c
> +
>  CAVIUM I2C DRIVER
>  M:=09Robert Richter <rric@kernel.org>
>  S:=09Odd Fixes
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9..4f951bcac1a 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called sel3350-platform.
> =20
> +config CASPER_WMI
> +=09tristate "Casper Excalibur Laptop WMI driver"
> +=09depends on ACPI_WMI
> +=09depends on HWMON
> +=09depends on LEDS_CLASS_MULTICOLOR
> +=09select ACPI_PLATFORM_PROFILE
> +=09help
> +=09  Say Y here if you want to support WMI-based fan speed reporting,
> +=09  power management and keyboard backlight support on Casper Excalibur
> +=09  Laptops.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called casper-wmi.
> +
>  endif # X86_PLATFORM_DEVICES
> =20
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 1de432e8861..4b527dd44ad 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)=09=09=09+=3D mxm-wmi.o
>  obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)=09+=3D nvidia-wmi-ec-backlight.o
>  obj-$(CONFIG_XIAOMI_WMI)=09=09+=3D xiaomi-wmi.o
>  obj-$(CONFIG_GIGABYTE_WMI)=09=09+=3D gigabyte-wmi.o
> +obj-$(CONFIG_CASPER_WMI)=09=09+=3D casper-wmi.o
> =20
>  # Acer
>  obj-$(CONFIG_ACERHDF)=09=09+=3D acerhdf.o
> diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/cas=
per-wmi.c
> new file mode 100644
> index 00000000000..80e1e2b16fb
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/module.h>
> +#include <linux/bits.h>
> +#include <linux/bitops.h>
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <acpi/acexcep.h>
> +#include <linux/bitfield.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_profile.h>
> +#include <linux/led-class-multicolor.h>
> +
> +#include <linux/dmi.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +#define CASPER_WMI_GUID "644C5791-B7B0-4123-A90B-E93876E0DAAD"
> +
> +#define CASPER_READ 0xfa00
> +#define CASPER_WRITE 0xfb00
> +#define CASPER_GET_HARDWAREINFO 0x0200
> +#define CASPER_SET_LED 0x0100
> +#define CASPER_POWERPLAN 0x0300
> +
> +#define CASPER_KEYBOARD_LED_1 0x03
> +#define CASPER_KEYBOARD_LED_2 0x04
> +#define CASPER_KEYBOARD_LED_3 0x05
> +#define CASPER_ALL_KEYBOARD_LEDS 0x06
> +#define CASPER_CORNER_LEDS 0x07
> +#define CASPER_LED_COUNT 4
> +
> +const char * const zone_names[CASPER_LED_COUNT] =3D {
> +=09"casper::kbd_zoned_backlight-right",
> +=09"casper::kbd_zoned_backlight-middle",
> +=09"casper::kbd_zoned_backlight-left",
> +=09"casper::kbd_zoned_backlight-corners",
> +};
> +
> +#define CASPER_LED_ALPHA GENMASK(31, 24)
> +#define CASPER_LED_RED=09 GENMASK(23, 16)
> +#define CASPER_LED_GREEN GENMASK(15, 8)
> +#define CASPER_LED_BLUE  GENMASK(7, 0)
> +#define CASPER_DEFAULT_COLOR (CASPER_LED_RED | CASPER_LED_GREEN | \
> +=09=09=09      CASPER_LED_BLUE)
> +#define CASPER_FAN_CPU 0
> +#define CASPER_FAN_GPU 1
> +
> +enum casper_power_profile_old {
> +=09CASPER_HIGH_PERFORMANCE =3D 1,
> +=09CASPER_GAMING=09=09=3D 2,
> +=09CASPER_TEXT_MODE=09=3D 3,
> +=09CASPER_POWERSAVE=09=3D 4
> +};
> +
> +enum casper_power_profile_new {
> +=09CASPER_NEW_HIGH_PEROFRMANCE=09=3D 0,

PERFORMANCE


> +=09ret =3D casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09switch (channel) {
> +=09case CASPER_FAN_CPU:
> +=09=09if (quirk_applied->big_endian_fans)
> +=09=09=09*val =3D be16_to_cpu((u16) out.a4);

So you use be16_to_cpu() but you cast the input to u16, not __be16!?!

Please run sparse with endianness checking enabled and make sure it won't=
=20
complain on these lines.


> +=09gen_id =3D x86_match_cpu(casper_gen);
> +=09if (!gen_id)
> +=09=09return -ENODEV;
> +
> +=09quirk_applied =3D (struct casper_quirk_entry *) gen_id->driver_data;

Don't leave space after casts. There could=20

> +=09dmi_id =3D dmi_first_match(casper_quirks);
> +=09if (!dmi_id)
> +=09=09return -ENODEV;
> +
> +=09quirk_applied->no_power_profiles =3D ((struct casper_quirk_entry *)
> +=09=09dmi_id->driver_data)->no_power_profiles;

Please make a local variable for struct casper_quirk_entry * instead of=20
trying to cram this into a single, multi-line statement.

> +=09casper_kbd_mcled_info =3D devm_kzalloc(&wdev->dev,
> +=09=09sizeof(*casper_kbd_mcled_info)*CASPER_LED_COUNT, GFP_KERNEL);

devm_kcalloc()


I'm yet to go through the use of multicolor led stuff (I don't have time=20
for that now and I'm not familiar enough with it to check it quickly).=20
But hopefully we get one of the leds people to take a look at it before I=
=20
do, their input would be much more valuable than my review.

--=20
 i.
--8323328-888064519-1710155751=:1142--

