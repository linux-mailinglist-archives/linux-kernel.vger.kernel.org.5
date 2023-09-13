Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261DB79E8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbjIMNL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbjIMNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADADA19B4;
        Wed, 13 Sep 2023 06:11:13 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XNT5aV5paLg1iK4+47E6rr7mjK+RF8y6ODrB8EBjWdI=;
        b=M7sPWgqUI0hVrNqiUhkvhaTJoH6vtD5TTZiKcowuWCXWq10XC1Qm4ZgyMqe9SRFkDgfTSs
        m84px/iTUXA9ZaPDUaqQGgxiN2fQM8THkawIDM3Mxmb+hNkVElCoY2LFbd1T5Lwtmz+tjs
        Pf5JxNptbvwaNQW9b9QgOBQDuNdaTir7cUmzzxVDcxiTUQq285GsLZ/F8Z8xYITRSog3kg
        XFwyUTrZiEMNrVY43pg1KjLUScOAKaFoK60eV3NR0mSsuHRK1yrTPZg2cTMswMRQWucuwg
        I6BZ+RMmTRek9Iu6vLVg6bxQe1TuupApRBXxvV0nVMnZeRyYQyaZS7YrOonuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XNT5aV5paLg1iK4+47E6rr7mjK+RF8y6ODrB8EBjWdI=;
        b=SW+iMqWr2rDi5NerpslOi+y8Ypp1SFU6moh2lfgHSCLdqlOU9CiCe07OSuMIl6QZa576Yu
        nJFYSsDqBYJZ4ZBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_rr_get_interval()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067174.27769.5481930955867667911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af7c5763f5e8bc1b3f827354a283ccaf6a8c8098
Gitweb:        https://git.kernel.org/tip/af7c5763f5e8bc1b3f827354a283ccaf6a8c8098
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:59:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:33 +02:00

sched: Simplify sched_rr_get_interval()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c8c40a..d298176 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9030,38 +9030,30 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 
 static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 {
-	struct task_struct *p;
-	unsigned int time_slice;
-	struct rq_flags rf;
-	struct rq *rq;
+	unsigned int time_slice = 0;
 	int retval;
 
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
+	scoped_guard (rcu) {
+		struct task_struct *p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	rq = task_rq_lock(p, &rf);
-	time_slice = 0;
-	if (p->sched_class->get_rr_interval)
-		time_slice = p->sched_class->get_rr_interval(rq, p);
-	task_rq_unlock(rq, p, &rf);
+		scoped_guard (task_rq_lock, p) {
+			struct rq *rq = scope.rq;
+			if (p->sched_class->get_rr_interval)
+				time_slice = p->sched_class->get_rr_interval(rq, p);
+		}
+	}
 
-	rcu_read_unlock();
 	jiffies_to_timespec64(time_slice, t);
 	return 0;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 /**
