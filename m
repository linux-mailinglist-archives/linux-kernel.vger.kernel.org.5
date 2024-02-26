Return-Path: <linux-kernel+bounces-81115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96404867068
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D476282549
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8431EEEA;
	Mon, 26 Feb 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwHNQKxy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59F14280;
	Mon, 26 Feb 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941286; cv=none; b=flAfX2mSLXKatCyQPAXvooVZsYlW0gIHzSt0pXURny9YrRrNMN/vKXAFbJav/ymi4Res51fqPExkNKmlpvVQ7W3E4CYoBQcmqUD3/8lET0PFH9R1K6jqT2+Q+oYwaFpq25MvqSiogICBjWiRkyqMxTe5xJFbqkCsH0M8apEliaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941286; c=relaxed/simple;
	bh=enB6Xir2DeuVTnHYJjI3T8tlXiRYYBFbJ7oEag0B5HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs81cbDautfHtX+lpXABoriy+rkPkpkuhRfIU0WMcnTNJMLzPD1O9KjpYDsdSk708Kyb0PmwzjahAWyUFWJf40JVwOpRhj1ePUbKCyszGzrOHSa8NdVw8NivrD2DXdeaUV65pkEAcix5IE1j5i/7BMaNvyxLGFiz3KhnLBsZVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwHNQKxy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708941285; x=1740477285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enB6Xir2DeuVTnHYJjI3T8tlXiRYYBFbJ7oEag0B5HQ=;
  b=MwHNQKxyapHMpnWbJbPGAA4PsVaQsL+s7G2Fg2/MFrzecbTCK77RLLEQ
   XvrWJwX2SrndPLwan8IgkRXxHsX2+aeDyBkGFzFv2VZ5Qd+iWiDAV9uQ6
   KLl4sge3gGLgG7m5ccmdsKNVHdvEvXskGPPRhCDIgLvqrYzeIXB64cvH3
   PdvSqrBehmkL46bPEUwklt9a747rjyb5Yh9TaAuTN28kVzSgQPnjueKL7
   EcSxFUWdQ9hxwav9cyZB9c4SJQCXDvsTMLp7gKZcxmJV50jjDf7ZeupO/
   nWDM0ewyWqzVQiHrqLpAvh0L4nEHnMFlvQZ5KVx6fQMQLXkVXPD6RpCkH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13859654"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13859654"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11205325"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2024 01:54:40 -0800
Date: Mon, 26 Feb 2024 17:50:38 +0800
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
Subject: Re: [PATCH v4 3/3] fpga: xilinx-selectmap: add new driver
Message-ID: <Zdxe7mvBbHDHzbiS@yilunxu-OptiPlex-7050>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-4-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221195058.1281973-4-charles.perry@savoirfairelinux.com>

On Wed, Feb 21, 2024 at 02:50:49PM -0500, Charles Perry wrote:
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
>  drivers/fpga/Kconfig            |  8 +++
>  drivers/fpga/Makefile           |  1 +
>  drivers/fpga/xilinx-selectmap.c | 97 +++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
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
> +
> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->core.dev = &pdev->dev;
> +	conf->core.write = xilinx_selectmap_write;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
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

Does the driver have to be used with OF or not?

If yes, please specify the reason and enforce in Kconfig.
If no, please ensure it decently compiles without CONFIG_OF.

Thanks,
Yilun

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
> 

