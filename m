Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886A8081C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377886AbjLGHXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:23:16 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC84137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:23:21 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxuerncnFldI8_AA--.51386S3;
        Thu, 07 Dec 2023 15:23:19 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxni_lcnFlkEdXAA--.62240S3;
        Thu, 07 Dec 2023 15:23:18 +0800 (CST)
Subject: Re: [PATCH v5 8/8] LoongArch: Add ORC stack unwinder support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
 <20231129130701.27744-9-yangtiezhu@loongson.cn>
 <CAAhV-H4XBG8XafSvY11j4GW8RGJ_uW=sXc4K0PEcMwyGyUPw=Q@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <eab54e21-550d-12a8-cec1-1634c9c7de20@loongson.cn>
Date:   Thu, 7 Dec 2023 15:23:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4XBG8XafSvY11j4GW8RGJ_uW=sXc4K0PEcMwyGyUPw=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxni_lcnFlkEdXAA--.62240S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5tFy5KFWkGrWDJFW7ZFc_yoW8Xryrpa
        yUAFs8tr4kK3y0qr9FyayUXr1kt3ykGr90gFs8CFy8Zwn8Z345Jrs3KF4DuFyUWwn5ArWI
        vFn5Wa4xuFW8A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2023 08:42 PM, Huacai Chen wrote:
> On Wed, Nov 29, 2023 at 9:07 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
>> similar in concept to a DWARF unwinder. The difference is that the format
>> of the ORC data is much simpler than DWARF, which in turn allows the ORC
>> unwinder to be much simpler and faster.

...

>> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
>> index a77bf160bfc4..e3023d9a508c 100644
>> --- a/arch/loongarch/lib/Makefile
>> +++ b/arch/loongarch/lib/Makefile
>> @@ -3,6 +3,8 @@
>>  # Makefile for LoongArch-specific library files.
>>  #
>>
>> +OBJECT_FILES_NON_STANDARD := y
>> +
>>  lib-y  += delay.o memset.o memcpy.o memmove.o \
>>            clear_user.o copy_user.o csum.o dump_tlb.o unaligned.o
>>
> I have a draft live-patch patch here:
> https://github.com/chenhuacai/linux/commit/744942cbf456b320f2333638e4bd27d35900284c
>
> But we get such an error:
>
> # selftests: livepatch: test-ftrace.sh
>
>                                       [48/1865]
> [14936.262721] livepatch: failed to register ftrace handler for
> function 'cmdline_proc_show' (-16)
> # TEST: livepatch interaction with ftrace_enabled sysctl ...

...

> I think it is probably because we skip mem* functions here.

I did not test livepatch which is a separate new feature,
let me try it, maybe it needs some time because I am very
busy with some other stuffs.

Thanks,
Tiezhu

