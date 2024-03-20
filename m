Return-Path: <linux-kernel+bounces-108949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0E881261
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2451F21655
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626D641211;
	Wed, 20 Mar 2024 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZyoVZpL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A042065;
	Wed, 20 Mar 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941639; cv=none; b=OUqfxjTmWpsrrPmb7eYFjCv00+oysHrg1ma/EIQU52fru259QlcyDPymGompYMuayLrcOg5ZNoqsqstN7Z8cos3lZkxKYdVlUdUgY/RYKRijSYJHqqJQibKJrwmiHGBVjwHfjh4ArrPANKKyfCAQgW/MCrjD3Oikbr6db03DSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941639; c=relaxed/simple;
	bh=K42gRmfiOJjQ0AnHx9T1hxS83ViiIMDcnBb0hjYgN1U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gm83JWGsphriq0HwWBi87jB/q38o3iwUd/ksYAvPaPvhVLqjJq/iRTVYO9fXHyIBP0wLVaMPE4R3l0SvaEQJBUDT7k4YhXH3UsmQeber/bGG/c8SCP8DwZPzcZKD0q8QHBblXQNL4AnALIlmLTye1sRMYmUBhqwU3QSkjUG5mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZyoVZpL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710941637; x=1742477637;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K42gRmfiOJjQ0AnHx9T1hxS83ViiIMDcnBb0hjYgN1U=;
  b=cZyoVZpLKTK0TjRjble26qzgny+LipatjwTWBcVfUMnA1LOeAn0OwRUD
   pH6omNAf+PAJ2zxJppYNmVFPojQn36IdYOFI5/2vxc+B0ZLWKqzPwryki
   3Qr2hp4Eni0NJnMbWJDAMBg88s6G6qww/+IKdi7id5YIAo1Z2tZPEcSes
   mdFfw4HdoOyMD8W8ofK4ef1iU8qJx6Bhe93gWztV380LitZkw4ZPKLfkv
   CBRUViYPr+QdSGjk/Rd3Pbt4QTXoS8qyoMqwRwEtl4JYCI21ibwa7vJe3
   AmtQc0pfx3wp6JYAbA2f9oLk79Tvu4Z5x8ZeeRVItQUcQLMdfUDdmAAo8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23321734"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23321734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14799534"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.16])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:32:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Mar 2024 15:32:42 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <20240310065408.63703-2-luke@ljones.dev>
Message-ID: <8595ad29-c864-0e2b-7509-4a32e8d9fc7a@linux.intel.com>
References: <20240310065408.63703-1-luke@ljones.dev> <20240310065408.63703-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 Mar 2024, Luke D. Jones wrote:

> Support the 2024 mini-led backlight and adjust the related functions
> to select the relevant dev-id. Also add `available_mini_led_mode` to the
> platform sysfs since the available mini-led levels can be different.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++++
>  drivers/platform/x86/asus-wmi.c               | 48 ++++++++++++++++---
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 8a7e25bde085..e32b4f0ae15f 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -126,6 +126,14 @@ Description:
>  		Change the mini-LED mode:
>  			* 0 - Single-zone,
>  			* 1 - Multi-zone
> +			* 2 - Multi-zone strong (available on newer generation mini-led)
> +
> +What:		/sys/devices/platform/<platform>/avilable_mini_led_mode

available

Can you please also check some pre-existing examples whether "mode" 
should be in plural.

> +Date:		Jun 2023
> +KernelVersion:	6.9

These need to be changed to 6.10 (also in the other patches).

> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		List the available mini-led modes.
>  
>  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
>  Date:		Jun 2023
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 18be35fdb381..a56152ccfbe7 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -297,6 +297,7 @@ struct asus_wmi {
>  
>  	bool panel_overdrive_available;
>  	bool mini_led_mode_available;
> +	u32 mini_led_dev_id;
>  
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
> @@ -2109,10 +2110,17 @@ static ssize_t mini_led_mode_show(struct device *dev,
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	int result;
>  
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> -	if (result < 0)
> -		return result;
> +	result = asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
>  
> +	// Remap the mode values to match previous generation mini-led including
> +	// if errored -19 since some of these bios return a bad result if set to "2"
> +	// which is mini-led off

Don't use // for multiline comments within code.

The grammar is incorrect and I had to guess the meaning, please try to 
rephrase. I suggest starting with "Some BIOSes return ..." because that 
seems to more natural order of what is occurring here in the code.

> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		if (result >= 0 || result == -19)

Never replace -Exx codes as literal, this is -ENODEV (also fix the 
comment).

> +			result = result == 1 ? 2 : result == 0 ? 1 : 0;

I feel this if () should be decomposed. To me it looks even you failed 
handle all cases correctly as asus_wmi_evaluate_method3() can return -EIO 
too, which tells me the code is too complex to follow.

The literals should be replaced with #define.

Consider adding a helper to do the mapping.

> +	} else if (result < 0) {
> +		return result;
> +	}
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -2129,10 +2137,15 @@ static ssize_t mini_led_mode_store(struct device *dev,
>  	if (result)
>  		return result;
>  
> -	if (mode > 1)
> +	if (mode > 1 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
>  		return -EINVAL;
> +	if (mode > 2 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
> +		return -EINVAL;
> +	// Remap the mode values to match previous generation mini-led
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
> +		mode = mode == 2 ? 1 : mode == 0 ? 2 : 0;

Literals to #defines (the same as above I think).
 
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
> +	err = asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
>  
>  	if (err) {
>  		pr_warn("Failed to set mini-LED: %d\n", err);
> @@ -2150,6 +2163,21 @@ static ssize_t mini_led_mode_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(mini_led_mode);
>  
> +static ssize_t available_mini_led_mode_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
> +		return sysfs_emit(buf, "0 1\n");
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
> +		return sysfs_emit(buf, "0 1 2\n");

Use switch.

-- 
 i.


> +
> +	return sysfs_emit(buf, "0\n");
> +}
> +
> +static DEVICE_ATTR_RO(available_mini_led_mode);
> +
>  /* Quirks *********************************************************************/
>  
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -4174,6 +4202,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_nv_temp_target.attr,
>  	&dev_attr_panel_od.attr,
>  	&dev_attr_mini_led_mode.attr,
> +	&dev_attr_available_mini_led_mode.attr,
>  	NULL
>  };
>  
> @@ -4496,10 +4525,17 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
>  	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
> -	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
>  	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>  						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE)) {
> +		asus->mini_led_mode_available = true;
> +		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> +	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> +		asus->mini_led_mode_available = true;
> +		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
> +	}
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index ab1c7deff118..9cadce10ad9a 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -71,6 +71,7 @@
>  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>  #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
>  #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
> +#define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 

