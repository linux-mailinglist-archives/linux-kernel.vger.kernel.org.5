Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E27C8532
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJMMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjJMMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:00:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EA1D58;
        Fri, 13 Oct 2023 05:00:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C4C433C9;
        Fri, 13 Oct 2023 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198401;
        bh=OrFL+Yftu/dBFajCkxlvH2Gier1tRKWYsuU8KyLe3dM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMyYYtKJ6dCQrEqAGWWgpSh3oU9RJ/2NrbUph/U7CVV4Co0COOAd1YUHMmbT5JEZ3
         nxDYpp9JYWLYbOYzTbAojl6BucGZyU3Qnx7Zx9hoqFwFptPvg0cvS/RkD0iSde8Udc
         U2MfXIhJIh2cQIUKhsk/vxkPDjpw1vJ7a3JhnVD0YwtiCj9Y8Tf4U7vsvc5XFOA2W0
         tteZjbF+Rp9tjAuZ2SwGGlKFd6+H5DKYLzmbV/NqAdvZLqcqSvEQang4eG65pLZhlg
         vbbqemSvesQV+NBPydDED1XVc2DItoCUa++0cnaf602gc2880KXrGwqBt9+l/t3mGM
         TNXTiELmPnKxA==
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
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Yong He <alexyonghe@tencent.com>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Like Xu <likexu@tencent.com>
Subject: [PATCH 18/18] srcu: Only accelerate on enqueue time
Date:   Fri, 13 Oct 2023 13:59:02 +0200
Message-Id: <20231013115902.1059735-19-frederic@kernel.org>
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

Acceleration in SRCU happens on enqueue time for each new callback. This
operation is expected not to fail and therefore any similar attempt
from other places shouldn't find any remaining callbacks to accelerate.

Moreover accelerations performed beyond enqueue time are error prone
because rcu_seq_snap() then may return the snapshot for a new grace
period that is not going to be started.

Remove these dangerous and needless accelerations and introduce instead
assertions reporting leaking unaccelerated callbacks beyond enqueue
time.

Co-developed-by: Yong He <alexyonghe@tencent.com>
Signed-off-by: Yong He <alexyonghe@tencent.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9fab9ac36996..560e99ec5333 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -784,8 +784,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
+	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
@@ -1721,6 +1720,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	ssp = sdp->ssp;
 	rcu_cblist_init(&ready_cbs);
 	spin_lock_irq_rcu_node(sdp);
+	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	if (sdp->srcu_cblist_invoking ||
@@ -1750,8 +1750,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 */
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
-- 
2.34.1

