Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B37EB1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKNOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKNOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:11:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB88A7;
        Tue, 14 Nov 2023 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699971086; x=1731507086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQgsz4xSVKjS3zoFWdC6OE36gpaEMOz/ndWYUV+d0hI=;
  b=YdlhQsLoUHaVp81oxjLgRScsDzBkPmzh+Od7tfm+9PSHDkq22BUwGlhe
   Fyon13wl7+zVWbxVHcQObO7W3GHVLTJopregOFTKnSBLeEIOCby49dhXc
   XQ9IitLL9W8ZAbpojGxxCWNtEpZ9xORxxKHWPXpZKm/LwIN3dYRvoB5Fr
   I1XORtXCGix3VgwEe3u8++S/WuBaKlmQYbdh3M83FLxI9M86DaEcfQaKp
   fPfhsfloXyQ3qOqbFbzMxescfsjktjY6K3pZV6u4xWvyNiqi87ZiF/lyE
   wlV7+HFVaM9JFiaC4FzIHENYcnq9QGxkDD1i2cUOykuqK3e0GULNKUEvh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3723625"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="3723625"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741105118"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741105118"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:11:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2u8N-0000000Dpfc-2Mrw;
        Tue, 14 Nov 2023 16:11:19 +0200
Date:   Tue, 14 Nov 2023 16:11:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
Subject: Re: [PATCH V7 1/3] mfd: Add support for UP board CPLD/FPGA
Message-ID: <ZVOABz35C8KmGrrk@smile.fi.intel.com>
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-2-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031015119.29756-2-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:51:17AM +0800, larry.lai wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
> 
> This driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that

s/This patch implements/Implement/

> manages direction and enable state for those header pins.
> 
> Partial support UP boards:

"for UP" or "supported" (choose one).

> * UP core + CREX
> * UP core + CRST02

> Reported-by: kernel test robot <lkp@intel.com>

No, this tag can't be applied to the new code.

> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>

Missing Co-developed-by?

...

> +config MFD_INTEL_UPBOARD_FPGA

I believe Intel has nothing to do with this one. The Intel SoC is accompanied
with OEM FPGA, right?

> +	tristate "Support for the Intel platform foundation kit UP board FPGA"

Depends on the above this most likely to be updated.

> +	select MFD_CORE

> +	depends on X86 && ACPI

No COMPILE_TEST?

> +	help
> +	  Select this option to enable the Intel AAEON UP and UP^2 on-board FPGA.

Intel is Intel.
AAEON is part of ASUS.

They never been part of Intel AFAICT.

> +	  This is core driver for the UP board that implements certain (pin
> +	  control, onboard LEDs or CEC) through an on-board FPGA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called upboard-fpga.

...

> +obj-$(CONFIG_MFD_INTEL_UPBOARD_FPGA)	+= upboard-fpga.o

Just drop INTEL_

...

> + * UP Board control CPLD/FPGA to provide more GPIO driving power
> + * also provide CPLD LEDs and pin mux function
> + * recognize HID AANT0F00 ~ AAANT0F04 in ACPI name space

This needs a bit of English grammar / punctuation update...

...

> +#include <linux/acpi.h>

How is this being used? Perhaps you need mod_devicetable.h and property.h
instead (see below).

> +#include <linux/dmi.h>

Unused.

> +#include <linux/gpio/consumer.h>

> +#include <linux/kernel.h>

What this header is for? Perhaps you meant array_size.h and other(s)?

> +#include <linux/leds.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

...

> +/*
> + * read CPLD register on custom protocol
> + * send clock and addr bit in strobe and datain pins then read from dataout pin
> + */

As per above, seems like all your comments need to be updated to follow some
English language rules...

...

> +static int upboard_cpld_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct upboard_fpga * const fpga = context;
> +	int i;
> +
> +	/* clear to start new transcation */
> +	gpiod_set_value(fpga->clear_gpio, 0);

No wait?

> +	gpiod_set_value(fpga->clear_gpio, 1);
> +
> +	reg |= UPFPGA_READ_FLAG;
> +
> +	/* send clock and data from strobe & datain */
> +	for (i = UPFPGA_ADDRESS_SIZE; i >= 0; i--) {
> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +		gpiod_set_value(fpga->datain_gpio, !!(reg & BIT(i)));
> +		gpiod_set_value(fpga->strobe_gpio, 1);
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 0);
> +	*val = 0;
> +
> +	/* read from dataout */
> +	for (i = UPFPGA_REGISTER_SIZE - 1; i >= 0; i--) {
> +		gpiod_set_value(fpga->strobe_gpio, 1);

No wait?

> +		gpiod_set_value(fpga->strobe_gpio, 0);
> +		*val |= gpiod_get_value(fpga->dataout_gpio) << i;
> +	}
> +
> +	gpiod_set_value(fpga->strobe_gpio, 1);
> +
> +	return 0;
> +}

This looks like SPI bitbang. Can you utilize that driver to do this for you?

...

> +static struct upboard_led_data upboard_gpio_led_data[] = {
> +	{ .bit = 0, .colour = "gpio" },
> +};
> +
> +/* 3 LEDs controlled by CPLD */
> +static struct upboard_led_data upboard_up_led_data[] = {
> +	{ .bit = 0, .colour = "yellow" },
> +	{ .bit = 1, .colour = "green" },
> +	{ .bit = 2, .colour = "red" },
> +};
> +
> +static const struct mfd_cell upboard_up_mfd_cells[] = {
> +	MFD_CELL_NAME("upboard-pinctrl"),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[0],
> +		       sizeof(*upboard_up_led_data), 0),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[1],
> +		       sizeof(*upboard_up_led_data), 1),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up_led_data[2],
> +		       sizeof(*upboard_up_led_data), 2),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
> +		       sizeof(*upboard_gpio_led_data), 0),
> +};

Why is not using LED framework?

...

> +static struct upboard_led_data upboard_up2_led_data[] = {
> +	{ .bit = 0, .colour = "blue" },
> +	{ .bit = 1, .colour = "yellow" },
> +	{ .bit = 2, .colour = "green" },
> +	{ .bit = 3, .colour = "red" },
> +};
> +
> +static const struct mfd_cell upboard_up2_mfd_cells[] = {
> +	MFD_CELL_NAME("upboard-pinctrl"),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[0],
> +		       sizeof(*upboard_up2_led_data), 0),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[1],
> +		       sizeof(*upboard_up2_led_data), 1),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[2],
> +		       sizeof(*upboard_up2_led_data), 2),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_up2_led_data[3],
> +		       sizeof(*upboard_up2_led_data), 3),
> +	MFD_CELL_BASIC("upboard-led", NULL, &upboard_gpio_led_data[0],
> +		       sizeof(*upboard_gpio_led_data), 0),
> +};

Ditto.

...

> +static int __init upboard_cpld_gpio_init(struct upboard_fpga *fpga)
> +{
> +	enum gpiod_flags flags = fpga->uninitialised ? GPIOD_OUT_LOW : GPIOD_ASIS;

> +	/*
> +	 * The SoC pinctrl driver may not support reserving the GPIO line for
> +	 * FPGA reset without causing an undesired reset pulse. This will clear
> +	 * any settings on the FPGA, so only do it if we must.
> +	 * Reset GPIO defaults HIGH, get GPIO and set to LOW, then set back to
> +	 * HIGH as a pulse.
> +	 */

So...

> +	if (fpga->uninitialised) {
> +		fpga->reset_gpio = devm_gpiod_get(fpga->dev, "reset", GPIOD_OUT_LOW);

...make it _optional() and use GPIOD_ASIS.

> +		if (IS_ERR(fpga->reset_gpio))
> +			return PTR_ERR(fpga->reset_gpio);

> +		gpiod_set_value(fpga->reset_gpio, RESET_DEVICE);

And with gpiod_direction_output() it may be conditionally called.

> +	}

> +	gpiod_set_value(fpga->enable_gpio, ENABLE_DEVICE);

> +	fpga->uninitialised = false;

How this flag is anyhow useful? Are you expecting the __init marked function to
be called twice?

Oh, it seems even __init is wrong here...

> +	return 0;
> +}

...

> +static const struct acpi_device_id upboard_fpga_acpi_match[] = {
> +	{ "AANT0000", AANT0000_ID },
> +	{ "AANT0F00", AANT0F00_ID },
> +	{ "AANT0F01", AANT0F01_ID },
> +	{ "AANT0F02", AANT0F02_ID },
> +	{ "AANT0F03", AANT0F03_ID },
> +	{ "AANT0F04", AANT0F04_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);

Move this closer to its real user (struct platform_driver below).

...

> +static int __init upboard_fpga_probe(struct platform_device *pdev)

How comes it's marked with __init?! Have you tested it?

...

> +	id = acpi_match_device(upboard_fpga_acpi_match, dev);
> +	if (!id)
> +		return -ENODEV;

No, use device_get_match_data() from property.h.

...

> +	switch (id->driver_data) {
> +	case AANT0F00_ID:
> +		cpld_config = &upboard_up_regmap_config;
> +		cells = upboard_up_mfd_cells;
> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
> +		break;
> +	case AANT0F01_ID:
> +		cpld_config = &upboard_up2_regmap_config;
> +		cells = upboard_up2_mfd_cells;
> +		ncells = ARRAY_SIZE(upboard_up2_mfd_cells);
> +		break;
> +	case AANT0F02_ID:
> +		cpld_config = &upboard_up_regmap_config;
> +		cells = upboard_up_mfd_cells;
> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
> +		break;
> +	case AANT0F03_ID:
> +		cpld_config = &upboard_up2_regmap_config;
> +		cells = upboard_up_mfd_cells;
> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
> +		break;
> +	case AANT0F04_ID:
> +		cpld_config = &upboard_up_regmap_config;
> +		cells = upboard_up_mfd_cells;
> +		ncells = ARRAY_SIZE(upboard_up_mfd_cells);
> +		break;
> +	case AANT0000_ID:
> +	default:
> +		cpld_config = &upboard_up_regmap_config;
> +		cells = upboard_pinctrl_cells;
> +		ncells = ARRAY_SIZE(upboard_pinctrl_cells);
> +		break;
> +	}

Drop this and make a custom structure which will be part of the driver data,
let's call it struct upboard_info. When it's done, you will simply have
to access constant info structure whenever you want to.

...

> +	platform_set_drvdata(pdev, ddata);

How is this being used?

...

> +enum upcpld_ids {
> +	AANT0000_ID		= 255,

Why not to start from 0?

> +	AANT0F00_ID		= 0,
> +	AANT0F01_ID		= 1,
> +	AANT0F02_ID		= 2,
> +	AANT0F03_ID		= 3,
> +	AANT0F04_ID		= 4,
> +};

...

> +enum upboard_fpgareg {
> +	UPFPGA_REG_PLATFORM_ID	= 0x10,
> +	UPFPGA_REG_FIRMWARE_ID	= 0x11,
> +	UPFPGA_REG_FUNC_EN0	= 0x20,
> +	UPFPGA_REG_FUNC_EN1	= 0x21,
> +	UPFPGA_REG_GPIO_EN0	= 0x30,
> +	UPFPGA_REG_GPIO_EN1	= 0x31,
> +	UPFPGA_REG_GPIO_EN2	= 0x32,
> +	UPFPGA_REG_GPIO_DIR0	= 0x40,
> +	UPFPGA_REG_GPIO_DIR1	= 0x41,
> +	UPFPGA_REG_GPIO_DIR2	= 0x42,
> +	UPFPGA_REG_MAX,

No comma for the termination.

> +};

...

Also, please split by models, first you add a driver with a single board
support and each new board addition is done in a separate change.

-- 
With Best Regards,
Andy Shevchenko


