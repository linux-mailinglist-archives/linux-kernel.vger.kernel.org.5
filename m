Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B56763FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGZTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:34:52 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F2E73;
        Wed, 26 Jul 2023 12:34:50 -0700 (PDT)
Received: from [192.168.0.107] (unknown [114.249.159.178])
        by APP-05 (Coremail) with SMTP id zQCowABnbrI4dcFk8hvfDg--.59552S2;
        Thu, 27 Jul 2023 03:34:16 +0800 (CST)
Message-ID: <10231b81-ea42-26d0-4c11-92851229e658@iscas.ac.cn>
Date:   Thu, 27 Jul 2023 03:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
References: <20230726174524.340952-1-xingmingzheng@iscas.ac.cn>
 <20230726-outclass-parade-2ccea9f6688a@spud>
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <20230726-outclass-parade-2ccea9f6688a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowABnbrI4dcFk8hvfDg--.59552S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw43Xw15uF1DJFy8urykXwb_yoW7XrW5pr
        W3CFyUCr4rXw48G3Wft34UWa4Yyrs3J3y8Jr43Kw1Uu3sxZF1FgrWkKw4agFyDZrZ3Gr40
        vr1xu3ZYvw1qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07beAp5UUUUU=
X-Originating-IP: [114.249.159.178]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCgYECmTBJBelrwAAse
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 02:02, Conor Dooley wrote:
> On Thu, Jul 27, 2023 at 01:45:24AM +0800, Mingzheng Xing wrote:
>> Binutils-2.38 and GCC-12.1.0 bump[0] default ISA spec to newer version
>> 20191213 which moves some instructions from the I extension to the
>> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
>> that version, we should turn on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>> to cope with the new changes.
>>
>> The case of clang is special[1][2], where older clang versions (<17) need
>> to be rolled back to old ISA spec to fix it. And the less common case,
>> since older GCC versions (<11.1.0) did not support zicsr and zifencei
> Can you provide a link to explain why this is 11.1.0 in particular?

Okay, I can add it in commit message. gcc-11.1.0 is particular
because it add support zicsr and zifencei extension for -march[1].

Link: 
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49 
[1]

>> extension for -march, also requires a fallback to cope with it.
>>
>> For more information, please refer to:
>> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
>> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd [0]
>> Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org [1]
>> Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org [2]
>> Link: https://lore.kernel.org/all/20230725170405.251011-1-xingmingzheng@iscas.ac.cn
> This shouldn't be here, you don't link to your old patches.

My bad, I will fix it.

>
>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> This is still broken for:
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23500
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23500

Do you mean that these CONFIG_* will cause kernel
compilation errors when paired with certain versions of GCC?
Or perhaps I misunderstood your meaning.

>
> Please don't post a v2 while there is still ongoing discussion on the
> v1. I'll try to reply here tomorrow with a diff you can fold in to fix
> the problem.

Okay, thanks for your review.

> Thanks,
> Conor.
>
>> ---
>>
>> v2:
>> - Update the Kconfig help text and commit message.
>> - Add considerations for low version gcc case.
>>
>> Sorry for the formatting error on my mailing list reply.
>>
>>   arch/riscv/Kconfig | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c86..08afd47de157 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -570,24 +570,27 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>   	def_bool y
>>   	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>> -	depends on AS_IS_GNU && AS_VERSION >= 23800
>> +	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>> +	depends on GCC_VERSION >= 120100 || (AS_IS_GNU && AS_VERSION >= 23800)
>>   	help
>> -	  Newer binutils versions default to ISA spec version 20191213 which
>> -	  moves some instructions from the I extension to the Zicsr and Zifencei
>> -	  extensions.
>> +	  Binutils-2.38 and GCC-12.1.0 bump default ISA spec to newer version
>> +	  20191213 which moves some instructions from the I extension to the
>> +	  Zicsr and Zifencei extensions.
>>   
>>   config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>>   	def_bool y
>>   	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>   	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
>> -	depends on CC_IS_CLANG && CLANG_VERSION < 170000
>> +	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
>> +	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || \
>> +		   (CC_IS_GCC && GCC_VERSION < 110100)
>>   	help
>> -	  Certain versions of clang do not support zicsr and zifencei via -march
>> -	  but newer versions of binutils require it for the reasons noted in the
>> -	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
>> +	  Certain versions of clang (or GCC) do not support zicsr and zifencei via
>> +	  -march but newer versions of binutils require it for the reasons noted
>> +	  in the help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
>>   	  option causes an older ISA spec compatible with these older versions
>> -	  of clang to be passed to GAS, which has the same result as passing zicsr
>> -	  and zifencei to -march.
>> +	  of clang (or GCC) to be passed to GAS, which has the same result as
>> +	  passing zicsr and zifencei to -march.
>>   
>>   config FPU
>>   	bool "FPU support"
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

