Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1378F401
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbjHaU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347392AbjHaU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACCF1B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8906B823BA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFABCC433C9;
        Thu, 31 Aug 2023 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513782;
        bh=yKq+K0AY5s6vg6cR2QhLxhtDuuzWAbIZ4RtywMq3NQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKDYbvTQbOAmwq9KDUR9xC4Wzlpx/BIOCiqQR+ZL/cpXKzRDIDyOE51dDJ8hHbD7I
         K2T2BYptPpmzcG+K4vAqO5BGr0pEjz6uUHar29ResIQFgMSSwJtNIKD2+Ng5khmeeW
         //aWE4JB+JQmT0obRin3nJpMFEirloV4Rv9zh6bGCpHiuytsTEOibMTJS2O63udHp1
         JVAAFvmrk7P6Mb8nuulFuNIBqSHlL2j7diONqs7FjaxAD5RvVnn4TFULETn7bXkMxH
         dYaqdq+Nc6eppzqfaPJrKL9xeZw13Rh5XLhY/Apbpq0BhP+Hz31zcYNwy/UFFYJzMh
         +zwZJ+FCoKSmA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4 2/7] sched/deadline: Collect sched_dl_entity initialization
Date:   Thu, 31 Aug 2023 22:28:53 +0200
Message-Id: <881b724c1657dae38a0af7a768c896a8c1f0b321.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Create a single function that initializes a sched_dl_entity.

Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c     |  5 +----
 kernel/sched/deadline.c | 22 +++++++++++++++-------
 kernel/sched/sched.h    |  5 +----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..b57746237a43 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4513,10 +4513,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
-	RB_CLEAR_NODE(&p->dl.rb_node);
-	init_dl_task_timer(&p->dl);
-	init_dl_inactive_task_timer(&p->dl);
-	__dl_clear_params(p);
+	init_dl_entity(&p->dl);
 
 	INIT_LIST_HEAD(&p->rt.run_list);
 	p->rt.timeout		= 0;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9a09d9dafd88..f8c402079404 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -335,6 +335,8 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void __dl_clear_params(struct sched_dl_entity *dl_se);
+
 /*
  * The utilization of a task cannot be immediately removed from
  * the rq active utilization (running_bw) when the task blocks.
@@ -434,7 +436,7 @@ static void task_non_contending(struct task_struct *p)
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 			raw_spin_unlock(&dl_b->lock);
-			__dl_clear_params(p);
+			__dl_clear_params(dl_se);
 		}
 
 		return;
@@ -1207,7 +1209,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
@@ -1413,7 +1415,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		raw_spin_lock(&dl_b->lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 		raw_spin_unlock(&dl_b->lock);
-		__dl_clear_params(p);
+		__dl_clear_params(dl_se);
 
 		goto unlock;
 	}
@@ -1429,7 +1431,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
@@ -2984,10 +2986,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 /*
  * This function clears the sched_dl_entity static params.
  */
-void __dl_clear_params(struct task_struct *p)
+static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	dl_se->dl_runtime		= 0;
 	dl_se->dl_deadline		= 0;
 	dl_se->dl_period		= 0;
@@ -3005,6 +3005,14 @@ void __dl_clear_params(struct task_struct *p)
 #endif
 }
 
+void init_dl_entity(struct sched_dl_entity *dl_se)
+{
+	RB_CLEAR_NODE(&dl_se->rb_node);
+	init_dl_task_timer(dl_se);
+	init_dl_inactive_task_timer(dl_se);
+	__dl_clear_params(dl_se);
+}
+
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1def5b7fa1df..5e0df4bba476 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -284,8 +284,6 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
-void __dl_clear_params(struct task_struct *p);
-
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -2443,8 +2441,7 @@ extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
-extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
+extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
-- 
2.40.1

