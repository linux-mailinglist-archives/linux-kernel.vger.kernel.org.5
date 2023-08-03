Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6447E76F404
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjHCU2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjHCU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:27:56 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177D10CA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691094474;
        bh=u1lt9tMIgYVhdDY1Tv7aqcW7LU2YS85yFCEbSSPFIik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xR44LSieM2jVKrgBndvTW1FeNVa6kBgxkyS8VIPns4u+ojdcQRUJPCeRVnPVthaQU
         boV914OUnkbHUiNwBh8k95jQHGs6JY5k+A+bvW9WsSvAtfEe8qRVfQMhJA3w6isbVT
         /nWQLfYYpBGo7VoSOOfWmHeW+WaUJeZmHIdqJ+FsEx0UdZ0yJDLnhRqx2u+p4jmaAz
         zpc7IeDfuOgoFhXA8WToHcAOdkR9o2blahIIGSakcr7JYBRiuuKH2/D19Yc43Oaobk
         brCGKKrbdOV3t+i3sYwm2YXAmD/lIWqI/xi3oC+Id+EKlW0euhaLV5kRpIq9BY+cEx
         OeodwnAXBqUzA==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RH0lY3csfz1Kgj;
        Thu,  3 Aug 2023 16:27:53 -0400 (EDT)
Message-ID: <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
Date:   Thu, 3 Aug 2023 16:28:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mmaas@google.com, hboehm@google.com, striker@us.ibm.com
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZMvLoI6PxLR8RJvR@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 11:45, Andrea Parri wrote:
> Adding Martin, Hans and Derek to the Cc: list,
> 
>    Andrea
> 
> 
> On Thu, Aug 03, 2023 at 06:01:11AM +0200, Andrea Parri wrote:
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>> For the MEMBARRIER maintainers:  RISC-V does not have "core serializing
>> instructions", meaning that there is no occurence of such a term in the
>> RISC-V ISA.  The discussion and git history about the SYNC_CORE command
>> suggested the implementation below: a FENCE.I instruction "synchronizes
>> the instruction and data streams" [1] on a CPU; in litmus parlance,
>>

Can you double-check that riscv switch_mm() implies a fence.i or 
equivalent on the CPU doing the switch_mm ?

AFAIR membarrier use of sync_core_before_usermode relies on switch_mm 
issuing a core serializing instruction.

Thanks,

Mathieu


>>    (single-hart test)
>>
>>    CPU0
>>
>>    UPDATE text   ;
>>    FENCE.I       ;
>>    EXECUTE text  ;  /* <-- will execute the updated/new text */
>>
>>
>>    (message-passing test)
>>
>>    CPU0             CPU1
>>
>>    UPDATE text   |  IF (flag) {     ;
>>    WMB           |    FENCE.I       ;
>>    SET flag      |    EXECUTE text  ;  /* execute the new text */
>>                  |  }               ;
>>
>>
>>    (and many others, including "maybe"s!  ;-) )
>>
>> How do these remarks resonate with the semantics of "a core serializing
>> instruction" (to be issued before returning to user-space)?
>>
>> RISCV maintainers, I'm missing some paths to user-space? (besides xRET)
>>
>>    Andrea
>>
>> [1] https://github.com/riscv/riscv-isa-manual/blob/main/src/zifencei.adoc
>>
>>
>>   .../sched/membarrier-sync-core/arch-support.txt   |  2 +-
>>   arch/riscv/Kconfig                                |  2 ++
>>   arch/riscv/include/asm/sync_core.h                | 15 +++++++++++++++
>>   3 files changed, 18 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/include/asm/sync_core.h
>>
>> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
>> index 23260ca449468..a17117d76e6d8 100644
>> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
>> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
>> @@ -44,7 +44,7 @@
>>       |    openrisc: | TODO |
>>       |      parisc: | TODO |
>>       |     powerpc: |  ok  |
>> -    |       riscv: | TODO |
>> +    |       riscv: |  ok  |
>>       |        s390: |  ok  |
>>       |          sh: | TODO |
>>       |       sparc: | TODO |
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c867..ed7ddaedc692e 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -27,6 +27,7 @@ config RISCV
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>>   	select ARCH_HAS_GIGANTIC_PAGE
>>   	select ARCH_HAS_KCOV
>> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>   	select ARCH_HAS_MMIOWB
>>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>   	select ARCH_HAS_PMEM_API
>> @@ -35,6 +36,7 @@ config RISCV
>>   	select ARCH_HAS_SET_MEMORY if MMU
>>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>>   	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>> +	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>   	select ARCH_HAS_VDSO_DATA
>> diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
>> new file mode 100644
>> index 0000000000000..d3ec6ac47ac9b
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/sync_core.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_RISCV_SYNC_CORE_H
>> +#define _ASM_RISCV_SYNC_CORE_H
>> +
>> +/*
>> + * Ensure that a core serializing instruction is issued before returning
>> + * to user-mode.  RISC-V implements return to user-space through an xRET
>> + * instruction, which is not core serializing.
>> + */
>> +static inline void sync_core_before_usermode(void)
>> +{
>> +	asm volatile ("fence.i" ::: "memory");
>> +}
>> +
>> +#endif /* _ASM_RISCV_SYNC_CORE_H */
>> -- 
>> 2.34.1
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

