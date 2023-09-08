Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1D798E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjIHTCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjIHTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:02:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF5E4B;
        Fri,  8 Sep 2023 12:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCE9C433BC;
        Fri,  8 Sep 2023 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196243;
        bh=D7FUcuOPVzJk8X2hOs374iQOqUnHacFnq8NJbv90vgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7e2/pDCCzrXv3esd3f7da+nKM4DCK0yHr8SvjbR3YFzMgZmVGNctuNJijs6mLyGu
         4/NMVKvYjieoulVw4+ABkZF4heJkqfP+stslQzChHXhTdwndG5KG9Vswl4L/ouJMme
         uhkDtrpAhJ816pBxyuJMZG/+7e37j64VO1V6tomKKOg67KT170wj7mIvkQ7HnQXnZq
         lK6Z8/NaaeflokFw7+a1Fs4cnZ9Pioytm8XcMwxYP0iQlD3q1Tw4w83ToTEDBYc4aE
         qhGaXJQDgTA2DESiXH/Z9KektuZ5SJHRcJCJIkU2Klcw7TOcEOuRUaNFLAvYNSz8Jy
         a4NLSskrjzBLw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, brauner@kernel.org,
        michael.christie@oracle.com, mst@redhat.com,
        wangkefeng.wang@huawei.com, akpm@linux-foundation.org,
        surenb@google.com, Liam.Howlett@oracle.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        mjguzik@gmail.com, avagin@gmail.com
Subject: [PATCH AUTOSEL 5.4 2/5] kernel/fork: beware of __put_task_struct() calling context
Date:   Fri,  8 Sep 2023 14:03:48 -0400
Message-Id: <20230908180352.3458731-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180352.3458731-1-sashal@kernel.org>
References: <20230908180352.3458731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit d243b34459cea30cfe5f3a9b2feb44e7daff9938 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/task.h | 28 +++++++++++++++++++++++++++-
 kernel/fork.c              |  8 ++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 853ab403e77b8..e3c20a4f81f5e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -113,10 +113,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
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
index 39134effb2bff..1728aa77861cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -749,6 +749,14 @@ void __put_task_struct(struct task_struct *tsk)
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
-- 
2.40.1

