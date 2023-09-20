Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444F17A7888
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjITKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjITKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:04:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A650A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:04:33 -0700 (PDT)
X-QQ-mid: bizesmtp76t1695204251taao2372
Received: from [10.4.6.71] ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Sep 2023 18:04:10 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: IV30oiqrgAb5rna1TIEV7YfRW072k5eKxAQ5LfodYttb50A7vd2R+5p1I1QL1
        laK8zIgLCa1QBVxGwsSeVP+5VLUtRrYmsY7fkrLmPFb6782LLuRNqfN7Qt+bY2ujIMut0HC
        BbE+EyBB+E/toQsROAWBx8NpBFyspfc7ndKuq7pOsFXa5JtnWqkP0hw6ZQm3OxpB2ki6Yrc
        SIpl+l5rSdDaWiSJn6PzpZtYagyK+7kWxUiz7keJ4frDvRtYMfx5cJfagGgh0UkajE/5wYH
        wnMdqfNLQsG8FkoeCOTlcGpgIEJt082cNpIa+3MhnaDw5gxc+6nX8A+uWCNOHAUMm0lveTf
        AOPeR6/fQymbQ/ybHWWlpUjS9gW0w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4374422987798744598
Message-ID: <114145FFA8546AF1+24aac21b-3748-3d50-4154-a25ab59be1be@tinylab.org>
Date:   Wed, 20 Sep 2023 18:04:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -fixes] riscv: Remove duplicate objcopy flag
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-8cabcad9-a181-4db8-904b-3f7daa7621f1@palmer-ri-x1c9a>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <mhng-8cabcad9-a181-4db8-904b-3f7daa7621f1@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/20 17:52, Palmer Dabbelt 写道:
> On Thu, 14 Sep 2023 02:13:34 PDT (-0700), songshuaishuai@tinylab.org wrote:
>> There are two duplicate `-O binary` flags when objcopying from vmlinux
>> to Image/xipImage.
>>
>> RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
>> Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
>> in Kbuild would join them together.
>>
>> The `-O binary` flag is only needed for objcopying Image, so remove the
>> OBJCOPYFLAGS in the top-level riscv Makefile.
>>
>> Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>  arch/riscv/Makefile | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index 1329e060c548..b43a6bb7e4dc 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -6,7 +6,6 @@
>>  # for more details.
>>  #
>>
>> -OBJCOPYFLAGS    := -O binary
>>  LDFLAGS_vmlinux := -z norelro
>>  ifeq ($(CONFIG_RELOCATABLE),y)
>>      LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs
> 
> Does this result in any incorrect behavior?  It looks fine to me, but if
Nop, objcopy works as it's expected. You can put this patch on -next.

> there's no regression I'll put in on -next instead of -fixes.
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 

-- 
Thanks
Song Shuai
