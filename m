Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27939756B35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGQSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGQSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7521E55;
        Mon, 17 Jul 2023 11:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF5A611CE;
        Mon, 17 Jul 2023 18:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6588C433CB;
        Mon, 17 Jul 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616998;
        bh=qrmkRJUcCb33D57HkzURt5PuKRrWNnsRo/tBMS92MhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdwHjLqXUhPxQ2N5R1zmC27110AaNXYiFtwwZ2a8+8xHPpWEmvCrbhUkry60YJLIM
         b2Pczt9fyDGyuVibGeaSgkeS2izPNY+H7icYNdr9eNUOovesJykc4EcyDMFnWuAS+S
         kCngrQmTBoYtZwBj6K4eqy8DQqSPsVLoVWZPolmCscxt9R7ihK7lIz3NExXJxFsf6r
         UndJA48RETusgsPrsvYbuZ33QpIHlpyRWNrL793sSCTGZcRg0UtGfUPzmYIWnXeHH7
         fjPMd18adrwHyXXDQeS4qcKtNMvo/2yMAUC7Whq/EI9VspYLBpIIv3JbBOJOGIpvrU
         XZcXo6W0YVc5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F9C0CE0836; Mon, 17 Jul 2023 11:03:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] rcu: Mark __rcu_irq_enter_check_tick() ->rcu_urgent_qs load
Date:   Mon, 17 Jul 2023 11:03:15 -0700
Message-Id: <20230717180317.1097590-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_request_urgent_qs_task() function does a cross-CPU store
to ->rcu_urgent_qs, so this commit therefore marks the load in
__rcu_irq_enter_check_tick() with READ_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fae9b4e29c93..aec07f2ec638 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -632,7 +632,7 @@ void __rcu_irq_enter_check_tick(void)
 	// prevents self-deadlock.  So we can safely recheck under the lock.
 	// Note that the nohz_full state currently cannot change.
 	raw_spin_lock_rcu_node(rdp->mynode);
-	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+	if (READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		// A nohz_full CPU is in the kernel and RCU needs a
 		// quiescent state.  Turn on the tick!
 		WRITE_ONCE(rdp->rcu_forced_tick, true);
-- 
2.40.1

