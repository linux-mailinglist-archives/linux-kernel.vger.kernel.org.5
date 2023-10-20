Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44D7D0A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376484AbjJTICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbjJTICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:02:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC6D64;
        Fri, 20 Oct 2023 01:02:03 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:02:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697788921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVM/DO9hPX/HC+aIcLv1OaWWQdOPuPcK8XTJEhv9K68=;
        b=YQgefFkcxhKEHvHDQmIVENrY61IH4mKpcdpRizRCQh0YE7mZvYHsD1+GMY2jiW74XTBtSh
        rcG4U2OzRF39XRFZ0JpBn2TcHGdPSfyYwnhhpC3q6OSqsxl8Le2EaI65OvN7/fhWx/HQ36
        tFZCBrLpRX2LF0OwSNz04fv3g0L01aTFmQcaIB0RfGSmmXGycklW/URGZ0JMGbWhWdWsHb
        3mf6hJsxnXm7K3/6YF5OAnBppJOvn/2wE2yz8W/+9ps3Fe9FT1AKs2yJu1HZCGVklYm79S
        Q1MrOVGZPywkDSJGpuGpvLRy81GkjeTzpWk9/FF7M3RshAcqR4wt4J2Eq8uK6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697788921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVM/DO9hPX/HC+aIcLv1OaWWQdOPuPcK8XTJEhv9K68=;
        b=ZKC5qXTgpwPVZYH0yhV207Ek01UWQhWPo+gIDne8YD5Kl+HwHJOwuskO0R3408p8RNi2zs
        JYzkBPIaa3DeD9CA==
From:   "tip-bot2 for Vineeth Pillai (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Update ->next_balance correctly during
 newidle balance
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231020014031.919742-3-joel@joelfernandes.org>
References: <20231020014031.919742-3-joel@joelfernandes.org>
MIME-Version: 1.0
Message-ID: <169778892069.3135.14832410141983613183.tip-bot2@tip-bot2>
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

Commit-ID:     1c0482707c42960ec46b88aadd6bffca8685db11
Gitweb:        https://git.kernel.org/tip/1c0482707c42960ec46b88aadd6bffca8685db11
Author:        Vineeth Pillai (Google) <vineeth@bitbyteword.org>
AuthorDate:    Fri, 20 Oct 2023 01:40:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 09:56:21 +02:00

sched/fair: Update ->next_balance correctly during newidle balance

When newidle balancing triggers, we see that it constantly clobbers
rq->next_balance even when there is no newidle balance happening due to
the cost estimates.  Due to this, we see that periodic load balance
(rebalance_domains) may trigger way more often when the CPU is going in
and out of idle at a high rate but is no really idle. Repeatedly
triggering load balance there is a bad idea as it is a heavy operation.
It also causes increases in softirq.

Another issue is ->last_balance is not updated after newidle balance
causing mistakes in the ->next_balance calculations.

Fix by updating last_balance when a newidle load balance actually
happens and then updating next_balance. This is also how it is done in
other load balance paths.

Testing shows a significant drop in softirqs when running:

  $ cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q

... goes from ~6,000 to ~800.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20231020014031.919742-3-joel@joelfernandes.org
---
 kernel/sched/fair.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c486ff..393d0dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12122,11 +12122,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
-
-		if (sd)
-			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();
@@ -12141,8 +12137,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
-		update_next_balance(sd, &next_balance);
-
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
 
@@ -12155,6 +12149,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
 			update_newidle_cost(sd, domain_cost);
+			sd->last_balance = jiffies;
+			update_next_balance(sd, &next_balance);
 
 			curr_cost += domain_cost;
 			t0 = t1;
