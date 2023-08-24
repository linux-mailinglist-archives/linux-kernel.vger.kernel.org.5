Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB778771A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbjHXRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjHXRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:31:14 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046E19B5;
        Thu, 24 Aug 2023 10:31:07 -0700 (PDT)
Received: from [192.168.0.107] (unknown [111.197.209.91])
        by APP-05 (Coremail) with SMTP id zQCowACXnGC8k+dkhsHRBA--.2541S2;
        Fri, 25 Aug 2023 01:30:36 +0800 (CST)
Message-ID: <4177c0c5-4d36-75e1-84e2-c6ac82b74e50@iscas.ac.cn>
Date:   Fri, 25 Aug 2023 01:30:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Content-Language: en-US
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     patchwork-bot+linux-riscv@kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, bmeng@tinylab.org,
        guoren@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
References: <20230809165648.21071-1-xingmingzheng@iscas.ac.cn>
 <169228562484.20811.14246462375671910714.git-patchwork-notify@kernel.org>
 <20230823-captive-abdomen-befd942a4a73@wendy>
 <20230823-facelift-ovary-41f2eb4d9eac@spud>
 <4677fc33-6e76-21e6-2a7f-f12670bc1ce2@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <4677fc33-6e76-21e6-2a7f-f12670bc1ce2@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXnGC8k+dkhsHRBA--.2541S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWrWF4xWryktFWxKFWxZwb_yoWrKF4kp3
        4rGF17GrWUJr18Jwn7tr1jqryjyrWUJ34UXrn8JF1UJryDWr1jqF1xXryY9r1DtF4rGr18
        Ar1UGF1xZr1DJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiAxMNCmTnYidivAAAsP
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 19:32, Mingzheng Xing wrote:
> On 8/23/23 21:31, Conor Dooley wrote:
>> On Wed, Aug 23, 2023 at 12:51:13PM +0100, Conor Dooley wrote:
>>> On Thu, Aug 17, 2023 at 03:20:24PM +0000, 
>>> patchwork-bot+linux-riscv@kernel.org wrote:
>>>> Hello:
>>>>
>>>> This patch was applied to riscv/linux.git (fixes)
>>>> by Palmer Dabbelt <palmer@rivosinc.com>:
>>>>
>>>> On Thu, 10 Aug 2023 00:56:48 +0800 you wrote:
>>>>> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to 
>>>>> the newer
>>>>> 20191213 version which moves some instructions from the I 
>>>>> extension to the
>>>>> Zicsr and Zifencei extensions. So if one of the binutils and GCC 
>>>>> exceeds
>>>>> that version, we should explicitly specifying Zicsr and Zifencei 
>>>>> via -march
>>>>> to cope with the new changes. but this only occurs when binutils 
>>>>> >= 2.36
>>>>> and GCC >= 11.1.0. It's a different story when binutils < 2.36.
>>>>>
>>>>> [...]
>>>> Here is the summary with links:
>>>>    - [v5] riscv: Handle zicsr/zifencei issue between gcc and binutils
>>>>      https://git.kernel.org/riscv/c/ca09f772ccca
>>> *sigh* so this breaks the build for gcc-11 & binutils 2.37 w/
>>>     Assembler messages:
>>>     Error: cannot find default versions of the ISA extension `zicsr'
>>>     Error: cannot find default versions of the ISA extension `zifencei'
>>>
>>> I'll have a poke later.
>> So uh, are we sure that this should not be:
>> -       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || 
>> (CC_IS_GCC && GCC_VERSION < 110100)
>> +       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || 
>> (CC_IS_GCC && GCC_VERSION <= 110100)
>>
>> My gcc-11.1 + binutils 2.37 toolchain built from riscv-gnu-toolchain
>> doesn't have the default versions & the above diff fixes the build.
>
> I reproduced the error, the combination of gcc-11.1 and
> binutils 2.37 does cause errors. What a surprise, since binutils
> 2.36 and 2.38 are fine.
>
> I used git bisect to locate this commit[1] for binutils.
> I'll test this diff in more detail later. Thanks!
>
> [1] 
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c
>

Hi, Conor.
The above error does originate from link[1] mentioned above, which was
resolved in gcc-12.1.0[2], and gcc-11.3.0 made the backport[3].
So gcc-11.2.0 combined with binutils 2.37 produces the same error.
I think we should do the following diff to fix it:
-       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC 
&& GCC_VERSION < 110100)
+       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC 
&& GCC_VERSION < 110300)

Then below are my test results after the fix:

gcc        binutils

10.5.0     2.35            ok
10.5.0     2.36            ok
10.5.0     2.37            ok
10.5.0     2.38            ok

11.1.0     2.35            ok
11.1.0     2.36            ok
11.1.0     2.37            ok
11.1.0     2.38            ok

11.2.0     2.35            ok
11.2.0     2.36            ok
11.2.0     2.37            ok
11.2.0     2.38            ok

11.3.0     2.35            ok
11.3.0     2.36            ok
11.3.0     2.37            ok
11.3.0     2.38            ok

11.4.0     2.35            ok
11.4.0     2.36            ok
11.4.0     2.37            ok
11.4.0     2.38            ok

12.1.0     2.35            ok
12.1.0     2.36            ok
12.1.0     2.37            ok
12.1.0     2.38            ok

12.2.0     2.35            ok
12.2.0     2.36            ok
12.2.0     2.37            ok
12.2.0     2.38            ok

[1] 
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c
[2] 
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ca2bbb88f999f4d3cc40e89bc1aba712505dd598
[3] 
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671

Thanks,
Mingzheng.

>>
>> Thanks,
>> Conor.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

