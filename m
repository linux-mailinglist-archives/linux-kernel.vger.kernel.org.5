Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC27EBF15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjKOJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjKOJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B73116;
        Wed, 15 Nov 2023 01:04:53 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mlon6AwPHxVWtOHq+SjY0eqO1xvbsxVV2KDAHNP7Pug=;
        b=AExkQ2pv7rQrX77yRmDfFgE3AvkyylIjpzVJPRMvJqRSypUZVfE7m74QYkMZXRrwRySm06
        Gjnxhv6k3F3Xbtw4o1Usw2E8wG5xUpE8hhVt0aXV1nn+0jpRLHlM2Fc418wl6CWUut6pPU
        7wyJCf61EwN3KzqpF3z5VrbjogtuvllPsrs7ruOB6jkSO9LuZcDlSm4KOMbdNqa8OrZdwH
        ab852syms72b4Rt7sxYnZyij0gCjTSaXVhlXhQAoCOtsZTL1dCXawFrIlRMfJwpeUOdXZT
        NS7r90cQnaQO3Q2RytlNRUE4hg/68HzGky1svG3mG4nv5zuOcvXF+mN1reRH5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mlon6AwPHxVWtOHq+SjY0eqO1xvbsxVV2KDAHNP7Pug=;
        b=Oc36iJmKjsJPDHJUbqyMtGffkotCD5D4d8bfPM0cJH52Dd5D5nXZdauVMKIGqM5Rz0fbdf
        KVvtCXNxGk0Lx8BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Unify more update_curr*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170003909188.391.12820719385957897531.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c708a4dc5ab547edc3d6537233ca9e79ea30ce47
Gitweb:        https://git.kernel.org/tip/c708a4dc5ab547edc3d6537233ca9e79ea30ce47
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 06 Nov 2023 14:04:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:49 +01:00

sched: Unify more update_curr*()

Now that trace_sched_stat_runtime() no longer takes a vruntime
argument, the task specific bits are identical between
update_curr_common() and update_curr().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33db70c..1cd92b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1126,6 +1126,13 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	return delta_exec;
 }
 
+static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
+{
+	trace_sched_stat_runtime(p, delta_exec);
+	account_group_exec_runtime(p, delta_exec);
+	cgroup_account_cputime(p, delta_exec);
+}
+
 /*
  * Used by other classes to account runtime.
  */
@@ -1135,12 +1142,8 @@ s64 update_curr_common(struct rq *rq)
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
-	if (unlikely(delta_exec <= 0))
-		return delta_exec;
-
-	trace_sched_stat_runtime(curr, delta_exec);
-	account_group_exec_runtime(curr, delta_exec);
-	cgroup_account_cputime(curr, delta_exec);
+	if (likely(delta_exec > 0))
+		update_curr_task(curr, delta_exec);
 
 	return delta_exec;
 }
@@ -1164,13 +1167,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr)) {
-		struct task_struct *curtask = task_of(curr);
-
-		trace_sched_stat_runtime(curtask, delta_exec);
-		cgroup_account_cputime(curtask, delta_exec);
-		account_group_exec_runtime(curtask, delta_exec);
-	}
+	if (entity_is_task(curr))
+		update_curr_task(task_of(curr), delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
