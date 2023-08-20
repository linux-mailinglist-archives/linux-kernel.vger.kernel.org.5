Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454ED781F79
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjHTTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjHTTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:22:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7421FC2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:17:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3196afc7d4bso2354537f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692559021; x=1693163821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi7BVaVqH9/0NVCmDDtGddZlbB0oky6sBNKDDM6FAvg=;
        b=ty9mOPcG1qrvOxzNEx6ty9AEeDVyyZIlVOikakvnj3VWxmrOC81SdeNTzpK13uje0W
         C5HfY3jvoIKNfh+SCw+7FzK6m3Rtdm74LWMGlrCaPxPA4CEYjpN4haKFqXMEhpDZIo24
         Cl3OZRl8QXUidmRJKrfe2JgSdBdVnS1wgKjU0+rj0thiSS93azFbOGwAsYqYZ6M8D6AK
         ucBmEo+WuFJNwWVE9hvGnDE5a46QEHfr/ImBmMt/im5W/7ftHkf+sAP09nDCgSHkG/k/
         0oidzOka1CAS11k3e0lqf1lbXdZ6piDPk9PdHMEfuMRUX3YivO0xa940x0yLPDCCIGI/
         V+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559021; x=1693163821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi7BVaVqH9/0NVCmDDtGddZlbB0oky6sBNKDDM6FAvg=;
        b=EF98nCC1La+UUZ6jwzi1kX41ov0Eq7N/dlhwVqSKSaLMTAuuM9kjIW2kAAp/ziECMm
         qV9z6FXK6Tx8Rs/YtT69cfSMUANGTt3QbWrmUv+iVI6yQOPX6EQVVFYqvbXPANv1Kk88
         IatOXQngDR4t/UWXwld3JWtjobw5DiW9pmIGxR6SizbOsU70RG2uqHQoVgndvzR/qrzk
         mkQuFllqiJZrEcI29vp8ayAV5YNh2FZquOdQeBX8xpUz1U8XDMd8D7Togdr9kkDXT7Y7
         QRkx5WCOxD0UEMhfbv5qOFiFb8Oei2RTdWPVXdFtGNkXnFizgVGHbP2/n/9qVrPKd/8J
         vG2w==
X-Gm-Message-State: AOJu0Ywin2bNsY7nxRUFZn+UqZxpcl1BRvzc5rcINpxxVR7exlmjifYk
        +D+yas5Lzj3BML7Cz+agD9pXkg==
X-Google-Smtp-Source: AGHT+IG6q7suIVDz5OrLi1EkT4+CNinb67PB8NucuYqb5G56jSc7NR4kUgAL/ftItQkH9LF7VQKCPA==
X-Received: by 2002:adf:ec8a:0:b0:319:790e:3bc5 with SMTP id z10-20020adfec8a000000b00319790e3bc5mr3292705wrn.41.1692559021749;
        Sun, 20 Aug 2023 12:17:01 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b00317f3fd21b7sm10125665wrv.80.2023.08.20.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:17:01 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/2] sched/fair: Remove capacity inversion detection
Date:   Sun, 20 Aug 2023 20:16:50 +0100
Message-Id: <20230820191650.532978-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820191650.532978-1-qyousef@layalina.io>
References: <20230820191650.532978-1-qyousef@layalina.io>
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

From: Vincent Guittot <vincent.guittot@linaro.org>

commit a2e90611b9f425adbbfcdaa5b5e49958ddf6f61b upstream.

Remove the capacity inversion detection which is now handled by
util_fits_cpu() returning -1 when we need to continue to look for a
potential CPU with better performance.

This ends up almost reverting patches below except for some comments:
commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230201143628.270912-3-vincent.guittot@linaro.org
(cherry picked from commit a2e90611b9f425adbbfcdaa5b5e49958ddf6f61b)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c  | 84 +++-----------------------------------------
 kernel/sched/sched.h | 19 ----------
 2 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a45ccee98ab1..612873ec2197 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4464,17 +4464,9 @@ static inline int util_fits_cpu(unsigned long util,
 	 *
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
-	 *
-	 * In case of capacity inversion we should honour the inverted capacity
-	 * for both uclamp_min and uclamp_max all the time.
 	 */
-	capacity_orig = cpu_in_capacity_inversion(cpu);
-	if (capacity_orig) {
-		capacity_orig_thermal = capacity_orig;
-	} else {
-		capacity_orig = capacity_orig_of(cpu);
-		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
-	}
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -8929,82 +8921,16 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
-	struct rq *rq = cpu_rq(cpu);
 
-	rq->cpu_capacity_orig = capacity_orig;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
 
-	rq->cpu_capacity = capacity;
-
-	/*
-	 * Detect if the performance domain is in capacity inversion state.
-	 *
-	 * Capacity inversion happens when another perf domain with equal or
-	 * lower capacity_orig_of() ends up having higher capacity than this
-	 * domain after subtracting thermal pressure.
-	 *
-	 * We only take into account thermal pressure in this detection as it's
-	 * the only metric that actually results in *real* reduction of
-	 * capacity due to performance points (OPPs) being dropped/become
-	 * unreachable due to thermal throttling.
-	 *
-	 * We assume:
-	 *   * That all cpus in a perf domain have the same capacity_orig
-	 *     (same uArch).
-	 *   * Thermal pressure will impact all cpus in this perf domain
-	 *     equally.
-	 */
-	if (sched_energy_enabled()) {
-		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd;
-
-		rcu_read_lock();
-
-		pd = rcu_dereference(rq->rd->pd);
-		rq->cpu_capacity_inverted = 0;
-
-		for (; pd; pd = pd->next) {
-			struct cpumask *pd_span = perf_domain_span(pd);
-			unsigned long pd_cap_orig, pd_cap;
-
-			/* We can't be inverted against our own pd */
-			if (cpumask_test_cpu(cpu_of(rq), pd_span))
-				continue;
-
-			cpu = cpumask_any(pd_span);
-			pd_cap_orig = arch_scale_cpu_capacity(cpu);
-
-			if (capacity_orig < pd_cap_orig)
-				continue;
-
-			/*
-			 * handle the case of multiple perf domains have the
-			 * same capacity_orig but one of them is under higher
-			 * thermal pressure. We record it as capacity
-			 * inversion.
-			 */
-			if (capacity_orig == pd_cap_orig) {
-				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
-
-				if (pd_cap > inv_cap) {
-					rq->cpu_capacity_inverted = inv_cap;
-					break;
-				}
-			} else if (pd_cap_orig > inv_cap) {
-				rq->cpu_capacity_inverted = inv_cap;
-				break;
-			}
-		}
-
-		rcu_read_unlock();
-	}
-
-	trace_sched_cpu_capacity_tp(rq);
+	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f18460f62f0..d6d488e8eb55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1041,7 +1041,6 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
-	unsigned long		cpu_capacity_inverted;
 
 	struct balance_callback *balance_callback;
 
@@ -2879,24 +2878,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
-/*
- * Returns inverted capacity if the CPU is in capacity inversion state.
- * 0 otherwise.
- *
- * Capacity inversion detection only considers thermal impact where actual
- * performance points (OPPs) gets dropped.
- *
- * Capacity inversion state happens when another performance domain that has
- * equal or lower capacity_orig_of() becomes effectively larger than the perf
- * domain this CPU belongs to due to thermal pressure throttling it hard.
- *
- * See comment in update_cpu_capacity().
- */
-static inline unsigned long cpu_in_capacity_inversion(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_inverted;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
-- 
2.34.1

