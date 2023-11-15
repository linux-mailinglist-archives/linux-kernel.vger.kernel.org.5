Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702D47EBF02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjKOJEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D97114;
        Wed, 15 Nov 2023 01:04:51 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYjLZIFHPeTFyFVUPt8LdW6UDKPYrmKzL1aYRxJ9lag=;
        b=k2XIrqJcyOecy+XDLqmYRNxz8R9ToP9FIE3uwjWHkz59xOLSyRnMUegm545/Y3Ue/9P2ZY
        xJieYiH2QPUWAVtecvxwgrc1beI3Mi82Ly5XF07c1l3eHio5ub2fxFhK5Zxg7+nqz8wvrD
        BW24r7rD0+kG0m4y7OaliOfwUWjxjPOoOeEa6YC7rFKUP9bpgFqD+MEG45qE/cX4VNpX3f
        BZlIE/1AnwElZ4IdjdQ5TKN+QBosealVu4aUESGWOKi5HK4MLmqzfQ9bfdN9YYpH9qMEnx
        GEqwPmcYHXyLqePiRhB5nNeO21hj3YQBqL0zP48rtM1TbvexhaYJoFwcfgVctQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYjLZIFHPeTFyFVUPt8LdW6UDKPYrmKzL1aYRxJ9lag=;
        b=P5g4iQT6hQpHBN46BHO93rPBv62BQNKu2znlmcBNHyCsM9bJqzr9MTnMe2DrajRuUz8RgR
        MYRxbvhR5Z1uLdBw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/timers: Explain why idle task schedules out
 on remote timer enqueue
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231114193840.4041-3-frederic@kernel.org>
References: <20231114193840.4041-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <170003908811.391.7438992731780383646.tip-bot2@tip-bot2>
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

Commit-ID:     194600008d5c43b5a4ba98c4b81633397e34ffad
Gitweb:        https://git.kernel.org/tip/194600008d5c43b5a4ba98c4b81633397e34ffad
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 14 Nov 2023 14:38:40 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:52 +01:00

sched/timers: Explain why idle task schedules out on remote timer enqueue

Trying to avoid that didn't bring much value after testing, add comment
about this.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lkml.kernel.org/r/20231114193840.4041-3-frederic@kernel.org
---
 kernel/sched/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5f4495..2de77a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1131,6 +1131,28 @@ static void wake_up_idle_cpu(int cpu)
 	if (cpu == smp_processor_id())
 		return;
 
+	/*
+	 * Set TIF_NEED_RESCHED and send an IPI if in the non-polling
+	 * part of the idle loop. This forces an exit from the idle loop
+	 * and a round trip to schedule(). Now this could be optimized
+	 * because a simple new idle loop iteration is enough to
+	 * re-evaluate the next tick. Provided some re-ordering of tick
+	 * nohz functions that would need to follow TIF_NR_POLLING
+	 * clearing:
+	 *
+	 * - On most archs, a simple fetch_or on ti::flags with a
+	 *   "0" value would be enough to know if an IPI needs to be sent.
+	 *
+	 * - x86 needs to perform a last need_resched() check between
+	 *   monitor and mwait which doesn't take timers into account.
+	 *   There a dedicated TIF_TIMER flag would be required to
+	 *   fetch_or here and be checked along with TIF_NEED_RESCHED
+	 *   before mwait().
+	 *
+	 * However, remote timer enqueue is not such a frequent event
+	 * and testing of the above solutions didn't appear to report
+	 * much benefits.
+	 */
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);
 	else
