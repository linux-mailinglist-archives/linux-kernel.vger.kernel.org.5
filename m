Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D8770772
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHDSFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHDSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:05:05 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106AC46A3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691172302;
        bh=VHBir7999qQ/5qjfN/1N+4Xr5C/fghWazsI01lj3bq0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BKXCI30TCLRoc/dHYnRk74jGhjC6o38c8FfkDKAy1H3oGeXMy27XEAJX+8DuR+njg
         rc+VAc5q3KOZl2r30ifupkrhSo7Bhx25Kzj3nfmpz/QypRQmuEBMA9+0GQGukJzqFQ
         vVlRxa+xlYibD5ulDqy9s1BITu/WbGJXe+CK7VqVPBDdTh228Bwwu5/eKLTg4ZwwlC
         NNrUC7URVx4TdAbSQ8cvb/Ql8CCOWug718ZJmTN0ewzB/uNoHorjecrBR2mh0+k+aY
         4XEn2MzI+Uq/AihSfDR4Cqylyr3mFZs3bXjAFeSQh0X5prrS1R47dthyJZKgYIOFRN
         Qr12Vkl7M147A==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RHYXG1Cx3z1KW8;
        Fri,  4 Aug 2023 14:05:02 -0400 (EDT)
Message-ID: <ab562167-e4a5-4a7d-7722-a4f99848d63e@efficios.com>
Date:   Fri, 4 Aug 2023 14:05:55 -0400
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
 <ZM0STfpkRSfNQBt8@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZM0STfpkRSfNQBt8@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 10:59, Andrea Parri wrote:
>> What is the relationship between FENCE.I and instruction cache flush on
>> RISC-V ?
> 
> The exact nature of this relationship is implementation-dependent.  From
> commentary included in the ISA portion referred to in the changelog:
> 
>    A simple implementation can flush the local instruction cache and
>    the instruction pipeline when the FENCE.I is executed.  A more
>    complex implementation might snoop the instruction (data) cache on
>    every data (instruction) cache miss, or use an inclusive unified
>    private L2 cache to invalidate lines from the primary instruction
>    cache when they are being written by a local store instruction.  If
>    instruction and data caches are kept coherent in this way, or if
>    the memory system consists of only uncached RAMs, then just the
>    fetch pipeline needs to be flushed at a FENCE.I.  [..]
> 
> Mmh, does this help?

Quoting

https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf

Chapter 3 "“Zifencei” Instruction-Fetch Fence, Version 2.0"

"First, it has been recognized that on some systems, FENCE.I will be expensive to implement
and alternate mechanisms are being discussed in the memory model task group. In particular,
for designs that have an incoherent instruction cache and an incoherent data cache, or where
the instruction cache refill does not snoop a coherent data cache, both caches must be completely
flushed when a FENCE.I instruction is encountered. This problem is exacerbated when there are
multiple levels of I and D cache in front of a unified cache or outer memory system.

Second, the instruction is not powerful enough to make available at user level in a Unix-like
operating system environment. The FENCE.I only synchronizes the local hart, and the OS can
reschedule the user hart to a different physical hart after the FENCE.I. This would require the
OS to execute an additional FENCE.I as part of every context migration. For this reason, the
standard Linux ABI has removed FENCE.I from user-level and now requires a system call to
maintain instruction-fetch coherence, which allows the OS to minimize the number of FENCE.I
executions required on current systems and provides forward-compatibility with future improved
instruction-fetch coherence mechanisms.

Future approaches to instruction-fetch coherence under discussion include providing more
restricted versions of FENCE.I that only target a given address specified in rs1, and/or allowing
software to use an ABI that relies on machine-mode cache-maintenance operations."

I start to suspect that even the people working on the riscv memory model have noticed
that letting a single instruction such as FENCE.I take care of both cache coherency
*and* flush the instruction pipeline will be a performance bottleneck, because it
can only clear the whole instruction cache.

Other architectures are either cache-coherent, or have cache flushing which can be
performed on a range of addresses. This is kept apart from whatever instruction
flushes the instruction pipeline of the processor.

By keeping instruction cache flushing separate from instruction pipeline flush, we can
let membarrier (and context switches, including thread migration) only care about the
instruction pipeline part, and leave instruction cache flush to either a dedicated
system call, or to specialized instructions which are available from user-mode.

Considering that FENCE.I is forced to invalidate the whole i-cache, I don't think you
will get away with executing it from switch_mm without making performance go down the
drain on cache incoherent implementations.

In my opinion, what we would need from RISC-V for membarrier (and context switch) is a
lightweight version of FENCE.I which only flushes the instruction pipeline of the local
processor. This should ideally come with a way for architectures with incoherent caches
to flush the relevant address ranges of the i-cache which are modified by a JIT. This
i-cache flush would not be required to flush the instruction pipeline, as it is typical
to batch invalidation of various address ranges together and issue a single instruction
pipeline flush on each CPU at the end. The i-cache flush could either be done by new
instructions available from user-space (similar to aarch64), or through privileged
instructions available through system calls (similar to arm cacheflush).

Thanks,

Mathieu


> 
>    Andrea

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

