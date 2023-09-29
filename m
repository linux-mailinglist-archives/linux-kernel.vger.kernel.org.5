Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E992A7B2DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjI2Ijd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2IjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:39:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A8CD7;
        Fri, 29 Sep 2023 01:39:03 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695976741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRW/hqRHf5LlVXHE8len/87TPg1FH9QryvIRGHSwRFI=;
        b=O4Xx6GlsoST6ueBkLI0J+Gt+eAGyZpHIawWS0LQhzIgKQ6CzGMhZNJ457o5nLKJ4Fd3q6x
        xNThyZ/G1G0CKW5Wr7SehJchHgaRwz744zFvbfMNqvdVlx3eN+CKQdDlACOzDkIl9JghGs
        gPSwLhCIcZ6rBqUQaHCQZOOiR78R+1cUg6ixr9qCQ7OhfS61mVBpM3BqRnoYazNE2OV9SW
        QB3SIAvjiO7sJ1yLxSpJRM0XxFOAiIsFFX5rgRerX+E9DlZhuqqBXf0CslPOkGyjE185jy
        uegaBuVIq9D8r50o84Ybe6vibJssWoSAYkxmHZVi0r6TcNvpBSTh4iaRiZKVyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695976741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRW/hqRHf5LlVXHE8len/87TPg1FH9QryvIRGHSwRFI=;
        b=WAlnZPKiG6mEcVuM3g2czbc5gymC1kdQkqV9+ZKVfpILlMWVAlBtD2VFaHb0oYU4KZVCME
        vsJgb07FqwAHaWDw==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Add new tracepoint to track compute
 energy computation
Cc:     "Qais Yousef (Google)" <qyousef@layalina.io>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230916232955.2099394-4-qyousef@layalina.io>
References: <20230916232955.2099394-4-qyousef@layalina.io>
MIME-Version: 1.0
Message-ID: <169597674098.27769.16189468145683453028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     15874a3d27e6405e9d17595f83bd3ca1b6cab16d
Gitweb:        https://git.kernel.org/tip/15874a3d27e6405e9d17595f83bd3ca1b6cab16d
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 17 Sep 2023 00:29:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Sep 2023 10:29:18 +02:00

sched/debug: Add new tracepoint to track compute energy computation

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230916232955.2099394-4-qyousef@layalina.io
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a6..a13d5d0 100644
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
index 84881a5..324980e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 284b0ab..e2a69af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7600,11 +7600,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
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
