Return-Path: <linux-kernel+bounces-99645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26753878B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E71F21913
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124658AB2;
	Mon, 11 Mar 2024 23:05:45 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139656B70
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198344; cv=none; b=qCfJ8wpOm9m4T4fWQ8D3ZCSgbjYEFjzy/GvBqJvca3MkF1PqT/7J+5M0Y58vB/3moLDVFy0XE3Re4SDghc2hdNJyZlXCm1IX4LHnvQ65VTL7APnuAXw0ZsvXBgFnkiBw2p615jKIvPIoQd4QuaCMushUlHebFdFoDZRj4Rv1oEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198344; c=relaxed/simple;
	bh=D28VkHywendSNSCG6I4rhALl2afA4LvcbwFoYAoHrL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/NeYL3X4o5qCe9J6Kqus0q71l6w83SJUoq/0xFBzEIJEZwrPpUIMViC5H5ksuMrIpJxtpogfFJiUZqf0UItwvGF0k6KfATxet2lAftA6lEdH5xC+yW7YICZlUg7wBqtnRSI8LVpx0qgj67EOMIGZjOGynVKcDg58J8LT2rr2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b8425178-dffb-11ee-b3cf-005056bd6ce9;
	Tue, 12 Mar 2024 01:04:32 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Mar 2024 01:04:31 +0200
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
Message-ID: <Ze-N_y5Tbjc93aRp@surfacebook.localdomain>
References: <20240306025801.8814-1-hpa@redhat.com>
 <20240306025801.8814-3-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306025801.8814-3-hpa@redhat.com>

Wed, Mar 06, 2024 at 10:58:01AM +0800, Kate Hsuan kirjoitti:
> This LED controller also installed on a Xiaomi pad2 and it is a x86
> platform. The original driver is based on device tree and can't be
> used for this ACPI based system. This patch migrated the driver to
> use fwnode to access the properties. Moreover, the fwnode API
> supports device tree so this work won't effect the original
> implementations.

..

> +	fwnode_for_each_available_child_node(np, child) {

Please, rename np to fwnode to avoid confusion.

> +		num_channels++;
> +	}

..

> -	for_each_available_child_of_node(np, child) {
> +	fwnode_for_each_available_child_node(np, child) {
>  		u32 mono_color;
>  		u32 reg;
>  		int ret;
>  
> -		ret = of_property_read_u32(child, "reg", &reg);
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret != 0 || reg >= chip->num_leds) {
>  			dev_err(chip->dev, "invalid 'reg' of %pOFn\n", child);

Must be %pfw now.

> -			of_node_put(child);
> +			fwnode_handle_put(child);

>  			return -EINVAL;

Side note: This shouldn't shadow error code when ret != 0.

>  		}

..

> -		ret = of_property_read_u32(child, "color", &mono_color);
> +		ret = fwnode_property_read_u32(child, "color", &mono_color);
>  		if (ret < 0 && ret != -EINVAL) {
>  			dev_err(chip->dev, "failed to parse 'color' of %pOF\n", child);

Must be %pfw now.

> -			of_node_put(child);
> +			fwnode_handle_put(child);
>  			return ret;
>  		}

..

> -	ret = of_property_read_u32(np, "reg", &reg);
> +	ret = fwnode_property_read_u32(np, "reg", &reg);
>  	if (ret != 0 || reg >= chip->num_leds) {
>  		dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);

Must be %pfw now.

>  		return -EINVAL;

>  	/* Color property is optional in single color case */
> -	ret = of_property_read_u32(np, "color", &color);
> +	ret = fwnode_property_read_u32(np, "color", &color);
>  	if (ret < 0 && ret != -EINVAL) {
>  		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);

Must be %pfw now.

>  		return ret;
>  	}

..

> +	struct fwnode_handle *child, *np;

Do not use np for sturct fwnode_handle. It will be quite confusing.

..

> -	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
> +	count = device_get_child_node_count(dev);

>  

Redundant blank line.

> -	count = of_get_available_child_count(np);
>  	if (!count || count > chip->num_leds)
>  		return -EINVAL;

..

> +	chip->num_leds = (unsigned long)i2c_get_match_data(client);

No warnings during compilation?

..

> +static const struct i2c_device_id ktd202x_id[] = {
> +	{"ktd2026", KTD2026_NUM_LEDS},
> +	{"ktd2027", KTD2027_NUM_LEDS},
> +	{},

N ocomma for the terminator entry.

> +};
> +MODULE_DEVICE_TABLE(i2c, ktd202x_id);

..

> +#ifndef CONFIG_ACPI

Please, no. Drop them.

>  static const struct of_device_id ktd202x_match_table[] = {
>  	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
>  	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ktd202x_match_table);
> +#endif
>  
>  static struct i2c_driver ktd202x_driver = {
>  	.driver = {
>  		.name = "leds-ktd202x",
> +#ifndef CONFIG_ACPI
>  		.of_match_table = ktd202x_match_table,
> +#endif

This is quite unusual besides being ugly.

>  	},
>  	.probe = ktd202x_probe,
>  	.remove = ktd202x_remove,
>  	.shutdown = ktd202x_shutdown,
> +	.id_table = ktd202x_id,
>  };

-- 
With Best Regards,
Andy Shevchenko



