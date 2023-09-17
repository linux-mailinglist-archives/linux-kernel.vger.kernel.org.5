Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2139A7A351B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjIQKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjIQKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:12:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DC197;
        Sun, 17 Sep 2023 03:12:10 -0700 (PDT)
Date:   Sun, 17 Sep 2023 10:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694945528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tVm7gmJMnGdDCZVKEuiJdX7a159lvd+qt6GKxewQjf0=;
        b=IBYMk0xTWKgxyi8TSjN+yS5E2ENVZ6cmek62kHknkR0yHBDWA7K8Fy1ooz2pqXYVnNjfUz
        Eo79UXzwNiBCwa3dQB01B8/gVTBnA9zH+j7w2GIDZspAxSrs2jte/QrwLbmc+T/CPyDuW8
        +RhC0YjBy6Pr7xjZHIOpoDA0TUkFSHIC73ZZdjfZBIQc5Bsr1fgPgBj+ezp4gLeETkYRfP
        lSgVbnDVHzODALqMFZ5WQ8yVt0ujHKiOUbZQhHtq8TmgmLth4zLru7QCMsoTCCW0UYDEFL
        JfALEcTQTXJ5poPQ6O2MR1STqyV4oDbTaEoGL3DK73J+M+eX8yrwebJrKI/7cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694945528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tVm7gmJMnGdDCZVKEuiJdX7a159lvd+qt6GKxewQjf0=;
        b=9MbrTzjcm9JM0yaw+mkJoRqkfDzAyYZLZZ6CIElaHVYukgUrc5GeSujOGiL5sRhaLKm8ea
        mmw47X3XK7dVAfDg==
From:   "tip-bot2 for Elliot Berman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove ifdeffery for saved_state
Cc:     Elliot Berman <quic_eberman@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169494552813.27769.7209596078545807501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fa14aa2c23d31eb39bc615feb920f28d32d2a87e
Gitweb:        https://git.kernel.org/tip/fa14aa2c23d31eb39bc615feb920f28d32d2a87e
Author:        Elliot Berman <quic_eberman@quicinc.com>
AuthorDate:    Fri, 08 Sep 2023 15:49:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 16 Sep 2023 11:16:01 +02:00

sched/core: Remove ifdeffery for saved_state

In preparation for freezer to also use saved_state, remove the
CONFIG_PREEMPT_RT compilation guard around saved_state.

On the arm64 platform I tested which did not have CONFIG_PREEMPT_RT,
there was no statistically significant deviation by applying this patch.

Test methodology:

perf bench sched message -g 40 -l 40

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/sched.h | 2 --
 kernel/sched/core.c   | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac..dc37ae7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -750,10 +750,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
 	/* saved state for "spinlock sleepers" */
 	unsigned int			saved_state;
-#endif
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f39482d..49541e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2232,23 +2232,20 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
-#endif
+
 	return 0;
 }
 
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
 	 * current_restore_rtlock_saved_state().
 	 */
 	guard(raw_spinlock_irq)(&p->pi_lock);
-#endif
 	return __task_state_match(p, state);
 }
 
@@ -4038,7 +4035,6 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
 	 * an RT lock.  If the state matches, set p::saved_state to
@@ -4054,7 +4050,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 */
 	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-#endif
+
 	return match > 0;
 }
 
