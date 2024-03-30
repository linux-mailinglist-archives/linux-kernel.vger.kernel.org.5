Return-Path: <linux-kernel+bounces-125806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3D892C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1891C216E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159AA3C6BA;
	Sat, 30 Mar 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al7PALi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2A3CF6E;
	Sat, 30 Mar 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822694; cv=none; b=F5HsF2nSgrBMlqXD3/LJBKaG0BxfUkgWpcAbT+XC8/oDt50MA3JCQJyjuCk5VHBLKLvNHfwnBgkHI0/Pb0X+eWSq+EJ9ZSBF4ez6zX+nAQgYTyAL0jmeCDtemwtN2cfwuSAo0goIEKQLkQ+QULoRXCbQmaFf6QydNpsN84Axlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822694; c=relaxed/simple;
	bh=tSJVzAE/viLobl+5ZHELowhXYvyGF9CcqNIXWq4q72A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1mlBKDRdhLMeHV6VWE+lnhGH+XpdaIJ9UGucH6EOSCg9MAOcNN/Dd7i2WASaRDSJC53v/1S4ODnjsl4P+c9+Nuw3+5LrmB7k/4TKdNSUn5Ib0Y0I/FB/SJ2mNDy3ri0OEFkRFrgYM2JUdC/b5oyEtUrZpLKdJOj6EVdKzNEXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al7PALi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87611C433B2;
	Sat, 30 Mar 2024 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711822693;
	bh=tSJVzAE/viLobl+5ZHELowhXYvyGF9CcqNIXWq4q72A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=al7PALi8gyJY85UO1kFDG802UTD5ca51yd7txQOUzFR5c4JSrCB3J3fUgrizzzETn
	 qu+NvbWmr6o703lJ5r9ioGO+KO5sCpF+4T8Qq4yzWxmVVfLWfpQCfEGCI6/Jcgyzyg
	 a6vcNIibzKkuKovRjmA0SdikarVPGvvVPMj9uN+jzzGYN6OTmA4l2e1tyv3MEKmyrs
	 LqV5z0Q8JLkH8MBeSiraivufx975y6kpbYu+PnxCxRCVvTC9BjN7p6paPjUVSTvGjs
	 O4kY8jNuVUki+1aDpmxbpp2Np9ThZ5zGAegPOOHxPLMT2EAIYospXCBFs/WB7AEpJo
	 uKmhjMR6N2QpQ==
Date: Sat, 30 Mar 2024 18:17:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: wefu@redhat.com
Cc: jszhang@kernel.org, guoren@kernel.org, conor@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 lars@metafoo.de, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
 marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 marius.cristea@microchip.com, fr0st61te@gmail.com, okan.sahin@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, lee@kernel.org,
 mike.looijmans@topic.nl, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers/iio/adc: Add XuanTie TH1520 ADC driver
Message-ID: <20240330181754.41f5dba1@jic23-huawei>
In-Reply-To: <20240329200241.4122000-2-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
	<20240329200241.4122000-2-wefu@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 04:01:24 +0800
wefu@redhat.com wrote:

> From: Wei Fu <wefu@redhat.com>
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>

Hi Wei Fu,

Comments inline.

Main thing is that there is quite a bit of code here to support a more
feature rich driver, but with parts missing.  Rip all that out until those
features are added in future patches.

Jonathan

> ---
>  drivers/iio/adc/Kconfig              |  13 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/xuantie-th1520-adc.c | 572 +++++++++++++++++++++++++++
>  drivers/iio/adc/xuantie-th1520-adc.h | 193 +++++++++
>  4 files changed, 779 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0d9282fa67f5..9e37ba2a877a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1515,4 +1515,17 @@ config XILINX_AMS
>  	  The driver can also be built as a module. If so, the module will be called
>  	  xilinx-ams.
>  
> +config XUANTIE_TH1520_ADC
> +	tristate "XuanTie TH1520 ADC driver"
> +	depends on OF

No need for that dependency.  In theory you could use this with ACPI PRP0001
for example.

> +	depends on HAS_IOMEM
> +	depends on ARCH_THEAD 
|| COMPILE_TEST 
to get us build coverage as I don't immediately see anything arch specific.

> +	default y
Don't set the default (i.e. rely on default default of no.)

> +	help
> +	  Say yes here to support for XuanTie TH1520 MPW analog-to-digital
> +	  converter.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called xuantie-th1520-adc.
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b3c434722364..820e2a136b33 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -135,4 +135,5 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
>  obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
> +obj-$(CONFIG_XUANTIE_TH1520_ADC) += xuantie-th1520-adc.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> diff --git a/drivers/iio/adc/xuantie-th1520-adc.c b/drivers/iio/adc/xuantie-th1520-adc.c
> new file mode 100644
> index 000000000000..df0452c2abe7
> --- /dev/null
> +++ b/drivers/iio/adc/xuantie-th1520-adc.c
> @@ -0,0 +1,572 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * XuanTie TH1520 ADC driver
> + *
> + * Copyright (C) 2021-2024 Alibaba Group Holding Limited.
> + * Fugang Duan <duanfugang.dfg@linux.alibaba.com>
> + *
Blank line here not useful so drop it.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
As below. Unlikely these are needed in a driver.

> +#include <linux/regulator/consumer.h>
> +#include <linux/of_platform.h>

Doubt you need that.  mod_devicetable.h perhaps?

> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
Why?

> +#include <linux/iio/sysfs.h>
> +
> +#include "xuantie-th1520-adc.h"
> +
> +static inline void th1520_adc_cfg_init(struct th1520_adc *info)
> +{
> +	struct th1520_adc_feature *adc_feature = &info->adc_feature;
> +
> +	/* set default Configuration for ADC controller */
> +	adc_feature->selres_sel = TH1520_ADC_SELRES_12BIT;
> +	adc_feature->input_mode = TH1520_ADC_SINGLE_ENDED_INPUTS;
> +	adc_feature->vol_ref = TH1520_ADC_VOL_VREF;
> +	adc_feature->offset_mode = TH1520_ADC_OFFSET_DIS;
> +	adc_feature->conv_mode = TH1520_ADC_MODE_SINGLE;
> +	adc_feature->clk_sel = TH1520_ADC_FCLK_TYP_1M;
> +
> +	adc_feature->int_actual = TH1520_ADC_ACTUAL_ALL;
> +	adc_feature->int_detal = TH1520_ADC_DETAL_ALL;
> +
> +	info->ch0_offmeas = 0;
> +	info->ch1_offmeas = 0;
Bring these features in when you add support to the driver. Until then
stick just using the default values inline as it simplifies the code.

> +}
> +
> +static void th1520_adc_reg_set(struct th1520_adc *info)
> +{
> +	u32 phy_cfg = 0;
> +	u32 op_ctrl = 0;
> +	struct th1520_adc_feature *adc_feature = &info->adc_feature;
> +
> +	/* phy_cfg */

That's obvious from the code, so I'd drop the comment.

> +	switch (adc_feature->selres_sel) {
> +	case TH1520_ADC_SELRES_6BIT:
Use numbers here.  You could just use maths for the conversion as well
to simplify things further.  However I've suggested elsewhere that you just
always use 12bit in which case this complexity isn't needed.

> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_6BIT;
> +		break;
> +	case TH1520_ADC_SELRES_8BIT:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_8BIT;
> +		break;
> +	case TH1520_ADC_SELRES_10BIT:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_10BIT;
> +		break;
> +	case TH1520_ADC_SELRES_12BIT:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_12BIT;
> +		break;
> +	default:
It's an enum, so we shouldn't get here with anything else and can drop the default.
> +		break;
> +	}
> +
> +	switch (adc_feature->input_mode) {
> +	case TH1520_ADC_SINGLE_ENDED_INPUTS:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELDIFF_SINGLE_ENDED_INPUTS;
> +		break;
> +	case TH1520_ADC_DIFFERENTIAL_INPUTS:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELDIFF_DIFFERENTIAL_INPUTS;
> +		break;
> +	default:

Not need as all values covered.

> +		break;
> +	}
> +
> +	switch (adc_feature->vol_ref) {
> +	case TH1520_ADC_VOL_VREF:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELBG_EXTERNAL |
> +			   TH1520_ADC_PHY_CFG_SELREF_EXT;
> +		break;
> +	case TH1520_ADC_VOL_INTE:
> +		phy_cfg |= TH1520_ADC_PHY_CFG_SELBG_INTERNAL |
> +			   TH1520_ADC_PHY_CFG_SELREF_INTERNAL;
> +		break;
> +	default:
Probably also not needed.
> +		break;
> +	}
> +
> +	/* op_ctrl */
> +	switch (adc_feature->conv_mode) {
> +	case TH1520_ADC_MODE_SINGLE:
> +		op_ctrl |= TH1520_ADC_OP_CTRL_MODE_SINGLE;
> +		break;
> +	case TH1520_ADC_MODE_CONTINOUS:
> +		op_ctrl |= TH1520_ADC_OP_CTRL_MODE_CONTINOUS;
> +		break;
> +	default:
As above.
> +		break;
> +	}
> +
> +	writel(phy_cfg, info->regs + TH1520_ADC_PHY_CFG);

I'd keep the writes with the register setup, so move this up above
filling in op_ctrl value.

> +	writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);
> +
> +	writel(TH1520_ADC_PHY_ENCTR, info->regs + TH1520_ADC_PHY_TEST);
> +
> +	/* disable the irq */
> +	writel(0xff, info->regs + TH1520_ADC_INT_CTRL1);
> +	writel(0xff, info->regs + TH1520_ADC_INT_CTRL2);
> +
> +	if (adc_feature->conv_mode == TH1520_ADC_MODE_CONTINOUS)
> +		writel(TH1520_ADC_PHY_CTRL_ENADC_EN,
> +		       info->regs + TH1520_ADC_PHY_CTRL);
> +}
> +
> +static void th1520_adc_fclk_set(struct th1520_adc *info)
> +{
> +	int fclk_ctrl = 0;
> +	int start_time = 0;
> +	int sample_time = 0;
> +	struct th1520_adc_feature *adc_feature = &info->adc_feature;
> +
> +	switch (adc_feature->clk_sel) {
> +	case TH1520_ADC_FCLK_TYP_1M:
> +		fclk_ctrl = TH1520_ADC_FCLK_CTRL_TYP_1M;
> +		start_time = TH1520_ADC_START_TIME_TYP_1M;
> +		if (adc_feature->selres_sel == TH1520_ADC_SELRES_6BIT)
Use numbers. Also maybe just convert from resolution to register value
using maths rather than an if/else stack.  Otherwise, you could just have
an array mapping from register value to real value and search it.

> +			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_6BIT;
> +		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_8BIT)
> +			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_8BIT;
> +		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_10BIT)
> +			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_10BIT;
> +		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_12BIT)
> +			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_12BIT;
> +		else {
> +			pr_err("[%s,%d]invalid selres select\n",
> +			       __func__, __LINE__);
> +			return;
> +		}
> +		break;
> +	default:
Comment on why nothing to do here.

> +		break;
> +	}
> +	writel(fclk_ctrl, info->regs + TH1520_ADC_FCLK_CTRL);
> +	writel(start_time, info->regs + TH1520_ADC_START_TIME);
> +	writel(sample_time, info->regs + TH1520_ADC_SAMPLE_TIME);
> +}
> +
> +static void th1520_adc_hw_init(struct th1520_adc *info)
> +{
> +	th1520_adc_reg_set(info);
> +	th1520_adc_fclk_set(info);
> +}
> +
> +static const struct iio_chan_spec th1520_adc_iio_channels[] = {
> +	TH1520_ADC_CHAN(0, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(1, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(2, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(3, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(4, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(5, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(6, IIO_VOLTAGE),
> +	TH1520_ADC_CHAN(7, IIO_VOLTAGE),
> +	/* sentinel */
?  There isn't a sentinel so drop the comment.

> +};
> +
> +static irqreturn_t th1520_adc_isr(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct th1520_adc *info = iio_priv(indio_dev);
> +	/* TBD */

?  Shouldn't see a TBD in a submitted driver.

> +	complete(&info->completion);
> +	return IRQ_HANDLED;
> +}
> +
> +static int th1520_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	int tmp;
> +	long ret;
> +	struct th1520_adc *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
Could use guard() here though the saving in this case is monor.

> +		mutex_lock(&info->mlock);
> +
> +		if (info->adc_feature.conv_mode == TH1520_ADC_MODE_SINGLE) {

At the moment there is no control over this mode, so I would drop
the alternative path until you add such control.  Also drop even tracking
what that mode is set to as it won't change.

> +			uint ievent;
> +			uint vld_flag;
> +			uint phy_ctrl;
> +			uint real_chan;
> +			uint op_ctrl = 0;
> +			uint single_retry = TH1520_ADC_FIFO_DATA_SIZE;
> +
> +			op_ctrl = readl(info->regs + TH1520_ADC_OP_CTRL);
> +			op_ctrl &= ~TH1520_ADC_OP_CTRL_CH_EN_ALL;
> +			op_ctrl |= (BIT(chan->channel +	TH1520_ADC_OP_CTRL_CH_EN_0) &
> +					TH1520_ADC_OP_CTRL_CH_EN_ALL);

FIELD_PREP()

> +			writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);

This first block is common to both paths. I'd factor out as much as possible

> +
> +			writel(TH1520_ADC_PHY_CTRL_ENADC_EN,
> +			       info->regs + TH1520_ADC_PHY_CTRL);
> +
> +			vld_flag = TH1520_ADC_SAMPLE_DATA_CH0_VLD;
> +
> +			while (single_retry--) {

Add a common to justify the retries (particularly why this number of them).

This deep indentation suggests to me that some of this code should be factored
out into a separate function.


> +				writel(TH1520_ADC_OP_SINGLE_START_EN,
> +				       info->regs + TH1520_ADC_OP_SINGLE_START);
> +				/* wait the sampling result */
> +				ret = readl_poll_timeout(info->regs +
> +							 TH1520_ADC_SAMPLE_DATA,
> +							 ievent,
> +							 ievent & vld_flag, 100,
> +							 TH1520_ADC_TIMEOUT);
> +				if (ret)
> +					pr_err("wait the sampling timeout\n");

Given you are going to retry, shouldn't see an error message here.

> +
> +				real_chan =
> +				(ievent & TH1520_ADC_SAMPLE_DATA_CH0_NUMBER) >>
> +				TH1520_ADC_SAMPLE_DATA_CH0_NUMBER_OFF;

FIELD_GET()

> +				if (real_chan == chan->channel)
> +					break;
> +			}
> +
> +			phy_ctrl = readl(info->regs + TH1520_ADC_PHY_CTRL);
> +			phy_ctrl &= ~TH1520_ADC_PHY_CTRL_ENADC_EN;
> +			writel(phy_ctrl, info->regs + TH1520_ADC_PHY_CTRL);
> +
> +			/* read the sampling data */
> +			*val = (ievent & TH1520_ADC_SAMPLE_DATA_CH0) >>
> +			       TH1520_ADC_SAMPLE_DATA_CH0_OFF;
FIELD_GET()

> +		} else {
> +			uint ievent;
> +			uint vld_flag;
> +			uint op_single;
> +			uint op_ctrl = 0;
> +
> +			op_ctrl = readl(info->regs + TH1520_ADC_OP_CTRL);
> +			op_ctrl &= ~TH1520_ADC_OP_CTRL_CH_EN_ALL;
> +			op_ctrl |= (BIT(chan->channel + TH1520_ADC_OP_CTRL_CH_EN_0) &
> +				   TH1520_ADC_OP_CTRL_CH_EN_ALL);
> +			writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);
> +
> +			op_single = readl(info->regs +
> +					  TH1520_ADC_OP_SINGLE_START);
> +			op_single &= ~TH1520_ADC_OP_SINGLE_START_EN;
> +			writel(op_single,
> +			       info->regs + TH1520_ADC_OP_SINGLE_START);
> +
> +			vld_flag = TH1520_ADC_SAMPLE_DATA_CH0_VLD |
> +				   TH1520_ADC_SAMPLE_DATA_CH1_VLD;
> +
> +			/* wait the sampling result */
> +			ret  = readl_poll_timeout(info->regs +
> +							TH1520_ADC_SAMPLE_DATA,
> +						  ievent, ievent & vld_flag, 10,
> +						  TH1520_ADC_TIMEOUT);
> +			if (ret)
> +				pr_err("wait the sampling timeout\n");
> +
> +			/* read the sampling data */
> +			tmp = readl(info->regs + TH1520_ADC_SAMPLE_DATA);
> +			if (tmp & TH1520_ADC_SAMPLE_DATA_CH0_VLD)
> +				*val = (tmp & TH1520_ADC_SAMPLE_DATA_CH0) >>
> +				       TH1520_ADC_SAMPLE_DATA_CH0_OFF;
> +			else
> +				*val = (tmp & TH1520_ADC_SAMPLE_DATA_CH1) >>
> +				       TH1520_ADC_SAMPLE_DATA_CH1_OFF;
> +		}
> +
> +		mutex_unlock(&info->mlock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_uv / 1000;
> +		*val2 = info->adc_feature.selres_sel;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = info->current_clk;
> +		*val2 = 0;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		break;
return -EINVAL; then drop the one below.

> +	}
> +
> +	return -EINVAL;
> +}

> +
> +static ssize_t th1520_adc_res_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	size_t bufpos = 0, count = 5;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct th1520_adc *info = iio_priv(indio_dev);
> +
> +	snprintf(buf + bufpos, count - bufpos, "%.*x: ", 4,
> +		 info->adc_feature.selres_sel);
> +	bufpos += 4;
> +	buf[bufpos++] = '\n';
> +
> +	return bufpos;
> +}
> +
> +static ssize_t th1520_adc_res_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t size)
> +{
> +	unsigned long res;
> +	char *start = (char *)buf;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct th1520_adc *info = iio_priv(indio_dev);
> +
> +	if (kstrtoul(start, 0, &res))
> +		return -EINVAL;
> +
> +	switch (res) {
> +	case TH1520_ADC_SELRES_6BIT:
> +	case TH1520_ADC_SELRES_8BIT:
> +	case TH1520_ADC_SELRES_10BIT:
> +	case TH1520_ADC_SELRES_12BIT:
> +		info->adc_feature.selres_sel = res;
> +		th1520_adc_reset(info);
> +		th1520_adc_hw_init(info);
> +		break;
> +	default:
> +		dev_err(dev, "not support res\n");
> +		return -EINVAL;
> +	}
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(th1520_adc_res);
Custom ABI needs documentation.  We very rarely allow direct control of resolution
as it normally also affects scale which is standard ABI. 

Also, for drivers only providing polled reads, the saving in time of using
low res readouts it negligible so just use 12bit ever time.

> +
> +static int th1520_adc_probe(struct platform_device *pdev)
> +{
> +	int irq;
> +	int ret;
> +	struct resource *mem;
> +	struct th1520_adc *info;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +					  sizeof(struct th1520_adc));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
dev_err_probe() here as well.

> +	}
> +
> +	info = iio_priv(indio_dev);
> +	info->dev = &pdev->dev;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(info->dev, irq, th1520_adc_isr, 0,
> +			       dev_name(&pdev->dev), indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> +		return ret;

Use return dev_err_probe() for errors in probe() routines and functions that
are only called during probe.  It better handles deferred probing and also
gives shorter code in general.

> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	info->clk = devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk)) {
> +		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> +			PTR_ERR(info->clk));
> +		return PTR_ERR(info->clk);
> +	}
> +
> +	info->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(info->vref))
> +		return PTR_ERR(info->vref);
> +
> +	ret = regulator_enable(info->vref);
> +	if (ret)
> +		return ret;
> +
> +	info->vref_uv = regulator_get_voltage(info->vref);

There is a patch set on list that will replace this boiler plate with a single
call to enable the regulator and get it's voltage, but we can make use of that
once/if that series is accepted.

> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	mutex_init(&info->mlock);
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
Both parent and of_node are set in the IIO core. I doubt you need to override
them.

> +	indio_dev->info = &th1520_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = th1520_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(th1520_adc_iio_channels);
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Could not prepare or enable the clock.\n");
> +		goto error_adc_clk_enable;
> +	}
> +
> +	th1520_adc_cfg_init(info);
> +	th1520_adc_reset(info);
> +	th1520_adc_hw_init(info);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto error_iio_device_register;
> +	}
> +
> +	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_th1520_adc_res.attr);

This is very much the wrong way to do sysfs attributes in general, but I doubt
this will end up in the final driver anyway so I won't go into how this should
be done.  Adding a file after registration is racey with userspace.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to create adc debug sysfs.\n");
> +		goto error_iio_device_register;
> +	}
> +
> +	dev_info(&pdev->dev, "XuanTie TH1520 adc registered.\n");

Too noisy.  There are loads of ways of finding that out that don't need a message
in the kernel log.  If you really want something then dev_dbg() at most.


> +	return 0;
> +
> +error_iio_device_register:
> +	clk_disable_unprepare(info->clk);
> +error_adc_clk_enable:
> +	regulator_disable(info->vref);
> +
> +	return ret;
> +}
> +
> +static int th1520_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct th1520_adc *info = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(info->vref);
> +	clk_disable_unprepare(info->clk);
> +
> +	return 0;
> +}

> +static SIMPLE_DEV_PM_OPS(th1520_adc_pm_ops,
IIRC this is deprecated use.
DEFINE_SIMPLE_DEV_PM_OPS()
> +			 th1520_adc_suspend, th1520_adc_resume);
> +
> +static struct platform_driver th1520_adc_driver = {
> +	.probe          = th1520_adc_probe,
> +	.remove         = th1520_adc_remove,
> +	.driver         = {
> +		.name   = DRIVER_NAME,

Put the string here and don't use a define.

> +		.of_match_table = th1520_adc_match,
> +		.pm     = &th1520_adc_pm_ops,
with the above, pm_sleep_ptr() around this and then if you build
without PM support the unused code will be removed by the compiler.

> +	},
> +};
> +module_platform_driver(th1520_adc_driver);
> +
> +MODULE_AUTHOR("fugang.duan <duanfugang.dfg@linux.alibaba.com>");
> +MODULE_DESCRIPTION("XuanTie TH1520 ADC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/xuantie-th1520-adc.h b/drivers/iio/adc/xuantie-th1520-adc.h
> new file mode 100644
> index 000000000000..c38d17fc6bbe
> --- /dev/null
> +++ b/drivers/iio/adc/xuantie-th1520-adc.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * XuanTie TH1520 ADC driver
> + *
> + * Copyright (C) 2021-2024 Alibaba Group Holding Limited.
> + * Fugang Duan <duanfugang.dfg@linux.alibaba.com>
> + *
> + */
> +
> +#include <linux/bitops.h>
> +
> +/* This will be the driver name the kernel reports */
> +#define DRIVER_NAME "xuantie-th1520-adc"

No obvious reason for a header - push this down into the C file.

> +
> +/* ADC registers */
> +#define TH1520_ADC_PHY_CFG			0x00
> +#define TH1520_ADC_PHY_CTRL			0x04
> +#define TH1520_ADC_PHY_TEST			0x08
> +#define TH1520_ADC_OP_CTRL			0x0C
> +#define TH1520_ADC_OP_SINGLE_START		0x10
> +#define TH1520_ADC_FCLK_CTRL			0x14
> +#define TH1520_ADC_START_TIME			0x18
> +#define TH1520_ADC_SAMPLE_TIME			0x1C
> +#define TH1520_ADC_SAMPLE_DATA			0x20
> +#define TH1520_ADC_INT_CTRL1			0x50
> +#define TH1520_ADC_INT_CTRL2			0x54
> +#define TH1520_ADC_INT_STATUS			0x58
> +#define TH1520_ADC_INT_ACTUAL_VALUE_CH0		0x60
> +#define TH1520_ADC_INT_ACTUAL_VALUE_CH1		0x64
> +#define TH1520_ADC_INT_DELTA_VALUE_CH0		0x90
> +#define TH1520_ADC_INT_DELTA_VALUE_CH1		0x94
> +
> +/* Configuration register field define */
> +#define TH1520_ADC_PHY_CFG_SELRES_6BIT			(0x0)
> +#define TH1520_ADC_PHY_CFG_SELRES_8BIT			(0x1)
> +#define TH1520_ADC_PHY_CFG_SELRES_10BIT			(0x2)
> +#define TH1520_ADC_PHY_CFG_SELRES_12BIT			(0x3)
> +#define TH1520_ADC_PHY_CFG_SELDIFF_SINGLE_ENDED_INPUTS	(0x0 << 4)
> +#define TH1520_ADC_PHY_CFG_SELDIFF_DIFFERENTIAL_INPUTS	(0x1 << 4)
> +#define TH1520_ADC_PHY_CFG_SELBG_INTERNAL		(0x1 << 8)
> +#define TH1520_ADC_PHY_CFG_SELBG_EXTERNAL		(0x0 << 8)
> +#define TH1520_ADC_PHY_CFG_SELREF_INTERNAL		(0x1 << 12)
> +#define TH1520_ADC_PHY_CFG_SELREF_EXT			(0x0 << 12)
> +
> +/* PHY CTRL register field define */
> +#define TH1520_ADC_PHY_CTRL_ENOFFSET_EN			(0x1 << 12)

BIT()

> +#define TH1520_ADC_PHY_CTRL_ENOFFMEAS_EN		(0x1 << 8)
> +#define TH1520_ADC_PHY_CTRL_RST_EN			(0x1 << 4)
> +#define TH1520_ADC_PHY_CTRL_ENADC_EN			(0x1 << 0)
> +
> +/* ADC OP ctrl field define  */
> +#define TH1520_ADC_OP_CTRL_CH_EN_ALL			GENMASK(19, 12)
> +#define TH1520_ADC_OP_CTRL_CH_EN_0			(12)
> +#define TH1520_ADC_OP_CTRL_MODE_SINGLE			(0x1 << 0)
> +#define TH1520_ADC_OP_CTRL_MODE_CONTINOUS		(0x0 << 0)
> +
> +/* ADC OP single start */
> +#define TH1520_ADC_OP_SINGLE_START_EN			BIT(0)
> +
> +/* ADC fclk ctrl */
> +#define TH1520_ADC_FCLK_CTRL_FCLLK_DIV			GENMASK(6, 0)
> +#define TH1520_ADC_FCLK_CTRL_TYP_1M			(0x10004)
> +#define TH1520_ADC_START_TIME_TYP_1M			(0x160)
> +#define TH1520_ADC_SAMPLE_TIME_TYP_1M			(0x10)
> +#define TH1520_ADC_SAMPLE_TIME_TYP_6BIT			(8)
> +#define TH1520_ADC_SAMPLE_TIME_TYP_8BIT			(10)
> +#define TH1520_ADC_SAMPLE_TIME_TYP_10BIT		(12)
> +#define TH1520_ADC_SAMPLE_TIME_TYP_12BIT		(14)
> +
> +/* ADC sample data */
> +#define TH1520_ADC_SAMPLE_DATA_CH1			GENMASK(27, 16)
> +#define TH1520_ADC_SAMPLE_DATA_CH1_OFF			(16)
> +#define TH1520_ADC_SAMPLE_DATA_CH1_VLD			BIT(31)
> +#define TH1520_ADC_SAMPLE_DATA_CH1_NUMBER		GENMASK(30, 28)
> +#define TH1520_ADC_SAMPLE_DATA_CH1_NUMBER_OFF		(28)
> +#define TH1520_ADC_SAMPLE_DATA_CH0			GENMASK(11, 0)
> +#define TH1520_ADC_SAMPLE_DATA_CH0_VLD			BIT(15)
> +#define TH1520_ADC_SAMPLE_DATA_CH0_OFF			(0)
> +#define TH1520_ADC_SAMPLE_DATA_CH0_NUMBER		GENMASK(14, 12)
> +#define TH1520_ADC_SAMPLE_DATA_CH0_NUMBER_OFF		(12)
> +
> +/* ADC INT Ctrl */
> +#define TH1520_ADC_INT_CTRL1_CH1_INT_MODE		BIT(1)
> +#define TH1520_ADC_INT_CTRL1_CH0_INT_MODE		BIT(0)
> +#define TH1520_ADC_INT_CTRL2_CH1_INT_MASK		BIT(1)
> +#define TH1520_ADC_INT_CTRL2_CH0_INT_MASK		BIT(0)
> +#define TH1520_ADC_INT_STS_CH1_INT_STS			BIT(1)
> +#define TH1520_ADC_INT_STS_CH0_INT_STS			BIT(0)
> +
> +#define TH1520_ADC_ACTUAL_VALUE_CH0_HVAL		GENMASK(27, 16)
> +#define TH1520_ADC_ACTUAL_VALUE_CH0_HVAL_OFF		(16)
> +#define TH1520_ADC_ACTUAL_VALUE_CH0_LVAL		GENMASK(11, 0)
> +#define TH1520_ADC_ACTUAL_VALUE_CH0_LVAL_OFF		(0)
> +#define TH1520_ADC_ACTUAL_VALUE_CH1_HVAL		GENMASK(27, 16)
> +#define TH1520_ADC_ACTUAL_VALUE_CH1_HVAL_OFF		(16)
> +#define TH1520_ADC_ACTUAL_VALUE_CH1_LVAL		GENMASK(11, 0)
> +#define TH1520_ADC_ACTUAL_VALUE_CH1_LVAL_OFF		(0)
> +
> +#define TH1520_ADC_DLT_VALUE_CH0_HVAL			GENMASK(27, 16)
> +#define TH1520_ADC_DLT_VALUE_CH0_HVAL_OFF		(16)
> +#define TH1520_ADC_DLT_VALUE_CH0_LVAL			GENMASK(11, 0)
> +#define TH1520_ADC_DLT_VALUE_CH0_LVAL_OFF		(0)
> +#define TH1520_ADC_DLT_VALUE_CH1_HVAL			GENMASK(27, 16)
> +#define TH1520_ADC_DLT_VALUE_CH1_HVAL_OFF		(16)
> +#define TH1520_ADC_DLT_VALUE_CH1_LVAL			GENMASK(11, 0)
> +#define TH1520_ADC_DLT_VALUE_CH1_LVAL_OFF		(0)
Don't specify offsets.  Use FIELD_GET() and FIELD_PREP()  for all accesses
as those work with the mask alone.  Also, make it clear what is a mask via
naming.  Typically _MSK or similar.


> +
> +#define TH1520_ADC_FIFO_DATA_SIZE			32
> +#define TH1520_ADC_PHY_ENCTR				0x8e0
> +#define TH1520_ADC_TIMEOUT				500000
> +
> +#define TH1520_ADC_CHAN(_idx, _chan_type) {			\
> +	.type = (_chan_type),					\
> +	.indexed = 1,						\
> +	.channel = (_idx),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +enum vol_ref {
> +	TH1520_ADC_VOL_VREF,
> +	TH1520_ADC_VOL_INTE,
> +};
> +
> +enum input_mode_sel {
> +	TH1520_ADC_SINGLE_ENDED_INPUTS,
> +	TH1520_ADC_DIFFERENTIAL_INPUTS,
> +};
> +
> +enum selres_sel {
> +	TH1520_ADC_SELRES_6BIT = 6,
These seem unnecessary given the numeric values make sense without the
enum.
> +	TH1520_ADC_SELRES_8BIT = 8,
> +	TH1520_ADC_SELRES_10BIT = 10,
> +	TH1520_ADC_SELRES_12BIT = 12,
> +};
> +
> +enum offset_mode_sel {
> +	TH1520_ADC_OFFSET_DIS = 0,
> +	TH1520_ADC_OFFSET_EN,
> +};
> +
> +enum conversion_mode_sel {
> +	TH1520_ADC_MODE_SINGLE,
> +	TH1520_ADC_MODE_CONTINOUS,
> +};
> +
> +enum clk_sel {
> +	TH1520_ADC_FCLK_TYP_1M,
> +};
> +
> +enum int_actual_mask {
> +	TH1520_ADC_ACTUAL_CH0,
> +	TH1520_ADC_ACTUAL_CH1,
> +	TH1520_ADC_ACTUAL_ALL,
> +

Excess blank line.

> +};
> +
> +enum int_delta_mask {
> +	TH1520_ADC_DETAL_CH0,
> +	TH1520_ADC_DETAL_CH1,
> +	TH1520_ADC_DETAL_ALL,
> +};
> +
> +struct th1520_adc_feature {
> +	enum selres_sel			selres_sel;
> +	enum input_mode_sel		input_mode;
> +	enum vol_ref			vol_ref;
> +	enum offset_mode_sel		offset_mode;
> +	enum conversion_mode_sel	conv_mode;
> +	enum clk_sel			clk_sel;
> +	enum int_actual_mask		int_actual;
> +	enum int_delta_mask		int_detal;
> +};
> +
> +struct th1520_adc {
> +	struct device			*dev;
> +	void __iomem			*regs;
> +	struct clk			*clk;
> +
> +	u32				vref_uv;
> +	u32				value;
> +	struct regulator		*vref;
> +	struct th1520_adc_feature	adc_feature;
> +	u32				current_clk;
> +	u32				ch0_offmeas;
> +	u32				ch1_offmeas;
As above - don't introduce this stuff until it is used by features
in the driver. Just hard code the defaults when you write the registers.
Then when control is enabled in a future patch, it's much more obvious
what has actually changed.

> +
> +	struct completion		completion;
> +	/* lock to protect against multiple access to the device */

More info please on why this is a problem.  Do we have read modify write
cycles, or sequences where we need to not change the config whilst
an ADC read is happening?

> +	struct mutex			mlock;
> +};
> +


