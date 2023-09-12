Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74E79CE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjILKes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjILKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC41725;
        Tue, 12 Sep 2023 03:29:01 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3lniy9RHFHDgNU4IAgj+N5WJjtPDH+gdHMfCR4IQ0jk=;
        b=bA70bpA80puu27xAY0qMf2pVjiUpMNYCcbkFonZKIqOeYrrjKyhqt8RqGAWMzSr5Go6NQy
        L0zUxO+3iXsCZz73A0cHEUnw+QFUh6f+AoQrnbTYqJ9xnh9BcuM3wAPa+QomBKLOUVeqcR
        o5ozJ5FeNMfJmI/4n/fxvZK3Lp/pR/g2cXAJTLmob6Y6AM7fsS4Ee/3XWM7Ih7HN5W5H2w
        HN83SiKK/5nGMIMj50xEvm2hggiDff3uFCPFvqm4EF4Pebi1B4KFezStaePtcRu912iZ0n
        IY8LgaYXgdrwtJWqhQJY2uIMd3cZu9Fz/te6Wm2IkXvVdEOTV8op0zuzZPY++A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3lniy9RHFHDgNU4IAgj+N5WJjtPDH+gdHMfCR4IQ0jk=;
        b=GfY990YDghAYmE7tRrwmqOOwf7No7rLvxRWwsD9u0GAX3laH2cP1r7kSeOh6mg87n5NovR
        uCUTjapi3+WWaNCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify syscalls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451453981.27769.8515070820878025008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c7084435ca61e76b8464fa05d7cb62766212bf6c
Gitweb:        https://git.kernel.org/tip/c7084435ca61e76b8464fa05d7cb62766212bf6c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:54:54 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:14 +02:00

sched: Simplify syscalls

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 154 ++++++++++++++++++-------------------------
 1 file changed, 68 insertions(+), 86 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e4d8b7a..db5cf31 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7507,6 +7507,21 @@ static struct task_struct *find_process_by_pid(pid_t pid)
 	return pid ? find_task_by_vpid(pid) : current;
 }
 
+static struct task_struct *find_get_task(pid_t pid)
+{
+	struct task_struct *p;
+	guard(rcu)();
+
+	p = find_process_by_pid(pid);
+	if (likely(p))
+		get_task_struct(p);
+
+	return p;
+}
+
+DEFINE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
+	     find_get_task(pid), pid_t pid)
+
 /*
  * sched_setparam() passes in -1 for its policy, to let the functions
  * it calls know not to change it.
@@ -7544,14 +7559,11 @@ static void __setscheduler_params(struct task_struct *p,
 static bool check_same_owner(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred;
-	bool match;
+	guard(rcu)();
 
-	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
-	rcu_read_unlock();
-	return match;
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
 }
 
 /*
@@ -7963,27 +7975,17 @@ static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
 	struct sched_param lparam;
-	struct task_struct *p;
-	int retval;
 
 	if (!param || pid < 0)
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
-
-	if (likely(p)) {
-		retval = sched_setscheduler(p, policy, &lparam);
-		put_task_struct(p);
-	}
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
 
-	return retval;
+	return sched_setscheduler(p, policy, &lparam);
 }
 
 /*
@@ -8079,7 +8081,6 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 			       unsigned int, flags)
 {
 	struct sched_attr attr;
-	struct task_struct *p;
 	int retval;
 
 	if (!uattr || pid < 0 || flags)
@@ -8094,21 +8095,14 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
 		attr.sched_policy = SETPARAM_POLICY;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
 
-	if (likely(p)) {
-		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-			get_params(p, &attr);
-		retval = sched_setattr(p, &attr);
-		put_task_struct(p);
-	}
+	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		get_params(p, &attr);
 
-	return retval;
+	return sched_setattr(p, &attr);
 }
 
 /**
@@ -8126,16 +8120,17 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
+	guard(rcu)();
 	p = find_process_by_pid(pid);
-	if (p) {
-		retval = security_task_getscheduler(p);
-		if (!retval)
-			retval = p->policy
-				| (p->sched_reset_on_fork ? SCHED_RESET_ON_FORK : 0);
+	if (!p)
+		return -ESRCH;
+
+	retval = security_task_getscheduler(p);
+	if (!retval) {
+		retval = p->policy;
+		if (p->sched_reset_on_fork)
+			retval |= SCHED_RESET_ON_FORK;
 	}
-	rcu_read_unlock();
 	return retval;
 }
 
@@ -8156,30 +8151,23 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 	if (!param || pid < 0)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	if (task_has_rt_policy(p))
-		lp.sched_priority = p->rt_priority;
-	rcu_read_unlock();
+		if (task_has_rt_policy(p))
+			lp.sched_priority = p->rt_priority;
+	}
 
 	/*
 	 * This one might sleep, we cannot do it with a spinlock held ...
 	 */
-	retval = copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
-
-	return retval;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
+	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
 }
 
 /*
@@ -8239,39 +8227,33 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	    usize < SCHED_ATTR_SIZE_VER0 || flags)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	kattr.sched_policy = p->policy;
-	if (p->sched_reset_on_fork)
-		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-	get_params(p, &kattr);
-	kattr.sched_flags &= SCHED_FLAG_ALL;
+		kattr.sched_policy = p->policy;
+		if (p->sched_reset_on_fork)
+			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		get_params(p, &kattr);
+		kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/*
-	 * This could race with another potential updater, but this is fine
-	 * because it'll correctly read the old or the new value. We don't need
-	 * to guarantee who wins the race as long as it doesn't return garbage.
-	 */
-	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+		/*
+		 * This could race with another potential updater, but this is fine
+		 * because it'll correctly read the old or the new value. We don't need
+		 * to guarantee who wins the race as long as it doesn't return garbage.
+		 */
+		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
-
-	rcu_read_unlock();
+	}
 
 	return sched_attr_copy_to_user(uattr, &kattr, usize);
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 #ifdef CONFIG_SMP
