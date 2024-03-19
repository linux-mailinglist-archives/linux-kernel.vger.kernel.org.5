Return-Path: <linux-kernel+bounces-107942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647D8803DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D2A1C22CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BE23772;
	Tue, 19 Mar 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3zk+imh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F3208D4;
	Tue, 19 Mar 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870514; cv=none; b=eaN6v3vczFlFPXpg1xJxNXHfvMCWr2UyGktSdbguV8C2+jCRdvR4CG0NVtUNSzPARBW0YVylbMGxhBNOf/SPmN2mUt4WO2f/+qp1Z3b4Gc0oofDfW4KA2jJekqiMGI6ZJ09cM1wdN8iCled9jBd/6KZVXagqCZftjbdGXzBgiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870514; c=relaxed/simple;
	bh=vPKVHtERmM698/xk0MvrZWvxD2gy5VDHDSR5S21JXkQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O1oshYi9/e92gzvye9szlptmvlJwlyGbi9zgEHlXQOyMt3wswrmkCIDRKM31ayDPCZAJfB6bgIlbmHaJBwYNzUMA4XMDowrueMZ/odSHxd9GdlHodYMwd6Cn3WfywZWxOj17qw7ryQ6/v4soNwTP7q3DewXmRa+78l1+bKI7KU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3zk+imh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710870512; x=1742406512;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vPKVHtERmM698/xk0MvrZWvxD2gy5VDHDSR5S21JXkQ=;
  b=a3zk+imhxKy+nsJj38EWIbFqy65GYlNzkaG1FPMqd9/IbdUmxXCNgVkL
   71JpiQX9iw7BigszJznldvcq49FSVf/hg3bbI9JoRigJERARIV6hoikXC
   Q+nxcFyBw+h/DSJ7ewg/lY+QlcbSga4y98hf6sJUbd2lh9PCSPeG0xt1r
   NseLY53wzLPRlYoSjW6Rxg5/DaF1/70BR+SqgMSC0VdPbZDecE7KTwzUT
   mFIGWEhi+F2FfadwclmWocCo9UR+bWmnzXCbiEuse8d5smmeBX+k0m0SC
   Of50uyE0/T1fqtq+zP4JtSfLulWDL8ZC2CO2GLSF+3guuAEiNFm8DDNCG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5971402"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5971402"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="18540831"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:48:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Mar 2024 19:48:09 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: support toggling POST sound
In-Reply-To: <20240310061715.16531-1-luke@ljones.dev>
Message-ID: <5f853562-cbe0-32d7-2644-d42d2bb9e060@linux.intel.com>
References: <20240310061715.16531-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 Mar 2024, Luke D. Jones wrote:

> Add support for toggling the BIOS POST sound on some ASUS laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  7 +++
>  drivers/platform/x86/asus-wmi.c               | 54 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index e32b4f0ae15f..f3c53b7453f0 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -194,3 +194,10 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set the target temperature limit of the Nvidia dGPU:
>  			* min=75, max=87
> +
> +What:		/sys/devices/platform/<platform>/boot_sound
> +Date:		Jun 2023
> +KernelVersion:	6.9
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set if the BIOS POST sound is played on boot.
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ca8c73c15fcc..26084e9846a1 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -297,6 +297,7 @@ struct asus_wmi {
>  	// The RSOC controls the maximum charging percentage.
>  	bool battery_rsoc_available;
>  
> +	bool boot_sound_available;
>  	bool panel_overdrive_available;
>  	bool mini_led_mode_available;
>  	u32 mini_led_dev_id;
> @@ -2106,6 +2107,55 @@ static ssize_t panel_od_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(panel_od);
>  
> +/* Bootup sound ***************************************************************/
> +
> +static ssize_t boot_sound_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result;
> +
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
> +	if (result < 0)
> +		return result;
> +
> +	return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t boot_sound_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 snd;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou32(buf, 10, &snd);
> +	if (result)
> +		return result;
> +
> +	if (snd > 1)
> +		return -EINVAL;

Why not just use kstrtobool()?

> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
> +
> +	if (err) {

Don't leave empty lines between the call and its error handling.

-- 
 i.

> +		pr_warn("Failed to set boot sound: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result > 1) {
> +		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(boot_sound);
> +
>  /* Mini-LED mode **************************************************************/
>  static ssize_t mini_led_mode_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -4196,6 +4246,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_ppt_platform_sppt.attr,
>  	&dev_attr_nv_dynamic_boost.attr,
>  	&dev_attr_nv_temp_target.attr,
> +	&dev_attr_boot_sound.attr,
>  	&dev_attr_panel_od.attr,
>  	&dev_attr_mini_led_mode.attr,
>  	&dev_attr_available_mini_led_mode.attr,
> @@ -4248,6 +4299,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->nv_dyn_boost_available;
>  	else if (attr == &dev_attr_nv_temp_target.attr)
>  		ok = asus->nv_temp_tgt_available;
> +	else if (attr == &dev_attr_boot_sound.attr)
> +		ok = asus->boot_sound_available;
>  	else if (attr == &dev_attr_panel_od.attr)
>  		ok = asus->panel_overdrive_available;
>  	else if (attr == &dev_attr_mini_led_mode.attr)
> @@ -4519,6 +4572,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->ppt_plat_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
>  	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
>  	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
> +	asus->boot_sound_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_BOOT_SOUND);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>  	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>  						&& dmi_match(DMI_BOARD_NAME, "RC71L");
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3e9a01467c67..3eb5cd6773ad 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -137,6 +137,9 @@
>  /* TUF laptop RGB power/state */
>  #define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
>  
> +/* Bootup sound control */
> +#define ASUS_WMI_DEVID_BOOT_SOUND	0x00130022
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
> 

