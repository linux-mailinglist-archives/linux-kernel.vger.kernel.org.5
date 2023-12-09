Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454680B15A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574928AbjLIBSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjLIBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:18:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA63E9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:18:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c25973988so28431445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702084712; x=1702689512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S2RIQK6R3dzB1Bkm7DGvzX/0PWdg4UTJUWFeUtQkyg=;
        b=ION6ddJkmpgcHiAGd73rCF3W8AuJwV2UzrSpeNadJGLXX+9mD57mB/ft8TOjtnsENm
         Yp35dhXxLuMvWAM2itn2JTlzjEA3RaUOSAp4+38Hx35kMeYryrMdK7DWozPp4HD3343E
         TvUvbdCz4gqoxf0fxcXR/eJZNV78QY3Nu1gwIkeiALGeH329ci/aA9QjWOhTq4OF7iqH
         65YvIwRkFYrcH2BJNlHvwqsyhdXpBKQTRtFWMjraVAku+THcH9qRXvNPyIQxmXbdCyPs
         SMIZL8IiWF0PFiQm/nWDhA5OuFzHaQzRJQA6KXlI5zH4PK9hCFRl2Ds1bG7mETxDO4ff
         vp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702084712; x=1702689512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S2RIQK6R3dzB1Bkm7DGvzX/0PWdg4UTJUWFeUtQkyg=;
        b=SsSDn2Udci/gVZ+Vyc9DGYS+iN4A2g4zxYcfZBUrn06bUXLQ1+/1Vf+VacGZibmQld
         Xg//CT04LWHjK/2qIC6uHNuSqARrWmHlW8rkUrYqNzPr6NrFR2jlDUTEKMzIxxxx+q0F
         /pz5qE0ZZ1yrJfpx6Wa4eEx52+u/Yb31r+hmCZzsjirzBdzt0zNlJdyCgApj16ze8viT
         ZhAZN+9IEwDONKUaASR6+GAv9AfpYrpPc+tDwD4YVdcq0OOnc3j4p+/Nj+ZLqM6xidhc
         Z0GmOCnkNaWxnm2nOMHDYtZYJZ9CKjVsfYOq13DBC0NH6U1pKdSMyqFR+suSUGGss3Ko
         c4sw==
X-Gm-Message-State: AOJu0Ywe7rgatgkuLbSrA6UpCMRGujIM/634o8pfhiM5eyavFNrduK3G
        PKRZYG7ykLZSwZ+wYQWj01CD/Q==
X-Google-Smtp-Source: AGHT+IEaPKc7KFp9qin3xQIa6tqjUl81GvceUK/SteWaWqPvuDsYBMHaNBTA/FbJdZIxe/s2zNWecw==
X-Received: by 2002:a05:600c:1d19:b0:40c:27a4:96af with SMTP id l25-20020a05600c1d1900b0040c27a496afmr454266wms.126.1702084712225;
        Fri, 08 Dec 2023 17:18:32 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm4772125wmq.43.2023.12.08.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:18:31 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/3] sched/fair: Generalize misfit lb by adding a misfit reason
Date:   Sat,  9 Dec 2023 01:17:58 +0000
Message-Id: <20231209011759.398021-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209011759.398021-1-qyousef@layalina.io>
References: <20231209011759.398021-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MISFIT_PERF is what is currently implemented. It indicates that the task
requires moving to a more performant CPU.

Guard misfit handling in find_busiest_queue and update_sd_pick_busiest
with MISFIT_PERF. They explicitly assume this type of misfit

This generalizes misfit lb to allow for more types of misfits to be
added. Like MISFIT_POWER to help uclamp_max being more effective, and
MISFIT_LATENCY to help latency sensitive tasks to be spread in
oversubscribe conditions.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c  | 28 +++++++++++++++++++++++-----
 kernel/sched/sched.h |  8 ++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb9e891182cc..dd49b89a6e3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5063,7 +5063,8 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 }
 
-static inline int is_misfit_task(struct task_struct *p, struct rq *rq)
+static inline int is_misfit_task(struct task_struct *p, struct rq *rq,
+				 misfit_reason_t *reason)
 {
 	if (!p || p->nr_cpus_allowed == 1)
 		return 0;
@@ -5071,16 +5072,21 @@ static inline int is_misfit_task(struct task_struct *p, struct rq *rq)
 	if (task_fits_cpu(p, cpu_of(rq)))
 		return 0;
 
+	if (reason)
+		*reason = MISFIT_PERF;
 	return 1;
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	misfit_reason_t reason;
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!is_misfit_task(p, rq)) {
+	if (!is_misfit_task(p, rq, &reason)) {
 		rq->misfit_task_load = 0;
+		rq->misfit_reason = -1;
 		return;
 	}
 
@@ -5089,6 +5095,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	 * task_h_load() returns 0.
 	 */
 	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
+	rq->misfit_reason = reason;
 }
 
 #else /* CONFIG_SMP */
@@ -9111,7 +9118,7 @@ static int detach_tasks(struct lb_env *env)
 
 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (!is_misfit_task(p, cpu_rq(env->src_cpu)))
+			if (!is_misfit_task(p, cpu_rq(env->src_cpu), NULL))
 				goto next;
 
 			env->imbalance = 0;
@@ -9426,6 +9433,7 @@ struct sg_lb_stats {
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	misfit_reason_t group_misfit_reason;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -9904,6 +9912,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
+				sgs->group_misfit_reason = rq->misfit_reason;
 				*sg_status |= SG_OVERLOAD;
 			}
 		} else if ((env->idle != CPU_NOT_IDLE) &&
@@ -9969,6 +9978,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
 	    (sgs->group_type == group_misfit_task) &&
+	    (sgs->group_misfit_reason == MISFIT_PERF) &&
 	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
@@ -10193,6 +10203,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	for_each_cpu(i, sched_group_span(group)) {
 		struct rq *rq = cpu_rq(i);
+		misfit_reason_t reason;
 		unsigned int local;
 
 		sgs->group_load += cpu_load_without(rq, p);
@@ -10212,9 +10223,15 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 		/* Check if task fits in the CPU */
 		if (sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load &&
-		    !is_misfit_task(p, rq))
+		    sgs->group_misfit_task_load) {
+		    if (!is_misfit_task(p, rq, &reason)) {
 			sgs->group_misfit_task_load = 0;
+			sgs->group_misfit_reason = -1;
+		    } else {
+			sgs->group_misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
+			sgs->group_misfit_reason = reason;
+		    }
+		}
 
 	}
 
@@ -11008,6 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		    rq->misfit_reason == MISFIT_PERF &&
 		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
 		    nr_running == 1)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..399b6526afab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -962,6 +962,10 @@ struct balance_callback {
 	void (*func)(struct rq *rq);
 };
 
+typedef enum misfit_reason {
+	MISFIT_PERF,		/* Requires moving to a more performant CPU */
+} misfit_reason_t;
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -1168,6 +1172,10 @@ struct rq {
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
 #endif
+
+#ifdef CONFIG_SMP
+	misfit_reason_t		misfit_reason;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.34.1

