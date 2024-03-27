Return-Path: <linux-kernel+bounces-121335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695E88E62B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA50C1F307F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58B2139D08;
	Wed, 27 Mar 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcqamP2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5E13958C;
	Wed, 27 Mar 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544723; cv=none; b=gr/+MwQWQMsv/XSd1EqAmIlcWzmTp4LhAg5BouOn234Wjgh7rO1hRr6e3+JQ6UPaJQ6rvs/fEDDl6Y7NAXMPTsQ0x8L2XjTV3tdBlc89n0FvhTakz+wtFh0cQn+nuouU2bQc4C4X/s7EWC/UvqkOk17Z+5UmCwZxLDo0edLdEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544723; c=relaxed/simple;
	bh=8YwpcKIqNazO8SK+TTlaZttTbvn+6kgBPbbLa74c47w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hhgzCT91sdBASAYlChkNFWRaqCk191nMjLLfJvP6qobvhSiQtqSRvbktLY4TpmnJgwrUAVpMENliKWTX7vd0ju1fLbUlLXdNf3JPL1iSBjwk9R9jLHT8KJAj9osob296v0TO+Vxz6GHq1qqHkTm6La1UYdyF2WebhUaCruNzyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcqamP2f; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711544719; x=1743080719;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8YwpcKIqNazO8SK+TTlaZttTbvn+6kgBPbbLa74c47w=;
  b=fcqamP2f3HuUmaiHgAUzcqmF+NrRSApFycuzl0F58B4MsadCo8XSUCeQ
   TXnigvZTBuPourYQ5PcwsX4Wn8DL+5QoX+ACdQ0w0jXrtzS0O3wyGrh6W
   BKwZU7uWZ6yB+W4SKbCX8MdwU1G8R99DWfUZyAx5x04zEr356h6/mRZGk
   Y5y+ARjdh7ZgmT5V4+cr0jbvlF6bhLjbDvr43wga2i2AlDDlLFJwWmCnt
   4PRn/SzPWniAXRHspHWXn292OYcO80K5mFqGud7zrO/4iVlbtnTZWWUHI
   NmJSB4LUGe5CxD1XtVcKbHgluyFLqa/hEGLTR50nSdSm2ey3PA5x2n6oa
   w==;
X-CSE-ConnectionGUID: g2kj6bK6QmaEC7OG7ava3A==
X-CSE-MsgGUID: Vw3HzStJRy2yMhp0+f2gvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6850841"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6850841"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16735547"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:05:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Mar 2024 15:05:12 +0200 (EET)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <998ee474-5e0c-4877-8a95-b22b0edd7837@gmail.com>
Message-ID: <69e28674-58b8-4e77-b4b1-033ccb7e4dce@linux.intel.com>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com> <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com> <998ee474-5e0c-4877-8a95-b22b0edd7837@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Mar 2024, Carlos Ferreira wrote:

> Hi, i have changed some of the code. How does it look now?
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---

First of all, you need to make a proper submission with versioning, that 
is:

- Put version into the subject: PATCH v2
- Don't put extra stuff into changelog like the above question, if you 
need to ask something, put your question underneath the first --- line.
- List the changes you made underneath the first --- line (see ML 
archives for examples about formatting)

>  drivers/platform/x86/hp/hp-wmi.c | 251 +++++++++++++++++++++++++++++--
>  1 file changed, 241 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index e53660422..8108ca7e9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -27,6 +27,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>
> +#include <linux/bitfield.h>

Try to put it earlier, these should eventually be in alphabetic order 
(again, ordered by a separate patch, not this one).

>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>  MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
> @@ -40,6 +41,10 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
>  #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
>  
> +#define FOURZONE_LIGHTING_SUPPORTED_BIT 0x01
> +#define FOURZONE_LIGHTING_ON  228
> +#define FOURZONE_LIGHTING_OFF 100
> +
>  /* DMI board names of devices that should use the omen specific path for
>   * thermal profiles.
>   * This was obtained by taking a look in the windows omen command center
> @@ -131,18 +136,36 @@ enum hp_wmi_commandtype {
>  };
>  
>  enum hp_wmi_gm_commandtype {
> -	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
> -	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
> -	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
> -	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> -	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
> +	HPWMI_FAN_SPEED_GET_QUERY	= 0x11,
> +	HPWMI_SET_PERFORMANCE_MODE	= 0x1A,
> +	HPWMI_FAN_SPEED_MAX_GET_QUERY	= 0x26,
> +	HPWMI_FAN_SPEED_MAX_SET_QUERY	= 0x27,
> +	HPWMI_GET_SYSTEM_DESIGN_DATA	= 0x28,
> +	HPWMI_GET_KEYBOARD_TYPE		= 0x2B,
> +};
> +
> +enum hp_wmi_fourzone_commandtype {
> +	HPWMI_SUPPORTS_LIGHTNING = 0x01,
> +	HPWMI_FOURZONE_COLOR_GET = 0x02,
> +	HPWMI_FOURZONE_COLOR_SET = 0x03,
> +	HPWMI_FOURZONE_MODE_GET  = 0x04,
> +	HPWMI_FOURZONE_MODE_SET  = 0x05,
> +};
> +
> +enum hp_wmi_keyboardtype {
> +	HPWMI_KEYBOARD_INVALID        = 0x00,
> +	HPWMI_KEYBOARD_NORMAL         = 0x01,
> +	HPWMI_KEYBOARD_WITH_NUMPAD    = 0x02,
> +	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
> +	HPWMI_KEYBOARD_RGB	      = 0x04,
>  };
>  
>  enum hp_wmi_command {
> -	HPWMI_READ	= 0x01,
> -	HPWMI_WRITE	= 0x02,
> -	HPWMI_ODM	= 0x03,
> -	HPWMI_GM	= 0x20008,
> +	HPWMI_READ     = 0x01,
> +	HPWMI_WRITE    = 0x02,
> +	HPWMI_ODM      = 0x03,
> +	HPWMI_GM       = 0x20008,
> +	HPWMI_FOURZONE = 0x20009,
>  };
>  
>  enum hp_wmi_hardware_mask {
> @@ -652,6 +675,74 @@ static int hp_wmi_rfkill2_refresh(void)
>  	return 0;
>  }
>  
> +static int fourzone_get_colors(u32 *colors)
> +{
> +	int ret;
> +	u8 buff[128];
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +				   &buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < 4; i++) {
> +		colors[3 - i] = FIELD_PREP(GENMASK(23, 16), buff[25 + i * 3])	   // r
> +			      |	FIELD_PREP(GENMASK(15, 8),  buff[25 + i * 3 + 1])  // g
> +			      | FIELD_PREP(GENMASK(7, 0),   buff[25 + i * 3 + 2]); // b

Those GENMASK() calls should be done in #define and only used here:

#define FOURZONE_COLOR_R		GENMASK(23, 16)
#define FOURZONE_COLOR_G		GENMASK(15, 8)
#define FOURZONE_COLOR_B		GENMASK(7, 0)

You can then drop the comments because the code is self-explanatory.

Add #include <linux/bits.h>.

..But please see my comments about multicolor below.

> +	}
> +
> +	return 0;
> +}
> +
> +static int fourzone_set_colors(u32 *colors)
> +{
> +	int ret;
> +	u8 buff[128];
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +				   &buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < 4; i++) {
> +		buff[25 + i * 3]     = FIELD_GET(GENMASK(23, 16), colors[3 - i]); // r
> +		buff[25 + i * 3 + 1] = FIELD_GET(GENMASK(15, 8),  colors[3 - i]); // g
> +		buff[25 + i * 3 + 2] = FIELD_GET(GENMASK(7, 0),	  colors[3 - i]); // b
> +	}
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
> +				    &buff, sizeof(buff), sizeof(buff));
> +}
> +
> +/*
> + * Returns a negative number on error or 0/1 for the mode.
> + */
> +static int fourzone_get_mode(void)
> +{
> +	int ret;
> +	u8 buff[4];

Try to use reverse xmas tree order where possible (go through the other 
functions too).

> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_MODE_GET, HPWMI_FOURZONE,
> +				   &buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return ret;
> +
> +	return buff[0] == FOURZONE_LIGHTING_ON ? 1 : 0;
> +}
> +
> +/*
> + * This device supports only two different modes:
> + * 1 -> lights on
> + * 0 -> lights off
> + */
> +static int fourzone_set_mode(u32 mode)
> +{
> +	u8 buff[4] = {mode ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF, 0, 0, 0};
> +
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
> +				    &buff, sizeof(buff), 0);
> +}
> +
>  static ssize_t display_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -754,6 +845,58 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	int ret;
> +	u32 colors[4];
> +
> +	ret = fourzone_get_colors(colors);
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%06x %06x %06x %06x\n", colors[0], colors[1], colors[2], colors[3]);
> +}
> +
> +static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int ret;
> +	u32 colors[4];
> +
> +	ret = sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]);
> +	if (ret != 4)
> +		return -EINVAL;

I now realize this should use leds multicolor API instead.

> +	ret = fourzone_set_colors(colors);
> +	return ret == 0 ? count : ret;
> +}
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	u32 ret = fourzone_get_mode();
> +
> +	if (ret < 0)

Please don't save one line like this, put the declaration on own 
line/declaration block so you can keep function call and it's error 
handling next to each other.

Also, compiler should have warned you here because u32 is not the correct 
type and you're checking for < 0!

> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", ret);
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int ret;
> +	u32 mode;
> +
> +	ret = kstrtou32(buf, 10, &mode);
> +	if (ret)
> +		return ret;
> +
> +	ret = fourzone_set_mode(mode);
> +	return ret == 0 ? count : ret;
> +}
> +
>  static int camera_shutter_input_setup(void)
>  {
>  	int err;
> @@ -781,6 +924,34 @@ static int camera_shutter_input_setup(void)
>  	return err;
>  }
>  
> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
> +{
> +	int ret;
> +	u8 buff[128];
> +
> +	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
> +				   &buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return HPWMI_KEYBOARD_INVALID;
> +
> +	/* the first byte in the response represents the keyboard type */
> +	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
> +}
> +
> +static ssize_t type_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	enum hp_wmi_keyboardtype type = fourzone_get_keyboard_type();
> +
> +	if (type == HPWMI_KEYBOARD_INVALID)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%d\n", type - 1);

These are always positive, right? So %u is better.

> +}
> +
> +/*
> + * Generic device attributes.
> + */
>  static DEVICE_ATTR_RO(display);
>  static DEVICE_ATTR_RO(hddtemp);
>  static DEVICE_ATTR_RW(als);
> @@ -797,7 +968,35 @@ static struct attribute *hp_wmi_attrs[] = {
>  	&dev_attr_postcode.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(hp_wmi);
> +
> +static struct attribute_group hp_wmi_group = {
> +	.attrs = hp_wmi_attrs,
> +};
> +
> +/*
> + * Omen fourzone specific device attributes.
> + */
> +static DEVICE_ATTR_RW(colors);
> +static DEVICE_ATTR_RW(mode);
> +static DEVICE_ATTR_RO(type);
> +
> +static struct attribute *hp_wmi_fourzone_attrs[] = {
> +	&dev_attr_colors.attr,
> +	&dev_attr_mode.attr,
> +	&dev_attr_type.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group hp_wmi_fourzone_group = {
> +	.attrs = hp_wmi_fourzone_attrs,
> +	.name = "kbd-backlight",
> +};
> +
> +static const struct attribute_group *hp_wmi_groups[] = {
> +	&hp_wmi_group,
> +	NULL,
> +	NULL,
> +};
>  
>  static void hp_wmi_notify(u32 value, void *context)
>  {
> @@ -1446,6 +1645,35 @@ static int thermal_profile_setup(void)
>  	return 0;
>  }
>  
> +static bool fourzone_supports_lighting(void)
> +{
> +	int ret;
> +	u8 buff[128];
> +
> +	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
> +				   &buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)

< 0 ?

-- 
 i.

> +		return false;
> +
> +	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
> +}
> +
> +static int fourzone_setup(struct platform_device *device)
> +{
> +	/* check if the system supports lighting */
> +	if (!fourzone_supports_lighting())
> +		return -ENODEV;
> +
> +	/* check if we have a supported keyboard type */
> +	if (fourzone_get_keyboard_type() != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
> +		return -ENODEV;
> +
> +	/* register the new groups */
> +	hp_wmi_groups[1] = &hp_wmi_fourzone_group;
> +
> +	return 0;
> +}
> +
>  static int hp_wmi_hwmon_init(void);
>  
>  static int __init hp_wmi_bios_setup(struct platform_device *device)
> @@ -1475,6 +1703,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  
>  	thermal_profile_setup();
>  
> +	/* setup 4 zone rgb, no problem if it fails */
> +	fourzone_setup(device);
> +
>  	return 0;
>  }
>  
> 

