Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72160799109
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbjIHUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344101AbjIHUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4A12C;
        Fri,  8 Sep 2023 13:36:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C2C433CB;
        Fri,  8 Sep 2023 20:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205380;
        bh=GOeZfICz6IgN8EOrRlzyyiYJ3WMWQY2axoWb8S5uGRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=If6qvcxVcxQ4YjCjO7D3jckmaba8n+kof+yqc7NEmlYUHjV/VWZ/w40/6+4jmB9Ri
         Y+vccZ1BH+/FvRY3YUZyqG482iO5pCVNNQ9EJrPXnt0n6eAzlbWJWS/u4yuxMmi/B3
         PsE7hF3WqQAYGEATCBBL2slDPGqkZTQ5pVDr8kOO2ryW37WQvlXcAs0h38/4BBoVTf
         w7K6tb/HDGgG3PTnsdLCFaSFzpq5gukKxldj02ATIkQ1czkCw80lva05aDoJZ/wVYt
         TMkG5IiGVMSNuAV2tToOnB4e790Z1OEi8ISCToMU/SULY+V2VuI/O3TqDPG9D3e/nt
         jU1ZWT9H33nPQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/10] rcu/nocb: Remove needless LOAD-ACQUIRE
Date:   Fri,  8 Sep 2023 22:35:56 +0200
Message-ID: <20230908203603.5865-4-frederic@kernel.org>
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

The LOAD-ACQUIRE access performed on rdp->nocb_cb_sleep advertizes
ordering callback execution against grace period completion. However
this is contradicted by the following:

* This LOAD-ACQUIRE doesn't pair with anything. The only counterpart
  barrier that can be found is the smp_mb() placed after callbacks
  advancing in nocb_gp_wait(). However the barrier is placed _after_
  ->nocb_cb_sleep write.

* Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
  ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
  rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.

* Both rcu_segcblist_extract_done_cbs() and rcu_advance_cbs() are called
  under the nocb_lock, the latter hereby providing already the desired
  ACQUIRE semantics.

Therefore it is safe to access ->nocb_cb_sleep with a simple compiler
barrier.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b9eab359c597..6e63ba4788e1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -933,8 +933,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 						    nocb_cb_wait_cond(rdp));
 
-		// VVV Ensure CB invocation follows _sleep test.
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
+		if (READ_ONCE(rdp->nocb_cb_sleep)) {
 			WARN_ON(signal_pending(current));
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
 		}
-- 
2.41.0

