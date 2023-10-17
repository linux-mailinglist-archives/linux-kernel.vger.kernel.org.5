Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88F7CC4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbjJQNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjJQNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:42:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36D77ED;
        Tue, 17 Oct 2023 06:42:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6BB2F4;
        Tue, 17 Oct 2023 06:42:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2253F5A1;
        Tue, 17 Oct 2023 06:42:06 -0700 (PDT)
Date:   Tue, 17 Oct 2023 14:42:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-ID: <ZS6PKYMXDfAVTeLw@FVFF77S0Q05N>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:22:14PM +0100, Mark Brown wrote:
> On Tue, Oct 17, 2023 at 01:34:18PM +0530, Naresh Kamboju wrote:
> 
> > Following kernel crash noticed while running selftests: ftrace:
> > ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.
> 
> > This is not an easy to reproduce issue and not seen on mainline and next.
> > We are investigating this report.
> 
> To confirm have you seen this on other stables as well or is this only
> v6.5?  For how long have you been seeing this?
> 
> > [  764.987161] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000000
> 
> > [  765.074221] Call trace:
> > [  765.075045]  sve_save_state+0x4/0xf0
> > [  765.076138]  fpsimd_thread_switch+0x2c/0xe8
> > [  765.077305]  __switch_to+0x20/0x158
> > [  765.078384]  __schedule+0x2cc/0xb38
> > [  765.079464]  preempt_schedule_irq+0x44/0xa8
> > [  765.080633]  el1_interrupt+0x4c/0x68
> > [  765.081691]  el1h_64_irq_handler+0x18/0x28
> > [  765.082829]  el1h_64_irq+0x64/0x68
> > [  765.083874]  ftrace_return_to_handler+0x98/0x158
> > [  765.085090]  return_to_handler+0x20/0x48
> > [  765.086205]  do_sve_acc+0x64/0x128
> > [  765.087272]  el0_sve_acc+0x3c/0xa0
> > [  765.088356]  el0t_64_sync_handler+0x114/0x130
> > [  765.089524]  el0t_64_sync+0x190/0x198
> 
> So something managed to get flagged as having SVE state without having
> the backing storage allocated.  We *were* preempted in the SVE access
> handler which does the allocation but I can't see the path that would
> trigger that since we allocate the state before setting TIF_SVE.  It's
> possible the compiler did something funky, a decode of the backtrace
> might help show that?

Having a vmlinux would be *really* helpful...

I tried generating fpsimd.o using the same config and the kernel.org crosstool
GCC 13.2.0, code dump below. Assuming the code generation is the same as for
Naresh, do_sve_acc+0x64 is at 0x191c, and is just after the call to sve_alloc().

So IIUC what's happening here is that sve_alloc() has been called, its entry
has been traced, its body has been run, and in the process of tracing its
return an IRQ has preempted the task and caused a reschedule.

So unless sve_alloc() failed, at the instant the IRQ was taken:

* `task->thread.sve_state` should be non-NULL
* `task->thread_info.flags & TIF_SVE` should be 0

... so if `task->thread.sve_state` becomes NULL, I wonder if we end up
accidentally blatting that as part of the context switch? I can't immedaitely
see how/

Mark.

00000000000018b8 <do_sve_acc>:
    18b8:       d503201f        nop
    18bc:       d503201f        nop
    18c0:       d503233f        paciasp
    18c4:       a9be7bfd        stp     x29, x30, [sp, #-32]!
    18c8:       910003fd        mov     x29, sp
    18cc:       1400000a        b       18f4 <do_sve_acc+0x3c>
    18d0:       d503201f        nop
    18d4:       f9408022        ldr     x2, [x1, #256]
    18d8:       d2800003        mov     x3, #0x0                        // #0
    18dc:       52800080        mov     w0, #0x4                        // #4
    18e0:       52800021        mov     w1, #0x1                        // #1
    18e4:       94000000        bl      0 <force_signal_inject>
    18e8:       a8c27bfd        ldp     x29, x30, [sp], #32
    18ec:       d50323bf        autiasp
    18f0:       d65f03c0        ret
    18f4:       90000000        adrp    x0, 0 <system_cpucaps>
    18f8:       f9400000        ldr     x0, [x0]
    18fc:       b6f7fec0        tbz     x0, #62, 18d4 <do_sve_acc+0x1c>
    1900:       f9000bf3        str     x19, [sp, #16]
    1904:       d5384113        mrs     x19, sp_el0
    1908:       f9400260        ldr     x0, [x19]
    190c:       37b005e0        tbnz    w0, #22, 19c8 <do_sve_acc+0x110>
    1910:       aa1303e0        mov     x0, x19
    1914:       52800021        mov     w1, #0x1                        // #1
    1918:       94000000        bl      1140 <sve_alloc>
    191c:       f946be60        ldr     x0, [x19, #3448]
    1920:       b4000480        cbz     x0, 19b0 <do_sve_acc+0xf8>
    1924:       97fffb59        bl      688 <get_cpu_fpsimd_context>
    1928:       14000016        b       1980 <do_sve_acc+0xc8>
    192c:       d2a01000        mov     x0, #0x800000                   // #8388608
    1930:       f8e03260        ldsetal x0, x0, [x19]
    1934:       36b80040        tbz     w0, #23, 193c <do_sve_acc+0x84>
    1938:       d4210000        brk     #0x800
    193c:       d5384113        mrs     x19, sp_el0
    1940:       f9400260        ldr     x0, [x19]
    1944:       371802c0        tbnz    w0, #3, 199c <do_sve_acc+0xe4>
    1948:       b94d8a73        ldr     w19, [x19, #3464]
    194c:       53047e73        lsr     w19, w19, #4
    1950:       51000673        sub     w19, w19, #0x1
    1954:       aa1303e0        mov     x0, x19
    1958:       94000000        bl      0 <sve_set_vq>
    195c:       aa1303e1        mov     x1, x19
    1960:       52800020        mov     w0, #0x1                        // #1
    1964:       94000000        bl      0 <sve_flush_live>
    1968:       97fffbb4        bl      838 <fpsimd_bind_task_to_cpu>
    196c:       97fffb61        bl      6f0 <put_cpu_fpsimd_context>
    1970:       f9400bf3        ldr     x19, [sp, #16]
    1974:       a8c27bfd        ldp     x29, x30, [sp], #32
    1978:       d50323bf        autiasp
    197c:       d65f03c0        ret
    1980:       f9800271        prfm    pstl1strm, [x19]
    1984:       c85f7e60        ldxr    x0, [x19]
    1988:       b2690001        orr     x1, x0, #0x800000
    198c:       c802fe61        stlxr   w2, x1, [x19]
    1990:       35ffffa2        cbnz    w2, 1984 <do_sve_acc+0xcc>
    1994:       d5033bbf        dmb     ish
    1998:       17ffffe7        b       1934 <do_sve_acc+0x7c>
    199c:       aa1303e0        mov     x0, x19
    19a0:       97fffaf2        bl      568 <fpsimd_to_sve>
    19a4:       52800040        mov     w0, #0x2                        // #2
    19a8:       b90d7260        str     w0, [x19, #3440]
    19ac:       17fffff0        b       196c <do_sve_acc+0xb4>
    19b0:       52800120        mov     w0, #0x9                        // #9
    19b4:       94000000        bl      0 <force_sig>
    19b8:       f9400bf3        ldr     x19, [sp, #16]
    19bc:       a8c27bfd        ldp     x29, x30, [sp], #32
    19c0:       d50323bf        autiasp
    19c4:       d65f03c0        ret
    19c8:       d4210000        brk     #0x800
    19cc:       f9400bf3        ldr     x19, [sp, #16]
    19d0:       17ffffc1        b       18d4 <do_sve_acc+0x1c>
    19d4:       d503201f        nop
    19d8:       d503201f        nop
    19dc:       d503201f        nop
