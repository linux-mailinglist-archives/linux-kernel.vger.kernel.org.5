Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BD76FA03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHDGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjHDGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:24:23 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14930C0;
        Thu,  3 Aug 2023 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691130253; bh=Ml+2o2coZyFwXLt1pDiShFgGa38mdGTl6NbjJ3zSPR0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jPL8PmVG9vYf+Dvnn6yL8DKdoJdeSVtwqngcjpDmbGCAfphQMyJ8Bld8gxFn+K3/Y
         csrmLcih49YCU9tyCFJOAy+Hqfwjlu1fZzf+afNXBBGLycuo0p82FngYv+mZiMmEIM
         FdkvcBhRxqIa7CbLTWIiJmLmfxHqx0BTUR3g9/Us=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6ABE5600CE;
        Fri,  4 Aug 2023 14:24:13 +0800 (CST)
Message-ID: <32a2ee70-c964-5a1e-06b5-d64c43384f2c@xen0n.name>
Date:   Fri, 4 Aug 2023 14:24:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] raid6: Add LoongArch SIMD recovery implementation
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Song Liu <song@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        linux-raid@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
References: <20230803170858.781245-1-kernel@xen0n.name>
 <20230803170858.781245-4-kernel@xen0n.name>
 <1363eb24-e209-6617-c205-19f13aa97b95@molgen.mpg.de>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1363eb24-e209-6617-c205-19f13aa97b95@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/8/4 03:49, Paul Menzel wrote:
> Dear Xuerui,
> 
> 
> Thank you for your patches.
> 
> 
> Am 03.08.23 um 19:08 schrieb WANG Xuerui:
>> From: WANG Xuerui <git@xen0n.name>
>>
>> Similar to the syndrome calculation, the recovery algorithms also work
>> on 64 bytes at a time to align with the L1 cache line size of current
>> and future LoongArch cores (that we care about). Which means
>> unrolled-by-4 LSX and unrolled-by-2 LASX code.
>>
>> The assembly is originally based on the x86 SSSE3/AVX2 ports, but
>> register allocation has been redone to take advantage of LSX/LASX's 32
>> vector registers, and instruction sequence has been optimized to suit
>> (e.g. LoongArch can perform per-byte srl and andi on vectors, but x86
>> cannot).
>>
>> Performance numbers measured by instrumenting the raid6test code:
> 
> It’d be great, if you also documented your test setup. That’s always 
> good for benchmarking numbers.
> 

Ah they're the same as described in the previous patches: a Loongson 
3A5000 + 7A1000 board (the Lemote A2101 board to be precise), with the 
3A5000 clocked at 2.5GHz. I'll amend the description in v3.

>>> lasx  2data: 354.987 MiB/s
>>> lasx  datap: 350.430 MiB/s
>>> lsx   2data: 340.026 MiB/s
>>> lsx   datap: 337.318 MiB/s
>>> intx1 2data: 164.280 MiB/s
>>> intx1 datap: 187.966 MiB/s
> 
> So the speed is more than doubled. Nice job! The lasx implementation is 
> always the fastest. Is it therefore the preferred one? Or does it come 
> with higher power consumption?

According to my experiments and other public info regarding the LA464 
micro-architecture such as [1], this should be the case for LA464, with 
no power consumption worries.

(Both LASX and LSX are handled by the same vector unit on LA464, so 
whenever LASX is available it should be preferred, as it's LSX that 
would be purely wasteful in this case: a full 256-bit result would get 
computed regardless.)

[1]: 
https://chipsandcheese.com/2023/04/09/loongsons-3a5000-chinas-best-shot/

> 
>> Signed-off-by: WANG Xuerui <git@xen0n.name>
> 
> Out of curiosity, what is your “first” name?

My first name / given name is "Xuerui"; I usually prefer having my 
romanized name in "native-endian" whenever it's convenient ;-)

> 
>> ---
>>   include/linux/raid/pq.h          |   2 +
>>   lib/raid6/Makefile               |   2 +-
>>   lib/raid6/algos.c                |   8 +
>>   lib/raid6/recov_loongarch_simd.c | 515 +++++++++++++++++++++++++++++++
>>   lib/raid6/test/Makefile          |   2 +-
>>   5 files changed, 527 insertions(+), 2 deletions(-)
>>   create mode 100644 lib/raid6/recov_loongarch_simd.c
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [snip]
>> +
>> +    /* Now, pick the proper data tables */
>> +    pbmul = raid6_vgfmul[raid6_gfexi[failb-faila]];
> 
> Should spaces be put around the operator?

Hmm, AFAICS almost all raid6 files "inherit" the scalar reference 
implementation's coding style, that happens to differ from the 
documented one. But given I already adjusted some of the comments, I 
think it would be best to also touch these too. Thanks for spotting this 
(and the others below).

> 
>> +    qmul  = raid6_vgfmul[raid6_gfinv[raid6_gfexp[faila] ^
>> +        raid6_gfexp[failb]]];
>> +
>> [snip]
>> +
>> +    /* Now, pick the proper data tables */
>> +    qmul  = raid6_vgfmul[raid6_gfinv[raid6_gfexp[faila]]];
> 
> Only one space after qmul?

As explained above; I'll fix this one and others in v3.

> [snip]
>> +    /* Now, pick the proper data tables */
>> +    pbmul = raid6_vgfmul[raid6_gfexi[failb-faila]];
> 
> Ditto.
> 
> [snip]
>> +    /* Now, pick the proper data tables */
>> +    qmul  = raid6_vgfmul[raid6_gfinv[raid6_gfexp[faila]]];
> 
> Ditto.
> 
> [snip]
>> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
>> index 7b244bce32b3d..2abe0076a636c 100644
>> --- a/lib/raid6/test/Makefile
>> +++ b/lib/raid6/test/Makefile
>> @@ -65,7 +65,7 @@ else ifeq ($(HAS_ALTIVEC),yes)
>>           OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
>>                   vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
>>   else ifeq ($(ARCH),loongarch64)
>> -        OBJS += loongarch_simd.o
>> +        OBJS += loongarch_simd.o recov_loongarch_simd.o
>>   endif
>>   .c.o:
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: I brought up the raid speed tests in the past, and Borislav called 
> them a random number generator [1]. ;-)
> 
> 
> [1]: https://lore.kernel.org/all/20210406124126.GM17806@zn.tnic/

Interesting, so the reason I've yet to observe such wild fluctuations 
may simply be that I didn't reboot that rig as many times. :D

And thanks for the review! I'll send v3 some time later (and stress the 
code more meanwhile).

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

