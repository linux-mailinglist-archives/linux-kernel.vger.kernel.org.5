Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA27AD2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjIYIMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjIYIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0DD4112;
        Mon, 25 Sep 2023 01:11:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D917BDA7;
        Mon, 25 Sep 2023 01:12:28 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BAB73F5A1;
        Mon, 25 Sep 2023 01:11:48 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 14/18] PM: EM: Add performance field to struct em_perf_state
Date:   Mon, 25 Sep 2023 09:11:35 +0100
Message-Id: <20230925081139.1305766-15-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index 41290ee2cdd0..37fc8490709d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -12,6 +12,7 @@
 
 /**
  * struct em_perf_state - Performance state of a performance domain
+ * @performance:	Non-linear CPU performance at a given frequency
  * @frequency:	The frequency in KHz, for consistency with CPUFreq
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
@@ -20,6 +21,7 @@
  * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
+	unsigned long performance;
 	unsigned long frequency;
 	unsigned long power;
 	unsigned long cost;
@@ -223,14 +225,14 @@ void em_dev_unregister_perf_domain(struct device *dev);
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
@@ -262,8 +264,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long allowed_cpu_cap)
 {
 	struct em_perf_table *runtime_table;
-	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
+	unsigned long scale_cpu;
 	int cpu, i;
 
 	if (!sum_util)
@@ -290,14 +292,13 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 
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
index 78e1495dc87e..c7ad42b42c46 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
 	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
 	debugfs_create_ulong("power", 0444, d, &ps->power);
 	debugfs_create_ulong("cost", 0444, d, &ps->cost);
+	debugfs_create_ulong("performance", 0444, d, &ps->performance);
 	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
 }
 
@@ -133,6 +134,30 @@ static void em_perf_runtime_table_set(struct device *dev,
 		call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
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
@@ -317,6 +342,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].frequency = prev_freq = freq;
 	}
 
+	em_init_performance(dev, pd, table, nr_states);
+
 	ret = em_compute_costs(dev, table, cb, nr_states, flags);
 	if (ret)
 		goto free_ps_table;
-- 
2.25.1

