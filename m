Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD82980821C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378028AbjLGHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377638AbjLGHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:43:02 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2A80137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:43:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxRvGKd3FltJA_AA--.61466S3;
        Thu, 07 Dec 2023 15:43:06 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxbNyId3FlwktXAA--.62372S3;
        Thu, 07 Dec 2023 15:43:04 +0800 (CST)
Subject: Re: [PATCH v5 8/8] LoongArch: Add ORC stack unwinder support
To:     Xi Ruoyao <xry111@xry111.site>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
 <20231129130701.27744-9-yangtiezhu@loongson.cn>
 <e860c6d42dc67e2c662c732ce56309874456f21b.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c172bf73-1e4e-9d4a-4b82-6aeb0f6f4ff8@loongson.cn>
Date:   Thu, 7 Dec 2023 15:43:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e860c6d42dc67e2c662c732ce56309874456f21b.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxbNyId3FlwktXAA--.62372S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4kKw4ruw13GrWrGFW7trc_yoW8GF4rpa
        ykGr4qkr4kXF4kXr17Aw4rJ39aqanrGrs8Xw42gayUCwsIqrsIgr4IkF45Ca47GrsFkFnF
        vFs3t3ZYv3W5C3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2023 09:20 PM, Xi Ruoyao wrote:
> On Wed, 2023-11-29 at 21:07 +0800, Tiezhu Yang wrote:
>> +KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
>> +KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
>> +
>> +ifdef CONFIG_OBJTOOL
>> +KBUILD_CFLAGS			+= -fno-optimize-sibling-calls -fno-jump-tables -falign-functions=4 -falign-labels=4
>> +endif
>
> I still hate regressing the optimization with a passion.

Yes, I agree in general.

>
> And -falign-labels=4 implies -falign-functions=4 so at least we can
> remove -falign-functions=4.

Thanks.

>
> And in GCC >= 14 the defaults are -falign-labels=16 and -falign-
> functions=32.  These values are determined by benchmarking on LA464 so
> I'd suggest using them (maybe unless CONFIG_CC_OPTIMIZE_FOR_SIZE).
>

The initial aim to add "-falign-functions=4 -falign-labels=4" is to
avoid generating nop instructions in .o file with -mrelax option
by default, otherwise the orc info can not match the symbol address
in vmlinux.

I want to add -mno-relax option and remove the extra option
"-falign-functions=4 -falign-labels=4", then the offsets in
each .o file and vmlinux are same, and it is not necessary
to do the special handling about local labels, I think
it will make life easier.

Thanks,
Tiezhu

