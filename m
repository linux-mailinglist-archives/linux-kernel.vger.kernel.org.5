Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488F7DF0E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbjKBLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347326AbjKBLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:08:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D79194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Q2pn5I7nEgFk410rx98yIHVX9gkNSJA5RXy11j/TIUU=; b=g2TxvWUb+tdjz89PIGGXgKdHMb
        o87ak7vYVvBl4+ZvD7z3AuVNmtL7xwzggARKzYhPihrBgmVI1PmuvvEaHlfavG4lyRPUgpYScj6nW
        dqoXOZdGRMfqYzR2xLnp3V3dpUTJDkdk7B+KxqYTjUx//QBCsNV0c5fItfVn2Dl/jIAsrEqWJRLBO
        1sx7xJVJCspPpK3P5TzGA9OmvIsoDOs2H66x4tymCb/2ydJGlF7N+tn+rmMZc4MpUWoAdZ/l/Hyf+
        qWKpWG0sWU6dmpvV3UijgOdNd8HGXD5ApSHviLuuxOo2BT3O2bZUdcMCAahH1l5ZGkBc1xMGn40Eq
        ojIsiMiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyVYZ-006WAQ-2h;
        Thu, 02 Nov 2023 11:08:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 7609F300940; Thu,  2 Nov 2023 12:08:11 +0100 (CET)
Message-Id: <20231102110706.568467727@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 11:44:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 2/2] ptrace: Convert ptrace_attach() to use lock guards
References: <20231102104429.025835330@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created as testing for the conditional guard infrastructure.
Specifically this makes use of the following form:

  scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
		     &task->signal->cred_guard_mutex) {
    ...
  }
  ...
  return 0;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/task.h |    2 
 include/linux/spinlock.h   |   26 ++++++++
 kernel/ptrace.c            |  138 +++++++++++++++++++++------------------------
 3 files changed, 94 insertions(+), 72 deletions(-)

--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -226,4 +226,6 @@ static inline void task_unlock(struct ta
 	spin_unlock(&p->alloc_lock);
 }
 
+DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
+
 #endif /* _LINUX_SCHED_TASK_H */
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -548,5 +548,31 @@ DEFINE_LOCK_GUARD_1(spinlock_irqsave, sp
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
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -386,6 +386,34 @@ static int check_ptrace_options(unsigned
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
@@ -393,17 +421,17 @@ static int ptrace_attach(struct task_str
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
@@ -414,88 +442,54 @@ static int ptrace_attach(struct task_str
 
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
-
-	task_lock(task);
-	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
-	task_unlock(task);
-	if (retval)
-		goto unlock_creds;
-
-	write_lock_irq(&tasklist_lock);
-	retval = -EPERM;
-	if (unlikely(task->exit_state))
-		goto unlock_tasklist;
-	if (task->ptrace)
-		goto unlock_tasklist;
-
-	task->ptrace = flags;
-
-	ptrace_link(task, current);
-
-	/* SEIZE doesn't trap tracee on attach */
-	if (!seize)
-		send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
+	scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
+			   &task->signal->cred_guard_mutex) {
 
-	spin_lock(&task->sighand->siglock);
+		scoped_guard (task_lock, task) {
+			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+			if (retval)
+				return retval;
+		}
+
+		scoped_guard (write_lock, &tasklist_lock) {
+			if (unlikely(task->exit_state))
+				return -EPERM;
+			if (task->ptrace)
+				return -EPERM;
+
+			task->ptrace = flags;
+
+			ptrace_link(task, current);
+
+			/* SEIZE doesn't trap tracee on attach */
+			if (!seize)
+				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
 
-	/*
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
-	 */
-	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
-		task->jobctl &= ~JOBCTL_STOPPED;
-		signal_wake_up_state(task, __TASK_STOPPED);
+			ptrace_set_stopped(task);
+		}
 	}
 
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
+	/*
+	 * We do not bother to change retval or clear JOBCTL_TRAPPING
+	 * if wait_on_bit() was interrupted by SIGKILL. The tracer will
+	 * not return to user-mode, it will exit and clear this bit in
+	 * __ptrace_unlink() if it wasn't already cleared by the tracee;
+	 * and until then nobody can ptrace this task.
+	 */
+	wait_on_bit(&task->jobctl, JOBCTL_TRAPPING_BIT, TASK_KILLABLE);
+	proc_ptrace_connector(task, PTRACE_ATTACH);
 
-	return retval;
+	return 0;
 }
 
 /**


