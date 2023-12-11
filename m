Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A280D311
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbjLKQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjLKQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:59:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9279E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:59:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7950FC433C7;
        Mon, 11 Dec 2023 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702313957;
        bh=yQInOwpTFWkRgs3AdNB6UC+94MBRoM50pp/M0nBk3wA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GjHeLnwpZAhJekd8UlqUTk4HgFvBsBj4+ukl3uM5JLOEwg4O0gh6U3bm3XTgoFeUY
         DkJDFZPnEC0kJZYxyqzAt+c0qRCS53qT6eNBBYYwYoi7Xap86QDZytit6sWwFKpbif
         MrH7OjI/HsHN93+mOr7oSBvutrRnQkj+O+aKiSwNeM2RTf7LlCXNmlnHUhOu6S9EDT
         RD6R26QDB122XfxTi5eDsCWtSA7H7GMUKkkm5/XLerGt23EgCH+1Cw6gPFTzBVBMtK
         xTgQQdCC2amUK8U1MlUScpmjTojBXo31OY7ZlAIqL1Pb06RBfGPCOANaITacc3zGfT
         OpyKJLNRil6qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E72C2CE0569; Mon, 11 Dec 2023 08:59:16 -0800 (PST)
Date:   Mon, 11 Dec 2023 08:59:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.11.08a] [EXP locktorture] 1254a620b4:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register
Message-ID: <2ad1abcc-d82b-406f-a7b7-606224a24813@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312071506.6eac1bac-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312071506.6eac1bac-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:19:56PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register" on:
> 
> commit: 1254a620b4a3832e65ac01bcef769b99e34515b2 ("EXP locktorture: Add RCU CPU stall-warning notifier stub")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.08a

Thank you for your testing efforts!

This one is expected behavior by explicit request from Linus Torvalds.
The concern is that people might use this hook without understanding
the risks of losing RCU CPU stall warnings.

One fix would be to never specify the rcupdate.rcu_cpu_stall_notifiers
kernel boot parameter.  Another would be to forgive this warning when
that boot parameter was specified.  Your choice!  ;-)

							Thanx, Paul

> in testcase: locktorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 
> 
> 
> compiler: clang-16
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------------------------+------------+------------+
> |                                                                       | 11b2bc2909 | 1254a620b4 |
> +-----------------------------------------------------------------------+------------+------------+
> | WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register | 0          | 12         |
> | RIP:rcu_stall_chain_notifier_register                                 | 0          | 12         |
> +-----------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312071506.6eac1bac-oliver.sang@intel.com
> 
> 
> [  200.668175][  T876] ------------[ cut here ]------------
> [ 200.669199][ T876] Adding torture_spin_lock_dump+0x0/0x20 [locktorture]() to RCU stall notifier list (failed, so all is well). 
> [ 200.671183][ T876] WARNING: CPU: 1 PID: 876 at kernel/rcu/tree_stall.h:1088 rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [  200.673094][  T876] Modules linked in: locktorture(+) torture
> [  200.674129][  T876] CPU: 1 PID: 876 Comm: modprobe Tainted: G        W        N 6.6.0-03747-g1254a620b4a3 #1 44194d056aabc0fb2e11ad706d62f862fdc5dd23
> [  200.676413][  T876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 200.678192][ T876] RIP: 0010:rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [ 200.679403][ T876] Code: 89 df e8 2f 0c 35 00 48 8b 33 85 ed 48 c7 c0 00 cb 49 97 48 c7 c2 a0 ca 49 97 48 0f 44 d0 48 c7 c7 40 ca 49 97 e8 fc 69 e4 ff <0f> 0b 85 ed 74 13 48 c7 c7 20 c7 1d 99 48 89 de 5b 41 5e 5d e9 83
> All code
> ========
>    0:	89 df                	mov    %ebx,%edi
>    2:	e8 2f 0c 35 00       	call   0x350c36
>    7:	48 8b 33             	mov    (%rbx),%rsi
>    a:	85 ed                	test   %ebp,%ebp
>    c:	48 c7 c0 00 cb 49 97 	mov    $0xffffffff9749cb00,%rax
>   13:	48 c7 c2 a0 ca 49 97 	mov    $0xffffffff9749caa0,%rdx
>   1a:	48 0f 44 d0          	cmove  %rax,%rdx
>   1e:	48 c7 c7 40 ca 49 97 	mov    $0xffffffff9749ca40,%rdi
>   25:	e8 fc 69 e4 ff       	call   0xffffffffffe46a26
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	85 ed                	test   %ebp,%ebp
>   2e:	74 13                	je     0x43
>   30:	48 c7 c7 20 c7 1d 99 	mov    $0xffffffff991dc720,%rdi
>   37:	48 89 de             	mov    %rbx,%rsi
>   3a:	5b                   	pop    %rbx
>   3b:	41 5e                	pop    %r14
>   3d:	5d                   	pop    %rbp
>   3e:	e9                   	.byte 0xe9
>   3f:	83                   	.byte 0x83
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	85 ed                	test   %ebp,%ebp
>    4:	74 13                	je     0x19
>    6:	48 c7 c7 20 c7 1d 99 	mov    $0xffffffff991dc720,%rdi
>    d:	48 89 de             	mov    %rbx,%rsi
>   10:	5b                   	pop    %rbx
>   11:	41 5e                	pop    %r14
>   13:	5d                   	pop    %rbp
>   14:	e9                   	.byte 0xe9
>   15:	83                   	.byte 0x83
> [  200.682780][  T876] RSP: 0018:ffffc90002b67978 EFLAGS: 00010246
> [  200.683857][  T876] RAX: 000000000000006b RBX: ffffffffc040a220 RCX: 0000000000000027
> [  200.685304][  T876] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff8883aeb27a10
> [  200.686724][  T876] RBP: 0000000000000000 R08: ffff8883aeb27a13 R09: 1ffff11075d64f42
> [  200.688142][  T876] R10: dffffc0000000000 R11: ffffed1075d64f43 R12: ffff88814879e080
> [  200.689573][  T876] R13: ffffc90002b679e0 R14: dffffc0000000000 R15: dffffc0000000000
> [  200.690976][  T876] FS:  0000000000000000(0000) GS:ffff8883aeb00000(0063) knlGS:00000000f7aa9700
> [  200.692536][  T876] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [  200.693695][  T876] CR2: 000000005664b010 CR3: 0000000141a71000 CR4: 00000000000406f0
> [  200.695095][  T876] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  200.696540][  T876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  200.698173][  T876] Call Trace:
> [  200.698865][  T876]  <TASK>
> [ 200.699476][ T876] ? __warn (kernel/panic.c:235 kernel/panic.c:673) 
> [ 200.700283][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [ 200.701381][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [ 200.702461][ T876] ? report_bug (lib/bug.c:?) 
> [ 200.703294][ T876] ? handle_bug (arch/x86/kernel/traps.c:237) 
> [ 200.704128][ T876] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
> [ 200.704995][ T876] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
> [ 200.705913][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [ 200.707177][ T876] ? rcu_stall_chain_notifier_register (kernel/rcu/tree_stall.h:1087) 
> [ 200.708908][ T876] init_module (include/linux/cpumask.h:909 kernel/locking/locktorture.c:98 kernel/locking/locktorture.c:1051) locktorture
> [ 200.710509][ T876] do_one_initcall (init/main.c:1232) 
> [  200.711382][  T876]  ? 0xffffffffc0418000
> [ 200.712246][ T876] ? __asan_register_globals (mm/kasan/generic.c:229) 
> [ 200.713299][ T876] do_init_module (kernel/module/main.c:2530) 
> [ 200.714163][ T876] __se_sys_finit_module (kernel/module/main.c:3148 kernel/module/main.c:3166 kernel/module/main.c:3186 kernel/module/main.c:3169) 
> [ 200.715119][ T876] __do_fast_syscall_32 (arch/x86/entry/common.c:164) 
> [ 200.716056][ T876] do_fast_syscall_32 (arch/x86/entry/common.c:255) 
> [ 200.716965][ T876] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:121) 
> [  200.718040][  T876] RIP: 0023:0xf7fbb539
> [ 200.718801][ T876] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> All code
> ========
>    0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    4:	10 07                	adc    %al,(%rdi)
>    6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    a:	10 08                	adc    %cl,(%rax)
>    c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:	55                   	push   %rbp
>   24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
>   2a:	5d                   	pop    %rbp
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	cc                   	int3
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>   39:	00 00 00 
>   3c:	0f                   	.byte 0xf
>   3d:	1f                   	(bad)
>   3e:	44                   	rex.R
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	ret
>    4:	cc                   	int3
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    f:	00 00 00 
>   12:	0f                   	.byte 0xf
>   13:	1f                   	(bad)
>   14:	44                   	rex.R
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231207/202312071506.6eac1bac-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
