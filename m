Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED878C495
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjH2M40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjH2Mzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:55:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F7629D;
        Tue, 29 Aug 2023 05:55:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8992F4;
        Tue, 29 Aug 2023 05:56:28 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05AE3F64C;
        Tue, 29 Aug 2023 05:55:47 -0700 (PDT)
Message-ID: <15c1cc81-c131-7abf-1680-0bbc968e638b@arm.com>
Date:   Tue, 29 Aug 2023 13:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: About ARM64 Kernel Instruction Trace
Content-Language: en-US
To:     scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yang@os.amperecomputing.com
References: <ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/08/2023 05:44, Steve Clevenger wrote:
> 
> Ampere has been using the following command sequence to generate a 'perf
> record' kernel instruction trace on an AmpereOne AARCH64 based systems
> using a 6.3.0 Fedora distribution with CoreSight related patches.
> 
> 
> [root@sut01sys-b212 kernel]# uname -a
> Linux sut01sys-b212.scc-lab.amperecomputing.com 6.3.0-coresight-enabled+
> #9 SMP PREEMPT_DYNAMIC Fri Jun 30 12:54:14 PDT 2023 aarch64 aarch64
> aarch64 GNU/Linux
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# timeout 45s perf record --kcore -o kcore -e
> cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
> of=/dev/null
> [ perf record: Woken up 41 times to write data ]
> [ perf record: Captured and wrote 144.056 MB kcore ]
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
> -rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# timeout 45s perf script --input
> ./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
> cpu,event,ip,addr,sym – -d objdump -k ~/linux/vmlinux > ./perf.itrace
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# ls -l perf.itrace
> -rw-r--r--. 1 root root  485834744 Jul 17 14:18 perf.itrace
> 
> 
> The executive summary is the code sections in vmlinux do not match the
> actual code executing on the target due to self-modifying code
> (alternate code sequences) in the kernel image. These sequences are
> typically applied over nop place-holder instructions. This was verified
> by comparing a location in the ./drivers/char/mem.c read_zero objdump
> instruction stream to the memory resident instructions captured with the
> TRACE32 ETM instruction trace feature. This particular instruction trace
> example shows a disconnect. It displays a ‘b    ffff800008ab8a70
> <read_zero+0x168>’ instruction at address 0xffff800008ab89e8 which did
> not branch. The actual instruction present at 0xffff800008ab89e8 is a ‘nop’.
>         .
>         .
>         ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
> <read_zero+0xd4>
>               dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
>         ffff800008ab89dc <read_zero+0xd4>:
>         ffff800008ab89dc:       9248f840        and     x0, x2,
> #0xff7fffffffffffff
>         ffff800008ab89e0:       aa1403e1        mov     x1, x20
>         ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
> <__arch_clear_user>
>               dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
> ffff8000090e65d0 <__arch_clear_user>:
>         ffff8000090e65d0:       d503245f        bti     c
>         ffff8000090e65d4:       8b010002        add     x2, x0, x1
>         ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
> <__arch_clear_user+0x2c>  // b.first
>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> <__arch_clear_user+0x10>  // b.pmore
>               dd  8774/8774  [0015]         0.000000000
> __arch_clear_user+0x1c
> ...vec/linux/arch/arm64/lib/clear_user.S   31         b.hi    1b
>         ffff8000090e65e0 <__arch_clear_user+0x10>:
>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> <__arch_clear_user+0x10>  // b.pmore
>         .
>         .
>         ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
>         ffff8000090e65f4:       d2800000        mov     x0, #0x0
>                // #0
>         ffff8000090e65f8:       d65f03c0        ret
>               dd  8774/8774  [0015]         0.000000000
> __arch_clear_user+0x28
> ...vec/linux/arch/arm64/lib/clear_user.S   34         ret
>         ffff800008ab89e8 <read_zero+0xe0>:
>         ffff800008ab89e8:       14000022        b       ffff800008ab8a70
> <read_zero+0x168>
>         ffff800008ab89ec:       d503201f        nop
>              dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
>                         /home/stevec/linux/drivers/char/mem.c     521
>              left = clear_user(buf + cleared, chunk);
>         ffff800008ab8a18 <read_zero+0x110>:
>         ffff800008ab8a18:       8b14035a        add     x26, x26, x20
>         ffff800008ab8a1c:       b5000360        cbnz    x0,
> ffff800008ab8a88 <read_zero+0x180>
>         ffff800008ab8a20:       f9400320        ldr     x0, [x25]
>         ffff800008ab8a24:       cb140273        sub     x19, x19, x20
>         .
>         .
> 
> Ostensibly, the ‘perf record –kcore’ option produces a representative
> image of the kernel. But this option does not produce suitable output to
> generate ARM64 kernel instruction trace. perf doesn’t disassemble ARM64,
> so the arm-cs-trace-disasm.py python script is used with the native
> objdump utility to provide ARM64 disassembly from CoreSight trace
> capture. objdump itself requires an ELF/DWARF file image + symbols to
> generate the symbolic (+ line information for mixed source) disassembly.
> The linux vmlinux image + symbols file is typically used for this
> purpose. The kallsyms file is not formatted for objdump use. As an
> experiment, I patched the executable code sections in a local copy of
> vmlinux with the corresponding executable code segments extracted from
> the kcore image using an Ampere internal ELF patch utility.
> 
> This patch utility leverages the (MIT Licensed) ELFIO open source
> library API. These were the commands.
> 
> 
> [root@sut01sys-b212 kernel]# timeout 30s perf record --kcore -o kcore -e
> cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
> of=/dev/null
> [ perf record: Woken up 25 times to write data ]
> [ perf record: Captured and wrote 88.053 MB kcore ]
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
> -rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
> [root@sut01sys-b212 kernel]# cp ~/linux/vmlinux .
> [root@sut01sys-b212 kernel]# patch-elf --help
> 
> patch-elf overlays the kernel image from a local copy of
> '/proc/kcore' to the  corresponding (by address) ELF sections
> in a local copy of the vmlinux ELF file.
> A local '/proc/kcore' is created by:
>     'perf report --kcore -e cs_etm/@tmc_etr1/k ...'
> The local (patched) vmlinux copy is used by:
>     'perf script -s arm-cs-trace-disasm.py ...'
> See the CoreSight Hardware-Assisted Trace Application Note for
> use of the 'perf report' and 'perf script' commands.
> 
> Usage: patch-elf <--verbose> kcore_file vmlinux_file
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# patch-elf kcore/kcore_dir/kcore ./vmlinux
> ELF File kcore Properties
> ELF file class:     ELF64
> ELF file encoding:  Little endian
> Machine:            ARM AArch64
> Type:               Core file
> Number of segments: 3
> Number of sections: 0
> 
> ELF File vmlinux Properties
> ELF file class:     ELF64
> ELF file encoding:  Little endian
> Machine:            ARM AArch64
> Type:               Shared object file
> Number of segments: 3
> Number of sections: 43
> 
> Patching section[ 2] ffff800008010000  17997936 bytes
> 
> Patching section[15] ffff800009a31000  20480 bytes
> 
> Patching section[16] ffff800009a40000  612372 bytes
> 
> Patching section[17] ffff800009ad5818  24752 bytes
> 
> [root@sut01sys-b212 kernel]# ls -l ./vmlinux
> -rwxr-xr-x. 1 root root 390426908 Jul 19 11:14 ./vmlinux*
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# timeout 45s perf script --input
> ./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
> cpu,event,ip,addr,sym – -d objdump -k ./vmlinux > ./perf.itrace
> [root@sut01sys-b212 kernel]#
> [root@sut01sys-b212 kernel]# ls -l perf.itrace
> -rw-r--r--. 1 root root  32142060 Jul 19 11:18 perf.itrace
> 
> Here is the representative kernel instruction trace using a patched vmlinux.
> 
>         .
>         .
>         ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
> <read_zero+0xd4>
>               dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
>         ffff800008ab89dc <read_zero+0xd4>:
>         ffff800008ab89dc:       9248f840        and     x0, x2,
> #0xff7fffffffffffff
>         ffff800008ab89e0:       aa1403e1        mov     x1, x20
>         ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
> <__arch_clear_user>
>               dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
> ffff8000090e65d0 <__arch_clear_user>:
>         ffff8000090e65d0:       d503245f        bti     c
>         ffff8000090e65d4:       8b010002        add     x2, x0, x1
>         ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
> <__arch_clear_user+0x2c>  // b.first
>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> <__arch_clear_user+0x10>  // b.pmore
>               dd  8774/8774  [0015]         0.000000000
> __arch_clear_user+0x1c
>         ffff8000090e65e0 <__arch_clear_user+0x10>:
>         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
>         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
>         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
>         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> <__arch_clear_user+0x10>  // b.pmore
>         .
>         .
>         ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
>         ffff8000090e65f4:       d2800000        mov     x0, #0x0
>                // #0
>         ffff8000090e65f8:       d65f03c0        ret
>               dd  8774/8774  [0015]         0.000000000
> __arch_clear_user+0x28
> ...vec/linux/arch/arm64/lib/clear_user.S   34         ret
>         ffff800008ab89e8 <read_zero+0xe0>:
>         ffff800008ab89e8:       d503201f        nop
>         ffff800008ab89ec:       1400000b        b       ffff800008ab8a18
> <read_zero+0x110>
>               dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
>                          /home/stevec/linux/drivers/char/mem.c     521
>               left = clear_user(buf + cleared, chunk);
>         ffff800008ab8a18 <read_zero+0x110>:
>         ffff800008ab8a18:       8b14035a        add     x26, x26, x20
>         ffff800008ab8a1c:       b5000360        cbnz    x0,
> ffff800008ab8a88 <read_zero+0x180>
>         ffff800008ab8a20:       f9400320        ldr     x0, [x25]
>         ffff800008ab8a24:       cb140273        sub     x19, x19, x20
>         .
>         .
>         .
> 
> This begs the question what perf enhancements could be added to make
> ARM64 kernel instruction trace easier to use? The process I’ve followed
> is cumbersome, but could be done behind the scenes by perf. The caveat
> is it requires a vmlinux which might not be available to an end user.
> Here are 2 options.
> 
> 1.	'perf report -kcore'could use the process I’ve used here
> transparently in the background. The plus side is the objdump feature of
> mixed disassembly is available based on the current vmlinux.
> 

Hi Steve,

What you're saying makes sense to me. I think #1 sounds best, I'm not
sure of the use-case where you wanted to make actionable decisions from
the trace but wouldn't have vmlinux available? Maybe an end-user could
be missing it, but I can only imagine use cases where you are actively
building and developing the kernel.

> 2.	'perf report -kcore' generates an ELF + symbols file based on
> kallsyms (and/or System.map). No vmlinux patching, so intermixed source
> and disassembly wouldn’t be available. It’s a reasonable alternative
> without relying on vmlinux.
> 
> It makes sense performance-wise to use an ARM64 disassembler directly
> through perf. perf-script use of the arm-cs-trace-disasm.py python
> script can be slow. I’m unfamiliar with the Intel implementation, but
> perf-annotate uses objdump. Unfortunately, I can't seem to get annotate
> to work for me. A patch operation is still be required if vmlinux is used.
> 

We have had other reports about arm-cs-trace-disasm.py being slow. I had
a plan to make it work with disassembly directly from Perf as that is
available in other modes. For example the annotate mode in perf already
works on Arm. What error are you getting with it exactly? It might
require installation of the aarch64 objdump tool if you are running on
x86, or provide the --objdump option?

> I suspect the CoreSight/perf communities are aware of these issues.
> Is there any ongoing work not known to the outside world?
> 
> Thanks and regards,
> Steve C.
