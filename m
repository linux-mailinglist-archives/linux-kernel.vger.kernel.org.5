Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB267B74EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjJCX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbjJCX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F92F0;
        Tue,  3 Oct 2023 16:29:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33129C433CA;
        Tue,  3 Oct 2023 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375764;
        bh=0rRo8FAmb5oxl6EZiJPhw9pHIJx5I2TobFmAd6Jx3js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckZ84jL+5znrqWKHYEA+9b1Rw3RT0Gi+UXmpmDTGlZhoPinert8WUNxoDLU4o56nk
         dmedaAxQJKrj7ntNQVKbPtnO2xlcoeh9TptXuh3uHCcLUzchAgQQSAxWftjDL7dHI4
         F0GlfzowXeBcgPjhVYmPfr5Vtqv1pKYzqUVAEbkdOOLw4rADsiMRppbrszlTsiYIXp
         najipfPoK5n//X9Kg/cvv3L1npieqZqr+QdozUZ9ALZVuzsIdeTaN32AS/NkaSNHQV
         vrd4UXNW8B3aGZGyz0IN4a6Eb7zGdywILKMBiwNxLEtYz+WsYVe5USMhK4ClYS+sxK
         PV7LRnOBhW8iw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 5/5] srcu: Explain why callbacks invocations can't run concurrently
Date:   Wed,  4 Oct 2023 01:29:03 +0200
Message-ID: <20231003232903.7109-6-frederic@kernel.org>
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

If an SRCU barrier is queued while callbacks are running and a new
callbacks invocator for the same sdp were to run concurrently, the
RCU barrier might execute too early. As this requirement is non-obvious,
make sure to keep a record.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2bfc8ed1eed2..0351a4e83529 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	/*
+	 * Although this function is theoretically re-entrant, concurrent
+	 * callbacks invocation is disallowed to avoid executing an SRCU barrier
+	 * too early.
+	 */
 	if (sdp->srcu_cblist_invoking ||
 	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irq_rcu_node(sdp);
@@ -1745,6 +1750,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
+	/* An SRCU barrier or callbacks from previous nesting work pending */
 	if (more)
 		srcu_schedule_cbs_sdp(sdp, 0);
 }
-- 
2.41.0

