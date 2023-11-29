Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F337FD40F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjK2KZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 05:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2KZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:25:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375EBA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:25:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8Hki-0002FE-Mm; Wed, 29 Nov 2023 11:25:08 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8Hkg-00CNkH-7g; Wed, 29 Nov 2023 11:25:06 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8Hkg-0004mQ-0U;
        Wed, 29 Nov 2023 11:25:06 +0100
Message-ID: <7d619d05314c51a4cb6ba3188d9f4b17a0b1aa31.camel@pengutronix.de>
Subject: Re: [PATCH v8 2/4] pwm: opencores: Add PWM driver support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Date:   Wed, 29 Nov 2023 11:25:06 +0100
In-Reply-To: <20231129092732.43387-3-william.qiu@starfivetech.com>
References: <20231129092732.43387-1-william.qiu@starfivetech.com>
         <20231129092732.43387-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2023-11-29 at 17:27 +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
> 
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 232 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 012df8ccf34e..ae6a7be47bc9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16206,6 +16206,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
>  
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d87e1bb350ba 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
>  
> +config PWM_OCORES
> +	tristate "OpenCores PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..517c4f643058 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..d96318b18570
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only do inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* OCPWM_CTRL register bits*/
> +#define REG_OCPWM_EN      BIT(0)
> +#define REG_OCPWM_ECLK    BIT(1)
> +#define REG_OCPWM_NEC     BIT(2)
> +#define REG_OCPWM_OE      BIT(3)
> +#define REG_OCPWM_SIGNLE  BIT(4)
> +#define REG_OCPWM_INTE    BIT(5)
> +#define REG_OCPWM_INT     BIT(6)
> +#define REG_OCPWM_CNTRRST BIT(7)
> +#define REG_OCPWM_CAPTE   BIT(8)
> +
> +struct ocores_pwm_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	const struct ocores_pwm_data *data;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> +};
> +
> +static inline u32 ocores_readl(struct ocores_pwm_device *ddata,
> +			       unsigned int channel,
> +			       unsigned int offset)
> +{
> +	void __iomem *base = ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	return readl(base + offset);
> +}
> +
> +static inline void ocores_writel(struct ocores_pwm_device *ddata,
> +				 unsigned int channel,
> +				 unsigned int offset, u32 val)
> +{
> +	void __iomem *base = ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	writel(val, base + offset);
> +}
> +
> +static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ocores_pwm_device, chip);
> +}
> +
> +static void __iomem *starfive_jh71x0_get_ch_base(void __iomem *base,
> +						 unsigned int channel)
> +{
> +	unsigned int offset = (channel > 3 ? 1 << 15 : 0) + (channel & 3) * 0x10;
> +
> +	return base + offset;
> +}
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data = ocores_readl(ddata, pwm->hwpwm, 0x8);
> +	duty_data = ocores_readl(ddata, pwm->hwpwm, 0x4);
> +	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +
> +	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
> +	state->polarity = PWM_POLARITY_INVERSED;
> +	state->enabled = (ctrl_data & REG_OCPWM_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 ctrl_data = 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
> +
> +	period_data = DIV_ROUND_DOWN_ULL(state->period * ddata->clk_rate, NSEC_PER_SEC);
> +	if (period_data <= U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
> +	else
> +		return -EINVAL;
> +
> +	duty_data = DIV_ROUND_DOWN_ULL(state->duty_cycle * ddata->clk_rate, NSEC_PER_SEC);
> +	if (duty_data <= U32_MAX)
> +		ocores_writel(ddata, pwm->hwpwm, 0x4, (u32)duty_data);
> +	else
> +		return -EINVAL;
> +
> +	ocores_writel(ddata, pwm->hwpwm, 0xC, 0);
> +
> +	if (state->enabled) {
> +		ctrl_data = ocores_readl(ddata, pwm->hwpwm, 0xC);
> +		ocores_writel(ddata, pwm->hwpwm, 0xC, ctrl_data | REG_OCPWM_EN | REG_OCPWM_OE);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops = {
> +	.get_state	= ocores_pwm_get_state,
> +	.apply		= ocores_pwm_apply,
> +};
> +
> +static const struct ocores_pwm_data jh7100_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct ocores_pwm_data jh7110_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] = {
> +	{ .compatible = "opencores,pwm-v1" },
> +	{ .compatible = "starfive,jh7100-pwm", .data = &jh7100_pwm_data},
> +	{ .compatible = "starfive,jh7110-pwm", .data = &jh7110_pwm_data},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
> +
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev = &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	id = of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->data = id->data;
> +	chip = &ddata->chip;
> +	chip->dev = dev;
> +	chip->ops = &ocores_pwm_ops;
> +	chip->npwm = 8;
> +	chip->of_pwm_n_cells = 3;
> +
> +	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	ddata->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ddata->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	reset_control_deassert(ddata->rst);

You could use devm_add_action_or_reset() to add reset assertion for
driver removal and the error paths here, allowing to drop
ocores_pwm_remove() and ...

> +	ddata->clk_rate = clk_get_rate(ddata->clk);
> +	if (ddata->clk_rate <= 0)
> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");

... then this wouldn't leave the reset deasserted ...

> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		reset_control_assert(ddata->rst);

... and this could be dropped.

> +		clk_disable_unprepare(ddata->clk);

This can be dropped, devm_clk_get_enabled() already disables the clock
on probe error.

> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	return ret;
> +}
> +
> +static void ocores_pwm_remove(struct platform_device *dev)
> +{
> +	struct ocores_pwm_device *ddata = platform_get_drvdata(dev);
> +
> +	reset_control_assert(ddata->rst);
> +	clk_disable_unprepare(ddata->clk);

Drop as well, devm_clk_get_enabled() already disables the clock on
driver removal.

regards
Philipp
