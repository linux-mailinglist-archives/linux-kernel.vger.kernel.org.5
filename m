Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0323C776C05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHIWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHIWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:12:56 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D62103
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:55 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-76ca7b4782cso23492385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619174; x=1692223974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD6vuUjSA6jvQT3OLU+SZ4Y6+nD0/e7X4lVaoLZ7PRc=;
        b=InMoIler5rOHArzpoihm2kyiIc8THS7j1z/8taCzI7XEbA0NhxQ5E3mFrfnCVngFYS
         0dpAwHtks3JUDJ44sRVzkAdDF6qh4dbMYWUxidzynZtmkiuUcMv1g/3OnXhnRfskaa4Q
         iNUcJ1s0D+cBOewbuKgAkVREC2e80qcry+OPkLYOfXzGXB9d3v1aShP7MoUZPVFx2JmX
         xLS+mAZ3NvVDjx9dRQTGKajDRBo10nLrSqH+3iRrzOPDr621Ys2+sFb5k7OG9S8PLMRv
         8AXArdQBj3beVKj9lYY0hFUR4Rqc5aiM3POq4Rw6BUmRH0p2uowzmYNyoDzJ6fATFiF2
         qi8A==
X-Gm-Message-State: AOJu0YydVkpsHeYc5/W1+rrJdtnZoe4I3w94m8maZ7eESRRr3Vzkn/35
        lJgBEGw5F3o88TFj3ehnI1epyfuXg44SrIUN
X-Google-Smtp-Source: AGHT+IEd6f1iuX8MFjgmBbvOI/61r0jzS0PBypdUd3aOt9AvbCnwZ2PNNkOja/DYkphkHZBPbp6OnQ==
X-Received: by 2002:a05:620a:4cc:b0:765:3e81:e74c with SMTP id 12-20020a05620a04cc00b007653e81e74cmr354657qks.21.1691619174312;
        Wed, 09 Aug 2023 15:12:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id d18-20020a05620a159200b00767c61ee342sm21970qkk.48.2023.08.09.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:53 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 5/7] sched/fair: Add SHARED_RUNQ sched feature and skeleton calls
Date:   Wed,  9 Aug 2023 17:12:16 -0500
Message-ID: <20230809221218.163894-6-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain workloads in CFS, CPU utilization is of the upmost
importance. For example, at Meta, our main web workload benefits from a
1 - 1.5% improvement in RPS, and a 1 - 2% improvement in p99 latency,
when CPU utilization is pushed as high as possible.

This is likely something that would be useful for any workload with long
slices, or for which avoiding migration is unlikely to result in
improved cache locality.

We will soon be enabling more aggressive load balancing via a new
feature called shared_runq, which places tasks into a FIFO queue in the
__enqueue_entity(), wakeup path, and then opportunistically dequeues
them in newidle_balance(). We don't want to enable the feature by
default, so this patch defines and declares a new scheduler feature
called SHARED_RUNQ which is disabled by default.

A set of future patches will implement these functions, and enable
shared_runq for both single and multi socket / CCX architectures.

Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c     | 34 ++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  2 ++
 kernel/sched/sched.h    |  1 +
 3 files changed, 37 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb15d6f46479..9c23e3b948fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -140,6 +140,20 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 #ifdef CONFIG_SMP
+void shared_runq_toggle(bool enabling)
+{}
+
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
+{}
+
+static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
+{
+	return 0;
+}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{}
+
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -162,6 +176,15 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
+#else
+void shared_runq_toggle(bool enabling)
+{}
+
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
+{}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{}
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -642,11 +665,15 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (sched_feat(SHARED_RUNQ) && entity_is_task(se))
+		shared_runq_enqueue_task(rq_of(cfs_rq), task_of(se));
 	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (sched_feat(SHARED_RUNQ) && entity_is_task(se))
+		shared_runq_dequeue_task(task_of(se));
 	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
 }
 
@@ -12043,6 +12070,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	if (sched_feat(SHARED_RUNQ)) {
+		pulled_task = shared_runq_pick_next_task(this_rq, rf);
+		if (pulled_task)
+			return pulled_task;
+	}
+
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
@@ -12543,6 +12576,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
+	shared_runq_dequeue_task(p);
 	detach_task_cfs_rq(p);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index e10074cb4be4..6d7c93fc1a8f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -103,3 +103,5 @@ SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
 
 SCHED_FEAT(HZ_BW, true)
+
+SCHED_FEAT_CALLBACK(SHARED_RUNQ, false, shared_runq_toggle)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2631da3c8a4d..a484bb527ee4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2132,6 +2132,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 #endif /* SCHED_DEBUG */
 
 typedef void (*sched_feat_change_f)(bool enabling);
+extern void shared_runq_toggle(bool enabling);
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
-- 
2.41.0

