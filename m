Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843B67E4F94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjKHDvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Nov 2023 22:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHDvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:51:48 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B97ED7D;
        Tue,  7 Nov 2023 19:51:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2BE3C807C;
        Wed,  8 Nov 2023 11:51:37 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Nov
 2023 11:51:37 +0800
Received: from [192.168.125.131] (113.72.147.118) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Nov
 2023 11:51:35 +0800
Message-ID: <b402eb4d-a770-4988-8274-8a2544362229@starfivetech.com>
Date:   Wed, 8 Nov 2023 11:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
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
 <bb819333-52d3-49fc-9bb9-1a227bd5ca8f@starfivetech.com>
 <d0e70434-e273-4799-c5ec-bbee1b3f5cc7@linaro.org>
 <540136d4-6f8f-49a6-80ff-cc621f2f462b@starfivetech.com>
 <65c38717-3e0c-46d3-a124-29cae48f1a2e@linaro.org>
 <72ad5029-42b2-481a-887f-8f6079d8859b@starfivetech.com>
 <a8f0011c-5689-4071-b5e0-90bd6b7c66bc@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <a8f0011c-5689-4071-b5e0-90bd6b7c66bc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.147.118]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/2 22:29, Daniel Lezcano wrote:
> 
> Hi Xingyu,
> 
> On 02/11/2023 14:15, Xingyu Wu wrote:
> 
> [ ... ]
> 
>>>>>>>> +struct jh7110_clkevt { +    struct clock_event_device
>>>>>>>> evt; + struct clocksource cs; +    bool cs_is_valid; +
>>>>>>>> struct clk *clk; +    struct reset_control *rst; +    u32
>>>>>>>> rate; +    u32 reload_val; +    void __iomem *base; +
>>>>>>>> char name[sizeof("jh7110-timer.chX")]; +}; + +struct jh7110_timer_priv { +    struct clk *pclk; +    struct reset_control *prst; +    struct jh7110_clkevt clkevt[JH7110_TIMER_CH_MAX];
>>>>>>>
>>>>>>> Why do you need several clock events and clock sources ?
>>>>>>
>>>>>> This timer has four counters (channels) which run
>>>>>> independently. So each counter can have its own clock event
>>>>>> and clock source to configure different settings.
>>>>>
>>>>> The kernel only needs one clocksource. Usually multiple
>>>>> clockevents are per-cpu based system.
>>>>>
>>>>> The driver does not seem to have a per cpu timer but just initializing multiple clockevents which will end up unused,
>>>>> wasting energy.
>>>>>
>>>>>
>>>>
>>>> The board of the StarFive JH7110 SoC has two types of timer : riscv-timer and jh7110-timer. It boots by
>>>> riscv-timer(clocksource) and the jh7110-timer is optional and
>>>> additional. I think I should initialize the four channels of
>>>> jh7110-timer as clockevents not clocksource pre-cpu.
>>>
>>> If no clocksource is needed on this SoC because riscv timers are
>>> used, then it is not useful to register a clocksource for this
>>> timer and the corresponding code can go away.
>>>
>>> If the clockevent is optional why do you need this driver at all?
>>>
>>>
>>>
>>
>> Hi Daniel,
>>
>> Sorry, maybe I didn't express it clearly enough. I use this
>> jh7110-timer as a global timer on the SoC and riscv-timer as cpu
>> local timer. So these are something different.
>>
>> These four counters in this jh7110-timer are exactly the same and
>> independent of each other. If this timer is used as a global timer,
>> do I use only one or all of the counters to register clocksource and
>> clockevent?
> 
> Yes.
> 
> The global timer is only there when the CPU is powered down at idle time, so the time framework will switch to the broadcast timer and there can be only one instance.
> 
> If you register all the counters, only one will be used by the kernel, so it pointless to add them all.
> 
> On the clocksource side, you may want to question if it is really useful. The riscv has a clocksource with a higher rate and flagged as continuous [1]. So if the JH7110 clocksource is registered, it won't be used too.
> 
> Hope that helps
> 
>   -- Daniel
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/clocksource/timer-riscv.c#n68
> 

Thanks. The riscv-timer has a clocksource with a higher rating but a clockevent with lower rating[1] than jh7110-timer. I tested the jh7110-timer as clockevent and flagged as one shot, which could do some of the works instead of riscv-timer. And the current_clockevent changed to jh7110-timer.

Because the jh7110-timer works as clocksource with lower rating and only will be used as global timer at CPU idle time. Is it necessary to be registered as clocksource? If not, should it just be registered as clockevent?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/clocksource/timer-riscv.c#n45

Thanks,
Xingyu Wu
