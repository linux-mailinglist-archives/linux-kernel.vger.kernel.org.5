Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B093799108
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIHUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIHUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B18E;
        Fri,  8 Sep 2023 13:36:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD2C433C9;
        Fri,  8 Sep 2023 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205375;
        bh=mvgQfp1WaBcpfDTbCSVaFFlPEh1S9we854LIGmy5oWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4r72CYfP8k8zha0VpGBOejgR2oZO5edDsBWsrRayIRwLTkKan/Bok+LpSDI/XWhb
         VwZYpRvFGYHMJKeGSBriUO30SdFeoL/e9fkvpVrR5YJSosGikFTaSK6Y1xocgPdg2R
         q66JaD+h4tZs+qql4yWrI2R6+L18dtGn6F+fQjNWx6Ko2WGX65fQHv1vetYyDn+mip
         YhwtStSj0EtCEqjxkN0Bo6nipse8R5mWnImjlpQDw/jYrNFdWyE93nO/sMVqT9Op8/
         JXnhXp0iSo1NB/wwLfbkN5yAHL9PQu29JQiZn8lhZTV1lcB2yK66RAzos/j/zJZwOl
         I78RcKSLfvNkA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 01/10] rcu: Use rcu_segcblist_segempty() instead of open coding it
Date:   Fri,  8 Sep 2023 22:35:54 +0200
Message-ID: <20230908203603.5865-2-frederic@kernel.org>
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

This makes the code more readable.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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
2.41.0

