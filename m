Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494C756F33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjGQV5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:57:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A10E4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-315adee6ac8so4895176f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689631054; x=1692223054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WKkqfYoJtvShat8zNk6ttkEMMI9ZSxKElnGbDROIGI=;
        b=W7jaDxfX6dvC+U9iyxvyuDVKo6H7qavqtg2jvMoLKxBCTZuPoOHFVlTQrXCpJqDQHx
         eJvB+LYsQOvR9LSbDAeGnUnsyVHpgGmX2auYiaSbyVEzZ/lnJpRqqPGnjHqmMEZv4D3K
         Ln1PjhhZSE5GOPPwaJ6KVSfmMHxqyrfPPuHgdZ5whWwNeaLI9xSLXGLjwTjjelk8no3d
         o19XTolf2+p1x7o7QgbAbAK6KAFHuVHgHKcIkA9RdZVQDR1VHaZE7Ja3UsXDxJm0JHCK
         xHh2B7RqN/4g184BYbYuQuHms9ZcznWFKfHR+QSU4ne5Fo1Y8LOOEH/T3nFh62Pfc6pH
         u2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631054; x=1692223054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WKkqfYoJtvShat8zNk6ttkEMMI9ZSxKElnGbDROIGI=;
        b=UZlpchhJNhj/8coopl+8fsuKpAcl26KiUbfYmAGCcmDMEGpibqiuqTT7La/1XRyXxM
         nB+ndgO1BF2iK/0tL1gjkO9z9XNUV7O6WONGL1/EPGEZ8RBvCj3qCvjObYRpJ6o/7mo5
         IVGEhUkOKmTXZOrc7t5EChDZ4esQX4y+IKhcTv+Pd//OaW1BUzewGEKaiHsZVOKGnhjb
         7nJYh1AISfbtQrbFxgwNfKqdOrH2cwYVRrRhjvyaO6f8yX5O7RXL6rqbXTR0cSPNetif
         MLIBqSR83CLwZALeaGx8MJ+Sx2PB4eXS19w+fIB4QcmkSNTwAVp6xdJ2ILZOz/3yI817
         oV9w==
X-Gm-Message-State: ABy/qLZ/djRpJD1HQJqSQEFCyhbeQoDY4saqfSO9n1Qc0wOOZi2DMr9u
        oXkOA1KsLEGDPEc7BAQbW+OfrA==
X-Google-Smtp-Source: APBJJlEJ7ma3iWeaBqU0E0BUmmMCsSdwAPhhr5l1MZCJ9pVtiYL4OvhoVW1YnWii05CBeEx3Yhbu6A==
X-Received: by 2002:a05:6000:90e:b0:313:f07b:801f with SMTP id cw14-20020a056000090e00b00313f07b801fmr11440758wrb.44.1689631053851;
        Mon, 17 Jul 2023 14:57:33 -0700 (PDT)
Received: from localhost.localdomain (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm671285wmc.19.2023.07.17.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:57:33 -0700 (PDT)
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
Subject: [PATCH v3 1/3] sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
Date:   Mon, 17 Jul 2023 22:57:15 +0100
Message-Id: <20230717215717.309174-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717215717.309174-1-qyousef@layalina.io>
References: <20230717215717.309174-1-qyousef@layalina.io>
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
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0cd1cdbae534..d489eece5a0d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7596,11 +7596,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7663,7 +7662,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7675,7 +7674,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7683,7 +7682,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap > -1) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.25.1

