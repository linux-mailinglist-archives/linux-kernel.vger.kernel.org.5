Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5F769A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGaPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGaPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:16:47 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406851707;
        Mon, 31 Jul 2023 08:16:45 -0700 (PDT)
Received: from [192.168.0.107] (unknown [111.197.209.91])
        by APP-05 (Coremail) with SMTP id zQCowACnLeo+0MdkHM9REA--.17667S2;
        Mon, 31 Jul 2023 23:16:14 +0800 (CST)
Message-ID: <90d97914-9576-42e7-0d7d-c752b5bd6a68@iscas.ac.cn>
Date:   Mon, 31 Jul 2023 23:16:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
References: <20230731095936.23397-1-xingmingzheng@iscas.ac.cn>
 <20230731-calzone-gratified-dbc51639beec@wendy>
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <20230731-calzone-gratified-dbc51639beec@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowACnLeo+0MdkHM9REA--.17667S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4fCw1kZr4UCFW8uFWDCFg_yoW3JF1Dpr
        W3CFyDCrs5Xa18G3WfJw1UX3WFvrs3G3yrKry5KryUu3sxCFyxKr9Yka13ZFyDZFnagw4F
        vw1xuFZY9w1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU5IksPUUUUU==
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCQYJCmTHvCUmcAABsh
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 22:01, Conor Dooley wrote:
> Hey,
>
> On Mon, Jul 31, 2023 at 05:59:36PM +0800, Mingzheng Xing wrote:
>> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the newer
>> 20191213 version which moves some instructions from the I extension to the
>> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
>> that version, we should explicitly specifying Zicsr and Zifencei via -march
>> to cope with the new changes. but this only occurs when binutils >= 2.36
>> and GCC >= 11.1.0. It's a different story when binutils < 2.36.
>>
>> binutils-2.36 supports the Zifencei extension[2] and splits Zifencei and
>> Zicsr from I[3]. GCC-11.1.0 is particular[4] because it add support Zicsr
>> and Zifencei extension for -march. binutils-2.35 does not support the
>> Zifencei extension, and does not need to specify Zicsr and Zifencei when
>> working with GCC >= 12.1.0.
>>
>> To make our lives easier, let's relax the check to binutils >= 2.36 in
>> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. For the other two cases,
>> where clang < 17 or GCC < 11.1.0, we will deal with them in
>> CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
>>
>> For more information, please refer to:
>> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
>> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
>> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc [0]
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd [1]
>> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=5a1b31e1e1cee6e9f1c92abff59cdcfff0dddf30 [2]
>> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=729a53530e86972d1143553a415db34e6e01d5d2 [3]
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49 [4]
>> Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
>> Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> You need to actually put the CC: stable@vger.kernel.org into the commit
> message for the stable folks to pick things up.

Thanks. Fixed in next version.

>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c86..2704bd91dfb5 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -570,24 +570,31 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>   	def_bool y
>>   	# https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>> -	depends on AS_IS_GNU && AS_VERSION >= 23800
>> -	help
>> -	  Newer binutils versions default to ISA spec version 20191213 which
>> -	  moves some instructions from the I extension to the Zicsr and Zifencei
>> -	  extensions.
>> +	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>> +	depends on AS_IS_GNU && AS_VERSION >= 23600
>> +	help
>> +	  Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
>> +	  20191213 version, which moves some instructions from the I extension to
>> +	  the Zicsr and Zifencei extensions. This requires explicitly specifying
>> +	  zicsr and zifencei when binutils >= 2.38 or GCC >= 12.1.0,
>> but this only
>> +	  occurs when binutils >= 2.36 and GCC >= 11.1.0.
>> +	 It's a different story when binutils < 2.36.
> I would replace this with something like:
> 	Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the newer
> 	20191213 version, which moves some instructions from the I extension to
> 	the Zicsr and Zifencei extensions. This requires explicitly specifying
> 	zicsr and zifencei when binutils >= 2.38 or GCC >= 12.1.0. Zicsr
> 	and Zifencei are supported in binutils from version 2.36 onwards.
> 	To make life easier, and avoid forcing toolchains that default to a
> 	newer ISA spec to version 2.2, relax the check to binutils >= 2.36.
> 	For clang < 17 or GCC < 11.1.0, for which this is not possible, this is
> 	dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
>
> I tried to take the personification out of it & hopefully made it a
> little clearer what dropping the check to 2.36 does for us.
>
>> Also, we have to consider the case of clang paired with binutils.
> I think this sentence can go, its covered in the other config text.
>
> I'm sorry for being a bit of a pedant about this, but this has been such
> a can of worms that I would like things to remain explained well enough
> that the text is sufficient next time a revisit is required.

Thanks for your review, I've made the changes and submitted a
new PATCH but there seems to be an email thread issue,
hopefully it won't have an effect, sorry about that.

:)
Thanks,
Mingzheng.

>
> Thanks,
> Conor.
>
>> +	  To make our lives easier, we relax the check to binutils >= 2.36. >
>>   config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>>   	def_bool y
>>   	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>   	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4498694e15bf8a16
>> -	depends on CC_IS_CLANG && CLANG_VERSION < 170000
>> -	help
>> -	  Certain versions of clang do not support zicsr and zifencei via -march
>> -	  but newer versions of binutils require it for the reasons noted in the
>> -	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
>> -	  option causes an older ISA spec compatible with these older versions
>> -	  of clang to be passed to GAS, which has the same result as passing zicsr
>> -	  and zifencei to -march.
>> +	# https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
>> +	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
>> +	help
>> +	  Certain versions of clang and GCC do not support zicsr and zifencei via
>> +	  -march. This option causes an older ISA spec compatible with these older
>> +	  versions of clang and GCC to be passed to GAS, which has the same result
>> +	  as passing zicsr and zifencei to -march.
>>   
>>   config FPU
>>   	bool "FPU support"
>> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
>> index 189345773e7e..b86e5e2c3aea 100644
>> --- a/arch/riscv/kernel/compat_vdso/Makefile
>> +++ b/arch/riscv/kernel/compat_vdso/Makefile
>> @@ -11,7 +11,13 @@ compat_vdso-syms += flush_icache
>>   COMPAT_CC := $(CC)
>>   COMPAT_LD := $(LD)
>>   
>> -COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
>> +# binutils 2.35 does not support the zifencei extension, but in the ISA
>> +# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
>> +ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>> +	COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
>> +else
>> +	COMPAT_CC_FLAGS := -march=rv32imafd -mabi=ilp32
>> +endif
>>   COMPAT_LD_FLAGS := -melf32lriscv
>>   
>>   # Disable attributes, as they're useless and break the build.
>> -- 
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

