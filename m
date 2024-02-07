Return-Path: <linux-kernel+bounces-56155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573C84C6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7788C1C2127A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490C20DCC;
	Wed,  7 Feb 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBZ6mQjO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B4208BC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296248; cv=none; b=o2T+NwC2b2ePGjG/92gGkQk7yNLjwGGfS0d4kupD++xw1sxouulgL+78m6sSfFl3/CiAaQnrgSU8+pmVth0+5FmhlIzCPLSBQD8B1CWaNbnWE8TEnkb5Mc8PjT+a/SVhSo44rRwcXLFt92tjXJaTgR3Mm3yBKdDW3nSRCvPYV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296248; c=relaxed/simple;
	bh=4wXlzz84B6FC7HC+Lda4uBOYGfK9pMEasjsIidtYf78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lDH7SSS0SMGVPTwzD3PlxSaCgtRJVfQFDQo31qW7rrONQ/xPxs0MqtnlvxzJ6OJAUSpDv7g2DSOzQwd8ogMYb0ix/LnDMJSnrEJ+U2Gyd51D8UY/l0kY+KLs5znvcbCzN/rILXxlPFznO3t5DkInKhyrZzx/G9KgORhx//S2foA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBZ6mQjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707296245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiwpei1G8h+mpDueqWLqXPDFDncgbOjsuv5z/xBaejM=;
	b=aBZ6mQjOF72O8HJIOQgfih3ljyKT0Gh4dEbxXG1UmJEuxgOxj9gTCMxsIWbh4EhJgAJM1Y
	++PgdyL7NOS/lRi+NUHv4zGyPYbCMQgMtDwsiEZ7phheBadNiSW17FE504Aa9EUoHOdH7J
	Httg2crGWHJuxnTrqDtUUI/ohWlUWRA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Rz3Ls_-TP_C9bnLA716y0w-1; Wed, 07 Feb 2024 03:57:24 -0500
X-MC-Unique: Rz3Ls_-TP_C9bnLA716y0w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a35ef7abe08so19634366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296243; x=1707901043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiwpei1G8h+mpDueqWLqXPDFDncgbOjsuv5z/xBaejM=;
        b=IJ2fTWfHUtfzr45QJQrohSmTKHU/77880rqgWpj78BZAPS319iOFySquV7qV/SII2R
         abng0LByUcCoYUYJu9NhDRC6rcqr6nwUwGQeDeq5DdZK5dcCangQPuYGx+NU9icN/XqN
         O3rz3MK4qo7wnsv4/0WIV3sUu1skZfJcAuhJTAqsWfluQc5kqQqiPQTFS479ZnTp/8EE
         RzE04lhERDb5F/kPUpCoBT20CMPUSiYkIBriWz69jn1IMxq7Lk8IREm56n+pMXudhxHx
         3+nCHPu1b87k3oT0M1bKTjWy1AO+blIccrLnDznhngk4J8rT9eIZXHWRZ02QSV7Hq/L0
         Y9Lg==
X-Gm-Message-State: AOJu0YzoDwxDhx20vTq8SzFH9Jw/LoBE1cOZ0OyKZXB1lnevx1svGWo6
	kYy+WaU7QpfmoNYvqvjZKa/PJtdkfLzl+pUCLNLwFIxiGNqTUQuVyiGY4RGIVXBHAv/bqImR4/Z
	24Uf2uTm4wiWgkD2wCEmgaqakgLiXPdwTg2MQjnT2Y1NTlPqCwylscKbyAJXofA==
X-Received: by 2002:a17:906:6d4e:b0:a31:805b:4172 with SMTP id a14-20020a1709066d4e00b00a31805b4172mr3399517ejt.9.1707296243347;
        Wed, 07 Feb 2024 00:57:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq82/qCnDbbkmQg922cnEy9yeXE3oQKLxjqFlfCfYdA7KqZaG0cSQYV6EBM1ll+1INlzctXA==
X-Received: by 2002:a17:906:6d4e:b0:a31:805b:4172 with SMTP id a14-20020a1709066d4e00b00a31805b4172mr3399501ejt.9.1707296242975;
        Wed, 07 Feb 2024 00:57:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFZ90n8v3luptaJcewiQA/CEWoImgXrIqpduXLcOLpNn6HjxAou5Jrq8lM10x1m94lLn6tKxdSpBB5iowiqvzizRCzgQv0D/iy5gq7+x37wxIe1HG7OgEcqOwkZrzcGcWpsgaLfhJxO+F04CCGd2VV4szPgAl7cw55iLW2wG6iNyCVIPpSDlp8ojNlx2G2N7uE7QHX0DAd6U0N3syngQn1zhWRqrVeSJr+6E9RIWwJYg4HIC4gdSxliOVrKu16ZCCnA2Nq
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vh8-20020a170907d38800b00a36c5b01ef3sm509430ejc.225.2024.02.07.00.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:57:22 -0800 (PST)
Message-ID: <e305a170-362d-48bb-a742-f4c8f010b2c7@redhat.com>
Date: Wed, 7 Feb 2024 09:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge
 control support
To: Szilard Fabian <szfabian@bluemarch.art>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, jwoithe@just42.net,
 ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
 Jelle van der Waa <jelle@vdwaa.nl>
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <20240207023031.56805-2-szfabian@bluemarch.art>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240207023031.56805-2-szfabian@bluemarch.art>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Szilard,

+Cc Jelle van der Waa who has been working on userspace (upower + GNOME)
support for these thresholds.

On 2/7/24 03:32, Szilard Fabian wrote:
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

Thank you for your patch. Do you happen to know if there also
is a noticeable fixed start threshold which is like say always 5%
lower then then end threshold ?

Note I'm *not* asking you to also add a start threshold attribute
at this time. But we (Jelle and me mostly atm) are thinking about
a way to export the start threshold offset in cases like this
to userspace.

Regards,

Hans



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
> +
> +	if (status < 0)
> +		return status;
> +
> +	return sprintf(buf, "%d\n", status);
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
> +
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


