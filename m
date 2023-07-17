Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11364756F35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQV5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGQV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:57:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DAE4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so51360285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689631058; x=1692223058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO1uwXv0rKYcU5XA4mBEnIS/I8OBYJT4uTImWwVx+iU=;
        b=u5VC9bPjM31LYY49sGBAq8cfSSsUJ2m9npkn3SUXvvL4fW+is7gT4uWJq6lgN10szp
         ENKkbaj8hJM//vVfoDIbRWmu2blikdUxhGKqhYlE40qqbav3U4VoS6HeoXtSRxkN1KvD
         MWYEBQJea/s+SYzjdOZRHAlujbDJu0I3resYXVD4iBZUpuG343nMYodFuU3vixolhRC6
         +x8im6SPAZZnSsFrhvEHiYcqCNzSSZh/Mrr1s5t18cEbhqsz9uwM4Xo01uhMYKDsksaw
         HmuaDHCuyoGLGESMA/CqTLgA2om5qGPENkWdk+BGymYUj3aeHUpDuNUQldR0GDeHzpLm
         p0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631058; x=1692223058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO1uwXv0rKYcU5XA4mBEnIS/I8OBYJT4uTImWwVx+iU=;
        b=Nj0BjXSVCJ9Idx/4D2tVDCCrGaX+MYrjQBmwsuNItAfe7fW30xIlDGcE7NG0Vgdx+B
         EDgH3ahZqRT79l0ScrTBJOGBMLRGWaw5NJzqW2k2UWE6kapRFkFwg2+NJNi2dMRUO06T
         GAvNjrhfufMlB3+R4U94AJtn8CvK6cvjfmIac2P8nYDLeVKEl4nj4P/DLBBYvuoWsDwK
         Xs7uauMgaVa1zPTLDpBOVjZihuMrXQbSZ+oBu6USQLoXm4M4Ll4T839dfR6phhV1wMoA
         6FanVXsMPSwAf+5IzCLzh8AjK9g4prXm7V29df2CxIA9TSqT2oJCNXU9QVLPmG8xMV8+
         YJeA==
X-Gm-Message-State: ABy/qLba+zGpIdYG1fQ/RFDR/hjRxHiThxHGuLuSif8daNJ7HqQStnvh
        PKqPGoQILfVOpZQjh6E+x1G0aA==
X-Google-Smtp-Source: APBJJlFfofHxFcS82r5U72ZGyKbpx7Lnz/PTgxlIK/+6xOqfs/GRKZszhI7PjgLWINrbDHg1I7rOkw==
X-Received: by 2002:a7b:c85a:0:b0:3fb:b56b:470f with SMTP id c26-20020a7bc85a000000b003fbb56b470fmr405904wml.14.1689631058214;
        Mon, 17 Jul 2023 14:57:38 -0700 (PDT)
Received: from localhost.localdomain (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm671285wmc.19.2023.07.17.14.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:57:37 -0700 (PDT)
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
Subject: [PATCH v3 3/3] sched/tp: Add new tracepoint to track compute energy computation
Date:   Mon, 17 Jul 2023 22:57:17 +0100
Message-Id: <20230717215717.309174-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717215717.309174-1-qyousef@layalina.io>
References: <20230717215717.309174-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..20cc884f72ff 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_compute_energy_tp,
+	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
+	TP_ARGS(p, dst_cpu, energy));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83e36547af17..2deca2dca625 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c701f490ca4c..23e026393210 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7493,11 +7493,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 {
 	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
 	unsigned long busy_time = eenv->pd_busy_time;
+	unsigned long energy;
 
 	if (dst_cpu >= 0)
 		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
 
-	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+
+	trace_sched_compute_energy_tp(p, dst_cpu, energy);
+
+	return energy;
 }
 
 /*
-- 
2.25.1

