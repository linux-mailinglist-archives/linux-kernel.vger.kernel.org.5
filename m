Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C800D769B46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjGaPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjGaPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:51:52 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B210D;
        Mon, 31 Jul 2023 08:51:50 -0700 (PDT)
Received: from [192.168.0.107] (unknown [111.197.209.91])
        by APP-03 (Coremail) with SMTP id rQCowAC312Re2MdksdyvDw--.16505S2;
        Mon, 31 Jul 2023 23:50:54 +0800 (CST)
Message-ID: <c2077e70-98ef-158f-fc82-4ed484f7ee37@iscas.ac.cn>
Date:   Mon, 31 Jul 2023 23:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and
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
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
References: <20230731095534.22842-1-xingmingzheng@iscas.ac.cn>
 <20230731150511.38140-1-xingmingzheng@iscas.ac.cn>
 <20230731-legume-commend-9aafd84c1fb2@spud>
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <20230731-legume-commend-9aafd84c1fb2@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowAC312Re2MdksdyvDw--.16505S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kuF4rKFyDXr1rXw17Awb_yoW5Gryrpr
        WfuF1Durs5Kw18J3Z5JF1UX3WYgrZ3G342gF15t34DWrs5GFykKr4S9w43uFn8ZFn2gr1Y
        vrn29FZYgw1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU56c_DUUUUU==
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCgkJCmTHu5c2qAAAsR
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 23:24, Conor Dooley wrote:
> On Mon, Jul 31, 2023 at 11:05:11PM +0800, Mingzheng Xing wrote:
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
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> This looks good to me now, thanks! Hopefully the next time we look at
> this code is removing support for binutils 2.35 :)

Thank you for the quick reply.
Hopefully no more "with weeping and gnashing of teeth". ;

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.

