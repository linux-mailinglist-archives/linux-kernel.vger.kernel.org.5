Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1780AF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574849AbjLHWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574872AbjLHWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:05:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2210E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:05:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B5AC433CA;
        Fri,  8 Dec 2023 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073158;
        bh=qpg9fNbGNVyk64uMzemypMgJeLqksx8712MtUIEzckQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM2juQ6EmRrOhvmyxHcXE3u2bwlmf2LzZdDUGrE5xSqLOVXm54u1x1In7oUrGl6oT
         c9G0m8dOHtHGQDbm0FUaYZQp8gANhIj15K6wJzxHBiCj4kYxvfHGQZA66ALO4rfqdf
         XXD8u+yq8Wd4uuahIMkSI8AZPHQHzP3sfI0wHaW8ne8VD7r7rvFqPITcqs1NCsnpe9
         z4Sy9vQjMsCAyZqrPaor5wHUA4J6uduTMXEACDNVy7qYIBIdUD7evm9w5PMFuk4EaX
         ry/xrNwEj7c0JQgnfWcEE5EeJ0TS+Z0aDZx/OtcVjhH8XevhLnsXLacLB02Tv/YCVM
         9/P2mxaJgYV/Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/8] rcu/nocb: Re-arrange call_rcu() NOCB specific code
Date:   Fri,  8 Dec 2023 23:05:39 +0100
Message-ID: <20231208220545.7452-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently the call_rcu() function interleaves NOCB and !NOCB enqueue
code in a complicated way such that:

* The bypass enqueue code may or may not have enqueued and may or may
  not have locked the ->nocb_lock. Everything that follows is in a
  Schrödinger locking state for the unwary reviewer's eyes.

* The was_alldone is always set but only used in NOCB related code.

* The NOCB wake up is distantly related to the locking hopefully
  performed by the bypass enqueue code that did not enqueue on the
  bypass list.

Unconfuse the whole and gather NOCB and !NOCB specific enqueue code to
their own functions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 44 +++++++++++++++++++-----------------------
 kernel/rcu/tree.h      |  5 ++---
 kernel/rcu/tree_nocb.h | 18 ++++++++++++++---
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74159c6d3bdf..82f8130d3fe3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2559,12 +2559,26 @@ static int __init rcu_spawn_core_kthreads(void)
 	return 0;
 }
 
+static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_callback_t func)
+{
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+	if (__is_kvfree_rcu_offset((unsigned long)func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
+					 (unsigned long)func,
+					 rcu_segcblist_n_cbs(&rdp->cblist));
+	else
+		trace_rcu_callback(rcu_state.name, head,
+				   rcu_segcblist_n_cbs(&rdp->cblist));
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+}
+
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
-static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
-			    unsigned long flags)
+static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags)
 {
+	rcutree_enqueue(rdp, head, func);
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -2660,7 +2674,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
-	bool was_alldone;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2697,28 +2710,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
-		local_irq_restore(flags);
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	}
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
+
+	if (unlikely(rcu_rdp_is_offloaded(rdp)))
+		call_rcu_nocb(rdp, head, func, flags, lazy);
 	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
-
-	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
-
-	/* Go handle any RCU core processing required. */
-	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
-		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-	} else {
-		__call_rcu_core(rdp, head, flags);
-	}
+		call_rcu_core(rdp, head, func, flags);
 	local_irq_restore(flags);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..e0e70b663cbf 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -467,9 +467,8 @@ static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
-static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags,
-				bool lazy);
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3f70fd0a2db4..868063621c2f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -622,6 +622,18 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 }
 
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy)
+{
+	bool was_alldone;
+
+	if (!rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
+		/* Not enqueued on bypass but locked, do regular enqueue */
+		rcutree_enqueue(rdp, head, func);
+		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
+	}
+}
+
 static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 			       bool *wake_state)
 {
@@ -1765,10 +1777,10 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	return true;
 }
 
-static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags, bool lazy)
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy)
 {
-	return false;
+	WARN_ON_ONCE(1);  /* Should be dead code! */
 }
 
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
-- 
2.42.1

