Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEB7A42FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjIRHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjIRHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:40:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341F170E;
        Mon, 18 Sep 2023 00:38:14 -0700 (PDT)
Date:   Mon, 18 Sep 2023 06:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695022692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qvDfBkQCd44w6tZnHtxeHXhGITJN6OtsLGSgzCBimoE=;
        b=1hjUvyZGt661iLpkU8nVLVvhkN0+CtXrlUOgp+TGeNRhvfs6FH9BoDP+ZI8h4mWilZ3YWT
        wejHs0Dq1kuQVzTQuEP11jTvotcKpHG6phrJEMQdwpxCrPGi1kCnqHw25S0M4UKHaPkK8O
        BR4t5Fxl4wPIvYeVbuBgbpfWbsj1V8op/Kg3ekndZb+AH44opwyJ4Bzj1MXAuanWw+i7bQ
        RFv3BhZV6yyrNQ1pfKWgc99PBnWNvn1cYhrK7yc/d8iq72S/6YK6xh0CR0YrmAMyFt1IFc
        EKG5+hfZdEfAcAGDi2+rlaUQQiM7F4/OO/4KLL0F4kbiJB+eE5UHE5naLFGgPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695022692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qvDfBkQCd44w6tZnHtxeHXhGITJN6OtsLGSgzCBimoE=;
        b=y5eCebUHPtKs6F+4Sw/I09Tu2Jxcc04RuTK51uPYUJzoR/+r8IQr6LMo27P6/WuPraF1hY
        4d93qFqerFr7A2BA==
From:   "tip-bot2 for Elliot Berman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove ifdeffery for saved_state
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169501808389.27769.10252810804131112374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fbaa6a181a4b1886cbf4214abdf9a2df68471510
Gitweb:        https://git.kernel.org/tip/fbaa6a181a4b1886cbf4214abdf9a2df68471510
Author:        Elliot Berman <quic_eberman@quicinc.com>
AuthorDate:    Fri, 08 Sep 2023 15:49:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 08:13:57 +02:00

sched/core: Remove ifdeffery for saved_state

In preparation for freezer to also use saved_state, remove the
CONFIG_PREEMPT_RT compilation guard around saved_state.

On the arm64 platform I tested which did not have CONFIG_PREEMPT_RT,
there was no statistically significant deviation by applying this patch.

Test methodology:

perf bench sched message -g 40 -l 40

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
