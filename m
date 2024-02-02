Return-Path: <linux-kernel+bounces-50100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2CD84743A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C328723D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28DA1487DD;
	Fri,  2 Feb 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDD2WSyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767F1487D8;
	Fri,  2 Feb 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890022; cv=none; b=ASmTgr1ygwvjchFLSDCw7lOZF3+vdqzRnO7S0B4eYI3W2hbjtrIVA51zkRq2gcxBUtCn/y4dN/HG5j2SAPUgGsFyoHgGXLOU1LESZFSmOcHdV31WQdYEzOYeH49Hc4t445FHGVTpvbQ80rB0yA55UXTUeGhPM6ffpd78y7xF8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890022; c=relaxed/simple;
	bh=fjc526JiXTlYO4KafAr/tJ2HguGEYH7TE0Z6zPLMyIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la0uY+W9qKqaf9ZJyrR2Lt5Gfk4F4iWE98cgTUjlJ3Hs0pr5IngzdBbPnO0wowOVT4fcAIpDvqIeIbPcZYpRWh8qIipaHcEmcCM/a384EfE5ExaWySl7M6+fz86XAVjnxHHGsSfV9PqBdsiav3BTWTHqcghaka/OeAOOok31hZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDD2WSyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27FCC43390;
	Fri,  2 Feb 2024 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890021;
	bh=fjc526JiXTlYO4KafAr/tJ2HguGEYH7TE0Z6zPLMyIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DDD2WSyUixPd1wKOiS1WU9EYNaefiKAxRgz7hNROQ+ZF4TG/8MNCmofzwkDG/lwo9
	 bRMxjXMExO89gr8t/E5WyxwuAZ1CiPQ/xmkyMm1FNDy+x8ZRJeGh7x14Y5ur6ExH7E
	 yFRKAOrliEa1JiMnF/DC/3qsOJQnq7zH/FTjRoRJxzkcBJUH04eHS4V701lIGe+Hx+
	 XzwZazrRqgbLRKspfbRoztCdwibytdyRQqX+esfV3II/KoKKU6eVzBejcKb0ReRcMo
	 pQk2MRTeG3u0PBHT/otghQlRyDim+aCLZJWkYcUJTkVRDXKkVJ0G3N1OlAYK1PQ0Gl
	 QumBkeU7Lj3uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 447D6CE2250; Fri,  2 Feb 2024 08:07:01 -0800 (PST)
Date: Fri, 2 Feb 2024 08:07:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <e572dedc-13cd-4202-8e31-5d851eea28ac@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <Zbz9rlGPbwBJMFLG@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbz9rlGPbwBJMFLG@alley>

On Fri, Feb 02, 2024 at 03:35:26PM +0100, Petr Mladek wrote:
> On Fri 2024-02-02 05:04:45, Paul E. McKenney wrote:
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
> It really sounds strange. Console drivers should not use workqueues
> at least for console->write() callbacks. The main reason is that
> workqueues do not work in panic(). But it might bring many problems
> even when the system is running "normally"
> 
> You wrote above that there was absolutely no console output so the problem
> was from the very beginning.
> 
> I looks like that the consoles get blocked either during registration
> of the first console or when trying to flush the first message.
> 
> Consoles, except for early consoles, are registered by
> console_initcall(). And init calls are proceed when the workqueues
> subsystem is already initialized. So, workqueues might
> somehow affect console driver initialization and registration.
> 
> My first though was that the workqueues change might somehow
> block synchronize_srcu() which is used when updating console_list.
> But it not called during console registration. It is called only
> during suspend, resume, and console unregistration. So, it should
> not block the first boot messages.
> 
> My current theory is that the change in workqueues might somehow
> block a console driver initialization. I think that some console
> drivers might use workqueues for some tasks even though they
> could not use them in the write() callback.
> 
> Could you please provide console log when the problematic patch
> is disabled? I wonder what consoles drivers are registered and when.

Please see below.  But again, next-20240202 no longer shows this behavior.
Perhaps both workqueues and printk were innocent bystanders?  :-/

> Just to be sure. Does the rcu torture configuration modify the
> behavior of srcu_read_lock_nmisafe() which is used by
> console_srcu_read_lock()?

No, and in all cases this was running in a guest OS.

Maybe something will jump out from the console log, but otherwise, I am
tempted to assume that workqueues and printk were innocent bystanders
for some other bug that got fixed.

							Thanx, Paul

------------------------------------------------------------------------

Or access this URL: https://drive.google.com/file/d/1rOtr3UP3oI6thYKyGOv7YGJiHkRcgJt9/view?usp=sharing

------------------------------------------------------------------------

[    0.000000] Linux version 6.8.0-rc2-next-20240131-00001-ge4a8ad1d3e46 (paulmckrcu@devbig010.nao1.facebook.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21), GNU ld version 2.30-123.el8) #40380 SMP PREEMPT_DYNAMIC Thu Feb  1 04:46:52 PST 2024
[    0.000000] Command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug console=ttyS0 nokaslr rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=60 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1 maxcpus=8 nr_cpus=43 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7 rcutorture.nocbs_nthreads=8 rcutorture.nocbs_toggle=1000 rcutorture.fwd_progress=0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001ffddfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001ffde000-0x000000001fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] debug_boot_weak_hash enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001] kvm-clock: using sched offset of 390900481 cycles
[    0.000003] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000006] tsc: Detected 1995.308 MHz processor
[    0.000955] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000958] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000964] last_pfn = 0x1ffde max_arch_pfn = 0x400000000
[    0.001008] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.001013] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.018200] ACPI: Early table checksum verification disabled
[    0.018204] ACPI: RSDP 0x00000000000F5B50 000014 (v00 BOCHS )
[    0.018215] ACPI: RSDT 0x000000001FFE2412 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.018222] ACPI: FACP 0x000000001FFE20E2 0000F4 (v03 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.018232] ACPI: DSDT 0x000000001FFDF400 002CE2 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.018237] ACPI: FACS 0x000000001FFDF3C0 000040
[    0.018241] ACPI: APIC 0x000000001FFE21D6 0001C8 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.018245] ACPI: HPET 0x000000001FFE239E 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.018250] ACPI: MCFG 0x000000001FFE23D6 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.018254] ACPI: Reserving FACP table memory at [mem 0x1ffe20e2-0x1ffe21d5]
[    0.018256] ACPI: Reserving DSDT table memory at [mem 0x1ffdf400-0x1ffe20e1]
[    0.018258] ACPI: Reserving FACS table memory at [mem 0x1ffdf3c0-0x1ffdf3ff]
[    0.018260] ACPI: Reserving APIC table memory at [mem 0x1ffe21d6-0x1ffe239d]
[    0.018261] ACPI: Reserving HPET table memory at [mem 0x1ffe239e-0x1ffe23d5]
[    0.018263] ACPI: Reserving MCFG table memory at [mem 0x1ffe23d6-0x1ffe2411]
[    0.018760] No NUMA configuration found
[    0.018763] Faking a node at [mem 0x0000000000000000-0x000000001ffddfff]
[    0.018775] NODE_DATA(0) allocated [mem 0x1ffbc000-0x1ffddfff]
[    0.018905] Zone ranges:
[    0.018907]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018910]   DMA32    [mem 0x0000000001000000-0x000000001ffddfff]
[    0.018912]   Normal   empty
[    0.018914] Movable zone start for each node
[    0.018917] Early memory node ranges
[    0.018917]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.018919]   node   0: [mem 0x0000000000100000-0x000000001ffddfff]
[    0.018922] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffddfff]
[    0.019435] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.019464] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.021948] On node 0, zone DMA32: 34 pages in unavailable ranges
[    0.022471] ACPI: PM-Timer IO Port: 0x608
[    0.022499] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.022549] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.022555] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.022557] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.022559] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.022560] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.022561] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.022567] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.022568] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.022573] smpboot: Allowing 43 CPUs, 0 hotplug CPUs
[    0.022592] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.022623] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.022625] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.022627] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.022628] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.022630] [mem 0x20000000-0xafffffff] available for PCI devices
[    0.022632] Booting paravirtualized kernel on KVM
[    0.022634] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.030062] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:43 nr_cpu_ids:43 nr_node_ids:1
[    0.035018] percpu: Embedded 56 pages/cpu s189352 r8192 d31832 u262144
[    0.035034] pcpu-alloc: s189352 r8192 d31832 u262144 alloc=1*2097152
[    0.035038] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.035050] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31 
[    0.035064] pcpu-alloc: [0] 32 33 34 35 36 37 38 39 [0] 40 41 42 -- -- -- -- -- 
[    0.035109] Kernel command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug console=ttyS0 nokaslr rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=60 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1 maxcpus=8 nr_cpus=43 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7 rcutorture.nocbs_nthreads=8 rcutorture.nocbs_toggle=1000 rcutorture.fwd_progress=0
[    0.035350] Unknown kernel command line parameters "nokaslr", will be passed to user space.
[    0.035358] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.035360] printk: log_buf_len total cpu_extra contributions: 172032 bytes
[    0.035372] printk: log_buf_len min size: 262144 bytes
[    0.036709] printk: log_buf_len: 524288 bytes
[    0.036710] printk: early log buf free: 255216(97%)
[    0.036991] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.037130] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.037838] Fallback order for Node 0: 0 
[    0.037845] Built 1 zonelists, mobility grouping on.  Total pages: 128734
[    0.037847] Policy zone: DMA32
[    0.037849] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.038987] Memory: 460744K/523760K available (18432K kernel code, 3201K rwdata, 6908K rodata, 3396K init, 2268K bss, 62760K reserved, 0K cma-reserved)
[    0.039120] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=43, Nodes=1
[    0.039158] Kernel/User page tables isolation: enabled
[    0.039286] Dynamic Preempt: full
[    0.039751] rcu: Preemptible hierarchical RCU implementation.
[    0.039752] rcu: 	RCU event tracing is enabled.
[    0.039752] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=43.
[    0.039753] rcu: 	RCU debug GP pre-init slowdown 3 jiffies.
[    0.039754] rcu: 	RCU debug GP init slowdown 3 jiffies.
[    0.039755] rcu: 	RCU debug GP cleanup slowdown 3 jiffies.
[    0.039755] 	Trampoline variant of Tasks RCU enabled.
[    0.039756] 	Rude variant of Tasks RCU enabled.
[    0.039757] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.039758] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=43
[    0.041336] NR_IRQS: 524544, nr_irqs: 768, preallocated irqs: 16
[    0.041591] rcu: 	Offload RCU callbacks from CPUs: 0-1,3-7.
[    0.041597] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.041678] calling  con_init+0x0/0x250 @ 0
[    0.047962] Console: colour VGA+ 80x25
[    0.047964] initcall con_init+0x0/0x250 returned 0 after 0 usecs
[    0.047967] calling  hvc_console_init+0x0/0x20 @ 0
[    0.047970] initcall hvc_console_init+0x0/0x20 returned 0 after 0 usecs
[    0.047972] calling  univ8250_console_init+0x0/0x40 @ 0
[    0.048008] printk: legacy console [ttyS0] enabled
[    0.155254] initcall univ8250_console_init+0x0/0x40 returned 0 after 0 usecs
[    0.156241] ACPI: Core revision 20230628
[    0.157272] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.158526] APIC: Switch to symmetric I/O mode setup
[    0.159167] APIC: Switched APIC routing to: physical flat
[    0.160962] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.161914] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3985bbcfaa7, max_idle_ns: 881590561327 ns
[    0.163594] Calibrating delay loop (skipped) preset value.. 3990.61 BogoMIPS (lpj=1995308)
[    0.164731] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.165592] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.166594] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.167593] Spectre V2 : Mitigation: Retpolines
[    0.168591] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.169592] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.170591] Speculative Store Bypass: Vulnerable
[    0.171593] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.172591] MMIO Stale Data: Unknown: No mitigations
[    0.173593] x86/fpu: x87 FPU will use FXSAVE
[    0.192285] Freeing SMP alternatives memory: 48K
[    0.192621] pid_max: default: 44032 minimum: 344
[    0.193684] LSM: initializing lsm=capability,integrity
[    0.194655] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.195592] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.299481] smpboot: CPU0: Intel Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)
[    0.299762] RCU Tasks: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1.
[    0.300610] RCU Tasks Rude: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1.
[    0.301611] calling  init_hw_perf_events+0x0/0x700 @ 1
[    0.302480] Performance Events: unsupported Netburst CPU model 6 no PMU driver, software events only.
[    0.302591] initcall init_hw_perf_events+0x0/0x700 returned 0 after 1000 usecs
[    0.303591] calling  do_init_real_mode+0x0/0x20 @ 1
[    0.304746] initcall do_init_real_mode+0x0/0x20 returned 0 after 0 usecs
[    0.305592] calling  init_sigframe_size+0x0/0x40 @ 1
[    0.306591] signal: max sigframe size: 1440
[    0.307194] initcall init_sigframe_size+0x0/0x40 returned 0 after 0 usecs
[    0.307591] calling  trace_init_perf_perm_irq_work_exit+0x0/0x20 @ 1
[    0.308591] initcall trace_init_perf_perm_irq_work_exit+0x0/0x20 returned 0 after 0 usecs
[    0.309592] calling  cache_ap_register+0x0/0x60 @ 1
[    0.310593] initcall cache_ap_register+0x0/0x60 returned 0 after 0 usecs
[    0.311576] calling  bp_init_aperfmperf+0x0/0x3a0 @ 1
[    0.311592] initcall bp_init_aperfmperf+0x0/0x3a0 returned 0 after 0 usecs
[    0.312592] calling  save_builtin_microcode+0x0/0xd0 @ 1
[    0.313592] initcall save_builtin_microcode+0x0/0xd0 returned 0 after 0 usecs
[    0.314591] calling  save_microcode_in_initrd+0x0/0x130 @ 1
[    0.315593] initcall save_microcode_in_initrd+0x0/0x130 returned 0 after 0 usecs
[    0.316592] calling  smp_init_primary_thread_mask+0x0/0x50 @ 1
[    0.317592] initcall smp_init_primary_thread_mask+0x0/0x50 returned 0 after 0 usecs
[    0.318592] calling  register_nmi_cpu_backtrace_handler+0x0/0x20 @ 1
[    0.319592] initcall register_nmi_cpu_backtrace_handler+0x0/0x20 returned 0 after 0 usecs
[    0.320593] calling  kvm_setup_vsyscall_timeinfo+0x0/0x120 @ 1
[    0.321592] initcall kvm_setup_vsyscall_timeinfo+0x0/0x120 returned 0 after 0 usecs
[    0.322591] calling  spawn_ksoftirqd+0x0/0x40 @ 1
[    0.323625] initcall spawn_ksoftirqd+0x0/0x40 returned 0 after 0 usecs
[    0.324591] calling  init_signal_sysctls+0x0/0x30 @ 1
[    0.325593] initcall init_signal_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.326591] calling  init_umh_sysctls+0x0/0x30 @ 1
[    0.327325] initcall init_umh_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.327591] calling  migration_init+0x0/0x40 @ 1
[    0.328591] initcall migration_init+0x0/0x40 returned 0 after 0 usecs
[    0.329591] calling  srcu_bootup_announce+0x0/0x80 @ 1
[    0.330591] rcu: Hierarchical SRCU implementation.
[    0.331591] rcu: 	Max phase no-delay instances is 400.
[    0.332374] initcall srcu_bootup_announce+0x0/0x80 returned 0 after 1000 usecs
[    0.332591] calling  rcu_spawn_gp_kthread+0x0/0x240 @ 1
[    0.333630] initcall rcu_spawn_gp_kthread+0x0/0x240 returned 0 after 1000 usecs
[    0.334599] calling  check_cpu_stall_init+0x0/0x20 @ 1
[    0.335333] initcall check_cpu_stall_init+0x0/0x20 returned 0 after 0 usecs
[    0.335591] calling  rcu_sysrq_init+0x0/0x30 @ 1
[    0.336591] initcall rcu_sysrq_init+0x0/0x30 returned 0 after 0 usecs
[    0.337592] calling  trace_init_flags_sys_enter+0x0/0x20 @ 1
[    0.338591] initcall trace_init_flags_sys_enter+0x0/0x20 returned 0 after 0 usecs
[    0.339591] calling  trace_init_flags_sys_exit+0x0/0x20 @ 1
[    0.340591] initcall trace_init_flags_sys_exit+0x0/0x20 returned 0 after 0 usecs
[    0.341591] calling  insert_crashkernel_resources+0x0/0x70 @ 1
[    0.342592] initcall insert_crashkernel_resources+0x0/0x70 returned 0 after 0 usecs
[    0.343591] calling  cpu_stop_init+0x0/0xa0 @ 1
[    0.344298] initcall cpu_stop_init+0x0/0xa0 returned 0 after 0 usecs
[    0.344591] calling  init_kprobes+0x0/0x1d0 @ 1
[    0.345688] initcall init_kprobes+0x0/0x1d0 returned 0 after 0 usecs
[    0.346591] calling  init_trace_printk+0x0/0x10 @ 1
[    0.347592] initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
[    0.348591] calling  event_trace_enable_again+0x0/0x60 @ 1
[    0.349592] initcall event_trace_enable_again+0x0/0x60 returned 0 after 0 usecs
[    0.350591] calling  irq_work_init_threads+0x0/0x10 @ 1
[    0.351591] initcall irq_work_init_threads+0x0/0x10 returned 0 after 0 usecs
[    0.352591] calling  static_call_init+0x0/0xd0 @ 1
[    0.353591] initcall static_call_init+0x0/0xd0 returned 0 after 0 usecs
[    0.354591] calling  jump_label_init_module+0x0/0x10 @ 1
[    0.355350] initcall jump_label_init_module+0x0/0x10 returned 0 after 0 usecs
[    0.355591] calling  init_zero_pfn+0x0/0x40 @ 1
[    0.356591] initcall init_zero_pfn+0x0/0x40 returned 0 after 0 usecs
[    0.357591] calling  init_fs_inode_sysctls+0x0/0x30 @ 1
[    0.358592] initcall init_fs_inode_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.359591] calling  init_fs_locks_sysctls+0x0/0x30 @ 1
[    0.360592] initcall init_fs_locks_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.361591] calling  init_fs_sysctls+0x0/0x30 @ 1
[    0.362592] initcall init_fs_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.363591] calling  init_security_keys_sysctls+0x0/0x30 @ 1
[    0.364594] initcall init_security_keys_sysctls+0x0/0x30 returned 0 after 0 usecs
[    0.365591] calling  efi_memreserve_root_init+0x0/0x30 @ 1
[    0.366592] initcall efi_memreserve_root_init+0x0/0x30 returned 0 after 0 usecs
[    0.367591] calling  efi_earlycon_remap_fb+0x0/0x70 @ 1
[    0.368592] initcall efi_earlycon_remap_fb+0x0/0x70 returned 0 after 0 usecs
[    0.370623] smp: Bringing up secondary CPUs ...
[    0.371522] smpboot: x86: Booting SMP configuration:
[    0.371599] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.119986] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.119986] smpboot: CPU 2 Converting physical 0 to logical die 2
[    0.119986] smpboot: CPU 3 Converting physical 0 to logical die 3
[    0.119986] smpboot: CPU 4 Converting physical 0 to logical die 4
[    0.119986] smpboot: CPU 5 Converting physical 0 to logical die 5
[    0.119986] smpboot: CPU 6 Converting physical 0 to logical die 6
[    0.119986] smpboot: CPU 7 Converting physical 0 to logical die 7
[    0.467595] smp: Brought up 1 node, 8 CPUs
[    0.468307] smpboot: Max logical packages: 43
[    0.468593] smpboot: Total of 8 processors activated (31924.92 BogoMIPS)
[    0.471686] devtmpfs: initialized
[    0.473147] calling  ipc_ns_init+0x0/0x50 @ 1
[    0.473595] initcall ipc_ns_init+0x0/0x50 returned 0 after 0 usecs
[    0.474594] calling  init_mmap_min_addr+0x0/0x30 @ 1
[    0.475595] initcall init_mmap_min_addr+0x0/0x30 returned 0 after 0 usecs
[    0.476592] calling  pci_realloc_setup_params+0x0/0x40 @ 1
[    0.477592] initcall pci_realloc_setup_params+0x0/0x40 returned 0 after 0 usecs
[    0.478592] calling  inet_frag_wq_init+0x0/0x40 @ 1
[    0.479607] initcall inet_frag_wq_init+0x0/0x40 returned 0 after 1000 usecs
[    0.480690] calling  e820__register_nvs_regions+0x0/0x60 @ 1
[    0.481592] initcall e820__register_nvs_regions+0x0/0x60 returned 0 after 0 usecs
[    0.482592] calling  cpufreq_register_tsc_scaling+0x0/0x40 @ 1
[    0.483601] initcall cpufreq_register_tsc_scaling+0x0/0x40 returned 0 after 0 usecs
[    0.484592] calling  reboot_init+0x0/0x50 @ 1
[    0.485595] initcall reboot_init+0x0/0x50 returned 0 after 0 usecs
[    0.486592] calling  init_lapic_sysfs+0x0/0x30 @ 1
[    0.487595] initcall init_lapic_sysfs+0x0/0x30 returned 0 after 0 usecs
[    0.488592] calling  alloc_frozen_cpus+0x0/0x30 @ 1
[    0.489353] initcall alloc_frozen_cpus+0x0/0x30 returned 0 after 0 usecs
[    0.489592] calling  cpu_hotplug_pm_sync_init+0x0/0x20 @ 1
[    0.490592] initcall cpu_hotplug_pm_sync_init+0x0/0x20 returned 0 after 0 usecs
[    0.491594] calling  wq_sysfs_init+0x0/0x80 @ 1
[    0.492607] initcall wq_sysfs_init+0x0/0x80 returned 0 after 0 usecs
[    0.493592] calling  ksysfs_init+0x0/0xc0 @ 1
[    0.494597] initcall ksysfs_init+0x0/0xc0 returned 0 after 0 usecs
[    0.495596] calling  schedutil_gov_init+0x0/0x10 @ 1
[    0.496592] initcall schedutil_gov_init+0x0/0x10 returned 0 after 0 usecs
[    0.497592] calling  pm_init+0x0/0x80 @ 1
[    0.498232] initcall pm_init+0x0/0x80 returned 0 after 0 usecs
[    0.498591] calling  pm_disk_init+0x0/0x20 @ 1
[    0.499608] initcall pm_disk_init+0x0/0x20 returned 0 after 0 usecs
[    0.500592] calling  swsusp_header_init+0x0/0x30 @ 1
[    0.501592] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    0.502592] calling  rcu_set_runtime_mode+0x0/0x20 @ 1
[    0.503601] initcall rcu_set_runtime_mode+0x0/0x20 returned 0 after 0 usecs
[    0.504592] calling  init_jiffies_clocksource+0x0/0x20 @ 1
[    0.505592] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.506592] initcall init_jiffies_clocksource+0x0/0x20 returned 0 after 1000 usecs
[    0.507592] calling  futex_init+0x0/0xe0 @ 1
[    0.508595] futex hash table entries: 16384 (order: 8, 1048576 bytes, linear)
[    0.509679] initcall futex_init+0x0/0xe0 returned 0 after 1000 usecs
[    0.510593] calling  cgroup_wq_init+0x0/0x30 @ 1
[    0.511606] initcall cgroup_wq_init+0x0/0x30 returned 0 after 0 usecs
[    0.512592] calling  cgroup1_wq_init+0x0/0x30 @ 1
[    0.513320] initcall cgroup1_wq_init+0x0/0x30 returned 0 after 0 usecs
[    0.513591] calling  trace_events_eprobe_init_early+0x0/0x40 @ 1
[    0.514592] initcall trace_events_eprobe_init_early+0x0/0x40 returned 0 after 0 usecs
[    0.515591] calling  init_kprobe_trace_early+0x0/0x40 @ 1
[    0.516411] initcall init_kprobe_trace_early+0x0/0x40 returned 0 after 0 usecs
[    0.516591] calling  fsnotify_init+0x0/0x50 @ 1
[    0.517610] initcall fsnotify_init+0x0/0x50 returned 0 after 0 usecs
[    0.518592] calling  filelock_init+0x0/0xb0 @ 1
[    0.519617] initcall filelock_init+0x0/0xb0 returned 0 after 0 usecs
[    0.520591] calling  init_misc_binfmt+0x0/0x50 @ 1
[    0.521593] initcall init_misc_binfmt+0x0/0x50 returned 0 after 0 usecs
[    0.522592] calling  init_script_binfmt+0x0/0x20 @ 1
[    0.523344] initcall init_script_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.523592] calling  init_elf_binfmt+0x0/0x20 @ 1
[    0.524591] initcall init_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.525591] calling  init_compat_elf_binfmt+0x0/0x20 @ 1
[    0.526591] initcall init_compat_elf_binfmt+0x0/0x20 returned 0 after 0 usecs
[    0.527592] calling  debugfs_init+0x0/0x80 @ 1
[    0.528594] initcall debugfs_init+0x0/0x80 returned 0 after 0 usecs
[    0.529591] calling  tracefs_init+0x0/0x80 @ 1
[    0.530602] initcall tracefs_init+0x0/0x80 returned 0 after 0 usecs
[    0.531566] calling  virtio_init+0x0/0x30 @ 1
[    0.531600] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    0.532592] calling  iommu_init+0x0/0x30 @ 1
[    0.533593] initcall iommu_init+0x0/0x30 returned 0 after 0 usecs
[    0.534592] calling  component_debug_init+0x0/0x20 @ 1
[    0.535625] initcall component_debug_init+0x0/0x20 returned 0 after 0 usecs
[    0.536592] calling  early_resume_init+0x0/0xe0 @ 1
[    0.537658] PM: RTC time: 12:50:23, date: 2024-02-01
[    0.538592] initcall early_resume_init+0x0/0xe0 returned 0 after 1000 usecs
[    0.539592] calling  cpufreq_core_init+0x0/0xa0 @ 1
[    0.540332] initcall cpufreq_core_init+0x0/0xa0 returned 0 after 0 usecs
[    0.540591] calling  cpufreq_gov_performance_init+0x0/0x10 @ 1
[    0.541592] initcall cpufreq_gov_performance_init+0x0/0x10 returned 0 after 0 usecs
[    0.542591] calling  cpufreq_gov_userspace_init+0x0/0x10 @ 1
[    0.543592] initcall cpufreq_gov_userspace_init+0x0/0x10 returned 0 after 0 usecs
[    0.544592] calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x10 @ 1
[    0.545451] initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x10 returned 0 after 0 usecs
[    0.545591] calling  cpuidle_init+0x0/0x20 @ 1
[    0.546343] initcall cpuidle_init+0x0/0x20 returned 0 after 0 usecs
[    0.546592] calling  sock_init+0x0/0xb0 @ 1
[    0.547806] initcall sock_init+0x0/0xb0 returned 0 after 0 usecs
[    0.548593] calling  net_inuse_init+0x0/0x30 @ 1
[    0.549599] initcall net_inuse_init+0x0/0x30 returned 0 after 0 usecs
[    0.550592] calling  net_defaults_init+0x0/0x30 @ 1
[    0.551592] initcall net_defaults_init+0x0/0x30 returned 0 after 0 usecs
[    0.552592] calling  init_default_flow_dissectors+0x0/0x60 @ 1
[    0.553592] initcall init_default_flow_dissectors+0x0/0x60 returned 0 after 0 usecs
[    0.554592] calling  netpoll_init+0x0/0x30 @ 1
[    0.555358] initcall netpoll_init+0x0/0x30 returned 0 after 0 usecs
[    0.555592] calling  netlink_proto_init+0x0/0x190 @ 1
[    0.556644] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.557603] initcall netlink_proto_init+0x0/0x190 returned 0 after 1000 usecs
[    0.558592] calling  genl_init+0x0/0x40 @ 1
[    0.559597] initcall genl_init+0x0/0x40 returned 0 after 0 usecs
[    0.560592] calling  bsp_pm_check_init+0x0/0x20 @ 1
[    0.561439] initcall bsp_pm_check_init+0x0/0x20 returned 0 after 0 usecs
[    0.561705] calling  irq_sysfs_init+0x0/0xa0 @ 1
[    0.562664] initcall irq_sysfs_init+0x0/0xa0 returned 0 after 0 usecs
[    0.563592] calling  audit_init+0x0/0x180 @ 1
[    0.564368] audit: initializing netlink subsys (disabled)
[    0.565597] initcall audit_init+0x0/0x180 returned 0 after 2000 usecs
[    0.565595] audit: type=2000 audit(1706791823.511:1): state=initialized audit_enabled=0 res=1
[    0.566592] calling  release_early_probes+0x0/0x50 @ 1
[    0.568592] initcall release_early_probes+0x0/0x50 returned 0 after 0 usecs
[    0.569592] calling  bdi_class_init+0x0/0x40 @ 1
[    0.570602] initcall bdi_class_init+0x0/0x40 returned 0 after 0 usecs
[    0.571592] calling  mm_sysfs_init+0x0/0x30 @ 1
[    0.572593] initcall mm_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.573592] calling  init_per_zone_wmark_min+0x0/0x30 @ 1
[    0.574617] initcall init_per_zone_wmark_min+0x0/0x30 returned 0 after 0 usecs
[    0.575592] calling  mpi_init+0x0/0x60 @ 1
[    0.576593] initcall mpi_init+0x0/0x60 returned 0 after 0 usecs
[    0.577592] calling  pcibus_class_init+0x0/0x10 @ 1
[    0.578594] initcall pcibus_class_init+0x0/0x10 returned 0 after 0 usecs
[    0.579592] calling  pci_driver_init+0x0/0x30 @ 1
[    0.580603] initcall pci_driver_init+0x0/0x30 returned 0 after 0 usecs
[    0.581592] calling  backlight_class_init+0x0/0xb0 @ 1
[    0.582594] initcall backlight_class_init+0x0/0xb0 returned 0 after 0 usecs
[    0.583592] calling  tty_class_init+0x0/0x10 @ 1
[    0.584594] initcall tty_class_init+0x0/0x10 returned 0 after 0 usecs
[    0.585592] calling  vtconsole_class_init+0x0/0xc0 @ 1
[    0.586610] initcall vtconsole_class_init+0x0/0xc0 returned 0 after 0 usecs
[    0.587592] calling  iommu_dev_init+0x0/0x10 @ 1
[    0.588594] initcall iommu_dev_init+0x0/0x10 returned 0 after 0 usecs
[    0.589592] calling  mipi_dsi_bus_init+0x0/0x10 @ 1
[    0.590444] initcall mipi_dsi_bus_init+0x0/0x10 returned 0 after 0 usecs
[    0.590592] calling  devlink_class_init+0x0/0x50 @ 1
[    0.591599] initcall devlink_class_init+0x0/0x50 returned 0 after 0 usecs
[    0.592592] calling  software_node_init+0x0/0x30 @ 1
[    0.593593] initcall software_node_init+0x0/0x30 returned 0 after 0 usecs
[    0.594592] calling  wakeup_sources_debugfs_init+0x0/0x30 @ 1
[    0.595595] initcall wakeup_sources_debugfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.596592] calling  wakeup_sources_sysfs_init+0x0/0x30 @ 1
[    0.597597] initcall wakeup_sources_sysfs_init+0x0/0x30 returned 0 after 0 usecs
[    0.598592] calling  regmap_initcall+0x0/0x10 @ 1
[    0.599594] initcall regmap_initcall+0x0/0x10 returned 0 after 0 usecs
[    0.600592] calling  i2c_init+0x0/0xf0 @ 1
[    0.601604] initcall i2c_init+0x0/0xf0 returned 0 after 0 usecs
[    0.602592] calling  thermal_init+0x0/0x180 @ 1
[    0.603376] thermal_sys: Registered thermal governor 'step_wise'
[    0.603377] thermal_sys: Registered thermal governor 'user_space'
[    0.603595] initcall thermal_init+0x0/0x180 returned 0 after 1000 usecs
[    0.605592] calling  init_menu+0x0/0x10 @ 1
[    0.606606] cpuidle: using governor menu
[    0.607592] initcall init_menu+0x0/0x10 returned 0 after 1000 usecs
[    0.608592] calling  init_haltpoll+0x0/0x20 @ 1
[    0.609307] initcall init_haltpoll+0x0/0x20 returned 0 after 0 usecs
[    0.609592] calling  pcc_init+0x0/0x60 @ 1
[    0.610593] initcall pcc_init+0x0/0x60 returned -19 after 0 usecs
[    0.611592] calling  amd_postcore_init+0x0/0x130 @ 1
[    0.612592] initcall amd_postcore_init+0x0/0x130 returned 0 after 0 usecs
[    0.613592] calling  kobject_uevent_init+0x0/0x10 @ 1
[    0.614596] initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
[    0.615695] calling  bts_init+0x0/0xc0 @ 1
[    0.616592] initcall bts_init+0x0/0xc0 returned -19 after 0 usecs
[    0.617592] calling  pt_init+0x0/0x3c0 @ 1
[    0.618296] initcall pt_init+0x0/0x3c0 returned -19 after 0 usecs
[    0.618592] calling  boot_params_ksysfs_init+0x0/0x320 @ 1
[    0.619595] initcall boot_params_ksysfs_init+0x0/0x320 returned 0 after 0 usecs
[    0.620592] calling  sbf_init+0x0/0xe0 @ 1
[    0.621592] initcall sbf_init+0x0/0xe0 returned 0 after 0 usecs
[    0.622592] calling  arch_kdebugfs_init+0x0/0x220 @ 1
[    0.623597] initcall arch_kdebugfs_init+0x0/0x220 returned 0 after 0 usecs
[    0.624592] calling  xfd_update_static_branch+0x0/0x30 @ 1
[    0.625592] initcall xfd_update_static_branch+0x0/0x30 returned 0 after 0 usecs
[    0.626592] calling  intel_pconfig_init+0x0/0x90 @ 1
[    0.628456] initcall intel_pconfig_init+0x0/0x90 returned 0 after 0 usecs
[    0.628592] calling  mtrr_if_init+0x0/0x70 @ 1
[    0.629366] initcall mtrr_if_init+0x0/0x70 returned 0 after 0 usecs
[    0.629592] calling  activate_jump_labels+0x0/0x40 @ 1
[    0.630592] initcall activate_jump_labels+0x0/0x40 returned 0 after 0 usecs
[    0.631592] calling  init_s4_sigcheck+0x0/0x30 @ 1
[    0.632592] initcall init_s4_sigcheck+0x0/0x30 returned 0 after 0 usecs
[    0.633591] calling  ffh_cstate_init+0x0/0x40 @ 1
[    0.634599] initcall ffh_cstate_init+0x0/0x40 returned 0 after 0 usecs
[    0.635591] calling  kvm_alloc_cpumask+0x0/0xc0 @ 1
[    0.636594] initcall kvm_alloc_cpumask+0x0/0xc0 returned 0 after 0 usecs
[    0.637591] calling  activate_jump_labels+0x0/0x40 @ 1
[    0.638745] initcall activate_jump_labels+0x0/0x40 returned 0 after 0 usecs
[    0.639592] calling  kcmp_cookies_init+0x0/0x40 @ 1
[    0.640594] initcall kcmp_cookies_init+0x0/0x40 returned 0 after 0 usecs
[    0.641592] calling  cryptomgr_init+0x0/0x10 @ 1
[    0.642592] initcall cryptomgr_init+0x0/0x10 returned 0 after 0 usecs
[    0.643592] calling  acpi_pci_init+0x0/0x50 @ 1
[    0.644300] initcall acpi_pci_init+0x0/0x50 returned 0 after 0 usecs
[    0.644592] calling  dma_channel_table_init+0x0/0x100 @ 1
[    0.645643] initcall dma_channel_table_init+0x0/0x100 returned 0 after 0 usecs
[    0.646592] calling  dma_bus_init+0x0/0xf0 @ 1
[    0.647602] initcall dma_bus_init+0x0/0xf0 returned 0 after 0 usecs
[    0.648592] calling  serial_base_init+0x0/0x70 @ 1
[    0.649605] initcall serial_base_init+0x0/0x70 returned 0 after 0 usecs
[    0.650592] calling  iommu_dma_init+0x0/0x20 @ 1
[    0.651592] initcall iommu_dma_init+0x0/0x20 returned 0 after 0 usecs
[    0.652592] calling  dmi_id_init+0x0/0x3e0 @ 1
[    0.653320] initcall dmi_id_init+0x0/0x3e0 returned 0 after 0 usecs
[    0.653592] calling  pci_arch_init+0x0/0x90 @ 1
[    0.654652] PCI: ECAM [mem 0xb0000000-0xbfffffff] (base 0xb0000000) for domain 0000 [bus 00-ff]
[    0.655593] PCI: ECAM [mem 0xb0000000-0xbfffffff] reserved as E820 entry
[    0.656603] PCI: Using configuration type 1 for base access
[    0.657594] initcall pci_arch_init+0x0/0x90 returned 0 after 3000 usecs
[    0.658693] calling  init_vdso_image_64+0x0/0x10 @ 1
[    0.659599] initcall init_vdso_image_64+0x0/0x10 returned 0 after 0 usecs
[    0.660592] calling  init_vdso_image_32+0x0/0x10 @ 1
[    0.661602] initcall init_vdso_image_32+0x0/0x10 returned 0 after 0 usecs
[    0.662592] calling  fixup_ht_bug+0x0/0xd0 @ 1
[    0.663592] initcall fixup_ht_bug+0x0/0xd0 returned 0 after 0 usecs
[    0.664593] calling  mtrr_init_finalize+0x0/0x40 @ 1
[    0.665368] initcall mtrr_init_finalize+0x0/0x40 returned 0 after 0 usecs
[    0.665592] calling  uid_cache_init+0x0/0xd0 @ 1
[    0.666598] initcall uid_cache_init+0x0/0xd0 returned 0 after 0 usecs
[    0.667592] calling  param_sysfs_init+0x0/0x50 @ 1
[    0.668594] initcall param_sysfs_init+0x0/0x50 returned 0 after 0 usecs
[    0.669592] calling  user_namespace_sysctl_init+0x0/0xd0 @ 1
[    0.670601] initcall user_namespace_sysctl_init+0x0/0xd0 returned 0 after 0 usecs
[    0.671592] calling  proc_schedstat_init+0x0/0x30 @ 1
[    0.672595] initcall proc_schedstat_init+0x0/0x30 returned 0 after 0 usecs
[    0.673592] calling  pm_sysrq_init+0x0/0x20 @ 1
[    0.674604] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs
[    0.675592] calling  create_proc_profile+0x0/0xe0 @ 1
[    0.676379] initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
[    0.676592] calling  crash_save_vmcoreinfo_init+0x0/0x690 @ 1
[    0.677620] initcall crash_save_vmcoreinfo_init+0x0/0x690 returned 0 after 0 usecs
[    0.678592] calling  crash_notes_memory_init+0x0/0x40 @ 1
[    0.679441] initcall crash_notes_memory_init+0x0/0x40 returned 0 after 0 usecs
[    0.679592] calling  crash_hotplug_init+0x0/0x30 @ 1
[    0.680366] initcall crash_hotplug_init+0x0/0x30 returned 67 after 0 usecs
[    0.680592] calling  cgroup_sysfs_init+0x0/0x20 @ 1
[    0.681594] initcall cgroup_sysfs_init+0x0/0x20 returned 0 after 0 usecs
[    0.682592] calling  init_optprobes+0x0/0x30 @ 1
[    0.683592] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.684592] initcall init_optprobes+0x0/0x30 returned 0 after 1000 usecs
[    0.685592] calling  trace_eval_init+0x0/0xc0 @ 1
[    0.686614] initcall trace_eval_init+0x0/0xc0 returned 0 after 0 usecs
[    0.687620] calling  oom_init+0x0/0x60 @ 1
[    0.688618] initcall oom_init+0x0/0x60 returned 0 after 0 usecs
[    0.689593] calling  default_bdi_init+0x0/0x30 @ 1
[    0.690629] initcall default_bdi_init+0x0/0x30 returned 0 after 0 usecs
[    0.691593] calling  percpu_enable_async+0x0/0x20 @ 1
[    0.692357] initcall percpu_enable_async+0x0/0x20 returned 0 after 0 usecs
[    0.692592] calling  kcompactd_init+0x0/0xd0 @ 1
[    0.693368] initcall kcompactd_init+0x0/0xd0 returned 0 after 0 usecs
[    0.693593] calling  init_user_reserve+0x0/0x40 @ 1
[    0.694592] initcall init_user_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.695592] calling  init_admin_reserve+0x0/0x40 @ 1
[    0.696592] initcall init_admin_reserve+0x0/0x40 returned 0 after 0 usecs
[    0.697592] calling  init_reserve_notifier+0x0/0x10 @ 1
[    0.698592] initcall init_reserve_notifier+0x0/0x10 returned 0 after 0 usecs
[    0.699592] calling  swap_init_sysfs+0x0/0x70 @ 1
[    0.700595] initcall swap_init_sysfs+0x0/0x70 returned 0 after 0 usecs
[    0.701592] calling  swapfile_init+0x0/0x100 @ 1
[    0.702592] initcall swapfile_init+0x0/0x100 returned 0 after 0 usecs
[    0.703592] calling  hugetlb_init+0x0/0x5f0 @ 1
[    0.704636] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.705592] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.706614] initcall hugetlb_init+0x0/0x5f0 returned 0 after 3000 usecs
[    0.707592] calling  memory_tier_init+0x0/0x400 @ 1
[    0.708639] initcall memory_tier_init+0x0/0x400 returned 0 after 0 usecs
[    0.709592] calling  numa_init_sysfs+0x0/0x70 @ 1
[    0.710370] initcall numa_init_sysfs+0x0/0x70 returned 0 after 0 usecs
[    0.710592] calling  seqiv_module_init+0x0/0x10 @ 1
[    0.711593] initcall seqiv_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.712592] calling  echainiv_module_init+0x0/0x10 @ 1
[    0.713592] initcall echainiv_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.714592] calling  rsa_init+0x0/0x50 @ 1
[    0.715593] initcall rsa_init+0x0/0x50 returned 0 after 0 usecs
[    0.716592] calling  crypto_cmac_module_init+0x0/0x10 @ 1
[    0.717592] initcall crypto_cmac_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.718592] calling  hmac_module_init+0x0/0x10 @ 1
[    0.719592] initcall hmac_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.720592] calling  crypto_null_mod_init+0x0/0x80 @ 1
[    0.721594] initcall crypto_null_mod_init+0x0/0x80 returned 0 after 0 usecs
[    0.722592] calling  md5_mod_init+0x0/0x10 @ 1
[    0.723593] initcall md5_mod_init+0x0/0x10 returned 0 after 0 usecs
[    0.724592] calling  sha256_generic_mod_init+0x0/0x20 @ 1
[    0.725458] initcall sha256_generic_mod_init+0x0/0x20 returned 0 after 0 usecs
[    0.725592] calling  sha512_generic_mod_init+0x0/0x20 @ 1
[    0.726456] initcall sha512_generic_mod_init+0x0/0x20 returned 0 after 0 usecs
[    0.726592] calling  sha3_generic_mod_init+0x0/0x20 @ 1
[    0.727595] initcall sha3_generic_mod_init+0x0/0x20 returned 0 after 0 usecs
[    0.728592] calling  crypto_ecb_module_init+0x0/0x10 @ 1
[    0.729592] initcall crypto_ecb_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.730592] calling  crypto_cbc_module_init+0x0/0x10 @ 1
[    0.731442] initcall crypto_cbc_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.731592] calling  crypto_ctr_module_init+0x0/0x20 @ 1
[    0.732592] initcall crypto_ctr_module_init+0x0/0x20 returned 0 after 0 usecs
[    0.733592] calling  crypto_gcm_module_init+0x0/0x80 @ 1
[    0.734593] initcall crypto_gcm_module_init+0x0/0x80 returned 0 after 0 usecs
[    0.735592] calling  crypto_ccm_module_init+0x0/0x20 @ 1
[    0.736592] initcall crypto_ccm_module_init+0x0/0x20 returned 0 after 0 usecs
[    0.737592] calling  aes_init+0x0/0x10 @ 1
[    0.738593] initcall aes_init+0x0/0x10 returned 0 after 0 usecs
[    0.739534] calling  crc32c_mod_init+0x0/0x10 @ 1
[    0.739593] initcall crc32c_mod_init+0x0/0x10 returned 0 after 0 usecs
[    0.740592] calling  crypto_authenc_module_init+0x0/0x10 @ 1
[    0.741592] initcall crypto_authenc_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.742592] calling  crypto_authenc_esn_module_init+0x0/0x10 @ 1
[    0.743592] initcall crypto_authenc_esn_module_init+0x0/0x10 returned 0 after 0 usecs
[    0.744592] calling  drbg_init+0x0/0x200 @ 1
[    0.745597] initcall drbg_init+0x0/0x200 returned 0 after 0 usecs
[    0.746592] calling  ghash_mod_init+0x0/0x10 @ 1
[    0.747317] initcall ghash_mod_init+0x0/0x10 returned 0 after 0 usecs
[    0.747592] calling  init_bio+0x0/0x90 @ 1
[    0.748608] initcall init_bio+0x0/0x90 returned 0 after 0 usecs
[    0.749592] calling  blk_ioc_init+0x0/0x30 @ 1
[    0.750592] initcall blk_ioc_init+0x0/0x30 returned 0 after 0 usecs
[    0.751593] calling  blk_mq_init+0x0/0x130 @ 1
[    0.752602] initcall blk_mq_init+0x0/0x130 returned 0 after 0 usecs
[    0.753592] calling  genhd_device_init+0x0/0x50 @ 1
[    0.754622] initcall genhd_device_init+0x0/0x50 returned 0 after 1000 usecs
[    0.755593] calling  io_wq_init+0x0/0x40 @ 1
[    0.756592] initcall io_wq_init+0x0/0x40 returned 0 after 0 usecs
[    0.757592] calling  sg_pool_init+0x0/0xe0 @ 1
[    0.758334] initcall sg_pool_init+0x0/0xe0 returned 0 after 0 usecs
[    0.758592] calling  pci_slot_init+0x0/0x50 @ 1
[    0.759464] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    0.759592] calling  acpi_init+0x0/0x510 @ 1
[    0.760440] ACPI: Added _OSI(Module Device)
[    0.760593] ACPI: Added _OSI(Processor Device)
[    0.761592] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.762592] ACPI: Added _OSI(Processor Aggregator Device)
[    0.764889] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.766625] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.767798] ACPI: Interpreter enabled
[    0.768602] ACPI: PM: (supports S0 S3 S4 S5)
[    0.769287] ACPI: Using IOAPIC for interrupt routing
[    0.769612] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.770592] PCI: Using E820 reservations for host bridge windows
[    0.771561] ACPI: Enabled 1 GPEs in block 00 to 3F
[    0.775687] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.776596] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.777646] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.778655] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[    0.779646] PCI host bridge to bus 0000:00
[    0.780593] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.781592] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.782592] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.783592] pci_bus 0000:00: root bus resource [mem 0x20000000-0xafffffff window]
[    0.784592] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.785593] pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff window]
[    0.786592] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.787622] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    0.788592] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    0.789592] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
[    0.790893] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x90 @ 1
[    0.791593] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x90 took 0 usecs
[    0.792753] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000 conventional PCI endpoint
[    0.796612] pci 0000:00:01.0: BAR 0 [mem 0xfd000000-0xfdffffff pref]
[    0.801612] pci 0000:00:01.0: BAR 2 [mem 0xfebf0000-0xfebf0fff]
[    0.809294] pci 0000:00:01.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.809662] pci 0000:00:01.0: calling  pci_fixup_video+0x0/0x110 @ 1
[    0.810621] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.811592] pci 0000:00:01.0: pci_fixup_video+0x0/0x110 took 976 usecs
[    0.813079] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
[    0.814003] pci 0000:00:1f.0: calling  quirk_ich7_lpc+0x0/0x60 @ 1
[    0.814615] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    0.815635] pci 0000:00:1f.0: quirk_ich7_lpc+0x0/0x60 took 976 usecs
[    0.816593] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x90 @ 1
[    0.817594] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x90 took 0 usecs
[    0.818796] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
[    0.823594] pci 0000:00:1f.2: BAR 4 [io  0xc040-0xc05f]
[    0.825347] pci 0000:00:1f.2: BAR 5 [mem 0xfebf1000-0xfebf1fff]
[    0.827057] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x90 @ 1
[    0.827593] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x90 took 0 usecs
[    0.829844] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
[    0.831876] pci 0000:00:1f.3: BAR 4 [io  0x0700-0x073f]
[    0.833112] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x90 @ 1
[    0.833593] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x90 took 0 usecs
[    0.835023] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.835648] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.836650] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.837644] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.838644] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
[    0.839645] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
[    0.840644] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.841643] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.842615] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
[    0.843600] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
[    0.844601] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
[    0.845600] ACPI: PCI: Interrupt link GSID configured for IRQ 19
[    0.846598] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
[    0.847598] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
[    0.848596] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
[    0.849597] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
[    0.852621] initcall acpi_init+0x0/0x510 returned 0 after 93000 usecs
[    0.853596] calling  pnp_init+0x0/0x10 @ 1
[    0.854232] initcall pnp_init+0x0/0x10 returned 0 after 0 usecs
[    0.854592] calling  misc_init+0x0/0xb0 @ 1
[    0.855603] initcall misc_init+0x0/0xb0 returned 0 after 0 usecs
[    0.856592] calling  iommu_subsys_init+0x0/0x160 @ 1
[    0.857592] iommu: Default domain type: Translated
[    0.858592] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.859592] initcall iommu_subsys_init+0x0/0x160 returned 0 after 2000 usecs
[    0.860592] calling  cn_init+0x0/0x100 @ 1
[    0.861620] initcall cn_init+0x0/0x100 returned 0 after 0 usecs
[    0.862592] calling  dma_buf_init+0x0/0xc0 @ 1
[    0.863339] initcall dma_buf_init+0x0/0xc0 returned 0 after 0 usecs
[    0.863592] calling  init_scsi+0x0/0x80 @ 1
[    0.864646] SCSI subsystem initialized
[    0.865592] initcall init_scsi+0x0/0x80 returned 0 after 1000 usecs
[    0.866592] calling  ata_init+0x0/0x420 @ 1
[    0.867695] libata version 3.00 loaded.
[    0.868230] initcall ata_init+0x0/0x420 returned 0 after 1000 usecs
[    0.868592] calling  phy_init+0x0/0x350 @ 1
[    0.869619] initcall phy_init+0x0/0x350 returned 0 after 0 usecs
[    0.870592] calling  init_pcmcia_cs+0x0/0x40 @ 1
[    0.871594] initcall init_pcmcia_cs+0x0/0x40 returned 0 after 0 usecs
[    0.872592] calling  usb_common_init+0x0/0x20 @ 1
[    0.873347] initcall usb_common_init+0x0/0x20 returned 0 after 0 usecs
[    0.873592] calling  usb_init+0x0/0x170 @ 1
[    0.874595] ACPI: bus type USB registered
[    0.875609] usbcore: registered new interface driver usbfs
[    0.876600] usbcore: registered new interface driver hub
[    0.877611] usbcore: registered new device driver usb
[    0.878415] initcall usb_init+0x0/0x170 returned 0 after 3000 usecs
[    0.878592] calling  serio_init+0x0/0x40 @ 1
[    0.879597] initcall serio_init+0x0/0x40 returned 0 after 0 usecs
[    0.880592] calling  input_init+0x0/0x110 @ 1
[    0.881597] initcall input_init+0x0/0x110 returned 0 after 0 usecs
[    0.882592] calling  rtc_init+0x0/0x50 @ 1
[    0.883239] initcall rtc_init+0x0/0x50 returned 0 after 0 usecs
[    0.883592] calling  pps_init+0x0/0xb0 @ 1
[    0.884594] pps_core: LinuxPPS API ver. 1 registered
[    0.885592] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.886592] initcall pps_init+0x0/0xb0 returned 0 after 2000 usecs
[    0.887592] calling  ptp_init+0x0/0xa0 @ 1
[    0.888594] PTP clock support registered
[    0.889211] initcall ptp_init+0x0/0xa0 returned 0 after 0 usecs
[    0.889592] calling  power_supply_class_init+0x0/0x40 @ 1
[    0.890599] initcall power_supply_class_init+0x0/0x40 returned 0 after 0 usecs
[    0.891592] calling  hwmon_init+0x0/0x100 @ 1
[    0.892595] initcall hwmon_init+0x0/0x100 returned 0 after 0 usecs
[    0.893592] calling  md_init+0x0/0x160 @ 1
[    0.894640] initcall md_init+0x0/0x160 returned 0 after 0 usecs
[    0.895592] calling  leds_init+0x0/0x10 @ 1
[    0.896255] initcall leds_init+0x0/0x10 returned 0 after 0 usecs
[    0.896592] calling  dmi_init+0x0/0x130 @ 1
[    0.897612] initcall dmi_init+0x0/0x130 returned 0 after 0 usecs
[    0.898592] calling  efisubsys_init+0x0/0x30 @ 1
[    0.899592] initcall efisubsys_init+0x0/0x30 returned 0 after 0 usecs
[    0.900592] calling  nvmem_init+0x0/0x10 @ 1
[    0.901276] initcall nvmem_init+0x0/0x10 returned 0 after 0 usecs
[    0.901592] calling  init_soundcore+0x0/0x10 @ 1
[    0.902594] initcall init_soundcore+0x0/0x10 returned 0 after 0 usecs
[    0.903592] calling  alsa_sound_init+0x0/0xa0 @ 1
[    0.904601] Advanced Linux Sound Architecture Driver Initialized.
[    0.905592] initcall alsa_sound_init+0x0/0xa0 returned 0 after 1000 usecs
[    0.906592] calling  alsa_seq_device_init+0x0/0x80 @ 1
[    0.907599] initcall alsa_seq_device_init+0x0/0x80 returned 0 after 0 usecs
[    0.908592] calling  hda_bus_init+0x0/0x10 @ 1
[    0.909596] initcall hda_bus_init+0x0/0x10 returned 0 after 0 usecs
[    0.910592] calling  proto_init+0x0/0x10 @ 1
[    0.911366] initcall proto_init+0x0/0x10 returned 0 after 0 usecs
[    0.911592] calling  net_dev_init+0x0/0x270 @ 1
[    0.912728] initcall net_dev_init+0x0/0x270 returned 0 after 0 usecs
[    0.913592] calling  neigh_init+0x0/0x90 @ 1
[    0.914594] initcall neigh_init+0x0/0x90 returned 0 after 0 usecs
[    0.915592] calling  fib_notifier_init+0x0/0x10 @ 1
[    0.916595] initcall fib_notifier_init+0x0/0x10 returned 0 after 0 usecs
[    0.917594] calling  netdev_genl_init+0x0/0x40 @ 1
[    0.918613] initcall netdev_genl_init+0x0/0x40 returned 0 after 0 usecs
[    0.919592] calling  fib_rules_init+0x0/0xc0 @ 1
[    0.920596] initcall fib_rules_init+0x0/0xc0 returned 0 after 0 usecs
[    0.921592] calling  init_cgroup_netprio+0x0/0x20 @ 1
[    0.922594] initcall init_cgroup_netprio+0x0/0x20 returned 0 after 0 usecs
[    0.923592] calling  pktsched_init+0x0/0x140 @ 1
[    0.924597] initcall pktsched_init+0x0/0x140 returned 0 after 0 usecs
[    0.925592] calling  tc_filter_init+0x0/0x110 @ 1
[    0.926605] initcall tc_filter_init+0x0/0x110 returned 0 after 0 usecs
[    0.927592] calling  tc_action_init+0x0/0x60 @ 1
[    0.928592] initcall tc_action_init+0x0/0x60 returned 0 after 0 usecs
[    0.929592] calling  ethnl_init+0x0/0x70 @ 1
[    0.930301] initcall ethnl_init+0x0/0x70 returned 0 after 0 usecs
[    0.930592] calling  nexthop_init+0x0/0x100 @ 1
[    0.931599] initcall nexthop_init+0x0/0x100 returned 0 after 0 usecs
[    0.932592] calling  cipso_v4_init+0x0/0x70 @ 1
[    0.933592] initcall cipso_v4_init+0x0/0x70 returned 0 after 0 usecs
[    0.934592] calling  ieee80211_init+0x0/0x70 @ 1
[    0.935611] initcall ieee80211_init+0x0/0x70 returned 0 after 0 usecs
[    0.936592] calling  netlbl_init+0x0/0x80 @ 1
[    0.937592] NetLabel: Initializing
[    0.938188] NetLabel:  domain hash size = 128
[    0.938592] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.939613] NetLabel:  unlabeled traffic allowed by default
[    0.940591] initcall netlbl_init+0x0/0x80 returned 0 after 3000 usecs
[    0.941592] calling  rfkill_init+0x0/0x140 @ 1
[    0.942658] initcall rfkill_init+0x0/0x140 returned 0 after 0 usecs
[    0.943593] calling  pci_subsys_init+0x0/0x90 @ 1
[    0.944592] PCI: Using ACPI for IRQ routing
[    1.003163] PCI: pci_cache_line_size set to 64 bytes
[    1.003673] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.004592] e820: reserve RAM buffer [mem 0x1ffde000-0x1fffffff]
[    1.005592] initcall pci_subsys_init+0x0/0x90 returned 0 after 61000 usecs
[    1.006592] calling  vsprintf_init_hashval+0x0/0x20 @ 1
[    1.007592] initcall vsprintf_init_hashval+0x0/0x20 returned 0 after 0 usecs
[    1.008592] calling  efi_runtime_map_init+0x0/0x260 @ 1
[    1.009592] initcall efi_runtime_map_init+0x0/0x260 returned 0 after 0 usecs
[    1.010592] calling  vga_arb_device_init+0x0/0xa0 @ 1
[    1.011611] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    1.012591] pci 0000:00:01.0: vgaarb: bridge control possible
[    1.012591] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.012594] vgaarb: loaded
[    1.013023] initcall vga_arb_device_init+0x0/0xa0 returned 0 after 1000 usecs
[    1.014592] calling  acpi_wmi_init+0x0/0x90 @ 1
[    1.015346] initcall acpi_wmi_init+0x0/0x90 returned 0 after 0 usecs
[    1.015698] calling  nmi_warning_debugfs+0x0/0x30 @ 1
[    1.016597] initcall nmi_warning_debugfs+0x0/0x30 returned 0 after 0 usecs
[    1.017592] calling  hpet_late_init+0x0/0x420 @ 1
[    1.018607] hpet: 3 channels of 0 reserved for per-cpu timers
[    1.019609] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.020591] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.025592] initcall hpet_late_init+0x0/0x420 returned 0 after 7000 usecs
[    1.026592] calling  init_amd_nbs+0x0/0x420 @ 1
[    1.027594] initcall init_amd_nbs+0x0/0x420 returned 0 after 0 usecs
[    1.028591] calling  iomem_init_inode+0x0/0x90 @ 1
[    1.029594] initcall iomem_init_inode+0x0/0x90 returned 0 after 1000 usecs
[    1.030591] calling  clocksource_done_booting+0x0/0x50 @ 1
[    1.031463] clocksource: Switched to clocksource kvm-clock
[    1.031494] initcall clocksource_done_booting+0x0/0x50 returned 0 after 903 usecs
[    1.032642] calling  tracer_init_tracefs+0x0/0xd0 @ 1
[    1.033410] initcall tracer_init_tracefs+0x0/0xd0 returned 0 after 16 usecs
[    1.034410] calling  init_trace_printk_function_export+0x0/0x30 @ 1
[    1.035931] initcall init_trace_printk_function_export+0x0/0x30 returned 0 after 615 usecs
[    1.037182] calling  init_kprobe_trace+0x0/0x1b0 @ 1
[    1.037892] initcall init_kprobe_trace+0x0/0x1b0 returned 0 after 1 usecs
[    1.038859] calling  init_dynamic_event+0x0/0x30 @ 1
[    1.039573] initcall init_dynamic_event+0x0/0x30 returned 0 after 0 usecs
[    1.040542] calling  init_uprobe_trace+0x0/0x70 @ 1
[    1.041244] initcall init_uprobe_trace+0x0/0x70 returned 0 after 4 usecs
[    1.042223] calling  secretmem_init+0x0/0x50 @ 1
[    1.043025] initcall secretmem_init+0x0/0x50 returned 0 after 18 usecs
[    1.044182] calling  init_fs_stat_sysctls+0x0/0x40 @ 1
[    1.045068] initcall init_fs_stat_sysctls+0x0/0x40 returned 0 after 4 usecs
[    1.046227] calling  init_fs_exec_sysctls+0x0/0x30 @ 1
[    1.047090] initcall init_fs_exec_sysctls+0x0/0x30 returned 0 after 0 usecs
[    1.048249] calling  init_pipe_fs+0x0/0x70 @ 1
[    1.049101] initcall init_pipe_fs+0x0/0x70 returned 0 after 18 usecs
[    1.050253] calling  init_fs_namei_sysctls+0x0/0x30 @ 1
[    1.051156] initcall init_fs_namei_sysctls+0x0/0x30 returned 0 after 1 usecs
[    1.052329] calling  init_fs_dcache_sysctls+0x0/0x30 @ 1
[    1.053291] initcall init_fs_dcache_sysctls+0x0/0x30 returned 0 after 0 usecs
[    1.054517] calling  init_fs_namespace_sysctls+0x0/0x30 @ 1
[    1.055528] initcall init_fs_namespace_sysctls+0x0/0x30 returned 0 after 1 usecs
[    1.056848] calling  inotify_user_setup+0x0/0x100 @ 1
[    1.057778] initcall inotify_user_setup+0x0/0x100 returned 0 after 9 usecs
[    1.058921] calling  eventpoll_init+0x0/0x110 @ 1
[    1.059713] initcall eventpoll_init+0x0/0x110 returned 0 after 1 usecs
[    1.060799] calling  anon_inode_init+0x0/0x60 @ 1
[    1.061607] initcall anon_inode_init+0x0/0x60 returned 0 after 10 usecs
[    1.062713] calling  proc_locks_init+0x0/0x30 @ 1
[    1.063501] initcall proc_locks_init+0x0/0x30 returned 0 after 1 usecs
[    1.064596] calling  init_fs_coredump_sysctls+0x0/0x30 @ 1
[    1.065533] initcall init_fs_coredump_sysctls+0x0/0x30 returned 0 after 2 usecs
[    1.066814] calling  iomap_init+0x0/0x20 @ 1
[    1.067580] initcall iomap_init+0x0/0x20 returned 0 after 21 usecs
[    1.068534] calling  dquot_init+0x0/0x160 @ 1
[    1.069225] VFS: Disk quotas dquot_6.6.0
[    1.069934] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.071060] initcall dquot_init+0x0/0x160 returned 0 after 1835 usecs
[    1.072036] calling  quota_init+0x0/0x30 @ 1
[    1.072695] initcall quota_init+0x0/0x30 returned 0 after 6 usecs
[    1.073619] calling  proc_cmdline_init+0x0/0x40 @ 1
[    1.074435] initcall proc_cmdline_init+0x0/0x40 returned 0 after 1 usecs
[    1.075539] calling  proc_consoles_init+0x0/0x30 @ 1
[    1.076349] initcall proc_consoles_init+0x0/0x30 returned 0 after 0 usecs
[    1.077379] calling  proc_cpuinfo_init+0x0/0x30 @ 1
[    1.078126] initcall proc_cpuinfo_init+0x0/0x30 returned 0 after 0 usecs
[    1.079141] calling  proc_devices_init+0x0/0x30 @ 1
[    1.079955] initcall proc_devices_init+0x0/0x30 returned 0 after 0 usecs
[    1.081095] calling  proc_interrupts_init+0x0/0x30 @ 1
[    1.081941] initcall proc_interrupts_init+0x0/0x30 returned 0 after 0 usecs
[    1.082992] calling  proc_loadavg_init+0x0/0x30 @ 1
[    1.083769] initcall proc_loadavg_init+0x0/0x30 returned 0 after 0 usecs
[    1.084882] calling  proc_meminfo_init+0x0/0x30 @ 1
[    1.085710] initcall proc_meminfo_init+0x0/0x30 returned 0 after 0 usecs
[    1.086848] calling  proc_stat_init+0x0/0x30 @ 1
[    1.087557] initcall proc_stat_init+0x0/0x30 returned 0 after 0 usecs
[    1.088531] calling  proc_uptime_init+0x0/0x30 @ 1
[    1.089256] initcall proc_uptime_init+0x0/0x30 returned 0 after 0 usecs
[    1.090257] calling  proc_version_init+0x0/0x30 @ 1
[    1.091000] initcall proc_version_init+0x0/0x30 returned 0 after 0 usecs
[    1.092013] calling  proc_softirqs_init+0x0/0x30 @ 1
[    1.092768] initcall proc_softirqs_init+0x0/0x30 returned 0 after 0 usecs
[    1.093792] calling  proc_kcore_init+0x0/0x180 @ 1
[    1.094533] initcall proc_kcore_init+0x0/0x180 returned 0 after 7 usecs
[    1.095530] calling  vmcore_init+0x0/0x6e0 @ 1
[    1.096249] initcall vmcore_init+0x0/0x6e0 returned 0 after 0 usecs
[    1.097246] calling  proc_kmsg_init+0x0/0x30 @ 1
[    1.097948] initcall proc_kmsg_init+0x0/0x30 returned 0 after 0 usecs
[    1.098903] calling  proc_page_init+0x0/0x40 @ 1
[    1.099590] initcall proc_page_init+0x0/0x40 returned 0 after 1 usecs
[    1.100568] calling  netfs_init+0x0/0x70 @ 1
[    1.101217] initcall netfs_init+0x0/0x70 returned 0 after 1 usecs
[    1.102160] calling  init_ramfs_fs+0x0/0x10 @ 1
[    1.102849] initcall init_ramfs_fs+0x0/0x10 returned 0 after 1 usecs
[    1.103809] calling  init_hugetlbfs_fs+0x0/0x140 @ 1
[    1.104669] initcall init_hugetlbfs_fs+0x0/0x140 returned 0 after 36 usecs
[    1.105816] calling  acpi_event_init+0x0/0x40 @ 1
[    1.106631] initcall acpi_event_init+0x0/0x40 returned 0 after 4 usecs
[    1.107659] calling  pnp_system_init+0x0/0x10 @ 1
[    1.108462] initcall pnp_system_init+0x0/0x10 returned 0 after 14 usecs
[    1.109625] calling  pnpacpi_init+0x0/0x80 @ 1
[    1.110370] pnp: PnP ACPI init
[    1.111246] pnp: PnP ACPI: found 5 devices
[    1.111912] initcall pnpacpi_init+0x0/0x80 returned 0 after 1541 usecs
[    1.112960] calling  chr_dev_init+0x0/0xa0 @ 1
[    1.115932] initcall chr_dev_init+0x0/0xa0 returned 0 after 2214 usecs
[    1.117003] calling  hwrng_modinit+0x0/0xb0 @ 1
[    1.117729] initcall hwrng_modinit+0x0/0xb0 returned 0 after 37 usecs
[    1.118748] calling  firmware_class_init+0x0/0xf0 @ 1
[    1.119524] initcall firmware_class_init+0x0/0xf0 returned 0 after 4 usecs
[    1.120642] calling  init_pcmcia_bus+0x0/0x70 @ 1
[    1.121464] initcall init_pcmcia_bus+0x0/0x70 returned 0 after 8 usecs
[    1.122557] calling  init_acpi_pm_clocksource+0x0/0x110 @ 1
[    1.128052] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.129502] initcall init_acpi_pm_clocksource+0x0/0x110 returned 0 after 6028 usecs
[    1.130793] calling  p2sb_fs_init+0x0/0x150 @ 1
[    1.131602] initcall p2sb_fs_init+0x0/0x150 returned 0 after 44 usecs
[    1.132661] calling  sysctl_core_init+0x0/0x30 @ 1
[    1.133506] initcall sysctl_core_init+0x0/0x30 returned 0 after 22 usecs
[    1.134573] calling  eth_offload_init+0x0/0x20 @ 1
[    1.135303] initcall eth_offload_init+0x0/0x20 returned 0 after 2 usecs
[    1.136307] calling  ipv4_offload_init+0x0/0xa0 @ 1
[    1.137172] initcall ipv4_offload_init+0x0/0xa0 returned 0 after 2 usecs
[    1.138228] calling  inet_init+0x0/0x300 @ 1
[    1.138915] NET: Registered PF_INET protocol family
[    1.139708] IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    1.141106] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    1.142377] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.143587] TCP established hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    1.144732] TCP bind hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    1.145775] TCP: Hash tables configured (established 4096 bind 4096)
[    1.146738] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    1.147673] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    1.148726] initcall inet_init+0x0/0x300 returned 0 after 9847 usecs
[    1.149639] calling  af_unix_init+0x0/0xc0 @ 1
[    1.150315] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.151181] initcall af_unix_init+0x0/0xc0 returned 0 after 866 usecs
[    1.152159] calling  ipv6_offload_init+0x0/0x90 @ 1
[    1.153059] initcall ipv6_offload_init+0x0/0x90 returned 0 after 3 usecs
[    1.154257] calling  init_sunrpc+0x0/0x90 @ 1
[    1.155247] RPC: Registered named UNIX socket transport module.
[    1.156283] RPC: Registered udp transport module.
[    1.157089] RPC: Registered tcp transport module.
[    1.157902] RPC: Registered tcp-with-tls transport module.
[    1.158840] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.159942] initcall init_sunrpc+0x0/0x90 returned 0 after 4950 usecs
[    1.161021] calling  cfg80211_init+0x0/0xe0 @ 1
[    1.162086] initcall cfg80211_init+0x0/0xe0 returned 0 after 306 usecs
[    1.163088] calling  pcibios_assign_resources+0x0/0xe0 @ 1
[    1.164000] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.165021] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.165955] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.167102] pci_bus 0000:00: resource 7 [mem 0x20000000-0xafffffff window]
[    1.168274] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
[    1.169377] pci_bus 0000:00: resource 9 [mem 0x100000000-0x8ffffffff window]
[    1.169577] kwatchdog (92) used greatest stack depth: 15128 bytes left
[    1.170520] initcall pcibios_assign_resources+0x0/0xe0 returned 0 after 6538 usecs
[    1.172752] calling  pci_apply_final_quirks+0x0/0x160 @ 1
[    1.173713] PCI: CLS 0 bytes, default 64
[    1.174391] initcall pci_apply_final_quirks+0x0/0x160 returned 0 after 731 usecs
[    1.175664] calling  acpi_reserve_resources+0x0/0x110 @ 1
[    1.176633] initcall acpi_reserve_resources+0x0/0x110 returned 0 after 1 usecs
[    1.177919] calling  populate_rootfs+0x0/0x50 @ 1
[    1.179154] initcall populate_rootfs+0x0/0x50 returned 0 after 515 usecs
[    1.180283] calling  pci_iommu_init+0x0/0x40 @ 1
[    1.181105] initcall pci_iommu_init+0x0/0x40 returned 0 after 2 usecs
[    1.182235] calling  ia32_binfmt_init+0x0/0x30 @ 1
[    1.183031] initcall ia32_binfmt_init+0x0/0x30 returned 0 after 1 usecs
[    1.184137] calling  rapl_pmu_init+0x0/0x280 @ 1
[    1.184930] initcall rapl_pmu_init+0x0/0x280 returned -19 after 0 usecs
[    1.186021] calling  amd_ibs_init+0x0/0x320 @ 1
[    1.186754] initcall amd_ibs_init+0x0/0x320 returned -19 after 0 usecs
[    1.187843] calling  amd_uncore_init+0x0/0x1a0 @ 1
[    1.188581] initcall amd_uncore_init+0x0/0x1a0 returned -19 after 0 usecs
[    1.189613] calling  amd_iommu_pc_init+0x0/0x280 @ 1
[    1.190374] initcall amd_iommu_pc_init+0x0/0x280 returned -19 after 2 usecs
[    1.191527] calling  msr_init+0x0/0x60 @ 1
[    1.192237] initcall msr_init+0x0/0x60 returned 0 after 18 usecs
[    1.193271] calling  intel_uncore_init+0x0/0x5e0 @ 1
[    1.194077] initcall intel_uncore_init+0x0/0x5e0 returned -19 after 0 usecs
[    1.195212] calling  cstate_pmu_init+0x0/0x290 @ 1
[    1.196028] initcall cstate_pmu_init+0x0/0x290 returned -19 after 0 usecs
[    1.197169] calling  register_kernel_offset_dumper+0x0/0x20 @ 1
[    1.198166] initcall register_kernel_offset_dumper+0x0/0x20 returned 0 after 0 usecs
[    1.199459] calling  i8259A_init_ops+0x0/0x30 @ 1
[    1.200260] initcall i8259A_init_ops+0x0/0x30 returned 0 after 0 usecs
[    1.201353] calling  init_tsc_clocksource+0x0/0xd0 @ 1
[    1.202214] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3985bbcfaa7, max_idle_ns: 881590561327 ns
[    1.203877] initcall init_tsc_clocksource+0x0/0xd0 returned 0 after 1664 usecs
[    1.205071] calling  add_rtc_cmos+0x0/0xc0 @ 1
[    1.205783] initcall add_rtc_cmos+0x0/0xc0 returned 0 after 0 usecs
[    1.206853] calling  i8237A_init_ops+0x0/0x40 @ 1
[    1.207655] initcall i8237A_init_ops+0x0/0x40 returned 0 after 7 usecs
[    1.208749] calling  umwait_init+0x0/0xc0 @ 1
[    1.209513] initcall umwait_init+0x0/0xc0 returned -19 after 0 usecs
[    1.210548] calling  msr_init+0x0/0xe0 @ 1
[    1.212272] initcall msr_init+0x0/0xe0 returned 0 after 1003 usecs
[    1.213320] calling  cpuid_init+0x0/0xe0 @ 1
[    1.214762] initcall cpuid_init+0x0/0xe0 returned 0 after 719 usecs
[    1.215821] calling  ioapic_init_ops+0x0/0x20 @ 1
[    1.216615] initcall ioapic_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.217771] calling  add_pcspkr+0x0/0x80 @ 1
[    1.218518] initcall add_pcspkr+0x0/0x80 returned 0 after 13 usecs
[    1.219552] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    1.220640] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 0 usecs
[    1.222016] calling  audit_classes_init+0x0/0xc0 @ 1
[    1.222849] initcall audit_classes_init+0x0/0xc0 returned 0 after 1 usecs
[    1.223982] calling  pt_dump_init+0x0/0x50 @ 1
[    1.224741] initcall pt_dump_init+0x0/0x50 returned 0 after 0 usecs
[    1.225694] calling  iosf_mbi_init+0x0/0x30 @ 1
[    1.226394] initcall iosf_mbi_init+0x0/0x30 returned 0 after 8 usecs
[    1.227385] calling  proc_execdomains_init+0x0/0x30 @ 1
[    1.228283] initcall proc_execdomains_init+0x0/0x30 returned 0 after 2 usecs
[    1.229414] calling  register_warn_debugfs+0x0/0x30 @ 1
[    1.230296] initcall register_warn_debugfs+0x0/0x30 returned 0 after 3 usecs
[    1.231473] calling  cpuhp_sysfs_init+0x0/0x100 @ 1
[    1.232378] initcall cpuhp_sysfs_init+0x0/0x100 returned 0 after 78 usecs
[    1.233520] calling  ioresources_init+0x0/0x50 @ 1
[    1.234275] initcall ioresources_init+0x0/0x50 returned 0 after 1 usecs
[    1.235380] calling  snapshot_device_init+0x0/0x10 @ 1
[    1.236315] initcall snapshot_device_init+0x0/0x10 returned 0 after 70 usecs
[    1.237504] calling  irq_pm_init_ops+0x0/0x20 @ 1
[    1.238294] initcall irq_pm_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.239322] calling  rcu_torture_init+0x0/0x1b40 @ 1
[    1.240088] torture module --- rcu:  disable_onoff_at_boot=0 ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 verbose_sleep_duration=1 random_shuffle=0
[    1.242440] rcu-torture:--- Start of test: nreaders=7 nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=60 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=1000 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=8 nocbs_toggle=1000 test_nmis=0
[    1.249266] rcu:  Start-test grace-period state: g-1132 f0x0
[    1.250228] rcu_torture_write_types: Testing conditional GPs.
[    1.251188] rcu_torture_write_types: Testing conditional expedited GPs.
[    1.252332] rcu_torture_write_types: Testing conditional full-state GPs.
[    1.253348] rcu_torture_write_types: Testing expedited GPs.
[    1.254243] rcu_torture_write_types: Testing asynchronous GPs.
[    1.255255] rcu_torture_write_types: Testing polling GPs.
[    1.256169] rcu_torture_write_types: Testing polling full-state GPs.
[    1.257358] rcu_torture_write_types: Testing polling expedited GPs.
[    1.258459] rcu_torture_write_types: Testing polling full-state expedited GPs.
[    1.259657] rcu_torture_write_types: Testing normal GPs.
[    1.260552] rcu-torture: Creating rcu_torture_writer task
[    1.261552] rcu-torture: Creating rcu_torture_fakewriter task
[    1.261576] rcu-torture: rcu_torture_writer task started
[    1.262589] rcu-torture: Creating rcu_torture_fakewriter task
[    1.262610] rcu-torture: rcu_torture_fakewriter task started
[    1.263378] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    1.266709] rcu-torture: Creating rcu_torture_fakewriter task
[    1.266723] rcu-torture: rcu_torture_fakewriter task started
[    1.267745] rcu-torture: Creating rcu_torture_fakewriter task
[    1.267758] rcu-torture: rcu_torture_fakewriter task started
[    1.270570] rcu-torture: Creating rcu_torture_reader task
[    1.270586] rcu-torture: rcu_torture_fakewriter task started
[    1.271507] rcu-torture: Creating rcu_torture_reader task
[    1.271529] rcu-torture: rcu_torture_reader task started
[    1.274428] rcu-torture: Creating rcu_torture_reader task
[    1.274435] rcu-torture: rcu_torture_reader task started
[    1.275442] rcu-torture: Creating rcu_torture_reader task
[    1.275450] rcu-torture: rcu_torture_reader task started
[    1.278810] rcu-torture: Creating rcu_torture_reader task
[    1.278821] rcu-torture: rcu_torture_reader task started
[    1.280057] rcu-torture: Creating rcu_torture_reader task
[    1.280066] rcu-torture: rcu_torture_reader task started
[    1.283437] rcu-torture: Creating rcu_torture_reader task
[    1.283451] rcu-torture: rcu_torture_reader task started
[    1.284658] rcu-torture: Creating rcu_nocb_toggle task
[    1.284667] rcu-torture: rcu_torture_reader task started
[    1.287866] rcu-torture: Creating rcu_nocb_toggle task
[    1.288980] rcu-torture: rcu_nocb_toggle task started
[    1.290115] rcu-torture: Creating rcu_nocb_toggle task
[    1.291204] rcu-torture: rcu_nocb_toggle task started
[    1.292316] rcu-torture: Creating rcu_nocb_toggle task
[    1.292437] rcu-torture: rcu_nocb_toggle task started
[    1.295340] rcu-torture: Creating rcu_nocb_toggle task
[    1.295343] rcu-torture: rcu_nocb_toggle task started
[    1.296519] rcu-torture: Creating rcu_nocb_toggle task
[    1.296531] rcu-torture: rcu_nocb_toggle task started
[    1.299621] rcu-torture: Creating rcu_nocb_toggle task
[    1.299637] rcu-torture: rcu_nocb_toggle task started
[    1.301843] rcu-torture: Creating rcu_nocb_toggle task
[    1.303013] rcu-torture: Creating rcu_torture_stats task
[    1.303025] rcu-torture: rcu_nocb_toggle task started
[    1.304192] rcu-torture: rcu_nocb_toggle task started
[    1.304238] rcu-torture: Creating torture_shuffle task
[    1.304242] rcu-torture: rcu_torture_stats task started
[    1.304273] rcu-torture: Creating torture_stutter task
[    1.304762] rcu-torture: Creating torture_shutdown task
[    1.304765] rcu-torture: torture_stutter task started
[    1.304801] rcu-torture: Creating torture_onoff task
[    1.304803] rcu-torture: torture_shutdown task started
[    1.304805] rcu-torture:torture_shutdown task: 59999 ms remaining
[    1.304822] rcu-torture: torture_shuffle task started
[    1.304839] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.304843] rcu-torture: torture_onoff task started
[    1.305122] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.305132] rcu-torture: rcu_torture_barrier_cbs task started
[    1.318197] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.318200] rcu-torture: rcu_torture_barrier_cbs task started
[    1.319414] rcu-torture: Creating rcu_torture_barrier_cbs task
[    1.319416] rcu-torture: rcu_torture_barrier_cbs task started
[    1.322625] rcu-torture: Creating rcu_torture_barrier task
[    1.322635] rcu-torture: rcu_torture_barrier_cbs task started
[    1.323700] rcu-torture: Creating rcu_torture_read_exit task
[    1.323712] rcu-torture: rcu_torture_barrier task starting
[    1.327003] initcall rcu_torture_init+0x0/0x1b40 returned 0 after 86918 usecs
[    1.327014] rcu-torture: rcu_torture_read_exit: Start of test
[    1.328314] calling  proc_modules_init+0x0/0x30 @ 1
[    1.328328]   #8
[    1.329198] rcu-torture: rcu_torture_read_exit: Start of episode
[    1.330063] initcall proc_modules_init+0x0/0x30 returned 0 after 6 usecs
[    1.332507] calling  timer_sysctl_init+0x0/0x30 @ 1
[    1.333358] initcall timer_sysctl_init+0x0/0x30 returned 0 after 3 usecs
[    1.334527] calling  timekeeping_init_ops+0x0/0x20 @ 1
[    1.335413] initcall timekeeping_init_ops+0x0/0x20 returned 0 after 0 usecs
[    1.336587] calling  init_clocksource_sysfs+0x0/0x30 @ 1
[    1.337476] initcall init_clocksource_sysfs+0x0/0x30 returned 0 after 33 usecs
[    1.338626] calling  init_timer_list_procfs+0x0/0x40 @ 1
[    1.339508] initcall init_timer_list_procfs+0x0/0x40 returned 0 after 11 usecs
[    0.119986] smpboot: CPU 8 Converting physical 0 to logical die 8
[    1.340683] calling  alarmtimer_init+0x0/0xf0 @ 1
[    1.342735] initcall alarmtimer_init+0x0/0xf0 returned 0 after 126 usecs
[    1.363889] calling  init_posix_timers+0x0/0x30 @ 1
[    1.364721] initcall init_posix_timers+0x0/0x30 returned 0 after 1 usecs
[    1.365841] calling  clockevents_init_sysfs+0x0/0xe0 @ 1
[    1.366953] initcall clockevents_init_sysfs+0x0/0xe0 returned 0 after 265 usecs
[    1.368047] calling  proc_dma_init+0x0/0x30 @ 1
[    1.368770] initcall proc_dma_init+0x0/0x30 returned 0 after 1 usecs
[    1.369925] calling  kallsyms_init+0x0/0x30 @ 1
[    1.370797] initcall kallsyms_init+0x0/0x30 returned 0 after 1 usecs
[    1.371813] calling  pid_namespaces_init+0x0/0x50 @ 1
[    1.372666] initcall pid_namespaces_init+0x0/0x50 returned 0 after 5 usecs
[    1.373754] calling  audit_watch_init+0x0/0x50 @ 1
[    1.374522] initcall audit_watch_init+0x0/0x50 returned 0 after 3 usecs
[    1.375567] calling  audit_fsnotify_init+0x0/0x50 @ 1
[    1.376440]   #9
[    1.376441] initcall audit_fsnotify_init+0x0/0x50 returned 0 after 0 usecs
[    1.377825] calling  audit_tree_init+0x0/0x80 @ 1
[    1.378599] initcall audit_tree_init+0x0/0x80 returned 0 after 6 usecs
[    1.379595] calling  seccomp_sysctl_init+0x0/0x30 @ 1
[    1.380372] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 4 usecs
[    1.381412] calling  utsname_sysctl_init+0x0/0x30 @ 1
[    1.382225] initcall utsname_sysctl_init+0x0/0x30 returned 0 after 3 usecs
[    1.383387] calling  init_tracepoints+0x0/0x40 @ 1
[    1.384178] initcall init_tracepoints+0x0/0x40 returned 0 after 0 usecs
[    1.385213] calling  init_blk_tracer+0x0/0x70 @ 1
[    1.386039] initcall init_blk_tracer+0x0/0x70 returned 0 after 12 usecs
[    1.387075] calling  perf_event_sysfs_init+0x0/0xa0 @ 1
[    0.119986] smpboot: CPU 9 Converting physical 0 to logical die 9
[    1.387932] initcall perf_event_sysfs_init+0x0/0xa0 returned 0 after 53 usecs
[    1.390409] calling  system_trusted_keyring_init+0x0/0x70 @ 1
[    1.411304] Initialise system trusted keyrings
[    1.412128] initcall system_trusted_keyring_init+0x0/0x70 returned 0 after 827 usecs
[    1.413354] calling  kswapd_init+0x0/0x70 @ 1
[    1.414182] initcall kswapd_init+0x0/0x70 returned 0 after 52 usecs
[    1.415215] calling  extfrag_debug_init+0x0/0x60 @ 1
[    1.416041] initcall extfrag_debug_init+0x0/0x60 returned 0 after 5 usecs
[    1.417109] calling  mm_compute_batch_init+0x0/0x20 @ 1
[    1.417925] initcall mm_compute_batch_init+0x0/0x20 returned 0 after 0 usecs
[    1.419041] calling  slab_proc_init+0x0/0x30 @ 1
[    1.419791] initcall slab_proc_init+0x0/0x30 returned 0 after 1 usecs
[    1.420861] calling  workingset_init+0x0/0xc0 @ 1
[    1.421654] workingset: timestamp_bits=52 max_order=17 bucket_order=0
[    1.422661] initcall workingset_init+0x0/0xc0 returned 0 after 1007 usecs
[    1.423795]  #10
[    1.423796] calling  proc_vmalloc_init+0x0/0x40 @ 1
[    1.424878] initcall proc_vmalloc_init+0x0/0x40 returned 0 after 1 usecs
[    1.425898] calling  slab_debugfs_init+0x0/0x70 @ 1
[    1.426649] initcall slab_debugfs_init+0x0/0x70 returned 0 after 5 usecs
[    1.427627] calling  procswaps_init+0x0/0x30 @ 1
[    1.428290] initcall procswaps_init+0x0/0x30 returned 0 after 1 usecs
[    1.429267] calling  fcntl_init+0x0/0x30 @ 1
[    1.429922] initcall fcntl_init+0x0/0x30 returned 0 after 0 usecs
[    1.430846] calling  proc_filesystems_init+0x0/0x30 @ 1
[    1.431648] initcall proc_filesystems_init+0x0/0x30 returned 0 after 0 usecs
[    1.432740] calling  start_dirtytime_writeback+0x0/0x30 @ 1
[    1.433614] initcall start_dirtytime_writeback+0x0/0x30 returned 0 after 0 usecs
[    1.434840] calling  dio_init+0x0/0x30 @ 1
[    0.119986] smpboot: CPU 10 Converting physical 0 to logical die 10
[    1.435475] initcall dio_init+0x0/0x30 returned 0 after 0 usecs
[    1.437617] calling  dnotify_init+0x0/0xa0 @ 1
[    1.458324] initcall dnotify_init+0x0/0xa0 returned 0 after 5 usecs
[    1.459515] calling  aio_setup+0x0/0xa0 @ 1
[    1.460284] initcall aio_setup+0x0/0xa0 returned 0 after 36 usecs
[    1.461382] calling  mbcache_init+0x0/0x40 @ 1
[    1.462203] initcall mbcache_init+0x0/0x40 returned 0 after 14 usecs
[    1.463314] calling  init_grace+0x0/0x10 @ 1
[    1.464069] initcall init_grace+0x0/0x10 returned 0 after 1 usecs
[    1.465246] calling  init_v2_quota_format+0x0/0x30 @ 1
[    1.466204] initcall init_v2_quota_format+0x0/0x30 returned 0 after 3 usecs
[    1.467298] calling  init_devpts_fs+0x0/0x40 @ 1
[    1.468031] initcall init_devpts_fs+0x0/0x40 returned 0 after 5 usecs
[    1.469415] calling  ext4_init_fs+0x0/0x1f0 @ 1
[    1.470332]  #11
[    1.470426] initcall ext4_init_fs+0x0/0x1f0 returned 0 after 92 usecs
[    1.471946] calling  journal_init+0x0/0x150 @ 1
[    1.472746] initcall journal_init+0x0/0x150 returned 0 after 13 usecs
[    1.473772] calling  init_fat_fs+0x0/0x50 @ 1
[    1.474475] initcall init_fat_fs+0x0/0x50 returned 0 after 19 usecs
[    1.475424] calling  init_vfat_fs+0x0/0x10 @ 1
[    1.476091] initcall init_vfat_fs+0x0/0x10 returned 0 after 0 usecs
[    1.477062] calling  init_msdos_fs+0x0/0x10 @ 1
[    1.477769] initcall init_msdos_fs+0x0/0x10 returned 0 after 0 usecs
[    1.478780] calling  init_iso9660_fs+0x0/0x90 @ 1
[    1.479542] initcall init_iso9660_fs+0x0/0x90 returned 0 after 14 usecs
[    1.480707] calling  init_nfs_fs+0x0/0x160 @ 1
[    0.119986] smpboot: CPU 11 Converting physical 0 to logical die 11
[    1.504533] initcall init_nfs_fs+0x0/0x160 returned 0 after 22880 usecs
[    1.505752] calling  init_nfs_v2+0x0/0x20 @ 1
[    1.506522] initcall init_nfs_v2+0x0/0x20 returned 0 after 2 usecs
[    1.507607] calling  init_nfs_v3+0x0/0x20 @ 1
[    1.508388] initcall init_nfs_v3+0x0/0x20 returned 0 after 0 usecs
[    1.509458] calling  init_nfs_v4+0x0/0x60 @ 1
[    1.510323] NFS: Registering the id_resolver key type
[    1.511265] Key type id_resolver registered
[    1.512032] Key type id_legacy registered
[    1.512768]  #12
[    1.512771] initcall init_nfs_v4+0x0/0x60 returned 0 after 2451 usecs
[    1.514212] calling  init_nlm+0x0/0x70 @ 1
[    1.514906] initcall init_nlm+0x0/0x70 returned 0 after 7 usecs
[    1.515926] calling  init_nls_cp437+0x0/0x20 @ 1
[    1.516743] initcall init_nls_cp437+0x0/0x20 returned 0 after 2 usecs
[    1.517825] calling  init_nls_ascii+0x0/0x20 @ 1
[    1.518614] initcall init_nls_ascii+0x0/0x20 returned 0 after 0 usecs
[    1.519696] calling  init_nls_iso8859_1+0x0/0x20 @ 1
[    1.520529] initcall init_nls_iso8859_1+0x0/0x20 returned 0 after 0 usecs
[    1.521743] calling  init_nls_utf8+0x0/0x30 @ 1
[    1.522505] initcall init_nls_utf8+0x0/0x30 returned 0 after 0 usecs
[    1.523569] calling  init_autofs_fs+0x0/0x40 @ 1
[    0.119986] smpboot: CPU 12 Converting physical 0 to logical die 12
[    1.524419] initcall init_autofs_fs+0x0/0x40 returned 0 after 67 usecs
[    1.528286] calling  init_v9fs+0x0/0x100 @ 1
[    1.549048] 9p: Installing v9fs 9p2000 file system support
[    1.550014] initcall init_v9fs+0x0/0x100 returned 0 after 966 usecs
[    1.551067] calling  ipc_init+0x0/0x30 @ 1
[    1.551784] initcall ipc_init+0x0/0x30 returned 0 after 26 usecs
[    1.552797] calling  ipc_sysctl_init+0x0/0x40 @ 1
[    1.553613] initcall ipc_sysctl_init+0x0/0x40 returned 0 after 11 usecs
[    1.554786] calling  init_mqueue_fs+0x0/0x110 @ 1
[    1.555693] initcall init_mqueue_fs+0x0/0x110 returned 0 after 48 usecs
[    1.556877] calling  key_proc_init+0x0/0x70 @ 1
[    1.557654] initcall key_proc_init+0x0/0x70 returned 0 after 1 usecs
[    1.558724] calling  selinux_nf_ip_init+0x0/0x40 @ 1
[    1.559561] initcall selinux_nf_ip_init+0x0/0x40 returned 0 after 0 usecs
[    1.560701] calling  init_sel_fs+0x0/0x130 @ 1
[    1.561468] initcall init_sel_fs+0x0/0x130 returned 0 after 0 usecs
[    1.561468]  #13
[    1.562532] calling  selnl_init+0x0/0xb0 @ 1
[    1.563576] initcall selnl_init+0x0/0xb0 returned 0 after 4 usecs
[    1.564552] calling  sel_netif_init+0x0/0x40 @ 1
[    1.565326] initcall sel_netif_init+0x0/0x40 returned 0 after 0 usecs
[    1.566406] calling  sel_netnode_init+0x0/0x40 @ 1
[    1.567214] initcall sel_netnode_init+0x0/0x40 returned 0 after 0 usecs
[    1.568312] calling  sel_netport_init+0x0/0x40 @ 1
[    1.569197] initcall sel_netport_init+0x0/0x40 returned 0 after 0 usecs
[    1.570366] calling  aurule_init+0x0/0x30 @ 1
[    1.571103] initcall aurule_init+0x0/0x30 returned 0 after 0 usecs
[    1.572140] calling  jent_mod_init+0x0/0xe0 @ 1
[    0.119986] smpboot: CPU 13 Converting physical 0 to logical die 13
[    1.604960] initcall jent_mod_init+0x0/0xe0 returned 0 after 32055 usecs
[    1.606087] calling  asymmetric_key_init+0x0/0x10 @ 1
[    1.606950] Key type asymmetric registered
[    1.606951]  #14
[    1.607578] initcall asymmetric_key_init+0x0/0x10 returned 0 after 629 usecs
[    1.609120] calling  x509_key_init+0x0/0x10 @ 1
[    1.609825] Asymmetric key parser 'x509' registered
[    1.610576] initcall x509_key_init+0x0/0x10 returned 0 after 753 usecs
[    1.611596] calling  blkdev_init+0x0/0x20 @ 1
[    0.119986] smpboot: CPU 14 Converting physical 0 to logical die 14
[    1.641542] initcall blkdev_init+0x0/0x20 returned 0 after 29214 usecs
[    1.642700] calling  proc_genhd_init+0x0/0x50 @ 1
[    1.643488] initcall proc_genhd_init+0x0/0x50 returned 0 after 2 usecs
[    1.644494] calling  bsg_init+0x0/0xa0 @ 1
[    1.645222] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.646467] initcall bsg_init+0x0/0xa0 returned 0 after 1262 usecs
[    1.647527] calling  ioprio_init+0x0/0x10 @ 1
[    1.648289] initcall ioprio_init+0x0/0x10 returned 0 after 19 usecs
[    1.649343] calling  iolatency_init+0x0/0x10 @ 1
[    1.650115] initcall iolatency_init+0x0/0x10 returned 0 after 0 usecs
[    1.651097] calling  ioc_init+0x0/0x10 @ 1
[    1.651727] initcall ioc_init+0x0/0x10 returned 0 after 4 usecs
[    1.652717] calling  deadline_init+0x0/0x10 @ 1
[    1.653561]  #15
[    1.653567] io scheduler mq-deadline registered
[    1.654600] initcall deadline_init+0x0/0x10 returned 0 after 1036 usecs
[    1.655669] calling  kyber_init+0x0/0x10 @ 1
[    1.656396] io scheduler kyber registered
[    1.657012] initcall kyber_init+0x0/0x10 returned 0 after 616 usecs
[    1.658071] calling  io_uring_init+0x0/0x80 @ 1
[    1.658842] initcall io_uring_init+0x0/0x80 returned 0 after 16 usecs
[    1.659819] calling  blake2s_mod_init+0x0/0x10 @ 1
[    1.660551] initcall blake2s_mod_init+0x0/0x10 returned 0 after 0 usecs
[    1.661582] calling  percpu_counter_startup+0x0/0x70 @ 1
[    0.119986] smpboot: CPU 15 Converting physical 0 to logical die 15
[    1.689757]  #16
[    0.119986] smpboot: CPU 16 Converting physical 0 to logical die 16
[    1.724809] initcall percpu_counter_startup+0x0/0x70 returned 0 after 62300 usecs
[    1.726120] calling  pcie_portdrv_init+0x0/0x40 @ 1
[    1.726976] initcall pcie_portdrv_init+0x0/0x40 returned 0 after 16 usecs
[    1.728066] calling  pci_proc_init+0x0/0x80 @ 1
[    1.728843] initcall pci_proc_init+0x0/0x80 returned 0 after 10 usecs
[    1.729912] calling  pci_hotplug_init+0x0/0x10 @ 1
[    1.730772] initcall pci_hotplug_init+0x0/0x10 returned 0 after 0 usecs
[    1.731903] calling  ged_driver_init+0x0/0x20 @ 1
[    1.732715] initcall ged_driver_init+0x0/0x20 returned 0 after 11 usecs
[    1.733862] calling  acpi_ac_init+0x0/0x50 @ 1
[    1.734618] initcall acpi_ac_init+0x0/0x50 returned 0 after 27 usecs
[    1.735634] calling  acpi_button_driver_init+0x0/0x60 @ 1
[    1.736728]  #17
[    1.736808] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.742029] ACPI: button: Power Button [PWRF]
[    1.742840] probe of LNXPWRBN:00 returned 0 after 6085 usecs
[    1.744023] initcall acpi_button_driver_init+0x0/0x60 returned 0 after 7291 usecs
[    1.745628] calling  acpi_fan_driver_init+0x0/0x20 @ 1
[    1.746752] initcall acpi_fan_driver_init+0x0/0x20 returned 0 after 7 usecs
[    0.119986] smpboot: CPU 17 Converting physical 0 to logical die 17
[    1.748087] calling  acpi_video_init+0x0/0xc0 @ 1
[    1.754442] initcall acpi_video_init+0x0/0xc0 returned 0 after 4299 usecs
[    1.775767] calling  acpi_processor_driver_init+0x0/0xc0 @ 1
[    1.777382]  #18
[    0.119986] smpboot: CPU 18 Converting physical 0 to logical die 18
[    1.812468] probe of cpu0 returned 0 after 35546 usecs
[    1.813374] probe of cpu1 returned 0 after 20 usecs
[    1.814172] probe of cpu2 returned 0 after 15 usecs
[    1.815023] probe of cpu3 returned 0 after 40 usecs
[    1.815783] probe of cpu4 returned 0 after 16 usecs
[    1.816578] probe of cpu5 returned 0 after 16 usecs
[    1.817413] probe of cpu6 returned 0 after 17 usecs
[    1.818227] probe of cpu7 returned 0 after 14 usecs
[    1.818983] probe of cpu8 returned 0 after 14 usecs
[    1.819754] probe of cpu9 returned 0 after 16 usecs
[    1.820516] probe of cpu10 returned 0 after 21 usecs
[    1.821283] probe of cpu11 returned 0 after 14 usecs
[    1.822147] probe of cpu12 returned 0 after 17 usecs
[    1.823026] probe of cpu13 returned 0 after 22 usecs
[    1.823854] probe of cpu14 returned 0 after 15 usecs
[    1.824647] probe of cpu15 returned 0 after 16 usecs
[    1.825429] probe of cpu16 returned 0 after 16 usecs
[    1.826202] probe of cpu17 returned 0 after 14 usecs
[    1.826980] probe of cpu18 returned 0 after 15 usecs
[    1.834883]  #19
[    0.119986] smpboot: CPU 19 Converting physical 0 to logical die 19
[    1.869891]  #20
[    0.119986] smpboot: CPU 20 Converting physical 0 to logical die 20
[    1.905149]  #21
[    0.119986] smpboot: CPU 21 Converting physical 0 to logical die 21
[    1.944539] probe of cpu19 returned 0 after 75178 usecs
[    1.945461] probe of cpu20 returned 0 after 22 usecs
[    1.946314] probe of cpu21 returned 0 after 19 usecs
[    1.967152]  #22
[    0.119986] smpboot: CPU 22 Converting physical 0 to logical die 22
[    2.002644]  #23
[    0.119986] smpboot: CPU 23 Converting physical 0 to logical die 23
[    2.051157]  #24
[    0.119986] smpboot: CPU 24 Converting physical 0 to logical die 24
[    2.087237] probe of cpu22 returned 0 after 85068 usecs
[    2.088232] probe of cpu23 returned 0 after 31 usecs
[    2.089261] probe of cpu24 returned 0 after 26 usecs
[    2.109882]  #25
[    0.119986] smpboot: CPU 25 Converting physical 0 to logical die 25
[    2.145927]  #26
[    0.119986] smpboot: CPU 26 Converting physical 0 to logical die 26
[    2.181549] probe of cpu25 returned 0 after 36219 usecs
[    2.182533] probe of cpu26 returned 0 after 27 usecs
[    2.204052]  #27
[    0.119986] smpboot: CPU 27 Converting physical 0 to logical die 27
[    2.245710]  #28
[    0.119986] smpboot: CPU 28 Converting physical 0 to logical die 28
[    2.282784]  #29
[    0.119986] smpboot: CPU 29 Converting physical 0 to logical die 29
[    2.321873] probe of cpu27 returned 0 after 76792 usecs
[    2.322851] probe of cpu28 returned 0 after 27 usecs
[    2.323734] probe of cpu29 returned 0 after 23 usecs
[    2.343817]  #30
[    0.119986] smpboot: CPU 30 Converting physical 0 to logical die 30
[    2.379722]  #31
[    0.119986] smpboot: CPU 31 Converting physical 0 to logical die 31
[    2.416843]  #32
[    0.119986] smpboot: CPU 32 Converting physical 0 to logical die 32
[    2.457460] probe of cpu30 returned 0 after 78260 usecs
[    2.458525] probe of cpu31 returned 0 after 41 usecs
[    2.459518] probe of cpu32 returned 0 after 35 usecs
[    2.479817]  #33
[    0.119986] smpboot: CPU 33 Converting physical 0 to logical die 33
[    2.515571]  #34
[    0.119986] smpboot: CPU 34 Converting physical 0 to logical die 34
[    2.555669] probe of cpu33 returned 0 after 40747 usecs
[    2.556802] probe of cpu34 returned 0 after 38 usecs
[    2.577815]  #35
[    0.119986] smpboot: CPU 35 Converting physical 0 to logical die 35
[    2.614164]  #36
[    0.119986] smpboot: CPU 36 Converting physical 0 to logical die 36
[    2.658400] probe of cpu35 returned 0 after 44827 usecs
[    2.659268] probe of cpu36 returned 0 after 23 usecs
[    2.680713]  #37
[    0.119986] smpboot: CPU 37 Converting physical 0 to logical die 37
[    2.721218]  #38
[    0.119986] smpboot: CPU 38 Converting physical 0 to logical die 38
[    2.760057] probe of cpu37 returned 0 after 39383 usecs
[    2.760972] probe of cpu38 returned 0 after 23 usecs
[    2.782873]  #39
[    0.119986] smpboot: CPU 39 Converting physical 0 to logical die 39
[    2.827236]  #40
[    0.119986] smpboot: CPU 40 Converting physical 0 to logical die 40
[    2.868408] probe of cpu39 returned 0 after 41743 usecs
[    2.869333] probe of cpu40 returned 0 after 22 usecs
[    2.890832]  #41
[    0.119986] smpboot: CPU 41 Converting physical 0 to logical die 41
[    2.929625]  #42
[    0.119986] smpboot: CPU 42 Converting physical 0 to logical die 42
[    2.966619] rcu-torture: torture_onoff begin holdoff
[    2.966667] probe of cpu41 returned 0 after 37639 usecs
[    2.968409] probe of cpu42 returned 0 after 28 usecs
[    2.969217] initcall acpi_processor_driver_init+0x0/0xc0 returned 0 after 1192306 usecs
[    2.970492] calling  acpi_thermal_init+0x0/0x80 @ 1
[    2.971520] initcall acpi_thermal_init+0x0/0x80 returned 0 after 251 usecs
[    2.972617] calling  acpi_battery_init+0x0/0x40 @ 1
[    2.973390] initcall acpi_battery_init+0x0/0x40 returned 0 after 2 usecs
[    2.974484] calling  bgrt_init+0x0/0xd0 @ 1
[    2.975162] initcall bgrt_init+0x0/0xd0 returned -19 after 0 usecs
[    2.976163] calling  virtio_pci_driver_init+0x0/0x20 @ 1
[    2.977018] initcall virtio_pci_driver_init+0x0/0x20 returned 0 after 9 usecs
[    2.978176] calling  virtio_input_driver_init+0x0/0x10 @ 1
[    2.979055] initcall virtio_input_driver_init+0x0/0x10 returned 0 after 10 usecs
[    2.980230] calling  n_null_init+0x0/0x20 @ 1
[    2.980923] initcall n_null_init+0x0/0x20 returned 0 after 2 usecs
[    2.981893] calling  pty_init+0x0/0x230 @ 1
[    2.982709] initcall pty_init+0x0/0x230 returned 0 after 144 usecs
[    2.983692] calling  sysrq_init+0x0/0x70 @ 1
[    2.984373] initcall sysrq_init+0x0/0x70 returned 0 after 3 usecs
[    2.985374] calling  serial8250_init+0x0/0x1e0 @ 1
[    2.986181] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.987227] probe of 00:04:0 returned 0 after 3 usecs
[    2.988062] probe of 00:04:0.0 returned 0 after 2 usecs
[    2.989073] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.990366] probe of 00:04 returned 0 after 3162 usecs
[    2.991183] probe of serial8250:0 returned 0 after 1 usecs
[    2.992029] probe of serial8250:0.1 returned 0 after 1 usecs
[    2.993069] probe of serial8250:0.2 returned 0 after 1 usecs
[    2.994021] probe of serial8250:0.3 returned 0 after 1 usecs
[    2.994955] probe of serial8250 returned 0 after 2 usecs
[    2.995776] initcall serial8250_init+0x0/0x1e0 returned 0 after 9594 usecs
[    2.996840] calling  exar_pci_driver_init+0x0/0x20 @ 1
[    2.997628] initcall exar_pci_driver_init+0x0/0x20 returned 0 after 5 usecs
[    2.998681] calling  lpss8250_pci_driver_init+0x0/0x20 @ 1
[    2.999522] initcall lpss8250_pci_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.000631] calling  mid8250_pci_driver_init+0x0/0x20 @ 1
[    3.001452] initcall mid8250_pci_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.002648] calling  serial_pci_driver_init+0x0/0x20 @ 1
[    3.003546] initcall serial_pci_driver_init+0x0/0x20 returned 0 after 7 usecs
[    3.004629] calling  pericom8250_pci_driver_init+0x0/0x20 @ 1
[    3.005520] initcall pericom8250_pci_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.006690] calling  random_sysctls_init+0x0/0x30 @ 1
[    3.007462] initcall random_sysctls_init+0x0/0x30 returned 0 after 4 usecs
[    3.008505] calling  virtio_console_init+0x0/0xe0 @ 1
[    3.009362] initcall virtio_console_init+0x0/0xe0 returned 0 after 14 usecs
[    3.010454] calling  hpet_init+0x0/0x90 @ 1
[    3.011272] probe of PNP0103:00 returned 19 after 24 usecs
[    3.012135] initcall hpet_init+0x0/0x90 returned 0 after 1038 usecs
[    3.013088] calling  nvram_module_init+0x0/0x90 @ 1
[    3.013955] Non-volatile memory driver v1.3
[    3.014604] initcall nvram_module_init+0x0/0x90 returned 0 after 765 usecs
[    3.015647] calling  via_rng_mod_init+0x0/0x60 @ 1
[    3.016351] initcall via_rng_mod_init+0x0/0x60 returned -19 after 0 usecs
[    3.017396] calling  agp_init+0x0/0x30 @ 1
[    3.018061] Linux agpgart interface v0.103
[    3.018711] initcall agp_init+0x0/0x30 returned 0 after 649 usecs
[    3.019670] calling  agp_amd64_mod_init+0x0/0x10 @ 1
[    3.020434] initcall agp_amd64_mod_init+0x0/0x10 returned -19 after 9 usecs
[    3.021504] calling  agp_intel_init+0x0/0x30 @ 1
[    3.022246] probe of 0000:00:00.0 returned 19 after 34 usecs
[    3.023109] initcall agp_intel_init+0x0/0x30 returned 0 after 898 usecs
[    3.024113] calling  drm_core_init+0x0/0xc0 @ 1
[    3.024931] ACPI: bus type drm_connector registered
[    3.025814] initcall drm_core_init+0x0/0xc0 returned 0 after 894 usecs
[    3.026806] calling  drm_buddy_module_init+0x0/0x40 @ 1
[    3.027602] initcall drm_buddy_module_init+0x0/0x40 returned 0 after 2 usecs
[    3.028690] calling  drm_display_helper_module_init+0x0/0x10 @ 1
[    3.029613] initcall drm_display_helper_module_init+0x0/0x10 returned 0 after 0 usecs
[    3.030740] calling  i915_init+0x0/0xb0 @ 1
[    3.031412] initcall i915_init+0x0/0xb0 returned 0 after 37 usecs
[    3.032339] calling  virtio_gpu_driver_init+0x0/0x10 @ 1
[    3.033178] initcall virtio_gpu_driver_init+0x0/0x10 returned 0 after 3 usecs
[    3.034269] calling  cn_proc_init+0x0/0x50 @ 1
[    3.034965] initcall cn_proc_init+0x0/0x50 returned 0 after 0 usecs
[    3.035920] calling  topology_sysfs_init+0x0/0x30 @ 1
[    3.036896] initcall topology_sysfs_init+0x0/0x30 returned 0 after 203 usecs
[    3.037989] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
[    3.042622] initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 3898 usecs
[    3.043784] calling  loop_init+0x0/0xf0 @ 1
[    3.047464] loop: module loaded
[    3.047967] initcall loop_init+0x0/0xf0 returned 0 after 3502 usecs
[    3.048928] calling  virtio_blk_init+0x0/0x90 @ 1
[    3.049677] initcall virtio_blk_init+0x0/0x90 returned 0 after 21 usecs
[    3.050648] calling  mei_init+0x0/0x90 @ 1
[    3.051248] initcall mei_init+0x0/0x90 returned 0 after 7 usecs
[    3.052181] calling  mei_me_driver_init+0x0/0x20 @ 1
[    3.053033] initcall mei_me_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.054151] calling  mac_hid_init+0x0/0x40 @ 1
[    3.054822] initcall mac_hid_init+0x0/0x40 returned 0 after 2 usecs
[    3.055714] calling  spi_transport_init+0x0/0x90 @ 1
[    3.056427] initcall spi_transport_init+0x0/0x90 returned 0 after 5 usecs
[    3.057485] calling  virtio_scsi_init+0x0/0xd0 @ 1
[    3.058229] initcall virtio_scsi_init+0x0/0xd0 returned 0 after 7 usecs
[    3.059175] calling  init_sd+0x0/0x100 @ 1
[    3.059825] initcall init_sd+0x0/0x100 returned 0 after 10 usecs
[    3.060786] calling  init_sr+0x0/0x60 @ 1
[    3.061402] initcall init_sr+0x0/0x60 returned 0 after 2 usecs
[    3.062290] calling  init_sg+0x0/0x200 @ 1
[    3.062982] initcall init_sg+0x0/0x200 returned 0 after 7 usecs
[    3.063977] calling  ahci_pci_driver_init+0x0/0x20 @ 1
[    3.064885] ahci 0000:00:1f.2: version 3.0
[    3.065696] ACPI: \_SB_.GSIA: Enabled at IRQ 16
[    3.067023] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    3.068298] ahci 0000:00:1f.2: flags: 64bit ncq only 
[    3.070493] scsi host0: ahci
[    3.071157] scsi host1: ahci
[    3.071760] scsi host2: ahci
[    3.072419] scsi host3: ahci
[    3.073074] scsi host4: ahci
[    3.073724] scsi host5: ahci
[    3.074237] ata1: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1100 irq 24 lpm-pol 0
[    3.075485] ata2: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1180 irq 24 lpm-pol 0
[    3.076703] ata3: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1200 irq 24 lpm-pol 0
[    3.077954] ata4: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1280 irq 24 lpm-pol 0
[    3.079202] ata5: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1300 irq 24 lpm-pol 0
[    3.080565] ata6: SATA max UDMA/133 abar m4096@0xfebf1000 port 0xfebf1380 irq 24 lpm-pol 0
[    3.081963] probe of 0000:00:1f.2 returned 0 after 17088 usecs
[    3.083098] initcall ahci_pci_driver_init+0x0/0x20 returned 0 after 18230 usecs
[    3.084587] calling  piix_init+0x0/0x30 @ 1
[    3.085276] initcall piix_init+0x0/0x30 returned 0 after 8 usecs
[    3.086250] calling  amd_pci_driver_init+0x0/0x20 @ 1
[    3.087039] initcall amd_pci_driver_init+0x0/0x20 returned 0 after 4 usecs
[    3.088148] calling  oldpiix_pci_driver_init+0x0/0x20 @ 1
[    3.089063] initcall oldpiix_pci_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.090178] calling  sch_pci_driver_init+0x0/0x20 @ 1
[    3.090946] initcall sch_pci_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.091967] calling  blackhole_netdev_init+0x0/0x80 @ 1
[    3.092781] initcall blackhole_netdev_init+0x0/0x80 returned 0 after 16 usecs
[    3.093888] calling  fixed_mdio_bus_init+0x0/0x70 @ 1
[    3.094730] initcall fixed_mdio_bus_init+0x0/0x70 returned 0 after 64 usecs
[    3.095789] calling  phy_module_init+0x0/0x20 @ 1
[    3.096583] initcall phy_module_init+0x0/0x20 returned 0 after 45 usecs
[    3.097589] calling  virtio_net_driver_init+0x0/0xb0 @ 1
[    3.098418] initcall virtio_net_driver_init+0x0/0xb0 returned 0 after 4 usecs
[    3.099553] calling  tg3_driver_init+0x0/0x20 @ 1
[    3.100275] initcall tg3_driver_init+0x0/0x20 returned 0 after 4 usecs
[    3.101266] calling  e100_init_module+0x0/0x60 @ 1
[    3.102004] e100: Intel(R) PRO/100 Network Driver
[    3.102732] e100: Copyright(c) 1999-2006 Intel Corporation
[    3.103607] initcall e100_init_module+0x0/0x60 returned 0 after 1602 usecs
[    3.104787] calling  e1000_init_module+0x0/0x80 @ 1
[    3.105613] e1000: Intel(R) PRO/1000 Network Driver
[    3.106388] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.107271] initcall e1000_init_module+0x0/0x80 returned 0 after 1657 usecs
[    3.108376] calling  e1000_init_module+0x0/0x40 @ 1
[    3.109215] e1000e: Intel(R) PRO/1000 Network Driver
[    3.110083] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.111085] initcall e1000_init_module+0x0/0x40 returned 0 after 1869 usecs
[    3.112250] calling  sky2_init_module+0x0/0x30 @ 1
[    3.113038] sky2: driver version 1.30
[    3.113600] initcall sky2_init_module+0x0/0x30 returned 0 after 562 usecs
[    3.114678] calling  forcedeth_pci_driver_init+0x0/0x20 @ 1
[    3.115533] initcall forcedeth_pci_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.116656] calling  rtl8139_init_module+0x0/0x20 @ 1
[    3.117416] initcall rtl8139_init_module+0x0/0x20 returned 0 after 4 usecs
[    3.118465] calling  rtl8169_pci_driver_init+0x0/0x20 @ 1
[    3.119294] initcall rtl8169_pci_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.120388] calling  net_failover_init+0x0/0x10 @ 1
[    3.121135] initcall net_failover_init+0x0/0x10 returned 0 after 0 usecs
[    3.122157] calling  cdrom_init+0x0/0x10 @ 1
[    3.122875] initcall cdrom_init+0x0/0x10 returned 0 after 6 usecs
[    3.123804] calling  nonstatic_sysfs_init+0x0/0x10 @ 1
[    3.124639] initcall nonstatic_sysfs_init+0x0/0x10 returned 0 after 0 usecs
[    3.125667] calling  yenta_cardbus_driver_init+0x0/0x20 @ 1
[    3.126503] initcall yenta_cardbus_driver_init+0x0/0x20 returned 0 after 4 usecs
[    3.127641] calling  mon_init+0x0/0x140 @ 1
[    3.128453] initcall mon_init+0x0/0x140 returned 0 after 160 usecs
[    3.129645] calling  ehci_hcd_init+0x0/0x80 @ 1
[    3.130417] initcall ehci_hcd_init+0x0/0x80 returned 0 after 0 usecs
[    3.131438] calling  ehci_pci_init+0x0/0x60 @ 1
[    3.132213] initcall ehci_pci_init+0x0/0x60 returned 0 after 8 usecs
[    3.133242] calling  ohci_hcd_mod_init+0x0/0x50 @ 1
[    3.134036] initcall ohci_hcd_mod_init+0x0/0x50 returned 0 after 2 usecs
[    3.135046] calling  ohci_pci_init+0x0/0x60 @ 1
[    3.135705] initcall ohci_pci_init+0x0/0x60 returned 0 after 7 usecs
[    3.136616] calling  uhci_hcd_init+0x0/0xb0 @ 1
[    3.137272] initcall uhci_hcd_init+0x0/0xb0 returned 0 after 5 usecs
[    3.138221] calling  xhci_hcd_init+0x0/0x30 @ 1
[    3.138921] initcall xhci_hcd_init+0x0/0x30 returned 0 after 1 usecs
[    3.139886] calling  xhci_pci_init+0x0/0x70 @ 1
[    3.140595] initcall xhci_pci_init+0x0/0x70 returned 0 after 6 usecs
[    3.141564] calling  usblp_driver_init+0x0/0x20 @ 1
[    3.142313] usbcore: registered new interface driver usblp
[    3.143148] initcall usblp_driver_init+0x0/0x20 returned 0 after 840 usecs
[    3.144188] calling  usb_storage_driver_init+0x0/0x30 @ 1
[    3.145014] usbcore: registered new interface driver usb-storage
[    3.145921] initcall usb_storage_driver_init+0x0/0x30 returned 0 after 913 usecs
[    3.147065] calling  i8042_init+0x0/0x5d0 @ 1
[    3.147766] probe of 00:01 returned 0 after 12 usecs
[    3.148543] probe of 00:02 returned 0 after 3 usecs
[    3.149296] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.151371] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.152174] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.152961] probe of i8042 returned 0 after 2421 usecs
[    3.153800] initcall i8042_init+0x0/0x5d0 returned 0 after 6070 usecs
[    3.154887] calling  serport_init+0x0/0x40 @ 1
[    3.155590] initcall serport_init+0x0/0x40 returned 0 after 0 usecs
[    3.156556] calling  input_leds_init+0x0/0x10 @ 1
[    3.157288] initcall input_leds_init+0x0/0x10 returned 0 after 1 usecs
[    3.158283] calling  evdev_init+0x0/0x10 @ 1
[    3.159095] initcall evdev_init+0x0/0x10 returned 0 after 158 usecs
[    3.160082] calling  atkbd_init+0x0/0x30 @ 1
[    3.160779] initcall atkbd_init+0x0/0x30 returned 0 after 38 usecs
[    3.161910] calling  psmouse_init+0x0/0xa0 @ 1
[    3.162756] initcall psmouse_init+0x0/0xa0 returned 0 after 135 usecs
[    3.163806] calling  cmos_init+0x0/0x90 @ 1
[    3.164522] rtc_cmos 00:00: RTC can wake from S4
[    3.165264] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    3.166755] probe of serio0 returned 0 after 6001 usecs
[    3.167808] probe of alarmtimer.0.auto returned 0 after 4 usecs
[    3.168266] probe of serio1 returned 19 after 400 usecs
[    3.169148] rtc_cmos 00:00: registered as rtc0
[    3.171811] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[    3.174314] probe of 00:00 returned 0 after 9806 usecs
[    3.175214] initcall cmos_init+0x0/0x90 returned 0 after 10739 usecs
[    3.176360] calling  smbalert_driver_init+0x0/0x20 @ 1
[    3.177244] initcall smbalert_driver_init+0x0/0x20 returned 0 after 8 usecs
[    3.178401] calling  i801_driver_init+0x0/0xe0 @ 1
[    3.179222] initcall i801_driver_init+0x0/0xe0 returned 0 after 16 usecs
[    3.180340] calling  ptp_kvm_init+0x0/0xe0 @ 1
[    3.180968] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    3.181257] initcall ptp_kvm_init+0x0/0xe0 returned 0 after 94 usecs
[    3.182217] i2c i2c-0: 1/1 memory slots populated (from DMI)
[    3.183239] calling  thermal_throttle_init_device+0x0/0x50 @ 1
[    3.184155] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[    3.185133] initcall thermal_throttle_init_device+0x0/0x50 returned 0 after 0 usecs
[    3.186665] probe of 0000:00:1f.3 returned 0 after 6100 usecs
[    3.187641] calling  dm_init+0x0/0x80 @ 1
[    3.189459] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    3.190874] initcall dm_init+0x0/0x80 returned 0 after 1628 usecs
[    3.191943] calling  dm_mirror_init+0x0/0x70 @ 1
[    3.192776] initcall dm_mirror_init+0x0/0x70 returned 0 after 21 usecs
[    3.193889] calling  dm_dirty_log_init+0x0/0x60 @ 1
[    3.194717] initcall dm_dirty_log_init+0x0/0x60 returned 0 after 3 usecs
[    3.195832] calling  dm_zero_init+0x0/0x10 @ 1
[    3.196585] initcall dm_zero_init+0x0/0x10 returned 0 after 0 usecs
[    3.197632] calling  intel_pstate_init+0x0/0x840 @ 1
[    3.198525] intel_pstate: CPU model not supported
[    3.199369] initcall intel_pstate_init+0x0/0x840 returned -19 after 845 usecs
[    3.200649] calling  haltpoll_init+0x0/0xf0 @ 1
[    3.201465] initcall haltpoll_init+0x0/0xf0 returned -19 after 2 usecs
[    3.202638] calling  esrt_sysfs_init+0x0/0x300 @ 1
[    3.203508] initcall esrt_sysfs_init+0x0/0x300 returned -38 after 0 usecs
[    3.204644] calling  hid_init+0x0/0x60 @ 1
[    3.205424] hid: raw HID events driver (C) Jiri Kosina
[    3.206334] initcall hid_init+0x0/0x60 returned 0 after 924 usecs
[    3.207353] calling  hid_generic_init+0x0/0x20 @ 1
[    3.208182] initcall hid_generic_init+0x0/0x20 returned 0 after 10 usecs
[    3.209408] calling  a4_driver_init+0x0/0x20 @ 1
[    3.210380] initcall a4_driver_init+0x0/0x20 returned 0 after 59 usecs
[    3.211559] calling  apple_driver_init+0x0/0x20 @ 1
[    3.212398] initcall apple_driver_init+0x0/0x20 returned 0 after 4 usecs
[    3.213602] calling  belkin_driver_init+0x0/0x20 @ 1
[    3.214432] initcall belkin_driver_init+0x0/0x20 returned 0 after 3 usecs
[    3.215643] calling  ch_driver_init+0x0/0x20 @ 1
[    3.216468] initcall ch_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.217729] calling  ch_driver_init+0x0/0x20 @ 1
[    3.218553] initcall ch_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.219667] calling  cp_driver_init+0x0/0x20 @ 1
[    3.220484] initcall cp_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.221607] calling  ez_driver_init+0x0/0x20 @ 1
[    3.222416] initcall ez_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.223537] calling  gyration_driver_init+0x0/0x20 @ 1
[    3.224436] initcall gyration_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.225778] calling  ite_driver_init+0x0/0x20 @ 1
[    3.226610] initcall ite_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.227772] calling  ks_driver_init+0x0/0x20 @ 1
[    3.228668] initcall ks_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.229858] calling  lg_driver_init+0x0/0x20 @ 1
[    3.230672] initcall lg_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.231789] calling  lg_g15_driver_init+0x0/0x20 @ 1
[    3.232662] initcall lg_g15_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.233920] calling  ms_driver_init+0x0/0x20 @ 1
[    3.234796] initcall ms_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.235928] calling  mr_driver_init+0x0/0x20 @ 1
[    3.236740] initcall mr_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.237851] calling  ntrig_driver_init+0x0/0x20 @ 1
[    3.238726] initcall ntrig_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.239959] calling  pl_driver_init+0x0/0x20 @ 1
[    3.240774] initcall pl_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.241887] calling  pl_driver_init+0x0/0x20 @ 1
[    3.242709] initcall pl_driver_init+0x0/0x20 returned 0 after 5 usecs
[    3.243823] calling  redragon_driver_init+0x0/0x20 @ 1
[    3.244801] initcall redragon_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.246107] calling  samsung_driver_init+0x0/0x20 @ 1
[    3.247058] initcall samsung_driver_init+0x0/0x20 returned 0 after 7 usecs
[    3.248340] calling  sony_init+0x0/0x20 @ 1
[    3.249156] initcall sony_init+0x0/0x20 returned 0 after 6 usecs
[    3.250276] calling  sp_driver_init+0x0/0x20 @ 1
[    3.251155] initcall sp_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.252379] calling  ts_driver_init+0x0/0x20 @ 1
[    3.253250] initcall ts_driver_init+0x0/0x20 returned 0 after 6 usecs
[    3.254451] calling  hid_init+0x0/0x70 @ 1
[    3.255253] usbcore: registered new interface driver usbhid
[    3.256288] usbhid: USB HID core driver
[    3.257022] initcall hid_init+0x0/0x70 returned 0 after 1781 usecs
[    3.258170] calling  wmi_bmof_driver_init+0x0/0x20 @ 1
[    3.259135] initcall wmi_bmof_driver_init+0x0/0x20 returned 0 after 7 usecs
[    3.260428] calling  eeepc_laptop_init+0x0/0x70 @ 1
[    3.261413] initcall eeepc_laptop_init+0x0/0x70 returned -19 after 45 usecs
[    3.262734] calling  alsa_hwdep_init+0x0/0x70 @ 1
[    3.263630] initcall alsa_hwdep_init+0x0/0x70 returned 0 after 6 usecs
[    3.264842] calling  alsa_timer_init+0x0/0x230 @ 1
[    3.265821] initcall alsa_timer_init+0x0/0x230 returned 0 after 82 usecs
[    3.267118] calling  snd_hrtimer_init+0x0/0x120 @ 1
[    3.268040] initcall snd_hrtimer_init+0x0/0x120 returned 0 after 0 usecs
[    3.269285] calling  alsa_pcm_init+0x0/0x80 @ 1
[    3.270143] initcall alsa_pcm_init+0x0/0x80 returned 0 after 1 usecs
[    3.271321] calling  alsa_seq_init+0x0/0x60 @ 1
[    3.272245] initcall alsa_seq_init+0x0/0x60 returned 0 after 71 usecs
[    3.273381] calling  alsa_seq_dummy_init+0x0/0xf0 @ 1
[    3.274241] initcall alsa_seq_dummy_init+0x0/0xf0 returned 0 after 5 usecs
[    3.275418] calling  azx_driver_init+0x0/0x20 @ 1
[    3.276291] initcall azx_driver_init+0x0/0x20 returned 0 after 14 usecs
[    3.277415] calling  sock_diag_init+0x0/0x30 @ 1
[    3.278294] initcall sock_diag_init+0x0/0x30 returned 0 after 41 usecs
[    3.279459] calling  failover_init+0x0/0x20 @ 1
[    3.280333] initcall failover_init+0x0/0x20 returned 0 after 5 usecs
[    3.281467] calling  blackhole_init+0x0/0x10 @ 1
[    3.282247] initcall blackhole_init+0x0/0x10 returned 0 after 1 usecs
[    3.283334] calling  init_cgroup_cls+0x0/0x10 @ 1
[    3.284189] initcall init_cgroup_cls+0x0/0x10 returned 0 after 0 usecs
[    3.285366] calling  nfnetlink_init+0x0/0x70 @ 1
[    3.286209] initcall nfnetlink_init+0x0/0x70 returned 0 after 7 usecs
[    3.287343] calling  nfnetlink_log_init+0x0/0xb0 @ 1
[    3.288270] initcall nfnetlink_log_init+0x0/0xb0 returned 0 after 8 usecs
[    3.289684] calling  nf_conntrack_standalone_init+0x0/0xb0 @ 1
[    3.290922] initcall nf_conntrack_standalone_init+0x0/0xb0 returned 0 after 100 usecs
[    3.292418] calling  ctnetlink_init+0x0/0xa0 @ 1
[    3.293314] initcall ctnetlink_init+0x0/0xa0 returned 0 after 0 usecs
[    3.294601] calling  nf_conntrack_ftp_init+0x0/0x130 @ 1
[    3.295704] initcall nf_conntrack_ftp_init+0x0/0x130 returned 0 after 4 usecs
[    3.297158] calling  nf_conntrack_irc_init+0x0/0x180 @ 1
[    3.298215] initcall nf_conntrack_irc_init+0x0/0x180 returned 0 after 2 usecs
[    3.299578] calling  nf_conntrack_sip_init+0x0/0x1a0 @ 1
[    3.300474] initcall nf_conntrack_sip_init+0x0/0x1a0 returned 0 after 4 usecs
[    3.301681] calling  nf_nat_init+0x0/0xc0 @ 1
[    3.302368] initcall nf_nat_init+0x0/0xc0 returned 0 after 24 usecs
[    3.303416] calling  nf_nat_ftp_init+0x0/0x30 @ 1
[    3.304364] initcall nf_nat_ftp_init+0x0/0x30 returned 0 after 0 usecs
[    3.305458] calling  nf_nat_irc_init+0x0/0x30 @ 1
[    3.306263] initcall nf_nat_irc_init+0x0/0x30 returned 0 after 0 usecs
[    3.307314] calling  nf_nat_sip_init+0x0/0x40 @ 1
[    3.308036] initcall nf_nat_sip_init+0x0/0x40 returned 0 after 0 usecs
[    3.309293] calling  xt_init+0x0/0x110 @ 1
[    3.310023] initcall xt_init+0x0/0x110 returned 0 after 13 usecs
[    3.310937] calling  tcpudp_mt_init+0x0/0x20 @ 1
[    3.311698] initcall tcpudp_mt_init+0x0/0x20 returned 0 after 2 usecs
[    3.312736] calling  connsecmark_tg_init+0x0/0x10 @ 1
[    3.313504] initcall connsecmark_tg_init+0x0/0x10 returned 0 after 0 usecs
[    3.314611] calling  nflog_tg_init+0x0/0x10 @ 1
[    3.315350] initcall nflog_tg_init+0x0/0x10 returned 0 after 0 usecs
[    3.316422] calling  secmark_tg_init+0x0/0x20 @ 1
[    3.317138] initcall secmark_tg_init+0x0/0x20 returned 0 after 0 usecs
[    3.318127] calling  tcpmss_tg_init+0x0/0x20 @ 1
[    3.318899] initcall tcpmss_tg_init+0x0/0x20 returned 0 after 0 usecs
[    3.320072] calling  conntrack_mt_init+0x0/0x20 @ 1
[    3.320891] initcall conntrack_mt_init+0x0/0x20 returned 0 after 0 usecs
[    3.322033] calling  policy_mt_init+0x0/0x20 @ 1
[    3.322805] initcall policy_mt_init+0x0/0x20 returned 0 after 0 usecs
[    3.323868] calling  state_mt_init+0x0/0x10 @ 1
[    3.324670] initcall state_mt_init+0x0/0x10 returned 0 after 0 usecs
[    3.325734] calling  gre_offload_init+0x0/0x60 @ 1
[    3.326543] initcall gre_offload_init+0x0/0x60 returned 0 after 1 usecs
[    3.327648] calling  sysctl_ipv4_init+0x0/0x60 @ 1
[    3.328502] initcall sysctl_ipv4_init+0x0/0x60 returned 0 after 52 usecs
[    3.329717] calling  tunnel4_init+0x0/0x70 @ 1
[    3.330473] initcall tunnel4_init+0x0/0x70 returned 0 after 0 usecs
[    3.331556] calling  nf_defrag_init+0x0/0x30 @ 1
[    3.332329] initcall nf_defrag_init+0x0/0x30 returned 0 after 0 usecs
[    3.333410] calling  ip_tables_init+0x0/0x80 @ 1
[    3.334283] initcall ip_tables_init+0x0/0x80 returned 0 after 8 usecs
[    3.335525] calling  iptable_filter_init+0x0/0xa0 @ 1
[    3.336450] initcall iptable_filter_init+0x0/0xa0 returned 0 after 5 usecs
[    3.337735] calling  iptable_mangle_init+0x0/0xa0 @ 1
[    3.338610] initcall iptable_mangle_init+0x0/0xa0 returned 0 after 0 usecs
[    3.339890] calling  reject_tg_init+0x0/0x10 @ 1
[    3.340740] initcall reject_tg_init+0x0/0x10 returned 0 after 0 usecs
[    3.341891] calling  cubictcp_register+0x0/0x70 @ 1
[    3.342749] initcall cubictcp_register+0x0/0x70 returned 0 after 0 usecs
[    3.343868] calling  xfrm_user_init+0x0/0x40 @ 1
[    3.344706] Initializing XFRM netlink socket
[    3.345462] initcall xfrm_user_init+0x0/0x40 returned 0 after 756 usecs
[    3.346661] calling  inet6_init+0x0/0x3b0 @ 1
[    3.347477] NET: Registered PF_INET6 protocol family
[    3.348940] Segment Routing with IPv6
[    3.349658] In-situ OAM (IOAM) with IPv6
[    3.350425] initcall inet6_init+0x0/0x3b0 returned 0 after 3035 usecs
[    3.351595] calling  ah6_init+0x0/0x80 @ 1
[    3.352345] initcall ah6_init+0x0/0x80 returned 0 after 13 usecs
[    3.353439] calling  esp6_init+0x0/0x80 @ 1
[    3.354190] initcall esp6_init+0x0/0x80 returned 0 after 0 usecs
[    3.355262] calling  ip6_tables_init+0x0/0x80 @ 1
[    3.356146] initcall ip6_tables_init+0x0/0x80 returned 0 after 7 usecs
[    3.357258] calling  ip6table_filter_init+0x0/0xa0 @ 1
[    3.358125] initcall ip6table_filter_init+0x0/0xa0 returned 0 after 3 usecs
[    3.359286] calling  ip6table_mangle_init+0x0/0xa0 @ 1
[    3.360209] initcall ip6table_mangle_init+0x0/0xa0 returned 0 after 0 usecs
[    3.361409] calling  nf_defrag_init+0x0/0x70 @ 1
[    3.362200] initcall nf_defrag_init+0x0/0x70 returned 0 after 13 usecs
[    3.363335] calling  ipv6header_mt6_init+0x0/0x10 @ 1
[    3.364183] initcall ipv6header_mt6_init+0x0/0x10 returned 0 after 0 usecs
[    3.365390] calling  reject_tg6_init+0x0/0x10 @ 1
[    3.366193] initcall reject_tg6_init+0x0/0x10 returned 0 after 0 usecs
[    3.367285] calling  sit_init+0x0/0xd0 @ 1
[    3.367978] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.369269] initcall sit_init+0x0/0xd0 returned 0 after 1291 usecs
[    3.370389] calling  packet_init+0x0/0x90 @ 1
[    3.371173] NET: Registered PF_PACKET protocol family
[    3.372057] initcall packet_init+0x0/0x90 returned 0 after 891 usecs
[    3.373155] calling  init_rpcsec_gss+0x0/0x70 @ 1
[    3.373965] initcall init_rpcsec_gss+0x0/0x70 returned 0 after 12 usecs
[    3.375146] calling  init_kerberos_module+0x0/0x40 @ 1
[    3.376125] initcall init_kerberos_module+0x0/0x40 returned 0 after 6 usecs
[    3.378016] calling  init_p9+0x0/0x30 @ 1
[    3.378789] 9pnet: Installing 9P2000 support
[    3.379553] initcall init_p9+0x0/0x30 returned 0 after 782 usecs
[    3.380641] calling  p9_trans_fd_init+0x0/0x30 @ 1
[    3.381571] initcall p9_trans_fd_init+0x0/0x30 returned 0 after 3 usecs
[    3.382778] calling  p9_virtio_init+0x0/0x60 @ 1
[    3.383596] initcall p9_virtio_init+0x0/0x60 returned 0 after 10 usecs
[    3.384719] calling  init_dns_resolver+0x0/0x100 @ 1
[    3.385619] Key type dns_resolver registered
[    3.386369] initcall init_dns_resolver+0x0/0x100 returned 0 after 762 usecs
[    3.387625] calling  handshake_init+0x0/0xa0 @ 1
[    3.388464] initcall handshake_init+0x0/0xa0 returned 0 after 18 usecs
[    3.389615] calling  pm_check_save_msr+0x0/0xd0 @ 1
[    3.390488] initcall pm_check_save_msr+0x0/0xd0 returned 0 after 12 usecs
[    3.391723] calling  mcheck_init_device+0x0/0x160 @ 1
[    3.395805] initcall mcheck_init_device+0x0/0x160 returned 0 after 3179 usecs
[    3.397208] calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x30 @ 1
[    3.398304] initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x30 returned 0 after 5 usecs
[    3.399738] calling  sld_mitigate_sysctl_init+0x0/0x30 @ 1
[    3.400694] initcall sld_mitigate_sysctl_init+0x0/0x30 returned 0 after 1 usecs
[    3.400728] ata1: SATA link down (SStatus 0 SControl 300)
[    3.402146] calling  intel_epb_init+0x0/0xa0 @ 1
[    3.402149] initcall intel_epb_init+0x0/0xa0 returned -19 after 0 usecs
[    3.403753] ata6: SATA link down (SStatus 0 SControl 300)
[    3.404334] calling  mcheck_late_init+0x0/0x80 @ 1
[    3.405963] ata5: SATA link down (SStatus 0 SControl 300)
[    3.406750] initcall mcheck_late_init+0x0/0x80 returned 0 after 13 usecs
[    3.408209] ata2: SATA link down (SStatus 0 SControl 300)
[    3.408800] calling  severities_debugfs_init+0x0/0x30 @ 1
[    3.410646] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.411236] initcall severities_debugfs_init+0x0/0x30 returned 0 after 2 usecs
[    3.412515] ata4: SATA link down (SStatus 0 SControl 300)
[    3.413229] calling  microcode_init+0x0/0x1f0 @ 1
[    3.414513] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    3.415395] initcall microcode_init+0x0/0x1f0 returned -22 after 0 usecs
[    3.415398] calling  cpu_init_debugfs+0x0/0xc0 @ 1
[    3.416162] ata3.00: applying bridge limits
[    3.417147] initcall cpu_init_debugfs+0x0/0xc0 returned 0 after 34 usecs
[    3.418435] ata3.00: configured for UDMA/100
[    3.419135] calling  hpet_insert_resource+0x0/0x30 @ 1
[    3.420333] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    3.421011] initcall hpet_insert_resource+0x0/0x30 returned 0 after 2 usecs
[    3.422812] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    3.422818] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.424035] calling  start_sync_check_timer+0x0/0x60 @ 1
[    3.425511] sr 2:0:0:0: [sr0] Hmm, seems the drive doesn't support multisession CD's
[    3.426368] initcall start_sync_check_timer+0x0/0x60 returned 0 after 0 usecs
[    3.429503] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    3.429861] calling  update_mp_table+0x0/0x6a0 @ 1
[    3.430993] probe of 2:0:0:0 returned 0 after 8832 usecs
[    3.431793] initcall update_mp_table+0x0/0x6a0 returned 0 after 0 usecs
[    3.432769] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    3.433567] calling  lapic_insert_resource+0x0/0x50 @ 1
[    3.436437] initcall lapic_insert_resource+0x0/0x50 returned 0 after 0 usecs
[    3.437624] calling  print_ipi_mode+0x0/0x40 @ 1
[    3.438398] IPI shorthand broadcast: enabled
[    3.439118] initcall print_ipi_mode+0x0/0x40 returned 0 after 720 usecs
[    3.440252] calling  print_ICs+0x0/0x100 @ 1
[    3.441072] initcall print_ICs+0x0/0x100 returned 0 after 0 usecs
[    3.442172] calling  setup_efi_kvm_sev_migration+0x0/0x10 @ 1
[    3.443212] initcall setup_efi_kvm_sev_migration+0x0/0x10 returned 0 after 0 usecs
[    3.444569] calling  create_tlb_single_page_flush_ceiling+0x0/0x30 @ 1
[    3.445677] initcall create_tlb_single_page_flush_ceiling+0x0/0x30 returned 0 after 3 usecs
[    3.447067] calling  pat_memtype_list_init+0x0/0x40 @ 1
[    3.447939] initcall pat_memtype_list_init+0x0/0x40 returned 0 after 1 usecs
[    3.449112] calling  create_init_pkru_value+0x0/0x40 @ 1
[    3.450003] initcall create_init_pkru_value+0x0/0x40 returned 0 after 0 usecs
[    3.451190] calling  kernel_panic_sysctls_init+0x0/0x30 @ 1
[    3.452131] initcall kernel_panic_sysctls_init+0x0/0x30 returned 0 after 4 usecs
[    3.453365] calling  kernel_panic_sysfs_init+0x0/0x20 @ 1
[    3.454275] initcall kernel_panic_sysfs_init+0x0/0x20 returned 0 after 3 usecs
[    3.455477] calling  kernel_exit_sysctls_init+0x0/0x30 @ 1
[    3.456466] initcall kernel_exit_sysctls_init+0x0/0x30 returned 0 after 1 usecs
[    3.457794] calling  kernel_exit_sysfs_init+0x0/0x20 @ 1
[    3.458717] initcall kernel_exit_sysfs_init+0x0/0x20 returned 0 after 1 usecs
[    3.459908] calling  param_sysfs_builtin_init+0x0/0x1a0 @ 1
[    3.463389] initcall param_sysfs_builtin_init+0x0/0x1a0 returned 0 after 2541 usecs
[    3.464669] calling  reboot_ksysfs_init+0x0/0x80 @ 1
[    3.465520] initcall reboot_ksysfs_init+0x0/0x80 returned 0 after 7 usecs
[    3.466659] calling  sched_core_sysctl_init+0x0/0x30 @ 1
[    3.467612] initcall sched_core_sysctl_init+0x0/0x30 returned 0 after 2 usecs
[    3.468813] calling  sched_fair_sysctl_init+0x0/0x30 @ 1
[    3.469705] initcall sched_fair_sysctl_init+0x0/0x30 returned 0 after 0 usecs
[    3.470895] calling  sched_rt_sysctl_init+0x0/0x30 @ 1
[    3.471815] initcall sched_rt_sysctl_init+0x0/0x30 returned 0 after 1 usecs
[    3.472982] calling  sched_dl_sysctl_init+0x0/0x30 @ 1
[    3.473843] initcall sched_dl_sysctl_init+0x0/0x30 returned 0 after 1 usecs
[    3.475001] calling  sched_clock_init_late+0x0/0x90 @ 1
[    3.475877] sched_clock: Marking stable (3356012082, 118986578)->(3646806140, -171807480)
[    3.477959] initcall sched_clock_init_late+0x0/0x90 returned 0 after 2082 usecs
[    3.479231] calling  cpu_latency_qos_init+0x0/0x50 @ 1
[    3.480193] initcall cpu_latency_qos_init+0x0/0x50 returned 0 after 67 usecs
[    3.481377] calling  pm_debugfs_init+0x0/0x30 @ 1
[    3.482176] initcall pm_debugfs_init+0x0/0x30 returned 0 after 4 usecs
[    3.483339] calling  printk_late_init+0x0/0x170 @ 1
[    3.484206] initcall printk_late_init+0x0/0x170 returned 0 after 8 usecs
[    3.485325] calling  init_srcu_module_notifier+0x0/0x40 @ 1
[    3.486283] initcall init_srcu_module_notifier+0x0/0x40 returned 0 after 2 usecs
[    3.487528] calling  swiotlb_create_default_debugfs+0x0/0xb0 @ 1
[    3.488604] initcall swiotlb_create_default_debugfs+0x0/0xb0 returned 0 after 11 usecs
[    3.490018] calling  tk_debug_sleep_time_init+0x0/0x30 @ 1
[    3.490960] initcall tk_debug_sleep_time_init+0x0/0x30 returned 0 after 1 usecs
[    3.492180] calling  kernel_acct_sysctls_init+0x0/0x30 @ 1
[    3.493101] initcall kernel_acct_sysctls_init+0x0/0x30 returned 0 after 1 usecs
[    3.494317] calling  kexec_core_sysctl_init+0x0/0x30 @ 1
[    3.495209] initcall kexec_core_sysctl_init+0x0/0x30 returned 0 after 1 usecs
[    3.496396] calling  bpf_rstat_kfunc_init+0x0/0x10 @ 1
[    3.497257] initcall bpf_rstat_kfunc_init+0x0/0x10 returned 0 after 0 usecs
[    3.498523] calling  debugfs_kprobe_init+0x0/0x80 @ 1
[    3.499384] initcall debugfs_kprobe_init+0x0/0x80 returned 0 after 4 usecs
[    3.500555] calling  kernel_delayacct_sysctls_init+0x0/0x30 @ 1
[    3.501569] initcall kernel_delayacct_sysctls_init+0x0/0x30 returned 0 after 1 usecs
[    3.502860] calling  taskstats_init+0x0/0x40 @ 1
[    3.503714] registered taskstats version 1
[    3.504467] initcall taskstats_init+0x0/0x40 returned 0 after 761 usecs
[    3.505651] calling  load_system_certificate_list+0x0/0x40 @ 1
[    3.506657] Loading compiled-in X.509 certificates
[    3.507550] initcall load_system_certificate_list+0x0/0x40 returned 0 after 893 usecs
[    3.508878] calling  fault_around_debugfs+0x0/0x30 @ 1
[    3.509750] initcall fault_around_debugfs+0x0/0x30 returned 0 after 1 usecs
[    3.510910] calling  slab_sysfs_init+0x0/0x120 @ 1
[    3.512701] initcall slab_sysfs_init+0x0/0x120 returned 0 after 965 usecs
[    3.513875] calling  max_swapfiles_check+0x0/0x10 @ 1
[    3.514788] initcall max_swapfiles_check+0x0/0x10 returned 0 after 0 usecs
[    3.515990] calling  hugetlb_vmemmap_init+0x0/0x90 @ 1
[    3.516883] initcall hugetlb_vmemmap_init+0x0/0x90 returned 0 after 6 usecs
[    3.518074] calling  mempolicy_sysfs_init+0x0/0x270 @ 1
[    3.518952] initcall mempolicy_sysfs_init+0x0/0x270 returned 0 after 2 usecs
[    3.520140] calling  check_early_ioremap_leak+0x0/0x50 @ 1
[    3.521064] initcall check_early_ioremap_leak+0x0/0x50 returned 0 after 0 usecs
[    3.522283] calling  init_root_keyring+0x0/0x10 @ 1
[    3.523144] initcall init_root_keyring+0x0/0x10 returned 0 after 35 usecs
[    3.524281] calling  integrity_fs_init+0x0/0x20 @ 1
[    3.525139] initcall integrity_fs_init+0x0/0x20 returned -19 after 0 usecs
[    3.526312] calling  crypto_algapi_init+0x0/0x10 @ 1
[    3.527231] initcall crypto_algapi_init+0x0/0x10 returned 0 after 2 usecs
[    3.528418] calling  blk_timeout_init+0x0/0x20 @ 1
[    3.529226] initcall blk_timeout_init+0x0/0x20 returned 0 after 0 usecs
[    3.530332] calling  depot_debugfs_init+0x0/0x40 @ 1
[    3.531221] initcall depot_debugfs_init+0x0/0x40 returned 0 after 3 usecs
[    3.532428] calling  pci_resource_alignment_sysfs_init+0x0/0x20 @ 1
[    3.533528] initcall pci_resource_alignment_sysfs_init+0x0/0x20 returned 0 after 3 usecs
[    3.534981] calling  pci_sysfs_init+0x0/0x90 @ 1
[    3.535837] initcall pci_sysfs_init+0x0/0x90 returned 0 after 13 usecs
[    3.536980] calling  dmar_free_unused_resources+0x0/0xd0 @ 1
[    3.537990] initcall dmar_free_unused_resources+0x0/0xd0 returned 0 after 0 usecs
[    3.539234] calling  sync_state_resume_initcall+0x0/0x10 @ 1
[    3.540193] initcall sync_state_resume_initcall+0x0/0x10 returned 0 after 0 usecs
[    3.541553] calling  deferred_probe_initcall+0x0/0x90 @ 1
[    3.542518] initcall deferred_probe_initcall+0x0/0x90 returned 0 after 15 usecs
[    3.543749] calling  late_resume_init+0x0/0x190 @ 1
[    3.544709] PM:   Magic number: 12:109:834
[    3.545577] initcall late_resume_init+0x0/0x190 returned 0 after 869 usecs
[    3.546795] calling  init_netconsole+0x0/0x2d0 @ 1
[    3.547620] printk: legacy console [netcon0] enabled
[    3.548451] netconsole: network logging started
[    3.549216] initcall init_netconsole+0x0/0x2d0 returned 0 after 1608 usecs
[    3.550368] calling  acpi_cpufreq_init+0x0/0x20 @ 1
[    3.551233] initcall acpi_cpufreq_init+0x0/0x20 returned -19 after 18 usecs
[    3.552395] calling  firmware_memmap_init+0x0/0x40 @ 1
[    3.553275] initcall firmware_memmap_init+0x0/0x40 returned 0 after 15 usecs
[    3.554451] calling  register_update_efi_random_seed+0x0/0x30 @ 1
[    3.555481] initcall register_update_efi_random_seed+0x0/0x30 returned 0 after 0 usecs
[    3.556907] calling  efi_shutdown_init+0x0/0x50 @ 1
[    3.557788] initcall efi_shutdown_init+0x0/0x50 returned -19 after 0 usecs
[    3.558950] calling  efi_earlycon_unmap_fb+0x0/0x50 @ 1
[    3.559826] initcall efi_earlycon_unmap_fb+0x0/0x50 returned 0 after 0 usecs
[    3.561001] calling  bpf_kfunc_init+0x0/0x10 @ 1
[    3.561778] initcall bpf_kfunc_init+0x0/0x10 returned 0 after 0 usecs
[    3.562864] calling  init_subsystem+0x0/0x10 @ 1
[    3.563647] initcall init_subsystem+0x0/0x10 returned 0 after 3 usecs
[    3.564733] calling  xdp_metadata_init+0x0/0x10 @ 1
[    3.565551] initcall xdp_metadata_init+0x0/0x10 returned 0 after 0 usecs
[    3.566666] calling  tcp_congestion_default+0x0/0x20 @ 1
[    3.567563] initcall tcp_congestion_default+0x0/0x20 returned 0 after 3 usecs
[    3.568755] calling  ip_auto_config+0x0/0x1410 @ 1
[    3.569566] initcall ip_auto_config+0x0/0x1410 returned 0 after 5 usecs
[    3.570667] calling  regulatory_init_db+0x0/0x100 @ 1
[    3.571528] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.573364] kworker/u93:0 (406) used greatest stack depth: 14320 bytes left
[    3.574165] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.574976] kworker/u93:0 (407) used greatest stack depth: 14264 bytes left
[    3.576159] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    3.578662] initcall regulatory_init_db+0x0/0x100 returned 0 after 7140 usecs
[    3.579895] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.581336] cfg80211: failed to load regulatory.db
[    3.582239] calling  pci_mmcfg_late_insert_resources+0x0/0x70 @ 1
[    3.583319] initcall pci_mmcfg_late_insert_resources+0x0/0x70 returned 0 after 1 usecs
[    3.585162] calling  software_resume_initcall+0x0/0x110 @ 1
[    3.586318] initcall software_resume_initcall+0x0/0x110 returned -2 after 6 usecs
[    3.587652] calling  trace_eval_sync+0x0/0x20 @ 1
[    3.588560] initcall trace_eval_sync+0x0/0x20 returned 0 after 25 usecs
[    3.589818] calling  late_trace_init+0x0/0xc0 @ 1
[    3.590715] initcall late_trace_init+0x0/0xc0 returned 0 after 0 usecs
[    3.591949] calling  alsa_sound_last_init+0x0/0x90 @ 1
[    3.592915] ALSA device list:
[    3.593462]   No soundcards found.
[    3.594065] initcall alsa_sound_last_init+0x0/0x90 returned 0 after 1150 usecs
[    3.595315] Warning: unable to open an initial console.
[    3.598182] Freeing unused kernel image (initmem) memory: 3396K
[    3.610098] Write protecting the kernel read-only data: 26624k
[    3.612697] Freeing unused kernel image (rodata/data gap) memory: 1284K
[    3.660546] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.661690] x86/mm: Checking user space page tables
[    3.706835] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.707941] Run /init as init process
[    3.708563]   with arguments:
[    3.709082]     /init
[    3.709492]     nokaslr
[    3.709908]   with environment:
[    3.710489]     HOME=/
[    3.710898]     TERM=linux
[    3.728193] rcu: Offloading 25
[    3.728852] rcu: Offloading 34
[    3.729628] rcu: Offloading 31
[    3.792162] rcu: De-offloading 4
[    3.794021] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    3.795713] probe of serio1 returned 0 after 625772 usecs
[    3.800115] rcu: Offloading 4
[    6.304936] rcu: Offloading 21
[    6.309198] rcu: Offloading 20
[    6.309675] rcu-torture: rcu_torture_read_exit: End of episode
[    7.449223] rcu: Offloading 11
[    7.450378] rcu: Offloading 10
[    7.451616] rcu: De-offloading 3
[    7.452596] rcu: Offloading 15
[    7.453376] rcu: Offloading 39
[    8.472348] rcu: Offloading 26
[    9.526156] rcu: Offloading 22
[    9.549174] rcu: Offloading 17
[    9.571545] rcu: De-offloading 21
[    9.582336] rcu: Offloading 18
[    9.665083] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1526568508187 wd_nsec: 496085944
[   10.702722] rcu: Offloading 27
[   10.704212] rcu: De-offloading 11
[   10.705342] rcu: De-offloading 31
[   12.125266] rcu: Offloading 9
[   12.126176] rcu: Offloading 8
[   12.126973] rcu: Offloading 40
[   12.128067] rcu: Offloading 13
[   12.128979] rcu: De-offloading 7
[   13.733248] rcu: Offloading 28
[   13.784225] rcu: Offloading 23
[   13.785255] rcu: Offloading 2
[   13.786144] rcu: Offloading 11
[   13.789042] rcu: Offloading 16
[   15.096248] rcu: De-offloading 20
[   15.097193] rcu: De-offloading 27
[   15.098055] rcu: De-offloading 25
[   15.098808] rcu: De-offloading 8
[   15.099652] rcu: Offloading 38
[   16.127807] rcu: De-offloading 26
[   16.142629] rcu: Offloading 29
[   16.193841] rcu: De-offloading 17
[   16.512191] rcu-torture: rtc: 0000000038f74bec ver: 467 tfle: 0 rta: 467 rtaf: 0 rtf: 456 rtmbe: 0 rtmbkf: 0/452 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 26373 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 84/84:0 read-exits: 16 nocb-toggles: 39:41
[   16.517127] rcu-torture: Reader Pipe:  41307093 2187 0 0 0 0 0 0 0 0 0
[   16.518544] rcu-torture: Reader Batch:  41304132 5148 0 0 0 0 0 0 0 0 0
[   16.520273] rcu-torture: Free-Block Circulation:  468 466 465 464 463 462 461 460 458 457 0
[   17.192181] rcu: De-offloading 18
[   17.213203] rcu: Offloading 3
[   17.591005] rcu: Offloading 12
[   17.591827] rcu: De-offloading 11
[   18.539096] rcu: Offloading 42
[   18.928156] rcu: Offloading 17
[   18.929109] rcu: De-offloading 23
[   18.930145] rcu: Offloading 27
[   19.544081] rcu: De-offloading 28
[   19.557056] rcu: De-offloading 40
[   19.648036] rcu-torture: rcu_torture_read_exit: Start of episode
[   19.652874] rcu-torture: rcu_torture_read_exit: End of episode
[   19.999552] rcu: De-offloading 22
[   20.000651] rcu: De-offloading 6
[   20.002134] rcu: De-offloading 5
[   21.048152] rcu: Offloading 6
[   21.048920] rcu: De-offloading 3
[   21.049734] rcu: Offloading 5
[   21.087086] rcu: De-offloading 9
[   21.107294] rcu: De-offloading 1
[   22.054820] rcu: De-offloading 12
[   22.067008] rcu: De-offloading 42
[   22.115344] rcu: Offloading 40
[   22.134167] rcu: De-offloading 17
[   22.187343] rcu: Offloading 19
[   23.173149] rcu: Offloading 37
[   23.179048] rcu: Offloading 18
[   23.185713] rcu: De-offloading 19
[   23.265507] rcu: Offloading 23
[   24.302182] rcu: Offloading 14
[   24.303139] rcu: Offloading 33
[   24.304118] rcu: De-offloading 14
[   24.305849] rcu: Offloading 36
[   24.859273] rcu: Offloading 42
[   25.309487] rcu: De-offloading 38
[   25.344336] rcu: Offloading 25
[   25.366186] rcu: Offloading 35
[   25.367012] rcu: De-offloading 10
[   25.427659] rcu: De-offloading 37
[   26.426886] rcu: Offloading 12
[   26.484049] rcu: Offloading 20
[   26.959177] rcu: De-offloading 5
[   31.872040] rcu-torture: rtc: 000000006d378f27 ver: 909 tfle: 0 rta: 909 rtaf: 0 rtf: 900 rtmbe: 0 rtmbkf: 0/885 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 53946 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 164/164:0 read-exits: 32 nocb-toggles: 74:78
[   31.875373] rcu-torture: Reader Pipe:  85199772 4280 0 0 0 0 0 0 0 0 0
[   31.876377] rcu-torture: Reader Batch:  85194247 9805 0 0 0 0 0 0 0 0 0
[   31.877421] rcu-torture: Free-Block Circulation:  908 908 907 906 905 904 903 902 901 900 0
[   32.306238] rcu: De-offloading 12
[   32.307612] rcu: Offloading 24
[   32.310010] rcu: Offloading 3
[   32.311324] rcu: Offloading 28
[   32.967999] rcu-torture: torture_onoff end holdoff
[   33.280043] rcu-torture: rcu_torture_read_exit: Start of episode
[   33.284593] rcu-torture: rcu_torture_read_exit: End of episode
[   33.677152] rcu: Offloading 17
[   33.678365] rcu: Offloading 22
[   33.679261] rcu: De-offloading 27
[   33.680265] rcu: Offloading 1
[   33.680848] rcu: De-offloading 17
[   33.693309] kworker/dying (71) used greatest stack depth: 13984 bytes left
[   33.703139] hrtimer: interrupt took 4421242 ns
[   33.826558] smpboot: CPU 6 is now offline
[   34.816222] rcu: De-offloading 15
[   34.817147] rcu: Offloading 19
[   34.818120] rcu: Offloading 32
[   34.819118] rcu: NOCB: Cannot CB-deoffload offline CPU 6
[   34.872924] smpboot: CPU 5 is now offline
[   35.976383] rcu: De-offloading 34
[   35.977559] rcu: De-offloading 19
[   35.978558] rcu: Offloading 14
[   35.979641] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   37.213149] rcu: De-offloading 35
[   37.214055] rcu: De-offloading 29
[   37.215007] rcu: De-offloading 0
[   37.215830] rcu: Offloading 35
[   37.216948] rcu: Offloading 9
[   37.217819] rcu: Offloading 38
[   37.638228] smpboot: CPU 7 is now offline
[   38.868491] rcu: De-offloading 35
[   38.885314] rcu: De-offloading 36
[   39.031846] smpboot: CPU 1 is now offline
[   40.210119] rcu: De-offloading 42
[   40.211934] rcu: Offloading 10
[   40.212870] rcu: De-offloading 10
[   40.213778] rcu: De-offloading 22
[   40.214754] rcu: De-offloading 38
[   40.215714] rcu: NOCB: Cannot CB-offload offline CPU 7
[   40.346524] smpboot: CPU 5 is now offline
[   41.258536] rcu: Offloading 30
[   41.268665] rcu: De-offloading 20
[   41.281205] rcu: Offloading 37
[   41.304313] rcu: Offloading 35
[   41.306456] rcu: Offloading 41
[   41.317165] rcu: Offloading 34
[   41.379392] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   42.544338] rcu: Offloading 27
[   42.545336] rcu: De-offloading 16
[   42.546254] rcu: Offloading 20
[   42.547613] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   43.552224] rcu: Offloading 38
[   43.571002] rcu: De-offloading 41
[   43.572057] rcu: De-offloading 24
[   43.573048] rcu: De-offloading 23
[   43.921273] rcu: De-offloading 2
[   43.922324] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   45.438205] rcu: De-offloading 20
[   45.455345] rcu: Offloading 24
[   45.457740] rcu: Offloading 22
[   45.459755] rcu: De-offloading 1
[   45.494965] smpboot: CPU 6 is now offline
[   46.612266] rcu: Offloading 41
[   46.613151] rcu: De-offloading 13
[   46.614163] rcu: De-offloading 3
[   46.615146] rcu: Offloading 36
[   46.976030] rcu-torture: rcu_torture_read_exit: Start of episode
[   46.980349] rcu-torture: rcu_torture_read_exit: End of episode
[   47.232009] rcu-torture: rtc: 0000000033669652 ver: 1351 tfle: 0 rta: 1352 rtaf: 0 rtf: 1341 rtmbe: 0 rtmbkf: 0/1320 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 89776 onoff: 4/4:6/6 64,417:45,860 803:2719 (HZ=1000) barrier: 218/219:0 read-exits: 64 nocb-toggles: 127:121
[   47.236772] rcu-torture: Reader Pipe:  142757514 6322 0 0 0 0 0 0 0 0 0
[   47.238052] rcu-torture: Reader Batch:  142748912 14924 0 0 0 0 0 0 0 0 0
[   47.239481] rcu-torture: Free-Block Circulation:  1351 1350 1349 1348 1347 1346 1345 1344 1343 1341 0
[   47.591592] smpboot: CPU 2 is now offline
[   47.629075] rcu: Offloading 7
[   47.629873] rcu: Offloading 1
[   47.648226] rcu: Offloading 21
[   47.666596] rcu: Offloading 23
[   47.667506] rcu: Offloading 42
[   47.668386] rcu: De-offloading 4
[   47.714153] rcu: De-offloading 7
[   49.269021] rcu: Offloading 31
[   49.270105] rcu: Offloading 4
[   49.274689] rcu: Offloading 12
[   49.275722] rcu: De-offloading 25
[   49.276886] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   50.681476] rcu: Offloading 25
[   50.682533] rcu: De-offloading 40
[   50.683552] rcu: De-offloading 6
[   50.913390] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   51.726100] rcu: De-offloading 9
[   51.742268] rcu: De-offloading 36
[   51.754564] rcu: Offloading 26
[   51.784915] rcu: De-offloading 41
[   52.754661] rcu: De-offloading 24
[   52.810641] rcu: Offloading 41
[   52.847079] rcu: Offloading 20
[   52.878285] rcu: Offloading 29
[   53.320319] smpboot: CPU 7 is now offline
[   54.333093] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   55.411602] smpboot: CPU 1 is now offline
[   56.433696] smpboot: CPU 3 is now offline
[   57.455003] smpboot: CPU 6 is now offline
[   58.320307] rcu: De-offloading 31
[   58.324100] rcu: De-offloading 34
[   58.325159] rcu: De-offloading 29
[   58.326155] rcu: Offloading 2
[   58.327079] rcu: De-offloading 32
[   58.328127] rcu: Offloading 19
[   58.695061] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   59.440702] rcu: De-offloading 23
[   59.441818] rcu: De-offloading 20
[   59.445229] rcu: Offloading 11
[   59.446148] rcu: Offloading 15
[   59.452618] rcu: NOCB: Cannot CB-offload offline CPU 5
[   59.455889] rcu: De-offloading 37
[   59.983692] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   60.288010] rcu-torture: rcu_torture_read_exit: Start of episode
[   60.293419] rcu-torture: rcu_torture_read_exit: End of episode
[   60.628239] rcu: Offloading 40
[   60.629000] rcu: De-offloading 1
[   60.632998] rcu: De-offloading 39
[   60.634413] rcu: Offloading 13
[   60.635197] rcu: De-offloading 14
[   60.636156] rcu: Offloading 1
[   61.304813] rcu-torture: torture_shutdown task shutting down system
[   61.306307] rcu-torture: rcu_torture_reader is stopping
[   61.306308] rcu-torture: rcu_torture_reader is stopping
[   61.306308] rcu-torture: rcu_torture_reader is stopping
[   61.306309] rcu-torture: Stopping torture_shuffle task
[   61.306309] rcu-torture: rcu_torture_reader is stopping
[   61.306309] rcu-torture: rcu_torture_reader is stopping
[   61.306309] rcu-torture: rcu_torture_reader is stopping
[   61.306309] rcu-torture: rcu_torture_reader is stopping
[   61.306355] rcu-torture: torture_shuffle is stopping
[   61.306387] rcu-torture: Stopping torture_stutter task
[   61.306426] rcu-torture: torture_stutter is stopping
[   61.306482] rcu-torture: Stopping torture_onoff task
[   61.306510] rcu-torture: torture_onoff is stopping
[   61.307240] rcu-torture: rcu_torture_fakewriter is stopping
[   61.307474] rcu-torture: rcu_torture_fakewriter is stopping
[   61.311187] rcu-torture: rcu_torture_writer is stopping
[   61.313098] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   61.315006] rcu-torture: rcu_torture_fakewriter is stopping
[   61.322046] rcu-torture: rcu_torture_fakewriter is stopping
[   61.391026] rcu-torture: rcu_torture_barrier is stopping
[   61.412889] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   61.452833] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 21 ->gp_activity 1 ->gp_req_activity 21 ->gp_wake_time 27 ->gp_wake_seq 11149 ->gp_seq 11153 ->gp_seq_needed 11152 ->gp_max 318 ->gp_flags 0x0
[   61.456849] rcu: 	rcu_node 0:42 ->gp_seq 11157 ->gp_seq_needed 11156 ->qsmask 0x7 .... ->n_boosts 0
[   61.458471] rcu: 	rcu_node 0:14 ->gp_seq 11157 ->gp_seq_needed 11164 ->qsmask 0x4 .... ->n_boosts 0
[   61.460155] rcu: 	cpu 0 ->gp_seq_needed 11164
[   61.460894] rcu: 	cpu 2 ->gp_seq_needed 11164
[   61.461678] rcu: 	cpu 3 ->gp_seq_needed 11160
[   61.462429] rcu: 	cpu 5 ->gp_seq_needed 11160
[   61.463180] rcu: 	cpu 6 ->gp_seq_needed 11164
[   61.463952] rcu: 	rcu_node 15:29 ->gp_seq 11157 ->gp_seq_needed 11164 ->qsmask 0x0 .... ->n_boosts 0
[   61.465548] rcu: 	cpu 20 ->gp_seq_needed 11164
[   61.466317] rcu:    CB 1^0->-1 KbclSW F226 L226 C0 ..... q0 S CPU 2
[   61.467449] rcu:    CB 2^0->1 KbclSW F227 L227 C0 ..... q0 S CPU 0
[   61.468656] rcu:    CB 4^0->2 KbclSW F164 L164 C0 ..... q0 S CPU 25
[   61.469840] rcu:    CB 11^7->13 KbclSW F1175 L1177 C1 ..... q0 S CPU 8
[   61.471085] rcu:    CB 12^7->11 KbclSW F165 L165 C0 ..... q0 S CPU 3
[   61.472281] rcu:    CB 13^7->-1 KbclSW F14859 L18801 C0 ..... q0 S CPU 3
[   61.473508] rcu:    CB 15^14->-1 KbclSW F26657 L26658 C0 ..... q0 S CPU 15
[   61.474773] rcu:    CB 18^14->19 KbclSW F1174 L1174 C0 ..... q0 S CPU 25
[   61.476016] rcu:    CB 19^14->15 KbclSW F1176 L1176 C0 ..... q0 S CPU 19
[   61.477246] rcu: nocb GP 21 KldtS W[..] ..:0 rnp 15:29 56 S CPU 24
[   61.478404] rcu:    CB 21^21->25 KbclSW F51906 L55165 C0 ..... q0 S CPU 0
[   61.479609] rcu:    CB 22^21->21 KbclSW F21265 L4294728615 C0 ..... q0 S CPU 17
[   61.480859] rcu:    CB 25^21->26 KbclSW F5039 L5039 C0 ..... q0 S CPU 16
[   61.482007] rcu:    CB 26^21->-1 KbclSW F4035 L4035 C2 ..... q0 S CPU 0
[   61.483137] rcu:    CB 27^21->22 KbclSW F1189 L1193 C2 ..... q0 S CPU 18
[   61.484276] rcu: nocb GP 28 KldtS W[..] ..:0 rnp 15:29 95287 S CPU 8
[   61.485453] rcu:    CB 28^28->30 KbclSW F181 L181 C0 ..... q0 S CPU 19
[   61.486559] rcu:    CB 30^28->-1 KbclSW F202 L202 C0 ..... q0 S CPU 2
[   61.487656] rcu:    CB 33^28->28 KbclSW F181 L181 C2 ..... q0 S CPU 16
[   61.488812] rcu: nocb GP 35 KldtS W[..] ..:0 rnp 30:42 562 S CPU 40
[   61.489967] rcu:    CB 35^35->38 KbclSW F1194 L1198 C2 ..... q0 S CPU 19
[   61.491105] rcu:    CB 38^35->41 KbclSW F1191 L1191 C0 ..... q0 S CPU 38
[   61.492289] rcu:    CB 40^35->-1 KbclSW F755 L826 C0 ..... q0 S CPU 14
[   61.493496] rcu:    CB 41^35->40 KbclSW F189 L189 C0 ..... q0 S CPU 40
[   61.494716] rcu: nocb GP 42 KldtS W[..] ..:0 rnp 30:42 26 S CPU 42
[   61.495882] rcu:    CB 42^42->-1 KbclSW F1200 L1203 C1 ..... q0 S CPU 16
[   61.497146] rcu: RCU callbacks invoked since boot: 123050
[   61.498163] rcu_tasks: RTGS_WAIT_CBS(11) since 61198 g:0 i:0/0 k.u. l:250 
[   61.499438] rcu_tasks_rude: RTGS_WAIT_CBS(11) since 61198 g:0 i:0/0 k.u. l:250 
[   61.709649] rcu-torture: rcu_nocb_toggle is stopping
[   61.717754] rcu-torture: rcu_nocb_toggle is stopping
[   61.717946] rcu-torture: rcu_nocb_toggle is stopping
[   61.722408] rcu-torture: rcu_nocb_toggle is stopping
[   61.723864] rcu-torture: rcu_nocb_toggle is stopping
[   61.738025] rcu-torture: rcu_nocb_toggle is stopping
[   61.742185] rcu-torture: rcu_nocb_toggle is stopping
[   61.756597] rcu-torture: rcu_nocb_toggle is stopping
[   62.336102] rcu-torture: rcu_torture_read_exit is stopping
[   62.336146] rcu-torture: Stopping rcutorture_read_exit task
[   62.338117] rcu-torture: Stopping rcu_torture_barrier task
[   62.339205] rcu-torture: Stopping rcu_torture_barrier_cbs task
[   62.346183] rcu-torture: rcu_torture_barrier_cbs is stopping
[   62.347161] rcu-torture: Stopping rcu_torture_barrier_cbs task
[   62.355052] rcu-torture: rcu_torture_barrier_cbs is stopping
[   62.355906] rcu-torture: Stopping rcu_torture_barrier_cbs task
[   62.364031] rcu-torture: rcu_torture_barrier_cbs is stopping
[   62.365181] rcu-torture: Stopping rcu_torture_barrier_cbs task
[   62.371239] rcu-torture: rcu_torture_barrier_cbs is stopping
[   62.372156] rcu-torture: Stopping rcu_torture_writer task
[   62.373271] rcu-torture: Stopping rcu_nocb_toggle task
[   62.374257] rcu-torture: Stopping rcu_nocb_toggle task
[   62.375251] rcu-torture: Stopping rcu_nocb_toggle task
[   62.376249] rcu-torture: Stopping rcu_nocb_toggle task
[   62.377270] rcu-torture: Stopping rcu_nocb_toggle task
[   62.378279] rcu-torture: Stopping rcu_nocb_toggle task
[   62.379269] rcu-torture: Stopping rcu_nocb_toggle task
[   62.380269] rcu-torture: Stopping rcu_nocb_toggle task
[   62.381270] rcu-torture: Stopping rcu_torture_reader task
[   62.382330] rcu-torture: Stopping rcu_torture_reader task
[   62.383394] rcu-torture: Stopping rcu_torture_reader task
[   62.384455] rcu-torture: Stopping rcu_torture_reader task
[   62.385519] rcu-torture: Stopping rcu_torture_reader task
[   62.386576] rcu-torture: Stopping rcu_torture_reader task
[   62.387671] rcu-torture: Stopping rcu_torture_reader task
[   62.388719] rcu-torture: Stopping rcu_torture_fakewriter task
[   62.389904] rcu-torture: Stopping rcu_torture_fakewriter task
[   62.391021] rcu-torture: Stopping rcu_torture_fakewriter task
[   62.392196] rcu-torture: Stopping rcu_torture_fakewriter task
[   62.393333] rcu:  End-test grace-period state: g11221 f0x0 total-gps=3089
[   62.394617] rcu-torture: Stopping rcu_torture_stats task
[   62.395659] rcu-torture: rtc: 0000000000000000 VER: 1674 tfle: 0 rta: 1674 rtaf: 0 rtf: 1665 rtmbe: 0 rtmbkf: 0/1631 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 112584 onoff: 9/9:11/11 51,828:20,860 2856:3186 (HZ=1000) barrier: 296/296:0 read-exits: 80 nocb-toggles: 162:150
[   62.399926] rcu-torture: Reader Pipe:  178129249 7810 0 0 0 0 0 0 0 0 0
[   62.401121] rcu-torture: Reader Batch:  178118693 18366 0 0 0 0 0 0 0 0 0
[   62.402350] rcu-torture: Free-Block Circulation:  1673 1673 1672 1671 1670 1669 1668 1667 1666 1665 0
[   62.404008] rcu-torture: rcu_torture_stats is stopping
[   62.404969] rcu_torture_cleanup: Invoking rcu_barrier+0x0/0x500().
[   62.447915] stackdepot: allocating hash table of 32768 entries via kvcalloc
[   62.449731] mem_dump_obj() slab test: rcu_torture_stats = 0000000000000000, &rhp = ffffc9000051be80, rhp = ffff888007296000, &z = ffffffff836658c0
[   62.452089] mem_dump_obj(ZERO_SIZE_PTR): zero-size pointer
[   62.453080] mem_dump_obj(NULL): NULL pointer
[   62.453851] mem_dump_obj(ffffc9000051be80): 4-page vmalloc region starting at 0xffffc90000518000 allocated at kernel_clone+0x99/0x3a0
[   62.456002] mem_dump_obj(ffff888007296000): slab rcuscale start ffff888007296000 pointer offset 0 size 136 allocated at rcu_torture_cleanup+0x4ad/0x960
[   62.458415]     kmem_cache_alloc+0x1f3/0x210
[   62.459199]     rcu_torture_cleanup+0x4ad/0x960
[   62.460022]     torture_shutdown+0xf5/0x220
[   62.460775]     kthread+0xe0/0x110
[   62.461398]     ret_from_fork+0x2f/0x40
[   62.462103]     ret_from_fork_asm+0x1a/0x30
[   62.462860] mem_dump_obj(ffff888007296008): slab rcuscale start ffff888007296000 pointer offset 8 size 136 allocated at rcu_torture_cleanup+0x4ad/0x960
[   62.465268]     kmem_cache_alloc+0x1f3/0x210
[   62.466046]     rcu_torture_cleanup+0x4ad/0x960
[   62.466866]     torture_shutdown+0xf5/0x220
[   62.467622]     kthread+0xe0/0x110
[   62.468247]     ret_from_fork+0x2f/0x40
[   62.468950]     ret_from_fork_asm+0x1a/0x30
[   62.469705] mem_dump_obj(ffffffff836658c0): non-slab/vmalloc memory
[   62.470888] mem_dump_obj() kmalloc test: rcu_torture_stats = 0000000000000000, &rhp = ffffc9000051be80, rhp = ffff888006186230
[   62.472920] mem_dump_obj(kmalloc ffff888006186230): slab kmalloc-16 start ffff888006186230 pointer offset 0 size 16
[   62.474779] mem_dump_obj(kmalloc ffff888006186238): slab kmalloc-16 start ffff888006186230 pointer offset 8 size 16
[   62.476656] mem_dump_obj() vmalloc test: rcu_torture_stats = 0000000000000000, &rhp = ffffc9000051be80, rhp = ffffc90000029000
[   62.478687] mem_dump_obj(vmalloc ffffc90000029000): 1-page vmalloc region starting at 0xffffc90000029000 allocated at rcu_torture_cleanup+0x624/0x960
[   62.481077] mem_dump_obj(vmalloc ffffc90000029008): 1-page vmalloc region starting at 0xffffc90000029000 allocated at rcu_torture_cleanup+0x624/0x960
[   62.483467] rcu-torture: rtc: 0000000000000000 VER: 1674 tfle: 0 rta: 1674 rtaf: 0 rtf: 1665 rtmbe: 0 rtmbkf: 0/1631 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 112584 onoff: 9/9:11/11 51,828:20,860 2856:3186 (HZ=1000) barrier: 296/296:0 read-exits: 80 nocb-toggles: 162:150
[   62.487678] rcu-torture: Reader Pipe:  178129249 7810 0 0 0 0 0 0 0 0 0
[   62.488898] rcu-torture: Reader Batch:  178118693 18366 0 0 0 0 0 0 0 0 0
[   62.490117] rcu-torture: Free-Block Circulation:  1673 1673 1672 1671 1670 1669 1668 1667 1666 1665 0
[   62.491771] rcu-torture:--- End of test: SUCCESS: nreaders=7 nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=60 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=1000 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=8 nocbs_toggle=1000 test_nmis=0
[   62.499904] i2c i2c-0: shutdown
[   62.500469] alarmtimer alarmtimer.0.auto: shutdown
[   62.501353] psmouse serio1: shutdown
[   62.502306] atkbd serio0: shutdown
[   62.503042] i8042 i8042: shutdown
[   62.503695] platform Fixed MDIO bus.0: shutdown
[   62.504634] serial8250 serial8250: shutdown
[   62.505448] platform pcspkr: shutdown
[   62.506117] platform regulatory.0: shutdown
[   62.506890] serial 00:04: shutdown
[   62.507510] pnp 00:03: shutdown
[   62.508087] i8042 aux 00:02: shutdown
[   62.508748] i8042 kbd 00:01: shutdown
[   62.509412] rtc_cmos 00:00: shutdown
[   62.510139] platform PNP0103:00: shutdown
[   62.510865] platform QEMU0002:00: shutdown
[   62.511667] i801_smbus 0000:00:1f.3: shutdown
[   62.512660] ahci 0000:00:1f.2: shutdown
[   62.513584] pci 0000:00:1f.0: shutdown
[   62.514269] pci 0000:00:01.0: shutdown
[   62.514950] pci 0000:00:00.0: shutdown
[   62.515685] ACPI: PM: Preparing to enter system sleep state S5
[   62.516940] PM: Calling mce_syscore_shutdown+0x0/0x10
[   62.517899] PM: Calling i8259A_shutdown+0x0/0x20
[   62.518761] reboot: Power down

