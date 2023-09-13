Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FBA79E8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbjIMNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbjIMNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995619B4;
        Wed, 13 Sep 2023 06:11:13 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6SEKQAKI17rOlG36fSIZP4oQp/6j7GYXmu+VY5njL/E=;
        b=Rpge5bezC6ApMrOqp8olKPNvBLXWHdxTafs7vE6woi06tNG73zwdRTamJBQJalBgKjSJ4+
        XiHDcAz+cXeycbvS8KN/GTgDTW0WxfQyZR2V8B3qHMG57ztNcMW5w4KVzIGX5PpRUk4gx8
        Q6tMskjdGmxJmEgEOI/fO0uui7mICn3P0cSb/ZkgRhkA0s/cL2QoNdKUAWcwpBckWv6Fb0
        B2fkBEcBxSxFKjynhEnyjf7MbXOcZ8EGjOa2A+WoX0PPtW9xnxKr39Ex+XyYQVn4VypPi+
        z3zQr6j4nwDjmDx/4DJo0UN1Vrk1rfsRc/YNppMJ8cdJcXFbH84xFTmWyM4RBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6SEKQAKI17rOlG36fSIZP4oQp/6j7GYXmu+VY5njL/E=;
        b=lUcdwMyhxHvEpQzezgAU0AG7a/4usUVaCnNc0TiaMhWCBaBWdG2UZmq5k2QWrvlom5/fv7
        xOWjMwuSOjPXzDAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_move_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067118.27769.14953901261043740127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fa614b4feb5a246474ac71b45e520a8ddefc809c
Gitweb:        https://git.kernel.org/tip/fa614b4feb5a246474ac71b45e520a8ddefc809c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:41:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:38 +02:00

sched: Simplify sched_move_task()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d298176..a3f4fb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10437,17 +10437,18 @@ void sched_move_task(struct task_struct *tsk)
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct task_group *group;
-	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(tsk, &rf);
+	CLASS(task_rq_lock, rq_guard)(tsk);
+	rq = rq_guard.rq;
+
 	/*
 	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
 	 * group changes.
 	 */
 	group = sched_get_task_group(tsk);
 	if (group == tsk->sched_task_group)
-		goto unlock;
+		return;
 
 	update_rq_clock(rq);
 
@@ -10472,9 +10473,6 @@ void sched_move_task(struct task_struct *tsk)
 		 */
 		resched_curr(rq);
 	}
-
-unlock:
-	task_rq_unlock(rq, tsk, &rf);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
