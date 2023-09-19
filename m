Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AA7A6C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjISURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:16:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4CBA;
        Tue, 19 Sep 2023 13:16:53 -0700 (PDT)
Date:   Tue, 19 Sep 2023 20:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695154611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vo0w5BZLCpHR/xC2Am5PL8qbWTO2IfzenEEO4d906mw=;
        b=wIt1s6lab2692tECwEvCdTDKqaqNdAUzheElMYHkpiDByarVyjvWLMmv6N2FGvlQJ9IqpJ
        5dXcTyA3iyoAhoqvb8ApTOTtLW6286PVL23M3CQ60NpSoXHBGQg8Wd+MOGuKHNLkvs6EVf
        NwbR18HhNwtB92jZrrZpqmVfj8M3RHPlO36HARcNUQyKAF649Q1yMcAH1ncUBcRHK7k7L0
        9d2wTwZkq1qspxXEaU9Pp5bf9NVw45FtTx7ztrPqFwMWjt34yYup1P/+Ym91G5jHTzo9qh
        0XX7lq4poXt7KTV+MLmrhBwG2c+Q9vpAwwJq5SE500X7tZJx3dp/S0oKftl/Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695154611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vo0w5BZLCpHR/xC2Am5PL8qbWTO2IfzenEEO4d906mw=;
        b=74s1o/ZeyDjMMaVjV7BO/X9q0fFUHlA6Gxmdm1Os5bgbWU2dh0UTikCRhf/v/revjeElkX
        vj1z5SLmjWOf+DDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] signal: Add a proper comment about preempt_disable()
 in ptrace_stop()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803100932.325870-2-bigeasy@linutronix.de>
References: <20230803100932.325870-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169515461116.27769.12932058744920773528.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/core branch of tip:

Commit-ID:     a20d6f63dbfc176697886d7709312ad0a795648e
Gitweb:        https://git.kernel.org/tip/a20d6f63dbfc176697886d7709312ad0a795648e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 03 Aug 2023 12:09:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 Sep 2023 22:08:29 +02:00

signal: Add a proper comment about preempt_disable() in ptrace_stop()

Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
between read_unlock() and the following schedule() invocation without
explaining why it is needed.

Replace the existing contentless comment with a proper explanation to
clarify that it is not needed for correctness but for performance reasons.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20230803100932.325870-2-bigeasy@linutronix.de

---
 kernel/signal.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 0901901..3035beb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2329,10 +2329,22 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 		do_notify_parent_cldstop(current, false, why);
 
 	/*
-	 * Don't want to allow preemption here, because
-	 * sys_ptrace() needs this task to be inactive.
+	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
+	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * which will be fulfilled after read_unlock() and the ptracer will be
+	 * put on the CPU.
+	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
+	 * this task wait in schedule(). If this task gets preempted then it
+	 * remains enqueued on the runqueue. The ptracer will observe this and
+	 * then sleep for a delay of one HZ tick. In the meantime this task
+	 * gets scheduled, enters schedule() and will wait for the ptracer.
 	 *
-	 * XXX: implement read_unlock_no_resched().
+	 * This preemption point is not bad from a correctness point of
+	 * view but extends the runtime by one HZ tick time due to the
+	 * ptracer's sleep.  The preempt-disable section ensures that there
+	 * will be no preemption between unlock and schedule() and so
+	 * improving the performance since the ptracer will observe that
+	 * the tracee is scheduled out once it gets on the CPU.
 	 */
 	preempt_disable();
 	read_unlock(&tasklist_lock);
