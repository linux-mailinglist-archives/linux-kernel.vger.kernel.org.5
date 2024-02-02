Return-Path: <linux-kernel+bounces-49876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868518470CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381971F23BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65F4684;
	Fri,  2 Feb 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKse/JN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA314C6A;
	Fri,  2 Feb 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879086; cv=none; b=TmBUmFJrumX42Gc5h0HEXtp3IgRiq329frOqxPuQfeyVJKsA512mitQmy1wbugbjKz8uZkRxGhXPrDt9mIomcZkgB/eQhlSy2ZfFlmv/MBeDWsEUBPTurVZ6hqvqSZ6GlWQXpFW8QDZ57xwcyVzv+IL/o66r9o5jBFgcBKA2WfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879086; c=relaxed/simple;
	bh=VHNzo62n2veQT6kzrf61FzcveAg/Vc9QAoX36epjdhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pNpZsqbD44mE2y8MfikfjkEOiZ41Qla0fRLi0/RnCLLIWWeO/j76mIM2ojFEgPW9uy8nkfAnVfDsZpgQEJ3hEkhqciXIta3257Rz+r6S4yFFm3XC3hUF2ojrQ8w/T6UATns3ITmqOv/ek9KljsCjca8bKw45hIvmneJbv+no+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKse/JN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228E8C43390;
	Fri,  2 Feb 2024 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706879086;
	bh=VHNzo62n2veQT6kzrf61FzcveAg/Vc9QAoX36epjdhA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=sKse/JN676bA5NZide99+MztzoAngiNHaHBrJtFzRH62D1u5E6R+3FQklBkF++I5N
	 PcOVGesJho5Ib34+3T8GBWTTBBfiklACb4v9B7L+N9g6yCkIlqVOl4i0oCiRGvavMs
	 uQQ6a64uLWESdPN6R4VyWAFV1KR0eb4wrLWEZpGdtnZXtU4awDjuxnIrk6gjOiLUUV
	 UZtvn/gLYaKxe9z8ta+dNODgkusDTGiAe+6EAyvirnEsF7NrPBwhkNWdsh/7lR/wuy
	 Zx5h7wAmjcXz+yXW7Xcb5I+b/VmW6TFU3lIxbSiEhJVHDsIALhhG1OEdfatM0BiDk3
	 77EQWuVd01vqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3478CE1ECC; Fri,  2 Feb 2024 05:04:45 -0800 (PST)
Date: Fri, 2 Feb 2024 05:04:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Starting with next-20240130 (and perhaps a bit earlier), rcutorture gets
what initially looked like early-boot hangs, but only when running on
dual-socket x86 systems [1], as it it works just fine on my x86 laptop [2].
But when running on dual-socket systems, this happens all the time,
perhaps because rcutorture works hard to split each guest OS across a
socket boundary.

This is the reproducer:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "10*TREE01" --trust-make

By "looked like early-boot hangs" I mean that qemu was quite happy,
but there was absolutely no console output.

Bisection identified this commit:

5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")

Reverting this commit made the problem go away.  Except that it is really
hard to imagine this commit having any effect whatsoever on early boot
execution.  Of course, this might be a failure of imagination on my part,
so I enlisted the aid of gdb:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "TREE01" --trust-make --gdb

After following the resulting gdb startup instructions and waiting for
about ten seconds, I hit control-C on the gdb window and then:

	(gdb) bt
	#0  default_idle () at arch/x86/kernel/process.c:743
	#1  0xffffffff81e94d34 in default_idle_call () at kernel/sched/idle.c:97
	#2  0xffffffff810d746d in cpuidle_idle_call () at kernel/sched/idle.c:170
	#3  do_idle () at kernel/sched/idle.c:312
	#4  0xffffffff810d76a4 in cpu_startup_entry (state=state@entry=CPUHP_ONLINE)
	    at kernel/sched/idle.c:410
	#5  0xffffffff81e95417 in rest_init () at init/main.c:730
	#6  0xffffffff8329adf2 in start_kernel () at init/main.c:1067
	#7  0xffffffff832a5038 in x86_64_start_reservations (
	    real_mode_data=real_mode_data@entry=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:555
	#8  0xffffffff832a513c in x86_64_start_kernel (
	    real_mode_data=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:536
	#9  0xffffffff810001d2 in secondary_startup_64 ()
	    at arch/x86/kernel/head_64.S:461
	#10 0x0000000000000000 in ?? ()
	(gdb) print jiffies
	$1 = 4294676330
	(gdb) print system_state
	$2 = SYSTEM_RUNNING

In other words, the system really has booted, and at least one CPU is
happily idling in the idle loop.  And another CPU is (maybe not quite
so happily) running rcutorture:

	(gdb) thread 6
	[Switching to thread 6 (Thread 1.6)]
	#0  0xffffffff8111160b in rcu_torture_one_read (
	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
	    at kernel/rcu/rcutorture.c:2003
	2003            completed = cur_ops->get_gp_seq();
	(gdb) bt
	#0  0xffffffff8111160b in rcu_torture_one_read (
	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
	    at kernel/rcu/rcutorture.c:2003
	#1  0xffffffff81111bef in rcu_torture_reader (arg=0x4 <fixed_percpu_data+4>)
	    at kernel/rcu/rcutorture.c:2097
	#2  0xffffffff810af3e0 in kthread (_create=0xffff8880047aa480)
	    at kernel/kthread.c:388
	#3  0xffffffff8103af1f in ret_from_fork (prev=<optimized out>,
	    regs=0xffffc900004abf58, fn=0xffffffff810af300 <kthread>,
	    fn_arg=0xffff8880047aa480) at arch/x86/kernel/process.c:147
	#4  0xffffffff8100247a in ret_from_fork_asm () at arch/x86/entry/entry_64.S:242
	#5  0x0000000000000000 in ?? ()

So the system really did boot and is running just fine.  It is just that
there is no console output.  Details, details!

Is there anything I can do to some combination of workqueues and printk
to help debug this?  Or that I can do to anything else, as I am not
feeling all that picky.  ;-)

							Thanx, Paul

[1] The dual-socket system is an 80-hardware-thread (20 cores per socket)
    system with model name Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz.
    I get the same results when using either of these compilers:
    gcc version 8.5.0 20210514 (Red Hat 8.5.0-21) (GCC)
    gcc version 11.4.1 20230605 (Red Hat 11.4.1-2) (GCC)

[2] My laptop is a 16-hardware-thread (8 cores) single-socket system with
    model name "Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz" and
    gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04).

