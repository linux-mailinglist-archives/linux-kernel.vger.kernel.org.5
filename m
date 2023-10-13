Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC977C852A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjJML7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjJML7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2E102;
        Fri, 13 Oct 2023 04:59:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF52C433AB;
        Fri, 13 Oct 2023 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198359;
        bh=R8Fp/1VLF0GqIaHBlnBp4fYP1iUMlAIDRWA+aBlSlzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c85EukgOs91vaaNy0DXYLoHblLD6GEv8zepj20ZCAZyIDZtG5oDyX0UWwW/3VOyy8
         bPSQt8ROD9OGxITChy9rpIDoQeyxhx6Z1o+syvASpJ0kr78ggMUdz9URTFUXqBIGqA
         TqVD3aAEwey859RgecAVU176ntPW9kpTeDchYQ8J4H1l9aCSBdo2wA+CT+VkRK5UAr
         By4VzSaFxNagN/ontbTyCBiPYR6UEcKTWeotTy0z8XaPYxuu+W/vX2kkJmH2oCYRIi
         yxCGXjO2vRkZju9goSBnnTMom505/il7qCjrHanAT8pbvFRMi1IlEAXeme6xkL2SiR
         aNDCvBqAEySeA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 04/18] rcu: Add sysfs to provide throttled access to rcu_barrier()
Date:   Fri, 13 Oct 2023 13:58:48 +0200
Message-Id: <20231013115902.1059735-5-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

When running a series of stress tests all making heavy use of RCU,
it is all too possible to OOM the system when the prior test's RCU
callbacks don't get invoked until after the subsequent test starts.
One way of handling this is just a timed wait, but this fails when a
given CPU has so many callbacks queued that they take longer to invoke
than allowed for by that timed wait.

This commit therefore adds an rcutree.do_rcu_barrier module parameter that
is accessible from sysfs.  Writing one of the many synonyms for boolean
"true" will cause an rcu_barrier() to be invoked, but will guarantee that
no more than one rcu_barrier() will be invoked per sixteenth of a second
via this mechanism.  The flip side is that a given request might wait a
second or three longer than absolutely necessary, but only when there are
multiple uses of rcutree.do_rcu_barrier within a one-second time interval.

This commit unnecessarily serializes the rcu_barrier() machinery, given
that serialization is already provided by procfs.  This has the advantage
of allowing throttled rcu_barrier() from other sources within the kernel.

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 kernel/rcu/tree.c                             | 76 +++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..7ec8a406d419 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4769,6 +4769,13 @@
 			Set maximum number of finished RCU callbacks to
 			process in one batch.
 
+	rcutree.do_rcu_barrier=	[KNL]
+			Request a call to rcu_barrier().  This is
+			throttled so that userspace tests can safely
+			hammer on the sysfs variable if they so choose.
+			If triggered before the RCU grace-period machinery
+			is fully active, this will error out with EAGAIN.
+
 	rcutree.dump_tree=	[KNL]
 			Dump the structure of the rcu_node combining tree
 			out at early boot.  This is used for diagnostic
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7c79480bfaa0..3c7281fc25a7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4083,6 +4083,82 @@ void rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
+static unsigned long rcu_barrier_last_throttle;
+
+/**
+ * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
+ *
+ * This can be thought of as guard rails around rcu_barrier() that
+ * permits unrestricted userspace use, at least assuming the hardware's
+ * try_cmpxchg() is robust.  There will be at most one call per second to
+ * rcu_barrier() system-wide from use of this function, which means that
+ * callers might needlessly wait a second or three.
+ *
+ * This is intended for use by test suites to avoid OOM by flushing RCU
+ * callbacks from the previous test before starting the next.  See the
+ * rcutree.do_rcu_barrier module parameter for more information.
+ *
+ * Why not simply make rcu_barrier() more scalable?  That might be
+ * the eventual endpoint, but let's keep it simple for the time being.
+ * Note that the module parameter infrastructure serializes calls to a
+ * given .set() function, but should concurrent .set() invocation ever be
+ * possible, we are ready!
+ */
+static void rcu_barrier_throttled(void)
+{
+	unsigned long j = jiffies;
+	unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
+	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
+
+	while (time_in_range(j, old, old + HZ / 16) ||
+	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
+		schedule_timeout_idle(HZ / 16);
+		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
+			smp_mb(); /* caller's subsequent code after above check. */
+			return;
+		}
+		j = jiffies;
+		old = READ_ONCE(rcu_barrier_last_throttle);
+	}
+	rcu_barrier();
+}
+
+/*
+ * Invoke rcu_barrier_throttled() when a rcutree.do_rcu_barrier
+ * request arrives.  We insist on a true value to allow for possible
+ * future expansion.
+ */
+static int param_set_do_rcu_barrier(const char *val, const struct kernel_param *kp)
+{
+	bool b;
+	int ret;
+
+	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
+		return -EAGAIN;
+	ret = kstrtobool(val, &b);
+	if (!ret && b) {
+		atomic_inc((atomic_t *)kp->arg);
+		rcu_barrier_throttled();
+		atomic_dec((atomic_t *)kp->arg);
+	}
+	return ret;
+}
+
+/*
+ * Output the number of outstanding rcutree.do_rcu_barrier requests.
+ */
+static int param_get_do_rcu_barrier(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%d\n", atomic_read((atomic_t *)kp->arg));
+}
+
+static const struct kernel_param_ops do_rcu_barrier_ops = {
+	.set = param_set_do_rcu_barrier,
+	.get = param_get_do_rcu_barrier,
+};
+static atomic_t do_rcu_barrier;
+module_param_cb(do_rcu_barrier, &do_rcu_barrier_ops, &do_rcu_barrier, 0644);
+
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
  * This will not be stable unless the rcu_node structure's ->lock is
-- 
2.34.1

