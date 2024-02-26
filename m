Return-Path: <linux-kernel+bounces-81041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F69866F58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60551C252E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1650A64;
	Mon, 26 Feb 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUpy4yLz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D67208A7;
	Mon, 26 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939410; cv=none; b=OX4ZCM+/bsEBR33ci57UbbdFhlvVsWG2K01+3KUDS/jFCX8XhVd99/P7hGSoRvS6VdbQP0XTDKxkkDCkF8s+C4j/mPgaBA+pmlJ5iZckaJO9VyZzELpnjapSy3R1llPvD/g+lzpfYJLqer2MFeRolTZrXopo8XfZWlXfpHz8nIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939410; c=relaxed/simple;
	bh=6Vlzu1oz2IE5YB6bOBK0775lxvhjEfx6TBMZ+Yf9uSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLkVp4gMhljOY48MSzWHK6FUp7Gh8N1O9w8ax//WqrGUI7TSH3FZzUqOPyKGup8LI49XVEyP+wx82C/UgrcEvCPksr60WDWm6vkjh3rB5aWQUVsOujdKYOBmsq+lfIAsbdeqQa9GDJs28LtzZ8JCwWRq5bjzzGZyekwMNF7rmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUpy4yLz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708939409; x=1740475409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Vlzu1oz2IE5YB6bOBK0775lxvhjEfx6TBMZ+Yf9uSQ=;
  b=KUpy4yLznS2sXhYZzdS0f/9eAmO4GRqT1gtrjVBf/V5AGqYARN2YQ+Ax
   3DbqFBrh51neNWNpmQxy4F3erokudfg+TE0/YbRxLrDBulc6Eyvfoz2g0
   3Zupi46XFIZWHqx4yq7MCmQM3fVc/smOcYkeLP3W0G3sjl19VM4Do/g6v
   mguvuvNldtyJ7svRSoCVCAPZpLtfOXHu9uaocOX0ACuFue8rLbsVeUTAA
   7Cm5++ALO4jiCIQYeVB7dTS3ZRPVrU1AE1bwNHFNJ+ZjgABgWiJuSsAYw
   OYO8lBviJ6wdW94SJy50m0KGvxec2ngqXD8Btq8qhgOfTvahF8FLmdBAJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3054252"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3054252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11249937"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 26 Feb 2024 01:23:24 -0800
Date: Mon, 26 Feb 2024 17:19:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] fpga: xilinx-spi: extract a common driver core
Message-ID: <ZdxXmof7r7JHahbM@yilunxu-OptiPlex-7050>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-2-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221195058.1281973-2-charles.perry@savoirfairelinux.com>

On Wed, Feb 21, 2024 at 02:50:47PM -0500, Charles Perry wrote:
> Factor out the gpio handshaking (using PROGRAM_B, INIT_B and DONE)
> protocol in xilinx-core so that it can be reused for another driver.
> This commit does not change anything functionally to xilinx-spi.
> 
> xilinx-core expects drivers to provide a single operation:
> 
>  * ->write(const char* buf, size_t count): write to the device
> 
> As well as a struct device* for resource management.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  drivers/fpga/Kconfig       |   4 +
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/xilinx-core.c | 208 ++++++++++++++++++++++++++++++++++++
>  drivers/fpga/xilinx-core.h |  28 +++++
>  drivers/fpga/xilinx-spi.c  | 212 +++----------------------------------
>  5 files changed, 254 insertions(+), 199 deletions(-)
>  create mode 100644 drivers/fpga/xilinx-core.c
>  create mode 100644 drivers/fpga/xilinx-core.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 2f689ac4ba3a3..d27a1ebf40838 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -64,9 +64,13 @@ config FPGA_MGR_STRATIX10_SOC
>  	help
>  	  FPGA manager driver support for the Intel Stratix10 SoC.
>  
> +config FPGA_MGR_XILINX_CORE
> +	tristate
> +
>  config FPGA_MGR_XILINX_SPI
>  	tristate "Xilinx Configuration over Slave Serial (SPI)"
>  	depends on SPI
> +	select FPGA_MGR_XILINX_CORE
>  	help
>  	  FPGA manager driver support for Xilinx FPGA configuration
>  	  over slave serial interface.
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 352a2612623e0..7ec795b6a5a70 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
> +obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
> new file mode 100644
> index 0000000000000..597e8b7a530b7
> --- /dev/null
> +++ b/drivers/fpga/xilinx-core.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Common parts of the Xilinx Spartan6 and 7 Series FPGA manager drivers.
> + *
> + * Copyright (C) 2017 DENX Software Engineering
> + *
> + * Anatolij Gustschin <agust@denx.de>
> + */
> +
> +#include "xilinx-core.h"
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +
> +static int get_done_gpio(struct fpga_manager *mgr)
> +{
> +	struct xilinx_fpga_core *core = mgr->priv;
> +	int ret;
> +
> +	ret = gpiod_get_value(core->done);
> +	if (ret < 0)
> +		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static enum fpga_mgr_states xilinx_core_state(struct fpga_manager *mgr)
> +{
> +	if (!get_done_gpio(mgr))
> +		return FPGA_MGR_STATE_RESET;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +/**
> + * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
> + * a given delay if the pin is unavailable
> + *
> + * @mgr:        The FPGA manager object
> + * @value:      Value INIT_B to wait for (1 = asserted = low)
> + * @alt_udelay: Delay to wait if the INIT_B GPIO is not available
> + *
> + * Returns 0 when the INIT_B GPIO reached the given state or -ETIMEDOUT if
> + * too much time passed waiting for that. If no INIT_B GPIO is available
> + * then always return 0.
> + */
> +static int wait_for_init_b(struct fpga_manager *mgr, int value,
> +			   unsigned long alt_udelay)
> +{
> +	struct xilinx_fpga_core *core = mgr->priv;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +
> +	if (core->init_b) {
> +		while (time_before(jiffies, timeout)) {
> +			int ret = gpiod_get_value(core->init_b);
> +
> +			if (ret == value)
> +				return 0;
> +
> +			if (ret < 0) {
> +				dev_err(&mgr->dev,
> +					"Error reading INIT_B (%d)\n", ret);
> +				return ret;
> +			}
> +
> +			usleep_range(100, 400);
> +		}
> +
> +		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
> +			value ? "assert" : "deassert");
> +		return -ETIMEDOUT;
> +	}
> +
> +	udelay(alt_udelay);
> +
> +	return 0;
> +}
> +
> +static int xilinx_core_write_init(struct fpga_manager *mgr,
> +				  struct fpga_image_info *info, const char *buf,
> +				  size_t count)
> +{
> +	struct xilinx_fpga_core *core = mgr->priv;
> +	int err;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	gpiod_set_value(core->prog_b, 1);
> +
> +	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
> +	if (err) {
> +		gpiod_set_value(core->prog_b, 0);
> +		return err;
> +	}
> +
> +	gpiod_set_value(core->prog_b, 0);
> +
> +	err = wait_for_init_b(mgr, 0, 0);
> +	if (err)
> +		return err;
> +
> +	if (get_done_gpio(mgr)) {
> +		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
> +		return -EIO;
> +	}
> +
> +	/* program latency */
> +	usleep_range(7500, 7600);
> +	return 0;
> +}
> +
> +static int xilinx_core_write(struct fpga_manager *mgr, const char *buf,
> +			     size_t count)
> +{
> +	struct xilinx_fpga_core *core = mgr->priv;
> +
> +	return core->write(core, buf, count);
> +}
> +
> +static int xilinx_core_write_complete(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info)
> +{
> +	struct xilinx_fpga_core *core = mgr->priv;
> +	unsigned long timeout =
> +		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> +	bool expired = false;
> +	int done;
> +	int ret;
> +	const char padding[1] = { 0xff };
> +
> +	/*
> +	 * This loop is carefully written such that if the driver is
> +	 * scheduled out for more than 'timeout', we still check for DONE
> +	 * before giving up and we apply 8 extra CCLK cycles in all cases.
> +	 */
> +	while (!expired) {
> +		expired = time_after(jiffies, timeout);
> +
> +		done = get_done_gpio(mgr);
> +		if (done < 0)
> +			return done;
> +
> +		ret = core->write(core, padding, 1);
                                                 ^

sizeof(padding), Use as less immediate numbers as possible.

> +		if (ret)
> +			return ret;
> +
> +		if (done)
> +			return 0;
> +	}
> +
> +	if (core->init_b) {
> +		ret = gpiod_get_value(core->init_b);
> +
> +		if (ret < 0) {
> +			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
> +			return ret;
> +		}
> +
> +		dev_err(&mgr->dev,
> +			ret ? "CRC error or invalid device\n" :
> +			      "Missing sync word or incomplete bitstream\n");
> +	} else {
> +		dev_err(&mgr->dev, "Timeout after config data transfer\n");
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static const struct fpga_manager_ops xilinx_core_ops = {
> +	.state = xilinx_core_state,
> +	.write_init = xilinx_core_write_init,
> +	.write = xilinx_core_write,
> +	.write_complete = xilinx_core_write_complete,
> +};
> +
> +int xilinx_core_probe(struct xilinx_fpga_core *core)
> +{
> +	struct fpga_manager *mgr;
> +
> +	if (!core || !core->dev || !core->write)
> +		return -EINVAL;
> +
> +	/* PROGRAM_B is active low */
> +	core->prog_b = devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
> +	if (IS_ERR(core->prog_b))
> +		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
> +				     "Failed to get PROGRAM_B gpio\n");
> +
> +	core->init_b = devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN);
> +	if (IS_ERR(core->init_b))
> +		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
> +				     "Failed to get INIT_B gpio\n");
> +
> +	core->done = devm_gpiod_get(core->dev, "done", GPIOD_IN);
> +	if (IS_ERR(core->done))
> +		return dev_err_probe(core->dev, PTR_ERR(core->done),
> +				     "Failed to get DONE gpio\n");
> +
> +	mgr = devm_fpga_mgr_register(core->dev,
> +				     "Xilinx Slave Serial FPGA Manager",
> +				     &xilinx_core_ops, core);
> +	return PTR_ERR_OR_ZERO(mgr);
> +}

EXPORT_SYMBOL_GPL() is needed? Have you ever built them as modules?
Try to follow Documentation/process/submit-checklist.rst as much as you can.


And MODULE_LICENSE() & MODULE_DESCRIPTION() please.

> diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
> new file mode 100644
> index 0000000000000..bea190287b403
> --- /dev/null
> +++ b/drivers/fpga/xilinx-core.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __XILINX_CORE_H
> +#define __XILINX_CORE_H
> +
> +#include <linux/device.h>
> +
> +/**
> + * struct xilinx_fpga_core - interface between the driver and the core manager
> + *                           of Xilinx 7 Series FPGA manager
> + * @dev:       device node, must be set by the driver
> + * @write:     write callback of the driver, must be set by the driver
> + * @prog_b:    PROGRAM_B gpio, handled by the core manager
> + * @init_b:    INIT_B gpio, handled by the core manager
> + * @done:      DONE gpio, handled by the core manager

Internal fields are not listed in the generated output documentation.

> + */
> +struct xilinx_fpga_core {
> +	struct device *dev;
> +	int (*write)(struct xilinx_fpga_core *core, const char *buf,
> +		     size_t count);
> +	struct gpio_desc *prog_b;
> +	struct gpio_desc *init_b;
> +	struct gpio_desc *done;

Use private tag here.

Please follow Documentation/doc-guide/kernel-doc.rst

> +};
> +
> +int xilinx_core_probe(struct xilinx_fpga_core *core);
> +
> +#endif /* __XILINX_CORE_H */
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index e1a227e7ff2ae..12f401502a53a 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -10,127 +10,24 @@
>   * the slave serial configuration interface.
>   */
>  
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/fpga/fpga-mgr.h>
> -#include <linux/gpio/consumer.h>
> +#include "xilinx-core.h"
> +
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of.h>
>  #include <linux/spi/spi.h>
> -#include <linux/sizes.h>
>  
>  struct xilinx_spi_conf {
> +	struct xilinx_fpga_core core;
>  	struct spi_device *spi;
> -	struct gpio_desc *prog_b;
> -	struct gpio_desc *init_b;
> -	struct gpio_desc *done;
>  };
>  
> -static int get_done_gpio(struct fpga_manager *mgr)
> -{
> -	struct xilinx_spi_conf *conf = mgr->priv;
> -	int ret;
> -
> -	ret = gpiod_get_value(conf->done);
> -
> -	if (ret < 0)
> -		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
> -
> -	return ret;
> -}
> -
> -static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
> -{
> -	if (!get_done_gpio(mgr))
> -		return FPGA_MGR_STATE_RESET;
> -
> -	return FPGA_MGR_STATE_UNKNOWN;
> -}
> -
> -/**
> - * wait_for_init_b - wait for the INIT_B pin to have a given state, or wait
> - * a given delay if the pin is unavailable
> - *
> - * @mgr:        The FPGA manager object
> - * @value:      Value INIT_B to wait for (1 = asserted = low)
> - * @alt_udelay: Delay to wait if the INIT_B GPIO is not available
> - *
> - * Returns 0 when the INIT_B GPIO reached the given state or -ETIMEDOUT if
> - * too much time passed waiting for that. If no INIT_B GPIO is available
> - * then always return 0.
> - */
> -static int wait_for_init_b(struct fpga_manager *mgr, int value,
> -			   unsigned long alt_udelay)
> -{
> -	struct xilinx_spi_conf *conf = mgr->priv;
> -	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> -
> -	if (conf->init_b) {
> -		while (time_before(jiffies, timeout)) {
> -			int ret = gpiod_get_value(conf->init_b);
> -
> -			if (ret == value)
> -				return 0;
> -
> -			if (ret < 0) {
> -				dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
> -				return ret;
> -			}
> -
> -			usleep_range(100, 400);
> -		}
> -
> -		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
> -			value ? "assert" : "deassert");
> -		return -ETIMEDOUT;
> -	}
> -
> -	udelay(alt_udelay);
> -
> -	return 0;
> -}
> -
> -static int xilinx_spi_write_init(struct fpga_manager *mgr,
> -				 struct fpga_image_info *info,
> -				 const char *buf, size_t count)
> -{
> -	struct xilinx_spi_conf *conf = mgr->priv;
> -	int err;
> -
> -	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> -		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> -		return -EINVAL;
> -	}
> -
> -	gpiod_set_value(conf->prog_b, 1);
> -
> -	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
> -	if (err) {
> -		gpiod_set_value(conf->prog_b, 0);
> -		return err;
> -	}
> -
> -	gpiod_set_value(conf->prog_b, 0);
> +#define to_xilinx_spi_conf(obj) container_of(obj, struct xilinx_spi_conf, core)

Use to_spi_device(), then no need the MACRO or struct xilinx_spi_conf

Thanks,
Yilun

>  
> -	err = wait_for_init_b(mgr, 0, 0);
> -	if (err)
> -		return err;
> -
> -	if (get_done_gpio(mgr)) {
> -		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
> -		return -EIO;
> -	}
> -
> -	/* program latency */
> -	usleep_range(7500, 7600);
> -	return 0;
> -}
> -
> -static int xilinx_spi_write(struct fpga_manager *mgr, const char *buf,
> +static int xilinx_spi_write(struct xilinx_fpga_core *core, const char *buf,
>  			    size_t count)
>  {
> -	struct xilinx_spi_conf *conf = mgr->priv;
> +	struct xilinx_spi_conf *conf = to_xilinx_spi_conf(core);
>  	const char *fw_data = buf;
>  	const char *fw_data_end = fw_data + count;
>  
> @@ -143,7 +40,7 @@ static int xilinx_spi_write(struct fpga_manager *mgr, const char *buf,
>  
>  		ret = spi_write(conf->spi, fw_data, stride);
>  		if (ret) {
> -			dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
> +			dev_err(core->dev, "SPI error in firmware write: %d\n",
>  				ret);
>  			return ret;
>  		}
> @@ -153,109 +50,26 @@ static int xilinx_spi_write(struct fpga_manager *mgr, const char *buf,
>  	return 0;
>  }
>  
> -static int xilinx_spi_apply_cclk_cycles(struct xilinx_spi_conf *conf)
> -{
> -	struct spi_device *spi = conf->spi;
> -	const u8 din_data[1] = { 0xff };
> -	int ret;
> -
> -	ret = spi_write(conf->spi, din_data, sizeof(din_data));
> -	if (ret)
> -		dev_err(&spi->dev, "applying CCLK cycles failed: %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int xilinx_spi_write_complete(struct fpga_manager *mgr,
> -				     struct fpga_image_info *info)
> -{
> -	struct xilinx_spi_conf *conf = mgr->priv;
> -	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> -	bool expired = false;
> -	int done;
> -	int ret;
> -
> -	/*
> -	 * This loop is carefully written such that if the driver is
> -	 * scheduled out for more than 'timeout', we still check for DONE
> -	 * before giving up and we apply 8 extra CCLK cycles in all cases.
> -	 */
> -	while (!expired) {
> -		expired = time_after(jiffies, timeout);
> -
> -		done = get_done_gpio(mgr);
> -		if (done < 0)
> -			return done;
> -
> -		ret = xilinx_spi_apply_cclk_cycles(conf);
> -		if (ret)
> -			return ret;
> -
> -		if (done)
> -			return 0;
> -	}
> -
> -	if (conf->init_b) {
> -		ret = gpiod_get_value(conf->init_b);
> -
> -		if (ret < 0) {
> -			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
> -			return ret;
> -		}
> -
> -		dev_err(&mgr->dev,
> -			ret ? "CRC error or invalid device\n"
> -			: "Missing sync word or incomplete bitstream\n");
> -	} else {
> -		dev_err(&mgr->dev, "Timeout after config data transfer\n");
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static const struct fpga_manager_ops xilinx_spi_ops = {
> -	.state = xilinx_spi_state,
> -	.write_init = xilinx_spi_write_init,
> -	.write = xilinx_spi_write,
> -	.write_complete = xilinx_spi_write_complete,
> -};
> -
>  static int xilinx_spi_probe(struct spi_device *spi)
>  {
>  	struct xilinx_spi_conf *conf;
> -	struct fpga_manager *mgr;
>  
>  	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>  	if (!conf)
>  		return -ENOMEM;
>  
> +	conf->core.dev = &spi->dev;
> +	conf->core.write = xilinx_spi_write;
>  	conf->spi = spi;
>  
> -	/* PROGRAM_B is active low */
> -	conf->prog_b = devm_gpiod_get(&spi->dev, "prog_b", GPIOD_OUT_LOW);
> -	if (IS_ERR(conf->prog_b))
> -		return dev_err_probe(&spi->dev, PTR_ERR(conf->prog_b),
> -				     "Failed to get PROGRAM_B gpio\n");
> -
> -	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN);
> -	if (IS_ERR(conf->init_b))
> -		return dev_err_probe(&spi->dev, PTR_ERR(conf->init_b),
> -				     "Failed to get INIT_B gpio\n");
> -
> -	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
> -	if (IS_ERR(conf->done))
> -		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
> -				     "Failed to get DONE gpio\n");
> -
> -	mgr = devm_fpga_mgr_register(&spi->dev,
> -				     "Xilinx Slave Serial FPGA Manager",
> -				     &xilinx_spi_ops, conf);
> -	return PTR_ERR_OR_ZERO(mgr);
> +	return xilinx_core_probe(&conf->core);
>  }
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id xlnx_spi_of_match[] = {
> -	{ .compatible = "xlnx,fpga-slave-serial", },
> +	{
> +		.compatible = "xlnx,fpga-slave-serial",
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, xlnx_spi_of_match);
> -- 
> 2.43.0
> 
> 

