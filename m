Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433947BB513
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjJFKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjJFKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:25:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCFF0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:25:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b6559cbd74so363689366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587926; x=1697192726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+aqieBeajZqXqrHGSLGPwvAfw8jp36eyQhM3e2OWuQ=;
        b=arLpI4ZvA9HbziYwndJNYvnsbJF5SUUaPfgl2uHNYVTH0W4096vV9YltxdQ6NNDW67
         k0vIHMDZQEG+ojUCoroXn0tuoM5OHeDD/9HaXVArhcFAkzvsBIXI+MNEx7okIdMN5d3J
         WjSRIvcIjSfb9MQ1CJwSHlvKIFHalLSrAMxs76WCIrcbumMAvEpUSh+n19EXtcx00wYX
         csq5YZMmTRA47LoMwT39siekVymssvLDPaN94gF52Mr2xfLEQu1yRjWoylQBbSLjNReP
         +dKTuxMkoZzf55LpwpHlUsW7kkdxJxtFjiRzCkNIviFs7ixBzJ7R89bOGL7R1u7zN0Bh
         Ms6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587926; x=1697192726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+aqieBeajZqXqrHGSLGPwvAfw8jp36eyQhM3e2OWuQ=;
        b=PNc6lCd8cQlfqfUflt9MdDQRHT+00cDcxr4kIWnIVsGv1PnRxHvFUyqthbAiEHO47I
         OO4B3zGKF/mRqfv27a4Isk47Os43pc/dCRKqqD03TdW8s93nwDKFPMKoBUIN8r0oRdLE
         4OPplxoZCuBmYSpOQImJvmXEJKyRbJRGlMGGFJA+EHjYl34PF/SGf91YwSNlC89F5WGb
         Wj3aiQ2OrME4d7T2sIYEIhfHPXnA1QyoY9uL8GKFYyP0phThMRxxIypKH6VnKZQk75O9
         uxPmfhvS14usR+hvL5NQmX20D7nZCLWkVuC9jBG1xMOauWXPtDz1pOiJk+dSz90IYsxE
         zD2Q==
X-Gm-Message-State: AOJu0Yxr8tf4oO8IREfPX+uIoDOpOPp8iAb/LmGeZVfzOMru2OzwvaKU
        gAs0r0ZIMlY67JYh8icklHuvvcIN7Tg=
X-Google-Smtp-Source: AGHT+IGq+o79zXvAgTJ4T6XqLuy6FcjiPSOiYrvTwOfpOVwTgHXDDGl9PRC+aEBUd2G7ONwmVXPXCA==
X-Received: by 2002:a17:906:19b:b0:9a5:c9a8:1816 with SMTP id 27-20020a170906019b00b009a5c9a81816mr6908095ejb.58.1696587925630;
        Fri, 06 Oct 2023 03:25:25 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009b957d5237asm2613502ejc.80.2023.10.06.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:25:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/3] sched/nohz: Update idle load-balancing (ILB) comments
Date:   Fri,  6 Oct 2023 12:25:16 +0200
Message-Id: <20231006102518.2452758-2-mingo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006102518.2452758-1-mingo@kernel.org>
References: <20231006102518.2452758-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix incorrect/misleading comments,

 - clarify some others,

 - fix typos & grammar,

 - and use more consistent style throughout.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fbcbda97d5..8435179779e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11547,14 +11547,15 @@ static inline int on_null_domain(struct rq *rq)
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
- * idle load balancing details
- * - When one of the busy CPUs notice that there may be an idle rebalancing
+ * NOHZ idle load balancing (ILB) details:
+ *
+ * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED not set
+ *
+ * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
  *   anywhere yet.
  */
-
 static inline int find_new_ilb(void)
 {
 	int ilb;
@@ -11575,8 +11576,10 @@ static inline int find_new_ilb(void)
 }
 
 /*
- * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
- * idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
+ * SMP function call (IPI).
+ *
+ * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
@@ -11604,7 +11607,7 @@ static void kick_ilb(unsigned int flags)
 
 	/*
 	 * This way we generate an IPI on the target CPU which
-	 * is idle. And the softirq performing nohz idle load balance
+	 * is idle, and the softirq performing NOHZ idle load balancing
 	 * will be run before returning from the IPI.
 	 */
 	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
@@ -11633,7 +11636,7 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	/*
 	 * None are in tickless mode and hence no need for NOHZ idle load
-	 * balancing.
+	 * balancing:
 	 */
 	if (likely(!atomic_read(&nohz.nr_cpus)))
 		return;
@@ -11655,9 +11658,8 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		/*
-		 * If there's a CFS task and the current CPU has reduced
-		 * capacity; kick the ILB to see if there's a better CPU to run
-		 * on.
+		 * If there's a runnable CFS task and the current CPU has reduced
+		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
@@ -11709,11 +11711,11 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (sds) {
 		/*
 		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
+		 * increase the overall cache utilization), we need a less-loaded LLC
+		 * domain to pull some load from. Likewise, we may need to spread
 		 * load within the current LLC domain (e.g. packed SMT cores but
 		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
+		 * the others are - so just get a NOHZ balance going if it looks
 		 * like this LLC domain has tasks we could move.
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
-- 
2.39.2

