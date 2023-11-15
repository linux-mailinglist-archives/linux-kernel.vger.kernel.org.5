Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343A7EBE42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjKOHxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 02:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:53:07 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70378F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:53:01 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 442CE7FEF;
        Wed, 15 Nov 2023 15:52:49 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 15:52:49 +0800
Received: from [192.168.100.10] (172.16.6.8) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 15:52:47 +0800
Message-ID: <f373645c-1e89-df76-e545-21bf0ba9ee8f@starfivetech.com>
Date:   Wed, 15 Nov 2023 15:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] clocksource/timer-risc: Add riscv_clock_shutdown
 callback
To:     Anup Patel <apatel@ventanamicro.com>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <leyfoon.tan@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20231115061811.10041-1-joshua.yeong@starfivetech.com>
 <CAK9=C2VXxNjKOq1XqQ9t6iVELdj2fFi85K77xNCOfdf3WRdy8w@mail.gmail.com>
Content-Language: en-US
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <CAK9=C2VXxNjKOq1XqQ9t6iVELdj2fFi85K77xNCOfdf3WRdy8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [172.16.6.8]
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 15-Nov-23 3:00 PM, Anup Patel wrote:
> On Wed, Nov 15, 2023 at 11:49 AM Joshua Yeong
> <joshua.yeong@starfivetech.com> wrote:
>> Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
>> switching out riscv timer as clock source
>>
>> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
>> ---
>>   drivers/clocksource/timer-riscv.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index da3071b387eb..588a05459b6a 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -50,12 +50,19 @@ static int riscv_clock_next_event(unsigned long delta,
>>          return 0;
>>   }
>>
>> +static int riscv_clock_shutdown(struct clock_event_device *evt)
>> +{
>> +       sbi_set_timer(-1);
> Use riscv_clock_event_stop() here.
You mean replacing riscv_clock_shutdown as riscv_clock_event_stop?
>
>> +       return 0;
>> +}
>> +
>>   static unsigned int riscv_clock_event_irq;
>>   static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>>          .name                   = "riscv_timer_clockevent",
>>          .features               = CLOCK_EVT_FEAT_ONESHOT,
>>          .rating                 = 100,
>>          .set_next_event         = riscv_clock_next_event,
>> +       .set_state_shutdown     = riscv_clock_shutdown,
>>   };
>>
>>   /*
>> --
>> 2.25.1
>>
> Regards,
> Anup
