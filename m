Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D28782161
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjHUC27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHUC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:28:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D1DE99;
        Sun, 20 Aug 2023 19:28:55 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx7+vly+Jk6XQaAA--.53002S3;
        Mon, 21 Aug 2023 10:28:53 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCPjy+JkVShfAA--.17092S3;
        Mon, 21 Aug 2023 10:28:51 +0800 (CST)
Subject: Re: [PATCH v4 3/4] MIPS: Return earlier in die() if notify_die()
 returns NOTIFY_STOP
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <1692434183-2054-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <467fb231-4b0a-478e-0f68-358d0651fc05@loongson.cn>
Date:   Mon, 21 Aug 2023 10:28:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPCPjy+JkVShfAA--.17092S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw13Aw4UZrWUArWxKrWUZFc_yoW8GF1Up3
        yDJayUKFW5XF1UW347tFsaqryaq3s8tayxuanFyw4FvwsIvwn5GF1kWFnIqayFvryrK3W0
        9Fy0qr1qka9xAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
        JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/20/2023 04:53 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Sun, Aug 20, 2023 at 7:21 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> After the call to oops_exit(), it should not panic or execute
>> the crash kernel if the oops is to be suppressed.
>>
>> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/mips/kernel/traps.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index 8e528a8..fd770dc 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -412,6 +412,9 @@ void die(const char *str, struct pt_regs *regs)
>>
>>         oops_exit();
>>
>> +       if (ret == NOTIFY_STOP)
>> +               return;
>> +
>>         if (in_interrupt())
>>                 panic("Fatal exception in interrupt");
>>
>> @@ -421,8 +424,7 @@ void die(const char *str, struct pt_regs *regs)
>>         if (regs && kexec_should_crash(current))
>>                 crash_kexec(regs);
>>
>> -       if (ret != NOTIFY_STOP)
>> -               make_task_dead(SIGSEGV);
>> +       make_task_dead(SIGSEGV);
> Then you call make_task_dead() at the end unconditionally, and die()
> becomes a noreturn function again.

No, it can return if (ret == NOTIFY_STOP), so die() is a return
function now, please see objdump -d arch/mips/kernel/traps.o.

Thanks,
Tiezhu

