Return-Path: <linux-kernel+bounces-135325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF889BF06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0FE1F24A99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124516BFC8;
	Mon,  8 Apr 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPlZbC6X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A6A342
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579653; cv=none; b=KDmNGCcb5mB16/AFK0STO7+HW8M3d2uEyFFIdB3fu3MFXDYFerIOEMsjYaJ7vA1amkpE7ppip1qla/oIPJ15nULo/obE6m8gjmZFs6MPGlVo5osq6XTwNefyEMunCpdRw5PmG3/UGnLP/BFyqQ8Bu7E2jFv4SHZBoy4twxyTbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579653; c=relaxed/simple;
	bh=dj5LAfsrTeiYzz4ndEmaJ/OyvFWl+oYNDC6SImYQTHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTJYLgbC95Mk961Yf9/C5c+/d/Zs/84O90+46tumMJYvoKxcoJ2gQVkuUnL+H5MTFNAZ8TbyfvUmPuF8r+8QnjMrHq5A10f9OqdKWiaB9jSKYwwgDaomhE47SyFMmWzv+igeC8h4TiJxS4ODOYQIgxFbpxVD+aXwHN5oSDDDzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPlZbC6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712579650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ9FknPyFolJWo9kktE00JvLm6NhkWwlePPMXGCBJgE=;
	b=IPlZbC6X2h5WjPi2IXlAhtQin+APuait9MEymKIoOs4PO1huymYhfidpkCfOA/O0B96iIV
	qJBQHZ9iteQALawhYgPgOOoi3h85FiZ7o/GnNIPOABE88P8r4Xtvm8obItq6PQgSQr5bhd
	pyXM9oDBGac/1HCM440ul3v78VXlo0s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-eBhI0yaKPgaI-EFBMCf2sQ-1; Mon, 08 Apr 2024 08:34:07 -0400
X-MC-Unique: eBhI0yaKPgaI-EFBMCf2sQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51cb1feb23so43746566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712579646; x=1713184446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ9FknPyFolJWo9kktE00JvLm6NhkWwlePPMXGCBJgE=;
        b=ZjHqBBXzF9J91+EAVBJ7IrBS3u7AQBI+CfQVeR3f+x3Dq2yWXLue9PMfcq04eiTgdK
         l0mxR6Q7QxA82WfuxhVvHpnoHnSwhzzaQ952E/EQMc8XR1rEEP7dWCvEdIoNCmz7IN1s
         S+VUMIXyo8YCUIrJX4J0UPnwt+K8RVwMCFZNODrXCeLtS3M5hGai+Rv9PruDGC3JY6Fa
         Hv6CiMwYBCc57apFIEg+Zm7QOF4Q07ZSfsCFNb/nVtaSG4WzliFv09oPzAq/T7B4n9sg
         0x5qjCSO/BpHK6358iCfL9vD1UUhnahTD0uGCScqcdZNnHktoNn2xc3UTOSdR0qxKiBW
         ETpA==
X-Forwarded-Encrypted: i=1; AJvYcCVqwmnDYAe5b6w+1/PexDzkJ6QLa8f7HnX00Yz1TCn/D+07wSr3It1PDX81tqaGOheab2pxLGfFDXGdkJAz0443aQFf9eC+u9VMtudG
X-Gm-Message-State: AOJu0Yz83S+txpVxPKzRQ8vHnBo4iDpfygIN3AHvFP2NIspIU5ehI41x
	o3Jo5kV3lYocNP8REHhsdhHxD8UKtHpRF/5/c1iaCFoY1hXZxXKSnbrmE+S0y2QfD6ESHmnP9gY
	eb6zkdvhFehQntCh1uqP5cB9CCLKoVir3ZP0rEniTe3AtgL4QOajH21sZTV5B2Q==
X-Received: by 2002:a17:906:11da:b0:a4e:146c:ff09 with SMTP id o26-20020a17090611da00b00a4e146cff09mr5570907eja.7.1712579646571;
        Mon, 08 Apr 2024 05:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdxAgdOGtdNePVBdRUjz9HRKrP+pDPjcQEFa1phRAOaF8bDt421J4Xb9kgwDw7TjCL7GlFDg==
X-Received: by 2002:a17:906:11da:b0:a4e:146c:ff09 with SMTP id o26-20020a17090611da00b00a4e146cff09mr5570889eja.7.1712579646094;
        Mon, 08 Apr 2024 05:34:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qy25-20020a170907689900b00a51b18a77b2sm3487694ejc.180.2024.04.08.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 05:34:05 -0700 (PDT)
Message-ID: <473d8897-7b97-4175-b171-42fd2c8de0d6@redhat.com>
Date: Mon, 8 Apr 2024 14:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>,
 Rishit Bansal <rishitbansal0@gmail.com>, mustafa <mustafa.eskieksi@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>,
 Linux LED Subsystem <linux-leds@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carlos,

On 3/24/24 7:05 PM, Carlos Ferreira wrote:
> Added support for 4 zone keyboard rgb on omen laptops.
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>

Thank you for your patch and sorry for being slow with replying to this.

There actually already was a previous attemp to add support for
the 4 zone keyboard to hp-wmi by Rishit Bansal:

https://lore.kernel.org/platform-driver-x86/20230131235027.36304-1-rishitbansal0@gmail.com/

As discussed there we really want to define a new standardized
userspace API for the backlight functionality of these zoned
RGB keyboards. Using driver specific sysfs attributes for this
is undesirable, since that will never get wide support in userspace.

OTOH if we define and document a new standard userspace API for this
then hopefully standard userspace stacks like KDE and GNOME will
eventually get support for this and then for the next zoned rgb
keyboard things will just work using the new standard API once
kernel support is merged.

I realize that using a single LED class device with kbd_backlight
in the name to tap into the existing userspace support to at least
control the overall backlight brightness is useful and tempting but

IMHO this really is a case where we need a new userspace API and then
emulating just a single brightness control for compatilbility with
existing userspace UI code can be done in powerdevil (KDE) or
upower (GNOME and others) in combination with offereing a more
complete DBUS API to also allow controlling the zones separately.

Recently another (laptop) driver for Casper Excalibur laptops has
been posted and this also include support for a 4 zone rgb keyboard:
https://lore.kernel.org/platform-driver-x86/20240324181201.87882-2-mustafa.eskieksi@gmail.com/

This driver actually already implements the userspace API proposed in
the discussion surrounding the earlier "[PATCH V3] platform/x86: hp-wmi:
Support omen backlight control wmi-acpi methods" patch.

This driver creates 4 LED class devices using the multi-color LED API
for RGB. One LED class device per zone. These are named:

casper:rgb:kbd_zoned_backlight-right
casper:rgb:kbd_zoned_backlight-middle
casper:rgb:kbd_zoned_backlight-left
casper:rgb:kbd_zoned_backlight-corners

Where as for the HP laptop case I believe the 4 multi-color LED
class devices should have the following names since the zones
are different:

hp:rgb:kbd_zoned_backlight-main
hp:rgb:kbd_zoned_backlight-wasd
hp:rgb:kbd_zoned_backlight-cursor
hp:rgb:kbd_zoned_backlight-numpad

As I mentioned in my review of the Casper Excalibur laptop driver
as part of adding support for these zoned rgb keyboards to various
laptop vendor specific drivers we should also document how these
devices are presented to userspace:

A separate patch needs to be written to add documentation about
the use of these names for zoned RGB backlit kbds in a new paragraph /
subsection of the "LED Device Naming" section of:

Documentation/leds/leds-class.rst 

And this should document at least the 2 currently known
zone sets:

:rgb:kbd_zoned_backlight-right
:rgb:kbd_zoned_backlight-middle
:rgb:kbd_zoned_backlight-left
:rgb:kbd_zoned_backlight-corners

:rgb:kbd_zoned_backlight-main
:rgb:kbd_zoned_backlight-wasd
:rgb:kbd_zoned_backlight-cursor
:rgb:kbd_zoned_backlight-numpad

with a comment that in the future different zone names are possible
if keyboards with a different zoning scheme show up.

Perhaps you can work together with Mustafa on writing a patch for:
Documentation/leds/leds-class.rst ?

for this and then hopefully Pavel can review + ack this patch
and then we can move forward with both the hp and the casper
laptop zoned rgb keyboard support.

Regards,

Hans




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
> +
> +static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	u32 colors[4];
> +
> +	/* read the colors from wmi and write them to the buf */
> +	if (fourzone_get_colors(colors) == 0)
> +		return sprintf(buf, "%06x %06x %06x %06x\n",
> +					colors[0], colors[1], colors[2], colors[3]);
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	u32 colors[4];
> +
> +	if (sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]) != 4)
> +		return -EINVAL;
> +
> +	/* set the colors */
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
> +	u32 ret = fourzone_get_mode();
> +
> +	if (ret >= 0)
> +		return sprintf(buf, "%d\n", ret);
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
> +		return ret;
> +
> +	/* set the mode */
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
> +		return sprintf(buf, "%d\n", type - 1);
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
> +	/* the first bit in the response is set to 1 if the system supports lighting */
> +	if (ret == 0)
> +		return (buff[0] & 0x01) == 1;
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
> +		for (int i = 0; i < 4; i++) {
> +			colors[3 - i] = ((buff[25 + i * 3]     & 0xFF) << 16)  // r
> +						  | ((buff[25 + i * 3 + 1] & 0xFF) <<  8)  // g
> +						  | ((buff[25 + i * 3 + 2] & 0xFF) <<  0); // b
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
> +		for (int i = 0; i < 4; i++) {
> +			buff[25 + i * 3]	 = (colors[3 - i] >> 16) & 0xFF; // r
> +			buff[25 + i * 3 + 1] = (colors[3 - i] >>  8) & 0xFF; // g
> +			buff[25 + i * 3 + 2] = (colors[3 - i] >>  0) & 0xFF; // b
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
> +		return buff[0] == 228 ? 1 : 0;
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
> +
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
> +								&buff, sizeof(buff), 0);
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


