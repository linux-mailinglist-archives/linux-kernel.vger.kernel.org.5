Return-Path: <linux-kernel+bounces-8700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5781BB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3245F2867B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2F58215;
	Thu, 21 Dec 2023 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5aHKt09"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1375821E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703173525; x=1734709525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gd6wKDRN8uX3IpoIU9qsH4qSjhv9zFYbxCKO/iBeMpw=;
  b=X5aHKt099I+wg3S6D/1KP90PpHPwwSwz1n+b7qdO6iD8rNGcFBXY4/Ux
   xZKqur8FNsjeWIqNC40HqAVDGDyXNAL/E/wAYlhPLObTc26Aspq+n2ca0
   ClW2jjapzGKULoHkGgVyQEANCRlToOkq+wfy4okgoNzumIqemyPkDpd87
   f+Ep9Wc7QdGbs2pRLHD22gHGHtBsXAaWdbykGEl81+g9wNz+rbja481VF
   CkktOKXWCxXS6981BPdK0SHHwRB3xFLajJGRWIdQDE44Chq0mE8Ftj7bQ
   2lhpFAGrqE4GUHua8NfWTEYOQV1HX/59huANIl7/sMrDejw9lnb3kxa71
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394882707"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394882707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:45:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="842651936"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="842651936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:45:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGLEa-00000007sz1-3WxJ;
	Thu, 21 Dec 2023 17:45:16 +0200
Date: Thu, 21 Dec 2023 17:45:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZYRdjHVgES1odZAQ@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 04:54:36PM -0700, Mark Hasemeyer wrote:
> The cros ec driver is manually managing the wake IRQ by calling
> enable_irq_wake()/disable_irq_wake() during suspend/resume.
> 
> Modify the driver to use the power management subsystem to manage the
> wakeirq.
> 
> Rather than assuming that the IRQ is wake capable, use the underlying
> firmware/device tree to determine whether or not to enable it as a wake
> source. Some Chromebooks rely solely on the ec_sync pin to wake the AP
> but do not specify the interrupt as wake capable in the ACPI _CRS. For
> LPC/ACPI based systems a DMI quirk is introduced listing boards whose
> firmware should not be trusted to provide correct wake capable values.
> For device tree base systems, it is not an issue as the relevant device
> tree entries have been updated and DTS is built from source for each
> ChromeOS update.
> 
> The IRQ wake logic was added on an interface basis (lpc, spi, uart) as
> opposed to adding it to cros_ec.c because the i2c subsystem already
> enables the wakirq (if applicable) on our behalf.

...

> +static const struct dmi_system_id untrusted_fw_irq_wake_capable[] = {
> +	{
> +		.ident = "Brya",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya")
> +		}

Leave trailing comma.

> +	},
> +	{
> +		.ident = "Brask",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brask")
> +		}

Ditto.

It will reduce a churn in the future if adding more fields here.

> +	},
> +	{ }
> +}

...

> +static bool cros_ec_should_force_irq_wake_capable(void)
> +{
> +	return dmi_first_match(untrusted_fw_irq_wake_capable) != NULL;

' != NULL' is redundant.

> +}

...

>  	struct device *dev = &pdev->dev;

> +	bool irq_wake = false;

Why not put this...

>  	struct acpi_device *adev;
>  	acpi_status status;
>  	struct cros_ec_device *ec_dev;
> +	struct resource irqres;

...here?

>  	u8 buf[2] = {};
>  	int irq, ret;

...

> +	irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
> +	if (irq > 0) {
>  		ec_dev->irq = irq;
> -	else if (irq != -ENXIO) {
> +		if (cros_ec_should_force_irq_wake_capable())
> +			irq_wake = true;
> +		else
> +			irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
> +		dev_dbg(dev, "IRQ: %i, wake_capable: %i\n", irq, irq_wake);
> +	} else if (irq != -ENXIO) {
>  		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
>  		return irq;
>  	}

Yeah, this is confusing now. Which one should I trust more: irq or irqres.start?
What is the point to have irqres with this duplication?

...

> -		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
> +		dev_err_probe(dev, ret, "couldn't register ec_dev (%d)\n", ret);
>  		return ret;

		return dev_err_probe(...);

...

> +			dev_err_probe(dev, ret, "Failed to init device for wakeup");
> +			return ret;

Ditto.

...

> +	if (!np)
> +		return;

Why do you need this now?

I would expect either agnostic code or the very first mandatory of_*() call
will fail with the error anyway.

...

>  	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
>  	if (!ret)
>  		ec_spi->end_of_msg_delay = val;

> +	if (ec_dev->irq > 0 && of_property_read_bool(np, "wakeup-source")) {
> +		ec_spi->irq_wake = true;
> +		dev_dbg(&spi->dev, "IRQ: %i, wake_capable: %i\n", ec_dev->irq, ec_spi->irq_wake);
> +	}

	if (ret)
		return;

	ec_spi->irq_wake = of_property_read_bool(np, "wakeup-source"));
	dev_dbg(&spi->dev, "IRQ: %i, wake_capable: %s\n", ec_dev->irq, str_yes_no(ec_spi->irq_wake));

?

...

> +	if (ec_spi->irq_wake) {
> +		err = device_init_wakeup(dev, true);
> +		if (err) {
> +			dev_err_probe(dev, err, "Failed to init device for wakeup\n");
> +			return err;

			return dev_err_probe(...);

> +		}
> +		err = dev_pm_set_wake_irq(dev, ec_dev->irq);
> +		if (err)
> +			dev_err_probe(dev, err, "Failed to set irq(%d) for wake\n", ec_dev->irq);

		Ditto.

> +	}

> -	return 0;
> +	return err;

Unneeded change (see above how to use dev_err_probe() in an efficient way).

ret / err... Even in one file already some inconsistency...

...

> @@ -78,6 +80,7 @@ struct cros_ec_uart {
>  	u32 baudrate;
>  	u8 flowcontrol;
>  	u32 irq;
> +	bool irq_wake;
>  	struct response_info response;
>  };

Run `pahole` and amend respectively to avoid wasting memory.

...

> +	dev_dbg(dev, "IRQ: %i, wake_capable: %i\n", ec_uart->irq, ec_uart->irq_wake);

str_yes_no() from string_choices.h?

...

> +	/* Register a new cros_ec device */
> +	ret = cros_ec_register(ec_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register ec_dev (%d)\n", ret);
> +		return ret;

Why not dev_err_probe() here...

> +	}
> +
> +	if (ec_uart->irq_wake) {
> +		ret = device_init_wakeup(dev, true);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Failed to init device for wakeup");
> +			return ret;

...and here?

> +		}
> +		ret = dev_pm_set_wake_irq(dev, ec_uart->irq);
> +	}
> +	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko



