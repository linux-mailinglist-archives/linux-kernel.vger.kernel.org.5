Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7CC763D03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjGZQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGZQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:55:35 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA95211F;
        Wed, 26 Jul 2023 09:55:33 -0700 (PDT)
Received: from [192.168.0.107] (unknown [114.249.159.178])
        by APP-05 (Coremail) with SMTP id zQCowABHTxf0T8Fk333YDg--.1863S2;
        Thu, 27 Jul 2023 00:55:16 +0800 (CST)
Message-ID: <a07f237a-20a2-06f0-3e20-0f4cd783649f@iscas.ac.cn>
Date:   Thu, 27 Jul 2023 00:55:16 +0800
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
 <20230725-name-aggregate-5de303072c9d@spud>
Content-Language: en-US
Organization: ISCAS
In-Reply-To: <20230725-name-aggregate-5de303072c9d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowABHTxf0T8Fk333YDg--.1863S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw43Aw4DWrWrAFy7tw4rAFb_yoW7ArW7p3
        9xGFn0krs5XrWxCwn7tw1UWFyFq395GrW5Wr1UG34Yvrn0vFyxKr4v9w4j9FyDZrs3Cw1j
        vr1S9Fyavw1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07beeHgUUUUU=
X-Originating-IP: [114.249.159.178]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiAxMECmTBI3VlbwAAsn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 06:17, Conor Dooley wrote:
> On Tue, Jul 25, 2023 at 07:57:54PM +0100, Conor Dooley wrote:
>> On Tue, Jul 25, 2023 at 10:23:44AM -0700, Nathan Chancellor wrote:
>>> On Wed, Jul 26, 2023 at 01:04:05AM +0800, Mingzheng Xing wrote:
>>>> When compiling the kernel with the toolchain composed of GCC >= 12.1.0 and
>>>> binutils < 2.38, default ISA spec used when building binutils and GCC, the
>>>> following build failure will appear because the
>>>> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI is not turned on.
>>>> (i.e, gcc-12.1.0 and binutils-2.36, or gcc-12.3.0 and binutils-2.37, use
>>>> default ISA spec.)
>>>>
>>>>    CC      arch/riscv/kernel/vdso/vgettimeofday.o
>>>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h: Assembler messages:
>>>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
>>> The gift that keeps on giving :/
>>>
>>>> Binutils has updated the default ISA spec version, and the community has
>>>> responded well to this[1][2][3], but it appears that this is not over yet.
> Also, I just noticed this comment. I disagree with the wording "well",
> and more like "with weeping and gnashing of teeth" ;) This stuff is a
> huge pain in the ass, and mixing toolchains between LLVM & GNU stuff (or
> using an older binutils with a newer GCC) really makes it a lot worse.
At least in the usual way , except in my unusual case...
> Thanks for submitting a fix for this so that Nathan or I didn't have to!
Hopefully this patch will make things better.
>>>> We also need to consider the situation of binutils < 2.38 but
>>>> GCC >= 12.1.0, since the combination between different versions of GCC and
>>>> binutils is not unique, which is to some extent flexible. GCC release
>>>> 12.1.0 updated the default ISA spec version in GCC commit[4].
>>> I suspect this combination is not too common because binutils 2.38 came
>>> out before GCC 12.1.0 but as you note, it is obviously possible. What
>>> toolchain has this combination in the wild, which would be helpful for
>>> documentation purposes?
>> Yeah, that'd be great to know, at least the other niche stuff that we
>> are working around had a clear use-case (testing LLVM in debian containers)
>> whereas there's no clear user for this.
>> That's doubly interesting, as this patch seems to break things for binutils
>> < 2.35, and if we have to make a trade-off between those too, then it'd
>> be good to be able to weigh up the options.
>> Do we perhaps need the misa-spec workaround instead for this case?
>> Haven't tested that though, trying to dig myself out of email backlog.
> I don't think the misa-spec stuff is what we need actually. Instead, the
> workaround/fix that this patch implements just needs to be constrained to
> versions of GAS greater than 2.35.
I'm sorry, I didn't quite understand this, could you provide some more
information, thank you very much!
I'll change the handling in v2. After testing it myself, it seems to 
work fine.

Thanks,
Mingzheng.
> Thanks,
> Conor.
>
>>>> For more information, please refer to:
>>>>
>>>> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
>>>> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
>>>>
>>>> [1]:https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/aE1ZeHHCYf4
>>>> [2]:https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
>>>> [3]:https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
>>>> [4]:https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>> btw, please make these regular Link: tags (with a [N] at EOL) and drop
>> the space between them and the sign off. Also, this probably needs to be
>> CC:stable@vger.kernel.org  too.
>>>> Signed-off-by: Mingzheng Xing<xingmingzheng@iscas.ac.cn>
>>>> ---
>>>>   arch/riscv/Kconfig | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 4c07b9189c86..b49cea30f6cc 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -570,11 +570,15 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>>>   	def_bool y
>>>>   	#https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>>>> -	depends on AS_IS_GNU && AS_VERSION >= 23800
>>>> +	#https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>>>> +	depends on CC_IS_GCC && GCC_VERSION >= 120100 || \
>>>> +		   AS_IS_GNU && AS_VERSION >= 23800
>>> GCC_VERSION will be 0 for clang, so you don't need the CC_IS_GCC check.
>>> With that change, this should be able to stay on one line:
>>>
>>>      depends on GCC_VERSION >= 120100 || (AS_IS_GNU && AS_VERSION >= 23800)
>>>
>>>>   	help
>>>>   	  Newer binutils versions default to ISA spec version 20191213 which
>>>>   	  moves some instructions from the I extension to the Zicsr and Zifencei
>>>>   	  extensions.
>>>> +	  Similarly, GCC release 12.1.0 has changed the default ISA spec version to
>>>> +	  20191213, so the above situation requires this option to be enabled.
>>>>   
>>>>   config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>>>>   	def_bool y
>>>> -- 
>>>> 2.34.1
>>>>

