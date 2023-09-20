Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008D7A744B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjITHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjITHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269789E;
        Wed, 20 Sep 2023 00:36:15 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYJlot/aScq95AA44zpJ6weT3yzT1qWlFyHFhFCVEfA=;
        b=x8s93U0T2L7PWWyTDvg4hWgUGwNgP6VBeNkNiXcd6EzRcgoIoZrUvCcZH0gLt6qvyQz+WJ
        sfSVWJqKu8erIDCZaFq9MnyyWu/3RZEwLOl/RBfoCsGV2KWEx6nG58x2yuDcfmHbUoXTHW
        S18g9jx8I/0z8zSyPjvWoFJ5ABZaPtiFom6tArBkWP0+e/FUiqraVUx0xTnOtE8gYwhouN
        E3I38TJBKKGsqGDa5zHLuEOZQVEyjlxj6O1F+yjZvC/pta/40EIfbxBPkpJy/G6HC0yKk1
        s6g6kNMk5V/7AlZ8LIHGFR01ny8glqMilDy46xszUGvFst0Yy6X98mD5njghuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYJlot/aScq95AA44zpJ6weT3yzT1qWlFyHFhFCVEfA=;
        b=2RnDIHlsXSQgxucYyz0oCsLl7oMtDhuGxdBdagf0i9eGAZ/7/NmO+37cbYvcLB/vvtnjB2
        5tbAIIj+v6cBwcBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Constrain locks in sched_submit_work()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-2-bigeasy@linutronix.de>
References: <20230908162254.999499-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519537258.27769.828089056891859325.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     28bc55f654de49f6122c7475b01b5d5ef4bdf0d4
Gitweb:        https://git.kernel.org/tip/28bc55f654de49f6122c7475b01b5d5ef4bdf0d4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Sep 2023 18:22:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:11 +02:00

sched: Constrain locks in sched_submit_work()

Even though sched_submit_work() is ran from preemptible context,
it is discouraged to have it use blocking locks due to the recursion
potential.

Enforce this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-2-bigeasy@linutronix.de
---
 kernel/sched/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5c..d555640 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6720,11 +6720,18 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
 
 	if (task_is_running(tsk))
 		return;
 
+	/*
+	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
+	 * will use a blocking primitive -- which would lead to recursion.
+	 */
+	lock_map_acquire_try(&sched_map);
+
 	task_flags = tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
@@ -6749,6 +6756,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * make sure to submit it to avoid deadlocks.
 	 */
 	blk_flush_plug(tsk->plug, true);
+
+	lock_map_release(&sched_map);
 }
 
 static void sched_update_worker(struct task_struct *tsk)
