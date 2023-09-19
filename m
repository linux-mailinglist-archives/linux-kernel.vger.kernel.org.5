Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB087A6423
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjISNAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjISNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F321E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BozJv5idKi9bmko/HVsGkv1+WMyzjICmyGBkY5AALuk=; b=kqfpO2c8+R+eLuXkcQqqtt8SUp
        v5cNI3ZMIxagJXChqMgDI4/IfFFj7lBg1Iph6oBXKbw10/KvVR5nwA5FAG2MZ7SFZ6XgtglgKb3Wh
        9RlNAKssJLV0F7p6HlxOVflZ2hcuewV+oAl0tYdcOXVgoqs2LYd8u6YshWRDlrhPKz6L8zj/+T33f
        u9lGsYb0ilkdGOHVPCTPeQI4inCOs/tPJSlA0JReoIgAR1/M9QmprcnLsjjjcYeQR4JH0C3SiTDrG
        cu/J02JQ5W1UmTWOy1DyIUIFd1KjpjhYnYyC+oBZjTajhZDe9e+3/T3GD/Jxc4qjC50V8GCC0IPRu
        esORkomQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiaKY-00HJen-Pe; Tue, 19 Sep 2023 12:59:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E565300585; Tue, 19 Sep 2023 14:59:54 +0200 (CEST)
Date:   Tue, 19 Sep 2023 14:59:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230919125954.GB39346@noisy.programming.kicks-ass.net>
References: <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
 <20230915221332.GC23174@noisy.programming.kicks-ass.net>
 <20230919125752.GA39346@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919125752.GA39346@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:57:52PM +0200, Peter Zijlstra wrote:
> On Sat, Sep 16, 2023 at 12:13:32AM +0200, Peter Zijlstra wrote:
> 
> > I think I can make it work, I'll go have a play, but perhaps not now,
> > it's past midnight ;-)
> 
> So I have been playing about with this a bit and it keeps falling short
> of 'nice' :/
> 
> What I ended up with is the below. The simple scoped_guard () extension
> is useful, albeit slightly awkward (I'll reply with another patch making
> use of it). But the basic problem is that it will have to have the form:

---
Index: linux-2.6/include/linux/sched/task.h
===================================================================
--- linux-2.6.orig/include/linux/sched/task.h
+++ linux-2.6/include/linux/sched/task.h
@@ -226,4 +226,6 @@ static inline void task_unlock(struct ta
 	spin_unlock(&p->alloc_lock);
 }
 
+DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
+
 #endif /* _LINUX_SCHED_TASK_H */
Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
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
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c
+++ linux-2.6/kernel/ptrace.c
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
@@ -414,88 +442,58 @@ static int ptrace_attach(struct task_str
 
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
+	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {
 
-	spin_lock(&task->sighand->siglock);
+		scoped_guard (task_lock, task) {
+			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+			if (retval)
+				return retval;
+		}
 
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
-	}
+		scoped_guard (write_lock, &tasklist_lock) {
+			if (unlikely(task->exit_state))
+				return -EPERM;
+			if (task->ptrace)
+				return -EPERM;
 
-	spin_unlock(&task->sighand->siglock);
+			task->ptrace = flags;
 
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
+			ptrace_link(task, current);
+
+			/* SEIZE doesn't trap tracee on attach */
+			if (!seize)
+				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
+
+			ptrace_set_stopped(task);
+
+		}
+
+		goto success;
 	}
+	return -ERESTARTNOINTR;
 
-	return retval;
+success:
+	/*
+	 * We do not bother to change retval or clear JOBCTL_TRAPPING
+	 * if wait_on_bit() was interrupted by SIGKILL. The tracer will
+	 * not return to user-mode, it will exit and clear this bit in
+	 * __ptrace_unlink() if it wasn't already cleared by the tracee;
+	 * and until then nobody can ptrace this task.
+	 */
+	wait_on_bit(&task->jobctl, JOBCTL_TRAPPING_BIT, TASK_KILLABLE);
+	proc_ptrace_connector(task, PTRACE_ATTACH);
+
+	return 0;
 }
 
 /**
