Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F079CE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjILKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjILKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1711722;
        Tue, 12 Sep 2023 03:29:00 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p5U7F6+T7pg7uOdMmZPiE6ZBW3x7QTJymrki28T32QQ=;
        b=LiWAbaLCaKztbVHAXXtIrokBdlQSJ9g88A4+EBclOMHitSGQkWGbbDdYKEP4/rIm8ZUm5a
        9VObRcRVi/AWtNI2baDmoV1DWECG3ZDtMTsC1AfV8i3QXm0mGAfhwZANSAYFYc0xCNnRxh
        lEuzqxIY0oIgEwa69pEJfvYfqZh/HnqiPAPevsHHXQwPv9SIKv5Iqhkouz12iG5OqX56B5
        3MfbKcRtmuOtAgp3RVmxTDASQIjNbBJnYnXOtglxMHXEw6bMAu8gW59VULemwXdoqz+Hku
        aee+0BaYxSMy5kNpkdTlZEUOK9WsYMLRgmlTDyL2LQNVUnFcTykHhDAk6CS+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p5U7F6+T7pg7uOdMmZPiE6ZBW3x7QTJymrki28T32QQ=;
        b=oS+deMDj8GYGBfvSqDmpUBsXUdIS8dxiZvYLbwkZRD/mruPyLYGtXAm0GhGovc9BVlPcgV
        tssYdvb+rdno8rBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_rr_get_interval()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451453824.27769.10199012591700147218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dc163158330c1bd1be33e54d37b09f10c0a8db07
Gitweb:        https://git.kernel.org/tip/dc163158330c1bd1be33e54d37b09f10c0a8db07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:59:05 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:16 +02:00

sched: Simplify sched_rr_get_interval()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e825839..acaab2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9031,38 +9031,30 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 
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
