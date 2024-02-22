Return-Path: <linux-kernel+bounces-76270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FD85F4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6188B27F03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5838DD8;
	Thu, 22 Feb 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMiyvQZS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537A381A1;
	Thu, 22 Feb 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595305; cv=none; b=iLH7D+nEYeo+nYH42epWwN+6YlDWTgG89SuJ+7IXRmnIQhrpttSLsk/1hOcMq5CpETt6zr+TyE7AL/Nqz1MPNMthERrB6aeCpz/vt4rv76uSLLNMhHjJ1VfqvVySR3+qCRhcJSVrvaZnMJZW4KJPMnps8tBFS0PS/vZ24Fu/wO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595305; c=relaxed/simple;
	bh=dmUazriXwFNzM3sE1wGM7IS3zRztscYDLyUV2Em9rYo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VXeOaKHxRKIxbftD0WD52AKBs9kViDv9qhI649VLs3wcz69U216I87lRmMP9F3oisVqNeul0K87qhxgoI6xqzs4G2D7JydLjp11a5N0ojQOjmY/UO5OZrZ3TaOUnaYH8F2MkPOnrCYHTV7X2g0WkEdfdk+iSG2XT4hzRp3dSris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMiyvQZS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708595303; x=1740131303;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dmUazriXwFNzM3sE1wGM7IS3zRztscYDLyUV2Em9rYo=;
  b=ZMiyvQZSjbq9w2iFCOmBApOFSCcHyC79/O/kKzc0R/7FjLbP72BiOTlm
   Kr+eZC5Fn4BJqDlxf1ckUTwLoS5yOKw1frriuYYOw7ojjOmwugr0RgaeG
   x8ezoo6s2+sogMsSsPbb1MLP6BayyAnRXW4l5fLwp4HSx9HD8WrDDLmkd
   W48rQt0z8JxXuiGtIc1U+WnMQ/lTmnhUAnvwoddFvti30p565uM3tDbJD
   FevAI5UQB2Rp4tpEyCDO2okwoNqPe8CJEuveLpz9tmw3gNy/5RKdflGQg
   CdPRhh28q9ijCJedxdsWiI+ZIzkm37kAVaRLQj72kKjElB2cmDRPP3rXB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28250671"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28250671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5403694"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:48:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 11:48:14 +0200 (EET)
To: =?ISO-8859-2?Q?Mustafa_Ek=BAi?= <mustafa.eskieksi@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, Pavel Machek <pavel@ucw.cz>, 
    Lee Jones <lee@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Add wmi driver support for Casper Excalibur laptops.
In-Reply-To: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
Message-ID: <2716dc6e-d091-f61c-7f77-a87215adfe19@linux.intel.com>
References: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1497083232-1708595294=:1961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1497083232-1708595294=:1961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

Added LED subsys people, please include them in future versions=20
automatically.

On Thu, 22 Feb 2024, Mustafa Ek=C5=9Fi wrote:

> Signed-off-by: Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
> ---
>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 344 ++++++++++++++++++++++++++++++
>  4 files changed, 365 insertions(+)
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
> +M:=09Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
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
> index 00000000000..aae08202b19
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/dmi.h>
> +#include <acpi/acexcep.h>
> +
> +MODULE_AUTHOR("Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");

Put these to the end of file.

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
> +struct casper_wmi_args {
> +=09u16 a0, a1;
> +=09u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +static u32 casper_last_color;
> +static u8 casper_last_led;
> +
> +static acpi_status casper_set(struct wmi_device *wdev, u16 a1, u8 led_id=
,
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
> +=09return wmidev_block_set(wdev, 0, &input);
> +}
> +
> +static ssize_t led_control_show(struct device *dev, struct device_attrib=
ute
> +=09=09=09=09*attr, char *buf)
> +{
> +=09return sprintf("%u%08x\n", buf, casper_last_led,
> +=09=09       casper_last_color);

Fits one line. Use sysfs_emit().

> +}
> +
> +
> +// input is formatted as "IMARRGGBB", I: led_id, M: mode, A: brightness,=
 ...

If you do things like this, please add defines for such "fields" and use=20
FIELD_GET/PREP().

Could LED subsystem folks plese check this the correct way to do RGB=20
control? (I suspect it's not).

> +static ssize_t led_control_store(struct device *dev, struct device_attri=
bute
> +=09=09=09=09 *attr, const char *buf, size_t count)
> +{
> +=09u64 tmp;
> +=09int ret;
> +
> +=09ret =3D kstrtou64(buf, 16, &tmp);
> +
> +=09if (ret)
> +=09=09return ret;

Don't place empty line between function and its error handling. Please go=
=20
through the entire patch and fix all of them (I won't mark them all).

> +
> +=09u8 led_id =3D (tmp >> (8 * 4))&0xFF;

FIELD_GET() + add #include for it.

> +
> +=09ret =3D
> +=09    casper_set(to_wmi_device(dev->parent), CASPER_SET_LED, led_id,
> +=09=09       (u32) tmp

Don't call variable "tmp"!

Please create a local variable for these to_wmi_device(dev->parent) to=20
make this fit one line.

> +=09    );
> +=09if (ACPI_FAILURE(ret)) {
> +=09=09dev_err(dev, "casper-wmi ACPI status: %d\n", ret);
> +=09=09return ret;
> +=09}
> +=09if (led_id !=3D CASPER_CORNER_LEDS) {
> +=09=09casper_last_color =3D (u32) tmp;
> +=09=09casper_last_led =3D led_id;
> +=09}
> +=09return count;
> +}
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
> +=09acpi_status ret =3D
> +=09    casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
> +=09=09       CASPER_KEYBOARD_LED_1,
> +=09=09       (casper_last_color & 0xF0FFFFFF) |
> +=09=09       (((u32) brightness) << 24)

Use FIELD_PREP().

As you need to split lines, please do the calculations in a local variable=
=20
beforehand and only then call.

> +=09    );
> +
> +=09if (ret !=3D 0)
> +=09=09dev_err(led_cdev->dev,
> +=09=09=09"Couldn't set brightness acpi status: %d\n", ret);
> +}
> +
> +static enum led_brightness get_casper_backlight_brightness(struct led_cl=
assdev
> +=09=09=09=09=09=09=09   *led_cdev)
> +{
> +=09return (casper_last_color&0x0F000000)>>24;

FIELD_GET().

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
> +static acpi_status casper_query(struct wmi_device *wdev, u16 a1,
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
> +
> +=09if (ACPI_FAILURE(ret)) {
> +=09=09dev_err(&wdev->dev,
> +=09=09=09"Could not query acpi status: %u", ret);

One line.

> +=09=09return ret;
> +=09}
> +
> +=09union acpi_object *obj =3D wmidev_block_query(wdev, 0);
> +
> +=09if (obj =3D=3D NULL) {
> +=09=09dev_err(&wdev->dev,
> +=09=09=09"Could not query hardware information");

Ditto.

> +=09=09return AE_ERROR;
> +=09}
> +=09if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +=09=09dev_err(&wdev->dev, "Return type is not a buffer");
> +=09=09return AE_TYPE;
> +=09}
> +
> +=09if (obj->buffer.length !=3D 32) {
> +=09=09dev_err(&wdev->dev, "Return buffer is not long enough");
> +=09=09return AE_ERROR;
> +=09}
> +=09memcpy(out, obj->buffer.pointer, 32);

32 appears at least twice here, add define for it.

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
> +
> +=09switch (type) {
> +=09case hwmon_fan:
> +=09=09acpi_status ret =3D casper_query(to_wmi_device(dev->parent),
> +=09=09=09=09=09       CASPER_GET_HARDWAREINFO, &out);
> +
> +=09=09if (ACPI_FAILURE(ret))
> +=09=09=09return ret;

Don't put empty line between the call and its error handling. Move=20
the declaration of the ret variable to function level.


> +=09=09if (channel =3D=3D 0) { // CPU fan
> +=09=09=09u32 cpu_fanspeed =3D out.a4;
> +
> +=09=09=09cpu_fanspeed <<=3D 8;
> +=09=09=09cpu_fanspeed +=3D out.a4 >> 8;

Is this byteswapping? Use proper endianness helpers/types when dealing=20
with endianness.

> +=09=09=09*val =3D (long) cpu_fanspeed;
> +=09=09} else if (channel =3D=3D 1) { // GPU fan
> +=09=09=09u32 gpu_fanspeed =3D out.a5;
> +
> +=09=09=09gpu_fanspeed <<=3D 8;
> +=09=09=09gpu_fanspeed +=3D out.a5 >> 8;
> +=09=09=09*val =3D (long) gpu_fanspeed;
> +=09=09}

Should the other channel values return -ENODEV or -EINVAL?

> +=09=09return 0;
> +=09case hwmon_pwm:
> +=09=09casper_query(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +=09=09=09     &out);
> +=09=09if (channel =3D=3D 0)
> +=09=09=09*val =3D (long)out.a2;
> +=09=09else
> +=09=09=09return -EOPNOTSUPP;
> +=09=09return 0;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09return 0;
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
> +=09=09=09*str =3D "gpu_fan_speed";
> +=09=09=09break;
> +=09=09default:
> +=09=09=09return -EOPNOTSUPP;
> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
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
> +=09=09if (channel !=3D 0)
> +=09=09=09return -EOPNOTSUPP;
> +=09=09ret =3D
> +=09=09    casper_set(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +=09=09=09       val, 0);
> +
> +=09=09if (ACPI_FAILURE(ret)) {
> +=09=09=09dev_err(dev, "Couldn't set power plan, acpi_status: %d",
> +=09=09=09=09ret);
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09=09return 0;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
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
> +=09// All Casper Excalibur Laptops use this GUID
> +=09if (!wmi_has_guid(CASPER_WMI_GUID))
> +=09=09return -ENODEV;
> +
> +=09hwmon_dev =3D
> +=09    devm_hwmon_device_register_with_info(&wdev->dev, "casper_wmi", wd=
ev,
> +=09=09=09=09=09=09 &casper_wmi_hwmon_chip_info,
> +=09=09=09=09=09=09 NULL);
> +
> +=09acpi_status result =3D led_classdev_register(&wdev->dev, &casper_kbd_=
led);
> +
> +=09if (result !=3D 0)
> +=09=09return -ENODEV;
> +
> +=09return PTR_ERR_OR_ZERO(hwmon_dev);
> +=09}

Misindented brace.

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
> +=09.remove =3D &casper_wmi_remove

Put comma to the end of this line.

> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
>=20

--=20
 i.

--8323328-1497083232-1708595294=:1961--

