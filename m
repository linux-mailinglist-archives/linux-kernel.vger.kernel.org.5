Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C646763CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGZQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGZQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:53:33 -0400
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 09:53:31 PDT
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC74106;
        Wed, 26 Jul 2023 09:53:30 -0700 (PDT)
Received: from [192.168.0.107] (unknown [114.249.159.178])
        by APP-05 (Coremail) with SMTP id zQCowADHi+h5T8Fk8GbYDg--.58865S2;
        Thu, 27 Jul 2023 00:53:13 +0800 (CST)
Message-ID: <29a02277-81ca-8874-e28a-0a31c4e73459@iscas.ac.cn>
Date:   Thu, 27 Jul 2023 00:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Subject: Re: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
To:     Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
References: <20230725170405.251011-1-xingmingzheng@iscas.ac.cn>
 <20230725172344.GA1445373@dev-arch.thelio-3990X>
 <20230725-skating-agent-b092f2257ca1@spud>
Content-Language: en-US
Organization: ISCAS
In-Reply-To: <20230725-skating-agent-b092f2257ca1@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHi+h5T8Fk8GbYDg--.58865S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4rXr15Gr4xZF4kCr17ZFb_yoWxXrWkpr
        W3GFn0krsYqrWxCr1vyw1UWa4FvrZ5G3y5WryUG34Utrs8uF92gr1v9r42gFyDZFsakw1Y
        vr1S9FWkWwn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07b0a0QUUUUU=
X-Originating-IP: [114.249.159.178]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCQoECmTBJKNhJAAAsq
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 02:57, Conor Dooley wrote:
> On Tue, Jul 25, 2023 at 10:23:44AM -0700, Nathan Chancellor wrote:
>> Hi Mingzheng,
>>
>> Thanks for the patch!
>>
>> On Wed, Jul 26, 2023 at 01:04:05AM +0800, Mingzheng Xing wrote:
>>> When compiling the kernel with the toolchain composed of GCC >= 12.1.0 and
>>> binutils < 2.38, default ISA spec used when building binutils and GCC, the
>>> following build failure will appear because the
>>> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI is not turned on.
>>> (i.e, gcc-12.1.0 and binutils-2.36, or gcc-12.3.0 and binutils-2.37, use
>>> default ISA spec.)
>>>
>>>    CC      arch/riscv/kernel/vdso/vgettimeofday.o
>>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h: Assembler messages:
>>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
>> The gift that keeps on giving :/
>>
>>> Binutils has updated the default ISA spec version, and the community has
>>> responded well to this[1][2][3], but it appears that this is not over yet.
>>>
>>> We also need to consider the situation of binutils < 2.38 but
>>> GCC >= 12.1.0, since the combination between different versions of GCC and
>>> binutils is not unique, which is to some extent flexible. GCC release
>>> 12.1.0 updated the default ISA spec version in GCC commit[4].
>> I suspect this combination is not too common because binutils 2.38 came
>> out before GCC 12.1.0 but as you note, it is obviously possible. What
>> toolchain has this combination in the wild, which would be helpful for
>> documentation purposes?
> Yeah, that'd be great to know, at least the other niche stuff that we
> are working around had a clear use-case (testing LLVM in debian containers)
> whereas there's no clear user for this.
> That's doubly interesting, as this patch seems to break things for binutils
> < 2.35, and if we have to make a trade-off between those too, then it'd
> be good to be able to weigh up the options.
> Do we perhaps need the misa-spec workaround instead for this case?
> Haven't tested that though, trying to dig myself out of email backlog.
Well, what I encountered use-case was a temporary thing caused by the
inconsistent pace of distro package upgrades, but it really happened and
took quite a bit of time to explore why. There are sites like [1] that count
the "Successful Builds" between different GCC and binutils releases,
(Though they don't seem to be updated much...), but it seems to indicate
that all kinds of available pairings are possible.

Before replying to the e-mail, I tested some "extreme" cases and things
seemed to be a little clearer.

1. binutils-2.38 and GCC-12.1.0 each changed default ISA spec version,
     updating from 2.2 to 20191213.

2. binutils>=2.38 or GCC>=12.1.0
     when meet any of these it is recommended to turn on
     TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI, the good outweighs
     the bad. (My personal understanding.)

3. (Extreme case) binutils>=2.38 AND GCC<11.1.0
     GCC-11.1.0 starts to support zicsr and zifencei extension for 
-march[2].
     In this case just turn on TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
     (Otherwise compiling the kernel will report an error whether
     TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI is turned on or not.)

4. (Extreme case) GCC>=12.1.0, binutils<2.36
     I tested GCC-12.1.0 + binutils-2.36 and it compiles the kernel 
fine(after
     hitting this patch). Also tested GCC-12.1.0 + binutils2.35 and
     GCC-12.1.0 + binutils-2.34.0, but both pairings gave errors and failed
     to produce a usable toolchain (Default ISA versions used). It seems 
safe
     to assume that GCC-12.1.0 + binutils<2.35 is almost non-existent.

I'm no expert on toolchains, so thanks for correcting me if I'm wrong 
somewhere...

[1] https://wiki.osdev.org/Cross-Compiler_Successful_Builds
[2] 
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b03be74bad08c382da47e048007a78fa3fb4ef49
>>> For more information, please refer to:
>>>
>>> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
>>> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
>>>
>>> [1]:https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/aE1ZeHHCYf4
>>> [2]:https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
>>> [3]:https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
>>> [4]:https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
> btw, please make these regular Link: tags (with a [N] at EOL) and drop
> the space between them and the sign off. Also, this probably needs to be
> CC:stable@vger.kernel.org  too.
OK, I'll fix it.

Thanks,
Mingzheng.
> Cheers,
> Conor.
>
>>> Signed-off-by: Mingzheng Xing<xingmingzheng@iscas.ac.cn>
>>> ---
>>>   arch/riscv/Kconfig | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 4c07b9189c86..b49cea30f6cc 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -570,11 +570,15 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>>   	def_bool y
>>>   	#https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>>> -	depends on AS_IS_GNU && AS_VERSION >= 23800
>>> +	#https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>>> +	depends on CC_IS_GCC && GCC_VERSION >= 120100 || \
>>> +		   AS_IS_GNU && AS_VERSION >= 23800
>> GCC_VERSION will be 0 for clang, so you don't need the CC_IS_GCC check.
>> With that change, this should be able to stay on one line:
>>
>>      depends on GCC_VERSION >= 120100 || (AS_IS_GNU && AS_VERSION >= 23800)
>>
>>>   	help
>>>   	  Newer binutils versions default to ISA spec version 20191213 which
>>>   	  moves some instructions from the I extension to the Zicsr and Zifencei
>>>   	  extensions.
>>> +	  Similarly, GCC release 12.1.0 has changed the default ISA spec version to
>>> +	  20191213, so the above situation requires this option to be enabled.
>>>   
>>>   config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>>>   	def_bool y
>>> -- 
>>> 2.34.1
>>>

