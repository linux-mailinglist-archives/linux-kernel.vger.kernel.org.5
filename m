Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979DA7EDCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjKPIXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjKPIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:22:27 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5535F19D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:21:41 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.173])
        by gateway (Coremail) with SMTP id _____8BxbOoR0VVlUn86AA--.22267S3;
        Thu, 16 Nov 2023 16:21:37 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxG9wM0VVl6uhDAA--.17764S3;
        Thu, 16 Nov 2023 16:21:34 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Implement stable timer shutdown interface
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231114114656.1003841-1-maobibo@loongson.cn>
 <21c772c3-b1ad-49c4-b6ca-204cb65042de@xen0n.name>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <762523c4-5452-bfad-e5dc-f3bca035fb69@loongson.cn>
Date:   Thu, 16 Nov 2023 16:21:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <21c772c3-b1ad-49c4-b6ca-204cb65042de@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxG9wM0VVl6uhDAA--.17764S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw18GrWxJr1xXFW5uw18tFc_yoWrGr4rpF
        s7CF9rtrWYkwnagF97Jr4kZFy5J348twsIy34DKa48JFyYqr1SgFs2qrWqgF45urW8XF4x
        A3WYvwnrZF47JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xuerui,

Thanks for reviewing my patch, and I reply inline.

On 2023/11/16 下午3:09, WANG Xuerui wrote:
> Hi,
> 
> Sorry for the late review but here we go:
> 
> On 11/14/23 19:46, Bibo Mao wrote:
>> When cpu is hotplug out, cpu is in idle state and function
> "When a CPU is hot-unplugged, it is put into idle state and the function 
> ... is called"
Will do in next patch.

>> arch_cpu_idle_dead is called. Timer interrupt for this processor should
>> be disabled, else there will be timer interrupt for the dead cpu. Also
>> this prevents vcpu to schedule out during halt-polling flow when system
>> is running in vm mode, since there is pending timer interrupt.
> 
> The logical relationship is a bit unclear, is my paraphrasing correct in 
> your opinion?
> 
> "Timer interrupt for this processor should be disabled, else a pending 
> timer interrupt will prevent the vCPU from scheduling out during the 
> halt-polling flow when system is running in VM mode"
> 
> (I don't immediately know what a "schedule out" is. Is that a 
> translation artifact or some KVM jargon?)
how about "prevent the vCPU from giving up scheduling"?

> 
>>
>> This patch adds detailed implementation for timer shutdown interface, so
>> that timer will be disabled when cpu is plug-out.
> 
> Missing some definite articles too.
> 
> "This patch implements the timer shutdown interface so that the timer 
> will be properly disabled when a CPU is hot-unplugged"
> 
> Is this version better?
sure, will do in next version.

Regards
Bibo Mao
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/kernel/time.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index 3064af94db9c..2920770e30a9 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -58,7 +58,7 @@ static int constant_set_state_oneshot(struct 
>> clock_event_device *evt)
>>       return 0;
>>   }
>> -static int constant_set_state_oneshot_stopped(struct 
>> clock_event_device *evt)
>> +static int constant_set_state_shutdown(struct clock_event_device *evt)
>>   {
>>       unsigned long timer_config;
>> @@ -90,11 +90,6 @@ static int constant_set_state_periodic(struct 
>> clock_event_device *evt)
>>       return 0;
>>   }
>> -static int constant_set_state_shutdown(struct clock_event_device *evt)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int constant_timer_next_event(unsigned long delta, struct 
>> clock_event_device *evt)
>>   {
>>       unsigned long timer_config;
>> @@ -161,7 +156,7 @@ int constant_clockevent_init(void)
>>       cd->rating = 320;
>>       cd->cpumask = cpumask_of(cpu);
>>       cd->set_state_oneshot = constant_set_state_oneshot;
>> -    cd->set_state_oneshot_stopped = constant_set_state_oneshot_stopped;
>> +    cd->set_state_oneshot_stopped = constant_set_state_shutdown;
>>       cd->set_state_periodic = constant_set_state_periodic;
>>       cd->set_state_shutdown = constant_set_state_shutdown;
>>       cd->set_next_event = constant_timer_next_event;
>>
>> base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
> 
> Otherwise LGTM (regarding the renaming of 
> constant_set_state_oneshot_stopped, both it and the removed 
> constant_set_state_shutdown only has one usage respectively, and looking 
> at the function body it's arguably more appropriate to let it take the 
> "shutdown" name: it's just clearing the enable bit from the CSR.TCFG and 
> nothing else).
> 
> With the nits addressed:
> 
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> 

