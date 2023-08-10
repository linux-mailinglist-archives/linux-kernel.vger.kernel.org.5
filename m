Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E2777844
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjHJM0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjHJM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B56326B9;
        Thu, 10 Aug 2023 05:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50C863FF3;
        Thu, 10 Aug 2023 12:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79394C433C8;
        Thu, 10 Aug 2023 12:26:18 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH V3 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Date:   Thu, 10 Aug 2023 20:24:56 +0800
Message-Id: <20230810122456.991421-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230810122456.991421-1-chenhuacai@loongson.cn>
References: <20230810122456.991421-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KGDB initial breakpoint gets an rcu stall warning after commit
a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
rcu_cpu_stall_reset()").

[   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
[   53.487950] rcu:     3-...0: (1 ticks this GP) idle=0e2c/1/0x4000000000000000 softirq=375/375 fqs=8
[   53.528243] rcu:     (t=12297 jiffies g=-995 q=1 ncpus=4)
[   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #4848
[   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2.0.05099-beta8 08
[   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000001000a0000 sp 90000001000a3710
[   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 0000000000000001 a3 0000000000000000
[   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 000000000000002c a7 0000000000000000
[   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 900000000131c9c0 t3 fffffffffffffffa
[   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 0000000000000004 t7 9000000001912d58
[   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 0000000000000028 s0 9000000001d512f0
[   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000000019fc410 s4 9000000001d4b488
[   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 0000000000000078 s8 9000000001d4b450
[   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
[   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
[   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
[   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   54.207838]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[   54.242503] ESTAT: 00000800 [INT] (IS=11 ECode=0 EsubCode=0)
[   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-HV)
[   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #4848
[   54.430170] Stack : 0072617764726148 0000000000000000 9000000000223504 90000001000a0000
[   54.472308]         9000000100073a90 9000000100073a98 0000000000000000 9000000100073bd8
[   54.514413]         9000000100073bd0 9000000100073bd0 9000000100073a00 0000000000000001
[   54.556018]         0000000000000001 9000000100073a98 99828271f24e961a 90000001002810c0
[   54.596924]         0000000000000001 0000000000010003 0000000000000000 0000000000000001
[   54.637115]         ffff8000337cdb80 0000000000000001 0000000006360000 900000000131c9c0
[   54.677049]         0000000000000000 0000000000000000 90000000017b4c98 9000000001912000
[   54.716394]         9000000001912f68 9000000001913000 9000000001912f70 00000000000002b0
[   54.754880]         90000000014a8840 0000000000000000 900000000022351c 0000000000000000
[   54.792372]         00000000000002b0 000000000000000c 0000000000000000 0000000000071c1c
[   54.829302]         ...
[   54.859163] Call Trace:
[   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
[   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
[   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x148
[   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe60
[   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc0
[   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
[   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x240
[   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
[   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38/0x60
[   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x50/0x160
[   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/0x80
[   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
[   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x28/0x40
[   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
[   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x60
[   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
[   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
[   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0x180
[   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0xa0
[   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
[   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
[   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
[   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160/0x1c0
[   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
[   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
[   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
[   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
[   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x140
[   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x120
[   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0x160
[   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
[   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
[   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
[   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
[   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2c0
[   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
[   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
[   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x2a0
[   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124

Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to one check
period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But jiffies
is only updated in the timer interrupt, so when kgdb_cpu_enter() begins
to run there may already be nearly one rcu check period after jiffies.
Since all interrupts are disabled during kgdb_cpu_enter(), jiffies will
not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_stall
maybe already gets timeout.

We can set rcu_state.jiffies_stall to two rcu check periods later, e.g.
jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_reset()
to avoid this problem. But this isn't a complete solution because kgdb
may take a very long time in irq disabled context.

Instead, update jiffies at the beginning of rcu_cpu_stall_reset() can
solve all kinds of problems.

Cc: stable@vger.kernel.org
Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..1c7b540985bf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
  */
 void rcu_cpu_stall_reset(void)
 {
+	do_update_jiffies_64(ktime_get());
 	WRITE_ONCE(rcu_state.jiffies_stall,
 		   jiffies + rcu_jiffies_till_stall_check());
 }
-- 
2.39.3

