Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A5763325
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjGZKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGZKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:08:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D5994;
        Wed, 26 Jul 2023 03:08:04 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Bx5fCD8MBk1iwKAA--.25566S3;
        Wed, 26 Jul 2023 18:08:03 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6C8MBkm6E7AA--.28785S3;
        Wed, 26 Jul 2023 18:08:02 +0800 (CST)
Message-ID: <5a891302-9657-ec95-4438-bc19d0efb556@loongson.cn>
Date:   Wed, 26 Jul 2023 18:08:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/2] irqchip/loongson-eiointc: Add simple irq routing
 method
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230719063558.3131045-1-maobibo@loongson.cn>
 <f19c393b-8c2e-e3aa-988a-88a423b59b99@loongson.cn>
 <86h6prt2vx.wl-maz@kernel.org>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <86h6prt2vx.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM6C8MBkm6E7AA--.28785S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1UCFWUAF4kXr1rXr18JFc_yoW8Jw4rpr
        WfJas5Kr4rWryfKa4avF1jyr1Yy3s5XryqqFyfJw48XFn8tr1UJr18KFn09rnFvw4xCFy0
        vF4rKFW7uFyUZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/26 17:53, Marc Zyngier 写道:
> On Wed, 26 Jul 2023 10:45:51 +0100,
> bibo mao <maobibo@loongson.cn> wrote:
>>
>> slight ping :)
> 
> Given that you have sent this series 5 times in two weeks, I don't
> think anyone is in a hurry to review it again. Just give it time.
Ok, I see. 
Sorry to bring out some noise and thanks for your response.

Regards
Bibo Mao 
> 
> Thanks,
> 
> 	M.
> 
>>
>> 在 2023/7/19 14:35, Bibo Mao 写道:
>>> Fix return value checking of eiointc_index where int type
>>> is converted uint32_t and check smaller than 0.
>>>
>>> Add simple irq route support on system with only one eiointc node,
>>> rather than use anysend method.
>>>
>>> ---
>>> Changes in v5:
>>>   Modify typo issue.
>>>
>>> Changes in v4:
>>>   Modify some spell checking problems.
>>>   Add Fixes tag.
>>>
>>> Changes in v3:
>>>   Modify some spell checking problems.
>>>
>>> Changes in v2:
>>>   Use the simple irq routing on embeded board like 2K0500 and 2K2000
>>> board, since there is only one eio node.
>>>
>>> ---
>>> Bibo Mao (2):
>>>   irqchip/loongson-eiointc: Fix return value checking of eiointc_index
>>>   irqchip/loongson-eiointc: Simplify irq routing on some platforms
>>>
>>>  drivers/irqchip/irq-loongson-eiointc.c | 93 +++++++++++++++++++++++---
>>>  1 file changed, 82 insertions(+), 11 deletions(-)
>>>
>>
>>
> 

