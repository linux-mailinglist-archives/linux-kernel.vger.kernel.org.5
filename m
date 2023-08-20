Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE017781FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjHTUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjHTUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:39:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF0044AF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:35:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso26557555e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692563673; x=1693168473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9P6jTOQpBkQFA/SbLjJepbgBUVm2umow+9EJLXSIz8w=;
        b=fvG+qXNlC0ttKjXfoQEpMdOAl4OmEm+JTxgfRalg87K+VqOhGVgm++brDLl3nm7pms
         +8RGjpFBsdEH2AYGuWVaKWs29b6OM+6P++7xkmbcb82qz4gEqNyJa6NcI2TOu7eMP1au
         +u2enarqE8Wk6ZHKzW0IvFzsctgoBFX0JfDCtNlocKAA4RD9MgMrXk0+USqMbQZkEM23
         zhNh/rHqTdDOmHzZhkpVkJYF93ir/JIyOfFMLWnZn3axOnwyiPJtADQWVbBxah0oyzZR
         6NkDy89GwgOeLSTmneZohlo0lfzlJsZ6cQbuHzvQXpQulSR4zEuh2s5kBuqmqwprzd/V
         kGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563673; x=1693168473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9P6jTOQpBkQFA/SbLjJepbgBUVm2umow+9EJLXSIz8w=;
        b=dpuBmvWDw6ZMR8pNFPeD7NXJwn6cfkX1xE75MtrG5ztpcldNa5HiRTc+Wm9cbeiV67
         fHN3ly52zqQpDEeBTOqV51YkrMAemKKIg2NjPLo+lK+WMZwkkWuD/Hu1ZmOTbtWziO6N
         3JtY5d66zKTKqY3Nqwp81oTbsoyZS9pSRGrNd75eXtEBsmZ12kvg+IOtP8Qq6wJAQNJ0
         Pxrtuj7tHHiyc1PQ4z7dj1sbyflm+SD3/C3kyiJTCdU5QlldNDYUODl7/hnlianLfvAi
         93Ck1V1uXdediw9wJde9BkwpM6fzCnK2oAeAUTE3JeqrSXrM9VVuO5PdaHGfg2sWKNgI
         qLnQ==
X-Gm-Message-State: AOJu0YynfFVIjKMjoIya8JU4qZxqRnPPhIUv801gnLraXjKyBwMp/3lJ
        48ENfzn/47Y+auSh/RUqOKroDm6QhXinjqigRdg=
X-Google-Smtp-Source: AGHT+IGIqQyLFmJNNo51zRDGuyb4LlOxdvImF/Ifv3uE4zghJ1zcBM7fThwtq+R87II2WO2x5LIxJw==
X-Received: by 2002:a1c:f716:0:b0:3fb:df34:176e with SMTP id v22-20020a1cf716000000b003fbdf34176emr3410013wmh.31.1692563672854;
        Sun, 20 Aug 2023 13:34:32 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003fbca942499sm13570714wme.14.2023.08.20.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 13:34:32 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] sched/fair: Check a task has a fitting cpu when updating misfit
Date:   Sun, 20 Aug 2023 21:34:29 +0100
Message-Id: <20230820203429.568884-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

If a misfit task is affined to a subset of the possible cpus, we need to
verify that one of these cpus can fit it. Otherwise the load balancer
code will continuously trigger needlessly leading the balance_interval
to increase in return and eventually end up with a situation where real
imbalances take a long time to address because of this impossible
imbalance situation.

This can happen in Android world where it's common for background tasks
to be restricted to little cores.

Similarly if we can't fit the biggest core, triggering misfit is
pointless as it is the best we can ever get on this system.

To speed the search up, don't call task_fits_cpu() which will repeatedly
call uclamp_eff_value() for the same task. Call util_fits_cpu() instead.
And only do so when we see a cpu with higher capacity level than
passed cpu_of(rq).

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..f08c5f3bf895 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4853,17 +4853,50 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	unsigned long uclamp_min, uclamp_max;
+	unsigned long util, cap_level;
+	bool has_fitting_cpu = false;
+	int cpu = cpu_of(rq);
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	if (!p || p->nr_cpus_allowed == 1)
+		goto out;
 
-	if (task_fits_cpu(p, cpu_of(rq))) {
-		rq->misfit_task_load = 0;
-		return;
+	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	util = task_util_est(p);
+
+	if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
+		goto out;
+
+	cap_level = capacity_orig_of(cpu);
+
+	/* If we can't fit the biggest CPU, that's the best we can ever get. */
+	if (cap_level == SCHED_CAPACITY_SCALE)
+		goto out;
+
+	/*
+	 * If the task affinity is not set to default, make sure it is not
+	 * restricted to a subset where no CPU can ever fit it. Triggering
+	 * misfit in this case is pointless as it has no where better to move
+	 * to. And it can lead to balance_interval to grow too high as we'll
+	 * continuously fail to move it anywhere.
+	 */
+	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
+		for_each_cpu(cpu, p->cpus_ptr) {
+			if (cap_level < capacity_orig_of(cpu)) {
+				cap_level = capacity_orig_of(cpu);
+				if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0) {
+					has_fitting_cpu = true;
+					break;
+				}
+			}
+		}
+
+		if (!has_fitting_cpu)
+			goto out;
 	}
 
 	/*
@@ -4871,6 +4904,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	 * task_h_load() returns 0.
 	 */
 	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
+	return;
+out:
+	rq->misfit_task_load = 0;
 }
 
 #else /* CONFIG_SMP */
-- 
2.34.1

