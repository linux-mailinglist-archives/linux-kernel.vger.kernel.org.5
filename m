Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB567ED9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjKPDRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjKPDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:17:51 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2CBA19E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:17:46 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.173])
        by gateway (Coremail) with SMTP id _____8Dxl+jYiVVlW3I6AA--.13712S3;
        Thu, 16 Nov 2023 11:17:44 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzdzViVVlMqlDAA--.17404S3;
        Thu, 16 Nov 2023 11:17:43 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Implement stable timer shutdown interface
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231114114656.1003841-1-maobibo@loongson.cn>
 <CAAhV-H46vueDp0ffTuD6sO=xWVsbcwVDBzFU7QirE9JwOWd4dg@mail.gmail.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <aebb1335-6398-07ba-089b-ec74899de6b0@loongson.cn>
Date:   Thu, 16 Nov 2023 11:17:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H46vueDp0ffTuD6sO=xWVsbcwVDBzFU7QirE9JwOWd4dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxzdzViVVlMqlDAA--.17404S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4UKw17KF1rZFWrWFWxuFX_yoW5Ar1xpa
        1DCFnxKr45KwnagFn7tr4kZr90k34jvw43t3srKa48Cr9Iqr1ftF4xtrWqvF45uryFgFWx
        A3WY9w1DZay7XagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
        sDUUUUU==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/16 上午10:50, Huacai Chen wrote:
> Hi, Bibo,
> 
> "stable timer" is Chinglish, use "constant timer" here.
will do if you insist on, the name is not created by me :(

> 
> On Tue, Nov 14, 2023 at 7:49 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> When cpu is hotplug out, cpu is in idle state and function
>> arch_cpu_idle_dead is called. Timer interrupt for this processor should
>> be disabled, else there will be timer interrupt for the dead cpu. Also
>> this prevents vcpu to schedule out during halt-polling flow when system
>> is running in vm mode, since there is pending timer interrupt.
>>
>> This patch adds detailed implementation for timer shutdown interface, so
>> that timer will be disabled when cpu is plug-out.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kernel/time.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index 3064af94db9c..2920770e30a9 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -58,7 +58,7 @@ static int constant_set_state_oneshot(struct clock_event_device *evt)
>>          return 0;
>>   }
>>
>> -static int constant_set_state_oneshot_stopped(struct clock_event_device *evt)
>> +static int constant_set_state_shutdown(struct clock_event_device *evt)
>>   {
>>          unsigned long timer_config;
>>
> Please remove the whole constant_set_state_oneshot_stopped() and move
> its logic to the below constant_set_state_shutdown().
will do.
> 
> And it is very strange that this "bug" hasn't caused any problems until now.
Since there is no other hw timer except percpu timer, there will be 
problem if hw timer is switched, also nobody watches hw behaviors when 
cpu is plug-out. LTP cpu hotplug test cases just report passed on 
physical machine.

Regards
Bibo Mao

> 
> Huacai
> 
>> @@ -90,11 +90,6 @@ static int constant_set_state_periodic(struct clock_event_device *evt)
>>          return 0;
>>   }
>>
>> -static int constant_set_state_shutdown(struct clock_event_device *evt)
>> -{
>> -       return 0;
>> -}
>> -
>>   static int constant_timer_next_event(unsigned long delta, struct clock_event_device *evt)
>>   {
>>          unsigned long timer_config;
>> @@ -161,7 +156,7 @@ int constant_clockevent_init(void)
>>          cd->rating = 320;
>>          cd->cpumask = cpumask_of(cpu);
>>          cd->set_state_oneshot = constant_set_state_oneshot;
>> -       cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
>> +       cd->set_state_oneshot_stopped = constant_set_state_shutdown;
>>          cd->set_state_periodic = constant_set_state_periodic;
>>          cd->set_state_shutdown = constant_set_state_shutdown;
>>          cd->set_next_event = constant_timer_next_event;
>>
>> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
>> --
>> 2.39.3
>>

