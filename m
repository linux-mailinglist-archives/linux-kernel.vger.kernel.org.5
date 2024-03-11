Return-Path: <linux-kernel+bounces-99619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58322878ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E9F1F21821
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657A58200;
	Mon, 11 Mar 2024 22:42:57 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCD5810E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196976; cv=none; b=evD/KiKXHssf9C2D2038ZBnYLGdtZex566t3i5FJ50pcIkBkRO+z94VwzZxb0rtTYahnCjjduCmdPSHGv3rsGxrt0EBeggTNL8A2L42WCE2iGc2GOfOKmxJO8iHP5x5EP1J2IL/wWAHCZetgSlCkhVf7AKW8CGkLzkFJjd10fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196976; c=relaxed/simple;
	bh=+sZIqcnM2l7CrSRowV74v420SAwJuaeLZJ7Ypv/JKp8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP/zCW17qjtNIUnzKtHNTdvD0qTslAxgkdObn5l9JeikHuKwO+Uj0O1RiPev0MvJOokZy5D0R4d2F/LP+zmOI3o95Nvk9K5AOVdcSVfWgeubPvCOMl3oVnBeylKViQ5gJ5dwZj3kKPbDiLoewC23vAYxUKyCj24prEwMsmmz2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id b165ae91-dff8-11ee-a9de-005056bdf889;
	Tue, 12 Mar 2024 00:42:52 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Mar 2024 00:42:51 +0200
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
Message-ID: <Ze-I63bNzaMkHfgg@surfacebook.localdomain>
References: <20240306025801.8814-1-hpa@redhat.com>
 <20240306025801.8814-2-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306025801.8814-2-hpa@redhat.com>

Wed, Mar 06, 2024 at 10:58:00AM +0800, Kate Hsuan kirjoitti:
> There is a KTD2026 LED controller to manage the indicator LED for Xiaomi
> pad2. The ACPI for it is not properly made so the kernel can't get
> a correct description of it.
> 
> This work add a description for this RGB LED controller and also set a
> trigger to indicate the chaging event (bq27520-0-charging). When it is
> charging, the indicator LED will be turn on.

Ilpo, Kate, please consider the following remarks.

..

>  #include <linux/gpio/machine.h>
>  #include <linux/input.h>
>  #include <linux/platform_device.h>

+ Blank line?

> +#include <dt-bindings/leds/common.h>

Not sure where to place this, some drivers put it the first, some after linux/*.

..

> +/* main fwnode for ktd2026 */
> +static const struct software_node ktd2026_node = {

No name?

> +};
> +
> +static const struct property_entry ktd2026_rgb_led_props[] = {
> +	PROPERTY_ENTRY_U32("reg", 0),
> +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
> +	PROPERTY_ENTRY_STRING("function", "indicator"),

> +	PROPERTY_ENTRY_STRING("linux,default-trigger",
> +			      "bq27520-0-charging"),

It's less than 80, why not on a single line?

> +

Redundant blank line.

> +	{ }
> +};

..

> +/* B */

B for red?!

> +static const struct property_entry ktd2026_red_led_props[] = {
> +	PROPERTY_ENTRY_U32("reg", 0),
> +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_BLUE),
> +	{ }
> +};

..

> +/* R */

R for blue?!

> +static const struct property_entry ktd2026_blue_led_props[] = {
> +	PROPERTY_ENTRY_U32("reg", 2),
> +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RED),
> +	{ }
> +};

..

> +static int __init xiaomi_mipad2_init(void)
> +{
> +	return software_node_register_node_group(ktd2026_node_group);
> +}
> +
> +static void xiaomi_mipad2_exit(void)

Don't you want to have __exit here?

> +{
> +	software_node_unregister_node_group(ktd2026_node_group);
> +}

-- 
With Best Regards,
Andy Shevchenko



