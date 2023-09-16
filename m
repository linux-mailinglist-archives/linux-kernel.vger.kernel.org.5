Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398C47A3361
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjIPXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 19:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjIPXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 19:30:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE345CD1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404314388ceso35094835e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694907010; x=1695511810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWEM5rFnaxOpgcGqQ9iXm3kgW4XrovKW3FNIx9UUP3U=;
        b=aX0OVGvG8a6WCDG1Hz5uw3UYiluU7DKtM7LcqqRaPC7q20kcZsaG3q6KimWyKqCaLP
         kGi/+c+KzTZQMjnmMH2vnBjHmv4Kx84zMDNqUT8SzqHZHl4Em5B6ev56jk7SvyXQZrR9
         WPqX7Y9TBes7u+Z8ayKNE4VvYuJMbVJRP1Lh4xnRVprv5v8XRX/XuuW9JL15miZC0vzi
         AJyQkSmVH5hfdRK3+DZnzZNqW3BegBN1Pb08eUaBSm32EyzYACz6nmKLIAR0Yu7Tol4a
         gUJTszRXy338qUC336Dv3t2sONouPtOraFMp2Qm0Id3v1FRBBgx588EFtxZ8lpxiRUun
         swUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694907010; x=1695511810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWEM5rFnaxOpgcGqQ9iXm3kgW4XrovKW3FNIx9UUP3U=;
        b=oGWSGD3JTZdyfQm1LRjS97TtuN4TZWy3EvfARTRiveut6tlp5DTJemG9lTsgftbhWS
         kRLMyct6YjtKERHvmdFTe0lJeAoIE4kF9fLAZ3RY99be6/oP6jIqv/S302Sxh8fIXcsD
         dAB4csUTFpaRSuAlXLvU/sxolw+vgKClft12/m/ILqt0wfCXWfMPDQXuDcXsXMhC668H
         WUbF8yNbRlvcQN2mLJIacC9vTyHCBhR6YaL58GMSSITZHlS7dSLSdWiKrHzlckp2vVA3
         HwwYjjf8RDf37Qa6CL7GSRRgyFYEeB8rK2nT1n/X7uUpX8aXPXCJT6NXfCv9Fo8J5P9+
         UAJg==
X-Gm-Message-State: AOJu0YxlWo5aqNQtwGVhIXQoTgBpcIzA6OEc1shfmkbKNrxTDORZZU7G
        ZR+ajUPd3zeaXrP/E/oWuCChzg==
X-Google-Smtp-Source: AGHT+IH8zt9b/coOQ/xxZj95zGbY/KfbY9VgHNql/0TMbF0y5DIMj6gMNv9nWvsWMlFWXyyAhIvdwQ==
X-Received: by 2002:a1c:7407:0:b0:3fd:30cb:18bd with SMTP id p7-20020a1c7407000000b003fd30cb18bdmr4936651wmc.15.1694907009520;
        Sat, 16 Sep 2023 16:30:09 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm11203929wmi.18.2023.09.16.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 16:30:09 -0700 (PDT)
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
Subject: [PATCH v5 1/3] sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
Date:   Sun, 17 Sep 2023 00:29:53 +0100
Message-Id: <20230916232955.2099394-2-qyousef@layalina.io>
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
	cpu_cap = capacity_of(cpu) - cpu_util(p);  // 0 if cpu_util(p) is high

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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c893721ff5b1..3a0a28a0b9c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7695,11 +7695,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7762,7 +7761,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7774,7 +7773,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7782,7 +7781,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap > -1) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1

