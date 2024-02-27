Return-Path: <linux-kernel+bounces-84106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645C86A237
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A5B1F24346
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82B1534F4;
	Tue, 27 Feb 2024 22:11:59 +0000 (UTC)
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE214E2CD;
	Tue, 27 Feb 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071919; cv=none; b=XfNaqKW9fqNRF8SJwtyMmtSRNTApQAPevb26uWLJV6YAsGQY8UwHbdsKjzoA4nxP+aVTyxAqYJ9zWZ5oAU3aDJxXaFfpuNnTSIJm10UGXp/TtQmJ3BHah7lqE42pBC7DOPUuT9m/q1qtOBw45TkY0VXZyHgK0nX/UN+zCTJZ8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071919; c=relaxed/simple;
	bh=qlimsLQ+9Ek9hizCvvfjMdet2Jw8BlNGeDYxx3D5tiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQHtAfAzIaAKDUMncK/ZjI7dQQLT89yyJjju+4E1duM0oLmUffSTIQ6LUWlZZ17TAmW9abZ7kcogrdaPc44hNS8U/iyUrrxgpzsHXEj5ZGKLurOS/PTPqgAUQO08Ylgia9f5/KMrC+w2hNKZ0dGWxmJ7w3CHL2PPL3pBNVma4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 41RLlJS0007032
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 28 Feb 2024 08:17:20 +1030
Date: Wed, 28 Feb 2024 08:17:19 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Szilard Fabian <szfabian@bluemarch.art>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de
Subject: Re: [PATCH v5] platform/x86/fujitsu-laptop: Add battery charge
 control support
Message-ID: <Zd5YZ9Gnt9GaipN4@marvin.atrad.com.au>
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <20240207023031.56805-2-szfabian@bluemarch.art>
 <20240215203012.228758-2-szfabian@bluemarch.art>
 <20240227120435.429687-2-szfabian@bluemarch.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227120435.429687-2-szfabian@bluemarch.art>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Tue, Feb 27, 2024 at 12:05:45PM +0000, Szilard Fabian wrote:
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

Acked-by: Jonathan Woithe <jwoithe@just42.net>

> v5:
> * add ACPI_BATTERY dependency into Kconfig
> 
> v4:
> * formatting fixes
> * replaced sprintf() with sysfs_emit()
> 
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
>  drivers/platform/x86/Kconfig          |   1 +
>  drivers/platform/x86/fujitsu-laptop.c | 125 ++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9a..945295f98560 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -374,6 +374,7 @@ config FUJITSU_LAPTOP
>  	depends on ACPI
>  	depends on INPUT
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on ACPI_BATTERY
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	select INPUT_SPARSEKMAP
>  	select NEW_LEDS
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 085e044e888e..69f9730bb14a 100644
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
> +
> +	status = call_fext_func(fext, FUNC_S006_METHOD,
> +				CHARGE_CONTROL_RW, 0x21, 0x0);
> +
> +	if (status < 0)
> +		return status;
> +
> +	return sysfs_emit(buf, "%d\n", status);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +/* ACPI battery hook */
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
> +static int fujitsu_battery_charge_control_add(struct acpi_device *device)
> +{
> +	struct fujitsu_laptop *priv = acpi_driver_data(device);
> +
> +	priv->charge_control_supported = false;
> +
> +	/*
> +	 * Check if the S006 0x21 method exists by trying to get the current
> +	 * battery charge limit.
> +	 */
> +	int s006_cc_return;
> +
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
> -- 
> 2.44.0
> 
> 

