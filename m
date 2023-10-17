Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0487CC34A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjJQMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:37:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BFAD95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:37:09 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_7vzfy5l3JYyAA--.38725S3;
        Tue, 17 Oct 2023 20:37:07 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxS9zzfy5ltuUnAA--.18125S3;
        Tue, 17 Oct 2023 20:37:07 +0800 (CST)
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
 <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4pVRLPZ9OrfvV-UbPm1kRRJ0gpTqRtVbDd-eA5WzUaXg@mail.gmail.com>
 <bd40004b-10af-3c06-5ae0-750850f31446@loongson.cn>
 <CAAhV-H77o8nMiYrKJt9nocpsOh5e66dAeg+j4soncniLc+eY=w@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8c1e7439-3961-5827-3837-a97ca02e4b75@loongson.cn>
Date:   Tue, 17 Oct 2023 20:37:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H77o8nMiYrKJt9nocpsOh5e66dAeg+j4soncniLc+eY=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9zzfy5ltuUnAA--.18125S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFy8GF18CFWDGFyfurW7trc_yoW5ZFyUp3
        9IvFW3Ga10gF1UA3WDKw13Xr43G34xuFWUXasxJFyIyF17XFn3G3WrXrsrCF48tr43XFWj
        qay2y34jvF4UCabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDU
        UUU
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2023 07:37 PM, Huacai Chen wrote:
> +CC Jinyang
>
> On Sat, Oct 14, 2023 at 5:21 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

...

>>>> diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Makefile
>>>> index 58151d0..bbd1d47 100644
>>>> --- a/arch/loongarch/power/Makefile
>>>> +++ b/arch/loongarch/power/Makefile
>>>> @@ -1,3 +1,5 @@
>>>> +OBJECT_FILES_NON_STANDARD_suspend_asm.o := y
>>> hibernate_asm.o has no problem?
>>
>> Yes, only suspend_asm.o has one warning, just ignore it.
> What kind of warning? When I submitted the suspend patch, Jinyang told
> me that with his changes loongarch_suspend_enter() can be a regular
> function.

Like this:

   AS      arch/loongarch/power/suspend_asm.o
arch/loongarch/power/suspend_asm.o: warning: objtool: 
loongarch_suspend_enter+0x6c: unreachable instruction

[fedora@linux 6.6.test]$ objdump -M no-aliases -D 
arch/loongarch/power/suspend_asm.o
0000000000000ffc <loongarch_suspend_enter>:
      ffc:	02fb0063 	addi.d      	$sp, $sp, -320
     1000:	29c02061 	st.d        	$ra, $sp, 8
     1004:	29c04062 	st.d        	$tp, $sp, 16
     1008:	29c06063 	st.d        	$sp, $sp, 24
     100c:	29c08064 	st.d        	$a0, $sp, 32
     1010:	29c2a075 	st.d        	$r21, $sp, 168
     1014:	29c2c076 	st.d        	$fp, $sp, 176
     1018:	29c2e077 	st.d        	$s0, $sp, 184
     101c:	29c30078 	st.d        	$s1, $sp, 192
     1020:	29c32079 	st.d        	$s2, $sp, 200
     1024:	29c3407a 	st.d        	$s3, $sp, 208
     1028:	29c3607b 	st.d        	$s4, $sp, 216
     102c:	29c3807c 	st.d        	$s5, $sp, 224
     1030:	29c3a07d 	st.d        	$s6, $sp, 232
     1034:	29c3c07e 	st.d        	$s7, $sp, 240
     1038:	29c3e07f 	st.d        	$s8, $sp, 248
     103c:	1a00000c 	pcalau12i   	$t0, 0
     1040:	02c0018c 	addi.d      	$t0, $t0, 0
     1044:	29c00183 	st.d        	$sp, $t0, 0
     1048:	54000000 	bl          	0	# 1048 <loongarch_suspend_enter+0x4c>
     104c:	02c00065 	addi.d      	$a1, $sp, 0
     1050:	1a000004 	pcalau12i   	$a0, 0
     1054:	02c00084 	addi.d      	$a0, $a0, 0
     1058:	1a00000c 	pcalau12i   	$t0, 0
     105c:	02c0018c 	addi.d      	$t0, $t0, 0
     1060:	28c0018c 	ld.d        	$t0, $t0, 0
     1064:	4c000184 	jirl        	$a0, $t0, 0

0000000000001068 <loongarch_wakeup_start>:
     1068:	0380040c 	ori         	$t0, $zero, 0x1
     106c:	0320018c 	lu52i.d     	$t0, $t0, -2048
     1070:	0406002c 	csrwr       	$t0, 0x180
     1074:	0380440c 	ori         	$t0, $zero, 0x11
     1078:	0324018c 	lu52i.d     	$t0, $t0, -1792
     107c:	0406042c 	csrwr       	$t0, 0x181
     1080:	0324000c 	lu52i.d     	$t0, $zero, -1792
     1084:	1800000d 	pcaddi      	$t1, 0
     1088:	0015358c 	or          	$t0, $t0, $t1
     108c:	4c000d80 	jirl        	$zero, $t0, 12
     1090:	0382c00c 	ori         	$t0, $zero, 0xb0
     1094:	0400002c 	csrwr       	$t0, 0x0
     1098:	1a00000c 	pcalau12i   	$t0, 0
     109c:	02c0018c 	addi.d      	$t0, $t0, 0
     10a0:	28c00183 	ld.d        	$sp, $t0, 0
     10a4:	28c02061 	ld.d        	$ra, $sp, 8
     10a8:	28c04062 	ld.d        	$tp, $sp, 16
     10ac:	28c06063 	ld.d        	$sp, $sp, 24
     10b0:	28c08064 	ld.d        	$a0, $sp, 32
     10b4:	28c2a075 	ld.d        	$r21, $sp, 168
     10b8:	28c2c076 	ld.d        	$fp, $sp, 176
     10bc:	28c2e077 	ld.d        	$s0, $sp, 184
     10c0:	28c30078 	ld.d        	$s1, $sp, 192
     10c4:	28c32079 	ld.d        	$s2, $sp, 200
     10c8:	28c3407a 	ld.d        	$s3, $sp, 208
     10cc:	28c3607b 	ld.d        	$s4, $sp, 216
     10d0:	28c3807c 	ld.d        	$s5, $sp, 224
     10d4:	28c3a07d 	ld.d        	$s6, $sp, 232
     10d8:	28c3c07e 	ld.d        	$s7, $sp, 240
     10dc:	28c3e07f 	ld.d        	$s8, $sp, 248
     10e0:	02c50063 	addi.d      	$sp, $sp, 320
     10e4:	4c000020 	jirl        	$zero, $ra, 0

It need to modify jirl decoder to handle the following instruction:
1064:	4c000184 	jirl        	$a0, $t0, 0

Thanks,
Tiezhu

