Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39E7ECB05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjKOTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjKOTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:11:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2B199;
        Wed, 15 Nov 2023 11:11:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE3C433C8;
        Wed, 15 Nov 2023 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700075493;
        bh=b4GSpROCgIcQBEluuLqw37z2afZmrOSo6EsA/1KM+bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QR4M2pHCubk+BGD+JllWKxf+LOjqI6w2qgt7rivD1NfHkmRwiLuzYbfI0TdABfioF
         tUXQgiioySp63uLWj50R0lLVZogLGyGIbaAjsIp6S+OtfjYVLglJY3Z8hjC5NNqrZm
         GgZviXe0mb0f7tugAXGxug1v+FwbmTLEmzp4QhfVfbB4wvH7K3EXrbEino/aVRnvly
         0adAe5dIKoteYZG02+E8957bOc1VN30Daml7eripT7HxyZMu+RuWFM3yr2GAg5R9i3
         uumlxSMw9OGa+Qh8wnUpdYMXaEc76zt+yMQOruz9CW6/8TWc+B8A3JrTj4qoOu9LJ9
         mWGDFUgA80aAQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcu/nocb: Remove needless LOAD-ACQUIRE
Date:   Wed, 15 Nov 2023 14:11:27 -0500
Message-ID: <20231115191128.15615-3-frederic@kernel.org>
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
index aecef51166c7..eb27878d46f1 100644
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
2.42.1

