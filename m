Return-Path: <linux-kernel+bounces-159605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E88B30E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8FC281E31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C43313AD01;
	Fri, 26 Apr 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiVsv2bc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07E567F;
	Fri, 26 Apr 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114635; cv=none; b=EJSoxwY/0+Uq6+Zbe0S93nXTD5qExke17C24PON/ETPUow+uKmZRB2Nu1zHHeWFwOBzJrjiN1SItfAUbD/9RiIekIOpwzrsTeN5Ck6Ifp8DJb/j8zwJtI81Rdsn7HavjXxk16AzP6aD73Yge0mM1NhZx7NaY1vjGJWbyjASMlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114635; c=relaxed/simple;
	bh=unTxuQNOdM/U1EpOcx+yhVVaT4i3FdvVzVfT0F7HGt4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eFR9z/EKe2IFFT64HnrbvKAKJCimgUhZVP5WXlyPD+ewn8sCh2qaCpYjb0QNcb9goFdHZb0RderTULVj7cv23AJYfbbn4ADVXfUWH8xB0o+Q8MI2y1HNc+p9b9zQ1RyO0ChtEPSNHlWnJyBaPj49mLC2EMrIqdMMjoRIvFMGb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiVsv2bc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714114634; x=1745650634;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=unTxuQNOdM/U1EpOcx+yhVVaT4i3FdvVzVfT0F7HGt4=;
  b=TiVsv2bcq4Rv6b0xa4h3DuPF0emwtGmu5H9tzDy7DxslXiec2IjXEekR
   IPK2z32acH31xBfW0BWcYJOEqKAyz9P9KEzNRMv5CDR9OkufUmLXMli1P
   IPCrKGunVThyn7oekbAIOO26BG3enknKdela6e0C5q+qLQkuUOLHu0/Ek
   a8bcn56YKtC2QujdfhUyAGYIJbjEhIXnGv81VN9da/pK8xW6MD28HbTvX
   kubngCVGH5o/JdU9lFVjvnwWfYn/y+wCYJd8dC/cwSjlKIVJRNgsxlIv+
   N9VRFqZMA8IexgeVD4aQcs9rXL+i4AujjtgB1Z1bVVjKiJR4qD4N6VWLE
   A==;
X-CSE-ConnectionGUID: d82hKRuRSRm339XNT2dSqg==
X-CSE-MsgGUID: UTupQ41lQtGFlh7VzN4qlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9693698"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="9693698"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:57:13 -0700
X-CSE-ConnectionGUID: F1+KTXOXShqYhNL/eyZYIg==
X-CSE-MsgGUID: rJ2FFHFuTf6Hestt9zr8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29776300"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:57:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 09:57:06 +0300 (EEST)
To: Lyndon Sanche <lsanche@lyndeno.ca>
cc: Matthew Garrett <mjg59@srcf.ucam.org>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
Message-ID: <3e99b429-835e-07e1-358f-f67128cb2e87@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Apr 2024, Lyndon Sanche wrote:

> Some Dell laptops support configuration of preset
> fan modes through smbios tables.
> 
> If the platform supports these fan modes, set up
> platform_profile to change these modes. If not
> supported, skip enabling platform_profile.

These are too short lines, wrap at 72 (or 75) characters.

> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 220 ++++++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h |   1 +
>  2 files changed, 221 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..7f9c4e0e5ef5 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,7 @@
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <linux/platform_profile.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -95,10 +96,18 @@ static struct backlight_device *dell_backlight_device;
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>  static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
>  
> +enum thermal_mode_bits {
> +	DELL_BALANCED = 0,
> +	DELL_COOL_BOTTOM = 1,
> +	DELL_QUIET = 2,
> +	DELL_PERFORMANCE = 3,
> +};

It would seem more more natural to define these with BIT(x) as that's how 
they're used in the code below?

>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
>  
> @@ -2199,6 +2208,211 @@ static int mute_led_set(struct led_classdev *led_cdev,
>  	return 0;
>  }
>  
> +// Derived from smbios-thermal-ctl
> +//
> +// cbClass 17
> +// cbSelect 19
> +// User Selectable Thermal Tables(USTT)
> +// cbArg1 determines the function to be performed
> +// cbArg1 0x0 = Get Thermal Information
> +//  cbRES1         Standard return codes (0, -1, -2)
> +//  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if its bit is set to 1
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes. Each mode
> +//                 corresponds to the supported thermal modes in byte 0. A mode is supported if
> +//                 its bit is set to 1.
> +//     Bit 0 AAC (Balanced)
> +//     Bit 1 AAC (Cool Bottom
> +//     Bit 2 AAC (Quiet)
> +//     Bit 3 AAC (Performance)
> +//  cbRes3, byte 0 Current Thermal Mode
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performanc
> +//  cbRes3, byte 1  AAC Configuration type
> +//          0       Global (AAC enable/disable applies to all supported USTT modes)
> +//          1       USTT mode specific
> +//  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> +//     If AAC Configuration Type is Global,
> +//          0       AAC mode disabled
> +//          1       AAC mode enabled
> +//     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> +//          Bit 0 AAC (Balanced)
> +//          Bit 1 AAC (Cool Bottom
> +//          Bit 2 AAC (Quiet)
> +//          Bit 3 AAC (Performance)
> +//  cbRes3, byte 3  Current Fan Failure Mode
> +//     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> +//     Bit 1 Catastrophic Fan Failure (all fans have failed)
> +//  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
> +//               desired AAC mode shall be applied
> +//  cbArg2, byte 0  Desired Thermal Mode to set (only one bit may be set for this parameter)
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> +//     If AAC Configuration Type is Global,
> +//         0  AAC mode disabled
> +//         1  AAC mode enabled
> +//
> +//     If AAC Configuration Type is USTT mode specific (multiple bits may be set for this parameter),
> +//         Bit 0 AAC (Balanced)
> +//         Bit 1 AAC (Cool Bottom
> +//         Bit 2 AAC (Quiet)
> +//         Bit 3 AAC (Performance)

Please use

/*
 *
 */

format for multiline comments.

Don't exceed 80 characters with comments.

> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	state = buffer.output[2];
> +	if ((state >> DELL_BALANCED) & 1)
> +		return DELL_BALANCED;
> +	else if ((state >> DELL_COOL_BOTTOM) & 1)
> +		return DELL_COOL_BOTTOM;
> +	else if ((state >> DELL_QUIET) & 1)
> +		return DELL_QUIET;
> +	else if ((state >> DELL_PERFORMANCE) & 1)
> +		return DELL_PERFORMANCE;

When you convert defines to use BIT(), these become simpler.

> +	else
> +		return 0;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*supported_bits = buffer.output[1] & 0xF;

Add named define + use FIELD_GET() + add #include <linux/bitfield.h> if 
not there already.

> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = ((buffer.output[3] >> 8) & 0xFF);

Use named define + FIELD_GET()

> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, (acc_mode << 8) | BIT(state), 0, 0);

Named define + FIELD_PREP(XX, acc_mode)

After converting the enum values to use BIT(), you can remove BIT() from 
here.

> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		ret = thermal_set_mode(DELL_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret = thermal_set_mode(DELL_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		ret = thermal_set_mode(DELL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_COOL:
> +		ret = thermal_set_mode(DELL_COOL_BOTTOM);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	switch (thermal_get_mode()) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret = thermal_get_supported_modes(&supported_modes);
> +
> +	if (ret != 0 || supported_modes == 0)

Don't leave empty lines between call and its error handling.

> +		return -ENXIO;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if ((supported_modes >> DELL_QUIET) & 1)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if ((supported_modes >> DELL_BALANCED) & 1)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)

These too will get simpler when the values are using BIT().

> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	platform_profile_register(thermal_handler);
> +
> +	return 0;
> +}
> +
> +void thermal_cleanup(void)
> +{
> +	platform_profile_remove();

This should be called if thermal_init() failed, sysfs_remove_group() will 
be called for a group that was never created and I don't think that's 
okay.

> +	kfree(thermal_handler);
> +}
> +
>  static struct led_classdev mute_led_cdev = {
>  	.name = "platform::mute",
>  	.max_brightness = 1,
> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>  		mute_led_registered = true;
>  	}
>  
> +	// Do not fail module if thermal modes not supported,
> +	// just skip

Fits to one line.

> +	if (thermal_init() != 0)
> +		pr_warn("Unable to setup platform_profile, skipping");
> +
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;
>  
> @@ -2344,6 +2563,7 @@ static void __exit dell_exit(void)
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> +	thermal_cleanup();
>  }
>  
>  /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index eb341bf000c6..585d042f1779 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>  /* Classes and selects used only in kernel drivers */
>  #define CLASS_KBD_BACKLIGHT 4
>  #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>  
>  /* Tokens used in kernel drivers, any of these
>   * should be filtered from userspace access
> 

-- 
 i.


