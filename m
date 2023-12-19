Return-Path: <linux-kernel+bounces-5321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC881895D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E59B23547
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA71C2AE;
	Tue, 19 Dec 2023 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz1kXCx+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE81C288;
	Tue, 19 Dec 2023 14:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5316C433CB;
	Tue, 19 Dec 2023 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702994937;
	bh=olwBkjtGrRL01ZZOKkwKkXaT+AdbROyJJkm9WBCnDxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cz1kXCx+PVGHy6h7DoE7dFV9VjQLa4SUUh/RoNna9wzlDdzXgo2ElMrzsQhPLxdj8
	 8EJ+QA3WGkzVC/4bRNrBlQr1xRfZemU6rZ3tLMsEwe7vVMhBuc5gBR45krDoRWYRKn
	 gvG1D1uYkqvlQUPEurHAFArlruRmdmNYJwM/hL4A9KJowTZgKLGkTbCoTgxensAdzf
	 fm55xOjE4Cu7ugUr8jyvbAmsGbhZxywsxX/ok705ytok4cuR78tdYn7a13dwZ/ji4x
	 Yi1v2EJy8KAky13CJGUWRiNi2q3Iqo4FID+vvi2WRyE4aPPJ3hR6BM6u2rNQrrnIeA
	 8zESdy6n+tYtA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH 2/8] rcu/nocb: Re-arrange call_rcu() NOCB specific code
Date: Tue, 19 Dec 2023 15:08:37 +0100
Message-Id: <20231219140843.939329-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219140843.939329-1-frederic@kernel.org>
References: <20231219140843.939329-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 kernel/rcu/tree.h      |  9 ++++-----
 kernel/rcu/tree_nocb.h | 18 ++++++++++++++---
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 91b2eb772e86..de5796ce024f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2597,12 +2597,26 @@ static int __init rcu_spawn_core_kthreads(void)
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
@@ -2698,7 +2712,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
-	bool was_alldone;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2735,28 +2748,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
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
index e9821a8422db..bf478da89a8f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -467,11 +467,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
-static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags,
-				bool lazy);
-static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
-				 unsigned long flags);
+static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
+			  rcu_callback_t func, unsigned long flags, bool lazy);
+static void __maybe_unused __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+						unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 06c8ff85850c..5fd47ea6d20e 100644
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
@@ -1764,10 +1776,10 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
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
2.34.1


