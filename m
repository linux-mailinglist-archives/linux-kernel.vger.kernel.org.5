Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671DB756B67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGQSMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGQSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA3E6F;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28082611E8;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B34C4339A;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=WXMDNs0NKjgJYxezPeNZXXRf2T8Uz/q0zB/XGeUalEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYVZQXwY1x+p2SFAg3b1Yi2EeSpc9tdtf1QRvIbUgJj5SfFvEALvdNSaswcUGc7tq
         aMYc2cK2zzcoAjCTMJdEL6xwLnPOc89KURa0OlTbv1fJGXRaAlMRH2xOW1CyZ53O/9
         JWtYVrqtq9ZuMrM/7W4RVig3+e3yNrbhi/g856QBdqcnE1hxWUA+yhTvEjJTcvmggM
         A35Oh0mJPKeW1u8NoVFW53qGVRN5Z3tg7X2aPtdu550UM9l7SuSQLoM0h5v03NguO6
         R1+F3WXzINVmVibHJeWZZNamiy1oBKcdue10uaYVrBJ7LWEzcj8rpW3sB29cxbiaHv
         +re2b2aT20CVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C04EFCE097F; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/13] rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time
Date:   Mon, 17 Jul 2023 11:11:34 -0700
Message-Id: <20230717181138.1098063-9-paulmck@kernel.org>
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

This commit causes RCU Tasks Trace to output the CPU time consumed by
its grace-period kthread.  The CPU time is whatever is in the designated
task's current->stime field, and thus is controlled by whatever CPU-time
accounting scheme is in effect.

This output appears in microseconds as follows on the console:

rcu_scale: Grace-period kthread CPU time: 42367.037

[ paulmck: Apply Willy Tarreau feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h      | 3 +++
 kernel/rcu/rcuscale.c | 1 +
 kernel/rcu/tasks.h    | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98c1544cf572..d58bc0e86769 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -505,6 +505,9 @@ void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
+# ifdef CONFIG_TASKS_RCU
+struct task_struct *get_rcu_tasks_gp_kthread(void);
+# endif // # ifdef CONFIG_TASKS_RCU
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 7fba3ab66e35..35e06c86acc9 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -298,6 +298,7 @@ static struct rcu_scale_ops tasks_ops = {
 	.gp_barrier	= rcu_barrier_tasks,
 	.sync		= synchronize_rcu_tasks,
 	.exp_sync	= synchronize_rcu_tasks,
+	.rso_gp_kthread	= get_rcu_tasks_gp_kthread,
 	.name		= "tasks"
 };
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 990a6cf5fa35..0f03de023097 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1042,6 +1042,12 @@ void show_rcu_tasks_classic_gp_kthread(void)
 EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
 #endif // !defined(CONFIG_TINY_RCU)
 
+struct task_struct *get_rcu_tasks_gp_kthread(void)
+{
+	return rcu_tasks.kthread_ptr;
+}
+EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
+
 /*
  * Contribute to protect against tasklist scan blind spot while the
  * task is exiting and may be removed from the tasklist. See
-- 
2.40.1

