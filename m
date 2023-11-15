Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3257ECB06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjKOTLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjKOTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:11:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE2FA;
        Wed, 15 Nov 2023 11:11:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CFCC433CA;
        Wed, 15 Nov 2023 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700075494;
        bh=+CwFhpZFJagUYR6sRV+zAT+zjPxnRMlVxvZF4rtuuss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRqQ355MpVkvPG4Din2KnuRYnR/dMc2x1hGi2P6G7B+yVZ2hOFIBMQ4lM3iTqMSXE
         RJW6mwFeShgda59qG3xg/J3BomgtT4vSBO/ZEL6/FvYY9DK8HUDM/cfcJSEyWOh6CG
         Hoputu2RO/KdslIEI5HYGubKKLr3tPFbzt4Z+qYBkob18Fma8mEn+Rnwt3viklXZio
         zA1ZVP9AwOV/D2JIpJ4fMqNutCtaEcFYOSFVe5NubGQfEJGZpCqMWTZOxMSFmK09Kk
         svMEGvysR9VqV2n68d/M+7+Jdwhh4ahR3lfOpoAfGM2IMbsEBbJsyNoYMoSHaJKnYz
         YhIHx16iU/LBQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/3] rcu/nocb: Remove needless full barrier after callback advancing
Date:   Wed, 15 Nov 2023 14:11:28 -0500
Message-ID: <20231115191128.15615-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191128.15615-1-frederic@kernel.org>
References: <20231115191128.15615-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A full barrier is issued from nocb_gp_wait() upon callbacks advancing
to order grace period completion with callbacks execution.

However these two events are already ordered by the
smp_mb__after_unlock_lock() barrier within the call to
raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
happen.

The following litmus test shows the kind of guarantee that this barrier
provides:

	C smp_mb__after_unlock_lock

	{}

	// rcu_gp_cleanup()
	P0(spinlock_t *rnp_lock, int *gpnum)
	{
		// Grace period cleanup increase gp sequence number
		spin_lock(rnp_lock);
		WRITE_ONCE(*gpnum, 1);
		spin_unlock(rnp_lock);
	}

	// nocb_gp_wait()
	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
	{
		int r1;

		// Call rcu_advance_cbs() from nocb_gp_wait()
		spin_lock(nocb_lock);
		spin_lock(rnp_lock);
		smp_mb__after_unlock_lock();
		r1 = READ_ONCE(*gpnum);
		WRITE_ONCE(*cb_ready, 1);
		spin_unlock(rnp_lock);
		spin_unlock(nocb_lock);
	}

	// nocb_cb_wait()
	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
	{
		int r2;

		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
		spin_lock(nocb_lock);
		r2 = READ_ONCE(*cb_ready);
		spin_unlock(nocb_lock);

		// Actual callback execution
		WRITE_ONCE(*cb_executed, 1);
	}

	P3(int *cb_executed, int *gpnum)
	{
		int r3;

		WRITE_ONCE(*cb_executed, 2);
		smp_mb();
		r3 = READ_ONCE(*gpnum);
	}

	exists (1:r1=1 /\ 2:r2=1 /\ cb_executed=2 /\ 3:r3=0) (* Bad outcome. *)

Here the bad outcome only occurs if the smp_mb__after_unlock_lock() is
removed. This barrier orders the grace period completion against
callbacks advancing and even later callbacks invocation, thanks to the
opportunistic propagation via the ->nocb_lock to nocb_cb_wait().

Therefore the smp_mb() placed after callbacks advancing can be safely
removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 6 ++++++
 kernel/rcu/tree_nocb.h | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ac3c846105f..c557302fc4f5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2113,6 +2113,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * Extract the list of ready callbacks, disabling IRQs to prevent
 	 * races with call_rcu() from interrupt handlers.  Leave the
 	 * callback counts, as rcu_barrier() needs to be conservative.
+	 *
+	 * Callbacks execution is fully ordered against preceding grace period
+	 * completion (materialized by rnp->gp_seq update) thanks to the
+	 * smp_mb__after_unlock_lock() upon node locking required for callbacks
+	 * advancing. In NOCB mode this ordering is then further relayed through
+	 * the nocb locking that protects both callbacks advancing and extraction.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eb27878d46f1..d82f96a66600 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -779,7 +779,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;
 			WRITE_ONCE(rdp->nocb_cb_sleep, false);
-			smp_mb(); /* CB invocation -after- GP end. */
 		} else {
 			needwake = false;
 		}
-- 
2.42.1

