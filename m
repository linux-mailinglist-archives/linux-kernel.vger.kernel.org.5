Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7AA7C8531
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjJML7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28010F5;
        Fri, 13 Oct 2023 04:59:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9AAC433C7;
        Fri, 13 Oct 2023 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198380;
        bh=9eKXMVkzj30bJjMYB0HS6GlgZmQ+aae2FrSYU4LFmqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lc6G8raIpvm9yT+YjPvUXfqlCcBSGvsvCO41iqsHlWYs4HoQlQBrbHeBxldNK5ZS3
         pONJYQJQN8KuhB5BjprBpq9wf/9T9SvMRBG39QxxHXQ1rPgL1L80QL2KM2Hrx+aklz
         VKsa6uz21SOzhNNhM6Hq/Rb5xNiB08jMy8WbNKBCHz6AL97J0u12oBp63SDRdoOUq1
         oRWY9+04XjJdF+ONPBtdBPLScLHxAB26DrcYD0AxeKLVNuuYdMOuxkOcszopNNoTeT
         hVSoEl1CZ5KCLZpPXkhjcr8tS+BpK++87WcEIiVWxi/QTe9H8Uj42fxnsq8L+LRdC9
         osyzbuL8PBVqQ==
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
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 11/18] rcu: Use rcu_segcblist_segempty() instead of open coding it
Date:   Fri, 13 Oct 2023 13:58:55 +0200
Message-Id: <20231013115902.1059735-12-frederic@kernel.org>
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

This makes the code more readable.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index f71fac422c8f..1693ea22ef1b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	smp_mb(); /* Ensure counts are updated before callback is entrained. */
 	rhp->next = NULL;
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
-		if (rsclp->tails[i] != rsclp->tails[i - 1])
+		if (!rcu_segcblist_segempty(rsclp, i))
 			break;
 	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
@@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * as their ->gp_seq[] grace-period completion sequence number.
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
-		if (rsclp->tails[i] != rsclp->tails[i - 1] &&
+		if (!rcu_segcblist_segempty(rsclp, i) &&
 		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
 			break;
 
-- 
2.34.1

