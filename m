Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9D782013
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjHTVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjHTVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:08:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB32346BF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c3726cc45so614633f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565685; x=1693170485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIPeq0k+JV1/cJi07cu7HqrUCm18GlZjB51v4GbQCSk=;
        b=oitvAfMTAL2TAzCpYa9n1HXigQmMES6+P4QDHTX71Tt0ktjQnBddDi2qMOk+f7RKtp
         ftHLz7jUn22Q0Qi2lP5zE50K8EwsYA/iu/rI+MEBXwzkdlDx6+tH47K4jEBzf39iYX0f
         uUWONXWXUi0RSZox/2hr0t+D2+j8xBXoExHBcQCkApZJ7DVcjD4C27lTe/soYgGB1LpL
         QPbkvnQ3/RSVFu3HnJUIp42wHIHHoMqV1N3P0s5jixalznezKx2uIJ0MYBwH3NMY3RFi
         29EJu0ZIg97o+uN1lU0i6EtiayWkizBVlggSfFJDE8MS1Z5NiMD+vEvUYxl0NS4cz9v2
         Oygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565685; x=1693170485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIPeq0k+JV1/cJi07cu7HqrUCm18GlZjB51v4GbQCSk=;
        b=A+zGKOA5n6iyvW6PZYFcVrmQxvoKhiC1nhgTBXh/yngUqC9au+4c3qLiF9UFcny+sE
         2+bL/g9VVNIjO/Wrw0y9lIzOEcE8OC/b5pyK36MUl2GUnt02E91dTQqJL7NDQHnYsw5A
         XJBUbhVp4UKhMaX5dZBwE4AQEJGNf0Gyzqh7JtpnmxznZA1fhvEnppwE4W79Ykt1VCyx
         mfF3+Kv6RsK9+GphaoGeXKK5RRGtlV1JY4AyfnIVcX7lOoQE8l9KK2y5m7s5TYnEtoOX
         4xAYXWx+5lhwUkXRtdHEmmYFCPTYu0PHfJlAdVGjz29XGGk5vrV/e4d65c/bJccfYqi2
         lSTQ==
X-Gm-Message-State: AOJu0Yy1y4Udpg5Q6sfrr2Gjo4TOR6yXk41ggNT0VfxfjgmBw0mjqGMa
        8FeUmptORySGOb10Kb6i0e+/zg==
X-Google-Smtp-Source: AGHT+IFmFD8f6fkzSvJchuznRWY9tDHKmOC6fE/r10rQ8Sa0lLB9+P3BHUwp0xhJBhBHNvoAvdlxXg==
X-Received: by 2002:adf:ee41:0:b0:31a:e772:ddf0 with SMTP id w1-20020adfee41000000b0031ae772ddf0mr3826175wro.53.1692565684931;
        Sun, 20 Aug 2023 14:08:04 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j6-20020adfea46000000b003197a4b0f68sm10336800wrn.7.2023.08.20.14.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:08:04 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping uclamp constraints
Date:   Sun, 20 Aug 2023 22:06:38 +0100
Message-Id: <20230820210640.585311-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820210640.585311-1-qyousef@layalina.io>
References: <20230820210640.585311-1-qyousef@layalina.io>
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

DVFS headroom is applied after we calculate the effective_cpu_util()
which is where we honour uclamp constraints. It makes more sense to
apply the headroom there once and let all users naturally get the right
thing without having to sprinkle the call around in various places.

Before this fix running

	uclampset -M 800 cat /dev/zero > /dev/null

Will cause the test system to run at max freq of 2.8GHz. After the fix
it runs at 2.2GHz instead which is the correct value that matches the
capacity of 800.

Note that similar problem exist for uclamp_min. If util was 50, and
uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
constraints, we'll end up with util of 125 instead of 100. IOW, we get
boosted twice, first time by uclamp_min, and second time by dvfs
headroom.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 11 ++++++++---
 kernel/sched/cpufreq_schedutil.c |  5 ++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 6ebde4e69e98..adec808b371a 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
 
-	max_util = apply_dvfs_headroom(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..441d433c83cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7439,8 +7439,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
+	if (type == FREQUENCY_UTIL) {
+		util = apply_dvfs_headroom(util);
 		util = uclamp_rq_util_with(rq, util, p);
+	}
 
 	dl_util = cpu_util_dl(rq);
 
@@ -7471,9 +7473,12 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 *              max - irq
 	 *   U' = irq + --------- * U
 	 *                 max
+	 *
+	 * We only need to apply dvfs headroom to irq part since the util part
+	 * already had it applied.
 	 */
 	util = scale_irq_capacity(util, irq, max);
-	util += irq;
+	util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
 
 	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
@@ -7486,7 +7491,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * an interface. So, we only do the latter for now.
 	 */
 	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
+		util += apply_dvfs_headroom(cpu_bw_dl(rq));
 
 	return min(max, util);
 }
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 916c4d3d6192..0c7565ac31fb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -143,7 +143,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
-	util = apply_dvfs_headroom(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -406,8 +405,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
-	cpufreq_driver_adjust_perf(sg_cpu->cpu, apply_dvfs_headroom(sg_cpu->bw_dl),
-				   apply_dvfs_headroom(sg_cpu->util), max_cap);
+	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_dl,
+				   sg_cpu->util, max_cap);
 
 	sg_cpu->sg_policy->last_freq_update_time = time;
 }
-- 
2.34.1

