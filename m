Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738AD7B74E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjJCX3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjJCX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E1BD;
        Tue,  3 Oct 2023 16:29:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B6C433C7;
        Tue,  3 Oct 2023 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375753;
        bh=SeJHCTpKmvGZu4Eri7N06Cc3UjYAkpJhCi+GE0MfaBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAVXdvQDOshnwP7RiEpZBQNaMyg87EVmQYfybY4RJsaRDcsnWJ0doRAHE02jHwjzl
         x3Gak5bzB5M4vfjOcV9bhQ5DZw4tXvNyH9fEY+4XL/HEL8l3H4K2g5WZ8ZIKnoDbs9
         Vj+Xl7yNFdnDplAhdnKNV/tjbz1cnh3wIzpbihaK1eqDlOtjlXNVR9bIXNyvGfypEm
         ygXG2wWRF18xWrJPKAh97N1+jik/gdlmbs3Kt1t8ExrO7xDeeoJKQIwoFL44MXou5C
         zpDszM2snNCzdj2YqmbVEF14BN1oTysf2DnF4wNhCN7pGd5AfktnK6wgEjnJaObOJ/
         xsxTD0qxTBfAw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 1/5] srcu: Fix callbacks acceleration mishandling
Date:   Wed,  4 Oct 2023 01:28:59 +0200
Message-ID: <20231003232903.7109-2-frederic@kernel.org>
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

SRCU callbacks acceleration might fail if the preceding callbacks
advance also fails. This can happen when the following steps are met:

1) The RCU_WAIT_TAIL segment has callbacks (say for gp_num 8) and the
   RCU_NEXT_READY_TAIL also has callbacks (say for gp_num 12).

2) The grace period for RCU_WAIT_TAIL is observed as started but not yet
   completed so rcu_seq_current() returns 4 + SRCU_STATE_SCAN1 = 5.

3) This value is passed to rcu_segcblist_advance() which can't move
   any segment forward and fails.

4) srcu_gp_start_if_needed() still proceeds with callback acceleration.
   But then the call to rcu_seq_snap() observes the grace period for the
   RCU_WAIT_TAIL segment (gp_num 8) as completed and the subsequent one
   for the RCU_NEXT_READY_TAIL segment as started
   (ie: 8 + SRCU_STATE_SCAN1 = 9) so it returns a snapshot of the
   next grace period, which is 16.

5) The value of 16 is passed to rcu_segcblist_accelerate() but the
   freshly enqueued callback in RCU_NEXT_TAIL can't move to
   RCU_NEXT_READY_TAIL which already has callbacks for a previous grace
   period (gp_num = 12). So acceleration fails.

6) Note in all these steps, srcu_invoke_callbacks() hadn't had a chance
   to run srcu_invoke_callbacks().

Then some very bad outcome may happen if the following happens:

7) Some other CPU races and starts the grace period number 16 before the
   CPU handling previous steps had a chance. Therefore srcu_gp_start()
   isn't called on the latter sdp to fix the acceleration leak from
   previous steps with a new pair of call to advance/accelerate.

8) The grace period 16 completes and srcu_invoke_callbacks() is finally
   called. All the callbacks from previous grace periods (8 and 12) are
   correctly advanced and executed but callbacks in RCU_NEXT_READY_TAIL
   still remain. Then rcu_segcblist_accelerate() is called with a
   snaphot of 20.

9) Since nothing started the grace period number 20, callbacks stay
   unhandled.

This has been reported in real load:

	[3144162.608392] INFO: task kworker/136:12:252684 blocked for more
	than 122 seconds.
	[3144162.615986]       Tainted: G           O  K   5.4.203-1-tlinux4-0011.1 #1
	[3144162.623053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
	disables this message.
	[3144162.631162] kworker/136:12  D    0 252684      2 0x90004000
	[3144162.631189] Workqueue: kvm-irqfd-cleanup irqfd_shutdown [kvm]
	[3144162.631192] Call Trace:
	[3144162.631202]  __schedule+0x2ee/0x660
	[3144162.631206]  schedule+0x33/0xa0
	[3144162.631209]  schedule_timeout+0x1c4/0x340
	[3144162.631214]  ? update_load_avg+0x82/0x660
	[3144162.631217]  ? raw_spin_rq_lock_nested+0x1f/0x30
	[3144162.631218]  wait_for_completion+0x119/0x180
	[3144162.631220]  ? wake_up_q+0x80/0x80
	[3144162.631224]  __synchronize_srcu.part.19+0x81/0xb0
	[3144162.631226]  ? __bpf_trace_rcu_utilization+0x10/0x10
	[3144162.631227]  synchronize_srcu+0x5f/0xc0
	[3144162.631236]  irqfd_shutdown+0x3c/0xb0 [kvm]
	[3144162.631239]  ? __schedule+0x2f6/0x660
	[3144162.631243]  process_one_work+0x19a/0x3a0
	[3144162.631244]  worker_thread+0x37/0x3a0
	[3144162.631247]  kthread+0x117/0x140
	[3144162.631247]  ? process_one_work+0x3a0/0x3a0
	[3144162.631248]  ? __kthread_cancel_work+0x40/0x40
	[3144162.631250]  ret_from_fork+0x1f/0x30

Fix this with taking the snapshot for acceleration _before_ the read
of the current grace period number.

The only side effect of this solution is that callbacks advancing happen
then _after_ the full barrier in rcu_seq_snap(). This is not a problem
because that barrier only cares about:

1) Ordering accesses of the update side before call_srcu() so they don't
   bleed.
2) See all the accesses prior to the grace period of the current gp_num

The only things callbacks advancing need to be ordered against are
carried by snp locking.

Reported-by: Yong He <zhuangel570@gmail.com>
Co-developed-by: Yong He <zhuangel570@gmail.com>
Co-developed-by: Joel Fernandes <joel@joelfernandes.org>
Co-developed-by: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Link: http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
Fixes: da915ad5cf25 ("srcu: Parallelize callback handling")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5602042856b1..9fab9ac36996 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1244,10 +1244,37 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	/*
+	 * The snapshot for acceleration must be taken _before_ the read of the
+	 * current gp sequence used for advancing, otherwise advancing may fail
+	 * and acceleration may then fail too.
+	 *
+	 * This could happen if:
+	 *
+	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
+	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
+	 *
+	 *  2) The grace period for RCU_WAIT_TAIL is seen as started but not
+	 *     completed so rcu_seq_current() returns X + SRCU_STATE_SCAN1.
+	 *
+	 *  3) This value is passed to rcu_segcblist_advance() which can't move
+	 *     any segment forward and fails.
+	 *
+	 *  4) srcu_gp_start_if_needed() still proceeds with callback acceleration.
+	 *     But then the call to rcu_seq_snap() observes the grace period for the
+	 *     RCU_WAIT_TAIL segment as completed and the subsequent one for the
+	 *     RCU_NEXT_READY_TAIL segment as started (ie: X + 4 + SRCU_STATE_SCAN1)
+	 *     so it returns a snapshot of the next grace period, which is X + 12.
+	 *
+	 *  5) The value of X + 12 is passed to rcu_segcblist_accelerate() but the
+	 *     freshly enqueued callback in RCU_NEXT_TAIL can't move to
+	 *     RCU_NEXT_READY_TAIL which already has callbacks for a previous grace
+	 *     period (gp_num = X + 8). So acceleration fails.
+	 */
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
+	rcu_segcblist_advance(&sdp->srcu_cblist,
+			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s) && rhp);
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
 		needgp = true;
-- 
2.41.0

