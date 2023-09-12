Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F379CE67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjILKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjILKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A31724;
        Tue, 12 Sep 2023 03:29:01 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rC7fJ3unKfH5ys7/EHhA1f5zHs+G6x74lKhYIE8XIZg=;
        b=ph2MQdU/nZ53WVCV6Gw2CLJ/0ppDu3jr6Rdn3a6FL+4WkmfvVcIeQeowSPWJ8MU87LOdm+
        SrhF4EMfKyQXsxPVWoA5KyYZy8jGkL6SjvlbscGJGYZpd5a/C0pCYnhNFcQ344T8IyerDj
        G7U6EqMEgH80Wu+k0MDICa9pM+59u+TeLNfaLZGAviqTKOWks9JGF2syAAMWHeKfN2G4Tv
        Eeu97Qt2eIa+oYiqqZsa16udmdzyE0N2y2+TVPAIYIacX8OtH7lb8l2bEzyYHVmbh/DCl8
        zSTv/j+Bu0idPONo4bIqWRaIC8C8EHWIM8kZbb+umyyKp3E2jMhdtGjYcKO1jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rC7fJ3unKfH5ys7/EHhA1f5zHs+G6x74lKhYIE8XIZg=;
        b=BwOZw6w/gmfTtyAdLKh29jVgroF6pFmP8XUHGA4+BO7pVHi9w1Qp4c2k9vt+s6srrTZJvq
        d+91SW7tukwAV+CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_{set,get}affinity()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451453926.27769.12507870986222267887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d2064a0466d38e7e312aecf815cef01b5f342ad9
Gitweb:        https://git.kernel.org/tip/d2064a0466d38e7e312aecf815cef01b5f342ad9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:57:35 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:15 +02:00

sched: Simplify sched_{set,get}affinity()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 53 +++++++++++---------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db5cf31..a9b9fa9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8348,39 +8348,24 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	struct affinity_context ac;
 	struct cpumask *user_mask;
-	struct task_struct *p;
 	int retval;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
+	CLASS(find_get_task, p)(pid);
+	if (!p)
 		return -ESRCH;
-	}
-
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
 
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			retval = -EPERM;
-			goto out_put_task;
-		}
-		rcu_read_unlock();
+		guard(rcu)();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-		goto out_put_task;
+		return retval;
 
 	/*
 	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
@@ -8390,8 +8375,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
 	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+		return -ENOMEM;
 	}
 
 	ac = (struct affinity_context){
@@ -8403,8 +8387,6 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
-out_put_task:
-	put_task_struct(p);
 	return retval;
 }
 
@@ -8446,28 +8428,21 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
-	unsigned long flags;
 	int retval;
 
-	rcu_read_lock();
-
-	retval = -ESRCH;
+	guard(rcu)();
 	p = find_process_by_pid(pid);
 	if (!p)
-		goto out_unlock;
+		return -ESRCH;
 
 	retval = security_task_getscheduler(p);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	guard(raw_spinlock_irqsave)(&p->pi_lock);
 	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-out_unlock:
-	rcu_read_unlock();
-
-	return retval;
+	return 0;
 }
 
 /**
