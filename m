Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93E7C93B8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjJNJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:21:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B86E5AD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 02:21:26 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dxl+iUXSplVv4xAA--.60580S3;
        Sat, 14 Oct 2023 17:21:24 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3tyQXSplKREkAA--.9803S3;
        Sat, 14 Oct 2023 17:21:21 +0800 (CST)
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
 <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4pVRLPZ9OrfvV-UbPm1kRRJ0gpTqRtVbDd-eA5WzUaXg@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bd40004b-10af-3c06-5ae0-750850f31446@loongson.cn>
Date:   Sat, 14 Oct 2023 17:21:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4pVRLPZ9OrfvV-UbPm1kRRJ0gpTqRtVbDd-eA5WzUaXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3tyQXSplKREkAA--.9803S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4UGryfXFWxKry8Zw4rXrc_yoWrKr45pF
        WDuFs2qF4kKF1qyr1jqw15ZrWDt3s7G343WFn8Ga409w4vqrnrGrsF9rZ8WF1qgF48t3yS
        vF1rW3yIqF45AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUU
        U==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 12:37 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> Maybe "LoongArch: Add ORC stack unwinder support" is better.

OK, will modify it.

>
> On Mon, Oct 9, 2023 at 9:03 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
>> similar in concept to a DWARF unwinder. The difference is that the format
>> of the ORC data is much simpler than DWARF, which in turn allows the ORC
>> unwinder to be much simpler and faster.

...

>> +ifdef CONFIG_OBJTOOL
>> +# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ecb802d02eeb
>> +# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=816029e06768
>> +ifeq ($(shell as --help 2>&1 | grep -e '-mthin-add-sub'),)
>> +  $(error Sorry, you need a newer gas version with -mthin-add-sub option)
> I prefer no error out here, because without this option we can still
> built a runnable kernel.

I agree with you that it is better to not error out to stop compilation,
but there are many objtool warnings during the compile process with old
binutils, so it is necessary to give a warning so that the users know
what happened and how to fix the lots of objtool warnings.

That is to say, I would prefer to replace "error" with "warning".

>> +endif
>> +KBUILD_AFLAGS  += $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
>> +KBUILD_CFLAGS  += $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
>> +KBUILD_CFLAGS  += -fno-optimize-sibling-calls -fno-jump-tables -falign-functions=4
>> +endif

...

>> +#define ORC_REG_BP                     3
> Use FP instead of BP in this patch, too.

OK, will do it.

>
>> +#define ORC_REG_MAX                    4

...

>> +.macro UNWIND_HINT_UNDEFINED
>
>> +       UNWIND_HINT type=UNWIND_HINT_TYPE_UNDEFINED
>> +.endm
> We don't need to set sp_reg=ORC_REG_UNDEFINED for UNWIND_HINT_UNDEFINED?

Yes, no need to set sp_reg, the instructions marked with UNDEFINED
are blind spots in ORC coverage, it is no related with stack trace,
this is similar with x86.

>
>> +
>> +.macro UNWIND_HINT_EMPTY
>> +       UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL
>> +.endm
> We don't need to define UNWIND_HINT_END_OF_STACK?

Yes, it is useless now.

>
>> +
>> +.macro UNWIND_HINT_REGS
>> +       UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_REGS
>> +.endm
>> +
>> +.macro UNWIND_HINT_FUNC
>> +       UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_CALL
>> +.endm
> We don't need to set sp_offset for UNWIND_HINT_REGS and UNWIND_HINT_FUNC?

sp_offset is 0 by default, no need to set it unless you need to change
its value, see include/linux/objtool.h
.macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0

>
>> +
>> +#endif /* __ASSEMBLY__ */

...

>> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
>> index 65518bb..e43115f 100644
>> --- a/arch/loongarch/kernel/entry.S
>> +++ b/arch/loongarch/kernel/entry.S
>> @@ -14,11 +14,13 @@
>>  #include <asm/regdef.h>
>>  #include <asm/stackframe.h>
>>  #include <asm/thread_info.h>
>> +#include <asm/unwind_hints.h>
>>
>>         .text
>>         .cfi_sections   .debug_frame
>>         .align  5
>> -SYM_FUNC_START(handle_syscall)
>> +SYM_CODE_START(handle_syscall)
> Why?
>

see include/linux/linkage.h
FUNC -- C-like functions (proper stack frame etc.)
CODE -- non-C code (e.g. irq handlers with different, special stack etc.)

>> +       UNWIND_HINT_UNDEFINED
>>         csrrd           t0, PERCPU_BASE_KS

...

>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index 53b883d..5664390 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -43,6 +43,7 @@ SYM_DATA(kernel_offset, .long _kernel_offset);
>>         .align 12
>>
>>  SYM_CODE_START(kernel_entry)                   # kernel entry point
>> +       UNWIND_HINT_EMPTY
> I'm not sure but I think this isn't needed, because
> "OBJECT_FILES_NON_STANDARD_head.o               :=y"

Yes, you are right, will remove it.

>
>>
>>         /* Config direct window and set PG */

...

>>  void __init setup_arch(char **cmdline_p)
>>  {
>> +       unwind_init();
> I think this line should be after cpu_probe().

I am OK to do this change, but if so, there are no stack trace before
cpu_probe() for the early code.

>
>>         cpu_probe();
>>
>>         init_environ();

...

>> diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
>> index 58151d0..bbd1d47 100644
>> --- a/arch/loongarch/power/Makefile
>> +++ b/arch/loongarch/power/Makefile
>> @@ -1,3 +1,5 @@
>> +OBJECT_FILES_NON_STANDARD_suspend_asm.o := y
> hibernate_asm.o has no problem?

Yes, only suspend_asm.o has one warning, just ignore it.

Thanks,
Tiezhu

