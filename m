Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A97C8533
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjJMMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjJML76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC0BF0;
        Fri, 13 Oct 2023 04:59:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC6C433CC;
        Fri, 13 Oct 2023 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198383;
        bh=Jc8jfSDSYlcGNx7gh6POnFvbeLKzhx7hBRosliLbEyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Num1RS1S+VHmhSvhhfUQFeinEqmcgTGDJDAIaONbq3FPkAFHzwUwOuvjJy8og4CQ7
         q81UTKTc6Nx18Ce5vhFTky4BySoGMXuBiiOhVrWipiajLoRtu3GN77cXBFdCzpwRi9
         ZCZV6NqAsS/oSBzFeZcgZ6nYtwfbmLl4YejSqQjzoBod3Xz2ogScl+ge2Ez2Zprbys
         elgAwJhY4FsXsi+9tjsMokcVAg+z8c7hmo0tBd9ZwIX6b6Pfb4OIxQEelAeQBKeCeG
         7pX4k7yEGk+3ZFDOYAWJKTn3Lro4s6k26vfj3sC3tm4MeGLIQ/76JO8ktlnQjjIeFj
         vLl+KJdpcDdzg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 12/18] rcu: Assume IRQS disabled from rcu_report_dead()
Date:   Fri, 13 Oct 2023 13:58:56 +0200
Message-Id: <20231013115902.1059735-13-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_report_dead() is the last RCU word from the CPU down through the
hotplug path. It is called in the idle loop right before the CPU shuts
down for good. Because it removes the CPU from the grace period state
machine and reports an ultimate quiescent state if necessary, no further
use of RCU is allowed. Therefore it is expected that IRQs are disabled
upon calling this function and are not to be re-enabled again until the
CPU shuts down.

Remove the IRQs disablement from that function and verify instead that
it is actually called with IRQs disabled as it is expected at that
special point in the idle path.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4dd7df30df31..8c2954502e55 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4562,11 +4562,16 @@ void rcu_cpu_starting(unsigned int cpu)
  */
 void rcu_report_dead(unsigned int cpu)
 {
-	unsigned long flags, seq_flags;
+	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	/*
+	 * IRQS must be disabled from now on and until the CPU dies, or an interrupt
+	 * may introduce a new READ-side while it is actually off the QS masks.
+	 */
+	lockdep_assert_irqs_disabled();
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
@@ -4574,7 +4579,6 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	local_irq_save(seq_flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4588,8 +4592,6 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-	local_irq_restore(seq_flags);
-
 	rdp->cpu_started = false;
 }
 
-- 
2.34.1

