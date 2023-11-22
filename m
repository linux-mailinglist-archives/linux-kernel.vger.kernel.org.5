Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74AE7F4FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjKVSn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:43:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89636D4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:43:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D504C433C9;
        Wed, 22 Nov 2023 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700678633;
        bh=greUwhHcleCvGLrnawmrLUpL+REUxW++4IRcRnG562U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hIPC4ajBO65xrq6JuXjfcKUm7Pfv1fseVp7plx2+m732Gh4eEFy5KzaeZS89aQYF+
         Tfj419WjKQa6Td8bn6LA5RIqUS0TjYn4e5uayBn2bvYp6q5k578w3Rx2v1M+nPnP5Z
         QDokseuGXFwiBkfaxZrJ/TBee/r6SXUrGw3Ms26oJ9uzyZKKkvQ4acFjUAR6zfqZPO
         JSH5UUtvvJXgf3mBWGsvnPZj6+VyOFZrqIiwQ9TujrDwSHkfeIMdYdP5a6ZKobRzlX
         h0TbKp2gMQAOWjcWdDGs4te3u8pCv4eiJc4/32IXxMSdhkuNP3O/cvlxa59vFsXT6+
         Q+w/lk3zOSp8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFDDACE0C41; Wed, 22 Nov 2023 10:43:52 -0800 (PST)
Date:   Wed, 22 Nov 2023 10:43:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     sfr@canb.auug.org.au, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [BUG] RCU CPU stall warning (heads up)
Message-ID: <fc50b62c-813b-45e6-ad7b-227cbd0415ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just FYI for the moment.

I hit the following three times out of 15 ten-hour TREE03 rcutorture
runs on next-20231121, which suggests an MTBF of about 50 hours.  This is
new over the past week or so.

The symptom is that the RCU grace-period kthread is marked as running
("R"), but remains stuck in schedule() for the remainder of the run.

My next steps will be to retry on today's -next, and if that reproduces
the bug, attempt to bisect.

But I figured that I should send this out on the off-chance that it is
a known problem.

						Thanx, Paul

[  456.859071] rcu-torture: rtc: 0000000002666dc0 ver: 14234 tfle: 0 rta: 14235 rtaf: 0 rtf: 14225 rtmbe: 0 rtmbkf: 0/10105 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 39 nt: 792049 onoff: 324/324:329/330 18,4182:5,9107 84652:154698 (HZ=1000) barrier: 1987/1988:0 read-exits: 416 nocb-toggles: 0:0
[  456.865422] rcu-torture: Reader Pipe:  1075314187 71402 0 0 0 0 0 0 0 0 0
[  456.867182] rcu-torture: Reader Batch:  1075090167 295422 0 0 0 0 0 0 0 0 0
[  456.868930] rcu-torture: Free-Block Circulation:  14234 14233 14232 14231 14230 14229 14228 14227 14226 14225 0
[  464.018060] rcu: INFO: rcu_preempt self-detected stall on CPU
[  464.019191] rcu: 	11-...!: (1 GPs behind) idle=b41c/0/0x1 softirq=0/0 fqs=88
[  464.020489] rcu: 	(t=21003 jiffies g=302741 q=71371 ncpus=11)
[  464.021549] rcu: rcu_preempt kthread starved for 20595 jiffies! g302741 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  464.023457] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  464.025117] rcu: RCU grace-period kthread stack dump:
[  464.026030] task:rcu_preempt     state:R  running task     stack:14896 pid:14    tgid:14    ppid:2      flags:0x00004000
[  464.028032] Call Trace:
[  464.028507]  <TASK>
[  464.028900]  __schedule+0x306/0x880
[  464.029559]  schedule+0x2b/0xb0
[  464.030139]  schedule_timeout+0x86/0x160
[  464.030857]  ? __pfx_process_timeout+0x10/0x10
[  464.031673]  rcu_gp_fqs_loop+0x12a/0x5f0
[  464.032406]  ? __pfx_rcu_gp_kthread+0x10/0x10
[  464.033207]  rcu_gp_kthread+0x191/0x240
[  464.033905]  kthread+0xd3/0x100
[  464.034494]  ? __pfx_kthread+0x10/0x10
[  464.035189]  ret_from_fork+0x2f/0x50
[  464.035837]  ? __pfx_kthread+0x10/0x10
[  464.036534]  ret_from_fork_asm+0x1a/0x30
[  464.037264]  </TASK>
[  464.037665] rcu: Stack dump where RCU GP kthread last ran:
[  464.038671] Sending NMI from CPU 11 to CPUs 0:
[  464.039507] NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20
[  464.040505] CPU: 11 PID: 0 Comm: swapper/11 Not tainted 6.7.0-rc2-next-20231121 #7188
[  464.042806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  464.044842] RIP: 0010:default_idle+0xf/0x20
[  464.045618] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 a8 36 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[  464.048992] RSP: 0000:ffffac70400fbef0 EFLAGS: 00000202
[  464.049952] RAX: ffff9d381f4c0000 RBX: ffff9d380124c740 RCX: 0000000000000000
[  464.051264] RDX: 4000000000000000 RSI: ffffffffb4afa83b RDI: 000000000c18b414
[  464.052557] RBP: 000000000000000b R08: 000000000c18b414 R09: 0000000000000000
[  464.053856] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  464.055169] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  464.056463] FS:  0000000000000000(0000) GS:ffff9d381f4c0000(0000) knlGS:0000000000000000
[  464.057936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.058988] CR2: 0000000000000000 CR3: 000000000204e000 CR4: 00000000000006f0
[  464.060314] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  464.061607] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  464.062907] Call Trace:
[  464.063378]  <IRQ>
[  464.063754]  ? rcu_dump_cpu_stacks+0xf1/0x150
[  464.064629]  ? rcu_sched_clock_irq+0x56e/0xee0
[  464.065450]  ? __kmem_cache_alloc_node+0x44/0x1e0
[  464.066316]  ? rcu_torture_timer+0x4e/0x80
[  464.067063]  ? __pfx_rcu_torture_timer+0x10/0x10
[  464.067910]  ? kvm_sched_clock_read+0x11/0x20
[  464.068713]  ? sched_clock+0x10/0x30
[  464.069395]  ? sched_clock_cpu+0xf/0x190
[  464.070116]  ? update_process_times+0x45/0x70
[  464.070907]  ? tick_nohz_highres_handler+0xb6/0xe0
[  464.071790]  ? __pfx_tick_nohz_highres_handler+0x10/0x10
[  464.072772]  ? __hrtimer_run_queues+0x10d/0x2a0
[  464.073606]  ? hrtimer_interrupt+0xfe/0x240
[  464.074386]  ? __sysvec_apic_timer_interrupt+0x53/0x140
[  464.075353]  ? sysvec_apic_timer_interrupt+0x6b/0x80
[  464.076270]  </IRQ>
[  464.076655]  <TASK>
[  464.077040]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  464.078021]  ? default_idle+0xf/0x20
[  464.078692]  default_idle_call+0x2d/0xe0
[  464.079420]  do_idle+0x180/0x1c0
[  464.080021]  cpu_startup_entry+0x24/0x30
[  464.080756]  start_secondary+0xf7/0x100
[  464.081479]  secondary_startup_64_no_verify+0x178/0x17b
[  464.082445]  </TASK>
