Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA57FD518
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjK2LJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjK2LI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 268602688;
        Wed, 29 Nov 2023 03:08:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA6802F4;
        Wed, 29 Nov 2023 03:09:23 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DF803F5A1;
        Wed, 29 Nov 2023 03:08:34 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 13/23] PM: EM: Add performance field to struct em_perf_state
Date:   Wed, 29 Nov 2023 11:08:43 +0000
Message-Id: <20231129110853.94344-14-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance doesn't scale linearly with the frequency. Also, it may
be different in different workloads. Some CPUs are designed to be
particularly good at some applications e.g. images or video processing
and other CPUs in different. When those different types of CPUs are
combined in one SoC they should be properly modeled to get max of the HW
in Energy Aware Scheduler (EAS). The Energy Model (EM) provides the
power vs. performance curves to the EAS, but assumes the CPUs capacity
is fixed and scales linearly with the frequency. This patch allows to
adjust the curve on the 'performance' axis as well.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 ++++++-----
 kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index ae3ccc8b9f44..e30750500b10 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -13,6 +13,7 @@
 
 /**
  * struct em_perf_state - Performance state of a performance domain
+ * @performance:	Non-linear CPU performance at a given frequency
  * @frequency:	The frequency in KHz, for consistency with CPUFreq
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
@@ -21,6 +22,7 @@
  * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
+	unsigned long performance;
 	unsigned long frequency;
 	unsigned long power;
 	unsigned long cost;
@@ -207,14 +209,14 @@ void em_free_table(struct em_perf_table __rcu *table);
  */
 static inline int
 em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
-			  unsigned long freq, unsigned long pd_flags)
+			  unsigned long max_util, unsigned long pd_flags)
 {
 	struct em_perf_state *ps;
 	int i;
 
 	for (i = 0; i < nr_perf_states; i++) {
 		ps = &table[i];
-		if (ps->frequency >= freq) {
+		if (ps->performance >= max_util) {
 			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
 			    ps->flags & EM_PERF_STATE_INEFFICIENT)
 				continue;
@@ -246,8 +248,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long allowed_cpu_cap)
 {
 	struct em_perf_table *runtime_table;
-	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
+	unsigned long scale_cpu;
 	int cpu, i;
 
 	if (!sum_util)
@@ -274,14 +276,13 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 
 	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
 	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
-				      freq, pd->flags);
+				      max_util, pd->flags);
 	ps = &runtime_table->state[i];
 
 	/*
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 614891fde8df..b5016afe6a19 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
 	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
 	debugfs_create_ulong("power", 0444, d, &ps->power);
 	debugfs_create_ulong("cost", 0444, d, &ps->cost);
+	debugfs_create_ulong("performance", 0444, d, &ps->performance);
 	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
 }
 
@@ -171,6 +172,30 @@ em_allocate_table(struct em_perf_domain *pd)
 	return table;
 }
 
+static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
+				struct em_perf_state *table, int nr_states)
+{
+	u64 fmax, max_cap;
+	int i, cpu;
+
+	/* This is needed only for CPUs and EAS skip other devices */
+	if (!_is_cpu_device(dev))
+		return;
+
+	cpu = cpumask_first(em_span_cpus(pd));
+
+	/*
+	 * Calculate the performance value for each frequency with
+	 * linear relationship. The final CPU capacity might not be ready at
+	 * boot time, but the EM will be updated a bit later with correct one.
+	 */
+	fmax = (u64) table[nr_states - 1].frequency;
+	max_cap = (u64) arch_scale_cpu_capacity(cpu);
+	for (i = 0; i < nr_states; i++)
+		table[i].performance = div64_u64(max_cap * table[i].frequency,
+						 fmax);
+}
+
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    struct em_data_callback *cb, int nr_states,
 			    unsigned long flags)
@@ -331,6 +356,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].frequency = prev_freq = freq;
 	}
 
+	em_init_performance(dev, pd, table, nr_states);
+
 	ret = em_compute_costs(dev, table, cb, nr_states, flags);
 	if (ret)
 		return -EINVAL;
-- 
2.25.1

