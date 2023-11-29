Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E17FDA83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjK2Oyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjK2Oyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:54:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551ED69;
        Wed, 29 Nov 2023 06:54:50 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BD4fc2II5JmX/ogKkIA4bMem3DQjdYD91dRBM/nPp4c=;
        b=zQpDqlNu3SSretm66P0pdVRM09tgf/PA6Sx6yU+DGPkKImORHF3xN1LhGINybwRj4YZDAd
        29Wy0oa4jGCj4HYdyEDFmU6cZo+aNaIrZvjyeVFGSvfeH7imDPo3QjtR03GJ764mvM3dAx
        3irYG4zawCXSXalbSIrkgIOwDRbg46bu/e8PoYl29kwAPmalc4uvZN5Rp9WfFNr0lljRfp
        VAj3WeNjUbJqes7zm1tBts0LZV9BTi6JLSrDsFl0f+7xMr4DeOfUflNxPMigdrSTUjbOwM
        VArBzMJpDFxuwLqP+ORqyfusbwaL4/sU9hvOvcK+Z8uwVoiMxZoSgyIk1QVg3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BD4fc2II5JmX/ogKkIA4bMem3DQjdYD91dRBM/nPp4c=;
        b=QpunPe5sFqmGBGFQBwchR1eq5QgvgiAtsoK4JtjjF3IwHYx6vPMuFG6OQXYNbWbs0XfqhO
        PIAbUogXXuj725AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] ptrace: Convert ptrace_attach() to use lock guards
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170126968827.398.8511748826615430128.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5431fdd2c181dd2eac218e45b44deb2925fa48f0
Gitweb:        https://git.kernel.org/tip/5431fdd2c181dd2eac218e45b44deb2925fa48f0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 17 Sep 2023 13:24:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:43:54 +01:00

ptrace: Convert ptrace_attach() to use lock guards

Created as testing for the conditional guard infrastructure.
Specifically this makes use of the following form:

  scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
		     &task->signal->cred_guard_mutex) {
    ...
  }
  ...
  return 0;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20231102110706.568467727%40infradead.org
---
 include/linux/sched/task.h |   2 +-
 include/linux/spinlock.h   |  26 +++++++-
 kernel/ptrace.c            | 128 +++++++++++++++++-------------------
 3 files changed, 89 insertions(+), 67 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index a23af22..4f3dca3 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -226,4 +226,6 @@ static inline void task_unlock(struct task_struct *p)
 	spin_unlock(&p->alloc_lock);
 }
 
+DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
+
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index ceb56b3..90bc853 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -548,5 +548,31 @@ DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
 			 spin_trylock_irqsave(_T->lock, _T->flags))
 
+DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
+		    read_lock(_T->lock),
+		    read_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(read_lock_irq, rwlock_t,
+		    read_lock_irq(_T->lock),
+		    read_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(read_lock_irqsave, rwlock_t,
+		    read_lock_irqsave(_T->lock, _T->flags),
+		    read_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+DEFINE_LOCK_GUARD_1(write_lock, rwlock_t,
+		    write_lock(_T->lock),
+		    write_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(write_lock_irq, rwlock_t,
+		    write_lock_irq(_T->lock),
+		    write_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
+		    write_lock_irqsave(_T->lock, _T->flags),
+		    write_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d8b5e13..5c579fb 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -386,6 +386,34 @@ static int check_ptrace_options(unsigned long data)
 	return 0;
 }
 
+static inline void ptrace_set_stopped(struct task_struct *task)
+{
+	guard(spinlock)(&task->sighand->siglock);
+
+	/*
+	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
+	 * TRAPPING, and kick it so that it transits to TRACED.  TRAPPING
+	 * will be cleared if the child completes the transition or any
+	 * event which clears the group stop states happens.  We'll wait
+	 * for the transition to complete before returning from this
+	 * function.
+	 *
+	 * This hides STOPPED -> RUNNING -> TRACED transition from the
+	 * attaching thread but a different thread in the same group can
+	 * still observe the transient RUNNING state.  IOW, if another
+	 * thread's WNOHANG wait(2) on the stopped tracee races against
+	 * ATTACH, the wait(2) may fail due to the transient RUNNING.
+	 *
+	 * The following task_is_stopped() test is safe as both transitions
+	 * in and out of STOPPED are protected by siglock.
+	 */
+	if (task_is_stopped(task) &&
+	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
+		task->jobctl &= ~JOBCTL_STOPPED;
+		signal_wake_up_state(task, __TASK_STOPPED);
+	}
+}
+
 static int ptrace_attach(struct task_struct *task, long request,
 			 unsigned long addr,
 			 unsigned long flags)
@@ -393,17 +421,17 @@ static int ptrace_attach(struct task_struct *task, long request,
 	bool seize = (request == PTRACE_SEIZE);
 	int retval;
 
-	retval = -EIO;
 	if (seize) {
 		if (addr != 0)
-			goto out;
+			return -EIO;
 		/*
 		 * This duplicates the check in check_ptrace_options() because
 		 * ptrace_attach() and ptrace_setoptions() have historically
 		 * used different error codes for unknown ptrace options.
 		 */
 		if (flags & ~(unsigned long)PTRACE_O_MASK)
-			goto out;
+			return -EIO;
+
 		retval = check_ptrace_options(flags);
 		if (retval)
 			return retval;
@@ -414,88 +442,54 @@ static int ptrace_attach(struct task_struct *task, long request,
 
 	audit_ptrace(task);
 
-	retval = -EPERM;
 	if (unlikely(task->flags & PF_KTHREAD))
-		goto out;
+		return -EPERM;
 	if (same_thread_group(task, current))
-		goto out;
+		return -EPERM;
 
 	/*
 	 * Protect exec's credential calculations against our interference;
 	 * SUID, SGID and LSM creds get determined differently
 	 * under ptrace.
 	 */
-	retval = -ERESTARTNOINTR;
-	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
-		goto out;
+	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
+			   &task->signal->cred_guard_mutex) {
 
-	task_lock(task);
-	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
-	task_unlock(task);
-	if (retval)
-		goto unlock_creds;
+		scoped_guard (task_lock, task) {
+			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+			if (retval)
+				return retval;
+		}
 
-	write_lock_irq(&tasklist_lock);
-	retval = -EPERM;
-	if (unlikely(task->exit_state))
-		goto unlock_tasklist;
-	if (task->ptrace)
-		goto unlock_tasklist;
+		scoped_guard (write_lock_irq, &tasklist_lock) {
+			if (unlikely(task->exit_state))
+				return -EPERM;
+			if (task->ptrace)
+				return -EPERM;
 
-	task->ptrace = flags;
+			task->ptrace = flags;
 
-	ptrace_link(task, current);
+			ptrace_link(task, current);
 
-	/* SEIZE doesn't trap tracee on attach */
-	if (!seize)
-		send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
+			/* SEIZE doesn't trap tracee on attach */
+			if (!seize)
+				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
 
-	spin_lock(&task->sighand->siglock);
+			ptrace_set_stopped(task);
+		}
+	}
 
 	/*
-	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
-	 * TRAPPING, and kick it so that it transits to TRACED.  TRAPPING
-	 * will be cleared if the child completes the transition or any
-	 * event which clears the group stop states happens.  We'll wait
-	 * for the transition to complete before returning from this
-	 * function.
-	 *
-	 * This hides STOPPED -> RUNNING -> TRACED transition from the
-	 * attaching thread but a different thread in the same group can
-	 * still observe the transient RUNNING state.  IOW, if another
-	 * thread's WNOHANG wait(2) on the stopped tracee races against
-	 * ATTACH, the wait(2) may fail due to the transient RUNNING.
-	 *
-	 * The following task_is_stopped() test is safe as both transitions
-	 * in and out of STOPPED are protected by siglock.
+	 * We do not bother to change retval or clear JOBCTL_TRAPPING
+	 * if wait_on_bit() was interrupted by SIGKILL. The tracer will
+	 * not return to user-mode, it will exit and clear this bit in
+	 * __ptrace_unlink() if it wasn't already cleared by the tracee;
+	 * and until then nobody can ptrace this task.
 	 */
-	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
-		task->jobctl &= ~JOBCTL_STOPPED;
-		signal_wake_up_state(task, __TASK_STOPPED);
-	}
-
-	spin_unlock(&task->sighand->siglock);
-
-	retval = 0;
-unlock_tasklist:
-	write_unlock_irq(&tasklist_lock);
-unlock_creds:
-	mutex_unlock(&task->signal->cred_guard_mutex);
-out:
-	if (!retval) {
-		/*
-		 * We do not bother to change retval or clear JOBCTL_TRAPPING
-		 * if wait_on_bit() was interrupted by SIGKILL. The tracer will
-		 * not return to user-mode, it will exit and clear this bit in
-		 * __ptrace_unlink() if it wasn't already cleared by the tracee;
-		 * and until then nobody can ptrace this task.
-		 */
-		wait_on_bit(&task->jobctl, JOBCTL_TRAPPING_BIT, TASK_KILLABLE);
-		proc_ptrace_connector(task, PTRACE_ATTACH);
-	}
+	wait_on_bit(&task->jobctl, JOBCTL_TRAPPING_BIT, TASK_KILLABLE);
+	proc_ptrace_connector(task, PTRACE_ATTACH);
 
-	return retval;
+	return 0;
 }
 
 /**
