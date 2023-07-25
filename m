Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7373762757
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGYX3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGYX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:44 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E981FC9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78374596182so307959339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327772; x=1690932572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DIiXFGh73Irk8k8jfSTlgn3pzuU9BPg/xYZpIge3SA=;
        b=devazoCc1ePSllifONKGQCl8V8kDvW5uvDEsIy/u3SDJfI/vz1wlFS0SUxKZdfqrcB
         NEV4tcQXSLdIR+lnufehU/yii4Le4bCblWZXsvn8b0MbCrfA5CbEFQh/KvLUcVyexJgD
         bAOucRRZCGzD+cJEPlkY3nJk/aUwJlJqC6WxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327772; x=1690932572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DIiXFGh73Irk8k8jfSTlgn3pzuU9BPg/xYZpIge3SA=;
        b=TqQKXbC151OYB6lHYeEu1+4y3EsVejkemOHuwCC5mXEzcVZsndUBOpeOnzlhmHgDr2
         pLpIavvBrnCJY2tIskgtpB3Qeaqr5HbpYPEP2mzrEPPxfrgLq/FjpZ96yNMhYk4LKKN+
         xLbCKv5lZBin2wradNaWt/9HneYW09VHTMInglmHITPRtOmXK54R9ajZ1hw+4wrDHjKk
         IcgW3Me+ORGjgdohGnkjECEkSnD1ETa7T7P4Bri0p90higfek48t9643+W+Y9tgolGH1
         fw/164n4f2Z3rHj0Y9PoKNKR6nHnusaldKubwxdISrJCLgyalkTgZmFwKeFrWO4Mkz9P
         mJTA==
X-Gm-Message-State: ABy/qLZizpOKLZvKZTd7YKhvigAb3GpfNo6qQ8On/kSuaVeGpFF+epO5
        ggA3xb0eBB/JyM+ctZbywGpJC4SdNmWVVtIoglU=
X-Google-Smtp-Source: APBJJlH9/vaRwB5vMSyP0PFSl3tgH3jguGqOapInYGQWm35VNrAOnNszvyRrx5BqXu6IQCKvacXg1g==
X-Received: by 2002:a05:6602:257a:b0:783:5fd9:3789 with SMTP id dj26-20020a056602257a00b007835fd93789mr367880iob.1.1690327772055;
        Tue, 25 Jul 2023 16:29:32 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc:     rcu@vger.kernel.org
Subject: [PATCH 4/5] tree/nocb: Improve readability of nocb_gp_wait()
Date:   Tue, 25 Jul 2023 23:29:09 +0000
Message-ID: <20230725232913.2981357-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nocb_gp_wait() function contains logic to check each rdp's bypass
list, flush if needed, and decide on wakeups. This makes the function
hard to follow.

Split out the bypass checking and flushing into a separate helper
nocb_gp_flush_wake(). The new function encapsulates the logic to:

- Check if the bypass needs to be flushed
- Flush if needed
- Return info on wakeups (lazy, bypass or none)

nocb_gp_wait() now becomes simpler by calling the helper to handle
the bypass flushing and waking logic.

This splitting improves the readability and maintainability of the
code by encapsulating related logic into a function with a clear
purpose.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 113 ++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 47 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..c805825c3f00 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -670,22 +670,68 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
 	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
 }
 
+/*
+ * Given an rdp, flush its bypass list if needed and return information about
+ * if a deferred-wakeup needs to be organized depending on whether things are
+ * still in the bypass list. Also tell caller if the list was flushed and if it
+ * is still empty after any flushing.
+ */
+static int nocb_gp_flush_wake(struct rcu_data *rdp, bool *empty, bool *flush)
+{
+	long bypass_ncbs;
+	long lazy_ncbs;
+	unsigned long j = jiffies;
+
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
+	lockdep_assert_held(&rdp->nocb_lock);
+	bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	lazy_ncbs = READ_ONCE(rdp->lazy_len);
+
+	*flush = false;
+	*empty = false;
+	if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
+	    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+	     bypass_ncbs > 2 * qhimark)) {
+		*flush = true;
+	} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
+			(time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
+			 bypass_ncbs > 2 * qhimark)) {
+		*flush = true;
+	} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+		*empty = true;
+		return RCU_NOCB_WAKE_NOT;
+	}
+
+	if (*flush) {
+		// Bypass full or old, so flush it.
+		(void)rcu_nocb_try_flush_bypass(rdp, j);
+		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+		lazy_ncbs = READ_ONCE(rdp->lazy_len);
+	}
+
+	if (bypass_ncbs) {
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+				    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
+		return (bypass_ncbs == lazy_ncbs ? RCU_NOCB_WAKE_LAZY :
+						   RCU_NOCB_WAKE_BYPASS);
+	}
+	return RCU_NOCB_WAKE_NOT;
+}
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
  */
 static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
-	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs = false;
-	unsigned long j = jiffies;
-	bool lazy = false;
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
 	bool needwake_gp;
+	int defer_wake_type = RCU_NOCB_WAKE_NOT;
 	struct rcu_data *rdp, *rdp_toggling = NULL;
 	struct rcu_node *rnp;
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
@@ -712,44 +758,24 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * won't be ignored for long.
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
-		long bypass_ncbs;
-		bool flush_bypass = false;
-		long lazy_ncbs;
+		int defer_wake_type_one = RCU_NOCB_WAKE_NOT;
+		bool flushed;
+		bool empty;
 
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
-		lockdep_assert_held(&rdp->nocb_lock);
-		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-		lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		defer_wake_type_one = nocb_gp_flush_wake(rdp, &empty, &flushed);
 
-		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
-		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-			continue; /* No callbacks here, try next. */
-		}
+		// We may need to do a deferred wakeup later for bypass/lazy
+		// So note down what we learnt from the rdp.
+		defer_wake_type = max(defer_wake_type_one, defer_wake_type);
 
-		if (flush_bypass) {
-			// Bypass full or old, so flush it.
-			(void)rcu_nocb_try_flush_bypass(rdp, j);
-			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-			lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		// Did we make any updates to main cblist? If not, no
+		// non-deferred wake up to do for this rdp.
+		if (!flushed && empty) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			continue;
 		}
 
-		if (bypass_ncbs) {
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-					    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
-			if (bypass_ncbs == lazy_ncbs)
-				lazy = true;
-			else
-				bypass = true;
-		}
 		rnp = rdp->mynode;
 
 		// Advance callbacks if helpful and low contention.
@@ -792,23 +818,16 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			rcu_gp_kthread_wake();
 	}
 
-	my_rdp->nocb_gp_bypass = bypass;
+	my_rdp->nocb_gp_bypass = (defer_wake_type == RCU_NOCB_WAKE_BYPASS);
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 
 	// At least one child with non-empty ->nocb_bypass, so set
 	// timer in order to avoid stranding its callbacks.
-	if (!rcu_nocb_poll) {
-		// If bypass list only has lazy CBs. Add a deferred lazy wake up.
-		if (lazy && !bypass) {
-			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
-					TPS("WakeLazyIsDeferred"));
-		// Otherwise add a deferred bypass wake up.
-		} else if (bypass) {
-			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
-					TPS("WakeBypassIsDeferred"));
-		}
-	}
+	if (!rcu_nocb_poll && defer_wake_type != RCU_NOCB_WAKE_NOT)
+		wake_nocb_gp_defer(my_rdp, defer_wake_type,
+				   defer_wake_type == RCU_NOCB_WAKE_LAZY ?
+				   TPS("WakeLazyIsDeferred") : TPS("WakeBypassIsDeferred"));
 
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
-- 
2.41.0.487.g6d72f3e995-goog

