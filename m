Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D476A686
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHABnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjHABm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:42:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188F31BDB;
        Mon, 31 Jul 2023 18:42:55 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxfeseY8hkdsUNAA--.30090S3;
        Tue, 01 Aug 2023 09:42:54 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx5swdY8hkx21DAA--.23984S3;
        Tue, 01 Aug 2023 09:42:54 +0800 (CST)
Message-ID: <92927822-1487-423b-cc08-fb728d07bb5c@loongson.cn>
Date:   Tue, 1 Aug 2023 09:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/2] irqchip/loongson-eiointc: Add simple irq routing
 method
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230719063558.3131045-1-maobibo@loongson.cn>
 <f19c393b-8c2e-e3aa-988a-88a423b59b99@loongson.cn>
 <86h6prt2vx.wl-maz@kernel.org>
 <5a891302-9657-ec95-4438-bc19d0efb556@loongson.cn>
 <CAAhV-H4wJiw43h2GfSey5CYUsmqX9SE+CAPSPUng9EQFMOcRdw@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H4wJiw43h2GfSey5CYUsmqX9SE+CAPSPUng9EQFMOcRdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx5swdY8hkx21DAA--.23984S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy3Xw47XF45ur15WrWfJFc_yoW8Zw18pr
        WUJa4kKr45GryxK3Waq3WUGr1Yy3Z5JrZFqFn3Jw18Xrn8tw1UJr18Krn0kFnIvw4xGFyj
        qr4rK347uF1UZwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/31 22:16, Huacai Chen 写道:
> On Wed, Jul 26, 2023 at 6:08 PM bibo mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/7/26 17:53, Marc Zyngier 写道:
>>> On Wed, 26 Jul 2023 10:45:51 +0100,
>>> bibo mao <maobibo@loongson.cn> wrote:
>>>>
>>>> slight ping :)
>>>
>>> Given that you have sent this series 5 times in two weeks, I don't
>>> think anyone is in a hurry to review it again. Just give it time.
>> Ok, I see.
>> Sorry to bring out some noise and thanks for your response.
> 1, If we really need a "virtual eiointc" variant, please document it
> in Documentation/loongarch/irq-chip-model.rst and
> Documentation/translations/zh_CN/loongarch/irq-chip-model.rst.
> 2, Then, I think it is better to only modify the type of 'index' in
> Patch-1, and move the 'if (index < 0) ...' modifications to Patch-2.
> Because all "virtual eiointc" code should be in a single patch.
sure, will do in this way.

Regards
Bibo Mao
> 
> 
> Huacai
>>
>> Regards
>> Bibo Mao
>>>
>>> Thanks,
>>>
>>>       M.
>>>
>>>>
>>>> 在 2023/7/19 14:35, Bibo Mao 写道:
>>>>> Fix return value checking of eiointc_index where int type
>>>>> is converted uint32_t and check smaller than 0.
>>>>>
>>>>> Add simple irq route support on system with only one eiointc node,
>>>>> rather than use anysend method.
>>>>>
>>>>> ---
>>>>> Changes in v5:
>>>>>   Modify typo issue.
>>>>>
>>>>> Changes in v4:
>>>>>   Modify some spell checking problems.
>>>>>   Add Fixes tag.
>>>>>
>>>>> Changes in v3:
>>>>>   Modify some spell checking problems.
>>>>>
>>>>> Changes in v2:
>>>>>   Use the simple irq routing on embeded board like 2K0500 and 2K2000
>>>>> board, since there is only one eio node.
>>>>>
>>>>> ---
>>>>> Bibo Mao (2):
>>>>>   irqchip/loongson-eiointc: Fix return value checking of eiointc_index
>>>>>   irqchip/loongson-eiointc: Simplify irq routing on some platforms
>>>>>
>>>>>  drivers/irqchip/irq-loongson-eiointc.c | 93 +++++++++++++++++++++++---
>>>>>  1 file changed, 82 insertions(+), 11 deletions(-)
>>>>>
>>>>
>>>>
>>>
>>

