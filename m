Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7D770959
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHDUF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHDUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:05:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D73C23
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691179512;
        bh=p8ApPgTyUo2or9aOrW2DrLZDU1RW+YyeyjKyOfQLzik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WMf3LUZ7Pl5T/mi9vfZRQ6InwkKNMa1TzAuwxh0eCo/8ruAnYsboLh5rlSxLfRHub
         SRmm9NElBvbNhzcWDaHEOUyWZL+HLy5iTFvGQHibJ0gVuF6yXjqrh/tKJMFjykCqYr
         sWT3XY55NUo1SORtwxc8btD3shAIYdgIq4KqKe6iTNp3h1hjAh0rvxIF/6+BetpygN
         oeGoaBjjf/Y29O6r7s5bsfvFnkfITGC3IsrV73zt7MFtlOgLm2ytFZlFjZ1ovpu1Hz
         aLPr393+PBkUHqfmxEtb41ufquZoClOheuP9cPtl3hDNGhamwoddQP4EuLp/FqP7nV
         zdjMyRZ2VD5EQ==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RHcBv5PB5z1KQ1;
        Fri,  4 Aug 2023 16:05:11 -0400 (EDT)
Message-ID: <e17900b8-ad20-e5c1-2443-0f9559f1fdb8@efficios.com>
Date:   Fri, 4 Aug 2023 16:06:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea> <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
 <ZMxDe0gXKYbY5jgt@andrea> <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
 <ZM0STfpkRSfNQBt8@andrea> <ab562167-e4a5-4a7d-7722-a4f99848d63e@efficios.com>
 <ZM1OhJY8/PZ/osTH@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZM1OhJY8/PZ/osTH@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 15:16, Andrea Parri wrote:
> On Fri, Aug 04, 2023 at 02:05:55PM -0400, Mathieu Desnoyers wrote:
>> On 8/4/23 10:59, Andrea Parri wrote:
>>>> What is the relationship between FENCE.I and instruction cache flush on
>>>> RISC-V ?
>>>
>>> The exact nature of this relationship is implementation-dependent.  From
>>> commentary included in the ISA portion referred to in the changelog:
>>>
>>>     A simple implementation can flush the local instruction cache and
>>>     the instruction pipeline when the FENCE.I is executed.  A more
>>>     complex implementation might snoop the instruction (data) cache on
>>>     every data (instruction) cache miss, or use an inclusive unified
>>>     private L2 cache to invalidate lines from the primary instruction
>>>     cache when they are being written by a local store instruction.  If
>>>     instruction and data caches are kept coherent in this way, or if
>>>     the memory system consists of only uncached RAMs, then just the
>>>     fetch pipeline needs to be flushed at a FENCE.I.  [..]
>>>
>>> Mmh, does this help?
>>
>> Quoting
>>
>> https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf
>>
>> Chapter 3 "“Zifencei” Instruction-Fetch Fence, Version 2.0"
>>
>> "First, it has been recognized that on some systems, FENCE.I will be expensive to implement
>> and alternate mechanisms are being discussed in the memory model task group. In particular,
>> for designs that have an incoherent instruction cache and an incoherent data cache, or where
>> the instruction cache refill does not snoop a coherent data cache, both caches must be completely
>> flushed when a FENCE.I instruction is encountered. This problem is exacerbated when there are
>> multiple levels of I and D cache in front of a unified cache or outer memory system.
>>
>> Second, the instruction is not powerful enough to make available at user level in a Unix-like
>> operating system environment. The FENCE.I only synchronizes the local hart, and the OS can
>> reschedule the user hart to a different physical hart after the FENCE.I. This would require the
>> OS to execute an additional FENCE.I as part of every context migration. For this reason, the
>> standard Linux ABI has removed FENCE.I from user-level and now requires a system call to
>> maintain instruction-fetch coherence, which allows the OS to minimize the number of FENCE.I
>> executions required on current systems and provides forward-compatibility with future improved
>> instruction-fetch coherence mechanisms.
>>
>> Future approaches to instruction-fetch coherence under discussion include providing more
>> restricted versions of FENCE.I that only target a given address specified in rs1, and/or allowing
>> software to use an ABI that relies on machine-mode cache-maintenance operations."
>>
>> I start to suspect that even the people working on the riscv memory model have noticed
>> that letting a single instruction such as FENCE.I take care of both cache coherency
>> *and* flush the instruction pipeline will be a performance bottleneck, because it
>> can only clear the whole instruction cache.
>>
>> Other architectures are either cache-coherent, or have cache flushing which can be
>> performed on a range of addresses. This is kept apart from whatever instruction
>> flushes the instruction pipeline of the processor.
>>
>> By keeping instruction cache flushing separate from instruction pipeline flush, we can
>> let membarrier (and context switches, including thread migration) only care about the
>> instruction pipeline part, and leave instruction cache flush to either a dedicated
>> system call, or to specialized instructions which are available from user-mode.
>>
>> Considering that FENCE.I is forced to invalidate the whole i-cache, I don't think you
>> will get away with executing it from switch_mm without making performance go down the
>> drain on cache incoherent implementations.
>>
>> In my opinion, what we would need from RISC-V for membarrier (and context switch) is a
>> lightweight version of FENCE.I which only flushes the instruction pipeline of the local
>> processor. This should ideally come with a way for architectures with incoherent caches
>> to flush the relevant address ranges of the i-cache which are modified by a JIT. This
>> i-cache flush would not be required to flush the instruction pipeline, as it is typical
>> to batch invalidation of various address ranges together and issue a single instruction
>> pipeline flush on each CPU at the end. The i-cache flush could either be done by new
>> instructions available from user-space (similar to aarch64), or through privileged
>> instructions available through system calls (similar to arm cacheflush).
> 
> Thanks for the remarks, Mathieu.  I think it will be very helpful to
> RISC-V architects (and memory model people) to have this context and
> reasoning written down.

One more noteworthy detail: if a system call similar to ARM cacheflush(2) is implemented for
RISC-V, perhaps an iovec ABI (similar to readv(2)/writev(2)) would be relevant to handle
batching of cache flushing when address ranges are not contiguous. Maybe with a new name
like "cacheflushv(2)", so eventually other architectures could implement it as well ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

