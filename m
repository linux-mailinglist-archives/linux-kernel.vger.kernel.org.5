Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA67CA3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjJPJO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjJPJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:13:59 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B976FF;
        Mon, 16 Oct 2023 02:13:47 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7D18980E2;
        Mon, 16 Oct 2023 17:13:39 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 17:13:39 +0800
Received: from [192.168.125.131] (183.27.98.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 16 Oct
 2023 17:13:38 +0800
Message-ID: <ec78d27e-8cc4-484e-aac9-e253498aa946@starfivetech.com>
Date:   Mon, 16 Oct 2023 17:07:32 +0800
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
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z8_AwYdgBLcAs=C9W2UtZ0CVecGMS_D198A8j4DYFFxBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/13 19:34, Emil Renner Berthing wrote:
> Xingyu Wu wrote:
>> Add timer driver for the StarFive JH7110 SoC.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  MAINTAINERS                        |   7 +
>>  drivers/clocksource/Kconfig        |  11 +
>>  drivers/clocksource/Makefile       |   1 +
>>  drivers/clocksource/timer-jh7110.c | 387 +++++++++++++++++++++++++++++
>>  4 files changed, 406 insertions(+)
>>  create mode 100644 drivers/clocksource/timer-jh7110.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6c4cce45a09d..1525f031d4a2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20472,6 +20472,13 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>>  F:	sound/soc/starfive/jh7110_tdm.c
>>
>> +STARFIVE JH7110 TIMER DRIVER
>> +M:	Samin Guo <samin.guo@starfivetech.com>
>> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
>> +F:	drivers/clocksource/timer-jh7110.c
>> +
>>  STARFIVE JH71X0 CLOCK DRIVERS
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  M:	Hal Feng <hal.feng@starfivetech.com>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 0ba0dc4ecf06..821abcc1e517 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -641,6 +641,17 @@ config RISCV_TIMER
>>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>>  	  required for all RISC-V systems.
>>
>> +config STARFIVE_JH7110_TIMER
>> +	bool "Timer for the STARFIVE JH7110 SoC"
>> +	depends on ARCH_STARFIVE || COMPILE_TEST
>> +	select TIMER_OF
>> +	select CLKSRC_MMIO
>> +	default ARCH_STARFIVE
>> +	help
>> +	  This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
>> +	  the system has started RISCV_TIMER, but you can also use this timer
>> +	  which can provide four channels to do a lot more things on JH7110 SoC.
>> +
>>  config CLINT_TIMER
>>  	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
>>  	depends on GENERIC_SCHED_CLOCK && RISCV
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 368c3461dab8..b66ac05ec086 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
>>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>>  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>> +obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+= timer-jh7110.o
>>  obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
>>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>> diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/timer-jh7110.c
>> new file mode 100644
>> index 000000000000..914424368290
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-jh7110.c
>> @@ -0,0 +1,387 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Starfive JH7110 Timer driver
>> + *
>> + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
>> + *
>> + * Author:
>> + * Xingyu Wu <xingyu.wu@starfivetech.com>
>> + * Samin Guo <samin.guo@starfivetech.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/sched_clock.h>
>> +
>> +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
>> +#define JH7110_TIMER_CH_LEN		0x40
>> +#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
>> +#define JH7110_TIMER_CH_MAX		4
>> +
>> +#define JH7110_CLOCK_SOURCE_RATING	200
>> +#define JH7110_VALID_BITS		32
>> +#define JH7110_DELAY_US			0
>> +#define JH7110_TIMEOUT_US		10000
>> +#define JH7110_CLOCKEVENT_RATING	300
>> +#define JH7110_TIMER_MAX_TICKS		0xffffffff
>> +#define JH7110_TIMER_MIN_TICKS		0xf
>> +#define JH7110_TIMER_NAME_NUM		19
>> +
>> +#define JH7110_TIMER_INT_STATUS		0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
>> +#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single run */
>> +#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
>> +#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
>> +#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload counter */
>> +#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
>> +#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear register */
>> +#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt mask register */
>> +#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
>> +
>> +struct jh7110_clkevt {
>> +	struct clock_event_device evt;
>> +	struct clocksource cs;
>> +	struct clk *clk;
>> +	char name[JH7110_TIMER_NAME_NUM];
> 
> Instead of this define maybe just use something like
> 
> 	char name[sizeof("jh7110-timer.chX")];
> 

Will fix.

>> +	int irq;
> 
> You wrote that you "dropped the extra copy of irq", but here you didn't.

What I mean is to drop the local variable of irq in the probe. Do you mean to use a local variable instead this in the probe?

> 
>> +	u32 rate;
>> +	u32 reload_val;
>> +	void __iomem *base;
>> +};
>> +
>> +static inline struct jh7110_clkevt *to_jh7110_clkevt(struct clock_event_device *evt)
>> +{
>> +	return container_of(evt, struct jh7110_clkevt, evt);
>> +}
>> +
>> +/* 0:continuous-run mode, 1:single-run mode */
>> +static inline void jh7110_timer_set_continuous_mod(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(0, clkevt->base + JH7110_TIMER_CTL);
>> +}
>> +
>> +static inline void jh7110_timer_set_single_mod(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(1, clkevt->base + JH7110_TIMER_CTL);
>> +}
>> +
>> +/* Interrupt Mask Register, 0:Unmask, 1:Mask */
>> +static inline void jh7110_timer_int_enable(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(0, clkevt->base + JH7110_TIMER_INT_MASK);
>> +}
>> +
>> +static inline void jh7110_timer_int_disable(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(1, clkevt->base + JH7110_TIMER_INT_MASK);
>> +}
> 
> I really don't think all these wrappers make the code any clearer. Please just
> inline the writel() calls. What you can do to make it a bit clearer is
> something like
> 
> enum {
> 	JH7110_TIMER_MODE_CONTINUOUS,
> 	JH7110_TIMER_MODE_SINGLE,
> };
> 
> so you can write
> 
> 	writel(JH7110_TIMER_MODE_CONTINUOUS, clkevt->base + JH7110_TIMER_CTL);
> 

Will fix.

>> +
>> +/*
>> + * BIT(0): Read value represent channel intr status.
>> + * Write 1 to this bit to clear interrupt. Write 0 has no effects.
>> + * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be written.
>> + */
>> +static inline int jh7110_timer_int_clear(struct jh7110_clkevt *clkevt)
>> +{
>> +	u32 value;
>> +	int ret;
>> +
>> +	/* waiting interrupt can be to clearing */
>> +	ret = readl_poll_timeout_atomic(clkevt->base + JH7110_TIMER_INT_CLR, value,
>> +					!(value & JH7110_TIMER_INT_CLR_AVA_MASK),
>> +					JH7110_DELAY_US, JH7110_TIMEOUT_US);
>> +	if (!ret)
>> +		writel(0x1, clkevt->base + JH7110_TIMER_INT_CLR);
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The initial value to be loaded into the
>> + * counter and is also used as the reload value.
>> + * val = clock rate --> 1s
>> + */
>> +static inline void jh7110_timer_set_load(struct jh7110_clkevt *clkevt, u32 val)
>> +{
>> +	writel(val, clkevt->base + JH7110_TIMER_LOAD);
>> +}
>> +
>> +static inline u32 jh7110_timer_get_val(struct jh7110_clkevt *clkevt)
>> +{
>> +	return readl(clkevt->base + JH7110_TIMER_VALUE);
>> +}
>> +
>> +/*
>> + * Write RELOAD register to reload preset value to counter.
>> + * Write 0 and write 1 are both ok.
>> + */
>> +static inline void jh7110_timer_set_reload(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(0, clkevt->base + JH7110_TIMER_RELOAD);
>> +}
>> +
>> +static inline void jh7110_timer_enable(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(1, clkevt->base + JH7110_TIMER_ENABLE);
>> +}
>> +
>> +static inline void jh7110_timer_disable(struct jh7110_clkevt *clkevt)
>> +{
>> +	writel(0, clkevt->base + JH7110_TIMER_ENABLE);
>> +}
> 
> The same thing goes for all these wrappers. If you do insist on having these
> wrappers then at least group them all together so you can quickly scroll past
> them to get to the "real" code.

Will fix.

> 
>> +
>> +static int jh7110_timer_int_init_enable(struct jh7110_clkevt *clkevt)
>> +{
>> +	int ret;
>> +
>> +	jh7110_timer_int_disable(clkevt);
>> +	ret = jh7110_timer_int_clear(clkevt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	jh7110_timer_int_enable(clkevt);
>> +	jh7110_timer_enable(clkevt);
>> +
>> +	return 0;
>> +}
>> +
>> +static int jh7110_timer_shutdown(struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	jh7110_timer_disable(clkevt);
>> +	return jh7110_timer_int_clear(clkevt);
>> +}
>> +
>> +static void jh7110_timer_suspend(struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	clkevt->reload_val = jh7110_timer_get_val(clkevt);
>> +	jh7110_timer_shutdown(evt);
>> +}
>> +
>> +static void jh7110_timer_resume(struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	jh7110_timer_set_load(clkevt, clkevt->reload_val);
>> +	jh7110_timer_set_reload(clkevt);
>> +	jh7110_timer_int_enable(clkevt);
>> +	jh7110_timer_enable(clkevt);
>> +}
>> +
>> +static int jh7110_timer_tick_resume(struct clock_event_device *evt)
>> +{
>> +	jh7110_timer_resume(evt);
>> +
>> +	return 0;
>> +}
>> +
>> +/* IRQ handler for the timer */
>> +static irqreturn_t jh7110_timer_interrupt(int irq, void *priv)
>> +{
>> +	struct clock_event_device *evt = (struct clock_event_device *)priv;
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	if (jh7110_timer_int_clear(clkevt))
>> +		return IRQ_NONE;
>> +
>> +	if (evt->event_handler)
>> +		evt->event_handler(evt);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int jh7110_timer_set_periodic(struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +	u32 periodic = DIV_ROUND_CLOSEST(clkevt->rate, HZ);
>> +
>> +	jh7110_timer_disable(clkevt);
>> +	jh7110_timer_set_continuous_mod(clkevt);
>> +	jh7110_timer_set_load(clkevt, periodic);
>> +
>> +	return jh7110_timer_int_init_enable(clkevt);
>> +}
>> +
>> +static int jh7110_timer_set_oneshot(struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	jh7110_timer_disable(clkevt);
>> +	jh7110_timer_set_single_mod(clkevt);
>> +	jh7110_timer_set_load(clkevt, JH7110_TIMER_MAX_TICKS);
>> +
>> +	return jh7110_timer_int_init_enable(clkevt);
>> +}
>> +
>> +static int jh7110_timer_set_next_event(unsigned long next,
>> +				       struct clock_event_device *evt)
>> +{
>> +	struct jh7110_clkevt *clkevt = to_jh7110_clkevt(evt);
>> +
>> +	jh7110_timer_disable(clkevt);
>> +	jh7110_timer_set_single_mod(clkevt);
>> +	jh7110_timer_set_load(clkevt, next);
>> +	jh7110_timer_enable(clkevt);
>> +
>> +	return 0;
>> +}
>> +
>> +static void jh7110_set_clockevent(struct clock_event_device *evt)
>> +{
>> +	evt->features = CLOCK_EVT_FEAT_PERIODIC |
>> +			CLOCK_EVT_FEAT_ONESHOT |
>> +			CLOCK_EVT_FEAT_DYNIRQ;
>> +	evt->set_state_shutdown = jh7110_timer_shutdown;
>> +	evt->set_state_periodic = jh7110_timer_set_periodic;
>> +	evt->set_state_oneshot = jh7110_timer_set_oneshot;
>> +	evt->set_state_oneshot_stopped = jh7110_timer_shutdown;
>> +	evt->tick_resume = jh7110_timer_tick_resume;
>> +	evt->set_next_event = jh7110_timer_set_next_event;
>> +	evt->suspend = jh7110_timer_suspend;
>> +	evt->resume = jh7110_timer_resume;
>> +	evt->rating = JH7110_CLOCKEVENT_RATING;
>> +}
>> +
>> +static u64 jh7110_timer_clocksource_read(struct clocksource *cs)
>> +{
>> +	struct jh7110_clkevt *clkevt = container_of(cs, struct jh7110_clkevt, cs);
>> +
>> +	return (u64)jh7110_timer_get_val(clkevt);
>> +}
>> +
>> +static int jh7110_clocksource_init(struct jh7110_clkevt *clkevt)
>> +{
>> +	int ret;
>> +
>> +	jh7110_timer_set_continuous_mod(clkevt);
>> +	jh7110_timer_set_load(clkevt, JH7110_TIMER_MAX_TICKS);
>> +
>> +	ret = jh7110_timer_int_init_enable(clkevt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	clkevt->cs.name = clkevt->name;
>> +	clkevt->cs.rating = JH7110_CLOCK_SOURCE_RATING;
>> +	clkevt->cs.read = jh7110_timer_clocksource_read;
>> +	clkevt->cs.mask = CLOCKSOURCE_MASK(JH7110_VALID_BITS);
>> +	clkevt->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>> +
>> +	return clocksource_register_hz(&clkevt->cs, clkevt->rate);
>> +}
>> +
>> +static void jh7110_clockevents_register(struct jh7110_clkevt *clkevt)
>> +{
>> +	clkevt->rate = clk_get_rate(clkevt->clk);
>> +
>> +	jh7110_set_clockevent(&clkevt->evt);
>> +	clkevt->evt.name = clkevt->name;
>> +	clkevt->evt.cpumask = cpu_possible_mask;
>> +
>> +	clockevents_config_and_register(&clkevt->evt, clkevt->rate,
>> +					JH7110_TIMER_MIN_TICKS, JH7110_TIMER_MAX_TICKS);
>> +}
>> +
>> +static int jh7110_timer_probe(struct platform_device *pdev)
>> +{
>> +	struct jh7110_clkevt *clkevt[JH7110_TIMER_CH_MAX];
>> +	char name[4];
>> +	struct clk *pclk;
>> +	struct reset_control *rst;
>> +	int ch;
>> +	int ret;
>> +	void __iomem *base;
>> +
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
>> +				     "failed to map registers\n");
>> +
>> +	rst = devm_reset_control_get_exclusive(&pdev->dev, "apb");
>> +	if (IS_ERR(rst))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get apb reset\n");
>> +
>> +	pclk = devm_clk_get_enabled(&pdev->dev, "apb");
>> +	if (IS_ERR(pclk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>> +				     "failed to get & enable apb clock\n");
>> +
>> +	ret = reset_control_deassert(rst);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n");
>> +
>> +	for (ch = 0; ch < JH7110_TIMER_CH_MAX; ch++) {
>> +		clkevt[ch] = devm_kzalloc(&pdev->dev, sizeof(*clkevt[ch]), GFP_KERNEL);
>> +		if (!clkevt[ch])
>> +			return -ENOMEM;
>> +
>> +		snprintf(name, sizeof(name), "ch%d", ch);
>> +
>> +		clkevt[ch]->base = base + JH7110_TIMER_CH_BASE(ch);
>> +		/* Ensure timer is disabled */
>> +		jh7110_timer_disable(clkevt[ch]);
>> +
>> +		rst = devm_reset_control_get_exclusive(&pdev->dev, name);
>> +		if (IS_ERR(rst))
>> +			return PTR_ERR(rst);
>> +
>> +		clkevt[ch]->clk = devm_clk_get_enabled(&pdev->dev, name);
>> +		if (IS_ERR(clkevt[ch]->clk))
>> +			return PTR_ERR(clkevt[ch]->clk);
>> +
>> +		ret = reset_control_deassert(rst);
>> +		if (ret)
>> +			return ret;
>> +
>> +		clkevt[ch]->evt.irq = platform_get_irq(pdev, ch);
>> +		if (clkevt[ch]->evt.irq < 0)
>> +			return clkevt[ch]->evt.irq;
>> +
>> +		snprintf(clkevt[ch]->name, sizeof(clkevt[ch]->name), "%s.ch%d", pdev->name, ch);
>> +		jh7110_clockevents_register(clkevt[ch]);
>> +
>> +		ret = devm_request_irq(&pdev->dev, clkevt[ch]->evt.irq, jh7110_timer_interrupt,
>> +				       IRQF_TIMER | IRQF_IRQPOLL,
>> +				       clkevt[ch]->name, &clkevt[ch]->evt);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = jh7110_clocksource_init(clkevt[ch]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id jh7110_timer_match[] = {
>> +	{ .compatible = "starfive,jh7110-timer", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, jh7110_timer_match);
>> +
>> +static struct platform_driver jh7110_timer_driver = {
>> +	.probe = jh7110_timer_probe,
>> +	.driver = {
>> +		.name = "jh7110-timer",
>> +		.of_match_table = jh7110_timer_match,
>> +	},
>> +};
>> +module_platform_driver(jh7110_timer_driver);
>> +
>> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
>> +MODULE_DESCRIPTION("StarFive JH7110 timer driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

Best regards,
Xingyu Wu

