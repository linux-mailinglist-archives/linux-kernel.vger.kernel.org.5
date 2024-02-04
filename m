Return-Path: <linux-kernel+bounces-51515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D368848C15
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10E61C21824
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA56111BF;
	Sun,  4 Feb 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0lEXMne"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190310A1E;
	Sun,  4 Feb 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034485; cv=none; b=QY2x83SJENjhb5+t2ncM4DDhYLMBbzXTMXQQBJmjfrdyQedInX8htEnWu6cdTnsHPXW4yfvBhjxE0StweSCjkxwqwDXk7gFhnI43m25mD/U7aNaGFA1+hAkBLpbFRZ4jsbdycHDHrEX8QUYQZz7nz4YawKrnd83Gt4dTDGyh18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034485; c=relaxed/simple;
	bh=eaufywgAjGaDsPHzb03zkkOhmriE3QAt5RjxbfErorM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8c05yI2E01mtF8fnseQ1Q+nOFrEUNTfk2GtfXDhIkNlVpx9FlJy2+CWNplRSJdn+PyJjjeiwP7vh1cXd/oiMZ0ZlLvaLR62P1XcwsstasN9Kc8X26OkvrgvfLpPWUy+xHqBVypbIwbvTkUS8gLpCEblqXRn9/Vaz1EHWNkioN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0lEXMne; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707034484; x=1738570484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eaufywgAjGaDsPHzb03zkkOhmriE3QAt5RjxbfErorM=;
  b=X0lEXMnewN7o9r/TRHSSMkwqPSrXqt/AVL3Dqp2HuUCNYoKNLscWYLdx
   TUvTnNDBQY5U/tdMCK0omxSYL5+C2ld3X4yeswBvbSrDch0FvBijBgY0r
   xy/QiMlk24sxO7ArpYZXSAsGmh7r912tD620CH/XRTahbeCzCj0kZ01B8
   3xni2T1g39IZ4vaRDrOdfHloYJywXYJqe1N5seDKpPmx/L4Y46yZrWXdG
   l1e3SNnWaG+xwrUkUToUimHYJKK5GcrfmARLAVhwcKz8SNxmR3t657i8O
   V8LTVrMbyAWzVX+mTKk9w7obBIFCSjdMjPCTUTm7IFmFUZJ4t7cIWce8v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="292345"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="292345"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 00:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="779907"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 04 Feb 2024 00:14:29 -0800
Date: Sun, 4 Feb 2024 16:10:57 +0800
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
Subject: Re: [PATCH 3/3] fpga: xilinx-selectmap: add new driver
Message-ID: <Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-4-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131230542.3993409-4-charles.perry@savoirfairelinux.com>

On Wed, Jan 31, 2024 at 06:05:33PM -0500, Charles Perry wrote:
> Xilinx 7 series FPGA can be programmed using a slave parallel port named
> the SelectMAP interface in the datasheet. This slave interface is
> compatible with the i.MX6 EIM bus controller but other types of external
> memory mapped parallel bus might work.
> 
> xilinx-selectmap currently only supports the x8 mode where data is loaded
> at one byte per rising edge of the clock, with the MSb of each byte
> presented to the D0 pin.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  drivers/fpga/Kconfig            |   8 +++
>  drivers/fpga/Makefile           |   1 +
>  drivers/fpga/xilinx-core.c      |  11 +++-
>  drivers/fpga/xilinx-core.h      |   3 +-
>  drivers/fpga/xilinx-selectmap.c | 106 ++++++++++++++++++++++++++++++++
>  drivers/fpga/xilinx-spi.c       |   3 +-
>  6 files changed, 127 insertions(+), 5 deletions(-)
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
> index aff40e9394085..64117759be100 100644
> --- a/drivers/fpga/xilinx-core.c
> +++ b/drivers/fpga/xilinx-core.c
> @@ -180,21 +180,26 @@ static const struct fpga_manager_ops xilinx_core_ops = {
>  
>  int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
>  		      xilinx_write_func write,
> -		      xilinx_write_one_dummy_byte_func write_one_dummy_byte)
> +		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
> +		      const char *prog_con_id, const char *init_con_id)

These gpio name inputs are not necessary except for DTS format concern.
Is it possible we don't change the names?

>  {
>  	struct fpga_manager *mgr;
>  
> +	if (!core || !dev || !write || !write_one_dummy_byte || !prog_con_id ||
> +	    !init_con_id)
> +		return -EINVAL;

These checks belong to Patch #1.

> +
>  	core->dev = dev;
>  	core->write = write;
>  	core->write_one_dummy_byte = write_one_dummy_byte;
>  
>  	/* PROGRAM_B is active low */
> -	core->prog_b = devm_gpiod_get(dev, "prog_b", GPIOD_OUT_LOW);
> +	core->prog_b = devm_gpiod_get(dev, prog_con_id, GPIOD_OUT_LOW);
>  	if (IS_ERR(core->prog_b))
>  		return dev_err_probe(dev, PTR_ERR(core->prog_b),
>  				     "Failed to get PROGRAM_B gpio\n");
>  
> -	core->init_b = devm_gpiod_get_optional(dev, "init-b", GPIOD_IN);
> +	core->init_b = devm_gpiod_get_optional(dev, init_con_id, GPIOD_IN);
>  	if (IS_ERR(core->init_b))
>  		return dev_err_probe(dev, PTR_ERR(core->init_b),
>  				     "Failed to get INIT_B gpio\n");
> diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
> index 40e120945ba70..817f0e551d093 100644
> --- a/drivers/fpga/xilinx-core.h
> +++ b/drivers/fpga/xilinx-core.h
> @@ -22,6 +22,7 @@ struct xilinx_fpga_core {
>  
>  int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
>  		      xilinx_write_func write,
> -		      xilinx_write_one_dummy_byte_func write_one_dummy_byte);
> +		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
> +		      const char *prog_con_id, const char *init_con_id);
>  
>  #endif /* __XILINX_CORE_H */
> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
> new file mode 100644
> index 0000000000000..08054e19bb498
> --- /dev/null
> +++ b/drivers/fpga/xilinx-selectmap.c
> @@ -0,0 +1,106 @@
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
> +
> +struct xilinx_selectmap_conf {
> +	struct xilinx_fpga_core core;
> +	void __iomem *base;
> +	struct gpio_desc *csi_b;
> +	struct gpio_desc *rdwr_b;

These 2 gpio_desc are not used globally, maybe remove them here.

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
> +static int xilinx_selectmap_apply_padding(struct xilinx_fpga_core *core)
> +{
> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
> +
> +	writeb(0xFF, conf->base);

Seems only one callback needed. Just use write() to xfer 1 byte?

Thanks,
Yilun

> +	return 0;
> +}
> +
> +static int xilinx_selectmap_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_selectmap_conf *conf;
> +	struct resource *r;
> +	void __iomem *base;
> +
> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				     "ioremap error\n");
> +	conf->base = base;
> +
> +	/* CSI_B is active low */
> +	conf->csi_b =
> +		devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->csi_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
> +				     "Failed to get CSI_B gpio\n");
> +
> +	/* RDWR_B is active low */
> +	conf->rdwr_b =
> +		devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->rdwr_b))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
> +				     "Failed to get RDWR_B gpio\n");
> +
> +	return xilinx_core_probe(&conf->core, &pdev->dev,
> +				 xilinx_selectmap_write,
> +				 xilinx_selectmap_apply_padding, "prog",
> +				 "init");
> +}
> +
> +static const struct of_device_id xlnx_selectmap_of_match[] = {
> +	{
> +		.compatible = "xlnx,fpga-selectmap",
> +	},
> +	{}
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
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index ec128dee97312..b9ab3d5da004c 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -74,7 +74,8 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  	conf->spi = spi;
>  
>  	return xilinx_core_probe(&conf->core, &spi->dev, xilinx_spi_write,
> -				 xilinx_spi_apply_cclk_cycles);
> +				 xilinx_spi_apply_cclk_cycles, "prog_b",
> +				 "init-b");
>  }
>  
>  #ifdef CONFIG_OF
> -- 
> 2.43.0
> 
> 

