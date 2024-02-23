Return-Path: <linux-kernel+bounces-78106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8EB860EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4F1F24CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E315D479;
	Fri, 23 Feb 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blOER3Xm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8691642A;
	Fri, 23 Feb 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683314; cv=none; b=Y8th7J6gtx3IdB3wKYbi0izhL8sKYQRkY1WnEBylPL+0+U4u28UzPhle1JtpLRD1acJOA6rd9niyZFsTkXSsQNwcnCfuUUgKTfqyPbL1M1JhMX/AQyZg6SUVZ1ZaC085LPxtpE7YVpa3g8XfKLuAy38PgjA8WjPZwVIkmpbVuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683314; c=relaxed/simple;
	bh=73kX+/NEuk1iaZrhUXLJKKoGJQXFowHJqhm7iiG20xc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iiZynykjabsjzirlMlAmErUv0leZrOli82Btcyi1npNditzPQfJ3SuOMZSCsj20A2ABRY6MAkQiop7sTLwfoJ8HUqnPwdlk+RS8FvUTET5thmcwsFyLWZgs3sQezL4S4/MOtPmHlh2nQRn/OzHqZGqskRp7bzh2rE6oBPJXJ4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blOER3Xm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708683312; x=1740219312;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=73kX+/NEuk1iaZrhUXLJKKoGJQXFowHJqhm7iiG20xc=;
  b=blOER3Xm3gK4C8JeXnJJl4Uh3nPzonaF6yOY3Q3+gk1pCtqEOS/bT8EH
   mW33mbj7ALvgCJYRkbyP0xSnaqp7XeOGq+V0k7xHEDMGGP4o/J2qghL7F
   yvtfHYUh7+zvpzgjoKceMWwTB729WwVTANJ3figH+1H56tGJFrRSOIMIf
   8jwsBQfgxxv8i4+glJcJ8n2MhRDnaoFcWPIJov35k0yWEPAvEyggCrkkb
   SSDM4mdwlWFkPLMsyiatHPaf0wW/M3NHROxCKGnYTFcPHvs1ZTBBjGoaD
   ht0ak+CY5578s4DXUCuoCWBYRWbXhX0Fs6i22JjC9ZB+FjOEiceTPjk77
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="20528324"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="20528324"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5748215"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:15:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Feb 2024 12:14:55 +0200 (EET)
To: =?ISO-8859-2?Q?Mustafa_Ek=BAi?= <mustafa.eskieksi@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, pavel@ucw.cz, lee@kernel.org
Subject: Re: [PATCH v2] platform/x86: Add wmi driver for Casper Excalibur
 laptops. Odd line breaks was because I have used scripts/Lindent without
 checking, I'm sorry for that. And for my weird rgb led API: This kind of
 design was also used in drivers/platform/x86/dell/alienware-wmi.c:239, but
 mine differs as it doesn't create different attributes for different leds.
 That is because driver doesn't know how many leds there are, to know how
 many leds there are it should check processor information (whether it's 10th
 gen or 11th). I don't think include/linux/mod_devicetable.h supports that.
 If there is a way to differentiate cpus, please let me know. And even if it
 knew how many leds there are, having different attributes can be cumbersome
 because there's no way of reading leds. And also user can change led state
 without notifying os (with some hotkey). But I'm open to further discussion.
 And thanks for all of your careful reviewing. It helped me to learn more.
In-Reply-To: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
Message-ID: <7863fff5-4de5-4e7a-09b4-fe05ca7765d5@linux.intel.com>
References: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1887983801-1708682173=:1148"
Content-ID: <6e06b268-d3c5-3914-3d9c-1332eaf88164@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1887983801-1708682173=:1148
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <02356207-00da-6cd5-aa06-8e3d8b1f42f9@linux.intel.com>

On Fri, 23 Feb 2024, Mustafa Ek=BAi wrote:

> Adding wmi driver for Casper Excalibur Laptops:
> This driver implements a ledclass_dev device for keyboard backlight
> and hwmon driver to read fan speed and (also write) pwm mode. NEW_LEDS is
> selected because this driver introduces new leds, and LEDS_CLASS is selec=
ted
> because this driver implements a led class device. All of Casper Excalibu=
r
> Laptops are supported but fan speeds has a bug for older generations.
>=20
> Signed-off-by: Mustafa Ek=BAi <mustafa.eskieksi@gmail.com>
> ---

v1 -> v2 changelog is missing from here!

>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 315 ++++++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/platform/x86/casper-wmi.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed4d386853..d0142a75d2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4723,6 +4723,12 @@ S:=09Maintained
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
> index bdd302274b9..ebef9c9dfb6 100644
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
> +=09select NEW_LEDS
> +=09select LEDS_CLASS
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
> index 00000000000..012ebda195d
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/bitops.h>
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <acpi/acexcep.h>
> +#include <linux/bitfield.h>
> +#include <linux/sysfs.h>
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
> +
> +#define CASPER_LED_ID    0xF00000000
> +#define CASPER_LED_MODE  0x0F0000000
> +#define CASPER_LED_ALPHA 0x00F000000

GENMASK()

> +
> +struct casper_wmi_args {
> +=09u16 a0, a1;
> +=09u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +static u32 casper_last_color;
> +static u8 casper_last_led;
> +
> +static int casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
> +=09=09=09      u32 data)
> +{
> +=09struct casper_wmi_args wmi_args =3D {
> +=09=09.a0 =3D CASPER_WRITE,
> +=09=09.a1 =3D a1,
> +=09=09.a2 =3D led_id,
> +=09=09.a3 =3D data
> +=09};
> +=09struct acpi_buffer input =3D {
> +=09=09(acpi_size) sizeof(struct casper_wmi_args),
> +=09=09&wmi_args
> +=09};
> +=09if (ACPI_FAILURE(wmidev_block_set(wdev, 0, &input)))

=09int status;

=09status =3D wmidev_block_set(wdev, 0, &input);
=09if (ACPI_FAILURE(status))

> +=09=09return -EINVAL;
> +=09return 0;
> +}
> +
> +static ssize_t led_control_show(struct device *dev, struct device_attrib=
ute
> +=09=09=09=09*attr, char *buf)
> +{
> +=09return sysfs_emit("%u%08x\n", buf, casper_last_led,
> +=09=09       casper_last_color);

I think I mentioned you should put this to one line, why you didn't follow =
it?

> +}
> +
> +/*
> + * Format wanted from user is a hexadecimal 36-bit integer: most signifi=
cant
> + * 4 bits are led_id, next 4 bits are mode and next 4 bits are brightnes=
s,
> + * next 24 bits are rgb value. 64 bits
> + * IMARRGGBB
> + */
> +static ssize_t led_control_store(struct device *dev, struct device_attri=
bute
> +=09=09=09=09 *attr, const char *buf, size_t count)

Don't split argumetns like this but only at commas.

> +{
> +=09if (strlen(buf) !=3D 10)
> +=09=09return -EINVAL;
> +=09u64 user_input;

Wrong place for declaration.

> +=09/*
> +=09 * 16-base selected for ease of writing color codes. I chose 64 bit a=
nd
> +=09 * kstrtou64 because format I use determined fits into 64 bit.
> +=09 */
> +=09int ret =3D kstrtou64(buf, 16, &user_input);

Don't declare varibles in the middle of nowhere even if that is nowadays=20
not prevented by the compiler UNLESS you're using the cleanup.h which is=20
the reason why that is allowed at all.

> +=09if (ret)
> +=09=09return ret;
> +=09/*
> +=09 * led_id can't exceed 255 but it can vary among newer versions and
> +=09 * other models.
> +=09 */
> +=09u8 led_id =3D FIELD_GET(CASPER_LED_ID, user_input);

Add #include <linux/bitfield.h>

> +=09ret =3D casper_set(to_wmi_device(dev->parent), CASPER_SET_LED,
> +=09=09=09led_id, (u32) user_input);
> +=09if (ret)
> +=09=09return ret;
> +=09if (led_id !=3D CASPER_CORNER_LEDS) {
> +=09=09casper_last_color =3D (u32) user_input;
> +=09=09casper_last_led =3D led_id;
> +=09}
> +=09return count;
> +}

So codingstylewise you should do this:

static ssize_t led_control_store(struct device *dev, struct device_attribut=
e *attr,
=09=09=09=09 const char *buf, size_t count)
{
=09struct wdev =3D to_wmi_device(dev->parent);
=09u64 user_input;
=09u8 led_id;

=09ret =3D kstrtou64(buf, 16, &user_input);
=09if (ret)
=09=09return ret;

=09led_id =3D FIELD_GET(CASPER_LED_ID, user_input);
=09ret =3D casper_set(wdev, CASPER_SET_LED, led_id, (u32)user_input);
=09if (ret)
=09=09return ret;

=09if (led_id ...) {
=09=09...
=09}

=09return 0;
}

However, I still suspect this is wrong way to do RGB leds and the multi_*=
=20
sysfs interface is the way you should use.

> +
> +static DEVICE_ATTR_RW(led_control);
> +
> +static struct attribute *casper_kbd_led_attrs[] =3D {
> +=09&dev_attr_led_control.attr,
> +=09NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(casper_kbd_led);
> +
> +static void set_casper_backlight_brightness(struct led_classdev *led_cde=
v,
> +=09=09=09=09=09    enum led_brightness brightness)
> +{
> +=09// Setting any of the keyboard leds' brightness sets brightness of al=
l
> +=09u32 bright_prep =3D FIELD_PREP(CASPER_LED_ALPHA, brightness);
> +=09u32 color_no_alpha =3D casper_last_color&~CASPER_LED_ALPHA;

Missing spaces.

> +
> +=09casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,

Create the wdev local var to avoid need to call to_wmi_device() on this=20
line like I told you already!

> +=09=09       CASPER_KEYBOARD_LED_1, color_no_alpha | bright_prep
> +=09);
> +}
> +
> +static enum led_brightness get_casper_backlight_brightness(struct led_cl=
assdev
> +=09=09=09=09=09=09=09   *led_cdev)
> +{
> +=09return FIELD_GET(CASPER_LED_ALPHA, casper_last_color);
> +}
> +
> +static struct led_classdev casper_kbd_led =3D {
> +=09.name =3D "casper::kbd_backlight",
> +=09.brightness =3D 0,
> +=09.brightness_set =3D set_casper_backlight_brightness,
> +=09.brightness_get =3D get_casper_backlight_brightness,
> +=09.max_brightness =3D 2,
> +=09.groups =3D casper_kbd_led_groups,
> +};
> +
> +static int casper_query(struct wmi_device *wdev, u16 a1,
> +=09=09=09=09struct casper_wmi_args *out)
> +{
> +=09struct casper_wmi_args wmi_args =3D {
> +=09=09.a0 =3D CASPER_READ,
> +=09=09.a1 =3D a1
> +=09};
> +=09struct acpi_buffer input =3D {
> +=09=09(acpi_size) sizeof(struct casper_wmi_args),
> +=09=09&wmi_args
> +=09};
> +
> +=09acpi_status ret =3D wmidev_block_set(wdev, 0, &input);

Put the declaration separately into the declarations block:

=09acpi_status ret;

=09ret =3D wmidev_block_set(wdev, 0, &input);

> +=09if (ACPI_FAILURE(ret))
> +=09=09return -EIO;
> +
> +=09union acpi_object *obj =3D wmidev_block_query(wdev, 0);
> +=09if (obj->type !=3D ACPI_TYPE_BUFFER) // obj will be int (0x10) on fai=
lure
> +=09=09return -EINVAL;
> +=09if (obj->buffer.length !=3D 32)
> +=09=09return -EIO;
> +
> +=09memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
> +=09kfree(obj);
> +=09return ret;
> +}
> +
> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
> +=09=09=09=09=09   enum hwmon_sensor_types type,
> +=09=09=09=09=09   u32 attr, int channel)
> +{
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09return 0444;
> +=09case hwmon_pwm:
> +=09=09return 0644;
> +=09default:
> +=09=09return 0;
> +=09}
> +=09return 0;
> +}
> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +=09=09=09=09 enum hwmon_sensor_types type, u32 attr,
> +=09=09=09=09 int channel, long *val)
> +{
> +=09struct casper_wmi_args out =3D { 0 };
> +=09struct wmi_device *wdev =3D to_wmi_device(dev->parent);
> +=09int ret;
> +
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09ret =3D casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);
> +=09=09/*
> +=09=09 * a4 and a5 is little endian in older laptops (with 10th gen
> +=09=09 * cpus or older) and big endian in newer ones. I don't think
> +=09=09 * dmi has something for cpu information. Also, defining a
> +=09=09 * dmi_list just for this seems like an overkill. This problem
> +=09=09 * can be solved in userspace too.
> +=09=09 */
> +=09=09if (channel =3D=3D 0) // CPU fan
> +=09=09=09*val =3D out.a4;
> +=09=09else if (channel =3D=3D 1) // GPU fan

Instead of comments like this, use defines so you can say:
=09=09if (channel =3D=3D CASPER_FAN_CPU)
=09=09=09...
=09=09if (channel =3D=3D CASPER_FAN_GPU)

> +=09=09=09*val =3D out.a5;
> +=09=09return 0;
> +=09case hwmon_pwm:
> +=09=09ret =3D casper_query(wdev, CASPER_POWERPLAN, &out);
> +=09=09if (ret) // power plan count varies generations.

I fail to see how the comment relates to if (ret) at all because that=20
looks like error handling!

> +=09=09=09return ret;
> +=09=09if (channel =3D=3D 0)
> +=09=09=09*val =3D out.a2;
> +=09=09return 0;
> +=09default:
> +=09=09return -ENODEV;
> +=09}
> +}
> +
> +static int casper_wmi_hwmon_read_string(struct device *dev,
> +=09=09=09=09=09enum hwmon_sensor_types type, u32 attr,
> +=09=09=09=09=09int channel, const char **str)
> +{
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09switch (channel) {
> +=09=09case 0:
> +=09=09=09*str =3D "cpu_fan_speed";
> +=09=09=09break;
> +=09=09case 1:

You can use those defines here too I think.

> +=09=09=09*str =3D "gpu_fan_speed";
> +=09=09=09break;
> +=09=09default:
> +=09=09=09return -ENODEV;
> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09return -ENODEV;
> +=09}

Do you expect other types? If not, this would be easier to follow:


=09if (type !=3D hwmon_fan)
=09=09return -ENODEV;

=09switch (channel) {
=09=09...

> +=09return 0;
> +}
> +
> +static int casper_wmi_hwmon_write(struct device *dev,
> +=09=09=09=09  enum hwmon_sensor_types type, u32 attr,
> +=09=09=09=09  int channel, long val)
> +{
> +=09acpi_status ret;
> +
> +=09switch (type) {
> +=09case hwmon_pwm:
> +=09=09if (val > 5 || val < 0)

There's in_range() which can be used.

> +=09=09=09return -EINVAL;
> +=09=09ret =3D casper_set(to_wmi_device(dev->parent),
> +=09=09=09=09 CASPER_POWERPLAN, val, 0);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09return 0;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}

Similar structural comment here with if + early return as in the above=20
function.

> +}
> +
> +static const struct hwmon_ops casper_wmi_hwmon_ops =3D {
> +=09.is_visible =3D &casper_wmi_hwmon_is_visible,
> +=09.read =3D &casper_wmi_hwmon_read,
> +=09.read_string =3D &casper_wmi_hwmon_read_string,
> +=09.write =3D &casper_wmi_hwmon_write
> +};
> +
> +static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] =
=3D {
> +=09HWMON_CHANNEL_INFO(fan,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL),
> +=09HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
> +=09NULL
> +};
> +
> +static const struct hwmon_chip_info casper_wmi_hwmon_chip_info =3D {
> +=09.ops =3D &casper_wmi_hwmon_ops,
> +=09.info =3D casper_wmi_hwmon_info,
> +};
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *context=
)
> +{
> +=09struct device *hwmon_dev;
> +
> +=09if (ACPI_FAILURE(led_classdev_register(&wdev->dev, &casper_kbd_led)))
> +=09=09return -ENODEV;
> +=09hwmon_dev =3D devm_hwmon_device_register_with_info(&wdev->dev,
> +=09=09=09=09=09=09"casper_wmi", wdev,
> +=09=09=09=09=09=09&casper_wmi_hwmon_chip_info,
> +=09=09=09=09=09=09NULL);
> +=09return PTR_ERR_OR_ZERO(hwmon_dev);

Don't you need to do rollback here for led_classdev_register() if=20
devm_hwmon_device_register_with_info() fails?

> +}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +=09led_classdev_unregister(&casper_kbd_led);
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] =3D {
> +=09{ CASPER_WMI_GUID, NULL },
> +=09{ }
> +};
> +
> +static struct wmi_driver casper_wmi_driver =3D {
> +=09.driver =3D {
> +=09=09   .name =3D "casper-wmi",
> +=09=09    },
> +=09.id_table =3D casper_wmi_id_table,
> +=09.probe =3D casper_wmi_probe,
> +=09.remove =3D &casper_wmi_remove,
> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
> +
> +MODULE_AUTHOR("Mustafa Ek=BAi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");
>=20

--=20
 i.
--8323328-1887983801-1708682173=:1148--

