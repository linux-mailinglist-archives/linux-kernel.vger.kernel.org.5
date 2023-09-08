Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5248799107
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbjIHUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIHUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69601B2;
        Fri,  8 Sep 2023 13:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E9C433CC;
        Fri,  8 Sep 2023 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205378;
        bh=Zu1FseTcB8ucaQhbROvFuH9zDir/2M+hapV0YqGSd20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce3J97XH0oLc7QOib+7DQ/wHo3Jhw1lL1t8k3AbgKGJ/Yb61Sjq+agUCLWVvGPJm5
         Ccc8O2a2Kn+X4nH9CL9PvG/sZTKgC87JXPjazn0+nobFMOuJ4e/nxG4/ZRoGXbhmUc
         gXmofbYu25ZhA50QS964E7BRuGe1vMmHX8TTA7JJsRDd8GzFafPWMUF90WVflxyhQZ
         ayMv51DVu1PkhwW9PbuOOnukUxvb+UAy0JiDhwTZCfp1oc9U/XdeQEjBt1ktM0qdlz
         rIfip7CC6D4LsLLV+tczwSUW2yZnPzAjUvc/6EX9JcejTY/K0zUf3f3l8jGnmHSraw
         myNgxLgUlj2xg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 02/10] rcu: Rename jiffies_till_flush to jiffies_lazy_flush
Date:   Fri,  8 Sep 2023 22:35:55 +0200
Message-ID: <20230908203603.5865-3-frederic@kernel.org>
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

The variable name jiffies_till_flush is too generic and therefore:

* It may shadow a global variable
* It doesn't tell on what it operates

Make the name more precise, along with the related APIs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h       |  8 ++++----
 kernel/rcu/rcuscale.c  |  6 +++---
 kernel/rcu/tree_nocb.h | 20 ++++++++++----------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 56a8466a11a2..4ac4daae9917 100644
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
index 5598212d1f27..b9eab359c597 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -264,21 +264,21 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
  * left unsubmitted to RCU after those many jiffies.
  */
 #define LAZY_FLUSH_JIFFIES (10 * HZ)
-static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+static unsigned long jiffies_lazy_flush = LAZY_FLUSH_JIFFIES;
 
 #ifdef CONFIG_RCU_LAZY
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
+		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_lazy_flush);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
@@ -482,7 +482,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// flush ->nocb_bypass to ->cblist.
 	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    (ncbs &&  bypass_is_lazy &&
-	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||
+	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush))) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
@@ -723,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		lazy_ncbs = READ_ONCE(rdp->lazy_len);
 
 		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) ||
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-- 
2.41.0

