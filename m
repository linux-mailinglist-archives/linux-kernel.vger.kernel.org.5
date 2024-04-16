Return-Path: <linux-kernel+bounces-146820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F88A6B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364CBB21978
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31412BF04;
	Tue, 16 Apr 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EluQSn24"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6112BE90;
	Tue, 16 Apr 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271873; cv=none; b=KG0Sbjm8P4xXX1uc5fp3PpbMwNPJ1vj0zjnQG0fu15ZoYqkV1dwYs4ecBBYc8e+Idxy2LCA+sZIDLZzSDQUc0/y2OFVdLCaPYx4SYXZP90F+HsZZLypLqckOEAdJVd9ezInotIuCViPbLcEhBBUN1sKd712wKxNRdyWCOzn+b+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271873; c=relaxed/simple;
	bh=Fkx0lmrEQ13x6qCZzt7GadT2MUtta6ibJ0Z0SpF1Yv8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rq9REeHHmNMNHFT5wqDolnvPjegmKt7EGldqWeAaLEutqYxUVSVA+54TbHl7eFOMryFIo3bOvzVu5zNTd3P4UKv+mzS9guOryE16FqgnBYHbTj/EQ+Gl6i1P5XuZR40BUavlEhoJr2w/jVKxiFB9eK46agZVp1Pwn/cZLfHkX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EluQSn24; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713271870; x=1744807870;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fkx0lmrEQ13x6qCZzt7GadT2MUtta6ibJ0Z0SpF1Yv8=;
  b=EluQSn249lN5piik2L6wBS6iA+5MfvO9sUN5tHgAndf7sKdrpHi4N9DT
   cFf+60SqrmLyCDgZufBBgMYomICIsJkfnij7yO22fc45nluhJw2etWGJr
   oErpoEp3Nx+Ac8VToLopfhVvb9QBtVO0eukQL1GlVSiN/wnm9WcD8wcix
   DYb+AjsdfxymY3qv9S6ytMeDhA1ZfPGrKgdwOFrTrgzpjywN8QkQsNWlo
   mOzFMdmt0Fh/ldsX5T0vhA6d7A5JM9sNdI/+4v0WrD5gd/LQ7AIGMeYOj
   IgHRqBOPKDbv4vEktaBzwHYxqq8Rm966nCZBQPT6Oz7bTaB8TRucZCLv3
   w==;
X-CSE-ConnectionGUID: sy36Wu8lRqmmevUlU37jiw==
X-CSE-MsgGUID: oz133EUCQ0av2Hp8Ti+fNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8567066"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8567066"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:51:09 -0700
X-CSE-ConnectionGUID: 2MtKPZQbRVG0TMRqH7OkKw==
X-CSE-MsgGUID: lGsvHdxESL6UQas5KyFJRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53431791"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:51:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Apr 2024 15:51:03 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    mohamed.ghanmi@supcom.tn, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for vivobook fan
 profiles
In-Reply-To: <20240413202112.37729-1-luke@ljones.dev>
Message-ID: <dccc5701-f533-e80e-09f8-199f232f447f@linux.intel.com>
References: <20240413202112.37729-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Apr 2024, Luke D. Jones wrote:

> From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> 
> Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> to adjust power limits.
> 
> These fan profiles have a different device id than the ROG series.
> and different order.

Fix grammar.

> This reorders the existing modes and adds a new
> full speed mode available on these laptops.
> 
> As part of keeping the patch clean the throttle_thermal_policy_available
> boolean stored in the driver struct is removed and
> throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> 
> Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 100 +++++++++++----------
>  include/linux/platform_data/x86/asus-wmi.h |   1 +
>  2 files changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2d2b4eca7fd8..439d330fb80b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
>  #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
>  
> +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
> +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
> +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO		1

Any good reason why these are not in numerical order?

> +#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
> +
>  #define USB_INTEL_XUSB2PR		0xD0
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
>  
> @@ -285,8 +290,8 @@ struct asus_wmi {
>  	u32 kbd_rgb_dev;
>  	bool kbd_rgb_state_available;
>  
> -	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> +	u32 throttle_thermal_policy_dev;
>  
>  	bool cpu_fan_curve_available;
>  	bool gpu_fan_curve_available;
> @@ -3153,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  	int err, fan_idx;
>  	u8 mode = 0;
>  
> -	if (asus->throttle_thermal_policy_available)
> +	if (asus->throttle_thermal_policy_dev)
>  		mode = asus->throttle_thermal_policy_mode;
>  	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
>  	if (mode == 2)
> @@ -3360,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
>  		 * For machines with throttle this is the only way to reset fans
>  		 * to default mode of operation (does not erase curve data).
>  		 */
> -		if (asus->throttle_thermal_policy_available) {
> +		if (asus->throttle_thermal_policy_dev) {
>  			err = throttle_thermal_policy_write(asus);
>  			if (err)
>  				return err;
> @@ -3577,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
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
> @@ -3619,38 +3624,31 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>  }
>  
>  /* Throttle thermal policy ****************************************************/
> -
> -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> -{
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
> -}
> -
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
> +		default:
> +			break;
> +		}
> +	}
>  
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> +	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>  				    value, &retval);
>  
>  	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> @@ -3680,7 +3678,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  
>  static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  {
> -	if (!asus->throttle_thermal_policy_available)
> +	if (!asus->throttle_thermal_policy_dev)
>  		return 0;
>  
>  	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> @@ -3690,9 +3688,14 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
>  {
>  	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> +	bool vivo;
>  	int err;
>  
> -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +	if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> +		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> +
> +	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
>  		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;

Hmm, add a throttle_thermal_policy_max_mode() helper instead so you can do 
just this:

	if (new_mode > throttle_thermal_policy_max_mode(...))
		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;


>  	asus->throttle_thermal_policy_mode = new_mode;
> @@ -3725,13 +3728,17 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	u8 new_mode;
>  	int result;
> +	bool vivo;
>  	int err;
>  
>  	result = kstrtou8(buf, 10, &new_mode);
>  	if (result < 0)
>  		return result;
>  
> -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
> +		return -EINVAL;
> +	else if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)

Use the throttle_thermal_policy_max_mode() helper here too.

>  		return -EINVAL;
>  
>  	asus->throttle_thermal_policy_mode = new_mode;

-- 
 i.


