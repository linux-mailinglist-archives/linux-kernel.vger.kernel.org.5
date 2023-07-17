Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526BF756B68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGQSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGQSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCBE6C;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324CF611F3;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB60C433B8;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=69vKKKzfGC7L050YBgFnUQUwQJCbn9lPzoOVI5TYOis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVBenQcQwciEEi4nOUmcwSTWJCl+76G9JTcvk7eW50gDhvG+pCZHN6i1q+i4LhGMd
         DoXwb5iZWAhKlTH0zF72oKkA/fHlGp88yJ7Xw0ti9qWjgKZkpByDPfuSLneOFG5kln
         Ovo7U0Ak1LOzLmGd8PNnjrH2dFU3QwDRSBVdrgFEv7Flm3yWutenNvOBGiXMj7UVb9
         eP0dgm9HyptgyRwZW4bqN34OtyuCjpQQtQPnd4Utfn1LuKVQHNpbN1hkBt77hIFfAV
         h1iPYEGGDrRze58f9ra76iLfYYaM+vpT1g96yClf8B9JakXLG1ojz7frQ64bZW3tIC
         xf/zXFS/m88OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C28D6CE09E0; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/13] rcuscale: Add RCU Tasks Rude testing
Date:   Mon, 17 Jul 2023 11:11:35 -0700
Message-Id: <20230717181138.1098063-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
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

Add a "tasks-rude" option to the rcuscale.scale_type module parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h                              |  3 ++
 kernel/rcu/rcuscale.c                         | 31 ++++++++++++++++++-
 kernel/rcu/tasks.h                            |  7 +++++
 .../rcutorture/configs/rcuscale/CFcommon      |  2 ++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d58bc0e86769..9829d8161b21 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -508,6 +508,9 @@ void show_rcu_tasks_gp_kthreads(void);
 # ifdef CONFIG_TASKS_RCU
 struct task_struct *get_rcu_tasks_gp_kthread(void);
 # endif // # ifdef CONFIG_TASKS_RCU
+# ifdef CONFIG_TASKS_RUDE_RCU
+struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
+# endif // # ifdef CONFIG_TASKS_RUDE_RCU
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 35e06c86acc9..5ce3b4e7ce71 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -310,6 +310,35 @@ static struct rcu_scale_ops tasks_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_RCU
 
+#ifdef CONFIG_TASKS_RUDE_RCU
+
+/*
+ * Definitions for RCU-tasks-rude scalability testing.
+ */
+
+static struct rcu_scale_ops tasks_rude_ops = {
+	.ptype		= RCU_TASKS_RUDE_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_scale_read_lock,
+	.readunlock	= tasks_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks_rude,
+	.gp_barrier	= rcu_barrier_tasks_rude,
+	.sync		= synchronize_rcu_tasks_rude,
+	.exp_sync	= synchronize_rcu_tasks_rude,
+	.rso_gp_kthread	= get_rcu_tasks_rude_gp_kthread,
+	.name		= "tasks-rude"
+};
+
+#define TASKS_RUDE_OPS &tasks_rude_ops,
+
+#else // #ifdef CONFIG_TASKS_RUDE_RCU
+
+#define TASKS_RUDE_OPS
+
+#endif // #else // #ifdef CONFIG_TASKS_RUDE_RCU
+
 #ifdef CONFIG_TASKS_TRACE_RCU
 
 /*
@@ -913,7 +942,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0f03de023097..0372c5cbc83b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1194,6 +1194,13 @@ void show_rcu_tasks_rude_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 #endif // !defined(CONFIG_TINY_RCU)
+
+struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
+{
+	return rcu_tasks_rude.kthread_ptr;
+}
+EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
+
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 6a00157bee5b..b1ffd7c67604 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -2,5 +2,7 @@ CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
 CONFIG_FORCE_TASKS_RCU=y
 #CHECK#CONFIG_TASKS_RCU=y
+CONFIG_FORCE_TASKS_RUDE_RCU=y
+#CHECK#CONFIG_TASKS_RUDE_RCU=y
 CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
-- 
2.40.1

