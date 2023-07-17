Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F5756B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGQSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjGQSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B0FE4C;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A011611EB;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBBCC433BB;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=Rgw6r2G/Sghz8SLefTEvi26Ln8tLe1JsOls+5spnAU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swl4+cF8ZOBu9qBeR2UIsxtcu9ToDchVqaq4KI2M3TUdgla1CqDPiMfk7RfjCCML6
         GaDFGFALZyXNFZ5zIv/bdk8G12L5lL5t/3ndgCj8bAyNKm8pDUQSaDPNJvRgU27ewm
         WMTKNnX/VLnP08S4tuCq2lD/UIMdevFLmgTydCtEnO+b1moMnww/cAcZZ40armK4sQ
         9cBnr/bibEWwY/3tsV7hI1SZtSpZJl4WJ8Rmus9HxKFE/iUDCWZnUnI0fSyjGZaqMT
         e/hFsOeAabwkiEg2608kPND41rKpI8mo7jlVZeOcdq2ytKguXt0003hARG/0SPxDUQ
         9DbUOpBPWTC+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4A7ECE0A0F; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Arnd Bergmann <arnd@arndb.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/13] rcuscale: fix building with RCU_TINY
Date:   Mon, 17 Jul 2023 11:11:36 -0700
Message-Id: <20230717181138.1098063-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Both the CONFIG_TASKS_RCU and CONFIG_TASKS_RUDE_RCU options
are broken when RCU_TINY is enabled as well, as some functions
are missing a declaration.

In file included from kernel/rcu/update.c:649:
kernel/rcu/tasks.h:1271:21: error: no previous prototype for 'get_rcu_tasks_rude_gp_kthread' [-Werror=missing-prototypes]
 1271 | struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/rcu/rcuscale.c:330:27: error: 'get_rcu_tasks_rude_gp_kthread' undeclared here (not in a function); did you mean 'get_rcu_tasks_trace_gp_kthread'?
  330 |         .rso_gp_kthread = get_rcu_tasks_rude_gp_kthread,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                           get_rcu_tasks_trace_gp_kthread

In file included from /home/arnd/arm-soc/kernel/rcu/update.c:649:
kernel/rcu/tasks.h:1113:21: error: no previous prototype for 'get_rcu_tasks_gp_kthread' [-Werror=missing-prototypes]
 1113 | struct task_struct *get_rcu_tasks_gp_kthread(void)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~

Also, building with CONFIG_TASKS_RUDE_RCU but not CONFIG_TASKS_RCU is
broken because of some missing stub functions:

kernel/rcu/rcuscale.c:322:27: error: 'tasks_scale_read_lock' undeclared here (not in a function); did you mean 'srcu_scale_read_lock'?
  322 |         .readlock       = tasks_scale_read_lock,
      |                           ^~~~~~~~~~~~~~~~~~~~~
      |                           srcu_scale_read_lock
kernel/rcu/rcuscale.c:323:27: error: 'tasks_scale_read_unlock' undeclared here (not in a function); did you mean 'srcu_scale_read_unlock'?
  323 |         .readunlock     = tasks_scale_read_unlock,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~
      |                           srcu_scale_read_unlock

Move the declarations outside of the RCU_TINY #ifdef and duplicate the
shared stub functions to address all of the above.

Fixes: 88d7ff818f0ce ("rcuscale: Add RCU Tasks Rude testing")
Fixes: 755f1c5eb416b ("rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h      | 14 ++++++++------
 kernel/rcu/rcuscale.c | 13 +++++++++++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9829d8161b21..5befd8780dcd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -505,18 +505,20 @@ void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
-# ifdef CONFIG_TASKS_RCU
-struct task_struct *get_rcu_tasks_gp_kthread(void);
-# endif // # ifdef CONFIG_TASKS_RCU
-# ifdef CONFIG_TASKS_RUDE_RCU
-struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
-# endif // # ifdef CONFIG_TASKS_RUDE_RCU
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_TASKS_RCU
+struct task_struct *get_rcu_tasks_gp_kthread(void);
+#endif // # ifdef CONFIG_TASKS_RCU
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
+#endif // # ifdef CONFIG_TASKS_RUDE_RCU
+
 #define RCU_SCHEDULER_INACTIVE	0
 #define RCU_SCHEDULER_INIT	1
 #define RCU_SCHEDULER_RUNNING	2
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5ce3b4e7ce71..a0eae1900708 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -316,11 +316,20 @@ static struct rcu_scale_ops tasks_ops = {
  * Definitions for RCU-tasks-rude scalability testing.
  */
 
+static int tasks_rude_scale_read_lock(void)
+{
+	return 0;
+}
+
+static void tasks_rude_scale_read_unlock(int idx)
+{
+}
+
 static struct rcu_scale_ops tasks_rude_ops = {
 	.ptype		= RCU_TASKS_RUDE_FLAVOR,
 	.init		= rcu_sync_scale_init,
-	.readlock	= tasks_scale_read_lock,
-	.readunlock	= tasks_scale_read_unlock,
+	.readlock	= tasks_rude_scale_read_lock,
+	.readunlock	= tasks_rude_scale_read_unlock,
 	.get_gp_seq	= rcu_no_completed,
 	.gp_diff	= rcu_seq_diff,
 	.async		= call_rcu_tasks_rude,
-- 
2.40.1

