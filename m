Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6327D4AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjJXIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjJXIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C5128;
        Tue, 24 Oct 2023 01:52:29 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mc2ImTGynSFGgCS40b/9mff9y6G7SrJMB/hVyO1Y/0=;
        b=yNs2o+s7Q1vyhVddEyHUUTuzpl/CtVi1bapzZqwPgm4o/tpIaElFfDhgexdKQy+Y3k3Knw
        g11mynAPTR4zs3PjA3Nms1cz97sHrNfoo0MxCeE/QuM5J3W3pFR8KYs1eiwNqV9uQoelkV
        LK0oIh96kmkVLtMhaVF14fLplkVN96nForL9eVaY3wuiRoUz9Fc2I4d+vKJ0Zpmm9yMi+F
        fUuCrOu++JNQD1L8ucvrfRg3v/TClJmuMh8LnL1WaVpVJFYGpStdL3RD4mvWFKszDDOC4D
        kxLg/1W3NiITvYXfIXb0BH61/xJcmQGAEVBa3LrWsOgqVG3ujy18SOAdiV9tNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mc2ImTGynSFGgCS40b/9mff9y6G7SrJMB/hVyO1Y/0=;
        b=LkCkGGNMjmk2f1j/fJUdiiZy/WMpB6+Zi/YMpSjbCAlEYVGplMmZ/PnkcLvrvyyY5hAX7d
        0MX6QZa2iZMgnwCQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix RQCF_ACT_SKIP leak
Cc:     Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Hao Jia <jiahao.os@bytedance.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
MIME-Version: 1.0
Message-ID: <169813754711.3135.4535193844351356313.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5ebde09d91707a4a9bec1e3d213e3c12ffde348f
Gitweb:        https://git.kernel.org/tip/5ebde09d91707a4a9bec1e3d213e3c12ffde348f
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Thu, 12 Oct 2023 17:00:03 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Oct 2023 10:38:42 +02:00

sched/core: Fix RQCF_ACT_SKIP leak

Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.

This warning may be triggered in the following situations:

    CPU0                                      CPU1

__schedule()
  *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
  pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
    newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
      rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
      raw_spin_rq_unlock(this_rq)
                                      rq_lock(*CPU0_rq*, &rf)
                                      rq_clock_start_loop_update()
                                      rq->clock_update_flags & RQCF_ACT_SKIP <--
      raw_spin_rq_lock(this_rq)

The purpose of RQCF_ACT_SKIP is to skip the update rq clock,
but the update is very early in __schedule(), but we clear
RQCF_*_SKIP very late, causing it to span that gap above
and triggering this warning.

In __schedule() we can clear the RQCF_*_SKIP flag immediately
after update_rq_clock() to avoid this RQCF_ACT_SKIP leak warning.
And set rq->clock_update_flags to RQCF_UPDATED to avoid
rq->clock_update_flags < RQCF_ACT_SKIP warning that may be triggered later.

Fixes: ebb83d84e49b ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
Closes: https://lore.kernel.org/all/20230913082424.73252-1-jiahao.os@bytedance.com
Reported-by: Igor Raits <igor.raits@gmail.com>
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 264c2eb..dc724f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5361,8 +5361,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
-	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
@@ -6600,6 +6598,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
+	rq->clock_update_flags = RQCF_UPDATED;
 
 	switch_count = &prev->nivcsw;
 
@@ -6679,8 +6678,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
