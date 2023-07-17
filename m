Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7D7563A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGQM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGQM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E7170C;
        Mon, 17 Jul 2023 05:57:43 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlOkQCFk3GFnRbPmQXKHbRTdEl3oGUWoIOQ8kMbDV9I=;
        b=QcutTLYx3wmQOeYFDjLlFyjsINXg/Jxhca1Hrz9u/WAol1fdADWM4dmnRq40f+tnVesYts
        VWeUj+Us7M5cnIRG2LDrpZU3ZpzoJ4Hv78NE1w7UChz/dYLPkMuOFVBksUtxRYaEGlB0bE
        fEi3IkASmaS3shCHBTtd8xdEXWZKoSiqV3jk68youiL5gVe463i2d0dXfyTO08/4zM9+ri
        Kc0tFq1ZNoPY82njIdHWH3S4/vfkDgDrwaXE0/+5pNzcddlddqYDXTHIM0v8itzCQGtnCZ
        vnUOqBb590cO7NV9VrN3vdRyuhcQ/+glWSDYhx20hVJbBGX62+wLZAlTDgHegQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlOkQCFk3GFnRbPmQXKHbRTdEl3oGUWoIOQ8kMbDV9I=;
        b=iS214HZ4+SeriTkWLWbI3D8WWXr2CNs3X5mTcVT24B7OVGtDor5LiUfayMSHC4uzXLWEUO
        IgqRtg1gJy/3hqBg==
From:   "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kernel/fork: beware of __put_task_struct() calling context
Cc:     Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230614122323.37957-2-wander@redhat.com>
References: <20230614122323.37957-2-wander@redhat.com>
MIME-Version: 1.0
Message-ID: <168959857646.28540.11268009313059773705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d243b34459cea30cfe5f3a9b2feb44e7daff9938
Gitweb:        https://git.kernel.org/tip/d243b34459cea30cfe5f3a9b2feb44e7daff9938
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Wed, 14 Jun 2023 09:23:21 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:48 +02:00

kernel/fork: beware of __put_task_struct() calling context

Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
locks. Therefore, it can't be called from an non-preemptible context.

One practical example is splat inside inactive_task_timer(), which is
called in a interrupt context:

  CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
   Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
   Call Trace:
   dump_stack_lvl+0x57/0x7d
   mark_lock_irq.cold+0x33/0xba
   mark_lock+0x1e7/0x400
   mark_usage+0x11d/0x140
   __lock_acquire+0x30d/0x930
   lock_acquire.part.0+0x9c/0x210
   rt_spin_lock+0x27/0xe0
   refill_obj_stock+0x3d/0x3a0
   kmem_cache_free+0x357/0x560
   inactive_task_timer+0x1ad/0x340
   __run_hrtimer+0x8a/0x1a0
   __hrtimer_run_queues+0x91/0x130
   hrtimer_interrupt+0x10f/0x220
   __sysvec_apic_timer_interrupt+0x7b/0xd0
   sysvec_apic_timer_interrupt+0x4f/0xd0
   asm_sysvec_apic_timer_interrupt+0x12/0x20
   RIP: 0033:0x7fff196bf6f5

Instead of calling __put_task_struct() directly, we defer it using
call_rcu(). A more natural approach would use a workqueue, but since
in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
the code would become more complex because we would need to put the
work_struct instance in the task_struct and initialize it when we
allocate a new task_struct.

The issue is reproducible with stress-ng:

  while true; do
      stress-ng --sched deadline --sched-period 1000000000 \
	      --sched-runtime 800000000 --sched-deadline \
	      1000000000 --mmapfork 23 -t 20
  done

Reported-by: Hu Chunyu <chuhu@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230614122323.37957-2-wander@redhat.com
---
 include/linux/sched/task.h | 28 +++++++++++++++++++++++++++-
 kernel/fork.c              |  8 ++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index dd35ce2..6b687c1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -118,10 +118,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 }
 
 extern void __put_task_struct(struct task_struct *t);
+extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
 {
-	if (refcount_dec_and_test(&t->usage))
+	if (!refcount_dec_and_test(&t->usage))
+		return;
+
+	/*
+	 * under PREEMPT_RT, we can't call put_task_struct
+	 * in atomic context because it will indirectly
+	 * acquire sleeping locks.
+	 *
+	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * to be called in process context.
+	 *
+	 * __put_task_struct() is called when
+	 * refcount_dec_and_test(&t->usage) succeeds.
+	 *
+	 * This means that it can't "conflict" with
+	 * put_task_struct_rcu_user() which abuses ->rcu the same
+	 * way; rcu_users has a reference so task->usage can't be
+	 * zero after rcu_users 1 -> 0 transition.
+	 *
+	 * delayed_free_task() also uses ->rcu, but it is only called
+	 * when it fails to fork a process. Therefore, there is no
+	 * way it can conflict with put_task_struct().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
+	else
 		__put_task_struct(t);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6..f811497 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -985,6 +985,14 @@ void __put_task_struct(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
+void __put_task_struct_rcu_cb(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	__put_task_struct(task);
+}
+EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
+
 void __init __weak arch_task_cache_init(void) { }
 
 /*
