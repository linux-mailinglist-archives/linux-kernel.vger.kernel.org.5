Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F47EB6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKNTix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjKNTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:38:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF210D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:38:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219ACC433C7;
        Tue, 14 Nov 2023 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699990727;
        bh=TiiyIUwqEqNWx33Q4JpkMzZZTKBz7XGXy64YGa5f2BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJCok1LbgCXsmVwz+wvwuwA+GtIUohmHHu9CjSL0aGZe6xFbQwsvWhCAEvG5pOHZm
         +g6RREpNN+IcN3bU0RHg1S9tWVOtmP9QQ5SVqJp0PDEmjhgrh+1haH4b1LrXE9j05r
         PWwDMvHiOdJ1BSJhpqg/ixBHCGfQ606CufxQ7BD95I/Kk35lkIwP03b4qb0/0KAWgy
         5luM9/GwumxshVaRAwlLHDglSTj3JtEKby3SnUHdYAiy2LSZS/0gtMellSmYlCUWvk
         cLYSbvN6TDMB8b+uy0TFtvInwWUCkxH9Th3iV179IeDBc27MztCMriYsHTN0uC0SG/
         0hIl//2IHIw0Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] sched/timers: Explain why idle task schedules out on remote timer enqueue
Date:   Tue, 14 Nov 2023 14:38:40 -0500
Message-ID: <20231114193840.4041-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114193840.4041-1-frederic@kernel.org>
References: <20231114193840.4041-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to avoid that didn't bring much value after testing, add comment
about this.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..50abc7eddb82 100644
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
-- 
2.42.1

