Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7379E579
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjIMK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbjIMK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:57:12 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461919B0;
        Wed, 13 Sep 2023 03:57:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 21BE524DBBE;
        Wed, 13 Sep 2023 18:57:05 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 18:57:05 +0800
Received: from [192.168.120.76] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 18:57:03 +0800
Message-ID: <c5fe3168-05b5-586c-f81c-f153a3e7c42f@starfivetech.com>
Date:   Wed, 13 Sep 2023 18:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC v4 2/4] pwm: starfive: Add PWM driver support
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230825081328.204442-1-william.qiu@starfivetech.com>
 <20230825081328.204442-3-william.qiu@starfivetech.com>
 <CAJM55Z9RsV7qGr6LUckg2XOeS2xjFO8tki3F4LoJj4COQv8dJw@mail.gmail.com>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z9RsV7qGr6LUckg2XOeS2xjFO8tki3F4LoJj4COQv8dJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/12 23:04, Emil Renner Berthing wrote:
> William Qiu wrote:
>> Add Pulse Width Modulation driver support for StarFive
>> JH7100 and JH7110 SoC.
>>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  MAINTAINERS                    |   7 ++
>>  drivers/pwm/Kconfig            |   9 ++
>>  drivers/pwm/Makefile           |   1 +
>>  drivers/pwm/pwm-starfive-ptc.c | 192 +++++++++++++++++++++++++++++++++
>>  4 files changed, 209 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d590ce31aa72..0e47818c6f64 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20299,6 +20299,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>>
>> +STARFIVE JH71X0 PWM DRIVERS
>> +M:	William Qiu <william.qiu@starfivetech.com>
>> +M:	Hal Feng <hal.feng@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/pwm/starfive,jh7100-pwm.yaml
>> +F:	drivers/pwm/pwm-starfive-ptc.c
>> +
>>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  M:	Hal Feng <hal.feng@starfivetech.com>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 6210babb0741..48800f33b5c1 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -569,6 +569,15 @@ config PWM_SPRD
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-sprd.
>>
>> +config PWM_STARFIVE_PTC
>> +	tristate "StarFive PWM PTC support"
>> +	depends on ARCH_STARFIVE || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for StarFive SoCs.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-starfive-ptc.
> 
> What is PTC short for? Are there other PWM peripherals on the JH7100 or JH7110
> that are not PTCs?
> 
> If there are both PTC and non-PTC PWMs on these SoCs then the device tree
> compatible strings should reflect that.
> 
> If not, maybe just call this driver pwm-starfive / PWM_STARFIVE, or maybe
> pwm-starfive-jh7100 / PWM_STARFIVE_JH7110 if you already know the PWMs on the
> JH81xx will be different.
> 
Will update.
>> +
>>  config PWM_STI
>>  	tristate "STiH4xx PWM support"
>>  	depends on ARCH_STI || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index c822389c2a24..d2b2a3aeea22 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>> +obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
>>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>> diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
>> new file mode 100644
>> index 000000000000..57b5736f6732
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-starfive-ptc.c
>> @@ -0,0 +1,192 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PWM driver for the StarFive JH71x0 SoC
>> + *
>> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +/* Access PTC register (CNTR, HRC, LRC and CTRL) */
>> +#define REG_PTC_BASE_ADDR_SUB(base, N)	\
>> +((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
> 
> Please indent the line above.
> 
Will update.
>> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
>> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
>> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
>> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
>> +
>> +/* PTC_RPTC_CTRL register bits*/
>> +#define PTC_EN      BIT(0)
>> +#define PTC_ECLK    BIT(1)
>> +#define PTC_NEC     BIT(2)
>> +#define PTC_OE      BIT(3)
>> +#define PTC_SIGNLE  BIT(4)
>> +#define PTC_INTE    BIT(5)
>> +#define PTC_INT     BIT(6)
>> +#define PTC_CNTRRST BIT(7)
>> +#define PTC_CAPTE   BIT(8)
>> +
>> +struct starfive_pwm_ptc_device {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	struct reset_control *rst;
>> +	void __iomem *regs;
>> +	u32 clk_rate; /* PWM APB clock frequency */
>> +};
>> +
>> +static inline
>> +struct starfive_pwm_ptc_device *chip_to_starfive_ptc(struct pwm_chip *c)
> 
> This looks weird. Either just put it on a single line or split between the type
> and function name. Also there was recently a patch to always name pwm_chip
> variables "chip".  Eg.
> 
> static inline struct starfive_pwm_ptc_device *
> chip_to_starfive_ptc(struct pwm_chip *chip)
> {
> 
Will update.
> 
>> +{
>> +	return container_of(c, struct starfive_pwm_ptc_device, chip);
>> +}
>> +
>> +static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
>> +				      struct pwm_device *dev,
>> +				      struct pwm_state *state)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
>> +	u32 period_data, duty_data, ctrl_data;
>> +
>> +	period_data = readl(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
>> +	duty_data = readl(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
>> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
>> +
>> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
>> +	state->polarity = PWM_POLARITY_INVERSED;
>> +	state->enabled = (ctrl_data & PTC_EN) ? true : false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
>> +				  struct pwm_device *dev,
>> +				  const struct pwm_state *state)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
>> +	u32 period_data, duty_data, ctrl_data = 0;
>> +
>> +	if (state->polarity != PWM_POLARITY_INVERSED)
>> +		return -EINVAL;
>> +
>> +	period_data = DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,
>> +					    NSEC_PER_SEC);
>> +	duty_data = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
>> +					  NSEC_PER_SEC);
>> +
>> +	writel(period_data, REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
>> +	writel(duty_data, REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
>> +	writel(0,  REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm));
>> +
>> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
>> +	if (state->enabled)
>> +		writel(ctrl_data | PTC_EN | PTC_OE, REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
>> +	else
>> +		writel(ctrl_data & ~(PTC_EN | PTC_OE), REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops starfive_pwm_ptc_ops = {
>> +	.get_state	= starfive_pwm_ptc_get_state,
>> +	.apply		= starfive_pwm_ptc_apply,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct starfive_pwm_ptc_device *pwm;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	chip = &pwm->chip;
>> +	chip->dev = dev;
>> +	chip->ops = &starfive_pwm_ptc_ops;
>> +	chip->npwm = 8;
>> +	chip->of_pwm_n_cells = 3;
>> +
>> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pwm->regs))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
>> +				     "Unable to map IO resources\n");
>> +
>> +	pwm->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +				     "Unable to get pwm's clock\n");
> 
> I think you can use devm_clk_get_enabled() here and drop the .clk field and
> clk_prepare_enable() and clk_disable_unprepare() calls below.
> 
Will update.

Thanks for taking time to review this patch series.

Best Regards,
William
>> +
>> +	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pwm->rst))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->rst),
>> +				     "Unable to get pwm's reset\n");
>> +
>> +	ret = clk_prepare_enable(pwm->clk);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to enable clock for pwm: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	reset_control_deassert(pwm->rst);
> 
> This returns an int that you ignore. Please don't do that.
> 
>> +
>> +	pwm->clk_rate = clk_get_rate(pwm->clk);
>> +	if (pwm->clk_rate <= 0) {
>> +		dev_warn(dev, "Failed to get APB clock rate\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot register PTC: %d\n", ret);
>> +		clk_disable_unprepare(pwm->clk);
>> +		reset_control_assert(pwm->rst);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
>> +
>> +	reset_control_assert(pwm->rst);
>> +	clk_disable_unprepare(pwm->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id starfive_pwm_ptc_of_match[] = {
>> +	{ .compatible = "starfive,jh7100-pwm" },
>> +	{ .compatible = "starfive,jh7110-pwm" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
>> +
>> +static struct platform_driver starfive_pwm_ptc_driver = {
>> +	.probe = starfive_pwm_ptc_probe,
>> +	.remove = starfive_pwm_ptc_remove,
>> +	.driver = {
>> +		.name = "pwm-starfive-ptc",
>> +		.of_match_table = starfive_pwm_ptc_of_match,
>> +	},
>> +};
>> +module_platform_driver(starfive_pwm_ptc_driver);
>> +
>> +MODULE_AUTHOR("Jieqin Chen");
>> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
>> +MODULE_DESCRIPTION("StarFive PWM PTC driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
