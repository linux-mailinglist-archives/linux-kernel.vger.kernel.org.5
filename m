Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037FC79CE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjILKeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjILKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBA1721;
        Tue, 12 Sep 2023 03:28:59 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:28:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xW3uHBe4EVpDKpMR5ruXEoKnvBzEJaz6nuKa3rYSCWg=;
        b=az9gPPXGEbv1gWAxMo78KFFQ3SfVir2dhFukdfKaukFaIIH+2VnWfjn5vmU75JLAsSn2Wj
        lUPD0onwBDpoOU90Htxwp4VPvfei3eI/hB16WhjVOR9tZKnrGWQchq8GMzFGWx47Wc5M4l
        kOEVw2wXatFGivt8ZoPJgVLfWzQKHO8ipe/3lGcG26zDvTkGhyVyvV3JSd+n1cf6pxLE9J
        B9l9F3WYULv6a1ifhb+Y2irWUol7OxOYmPqi78W6jgubHlbQeIg926XBjGXq3HsOAAxZxH
        0lJudRwu7gZeDnup93/MJuJ/rQG1rdaM9PnGsIcotM8UeAMGm+DKy0oMC5llVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xW3uHBe4EVpDKpMR5ruXEoKnvBzEJaz6nuKa3rYSCWg=;
        b=lsaYGDpRqK1pfiMNTzqsqcg11HkI+NyeweBPeibkFurL8AQCLnomb/SH21E4tdP7itUbO+
        6WwXMCXc0NEznsAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_move_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451453771.27769.16417895756640508965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3840155df4460200584624c7ce71be8e9c9d4f6a
Gitweb:        https://git.kernel.org/tip/3840155df4460200584624c7ce71be8e9c9d4f6a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:41:09 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:17 +02:00

sched: Simplify sched_move_task()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index acaab2d..bcae6e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10438,17 +10438,18 @@ void sched_move_task(struct task_struct *tsk)
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
 
@@ -10473,9 +10474,6 @@ void sched_move_task(struct task_struct *tsk)
 		 */
 		resched_curr(rq);
 	}
-
-unlock:
-	task_rq_unlock(rq, tsk, &rf);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
