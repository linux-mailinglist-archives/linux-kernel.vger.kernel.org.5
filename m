Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2276C6DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjHBHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHBHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:32:20 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1131EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:32:18 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0021224E03C;
        Wed,  2 Aug 2023 15:32:16 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 15:32:17 +0800
Received: from [192.168.125.127] (183.27.98.54) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 15:32:15 +0800
Message-ID: <d64874cb-8628-a6d2-d2f4-8af4d0ebf8b2@starfivetech.com>
Date:   Wed, 2 Aug 2023 15:32:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace
 zihintpause
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Dao Lu <daolu@rivosinc.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
 <20230802-sharpness-spoon-f9b8804fb66f@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230802-sharpness-spoon-f9b8804fb66f@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/2 14:54, Conor Dooley wrote:
> Hey Minda,
> 
> On Wed, Aug 02, 2023 at 02:42:15PM +0800, Minda Chen wrote:
>> Actually it is a part of Conor's
>> commit aae538cd03bc ("riscv: fix detection of toolchain
>> Zihintpause support").
>> It is looks like a merge issue.
> 
> Yup, spot on.
> 
>> Samuel's
>> commit 0b1d60d6dd9e ("riscv: Fix build with
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y") do not base on Conor's commit and
>> revert to __riscv_zihintpause. So this patch can fix it.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
> Did you actually manage to trigger this, or was this by inspection?
> clang-15 + binutils 2.35 was, IIRC, how we spotted this because that's
> what the clang-built-linux CI uses to test the LTS kernels from before
> LLVM's IAS was supported for RISC-V. Seemingly all that needs to be
> satisfied there is that zihintpause doesn't appear in -march so this has
> gone unnoticed.
> 
> Fixes: 3c349eacc559 ("Merge patch "riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y"")
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
Thanks, Conor. I found this just by inspection. I found a issue that vdso.so call cpu_relax
cause application core dump in kernel 6.1.31. I need Samuel'patch to fix this. And I search the log
of processor.h found this issue.
>> ---
>>  arch/riscv/include/asm/vdso/processor.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
>> index 14f5d27783b8..96b65a5396df 100644
>> --- a/arch/riscv/include/asm/vdso/processor.h
>> +++ b/arch/riscv/include/asm/vdso/processor.h
>> @@ -14,7 +14,7 @@ static inline void cpu_relax(void)
>>  	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>  #endif
>>  
>> -#ifdef __riscv_zihintpause
>> +#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
>>  	/*
>>  	 * Reduce instruction retirement.
>>  	 * This assumes the PC changes.
>> -- 
>> 2.17.1
>> 
