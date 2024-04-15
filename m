Return-Path: <linux-kernel+bounces-145491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407898A56D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995C2B21820
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FD7BAF9;
	Mon, 15 Apr 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHawwHEK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2C1E535;
	Mon, 15 Apr 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196661; cv=none; b=Z5egYbub3SFkOq1bEbElVMhlp6DgI7Jb2PT4JmJHhQ9Md3mOzafrIlBBz6iFc5EOVkW/VVtEhLxd+ZgZfx3Vxvu26sFUhFtJ4rOLrcTcas2t//1lulPNzn3msrMHs1LrdY90JqI5PMRIActkB77U0O00PmLMwKFEOYAjtmGyjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196661; c=relaxed/simple;
	bh=1VFPf/8L9loaEb3hWCEyFbiAGfd1d8Io/SEPciZW5jk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W3rrJxa/3HMh4pyAIkD2nmhZ70fbllg5qiDoHCUCsy32BgPPePmMxEVp59FEhusz+6dPiKGw2wiitClV2HebHsmScfJTCTM8exOO3bshu7goW9sFyPoocYILHgSNn3MtZXbBDN0P5KtR6kmhXBdZS6N1POH6J3IzKNIDSxCNpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHawwHEK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713196659; x=1744732659;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1VFPf/8L9loaEb3hWCEyFbiAGfd1d8Io/SEPciZW5jk=;
  b=gHawwHEKvg5I4QkDsc9nNJP/onPXwJVFOVMmTGJNof7kjJuHYPkOAae5
   Jz28S9wgZFWCY0xP6D3z5EVe9Frr46HQU3TEboSUnK4B6jqRJVuPAtfwl
   5krjgyU1oya0oP+QyxExdaa6rkBt8uaxGMluRlIfdHGgOAfdMo6AcRtpa
   k8CjOu7a8u3eEoGyJLNJH4TtpU+e2f/rGK3PdPe5oC4rwL70gDub1fe5A
   fwUwrdOQuzkrHZOPR3BHYULyufkr1VCXSEayFAAuiAIhRX+30SHT4M1ik
   5VShHlQcMxTmZ3dLxxhnYjOAaSWqs/6PITcZue1SNyD1RwtRN4LIxYpoQ
   w==;
X-CSE-ConnectionGUID: kGnz1jjBTWC5AzSMa1yP5A==
X-CSE-MsgGUID: hhZxhdf/TaO42UfTOgJ9Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19156643"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19156643"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 08:57:38 -0700
X-CSE-ConnectionGUID: JTqYNy7lR/W6ya5NtXaxrQ==
X-CSE-MsgGUID: 1tY8o3/9QoaKdWPxehmVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22052435"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.33])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 08:57:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Apr 2024 18:57:29 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, linux@weissschuh.net, 
    ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: fan: Add hwmon support
In-Reply-To: <20240414174743.8575-1-W_Armin@gmx.de>
Message-ID: <67b4faf4-eadc-3375-62b4-aaad1b3af564@linux.intel.com>
References: <20240414174743.8575-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Apr 2024, Armin Wolf wrote:

> Currently, the driver does only support a custom sysfs
> to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v3:
> - drop fault attrs
> - rework initialization
> 
> Changes since v2:
> - add support for fanX_target and power attrs
> 
> Changes since v1:
> - fix undefined reference error
> - fix fan speed validation
> - coding style fixes
> - clarify that the changes are compile-tested only
> - add hwmon maintainers to cc list
> 
> The changes will be tested by Mikael Lund Jepsen from Danelec and
> should be merged only after those tests.
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/fan.h       |   9 +++
>  drivers/acpi/fan_core.c  |   4 +
>  drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 39ea5cfa8326..61ca4afe83dc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
>  obj-$(CONFIG_ACPI_FAN)		+= fan.o
>  fan-objs			:= fan_core.o
>  fan-objs			+= fan_attr.o
> +fan-$(CONFIG_HWMON)		+= fan_hwmon.o
> 
>  obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>  obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index f89d19c922dc..db25a3898af7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -10,6 +10,8 @@
>  #ifndef _ACPI_FAN_H_
>  #define _ACPI_FAN_H_
> 
> +#include <linux/kconfig.h>
> +
>  #define ACPI_FAN_DEVICE_IDS	\
>  	{"INT3404", }, /* Fan */ \
>  	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
> @@ -57,4 +59,11 @@ struct acpi_fan {
>  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>  int acpi_fan_create_attributes(struct acpi_device *device);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +#else
> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..7cea4495f19b 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>  		if (result)
>  			return result;
> 
> +		result = devm_acpi_fan_create_hwmon(device);
> +		if (result)
> +			return result;
> +
>  		result = acpi_fan_create_attributes(device);
>  		if (result)
>  			return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..0ae9017bdbae
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/units.h>
> +
> +#include "fan.h"
> +
> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE	0xffffffff
> +#define FAN_POWER_UNAVAILABLE	0xffffffff
> +
> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
> +{
> +	int i;
> +
> +	for (i = 0; i < fan->fps_count; i++) {
> +		if (fan->fps[i].control == control)
> +			return &fan->fps[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	const struct acpi_fan *fan = drvdata;
> +	int i;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return 0444;
> +		case hwmon_fan_target:
> +			/* When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */
> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			/* When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */
> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			/* When all fan performance states contain no valid power data,
> +			 * when the associated atttribute should not be created.

attribute

-- 
 i.


> +			 */
> +			for (i = 0; i < fan->fps_count; i++) {
> +				if (fan->fps[i].power != FAN_POWER_UNAVAILABLE)
> +					return 0444;
> +			}
> +
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			 long *val)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev->parent);
> +	struct acpi_fan *fan = dev_get_drvdata(dev);
> +	struct acpi_fan_fps *fps;
> +	struct acpi_fan_fst fst;
> +	int ret;
> +
> +	ret = acpi_fan_get_fst(adev, &fst);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			if (fst.speed == FAN_SPEED_UNAVAILABLE)
> +				return -ENODATA;
> +
> +			if (fst.speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fst.speed;
> +			return 0;
> +		case hwmon_fan_target:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -ENODATA;
> +
> +			*val = fps->speed;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -ENODATA;
> +
> +			if (fps->power == FAN_POWER_UNAVAILABLE)
> +				return -ENODATA;
> +
> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
> +				return -EOVERFLOW;
> +
> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops acpi_fan_ops = {
> +	.is_visible = acpi_fan_is_visible,
> +	.read = acpi_fan_read,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_chip_info = {
> +	.ops = &acpi_fan_ops,
> +	.info = acpi_fan_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(device);
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", fan,
> +						    &acpi_fan_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
> 

