Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91007AA0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjIUUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjIUUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:50:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEBEE5BA;
        Thu, 21 Sep 2023 11:46:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rrw0N4sL9z6J8vf;
        Thu, 21 Sep 2023 20:37:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 13:42:30 +0100
Date:   Thu, 21 Sep 2023 13:42:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Lechner <dlechner@baylibre.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
Message-ID: <20230921134229.00002d5b@Huawei.com>
In-Reply-To: <20230920170253.203395-5-dlechner@baylibre.com>
References: <20230920170253.203395-1-dlechner@baylibre.com>
        <20230920170253.203395-5-dlechner@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 12:02:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new driver for Analog Devices, Inc. AD2S1210 resolver to
> digital converter. The driver is based on the staging driver with the
> following improvements:
> 
> Fixes:
> - Fix use before initialization bug in probe.
> - Fix not checking error returns in probe.
> - Remove spi_setup() and spi_set_drvdata() from probe.
> - Fix ordering of devm_iio_device_register()
> - Remove incorrect hysteresis logic
> 
> Changes:
> - Use BIT/GENMASK macros.
> - Use devicetree to get CLKIN frequency (was sysfs attribute).
> - No longer bit-shift the raw value for IIO_CHAN_INFO_RAW.
> - Use regmap for register access.
> - Remove config sysfs attribute.
> - Use gpio array for mode and resolution gpios.
> - Invert sample gpio logic and use GPIO_ACTIVE_LOW in devicetree.
> - Change hysteresis to use IIO_CHAN_INFO_HYSTERESIS instead of custom
>   device attribute.
> - Rename fexcit attribute to excitation_frequency.
> - Use devicetree to specify resolution instead of sysfs attribute.
> 
> Additions:
> - Implement IIO_CHAN_INFO_SCALE.
> - Implement debugfs register access.
> - Add phase_lock_range attribute.
> - Add triggered buffer support.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

Great to see you are looking at this one.

The way I'd prefer to see a staging graduation is not to delete the old driver
and replace it with a more fully featured driver.

Fix it up in staging then propose a move as a git mv
but format the patch with move detection disabled so that we can see
the whole code in that graduation patch.

Move the minimum first that complies with the IIO ABI and is fairly clean
then add features, possibly as a follow up patch set.

There may be existing users of this driver and they want to see the
gradual steps and chose whether to backport them all or not.

Jonathan


> ---
>  .../testing/sysfs-bus-iio-resolver-ad2s1210   | 109 ++
>  drivers/iio/resolver/Kconfig                  |  13 +
>  drivers/iio/resolver/Makefile                 |   1 +
>  drivers/iio/resolver/ad2s1210.c               | 948 ++++++++++++++++++
>  4 files changed, 1071 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
>  create mode 100644 drivers/iio/resolver/ad2s1210.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210 b/Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
> new file mode 100644
> index 000000000000..32890c85168e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
> @@ -0,0 +1,109 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_mis_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Mismatch
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_ovr_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Overrange
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_max_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Maximum
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_min_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Minimum
> +		Threshold value. Writing sets the value. Valid values are 0 (0V)
> +		to 127 (4.826V). To convert the value to volts, multiply by
> +		0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fault
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a hex value containing the fault bit flags.
> +
> +		Bit	Description
> +		---	-----------
> +		D7	Sine/cosine inputs clipped
> +		D6	Sine/cosine inputs below LOS threshold
> +		D5	Sine/cosine inputs exceed DOS overrange threshold
> +		D4	Sine/cosine inputs exceed DOS mismatch threshold
> +		D3	Tracking error exceeds LOT threshold
> +		D2	Velocity exceeds maximum tracking rate
> +		D1	Phase error exceeds phase lock range
> +		D0	Configuration parity error
> +
> +		Writing any value will clear any fault conditions.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/excitation_frequency
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Excitation Frequency in Hz. Writing
> +		sets the Excitation Frequency and performs a software reset on
> +		the device to apply the change. Valid values are 2000 (2kHz) to
> +		20000 (20kHz).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/los_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Signal Reset Threshold
> +		value. Writing sets the value. Valid values are 0 (0V) to
> +		127 (4.826V). To convert the value to volts, multiply by 0.038.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/lot_high_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Position Tracking Detection
> +		High Threshold value. Writing sets the value. Valid values are
> +		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
> +		depends on the selected resolution. To convert the value to
> +		degrees, multiply by 0.35 for 10-bit resolution, multiply by
> +		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
> +		resolution.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/lot_low_thrd
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Loss of Position Tracking Detection
> +		Low Threshold value. Writing sets the value. Valid values are
> +		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
> +		depends on the selected resolution. To convert the value to
> +		degrees, multiply by 0.35 for 10-bit resolution, multiply by
> +		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
> +		resolution.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Phase lock range in degrees. Writing
> +		sets the value in the configuration register.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range_available
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the possible values for the phase_lock_range
> +		attribute, namely 44 and 360.
> diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
> index 47dbfead9b31..424529d36080 100644
> --- a/drivers/iio/resolver/Kconfig
> +++ b/drivers/iio/resolver/Kconfig
> @@ -25,4 +25,17 @@ config AD2S1200
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad2s1200.
> +
> +config AD2S1210
> +	tristate "Analog Devices ad2s1210 driver"
> +	depends on SPI
> +	depends on COMMON_CLK
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  Say yes here to build support for Analog Devices spi resolver
> +	  to digital converters, ad2s1210, provides direct access via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad2s1210.
> +
>  endmenu
> diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
> index fa558138ce45..7f6c876c35ae 100644
> --- a/drivers/iio/resolver/Makefile
> +++ b/drivers/iio/resolver/Makefile
> @@ -5,3 +5,4 @@
>  
>  obj-$(CONFIG_AD2S90) += ad2s90.o
>  obj-$(CONFIG_AD2S1200) += ad2s1200.o
> +obj-$(CONFIG_AD2S1210) += ad2s1210.o
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> new file mode 100644
> index 000000000000..97833fbcbf7a
> --- /dev/null
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -0,0 +1,948 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
> + *
> + * Copyright (c) 2010-2010 Analog Devices Inc.
> + * Copyright (C) 2023 BayLibre, SAS
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define DRV_NAME "ad2s1210"
> +
> +/* default value of control register on powerup */
> +#define AD2S1210_DEF_CONTROL		0x7E
> +
> +/* control register flags */
> +#define AD2S1210_ADDRESS_DATA		BIT(7)
> +#define AD2S1210_PHASE_LOCK_RANGE_44	BIT(5)
> +#define AD2S1210_ENABLE_HYSTERESIS	BIT(4)
> +#define AD2S1210_SET_ENRES		GENMASK(3, 2)
> +#define AD2S1210_SET_RES		GENMASK(1, 0)
> +
> +#define AD2S1210_REG_POSITION_MSB	0x80
> +#define AD2S1210_REG_POSITION_LSB	0x81
> +#define AD2S1210_REG_VELOCITY_MSB	0x82
> +#define AD2S1210_REG_VELOCITY_LSB	0x83
> +#define AD2S1210_REG_LOS_THRD		0x88
> +#define AD2S1210_REG_DOS_OVR_THRD	0x89
> +#define AD2S1210_REG_DOS_MIS_THRD	0x8A
> +#define AD2S1210_REG_DOS_RST_MAX_THRD	0x8B
> +#define AD2S1210_REG_DOS_RST_MIN_THRD	0x8C
> +#define AD2S1210_REG_LOT_HIGH_THRD	0x8D
> +#define AD2S1210_REG_LOT_LOW_THRD	0x8E
> +#define AD2S1210_REG_EXCIT_FREQ		0x91
> +#define AD2S1210_REG_CONTROL		0x92
> +#define AD2S1210_REG_SOFT_RESET		0xF0
> +#define AD2S1210_REG_FAULT		0xFF
> +
> +#define AD2S1210_MIN_CLKIN	6144000
> +#define AD2S1210_MAX_CLKIN	10240000
> +#define AD2S1210_MIN_EXCIT	2000
> +#define AD2S1210_DEF_EXCIT	10000
> +#define AD2S1210_MAX_EXCIT	20000
> +#define AD2S1210_MIN_FCW	0x4
> +#define AD2S1210_MAX_FCW	0x50
> +
> +enum ad2s1210_mode {
> +	AD2S1210_MODE_POS = 0b00,
> +	AD2S1210_MODE_VEL = 0b01,
> +	AD2S1210_MODE_CONFIG = 0b11,
> +};
> +
> +enum ad2s1210_resolution {
> +	AD2S1210_RES_10 = 0b00,
> +	AD2S1210_RES_12 = 0b01,
> +	AD2S1210_RES_14 = 0b10,
> +	AD2S1210_RES_16 = 0b11,
> +};
> +
> +struct ad2s1210_state {
> +	struct mutex lock;
> +	struct spi_device *sdev;
> +	/** GPIO pin connected to SAMPLE line. */
> +	struct gpio_desc *sample_gpio;
> +	/** GPIO pins connected to A0 and A1 lines. */
> +	struct gpio_descs *mode_gpios;
> +	/** Used to access config registers. */
> +	struct regmap *regmap;
> +	/** The external oscillator frequency in Hz. */
> +	unsigned long fclkin;
> +	/** The selected resolution */
> +	enum ad2s1210_resolution resolution;
> +	/* Scan buffer */
> +	struct {
> +		__be16 chan[2];
> +		/* Ensure timestamp is naturally aligned. */
> +		s64 timestamp __aligned(8);
> +	} scan;
> +	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
> +	u8 tx[2];
> +};
> +
> +static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
> +{
> +	struct gpio_descs *gpios = st->mode_gpios;
> +	DECLARE_BITMAP(bitmap, 2);
> +
> +	bitmap[0] = mode;
> +
> +	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
> +				     bitmap);
> +}
> +
> +/**
> + * Writes the given data to the given register address.
> + *
> + * If the mode is configurable, the device will first be placed in
> + * configuration mode.
> + */
> +static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
> +				     unsigned int val)
> +{
> +	struct ad2s1210_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.len = 1,
> +			.rx_buf = &st->rx[0],
> +			.tx_buf = &st->tx[0],
> +			.cs_change = 1,
> +		}, {
> +			.len = 1,
> +			.rx_buf = &st->rx[1],
> +			.tx_buf = &st->tx[1],
> +		},
> +	};
> +	int ret;
> +
> +	/* values can only be 7 bits, the MSB indicates an address */
> +	if (val & ~0x7F)
> +		return -EINVAL;
> +
> +	st->tx[0] = reg;
> +	st->tx[1] = val;
> +
> +	ret = ad2s1210_set_mode(st, AD2S1210_MODE_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
> +}
> +
> +/**
> + * Reads value from one of the registers.
> + *
> + * If the mode is configurable, the device will first be placed in
> + * configuration mode.
> + */
> +static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
> +				    unsigned int *val)
> +{
> +	struct ad2s1210_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.len = 1,
> +			.rx_buf = &st->rx[0],
> +			.tx_buf = &st->tx[0],
> +			.cs_change = 1,
> +		}, {
> +			.len = 1,
> +			.rx_buf = &st->rx[1],
> +			.tx_buf = &st->tx[1],
> +		},
> +	};
> +	int ret;
> +
> +	ret = ad2s1210_set_mode(st, AD2S1210_MODE_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->tx[0] = reg;
> +	/* Must be valid register address here otherwise this could write data.
> +	 * It doesn't matter which one.
> +	 */
> +	st->tx[1] = AD2S1210_REG_FAULT;
> +
> +	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* If the D7 bit is set on any read/write register, it indicates a
> +	 * parity error. The fault register is read-only and the D7 bit means
> +	 * something else there.
> +	 */
> +	if (reg != AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
> +		return -EBADMSG;
> +
> +	*val = st->rx[1];
> +
> +	return 0;
> +}
> +
> +/**
> + * Sets the excitation frequency and performs software reset.
> + *
> + * Must be called with lock held.
> + */
> +static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
> +					     u16 fexcit)
> +{
> +	int ret;
> +	u8 fcw;
> +
> +	fcw = fexcit * (1 << 15) / st->fclkin;
> +	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW)
> +		return -ERANGE;
> +
> +	ret = regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* software reset reinitializes the excitation frequency output */
> +	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
> +}
> +
> +static ssize_t excitation_frequency_show(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int value;
> +	u16 fexcit;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &value);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	fexcit = value * st->fclkin / (1 << 15);
> +
> +	ret = sysfs_emit(buf, "%u\n", fexcit);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static ssize_t excitation_frequency_store(struct device *dev,
> +						   struct device_attribute *attr,
> +						   const char *buf, size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	u16 fexcit;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 10, &fexcit);
> +	if (ret < 0 || fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = ad2s1210_set_excitation_frequency(st, fexcit);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = len;
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t phase_lock_range_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +			       AD2S1210_PHASE_LOCK_RANGE_44);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = sysfs_emit(buf, "%d\n", ret ? 44 : 360);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static ssize_t phase_lock_range_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	u16 udata;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 10, &udata);
> +	if (ret < 0 || (udata != 44 && udata != 360))
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +				 AD2S1210_PHASE_LOCK_RANGE_44,
> +				 udata == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = len;
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static ssize_t phase_lock_range_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	return sysfs_emit(buf, "44 360\n");
> +}
> +
> +/* read the fault register since last sample */
> +static ssize_t fault_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int value;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
> +	mutex_unlock(&st->lock);
> +
> +	return ret < 0 ? ret : sysfs_emit(buf, "0x%02x\n", value);
> +}
> +
> +static ssize_t fault_store(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf,
> +			   size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int value;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	gpiod_set_value(st->sample_gpio, 1);
> +	/* delay (2 * tck + 20) nano seconds */
> +	udelay(1);
> +	gpiod_set_value(st->sample_gpio, 0);
> +
> +	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	gpiod_set_value(st->sample_gpio, 1);
> +	gpiod_set_value(st->sample_gpio, 0);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static ssize_t reg_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	unsigned int value;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, iattr->address, &value);
> +	mutex_unlock(&st->lock);
> +
> +	return ret < 0 ? ret : sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t reg_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned char data;
> +	int ret;
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +
> +	ret = kstrtou8(buf, 10, &data);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_write(st->regmap, iattr->address, data);
> +	mutex_unlock(&st->lock);
> +	return ret < 0 ? ret : len;
> +}
> +
> +static const int ad2s1210_velocity_scale[] = {
> +	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
> +	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
> +	85445659, /* 8.192MHz / (2*pi * 500 / 2^15) */
> +	341782638, /* 8.192MHz / (2*pi * 125 / 2^15) */
> +};
> +
> +static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val,
> +			     int *val2,
> +			     long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		gpiod_set_value(st->sample_gpio, 1);
> +		/* delay (6 * tck + 20) nano seconds */
> +		udelay(1);
> +
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			ret = ad2s1210_set_mode(st, AD2S1210_MODE_POS);
> +			break;
> +		case IIO_ANGL_VEL:
> +			ret = ad2s1210_set_mode(st, AD2S1210_MODE_VEL);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		if (ret < 0)
> +			goto error_info_raw;
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0)
> +			goto error_info_raw;
> +
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*val = be16_to_cpup((__be16 *)st->rx);
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_ANGL_VEL:
> +			*val = (s16)be16_to_cpup((__be16 *)st->rx);
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +error_info_raw:
> +		gpiod_set_value(st->sample_gpio, 0);
> +		/* delay (2 * tck + 20) nano seconds */
> +		udelay(1);
> +		mutex_unlock(&st->lock);
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			/* approx 0.3 arc min converted to radians */
> +			*val = 0;
> +			*val2 = 95874;
> +			ret = IIO_VAL_INT_PLUS_NANO;
> +			break;
> +		case IIO_ANGL_VEL:
> +			*val = st->fclkin;
> +			*val2 = ad2s1210_velocity_scale[st->resolution];
> +			ret = IIO_VAL_FRACTIONAL;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			mutex_lock(&st->lock);
> +			ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +					       AD2S1210_ENABLE_HYSTERESIS);
> +			if (ret < 0)
> +				goto error_info_hysteresis;
> +
> +			*val = !!ret;
> +			ret = IIO_VAL_INT;
> +
> +error_info_hysteresis:
> +			mutex_unlock(&st->lock);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad2s1210_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type,
> +			       int *length, long mask)
> +{
> +	static const int available[] = { 0, 1 };
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*vals = available;
> +			*type = IIO_VAL_INT;
> +			*length = ARRAY_SIZE(available);
> +			ret = IIO_AVAIL_LIST;
> +			break;
> +		default:
> +			break;
> +		}
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad2s1210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			mutex_lock(&st->lock);
> +			ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +						 AD2S1210_ENABLE_HYSTERESIS,
> +						 val ? AD2S1210_ENABLE_HYSTERESIS
> +						     : 0);
> +			mutex_unlock(&st->lock);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
> +static IIO_DEVICE_ATTR_RW(phase_lock_range, 0);
> +static IIO_DEVICE_ATTR_RO(phase_lock_range_available, 0);
> +static IIO_DEVICE_ATTR_RW(fault, 0);
> +static IIO_DEVICE_ATTR_NAMED_RW(los_thrd, reg, AD2S1210_REG_LOS_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(dos_ovr_thrd, reg, AD2S1210_REG_DOS_OVR_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(dos_mis_thrd, reg, AD2S1210_REG_DOS_MIS_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(dos_rst_max_thrd, reg,
> +				AD2S1210_REG_DOS_RST_MAX_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(dos_rst_min_thrd, reg,
> +				AD2S1210_REG_DOS_RST_MIN_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(lot_high_thrd, reg, AD2S1210_REG_LOT_HIGH_THRD);
> +static IIO_DEVICE_ATTR_NAMED_RW(lot_low_thrd, reg, AD2S1210_REG_LOT_LOW_THRD);
> +
> +static const struct iio_chan_spec ad2s1210_channels[] = {
> +	{
> +		.type = IIO_ANGL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.info_mask_separate_available =
> +					BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.datasheet_name = "position",
> +	}, {
> +		.type = IIO_ANGL_VEL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.datasheet_name = "velocity",
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static struct attribute *ad2s1210_attributes[] = {
> +	&iio_dev_attr_excitation_frequency.dev_attr.attr,
> +	&iio_dev_attr_phase_lock_range.dev_attr.attr,
> +	&iio_dev_attr_phase_lock_range_available.dev_attr.attr,
> +	&iio_dev_attr_fault.dev_attr.attr,
> +	&iio_dev_attr_los_thrd.dev_attr.attr,
> +	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
> +	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
> +	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
> +	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
> +	&iio_dev_attr_lot_high_thrd.dev_attr.attr,
> +	&iio_dev_attr_lot_low_thrd.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad2s1210_attribute_group = {
> +	.attrs = ad2s1210_attributes,
> +};
> +
> +static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
> +				       unsigned int reg, unsigned int writeval,
> +				       unsigned int *readval)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	size_t chan = 0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	memset(&st->scan, 0, sizeof(st->scan));
> +	gpiod_set_value(st->sample_gpio, 1);
> +
> +	if (test_bit(0, indio_dev->active_scan_mask)) {
> +		ret = ad2s1210_set_mode(st, AD2S1210_MODE_POS);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		/* REVIST: we can read 3 bytes here and also get fault flags */
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +	}
> +
> +	if (test_bit(1, indio_dev->active_scan_mask)) {
> +		ret = ad2s1210_set_mode(st, AD2S1210_MODE_VEL);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		/* REVIST: we can read 3 bytes here and also get fault flags */
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
> +
> +error_ret:
> +	gpiod_set_value(st->sample_gpio, 0);
> +	mutex_unlock(&st->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad2s1210_info = {
> +	.read_raw = ad2s1210_read_raw,
> +	.read_avail = ad2s1210_read_avail,
> +	.write_raw = ad2s1210_write_raw,
> +	.attrs = &ad2s1210_attribute_group,
> +	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
> +};
> +
> +static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"failed to read assigned-resolution-bits property\n");
> +
> +	if (val < 10 || val > 16)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "resolution out of range: %u\n", val);
> +
> +	st->resolution = (val - 10) >> 1;
> +
> +	return 0;
> +}
> +
> +static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	struct clk *clk;
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	st->fclkin = clk_get_rate(clk);
> +	if (st->fclkin < AD2S1210_MIN_CLKIN || st->fclkin > AD2S1210_MAX_CLKIN)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "clock frequency out of range: %lu\n",
> +				     st->fclkin);
> +
> +	return 0;
> +}
> +
> +static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	struct gpio_descs *resolution_gpios;
> +	DECLARE_BITMAP(bitmap, 2);
> +	int ret;
> +
> +	/* should not be sampling on startup */
> +	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sample_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->sample_gpio),
> +				     "failed to request sample GPIO\n");
> +
> +	/* both pins high means that we start in config mode */
> +	st->mode_gpios = devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->mode_gpios))
> +		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
> +				     "failed to request mode GPIOs\n");
> +
> +	if (st->mode_gpios->ndescs != 2)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "requires exactly 2 mode-gpios\n");
> +
> +	/* If resolution gpios are provided, they get set to the required
> +	 * resolution, otherwise it is assumed the RES0 and RES1 pins are
> +	 * hard-wired to match the resolution indicated in the devicetree.
> +	 */
> +	resolution_gpios = devm_gpiod_get_array_optional(dev, "resolution",
> +							 GPIOD_ASIS);
> +	if (IS_ERR(resolution_gpios))
> +		return dev_err_probe(dev, PTR_ERR(resolution_gpios),
> +				     "failed to request resolution GPIOs\n");
> +
> +	if (resolution_gpios) {
> +		if (resolution_gpios->ndescs != 2)
> +			return dev_err_probe(dev, -EINVAL,
> +				      "requires exactly 2 resolution-gpios\n");
> +
> +		bitmap[0] = st->resolution;
> +
> +		ret = gpiod_set_array_value(resolution_gpios->ndescs,
> +					    resolution_gpios->desc,
> +					    resolution_gpios->info,
> +					    bitmap);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to set resolution gpios\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_range ad2s1210_regmap_readable_ranges[] = {
> +	regmap_reg_range(AD2S1210_REG_POSITION_MSB, AD2S1210_REG_VELOCITY_LSB),
> +	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
> +	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
> +	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
> +};
> +
> +static const struct regmap_access_table ad2s1210_regmap_rd_table = {
> +	.yes_ranges = ad2s1210_regmap_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_readable_ranges),
> +};
> +
> +static const struct regmap_range ad2s1210_regmap_writeable_ranges[] = {
> +	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
> +	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
> +	regmap_reg_range(AD2S1210_REG_SOFT_RESET, AD2S1210_REG_SOFT_RESET),
> +	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
> +};
> +
> +static const struct regmap_access_table ad2s1210_regmap_wr_table = {
> +	.yes_ranges = ad2s1210_regmap_writeable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_writeable_ranges),
> +};
> +
> +static int ad2s1210_setup_regmap(struct ad2s1210_state *st)
> +{
> +	struct device *dev = &st->sdev->dev;
> +	const struct regmap_config config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.disable_locking = true,
> +		.reg_read = ad2s1210_regmap_reg_read,
> +		.reg_write = ad2s1210_regmap_reg_write,
> +		.rd_table = &ad2s1210_regmap_rd_table,
> +		.wr_table = &ad2s1210_regmap_wr_table,
> +		.can_sleep = true,
> +	};
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "failed to allocate register map\n");
> +
> +	return 0;
> +}
> +
> +static int ad2s1210_init(struct ad2s1210_state *st)
> +{
> +	unsigned char data;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;
> +	data |= st->resolution;
> +
> +	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = ad2s1210_set_excitation_frequency(st, AD2S1210_DEF_EXCIT);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int ad2s1210_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad2s1210_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	mutex_init(&st->lock);
> +	st->sdev = spi;
> +
> +	ret = ad2s1210_setup_properties(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_setup_clocks(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_setup_gpios(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_setup_regmap(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_init(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->info = &ad2s1210_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad2s1210_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad2s1210_trigger_handler, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad2s1210_of_match[] = {
> +	{ .compatible = "adi,ad2s1210", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
> +
> +static const struct spi_device_id ad2s1210_id[] = {
> +	{ "ad2s1210" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad2s1210_id);
> +
> +static struct spi_driver ad2s1210_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = ad2s1210_of_match,
> +	},
> +	.probe = ad2s1210_probe,
> +	.id_table = ad2s1210_id,
> +};
> +module_spi_driver(ad2s1210_driver);
> +
> +MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices AD2S1210 Resolver to Digital SPI driver");
> +MODULE_LICENSE("GPL v2");

