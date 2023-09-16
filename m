Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0047A3362
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjIPXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjIPXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 19:30:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4829CD5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so38229645e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694907013; x=1695511813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvpHqEWL9tMeSEEzcenarEoP8GnGGnnH5tB09ndPi7w=;
        b=212WK3aKLXkp/Ji6htbdVwyWND4jzTXqmQxi0i+zI1H9DPa0Fj1gBl5MGtWPD3DuVs
         ctKF9oXotBhTigLzIwENut93eKCeaLDhffu81gcKquas7Le5Ad3RUy0Q0YfoqCz7TeDa
         9ybxNXyoqDRbtokMndlh5UalyGbKgINz3szXaJwJ7n8ciepy2pJ8Bx20O2Z7GAnttnxn
         2FfFLl7IF3lw2de2v6hu2IE5V+14lxfpnVy40mwwnUKt8tlQE7VM62yhW0DSAO1m+Dfn
         B16LfRx2dLOeMB8eITJAzlydgZl+SNnB3YcDmQ3aoRA1aLyg/MmrSSdSJ4qbCqnMF4yc
         6A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694907013; x=1695511813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvpHqEWL9tMeSEEzcenarEoP8GnGGnnH5tB09ndPi7w=;
        b=J5ucWGRUAKyzQMezRLD5Tt1q3yxEbOFD9zRQgOpMcSntKmSxi8O2gBkTWQTE6U1j+J
         skfInh1l6HJLFxRmxodFwi9kqHPfhEy3hZ8R+GRubwCPt1PlDQsf7VPyfEqUCZHHjjDK
         FWu61oDuYAYu4/YfTRqzKw+4dnDc6gddModKNAWMcbEjsd3FJI4vGZsSa9FqeZ5Vph0A
         Bxh1CVdqpGSghtTGw7rlGBYAh21tYJV2sCKHa67GMUNMlGwu3ELyDlyWEYYdyu833JWC
         cQFD9pyuEOn/rkahJybOy+1F/KKNNlk9/0JuXbDSFzKupRGhvJwXx8R49p07E0aMGGLR
         KbEA==
X-Gm-Message-State: AOJu0YxcsS/YLka1aNZHXgkVnzLPMNmkQOgOyZm0+0trXwPsaOSbOhyY
        G1BDyTRGXLv5dE25350CzjTXjg==
X-Google-Smtp-Source: AGHT+IGJaftLGOz56YNHXpoJKuj24Fzr5v2Elkfs4cvzy8dqPeKRUBAW5iVc1kJAXF0umJTJC6K+Uw==
X-Received: by 2002:a7b:cd0b:0:b0:401:d947:c8a9 with SMTP id f11-20020a7bcd0b000000b00401d947c8a9mr4506416wmj.19.1694907013344;
        Sat, 16 Sep 2023 16:30:13 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm11203929wmi.18.2023.09.16.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 16:30:13 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 3/3] sched/tp: Add new tracepoint to track compute energy computation
Date:   Sun, 17 Sep 2023 00:29:55 +0100
Message-Id: <20230916232955.2099394-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916232955.2099394-1-qyousef@layalina.io>
References: <20230916232955.2099394-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..a13d5d06be9d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,11 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_compute_energy_tp,
+	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy,
+		 unsigned long max_util, unsigned long busy_time),
+	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f39482d6a6e6..cc87627a7c63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d0582e02409..fd7fd7b5aef2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7592,11 +7592,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 {
 	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
 	unsigned long busy_time = eenv->pd_busy_time;
+	unsigned long energy;
 
 	if (dst_cpu >= 0)
 		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
 
-	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+
+	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
+
+	return energy;
 }
 
 /*
-- 
2.34.1

