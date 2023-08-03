Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172D76EEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbjHCP7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjHCP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48403115;
        Thu,  3 Aug 2023 08:59:18 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QOYYpFCjIgnStr2qW66eWt25QWHWyNJ2vYvVd9dQEZU=;
        b=JcWL/HMT4G1Gg5ivm/Dz8DXVPBBZ5j3u/KlspYkdOpZssvu+6WGe4rAAlw6czGDmSm67py
        ukkCs7qRT9/ttMKN8CWp5RjHzG3n7RHKsFLgTOIxxi3mqI2l+cTTDo2WaCIs66jQfXtNSo
        Y3K7iHVtcoTTwZslvjCdsyHFffsUh53ClfE1MaAdP+C0UAQ2zfE35kQk9DTdRKLcf82EKg
        c6JNq2+7nggSlIZJht664Z8UO7P4hV/U0ZNZffj/+T9qkV4z/uWOjDTxu3HEA3FohLQOZ9
        0iJ4stJF6axqBr/rumSEmnCow3kcquj8uUlnOo7IxUme5G1hvmI/VQLi5ARgXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QOYYpFCjIgnStr2qW66eWt25QWHWyNJ2vYvVd9dQEZU=;
        b=Ir6WTfyub+vLdjLBsOY8fUze0fW1fRj98VNIR2aiKqNZqN10pVw8zlX9HEIvBq4ALXIZG5
        +j3B1IZhoZBSRoCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Revert "sched/fair: Move unused stub functions to header"
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169107835534.28540.16435626638250235806.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     22dc02f81cddd19528fc1d4fbd7404defbf736c5
Gitweb:        https://git.kernel.org/tip/22dc02f81cddd19528fc1d4fbd7404defbf736c5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Jul 2023 21:30:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 31 Jul 2023 11:47:08 +02:00

Revert "sched/fair: Move unused stub functions to header"

Revert commit 7aa55f2a5902 ("sched/fair: Move unused stub functions to
header"), for while it has the right Changelog, the actual patch
content a revert of the previous 4 patches:

  f7df852ad6db ("sched: Make task_vruntime_update() prototype visible")
  c0bdfd72fbfb ("sched/fair: Hide unused init_cfs_bandwidth() stub")
  378be384e01f ("sched: Add schedule_user() declaration")
  d55ebae3f312 ("sched: Hide unused sched_update_scaling()")

So in effect this is a revert of a revert and re-applies those
patches.

Fixes: 7aa55f2a5902 ("sched/fair: Move unused stub functions to header")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be..695f8e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-
+#ifdef CONFIG_SMP
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -702,6 +702,7 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
+#endif
 
 /*
  * delta /= w
@@ -6186,9 +6187,8 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006..44b540a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1245,6 +1245,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 			bool fi);
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
@@ -2398,6 +2399,7 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 #endif
 
 extern void schedule_idle(void);
+asmlinkage void schedule_user(void);
 
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
