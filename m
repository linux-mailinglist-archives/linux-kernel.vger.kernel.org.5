Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE17B74ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjJCX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbjJCX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E766DC;
        Tue,  3 Oct 2023 16:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0123C433C7;
        Tue,  3 Oct 2023 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375758;
        bh=v3XWzp5y3b223EZI0Adeq7leNILWY4Ny2s3VXNJdVDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxBFBO9fexrgAIW8L6p/0lDFR+U7WAcxIocLnY5i/UnkELy4bW/aP796oq73qPyDe
         GgqjDQK5xFLEp4d9OxZ7X1QP5pGMLkxZDlpb4v7PNi+0s+guASOFbwUYqeCBCMaUFC
         lk7UIp12bc6DjYNl2ccy5N5xrHAPtnGqFQDiXFEjxGN8IEKvA9qPfwRgQzBL7HGvIx
         AgMOTbk04C7loWaFhVWUwVft01hR9G4WyrkiM3bnFKNyFDSkH+4bdVgsMUedtGVf7o
         1PLlBmv41w4svke1Z8RSZd1rj1N0UBikaJTJq2i8hidOcZuLTXbNwmJ2gKPM2Va0Bk
         4Ja4UJsw9BAKQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 3/5] srcu: Remove superfluous callbacks advancing from srcu_start_gp()
Date:   Wed,  4 Oct 2023 01:29:01 +0200
Message-ID: <20231003232903.7109-4-frederic@kernel.org>
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

Callbacks advancing on SRCU must be performed on two specific places:

1) On enqueue time in order to make room for the acceleration of the
   new callback.

2) On invocation time in order to move the callbacks ready to invoke.

Any other callback advancing callsite is needless. Remove the remaining
one in srcu_gp_start().

Co-developed-by: Yong He <zhuangel570@gmail.com>
Co-developed-by: Joel Fernandes <joel@joelfernandes.org>
Co-developed-by: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 560e99ec5333..e9356a103626 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -772,20 +772,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp;
 	int state;
 
-	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
-	else
-		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
-	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
-	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
-- 
2.41.0

