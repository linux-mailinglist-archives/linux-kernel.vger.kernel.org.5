Return-Path: <linux-kernel+bounces-5320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C7B81895C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F84FB23898
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872D1BDE0;
	Tue, 19 Dec 2023 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU0dz90e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DA1BDC4;
	Tue, 19 Dec 2023 14:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B556C433C8;
	Tue, 19 Dec 2023 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702994934;
	bh=sHJt3IsM3iUK3gN9HVpHb6yt/cnAOvUK8korBBbdabk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TU0dz90eOUJ5pXT+op/xqPwl8wMUEWPhe3EEKoJVXmaTf6aU6j8FzRm2buDs1LnTS
	 to3P9wsEdl2nGt7Ac4IAlg4ijbNaa8ZBEqUTL2DyN5UDpO99MtQ1hY3lO5AnB7K5nP
	 e045XJ6RYl9RG+dhJbpoySi+OIOzSPTGvnlLZEUadzKm8hqDJ49859GLAvjM+NZ+3a
	 4yMAhPieON9jT1YU4YjjMSIOxytI5yp3tZEgyjHfpk0FxnDF6tWPhhosmQGvuJnPdk
	 hDd7X8Gi5rVAtFG0Jvwaq83LvCVDKjHz0wShdBMJ/sZBcQjq4BaNiHxeXZJEjLzWOa
	 mQSbf3rvwwljw==
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
	Hillf Danton <hdanton@sina.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH 1/8] rcu/nocb: Make IRQs disablement symmetric
Date: Tue, 19 Dec 2023 15:08:36 +0100
Message-Id: <20231219140843.939329-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219140843.939329-1-frederic@kernel.org>
References: <20231219140843.939329-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently IRQs are disabled on call_rcu() and then depending on the
context:

* If the CPU is in nocb mode:

   - If the callback is enqueued in the bypass list, IRQs are re-enabled
     implictly by rcu_nocb_try_bypass()

   - If the callback is enqueued in the normal list, IRQs are re-enabled
     implicitly by __call_rcu_nocb_wake()

* If the CPU is NOT in nocb mode, IRQs are reenabled explicitly from call_rcu()

This makes the code a bit hard to follow, especially as it interleaves
with nocb locking.

To make the IRQ flags coverage clearer and also in order to prepare for
moving all the nocb enqueue code to its own function, always re-enable
the IRQ flags explicitly from call_rcu().

Reviewed-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      |  9 ++++++---
 kernel/rcu/tree_nocb.h | 20 +++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 499803234176..91b2eb772e86 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2735,8 +2735,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy)) {
+		local_irq_restore(flags);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
@@ -2754,8 +2756,8 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
-		local_irq_restore(flags);
 	}
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -4651,8 +4653,9 @@ void rcutree_migrate_callbacks(int cpu)
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
 		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
-		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
+		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 	}
+	local_irq_restore(flags);
 	if (needwake)
 		rcu_gp_kthread_wake();
 	lockdep_assert_irqs_enabled();
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d82f96a66600..06c8ff85850c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -532,9 +532,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// 2. Both of these conditions are met:
 	//    a. The bypass list previously had only lazy CBs, and:
 	//    b. The new CB is non-lazy.
-	if (ncbs && (!bypass_is_lazy || lazy)) {
-		local_irq_restore(flags);
-	} else {
+	if (!ncbs || (bypass_is_lazy && !lazy)) {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
 		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
@@ -544,7 +542,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 		}
 	}
 	return true; // Callback already enqueued.
@@ -570,7 +568,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
 		return;
@@ -583,17 +581,17 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		rdp->qlen_last_fqs_check = len;
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
@@ -611,15 +609,15 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
 		    !timer_pending(&rdp->nocb_timer)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
 		} else {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
+			rcu_nocb_unlock(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		}
 	} else {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_nocb_unlock(rdp);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 }
-- 
2.34.1


