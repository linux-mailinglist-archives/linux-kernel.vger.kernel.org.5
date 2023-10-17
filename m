Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A87CC33C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjJQMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjJQMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:33:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C595FF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:33:27 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxbOoVfy5lopYyAA--.4707S3;
        Tue, 17 Oct 2023 20:33:25 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxni8Ufy5lQuUnAA--.18272S3;
        Tue, 17 Oct 2023 20:33:25 +0800 (CST)
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
 <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H5sugXajP-b=oeXiAy5Nr4jN+N_BMhWxF-b1m7Z5H5cJA@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f1a6eea5-48e2-9418-815a-c6eede462afc@loongson.cn>
Date:   Tue, 17 Oct 2023 20:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5sugXajP-b=oeXiAy5Nr4jN+N_BMhWxF-b1m7Z5H5cJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxni8Ufy5lQuUnAA--.18272S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1rCr45CFWruFy5Cw17Jwc_yoW8Ww18pF
        48Ar4DtrsYkF1S9FZFya97WFs5trnFyF9FgF4qyrW8Ar45Za4xZr1ktrnIvFZxt395Zw40
        qr95KFnxKa1UC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
        N3UUUUU==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2023 07:40 PM, Huacai Chen wrote:
> On Mon, Oct 9, 2023 at 9:03 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
>> similar in concept to a DWARF unwinder. The difference is that the format
>> of the ORC data is much simpler than DWARF, which in turn allows the ORC
>> unwinder to be much simpler and faster.

...

>> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
>> index a3b52aa..de911c3 100644
>> --- a/arch/loongarch/configs/loongson3_defconfig
>> +++ b/arch/loongarch/configs/loongson3_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_NO_HZ=y
>>  CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_BPF_SYSCALL=y
>>  CONFIG_BPF_JIT=y
>> +CONFIG_BPF_JIT_ALWAYS_ON=y
> Does BPF have something to do with ORC?

This is to avoid the following warning:

  CC      kernel/bpf/core.o
{standard input}: Assembler messages:
{standard input}:10805: Warning: setting incorrect section attributes 
for .rodata..c_jump_table
kernel/bpf/core.o: warning: objtool: ___bpf_prog_run+0x44: sibling call 
from callable instruction with modified stack frame

Because -fno-jump-tables is specified in arch/loongarch/Makefile
for now, but __annotate_jump_table is used in ___bpf_prog_run().

#ifndef CONFIG_BPF_JIT_ALWAYS_ON
...
static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
{
...
	static const void * const jumptable[256] __annotate_jump_table = {
...
}
#endif

I think we can remove CONFIG_BPF_JIT_ALWAYS_ON in defconfig now
due to the warning is harmless.

Thanks,
Tiezhu

