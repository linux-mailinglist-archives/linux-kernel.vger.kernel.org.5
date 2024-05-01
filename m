Return-Path: <linux-kernel+bounces-164852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6B8B83FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D659BB21B88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051C522A;
	Wed,  1 May 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoFl8gBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58194437;
	Wed,  1 May 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527387; cv=none; b=r31uCbvixHUnxo/t7/fViw/J7w+AK+XSIu8+IFAi+cso5EipOExYkrHgT/sJmp8r13CBDc8tac9zoHcciRHDQXPY5rxPqSWRU2cDeQJHb3HVPL5k5hF4Mr/6iboBMLeUSu103y7YjSPeGd/BALd+XHZ3DxN/DzW1BCRIn2BhoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527387; c=relaxed/simple;
	bh=YbyB5uFZ5GL7wTKxhEqJGouiS+nev54QnSgi0q7UgLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmIRcI7tRqp3zItk1TXl9j1THf9Nco118Homj5KEthS2WtimxpnKaG0JkINLLtavtwIotc3Y00ianV0FH2o6vEQOzkqgZs5HpAu2eUIr4OgmHuk7ZCy8ewvpKx1Fl6OjABtB89FWofMhhN53yi3smMJ4qKIjoJkaarSaOOz5Fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoFl8gBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6BC2BBFC;
	Wed,  1 May 2024 01:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714527387;
	bh=YbyB5uFZ5GL7wTKxhEqJGouiS+nev54QnSgi0q7UgLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoFl8gBZXnEf51PLxGFnIl7Ovi0YE46t37IUO+Ur/yxNZVuHA8vb/tBnOdtcJOGBm
	 yUmB8ZI7L8sZAhHQS9dHE38SJm8F5Fj4rnMpVTuwilxIx4mlOWocAncO8bKf4XD++4
	 rFlLrIgw8p6CnghyQG7dD6ncBPQzUZS24PDz4GnilBZk93HB5xeyt3Vjf8lPBwl+zH
	 N2rWGPMPwC/jDKfreC4z92i5zL7VRqsmwmB3ogFdaJwQaaD3Hw6j/rLuSIIyZnfqu9
	 I6qnRs7u31UTgftudCWoTgrcIzd8D4RiXPtOe1DrOFvea4GPJyh1AEK4jKNTthdVdj
	 De28iajxCEPSA==
Received: by pali.im (Postfix)
	id EBD547FD; Wed,  1 May 2024 03:36:23 +0200 (CEST)
Date: Wed, 1 May 2024 03:36:23 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	lkp@intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v4] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <20240501013623.ia3debwadlu2qzff@pali>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501011507.6942-2-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501011507.6942-2-lsanche@lyndeno.ca>
User-Agent: NeoMutt/20180716

On Tuesday 30 April 2024 19:14:52 Lyndon Sanche wrote:
> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
> 
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
> v4:
>  - Make thermal_init and thermal_cleanup static
>  - Rearrange order of added includes, did not edit current includes
>  - Include bits.h
>  - Switch comment style
>  - Return error if platform_profile registering failed
>  - Add thermal calls to call_blacklist
>  - Align defines with tabs
>  - Correct separation of function and error handling
>  - Propagate error codes up
> v3:
>  - Convert smbios-thermal-ctl docs to multiline comment and wrap
>  - Change thermal_mode_bits enum to directly be BIT() values
> 	- Convert related code to use this
>  - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
> 	- Correct offset for getting current ACC mode, setting offset
> 		unchanged
>  - Check if thermal_handler is allocated before freeing and
> 	 unregistering platform_profile
> v2:
>  - Wrap smbios-thermal-ctl comment
>  - Return proper error code when invalid state returned
>  - Simplify platform_profile_get returns
>  - Propogate ENOMEM error
> ---
>  drivers/platform/x86/dell/dell-laptop.c      | 238 +++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios-base.c |   2 +
>  drivers/platform/x86/dell/dell-smbios.h      |   1 +
>  3 files changed, 241 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..530ee6079447 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,9 @@
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>  static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
> @@ -2199,6 +2203,232 @@ static int mute_led_set(struct led_classdev *led_cdev,
>  	return 0;
>  }
>  
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 = Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
> + *                 Each mode corresponds to the supported thermal modes in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and

Broken indentation. cbArg1 should have only one space after "*" and be
at the same level as the previous cbArg1 description.

And I would suggest to add a newline before cbArg1 as it start
description of the next command.

> + *               desired AAC mode shall be applied
> + *  cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *

And here I would suggest to remove empty line as the comment below
belongs to the AAC description above the empty line.

> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
> +
> +enum thermal_mode_bits {
> +	DELL_BALANCED = BIT(0),
> +	DELL_COOL_BOTTOM = BIT(1),
> +	DELL_QUIET = BIT(2),
> +	DELL_PERFORMANCE = BIT(3),
> +};
> +
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
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
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
> +	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
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
> +	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
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
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret;
> +
> +	ret = thermal_get_mode();
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
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
> +static int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	/* If thermal modes not supported, exit without error */
> +	ret = thermal_get_supported_modes(&supported_modes);
> +	if (ret < 0)
> +		return ret;
> +	if (!supported_modes)
> +		return 0;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	/* Clean up if failed */
> +	ret = platform_profile_register(thermal_handler);
> +	if (ret)
> +		kfree(thermal_handler);
> +
> +	return ret;
> +}
> +
> +static void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>  static struct led_classdev mute_led_cdev = {
>  	.name = "platform::mute",
>  	.max_brightness = 1,
> @@ -2238,6 +2468,11 @@ static int __init dell_init(void)
>  		goto fail_rfkill;
>  	}
>  
> +	/* Do not fail module if thermal modes not supported, just skip */
> +	ret = thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_init(&platform_device->dev);
>  
> @@ -2317,6 +2552,8 @@ static int __init dell_init(void)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>  fail_rfkill:
>  	platform_device_del(platform_device);
>  fail_platform_device2:
> @@ -2344,6 +2581,7 @@ static void __exit dell_exit(void)
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> +	thermal_cleanup();
>  }
>  
>  /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..40aa4469b38b 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -9,6 +9,7 @@
>   *  Based on documentation in the libsmbios package:
>   *  Copyright (C) 2005-2014 Dell Inc.
>   */
> +#include "linux/wmi.h"

Is this include file really used? Because only SELECT_THERMAL_MANAGEMENT
was added and it is in the dell-smbios.h. And others constants like
SELECT_KBD_BACKLIGHT did not needed it.

>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> @@ -71,6 +72,7 @@ static struct smbios_call call_blacklist[] = {
>  	/* handled by kernel: dell-laptop */
>  	{0x0000, CLASS_INFO, SELECT_RFKILL},
>  	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>  };
>  
>  struct token_range {
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
> -- 
> 2.42.0
> 

