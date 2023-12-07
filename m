Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D95808BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443445AbjLGPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443432AbjLGPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC110EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:20:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1363C433C8;
        Thu,  7 Dec 2023 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962446;
        bh=Gx8sz2eVSZ1HcaXgJaOB0w/q57DRCo4xFJwZYrTqS9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXHrmLmG5+Gfu6lGBgMwyOC7etjAbkeJpwb6T693Ly+Be3e97cAWeNXDAMQHam4W5
         R1itLbjRxuVnV1mxPW5nnkBsllmepjY+Qp/970z4K3sfVFEASX+BaELy61F52QjHZf
         1Omm0UogS8ID5QE9fSrrMyluzb1XTXEm+xdIXq2+kxifF6GGqEVBTJC9TreCURO0pP
         TCBso0KS4P52/13r15T19EXomLszw8GpYDB05xF6Hy3DLCKph1hNZ7nYGqKhHMXvSY
         CJ0wy1Hb9o8uIAG/3LtU/hS0usZaUeTNSVcnpW7NpheLPUk5Pdc2NAhrQwzmgZYS/4
         TYqijSN1jYqfw==
Date:   Thu, 7 Dec 2023 15:20:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Shawn Anastasio <sanastasio@raptorengineering.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v2 2/2] mfd: sie-cronos-cpld: Add driver for Sony Cronos
 CPLD
Message-ID: <20231207152041.GF8867@google.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
 <05fae4dfc455e44a9eda7da447e86a3f34ee395e.1701203916.git.sanastasio@raptorengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05fae4dfc455e44a9eda7da447e86a3f34ee395e.1701203916.git.sanastasio@raptorengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Shawn Anastasio wrote:

> From: Timothy Pearson <tpearson@raptorengineering.com>
> 
> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller for
> the Sony Interactive Entertainment Cronos x86 server platform. As both
> functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
> Changes in v2:
>   - Change SIE to Sony (SIE's parent company) to be more consistent
>   with how other subsidiaries are treated in the kernel
>   - Fix build issue under !CONFIG_OF discovered by kernel test robot

Does this driver work without Device Tree?

Why can't you just drop the of_match_ptr()?

>   by guarding definition of `cronos_cpld_dt_ids` as is done in other
>   drivers.
> 
>  MAINTAINERS                               |   7 +
>  drivers/mfd/Kconfig                       |  11 +
>  drivers/mfd/Makefile                      |   1 +
>  drivers/mfd/sony-cronos-cpld.c            | 591 ++++++++++++++++++++++
>  include/linux/mfd/sony/cronos/core.h      |  17 +
>  include/linux/mfd/sony/cronos/registers.h |  59 +++
>  6 files changed, 686 insertions(+)
>  create mode 100644 drivers/mfd/sony-cronos-cpld.c
>  create mode 100644 include/linux/mfd/sony/cronos/core.h
>  create mode 100644 include/linux/mfd/sony/cronos/registers.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c4cce45a09d..623681826820 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19932,6 +19932,13 @@ S:	Maintained
>  F:	drivers/ssb/
>  F:	include/linux/ssb/
> 
> +SONY CRONOS CPLD DRIVER
> +M:	Georgy Yakovlev <Georgy.Yakovlev@sony.com>

Are they aware of this?

They do not appear to be in the submission path.

> +S:	Maintained

This should probably be Supported.

> +F:	Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> +F:	drivers/mfd/sony-cronos-cpld.c
> +F:	include/linux/mfd/sony/cronos/
> +
>  SONY IMX208 SENSOR DRIVER
>  M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 90ce58fd629e..27f28fbbc7cc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2217,6 +2217,17 @@ config MFD_QCOM_PM8008
>  	  under it in the device tree. Additional drivers must be enabled in
>  	  order to use the functionality of the device.
> 
> +config MFD_SONY_CRONOS_CPLD
> +	tristate "Sony Cronos CPLD Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +      Support for the Sony Cronos system control CPLDs. Additional drivers must
> +      be enabled in order to use the functionality of the device, including LED
> +      control and the system watchdog. The controller itself is a custom design
> +      tailored to the specific needs of the Sony Cronos hardware platform.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c66f07edcd0e..be9974f0fe9c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -284,3 +284,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>  rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> +obj-$(CONFIG_MFD_SONY_CRONOS_CPLD)	+= sony-cronos-cpld.o
> diff --git a/drivers/mfd/sony-cronos-cpld.c b/drivers/mfd/sony-cronos-cpld.c
> new file mode 100644
> index 000000000000..569793cd9697
> --- /dev/null
> +++ b/drivers/mfd/sony-cronos-cpld.c
> @@ -0,0 +1,591 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * I2C device driver for Sony Cronos CPLDs

This is not an I2C device driver.

> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022  Raptor Engineering, LLC

No changes since 2022?

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/sony/cronos/core.h>
> +#include <linux/mfd/sony/cronos/registers.h>

Alphabetical.

> +static struct resource cronos_wdt_resources[] = {
> +};
> +
> +static struct resource cronos_led_resources[] = {
> +};

What is the point of these?

> +static const struct mfd_cell cronos_cpld_devs[] = {
> +	{
> +		.name          = "cronos-watchdog",
> +		.num_resources = ARRAY_SIZE(cronos_wdt_resources),
> +		.resources     = cronos_wdt_resources,
> +		.of_compatible = "sony,cronos-watchdog",
> +	},
> +	{
> +		.name          = "cronos-leds",
> +		.id            = 1,

Why are you manually numbering them?

> +		.num_resources = ARRAY_SIZE(cronos_led_resources),
> +		.resources     = cronos_led_resources,
> +		.of_compatible = "sony,cronos-leds",
> +	},
> +};
> +
> +static ssize_t payload_power_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int payloadpower_val = 0;

Ironically, the "_val" provides no value here.

> +	int ret = -EIO;

Why is this being pre-initialised?  Same throughout.

> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);

Move this line to the top - same throughout.

> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG, &payloadpower_val);
> +	if (ret < 0)

if (ret) is fine.  For all cases below too.

> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", payloadpower_val);

sysfs_emit().  For all cases below too.

> +}
> +
> +static ssize_t payload_power_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	u8 val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(chip->regmap, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_PAYLOAD_POWER_CTL_REG);

Why dump an error messages here and not in other places?

I suggest they are dropped.

> +		return ret;
> +	}
> +	return len;
> +}
> +
> +
> +static ssize_t bmc_flash_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int bmcflash_val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG, &bmcflash_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", bmcflash_val);
> +}
> +
> +static ssize_t bmc_flash_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	u8 val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(chip->regmap, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +
> +static ssize_t switch_reset_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int switchreset_val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, &switchreset_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", switchreset_val);
> +}
> +
> +static ssize_t switch_reset_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	unsigned int switchreset_val = 0;
> +	u8 val = -EINVAL;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, &switchreset_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(chip->regmap, CRONOS_CPLD_SWITCH_RESET_CMD_REG, switchreset_val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +				switchreset_val, CRONOS_CPLD_SWITCH_RESET_CMD_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +
> +static ssize_t switch_flash_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int switchflash_val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG, &switchflash_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", switchflash_val);
> +}
> +
> +static ssize_t switch_flash_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	u8 val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(chip->regmap, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +
> +static ssize_t uart_mux_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int uartmux_val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_UART_MUX_REG, &uartmux_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", uartmux_val);
> +}
> +
> +static ssize_t uart_mux_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t len)
> +{
> +	u8 val = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_write(chip->regmap, CRONOS_CPLD_UART_MUX_REG, val);
> +	if (ret) {
> +		dev_err(dev, "Failed to write value 0x%02x to address 0x%02x",
> +			val, CRONOS_CPLD_UART_MUX_REG);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +
> +static ssize_t led_get_brightness(struct sony_cronos_cpld *chip, unsigned int reg, char *buf)
> +{
> +	unsigned int brightness_val;
> +	int ret = -EIO;
> +
> +	ret = regmap_read(chip->regmap, reg, &brightness_val);
> +	if (ret != 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", brightness_val);
> +}
> +
> +static ssize_t led_set_brightness(struct sony_cronos_cpld *chip, unsigned int reg, const char *buf,
> +	size_t len)
> +{
> +	u8 val = 0;
> +	int ret = -EIO;
> +
> +	if (kstrtou8(buf, 0, &val))
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(chip->regmap, reg, CRONOS_CPLD_LEDS_BRIGHTNESS_SET_MASK, val);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to write value 0x%02x to address 0x%02x", val, reg);
> +		return ret;
> +	}
> +	return len;
> +}
> +
> +static ssize_t brightness_red_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_RED_REG, buf);
> +}
> +
> +static ssize_t brightness_red_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_RED_REG, buf, len);
> +}
> +
> +static ssize_t brightness_green_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_GREEN_REG, buf);
> +}
> +
> +static ssize_t brightness_green_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_GREEN_REG, buf, len);
> +}
> +
> +static ssize_t brightness_blue_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_get_brightness(chip, CRONOS_CPLD_BRIGHTNESS_BLUE_REG, buf);
> +}
> +
> +static ssize_t brightness_blue_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	return led_set_brightness(chip, CRONOS_CPLD_BRIGHTNESS_BLUE_REG, buf, len);
> +}

All of the LED related code should be in the LED driver.

> +
> +

No double line spacings.

> +static ssize_t revision_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	u16 revision = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_REVISION_LOW_REG, &revision, 2);
> +	if (ret)
> +		return -EIO;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%04x\n", revision);
> +}
> +
> +static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	u16 device_id = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG, &device_id, 2);
> +	if (ret)
> +		return -EIO;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%04x\n", device_id);
> +}
> +
> +static ssize_t bmc_mac_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	u8 bmc_mac[6];
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_bulk_read(chip->regmap, CRONOS_CPLD_BMC_MAC_LOW_REG, bmc_mac, 6);
> +	if (ret)
> +		return -EIO;
> +
> +	return snprintf(buf, PAGE_SIZE, "%pM\n", bmc_mac);
> +}
> +
> +static ssize_t status_2_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int last_boot = 0;
> +	int ret = -EIO;
> +	struct sony_cronos_cpld *chip = dev_get_drvdata(dev);
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_STATUS_2_REG, &last_boot);
> +	if (ret < 0)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%02x\n", last_boot);
> +}
> +
> +
> +static DEVICE_ATTR_RO(revision);
> +static DEVICE_ATTR_RO(device_id);
> +static DEVICE_ATTR_RO(bmc_mac);
> +static DEVICE_ATTR_RO(status_2);
> +
> +static DEVICE_ATTR_RW(uart_mux);
> +static DEVICE_ATTR_RW(switch_flash);
> +static DEVICE_ATTR_RW(switch_reset);
> +static DEVICE_ATTR_RW(bmc_flash);
> +static DEVICE_ATTR_RW(payload_power);
> +
> +static DEVICE_ATTR_RW(brightness_red);
> +static DEVICE_ATTR_RW(brightness_green);
> +static DEVICE_ATTR_RW(brightness_blue);

'\n'

> +static struct attribute *cronos_cpld_sysfs_entries[] = {
> +	&dev_attr_revision.attr,
> +	&dev_attr_device_id.attr,
> +	&dev_attr_bmc_mac.attr,
> +	&dev_attr_status_2.attr,
> +	&dev_attr_uart_mux.attr,
> +	&dev_attr_switch_flash.attr,
> +	&dev_attr_switch_reset.attr,
> +	&dev_attr_bmc_flash.attr,
> +	&dev_attr_payload_power.attr,
> +	&dev_attr_brightness_red.attr,
> +	&dev_attr_brightness_green.attr,
> +	&dev_attr_brightness_blue.attr,
> +	NULL,
> +};

These all need to be documented or dropped.

Please read:

  Documentation/filesystems/sysfs.rst

And do:

  `find Documentation -name *sysfs*`

> +static const struct attribute_group cronos_cpld_attr_group = {
> +	.attrs	= cronos_cpld_sysfs_entries,
> +};
> +
> +static int sony_cronos_get_device_type(struct sony_cronos_cpld *chip)
> +{
> +	int device_id;
> +	int byte;

Introduce 2 variables and do all of the bit manipulation at the bottom.

> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_HIGH_REG, &byte);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Cannot read chip ID.\n");
> +		return -EIO;
> +	}

Spread these out with '\n's.

> +	device_id = byte << 8;
> +	ret = regmap_read(chip->regmap, CRONOS_CPLD_DEVICE_ID_LOW_REG, &byte);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Cannot read chip ID.\n");
> +		return -EIO;
> +	}
> +	device_id |= byte;
> +	if (device_id != CRONOS_CPLD_DEVICE_ID) {
> +		dev_err(chip->dev, "Invalid device ID: 0x%04x\n", device_id);

"Unsupported"

> +		return -ENODEV;
> +	}
> +
> +	dev_info(chip->dev,
> +		 "Device detected (device-ID: 0x%04X)\n",
> +		 device_id);

Why line break here?  The lines above are way longer.

> +	return ret;
> +}
> +
> +static bool cronos_cpld_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
> +	case CRONOS_LEDS_SMC_STATUS_REG:
> +	case CRONOS_LEDS_SWITCH_STATUS_REG:
> +	case CRONOS_LEDS_CCM1_STATUS_REG:
> +	case CRONOS_LEDS_CCM2_STATUS_REG:
> +	case CRONOS_LEDS_CCM3_STATUS_REG:
> +	case CRONOS_LEDS_CCM4_STATUS_REG:
> +	case CRONOS_LEDS_CCM_POWER_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +
> +	case CRONOS_CPLD_UART_MUX_REG:
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool cronos_cpld_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_REVISION_HIGH_REG:
> +	case CRONOS_CPLD_REVISION_LOW_REG:
> +	case CRONOS_CPLD_DEVICE_ID_HIGH_REG:
> +	case CRONOS_CPLD_DEVICE_ID_LOW_REG:
> +
> +	case CRONOS_CPLD_BRIGHTNESS_RED_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_GREEN_REG:
> +	case CRONOS_CPLD_BRIGHTNESS_BLUE_REG:
> +	case CRONOS_LEDS_SMC_STATUS_REG:
> +	case CRONOS_LEDS_SWITCH_STATUS_REG:
> +	case CRONOS_LEDS_CCM1_STATUS_REG:
> +	case CRONOS_LEDS_CCM2_STATUS_REG:
> +	case CRONOS_LEDS_CCM3_STATUS_REG:
> +	case CRONOS_LEDS_CCM4_STATUS_REG:
> +	case CRONOS_LEDS_CCM_POWER_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +
> +	case CRONOS_CPLD_STATUS_2_REG:
> +	case CRONOS_CPLD_UART_MUX_REG:
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +
> +	case CRONOS_CPLD_BMC_MAC_LOW_REG ... CRONOS_CPLD_BMC_MAC_HIGH_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool cronos_cpld_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case CRONOS_CPLD_REVISION_HIGH_REG:
> +	case CRONOS_CPLD_REVISION_LOW_REG:
> +
> +	case CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_SWITCH_RESET_CMD_REG:
> +	case CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG:
> +	case CRONOS_CPLD_PAYLOAD_POWER_CTL_REG:
> +
> +	case CRONOS_WDT_CTL_REG:
> +	case CRONOS_WDT_CLR_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static struct regmap_config cronos_cpld_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = CRONOS_CPLD_REVISION_HIGH_REG,
> +	.writeable_reg = cronos_cpld_is_writeable_reg,
> +	.readable_reg = cronos_cpld_is_readable_reg,
> +	.volatile_reg = cronos_cpld_is_volatile_reg,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.cache_type = REGCACHE_RBTREE,

This is being phased out for the Maple Tree.

> +};
> +
> +#ifdef CONFIG_OF

These are ugly and shouldn't be required.

> +static const struct of_device_id cronos_cpld_dt_ids[] = {
> +	{ .compatible = "sony,cronos-cpld", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cronos_cpld_dt_ids);
> +#endif
> +
> +static int sony_cronos_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct sony_cronos_cpld *chip;

Chip is wrong here.  This should be ddata.

> +	const struct of_device_id *match;
> +	const struct mfd_cell *cell;

Why do you need this?

> +	const struct regmap_config *config;
> +	int cell_num;
> +	int ret;
> +
> +	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	if (i2c->dev.of_node) {
> +		match = of_match_node(cronos_cpld_dt_ids, i2c->dev.of_node);

Why are you doing this?

> +		if (!match)
> +			return -EINVAL;
> +	}
> +
> +	i2c_set_clientdata(i2c, chip);

Do this *after* the struct has been populated.

> +	chip->dev = &i2c->dev;
> +
> +	cell = cronos_cpld_devs;
> +	cell_num = ARRAY_SIZE(cronos_cpld_devs);
> +	config = &cronos_cpld_regmap_config;

This is bananas.  Why the intermediary variables?

> +	chip->regmap = devm_regmap_init_i2c(i2c, config);
> +	if (IS_ERR(chip->regmap)) {
> +		ret = PTR_ERR(chip->regmap);
> +		dev_err(chip->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;

dev_err_probe()

> +	}
> +
> +	ret = sony_cronos_get_device_type(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,

Why not AUTO?

> +			      cell_num, NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(chip->dev, "Cannot register child devices\n");
> +		return ret;
> +	}
> +
> +	/* Add sysfs */

This doesn't add anything.

> +	ret = sysfs_create_group(&chip->dev->kobj, &cronos_cpld_attr_group);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to create sysfs entries\n");
> +
> +	return ret;
> +}
> +
> +static void sony_cronos_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct sony_cronos_cpld *chip = i2c_get_clientdata(i2c);
> +
> +	sysfs_remove_group(&chip->dev->kobj, &cronos_cpld_attr_group);
> +	mfd_remove_devices(chip->dev);

Use devm_* instead.

> +}
> +
> +static struct i2c_driver sony_cronos_i2c_driver = {
> +	.driver = {
> +		.name = "sony-cronos",

It's 'cpld' everywhere else.  Why the change of heart?

> +		.of_match_table = of_match_ptr(cronos_cpld_dt_ids),
> +	},
> +	.probe    = sony_cronos_i2c_probe,
> +	.remove   = sony_cronos_i2c_remove,
> +};
> +

Remove this line.

> +module_i2c_driver(sony_cronos_i2c_driver);
> +
> +MODULE_DESCRIPTION("Core device driver for sony Cronos CPLDs");

First mention of Core too.

"Sony"

> +MODULE_AUTHOR("Raptor Engineering, LLC <support@raptorengineering.com>");

Your 'support' department did not author this driver.

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/sony/cronos/core.h b/include/linux/mfd/sony/cronos/core.h
> new file mode 100644
> index 000000000000..6f80b90af5ca
> --- /dev/null
> +++ b/include/linux/mfd/sony/cronos/core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022  Raptor Engineering, LLC
> + */
> +
> +#ifndef __MFD_SONY_CRONOS_CORE_H__
> +#define __MFD_SONY_CRONOS_CORE_H__
> +
> +#include <linux/mfd/sony/cronos/registers.h>
> +
> +struct sony_cronos_cpld {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +#endif /* __MFD_SONY_CRONOS_H__ */
> diff --git a/include/linux/mfd/sony/cronos/registers.h b/include/linux/mfd/sony/cronos/registers.h
> new file mode 100644
> index 000000000000..2bcc3cf17fe5
> --- /dev/null
> +++ b/include/linux/mfd/sony/cronos/registers.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2015-2017  Dialog Semiconductor
> + * Copyright (C) 2022  Raptor Engineering, LLC
> + */
> +
> +#ifndef __SONY_CRONOS_H__
> +#define __SONY_CRONOS_H__
> +
> +#define CRONOS_CPLD_DEVICE_ID		0x0134
> +
> +/*
> + * Registers and control masks / values
> + */
> +
> +#define CRONOS_CPLD_REVISION_HIGH_REG			0x73
> +#define CRONOS_CPLD_REVISION_LOW_REG			0x72
> +#define CRONOS_CPLD_DEVICE_ID_HIGH_REG			0x71
> +#define CRONOS_CPLD_DEVICE_ID_LOW_REG			0x70
> +
> +#define CRONOS_CPLD_BRIGHTNESS_RED_REG			0x17
> +#define CRONOS_CPLD_BRIGHTNESS_GREEN_REG		0x18
> +#define CRONOS_CPLD_BRIGHTNESS_BLUE_REG			0x19
> +
> +#define CRONOS_CPLD_LEDS_BRIGHTNESS_SET_MASK		0x7F
> +#define CRONOS_LEDS_MAX_BRIGHTNESS			0x7F
> +
> +#define CRONOS_LEDS_SMC_STATUS_REG			0x10
> +#define CRONOS_LEDS_SWITCH_STATUS_REG			0x11
> +
> +#define CRONOS_LEDS_CCM1_STATUS_REG			0x15
> +#define CRONOS_LEDS_CCM2_STATUS_REG			0x13
> +#define CRONOS_LEDS_CCM3_STATUS_REG			0x12
> +#define CRONOS_LEDS_CCM4_STATUS_REG			0x14
> +
> +#define CRONOS_LEDS_CCM_POWER_REG			0x16
> +
> +#define CRONOS_CPLD_UART_MUX_REG			0x0e
> +#define CRONOS_CPLD_SWITCH_BOOT_FLASH_SELECT_REG	0x00
> +#define CRONOS_CPLD_SWITCH_RESET_CMD_REG		0x01
> +#define CRONOS_CPLD_BMC_BOOT_FLASH_SELECT_REG		0x02
> +#define CRONOS_CPLD_PAYLOAD_POWER_CTL_REG		0x0a
> +#define CRONOS_CPLD_BMC_MAC_LOW_REG			0x30
> +#define CRONOS_CPLD_BMC_MAC_HIGH_REG			0x35
> +
> +#define CRONOS_WDT_CLR_REG		0x03
> +#define CRONOS_WDT_CTL_REG		0x0c
> +
> +#define CRONOS_CPLD_STATUS_2_REG	0x05
> +
> +#define CRONOS_WDT_CLR_VAL		0xc3
> +#define CRONOS_WDT_ENABLE_MASK		0x80
> +#define CRONOS_WDT_ENABLE_VAL		0x80
> +#define CRONOS_WDT_DISABLE_VAL		0x00
> +#define CRONOS_WDT_TIMEOUT_MASK		0x07
> +#define CRONOS_WDT_CTL_RESET_VAL	0x00
> +
> +
> +#endif /* __SONY_CRONOS_H__ */
> --
> 2.30.2
> 

-- 
Lee Jones [李琼斯]
