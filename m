Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCF7E30E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjKFXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjKFXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:14:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7210CB;
        Mon,  6 Nov 2023 15:14:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A01C433CA;
        Mon,  6 Nov 2023 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312492;
        bh=nH7ua12l/437prLse1i5LGVQRNDMxr2wpXgADoEIiMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH3XpyGKEQCkz3GUQWdsz0Q963X30pE3GKywhh72U07FZKBatE3VXM7NzMHMvr+ev
         mk7MIjjaOFdXfA+ehc04tH8AAcMMDGnu451KdCiOIWbzmQLpZvL8BHwYLDTVhnoFIx
         vNNDXNjJkK0ALMNKJRnSo26uca6J8422Em70M3xshirNPL8oq4lkHR0PrScyescqId
         csrWaZB/8uWaHfd6oz2ei9QvwHXECVL/UtmoNMTUH2XjR52RGWxUh2EAybTupPC6TM
         QzxPkiRg0u0xpB+pIlNeU/Tj9oBhP+kt+NGh/g6HMNNU9S11N72CWpB6DiXfKOlx14
         hiyjaCh329lXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yong He <alexyonghe@tencent.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Like Xu <likexu@tencent.com>, Sasha Levin <sashal@kernel.org>,
        jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
        rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/13] srcu: Only accelerate on enqueue time
Date:   Mon,  6 Nov 2023 18:14:22 -0500
Message-ID: <20231106231435.3734790-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231435.3734790-1-sashal@kernel.org>
References: <20231106231435.3734790-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 8a77f38bcd28d3c22ab7dd8eff3f299d43c00411 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a1fcb8566b2e3..dbb5116bb0200 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -782,8 +782,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
+	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
@@ -1692,6 +1691,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	ssp = sdp->ssp;
 	rcu_cblist_init(&ready_cbs);
 	spin_lock_irq_rcu_node(sdp);
+	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	if (sdp->srcu_cblist_invoking ||
@@ -1721,8 +1721,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 */
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
-- 
2.42.0

