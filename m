Return-Path: <linux-kernel+bounces-50152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233B8474F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B18A1C26957
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972414A083;
	Fri,  2 Feb 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PohF5F1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359D149018;
	Fri,  2 Feb 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891752; cv=none; b=ZNPjxcikeSvwtPT2phkw/cHIdueHnZyHS/PGLkBt7Rrev/aYlQYK9TIC3CJiGZVVZPlMxh46srNc7N2JXAdOjDSz6vhExB00v5R7gr4xXMgPGsW3WkW5kk/wUwBSi9q2SjHArZYBe+z8Nja8U5qltOMJakpEgMG+sHlvPu4jEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891752; c=relaxed/simple;
	bh=7KArxsc9KpfiNC0LkBPfiAPPOAllhFZSPijNu//MD1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGRizfq2dZJvYUUlqsI4wZFNz8hxJmrK5SVecGo2xvXPv/uUZ9KIjuasmvtiultwLa9JaWIXc6xl07K55Z6puBoRNttTp+xcakLO16q5DnomXrpDmAqyVxLcnCUcn9EuXDQaaySnmIhhcExzIjAQIg28cDqcmdcAWSMukKCMUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PohF5F1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5BC433C7;
	Fri,  2 Feb 2024 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891752;
	bh=7KArxsc9KpfiNC0LkBPfiAPPOAllhFZSPijNu//MD1k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PohF5F1yUnx5iSP6WVf7/rbTb5HasfOyFrkznLJdJgo3LjarMmgyqQwq6qhIZKAa+
	 W7mzQigO5Ly1glSlJAAuRORIikVK8VCKfrlz4XYd28tFs3lBRoQxepd+PRepZju4D0
	 i9o9LAAisPZ0YvmuP2kcpbuPx22P4cV3e8F4ukAv+kqPH72Z3wUU/a+ZGibyRGJK7X
	 2Vz+/LAseoaRFwc7ZCbkemKMCKxtpIZFHYF+SOxo7rbcrUU39EqCIj2gcxFiM54573
	 FLpXKk3ZX3rZ8YgcYxFNFq1kwDuWomWFsamwrTUbsqL9PMaIiyc0AjzLn97XJAv/XY
	 kgd0drF6JcIMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B1473CE2250; Fri,  2 Feb 2024 08:35:51 -0800 (PST)
Date: Fri, 2 Feb 2024 08:35:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>

On Fri, Feb 02, 2024 at 03:26:14PM +0100, Jonas Oberhauser wrote:
> 
> Am 2/2/2024 um 2:04 PM schrieb Paul E. McKenney:
> > Hello!
> > 
> > Starting with next-20240130 (and perhaps a bit earlier), rcutorture gets
> > what initially looked like early-boot hangs, but only when running on
> > dual-socket x86 systems [1], as it it works just fine on my x86 laptop [2].
> > But when running on dual-socket systems, this happens all the time,
> > perhaps because rcutorture works hard to split each guest OS across a
> > socket boundary.
> > 
> > This is the reproducer:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "10*TREE01" --trust-make
> > 
> > By "looked like early-boot hangs" I mean that qemu was quite happy,
> > but there was absolutely no console output.
> > 
> > Bisection identified this commit:
> > 
> > 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> > 
> > Reverting this commit made the problem go away.  Except that it is really
> > hard to imagine this commit having any effect whatsoever on early boot
> > execution.  Of course, this might be a failure of imagination on my part,
> > so I enlisted the aid of gdb:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "TREE01" --trust-make --gdb
> > 
> > After following the resulting gdb startup instructions and waiting for
> > about ten seconds, I hit control-C on the gdb window and then:
> > 
> > 	(gdb) bt
> > 	#0  default_idle () at arch/x86/kernel/process.c:743
> > 	#1  0xffffffff81e94d34 in default_idle_call () at kernel/sched/idle.c:97
> > 	#2  0xffffffff810d746d in cpuidle_idle_call () at kernel/sched/idle.c:170
> > 	#3  do_idle () at kernel/sched/idle.c:312
> > 	#4  0xffffffff810d76a4 in cpu_startup_entry (state=state@entry=CPUHP_ONLINE)
> > 	    at kernel/sched/idle.c:410
> > 	#5  0xffffffff81e95417 in rest_init () at init/main.c:730
> > 	#6  0xffffffff8329adf2 in start_kernel () at init/main.c:1067
> > 	#7  0xffffffff832a5038 in x86_64_start_reservations (
> > 	    real_mode_data=real_mode_data@entry=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:555
> > 	#8  0xffffffff832a513c in x86_64_start_kernel (
> > 	    real_mode_data=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:536
> > 	#9  0xffffffff810001d2 in secondary_startup_64 ()
> > 	    at arch/x86/kernel/head_64.S:461
> > 	#10 0x0000000000000000 in ?? ()
> > 	(gdb) print jiffies
> > 	$1 = 4294676330
> > 	(gdb) print system_state
> > 	$2 = SYSTEM_RUNNING
> > 
> > In other words, the system really has booted, and at least one CPU is
> > happily idling in the idle loop.  And another CPU is (maybe not quite
> > so happily) running rcutorture:
> > 
> > 	(gdb) thread 6
> > 	[Switching to thread 6 (Thread 1.6)]
> > 	#0  0xffffffff8111160b in rcu_torture_one_read (
> > 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> > 	    at kernel/rcu/rcutorture.c:2003
> > 	2003            completed = cur_ops->get_gp_seq();
> > 	(gdb) bt
> > 	#0  0xffffffff8111160b in rcu_torture_one_read (
> > 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> > 	    at kernel/rcu/rcutorture.c:2003
> > 	#1  0xffffffff81111bef in rcu_torture_reader (arg=0x4 <fixed_percpu_data+4>)
> > 	    at kernel/rcu/rcutorture.c:2097
> > 	#2  0xffffffff810af3e0 in kthread (_create=0xffff8880047aa480)
> > 	    at kernel/kthread.c:388
> > 	#3  0xffffffff8103af1f in ret_from_fork (prev=<optimized out>,
> > 	    regs=0xffffc900004abf58, fn=0xffffffff810af300 <kthread>,
> > 	    fn_arg=0xffff8880047aa480) at arch/x86/kernel/process.c:147
> > 	#4  0xffffffff8100247a in ret_from_fork_asm () at arch/x86/entry/entry_64.S:242
> > 	#5  0x0000000000000000 in ?? ()
> > 
> > So the system really did boot and is running just fine.  It is just that
> > there is no console output.  Details, details!
> > 
> > Is there anything I can do to some combination of workqueues and printk
> > to help debug this?  Or that I can do to anything else, as I am not
> > feeling all that picky.  ;-)
> 
> Just to exclude one source of troubles, have you tried turning all atomics
> into full barriers and seen if the issue still reproduces?

Good point, and if this sort of thing happens frequently, perhaps there
should be an easy way of doing this.  One crude hack that might come
pretty close would be to redefine the barrier() macro to be smp_mb().

But as noted earlier, -ENOREPRODUCE on today's -next.  I will try the
next several -next releases.  But if they all get -ENOREPRODUCE, I owe
everyone on CC an apology for having sent this report out before trying
next-20240202.  :-/

							Thanx, Paul

> jonas
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > [1] The dual-socket system is an 80-hardware-thread (20 cores per socket)
> >      system with model name Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz.
> >      I get the same results when using either of these compilers:
> >      gcc version 8.5.0 20210514 (Red Hat 8.5.0-21) (GCC)
> >      gcc version 11.4.1 20230605 (Red Hat 11.4.1-2) (GCC)
> > 
> > [2] My laptop is a 16-hardware-thread (8 cores) single-socket system with
> >      model name "Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz" and
> >      gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04).
> 

