Return-Path: <linux-kernel+bounces-118845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E78288C01F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C161F3616C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB647F45;
	Tue, 26 Mar 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHluTOVE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191B23D0;
	Tue, 26 Mar 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451129; cv=none; b=TMDuRX/yxTlYn5Irys/6ScPdF9HaBXTN+XpZzEr9AQmGfaQ6dhH1dEQuVxt1pfpov3chwj6LGFOBSwfK9qsorPxXNY9suLQ1jDr2AMTWFqQtU/VtOrm1vXPD4AME9gdYq69mkoiA6rRXikGxGWKT4pAjcLdcjX2+dGWgm4lmDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451129; c=relaxed/simple;
	bh=Il2RTZya9cRb76sjzm3oN7L+48hgsnJ5aKx7MdO36MI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=or7mlaAPVaE8Q9pqIwxEEuGGLME9Jm4/w3gyOkHpPOer5A14b7zHU8IS9ydPv/MI56aBAufFVggErlU759N3OB5XS+bMZ0TMQcvQFIDqXCw9jwOWlfpyfk2KuPLTaLMF5ULyGHnLN97asJHjTnnltluykDppa3g2r2yVNiP6PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHluTOVE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711451128; x=1742987128;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Il2RTZya9cRb76sjzm3oN7L+48hgsnJ5aKx7MdO36MI=;
  b=JHluTOVE1zHssww8DqyN0KGnrFUadvblmntB6iw+zj5n+v6v7CucdlCl
   +4vvBlAZY04Ja55GPBP5bB1B68hhkIBYOEf0xzrwxxtctnjVJEYwi5op2
   GMnON33wiOz1u0LaHUXvkelKWzCzrHxOtTUCG/fxkrIEReyIt2jl0fk4C
   CJhExMwPyrXFAXruHzg3v4BVEe+sg7D0+62loYN7R+4qZj6JyKI+hYLSK
   duAmpJTIakAObGDYe0JCxmxR8w97I5EQ3uoX+7K0nwoUc0QniC1Hsw4lO
   A3ZLi1098DOUasyt/ImC9Ccvh+SvpXboWwmk44/u18FZ/QHahXix8hom3
   w==;
X-CSE-ConnectionGUID: tS9u6MZjQqiuDWHe4FML2Q==
X-CSE-MsgGUID: EtQHfR85Qw+e8VyQAngipQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6360413"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6360413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20480953"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.20])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:05:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 26 Mar 2024 13:05:17 +0200 (EET)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
Message-ID: <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Mar 2024, Carlos Ferreira wrote:

> Added support for 4 zone keyboard rgb on omen laptops.
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 308 +++++++++++++++++++++++++++----
>  1 file changed, 273 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index e53660422..f420f41c7 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -103,7 +103,7 @@ enum hp_wmi_event_ids {
>  /*
>   * struct bios_args buffer is dynamically allocated.  New WMI command types
>   * were introduced that exceeds 128-byte data size.  Changes to handle
> - * the data size allocation scheme were kept in hp_wmi_perform_qurey function.
> + * the data size allocation scheme were kept in hp_wmi_perform_query function.

Good change, but unrelated to "added support for" patch. Please make a 
separate change out of it.

>   */
>  struct bios_args {
>  	u32 signature;
> @@ -114,15 +114,15 @@ struct bios_args {
>  };
>  
>  enum hp_wmi_commandtype {
> -	HPWMI_DISPLAY_QUERY		= 0x01,
> -	HPWMI_HDDTEMP_QUERY		= 0x02,
> -	HPWMI_ALS_QUERY			= 0x03,
> +	HPWMI_DISPLAY_QUERY			= 0x01,
> +	HPWMI_HDDTEMP_QUERY			= 0x02,
> +	HPWMI_ALS_QUERY				= 0x03,

Likewise, these changes of whitespace are unrelated so if you want to 
make them, please make a separate patch for them (please go through your 
whole patch this in mind).

>  	HPWMI_HARDWARE_QUERY		= 0x04,
>  	HPWMI_WIRELESS_QUERY		= 0x05,
> -	HPWMI_BATTERY_QUERY		= 0x07,
> -	HPWMI_BIOS_QUERY		= 0x09,
> -	HPWMI_FEATURE_QUERY		= 0x0b,
> -	HPWMI_HOTKEY_QUERY		= 0x0c,
> +	HPWMI_BATTERY_QUERY			= 0x07,
> +	HPWMI_BIOS_QUERY			= 0x09,
> +	HPWMI_FEATURE_QUERY			= 0x0b,
> +	HPWMI_HOTKEY_QUERY			= 0x0c,
>  	HPWMI_FEATURE2_QUERY		= 0x0d,
>  	HPWMI_WIRELESS2_QUERY		= 0x1b,
>  	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
> @@ -131,18 +131,36 @@ enum hp_wmi_commandtype {
>  };
>  
>  enum hp_wmi_gm_commandtype {
> -	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
> -	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
> +	HPWMI_FAN_SPEED_GET_QUERY	  = 0x11,
> +	HPWMI_SET_PERFORMANCE_MODE    = 0x1A,
>  	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
>  	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> -	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
> +	HPWMI_GET_SYSTEM_DESIGN_DATA  = 0x28,
> +	HPWMI_GET_KEYBOARD_TYPE		  = 0x2B,
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
> +	HPWMI_KEYBOARD_INVALID		  = 0x00,
> +	HPWMI_KEYBOARD_NORMAL		  = 0x01,
> +	HPWMI_KEYBOARD_WITH_NUMPAD	  = 0x02,
> +	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
> +	HPWMI_KEYBOARD_RGB			  = 0x04,
>  };
>  
>  enum hp_wmi_command {
> -	HPWMI_READ	= 0x01,
> -	HPWMI_WRITE	= 0x02,
> -	HPWMI_ODM	= 0x03,
> -	HPWMI_GM	= 0x20008,
> +	HPWMI_READ	   = 0x01,
> +	HPWMI_WRITE	   = 0x02,
> +	HPWMI_ODM	   = 0x03,
> +	HPWMI_GM	   = 0x20008,
> +	HPWMI_FOURZONE = 0x20009,
>  };
>  
>  enum hp_wmi_hardware_mask {
> @@ -156,18 +174,18 @@ struct bios_return {
>  };
>  
>  enum hp_return_value {
> -	HPWMI_RET_WRONG_SIGNATURE	= 0x02,
> -	HPWMI_RET_UNKNOWN_COMMAND	= 0x03,
> -	HPWMI_RET_UNKNOWN_CMDTYPE	= 0x04,
> -	HPWMI_RET_INVALID_PARAMETERS	= 0x05,
> +	HPWMI_RET_WRONG_SIGNATURE	 = 0x02,
> +	HPWMI_RET_UNKNOWN_COMMAND	 = 0x03,
> +	HPWMI_RET_UNKNOWN_CMDTYPE	 = 0x04,
> +	HPWMI_RET_INVALID_PARAMETERS = 0x05,
>  };
>  
>  enum hp_wireless2_bits {
> -	HPWMI_POWER_STATE	= 0x01,
> -	HPWMI_POWER_SOFT	= 0x02,
> -	HPWMI_POWER_BIOS	= 0x04,
> -	HPWMI_POWER_HARD	= 0x08,
> -	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
> +	HPWMI_POWER_STATE	 = 0x01,
> +	HPWMI_POWER_SOFT	 = 0x02,
> +	HPWMI_POWER_BIOS	 = 0x04,
> +	HPWMI_POWER_HARD	 = 0x08,
> +	HPWMI_POWER_FW_OR_HW = HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>  };
>  
>  enum hp_thermal_profile_omen_v0 {
> @@ -177,22 +195,22 @@ enum hp_thermal_profile_omen_v0 {
>  };
>  
>  enum hp_thermal_profile_omen_v1 {
> -	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
> -	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
> -	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
> +	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	   = 0x30,
> +	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE = 0x31,
> +	HP_OMEN_V1_THERMAL_PROFILE_COOL		   = 0x50,
>  };
>  
>  enum hp_thermal_profile_victus {
> -	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
> -	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE		= 0x01,
> -	HP_VICTUS_THERMAL_PROFILE_QUIET			= 0x03,
> +	HP_VICTUS_THERMAL_PROFILE_DEFAULT	  = 0x00,
> +	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE = 0x01,
> +	HP_VICTUS_THERMAL_PROFILE_QUIET		  = 0x03,
>  };
>  
>  enum hp_thermal_profile {
> -	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
> -	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
> -	HP_THERMAL_PROFILE_COOL			= 0x02,
> -	HP_THERMAL_PROFILE_QUIET		= 0x03,
> +	HP_THERMAL_PROFILE_PERFORMANCE = 0x00,
> +	HP_THERMAL_PROFILE_DEFAULT	   = 0x01,
> +	HP_THERMAL_PROFILE_COOL		   = 0x02,
> +	HP_THERMAL_PROFILE_QUIET	   = 0x03,
>  };
>  
>  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
> @@ -754,6 +772,67 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static int fourzone_get_colors(u32 *colors);
> +static int fourzone_set_colors(u32 *colors);

Please rearrange code so tha you don't need forward declarations for 
function.

> +static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	u32 colors[4];
> +
> +	/* read the colors from wmi and write them to the buf */
> +	if (fourzone_get_colors(colors) == 0)
> +		return sprintf(buf, "%06x %06x %06x %06x\n",
> +					colors[0], colors[1], colors[2], colors[3]);

sysfs_emit()

The second line Looks misaligned. 

> +
> +	return -EINVAL;

IMO, it would be better to reverse the condition and return -EINVAL if
fourzone_get_colors(colors) != 0.

> +}
> +
> +static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	u32 colors[4];
> +
> +	if (sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]) != 4)

Please add ret variable and do:

	ret = sscanf(...);
	if (ret != 4)

> +		return -EINVAL;
> +
> +	/* set the colors */

Unnecessary comment.

> +	int ret = fourzone_set_colors(colors);
> +
> +	return ret == 0 ? count : ret;
> +}
> +
> +static int fourzone_get_mode(void);
> +static int fourzone_set_mode(u32 mode);
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	/* read the mode from wmi and write it to the buf */

Unnecessary comment (and not placed well anyway since it cover what the 
entire function does).

> +	u32 ret = fourzone_get_mode();
> +
> +	if (ret >= 0)

Reverse logic:

	if (ret < 0)
		return ret;

> +		return sprintf(buf, "%d\n", ret);

sysfs_emit()

> +
> +	return ret;
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	u32 mode;
> +
> +	int ret = kstrtou32(buf, 10, &mode);
> +
> +	if (ret)

Misgrouped lines, please do:

	u32 mode;
	int ret;

	ret = kstrtou32(buf, 10, &mode);
	if (ret)

> +		return ret;
> +
> +	/* set the mode */

Unnecessary comment, your function name already tell the very same bit of 
information.

> +	ret = fourzone_set_mode(mode);
> +
> +	return ret == 0 ? count : ret;
> +}
> +
>  static int camera_shutter_input_setup(void)
>  {
>  	int err;
> @@ -781,6 +860,22 @@ static int camera_shutter_input_setup(void)
>  	return err;
>  }
>  
> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void);
> +
> +static ssize_t type_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	enum hp_wmi_keyboardtype type = fourzone_get_keyboard_type();
> +
> +	if (type != HPWMI_KEYBOARD_INVALID)

Reverse logic.

> +		return sprintf(buf, "%d\n", type - 1);

sysfs_emit()

> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * Generic device attributes.
> + */
>  static DEVICE_ATTR_RO(display);
>  static DEVICE_ATTR_RO(hddtemp);
>  static DEVICE_ATTR_RW(als);
> @@ -797,7 +892,35 @@ static struct attribute *hp_wmi_attrs[] = {
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
> @@ -1446,6 +1569,118 @@ static int thermal_profile_setup(void)
>  	return 0;
>  }
>  
> +static bool fourzone_supports_lighting(void)
> +{
> +	u8 buff[128];
> +
> +	int ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
> +								&buff, sizeof(buff), sizeof(buff));

Misaligned line, please fix all of these in your patch.

> +	/* the first bit in the response is set to 1 if the system supports lighting */
> +	if (ret == 0)
> +		return (buff[0] & 0x01) == 1;

Please name 0x01 with a #define. After doing that, I suspect the comment 
is unnecessary as the code is self-explaining.

Since you're returning bool, == 1 is unnecessary.

> +
> +	return false;
> +}
> +
> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
> +{
> +	u8 buff[128];
> +
> +	int ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
> +								&buff, sizeof(buff), sizeof(buff));
> +	/* the first byte in the response represents the keyborad type */
> +	if (ret == 0)
> +		return (enum hp_wmi_keyboardtype)(buff[0] + 1);
> +
> +	return HPWMI_KEYBOARD_INVALID;
> +}
> +
> +static int fourzone_get_colors(u32 *colors)
> +{
> +	u8 buff[128];
> +
> +	if (hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +							&buff, sizeof(buff), sizeof(buff)) == 0) {

Use ret variable and separate if ().

Again, reverse the logic so error is returned first so the for look can 
be with lower indentation level.

> +		for (int i = 0; i < 4; i++) {
> +			colors[3 - i] = ((buff[25 + i * 3]     & 0xFF) << 16)  // r
> +						  | ((buff[25 + i * 3 + 1] & 0xFF) <<  8)  // g
> +						  | ((buff[25 + i * 3 + 2] & 0xFF) <<  0); // b

Looks like #define XX GENMASK(x, y) + FIELD_PREP(XX, ) for me.

Don't forget to add #include for those macros.

> +		}
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int fourzone_set_colors(u32 *colors)
> +{
> +	u8 buff[128];
> +
> +	if (hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +							&buff, sizeof(buff), sizeof(buff)) == 0) {

Same comments as above.

> +		for (int i = 0; i < 4; i++) {
> +			buff[25 + i * 3]	 = (colors[3 - i] >> 16) & 0xFF; // r
> +			buff[25 + i * 3 + 1] = (colors[3 - i] >>  8) & 0xFF; // g
> +			buff[25 + i * 3 + 2] = (colors[3 - i] >>  0) & 0xFF; // b

Named #defines + FIELD_GET().

> +		}
> +
> +		return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
> +						&buff, sizeof(buff), sizeof(buff));
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * Returns a negative number on error or 0/1 for the mode.
> + */
> +static int fourzone_get_mode(void)
> +{
> +	u8 buff[4];
> +
> +	int ret = hp_wmi_perform_query(HPWMI_FOURZONE_MODE_GET, HPWMI_FOURZONE,
> +								&buff, sizeof(buff), sizeof(buff));
> +
> +	if (ret == 0)

Don't declare ret on the same line as the call but move the declaration 
into declarations block.

Reverse the logic and keep function call and it's error handling together 
without extra lines in between them.

> +		return buff[0] == 228 ? 1 : 0;

Name 228 magic with a #define.

> +
> +	return ret;
> +}
> +
> +/*
> + * This device supports only two different modes:
> + * 1 -> lights on
> + * 0 -> lights off
> + */
> +static int fourzone_set_mode(u32 mode)
> +{
> +	u8 buff[4] = {mode ? 228 : 100, 0, 0, 0};

Magic numbers, name with #defines

> +
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
> +								&buff, sizeof(buff), 0);

Misaligned.

> +}
> +
> +static int fourzone_setup(struct platform_device *device)
> +{
> +	/* check if the system supports lighting */
> +	bool supports_lighting = fourzone_supports_lighting();
> +
> +	if (!supports_lighting)
> +		return -ENODEV;
> +
> +	/* check if we have a supported keyboard type */
> +	enum hp_wmi_keyboardtype kbd_type = fourzone_get_keyboard_type();

Don't declare variable within function like this but in the declaration 
block (unless needed by cleanup.h which is not the case here).

But I don't understand why you need either of these variables, they can 
be part of the if condition without a variable.

> +
> +	if (kbd_type != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
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
> @@ -1475,6 +1710,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
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

-- 
 i.


