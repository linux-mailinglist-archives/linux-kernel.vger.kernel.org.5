Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE9781E98
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHTPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjHTPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:25:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C83AB8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:21:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee17aebc8so12204425e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544912; x=1693149712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPjb9X+iW100sHXDLNl7mCpjYd6b3DTbRET67T+y9tc=;
        b=KlQWPqufkUeiyXTjvp8nHpE9RRtahNKjSEHnuBtoTMA7pOXuuVLDkTV9dRQUWIlZ1R
         cVyko8RBwlE0MOcAzGSPeI1bE9fLPjgNaaS+QyyJ6oj/FkLPE2W0BTgYLPwPmPh8vqH1
         dqMuL6BXP8dhKEgvVvs5Piy947BFLYs/2dJ9DHpc6uzMTRcjNFqyfS5OcqrCzkUS31kr
         BHdcxPJJ+BFpA2jnKk/eYWOOwNy/711uvPCgI+qGrNz3Mpp68yfWVNdNZ4db7eTbPd4t
         aJDpU0sNMhXirnAmnL08ufV5YqQUb37SCSaSHbj+7PbnYPZ9LXYdQLxOUJ/21dS1mI2u
         fyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544912; x=1693149712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPjb9X+iW100sHXDLNl7mCpjYd6b3DTbRET67T+y9tc=;
        b=JNgBi4Jeoa1EspxyYUBNJo9rpSlAIVfvog9wiHt2DysXIq9moTmrdCetaUxOJQoPJr
         b4mUJT0SZKOptaRZ8eZgTzI7J7A3OhRQ2pKEmbu0DrVErXCS5xz7POpezqY0mQfHZlbh
         7gRjncBwitQ5mete1U075z316YQTxfMqYuxccuMQLL5uiKSaKGKNTTPQaeiVyUIaANyb
         GJAPcw7FSskvlDX5ONJVD1IdSoKSq78v+ejlbGSg98+t6P4KEJ38tSpqGUbl7WnRuvKy
         7DvwkL6L3js62rrXwGW5A0j8ljzzAdVH/B5no1P8xisv1KD338GZCPuD2U06sLnhZND6
         octA==
X-Gm-Message-State: AOJu0Yx6HT4aBdrOzJgXrdpCEnOcHZVfse8CF17lWB0ZYX2ycJdfLV19
        NgOUeYsMbCnIOhhG+QvzyP3c4y1ftnYVU1EgCzE=
X-Google-Smtp-Source: AGHT+IE+l+uqFWWVAvWszCcZJINNFwmvAJJkE/qs7LHOqCwZmXG95ckzMiAuVFRnVhjuhJdd94Ed3g==
X-Received: by 2002:a05:600c:214a:b0:3fc:a8:dc3c with SMTP id v10-20020a05600c214a00b003fc00a8dc3cmr3438849wml.37.1692544912568;
        Sun, 20 Aug 2023 08:21:52 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003fe3674bb39sm9762497wms.2.2023.08.20.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:21:52 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
Date:   Sun, 20 Aug 2023 16:21:41 +0100
Message-Id: <20230820152144.517461-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152144.517461-1-qyousef@layalina.io>
References: <20230820152144.517461-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit 6c24849f5515e4966d94fa5279bdff4acf2e9489 upstream.

Qais reported that iterating over all tasks when rebuilding root domains
for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume).

To fix the problem keep track of the number of DEADLINE tasks belonging
to each cpuset and then use this information (followup patch) to only
perform the above iteration if DEADLINE tasks are actually present in
the cpuset for which a corresponding root domain is being rebuilt.

Reported-by: Qais Yousef (Google) <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 6c24849f5515e4966d94fa5279bdff4acf2e9489)
[Fix conflicts in kernel/cgroup/cpuset.c and kernel/sched/deadline.c due
to pulling new fields and functions. Remove new code and match the patch
diff.]
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/cpuset.h  |  4 ++++
 kernel/cgroup/cgroup.c  |  4 ++++
 kernel/cgroup/cpuset.c  | 25 +++++++++++++++++++++++++
 kernel/sched/deadline.c | 13 +++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 3261a45f97d1..b70224370832 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
@@ -178,6 +180,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 70ed21607e47..11400eba6124 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -56,6 +56,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6326,6 +6327,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(cgroup_task_freeze(tsk)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8f31ed881938..fa8684c790a9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -161,6 +161,12 @@ struct cpuset {
 	 */
 	int use_parent_ecpus;
 	int child_ecpus_count;
+
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
 };
 
 /*
@@ -206,6 +212,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -2172,6 +2192,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_deadline_tasks++;
+			cpuset_attach_old_cs->nr_deadline_tasks--;
+		}
 	}
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59cb3e8a613..7d66c31db46c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,7 @@
  */
 #include "sched.h"
 #include "pelt.h"
+#include <linux/cpuset.h>
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -2417,6 +2418,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
+	/*
+	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
+	 * keep track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	dec_dl_tasks_cs(p);
+
 	if (!task_on_rq_queued(p)) {
 		/*
 		 * Inactive timer is armed. However, p is leaving DEADLINE and
@@ -2457,6 +2464,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
+	 * track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	inc_dl_tasks_cs(p);
+
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
-- 
2.34.1

