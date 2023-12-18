Return-Path: <linux-kernel+bounces-3429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4E816C24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8049B1F236EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B1199C7;
	Mon, 18 Dec 2023 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0IpaUto"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8F1B26E;
	Mon, 18 Dec 2023 11:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61453C433C9;
	Mon, 18 Dec 2023 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702898709;
	bh=oOWqt4mzn7lpvdcD4G7rn9WQ45Li9D1HAbQ2G4vdYaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W0IpaUtotPuuLTTquw8XLDpxeOxMg5uKkf+Nox6BLbsHeqaqbKASQGJgZUx2+mvDn
	 4YE0nJ0RLxIubm43H9YgCEyq6ywveExRAfkxFYoRjYODPJArv7H6kop8E+leI1YMr6
	 ETIp1tM51CBVmn6StNSaTtlBTvB3OXZf17bodukLaTTInMN24LzCff2TJRHYx6ggIn
	 83VuvNLh8sH8T3gmmkPiborVgqPEYTE2jgbWfk9oTcn8guC2MVC/VeNo/hRFP7bbcm
	 odsJBtFjAeaEz0d4PjUckzySLGGsxmsn7/YM76uNQUqnx1KQPs0TX/gB7IxhRN0b1P
	 y62S9/YBhPKiA==
Date: Mon, 18 Dec 2023 20:25:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [mhiramat:topic/fprobe-on-fgraph] [function_graph] b92a5e78c3:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-Id: <20231218202505.be19ab6c5fd58cdba15c56c6@kernel.org>
In-Reply-To: <202312181100.508f8f48-oliver.sang@intel.com>
References: <202312181100.508f8f48-oliver.sang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 15:04:46 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:
> 
> commit: b92a5e78c35fde3c1be7263b39724388482a4bd9 ("function_graph: Add a new entry handler with parent_ip and ftrace_regs")
> https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 600s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/

Thanks for reporting, I confirmed my (preparing) v5 fixed this issue.

[   20.788448][    T1] Testing tracer nop: PASSED
[   20.792288][    T1] Testing tracer function_graph: PASSED
[   37.458753][    T1] Testing fgraph storage of 1 byte: PASSED
[   37.556119][    T1] Testing fgraph storage of 2 bytes: PASSED
[   37.660124][    T1] Testing fgraph storage of 4 bytes: PASSED
[   37.768140][    T1] Testing fgraph storage of 8 bytes: PASSED
[   37.877687][    T1] prandom: seed boundary self test passed

Thank you,


> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +----------------------------------------------------------------------------------+------------+------------+
> |                                                                                  | 26fcffc6d7 | b92a5e78c3 |
> +----------------------------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/trace/trace.c:#run_tracer_selftest                             | 0          | 8          |
> | EIP:run_tracer_selftest                                                          | 0          | 8          |
> +----------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312181100.508f8f48-oliver.sang@intel.com
> 
> 
> [    5.502226][    T1] ------------[ cut here ]------------
> [ 5.502226][ T1] WARNING: CPU: 1 PID: 1 at kernel/trace/trace.c:2031 run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [    5.502899][    T1] Modules linked in:
> [    5.503348][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc2-00034-gb92a5e78c35f #1
> [    5.504358][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 5.505125][ T1] EIP: run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [ 5.505764][ T1] Code: ff ff a3 18 30 4b c2 89 f8 89 15 1c 30 4b c2 e8 cb b1 ff ff 89 f8 e8 58 52 ff ff e9 c1 fe ff ff 68 50 d6 f9 c1 e8 2d 61 f7 ff <0f> 0b b8 ff ff ff ff 5a e9 22 ff ff ff b8 f4 ff ff ff e9 18 ff ff
> All code
> ========
>    0:	ff                   	(bad)
>    1:	ff a3 18 30 4b c2    	jmp    *-0x3db4cfe8(%rbx)
>    7:	89 f8                	mov    %edi,%eax
>    9:	89 15 1c 30 4b c2    	mov    %edx,-0x3db4cfe4(%rip)        # 0xffffffffc24b302b
>    f:	e8 cb b1 ff ff       	call   0xffffffffffffb1df
>   14:	89 f8                	mov    %edi,%eax
>   16:	e8 58 52 ff ff       	call   0xffffffffffff5273
>   1b:	e9 c1 fe ff ff       	jmp    0xfffffffffffffee1
>   20:	68 50 d6 f9 c1       	push   $0xffffffffc1f9d650
>   25:	e8 2d 61 f7 ff       	call   0xfffffffffff76157
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>   31:	5a                   	pop    %rdx
>   32:	e9 22 ff ff ff       	jmp    0xffffffffffffff59
>   37:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
>   3c:	e9                   	.byte 0xe9
>   3d:	18 ff                	sbb    %bh,%bh
>   3f:	ff                   	.byte 0xff
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>    7:	5a                   	pop    %rdx
>    8:	e9 22 ff ff ff       	jmp    0xffffffffffffff2f
>    d:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
>   12:	e9                   	.byte 0xe9
>   13:	18 ff                	sbb    %bh,%bh
>   15:	ff                   	.byte 0xff
> [    5.508031][    T1] EAX: 00000007 EBX: c1f9fa5b ECX: 00000000 EDX: 00000000
> [    5.508856][    T1] ESI: c25e18e0 EDI: c0109500 EBP: c031bed4 ESP: c031bec4
> [    5.513135][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> [    5.514023][    T1] CR0: 80050033 CR2: 00000000 CR3: 02763000 CR4: 000406d0
> [    5.514855][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    5.515688][    T1] DR6: fffe0ff0 DR7: 00000400
> [    5.516235][    T1] Call Trace:
> [ 5.516632][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> [ 5.517125][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [ 5.517722][ T1] ? __warn (kernel/panic.c:677) 
> [ 5.518185][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [ 5.518797][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> [ 5.519323][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 5.519844][ T1] ? handle_bug (arch/x86/kernel/traps.c:216) 
> [ 5.520351][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
> [ 5.521153][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
> [ 5.521153][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 5.521642][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [ 5.522253][ T1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
> [ 5.522776][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2031 (discriminator 1)) 
> [ 5.523386][ T1] register_tracer (kernel/trace/trace.c:2065 kernel/trace/trace.c:2188) 
> [ 5.523932][ T1] ? init_graph_tracefs (kernel/trace/trace_functions_graph.c:1448) 
> [ 5.525126][ T1] init_graph_trace (kernel/trace/trace_functions_graph.c:1462) 
> [ 5.525126][ T1] do_one_initcall (init/main.c:1236) 
> [ 5.525132][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
> [ 5.525660][ T1] kernel_init_freeable (init/main.c:1553) 
> [ 5.526271][ T1] ? rest_init (init/main.c:1433) 
> [ 5.526789][ T1] kernel_init (init/main.c:1443) 
> [ 5.527291][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 5.527828][ T1] ? rest_init (init/main.c:1433) 
> [ 5.529154][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
> [ 5.529154][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
> [    5.529154][    T1] irq event stamp: 2126727
> [ 5.529642][ T1] hardirqs last enabled at (2126735): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
> [ 5.530695][ T1] hardirqs last disabled at (2126742): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
> [ 5.533126][ T1] softirqs last enabled at (2126476): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
> [ 5.533126][ T1] softirqs last disabled at (2126471): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
> [    5.533126][    T1] ---[ end trace 0000000000000000 ]---
> [    5.534553][    T1] prandom: seed boundary self test passed
> [    5.537152][    T1] prandom: 100 self tests passed
> [    5.537152][    T1] pinctrl core: initialized pinctrl subsystem
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231218/202312181100.508f8f48-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

