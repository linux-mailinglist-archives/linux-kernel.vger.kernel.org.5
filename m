Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1642278E432
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbjHaBNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbjHaBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:13:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1DABCFF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:12:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.177])
        by gateway (Coremail) with SMTP id _____8BxJvEL6e9kAEUdAA--.60224S3;
        Thu, 31 Aug 2023 09:12:44 +0800 (CST)
Received: from [10.180.13.177] (unknown [10.180.13.177])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF80K6e9k3rNnAA--.51203S3;
        Thu, 31 Aug 2023 09:12:43 +0800 (CST)
Subject: Re: [PATCH 1/1] LoongArch: adjust copy/clear_user exception handler
 behavior
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     kernel@xen0n.name, wangrui@loongson.cn, masahiroy@kernel.org,
        yijun@loongson.cn, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230830010435.2969785-1-liweihao@loongson.cn>
 <CAAhV-H4T+od3DWKWRRb1QhFgMrPcXLeR90EOdjO15cjFrt4w8g@mail.gmail.com>
From:   liweihao <liweihao@loongson.cn>
Message-ID: <5b008782-c8fc-da27-a8c9-8b4d6e72bc30@loongson.cn>
Date:   Thu, 31 Aug 2023 09:12:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4T+od3DWKWRRb1QhFgMrPcXLeR90EOdjO15cjFrt4w8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF80K6e9k3rNnAA--.51203S3
X-CM-SenderInfo: 5olzvxhkdrqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJw47XFW5uw4UGrW8CrWDKFX_yoWktFWkpF
        y5CFnakFZ8WFWxXa15trn0yrn8Wr40qas8Cr4xJF1rX3WUCw1rK343G39agFnFvaykXryr
        Ja40gF18Cr48JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai,

Thanks for the advices.
I'll fix these issues and create a new patch version.

Weihao

On 2023/8/30 下午11:40, Huacai Chen wrote:
> Hi, Weihao,
> 
> The title should be "LoongArch: Adjust {copy, clear}_user exception
> handler behavior" and 1/1 is unnecessary. Commit logs also need
> similar adjustments.
> 
> On Wed, Aug 30, 2023 at 9:04 AM liweihao <liweihao@loongson.cn> wrote:
>>
>> The copy/clear_user function should returns number of bytes that could
>> not be copied/cleared. So, try to copy/clear byte by byte when ld.d/w/h
>> and st.d/w/h trapped into an exception.
>>
>> Signed-off-by: liweihao <liweihao@loongson.cn>
> Your email format should be "Weihao Li  <liweihao@loongson.cn>"
> 
> Huacai
>> ---
>>   arch/loongarch/lib/clear_user.S |  87 ++++++++---------
>>   arch/loongarch/lib/copy_user.S  | 161 ++++++++++++++++----------------
>>   2 files changed, 127 insertions(+), 121 deletions(-)
>>
>> diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
>> index 0790eadce166..9b6eef569f89 100644
>> --- a/arch/loongarch/lib/clear_user.S
>> +++ b/arch/loongarch/lib/clear_user.S
>> @@ -11,19 +11,6 @@
>>   #include <asm/cpu.h>
>>   #include <asm/regdef.h>
>>
>> -.irp to, 0, 1, 2, 3, 4, 5, 6, 7
>> -.L_fixup_handle_\to\():
>> -       sub.d   a0, a2, a0
>> -       addi.d  a0, a0, (\to) * (-8)
>> -       jr      ra
>> -.endr
>> -
>> -.irp to, 0, 2, 4
>> -.L_fixup_handle_s\to\():
>> -       addi.d  a0, a1, -\to
>> -       jr      ra
>> -.endr
>> -
>>   SYM_FUNC_START(__clear_user)
>>          /*
>>           * Some CPUs support hardware unaligned access
>> @@ -51,7 +38,7 @@ SYM_FUNC_START(__clear_user_generic)
>>   2:     move    a0, a1
>>          jr      ra
>>
>> -       _asm_extable 1b, .L_fixup_handle_s0
>> +       _asm_extable 1b, 2b
>>   SYM_FUNC_END(__clear_user_generic)
>>
>>   /*
>> @@ -173,33 +160,47 @@ SYM_FUNC_START(__clear_user_fast)
>>          jr      ra
>>
>>          /* fixup and ex_table */
>> -       _asm_extable 0b, .L_fixup_handle_0
>> -       _asm_extable 1b, .L_fixup_handle_0
>> -       _asm_extable 2b, .L_fixup_handle_1
>> -       _asm_extable 3b, .L_fixup_handle_2
>> -       _asm_extable 4b, .L_fixup_handle_3
>> -       _asm_extable 5b, .L_fixup_handle_4
>> -       _asm_extable 6b, .L_fixup_handle_5
>> -       _asm_extable 7b, .L_fixup_handle_6
>> -       _asm_extable 8b, .L_fixup_handle_7
>> -       _asm_extable 9b, .L_fixup_handle_0
>> -       _asm_extable 10b, .L_fixup_handle_1
>> -       _asm_extable 11b, .L_fixup_handle_2
>> -       _asm_extable 12b, .L_fixup_handle_3
>> -       _asm_extable 13b, .L_fixup_handle_0
>> -       _asm_extable 14b, .L_fixup_handle_1
>> -       _asm_extable 15b, .L_fixup_handle_0
>> -       _asm_extable 16b, .L_fixup_handle_0
>> -       _asm_extable 17b, .L_fixup_handle_s0
>> -       _asm_extable 18b, .L_fixup_handle_s0
>> -       _asm_extable 19b, .L_fixup_handle_s0
>> -       _asm_extable 20b, .L_fixup_handle_s2
>> -       _asm_extable 21b, .L_fixup_handle_s0
>> -       _asm_extable 22b, .L_fixup_handle_s0
>> -       _asm_extable 23b, .L_fixup_handle_s4
>> -       _asm_extable 24b, .L_fixup_handle_s0
>> -       _asm_extable 25b, .L_fixup_handle_s4
>> -       _asm_extable 26b, .L_fixup_handle_s0
>> -       _asm_extable 27b, .L_fixup_handle_s4
>> -       _asm_extable 28b, .L_fixup_handle_s0
>> +.Llarge_fixup:
>> +       sub.d   a1, a2, a0
>> +
>> +.Lsmall_fixup:
>> +29:    st.b    zero, a0, 0
>> +       addi.d  a0, a0, 1
>> +       addi.d  a1, a1, -1
>> +       bgt     a1, zero, 1b
>> +
>> +.Lexit:
>> +       move    a0, a1
>> +       jr      ra
>> +
>> +       _asm_extable 0b, .Lsmall_fixup
>> +       _asm_extable 1b, .Llarge_fixup
>> +       _asm_extable 2b, .Llarge_fixup
>> +       _asm_extable 3b, .Llarge_fixup
>> +       _asm_extable 4b, .Llarge_fixup
>> +       _asm_extable 5b, .Llarge_fixup
>> +       _asm_extable 6b, .Llarge_fixup
>> +       _asm_extable 7b, .Llarge_fixup
>> +       _asm_extable 8b, .Llarge_fixup
>> +       _asm_extable 9b, .Llarge_fixup
>> +       _asm_extable 10b, .Llarge_fixup
>> +       _asm_extable 11b, .Llarge_fixup
>> +       _asm_extable 12b, .Llarge_fixup
>> +       _asm_extable 13b, .Llarge_fixup
>> +       _asm_extable 14b, .Llarge_fixup
>> +       _asm_extable 15b, .Llarge_fixup
>> +       _asm_extable 16b, .Llarge_fixup
>> +       _asm_extable 17b, .Lexit
>> +       _asm_extable 18b, .Lsmall_fixup
>> +       _asm_extable 19b, .Lsmall_fixup
>> +       _asm_extable 20b, .Lsmall_fixup
>> +       _asm_extable 21b, .Lsmall_fixup
>> +       _asm_extable 22b, .Lsmall_fixup
>> +       _asm_extable 23b, .Lsmall_fixup
>> +       _asm_extable 24b, .Lsmall_fixup
>> +       _asm_extable 25b, .Lsmall_fixup
>> +       _asm_extable 26b, .Lsmall_fixup
>> +       _asm_extable 27b, .Lsmall_fixup
>> +       _asm_extable 28b, .Lsmall_fixup
>> +       _asm_extable 29b, .Lexit
>>   SYM_FUNC_END(__clear_user_fast)
>> diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
>> index bfe3d2793d00..feec3d362803 100644
>> --- a/arch/loongarch/lib/copy_user.S
>> +++ b/arch/loongarch/lib/copy_user.S
>> @@ -11,19 +11,6 @@
>>   #include <asm/cpu.h>
>>   #include <asm/regdef.h>
>>
>> -.irp to, 0, 1, 2, 3, 4, 5, 6, 7
>> -.L_fixup_handle_\to\():
>> -       sub.d   a0, a2, a0
>> -       addi.d  a0, a0, (\to) * (-8)
>> -       jr      ra
>> -.endr
>> -
>> -.irp to, 0, 2, 4
>> -.L_fixup_handle_s\to\():
>> -       addi.d  a0, a2, -\to
>> -       jr      ra
>> -.endr
>> -
>>   SYM_FUNC_START(__copy_user)
>>          /*
>>           * Some CPUs support hardware unaligned access
>> @@ -54,8 +41,8 @@ SYM_FUNC_START(__copy_user_generic)
>>   3:     move    a0, a2
>>          jr      ra
>>
>> -       _asm_extable 1b, .L_fixup_handle_s0
>> -       _asm_extable 2b, .L_fixup_handle_s0
>> +       _asm_extable 1b, 3b
>> +       _asm_extable 2b, 3b
>>   SYM_FUNC_END(__copy_user_generic)
>>
>>   /*
>> @@ -69,10 +56,10 @@ SYM_FUNC_START(__copy_user_fast)
>>          sltui   t0, a2, 9
>>          bnez    t0, .Lsmall
>>
>> -       add.d   a3, a1, a2
>> -       add.d   a2, a0, a2
>>   0:     ld.d    t0, a1, 0
>>   1:     st.d    t0, a0, 0
>> +       add.d   a3, a1, a2
>> +       add.d   a2, a0, a2
>>
>>          /* align up destination address */
>>          andi    t1, a0, 7
>> @@ -94,7 +81,6 @@ SYM_FUNC_START(__copy_user_fast)
>>   7:     ld.d    t5, a1, 40
>>   8:     ld.d    t6, a1, 48
>>   9:     ld.d    t7, a1, 56
>> -       addi.d  a1, a1, 64
>>   10:    st.d    t0, a0, 0
>>   11:    st.d    t1, a0, 8
>>   12:    st.d    t2, a0, 16
>> @@ -103,6 +89,7 @@ SYM_FUNC_START(__copy_user_fast)
>>   15:    st.d    t5, a0, 40
>>   16:    st.d    t6, a0, 48
>>   17:    st.d    t7, a0, 56
>> +       addi.d  a1, a1, 64
>>          addi.d  a0, a0, 64
>>          bltu    a1, a4, .Lloop64
>>
>> @@ -114,11 +101,11 @@ SYM_FUNC_START(__copy_user_fast)
>>   19:    ld.d    t1, a1, 8
>>   20:    ld.d    t2, a1, 16
>>   21:    ld.d    t3, a1, 24
>> -       addi.d  a1, a1, 32
>>   22:    st.d    t0, a0, 0
>>   23:    st.d    t1, a0, 8
>>   24:    st.d    t2, a0, 16
>>   25:    st.d    t3, a0, 24
>> +       addi.d  a1, a1, 32
>>          addi.d  a0, a0, 32
>>
>>   .Llt32:
>> @@ -126,9 +113,9 @@ SYM_FUNC_START(__copy_user_fast)
>>          bgeu    a1, a4, .Llt16
>>   26:    ld.d    t0, a1, 0
>>   27:    ld.d    t1, a1, 8
>> -       addi.d  a1, a1, 16
>>   28:    st.d    t0, a0, 0
>>   29:    st.d    t1, a0, 8
>> +       addi.d  a1, a1, 16
>>          addi.d  a0, a0, 16
>>
>>   .Llt16:
>> @@ -136,6 +123,7 @@ SYM_FUNC_START(__copy_user_fast)
>>          bgeu    a1, a4, .Llt8
>>   30:    ld.d    t0, a1, 0
>>   31:    st.d    t0, a0, 0
>> +       addi.d  a1, a1, 8
>>          addi.d  a0, a0, 8
>>
>>   .Llt8:
>> @@ -214,62 +202,79 @@ SYM_FUNC_START(__copy_user_fast)
>>          jr      ra
>>
>>          /* fixup and ex_table */
>> -       _asm_extable 0b, .L_fixup_handle_0
>> -       _asm_extable 1b, .L_fixup_handle_0
>> -       _asm_extable 2b, .L_fixup_handle_0
>> -       _asm_extable 3b, .L_fixup_handle_0
>> -       _asm_extable 4b, .L_fixup_handle_0
>> -       _asm_extable 5b, .L_fixup_handle_0
>> -       _asm_extable 6b, .L_fixup_handle_0
>> -       _asm_extable 7b, .L_fixup_handle_0
>> -       _asm_extable 8b, .L_fixup_handle_0
>> -       _asm_extable 9b, .L_fixup_handle_0
>> -       _asm_extable 10b, .L_fixup_handle_0
>> -       _asm_extable 11b, .L_fixup_handle_1
>> -       _asm_extable 12b, .L_fixup_handle_2
>> -       _asm_extable 13b, .L_fixup_handle_3
>> -       _asm_extable 14b, .L_fixup_handle_4
>> -       _asm_extable 15b, .L_fixup_handle_5
>> -       _asm_extable 16b, .L_fixup_handle_6
>> -       _asm_extable 17b, .L_fixup_handle_7
>> -       _asm_extable 18b, .L_fixup_handle_0
>> -       _asm_extable 19b, .L_fixup_handle_0
>> -       _asm_extable 20b, .L_fixup_handle_0
>> -       _asm_extable 21b, .L_fixup_handle_0
>> -       _asm_extable 22b, .L_fixup_handle_0
>> -       _asm_extable 23b, .L_fixup_handle_1
>> -       _asm_extable 24b, .L_fixup_handle_2
>> -       _asm_extable 25b, .L_fixup_handle_3
>> -       _asm_extable 26b, .L_fixup_handle_0
>> -       _asm_extable 27b, .L_fixup_handle_0
>> -       _asm_extable 28b, .L_fixup_handle_0
>> -       _asm_extable 29b, .L_fixup_handle_1
>> -       _asm_extable 30b, .L_fixup_handle_0
>> -       _asm_extable 31b, .L_fixup_handle_0
>> -       _asm_extable 32b, .L_fixup_handle_0
>> -       _asm_extable 33b, .L_fixup_handle_0
>> -       _asm_extable 34b, .L_fixup_handle_s0
>> -       _asm_extable 35b, .L_fixup_handle_s0
>> -       _asm_extable 36b, .L_fixup_handle_s0
>> -       _asm_extable 37b, .L_fixup_handle_s0
>> -       _asm_extable 38b, .L_fixup_handle_s0
>> -       _asm_extable 39b, .L_fixup_handle_s0
>> -       _asm_extable 40b, .L_fixup_handle_s0
>> -       _asm_extable 41b, .L_fixup_handle_s2
>> -       _asm_extable 42b, .L_fixup_handle_s0
>> -       _asm_extable 43b, .L_fixup_handle_s0
>> -       _asm_extable 44b, .L_fixup_handle_s0
>> -       _asm_extable 45b, .L_fixup_handle_s0
>> -       _asm_extable 46b, .L_fixup_handle_s0
>> -       _asm_extable 47b, .L_fixup_handle_s4
>> -       _asm_extable 48b, .L_fixup_handle_s0
>> -       _asm_extable 49b, .L_fixup_handle_s0
>> -       _asm_extable 50b, .L_fixup_handle_s0
>> -       _asm_extable 51b, .L_fixup_handle_s4
>> -       _asm_extable 52b, .L_fixup_handle_s0
>> -       _asm_extable 53b, .L_fixup_handle_s0
>> -       _asm_extable 54b, .L_fixup_handle_s0
>> -       _asm_extable 55b, .L_fixup_handle_s4
>> -       _asm_extable 56b, .L_fixup_handle_s0
>> -       _asm_extable 57b, .L_fixup_handle_s0
>> +.Llarge_fixup:
>> +       sub.d   a2, a2, a0
>> +
>> +.Lsmall_fixup:
>> +58:    ld.b    t0, a1, 0
>> +59:    st.b    t0, a0, 0
>> +       addi.d  a0, a0, 1
>> +       addi.d  a1, a1, 1
>> +       addi.d  a2, a2, -1
>> +       bgt     a2, zero, 58b
>> +
>> +.Lexit:
>> +       move    a0, a2
>> +       jr      ra
>> +
>> +       _asm_extable 0b, .Lsmall_fixup
>> +       _asm_extable 1b, .Lsmall_fixup
>> +       _asm_extable 2b, .Llarge_fixup
>> +       _asm_extable 3b, .Llarge_fixup
>> +       _asm_extable 4b, .Llarge_fixup
>> +       _asm_extable 5b, .Llarge_fixup
>> +       _asm_extable 6b, .Llarge_fixup
>> +       _asm_extable 7b, .Llarge_fixup
>> +       _asm_extable 8b, .Llarge_fixup
>> +       _asm_extable 9b, .Llarge_fixup
>> +       _asm_extable 10b, .Llarge_fixup
>> +       _asm_extable 11b, .Llarge_fixup
>> +       _asm_extable 12b, .Llarge_fixup
>> +       _asm_extable 13b, .Llarge_fixup
>> +       _asm_extable 14b, .Llarge_fixup
>> +       _asm_extable 15b, .Llarge_fixup
>> +       _asm_extable 16b, .Llarge_fixup
>> +       _asm_extable 17b, .Llarge_fixup
>> +       _asm_extable 18b, .Llarge_fixup
>> +       _asm_extable 19b, .Llarge_fixup
>> +       _asm_extable 20b, .Llarge_fixup
>> +       _asm_extable 21b, .Llarge_fixup
>> +       _asm_extable 22b, .Llarge_fixup
>> +       _asm_extable 23b, .Llarge_fixup
>> +       _asm_extable 24b, .Llarge_fixup
>> +       _asm_extable 25b, .Llarge_fixup
>> +       _asm_extable 26b, .Llarge_fixup
>> +       _asm_extable 27b, .Llarge_fixup
>> +       _asm_extable 28b, .Llarge_fixup
>> +       _asm_extable 29b, .Llarge_fixup
>> +       _asm_extable 30b, .Llarge_fixup
>> +       _asm_extable 31b, .Llarge_fixup
>> +       _asm_extable 32b, .Llarge_fixup
>> +       _asm_extable 33b, .Llarge_fixup
>> +       _asm_extable 34b, .Lexit
>> +       _asm_extable 35b, .Lexit
>> +       _asm_extable 36b, .Lsmall_fixup
>> +       _asm_extable 37b, .Lsmall_fixup
>> +       _asm_extable 38b, .Lsmall_fixup
>> +       _asm_extable 39b, .Lsmall_fixup
>> +       _asm_extable 40b, .Lsmall_fixup
>> +       _asm_extable 41b, .Lsmall_fixup
>> +       _asm_extable 42b, .Lsmall_fixup
>> +       _asm_extable 43b, .Lsmall_fixup
>> +       _asm_extable 44b, .Lsmall_fixup
>> +       _asm_extable 45b, .Lsmall_fixup
>> +       _asm_extable 46b, .Lsmall_fixup
>> +       _asm_extable 47b, .Lsmall_fixup
>> +       _asm_extable 48b, .Lsmall_fixup
>> +       _asm_extable 49b, .Lsmall_fixup
>> +       _asm_extable 50b, .Lsmall_fixup
>> +       _asm_extable 51b, .Lsmall_fixup
>> +       _asm_extable 52b, .Lsmall_fixup
>> +       _asm_extable 53b, .Lsmall_fixup
>> +       _asm_extable 54b, .Lsmall_fixup
>> +       _asm_extable 55b, .Lsmall_fixup
>> +       _asm_extable 56b, .Lsmall_fixup
>> +       _asm_extable 57b, .Lsmall_fixup
>> +       _asm_extable 58b, .Lexit
>> +       _asm_extable 59b, .Lexit
>>   SYM_FUNC_END(__copy_user_fast)
>> --
>> 2.39.2
>>
>>

