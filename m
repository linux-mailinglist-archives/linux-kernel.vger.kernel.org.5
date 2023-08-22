Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA7783C34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjHVIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjHVIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:55:32 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE98C1B5;
        Tue, 22 Aug 2023 01:55:29 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxueoAeORkwdwaAA--.44984S3;
        Tue, 22 Aug 2023 16:55:28 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB83+d+RkbS9gAA--.30949S3;
        Tue, 22 Aug 2023 16:55:27 +0800 (CST)
Subject: Re: [PATCH v4 3/4] MIPS: Return earlier in die() if notify_die()
 returns NOTIFY_STOP
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <1692434183-2054-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
 <467fb231-4b0a-478e-0f68-358d0651fc05@loongson.cn>
 <CAAhV-H7KRGM-Aw9mNUxypE7RKLdK6HPh0fx4hg5bavL_CsFE_g@mail.gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7982dff9-c052-fec1-8473-5bc8431decc6@loongson.cn>
Date:   Tue, 22 Aug 2023 16:55:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7KRGM-Aw9mNUxypE7RKLdK6HPh0fx4hg5bavL_CsFE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB83+d+RkbS9gAA--.30949S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW8XFWUXr48Zr1ktrW7Jrc_yoW8Ar1Up3
        yUJa1UKF4UXF4UXr17tFsYqryaq3s8tFyxua1vyw4FqwnFvw1fGF18WF17ua4FvryrKa10
        vFW0gr129asxAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/22/2023 03:38 PM, Huacai Chen wrote:
> On Mon, Aug 21, 2023 at 10:29 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>
>>
>> On 08/20/2023 04:53 PM, Huacai Chen wrote:
>>> Hi, Tiezhu,
>>>
>>> On Sun, Aug 20, 2023 at 7:21 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>
>>>> After the call to oops_exit(), it should not panic or execute
>>>> the crash kernel if the oops is to be suppressed.
>>>>
>>>> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>  arch/mips/kernel/traps.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>>>> index 8e528a8..fd770dc 100644
>>>> --- a/arch/mips/kernel/traps.c
>>>> +++ b/arch/mips/kernel/traps.c
>>>> @@ -412,6 +412,9 @@ void die(const char *str, struct pt_regs *regs)
>>>>
>>>>         oops_exit();
>>>>
>>>> +       if (ret == NOTIFY_STOP)
>>>> +               return;
>>>> +
>>>>         if (in_interrupt())
>>>>                 panic("Fatal exception in interrupt");
>>>>
>>>> @@ -421,8 +424,7 @@ void die(const char *str, struct pt_regs *regs)
>>>>         if (regs && kexec_should_crash(current))
>>>>                 crash_kexec(regs);
>>>>
>>>> -       if (ret != NOTIFY_STOP)
>>>> -               make_task_dead(SIGSEGV);
>>>> +       make_task_dead(SIGSEGV);
>>> Then you call make_task_dead() at the end unconditionally, and die()
>>> becomes a noreturn function again.
>>
>> No, it can return if (ret == NOTIFY_STOP), so die() is a return
>> function now, please see objdump -d arch/mips/kernel/traps.o.
> Then should loongarch patches need to be updated, too?

Yes, I think so, will do it.

Thanks,
Tiezhu

