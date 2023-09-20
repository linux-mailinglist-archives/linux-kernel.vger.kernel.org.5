Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982AC7A73E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjITHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjITHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:21:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEFEA;
        Wed, 20 Sep 2023 00:21:28 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695194486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/5KJNffF9+5nflASRQLuduWKw+t4/oBUSb/rEqjysqg=;
        b=1xKQidzeW6MhNkgGwAwtZ5RX3jdN/0tRQXxm3kdSllbVafx9VONnSefp7z7tOiF3/IBx6D
        NJAsYddi3LExxNaiblIKaQDEiV+/D/nhOjkkA5Hqo4YTlYrLQc/rk4P2QzBgMpOGmL0DZr
        53xwiCO6siqZQfUHOe1vsu5ZybVJYO6CMww1rEeT0QMRnTIe1QcFKBkLMJdFflm6Q7ua4U
        lqPsuugLWT+4WntDW3XhBk7wFBY1vvq8ogDnQE9opOwnml5yyWrwuGxHMO8rUFna18Alc4
        B4nXiGUiimGszdvrqVkZnXAmGsVP8gr5Lha/dVPVKK8+3Oxdcn/hk4ov4Z9B5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695194486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/5KJNffF9+5nflASRQLuduWKw+t4/oBUSb/rEqjysqg=;
        b=Nvy1+iSqfLSq1YVJ4N2EdBBk6V3JlS6LMtuTxHMYNxUqJMlf28gi4xkb29Q4eU94Y/xfYh
        AZ0ctaNY3r+SmgBw==
From:   "tip-bot2 for Liam R. Howlett" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] kernel/sched: Modify initial boot task idle setup
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169519448577.27769.8422721059198672038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cff9b2332ab762b7e0586c793c431a8f2ea4db04
Gitweb:        https://git.kernel.org/tip/cff9b2332ab762b7e0586c793c431a8f2ea4db04
Author:        Liam R. Howlett <Liam.Howlett@oracle.com>
AuthorDate:    Fri, 15 Sep 2023 13:44:44 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Sep 2023 10:48:04 +02:00

kernel/sched: Modify initial boot task idle setup

Initial booting is setting the task flag to idle (PF_IDLE) by the call
path sched_init() -> init_idle().  Having the task idle and calling
call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
set.  Subsequent calls to any cond_resched() will enable IRQs,
potentially earlier than the IRQ setup has completed.  Recent changes
have caused just this scenario and IRQs have been enabled early.

This causes a warning later in start_kernel() as interrupts are enabled
before they are fully set up.

Fix this issue by setting the PF_IDLE flag later in the boot sequence.

Although the boot task was marked as idle since (at least) d80e4fda576d,
I am not sure that it is wrong to do so.  The forced context-switch on
idle task was introduced in the tiny_rcu update, so I'm going to claim
this fixes 5f6130fa52ee.

Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
---
 kernel/sched/core.c | 2 +-
 kernel/sched/idle.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5c..802551e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a..5007b25 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
