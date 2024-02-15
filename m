Return-Path: <linux-kernel+bounces-66814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791168561CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F429520F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E912CD9C;
	Thu, 15 Feb 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEc7Tm+u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08E12CD88;
	Thu, 15 Feb 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996852; cv=none; b=qiuJ23CmqdLlxIHTKJu0rUGwKF+nXbVQTaZtOyohkV49QjIzGI5uvLXiOktoDaOtOz++Zi7hiEsVHKrKYkLPuavStGXIU5UzOGJ6vYmbMW6OEzEid7r/jjCdpxfslgcl7wD87XPmg0ex7IoOmTdE4k6VXqUM8obyw9cvtayF9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996852; c=relaxed/simple;
	bh=oDLnpZDyktj3+YJL+eHMZybGsI1GlhiKMdzy3r+RNw0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y+wFHbEOlbuWdC1RpVgZAn7PqwU79KohbsDr4jDpa/fTtwkeHwfnE16h081FbMnyo8yWp3T48sSBOpRmvWKagz7QaNl8HszIwreOX/ovYaxBEKZHsWuhSn6ptigKbuaS+1HXkpfgDz+YdEk49n/sH+///fTrAJ7MN4EPh2umUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEc7Tm+u; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707996851; x=1739532851;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oDLnpZDyktj3+YJL+eHMZybGsI1GlhiKMdzy3r+RNw0=;
  b=BEc7Tm+uYwzl9scr9q0ssroZOfJltL/oIilDzQs3STx4HA9udSplsDz9
   trGFi60T4BhqzxoPQn+a3CeWqs1U8Xt4j16GQzusfVOR6nC53csSG/XWa
   Jr17tZLQpf4Z2zccrsTD8oL2rvD0AEo5iqimBnI+2dbEkdbHxJInpkHTF
   RN8wglMEIAJzgF3lm/CMXLFWdwhGj7PsogzgTWvZs7sp+jzuMby+OYviP
   UtkuadrhiOXuPgAJ4zOHs1RSsCrGVl5A0/KUbU64uibmywuADkMeF6vRX
   y8BdiyYI9xPIAslBwhSdM1m7CG/ysbzX7t3fjHBGI2Wi+U1wx2mFL5lVq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13177902"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13177902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="826403606"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="826403606"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:34:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Feb 2024 13:34:00 +0200 (EET)
To: Szilard Fabian <szfabian@bluemarch.art>
cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    jwoithe@just42.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
    W_Armin@gmx.de
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge
 control support
In-Reply-To: <20240207023031.56805-2-szfabian@bluemarch.art>
Message-ID: <43960922-d6bb-e5f6-2156-f1b35142244a@linux.intel.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Feb 2024, Szilard Fabian wrote:

> This patch adds battery charge control support on Fujitsu notebooks
> via the S006 method of the FUJ02E3 ACPI device. With this method it's
> possible to set charge_control_end_threshold between 50 and 100%.
> 
> Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
> patch on a dual battery one, but I didn't find any clue about
> independent battery charge control on dual battery Fujitsu notebooks
> either. And by that I mean checking the DSDT table of various Lifebook
> notebooks and reverse engineering FUJ02E3.dll.
> 
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
> ---
> v3:
> * added additional error handling
> * removed if statement with device_create_file(), just returning that
>   function instead
> * added bool charge_control_supported into struct fujitsu_laptop
> * added a 'charge_control_add' and 'charge_control_remove' function to be
>   called from acpi_fujitsu_laptop_add() and acpi_fujitsu_laptop_remove()
> * moved FUJ02E3 S006 probing logic from the ACPI battery hooks to the new
>   'charge_control_*' functions
> 
> v2:
> Forgot to sign-off the original commit. Fixed, sorry for the
> inconvenience.
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 125 ++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 085e044e888e..2fcbc10a0d9d 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -49,6 +49,8 @@
>  #include <linux/kfifo.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <acpi/battery.h>
>  #include <acpi/video.h>
>  
>  #define FUJITSU_DRIVER_VERSION		"0.6.0"
> @@ -97,6 +99,10 @@
>  #define BACKLIGHT_OFF			(BIT(0) | BIT(1))
>  #define BACKLIGHT_ON			0
>  
> +/* FUNC interface - battery control interface */
> +#define FUNC_S006_METHOD		0x1006
> +#define CHARGE_CONTROL_RW		0x21
> +
>  /* Scancodes read from the GIRB register */
>  #define KEY1_CODE			0x410
>  #define KEY2_CODE			0x411
> @@ -132,6 +138,7 @@ struct fujitsu_laptop {
>  	spinlock_t fifo_lock;
>  	int flags_supported;
>  	int flags_state;
> +	bool charge_control_supported;
>  };
>  
>  static struct acpi_device *fext;
> @@ -164,6 +171,118 @@ static int call_fext_func(struct acpi_device *device,
>  	return value;
>  }
>  
> +/* Battery charge control code */
> +

Please remove these empty lines between the comment and function (not 
just this but the others too).

> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int value, ret;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value < 50 || value > 100)
> +		return -EINVAL;
> +
> +	int cc_end_value, s006_cc_return;
> +
> +	cc_end_value = value * 0x100 + 0x20;
> +	s006_cc_return = call_fext_func(fext, FUNC_S006_METHOD,
> +					CHARGE_CONTROL_RW, cc_end_value, 0x0);
> +
> +	if (s006_cc_return < 0)
> +		return s006_cc_return;
> +
> +	/*
> +	 * The S006 0x21 method returns 0x00 in case the provided value
> +	 * is invalid.
> +	 */
> +	if (s006_cc_return == 0x00)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	int status;
> +	status = call_fext_func(fext, FUNC_S006_METHOD,
> +				CHARGE_CONTROL_RW, 0x21, 0x0);

Add empty line after declaration.

> +
> +	if (status < 0)
> +		return status;
> +
> +	return sprintf(buf, "%d\n", status);

sysfs_emit()

> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +/* ACPI battery hook */
> +
> +static int fujitsu_battery_add_hook(struct power_supply *battery,
> +			       struct acpi_battery_hook *hook)
> +{
> +	return device_create_file(&battery->dev,
> +				  &dev_attr_charge_control_end_threshold);
> +}
> +
> +static int fujitsu_battery_remove_hook(struct power_supply *battery,
> +				  struct acpi_battery_hook *hook)
> +{
> +	device_remove_file(&battery->dev,
> +			   &dev_attr_charge_control_end_threshold);
> +
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook = {
> +	.add_battery = fujitsu_battery_add_hook,
> +	.remove_battery = fujitsu_battery_remove_hook,
> +	.name = "Fujitsu Battery Extension",
> +};
> +
> +/*
> + * These functions are intended to be called from acpi_fujitsu_laptop_add and
> + * acpi_fujitsu_laptop_remove.
> + */
> +
> +static int fujitsu_battery_charge_control_add(struct acpi_device *device)
> +{
> +	struct fujitsu_laptop *priv = acpi_driver_data(device);
> +	priv->charge_control_supported = false;

Add a newline between these too as well.

> +	/*
> +	 * Check if the S006 0x21 method exists by trying to get the current
> +	 * battery charge limit.
> +	 */
> +	int s006_cc_return;
> +	s006_cc_return = call_fext_func(fext, FUNC_S006_METHOD,
> +					CHARGE_CONTROL_RW, 0x21, 0x0);
> +
> +	if (s006_cc_return < 0)
> +		return s006_cc_return;
> +
> +	if (s006_cc_return == UNSUPPORTED_CMD)
> +		return -ENODEV;
> +
> +	priv->charge_control_supported = true;
> +	battery_hook_register(&battery_hook);
> +
> +	return 0;
> +}
> +
> +static void fujitsu_battery_charge_control_remove(struct acpi_device *device)
> +{
> +	struct fujitsu_laptop *priv = acpi_driver_data(device);
> +
> +	if (priv->charge_control_supported)
> +		battery_hook_unregister(&battery_hook);
> +}
> +
>  /* Hardware access for LCD brightness control */
>  
>  static int set_lcd_level(struct acpi_device *device, int level)
> @@ -839,6 +958,10 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	if (ret)
>  		goto err_free_fifo;
>  
> +	ret = fujitsu_battery_charge_control_add(device);
> +	if (ret < 0)
> +		pr_warn("Unable to register battery charge control: %d\n", ret);
> +
>  	return 0;
>  
>  err_free_fifo:
> @@ -851,6 +974,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
>  {
>  	struct fujitsu_laptop *priv = acpi_driver_data(device);
>  
> +	fujitsu_battery_charge_control_remove(device);
> +
>  	fujitsu_laptop_platform_remove(device);
>  
>  	kfifo_free(&priv->fifo);

Why is this posted as RFC?

-- 
 i.


