Return-Path: <linux-kernel+bounces-55275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561684BA2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6952B2B907
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709C132C38;
	Tue,  6 Feb 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="f/7OTRbw"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621213341C;
	Tue,  6 Feb 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234511; cv=none; b=B4pXv9jjY8Ch15nMSM8L5R36wTBXlAj34+SbfdfZI7L0Erj4v/YdEU5aVe9P6NtlOntiKA9rBuEPlp6Bde808sUfBEaKjKsFjLRyHG9oLSqAP4rLlv+cE+LDGnI+2NTijZKRPSlr37JG/iAXIWAouH8C8650+JOQO3ZE57wkM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234511; c=relaxed/simple;
	bh=wbK0orDWOupuSqWMwk522Xq5fcRd/HqHPc9jvGyB2uc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tCWU0h5Nu4lMArU471ppI6sXPxEwF92ltO7xM3LTs8DJwnHT6HIH3Iop4J9t1ctyaojLnqALkmdbsjnroPw797rnPAi4sSxoHslMgJ1a6osZlKDo93H8ifkKLC8YMuc94iYIxM/egRpZQJ8yF0pvGg4M/2X+tRkngxcp757A8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=f/7OTRbw; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 875E39C48FD;
	Tue,  6 Feb 2024 10:48:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Ja5EqKSt25TP; Tue,  6 Feb 2024 10:48:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 864C19C46CD;
	Tue,  6 Feb 2024 10:48:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 864C19C46CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707234505; bh=cjjarokzRd08SrjUoK5tROSotmusVZLJUU0CaUjWH9U=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=f/7OTRbwJCOnul7q46P4GgA6Vu0eM24nBZ7SSmRit89BzJ7vLC83goe4iFvbBZNmf
	 r2wqnfy9rg5SGVupivKeLg74cy3wtttPFME6joc13aYRu4LekqLJSiQh/P3Tp7Kji5
	 5jc/w37v7F4VrSauvnWBWDv4kp61OZ/AHeadj2zFxQq/qmzqN4JyBrXiu7i9+UPkOd
	 UUB5vI3aCGa/Xvk5tUCkqifWaS8svfaJySivy6wO8Shw4INh/7xFl8n0JNSgf/SbEO
	 qQ1RyZESSyAChIUaVPRIvHFBcI04ZMMhrJ1HhV98BFA7BtiJK3Bc10gyneP1Nsf3IE
	 lSKvLU3mI1b1Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6_vVbBU_TKUb; Tue,  6 Feb 2024 10:48:25 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3BE459C284E;
	Tue,  6 Feb 2024 10:48:25 -0500 (EST)
Date: Tue, 6 Feb 2024 10:48:25 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1245786788.524590.1707234505127.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-4-charles.perry@savoirfairelinux.com> <Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH 3/3] fpga: xilinx-selectmap: add new driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: fpga: xilinx-selectmap: add new driver
Thread-Index: RM1E82nMFT87ZB0X9Ai1OqQ0IiZjGQ==

On Feb 4, 2024, at 3:10 AM, Xu Yilun yilun.xu@linux.intel.com wrote:
> On Wed, Jan 31, 2024 at 06:05:33PM -0500, Charles Perry wrote:
>> Xilinx 7 series FPGA can be programmed using a slave parallel port named
>> the SelectMAP interface in the datasheet. This slave interface is
>> compatible with the i.MX6 EIM bus controller but other types of external
>> memory mapped parallel bus might work.
>> 
>> xilinx-selectmap currently only supports the x8 mode where data is loaded
>> at one byte per rising edge of the clock, with the MSb of each byte
>> presented to the D0 pin.
>> 
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>>  drivers/fpga/Kconfig            |   8 +++
>>  drivers/fpga/Makefile           |   1 +
>>  drivers/fpga/xilinx-core.c      |  11 +++-
>>  drivers/fpga/xilinx-core.h      |   3 +-
>>  drivers/fpga/xilinx-selectmap.c | 106 ++++++++++++++++++++++++++++++++
>>  drivers/fpga/xilinx-spi.c       |   3 +-
>>  6 files changed, 127 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/fpga/xilinx-selectmap.c
>> 
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index d27a1ebf40838..37b35f58f0dfb 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -67,6 +67,14 @@ config FPGA_MGR_STRATIX10_SOC
>>  config FPGA_MGR_XILINX_CORE
>>  	tristate
>>  
>> +config FPGA_MGR_XILINX_SELECTMAP
>> +	tristate "Xilinx Configuration over SelectMAP"
>> +	depends on HAS_IOMEM
>> +	select FPGA_MGR_XILINX_CORE
>> +	help
>> +	  FPGA manager driver support for Xilinx FPGA configuration
>> +	  over SelectMAP interface.
>> +
>>  config FPGA_MGR_XILINX_SPI
>>  	tristate "Xilinx Configuration over Slave Serial (SPI)"
>>  	depends on SPI
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 7ec795b6a5a70..aeb89bb13517e 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>>  obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>>  obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>> +obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>> diff --git a/drivers/fpga/xilinx-core.c b/drivers/fpga/xilinx-core.c
>> index aff40e9394085..64117759be100 100644
>> --- a/drivers/fpga/xilinx-core.c
>> +++ b/drivers/fpga/xilinx-core.c
>> @@ -180,21 +180,26 @@ static const struct fpga_manager_ops xilinx_core_ops = {
>>  
>>  int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
>>  		      xilinx_write_func write,
>> -		      xilinx_write_one_dummy_byte_func write_one_dummy_byte)
>> +		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
>> +		      const char *prog_con_id, const char *init_con_id)
> 
> These gpio name inputs are not necessary except for DTS format concern.
> Is it possible we don't change the names?
> 

Krzysztof won't accept the old names as they are non standard (contain a 
prohibited char "_" and use a "-b" prefix for active low). I agree that it
is cumbersome to have different gpio names injected in the core by the top 
level driver.

Can I change the GPIO names of xlnx,fpga-slave-serial? i.e.:

 * "prog_b" -> "prog"
 * "init-b" -> "init"

and keep a fallback in the driver so that current users of this driver keep
working without adaptation in the DT.

>>  {
>>  	struct fpga_manager *mgr;
>>  
>> +	if (!core || !dev || !write || !write_one_dummy_byte || !prog_con_id ||
>> +	    !init_con_id)
>> +		return -EINVAL;
> 
> These checks belong to Patch #1.
> 

Ok

>> +
>>  	core->dev = dev;
>>  	core->write = write;
>>  	core->write_one_dummy_byte = write_one_dummy_byte;
>>  
>>  	/* PROGRAM_B is active low */
>> -	core->prog_b = devm_gpiod_get(dev, "prog_b", GPIOD_OUT_LOW);
>> +	core->prog_b = devm_gpiod_get(dev, prog_con_id, GPIOD_OUT_LOW);
>>  	if (IS_ERR(core->prog_b))
>>  		return dev_err_probe(dev, PTR_ERR(core->prog_b),
>>  				     "Failed to get PROGRAM_B gpio\n");
>>  
>> -	core->init_b = devm_gpiod_get_optional(dev, "init-b", GPIOD_IN);
>> +	core->init_b = devm_gpiod_get_optional(dev, init_con_id, GPIOD_IN);
>>  	if (IS_ERR(core->init_b))
>>  		return dev_err_probe(dev, PTR_ERR(core->init_b),
>>  				     "Failed to get INIT_B gpio\n");
>> diff --git a/drivers/fpga/xilinx-core.h b/drivers/fpga/xilinx-core.h
>> index 40e120945ba70..817f0e551d093 100644
>> --- a/drivers/fpga/xilinx-core.h
>> +++ b/drivers/fpga/xilinx-core.h
>> @@ -22,6 +22,7 @@ struct xilinx_fpga_core {
>>  
>>  int xilinx_core_probe(struct xilinx_fpga_core *core, struct device *dev,
>>  		      xilinx_write_func write,
>> -		      xilinx_write_one_dummy_byte_func write_one_dummy_byte);
>> +		      xilinx_write_one_dummy_byte_func write_one_dummy_byte,
>> +		      const char *prog_con_id, const char *init_con_id);
>>  
>>  #endif /* __XILINX_CORE_H */
>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>> new file mode 100644
>> index 0000000000000..08054e19bb498
>> --- /dev/null
>> +++ b/drivers/fpga/xilinx-selectmap.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Xilinx Spartan6 and 7 Series SelectMAP interface driver
>> + *
>> + * (C) 2024 Charles Perry <charles.perry@savoirfairelinux.com>
>> + *
>> + * Manage Xilinx FPGA firmware loaded over the SelectMAP configuration
>> + * interface.
>> + */
>> +
>> +#include "xilinx-core.h"
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/of.h>
>> +#include <linux/io.h>
>> +
>> +struct xilinx_selectmap_conf {
>> +	struct xilinx_fpga_core core;
>> +	void __iomem *base;
>> +	struct gpio_desc *csi_b;
>> +	struct gpio_desc *rdwr_b;
> 
> These 2 gpio_desc are not used globally, maybe remove them here.
> 

Ok

>> +};
>> +
>> +#define to_xilinx_selectmap_conf(obj) \
>> +	container_of(obj, struct xilinx_selectmap_conf, core)
>> +
>> +static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>> +	u32 i;
>> +
>> +	for (i = 0; i < count; ++i)
>> +		writeb(buf[i], conf->base);
>> +
>> +	return 0;
>> +}
>> +
>> +static int xilinx_selectmap_apply_padding(struct xilinx_fpga_core *core)
>> +{
>> +	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>> +
>> +	writeb(0xFF, conf->base);
> 
> Seems only one callback needed. Just use write() to xfer 1 byte?
> 
> Thanks,
> Yilun
> 

Yes, will be changed.

Thank you,
Charles

>> +	return 0;
>> +}
>> +
>> +static int xilinx_selectmap_probe(struct platform_device *pdev)
>> +{
>> +	struct xilinx_selectmap_conf *conf;
>> +	struct resource *r;
>> +	void __iomem *base;
>> +
>> +	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>> +	if (!conf)
>> +		return -ENOMEM;
>> +
>> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>> +	if (IS_ERR(base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>> +				     "ioremap error\n");
>> +	conf->base = base;
>> +
>> +	/* CSI_B is active low */
>> +	conf->csi_b =
>> +		devm_gpiod_get_optional(&pdev->dev, "csi", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(conf->csi_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->csi_b),
>> +				     "Failed to get CSI_B gpio\n");
>> +
>> +	/* RDWR_B is active low */
>> +	conf->rdwr_b =
>> +		devm_gpiod_get_optional(&pdev->dev, "rdwr", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(conf->rdwr_b))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(conf->rdwr_b),
>> +				     "Failed to get RDWR_B gpio\n");
>> +
>> +	return xilinx_core_probe(&conf->core, &pdev->dev,
>> +				 xilinx_selectmap_write,
>> +				 xilinx_selectmap_apply_padding, "prog",
>> +				 "init");
>> +}
>> +
>> +static const struct of_device_id xlnx_selectmap_of_match[] = {
>> +	{
>> +		.compatible = "xlnx,fpga-selectmap",
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, xlnx_selectmap_of_match);
>> +
>> +static struct platform_driver xilinx_selectmap_driver = {
>> +	.driver = {
>> +		.name = "xilinx-selectmap",
>> +		.of_match_table = xlnx_selectmap_of_match,
>> +	},
>> +	.probe  = xilinx_selectmap_probe,
>> +};
>> +
>> +module_platform_driver(xilinx_selectmap_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Charles Perry <charles.perry@savoirfairelinux.com>");
>> +MODULE_DESCRIPTION("Load Xilinx FPGA firmware over SelectMap");
>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>> index ec128dee97312..b9ab3d5da004c 100644
>> --- a/drivers/fpga/xilinx-spi.c
>> +++ b/drivers/fpga/xilinx-spi.c
>> @@ -74,7 +74,8 @@ static int xilinx_spi_probe(struct spi_device *spi)
>>  	conf->spi = spi;
>>  
>>  	return xilinx_core_probe(&conf->core, &spi->dev, xilinx_spi_write,
>> -				 xilinx_spi_apply_cclk_cycles);
>> +				 xilinx_spi_apply_cclk_cycles, "prog_b",
>> +				 "init-b");
>>  }
>>  
>>  #ifdef CONFIG_OF
>> --
>> 2.43.0
>> 

