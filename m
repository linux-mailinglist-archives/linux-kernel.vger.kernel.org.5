Return-Path: <linux-kernel+bounces-109152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B886881564
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC931F2497F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC0854F9D;
	Wed, 20 Mar 2024 16:17:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5DC5474D;
	Wed, 20 Mar 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951470; cv=none; b=KjpmVHTYbvEsxE1e3y4qyG9IhbM9Km88TJ7ebwRyveKw18AP4YvgQBMyqj05dD+RMuVq5Yj/J74c9r9eE8wSrbLHMgTaLiQHg1NQ4lKUA1E9P9CPOOc9Irazr02wwuXXJsQbO2WkdjNv7jv0YNndlPUVSWojBX9BOSAkfVACKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951470; c=relaxed/simple;
	bh=MjsTErL++3mNSNQUdfMEPoHEWuqAralTC+D1xVnk5Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SPqDanPLWdnW0ZHFV2yXkG6HQExKHIOUdmjT9nxHM8N0Kr4Arzpf9AsNvQsQnt79QP6Jz2aDWzIWQNEGGS/3Eq1Sth1QxhOSLbqByl4fk+Z2Zc5DtYF/ow9A9Dqa7PH7CsqrmGkIKc663mXrjeT5di3km/DPeBmVmA/YsxZ4214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC6C433F1;
	Wed, 20 Mar 2024 16:17:48 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:20:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Message-ID: <20240320122012.2c1f461f@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt (Google) <rostedt@goodmis.org>

I'm debugging some latency issues on a Chromebook and the preemptirqsoff
tracer hit this:

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 5.15.148-21853-g165fd2387469-dirty
# --------------------------------------------------------------------
# latency: 7813 us, #60/60, CPU#1 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
#    -----------------
#    | task: init-1 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: rwsem_optimistic_spin
#  => ended at:   rwsem_optimistic_spin
#
#
#                    _------=> CPU#            
#                   / _-----=> irqs-off        
#                  | / _----=> need-resched    
#                  || / _---=> hardirq/softirq 
#                  ||| / _--=> preempt-depth   
#                  |||| / _-=> migrate-disable 
#                  ||||| /     delay           
#  cmd     pid     |||||| time  |   caller     
#     \   /        ||||||  \    |    /       
   <...>-1         1...1.    0us!: rwsem_optimistic_spin+0x20/0x194 <-rwsem_optimistic_spin+0x20/0x194
   <...>-1         1.N.1. 7813us : rwsem_optimistic_spin+0x140/0x194 <-rwsem_optimistic_spin+0x140/0x194
   <...>-1         1.N.1. 7814us+: tracer_preempt_on+0x4c/0x6a <-rwsem_optimistic_spin+0x140/0x194
   <...>-1         1.N.1. 7824us : <stack trace>
 => rwsem_optimistic_spin+0x140/0x194
 => rwsem_down_write_slowpath+0xc9/0x3fe
 => copy_process+0xd08/0x1b8a
 => kernel_clone+0x94/0x256
 => __x64_sys_clone+0x7a/0x9a
 => do_syscall_64+0x51/0xa1
 => entry_SYSCALL_64_after_hwframe+0x5c/0xc6

Which isn't a real issue, as it's in the rwsem_optimistic_spin() code that
spins with interrupts enabled, preempt disabled, and checks for
need_resched(). If it is true, it breaks out and schedules.

Hence, it's hiding real issues, because it can spin for a very long time
and this is not the source of the latency I'm tracking down.

I would like to introduce restart_critical_timings() and place it in
locations that have this behavior.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 147feebd508c..e9f97f60bfc0 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -145,6 +145,13 @@ do {						\
 # define start_critical_timings() do { } while (0)
 #endif
 
+/* Used in spins that check need_resched() with preemption disabled */
+static inline void restart_critical_timings(void)
+{
+	stop_critical_timings();
+	start_critical_timings();
+}
+
 #ifdef CONFIG_DEBUG_IRQFLAGS
 extern void warn_bogus_irq_restore(void);
 #define raw_check_bogus_irq_restore()			\
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..fa7b43e53d20 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <linux/irqflags.h>
 #include <trace/events/lock.h>
 
 #ifndef CONFIG_PREEMPT_RT
@@ -780,6 +781,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		barrier();
 
+		restart_critical_timings();
 		if (need_resched() || !owner_on_cpu(owner)) {
 			state = OWNER_NONSPINNABLE;
 			break;
@@ -912,6 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * a writer, need_resched() check needs to be done here.
 		 */
 		if (owner_state != OWNER_WRITER) {
+			restart_critical_timings();
 			if (need_resched())
 				break;
 			if (rt_task(current) &&

