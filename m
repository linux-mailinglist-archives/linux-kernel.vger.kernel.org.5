Return-Path: <linux-kernel+bounces-18429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA7825D4E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06641C234A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E8E627;
	Sat,  6 Jan 2024 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EstvR7yw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22075636
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 00:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3C8C433C7;
	Sat,  6 Jan 2024 00:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704499541;
	bh=Jv0QLhl34t2O2tH/6SJ85TAZe1F/TWEzJ2TQMXv0r80=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EstvR7ywcCCPwJdNdEk3fFK0Kf/1EgcqADFScdToeaquPQCHO21HY6QpLy5CFNDj/
	 eBULmj4G+KE9NyyszQpJq5TqXIQbnS41l/j5aqVlqYoVW+OK37rflWVyZ184QadQEG
	 jWRFkxa2dU+Cyo/uVqYn7m1SCce3o3/HLWnpDRE9Lo4cpB1cL1ehBE0QiBJLnXpYRv
	 7hz6wEapN8sByoRzu+DxShM8XyVhbXQmNhNMsmn1lU2dlE1Y61nHJbJ2AJHqHPO507
	 0Cv18sgtvOegw9dPcmG/kYtF8gNuhCv0YBnAFejmWVCm8WARnvMVUDcIw0VJGsTmat
	 baK1kvwNHFWzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F42ECE1D34; Fri,  5 Jan 2024 16:05:41 -0800 (PST)
Date: Fri, 5 Jan 2024 16:05:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prototype patch to avoid TREE07 rcu_torture_writer() stalls
Message-ID: <3da2e014-ed54-4b2a-9fde-99d6eef3e897@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a40344c8-a260-41f3-bd7a-6a63d8660489@paulmck-laptop>
 <ZZiIQvu+2CGufvOL@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZiIQvu+2CGufvOL@lothringen>

On Fri, Jan 05, 2024 at 11:52:50PM +0100, Frederic Weisbecker wrote:
> On Wed, Jan 03, 2024 at 11:29:47AM -0800, Paul E. McKenney wrote:
> > Hello, Frederic,
> > 
> > You mentioned rcu_torture_writer() stall issues on TREE07.  Does the
> > patch shown below help?
> 
> Hmm, I fear that doesn't help.
> 
> > 
> > If so, I predict that your bisection will converge on commit af19a2526cba9
> > ("rcutorture: Add mid-sized stall to TREE07").
> 
> Nope I can reproduce several releases back (at least since 6.4 but maybe
> even before).
> 
> Here is a dmesg example:

RCU grace-period kthread starvation.  That is indeed something else!

> [    0.000000] Linux version 6.7.0-rc8-dirty (root@cuk) (gcc (SUSE Linux) 7.5.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.39.0.20220810-150100.7.40) #51 SMP Fri Jan  5 15:49:51 CET 2024
> [    0.000000] Command line: debug_boot_weak_hash panic=-1 selinux=0 initcall_debug debug console=ttyS0 rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=1800 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1 nohz_full=2-9

[ . . . ]

> [  161.516880] rcu_torture_fwd_prog_nr: 0 Duration 14116 cver 91 gps 78
> [  161.543421] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  161.566738] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  161.571198] rcu-torture: rtc: 00000000f265c3a1 ver: 3712 tfle: 0 rta: 3713 rtaf: 0 rtf: 3697 rtmbe: 0 rtmbkf: 0/1971 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 522350 onoff: 43/44:50/50 28,827:21,1484 6780:13720 (HZ=1000) barrier: 744/744:0 read-exits: 176 nocb-toggles: 0:0
> [  161.624992] rcu-torture: Reader Pipe:  201099524 19983 0 0 0 0 0 0 0 0 0
> [  161.636640] rcu-torture: Reader Batch:  201079044 40463 0 0 0 0 0 0 0 0 0
> [  161.648794] rcu-torture: Free-Block Circulation:  3712 3711 3710 3709 3707 3705 3703 3701 3699 3698 0
> [  162.682828] smpboot: CPU 1 is now offline
> [  163.747014] rcu-torture: rcu_torture_read_exit: Start of episode
> [  163.774236] rcu-torture: rcu_torture_read_exit: End of episode
> [  163.785123] smpboot: CPU 12 is now offline
> [  164.816157] smpboot: CPU 13 is now offline
> [  165.844847] smpboot: CPU 10 is now offline
> [  166.857617] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  167.900909] smpboot: CPU 13 is now offline
> [  168.922262] smpboot: CPU 2 is now offline
> [  176.970008] rcu-torture: rtc: 00000000abe7a7e8 ver: 3861 tfle: 0 rta: 3862 rtaf: 0 rtf: 3850 rtmbe: 0 rtmbkf: 0/2026 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 545828 onoff: 45/45:56/57 28,827:20,1484 7204:14029 (HZ=1000) barrier: 808/809:0 read-exits: 192 nocb-toggles: 0:0
> [  177.022952] rcu-torture: Reader Pipe:  210528233 20686 0 0 0 0 0 0 0 0 0
> [  177.034773] rcu-torture: Reader Batch:  210507122 41797 0 0 0 0 0 0 0 0 0
> [  177.046571] rcu-torture: Free-Block Circulation:  3861 3860 3859 3858 3857 3854 3853 3852 3851 3850 0
> [  177.123929] rcu-torture: rcu_torture_read_exit: Start of episode
> [  190.824862] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  190.837217] rcu: 	11-...!: (1 GPs behind) idle=d7fc/1/0x4000000000000000 softirq=8768/8770 fqs=1
> [  190.850431] rcu: 	(detected by 0, t=21002 jiffies, g=20577, q=26630 ncpus=5)
> [  190.861056] Sending NMI from CPU 0 to CPUs 11:
> [  200.956274] rcu: rcu_sched kthread starved for 20992 jiffies! g20577 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0

Ten seconds to get from the start of the stall to printing out the
"starved" message?  That is unusual.  Unless you have slow console
or something.

> [  200.974135] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> [  200.989843] rcu: RCU grace-period kthread stack dump:
> [  200.997714] task:rcu_sched       state:R  running task     stack:14840 pid:14    tgid:14    ppid:2      flags:0x00004000

And it is running, but apparently not all that quickly...

> [  201.014715] Call Trace:
> [  201.018704]  <TASK>
> [  201.022130]  __schedule+0x2e2/0xa30
> [  201.027858]  schedule+0x18/0x80
> [  201.033322]  schedule_timeout+0x198/0x2d0
> [  201.039818]  ? __pfx_process_timeout+0x10/0x10
> [  201.047099]  rcu_gp_fqs_loop+0x383/0x4d0
> [  201.053579]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [  201.060678]  rcu_gp_kthread+0x77/0x1d0
> [  201.067477]  kthread+0xc6/0xf0
> [  201.073114]  ? __pfx_kthread+0x10/0x10
> [  201.080465]  ret_from_fork+0x2b/0x40
> [  201.087313]  ? __pfx_kthread+0x10/0x10
> [  201.094106]  ret_from_fork_asm+0x1b/0x30
> [  201.101197]  </TASK>
> [  201.105223] rcu: Stack dump where RCU GP kthread last ran:
> [  201.115194] CPU: 0 PID: 140 Comm: rcu_torture_fak Not tainted 6.7.0-rc8-dirty #51
> [  201.128609] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-6-gb1b30830-rebuilt.opensuse.org 04/01/2014
> [  201.148518] RIP: 0010:smp_call_function_single+0xf0/0x120
> [  201.158384] Code: 83 c4 48 41 5a 5d 49 8d 62 f8 c3 cc cc cc cc 48 89 75 c0 48 8d 75 b0 48 89 55 c8 e8 0a fe ff ff 8b 55 b8 83 e2 01 74 0a f3 90 <8b> 55 b8 83 e2 01 75 f6 eb bc 8b 05 78 d6 33 02 85 c0 0f 85 63 ff
> [  201.193557] RSP: 0018:ffff9eed0051fe00 EFLAGS: 00000202
> [  201.203150] RAX: 0000000000000000 RBX: ffff94ad1f4ec100 RCX: ffff94ad1f2ec4c0
> [  201.215932] RDX: 0000000000000001 RSI: ffff9eed0051fe00 RDI: ffff9eed0051fe00
> [  201.229322] RBP: ffff9eed0051fe50 R08: 0000000000000003 R09: 0000000000000003
> [  201.242552] R10: ffff9eed0051fe80 R11: 00000000000000e1 R12: ffffffffb033f9b0
> [  201.255633] R13: 000000000002c100 R14: 000000000000000b R15: 000000000000000b
> [  201.267326] FS:  0000000000000000(0000) GS:ffff94ad1f200000(0000) knlGS:0000000000000000
> [  201.280527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  201.289855] CR2: ffff94ad13e01000 CR3: 0000000001adc000 CR4: 00000000000006f0
> [  201.301280] Call Trace:
> [  201.306048]  <IRQ>
> [  201.310029]  ? rcu_check_gp_kthread_starvation+0x10a/0x124
> [  201.322295]  ? rcu_sched_clock_irq+0x731/0x9d0
> [  201.331979]  ? update_process_times+0x56/0x80
> [  201.341053]  ? tick_sched_handle.isra.21+0x2a/0x40
> [  201.350662]  ? tick_nohz_highres_handler+0x6a/0x80
> [  201.357990]  ? __pfx_tick_nohz_highres_handler+0x10/0x10
> [  201.365587]  ? __hrtimer_run_queues+0x10c/0x230
> [  201.372257]  ? hrtimer_interrupt+0xe0/0x240
> [  201.378093]  ? __sysvec_apic_timer_interrupt+0x44/0xe0
> [  201.384871]  ? sysvec_apic_timer_interrupt+0x44/0x80
> [  201.391556]  </IRQ>
> [  201.394511]  <TASK>
> [  201.397379]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [  201.404583]  ? smp_call_function_single+0xf0/0x120
> [  201.411146]  ? __pfx_rcu_barrier_handler+0x10/0x10
> [  201.417520]  ? rcu_barrier+0x217/0x4c0
> [  201.422664]  rcu_barrier+0x217/0x4c0
> [  201.428607]  ? __pfx_rcu_torture_fakewriter+0x10/0x10
> [  201.436175]  rcu_torture_fakewriter+0x95/0x480
> [  201.444477]  kthread+0xc6/0xf0
> [  201.450114]  ? __pfx_kthread+0x10/0x10
> [  201.457164]  ret_from_fork+0x2b/0x40
> [  201.462499]  ? __pfx_kthread+0x10/0x10
> [  201.467573]  ret_from_fork_asm+0x1b/0x30
> [  201.472763]  </TASK>

Maybe things are stacked up behind a CPU spinning with interrupts
disabled?  That would cause trouble for smp_call_function_single().

> [  201.476199] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 11-...D } 31660 jiffies s: 28553 root: 0x2/.

This looks like the same cause, CPU 11.

> [  201.476403] rcu-torture: 
> [  201.496001] rcu: blocking rcu_node structures (internal RCU debug): l=1:8-15:0x1/. l=2:8-11:0x2/. l=3:10-11:0x2/.
> [  201.500853] rtc: 00000000abe7a7e8 ver: 3861 tfle: 0 rta: 3862 rtaf: 0 rtf: 3850 rtmbe: 0 rtmbkf: 0/2026 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 562192 onoff: 45/45:56/57 28,827:20,1484 7204:14029 (HZ=1000) barrier: 808/809:0 read-exits: 192 nocb-toggles: 0:0
> [  201.519343] Sending NMI from CPU 3 to CPUs 11:
> [  201.564392] rcu-torture: Reader Pipe:  215578794 20686 0 0 0 0 0 0 0 0 0
> [  201.564457] rcu-torture: Reader Batch:  215557683 41797 0 0 0 0 0 0 0 0 0
> [  201.596996] rcu-torture: Free-Block Circulation:  3861 3860 3859 3858 3857 3854 3853 3852 3851 3850 0
> [  201.616641] ??? Writer stall state RTWS_POLL_WAIT(17) g20577 f0x2 ->state 0x402 cpu 11
> [  201.631086] task:rcu_torture_wri state:I stack:14416 pid:139   tgid:139   ppid:2      flags:0x00004000
> [  201.645924] Call Trace:
> [  201.649864]  <TASK>
> [  201.653235]  __schedule+0x2e2/0xa30
> [  201.659334]  schedule+0x18/0x80
> [  201.664438]  schedule_hrtimeout_range_clock+0xa3/0x120
> [  201.672991]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [  201.680290]  torture_hrtimeout_ns+0x51/0x80
> [  201.687525]  rcu_torture_writer+0x961/0xdb0
> [  201.695087]  ? __pfx_rcu_torture_writer+0x10/0x10
> [  201.703129]  ? kthread+0xc6/0xf0
> [  201.708657]  ? __pfx_rcu_torture_writer+0x10/0x10
> [  201.716684]  kthread+0xc6/0xf0
> [  201.722158]  ? __pfx_kthread+0x10/0x10
> [  201.728567]  ret_from_fork+0x2b/0x40
> [  201.734767]  ? __pfx_kthread+0x10/0x10
> [  201.741554]  ret_from_fork_asm+0x1b/0x30
> [  201.748335]  </TASK>
> [  201.752612] rcu: rcu_sched: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x0 ->rt_priority 0 delta ->gp_start 31929 ->gp_activity 31919 ->gp_req_activity 31929 ->gp_wake_time 16671 ->gp_wake_seq 20577 ->gp_seq 20577 ->gp_seq_needed 20580 ->gp_max 804 ->gp_flags 0x2
> [  201.794135] rcu: 	rcu_node 0:15 ->gp_seq 20577 ->gp_seq_needed 20580 ->qsmask 0x2 .... ->n_boosts 0
> [  201.814161] rcu: 	rcu_node 8:15 ->gp_seq 20577 ->gp_seq_needed 20576 ->qsmask 0x1 .... ->n_boosts 0
> [  201.834605] rcu: 	rcu_node 8:11 ->gp_seq 20577 ->gp_seq_needed 20576 ->qsmask 0x2 .... ->n_boosts 0
> [  201.853192] rcu: 	rcu_node 0:1 ->gp_seq 20577 ->gp_seq_needed 20584 ->qsmask 0x0 .... ->n_boosts 0
> [  201.870244] rcu: 	cpu 0 ->gp_seq_needed 20580
> [  201.878647] rcu: 	rcu_node 10:11 ->gp_seq 20577 ->gp_seq_needed 20580 ->qsmask 0x2 .... ->n_boosts 0
> [  201.894363] rcu:    CB 2^0->3 KbclSW F32976 L32976 C0 ..... q0 S CPU 11
> [  201.906202] rcu:    CB 3^0->-1 KbclSW F32031 L32031 C0 ...N. q1 S CPU 0
> [  201.919364] rcu: nocb GP 4 Kldts W[..] ..:0 rnp 4:5 169611 R CPU 0!
> [  201.933289] rcu:    CB 4^4->5 KbclSW F37696 L37698 C0 ..... q0 S CPU 10
> [  201.946765] rcu:    CB 5^4->6 KbclSW F32071 L32071 C1 ...N. q2 S CPU 0
> [  201.959038] rcu:    CB 6^4->7 KbclSW F65914 L65926 C0 ..... q0 S CPU 12
> [  201.970970] rcu:    CB 7^4->-1 KbclSW F45412 L45726 C0 ..... q0 S CPU 14
> [  201.982265] rcu: nocb GP 8 KldtS W[..] ..:0 rnp 8:9 845 S CPU 13
> [  201.991794] rcu:    CB 8^8->9 KbclSW F56458 L56458 C0 ..... q0 S CPU 13
> [  202.001161] rcu:    CB 9^8->-1 KbclSW F48787 L49202 C2 ..... q0 S CPU 13
> [  202.011431] rcu: RCU callbacks invoked since boot: 711640
> [  202.019019] Dumping ftrace buffer:
> [  202.023738]    (ftrace buffer empty)
> [  204.057351] NMI backtrace for cpu 11
> [  204.057364] CPU: 11 PID: 152 Comm: rcu_torture_rea Not tainted 6.7.0-rc8-dirty #51
> [  204.057373] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-6-gb1b30830-rebuilt.opensuse.org 04/01/2014
> [  204.057378] RIP: 0010:rcutorture_one_extend+0x21/0x300
> [  204.057398] Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 41 89 f5 55 53 89 f5 f7 d5 48 83 ec 28 44 8b 27 48 89 54 24 18 48 89 3c 24 <48> 89 4c 24 08 44 89 e2 44 21 e5 f7 d2 21 f2 45 85 e4 41 89 d6 0f
> [  204.057405] RSP: 0000:ffff9eed0057fc08 EFLAGS: 00000292
> [  204.057412] RAX: 0000000000000000 RBX: ffff9eed0057fcb0 RCX: ffff9eed0057fdc8
> [  204.057416] RDX: ffff9eed0057fe80 RSI: 0000000000000000 RDI: ffff9eed0057fc9c
> [  204.057421] RBP: 00000000ffffffff R08: 0000000000000005 R09: 0000000000000000
> [  204.057424] R10: 000000000000505d R11: 0000000000000000 R12: 0000000000000001
> [  204.057427] R13: 0000000000000000 R14: ffffffffb0ccbbb0 R15: 0000000000000000
> [  204.057431] FS:  0000000000000000(0000) GS:ffff94ad1f4c0000(0000) knlGS:0000000000000000
> [  204.057458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  204.057469] CR2: 0000000000000000 CR3: 000000001322c000 CR4: 00000000000006f0
> [  204.057473] Call Trace:
> [  204.057480]  <NMI>
> [  204.057485]  ? nmi_cpu_backtrace+0x74/0xe0
> [  204.057503]  ? nmi_cpu_backtrace_handler+0x8/0x10
> [  204.057513]  ? nmi_handle+0x5e/0x140
> [  204.057522]  ? default_do_nmi+0x4a/0xf0
> [  204.057531]  ? exc_nmi+0x113/0x130
> [  204.057538]  ? end_repeat_nmi+0xf/0x60
> [  204.057546]  ? rcutorture_one_extend+0x21/0x300
> [  204.057557]  ? rcutorture_one_extend+0x21/0x300
> [  204.057566]  ? first_nmi+0x30/0x30
> [  204.057571]  </NMI>
> [  204.057574] WARNING: stack recursion on stack type 6

Is this related?

But then the system picks itself up, dusts itself off, and goes along
as if nothing had happened.

Maybe a long-running IRQ, NMI, or SMI?

							Thanx, Paul

> [  204.265445] rcu-torture: rcu_torture_read_exit: End of episode
> [  204.521371] smpboot: CPU 4 is now offline
> [  205.549496] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  207.600256] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  209.701127] smpboot: CPU 12 is now offline
> [  210.778107] smpboot: CPU 5 is now offline
> [  211.814620] smpboot: CPU 3 is now offline
> [  212.866159] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  213.929208] smpboot: CPU 15 is now offline
> [  214.948230] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  215.992202] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  217.382939] rcu-torture: rtc: 00000000f0da0bf3 ver: 4692 tfle: 0 rta: 4693 rtaf: 0 rtf: 4683 rtmbe: 0 rtmbkf: 0/2026 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 586918 onoff: 50/50:61/62 28,827:20,34603 7467:48853 (HZ=1000) barrier: 891/892:0 read-exits: 208 nocb-toggles: 0:0
> [  217.408490] rcu-torture: Reader Pipe:  225758940 22205 0 0 0 0 0 0 0 0 0
> [  217.416851] rcu-torture: Reader Batch:  225734694 46451 0 0 0 0 0 0 0 0 0
> [  217.425748] rcu-torture: Free-Block Circulation:  4692 4691 4690 4689 4688 4687 4686 4685 4684 4683 0
> [  217.454026] smpboot: CPU 15 is now offline
> [  217.827968] rcu-torture: rcu_torture_read_exit: Start of episode
> [  217.867515] rcu-torture: rcu_torture_read_exit: End of episode
> [  218.466186] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  219.896283] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  221.193229] smpboot: CPU 13 is now offline
> [  222.228579] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  223.281829] smpboot: CPU 11 is now offline
> [  223.527723] rcu_torture_fwd_prog n_max_cbs: 33218
> [  223.537159] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  223.549426] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  223.626028] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  223.666747] rcu_torture_fwd_prog_cr Duration 60 barrier: 38 pending 19710 n_launders: 55003 n_launders_sa: 54987 n_max_gps: 100 n_max_cbs: 27452 cver 0 gps 13
> [  223.692475] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 126 jiffies): 1s/10: 82455:16
> [  224.310071] smpboot: CPU 2 is now offline
> [  224.739514] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  225.526233] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  227.482022] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  229.270286] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  231.202995] rcu-torture: rcu_torture_read_exit: Start of episode
> [  231.254252] rcu-torture: rcu_torture_read_exit: End of episode
> [  231.665966] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  232.545874] rcu_torture_fwd_prog_nr: 0 Duration 7785 cver 18 gps 37
> [  232.587066] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  232.740013] rcu-torture: rtc: 00000000be258066 ver: 4987 tfle: 0 rta: 4988 rtaf: 0 rtf: 4977 rtmbe: 0 rtmbkf: 0/2026 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 614451 onoff: 57/57:65/66 28,967:20,34603 10361:49617 (HZ=1000) barrier: 953/953:0 read-exits: 240 nocb-toggles: 0:0
> [  232.781596] rcu-torture: Reader Pipe:  238322150 22935 0 0 0 0 0 0 0 0 0
> [  232.793173] rcu-torture: Reader Batch:  238296735 48350 0 0 0 0 0 0 0 0 0
> [  232.807362] rcu-torture: Free-Block Circulation:  4987 4986 4985 4984 4983 4982 4981 4980 4978 4977 0
> [  232.874599] smpboot: CPU 14 is now offline
> [  233.972670] smpboot: CPU 1 is now offline
> [  235.006485] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  236.138082] smpboot: CPU 6 is now offline
> [  237.182206] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  238.237218] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  239.524773] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  240.599285] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  241.703197] smpboot: CPU 3 is now offline
> [  242.761121] smpboot: CPU 15 is now offline
> [  244.281080] smpboot: CPU 8 is now offline
> [  245.298250] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  245.859101] rcu-torture: rcu_torture_read_exit: Start of episode
> [  245.909140] rcu-torture: rcu_torture_read_exit: End of episode
> [  246.355411] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  247.978284] smpboot: CPU 2 is now offline
> [  248.099221] rcu-torture: rtc: 0000000016e1749d ver: 5648 tfle: 0 rta: 5649 rtaf: 0 rtf: 5638 rtmbe: 0 rtmbkf: 0/2153 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 667675 onoff: 64/64:72/72 28,967:20,34603 10986:51264 (HZ=1000) barrier: 1039/1040:0 read-exits: 256 nocb-toggles: 0:0
> [  248.135321] rcu-torture: Reader Pipe:  261810097 25498 0 0 0 0 0 0 0 0 0
> [  248.149009] rcu-torture: Reader Batch:  261782059 53536 0 0 0 0 0 0 0 0 0
> [  248.162820] rcu-torture: Free-Block Circulation:  5648 5646 5645 5644 5643 5642 5641 5640 5639 5638 0
> [  248.994197] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  250.055252] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  251.174760] smpboot: CPU 2 is now offline
> [  252.254723] smpboot: CPU 7 is now offline
> [  253.270314] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  255.417556] smpboot: CPU 4 is now offline
> [  256.463116] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  257.608328] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  259.362990] rcu-torture: rcu_torture_read_exit: Start of episode
> [  259.408097] rcu-torture: rcu_torture_read_exit: End of episode
> [  259.758094] smpboot: CPU 9 is now offline
> [  260.801189] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  261.901485] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  263.388442] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  263.459009] rcu-torture: rtc: 000000009f3a8505 ver: 6126 tfle: 0 rta: 6126 rtaf: 0 rtf: 6117 rtmbe: 0 rtmbkf: 0/2427 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 711116 onoff: 72/72:76/76 28,967:20,34603 12015:51650 (HZ=1000) barrier: 1141/1141:0 read-exits: 272 nocb-toggles: 0:0
> [  263.500197] rcu-torture: Reader Pipe:  278931535 27803 0 0 0 0 0 0 0 0 0
> [  263.512701] rcu-torture: Reader Batch:  278901156 58182 0 0 0 0 0 0 0 0 0
> [  263.524317] rcu-torture: Free-Block Circulation:  6126 6125 6124 6123 6122 6121 6120 6119 6118 6117 0
> [  265.821543] smpboot: CPU 3 is now offline
> [  266.902729] smpboot: CPU 2 is now offline
> [  268.038368] smpboot: CPU 7 is now offline
> [  269.086225] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  270.681976] smpboot: CPU 1 is now offline
> [  271.755102] smpboot: CPU 5 is now offline
> [  272.803034] rcu-torture: rcu_torture_read_exit: Start of episode
> [  272.832262] smpboot: CPU 14 is now offline
> [  272.857355] rcu-torture: rcu_torture_read_exit: End of episode
> [  273.879271] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  274.920328] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  275.987062] smpboot: CPU 10 is now offline
> [  277.002033] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  278.105536] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  278.819329] rcu-torture: rtc: 00000000928d6222 ver: 6588 tfle: 0 rta: 6588 rtaf: 0 rtf: 6579 rtmbe: 0 rtmbkf: 0/2653 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 757262 onoff: 77/77:83/83 28,967:20,34603 12409:53032 (HZ=1000) barrier: 1237/1237:0 read-exits: 288 nocb-toggles: 0:0
> [  278.865185] rcu-torture: Reader Pipe:  301681359 30093 0 0 0 0 0 0 0 0 0
> [  278.877643] rcu-torture: Reader Batch:  301648395 63057 0 0 0 0 0 0 0 0 0
> [  278.892049] rcu-torture: Free-Block Circulation:  6587 6587 6586 6585 6584 6583 6582 6581 6580 6579 0
> [  279.278683] smpboot: CPU 3 is now offline
> [  281.520638] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  282.637756] smpboot: CPU 3 is now offline
> [  283.732157] smpboot: CPU 8 is now offline
> [  284.766235] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  286.026194] smpboot: CPU 1 is now offline
> [  286.242994] rcu-torture: rcu_torture_read_exit: Start of episode
> [  286.312100] rcu-torture: rcu_torture_read_exit: End of episode
> [  287.271385] smpboot: CPU 5 is now offline
> [  288.546316] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  289.593130] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  290.655244] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  291.733835] smpboot: CPU 10 is now offline
> [  292.788200] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  293.155171] rcu_torture_fwd_prog n_max_cbs: 27452
> [  293.163983] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  293.175925] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  293.322654] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  293.406151] rcu_torture_fwd_prog_cr Duration 101 barrier: 84 pending 25044 n_launders: 39508 n_launders_sa: 27760 n_max_gps: 100 n_max_cbs: 27660 cver 9 gps 10
> [  293.431337] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 210 jiffies): 1s/10: 42124:10 2s/10: 25044:6
> [  293.842332] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  294.180986] rcu-torture: rtc: 00000000375827ac ver: 7221 tfle: 0 rta: 7222 rtaf: 0 rtf: 7209 rtmbe: 0 rtmbkf: 0/2923 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 813809 onoff: 84/84:89/89 28,967:20,34603 13254:53821 (HZ=1000) barrier: 1321/1322:0 read-exits: 304 nocb-toggles: 0:0
> [  294.223198] rcu-torture: Reader Pipe:  323759897 32990 0 0 0 0 0 0 0 0 0
> [  294.236134] rcu-torture: Reader Batch:  323724292 68595 0 0 0 0 0 0 0 0 0
> [  294.251545] rcu-torture: Free-Block Circulation:  7222 7221 7220 7219 7216 7214 7213 7212 7211 7210 0
> [  294.501597] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  295.820185] smpboot: CPU 3 is now offline
> [  298.569587] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  299.938970] rcu-torture: rcu_torture_read_exit: Start of episode
> [  299.995956] rcu-torture: rcu_torture_read_exit: End of episode
> [  301.013105] smpboot: CPU 3 is now offline
> [  302.663277] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  303.483915] rcu_torture_fwd_prog_nr: 0 Duration 8933 cver 32 gps 43
> [  303.500634] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  303.764601] smpboot: CPU 9 is now offline
> [  305.845929] smpboot: CPU 5 is now offline
> [  306.967086] smpboot: CPU 14 is now offline
> [  308.070201] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  309.539049] rcu-torture: rtc: 00000000bfb13814 ver: 7449 tfle: 0 rta: 7450 rtaf: 0 rtf: 7439 rtmbe: 0 rtmbkf: 0/3032 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 859327 onoff: 87/87:94/94 28,967:20,34603 14819:56469 (HZ=1000) barrier: 1373/1374:0 read-exits: 320 nocb-toggles: 0:0
> [  309.596547] rcu-torture: Reader Pipe:  348032914 34135 0 0 0 0 0 0 0 0 0
> [  309.609512] rcu-torture: Reader Batch:  347996365 70684 0 0 0 0 0 0 0 0 0
> [  309.623095] rcu-torture: Free-Block Circulation:  7449 7448 7447 7446 7445 7444 7442 7441 7440 7439 0
> [  310.223454] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  311.351404] smpboot: CPU 7 is now offline
> [  312.425249] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  313.591476] smpboot: CPU 2 is now offline
> [  314.339966] rcu-torture: rcu_torture_read_exit: Start of episode
> [  314.386000] rcu-torture: rcu_torture_read_exit: End of episode
> [  315.649552] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  316.822722] smpboot: CPU 2 is now offline
> [  317.876253] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  319.028631] smpboot: CPU 9 is now offline
> [  321.115631] smpboot: CPU 4 is now offline
> [  322.308915] smpboot: CPU 13 is now offline
> [  323.335629] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  324.608004] smpboot: CPU 15 is now offline
> [  324.901024] rcu-torture: rtc: 00000000d1ef1092 ver: 8078 tfle: 0 rta: 8079 rtaf: 0 rtf: 8066 rtmbe: 0 rtmbkf: 0/3384 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 922945 onoff: 92/92:101/101 28,967:20,34603 15276:57506 (HZ=1000) barrier: 1458/1458:0 read-exits: 336 nocb-toggles: 0:0
> [  324.941144] rcu-torture: Reader Pipe:  375229547 37238 0 0 0 0 0 0 0 0 0
> [  324.948682] rcu-torture: Reader Batch:  375190045 76740 0 0 0 0 0 0 0 0 0
> [  324.956203] rcu-torture: Free-Block Circulation:  8079 8078 8077 8076 8075 8074 8073 8072 8068 8067 0
> [  325.696055] smpboot: CPU 8 is now offline
> [  326.727971] smpboot: CPU 6 is now offline
> [  327.755120] smpboot: CPU 1 is now offline
> [  327.779109] rcu-torture: rcu_torture_read_exit: Start of episode
> [  328.772688] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  329.819229] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  330.910739] smpboot: CPU 1 is now offline
> [  331.577610] rcu-torture: rcu_torture_read_exit: End of episode
> [  331.941228] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  333.001483] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  334.067571] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  334.115888] kworker/dying (118) used greatest stack depth: 13928 bytes left
> [  335.173995] smpboot: CPU 15 is now offline
> [  336.214323] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  337.270550] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  338.399672] smpboot: CPU 3 is now offline
> [  339.437320] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  340.261001] rcu-torture: rtc: 00000000e5b8a0be ver: 8625 tfle: 0 rta: 8626 rtaf: 0 rtf: 8616 rtmbe: 0 rtmbkf: 0/3438 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 959341 onoff: 100/100:107/107 28,967:20,34603 15711:57913 (HZ=1000) barrier: 1565/1566:0 read-exits: 352 nocb-toggles: 0:0
> [  340.302323] rcu-torture: Reader Pipe:  389058984 39363 0 0 0 0 0 0 0 0 0
> [  340.313869] rcu-torture: Reader Batch:  389017676 80671 0 0 0 0 0 0 0 0 0
> [  340.326505] rcu-torture: Free-Block Circulation:  8625 8624 8623 8622 8621 8620 8619 8618 8617 8616 0
> [  340.660967] smpboot: CPU 7 is now offline
> [  341.720234] smpboot: CPU 5 is now offline
> [  344.774110] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  344.930955] rcu-torture: rcu_torture_read_exit: Start of episode
> [  344.970287] rcu-torture: rcu_torture_read_exit: End of episode
> [  346.824251] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  347.902064] smpboot: CPU 4 is now offline
> [  348.953929] smpboot: CPU 6 is now offline
> [  350.004570] smpboot: CPU 13 is now offline
> [  351.303851] smpboot: CPU 1 is now offline
> [  352.323237] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  353.364314] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  354.486165] smpboot: CPU 12 is now offline
> [  355.504017] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  355.619006] rcu-torture: rtc: 0000000044054a8f ver: 9239 tfle: 0 rta: 9239 rtaf: 0 rtf: 9230 rtmbe: 0 rtmbkf: 0/3476 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 998789 onoff: 105/105:114/114 28,967:20,34603 16026:58692 (HZ=1000) barrier: 1669/1669:0 read-exits: 368 nocb-toggles: 0:0
> [  355.684082] rcu-torture: Reader Pipe:  407818819 41597 0 0 0 0 0 0 0 0 0
> [  355.704302] rcu-torture: Reader Batch:  407774281 86135 0 0 0 0 0 0 0 0 0
> [  355.719066] rcu-torture: Free-Block Circulation:  9238 9238 9237 9236 9235 9234 9233 9232 9231 9230 0
> [  356.582378] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  357.719628] smpboot: CPU 14 is now offline
> [  358.307038] rcu-torture: rcu_torture_read_exit: Start of episode
> [  358.339403] rcu-torture: rcu_torture_read_exit: End of episode
> [  359.086464] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  360.159698] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  361.317985] smpboot: CPU 14 is now offline
> [  362.382242] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  363.484149] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  364.538497] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  365.652496] smpboot: CPU 11 is now offline
> [  366.871260] smpboot: CPU 15 is now offline
> [  366.885935] rcu_torture_fwd_prog n_max_cbs: 27660
> [  366.894716] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  366.905192] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  367.001831] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  367.093607] rcu_torture_fwd_prog_cr Duration 74 barrier: 92 pending 31764 n_launders: 67825 n_launders_sa: 9566 n_max_gps: 100 n_max_cbs: 36838 cver 6 gps 14
> [  367.117666] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 190 jiffies): 1s/10: 103403:16 2s/10: 1260:1
> [  367.950318] smpboot: CPU 8 is now offline
> [  368.163016] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  369.513501] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  370.978987] rcu-torture: rtc: 000000007c4a8bb7 ver: 9738 tfle: 0 rta: 9739 rtaf: 0 rtf: 9729 rtmbe: 0 rtmbkf: 0/3669 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1050893 onoff: 112/112:119/120 28,967:20,34603 17371:59311 (HZ=1000) barrier: 1755/1756:0 read-exits: 384 nocb-toggles: 0:0
> [  371.018968] rcu-torture: Reader Pipe:  428559615 43806 0 0 0 0 0 0 0 0 0
> [  371.030001] rcu-torture: Reader Batch:  428512275 91146 0 0 0 0 0 0 0 0 0
> [  371.041341] rcu-torture: Free-Block Circulation:  9738 9737 9736 9735 9734 9733 9732 9731 9730 9729 0
> [  371.683060] rcu-torture: rcu_torture_read_exit: Start of episode
> [  371.696445] smpboot: CPU 10 is now offline
> [  371.729599] rcu-torture: rcu_torture_read_exit: End of episode
> [  374.550882] rcu_torture_fwd_prog_nr: 0 Duration 6369 cver 24 gps 29
> [  374.572580] smpboot: CPU 3 is now offline
> [  374.572589] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  375.657538] smpboot: CPU 1 is now offline
> [  376.689100] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  377.787259] smpboot: CPU 12 is now offline
> [  378.804043] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  379.884975] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  380.936106] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  383.053935] smpboot: CPU 2 is now offline
> [  384.150585] smpboot: CPU 9 is now offline
> [  385.239083] smpboot: CPU 13 is now offline
> [  386.019717] rcu-torture: rcu_torture_read_exit: Start of episode
> [  386.078303] rcu-torture: rcu_torture_read_exit: End of episode
> [  386.300261] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  386.345035] rcu-torture: rtc: 00000000de9c3375 ver: 10047 tfle: 0 rta: 10048 rtaf: 0 rtf: 10038 rtmbe: 0 rtmbkf: 0/3674 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1082829 onoff: 117/117:126/126 28,967:20,34603 17738:62716 (HZ=1000) barrier: 1838/1839:0 read-exits: 416 nocb-toggles: 0:0
> [  386.395965] rcu-torture: Reader Pipe:  445125933 44870 0 0 0 0 0 0 0 0 0
> [  386.411241] rcu-torture: Reader Batch:  445077199 93604 0 0 0 0 0 0 0 0 0
> [  386.427217] rcu-torture: Free-Block Circulation:  10048 10047 10046 10045 10044 10043 10042 10041 10040 10039 0
> [  387.401170] smpboot: CPU 12 is now offline
> [  388.442190] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  390.504623] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  391.559169] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  392.957593] smpboot: CPU 9 is now offline
> [  394.061615] smpboot: CPU 6 is now offline
> [  395.145224] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  396.287232] smpboot: CPU 8 is now offline
> [  397.504429] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  398.753216] smpboot: CPU 15 is now offline
> [  399.459971] rcu-torture: rcu_torture_read_exit: Start of episode
> [  399.502722] rcu-torture: rcu_torture_read_exit: End of episode
> [  399.795207] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  401.171327] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  401.699925] rcu-torture: rtc: 00000000cad2a34a ver: 10690 tfle: 0 rta: 10691 rtaf: 0 rtf: 10680 rtmbe: 0 rtmbkf: 0/3699 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1134547 onoff: 124/124:131/131 28,967:20,34603 18707:63606 (HZ=1000) barrier: 1921/1922:0 read-exits: 432 nocb-toggles: 0:0
> [  401.726633] rcu-torture: Reader Pipe:  467641150 47291 0 0 0 0 0 0 0 0 0
> [  401.733841] rcu-torture: Reader Batch:  467589811 98630 0 0 0 0 0 0 0 0 0
> [  401.741390] rcu-torture: Free-Block Circulation:  10690 10689 10688 10687 10686 10684 10683 10682 10681 10680 0
> [  402.226327] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  403.890857] smpboot: CPU 9 is now offline
> [  404.940391] smpboot: CPU 5 is now offline
> [  406.021839] smpboot: CPU 13 is now offline
> [  407.089746] smpboot: CPU 11 is now offline
> [  408.121337] smpboot: CPU 6 is now offline
> [  409.136249] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  410.217548] smpboot: CPU 3 is now offline
> [  411.263689] smpboot: CPU 6 is now offline
> [  412.278137] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  412.899053] rcu-torture: rcu_torture_read_exit: Start of episode
> [  412.945180] rcu-torture: rcu_torture_read_exit: End of episode
> [  413.368177] smpboot: CPU 10 is now offline
> [  414.412257] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  415.461105] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  416.546250] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  417.062423] rcu-torture: rtc: 00000000be258066 ver: 11271 tfle: 0 rta: 11272 rtaf: 0 rtf: 11258 rtmbe: 0 rtmbkf: 0/3765 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1164709 onoff: 130/130:139/139 28,967:20,34603 19044:64638 (HZ=1000) barrier: 2030/2030:0 read-exits: 448 nocb-toggles: 0:0
> [  417.109271] rcu-torture: Reader Pipe:  480866908 48848 0 0 0 0 0 0 0 0 0
> [  417.122032] rcu-torture: Reader Batch:  480813386 102370 0 0 0 0 0 0 0 0 0
> [  417.135945] rcu-torture: Free-Block Circulation:  11272 11271 11270 11269 11268 11263 11262 11261 11260 11259 0
> [  417.636299] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  418.749029] smpboot: CPU 6 is now offline
> [  419.783262] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  420.845340] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  421.897247] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  423.001265] smpboot: CPU 2 is now offline
> [  424.033551] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  426.132689] smpboot: CPU 2 is now offline
> [  426.275040] rcu-torture: rcu_torture_read_exit: Start of episode
> [  426.303100] rcu-torture: rcu_torture_read_exit: End of episode
> [  427.312465] smpboot: CPU 1 is now offline
> [  428.849195] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  429.951609] smpboot: CPU 8 is now offline
> [  431.008607] smpboot: CPU 15 is now offline
> [  432.025274] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  432.419130] rcu-torture: rtc: 00000000062f53cc ver: 11842 tfle: 0 rta: 11842 rtaf: 0 rtf: 11833 rtmbe: 0 rtmbkf: 0/3997 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1215731 onoff: 137/137:145/145 28,967:20,34603 19972:65189 (HZ=1000) barrier: 2118/2118:0 read-exits: 464 nocb-toggles: 0:0
> [  432.467089] rcu-torture: Reader Pipe:  504717801 51435 0 0 0 0 0 0 0 0 0
> [  432.477561] rcu-torture: Reader Batch:  504661446 107790 0 0 0 0 0 0 0 0 0
> [  432.490314] rcu-torture: Free-Block Circulation:  11841 11841 11840 11839 11838 11837 11836 11835 11834 11833 0
> [  433.085748] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  434.133482] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  435.194518] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  436.375226] smpboot: CPU 6 is now offline
> [  436.515301] rcu_torture_fwd_prog n_max_cbs: 36838
> [  436.525486] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  436.537812] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  436.606172] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  436.656620] rcu_torture_fwd_prog_cr Duration 47 barrier: 50 pending 27762 n_launders: 49261 n_launders_sa: 24582 n_max_gps: 100 n_max_cbs: 31448 cver 4 gps 13
> [  436.676800] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 117 jiffies): 1s/10: 80709:16
> [  437.486019] smpboot: CPU 4 is now offline
> [  437.731342] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  439.716044] rcu-torture: rcu_torture_read_exit: Start of episode
> [  439.765147] rcu-torture: rcu_torture_read_exit: End of episode
> [  439.850002] smpboot: CPU 14 is now offline
> [  441.175259] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  443.555054] smpboot: CPU 12 is now offline
> [  445.582539] smpboot: CPU 14 is now offline
> [  447.779997] rcu-torture: rtc: 00000000e9bd9eab ver: 11982 tfle: 0 rta: 11983 rtaf: 0 rtf: 11973 rtmbe: 0 rtmbkf: 0/4085 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1258640 onoff: 141/141:150/151 28,967:20,34603 20511:69159 (HZ=1000) barrier: 2168/2169:0 read-exits: 480 nocb-toggles: 0:0
> [  447.823371] rcu-torture: Reader Pipe:  521991729 52112 0 0 0 0 0 0 0 0 0
> [  447.840285] rcu-torture: Reader Batch:  521934666 109175 0 0 0 0 0 0 0 0 0
> [  447.852278] rcu-torture: Free-Block Circulation:  11982 11981 11980 11979 11978 11977 11976 11975 11974 11973 0
> [  447.871565] smpboot: CPU 13 is now offline
> [  449.387965] smpboot: CPU 2 is now offline
> [  450.876027] smpboot: CPU 3 is now offline
> [  452.319881] rcu_torture_fwd_prog_nr: 0 Duration 14553 cver 44 gps 70
> [  452.346942] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  452.365217] smpboot: CPU 10 is now offline
> [  453.386201] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  453.666999] rcu-torture: rcu_torture_read_exit: Start of episode
> [  453.681848] rcu-torture: rcu_torture_read_exit: End of episode
> [  454.710427] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  455.812421] smpboot: CPU 14 is now offline
> [  456.830454] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  457.904905] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  458.944617] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  460.032074] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  461.098776] smpboot: CPU 10 is now offline
> [  462.186014] smpboot: CPU 7 is now offline
> [  463.139185] rcu-torture: rtc: 00000000804f89a4 ver: 12346 tfle: 0 rta: 12347 rtaf: 0 rtf: 12335 rtmbe: 0 rtmbkf: 0/4085 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1280878 onoff: 147/147:157/157 28,967:20,34603 21112:72149 (HZ=1000) barrier: 2252/2252:0 read-exits: 496 nocb-toggles: 0:0
> [  463.185068] rcu-torture: Reader Pipe:  531944283 52875 0 0 0 0 0 0 0 0 0
> [  463.198274] rcu-torture: Reader Batch:  531886176 110982 0 0 0 0 0 0 0 0 0
> [  463.212187] rcu-torture: Free-Block Circulation:  12346 12345 12344 12343 12341 12340 12339 12338 12336 12335 0
> [  463.351206] smpboot: CPU 9 is now offline
> [  464.383372] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  465.441334] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  466.525976] smpboot: CPU 15 is now offline
> [  467.043079] rcu-torture: rcu_torture_read_exit: Start of episode
> [  467.057655] rcu-torture: rcu_torture_read_exit: End of episode
> [  467.563505] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  468.697367] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  469.760654] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  470.880594] smpboot: CPU 9 is now offline
> [  471.898985] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  472.987986] smpboot: CPU 13 is now offline
> [  474.035837] smpboot: CPU 10 is now offline
> [  475.142328] smpboot: CPU 5 is now offline
> [  476.171240] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  477.449413] smpboot: CPU 2 is now offline
> [  478.498907] rcu-torture: rtc: 000000004996002a ver: 13095 tfle: 0 rta: 13096 rtaf: 0 rtf: 13086 rtmbe: 0 rtmbkf: 0/4153 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1331772 onoff: 154/154:164/165 28,967:20,34603 21567:72936 (HZ=1000) barrier: 2346/2346:0 read-exits: 512 nocb-toggles: 0:0
> [  478.524642] rcu-torture: Reader Pipe:  551151575 55521 0 0 0 0 0 0 0 0 0
> [  478.531695] rcu-torture: Reader Batch:  551090537 116559 0 0 0 0 0 0 0 0 0
> [  478.539311] rcu-torture: Free-Block Circulation:  13096 13095 13094 13093 13092 13091 13090 13089 13088 13087 0
> [  478.563956] smpboot: CPU 4 is now offline
> [  479.610403] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  480.419174] rcu-torture: rcu_torture_read_exit: Start of episode
> [  480.464145] rcu-torture: rcu_torture_read_exit: End of episode
> [  480.656821] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  481.711518] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  482.746200] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  483.834217] smpboot: CPU 4 is now offline
> [  484.853148] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  485.891266] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  487.001298] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  488.273750] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  489.412769] smpboot: CPU 5 is now offline
> [  492.512619] smpboot: CPU 13 is now offline
> [  493.595500] smpboot: CPU 15 is now offline
> [  493.866014] rcu-torture: rtc: 00000000928d6222 ver: 13490 tfle: 0 rta: 13491 rtaf: 0 rtf: 13479 rtmbe: 0 rtmbkf: 0/4307 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1374580 onoff: 162/162:169/169 28,967:20,34603 22239:73397 (HZ=1000) barrier: 2440/2441:0 read-exits: 528 nocb-toggles: 0:0
> [  493.896968] rcu-torture: Reader Pipe:  569282556 57373 0 0 0 0 0 0 0 0 0
> [  493.904303] rcu-torture: Reader Batch:  569219785 120144 0 0 0 0 0 0 0 0 0
> [  493.911668] rcu-torture: Free-Block Circulation:  13490 13489 13488 13487 13486 13485 13484 13483 13480 13479 0
> [  493.923010] rcu-torture: rcu_torture_read_exit: Start of episode
> [  493.969740] rcu-torture: rcu_torture_read_exit: End of episode
> [  494.718354] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  495.842204] smpboot: CPU 3 is now offline
> [  496.956149] smpboot: CPU 4 is now offline
> [  498.036621] smpboot: CPU 11 is now offline
> [  499.071402] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  500.296729] smpboot: CPU 8 is now offline
> [  501.333411] smpboot: CPU 14 is now offline
> [  502.363237] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  503.677121] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  504.792958] smpboot: CPU 15 is now offline
> [  506.163308] smpboot: CPU 10 is now offline
> [  507.208163] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  507.554972] rcu-torture: rcu_torture_read_exit: Start of episode
> [  507.566230] rcu-torture: rcu_torture_read_exit: End of episode
> [  508.476197] smpboot: CPU 7 is now offline
> [  509.219034] rcu-torture: rtc: 00000000f0da0bf3 ver: 14081 tfle: 0 rta: 14081 rtaf: 0 rtf: 14072 rtmbe: 0 rtmbkf: 0/4371 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1421756 onoff: 167/167:177/177 28,967:20,34603 22860:74638 (HZ=1000) barrier: 2526/2526:0 read-exits: 560 nocb-toggles: 0:0
> [  509.259934] rcu-torture: Reader Pipe:  591672562 59557 0 0 0 0 0 0 0 0 0
> [  509.272437] rcu-torture: Reader Batch:  591606954 125165 0 0 0 0 0 0 0 0 0
> [  509.283945] rcu-torture: Free-Block Circulation:  14080 14080 14079 14078 14077 14076 14075 14074 14073 14072 0
> [  509.516013] smpboot: CPU 9 is now offline
> [  510.531444] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  511.567829] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  512.644046] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  513.736243] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  514.339299] rcu_torture_fwd_prog n_max_cbs: 31448
> [  514.348942] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  514.361446] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  514.450017] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  514.493146] rcu_torture_fwd_prog_cr Duration 64 barrier: 43 pending 35747 n_launders: 54571 n_launders_sa: 4 n_max_gps: 100 n_max_cbs: 35749 cver 6 gps 13
> [  514.511529] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 125 jiffies): 1s/10: 90320:16
> [  514.815476] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  515.555172] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  516.819346] smpboot: CPU 2 is now offline
> [  519.258993] smpboot: CPU 8 is now offline
> [  520.931230] rcu-torture: rcu_torture_read_exit: Start of episode
> [  520.952252] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  521.003005] rcu-torture: rcu_torture_read_exit: End of episode
> [  522.803316] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  524.581952] rcu-torture: rtc: 000000005bd3d8a8 ver: 14239 tfle: 0 rta: 14240 rtaf: 0 rtf: 14229 rtmbe: 0 rtmbkf: 0/4468 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1464389 onoff: 174/174:180/181 28,967:20,34603 24751:77097 (HZ=1000) barrier: 2584/2585:0 read-exits: 576 nocb-toggles: 0:0
> [  524.626809] rcu-torture: Reader Pipe:  609652348 60288 0 0 0 0 0 0 0 0 0
> [  524.638006] rcu-torture: Reader Batch:  609586158 126478 0 0 0 0 0 0 0 0 0
> [  524.650028] rcu-torture: Free-Block Circulation:  14239 14238 14237 14236 14235 14233 14232 14231 14230 14229 0
> [  524.972994] smpboot: CPU 9 is now offline
> [  527.468292] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  529.918057] smpboot: CPU 4 is now offline
> [  531.967877] rcu_torture_fwd_prog_nr: 0 Duration 16378 cver 63 gps 66
> [  532.045318] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  532.055421] smpboot: CPU 1 is now offline
> [  533.107989] smpboot: CPU 3 is now offline
> [  534.310431] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  535.400014] smpboot: CPU 6 is now offline
> [  535.843083] rcu-torture: rcu_torture_read_exit: Start of episode
> [  536.415977] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  537.514470] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  538.607621] smpboot: CPU 2 is now offline
> [  539.487751] rcu-torture: rcu_torture_read_exit: End of episode
> [  539.642720] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  539.939144] rcu-torture: rtc: 0000000031c77211 ver: 14429 tfle: 0 rta: 14430 rtaf: 0 rtf: 14418 rtmbe: 0 rtmbkf: 0/4494 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1503070 onoff: 179/179:186/186 28,1506:20,34603 26721:80957 (HZ=1000) barrier: 2652/2653:0 read-exits: 592 nocb-toggles: 0:0
> [  539.982720] rcu-torture: Reader Pipe:  630675061 61086 0 0 0 0 0 0 0 0 0
> [  539.993910] rcu-torture: Reader Batch:  630608059 128088 0 0 0 0 0 0 0 0 0
> [  540.005410] rcu-torture: Free-Block Circulation:  14429 14428 14427 14425 14424 14422 14421 14420 14419 14418 0
> [  540.856340] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  541.958612] smpboot: CPU 13 is now offline
> [  543.069076] smpboot: CPU 5 is now offline
> [  544.109176] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  545.160609] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  546.537819] smpboot: CPU 13 is now offline
> [  547.668583] smpboot: CPU 10 is now offline
> [  548.744521] smpboot: CPU 12 is now offline
> [  550.102776] smpboot: CPU 11 is now offline
> [  552.156416] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  552.866944] rcu-torture: rcu_torture_read_exit: Start of episode
> [  552.907279] rcu-torture: rcu_torture_read_exit: End of episode
> [  553.492975] smpboot: CPU 8 is now offline
> [  554.516354] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  555.299950] rcu-torture: rtc: 00000000d37ac840 ver: 15129 tfle: 0 rta: 15130 rtaf: 0 rtf: 15120 rtmbe: 0 rtmbkf: 0/4614 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1558940 onoff: 184/184:193/193 28,1506:20,34603 27156:82370 (HZ=1000) barrier: 2744/2744:0 read-exits: 608 nocb-toggles: 0:0
> [  555.337005] rcu-torture: Reader Pipe:  652895921 64067 0 0 0 0 0 0 0 0 0
> [  555.348189] rcu-torture: Reader Batch:  652825804 134184 0 0 0 0 0 0 0 0 0
> [  555.358578] rcu-torture: Free-Block Circulation:  15129 15128 15127 15126 15125 15124 15123 15122 15121 15120 0
> [  555.583233] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  556.656233] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  557.715060] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  558.860947] smpboot: CPU 14 is now offline
> [  559.978038] smpboot: CPU 12 is now offline
> [  561.048556] smpboot: CPU 6 is now offline
> [  562.064150] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  563.190819] smpboot: CPU 3 is now offline
> [  564.241337] smpboot: CPU 5 is now offline
> [  565.260170] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  566.307252] rcu-torture: rcu_torture_read_exit: Start of episode
> [  566.319173] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  566.372654] rcu-torture: rcu_torture_read_exit: End of episode
> [  567.380234] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  568.491438] smpboot: CPU 1 is now offline
> [  569.585011] smpboot: CPU 4 is now offline
> [  570.945816] rcu-torture: rtc: 000000004996002a ver: 15485 tfle: 0 rta: 15486 rtaf: 0 rtf: 15474 rtmbe: 0 rtmbkf: 0/4651 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1597045 onoff: 191/192:200/200 28,1506:20,34603 27584:82968 (HZ=1000) barrier: 2837/2838:0 read-exits: 624 nocb-toggles: 0:0
> [  570.989844] rcu-torture: Reader Pipe:  671147402 65595 0 0 0 0 0 0 0 0 0
> [  571.004476] rcu-torture: Reader Batch:  671075229 137768 0 0 0 0 0 0 0 0 0
> [  571.018465] rcu-torture: Free-Block Circulation:  15485 15484 15483 15482 15481 15479 15478 15477 15476 15474 0
> [  571.058733] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  572.112088] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  573.146929] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  574.209742] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  575.329306] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  576.627619] smpboot: CPU 15 is now offline
> [  578.024687] smpboot: CPU 14 is now offline
> [  579.114687] smpboot: CPU 11 is now offline
> [  579.747133] rcu-torture: rcu_torture_read_exit: Start of episode
> [  579.764172] rcu-torture: rcu_torture_read_exit: End of episode
> [  580.506700] smpboot: CPU 13 is now offline
> [  581.547193] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  582.610453] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  584.116835] smpboot: CPU 2 is now offline
> [  585.314383] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  586.716078] rcu-torture: 
> [  586.716096] smpboot: CPU 13 is now offline
> [  586.716095] rtc: 000000005643230d ver: 16124 tfle: 0 rta: 16125 rtaf: 0 rtf: 16113 rtmbe: 0 rtmbkf: 0/4983 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1663179 onoff: 199/199:205/206 28,1506:20,34603 28886:84335 (HZ=1000) barrier: 2924/2925:0 read-exits: 640 nocb-toggles: 0:0
> [  586.724854] rcu-torture: Reader Pipe:  702101321 68883 0 0 0 0 0 0 0 0 0
> [  586.725041] rcu-torture: Reader Batch:  702025559 144645 0 0 0 0 0 0 0 0 0
> [  586.725089] rcu-torture: Free-Block Circulation:  16124 16123 16122 16121 16120 16119 16118 16117 16115 16113 0
> [  587.823895] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  588.920831] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  589.979430] smpboot: CPU 7 is now offline
> [  590.997166] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  592.404198] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  593.125964] rcu-torture: rcu_torture_read_exit: Start of episode
> [  593.196184] rcu-torture: rcu_torture_read_exit: End of episode
> [  593.474725] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  595.174778] smpboot: CPU 7 is now offline
> [  596.259133] rcu_torture_fwd_prog n_max_cbs: 35749
> [  596.268511] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  596.279834] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  596.293635] smpboot: CPU 3 is now offline
> [  596.401809] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  596.457452] rcu_torture_fwd_prog_cr Duration 66 barrier: 56 pending 25799 n_launders: 56185 n_launders_sa: 11590 n_max_gps: 100 n_max_cbs: 35348 cver 5 gps 14
> [  596.483069] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 148 jiffies): 1s/10: 91533:16
> [  597.378779] smpboot: CPU 5 is now offline
> [  597.540983] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  599.672105] smpboot: CPU 4 is now offline
> [  601.891946] rcu-torture: rtc: 00000000f265c3a1 ver: 16322 tfle: 0 rta: 16323 rtaf: 0 rtf: 16312 rtmbe: 0 rtmbkf: 0/5125 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1708948 onoff: 204/204:211/212 28,1506:20,34603 29523:87007 (HZ=1000) barrier: 2998/2999:0 read-exits: 656 nocb-toggles: 0:0
> [  601.920995] rcu-torture: Reader Pipe:  721218521 70026 0 0 0 0 0 0 0 0 0
> [  601.929380] rcu-torture: Reader Batch:  721141435 147112 0 0 0 0 0 0 0 0 0
> [  601.939415] rcu-torture: Free-Block Circulation:  16322 16321 16320 16319 16318 16317 16315 16314 16313 16312 0
> [  602.122303] smpboot: CPU 9 is now offline
> [  605.573732] smpboot: CPU 10 is now offline
> [  606.755932] rcu-torture: rcu_torture_read_exit: Start of episode
> [  606.798436] rcu-torture: rcu_torture_read_exit: End of episode
> [  608.361605] smpboot: CPU 1 is now offline
> [  610.098146] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  611.356330] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  612.530929] rcu_torture_fwd_prog_nr: 0 Duration 14958 cver 42 gps 61
> [  612.566556] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  612.626194] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  613.664274] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  614.746284] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  615.856679] smpboot: CPU 4 is now offline
> [  616.899137] smpboot: CPU 14 is now offline
> [  617.251036] rcu-torture: rtc: 00000000e9bd9eab ver: 16363 tfle: 0 rta: 16363 rtaf: 0 rtf: 16354 rtmbe: 0 rtmbkf: 0/5127 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1739849 onoff: 209/209:216/216 28,1506:20,34603 30988:92764 (HZ=1000) barrier: 3051/3051:0 read-exits: 672 nocb-toggles: 0:0
> [  617.279966] rcu-torture: Reader Pipe:  736527922 70144 0 0 0 0 0 0 0 0 0
> [  617.289004] rcu-torture: Reader Batch:  736450695 147371 0 0 0 0 0 0 0 0 0
> [  617.299162] rcu-torture: Free-Block Circulation:  16362 16362 16361 16360 16359 16358 16357 16356 16355 16354 0
> [  618.225401] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  619.346089] smpboot: CPU 11 is now offline
> [  620.430326] smpboot: CPU 13 is now offline
> [  621.154999] rcu-torture: rcu_torture_read_exit: Start of episode
> [  621.201453] rcu-torture: rcu_torture_read_exit: End of episode
> [  621.592644] smpboot: CPU 12 is now offline
> [  623.628578] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  624.737973] smpboot: CPU 8 is now offline
> [  625.800392] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  626.884279] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  628.245272] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  629.348235] smpboot: CPU 6 is now offline
> [  630.425031] smpboot: CPU 14 is now offline
> [  631.569264] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  632.612055] rcu-torture: rtc: 00000000b894cacb ver: 17096 tfle: 0 rta: 17097 rtaf: 0 rtf: 17085 rtmbe: 0 rtmbkf: 0/5328 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1797199 onoff: 215/216:222/222 28,1506:20,34603 31963:93352 (HZ=1000) barrier: 3143/3144:0 read-exits: 688 nocb-toggles: 0:0
> [  632.655241] rcu-torture: Reader Pipe:  758269433 73389 0 0 0 0 0 0 0 0 0
> [  632.665506] rcu-torture: Reader Batch:  758189137 153685 0 0 0 0 0 0 0 0 0
> [  632.676539] rcu-torture: Free-Block Circulation:  17096 17095 17094 17093 17091 17089 17088 17087 17086 17085 0
> [  632.696260] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  633.835057] smpboot: CPU 5 is now offline
> [  634.595068] rcu-torture: rcu_torture_read_exit: Start of episode
> [  634.670078] rcu-torture: rcu_torture_read_exit: End of episode
> [  635.451077] smpboot: CPU 2 is now offline
> [  636.561509] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  637.659610] smpboot: CPU 3 is now offline
> [  638.723436] smpboot: CPU 7 is now offline
> [  639.738284] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  640.848675] smpboot: CPU 15 is now offline
> [  641.865313] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  642.945841] smpboot: CPU 11 is now offline
> [  643.996170] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  645.332728] smpboot: CPU 12 is now offline
> [  646.369190] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  647.426354] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  647.970982] rcu-torture: rtc: 00000000c13cefc2 ver: 17497 tfle: 0 rta: 17498 rtaf: 0 rtf: 17485 rtmbe: 0 rtmbkf: 0/5413 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1833332 onoff: 222/222:229/229 28,1506:20,34603 32518:94644 (HZ=1000) barrier: 3241/3242:0 read-exits: 704 nocb-toggles: 0:0
> [  648.022225] rcu-torture: Reader Pipe:  776157204 75051 0 0 0 0 0 0 0 0 0
> [  648.035654] rcu-torture: Reader Batch:  776074880 157375 0 0 0 0 0 0 0 0 0
> [  648.050143] rcu-torture: Free-Block Circulation:  17497 17496 17495 17494 17492 17491 17490 17489 17487 17486 0
> [  648.226984] rcu-torture: rcu_torture_read_exit: Start of episode
> [  648.285184] rcu-torture: rcu_torture_read_exit: End of episode
> [  648.559562] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  650.012507] smpboot: CPU 12 is now offline
> [  651.107820] smpboot: CPU 9 is now offline
> [  652.150795] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  653.441956] smpboot: CPU 10 is now offline
> [  654.491229] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  655.528687] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  656.695631] smpboot: CPU 6 is now offline
> [  658.008041] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  659.455300] smpboot: CPU 2 is now offline
> [  660.484505] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  661.523545] smpboot: CPU 3 is now offline
> [  661.795295] kworker/dying (11) used greatest stack depth: 13160 bytes left
> [  661.923016] rcu-torture: rcu_torture_read_exit: Start of episode
> [  661.976331] rcu-torture: rcu_torture_read_exit: End of episode
> [  662.653462] smpboot: CPU 11 is now offline
> [  663.332972] rcu-torture: rtc: 000000002aab04c9 ver: 18128 tfle: 0 rta: 18129 rtaf: 0 rtf: 18117 rtmbe: 0 rtmbkf: 0/5722 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1893624 onoff: 228/228:236/236 28,1506:20,34603 33380:95981 (HZ=1000) barrier: 3320/3321:0 read-exits: 736 nocb-toggles: 0:0
> [  663.360151] rcu-torture: Reader Pipe:  804344148 77973 0 0 0 0 0 0 0 0 0
> [  663.367466] rcu-torture: Reader Batch:  804259281 162840 0 0 0 0 0 0 0 0 0
> [  663.374744] rcu-torture: Free-Block Circulation:  18128 18126 18125 18123 18122 18121 18120 18119 18118 18117 0
> [  664.001179] smpboot: CPU 8 is now offline
> [  665.022233] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  666.064350] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  667.194544] smpboot: CPU 15 is now offline
> [  668.239476] smpboot: CPU 1 is now offline
> [  670.486011] smpboot: CPU 4 is now offline
> [  671.790652] smpboot: CPU 5 is now offline
> [  672.816741] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  673.871046] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  674.082957] rcu_torture_fwd_prog n_max_cbs: 35348
> [  674.091807] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  674.103039] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  674.187502] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  674.288646] rcu_torture_fwd_prog_cr Duration 62 barrier: 101 pending 35120 n_launders: 61287 n_launders_sa: 683 n_max_gps: 100 n_max_cbs: 35156 cver 7 gps 18
> [  674.308577] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 183 jiffies): 1s/10: 96443:21
> [  674.954692] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  675.363153] rcu-torture: rcu_torture_read_exit: Start of episode
> [  675.363325] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  675.421594] rcu-torture: rcu_torture_read_exit: End of episode
> [  677.479571] smpboot: CPU 14 is now offline
> [  678.692973] rcu-torture: rtc: 00000000abe7a7e8 ver: 18466 tfle: 0 rta: 18467 rtaf: 0 rtf: 18456 rtmbe: 0 rtmbkf: 0/5722 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1925786 onoff: 233/233:242/243 28,1506:20,34603 33686:98489 (HZ=1000) barrier: 3408/3409:0 read-exits: 752 nocb-toggles: 0:0
> [  678.747014] rcu-torture: Reader Pipe:  816765751 79013 0 0 0 0 0 0 0 0 0
> [  678.758057] rcu-torture: Reader Batch:  816679455 165309 0 0 0 0 0 0 0 0 0
> [  678.769639] rcu-torture: Free-Block Circulation:  18467 18466 18465 18464 18463 18462 18460 18459 18458 18457 0
> [  680.175648] smpboot: CPU 9 is now offline
> [  681.493598] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  682.849567] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  684.278022] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  686.356309] smpboot: CPU 8 is now offline
> [  689.269288] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  689.379950] rcu-torture: rcu_torture_read_exit: Start of episode
> [  689.432965] rcu-torture: rcu_torture_read_exit: End of episode
> [  690.831502] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  692.285162] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  693.970227] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  693.984927] rcu_torture_fwd_prog_nr: 0 Duration 18547 cver 80 gps 84
> [  694.012518] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  694.050968] rcu-torture: rtc: 000000007c4a8bb7 ver: 18534 tfle: 0 rta: 18534 rtaf: 0 rtf: 18525 rtmbe: 0 rtmbkf: 0/5734 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 1962826 onoff: 240/240:244/244 28,1937:20,34603 38441:101239 (HZ=1000) barrier: 3427/3427:0 read-exits: 768 nocb-toggles: 0:0
> [  694.087339] rcu-torture: Reader Pipe:  836348532 79241 0 0 0 0 0 0 0 0 0
> [  694.097386] rcu-torture: Reader Batch:  836262145 165628 0 0 0 0 0 0 0 0 0
> [  694.108512] rcu-torture: Free-Block Circulation:  18533 18533 18532 18531 18530 18529 18528 18527 18526 18525 0
> [  695.019536] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  696.231243] smpboot: CPU 1 is now offline
> [  697.343980] smpboot: CPU 5 is now offline
> [  698.438359] smpboot: CPU 14 is now offline
> [  699.565022] smpboot: CPU 3 is now offline
> [  700.600319] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  701.713083] smpboot: CPU 6 is now offline
> [  703.279249] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  704.035970] rcu-torture: rcu_torture_read_exit: Start of episode
> [  704.052965] rcu-torture: rcu_torture_read_exit: End of episode
> [  704.529246] smpboot: CPU 14 is now offline
> [  705.573393] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  706.689255] smpboot: CPU 10 is now offline
> [  708.116463] smpboot: CPU 12 is now offline
> [  709.288480] smpboot: CPU 11 is now offline
> [  709.411975] rcu-torture: rtc: 0000000079331c5b ver: 19129 tfle: 0 rta: 19130 rtaf: 0 rtf: 19118 rtmbe: 0 rtmbkf: 0/6105 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2023772 onoff: 244/244:253/253 28,1937:20,34603 39239:102707 (HZ=1000) barrier: 3517/3517:0 read-exits: 784 nocb-toggles: 0:0
> [  709.455112] rcu-torture: Reader Pipe:  859800758 82436 0 0 0 0 0 0 0 0 0
> [  709.466852] rcu-torture: Reader Batch:  859711783 171411 0 0 0 0 0 0 0 0 0
> [  709.479538] rcu-torture: Free-Block Circulation:  19130 19129 19127 19126 19125 19124 19123 19122 19120 19119 0
> [  710.334968] smpboot: CPU 15 is now offline
> [  712.411438] smpboot: CPU 7 is now offline
> [  713.443062] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  714.491491] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  715.542080] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  716.740441] smpboot: CPU 3 is now offline
> [  717.754776] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  717.811767] rcu-torture: rcu_torture_read_exit: Start of episode
> [  718.880574] smpboot: CPU 9 is now offline
> [  719.895782] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  721.022206] smpboot: CPU 3 is now offline
> [  721.755945] rcu-torture: rcu_torture_read_exit: End of episode
> [  722.060279] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  723.297293] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  724.771105] rcu-torture: rtc: 000000003e7494f4 ver: 19570 tfle: 0 rta: 19571 rtaf: 0 rtf: 19561 rtmbe: 0 rtmbkf: 0/6133 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2056687 onoff: 251/251:258/258 28,1937:20,34603 39820:103151 (HZ=1000) barrier: 3615/3616:0 read-exits: 800 nocb-toggles: 0:0
> [  724.806116] rcu-torture: Reader Pipe:  874558187 83916 0 0 0 0 0 0 0 0 0
> [  724.815699] rcu-torture: Reader Batch:  874467448 174655 0 0 0 0 0 0 0 0 0
> [  724.825467] rcu-torture: Free-Block Circulation:  19570 19569 19568 19567 19566 19565 19564 19563 19562 19561 0
> [  725.431692] smpboot: CPU 4 is now offline
> [  726.463123] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  727.572200] smpboot: CPU 11 is now offline
> [  728.650586] smpboot: CPU 15 is now offline
> [  729.688119] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  730.742202] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  731.893749] smpboot: CPU 8 is now offline
> [  733.981151] smpboot: CPU 13 is now offline
> [  735.019166] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  735.139217] rcu-torture: rcu_torture_read_exit: Start of episode
> [  735.197745] rcu-torture: rcu_torture_read_exit: End of episode
> [  736.136945] smpboot: CPU 7 is now offline
> [  737.189263] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  738.285341] smpboot: CPU 5 is now offline
> [  739.362227] smpboot: CPU 4 is now offline
> [  740.165106] rcu-torture: rtc: 000000007abed409 ver: 20346 tfle: 0 rta: 20347 rtaf: 0 rtf: 20336 rtmbe: 0 rtmbkf: 0/6221 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2111226 onoff: 256/256:266/266 28,1937:20,34603 40107:103881 (HZ=1000) barrier: 3712/3713:0 read-exits: 816 nocb-toggles: 0:0
> [  740.203007] rcu-torture: Reader Pipe:  898901665 87026 0 0 0 0 0 0 0 0 0
> [  740.211809] rcu-torture: Reader Batch:  898807031 181660 0 0 0 0 0 0 0 0 0
> [  740.220719] rcu-torture: Free-Block Circulation:  20346 20345 20344 20343 20342 20341 20339 20338 20337 20336 0
> [  740.413801] smpboot: CPU 8 is now offline
> [  741.428031] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  743.463230] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  744.533417] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  745.625392] smpboot: CPU 1 is now offline
> [  746.686652] smpboot: CPU 12 is now offline
> [  747.701176] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  748.645929] rcu-torture: rcu_torture_read_exit: Start of episode
> [  748.659360] rcu-torture: rcu_torture_read_exit: End of episode
> [  748.792854] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  749.858366] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  750.913621] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  751.986353] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  753.327303] smpboot: CPU 9 is now offline
> [  754.386548] smpboot: CPU 8 is now offline
> [  755.491959] rcu-torture: rtc: 000000003ce8dd47 ver: 20839 tfle: 0 rta: 20840 rtaf: 0 rtf: 20829 rtmbe: 0 rtmbkf: 0/6379 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2148498 onoff: 264/264:271/272 28,1937:20,34603 40608:104389 (HZ=1000) barrier: 3814/3814:0 read-exits: 832 nocb-toggles: 0:0
> [  755.535486] rcu-torture: Reader Pipe:  913664495 88980 0 0 0 0 0 0 0 0 0
> [  755.545372] rcu-torture: Reader Batch:  913567654 185821 0 0 0 0 0 0 0 0 0
> [  755.555323] rcu-torture: Free-Block Circulation:  20839 20838 20837 20836 20835 20834 20833 20831 20830 20829 0
> [  755.571837] smpboot: CPU 12 is now offline
> [  756.005959] rcu_torture_fwd_prog n_max_cbs: 35156
> [  756.014539] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  756.023712] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  756.151410] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  756.216817] rcu_torture_fwd_prog_cr Duration 57 barrier: 65 pending 27044 n_launders: 54857 n_launders_sa: 47903 n_max_gps: 100 n_max_cbs: 29660 cver 5 gps 11
> [  756.241491] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 147 jiffies): 1s/10: 84517:15
> [  756.689281] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  757.283102] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  759.090215] smpboot: CPU 4 is now offline
> [  760.357353] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  762.083073] rcu-torture: rcu_torture_read_exit: Start of episode
> [  762.149276] rcu-torture: rcu_torture_read_exit: End of episode
> [  763.141176] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  765.575166] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  767.844479] smpboot: CPU 5 is now offline
> [  769.669257] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  770.851034] rcu-torture: rtc: 00000000e9bd9eab ver: 20980 tfle: 0 rta: 20980 rtaf: 0 rtf: 20969 rtmbe: 0 rtmbkf: 0/6424 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2201199 onoff: 269/269:274/275 28,1937:20,34603 43110:107200 (HZ=1000) barrier: 3837/3838:0 read-exits: 848 nocb-toggles: 0:0
> [  770.895506] rcu-torture: Reader Pipe:  942037745 89610 0 0 0 0 0 0 0 0 0
> [  770.908846] rcu-torture: Reader Batch:  941940422 186933 0 0 0 0 0 0 0 0 0
> [  770.922678] rcu-torture: Free-Block Circulation:  20979 20979 20978 20977 20976 20975 20974 20972 20971 20969 0
> [  772.189738] smpboot: CPU 15 is now offline
> [  773.839885] rcu_torture_fwd_prog_nr: 0 Duration 16512 cver 53 gps 73
> [  773.891266] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  773.907465] smpboot: CPU 11 is now offline
> [  774.993339] smpboot: CPU 13 is now offline
> [  776.055620] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  776.485965] rcu-torture: rcu_torture_read_exit: Start of episode
> [  776.520151] rcu-torture: rcu_torture_read_exit: End of episode
> [  778.145455] smpboot: CPU 1 is now offline
> [  779.223785] smpboot: CPU 7 is now offline
> [  780.334737] smpboot: CPU 10 is now offline
> [  781.398683] smpboot: CPU 3 is now offline
> [  782.430568] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  783.720370] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  784.770276] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  785.862465] smpboot: CPU 8 is now offline
> [  786.211952] rcu-torture: rtc: 00000000291f4d1b ver: 21545 tfle: 0 rta: 21546 rtaf: 0 rtf: 21536 rtmbe: 0 rtmbkf: 0/6501 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2244167 onoff: 273/273:282/282 28,1937:20,34603 43593:109855 (HZ=1000) barrier: 3911/3912:0 read-exits: 864 nocb-toggles: 0:0
> [  786.246430] rcu-torture: Reader Pipe:  959967628 91724 0 0 0 0 0 0 0 0 0
> [  786.255613] rcu-torture: Reader Batch:  959867852 191500 0 0 0 0 0 0 0 0 0
> [  786.265072] rcu-torture: Free-Block Circulation:  21545 21544 21543 21542 21541 21540 21539 21538 21537 21536 0
> [  786.987837] smpboot: CPU 3 is now offline
> [  788.085605] smpboot: CPU 2 is now offline
> [  789.106971] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  790.117987] rcu-torture: rcu_torture_read_exit: Start of episode
> [  790.153475] rcu-torture: rcu_torture_read_exit: End of episode
> [  791.171784] smpboot: CPU 15 is now offline
> [  792.192276] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  793.252555] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  794.319333] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  795.369287] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  796.408279] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  797.498824] smpboot: CPU 12 is now offline
> [  798.570641] smpboot: CPU 6 is now offline
> [  799.606026] smpboot: CPU 14 is now offline
> [  800.672350] smpboot: CPU 11 is now offline
> [  801.314990] rcu-torture: rtc: 00000000f0da0bf3 ver: 22168 tfle: 0 rta: 22169 rtaf: 0 rtf: 22159 rtmbe: 0 rtmbkf: 0/6501 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2271737 onoff: 279/279:289/289 28,1937:20,34603 43886:110364 (HZ=1000) barrier: 4024/4024:0 read-exits: 880 nocb-toggles: 0:0
> [  801.365018] rcu-torture: Reader Pipe:  973326646 93528 0 0 0 0 0 0 0 0 0
> [  801.377981] rcu-torture: Reader Batch:  973223798 196376 0 0 0 0 0 0 0 0 0
> [  801.390053] rcu-torture: Free-Block Circulation:  22169 22168 22167 22166 22165 22164 22163 22162 22161 22160 0
> [  801.699072] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  802.849004] smpboot: CPU 5 is now offline
> [  803.491078] rcu-torture: rcu_torture_read_exit: Start of episode
> [  803.511749] rcu-torture: rcu_torture_read_exit: End of episode
> [  803.874137] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  804.942033] smpboot: CPU 3 is now offline
> [  806.045420] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  807.073843] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  808.136507] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  809.277794] smpboot: CPU 13 is now offline
> [  811.333161] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  812.376220] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  813.541851] smpboot: CPU 9 is now offline
> [  814.615808] smpboot: CPU 1 is now offline
> [  815.711549] smpboot: CPU 14 is now offline
> [  816.422997] rcu-torture: rtc: 00000000e5b8a0be ver: 22897 tfle: 0 rta: 22898 rtaf: 0 rtf: 22883 rtmbe: 0 rtmbkf: 0/6583 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2324184 onoff: 286/286:295/295 28,1937:20,34603 44302:110974 (HZ=1000) barrier: 4113/4113:0 read-exits: 896 nocb-toggles: 0:0
> [  816.458255] rcu-torture: Reader Pipe:  993752981 96271 0 0 0 0 0 0 0 0 0
> [  816.466909] rcu-torture: Reader Batch:  993647462 201790 0 0 0 0 0 0 0 0 0
> [  816.474228] rcu-torture: Free-Block Circulation:  22897 22896 22894 22893 22892 22891 22890 22888 22884 22883 0
> [  816.867043] rcu-torture: rcu_torture_read_exit: Start of episode
> [  816.883626] rcu-torture: rcu_torture_read_exit: End of episode
> [  817.033273] smpboot: CPU 8 is now offline
> [  818.090550] smpboot: CPU 7 is now offline
> [  819.139488] smpboot: CPU 4 is now offline
> [  820.162116] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  821.202177] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  822.236330] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  823.341725] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  824.402037] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  825.545386] smpboot: CPU 2 is now offline
> [  826.597219] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  828.735295] smpboot: CPU 11 is now offline
> [  829.857435] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  830.371054] rcu-torture: rcu_torture_read_exit: Start of episode
> [  830.396611] rcu-torture: rcu_torture_read_exit: End of episode
> [  831.779191] rcu-torture: rtc: 000000004d9afe17 ver: 23397 tfle: 0 rta: 23398 rtaf: 0 rtf: 23388 rtmbe: 0 rtmbkf: 0/6583 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2359493 onoff: 293/293:300/300 28,1937:20,34603 44892:111566 (HZ=1000) barrier: 4216/4216:0 read-exits: 928 nocb-toggles: 0:0
> [  831.818946] rcu-torture: Reader Pipe:  1008971167 97988 0 0 0 0 0 0 0 0 0
> [  831.829229] rcu-torture: Reader Batch:  1008863904 205251 0 0 0 0 0 0 0 0 0
> [  831.840002] rcu-torture: Free-Block Circulation:  23398 23397 23396 23395 23394 23393 23392 23391 23390 23389 0
> [  832.019094] smpboot: CPU 10 is now offline
> [  833.043979] smpboot: CPU 9 is now offline
> [  834.120115] smpboot: CPU 5 is now offline
> [  835.166770] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  836.214654] smpboot: CPU 6 is now offline
> [  837.243296] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  837.923229] rcu_torture_fwd_prog n_max_cbs: 29660
> [  837.932422] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  837.948430] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  838.064308] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  838.160398] rcu_torture_fwd_prog_cr Duration 82 barrier: 96 pending 16841 n_launders: 63593 n_launders_sa: 20335 n_max_gps: 100 n_max_cbs: 35141 cver 7 gps 13
> [  838.181959] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 200 jiffies): 1s/10: 97145:14 2s/10: 1589:2
> [  838.463411] smpboot: CPU 10 is now offline
> [  839.202976] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  839.856616] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  841.865544] smpboot: CPU 4 is now offline
> [  843.356330] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  843.811092] rcu-torture: rcu_torture_read_exit: Start of episode
> [  843.848531] rcu-torture: rcu_torture_read_exit: End of episode
> [  845.010108] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  846.705430] smpboot: CPU 12 is now offline
> [  847.139067] rcu-torture: rtc: 00000000cdea12a5 ver: 23843 tfle: 0 rta: 23843 rtaf: 0 rtf: 23830 rtmbe: 0 rtmbkf: 0/6583 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2403964 onoff: 298/298:307/307 28,1937:20,34603 46592:113661 (HZ=1000) barrier: 4269/4270:0 read-exits: 944 nocb-toggles: 0:0
> [  847.186197] rcu-torture: Reader Pipe:  1028564170 99474 0 0 0 0 0 0 0 0 0
> [  847.201083] rcu-torture: Reader Batch:  1028455617 208027 0 0 0 0 0 0 0 0 0
> [  847.211336] rcu-torture: Free-Block Circulation:  23842 23842 23840 23839 23837 23835 23833 23832 23831 23830 0
> [  847.719411] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  848.763798] smpboot: CPU 1 is now offline
> [  849.776662] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  850.084931] rcu_torture_fwd_prog_nr: 0 Duration 10833 cver 53 gps 50
> [  850.096287] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  850.919110] smpboot: CPU 11 is now offline
> [  851.989974] smpboot: CPU 7 is now offline
> [  853.070755] smpboot: CPU 8 is now offline
> [  854.099239] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  855.153159] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  856.223311] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  857.371009] smpboot: CPU 2 is now offline
> [  858.020013] rcu-torture: rcu_torture_read_exit: Start of episode
> [  858.037844] rcu-torture: rcu_torture_read_exit: End of episode
> [  858.677369] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  859.768181] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  860.914514] smpboot: CPU 3 is now offline
> [  861.956296] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  862.499125] rcu-torture: rtc: 0000000066f543dd ver: 24363 tfle: 0 rta: 24364 rtaf: 0 rtf: 24354 rtmbe: 0 rtmbkf: 0/6583 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2439643 onoff: 306/306:313/313 28,1937:17,34603 47098:114149 (HZ=1000) barrier: 4351/4351:0 read-exits: 960 nocb-toggles: 0:0
> [  862.554208] rcu-torture: Reader Pipe:  1041364546 101331 0 0 0 0 0 0 0 0 0
> [  862.572528] rcu-torture: Reader Batch:  1041254259 211618 0 0 0 0 0 0 0 0 0
> [  862.586557] rcu-torture: Free-Block Circulation:  24364 24363 24362 24361 24360 24359 24358 24357 24356 24355 0
> [  863.177554] smpboot: CPU 5 is now offline
> [  864.230454] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  865.453804] smpboot: CPU 12 is now offline
> [  866.496286] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  867.560206] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  868.627349] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  869.729420] smpboot: CPU 8 is now offline
> [  871.177400] smpboot: CPU 12 is now offline
> [  871.394927] rcu-torture: rcu_torture_read_exit: Start of episode
> [  871.424308] rcu-torture: rcu_torture_read_exit: End of episode
> [  872.338756] smpboot: CPU 13 is now offline
> [  873.360256] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  874.411192] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  875.557479] smpboot: CPU 14 is now offline
> [  876.650073] smpboot: CPU 4 is now offline
> [  877.665750] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  877.862967] rcu-torture: rtc: 000000003e7494f4 ver: 24762 tfle: 0 rta: 24763 rtaf: 0 rtf: 24752 rtmbe: 0 rtmbkf: 0/6704 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2481965 onoff: 313/313:320/320 28,1937:17,34603 47538:115396 (HZ=1000) barrier: 4450/4451:0 read-exits: 976 nocb-toggles: 0:0
> [  877.914008] rcu-torture: Reader Pipe:  1063329224 103290 0 0 0 0 0 0 0 0 0
> [  877.927633] rcu-torture: Reader Batch:  1063216569 215945 0 0 0 0 0 0 0 0 0
> [  877.941317] rcu-torture: Free-Block Circulation:  24763 24762 24761 24759 24758 24757 24756 24755 24754 24753 0
> [  878.785708] smpboot: CPU 6 is now offline
> [  879.870559] smpboot: CPU 3 is now offline
> [  880.916367] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  881.979241] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  883.046348] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  884.114407] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  884.835318] rcu-torture: rcu_torture_read_exit: Start of episode
> [  884.874969] rcu-torture: rcu_torture_read_exit: End of episode
> [  885.297308] smpboot: CPU 9 is now offline
> [  886.411664] smpboot: CPU 12 is now offline
> [  887.478347] smpboot: CPU 13 is now offline
> [  888.811334] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  889.869822] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  890.962301] smpboot: CPU 15 is now offline
> [  891.990237] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  893.221962] rcu-torture: rtc: 00000000238e9780 ver: 25423 tfle: 0 rta: 25424 rtaf: 0 rtf: 25412 rtmbe: 0 rtmbkf: 0/7013 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2542452 onoff: 320/321:326/326 28,1937:17,34603 48252:115993 (HZ=1000) barrier: 4536/4537:0 read-exits: 992 nocb-toggles: 0:0
> [  893.262922] rcu-torture: Reader Pipe:  1087405611 106375 0 0 0 0 0 0 0 0 0
> [  893.272571] rcu-torture: Reader Batch:  1087289612 222374 0 0 0 0 0 0 0 0 0
> [  893.283376] rcu-torture: Free-Block Circulation:  25424 25423 25422 25421 25420 25419 25418 25416 25414 25413 0
> [  893.328792] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  894.434344] smpboot: CPU 6 is now offline
> [  895.875798] smpboot: CPU 3 is now offline
> [  896.930403] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  897.974516] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  898.211139] rcu-torture: rcu_torture_read_exit: Start of episode
> [  898.231381] rcu-torture: rcu_torture_read_exit: End of episode
> [  899.015256] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  900.154037] smpboot: CPU 10 is now offline
> [  901.188748] smpboot: CPU 9 is now offline
> [  902.259372] smpboot: CPU 12 is now offline
> [  903.316976] smpboot: CPU 13 is now offline
> [  904.427727] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  905.484689] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  906.754706] smpboot: CPU 15 is now offline
> [  907.838954] smpboot: CPU 4 is now offline
> [  908.579076] rcu-torture: rtc: 00000000f0da0bf3 ver: 25787 tfle: 0 rta: 25788 rtaf: 0 rtf: 25778 rtmbe: 0 rtmbkf: 0/7144 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2586132 onoff: 326/326:334/334 28,1937:17,34603 48961:117093 (HZ=1000) barrier: 4631/4631:0 read-exits: 1008 nocb-toggles: 0:0
> [  908.618470] rcu-torture: Reader Pipe:  1108425011 108237 0 0 0 0 0 0 0 0 0
> [  908.629309] rcu-torture: Reader Batch:  1108306917 226331 0 0 0 0 0 0 0 0 0
> [  908.640136] rcu-torture: Free-Block Circulation:  25787 25786 25785 25784 25783 25782 25781 25780 25779 25778 0
> [  909.170431] smpboot: CPU 14 is now offline
> [  910.227493] smpboot: CPU 6 is now offline
> [  911.285014] smpboot: CPU 3 is now offline
> [  911.652090] rcu-torture: rcu_torture_read_exit: Start of episode
> [  911.696121] rcu-torture: rcu_torture_read_exit: End of episode
> [  912.305161] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  913.366067] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  914.438984] smpboot: CPU 8 is now offline
> [  915.469400] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  915.746932] rcu_torture_fwd_prog n_max_cbs: 35141
> [  915.755843] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  915.767978] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  915.849954] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  915.893468] rcu_torture_fwd_prog_cr Duration 57 barrier: 43 pending 16837 n_launders: 45825 n_launders_sa: 43124 n_max_gps: 100 n_max_cbs: 26332 cver 5 gps 11
> [  915.914056] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 121 jiffies): 1s/10: 72157:14
> [  916.568246] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  916.963185] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  919.005546] smpboot: CPU 12 is now offline
> [  921.469978] smpboot: CPU 13 is now offline
> [  922.614271] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  923.939091] rcu-torture: rtc: 00000000e9bd9eab ver: 26269 tfle: 0 rta: 26270 rtaf: 0 rtf: 26257 rtmbe: 0 rtmbkf: 0/7144 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2631933 onoff: 331/332:340/340 28,1937:17,34603 49369:120472 (HZ=1000) barrier: 4696/4697:0 read-exits: 1024 nocb-toggles: 0:0
> [  923.987013] rcu-torture: Reader Pipe:  1128259937 109676 0 0 0 0 0 0 0 0 0
> [  924.001390] rcu-torture: Reader Batch:  1128139960 229653 0 0 0 0 0 0 0 0 0
> [  924.016325] rcu-torture: Free-Block Circulation:  26269 26267 26266 26264 26263 26262 26260 26259 26258 26257 0
> [  924.166413] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  925.091022] rcu-torture: rcu_torture_read_exit: Start of episode
> [  925.626957] rcu_torture_fwd_prog_nr: 0 Duration 8630 cver 30 gps 40
> [  925.648350] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  925.678870] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  926.760227] smpboot: CPU 3 is now offline
> [  927.822844] smpboot: CPU 14 is now offline
> [  928.879430] smpboot: CPU 6 is now offline
> [  929.739953] rcu-torture: rcu_torture_read_exit: End of episode
> [  929.943701] smpboot: CPU 2 is now offline
> [  931.363749] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  932.459745] smpboot: CPU 11 is now offline
> [  933.546470] smpboot: CPU 8 is now offline
> [  934.571143] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  935.645359] smpboot: CPU 7 is now offline
> [  936.660077] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  937.738753] smpboot: CPU 12 is now offline
> [  938.771255] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  939.301079] rcu-torture: rtc: 0000000073a266c1 ver: 26885 tfle: 0 rta: 26886 rtaf: 0 rtf: 26875 rtmbe: 0 rtmbkf: 0/7144 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2655882 onoff: 337/337:348/348 28,1937:17,34603 50983:121001 (HZ=1000) barrier: 4798/4798:0 read-exits: 1040 nocb-toggles: 0:0
> [  939.345843] rcu-torture: Reader Pipe:  1137318320 111091 0 0 0 0 0 0 0 0 0
> [  939.360032] rcu-torture: Reader Batch:  1137196693 232718 0 0 0 0 0 0 0 0 0
> [  939.372710] rcu-torture: Free-Block Circulation:  26885 26884 26883 26882 26881 26880 26879 26878 26877 26876 0
> [  939.835661] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  940.937364] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  942.338738] smpboot: CPU 2 is now offline
> [  943.139051] rcu-torture: rcu_torture_read_exit: Start of episode
> [  943.181453] rcu-torture: rcu_torture_read_exit: End of episode
> [  943.401346] smpboot: CPU 13 is now offline
> [  944.435389] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  945.668954] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  946.768658] smpboot: CPU 11 is now offline
> [  947.874856] smpboot: CPU 10 is now offline
> [  949.140312] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  950.256196] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  951.309020] smpboot: CPU 6 is now offline
> [  952.328310] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  953.370326] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  954.659067] rcu-torture: rtc: 00000000752e1e6e ver: 27459 tfle: 0 rta: 27459 rtaf: 0 rtf: 27450 rtmbe: 0 rtmbkf: 0/7144 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2685532 onoff: 345/345:353/353 28,1937:17,34603 51958:121649 (HZ=1000) barrier: 4898/4898:0 read-exits: 1056 nocb-toggles: 0:0
> [  954.709602] rcu-torture: Reader Pipe:  1151108928 112608 0 0 0 0 0 0 0 0 0
> [  954.723211] rcu-torture: Reader Batch:  1150985071 236465 0 0 0 0 0 0 0 0 0
> [  954.738384] rcu-torture: Free-Block Circulation:  27458 27458 27457 27456 27455 27454 27453 27452 27451 27450 0
> [  955.454390] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  956.547785] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [  956.643039] rcu-torture: rcu_torture_read_exit: Start of episode
> [  956.692580] rcu-torture: rcu_torture_read_exit: End of episode
> [  957.649675] smpboot: CPU 1 is now offline
> [  958.824440] smpboot: CPU 11 is now offline
> [  960.118586] smpboot: CPU 3 is now offline
> [  962.215308] smpboot: CPU 10 is now offline
> [  963.490305] smpboot: CPU 9 is now offline
> [  964.546706] smpboot: CPU 5 is now offline
> [  965.581565] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [  966.954547] smpboot: CPU 4 is now offline
> [  967.985932] smpboot: CPU 8 is now offline
> [  969.000182] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [  970.020172] rcu-torture: rtc: 000000000317e471 ver: 28239 tfle: 0 rta: 28240 rtaf: 0 rtf: 28229 rtmbe: 0 rtmbkf: 0/7144 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2726588 onoff: 349/349:361/361 28,1937:17,34603 52188:122991 (HZ=1000) barrier: 4994/4994:0 read-exits: 1072 nocb-toggles: 0:0
> [  970.056410] rcu-torture: Reader Pipe:  1165827396 114853 0 0 0 0 0 0 0 0 0
> [  970.069543] rcu-torture: Reader Batch:  1165701480 240769 0 0 0 0 0 0 0 0 0
> [  970.082924] rcu-torture: Free-Block Circulation:  28240 28239 28238 28237 28235 28234 28233 28232 28231 28230 0
> [  970.083215] rcu-torture: rcu_torture_read_exit: Start of episode
> [  970.122197] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  970.429170] rcu-torture: rcu_torture_read_exit: End of episode
> [  971.447289] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  972.496289] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [  973.610192] smpboot: CPU 15 is now offline
> [  974.808816] smpboot: CPU 9 is now offline
> [  976.040682] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [  977.085263] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [  978.158297] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [  979.250222] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  980.290257] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [  981.381848] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [  982.550423] smpboot: CPU 2 is now offline
> [  983.666417] smpboot: CPU 6 is now offline
> [  983.908944] rcu-torture: rcu_torture_read_exit: Start of episode
> [  983.959416] rcu-torture: rcu_torture_read_exit: End of episode
> [  984.901657] smpboot: CPU 7 is now offline
> [  985.379048] rcu-torture: rtc: 00000000be258066 ver: 28733 tfle: 0 rta: 28734 rtaf: 0 rtf: 28724 rtmbe: 0 rtmbkf: 0/7228 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2759072 onoff: 358/358:366/366 28,1937:17,34603 53310:123736 (HZ=1000) barrier: 5100/5100:0 read-exits: 1104 nocb-toggles: 0:0
> [  985.434281] rcu-torture: Reader Pipe:  1179897452 116443 0 0 0 0 0 0 0 0 0
> [  985.450698] rcu-torture: Reader Batch:  1179769116 244779 0 0 0 0 0 0 0 0 0
> [  985.467252] rcu-torture: Free-Block Circulation:  28734 28733 28732 28731 28730 28729 28728 28727 28726 28725 0
> [  986.277700] smpboot: CPU 12 is now offline
> [  987.318127] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [  988.382295] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [  989.458267] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [  990.700726] smpboot: CPU 7 is now offline
> [  991.819029] smpboot: CPU 15 is now offline
> [  992.854477] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [  993.573752] rcu_torture_fwd_prog n_max_cbs: 26332
> [  993.582333] rcu_torture_fwd_prog: Starting forward-progress test 0
> [  993.593141] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [  993.702710] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [  993.792083] rcu_torture_fwd_prog_cr Duration 80 barrier: 90 pending 14756 n_launders: 63085 n_launders_sa: 63085 n_max_gps: 100 n_max_cbs: 31493 cver 4 gps 16
> [  993.817956] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 196 jiffies): 1s/10: 82317:16 2s/10: 12261:2
> [  993.902221] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [  994.851216] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [  996.865156] smpboot: CPU 4 is now offline
> [  997.347041] rcu-torture: rcu_torture_read_exit: Start of episode
> [  997.388998] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1000.508717] smpboot: CPU 1 is now offline
> [ 1000.738988] rcu-torture: rtc: 000000008cfcac87 ver: 29197 tfle: 0 rta: 29198 rtaf: 0 rtf: 29187 rtmbe: 0 rtmbkf: 0/7388 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2815249 onoff: 363/363:371/371 28,1937:17,34603 53619:128025 (HZ=1000) barrier: 5163/5164:0 read-exits: 1120 nocb-toggles: 0:0
> [ 1000.784233] rcu-torture: Reader Pipe:  1206719589 118449 0 0 0 0 0 0 0 0 0
> [ 1000.798466] rcu-torture: Reader Batch:  1206588742 249296 0 0 0 0 0 0 0 0 0
> [ 1000.810622] rcu-torture: Free-Block Circulation:  29197 29196 29195 29194 29193 29192 29191 29190 29188 29187 0
> [ 1003.806616] smpboot: CPU 3 is now offline
> [ 1005.568341] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1007.730332] smpboot: CPU 10 is now offline
> [ 1010.485037] smpboot: CPU 13 is now offline
> [ 1011.295882] rcu_torture_fwd_prog_nr: 0 Duration 16422 cver 48 gps 63
> [ 1011.325519] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1011.541756] smpboot: CPU 5 is now offline
> [ 1012.002912] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1012.054305] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1012.626227] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1013.715668] smpboot: CPU 4 is now offline
> [ 1014.775408] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1015.852357] smpboot: CPU 8 is now offline
> [ 1016.098971] rcu-torture: rtc: 00000000d77fc62d ver: 29487 tfle: 0 rta: 29488 rtaf: 0 rtf: 29478 rtmbe: 0 rtmbkf: 0/7389 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2843095 onoff: 366/366:377/377 28,1937:17,34603 54600:132379 (HZ=1000) barrier: 5204/5204:0 read-exits: 1136 nocb-toggles: 0:0
> [ 1016.133030] rcu-torture: Reader Pipe:  1218447042 119283 0 0 0 0 0 0 0 0 0
> [ 1016.142443] rcu-torture: Reader Batch:  1218315188 251137 0 0 0 0 0 0 0 0 0
> [ 1016.151804] rcu-torture: Free-Block Circulation:  29487 29486 29485 29484 29483 29482 29481 29480 29479 29478 0
> [ 1016.880237] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1017.943203] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1019.003213] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1020.172066] smpboot: CPU 14 is now offline
> [ 1021.221577] smpboot: CPU 13 is now offline
> [ 1023.274440] smpboot: CPU 1 is now offline
> [ 1024.301039] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1025.440504] smpboot: CPU 10 is now offline
> [ 1025.446116] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1025.492172] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1026.638394] smpboot: CPU 2 is now offline
> [ 1027.676546] smpboot: CPU 7 is now offline
> [ 1028.699133] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1029.735286] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1030.803311] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1031.459033] rcu-torture: rtc: 00000000303bba63 ver: 30203 tfle: 0 rta: 30203 rtaf: 0 rtf: 30194 rtmbe: 0 rtmbkf: 0/7389 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2875603 onoff: 373/373:383/383 28,1937:17,34603 54967:132980 (HZ=1000) barrier: 5305/5305:0 read-exits: 1152 nocb-toggles: 0:0
> [ 1031.508709] rcu-torture: Reader Pipe:  1234361227 121188 0 0 0 0 0 0 0 0 0
> [ 1031.521533] rcu-torture: Reader Batch:  1234226358 256057 0 0 0 0 0 0 0 0 0
> [ 1031.534242] rcu-torture: Free-Block Circulation:  30202 30202 30201 30200 30199 30198 30197 30196 30195 30194 0
> [ 1031.844507] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1032.883429] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1033.986722] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1035.204571] smpboot: CPU 11 is now offline
> [ 1036.278497] smpboot: CPU 9 is now offline
> [ 1037.315230] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1038.403941] smpboot: CPU 13 is now offline
> [ 1038.882978] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1038.925274] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1039.433258] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1040.501247] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1041.609094] smpboot: CPU 14 is now offline
> [ 1042.717245] smpboot: CPU 3 is now offline
> [ 1043.750461] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1044.829762] smpboot: CPU 5 is now offline
> [ 1045.858576] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1046.819941] rcu-torture: rtc: 00000000752e1e6e ver: 30849 tfle: 0 rta: 30850 rtaf: 0 rtf: 30838 rtmbe: 0 rtmbkf: 0/7458 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2919796 onoff: 381/381:389/389 28,1937:17,34603 55419:133564 (HZ=1000) barrier: 5402/5403:0 read-exits: 1168 nocb-toggles: 0:0
> [ 1046.864250] rcu-torture: Reader Pipe:  1251795713 123761 0 0 0 0 0 0 0 0 0
> [ 1046.876683] rcu-torture: Reader Batch:  1251657279 262195 0 0 0 0 0 0 0 0 0
> [ 1046.889299] rcu-torture: Free-Block Circulation:  30850 30849 30848 30847 30846 30844 30843 30841 30840 30839 0
> [ 1046.914685] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1047.977457] smpboot: CPU 10 is now offline
> [ 1049.034675] smpboot: CPU 6 is now offline
> [ 1050.053695] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1051.097556] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1052.159239] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1052.323915] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1052.355820] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1053.322578] smpboot: CPU 9 is now offline
> [ 1054.368351] smpboot: CPU 15 is now offline
> [ 1055.404292] smpboot: CPU 2 is now offline
> [ 1056.433679] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1057.471080] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1058.527989] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1059.672190] smpboot: CPU 1 is now offline
> [ 1060.763618] smpboot: CPU 13 is now offline
> [ 1061.863004] smpboot: CPU 7 is now offline
> [ 1061.923011] rcu-torture: rtc: 00000000251a4f2e ver: 31349 tfle: 0 rta: 31350 rtaf: 0 rtf: 31340 rtmbe: 0 rtmbkf: 0/7615 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 2956084 onoff: 388/388:397/397 28,1937:17,34603 55823:134122 (HZ=1000) barrier: 5509/5509:0 read-exits: 1184 nocb-toggles: 0:0
> [ 1061.972714] rcu-torture: Reader Pipe:  1270529728 125927 0 0 0 0 0 0 0 0 0
> [ 1061.986105] rcu-torture: Reader Batch:  1270387994 267661 0 0 0 0 0 0 0 0 0
> [ 1062.000290] rcu-torture: Free-Block Circulation:  31350 31349 31348 31347 31346 31345 31344 31343 31342 31341 0
> [ 1063.022947] smpboot: CPU 6 is now offline
> [ 1064.055203] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1065.111185] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1065.765182] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1065.827296] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1066.174384] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1067.594313] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1068.782458] smpboot: CPU 5 is now offline
> [ 1069.902668] smpboot: CPU 11 is now offline
> [ 1070.953365] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1072.046303] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1073.124357] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1074.202171] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1075.319371] smpboot: CPU 12 is now offline
> [ 1075.491108] rcu_torture_fwd_prog n_max_cbs: 31493
> [ 1075.498082] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1075.506742] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1075.656412] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1075.711031] rcu_torture_fwd_prog_cr Duration 74 barrier: 55 pending 36582 n_launders: 110204 n_launders_sa: 108166 n_max_gps: 100 n_max_cbs: 55082 cver 7 gps 21
> [ 1075.729699] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 147 jiffies): 1s/10: 165286:24
> [ 1076.422507] smpboot: CPU 9 is now offline
> [ 1076.772935] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1077.028018] rcu-torture: rtc: 00000000b48fccde ver: 32002 tfle: 0 rta: 32003 rtaf: 0 rtf: 31992 rtmbe: 0 rtmbkf: 0/7878 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3017636 onoff: 396/396:402/402 28,1937:17,34603 56725:134762 (HZ=1000) barrier: 5595/5596:0 read-exits: 1200 nocb-toggles: 0:0
> [ 1077.069313] rcu-torture: Reader Pipe:  1297266295 129111 0 0 0 0 0 0 0 0 0
> [ 1077.078714] rcu-torture: Reader Batch:  1297121289 274117 0 0 0 0 0 0 0 0 0
> [ 1077.088441] rcu-torture: Free-Block Circulation:  32002 32000 31999 31998 31997 31996 31995 31994 31993 31992 0
> [ 1078.974589] smpboot: CPU 2 is now offline
> [ 1079.205997] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1079.229722] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1081.396387] smpboot: CPU 1 is now offline
> [ 1083.166634] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1085.120365] smpboot: CPU 14 is now offline
> [ 1086.588305] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1088.210878] rcu_torture_fwd_prog_nr: 0 Duration 11386 cver 25 gps 48
> [ 1088.283529] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1090.152676] smpboot: CPU 6 is now offline
> [ 1091.204216] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1092.266220] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1092.389110] rcu-torture: rtc: 0000000050b26d72 ver: 32195 tfle: 0 rta: 32196 rtaf: 0 rtf: 32185 rtmbe: 0 rtmbkf: 0/7954 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3055234 onoff: 400/400:406/406 28,1937:17,34603 58149:139197 (HZ=1000) barrier: 5629/5630:0 read-exits: 1216 nocb-toggles: 0:0
> [ 1092.433802] rcu-torture: Reader Pipe:  1315336630 129994 0 0 0 0 0 0 0 0 0
> [ 1092.445382] rcu-torture: Reader Batch:  1315190658 275966 0 0 0 0 0 0 0 0 0
> [ 1092.458570] rcu-torture: Free-Block Circulation:  32196 32195 32194 32193 32192 32191 32190 32189 32188 32186 0
> [ 1093.335186] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1093.986951] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1094.017821] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1095.376509] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1096.463247] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1097.676945] smpboot: CPU 13 is now offline
> [ 1098.778420] smpboot: CPU 12 is now offline
> [ 1099.986363] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1101.130935] smpboot: CPU 9 is now offline
> [ 1102.377316] smpboot: CPU 7 is now offline
> [ 1104.094751] smpboot: CPU 11 is now offline
> [ 1105.161030] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1106.361849] smpboot: CPU 1 is now offline
> [ 1107.396517] smpboot: CPU 3 is now offline
> [ 1107.427029] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1107.747064] rcu-torture: rtc: 00000000c6cda55c ver: 32657 tfle: 0 rta: 32657 rtaf: 0 rtf: 32648 rtmbe: 0 rtmbkf: 0/8259 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3120116 onoff: 405/405:413/413 28,1937:17,34603 58655:140791 (HZ=1000) barrier: 5707/5707:0 read-exits: 1232 nocb-toggles: 0:0
> [ 1107.788288] rcu-torture: Reader Pipe:  1346839871 132732 0 0 0 0 0 0 0 0 0
> [ 1107.801787] rcu-torture: Reader Batch:  1346690697 281906 0 0 0 0 0 0 0 0 0
> [ 1107.812701] rcu-torture: Free-Block Circulation:  32656 32656 32655 32654 32653 32652 32651 32650 32649 32648 0
> [ 1108.456523] smpboot: CPU 11 is now offline
> [ 1110.477302] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1111.524310] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1111.766634] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1112.845019] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1113.986845] smpboot: CPU 8 is now offline
> [ 1115.015361] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1116.150506] smpboot: CPU 2 is now offline
> [ 1117.671234] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1118.752429] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1119.840777] smpboot: CPU 5 is now offline
> [ 1120.894843] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1122.068989] smpboot: CPU 11 is now offline
> [ 1123.107138] rcu-torture: rtc: 000000004996002a ver: 33049 tfle: 0 rta: 33050 rtaf: 0 rtf: 33037 rtmbe: 0 rtmbkf: 0/8510 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3166596 onoff: 412/412:418/419 28,1937:17,34603 59813:141290 (HZ=1000) barrier: 5792/5793:0 read-exits: 1248 nocb-toggles: 0:0
> [ 1123.166517] rcu-torture: Reader Pipe:  1365039321 134751 0 0 0 0 0 0 0 0 0
> [ 1123.179238] rcu-torture: Reader Batch:  1364888419 285653 0 0 0 0 0 0 0 0 0
> [ 1123.192135] rcu-torture: Free-Block Circulation:  33050 33049 33048 33047 33046 33045 33044 33043 33042 33041 0
> [ 1123.270823] smpboot: CPU 14 is now offline
> [ 1124.672861] smpboot: CPU 6 is now offline
> [ 1125.154997] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1125.175687] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1125.709494] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1126.822494] smpboot: CPU 5 is now offline
> [ 1127.863377] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1128.943280] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1130.073077] smpboot: CPU 2 is now offline
> [ 1131.099708] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1132.201297] smpboot: CPU 12 is now offline
> [ 1133.224113] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1134.259514] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1135.348734] smpboot: CPU 15 is now offline
> [ 1136.369480] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1137.466079] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1138.470093] rcu-torture: rtc: 000000004996002a ver: 33445 tfle: 0 rta: 33446 rtaf: 0 rtf: 33434 rtmbe: 0 rtmbkf: 0/8721 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3208394 onoff: 420/420:424/424 28,1937:17,34603 60306:142248 (HZ=1000) barrier: 5887/5887:0 read-exits: 1264 nocb-toggles: 0:0
> [ 1138.520230] rcu-torture: Reader Pipe:  1386039811 136690 0 0 0 0 0 0 0 0 0
> [ 1138.534727] rcu-torture: Reader Batch:  1385886593 289907 0 0 0 0 0 0 0 0 0
> [ 1138.549080] rcu-torture: Free-Block Circulation:  33446 33445 33443 33442 33441 33440 33438 33437 33436 33435 0
> [ 1138.596972] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1138.646405] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1138.660214] smpboot: CPU 7 is now offline
> [ 1140.071999] smpboot: CPU 15 is now offline
> [ 1141.188935] smpboot: CPU 4 is now offline
> [ 1142.719484] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1143.784253] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1144.844257] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1146.251058] smpboot: CPU 12 is now offline
> [ 1147.400967] smpboot: CPU 10 is now offline
> [ 1148.493358] smpboot: CPU 6 is now offline
> [ 1149.219304] rcu_torture_fwd_prog n_max_cbs: 55082
> [ 1149.229869] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1149.242014] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1149.355768] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1149.422429] rcu_torture_fwd_prog_cr Duration 58 barrier: 67 pending 22920 n_launders: 43708 n_launders_sa: 4250 n_max_gps: 100 n_max_cbs: 28310 cver 4 gps 8
> [ 1149.441744] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 144 jiffies): 1s/10: 72018:11
> [ 1149.539279] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1150.500351] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1151.669819] smpboot: CPU 5 is now offline
> [ 1152.035979] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1152.073159] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1153.833991] rcu-torture: rtc: 00000000375827ac ver: 33952 tfle: 0 rta: 33953 rtaf: 0 rtf: 33943 rtmbe: 0 rtmbkf: 0/8911 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3274336 onoff: 424/424:431/432 28,1937:17,34603 61051:144624 (HZ=1000) barrier: 5954/5955:0 read-exits: 1296 nocb-toggles: 0:0
> [ 1153.879266] rcu-torture: Reader Pipe:  1413683165 139580 0 0 0 0 0 0 0 0 0
> [ 1153.890283] rcu-torture: Reader Batch:  1413527460 295285 0 0 0 0 0 0 0 0 0
> [ 1153.901630] rcu-torture: Free-Block Circulation:  33952 33951 33950 33949 33948 33947 33946 33945 33944 33943 0
> [ 1153.918989] smpboot: CPU 8 is now offline
> [ 1154.927630] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1157.585370] smpboot: CPU 14 is now offline
> [ 1157.737890] rcu_torture_fwd_prog_nr: 0 Duration 7204 cver 38 gps 31
> [ 1157.795234] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1158.650717] smpboot: CPU 1 is now offline
> [ 1159.678313] smpboot: CPU 9 is now offline
> [ 1160.707237] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1161.746472] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1162.799165] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1163.984163] smpboot: CPU 11 is now offline
> [ 1165.148578] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1166.466805] smpboot: CPU 3 is now offline
> [ 1166.629030] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1166.647727] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1167.583949] smpboot: CPU 15 is now offline
> [ 1169.188057] rcu-torture: rtc: 000000009b358718 ver: 34245 tfle: 0 rta: 34246 rtaf: 0 rtf: 34235 rtmbe: 0 rtmbkf: 0/8911 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3310130 onoff: 429/429:438/438 28,1937:17,34603 61410:148165 (HZ=1000) barrier: 6037/6037:0 read-exits: 1312 nocb-toggles: 0:0
> [ 1169.219743] rcu-torture: Reader Pipe:  1430592749 140730 0 0 0 0 0 0 0 0 0
> [ 1169.227059] rcu-torture: Reader Batch:  1430435943 297536 0 0 0 0 0 0 0 0 0
> [ 1169.234260] rcu-torture: Free-Block Circulation:  34245 34244 34243 34242 34241 34240 34239 34238 34237 34235 0
> [ 1169.773079] smpboot: CPU 14 is now offline
> [ 1170.809151] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1171.935686] smpboot: CPU 2 is now offline
> [ 1173.047334] smpboot: CPU 7 is now offline
> [ 1174.068242] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1175.113354] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1176.188261] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1177.311422] smpboot: CPU 1 is now offline
> [ 1178.390031] smpboot: CPU 8 is now offline
> [ 1179.421171] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1180.002978] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1180.039612] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1180.698366] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1181.749148] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1182.825260] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1183.990246] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1184.547075] rcu-torture: rtc: 00000000fd872ed6 ver: 35024 tfle: 0 rta: 35025 rtaf: 0 rtf: 35014 rtmbe: 0 rtmbkf: 0/8911 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3360353 onoff: 438/438:443/443 28,1937:17,34603 62254:148745 (HZ=1000) barrier: 6126/6127:0 read-exits: 1328 nocb-toggles: 0:0
> [ 1184.592746] rcu-torture: Reader Pipe:  1452680268 143334 0 0 0 0 0 0 0 0 0
> [ 1184.605096] rcu-torture: Reader Batch:  1452520422 303180 0 0 0 0 0 0 0 0 0
> [ 1184.617442] rcu-torture: Free-Block Circulation:  35025 35024 35023 35022 35021 35020 35019 35018 35017 35015 0
> [ 1185.038607] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1186.182751] smpboot: CPU 10 is now offline
> [ 1187.198148] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1189.316505] smpboot: CPU 2 is now offline
> [ 1190.872977] smpboot: CPU 10 is now offline
> [ 1191.937703] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1193.058150] smpboot: CPU 9 is now offline
> [ 1193.702040] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1193.730464] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1195.149723] smpboot: CPU 12 is now offline
> [ 1196.264748] smpboot: CPU 6 is now offline
> [ 1197.358048] smpboot: CPU 4 is now offline
> [ 1199.401195] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1199.907120] rcu-torture: rtc: 00000000b3041531 ver: 35437 tfle: 0 rta: 35438 rtaf: 0 rtf: 35428 rtmbe: 0 rtmbkf: 0/9099 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3402717 onoff: 442/442:450/450 28,1937:17,34603 62563:149830 (HZ=1000) barrier: 6224/6224:0 read-exits: 1344 nocb-toggles: 0:0
> [ 1199.947248] rcu-torture: Reader Pipe:  1467636565 145256 0 0 0 0 0 0 0 0 0
> [ 1199.958660] rcu-torture: Reader Batch:  1467474601 307220 0 0 0 0 0 0 0 0 0
> [ 1199.970191] rcu-torture: Free-Block Circulation:  35438 35437 35436 35435 35434 35433 35432 35431 35430 35429 0
> [ 1200.500729] smpboot: CPU 15 is now offline
> [ 1201.560655] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1202.642039] smpboot: CPU 2 is now offline
> [ 1203.984115] smpboot: CPU 8 is now offline
> [ 1204.996972] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1206.276203] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1207.075018] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1207.106047] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1207.377608] smpboot: CPU 7 is now offline
> [ 1208.427754] smpboot: CPU 1 is now offline
> [ 1209.447164] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1210.535233] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1211.631042] smpboot: CPU 14 is now offline
> [ 1212.655637] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1213.739147] smpboot: CPU 8 is now offline
> [ 1214.755010] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1215.266980] rcu-torture: rtc: 00000000ff12e684 ver: 35992 tfle: 0 rta: 35992 rtaf: 0 rtf: 35983 rtmbe: 0 rtmbkf: 0/9099 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3434950 onoff: 449/449:457/457 27,1937:17,34603 63168:150572 (HZ=1000) barrier: 6329/6329:0 read-exits: 1360 nocb-toggles: 0:0
> [ 1215.309372] rcu-torture: Reader Pipe:  1483796305 147071 0 0 0 0 0 0 0 0 0
> [ 1215.322122] rcu-torture: Reader Batch:  1483631389 311987 0 0 0 0 0 0 0 0 0
> [ 1215.334357] rcu-torture: Free-Block Circulation:  35991 35991 35990 35989 35988 35987 35986 35985 35984 35983 0
> [ 1215.841594] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1217.118113] smpboot: CPU 10 is now offline
> [ 1218.160288] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1218.851044] rcu_torture_fwd_prog n_max_cbs: 28310
> [ 1218.856480] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1218.864483] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1218.982943] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1219.039009] rcu_torture_fwd_prog_cr Duration 92 barrier: 56 pending 37312 n_launders: 68343 n_launders_sa: 14309 n_max_gps: 100 n_max_cbs: 42471 cver 7 gps 17
> [ 1219.063606] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 172 jiffies): 1s/10: 96839:18 2s/10: 13975:2
> [ 1219.266341] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1220.131159] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1220.450973] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1220.529126] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1221.672308] smpboot: CPU 2 is now offline
> [ 1224.364689] smpboot: CPU 10 is now offline
> [ 1225.772662] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1227.447340] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1230.626997] rcu-torture: rtc: 0000000050b26d72 ver: 36210 tfle: 0 rta: 36211 rtaf: 0 rtf: 36199 rtmbe: 0 rtmbkf: 0/9199 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3491630 onoff: 454/454:460/461 27,1937:17,34603 64495:153895 (HZ=1000) barrier: 6368/6369:0 read-exits: 1376 nocb-toggles: 0:0
> [ 1230.672730] rcu-torture: Reader Pipe:  1506767072 148007 0 0 0 0 0 0 0 0 0
> [ 1230.681686] rcu-torture: Reader Batch:  1506601087 313992 0 0 0 0 0 0 0 0 0
> [ 1230.691235] rcu-torture: Free-Block Circulation:  36210 36208 36207 36206 36205 36204 36203 36201 36200 36199 0
> [ 1231.180615] smpboot: CPU 12 is now offline
> [ 1233.613955] smpboot: CPU 5 is now offline
> [ 1234.978943] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1235.038028] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1235.695389] smpboot: CPU 4 is now offline
> [ 1237.265961] rcu_torture_fwd_prog_nr: 0 Duration 17092 cver 57 gps 69
> [ 1237.288912] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1237.314760] smpboot: CPU 15 is now offline
> [ 1239.344411] smpboot: CPU 14 is now offline
> [ 1240.363566] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1241.452969] smpboot: CPU 1 is now offline
> [ 1242.499277] smpboot: CPU 7 is now offline
> [ 1243.570046] smpboot: CPU 9 is now offline
> [ 1244.592349] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1245.643245] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1245.993047] rcu-torture: rtc: 0000000073a266c1 ver: 36560 tfle: 0 rta: 36561 rtaf: 0 rtf: 36551 rtmbe: 0 rtmbkf: 0/9208 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3521604 onoff: 457/457:468/468 27,1937:17,34603 64635:158944 (HZ=1000) barrier: 6443/6443:0 read-exits: 1392 nocb-toggles: 0:0
> [ 1246.027581] rcu-torture: Reader Pipe:  1522775074 148634 0 0 0 0 0 0 0 0 0
> [ 1246.038032] rcu-torture: Reader Batch:  1522608103 315605 0 0 0 0 0 0 0 0 0
> [ 1246.048517] rcu-torture: Free-Block Circulation:  36560 36559 36558 36557 36556 36555 36554 36553 36552 36551 0
> [ 1247.696421] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1248.995017] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1249.059468] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1249.341272] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1250.525196] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1251.591453] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1252.668494] smpboot: CPU 6 is now offline
> [ 1253.723998] smpboot: CPU 7 is now offline
> [ 1254.765209] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1255.883097] smpboot: CPU 8 is now offline
> [ 1256.904168] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1257.985958] smpboot: CPU 13 is now offline
> [ 1260.051594] smpboot: CPU 8 is now offline
> [ 1261.209083] smpboot: CPU 12 is now offline
> [ 1261.349364] rcu-torture: rtc: 00000000be258066 ver: 37337 tfle: 0 rta: 37338 rtaf: 0 rtf: 37327 rtmbe: 0 rtmbkf: 0/9229 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3567944 onoff: 463/463:474/474 27,1937:17,34603 65674:159430 (HZ=1000) barrier: 6533/6534:0 read-exits: 1408 nocb-toggles: 0:0
> [ 1261.403613] rcu-torture: Reader Pipe:  1544700092 151320 0 0 0 0 0 0 0 0 0
> [ 1261.417337] rcu-torture: Reader Batch:  1544529631 321781 0 0 0 0 0 0 0 0 0
> [ 1261.427389] rcu-torture: Free-Block Circulation:  37338 37337 37336 37335 37333 37332 37331 37330 37329 37328 0
> [ 1262.235259] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1262.818999] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1263.276009] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1264.314175] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1265.419531] smpboot: CPU 3 is now offline
> [ 1266.493306] smpboot: CPU 1 is now offline
> [ 1267.562465] smpboot: CPU 13 is now offline
> [ 1267.757008] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1268.582419] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1269.673649] smpboot: CPU 11 is now offline
> [ 1270.703256] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1271.750339] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1272.794298] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1273.933980] smpboot: CPU 6 is now offline
> [ 1275.173304] smpboot: CPU 14 is now offline
> [ 1276.206378] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1276.709019] rcu-torture: rtc: 0000000004a39c1f ver: 37970 tfle: 0 rta: 37971 rtaf: 0 rtf: 37960 rtmbe: 0 rtmbkf: 0/9229 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3596854 onoff: 471/471:480/480 27,1937:17,34603 66047:160068 (HZ=1000) barrier: 6646/6647:0 read-exits: 1424 nocb-toggles: 0:0
> [ 1276.756331] rcu-torture: Reader Pipe:  1555197898 153028 0 0 0 0 0 0 0 0 0
> [ 1276.770778] rcu-torture: Reader Batch:  1555025323 325603 0 0 0 0 0 0 0 0 0
> [ 1276.785384] rcu-torture: Free-Block Circulation:  37970 37969 37968 37967 37966 37965 37964 37963 37962 37960 0
> [ 1277.336665] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1278.430322] smpboot: CPU 3 is now offline
> [ 1280.490123] smpboot: CPU 9 is now offline
> [ 1281.122996] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1281.160226] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1281.551623] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1282.606703] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1283.732492] smpboot: CPU 4 is now offline
> [ 1284.771266] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1285.827243] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1286.942597] smpboot: CPU 4 is now offline
> [ 1288.003271] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1289.053160] smpboot: CPU 12 is now offline
> [ 1290.070024] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1291.107464] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1292.067023] rcu-torture: rtc: 00000000f7f6793c ver: 38561 tfle: 0 rta: 38561 rtaf: 0 rtf: 38552 rtmbe: 0 rtmbkf: 0/9289 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3638707 onoff: 479/479:485/485 27,1937:17,34603 66637:160421 (HZ=1000) barrier: 6745/6745:0 read-exits: 1440 nocb-toggles: 0:0
> [ 1292.104977] rcu-torture: Reader Pipe:  1575698677 155451 0 0 0 0 0 0 0 0 0
> [ 1292.114134] rcu-torture: Reader Batch:  1575523865 330263 0 0 0 0 0 0 0 0 0
> [ 1292.124157] rcu-torture: Free-Block Circulation:  38560 38560 38559 38558 38557 38556 38555 38554 38553 38552 0
> [ 1292.208321] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1293.287894] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1294.469098] smpboot: CPU 5 is now offline
> [ 1294.563788] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1294.577035] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1295.551584] smpboot: CPU 15 is now offline
> [ 1296.660567] smpboot: CPU 13 is now offline
> [ 1297.761371] smpboot: CPU 8 is now offline
> [ 1298.891245] smpboot: CPU 9 is now offline
> [ 1299.980656] smpboot: CPU 7 is now offline
> [ 1301.036204] smpboot: CPU 10 is now offline
> [ 1302.076589] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1303.138161] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1304.215421] smpboot: CPU 2 is now offline
> [ 1304.867937] rcu_torture_fwd_prog n_max_cbs: 42471
> [ 1304.876349] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1304.886999] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1305.191614] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1305.231334] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1305.245720] rcu_torture_fwd_prog_cr Duration 69 barrier: 54 pending 35457 n_launders: 53330 n_launders_sa: 4676 n_max_gps: 100 n_max_cbs: 36005 cver 6 gps 18
> [ 1305.272995] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 151 jiffies): 1s/10: 89335:20
> [ 1306.322249] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1306.339215] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1307.433045] rcu-torture: rtc: 0000000062f045f0 ver: 39176 tfle: 0 rta: 39177 rtaf: 0 rtf: 39164 rtmbe: 0 rtmbkf: 0/9421 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3685276 onoff: 485/486:493/493 27,1937:17,34603 67052:161149 (HZ=1000) barrier: 6834/6835:0 read-exits: 1456 nocb-toggles: 0:0
> [ 1307.470213] rcu-torture: Reader Pipe:  1594355243 157944 0 0 0 0 0 0 0 0 0
> [ 1307.479717] rcu-torture: Reader Batch:  1594177919 335268 0 0 0 0 0 0 0 0 0
> [ 1307.489804] rcu-torture: Free-Block Circulation:  39176 39172 39171 39170 39169 39168 39167 39166 39165 39164 0
> [ 1307.939047] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1307.981923] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1307.992832] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1310.365370] smpboot: CPU 14 is now offline
> [ 1312.184328] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1314.401270] smpboot: CPU 4 is now offline
> [ 1315.861426] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1317.417270] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1319.582734] smpboot: CPU 14 is now offline
> [ 1320.926887] rcu_torture_fwd_prog_nr: 0 Duration 14557 cver 48 gps 64
> [ 1320.955440] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1320.956283] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1322.088075] smpboot: CPU 15 is now offline
> [ 1322.276043] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1322.310059] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1322.787065] rcu-torture: rtc: 0000000081db4151 ver: 39266 tfle: 0 rta: 39267 rtaf: 0 rtf: 39254 rtmbe: 0 rtmbkf: 0/9471 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3723134 onoff: 490/490:497/497 27,1937:17,34603 70004:164922 (HZ=1000) barrier: 6857/6858:0 read-exits: 1488 nocb-toggles: 0:0
> [ 1322.831623] rcu-torture: Reader Pipe:  1613642437 158378 0 0 0 0 0 0 0 0 0
> [ 1322.844312] rcu-torture: Reader Batch:  1613464667 336148 0 0 0 0 0 0 0 0 0
> [ 1322.857055] rcu-torture: Free-Block Circulation:  39266 39265 39264 39262 39261 39260 39258 39257 39256 39254 0
> [ 1323.132288] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1324.225430] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1325.306342] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1326.387298] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1327.478111] smpboot: CPU 3 is now offline
> [ 1328.593953] smpboot: CPU 12 is now offline
> [ 1329.632177] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1330.789787] smpboot: CPU 15 is now offline
> [ 1331.902636] smpboot: CPU 9 is now offline
> [ 1333.173262] smpboot: CPU 7 is now offline
> [ 1334.245113] smpboot: CPU 2 is now offline
> [ 1335.321697] smpboot: CPU 3 is now offline
> [ 1336.295003] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1336.336017] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1336.494144] smpboot: CPU 1 is now offline
> [ 1337.536295] smpboot: CPU 4 is now offline
> [ 1338.146988] rcu-torture: rtc: 00000000752e1e6e ver: 39847 tfle: 0 rta: 39848 rtaf: 0 rtf: 39836 rtmbe: 0 rtmbkf: 0/9728 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3787818 onoff: 495/495:506/506 27,1937:17,34603 70379:165973 (HZ=1000) barrier: 6936/6936:0 read-exits: 1504 nocb-toggles: 0:0
> [ 1338.182493] rcu-torture: Reader Pipe:  1640277370 161155 0 0 0 0 0 0 0 0 0
> [ 1338.191714] rcu-torture: Reader Batch:  1640096173 342352 0 0 0 0 0 0 0 0 0
> [ 1338.201541] rcu-torture: Free-Block Circulation:  39848 39847 39845 39844 39843 39842 39841 39840 39838 39837 0
> [ 1338.556062] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1339.608202] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1340.728996] smpboot: CPU 11 is now offline
> [ 1341.745303] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1342.797180] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1343.871238] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1344.970059] smpboot: CPU 8 is now offline
> [ 1346.364842] smpboot: CPU 4 is now offline
> [ 1347.458367] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1348.543337] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1349.672568] smpboot: CPU 7 is now offline
> [ 1349.795019] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1349.860343] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1350.731756] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1351.794584] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1353.036949] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1353.507000] rcu-torture: rtc: 00000000ad735f96 ver: 40320 tfle: 0 rta: 40321 rtaf: 0 rtf: 40306 rtmbe: 0 rtmbkf: 0/9832 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3825250 onoff: 505/505:510/510 27,1937:17,34603 71273:166599 (HZ=1000) barrier: 7043/7043:0 read-exits: 1520 nocb-toggles: 0:0
> [ 1353.541796] rcu-torture: Reader Pipe:  1655171632 163108 0 0 0 0 0 0 0 0 0
> [ 1353.551984] rcu-torture: Reader Batch:  1654987914 346826 0 0 0 0 0 0 0 0 0
> [ 1353.562042] rcu-torture: Free-Block Circulation:  40321 40318 40316 40314 40313 40312 40311 40310 40309 40307 0
> [ 1354.413076] smpboot: CPU 8 is now offline
> [ 1355.494035] smpboot: CPU 13 is now offline
> [ 1356.717725] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1357.843085] smpboot: CPU 7 is now offline
> [ 1358.908769] smpboot: CPU 11 is now offline
> [ 1359.974558] smpboot: CPU 5 is now offline
> [ 1361.011294] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1362.080416] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1363.240988] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1363.281165] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1363.462697] smpboot: CPU 1 is now offline
> [ 1364.672136] smpboot: CPU 15 is now offline
> [ 1365.712525] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1366.769134] smpboot: CPU 11 is now offline
> [ 1367.792420] smpboot: CPU 9 is now offline
> [ 1368.845418] smpboot: CPU 12 is now offline
> [ 1368.867059] rcu-torture: rtc: 000000004f26b5c5 ver: 40957 tfle: 0 rta: 40957 rtaf: 0 rtf: 40948 rtmbe: 0 rtmbkf: 0/10017 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3873485 onoff: 509/509:520/520 27,1937:17,34603 71697:167945 (HZ=1000) barrier: 7139/7140:0 read-exits: 1536 nocb-toggles: 0:0
> [ 1368.914114] rcu-torture: Reader Pipe:  1679216886 165873 0 0 0 0 0 0 0 0 0
> [ 1368.924678] rcu-torture: Reader Batch:  1679029834 352925 0 0 0 0 0 0 0 0 0
> [ 1368.940281] rcu-torture: Free-Block Circulation:  40956 40956 40955 40954 40953 40952 40951 40950 40949 40948 0
> [ 1369.868282] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1370.918629] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1372.042946] smpboot: CPU 3 is now offline
> [ 1373.113672] smpboot: CPU 10 is now offline
> [ 1374.128204] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1375.176293] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1376.261003] smpboot: CPU 15 is now offline
> [ 1376.739963] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1376.790077] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1377.612205] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1378.801654] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1379.864692] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1380.944616] smpboot: CPU 14 is now offline
> [ 1382.294456] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1382.691152] rcu_torture_fwd_prog n_max_cbs: 36005
> [ 1382.700059] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1382.711169] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1383.059542] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1383.143674] rcu_torture_fwd_prog_cr Duration 83 barrier: 84 pending 13265 n_launders: 80648 n_launders_sa: 65628 n_max_gps: 100 n_max_cbs: 43364 cver 9 gps 22
> [ 1383.166507] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 190 jiffies): 1s/10: 113251:22 2s/10: 10761:2
> [ 1383.404300] smpboot: CPU 12 is now offline
> [ 1384.227938] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1384.227945] rcu-torture: rtc: 000000000bc00967 ver: 41603 tfle: 0 rta: 41604 rtaf: 0 rtf: 41594 rtmbe: 0 rtmbkf: 0/10084 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3912830 onoff: 517/517:525/525 27,1937:17,34603 72881:168291 (HZ=1000) barrier: 7238/7238:0 read-exits: 1552 nocb-toggles: 0:0
> [ 1384.274393] rcu-torture: Reader Pipe:  1694303114 168195 0 0 0 0 0 0 0 0 0
> [ 1384.286729] rcu-torture: Reader Batch:  1694113581 357728 0 0 0 0 0 0 0 0 0
> [ 1384.299496] rcu-torture: Free-Block Circulation:  41603 41602 41601 41600 41599 41598 41597 41596 41595 41594 0
> [ 1385.674021] smpboot: CPU 15 is now offline
> [ 1387.357123] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1389.215503] smpboot: CPU 4 is now offline
> [ 1390.114985] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1390.147201] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1390.648426] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1391.885176] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1393.037799] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1394.228048] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1396.689005] smpboot: CPU 3 is now offline
> [ 1399.278052] smpboot: CPU 14 is now offline
> [ 1399.589016] rcu-torture: rtc: 0000000099a9cf6a ver: 41648 tfle: 0 rta: 41649 rtaf: 0 rtf: 41639 rtmbe: 0 rtmbkf: 0/10094 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3947409 onoff: 522/522:529/529 27,1937:17,34603 74653:173374 (HZ=1000) barrier: 7259/7260:0 read-exits: 1568 nocb-toggles: 0:0
> [ 1399.625664] rcu-torture: Reader Pipe:  1712183162 168346 0 0 0 0 0 0 0 0 0
> [ 1399.636084] rcu-torture: Reader Batch:  1711993459 358049 0 0 0 0 0 0 0 0 0
> [ 1399.645943] rcu-torture: Free-Block Circulation:  41648 41647 41646 41645 41644 41643 41642 41641 41640 41639 0
> [ 1400.912236] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1403.277726] smpboot: CPU 6 is now offline
> [ 1404.081884] rcu_torture_fwd_prog_nr: 0 Duration 19755 cver 63 gps 87
> [ 1404.123964] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1404.195011] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1404.243086] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1404.368931] smpboot: CPU 1 is now offline
> [ 1405.472312] smpboot: CPU 2 is now offline
> [ 1406.549840] smpboot: CPU 15 is now offline
> [ 1407.767096] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1408.884195] smpboot: CPU 2 is now offline
> [ 1409.940607] smpboot: CPU 7 is now offline
> [ 1410.998608] smpboot: CPU 9 is now offline
> [ 1413.417114] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1414.477093] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1414.947068] rcu-torture: rtc: 00000000b1785d83 ver: 42315 tfle: 0 rta: 42316 rtaf: 0 rtf: 42304 rtmbe: 0 rtmbkf: 0/10116 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 3993682 onoff: 526/526:536/536 27,1937:17,34603 76033:175192 (HZ=1000) barrier: 7336/7337:0 read-exits: 1584 nocb-toggles: 0:0
> [ 1414.991945] rcu-torture: Reader Pipe:  1732367565 170202 0 0 0 0 0 0 0 0 0
> [ 1415.001482] rcu-torture: Reader Batch:  1732175473 362294 0 0 0 0 0 0 0 0 0
> [ 1415.011673] rcu-torture: Free-Block Circulation:  42315 42314 42313 42311 42309 42308 42307 42306 42305 42304 0
> [ 1415.579384] smpboot: CPU 5 is now offline
> [ 1416.607235] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1417.664957] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1417.718421] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1417.803352] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1418.849465] smpboot: CPU 8 is now offline
> [ 1419.867948] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1420.924835] smpboot: CPU 4 is now offline
> [ 1421.942224] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1423.021317] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1424.137064] smpboot: CPU 4 is now offline
> [ 1425.186166] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1426.712581] smpboot: CPU 11 is now offline
> [ 1427.774314] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1428.842653] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1429.958300] smpboot: CPU 1 is now offline
> [ 1430.307044] rcu-torture: rtc: 000000003ce8dd47 ver: 42877 tfle: 0 rta: 42878 rtaf: 0 rtf: 42866 rtmbe: 0 rtmbkf: 0/10160 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4027571 onoff: 534/534:542/542 27,1937:17,34603 76671:176010 (HZ=1000) barrier: 7446/7446:0 read-exits: 1600 nocb-toggles: 0:0
> [ 1430.363507] rcu-torture: Reader Pipe:  1747888444 172347 0 0 0 0 0 0 0 0 0
> [ 1430.379349] rcu-torture: Reader Batch:  1747693885 366906 0 0 0 0 0 0 0 0 0
> [ 1430.395460] rcu-torture: Free-Block Circulation:  42878 42877 42876 42875 42874 42873 42872 42871 42869 42867 0
> [ 1431.138988] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1431.193167] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1431.367031] smpboot: CPU 7 is now offline
> [ 1432.462761] smpboot: CPU 3 is now offline
> [ 1433.503817] smpboot: CPU 12 is now offline
> [ 1434.536292] smpboot: CPU 10 is now offline
> [ 1435.566256] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1436.653985] smpboot: CPU 6 is now offline
> [ 1437.683124] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1438.732109] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1439.842278] smpboot: CPU 6 is now offline
> [ 1441.125449] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1442.186131] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1443.464334] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1444.667785] smpboot: CPU 9 is now offline
> [ 1444.707035] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1445.666993] rcu-torture: rtc: 00000000ad735f96 ver: 43710 tfle: 0 rta: 43710 rtaf: 0 rtf: 43701 rtmbe: 0 rtmbkf: 0/10160 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4066550 onoff: 540/540:549/549 27,1937:17,34603 77467:176904 (HZ=1000) barrier: 7546/7546:0 read-exits: 1624 nocb-toggles: 0:0
> [ 1445.715646] rcu-torture: Reader Pipe:  1765136230 174612 0 0 0 0 0 0 0 0 0
> [ 1445.728178] rcu-torture: Reader Batch:  1764939015 371827 0 0 0 0 0 0 0 0 0
> [ 1445.740108] rcu-torture: Free-Block Circulation:  43709 43709 43708 43707 43706 43705 43704 43703 43702 43701 0
> [ 1445.759340] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1446.811649] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1447.914046] smpboot: CPU 5 is now offline
> [ 1448.959468] smpboot: CPU 14 is now offline
> [ 1449.785855] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1449.990164] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1451.067376] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1452.130567] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1453.235445] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1454.355107] smpboot: CPU 8 is now offline
> [ 1455.400195] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1456.682996] smpboot: CPU 13 is now offline
> [ 1457.731586] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1458.778477] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1459.865824] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1460.990513] smpboot: CPU 4 is now offline
> [ 1461.027040] rcu-torture: rtc: 0000000016e1749d ver: 44025 tfle: 0 rta: 44026 rtaf: 0 rtf: 44013 rtmbe: 0 rtmbkf: 0/10363 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4117536 onoff: 550/550:554/554 27,1937:17,34603 78185:177450 (HZ=1000) barrier: 7632/7633:0 read-exits: 1632 nocb-toggles: 0:0
> [ 1461.078930] rcu-torture: Reader Pipe:  1786231333 176333 0 0 0 0 0 0 0 0 0
> [ 1461.092420] rcu-torture: Reader Batch:  1786032070 375596 0 0 0 0 0 0 0 0 0
> [ 1461.105797] rcu-torture: Free-Block Circulation:  44025 44024 44021 44020 44019 44018 44017 44016 44015 44013 0
> [ 1462.090022] smpboot: CPU 11 is now offline
> [ 1463.122011] smpboot: CPU 6 is now offline
> [ 1463.138992] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1463.157651] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1464.222261] smpboot: CPU 15 is now offline
> [ 1464.611164] rcu_torture_fwd_prog n_max_cbs: 43364
> [ 1464.618636] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1464.627290] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1464.731192] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1464.829770] rcu_torture_fwd_prog_cr Duration 76 barrier: 98 pending 33435 n_launders: 71403 n_launders_sa: 71403 n_max_gps: 100 n_max_cbs: 35652 cver 8 gps 14
> [ 1464.855633] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 200 jiffies): 1s/10: 107055:17
> [ 1465.268226] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1465.891215] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1467.387671] smpboot: CPU 9 is now offline
> [ 1469.218163] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1471.293779] smpboot: CPU 7 is now offline
> [ 1473.151005] smpboot: CPU 9 is now offline
> [ 1474.864434] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1476.329525] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1476.389101] rcu-torture: rtc: 00000000427992e1 ver: 44271 tfle: 0 rta: 44272 rtaf: 0 rtf: 44261 rtmbe: 0 rtmbkf: 0/10510 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4162726 onoff: 554/554:560/560 27,1937:17,34603 80301:180696 (HZ=1000) barrier: 7675/7675:0 read-exits: 1648 nocb-toggles: 0:0
> [ 1476.442144] rcu-torture: Reader Pipe:  1809073665 177612 0 0 0 0 0 0 0 0 0
> [ 1476.453677] rcu-torture: Reader Batch:  1808873204 378073 0 0 0 0 0 0 0 0 0
> [ 1476.465596] rcu-torture: Free-Block Circulation:  44271 44269 44268 44267 44266 44265 44264 44263 44262 44261 0
> [ 1476.580964] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1476.617512] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1476.674887] rcu_torture_fwd_prog_nr: 0 Duration 10732 cver 35 gps 49
> [ 1476.706199] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1478.418773] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1479.492223] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1480.664569] smpboot: CPU 5 is now offline
> [ 1482.091600] smpboot: CPU 12 is now offline
> [ 1483.175380] smpboot: CPU 7 is now offline
> [ 1485.348311] smpboot: CPU 14 is now offline
> [ 1486.646483] smpboot: CPU 10 is now offline
> [ 1487.697220] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1488.756471] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1489.870552] smpboot: CPU 10 is now offline
> [ 1490.082997] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1490.100741] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1490.911332] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1491.747958] rcu-torture: rtc: 00000000928d6222 ver: 44921 tfle: 0 rta: 44922 rtaf: 0 rtf: 44911 rtmbe: 0 rtmbkf: 0/10771 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4224699 onoff: 559/559:566/566 27,1937:17,34603 80639:181912 (HZ=1000) barrier: 7757/7757:0 read-exits: 1680 nocb-toggles: 0:0
> [ 1491.786802] rcu-torture: Reader Pipe:  1833509292 180633 0 0 0 0 0 0 0 0 0
> [ 1491.797285] rcu-torture: Reader Batch:  1833306024 383901 0 0 0 0 0 0 0 0 0
> [ 1491.807582] rcu-torture: Free-Block Circulation:  44921 44920 44919 44918 44917 44916 44915 44914 44913 44911 0
> [ 1492.075750] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1493.173407] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1494.322748] smpboot: CPU 8 is now offline
> [ 1495.418083] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1496.489285] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1497.570066] smpboot: CPU 12 is now offline
> [ 1498.590235] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1499.662827] smpboot: CPU 1 is now offline
> [ 1500.748509] smpboot: CPU 15 is now offline
> [ 1501.932121] smpboot: CPU 10 is now offline
> [ 1502.993247] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1503.460317] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1503.493978] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1504.153529] smpboot: CPU 8 is now offline
> [ 1505.282795] smpboot: CPU 10 is now offline
> [ 1506.575311] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1507.108218] rcu-torture: rtc: 00000000dd107bc8 ver: 45306 tfle: 0 rta: 45306 rtaf: 0 rtf: 45295 rtmbe: 0 rtmbkf: 0/10926 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4270387 onoff: 566/566:573/573 27,1937:17,34603 81514:182639 (HZ=1000) barrier: 7852/7853:0 read-exits: 1696 nocb-toggles: 0:0
> [ 1507.147744] rcu-torture: Reader Pipe:  1855619509 182691 0 0 0 0 0 0 0 0 0
> [ 1507.159183] rcu-torture: Reader Batch:  1855414091 388108 0 0 0 0 0 0 0 0 0
> [ 1507.171537] rcu-torture: Free-Block Circulation:  45306 45305 45304 45303 45301 45300 45298 45297 45296 45295 0
> [ 1507.669286] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1508.751215] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1509.814306] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1510.948480] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1512.205966] smpboot: CPU 6 is now offline
> [ 1513.747610] smpboot: CPU 12 is now offline
> [ 1514.990544] smpboot: CPU 8 is now offline
> [ 1516.095520] smpboot: CPU 1 is now offline
> [ 1516.899940] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1516.929250] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1517.204733] smpboot: CPU 15 is now offline
> [ 1518.302441] smpboot: CPU 10 is now offline
> [ 1519.476083] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1520.594755] smpboot: CPU 7 is now offline
> [ 1521.788641] smpboot: CPU 10 is now offline
> [ 1522.472209] rcu-torture: rtc: 0000000035cc6ffe ver: 45909 tfle: 0 rta: 45910 rtaf: 0 rtf: 45898 rtmbe: 0 rtmbkf: 0/11221 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4331891 onoff: 571/571:581/581 27,1937:17,34603 81945:184236 (HZ=1000) barrier: 7933/7933:0 read-exits: 1712 nocb-toggles: 0:0
> [ 1522.517571] rcu-torture: Reader Pipe:  1883637010 185653 0 0 0 0 0 0 0 0 0
> [ 1522.527305] rcu-torture: Reader Batch:  1883428561 394102 0 0 0 0 0 0 0 0 0
> [ 1522.543705] rcu-torture: Free-Block Circulation:  45909 45908 45907 45906 45905 45903 45902 45901 45900 45898 0
> [ 1522.802244] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1523.846188] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1524.886221] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1525.933347] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1526.983329] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1528.283417] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1529.515967] smpboot: CPU 12 is now offline
> [ 1530.662261] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1530.723121] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1530.766125] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1533.047225] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1534.433444] smpboot: CPU 9 is now offline
> [ 1535.542358] smpboot: CPU 10 is now offline
> [ 1537.141534] smpboot: CPU 7 is now offline
> [ 1537.826978] rcu-torture: rtc: 00000000b1785d83 ver: 46233 tfle: 0 rta: 46234 rtaf: 0 rtf: 46222 rtmbe: 0 rtmbkf: 0/11446 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4384818 onoff: 579/579:585/585 27,1937:17,34603 83074:185445 (HZ=1000) barrier: 8023/8023:0 read-exits: 1728 nocb-toggles: 0:0
> [ 1537.869169] rcu-torture: Reader Pipe:  1904549350 187681 0 0 0 0 0 0 0 0 0
> [ 1537.880860] rcu-torture: Reader Batch:  1904338924 398107 0 0 0 0 0 0 0 0 0
> [ 1537.894073] rcu-torture: Free-Block Circulation:  46233 46231 46230 46229 46228 46226 46225 46224 46223 46222 0
> [ 1538.232749] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1538.340991] rcu_torture_fwd_prog n_max_cbs: 35652
> [ 1538.350682] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1538.361461] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1538.474589] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1538.552646] rcu_torture_fwd_prog_cr Duration 81 barrier: 78 pending 14003 n_launders: 72877 n_launders_sa: 72877 n_max_gps: 100 n_max_cbs: 36389 cver 6 gps 12
> [ 1538.577286] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 184 jiffies): 1s/10: 103820:13 2s/10: 5446:1
> [ 1539.315010] smpboot: CPU 9 is now offline
> [ 1539.619549] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1542.078973] smpboot: CPU 14 is now offline
> [ 1544.162954] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1544.201241] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1544.862184] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1547.308646] smpboot: CPU 11 is now offline
> [ 1549.131642] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1551.012399] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1551.840932] rcu_torture_fwd_prog_nr: 0 Duration 12183 cver 24 gps 46
> [ 1551.857237] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1552.095829] smpboot: CPU 7 is now offline
> [ 1553.145484] smpboot: CPU 15 is now offline
> [ 1553.187499] rcu-torture: rtc: 00000000cad2a34a ver: 46344 tfle: 0 rta: 46344 rtaf: 0 rtf: 46335 rtmbe: 0 rtmbkf: 0/11495 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4429946 onoff: 583/583:590/590 27,1937:17,34603 85718:188799 (HZ=1000) barrier: 8058/8058:0 read-exits: 1744 nocb-toggles: 0:0
> [ 1553.243309] rcu-torture: Reader Pipe:  1929118472 188241 0 0 0 0 0 0 0 0 0
> [ 1553.256708] rcu-torture: Reader Batch:  1928907283 399430 0 0 0 0 0 0 0 0 0
> [ 1553.272265] rcu-torture: Free-Block Circulation:  46343 46343 46342 46341 46340 46339 46338 46337 46336 46335 0
> [ 1554.486765] smpboot: CPU 13 is now offline
> [ 1555.700097] smpboot: CPU 8 is now offline
> [ 1556.754192] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1557.809109] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1558.499054] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1558.517009] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1558.866376] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1560.081002] smpboot: CPU 8 is now offline
> [ 1561.137324] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1562.218672] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1563.363476] smpboot: CPU 6 is now offline
> [ 1564.416080] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1565.619571] smpboot: CPU 3 is now offline
> [ 1566.723233] smpboot: CPU 10 is now offline
> [ 1567.878997] smpboot: CPU 5 is now offline
> [ 1568.547071] rcu-torture: rtc: 00000000941919cf ver: 47008 tfle: 0 rta: 47009 rtaf: 0 rtf: 46999 rtmbe: 0 rtmbkf: 0/11741 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4489940 onoff: 589/589:597/597 27,1937:17,34603 86158:190087 (HZ=1000) barrier: 8141/8141:0 read-exits: 1760 nocb-toggles: 0:0
> [ 1568.577810] rcu-torture: Reader Pipe:  1952997667 191434 0 0 0 0 0 0 0 0 0
> [ 1568.585571] rcu-torture: Reader Batch:  1952783648 405453 0 0 0 0 0 0 0 0 0
> [ 1568.592970] rcu-torture: Free-Block Circulation:  47009 47008 47007 47006 47005 47004 47003 47002 47001 47000 0
> [ 1569.017231] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1570.140293] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1571.236390] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1571.938950] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1571.980494] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1572.648484] smpboot: CPU 7 is now offline
> [ 1573.707223] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1574.749799] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1575.817291] smpboot: CPU 7 is now offline
> [ 1576.906696] smpboot: CPU 11 is now offline
> [ 1577.977516] smpboot: CPU 13 is now offline
> [ 1579.044464] smpboot: CPU 4 is now offline
> [ 1580.353422] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1581.461815] smpboot: CPU 2 is now offline
> [ 1582.627284] smpboot: CPU 8 is now offline
> [ 1583.661193] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1583.906985] rcu-torture: rtc: 00000000c6cda55c ver: 47439 tfle: 0 rta: 47440 rtaf: 0 rtf: 47429 rtmbe: 0 rtmbkf: 0/11940 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4532777 onoff: 596/596:604/604 27,1937:17,34603 87044:190991 (HZ=1000) barrier: 8242/8242:0 read-exits: 1776 nocb-toggles: 0:0
> [ 1583.954013] rcu-torture: Reader Pipe:  1974724999 193624 0 0 0 0 0 0 0 0 0
> [ 1583.965385] rcu-torture: Reader Batch:  1974508548 410075 0 0 0 0 0 0 0 0 0
> [ 1583.977617] rcu-torture: Free-Block Circulation:  47440 47439 47438 47437 47435 47434 47433 47432 47431 47430 0
> [ 1584.803628] smpboot: CPU 12 is now offline
> [ 1585.314945] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1585.354081] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1585.854352] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1586.998101] smpboot: CPU 5 is now offline
> [ 1588.046234] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1589.102183] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1590.467909] smpboot: CPU 5 is now offline
> [ 1591.525165] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1592.624947] smpboot: CPU 9 is now offline
> [ 1593.670194] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1594.760743] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1595.819359] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1598.145466] smpboot: CPU 6 is now offline
> [ 1599.202959] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1599.241481] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1599.277919] rcu-torture: rtc: 00000000238e9780 ver: 48088 tfle: 0 rta: 48089 rtaf: 0 rtf: 48075 rtmbe: 0 rtmbkf: 0/12113 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4592076 onoff: 603/603:609/610 27,1937:17,34603 87797:191683 (HZ=1000) barrier: 8326/8327:0 read-exits: 1808 nocb-toggles: 0:0
> [ 1599.303733] rcu-torture: Reader Pipe:  2003018568 196538 0 0 0 0 0 0 0 0 0
> [ 1599.311605] rcu-torture: Reader Batch:  2002798455 416651 0 0 0 0 0 0 0 0 0
> [ 1599.319710] rcu-torture: Free-Block Circulation:  48088 48087 48085 48083 48082 48081 48079 48077 48076 48075 0
> [ 1599.527575] smpboot: CPU 1 is now offline
> [ 1600.684456] smpboot: CPU 10 is now offline
> [ 1601.698304] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1602.897019] smpboot: CPU 3 is now offline
> [ 1603.910142] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1606.059834] smpboot: CPU 3 is now offline
> [ 1607.150965] smpboot: CPU 2 is now offline
> [ 1608.200132] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1609.709607] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1611.855697] smpboot: CPU 4 is now offline
> [ 1612.770991] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1612.828063] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1612.897538] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1614.265246] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1614.626991] rcu-torture: rtc: 0000000035cc6ffe ver: 48517 tfle: 0 rta: 48518 rtaf: 0 rtf: 48508 rtmbe: 0 rtmbkf: 0/12258 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4628712 onoff: 609/609:615/615 27,1937:17,34603 88938:192676 (HZ=1000) barrier: 8426/8426:0 read-exits: 1824 nocb-toggles: 0:0
> [ 1614.678344] rcu-torture: Reader Pipe:  2018452687 198347 0 0 0 0 0 0 0 0 0
> [ 1614.694139] rcu-torture: Reader Batch:  2018230323 420711 0 0 0 0 0 0 0 0 0
> [ 1614.709162] rcu-torture: Free-Block Circulation:  48518 48517 48516 48515 48514 48513 48512 48511 48510 48509 0
> [ 1615.386646] smpboot: CPU 15 is now offline
> [ 1616.163937] rcu_torture_fwd_prog n_max_cbs: 36389
> [ 1616.173397] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1616.184317] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1616.493181] smpboot: CPU 8 is now offline
> [ 1616.517982] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1616.587951] rcu_torture_fwd_prog_cr Duration 95 barrier: 70 pending 50170 n_launders: 74001 n_launders_sa: 18907 n_max_gps: 100 n_max_cbs: 66098 cver 6 gps 21
> [ 1616.606929] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 184 jiffies): 1s/10: 111599:22 2s/10: 28500:2
> [ 1617.591517] smpboot: CPU 5 is now offline
> [ 1617.635201] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1621.888296] smpboot: CPU 14 is now offline
> [ 1624.770365] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1626.274981] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1626.320350] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1626.612752] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1628.167717] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1629.987021] rcu-torture: rtc: 000000006a0cb339 ver: 48704 tfle: 0 rta: 48704 rtaf: 0 rtf: 48693 rtmbe: 0 rtmbkf: 0/12300 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4666659 onoff: 612/612:619/620 27,1937:17,34603 91240:194267 (HZ=1000) barrier: 8454/8455:0 read-exits: 1840 nocb-toggles: 0:0
> [ 1630.030040] rcu-torture: Reader Pipe:  2037169507 199122 0 0 0 0 0 0 0 0 0
> [ 1630.042723] rcu-torture: Reader Batch:  2036946605 422024 0 0 0 0 0 0 0 0 0
> [ 1630.055375] rcu-torture: Free-Block Circulation:  48703 48703 48702 48701 48700 48699 48697 48696 48695 48693 0
> [ 1630.488719] smpboot: CPU 13 is now offline
> [ 1632.610363] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1634.382480] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1634.602876] rcu_torture_fwd_prog_nr: 0 Duration 16925 cver 84 gps 69
> [ 1634.665936] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1636.465278] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1637.576613] smpboot: CPU 4 is now offline
> [ 1638.699206] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1639.763139] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1640.611950] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1640.627054] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1640.841522] smpboot: CPU 13 is now offline
> [ 1641.974677] smpboot: CPU 10 is now offline
> [ 1643.127251] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1644.266021] smpboot: CPU 12 is now offline
> [ 1645.346984] rcu-torture: rtc: 0000000062f045f0 ver: 49158 tfle: 0 rta: 49159 rtaf: 0 rtf: 49144 rtmbe: 0 rtmbkf: 0/12594 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4728717 onoff: 618/618:624/625 27,1937:17,34603 93618:195955 (HZ=1000) barrier: 8518/8518:0 read-exits: 1856 nocb-toggles: 0:0
> [ 1645.381773] rcu-torture: Reader Pipe:  2063038594 201680 0 0 0 0 0 0 0 0 0
> [ 1645.395491] rcu-torture: Reader Batch:  2062813349 426925 0 0 0 0 0 0 0 0 0
> [ 1645.408697] rcu-torture: Free-Block Circulation:  49158 49157 49155 49153 49152 49151 49150 49149 49148 49147 0
> [ 1645.436665] smpboot: CPU 1 is now offline
> [ 1646.572079] smpboot: CPU 3 is now offline
> [ 1647.642991] smpboot: CPU 9 is now offline
> [ 1648.707333] smpboot: CPU 13 is now offline
> [ 1649.834707] smpboot: CPU 7 is now offline
> [ 1651.058213] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1652.118118] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1653.158011] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1653.987087] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1654.207141] smpboot: CPU 15 is now offline
> [ 1655.224072] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1656.344981] smpboot: CPU 10 is now offline
> [ 1657.362104] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1657.810125] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1658.446358] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1659.557362] smpboot: CPU 9 is now offline
> [ 1660.637068] smpboot: CPU 13 is now offline
> [ 1660.707289] rcu-torture: rtc: 00000000abe7a7e8 ver: 49633 tfle: 0 rta: 49634 rtaf: 0 rtf: 49623 rtmbe: 0 rtmbkf: 0/12652 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4762450 onoff: 624/624:633/633 27,1937:17,34603 94183:196750 (HZ=1000) barrier: 8618/8619:0 read-exits: 1872 nocb-toggles: 0:0
> [ 1660.761699] rcu-torture: Reader Pipe:  2079323775 203468 0 0 0 0 0 0 0 0 0
> [ 1660.774292] rcu-torture: Reader Batch:  2079096823 430420 0 0 0 0 0 0 0 0 0
> [ 1660.787310] rcu-torture: Free-Block Circulation:  49634 49633 49632 49631 49630 49629 49628 49627 49626 49625 0
> [ 1661.740449] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1662.831354] smpboot: CPU 6 is now offline
> [ 1663.857712] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1664.916667] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1665.965923] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1667.021710] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1668.081788] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1669.198482] smpboot: CPU 11 is now offline
> [ 1670.253419] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1671.202971] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1671.218456] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1671.596535] smpboot: CPU 6 is now offline
> [ 1672.672365] smpboot: CPU 3 is now offline
> [ 1673.793776] smpboot: CPU 5 is now offline
> [ 1674.836084] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1676.067915] rcu-torture: rtc: 00000000a251f460 ver: 50192 tfle: 0 rta: 50193 rtaf: 0 rtf: 50179 rtmbe: 0 rtmbkf: 0/12922 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4825529 onoff: 632/632:638/639 27,1937:17,34603 94720:197193 (HZ=1000) barrier: 8697/8698:0 read-exits: 1888 nocb-toggles: 0:0
> [ 1676.093787] rcu-torture: Reader Pipe:  2108735613 206281 0 0 0 0 0 0 0 0 0
> [ 1676.101074] rcu-torture: Reader Batch:  2108505360 436534 0 0 0 0 0 0 0 0 0
> [ 1676.108260] rcu-torture: Free-Block Circulation:  50193 50192 50191 50190 50189 50188 50185 50184 50182 50181 0
> [ 1676.553972] smpboot: CPU 9 is now offline
> [ 1677.599077] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1678.725187] smpboot: CPU 1 is now offline
> [ 1679.742185] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1680.873722] smpboot: CPU 15 is now offline
> [ 1681.993163] smpboot: CPU 5 is now offline
> [ 1684.034116] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1684.962945] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1685.017328] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1685.091151] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1686.213622] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1687.557201] smpboot: CPU 1 is now offline
> [ 1688.612565] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1691.428031] rcu-torture: rtc: 00000000941919cf ver: 50611 tfle: 0 rta: 50612 rtaf: 0 rtf: 50600 rtmbe: 0 rtmbkf: 0/13174 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4872074 onoff: 638/638:643/643 27,1937:17,34603 95183:198499 (HZ=1000) barrier: 8791/8792:0 read-exits: 1904 nocb-toggles: 0:0
> [ 1691.494595] rcu-torture: Reader Pipe:  2128798635 208485 0 0 0 0 0 0 0 0 0
> [ 1691.513263] rcu-torture: Reader Batch:  2128566541 440579 0 0 0 0 0 0 0 0 0
> [ 1691.528639] rcu-torture: Free-Block Circulation:  50613 50611 50610 50609 50607 50606 50604 50603 50602 50601 0
> [ 1691.974072] smpboot: CPU 4 is now offline
> [ 1693.383755] smpboot: CPU 6 is now offline
> [ 1694.494192] smpboot: CPU 13 is now offline
> [ 1695.519291] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1696.652421] smpboot: CPU 10 is now offline
> [ 1698.085948] rcu_torture_fwd_prog n_max_cbs: 66098
> [ 1698.092674] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1698.103034] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1698.262812] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1698.335462] rcu_torture_fwd_prog_cr Duration 114 barrier: 73 pending 34419 n_launders: 107526 n_launders_sa: 70182 n_max_gps: 100 n_max_cbs: 62924 cver 12 gps 27
> [ 1698.354243] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 206 jiffies): 1s/10: 128974:26 2s/10: 41476:3
> [ 1698.404927] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1698.447423] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1699.055526] smpboot: CPU 11 is now offline
> [ 1699.427378] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1700.383282] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1702.089845] smpboot: CPU 2 is now offline
> [ 1703.610473] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1705.970212] smpboot: CPU 12 is now offline
> [ 1706.787225] rcu-torture: rtc: 00000000a7e2a9fb ver: 50970 tfle: 0 rta: 50970 rtaf: 0 rtf: 50961 rtmbe: 0 rtmbkf: 0/13283 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4920457 onoff: 641/641:650/650 27,1937:17,34603 96120:201885 (HZ=1000) barrier: 8840/8841:0 read-exits: 1920 nocb-toggles: 0:0
> [ 1706.839705] rcu-torture: Reader Pipe:  2152075589 209975 0 0 0 0 0 0 0 0 0
> [ 1706.850765] rcu-torture: Reader Batch:  2151841519 444045 0 0 0 0 0 0 0 0 0
> [ 1706.861880] rcu-torture: Free-Block Circulation:  50969 50969 50968 50967 50966 50965 50964 50963 50962 50961 0
> [ 1708.183453] smpboot: CPU 9 is now offline
> [ 1709.035964] rcu_torture_fwd_prog_nr: 0 Duration 9566 cver 30 gps 40
> [ 1709.053568] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1709.196096] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1710.425619] smpboot: CPU 11 is now offline
> [ 1711.467400] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1711.781021] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1711.855138] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1712.574027] smpboot: CPU 1 is now offline
> [ 1713.661023] smpboot: CPU 8 is now offline
> [ 1714.694461] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1715.773785] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1716.831529] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1717.902188] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1718.985711] smpboot: CPU 15 is now offline
> [ 1720.081941] smpboot: CPU 12 is now offline
> [ 1721.213468] smpboot: CPU 7 is now offline
> [ 1722.147062] rcu-torture: rtc: 00000000c13cefc2 ver: 51640 tfle: 0 rta: 51641 rtaf: 0 rtf: 51628 rtmbe: 0 rtmbkf: 0/13315 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4959379 onoff: 647/647:657/657 27,1937:17,34603 96472:203761 (HZ=1000) barrier: 8931/8932:0 read-exits: 1936 nocb-toggles: 0:0
> [ 1722.195350] rcu-torture: Reader Pipe:  2167515733 212272 0 0 0 0 0 0 0 0 0
> [ 1722.207609] rcu-torture: Reader Batch:  2167279162 448843 0 0 0 0 0 0 0 0 0
> [ 1722.220361] rcu-torture: Free-Block Circulation:  51640 51639 51637 51635 51634 51633 51632 51631 51630 51628 0
> [ 1722.265300] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1723.385967] smpboot: CPU 4 is now offline
> [ 1724.428306] smpboot: CPU 6 is now offline
> [ 1725.219462] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1725.255378] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1725.490040] smpboot: CPU 5 is now offline
> [ 1726.519036] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1727.598973] smpboot: CPU 11 is now offline
> [ 1728.637254] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1729.710135] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1730.749288] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1731.786274] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1732.830410] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1733.912388] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1734.971288] smpboot: CPU 7 is now offline
> [ 1736.057301] smpboot: CPU 1 is now offline
> [ 1737.088318] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1737.507007] rcu-torture: rtc: 0000000035cc6ffe ver: 52205 tfle: 0 rta: 52206 rtaf: 0 rtf: 52194 rtmbe: 0 rtmbkf: 0/13334 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4987438 onoff: 656/656:663/663 27,1937:17,34603 96964:204136 (HZ=1000) barrier: 9042/9042:0 read-exits: 1952 nocb-toggles: 0:0
> [ 1737.553079] rcu-torture: Reader Pipe:  2180426074 213956 0 0 0 0 0 0 0 0 0
> [ 1737.564751] rcu-torture: Reader Batch:  2180187824 452206 0 0 0 0 0 0 0 0 0
> [ 1737.576835] rcu-torture: Free-Block Circulation:  52205 52204 52203 52202 52201 52200 52198 52197 52196 52195 0
> [ 1738.217122] smpboot: CPU 14 is now offline
> [ 1738.661239] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1738.717173] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1741.536371] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1742.947241] smpboot: CPU 6 is now offline
> [ 1743.985597] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1746.093143] smpboot: CPU 9 is now offline
> [ 1747.410182] smpboot: CPU 15 is now offline
> [ 1748.587476] smpboot: CPU 10 is now offline
> [ 1749.634207] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1751.703590] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1752.099226] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1752.128442] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1752.803078] smpboot: CPU 11 is now offline
> [ 1752.870139] rcu-torture: rtc: 00000000f66ac18e ver: 52901 tfle: 0 rta: 52902 rtaf: 0 rtf: 52892 rtmbe: 0 rtmbkf: 0/13468 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5042094 onoff: 660/660:669/669 27,1937:17,34603 97488:205280 (HZ=1000) barrier: 9130/9130:0 read-exits: 1984 nocb-toggles: 0:0
> [ 1752.899783] rcu-torture: Reader Pipe:  2203390500 216718 0 0 0 0 0 0 0 0 0
> [ 1752.908442] rcu-torture: Reader Batch:  2203148777 458441 0 0 0 0 0 0 0 0 0
> [ 1752.916153] rcu-torture: Free-Block Circulation:  52901 52900 52899 52898 52897 52896 52895 52894 52893 52892 0
> [ 1753.839162] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1754.891239] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1755.980560] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1757.025599] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1758.074290] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1759.181674] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1760.304072] smpboot: CPU 10 is now offline
> [ 1761.437462] smpboot: CPU 3 is now offline
> [ 1762.537799] smpboot: CPU 9 is now offline
> [ 1763.647117] smpboot: CPU 4 is now offline
> [ 1764.784987] smpboot: CPU 12 is now offline
> [ 1765.731970] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1765.784201] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1765.991496] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1767.061435] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1768.158389] smpboot: CPU 4 is now offline
> [ 1768.228767] rcu-torture: rtc: 00000000eb495658 ver: 53342 tfle: 0 rta: 53343 rtaf: 0 rtf: 53333 rtmbe: 0 rtmbkf: 0/13597 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5082326 onoff: 668/668:675/675 27,1937:17,34603 98249:205857 (HZ=1000) barrier: 9228/9228:0 read-exits: 2000 nocb-toggles: 0:0
> [ 1768.273323] rcu-torture: Reader Pipe:  2221714127 218878 0 0 0 0 0 0 0 0 0
> [ 1768.285524] rcu-torture: Reader Batch:  2221470359 462646 0 0 0 0 0 0 0 0 0
> [ 1768.297647] rcu-torture: Free-Block Circulation:  53343 53342 53341 53340 53339 53338 53337 53336 53335 53334 0
> [ 1769.286158] smpboot: CPU 1 is now offline
> [ 1770.319198] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1771.597820] smpboot: CPU 2 is now offline
> [ 1771.811240] rcu_torture_fwd_prog n_max_cbs: 62924
> [ 1771.820396] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1771.830563] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1771.957211] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1772.026787] rcu_torture_fwd_prog_cr Duration 81 barrier: 69 pending 35367 n_launders: 63729 n_launders_sa: 8383 n_max_gps: 100 n_max_cbs: 39662 cver 6 gps 15
> [ 1772.052612] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 176 jiffies): 1s/10: 100344:17 2s/10: 3047:1
> [ 1772.632345] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 1773.091341] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1775.272968] smpboot: CPU 8 is now offline
> [ 1777.867466] smpboot: CPU 15 is now offline
> [ 1778.564534] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1778.973819] smpboot: CPU 3 is now offline
> [ 1779.363018] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1779.393067] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1779.992391] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1781.053152] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1782.184560] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1783.248222] smpboot: CPU 5 is now offline
> [ 1783.587142] rcu-torture: rtc: 0000000099a9cf6a ver: 53824 tfle: 0 rta: 53824 rtaf: 0 rtf: 53815 rtmbe: 0 rtmbkf: 0/13682 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5133452 onoff: 673/673:681/681 27,1937:17,34603 98605:209583 (HZ=1000) barrier: 9297/9297:0 read-exits: 2016 nocb-toggles: 0:0
> [ 1783.631563] rcu-torture: Reader Pipe:  2245849200 220730 0 0 0 0 0 0 0 0 0
> [ 1783.643027] rcu-torture: Reader Batch:  2245603534 466396 0 0 0 0 0 0 0 0 0
> [ 1783.654620] rcu-torture: Free-Block Circulation:  53823 53823 53822 53821 53820 53819 53818 53817 53816 53815 0
> [ 1784.261074] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 1785.358043] smpboot: CPU 13 is now offline
> [ 1786.377090] smpboot: Booting Node 0 Processor 13 APIC 0xd
> [ 1787.473736] smpboot: CPU 10 is now offline
> [ 1788.494376] smpboot: CPU 12 is now offline
> [ 1789.552219] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1791.624405] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 1792.688283] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1792.738948] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1792.763684] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1793.969531] smpboot: CPU 11 is now offline
> [ 1795.473563] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1796.543310] smpboot: Booting Node 0 Processor 10 APIC 0xa
> [ 1797.833128] smpboot: CPU 6 is now offline
> [ 1798.947066] rcu-torture: rtc: 000000006f9d68d3 ver: 54192 tfle: 0 rta: 54193 rtaf: 0 rtf: 54180 rtmbe: 0 rtmbkf: 0/13845 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5179637 onoff: 680/680:686/687 27,1937:17,34603 99548:210205 (HZ=1000) barrier: 9383/9384:0 read-exits: 2032 nocb-toggles: 0:0
> [ 1798.984456] rcu-torture: Reader Pipe:  2264870240 222555 0 0 0 0 0 0 0 0 0
> [ 1798.993773] rcu-torture: Reader Batch:  2264622944 469851 0 0 0 0 0 0 0 0 0
> [ 1799.004534] rcu-torture: Free-Block Circulation:  54193 54192 54190 54189 54188 54187 54186 54185 54183 54181 0
> [ 1799.081540] smpboot: CPU 14 is now offline
> [ 1800.137820] smpboot: Booting Node 0 Processor 11 APIC 0xb
> [ 1801.271492] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1802.631739] smpboot: CPU 6 is now offline
> [ 1803.748607] smpboot: CPU 2 is now offline
> [ 1804.788148] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [ 1805.912975] smpboot: CPU 4 is now offline
> [ 1806.114921] rcu-torture: rcu_torture_read_exit: Start of episode
> [ 1806.145432] rcu-torture: rcu_torture_read_exit: End of episode
> [ 1807.001922] smpboot: CPU 8 is now offline
> [ 1808.330167] smpboot: Booting Node 0 Processor 9 APIC 0x9
> [ 1808.537200] rcu-torture: torture_shutdown task shutting down system
> [ 1808.543936] rcu-torture: rcu_torture_reader is stopping
> [ 1808.543936] rcu-torture: rcu_torture_reader is stopping
> [ 1808.543937] rcu-torture: Stopping torture_shuffle task
> [ 1808.543965] rcu-torture: rcu_torture_reader is stopping
> [ 1808.543984] rcu-torture: torture_shuffle is stopping
> [ 1808.543994] rcu-torture: rcu_torture_reader is stopping
> [ 1808.543998] rcu-torture: rcu_torture_reader is stopping
> [ 1808.544009] rcu-torture: rcu_torture_reader is stopping
> [ 1808.544037] rcu-torture: rcu_torture_reader is stopping
> [ 1808.544050] rcu-torture: Stopping torture_stutter task
> [ 1808.544146] rcu-torture: torture_stutter is stopping
> [ 1808.544256] rcu-torture: Stopping torture_onoff task
> [ 1808.544342] rcu-torture: torture_onoff is stopping
> [ 1808.544532] rcu-torture: rcu_torture_reader is stopping
> [ 1808.544547] rcu-torture: rcu_torture_reader is stopping
> [ 1808.554594] rcu-torture: rcu_torture_reader is stopping
> [ 1808.620739] rcu-torture: rcu_torture_reader is stopping
> [ 1808.627507] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 1808.627946] rcu-torture: rcu_torture_fakewriter is stopping
> [ 1808.631021] rcu-torture: rcu_torture_fakewriter is stopping
> [ 1808.631816] rcu-torture: rcu_torture_fakewriter is stopping
> [ 1808.634966] rcu-torture: rcu_torture_barrier is stopping
> [ 1808.706293] rcu-torture: rcu_torture_reader is stopping
> [ 1808.706301] rcu-torture: rcu_torture_reader is stopping
> [ 1808.706315] rcu-torture: rcu_torture_reader is stopping
> [ 1808.706328] rcu-torture: rcu_torture_reader is stopping
> [ 1808.712173] rcu-torture: rcu_torture_writer is stopping
> [ 1808.714207] rcu-torture: rcu_torture_fakewriter is stopping
> [ 1808.716486] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [ 1808.763393] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [ 1808.791825] smpboot: Booting Node 0 Processor 8 APIC 0x8
> [ 1808.819081] smpboot: Booting Node 0 Processor 12 APIC 0xc
> [ 1808.844710] smpboot: Booting Node 0 Processor 14 APIC 0xe
> [ 1808.870690] smpboot: Booting Node 0 Processor 15 APIC 0xf
> [ 1808.896358] rcu: rcu_sched: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 1 ->gp_activity 1 ->gp_req_activity 1 ->gp_wake_time 79 ->gp_wake_seq 308380 ->gp_seq 308397 ->gp_seq_needed 308396 ->gp_max 34481 ->gp_flags 0x0
> [ 1808.919407] rcu: 	rcu_node 0:1 ->gp_seq 308397 ->gp_seq_needed 308404 ->qsmask 0x0 .... ->n_boosts 0
> [ 1808.928681] rcu: 	cpu 0 ->gp_seq_needed 308404
> [ 1808.933219] rcu: 	cpu 1 ->gp_seq_needed 308404
> [ 1808.937758] rcu: 	rcu_node 8:9 ->gp_seq 308401 ->gp_seq_needed 308404 ->qsmask 0x0 .... ->n_boosts 0
> [ 1808.947024] rcu: 	rcu_node 12:13 ->gp_seq 308401 ->gp_seq_needed 308404 ->qsmask 0x0 .... ->n_boosts 0
> [ 1808.956426] rcu: 	cpu 13 ->gp_seq_needed 308404
> [ 1808.961054] rcu: 	rcu_node 14:15 ->gp_seq 308401 ->gp_seq_needed 308404 ->qsmask 0x0 .... ->n_boosts 0
> [ 1808.970991] rcu: 	cpu 14 ->gp_seq_needed 308404
> [ 1808.975710] rcu: 	cpu 15 ->gp_seq_needed 308404
> [ 1808.980364] rcu:    CB 2^0->3 KbclSW F264 L264 C8 ..... q0 S CPU 13
> [ 1808.986704] rcu:    CB 3^0->-1 KbclSW F483 L487 C0 ..... q0 S CPU 0
> [ 1808.993057] rcu: nocb GP 4 KldtS W[..] ..:0 rnp 4:5 2510548 S CPU 10
> [ 1808.999483] rcu:    CB 4^4->5 KbclSW F237 L237 C10 ..... q0 S CPU 13
> [ 1809.005895] rcu:    CB 5^4->6 KbclSW F1612 L1612 C0 ..... q0 S CPU 1
> [ 1809.012343] rcu:    CB 6^4->7 KbclSW F221 L221 C10 ..... q0 S CPU 13
> [ 1809.018818] rcu:    CB 7^4->-1 KbclSW F980 L1011 C0 ..... q0 S CPU 1
> [ 1809.025726] rcu: nocb GP 8 KldtS .[.W] .G:308404 rnp 8:9 9920 S CPU 1
> [ 1809.032282] rcu:    CB 8^8->9 KbclSW F214 L214 C12 ..... q0 S CPU 11
> [ 1809.038736] rcu:    CB 9^8->-1 KbclSW F142 L142 C1 .W308404... q2 S CPU 0
> [ 1809.045698] rcu: RCU callbacks invoked since boot: 7772972
> [ 1809.571237] rcu-torture: rcu_torture_read_exit is stopping
> [ 1809.571261] rcu-torture: Stopping rcutorture_read_exit task
> [ 1809.588298] rcu-torture: Stopping rcu_torture_barrier task
> [ 1809.594269] rcu-torture: Stopping rcu_torture_barrier_cbs task
> [ 1809.607965] rcu-torture: rcu_torture_barrier_cbs is stopping
> [ 1809.620231] rcu-torture: Stopping rcu_torture_barrier_cbs task
> [ 1809.630039] rcu-torture: rcu_torture_barrier_cbs is stopping
> [ 1809.638506] rcu-torture: Stopping rcu_torture_barrier_cbs task
> [ 1809.654584] rcu-torture: rcu_torture_barrier_cbs is stopping
> [ 1809.662277] rcu-torture: Stopping rcu_torture_barrier_cbs task
> [ 1809.672076] rcu-torture: rcu_torture_barrier_cbs is stopping
> [ 1809.678364] rcu-torture: Stopping rcu_torture_fwd_prog task
> [ 1809.684467] rcu_torture_fwd_prog n_max_cbs: 39662
> [ 1809.689711] rcu_torture_fwd_prog: Starting forward-progress test 0
> [ 1809.696194] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [ 1809.707595] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1810.723205] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [ 1810.741359] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x4c0() 0
> [ 1810.859039] rcu_torture_fwd_prog: tested 22 tested_tries 24
> [ 1810.866996] rcu-torture: rcu_torture_fwd_prog is stopping
> [ 1810.874974] rcu-torture: Stopping rcu_torture_writer task
> [ 1810.881102] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.888753] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.897192] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.903237] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.909117] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.914953] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.920772] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.926560] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.932338] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.938194] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.944149] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.950129] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.955969] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.961773] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.967999] rcu-torture: Stopping rcu_torture_reader task
> [ 1810.974198] rcu-torture: Stopping rcu_torture_fakewriter task
> [ 1810.980648] rcu-torture: Stopping rcu_torture_fakewriter task
> [ 1810.988327] rcu-torture: Stopping rcu_torture_fakewriter task
> [ 1810.994788] rcu-torture: Stopping rcu_torture_fakewriter task
> [ 1811.001336] rcu:  End-test grace-period state: g308533 f0x0 total-gps=77411
> [ 1811.008478] rcu-torture: Stopping rcu_torture_stats task
> [ 1811.013996] rcu-torture: rtc: 0000000000000000 VER: 54543 tfle: 0 rta: 54543 rtaf: 0 rtf: 54531 rtmbe: 0 rtmbkf: 0/14003 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5219949 onoff: 684/684:691/691 27,1937:17,34603 100197:210808 (HZ=1000) barrier: 9428/9428:0 read-exits: 2048 nocb-toggles: 0:0
> [ 1811.039557] rcu-torture: Reader Pipe:  2290105053 224296 0 0 0 0 0 0 0 0 0
> [ 1811.046692] rcu-torture: Reader Batch:  2289855982 473367 0 0 0 0 0 0 0 0 0
> [ 1811.054016] rcu-torture: Free-Block Circulation:  54542 54542 54541 54540 54538 54537 54536 54535 54532 54531 0
> [ 1811.064318] rcu-torture: rcu_torture_stats is stopping
> [ 1811.069987] rcu_torture_cleanup: Invoking rcu_barrier+0x0/0x4c0().
> [ 1811.083727] stackdepot: allocating hash table of 32768 entries via kvcalloc
> [ 1811.091291] mem_dump_obj() slab test: rcu_torture_stats = 0000000000000000, &rhp = ffff9eed0061fe80, rhp = ffff94ad02224000, &z = ffffffffb0cca6a0
> [ 1811.109407] mem_dump_obj(ZERO_SIZE_PTR): zero-size pointer
> [ 1811.115121] mem_dump_obj(NULL): NULL pointer
> [ 1811.119536] mem_dump_obj(ffff9eed0061fe80): 4-page vmalloc region starting at 0xffff9eed0061c000 allocated at kernel_clone+0x96/0x390
> [ 1811.131654] mem_dump_obj(ffff94ad02224000): slab rcuscale start ffff94ad02224000 pointer offset 0 size 136 allocated at rcu_torture_cleanup+0x4f2/0x930
> [ 1811.150130]     rcu_torture_cleanup+0x4f2/0x930
> [ 1811.155038]     torture_shutdown+0xe6/0x210
> [ 1811.159407]     kthread+0xc6/0xf0
> [ 1811.163022]     ret_from_fork+0x2b/0x40
> [ 1811.167250]     ret_from_fork_asm+0x1b/0x30
> [ 1811.171785] mem_dump_obj(ffff94ad02224008): slab rcuscale start ffff94ad02224000 pointer offset 8 size 136 allocated at rcu_torture_cleanup+0x4f2/0x930
> [ 1811.190239]     rcu_torture_cleanup+0x4f2/0x930
> [ 1811.194934]     torture_shutdown+0xe6/0x210
> [ 1811.199436]     kthread+0xc6/0xf0
> [ 1811.202909]     ret_from_fork+0x2b/0x40
> [ 1811.207008]     ret_from_fork_asm+0x1b/0x30
> [ 1811.211306] mem_dump_obj(ffffffffb0cca6a0): non-slab/vmalloc memory
> [ 1811.218097] mem_dump_obj() kmalloc test: rcu_torture_stats = 0000000000000000, &rhp = ffff9eed0061fe80, rhp = ffff94ad0376b480
> [ 1811.231097] mem_dump_obj(kmalloc ffff94ad0376b480): slab kmalloc-16 start ffff94ad0376b480 pointer offset 0 size 16
> [ 1811.242221] mem_dump_obj(kmalloc ffff94ad0376b488): slab kmalloc-16 start ffff94ad0376b480 pointer offset 8 size 16
> [ 1811.253284] mem_dump_obj() vmalloc test: rcu_torture_stats = 0000000000000000, &rhp = ffff9eed0061fe80, rhp = ffff9eed0002d000
> [ 1811.265595] mem_dump_obj(vmalloc ffff9eed0002d000): 1-page vmalloc region starting at 0xffff9eed0002d000 allocated at rcu_torture_cleanup+0x669/0x930
> [ 1811.279908] mem_dump_obj(vmalloc ffff9eed0002d008): 1-page vmalloc region starting at 0xffff9eed0002d000 allocated at rcu_torture_cleanup+0x669/0x930
> [ 1811.294423] rcu-torture: rtc: 0000000000000000 VER: 54543 tfle: 0 rta: 54543 rtaf: 0 rtf: 54531 rtmbe: 0 rtmbkf: 0/14003 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 5219949 onoff: 684/684:691/691 27,1937:17,34603 100197:210808 (HZ=1000) barrier: 9428/9428:0 read-exits: 2048 nocb-toggles: 0:0
> [ 1811.322370] rcu-torture: Reader Pipe:  2290105053 224296 0 0 0 0 0 0 0 0 0
> [ 1811.329790] rcu-torture: Reader Batch:  2289855982 473367 0 0 0 0 0 0 0 0 0
> [ 1811.337269] rcu-torture: Free-Block Circulation:  54542 54542 54541 54540 54538 54537 54536 54535 54532 54531 0
> [ 1811.348246] rcu-torture:--- End of test: SUCCESS: nreaders=15 nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=1800 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=1000 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> [ 1811.395955] i2c i2c-0: shutdown
> [ 1811.399731] alarmtimer alarmtimer.0.auto: shutdown
> [ 1811.405234] psmouse serio1: shutdown
> [ 1811.410065] atkbd serio0: shutdown
> [ 1811.414164] i8042 i8042: shutdown
> [ 1811.418083] platform Fixed MDIO bus.0: shutdown
> [ 1811.422845] serial8250 serial8250: shutdown
> [ 1811.427270] platform pcspkr: shutdown
> [ 1811.431247] platform regulatory.0: shutdown
> [ 1811.437462] system 00:05: shutdown
> [ 1811.441030] rtc_cmos 00:04: shutdown
> [ 1811.445115] serial 00:03: shutdown
> [ 1811.448887] pnp 00:02: shutdown
> [ 1811.452253] i8042 aux 00:01: shutdown
> [ 1811.456059] i8042 kbd 00:00: shutdown
> [ 1811.459902] platform PNP0103:00: shutdown
> [ 1811.464041] platform QEMU0002:00: shutdown
> [ 1811.468440] i801_smbus 0000:00:1f.3: shutdown
> [ 1811.475100] ahci 0000:00:1f.2: shutdown
> [ 1811.481690] pci 0000:00:1f.0: shutdown
> [ 1811.485789] pci 0000:00:01.0: shutdown
> [ 1811.489733] pci 0000:00:00.0: shutdown
> [ 1811.493757] ACPI: PM: Preparing to enter system sleep state S5
> [ 1811.500155] PM: Calling mce_syscore_shutdown+0x0/0x10
> [ 1811.505651] PM: Calling i8259A_shutdown+0x0/0x10
> [ 1811.510524] reboot: Power down
> 
> 
> 

