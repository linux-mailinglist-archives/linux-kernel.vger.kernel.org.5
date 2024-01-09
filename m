Return-Path: <linux-kernel+bounces-21472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E801C828FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8D283692
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06723EA6C;
	Tue,  9 Jan 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYxyiNPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904C3E499;
	Tue,  9 Jan 2024 22:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16ADC43394;
	Tue,  9 Jan 2024 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704839056;
	bh=7G6zMOBlrDBrz9IFrxxD1LvMGu57Oi45V5z6uSEnxiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYxyiNPtWbIoYE9pwkV4RYD6SmcHZMyJUWHEKhbMfcNfLUFd4lOBhLi+dVwmFq3NB
	 jB12yA9WYekWi0BaJKW3GgppBEpsWOli+NDzLWrO27ef35XypOoANF7alTuMNVcblw
	 4EkErYPnSAVjA/SSdvxGXXPtwbX6lQDqikqPDDe7Fin/REZIIFkvUf+NtvvknCMYvH
	 R4ids+fOckanL17PCX1NEK00uJRcKdXhfrXSpcJNJmxS7b7+mvpxZZMcPd80olEagW
	 VqHH3Yai1Tk57E88NcOuPxPHy1xiNug6ct64kAta8ELHW7xycD5f+jTa4aurhV/tqy
	 tJxCT8UuRoKVA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/2] rcu/nocb: Re-arrange call_rcu() NOCB specific code
Date: Tue,  9 Jan 2024 23:24:01 +0100
Message-ID: <20240109222401.28961-3-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109222401.28961-1-frederic@kernel.org>
References: <20240109222401.28961-1-frederic@kernel.org>
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
2.43.0


