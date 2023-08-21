Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A567835EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjHUWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHUWpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:45:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994E611C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fee51329feso14800255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692657933; x=1693262733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzq7IbgBFvXakSTDpDD8sUuiaW62Itouod8nHWu/KrQ=;
        b=njsObfMPbLtoGjA7l4l+mCRF58/BRFLm3RNAL11cjYI+ph5M0gG453YGPdLJYY/t1r
         KJdfaKGef0nkVGD8f4bJ9xbOI2j87eEpraaVi63SlKQOw9tBFqtPxZ56BBFEtykNjzt2
         ywSB9d7GE7eCbjr7FrWa/e2Ra8HH0sgHN/OpxVhKWl84bJcCi67NHLkCGf/uvLkwzaqv
         /KqUPDZNb93Peu4Hgbm7DmDxyflBC/HWMEtgkDGisYeXFZnetsDbpi5fOBYjjfIgbS43
         rEMLV7+QC/ttQjTfqzeF3TfE3Zo+bu0uxkHgOub2BjdVG6lZEZkBh2M7S2E1VOIcmGPb
         Spsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692657933; x=1693262733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzq7IbgBFvXakSTDpDD8sUuiaW62Itouod8nHWu/KrQ=;
        b=lPtxbY7mza5eqXtdha+jG633u+BB7XVjCYozqsj7PDvBMC2a/3dFWQRrIk6dKcz1Rt
         b6lIPLHTGmKcCj6TqJjoZPuX1GtzTgdVp7iXksHj+udzvLoCC8Z1xX3d0RKfZzUq2Iij
         Eo7wfGiICCNrx6jpYDxxWgnEeo/uHpA12WXfp3aVnlt96fcS8tiplyZtgML7dk/0QDI3
         2UcX5XHR/j4WMQruZ7QC7+6ORZq4hyTSe4fNqdv4NrTr7ZpdKVpCMicJR6IhQGIanGwO
         GS3aVHNDiHg0CZaqnpU+xWN8tuqsaKaA+eOTBmqJgwA4D3jpV4tMNB8Li6oB0D0qccA9
         A0rA==
X-Gm-Message-State: AOJu0Yx0yOzcOY+IJUMGdsteGuso+BadYTLqyzh5ih6yzsz4q5s2To1L
        U+JL1IKE9FM+qBqRkMGbqaRjFL37QMpuDYL1pJQ=
X-Google-Smtp-Source: AGHT+IHfRxXvJnAknB81a8TAJT4sx6xhy1IfGtec2IhtQak9V5VTrKQvhGobVueM0Gtx716z/RSvfw==
X-Received: by 2002:a05:600c:2e51:b0:3f9:b867:4bb with SMTP id q17-20020a05600c2e5100b003f9b86704bbmr5935676wmf.2.1692657933204;
        Mon, 21 Aug 2023 15:45:33 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b0031981c500aasm13820788wrx.25.2023.08.21.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:45:32 -0700 (PDT)
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
Subject: [PATCH v4 1/3] sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
Date:   Mon, 21 Aug 2023 23:45:02 +0100
Message-Id: <20230821224504.710576-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821224504.710576-1-qyousef@layalina.io>
References: <20230821224504.710576-1-qyousef@layalina.io>
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

When uclamp_max is being used, the util of the task could be higher than
the spare capacity of the CPU, but due to uclamp_max value we force fit
it there.

The way the condition for checking for max_spare_cap in
find_energy_efficient_cpu() was constructed; it ignored any CPU that has
its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
hence ending up never performing compute_energy() for this cluster and
missing an opportunity for a better energy efficient placement to honour
uclamp_max setting.

	max_spare_cap = 0;
	cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high

	...

	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit

	...

	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
	if (cpu_cap > max_spare_cap) {
		max_spare_cap = cpu_cap;
		max_spare_cap_cpu = cpu;
	}

prev_spare_cap suffers from a similar problem.

Fix the logic by converting the variables into long and treating -1
value as 'not populated' instead of 0 which is a viable and correct
spare capacity value. We need to be careful signed comparison is used
when comparing with cpu_cap in one of the conditions.

Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..5da6538ed220 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7707,11 +7707,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
-		unsigned long cur_delta, max_spare_cap = 0;
+		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long prev_spare_cap = 0;
+		unsigned long cur_delta, base_energy;
 		int max_spare_cap_cpu = -1;
-		unsigned long base_energy;
 		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
@@ -7774,7 +7773,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7786,7 +7785,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7794,7 +7793,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap > -1) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1

