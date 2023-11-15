Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB867ECB04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKOTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjKOTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:11:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4912C;
        Wed, 15 Nov 2023 11:11:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A301CC433C9;
        Wed, 15 Nov 2023 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700075492;
        bh=+Lz3UclCdi8Chr5LH8Nj8EvSuzzxtIfVUkXPRBwTd6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQn+FuTYTgFeL/Jp2HT/7etsJiu/0YXKTPBfYyT+ArYrZBFdVGim0VLPpDkf1ko1N
         mzl28sS02q6k/mtc2tPIg5aX1tgtN/R57kWY5lQMNSQCK62ScVpE6U7WzzvhQ/uU1B
         Lg+EkucCzz2n+K1xmmX0tQVp9myVLE77/picPzOTfM+hTrUdgzAoK3X095ttdUi4O7
         iWYrJZC7wGDSxk0N6ardAWFMRq4bopnZAGrxGcZ6VfqNtzFjMJ9KnsnE9WWtPcUJh3
         ENZ62N3OORYIDxARdyAqFOYIeb3cLU6RspyuMopq5l8ZCk+9cqvSheS8NR06VcE+F5
         QReAOZ2SlRG1A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/3] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
Date:   Wed, 15 Nov 2023 14:11:26 -0500
Message-ID: <20231115191128.15615-2-frederic@kernel.org>
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

The variable name jiffies_till_flush is too generic and therefore:

* It may shadow a global variable
* It doesn't tell on what it operates

Make the name more precise, along with the related APIs.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h       |  8 ++++----
 kernel/rcu/rcuscale.c  |  6 +++---
 kernel/rcu/tree_nocb.h | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b531c33e9545..ff41423cd61c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -541,11 +541,11 @@ enum rcutorture_type {
 };
 
 #if defined(CONFIG_RCU_LAZY)
-unsigned long rcu_lazy_get_jiffies_till_flush(void);
-void rcu_lazy_set_jiffies_till_flush(unsigned long j);
+unsigned long rcu_get_jiffies_lazy_flush(void);
+void rcu_set_jiffies_lazy_flush(unsigned long j);
 #else
-static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
-static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
+static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
+static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
 #if defined(CONFIG_TREE_RCU)
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ffdb30495e3c..8db4fedaaa1e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -764,9 +764,9 @@ kfree_scale_init(void)
 
 	if (kfree_by_call_rcu) {
 		/* do a test to check the timeout. */
-		orig_jif = rcu_lazy_get_jiffies_till_flush();
+		orig_jif = rcu_get_jiffies_lazy_flush();
 
-		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_set_jiffies_lazy_flush(2 * HZ);
 		rcu_barrier();
 
 		jif_start = jiffies;
@@ -775,7 +775,7 @@ kfree_scale_init(void)
 
 		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
 
-		rcu_lazy_set_jiffies_till_flush(orig_jif);
+		rcu_set_jiffies_lazy_flush(orig_jif);
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4efbf7333d4e..aecef51166c7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -256,6 +256,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
 }
 
+#ifdef CONFIG_RCU_LAZY
 /*
  * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
  * can elapse before lazy callbacks are flushed. Lazy callbacks
@@ -264,21 +265,20 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
  * left unsubmitted to RCU after those many jiffies.
  */
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
-static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+static unsigned long jiffies_lazy_flush = LAZY_FLUSH_JIFFIES;
 
-#ifdef CONFIG_RCU_LAZY
 // To be called only from test code.
-void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
+void rcu_set_jiffies_lazy_flush(unsigned long jif)
 {
-	jiffies_till_flush = jif;
+	jiffies_lazy_flush = jif;
 }
-EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
+EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);
 
-unsigned long rcu_lazy_get_jiffies_till_flush(void)
+unsigned long rcu_get_jiffies_lazy_flush(void)
 {
-	return jiffies_till_flush;
+	return jiffies_lazy_flush;
 }
-EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
+EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);
 #endif
 
 /*
@@ -299,7 +299,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 */
 	if (waketype == RCU_NOCB_WAKE_LAZY &&
 	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
+		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
@@ -482,7 +482,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// flush ->nocb_bypass to ->cblist.
 	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||
+	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()))) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
@@ -723,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
 		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + rcu_get_jiffies_lazy_flush()) ||
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-- 
2.42.1

