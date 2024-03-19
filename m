Return-Path: <linux-kernel+bounces-107113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043787F7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB0D1F22E51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844950A77;
	Tue, 19 Mar 2024 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJgWBx65"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FD5024E;
	Tue, 19 Mar 2024 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830407; cv=none; b=Z4SfAPvA30CTuuwlnN782+rim0F2LkgpPnMsopJvG8l4AXQkhNL9dapDx85uCSBOjoXPU+hgI0SEbFLcUdZaZtTTDCmJOmbj62NTtqzBmUYYlUbd42bhBus43e6JwDvsMqueTKx/yUNLdLZwgqc2vCxOEVdON/QAWlKlsVkVazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830407; c=relaxed/simple;
	bh=igetNCexyau5jpzxn3bC4vTACZALpnEId5+W6FhTmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsbxUUc5up12HBG2CyRguDemXyTjKpZvcwCMsuqEBLSN55lGjhRcE/GP+eNxW+AIF45t40BMbUf4RgQ4mPp45ieIISYpa8iMwNIPHl6hN5OWOhAGc2YrSf9KvB4DYjomwEUuqLDrsbhhH0OR17xiw+m9yQO44IQJ7jJWT8nV94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJgWBx65; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710830406; x=1742366406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igetNCexyau5jpzxn3bC4vTACZALpnEId5+W6FhTmC4=;
  b=aJgWBx65/Q5QqC3EvpO+ED1ZnyRFZ8S0SceM6sYLgXjVRfaiIJqzNRE/
   FVwLEAXO3TjFgTJ3b9iy/cvaIfv1m2N4KfN54ykZ4JRXJ5vjklzmWvtdP
   fDlWsFdMVSazQ60N0+IScKZ2Z89NmLt87hi0ix9eIdVYO2xS0z8ju2lG/
   24e/gbzR1lE/aFCqrWMDzjUVi8mrSvXTrtqeIV1TIvqYFE8M2vZNzGkYV
   rQhGL76jmCp04huNqW+2ipzXOLv5KHXMGgbPQhNj4gZ5IkocuciL4ZHka
   72xDyd8JkNML/rh8aYCC+/bl4KdtxI20LdAO1EXE+G6wu6+GZOVP/SfAh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5527841"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5527841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18406359"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 18 Mar 2024 23:40:01 -0700
Date: Tue, 19 Mar 2024 14:35:29 +0800
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
Subject: Re: [PATCH v5 3/3] fpga: xilinx-selectmap: add new driver
Message-ID: <ZfkyMSczuFUdy3tU@yilunxu-OptiPlex-7050>
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
 <20240313225746.489253-4-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313225746.489253-4-charles.perry@savoirfairelinux.com>

On Wed, Mar 13, 2024 at 06:57:37PM -0400, Charles Perry wrote:
> Xilinx 7 series FPGA can be programmed using a parallel port named
> the SelectMAP interface in the datasheet. This interface is compatible
> with the i.MX6 EIM bus controller but other types of external memory
> mapped parallel bus might work.
> 
> xilinx-selectmap currently only supports the x8 mode where data is loaded
> at one byte per rising edge of the clock, with the MSb of each byte
> presented to the D0 pin.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
> Changes since v4: (from Yilun review)
>  * xilinx-core: select between prog/init and prog_b/init-b
> 
>  drivers/fpga/Kconfig            |  8 +++
>  drivers/fpga/Makefile           |  1 +
>  drivers/fpga/xilinx-core.c      | 29 +++++++++-
>  drivers/fpga/xilinx-selectmap.c | 97 +++++++++++++++++++++++++++++++++
>  4 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/fpga/xilinx-selectmap.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d27a1ebf40838..37b35f58f0dfb 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
>  config FPGA_MGR_XILINX_CORE
>  	tristate
> 
> +config FPGA_MGR_XILINX_SELECTMAP
> +	tristate "Xilinx Configuration over SelectMAP"
> +	depends on HAS_IOMEM
> +	select FPGA_MGR_XILINX_CORE
> +	help
> +	  FPGA manager driver support for Xilinx FPGA configuration
> +	  over SelectMAP interface.
> +
>  config FPGA_MGR_XILINX_SPI
>  	tristate "Xilinx Configuration over Slave Serial (SPI)"
>  	depends on SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 7ec795b6a5a70..aeb89bb13517e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>  obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
> +obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
> index a35c43382dd5f..ccdeb45eba4ee 100644
> --- a/drivers/fpga/xilinx-core.c
> +++ b/drivers/fpga/xilinx-core.c
> @@ -171,6 +171,29 @@ static int xilinx_core_write_complete(struct fpga_manager *mgr,
>  	return -ETIMEDOUT;
>  }
> 
> +/**
> + * xilinx_core_devm_gpiod_get - Obtain a resource-managed GPIO using a
> + *                              legacy consumer name fallback.
> + *
> + * @dev:           Device managing the GPIO
> + * @con_id:        Consumer id
> + * @legacy_con_id: Legacy consumer id
> + * @flags:         optional GPIO initialization flags
> + */

No need to have kernel doc comments for internal functions.

> +static inline struct gpio_desc *
> +xilinx_core_devm_gpiod_get(struct device *dev, const char *con_id,
> +			   const char *legacy_con_id, enum gpiod_flags flags)
> +{
> +	struct gpio_desc *desc;
> +
> +	desc = devm_gpiod_get(dev, con_id, flags);
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT &&
> +	    of_device_is_compatible(dev->of_node, "xlnx,fpga-slave-serial"))
> +		desc = devm_gpiod_get(dev, legacy_con_id, flags);
> +
> +	return desc;
> +}
> +
>  static const struct fpga_manager_ops xilinx_core_ops = {
>  	.state = xilinx_core_state,
>  	.write_init = xilinx_core_write_init,
> @@ -186,12 +209,14 @@ int xilinx_core_probe(struct xilinx_fpga_core *core)
>  		return -EINVAL;
> 
>  	/* PROGRAM_B is active low */
> -	core->prog_b = devm_gpiod_get(core->dev, "prog_b", GPIOD_OUT_LOW);
> +	core->prog_b = xilinx_core_devm_gpiod_get(core->dev, "prog", "prog_b",
> +						  GPIOD_OUT_LOW);
>  	if (IS_ERR(core->prog_b))
>  		return dev_err_probe(core->dev, PTR_ERR(core->prog_b),
>  				     "Failed to get PROGRAM_B gpio\n");
> 
> -	core->init_b = devm_gpiod_get_optional(core->dev, "init-b", GPIOD_IN);
> +	core->init_b = xilinx_core_devm_gpiod_get(core->dev, "init", "init-b",
> +						  GPIOD_IN);
>  	if (IS_ERR(core->init_b))
>  		return dev_err_probe(core->dev, PTR_ERR(core->init_b),
>  				     "Failed to get INIT_B gpio\n");

Please make a separate patch for the naming change. This give a chance
to explain why the change and how to correctly use the GPIO names.

> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
> new file mode 100644
> index 0000000000000..b63f4623f8b2c
> --- /dev/null
> +++ b/drivers/fpga/xilinx-selectmap.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Xilinx Spartan6 and 7 Series SelectMAP interface driver
> + *
> + * (C) 2024 Charles Perry <charles.perry@savoirfairelinux.com>
> + *
> + * Manage Xilinx FPGA firmware loaded over the SelectMAP configuration
> + * interface.
> + */
> +
> +#include "xilinx-core.h"
> +
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/io.h>

alphabetical order please.

> +
> +struct xilinx_selectmap_conf {
> +	struct xilinx_fpga_core core;
> +	void __iomem *base;
> +};
> +
> +#define to_xilinx_selectmap_conf(obj) \
> +	container_of(obj, struct xilinx_selectmap_conf, core)
> +
> +static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
> +				  const char *buf, size_t count)
> +{
> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
> +	u32 i;
> +
> +	for (i = 0; i < count; ++i)
> +		writeb(buf[i], conf->base);
> +
> +	return 0;
> +}
> +
> +static int xilinx_selectmap_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_selectmap_conf *conf;
> +	struct resource *r;
> +	void __iomem *base;
> +	struct gpio_desc *csi_b;
> +	struct gpio_desc *rdwr_b;

One gpio_desc is enough, is it?  We don't use these gpio_desc anywhere
else.

BTW, reverse Xmas tree is not strictly required, but please do it when it is easy to follow.

> +
> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->core.dev = &pdev->dev;
> +	conf->core.write = xilinx_selectmap_write;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);

I can't find where 'r' is used.

Thanks,
Yilun

> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				     "ioremap error\n");
> +	conf->base = base;
> +
> +	/* CSI_B is active low */
> +	csi_b = devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
> +	if (IS_ERR(csi_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(csi_b),
> +				     "Failed to get CSI_B gpio\n");
> +
> +	/* RDWR_B is active low */
> +	rdwr_b = devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
> +	if (IS_ERR(rdwr_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rdwr_b),
> +				     "Failed to get RDWR_B gpio\n");
> +
> +	return xilinx_core_probe(&conf->core);
> +}
> +
> +static const struct of_device_id xlnx_selectmap_of_match[] = {
> +	{ .compatible = "xlnx,fpga-xc7s-selectmap", }, // Spartan-7
> +	{ .compatible = "xlnx,fpga-xc7a-selectmap", }, // Artix-7
> +	{ .compatible = "xlnx,fpga-xc7k-selectmap", }, // Kintex-7
> +	{ .compatible = "xlnx,fpga-xc7v-selectmap", }, // Virtex-7
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
> +
> +static struct platform_driver xilinx_selectmap_driver = {
> +	.driver = {
> +		.name = "xilinx-selectmap",
> +		.of_match_table = xlnx_selectmap_of_match,
> +	},
> +	.probe  = xilinx_selectmap_probe,
> +};
> +
> +module_platform_driver(xilinx_selectmap_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
> +MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
> --
> 2.43.0
> 

