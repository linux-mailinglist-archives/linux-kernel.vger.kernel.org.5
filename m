Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD179E8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbjIMNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbjIMNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1019B4;
        Wed, 13 Sep 2023 06:11:15 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUs7WdOriEo9kPeOZfOtmRkfjUH0ChX7TsnM4I+wkEY=;
        b=kREmJ4NrhnAOmWvyWNNl67+OOZ0ulNA73yp3MBmNptT2J0RNdmhvWFmkCHwy+iKm0urSKK
        VkZjepgHLR8IHHTDoJj+wAK45PdPlkkECs4bYUE0iUi91b3qXvG5Wzos/7dh+hlJQe79D8
        QPbppYgTdF9WULKeKyQVfxaMyRalRM2TmFsyxovFS4Svxmij4g022bzAGdoPazuaWHrYhI
        WLhvhAnNoily2F683bh4ko78gTovVTWNW2+p0YhwiabkT6EdfZfxTh/JWx2SEfSbziQt8d
        bbEPWx1G+JmXzHZwS6SejjEOBXqVim+ussdT9VHh5s1+xnqv3EDdcghsDsKH3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JUs7WdOriEo9kPeOZfOtmRkfjUH0ChX7TsnM4I+wkEY=;
        b=w/KA1mlHq4MddaIe1ay5K1KzGHpIu7Qg+6VrF67j3yFNVqWPEsApfrwNXx3PQDGf1OneW4
        RBtOZ7BstsQT8SAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_{set,get}affinity()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067276.27769.13650151079752562005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     92c2ec5bc1081e6bbbe172bcfb1a566ad7b4f809
Gitweb:        https://git.kernel.org/tip/92c2ec5bc1081e6bbbe172bcfb1a566ad7b4f809
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:57:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:24 +02:00

sched: Simplify sched_{set,get}affinity()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 53 +++++++++++---------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67c32c4..1d5cbb3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8347,39 +8347,24 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
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
@@ -8389,8 +8374,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
 	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+		return -ENOMEM;
 	}
 
 	ac = (struct affinity_context){
@@ -8402,8 +8386,6 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
-out_put_task:
-	put_task_struct(p);
 	return retval;
 }
 
@@ -8445,28 +8427,21 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
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
