Return-Path: <linux-kernel+bounces-162040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3068B5517
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D11C2080D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FF3716F;
	Mon, 29 Apr 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTPg2Lee"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E02D05D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386040; cv=none; b=CPsqogW4ML1s0G7GpU9f/pigJH0ZY/Wq0XrbOBRllBEVPp1m2Ckknc7Lr3XB9UVCZr1WjE5qRoY9nBbwg1L11/uPPi8PS48rjsgcnE9hHk6D5Rt9MeajoioojWQkzOkBnoflbwxuCfKyZr047sQv6UU4PLQercORb1EbbQbgUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386040; c=relaxed/simple;
	bh=kJdfUDvtofnpGE6pIMlp6EA43KPWK5fSn82l1+0tmgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3wWG2xtL0fxDyLRTFlhJ5YC1qZRegDTY21OvMdjOHo53EFGtemBdvo6st5M+BZj24pbIjBrfcoTIBmoTSvLIzLI5veiebrmBG6vRq3e+cGBMcCkAKyEPRDd1KRQIDf3uUlDZtE0VVXMqYx8RxVlEC1r4okhWMvtkV2LkPSSOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTPg2Lee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714386037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9EMJY0AcENfEBaiMObTSbRLxPCXg5yOzZGAuSj5l6Q=;
	b=dTPg2LeepMxBd1F9VLXWGTurA+y1uNl2cufqWfdO+Vh6cS7+rP5VOxrNH6Mo96y9oVkR6C
	j2SCIAwP6ORJZRzGGp2KBNfmAU52URbzLjmCDwDahPcn5bPi9Is1jKCljeZNPtxRL+92Fi
	1/eFI9iAn0mDwdhHsBz2L5rhZD5XVb0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-s27SXXdGPH6gV-BzsuL9Pg-1; Mon, 29 Apr 2024 06:20:36 -0400
X-MC-Unique: s27SXXdGPH6gV-BzsuL9Pg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51b1a65c68eso3751496e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386035; x=1714990835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9EMJY0AcENfEBaiMObTSbRLxPCXg5yOzZGAuSj5l6Q=;
        b=us7hUZ64qnJdnGK4dKL4d2Wf9NAlLdhvyk/uEP6Od7ozvp+daj/bdxs8Y6femTkGlF
         TOpPiYhK5KytOTFb+LG4034frgdUh7APG2FCxSwCaBJ96JY6hLKBhhC3mlsn3UkoRXYj
         w5LJ7+/XvsIzDh1TtryQ13F3qDsXnwFaTDdPA2C60cZ/7Y2oZJdgl2LfwZyGjcoCi6On
         D8KGz6MJrgeB6Nbpq+l2zx7mCcwpjIfLIj07ADHkMCpWAgjbzGqhTRplQTOkqQJKWJ00
         tMWIPKvzXfX98gLHfzDdoRTu4IFow5uQHNYwsWOkFhsY4e75m/9fMba23n+ac/U73dLN
         KFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3p0UuZTk3PpmHsZQNYRoTXPipPl94dV8pkPtolJAyb6pjKsPgVZNLcAH0AG9G5XGhBVU7FehBSvVk3K/Ln8eFU4rrX6uHeC7e3sTS
X-Gm-Message-State: AOJu0YzZrjbuBe5YI7aZYWshCrEqr1C/Re2ymBATQGkR8bX9Ouxb5+24
	7VnEXJ8FPhZUVxbYpTS7dQq4CQpy4sYcw9ApEUb+MnOL57/ed9plPQ7cvJni+2xDufrhAPXRU+o
	UsWR9uY92TUjrWSHHUYnzZIi7HTwmNMezmjm6ZYgZ+JNrGMKPtF4ZGWFOFckF9A==
X-Received: by 2002:a19:914d:0:b0:51e:1264:8435 with SMTP id y13-20020a19914d000000b0051e12648435mr221157lfj.27.1714386034742;
        Mon, 29 Apr 2024 03:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYhuYuErdyHDTWDrYiuCa8/Zj00+3B3nO4dPCLCOqKXAam3DP+nXnVPPBprcbs0XNwQuq/2A==
X-Received: by 2002:a19:914d:0:b0:51e:1264:8435 with SMTP id y13-20020a19914d000000b0051e12648435mr221140lfj.27.1714386034238;
        Mon, 29 Apr 2024 03:20:34 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h22-20020a197016000000b0051d8a187d5esm457384lfc.208.2024.04.29.03.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:20:33 -0700 (PDT)
Message-ID: <de8fcb82-3e08-41e6-b099-75df27c6df23@redhat.com>
Date: Mon, 29 Apr 2024 12:20:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Luke D . Jones" <luke@ljones.dev>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
 <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/21/24 9:43 PM, Mohamed Ghanmi wrote:
> Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> to adjust power limits.
> 
> These fan profiles have a different device id than the ROG series
> and different order. This reorders the existing modes and adds a new
> full speed mode available on these laptops.
> 
> As part of keeping the patch clean the throttle_thermal_policy_available
> boolean stored in the driver struct is removed and
> throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> 
> Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++----------
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 51 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3c61d75a3..1f54596ca 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
>  #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
>  
> +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
> +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
> +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
> +#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
> +
>  #define USB_INTEL_XUSB2PR		0xD0
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
>  
> @@ -293,8 +298,8 @@ struct asus_wmi {
>  	u32 kbd_rgb_dev;
>  	bool kbd_rgb_state_available;
>  
> -	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> +	u32 throttle_thermal_policy_dev;
>  
>  	bool cpu_fan_curve_available;
>  	bool gpu_fan_curve_available;
> @@ -3152,7 +3157,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  	int err, fan_idx;
>  	u8 mode = 0;
>  
> -	if (asus->throttle_thermal_policy_available)
> +	if (asus->throttle_thermal_policy_dev)
>  		mode = asus->throttle_thermal_policy_mode;
>  	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
>  	if (mode == 2)
> @@ -3359,7 +3364,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
>  		 * For machines with throttle this is the only way to reset fans
>  		 * to default mode of operation (does not erase curve data).
>  		 */
> -		if (asus->throttle_thermal_policy_available) {
> +		if (asus->throttle_thermal_policy_dev) {
>  			err = throttle_thermal_policy_write(asus);
>  			if (err)
>  				return err;
> @@ -3576,8 +3581,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
>  __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
>  
>  /*
> - * Must be initialised after throttle_thermal_policy_check_present() as
> - * we check the status of throttle_thermal_policy_available during init.
> + * Must be initialised after throttle_thermal_policy_dev is set as
> + * we check the status of throttle_thermal_policy_dev during init.
>   */
>  static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>  {
> @@ -3618,38 +3623,37 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>  }
>  
>  /* Throttle thermal policy ****************************************************/
> -
> -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> +static u8 throttle_thermal_policy_max_mode(struct asus_wmi *asus)
>  {
> -	u32 result;
> -	int err;
> -
> -	asus->throttle_thermal_policy_available = false;
> -
> -	err = asus_wmi_get_devstate(asus,
> -				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> -				    &result);
> -	if (err) {
> -		if (err == -ENODEV)
> -			return 0;
> -		return err;
> -	}
> -
> -	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> -		asus->throttle_thermal_policy_available = true;
> -
> -	return 0;
> +	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO)
> +		return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
> +	else
> +		return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>  }
>  
>  static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  {
> -	int err;
> -	u8 value;
> +	u8 value = asus->throttle_thermal_policy_mode;
>  	u32 retval;
> +	bool vivo;
> +	int err;
>  
> -	value = asus->throttle_thermal_policy_mode;
> +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +	if (vivo) {
> +		switch (value) {
> +		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> +			break;
> +		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> +			break;
> +		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> +			break;
> +		}
> +	}
>  
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> +	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>  				    value, &retval);
>  
>  	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> @@ -3679,7 +3683,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  
>  static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  {
> -	if (!asus->throttle_thermal_policy_available)
> +	if (!asus->throttle_thermal_policy_dev)
>  		return 0;
>  
>  	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> @@ -3689,9 +3693,10 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>  {
>  	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> +	u8 max_mode = throttle_thermal_policy_max_mode(asus);
>  	int err;
>  
> -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> +	if (new_mode > max_mode)
>  		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>  
>  	asus->throttle_thermal_policy_mode = new_mode;
> @@ -3722,6 +3727,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  				    const char *buf, size_t count)
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	u8 max_mode = throttle_thermal_policy_max_mode(asus);
>  	u8 new_mode;
>  	int result;
>  	int err;
> @@ -3730,7 +3736,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> +	if (new_mode > max_mode)
>  		return -EINVAL;
>  
>  	asus->throttle_thermal_policy_mode = new_mode;
> @@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  	return count;
>  }
>  
> -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> +/*
> + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> + * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - overboost, 3 - fullspeed
> + */

throttle_thermal_policy_write() always expects normal (non vivobook) values and
then translates those to vivo values, so this comment is not correct.

The only difference is that vivobook also has fullspeed, but the way userspace
sees it 1/2 or silent/overspeed are not swapped, since the swapping is taking
care of in throttle_thermal_policy_write().

Also the new fullspeed is not exported through the platform_profile interface,
for setting values this is somewhat ok, but fullspeed can be set through
sysfs, and this will then cause asus_wmi_platform_profile_get() to fail
with -EINVAL, so this need to be fixed. Either map fullspeed to
PLATFORM_PROFILE_PERFORMANCE in asus_wmi_platform_profile_get(), or add
a new platform_profile value for this.

Regards,

Hans




>  static DEVICE_ATTR_RW(throttle_thermal_policy);
>  
>  /* Platform profile ***********************************************************/
> @@ -3813,7 +3822,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  	 * Not an error if a component platform_profile relies on is unavailable
>  	 * so early return, skipping the setup of platform_profile.
>  	 */
> -	if (!asus->throttle_thermal_policy_available)
> +	if (!asus->throttle_thermal_policy_dev)
>  		return 0;
>  
>  	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> @@ -4228,7 +4237,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
>  		if (asus->fan_boost_mode_available)
>  			fan_boost_mode_switch_next(asus);
> -		if (asus->throttle_thermal_policy_available)
> +		if (asus->throttle_thermal_policy_dev)
>  			throttle_thermal_policy_switch_next(asus);
>  		return;
>  
> @@ -4436,7 +4445,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  	else if (attr == &dev_attr_fan_boost_mode.attr)
>  		ok = asus->fan_boost_mode_available;
>  	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> -		ok = asus->throttle_thermal_policy_available;
> +		ok = asus->throttle_thermal_policy_dev != 0;
>  	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
>  		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
>  	else if (attr == &dev_attr_ppt_pl1_spl.attr)
> @@ -4745,16 +4754,15 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
>  		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> +		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> +	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> +		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
>  
> -	err = throttle_thermal_policy_check_present(asus);
> -	if (err)
> -		goto fail_throttle_thermal_policy;
> -	else
> -		throttle_thermal_policy_set_default(asus);
> -
>  	err = platform_profile_setup(asus);
>  	if (err)
>  		goto fail_platform_profile_setup;
> @@ -4849,7 +4857,6 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_input:
>  	asus_wmi_sysfs_exit(asus->platform_device);
>  fail_sysfs:
> -fail_throttle_thermal_policy:
>  fail_custom_fan_curve:
>  fail_platform_profile_setup:
>  	if (asus->platform_profile_support)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3eb5cd677..982a63774 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -64,6 +64,7 @@
>  #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
>  #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
>  
>  /* Misc */
>  #define ASUS_WMI_DEVID_PANEL_OD		0x00050019


