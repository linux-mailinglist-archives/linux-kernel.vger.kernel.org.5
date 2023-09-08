Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006A79910A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjIHUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbjIHUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A012B;
        Fri,  8 Sep 2023 13:36:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BFAC433CB;
        Fri,  8 Sep 2023 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205385;
        bh=jDNkBDS/qfTFPfcD21qgFaMBxLKgVcToMO54awbM3I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPpmn/DmCtFxr+xOeItYC9TcDzjbNDWMr9tkF5K68mh93CaOUVS5q+SXn34MRwg9p
         GJjYK8PJkQIAboGENjtWkb7uQcNgNSgj45hYcaFXtwRD3k3VO2CB4bwW6QvcPlHZfk
         tMhmVecVYjMgKebTkthKhWjWVslirLZDQlzxQP5vyJdoQZOcge6ViG7K0ZZ0ZDF25T
         u/J7PusNlWTRFA4XibyAsebL4M5iBbucAdfutwlqOmPIh9dR3okAfeyi0m2tMon0be
         IAun0m6SUAEBCBgT9QvIOzRCIrTjBkwuTjBU4tj+WZlB+Slygkaefigt4U7PvOjgNH
         6KuRh5JvkTvlg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/10] rcu: Assume IRQS disabled from rcu_report_dead()
Date:   Fri,  8 Sep 2023 22:35:58 +0200
Message-ID: <20230908203603.5865-6-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a83ecab77917..8b5ebef32e17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4553,11 +4553,16 @@ void rcu_cpu_starting(unsigned int cpu)
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
 
@@ -4565,7 +4570,6 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	local_irq_save(seq_flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4579,8 +4583,6 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-	local_irq_restore(seq_flags);
-
 	rdp->cpu_started = false;
 }
 
-- 
2.41.0

