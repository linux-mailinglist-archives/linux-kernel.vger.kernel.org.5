Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052BA7B74EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjJCX3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjJCX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98382AF;
        Tue,  3 Oct 2023 16:29:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB0DC433CB;
        Tue,  3 Oct 2023 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375756;
        bh=CgxY0LqJVEeiQkh649qa4IrU9jtDS9lKPNw7zJo199M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdXvGbF/AWxAYuxckUhWjwbmC2g8wVhiZA+GsiwvL2w7wW+3ZfahRlEMz5eqlQiuZ
         A8IJPuFHWxv1q/wlKOLNIJY1WtvDfMnk8i3N7Q48BOaAgWNkNDhGw1mujdUdI2cw3y
         81C8Ty5CpnNlhTT9W1J4Ucp/RoAQYbKGdM0M9gRpiDwWR9pFGqCdZPBn7WzFKFbdBX
         Y8SWXIfR5NbltrTaLhYEjbCq/H50C4OQPp+WNM5isy2ztzmkDsomYm/ok6XTUImG1a
         milVgIIcWpGmrvc69skdFZ9uWD0ycflSvBh02qpWAjAkibTQBcGs+PfDUT//aZRWL3
         E5H2XdgVc5U5g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 2/5] srcu: Only accelerate on enqueue time
Date:   Wed,  4 Oct 2023 01:29:00 +0200
Message-ID: <20231003232903.7109-3-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003232903.7109-1-frederic@kernel.org>
References: <20231003232903.7109-1-frederic@kernel.org>
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

Acceleration in SRCU happens on enqueue time for each new callback. This
operation is expected not to fail and therefore any similar attempt
from other places shouldn't find any remaining callbacks to accelerate.

Moreover accelerations performed beyond enqueue time are error prone
because rcu_seq_snap() then may return the snapshot for a new grace
period that is not going to be started.

Remove these dangerous and needless accelerations and introduce instead
assertions reporting leaking unaccelerated callbacks beyond enqueue
time.

Co-developed-by: Yong He <zhuangel570@gmail.com>
Co-developed-by: Joel Fernandes <joel@joelfernandes.org>
Co-developed-by: Neeraj upadhyay <neeraj.iitr10@gmail.com>
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
2.41.0

