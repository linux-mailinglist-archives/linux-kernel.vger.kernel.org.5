Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3A756B66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjGQSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGQSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DD8E;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2341B611E4;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6EAC433AD;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=MIhkeztsVEuhvwr2MszSXvW/fHdP74ZIBpgGzjKJOiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESE4wom7KKaNW9leiHXoMJj7L0T+MzWGD5OkIzc64KKMmdDl2S8BaLZ0gkas26IWv
         LUY2EYq2hYp6TFC3lzbhVniZmDfAJ1iMCH4lOzBLurSnrX4Sj8Uv09PlOOhdu4vU/m
         EKUV5Mo+YKDz3ScEWvDirSmjJbpeNWraepE0TxU947n73KC2CcuMETZDbQIJwzMjHZ
         gvX8s9oKlHGvRjBVC+ZnTJbJEzTxBSJBTP85411UzR/b2cyx2UilK2t6jISodbky8D
         cvBtpcvCEhyGThcxpko2XfW4/AzE0xds15W184m/HtfVwY49BFtGhXMv1Cy6DR2yQA
         9ox0Xw/6FW4gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9A28CE092F; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
Subject: [PATCH rcu 06/13] rcuscale: Measure grace-period kthread CPU time
Date:   Mon, 17 Jul 2023 11:11:31 -0700
Message-Id: <20230717181138.1098063-6-paulmck@kernel.org>
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

This commit adds the ability to output the CPU time consumed by the
grace-period kthread for the RCU variant under test.  The CPU time is
whatever is in the designated task's current->stime field, and thus is
controlled by whatever CPU-time accounting scheme is in effect.

This output appears in microseconds as follows on the console:

rcu_scale: Grace-period kthread CPU time: 42367.037

[ paulmck: Apply feedback from Stephen Rothwell and kernel test robot. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
---
 include/linux/rcupdate_trace.h |  1 +
 kernel/rcu/rcuscale.c          | 21 +++++++++++++++++++++
 kernel/rcu/tasks.h             |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 9bc8cbb33340..eda493200663 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -87,6 +87,7 @@ static inline void rcu_read_unlock_trace(void)
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 void synchronize_rcu_tasks_trace(void);
 void rcu_barrier_tasks_trace(void);
+struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
 #else
 /*
  * The BPF JIT forms these addresses even when it doesn't call these
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 821a3e65c54a..7fba3ab66e35 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -141,6 +141,7 @@ struct rcu_scale_ops {
 	void (*gp_barrier)(void);
 	void (*sync)(void);
 	void (*exp_sync)(void);
+	struct task_struct *(*rso_gp_kthread)(void);
 	const char *name;
 };
 
@@ -336,6 +337,7 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.gp_barrier	= rcu_barrier_tasks_trace,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
+	.rso_gp_kthread	= get_rcu_tasks_trace_gp_kthread,
 	.name		= "tasks-tracing"
 };
 
@@ -563,6 +565,8 @@ static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
 static atomic_t n_kfree_scale_thread_started;
 static atomic_t n_kfree_scale_thread_ended;
+static struct task_struct *kthread_tp;
+static u64 kthread_stime;
 
 struct kfree_obj {
 	char kfree_obj[8];
@@ -808,6 +812,18 @@ rcu_scale_cleanup(void)
 	if (gp_exp && gp_async)
 		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
+	// If built-in, just report all of the GP kthread's CPU time.
+	if (IS_BUILTIN(CONFIG_RCU_SCALE_TEST) && !kthread_tp && cur_ops->rso_gp_kthread)
+		kthread_tp = cur_ops->rso_gp_kthread();
+	if (kthread_tp) {
+		u32 ns;
+		u64 us;
+
+		kthread_stime = kthread_tp->stime - kthread_stime;
+		us = div_u64_rem(kthread_stime, 1000, &ns);
+		pr_info("rcu_scale: Grace-period kthread CPU time: %llu.%03u us\n", us, ns);
+		show_rcu_gp_kthreads();
+	}
 	if (kfree_rcu_test) {
 		kfree_scale_cleanup();
 		return;
@@ -921,6 +937,11 @@ rcu_scale_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
+	if (cur_ops->rso_gp_kthread) {
+		kthread_tp = cur_ops->rso_gp_kthread();
+		if (kthread_tp)
+			kthread_stime = kthread_tp->stime;
+	}
 	if (kfree_rcu_test)
 		return kfree_scale_init();
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b770add3f843..990a6cf5fa35 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1830,6 +1830,12 @@ void show_rcu_tasks_trace_gp_kthread(void)
 EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
 #endif // !defined(CONFIG_TINY_RCU)
 
+struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
+{
+	return rcu_tasks_trace.kthread_ptr;
+}
+EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1

