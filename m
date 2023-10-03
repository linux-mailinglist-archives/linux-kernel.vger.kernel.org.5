Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC327B74EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjJCX33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjJCX3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0116890;
        Tue,  3 Oct 2023 16:29:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827CEC433CC;
        Tue,  3 Oct 2023 23:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696375761;
        bh=AYpsqjGYQerYpEpgb3/3JuONsnqpe9k5KpicXU2iC5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vb8yt7rj1+eASMqdgd8uOd7YztQbD2LY9C8D6UKrRfCDQEWlcvcvXP+pYsO1KYl3F
         wKo7Ipua6EfHoRWZg6Gh9t3205hor55zobDIFfZQK+/0sBOlmNyXAzW5kyHOveRedJ
         tlpo2xc6XMDQkLBC/d/cAioxpFZ/Tb40pP0QU+M4nhFeRad5DIaZ7oQZLxwrmVzEvr
         BH2bP6bdKh3ey9tW6/I+GMMIihWm9SNc5TC0i9t83zpy4b+Ge+x4qt/Sohw3GLHgN+
         LUFyxegCWNp/NlJAT09G8e1UXQu8Xg/FZnZ79+rrMLxk6hfFfzi3QJZ0bKBz97ZPSI
         a7srEntCpnslg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: [PATCH 4/5] srcu: No need to advance/accelerate if no callback enqueued
Date:   Wed,  4 Oct 2023 01:29:02 +0200
Message-ID: <20231003232903.7109-5-frederic@kernel.org>
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

While in grace period start, there is nothing to accelerate and
therefore no need to advance the callbacks either if no callback is
to be enqueued.

Spare these needless operations in this case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e9356a103626..2bfc8ed1eed2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1261,9 +1261,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 *     period (gp_num = X + 8). So acceleration fails.
 	 */
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s) && rhp);
+	if (rhp) {
+		rcu_segcblist_advance(&sdp->srcu_cblist,
+				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
+	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
 		needgp = true;
-- 
2.41.0

