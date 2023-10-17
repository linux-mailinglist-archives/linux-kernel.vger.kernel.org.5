Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45367CC4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjJQN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:27:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2FEA;
        Tue, 17 Oct 2023 06:27:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19CEC433C8;
        Tue, 17 Oct 2023 13:27:20 +0000 (UTC)
Date:   Tue, 17 Oct 2023 09:28:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@google.com>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
Message-ID: <20231017092857.304a6d11@gandalf.local.home>
In-Reply-To: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 13:34:18 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Following kernel crash noticed while running selftests: ftrace:
> ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.
> 
> This is not an easy to reproduce issue and not seen on mainline and next.
> We are investigating this report.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> 
> Test log:
> ----------
> kselftest: Running tests in ftrace
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: ftrace: ftracetest-ktap
> # TAP version 13
> # 1..129
> # ok 1 Basic trace file check
> # ok 2 Basic test for tracers
> # ok 3 Basic trace clock test
> # ok 4 Basic event tracing check
> # ok 5 Change the ringbuffer size
> # ok 6 Snapshot and tracing setting
> # ok 7 Snapshot and tracing_cpumask
> # ok 8 trace_pipe and trace_marker

Sad part about ktap format is that it doesn't show you what test crashed. I
had to run it to see what was next. That was:

  ok 9 Test ftrace direct functions against tracers

Adding Mark Rutland and Florent, as they worked on the direct trampolines
on Arm 64.

-- Steve


> [  471.689140]
> [  471.689264] **********************************************************
> [  471.689422] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> [  471.689574] **                                                      **
> [  471.689716] ** trace_printk() being used. Allocating extra memory.  **
> [  471.689878] **                                                      **
> [  471.690031] ** This means that this is a DEBUG kernel and it is     **
> [  471.690183] ** unsafe for production use.                           **
> [  471.690335] **                                                      **
> [  471.690487] ** If you see this message and you are not debugging    **
> [  471.690728] ** the kernel, report this immediately to your vendor!  **
> [  471.690881] **                                                      **
> [  471.691033] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> [  471.691185] **********************************************************
> [  543.243648] hrtimer: interrupt took 11937170 ns
> [  764.987161] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  764.992518] Mem abort info:
> [  764.995330]   ESR = 0x0000000096000044
> [  764.998562]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  765.002434]   SET = 0, FnV = 0
> [  765.005361]   EA = 0, S1PTW = 0
> [  765.008327]   FSC = 0x04: level 0 translation fault
> [  765.012011] Data abort info:
> [  765.014858]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> [  765.018797]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [  765.022562]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  765.026438] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008848bd000
> [  765.030782] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  765.037045] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> [  765.038392] Modules linked in: ftrace_direct pl111_drm arm_spe_pmu
> drm_dma_helper crct10dif_ce panel_simple drm_kms_helper fuse drm
> dm_mod ip_tables x_tables [last unloaded: ftrace_direct]
> [  765.044892] CPU: 3 PID: 808 Comm: rmmod Not tainted 6.5.8-rc2 #1
> [  765.046192] Hardware name: FVP Base RevC (DT)
> [  765.047264] pstate: 234020c9 (nzCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [  765.048693] pc : sve_save_state+0x4/0xf0
> [  765.049820] lr : fpsimd_save+0x1b8/0x218
> [  765.050933] sp : ffff800080a83ac0
> [  765.051871] x29: ffff800080a83ac0 x28: ffff000805257058 x27: 0000000000000001
> [  765.054108] x26: 0000000000000000 x25: ffffd7c64d332980 x24: 0000000000000000
> [  765.056341] x23: 0000000000000001 x22: ffff284232103000 x21: 0000000000000040
> [  765.058575] x20: ffff00087f7470b0 x19: ffffd7c64d6440b0 x18: 0000000000000000
> [  765.060811] x17: 0000000000000000 x16: ffff800080018000 x15: 0000000000000000
> [  765.063041] x14: 0000000000000000 x13: 0000000000000000 x12: 0000380a873b560e
> [  765.065277] x11: ffffd7c64e0ae390 x10: ffff800080a83b10 x9 : ffffd7c64b5b7710
> [  765.067516] x8 : ffff800080a839b8 x7 : 000000000000001e x6 : ffff00080000c200
> [  765.069752] x5 : ffffd7c64b78cc30 x4 : 0000000000000000 x3 : 0000000000000000
> [  765.071983] x2 : 0000000000000001 x1 : ffff000805257820 x0 : 0000000000000880
> [  765.074221] Call trace:
> [  765.075045]  sve_save_state+0x4/0xf0
> [  765.076138]  fpsimd_thread_switch+0x2c/0xe8
> [  765.077305]  __switch_to+0x20/0x158
> [  765.078384]  __schedule+0x2cc/0xb38
> [  765.079464]  preempt_schedule_irq+0x44/0xa8
> [  765.080633]  el1_interrupt+0x4c/0x68
> [  765.081691]  el1h_64_irq_handler+0x18/0x28
> [  765.082829]  el1h_64_irq+0x64/0x68
> [  765.083874]  ftrace_return_to_handler+0x98/0x158
> [  765.085090]  return_to_handler+0x20/0x48
> [  765.086205]  do_sve_acc+0x64/0x128
> [  765.087272]  el0_sve_acc+0x3c/0xa0
> [  765.088356]  el0t_64_sync_handler+0x114/0x130
> [  765.089524]  el0t_64_sync+0x190/0x198
> [  765.090712] Code: d51b4408 d65f03c0 d503201f d503245f (e5bb5800)
> [  765.092024] ---[ end trace 0000000000000000 ]---
> [  765.904294] pstore: backend (efi_pstore) writing error (-5)
> [  765.905531] note: rmmod[808] exited with irqs disabled
> 
> Links:
> test log link:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.7-191-gbe4ec7370801/testrun/20672437/suite/log-parser-test/test/check-kernel-oops/log
> 
> Details of tests:
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WrHwIIFdZpJWV5smWZVr2yJxl1
> 
> Build link:
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WrHvExYOOOZVoxlISTdAD1gMzO/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

