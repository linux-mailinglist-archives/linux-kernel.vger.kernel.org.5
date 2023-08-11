Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644F77916C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHKOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93656EA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B00672D0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429C8C433C7;
        Fri, 11 Aug 2023 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762983;
        bh=P8F0Qr3MrxQHzChWyohIy2/GJBdBsxuPeUJjOjzXMYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4lHJsK/LhTrzN67VOkFMoAFT4yLJoVKvmrU9GTjt2SYeJNkwwcfgbIGSgnxrUq4c
         yI6M+QmGEh+U8jMRzdwKdyZheB9+P7e1kr0vHs24S9A2t761Vgm4PZfLj1+lUJC1oe
         7a5QL0e3zUsMkTX7UXxjLt5v/KUW2H9vN9hCWA/rcwOA6Gt427P26WBawhPdUzTuYl
         I+8/HTJ88xQzNdHTWTNg1/yeGaFjo2FST46B1Y9jP40kWrNErX/JVKadrTc026sLKR
         u8qciLF5wRvYOKmRzLJQUAOBUfh2Okadb9+BQrWLnPdW8fKj6BydIFd4nuPhbrEEpk
         b17aSytL33vOQ==
Date:   Fri, 11 Aug 2023 07:09:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230811140941.GB193223@dev-arch.thelio-3990X>
References: <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
 <20230810132706.GA3805855@dev-arch.thelio-3990X>
 <20230810133216.GKZNTm4KpohRR4gVsT@fat_crate.local>
 <20230810134056.GA130730@dev-arch.thelio-3990X>
 <20230810144344.GLZNT3oM6MLVdzGlyd@fat_crate.local>
 <20230810150706.GA42856@dev-arch.thelio-3990X>
 <20230810151410.GNZNT+wn/cLBWiU6dO@fat_crate.local>
 <20230810154831.GA38495@dev-arch.thelio-3990X>
 <20230810161414.GA4000@dev-arch.thelio-3990X>
 <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811101456.GDZNYKIHs1k7ri8hrI@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:14:56PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 09:14:14AM -0700, Nathan Chancellor wrote:
> > Not sure how helpful that will be...
> 
> Yeah, not really. More wild guesses: if you uncomment the UNTRAIN_RET in
> __svm_vcpu_run() on the host, does that have any effect? Diff below.

Unfortunately, that seems to make no difference...

I did have to switch to the Ryzen 3 box for testing, as I am not at home
for a couple of days and I did not want to lose access to my workstation
if I took a bad update since it has no remote management capabilities.
Something I noticed in doing so is that the VM boot on that machine
appears to get farther along than on my Threadripper 3990X, but I still
see a hang with a stack trace similar to the one that I reported in the
initial post with '-smp 2', so I think it is the same problem but
perhaps the more cores the VM has, the more likely it is to appear
totally hung? Might be a red herring but I figured I would mention it in
case it is relevant.

[    0.000000] Linux version 6.5.0-rc5 (nathan@distrobox-CUV1ywFutd.thelio-3990X) (ClangBuiltLinux clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6), GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Fri Aug 11 06:15:25 MST 2023
...
[    0.141781] smp: Bringing up secondary CPUs ...
[    0.142524] smpboot: x86: Booting SMP configuration:
[    0.143450] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[   21.145445] rcu: INFO: rcu_preempt self-detected stall on CPU
[   21.146443] rcu:     1-...!: (20554 ticks this GP) idle=04bc/0/0x1 softirq=1/1 fqs=0
[   21.146443] rcu:     (t=21007 jiffies g=-1187 q=1 ncpus=8)
[   21.146443] rcu: rcu_preempt kthread starved for 21009 jiffies! g-1187 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[   21.146443] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   21.146443] rcu: RCU grace-period kthread stack dump:
[   21.146443] task:rcu_preempt     state:R  running task     stack:15360 pid:14    ppid:2      flags:0x00004000
[   21.146443] Call Trace:
[   21.146443]  <TASK>
[   21.146443]  __schedule+0x618/0x8a0
[   21.146443]  schedule+0x51/0x90
[   21.146443]  schedule_timeout+0xb5/0x170
[   21.146443]  ? __pfx_process_timeout+0x10/0x10
[   21.146443]  rcu_gp_fqs_loop+0x1a7/0x6b0
[   21.146443]  ? __note_gp_changes+0x39/0x210
[   21.146443]  rcu_gp_kthread+0x1c/0x1e0
[   21.146443]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   21.146443]  kthread+0xe6/0x100
[   21.146443]  ? __pfx_kthread+0x10/0x10
[   21.146443]  ret_from_fork+0x35/0x40
[   21.146443]  ? __pfx_kthread+0x10/0x10
[   21.146443]  ret_from_fork_asm+0x1b/0x30
[   21.146443]  </TASK>
[   21.146443] rcu: Stack dump where RCU GP kthread last ran:
[   21.146443] Sending NMI from CPU 1 to CPUs 0:
[   21.196100] NMI backtrace for cpu 0
[   21.196103] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5 #1
[   21.196105] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[   21.196106] RIP: 0010:default_send_IPI_allbutself+0x23/0x50
[   21.196111] Code: 90 90 90 90 90 90 90 f3 0f 1e fa 83 ff 02 74 2f f7 04 25 00 c3 5f ff 00 10 00 00 74 0f f3 90 f7 04 25 00 c3 5f ff 00 10 00 00 <75> f1 81 cf 00 00 0c 00 89 3c 25 00 c3 5f ff 2e e9 68 5b ef 00 48
[   21.196112] RSP: 0018:ffffb268c0013cb0 EFLAGS: 00000282
[   21.196114] RAX: ffffffff9e993b50 RBX: ffffa2061f02bf90 RCX: 00000000000000ff
[   21.196115] RDX: 0000000000000000 RSI: ffffa2061f1efda0 RDI: 00000000000000fc
[   21.196116] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   21.196117] R10: 0000000000000000 R11: ffffffff9d2652a0 R12: 0000000000000000
[   21.196118] R13: ffffa2061f02bf80 R14: ffffa2061f1efda0 R15: 0000000000000007
[   21.196120] FS:  0000000000000000(0000) GS:ffffa2061f000000(0000) knlGS:0000000000000000
[   21.196121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.196122] CR2: ffffa20607a01000 CR3: 0000000006e2a000 CR4: 0000000000350ef0
[   21.196124] Call Trace:
[   21.196126]  <NMI>
[   21.196127]  ? nmi_cpu_backtrace+0x105/0x130
[   21.196130]  ? nmi_cpu_backtrace_handler+0xc/0x20
[   21.196132]  ? nmi_handle+0x66/0x150
[   21.196134]  ? default_send_IPI_allbutself+0x23/0x50
[   21.196135]  ? default_do_nmi+0x41/0x100
[   21.196137]  ? exc_nmi+0xbb/0x130
[   21.196138]  ? end_repeat_nmi+0x16/0x67
[   21.196140]  ? __pfx_default_send_IPI_allbutself+0x10/0x10
[   21.196141]  ? default_send_IPI_allbutself+0x23/0x50
[   21.196143]  ? default_send_IPI_allbutself+0x23/0x50
[   21.196144]  ? default_send_IPI_allbutself+0x23/0x50
[   21.196145]  </NMI>
[   21.196145]  <TASK>
[   21.196146]  kvm_smp_send_call_func_ipi+0x10/0x60
[   21.196148]  smp_call_function_many_cond+0x2be/0x520
[   21.196151]  ? __pfx_do_sync_core+0x10/0x10
[   21.196153]  on_each_cpu_cond_mask+0x1c/0x40
[   21.196155]  text_poke_bp_batch+0xb3/0x2a0
[   21.196156]  text_poke_finish+0x1a/0x30
[   21.196157]  arch_jump_label_transform_apply+0x15/0x30
[   21.196159]  static_key_enable_cpuslocked+0x48/0x80
[   21.196161]  static_key_enable+0x15/0x20
[   21.196163]  _cpu_up+0x1f7/0x280
[   21.196165]  cpu_up+0x60/0xa0
[   21.196166]  cpuhp_bringup_mask+0x49/0xc0
[   21.196169]  cpuhp_bringup_cpus_parallel+0xba/0xd0
[   21.196171]  bringup_nonboot_cpus+0xc/0x30
[   21.196172]  smp_init+0x25/0x80
[   21.196174]  kernel_init_freeable+0xd3/0x150
[   21.196177]  ? __pfx_kernel_init+0x10/0x10
[   21.196179]  kernel_init+0x15/0x190
[   21.196180]  ret_from_fork+0x35/0x40
[   21.196182]  ? __pfx_kernel_init+0x10/0x10
[   21.196183]  ret_from_fork_asm+0x1b/0x30
[   21.196186]  </TASK>
[   84.297444] rcu: INFO: rcu_preempt self-detected stall on CPU
[   84.298443] rcu:     2-....: (82371 ticks this GP) idle=1c5c/0/0x1 softirq=1/1 fqs=0
[   84.298443] rcu:     (t=84155 jiffies g=-1187 q=1 ncpus=8)
[   84.298443] rcu: rcu_preempt kthread starved for 84156 jiffies! g-1187 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[   84.298443] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   84.298443] rcu: RCU grace-period kthread stack dump:
[   84.298443] task:rcu_preempt     state:R  running task     stack:15360 pid:14    ppid:2      flags:0x00004000
[   84.298443] Call Trace:
[   84.298443]  <TASK>
[   84.298443]  __schedule+0x618/0x8a0
[   84.298443]  schedule+0x51/0x90
[   84.298443]  schedule_timeout+0xb5/0x170
[   84.298443]  ? __pfx_process_timeout+0x10/0x10
[   84.298443]  rcu_gp_fqs_loop+0x1a7/0x6b0
[   84.298443]  ? __note_gp_changes+0x39/0x210
[   84.298443]  rcu_gp_kthread+0x1c/0x1e0
[   84.298443]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   84.298443]  kthread+0xe6/0x100
[   84.298443]  ? __pfx_kthread+0x10/0x10
[   84.298443]  ret_from_fork+0x35/0x40
[   84.298443]  ? __pfx_kthread+0x10/0x10
[   84.298443]  ret_from_fork_asm+0x1b/0x30
[   84.298443]  </TASK>
[   84.298443] rcu: Stack dump where RCU GP kthread last ran:
[   84.298443] Sending NMI from CPU 2 to CPUs 0:
[   84.321804] NMI backtrace for cpu 0
[   84.321804] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5 #1
[   84.321804] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[   84.321804] RIP: 0010:default_send_IPI_allbutself+0x23/0x50
[   84.321804] Code: 90 90 90 90 90 90 90 f3 0f 1e fa 83 ff 02 74 2f f7 04 25 00 c3 5f ff 00 10 00 00 74 0f f3 90 f7 04 25 00 c3 5f ff 00 10 00 00 <75> f1 81 cf 00 00 0c 00 89 3c 25 00 c3 5f ff 2e e9 68 5b ef 00 48
[   84.321804] RSP: 0018:ffffb268c0013cb0 EFLAGS: 00000286
[   84.321804] RAX: ffffffff9e993b50 RBX: ffffa2061f02bf90 RCX: 00000000000000ff
[   84.321804] RDX: 0000000000000000 RSI: ffffa2061f1efda0 RDI: 00000000000000fc
[   84.321804] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   84.321804] R10: 0000000000000000 R11: ffffffff9d2652a0 R12: 0000000000000000
[   84.321804] R13: ffffa2061f02bf80 R14: ffffa2061f1efda0 R15: 0000000000000007
[   84.321804] FS:  0000000000000000(0000) GS:ffffa2061f000000(0000) knlGS:0000000000000000
[   84.321804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.321804] CR2: ffffa20607a01000 CR3: 0000000006e2a000 CR4: 0000000000350ef0
[   84.321804] Call Trace:
[   84.321804]  <NMI>
[   84.321804]  ? nmi_cpu_backtrace+0x105/0x130
[   84.321804]  ? nmi_cpu_backtrace_handler+0xc/0x20
[   84.321804]  ? nmi_handle+0x66/0x150
[   84.321804]  ? default_send_IPI_allbutself+0x23/0x50
[   84.321804]  ? default_send_IPI_allbutself+0x23/0x50
[   84.321804]  ? default_do_nmi+0x41/0x100
[   84.321804]  ? exc_nmi+0xbb/0x130
[   84.321804]  ? end_repeat_nmi+0x16/0x67
[   84.321804]  ? __pfx_default_send_IPI_allbutself+0x10/0x10
[   84.321804]  ? default_send_IPI_allbutself+0x23/0x50
[   84.321804]  ? default_send_IPI_allbutself+0x23/0x50
[   84.321804]  ? default_send_IPI_allbutself+0x23/0x50
[   84.321804]  </NMI>
[   84.321804]  <TASK>
[   84.321804]  kvm_smp_send_call_func_ipi+0x10/0x60
[   84.321804]  smp_call_function_many_cond+0x2be/0x520
[   84.321859]  ? __pfx_do_sync_core+0x10/0x10
[   84.321859]  on_each_cpu_cond_mask+0x1c/0x40
[   84.321859]  text_poke_bp_batch+0xb3/0x2a0
[   84.321863]  text_poke_finish+0x1a/0x30
[   84.321863]  arch_jump_label_transform_apply+0x15/0x30
[   84.321863]  static_key_enable_cpuslocked+0x48/0x80
[   84.321863]  static_key_enable+0x15/0x20
[   84.321863]  _cpu_up+0x1f7/0x280
[   84.321863]  cpu_up+0x60/0xa0
[   84.321863]  cpuhp_bringup_mask+0x49/0xc0
[   84.321863]  cpuhp_bringup_cpus_parallel+0xba/0xd0
[   84.321863]  bringup_nonboot_cpus+0xc/0x30
[   84.321863]  smp_init+0x25/0x80
[   84.321863]  kernel_init_freeable+0xd3/0x150
[   84.321863]  ? __pfx_kernel_init+0x10/0x10
[   84.321863]  kernel_init+0x15/0x190
[   84.321863]  ret_from_fork+0x35/0x40
[   84.321863]  ? __pfx_kernel_init+0x10/0x10
[   84.321863]  ret_from_fork_asm+0x1b/0x30
[   84.321863]  </TASK>
[   84.298443] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.5.0-rc5 #1
[   84.298443] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[   84.298443] RIP: 0010:default_idle+0x13/0x20
[   84.298443] Code: 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d f9 81 2b 00 f3 0f 1e fa fb f4 <fa> 2e e9 c6 b5 00 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
[   84.298443] RSP: 0018:ffffb268c0093ee8 EFLAGS: 00000206
[   84.298443] RAX: ffffa2061f0a7e28 RBX: 0000000000000002 RCX: 0000000000141c54
[   84.298443] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000141c54
[   84.298443] RBP: ffffb268c0093ef8 R08: ffffffffffff98d0 R09: 000000000000db9d
[   84.298443] R10: 000000000002271c R11: ffffffff9d34d300 R12: 0000000000000000
[   84.298443] R13: ffffa206011f8000 R14: 0000000000000000 R15: 0000000000000000
[   84.298443] FS:  0000000000000000(0000) GS:ffffa2061f080000(0000) knlGS:0000000000000000
[   84.298443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.298443] CR2: 0000000000000000 CR3: 0000000006e2a000 CR4: 0000000000350ee0
[   84.298443] Call Trace:
[   84.298443]  <IRQ>
[   84.298443]  ? rcu_dump_cpu_stacks+0xd9/0x130
[   84.298443]  ? rcu_sched_clock_irq+0x52e/0xf40
[   84.298443]  ? __pfx_jiffies_read+0x10/0x10
[   84.298443]  ? update_process_times+0x5a/0x80
[   84.298443]  ? tick_periodic+0x60/0x70
[   84.298443]  ? tick_handle_periodic+0x1d/0x90
[   84.298443]  ? __sysvec_apic_timer_interrupt+0x5b/0x190
[   84.298443]  ? sysvec_apic_timer_interrupt+0x67/0x80
[   84.298443]  </IRQ>
[   84.298443]  <TASK>
[   84.298443]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   84.298443]  ? __pfx_jiffies_read+0x10/0x10
[   84.298443]  ? default_idle+0x13/0x20
[   84.298443]  default_idle_call+0x35/0x60
[   84.298443]  do_idle+0xce/0x240
[   84.298443]  cpu_startup_entry+0x18/0x20
[   84.298443]  start_secondary+0x97/0xa0
[   84.298443]  secondary_startup_64_no_verify+0x179/0x17b
[   84.298443]  </TASK>
[   84.298443] Sending NMI from CPU 2 to CPUs 3:
[   84.407546] NMI backtrace for cpu 3 skipped: idling at default_idle+0x13/0x20
...

> Also, can you send me the host and guest .configs and the compilers
> you've used so that I can try to reproduce here exactly what you have?

Sure thing!

Host compiler: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-x86_64-linux.tar.xz
Host config: https://gist.github.com/nathanchance/e3b03f955e718fd802229ef04f3a87da/raw/46d1ec9f37506f87f40dc32729019d841ec921c0/srso-host.config

Guest compiler: https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-16.0.6-x86_64.tar.xz
Guest config: https://gist.github.com/nathanchance/e3b03f955e718fd802229ef04f3a87da/raw/46d1ec9f37506f87f40dc32729019d841ec921c0/srso-guest.config

Cheers,
Nathan
