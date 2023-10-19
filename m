Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8907A7CF7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjJSMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbjJSMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28B187;
        Thu, 19 Oct 2023 05:02:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F72C433C8;
        Thu, 19 Oct 2023 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716938;
        bh=Vnj5hN2dPt9MAc5s8TCef1rcSgQpQJDKJ311AZcgTbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHiWEClJahpQOALP7cH2yadREFbTb1JxW4abwGr8xTP67tB9OFxQYrkXWIO/TEQkN
         /6naZ9UwnQatD4XgLhF6rWC6UmJ8xaALg0DSBMb26W8CLI8Ff1PP9yyswYP7g+GHfP
         PtF01MW4KsALhsRkSIz2rs9UmJ6jZIZrzmQUii1Tmf+WZ6JCd+iExLL1Xs8OY1qTcZ
         520FMxdydmor7RotTaYeHx+IilBR6CWoq7U0H054JnJ2WAc9k5M/X48vXBJoCNZ5lA
         KV3NYPlHj0mwG0g/Z7CFWIL+lmy+Lu+2I0m2TNg+pM20pwLZcnmJSmbBHhNH+k8rRv
         O+wnLthrWvBxg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/6] rcu: Eliminate check_cpu_stall() duplicate code
Date:   Thu, 19 Oct 2023 14:01:59 +0200
Message-Id: <20231019120202.1216228-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120202.1216228-1-frederic@kernel.org>
References: <20231019120202.1216228-1-frederic@kernel.org>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

The code and comments of self-detected and other-detected RCU CPU stall
warnings are identical except the output function.  This commit therefore
refactors so as to consolidate the duplicate code.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_stall.h | 42 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index fc04a8d7ce96..2443d1d4a6dc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -711,7 +711,7 @@ static void print_cpu_stall(unsigned long gps)
 
 static void check_cpu_stall(struct rcu_data *rdp)
 {
-	bool didstall = false;
+	bool self_detected;
 	unsigned long gs1;
 	unsigned long gs2;
 	unsigned long gps;
@@ -758,10 +758,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + ULONG_MAX / 2;
+	self_detected = READ_ONCE(rnp->qsmask) & rdp->grpmask;
 	if (rcu_gp_in_progress() &&
-	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
+	    (self_detected || ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
-
 		/*
 		 * If a virtual machine is stopped by the host it can look to
 		 * the watchdog like an RCU stall. Check to see if the host
@@ -770,33 +770,21 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		if (kvm_check_and_clear_guest_paused())
 			return;
 
-		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall(gps);
-		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-			rcu_ftrace_dump(DUMP_ALL);
-		didstall = true;
-
-	} else if (rcu_gp_in_progress() &&
-		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
-		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+		if (self_detected) {
+			/* We haven't checked in, so go dump stack. */
+			print_cpu_stall(gps);
+		} else {
+			/* They had a few time units to dump stack, so complain. */
+			print_other_cpu_stall(gs2, gps);
+		}
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
-		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
-		didstall = true;
-	}
-	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
-		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
-		WRITE_ONCE(rcu_state.jiffies_stall, jn);
+
+		if (READ_ONCE(rcu_state.jiffies_stall) == jn) {
+			jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+			WRITE_ONCE(rcu_state.jiffies_stall, jn);
+		}
 	}
 }
 
-- 
2.34.1

