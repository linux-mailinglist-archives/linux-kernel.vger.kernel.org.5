Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC347D6655
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJYJLQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 05:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:11:13 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF13B9;
        Wed, 25 Oct 2023 02:11:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CFD9B24E203;
        Wed, 25 Oct 2023 17:10:59 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 17:10:59 +0800
Received: from [192.168.125.131] (183.27.99.126) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 25 Oct
 2023 17:10:58 +0800
Message-ID: <bb819333-52d3-49fc-9bb9-1a227bd5ca8f@starfivetech.com>
Date:   Wed, 25 Oct 2023 17:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Walker Chen <walker.chen@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20231019053501.46899-1-xingyu.wu@starfivetech.com>
 <20231019053501.46899-3-xingyu.wu@starfivetech.com>
 <3f76f965-7c7b-109e-2ee0-3033e332e84b@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <3f76f965-7c7b-109e-2ee0-3033e332e84b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.99.126]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/24 22:56, Daniel Lezcano wrote:
> 
> Hi Xingyu,
> 
> 
> On 19/10/2023 07:35, Xingyu Wu wrote:
>> Add timer driver for the StarFive JH7110 SoC.
> 
> As it is a new timer, please add a proper nice description explaining the timer hardware, thanks.

OK. Will add the description in next version.

> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>   MAINTAINERS                        |   7 +
>>   drivers/clocksource/Kconfig        |  11 +
>>   drivers/clocksource/Makefile       |   1 +
>>   drivers/clocksource/timer-jh7110.c | 380 +++++++++++++++++++++++++++++
>>   4 files changed, 399 insertions(+)
>>   create mode 100644 drivers/clocksource/timer-jh7110.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7a7bd8bd80e9..91c09b399131 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20473,6 +20473,13 @@ S:    Maintained
>>   F:    Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>>   F:    sound/soc/starfive/jh7110_tdm.c
>>   +STARFIVE JH7110 TIMER DRIVER
>> +M:    Samin Guo <samin.guo@starfivetech.com>
>> +M:    Xingyu Wu <xingyu.wu@starfivetech.com>
>> +S:    Supported
>> +F:    Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
>> +F:    drivers/clocksource/timer-jh7110.c
>> +
>>   STARFIVE JH71X0 CLOCK DRIVERS
>>   M:    Emil Renner Berthing <kernel@esmil.dk>
>>   M:    Hal Feng <hal.feng@starfivetech.com>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 0ba0dc4ecf06..821abcc1e517 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -641,6 +641,17 @@ config RISCV_TIMER
>>         is accessed via both the SBI and the rdcycle instruction.  This is
>>         required for all RISC-V systems.
>>   +config STARFIVE_JH7110_TIMER
>> +    bool "Timer for the STARFIVE JH7110 SoC"
>> +    depends on ARCH_STARFIVE || COMPILE_TEST
> 
> You may want to use ARCH_STARFIVE only if the platform can make this timer optional. Otherwise, set the option from the platform Kconfig and put the bool "bla bla" if COMPILE_TEST

Yes, this timer only be used on the StarFive SoC. So I intend to modify to this:

bool "Timer for the STARFIVE JH7110 SoC" if COMPILE_TEST
depends on ARCH_STARFIVE

> 
>> +    select TIMER_OF
>> +    select CLKSRC_MMIO
>> +    default ARCH_STARFIVE
> 
> no "default"

Will drop it.

> 
>> +    help
>> +      This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
>> +      the system has started RISCV_TIMER, but you can also use this timer
>> +      which can provide four channels to do a lot more things on JH7110 SoC.
>> +
>>   config CLINT_TIMER
>>       bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
>>       depends on GENERIC_SCHED_CLOCK && RISCV
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 368c3461dab8..b66ac05ec086 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)        += ingenic-timer.o
>>   obj-$(CONFIG_CLKSRC_ST_LPC)        += clksrc_st_lpc.o
>>   obj-$(CONFIG_X86_NUMACHIP)        += numachip.o
>>   obj-$(CONFIG_RISCV_TIMER)        += timer-riscv.o
>> +obj-$(CONFIG_STARFIVE_JH7110_TIMER)    += timer-jh7110.o
>>   obj-$(CONFIG_CLINT_TIMER)        += timer-clint.o
>>   obj-$(CONFIG_CSKY_MP_TIMER)        += timer-mp-csky.o
>>   obj-$(CONFIG_GX6605S_TIMER)        += timer-gx6605s.o
>> diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/timer-jh7110.c
>> new file mode 100644
>> index 000000000000..71de29a3ec91
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-jh7110.c
>> @@ -0,0 +1,380 @@
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
> 
> Please double check the headers and remove the pointless ones.

Will fix.

> 
> 
>> +/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
>> +#define JH7110_TIMER_CH_LEN        0x40
>> +#define JH7110_TIMER_CH_BASE(x)        ((x) * JH7110_TIMER_CH_LEN)
>> +#define JH7110_TIMER_CH_MAX        4
>> +
>> +#define JH7110_CLOCK_SOURCE_RATING    200
>> +#define JH7110_VALID_BITS        32
>> +#define JH7110_DELAY_US            0
>> +#define JH7110_TIMEOUT_US        10000
>> +#define JH7110_CLOCKEVENT_RATING    300
>> +#define JH7110_TIMER_MAX_TICKS        0xffffffff
>> +#define JH7110_TIMER_MIN_TICKS        0xf
>> +#define JH7110_TIMER_RELOAD_VALUE    0
>> +
>> +#define JH7110_TIMER_INT_STATUS        0x00 /* RO[0:4]: Interrupt Status for channel0~4 */
>> +#define JH7110_TIMER_CTL        0x04 /* RW[0]: 0-continuous run, 1-single run */
>> +#define JH7110_TIMER_LOAD        0x08 /* RW: load value to counter */
>> +#define JH7110_TIMER_ENABLE        0x10 /* RW[0]: timer enable register */
>> +#define JH7110_TIMER_RELOAD        0x14 /* RW: write 1 or 0 both reload counter */
>> +#define JH7110_TIMER_VALUE        0x18 /* RO: timer value register */
>> +#define JH7110_TIMER_INT_CLR        0x20 /* RW: timer interrupt clear register */
>> +#define JH7110_TIMER_INT_MASK        0x24 /* RW[0]: timer interrupt mask register */
>> +
>> +#define JH7110_TIMER_INT_CLR_ENA    BIT(0)
>> +#define JH7110_TIMER_INT_CLR_AVA_MASK    BIT(1)
>> +
>> +struct jh7110_clkevt {
>> +    struct clock_event_device evt;
>> +    struct clocksource cs;
>> +    bool cs_is_valid;
>> +    struct clk *clk;
>> +    struct reset_control *rst;
>> +    u32 rate;
>> +    u32 reload_val;
>> +    void __iomem *base;
>> +    char name[sizeof("jh7110-timer.chX")];
>> +};
>> +
>> +struct jh7110_timer_priv {
>> +    struct clk *pclk;
>> +    struct reset_control *prst;
>> +    struct jh7110_clkevt clkevt[JH7110_TIMER_CH_MAX];
> 
> Why do you need several clock events and clock sources ?

This timer has four counters (channels) which run independently. So each counter can have its own clock event and clock source to configure different settings.

> 
> [ ... ]
> 
> 

Thanks,
Xingyu Wu
