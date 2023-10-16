Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2CC7CA4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjJPKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJPKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:13:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA520B4;
        Mon, 16 Oct 2023 03:13:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A0FE118141;
        Mon, 16 Oct 2023 18:13:47 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 18:13:47 +0800
Received: from [192.168.125.131] (183.27.98.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 18:13:46 +0800
Message-ID: <4503625e-c696-4ed5-84b3-398bbb243162@starfivetech.com>
Date:   Mon, 16 Oct 2023 18:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Walker Chen" <walker.chen@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20231012081015.33121-1-xingyu.wu@starfivetech.com>
 <20231012081015.33121-3-xingyu.wu@starfivetech.com>
 <CAJM55Z8_AwYdgBLcAs=C9W2UtZ0CVecGMS_D198A8j4DYFFxBw@mail.gmail.com>
 <ec78d27e-8cc4-484e-aac9-e253498aa946@starfivetech.com>
 <CAJM55Z9HCLWAB0G-froC1bEDk=DERQhKvSD7w+eQ_6a3J+74wg@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z9HCLWAB0G-froC1bEDk=DERQhKvSD7w+eQ_6a3J+74wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 17:23, Emil Renner Berthing wrote:
> Xingyu Wu wrote:
>> On 2023/10/13 19:34, Emil Renner Berthing wrote:
>> > Xingyu Wu wrote:
>> >> Add timer driver for the StarFive JH7110 SoC.
>> >>
>> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> ---
>> >>  MAINTAINERS                        |   7 +
>> >>  drivers/clocksource/Kconfig        |  11 +
>> >>  drivers/clocksource/Makefile       |   1 +
>> >>  drivers/clocksource/timer-jh7110.c | 387 +++++++++++++++++++++++++++++
>> >>  4 files changed, 406 insertions(+)
>> >>  create mode 100644 drivers/clocksource/timer-jh7110.c
>> >>
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index 6c4cce45a09d..1525f031d4a2 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -20472,6 +20472,13 @@ S:	Maintained
>> >>  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>> >>  F:	sound/soc/starfive/jh7110_tdm.c
>> >>
>> >> +STARFIVE JH7110 TIMER DRIVER
>> >> +M:	Samin Guo <samin.guo@starfivetech.com>
>> >> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> +S:	Supported
>> >> +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
>> >> +F:	drivers/clocksource/timer-jh7110.c
>> >> +
>> >>  STARFIVE JH71X0 CLOCK DRIVERS
>> >>  M:	Emil Renner Berthing <kernel@esmil.dk>
>> >>  M:	Hal Feng <hal.feng@starfivetech.com>
>> >> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> >> index 0ba0dc4ecf06..821abcc1e517 100644
>> >> --- a/drivers/clocksource/Kconfig
>> >> +++ b/drivers/clocksource/Kconfig
>> >> @@ -641,6 +641,17 @@ config RISCV_TIMER
>> >>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>> >>  	  required for all RISC-V systems.
>> >>
>> >> +config STARFIVE_JH7110_TIMER
>> >> +	bool "Timer for the STARFIVE JH7110 SoC"
>> >> +	depends on ARCH_STARFIVE || COMPILE_TEST
>> >> +	select TIMER_OF
>> >> +	select CLKSRC_MMIO
>> >> +	default ARCH_STARFIVE
>> >> +	help
>> >> +	  This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
>> >> +	  the system has started RISCV_TIMER, but you can also use this timer
>> >> +	  which can provide four channels to do a lot more things on JH7110 SoC.
>> >> +
>> >>  config CLINT_TIMER
>> >>  	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
>> >>  	depends on GENERIC_SCHED_CLOCK && RISCV
>> >> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> >> index 368c3461dab8..b66ac05ec086 100644
>> >> --- a/drivers/clocksource/Makefile
>> >> +++ b/drivers/clocksource/Makefile
>> >> @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
>> >>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>> >>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>> >>  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>> >> +obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+= timer-jh7110.o
>> >>  obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
>> >>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>> >>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>> >> diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/timer-jh7110.c
>> >> new file mode 100644
>> >> index 000000000000..914424368290
>> >> --- /dev/null
>> >> +++ b/drivers/clocksource/timer-jh7110.c
>> >> @@ -0,0 +1,387 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/*
>> >> + * Starfive JH7110 Timer driver
>> >> + *
>> >> + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
>> >> + *
>> >> + * Author:
>> >> + * Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> + * Samin Guo <samin.guo@starfivetech.com>
>> >> + */
>> >> +
>> >> +#include <linux/clk.h>
>> >> +#include <linux/clockchips.h>
>> >> +#include <linux/clocksource.h>
>> >> +#include <linux/err.h>
>> >> +#include <linux/interrupt.h>
>> >> +#include <linux/io.h>
>> >> +#include <linux/iopoll.h>
>> >> +#include <linux/irq.h>
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/module.h>
>> >> +#include <linux/of.h>
>> >> +#include <linux/of_device.h>
>> >> +#include <linux/platform_device.h>
>> >> +#include <linux/reset.h>
>> >> +#include <linux/sched_clock.h>
>> >> +
>> >> +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
>> >> +#define JH7110_TIMER_CH_LEN		0x40
>> >> +#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
>> >> +#define JH7110_TIMER_CH_MAX		4
>> >> +
>> >> +#define JH7110_CLOCK_SOURCE_RATING	200
>> >> +#define JH7110_VALID_BITS		32
>> >> +#define JH7110_DELAY_US			0
>> >> +#define JH7110_TIMEOUT_US		10000
>> >> +#define JH7110_CLOCKEVENT_RATING	300
>> >> +#define JH7110_TIMER_MAX_TICKS		0xffffffff
>> >> +#define JH7110_TIMER_MIN_TICKS		0xf
>> >> +#define JH7110_TIMER_NAME_NUM		19
>> >> +
>> >> +#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
>> >> +#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single run */
>> >> +#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
>> >> +#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
>> >> +#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload counter */
>> >> +#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
>> >> +#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear register */
>> >> +#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt mask register */
>> >> +#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
>> >> +
>> >> +struct jh7110_clkevt {
>> >> +	struct clock_event_device evt;
>> >> +	struct clocksource cs;
>> >> +	struct clk *clk;
>> >> +	char name[JH7110_TIMER_NAME_NUM];
>> >
>> > Instead of this define maybe just use something like
>> >
>> > 	char name[sizeof("jh7110-timer.chX")];
>> >
>>
>> Will fix.
>>
>> >> +	int irq;
>> >
>> > You wrote that you "dropped the extra copy of irq", but here you didn't.
>>
>> What I mean is to drop the local variable of irq in the probe. Do you mean to use a local variable instead this in the probe?
> 
> No, what I mean is that this field is no longer used, so you can delete it.
> 

OK, drop it here.

>>
>> >> +
>> >> +static int jh7110_timer_probe(struct platform_device *pdev)
>> >> +{
>> >> +	struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
>> >> +	char name[4];
>> >> +	struct clk *pclk;
>> >> +	struct reset_control *rst;
>> >> +	int ch;
>> >> +	int ret;
>> >> +	void __iomem *base
>> >> +
>> >> +	base = devm_platform_ioremap_resource(pdev, 0);
>> >> +	if (IS_ERR(base))
>> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>> >> +				     "failed to map registers\n");
>> >> +
>> >> +	rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
>> >> +	if (IS_ERR(rst))
>> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
>> >> +
>> >> +	pclk = devm_clk_get_enabled(&pdev->dev, "apb");
>> >> +	if (IS_ERR(pclk))
>> >> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>> >> +				     "failed to get & enable apb clock\n");
>> >> +
>> >> +	ret = reset_control_deassert(rst);
>> >> +	if (ret)
>> >> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");
>> >> +
>> >> +	for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
>> >> +		clkevt[ch] = devm_kzalloc(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
>> >> +		if (!clkevt[ch])
>> >> +			return -ENOMEM;
>> >> +
>> >> +		snprintf(name, sizeof(name), "ch%d", ch);
>> >> +
>> >> +		clkevt[ch]->base = base + JH7110_TIMER_CH_BASE(ch);
>> >> +		/* Ensure timer is disabled */
>> >> +		jh7110_timer_disable(clkevt[ch]);
>> >> +
>> >> +		rst = devm_reset_control_get_exclusive(&pdev->dev, name);
>> >> +		if (IS_ERR(rst))
>> >> +			return PTR_ERR(rst);
>> >> +
>> >> +		clkevt[ch]->clk = devm_clk_get_enabled(&pdev->dev, name);
>> >> +		if (IS_ERR(clkevt[ch]->clk))
>> >> +			return PTR_ERR(clkevt[ch]->clk);
>> >> +
>> >> +		ret = reset_control_deassert(rst);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +
>> >> +		clkevt[ch]->evt.irq = platform_get_irq(pdev, ch);
>> >> +		if (clkevt[ch]->evt.irq < 0)
>> >> +			return clkevt[ch]->evt.irq;
I should use a local variable of irq instead here. Right?

>> >> +
>> >> +		snprintf(clkevt[ch]->name, sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
>> >> +		jh7110_clockevents_register(clkevt[ch]);
>> >> +
>> >> +		ret = devm_request_irq(&pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
>> >> +				       IRQF_TIMER | IRQF_IRQPOLL,
>> >> +				       clkevt[ch]->name, &clkevt[ch]->evt);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +
>> >> +		ret = jh7110_clocksource_init(clkevt[ch]);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static const struct of_device_id jh7110_timer_match[] = {
>> >> +	{ .compatible = "starfive,jh7110-timer", },
>> >> +	{ /* sentinel */ }
>> >> +};
>> >> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
>> >> +
>> >> +static struct platform_driver jh7110_timer_driver = {
>> >> +	.probe = jh7110_timer_probe,
>> >> +	.driver = {
>> >> +		.name = "jh7110-timer",
>> >> +		.of_match_table = jh7110_timer_match,
>> >> +	},
>> >> +};
>> >> +module_platform_driver(jh7110_timer_driver);
>> >> +
>> >> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
>> >> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
>> >> +MODULE_LICENSE("GPL");
>> >> --
>> >> 2.25.1

Thanks,
Xingyu Wu
