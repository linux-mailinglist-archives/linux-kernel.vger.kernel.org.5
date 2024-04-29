Return-Path: <linux-kernel+bounces-162108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB78B55FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED81F23314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614F3BBF8;
	Mon, 29 Apr 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWC0CKUK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A953B7A0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388731; cv=none; b=tbfHPMIEdPBSmZYXeXlXbPtuwDxroFTCoHwH6DnkQdth6naUzXPxpVN9p4H09/QN5L8WBXxaNknd/32lRxauOA2Ip+ufdnLMPDwUyLlhOq8crDbe5gy70ay8Kn6PXodBi+u5PnXAkphcFBykcBYKTfr3BMo1ZN7DxaPYVoz4B+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388731; c=relaxed/simple;
	bh=qGDaqg63/846loIrKt3rLFBTn/55BAVx41K8+VKsKC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEpzodaA6ac3VRDrFllLn17IxlBEZrepx0AJnyIyHtHeqEKBrm8lPfqpYdWubEpqHPTf6bKh6OerTdIEeBQGSWVqWFRU3TKwzQ78Ymj2qZR7ZPJzf+PpwnNCLOTaB5pRXtcqvpB9E6/QlcYWU/bwMBURNI+XVbxVQlmMcX2jfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWC0CKUK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714388728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URyUBWwW/8s6cUiXsNVvT240BG7i32T50ylUsy9Neg0=;
	b=bWC0CKUKV0MOhyYSUmwlFh5hvykdZ7XaPoF3MKSu5t6ZZcJDjzHc7L/db5BT9OFS+JhDEX
	vYUyrfcbE0Dg/m6RcPPq/+F5qhFnKxZua/RJyldZOJ7IzhbHE+VCHjrM4jvsccP7t9e8kH
	f7SuzRhFYL/fukBB0lzAHFQudMK8FAQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-DeFj0TnRPBiK7oUHTtA_PQ-1; Mon, 29 Apr 2024 07:05:26 -0400
X-MC-Unique: DeFj0TnRPBiK7oUHTtA_PQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4455ae71fcso238690566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714388725; x=1714993525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URyUBWwW/8s6cUiXsNVvT240BG7i32T50ylUsy9Neg0=;
        b=MtBvI3T3wntlvBVprfqVNbDScbE1JawFTody/Ni+dw8+ULWFfiV1/td/U6MtMNrdR9
         HUktTdHrbO+cWqeHev0LhsAIhfSnZXZ5XGUXSsUbCHGfhWdlXgynpVpnpNspHLGswWhQ
         2fNGg+/fXGIH2MEhhNJWaLO4QpG+5fTX/qaJlIH1GCDotQIUrWMSTwExBV+R63WIFMF9
         DDzdy1c9a3LQJVA5jhzzOcn2qLBUXAAvKWv5aFLOdDGyw8JavCcO3/GQjchYJ//xRfaW
         1JxwLXYmEkebojRqO8zpB6+ZmvxrZ+MoRGm/SJ4uvx5hXjLkQoKnBh9LuSJWl17drgGA
         j9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV2NOoOj1ZVr+cJhe7WF243R0SwJaJt3Q+PVCDOoCWEIoMRHSLBcS/V/QYw1nwWQB0f/e4lfvElKns8DmWlCb1ii3kW9DGXXSEqgoqA
X-Gm-Message-State: AOJu0YzqsdJP0JXbgH+qKCSVwKqjUFkGSpT6JIfDYQP0KsNsV3BEOJqk
	wyRAGrYcxcPYeyPUNZ4Sg0Ue+L8EvyF+qqrwGlEyOUqLKbne8+iUtbNdC7tQkjqUBYjobm3NAn9
	dbwWSUqWOeGO3V1IZ8w2vU0PvQopf47Qt8udXy0GAgpuyJOhfDt8vb/giZJNnAw==
X-Received: by 2002:a17:906:244d:b0:a51:e05f:2455 with SMTP id a13-20020a170906244d00b00a51e05f2455mr8326817ejb.48.1714388725281;
        Mon, 29 Apr 2024 04:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl2hONlsSnUfKEuig2Ybcrp0d2fsKU86vh/maQFAEN/gUKMAU6+9L/rs1Hz400Xsu454Qb0A==
X-Received: by 2002:a17:906:244d:b0:a51:e05f:2455 with SMTP id a13-20020a170906244d00b00a51e05f2455mr8326796ejb.48.1714388724878;
        Mon, 29 Apr 2024 04:05:24 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906378400b00a522fb5587esm11767090ejc.144.2024.04.29.04.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:05:24 -0700 (PDT)
Message-ID: <fe0bb552-52d8-4ae1-a20b-c7236cf1f255@redhat.com>
Date: Mon, 29 Apr 2024 13:05:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20240424065212.263784-1-hpa@redhat.com>
 <20240424065212.263784-2-hpa@redhat.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240424065212.263784-2-hpa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/24/24 8:52 AM, Kate Hsuan wrote:
> This LED controller is installed on a Xiaomi pad2 and it is an x86
> platform. The original driver is based on the device tree and can't be
> used for this ACPI based system. This patch migrated the driver to use
> fwnode to access the properties. Moreover, the fwnode API supports the
> device tree so this work won't affect the original implementations.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> Tested-by: André Apitzsch <git@apitzsch.eu> # on BQ Aquaris M5

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/leds/rgb/Kconfig        |  1 -
>  drivers/leds/rgb/leds-ktd202x.c | 64 +++++++++++++++++----------------
>  2 files changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index e66bd21b9852..14d6b294a786 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -17,7 +17,6 @@ config LEDS_GROUP_MULTICOLOR
>  config LEDS_KTD202X
>  	tristate "LED support for KTD202x Chips"
>  	depends on I2C
> -	depends on OF
>  	select REGMAP_I2C
>  	help
>  	  This option enables support for the Kinetic KTD2026/KTD2027
> diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
> index 514965795a10..f1c810c415a4 100644
> --- a/drivers/leds/rgb/leds-ktd202x.c
> +++ b/drivers/leds/rgb/leds-ktd202x.c
> @@ -99,7 +99,7 @@ struct ktd202x {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	bool enabled;
> -	int num_leds;
> +	unsigned long num_leds;
>  	struct ktd202x_led leds[] __counted_by(num_leds);
>  };
>  
> @@ -381,16 +381,19 @@ static int ktd202x_blink_mc_set(struct led_classdev *cdev,
>  				 mc->num_colors);
>  }
>  
> -static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
> +static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwnode,
>  				 struct ktd202x_led *led, struct led_init_data *init_data)
>  {
> +	struct fwnode_handle *child;
>  	struct led_classdev *cdev;
> -	struct device_node *child;
>  	struct mc_subled *info;
>  	int num_channels;
>  	int i = 0;
>  
> -	num_channels = of_get_available_child_count(np);
> +	num_channels = 0;
> +	fwnode_for_each_available_child_node(fwnode, child)
> +		num_channels++;
> +
>  	if (!num_channels || num_channels > chip->num_leds)
>  		return -EINVAL;
>  
> @@ -398,22 +401,22 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	for_each_available_child_of_node(np, child) {
> +	fwnode_for_each_available_child_node(fwnode, child) {
>  		u32 mono_color;
>  		u32 reg;
>  		int ret;
>  
> -		ret = of_property_read_u32(child, "reg", &reg);
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret != 0 || reg >= chip->num_leds) {
> -			dev_err(chip->dev, "invalid 'reg' of %pOFn\n", child);
> -			of_node_put(child);
> -			return -EINVAL;
> +			dev_err(chip->dev, "invalid 'reg' of %pfw\n", child);
> +			fwnode_handle_put(child);
> +			return ret;
>  		}
>  
> -		ret = of_property_read_u32(child, "color", &mono_color);
> +		ret = fwnode_property_read_u32(child, "color", &mono_color);
>  		if (ret < 0 && ret != -EINVAL) {
> -			dev_err(chip->dev, "failed to parse 'color' of %pOF\n", child);
> -			of_node_put(child);
> +			dev_err(chip->dev, "failed to parse 'color' of %pfw\n", child);
> +			fwnode_handle_put(child);
>  			return ret;
>  		}
>  
> @@ -433,16 +436,16 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
>  	return devm_led_classdev_multicolor_register_ext(chip->dev, &led->mcdev, init_data);
>  }
>  
> -static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np,
> +static int ktd202x_setup_led_single(struct ktd202x *chip, struct fwnode_handle *fwnode,
>  				    struct ktd202x_led *led, struct led_init_data *init_data)
>  {
>  	struct led_classdev *cdev;
>  	u32 reg;
>  	int ret;
>  
> -	ret = of_property_read_u32(np, "reg", &reg);
> +	ret = fwnode_property_read_u32(fwnode, "reg", &reg);
>  	if (ret != 0 || reg >= chip->num_leds) {
> -		dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
> +		dev_err(chip->dev, "invalid 'reg' of %pfw\n", fwnode);
>  		return -EINVAL;
>  	}
>  	led->index = reg;
> @@ -454,7 +457,7 @@ static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np
>  	return devm_led_classdev_register_ext(chip->dev, &led->cdev, init_data);
>  }
>  
> -static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigned int index)
> +static int ktd202x_add_led(struct ktd202x *chip, struct fwnode_handle *fwnode, unsigned int index)
>  {
>  	struct ktd202x_led *led = &chip->leds[index];
>  	struct led_init_data init_data = {};
> @@ -463,21 +466,21 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
>  	int ret;
>  
>  	/* Color property is optional in single color case */
> -	ret = of_property_read_u32(np, "color", &color);
> +	ret = fwnode_property_read_u32(fwnode, "color", &color);
>  	if (ret < 0 && ret != -EINVAL) {
> -		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);
> +		dev_err(chip->dev, "failed to parse 'color' of %pfw\n", fwnode);
>  		return ret;
>  	}
>  
>  	led->chip = chip;
> -	init_data.fwnode = of_fwnode_handle(np);
> +	init_data.fwnode = fwnode;
>  
>  	if (color == LED_COLOR_ID_RGB) {
>  		cdev = &led->mcdev.led_cdev;
> -		ret = ktd202x_setup_led_rgb(chip, np, led, &init_data);
> +		ret = ktd202x_setup_led_rgb(chip, fwnode, led, &init_data);
>  	} else {
>  		cdev = &led->cdev;
> -		ret = ktd202x_setup_led_single(chip, np, led, &init_data);
> +		ret = ktd202x_setup_led_single(chip, fwnode, led, &init_data);
>  	}
>  
>  	if (ret) {
> @@ -490,15 +493,14 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
>  	return 0;
>  }
>  
> -static int ktd202x_probe_dt(struct ktd202x *chip)
> +static int ktd202x_probe_fw(struct ktd202x *chip)
>  {
> -	struct device_node *np = dev_of_node(chip->dev), *child;
> +	struct fwnode_handle *child;
> +	struct device *dev = chip->dev;
>  	int count;
>  	int i = 0;
>  
> -	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
> -
> -	count = of_get_available_child_count(np);
> +	count = device_get_child_node_count(dev);
>  	if (!count || count > chip->num_leds)
>  		return -EINVAL;
>  
> @@ -507,11 +509,11 @@ static int ktd202x_probe_dt(struct ktd202x *chip)
>  	/* Allow the device to execute the complete reset */
>  	usleep_range(200, 300);
>  
> -	for_each_available_child_of_node(np, child) {
> +	device_for_each_child_node(dev, child) {
>  		int ret = ktd202x_add_led(chip, child, i);
>  
>  		if (ret) {
> -			of_node_put(child);
> +			fwnode_handle_put(child);
>  			return ret;
>  		}
>  		i++;
> @@ -554,6 +556,8 @@ static int ktd202x_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	chip->num_leds = (unsigned long)i2c_get_match_data(client);
> +
>  	chip->regulators[0].supply = "vin";
>  	chip->regulators[1].supply = "vio";
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);
> @@ -568,7 +572,7 @@ static int ktd202x_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = ktd202x_probe_dt(chip);
> +	ret = ktd202x_probe_fw(chip);
>  	if (ret < 0) {
>  		regulator_bulk_disable(ARRAY_SIZE(chip->regulators), chip->regulators);
>  		return ret;
> @@ -605,7 +609,7 @@ static void ktd202x_shutdown(struct i2c_client *client)
>  static const struct of_device_id ktd202x_match_table[] = {
>  	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
>  	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, ktd202x_match_table);
>  


