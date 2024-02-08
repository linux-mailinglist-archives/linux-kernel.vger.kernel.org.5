Return-Path: <linux-kernel+bounces-58007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D784E030
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E71C2663F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06337B3E1;
	Thu,  8 Feb 2024 11:56:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA87B3DC;
	Thu,  8 Feb 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393407; cv=none; b=rhAvbg7dm4cWC9VnglUoYiNvQvhaYFn00glE0aH7vE3ELYyWMiJcOM+T84SBnXg8p3V6aByFc+txsRCOb55p8TfwfIAR3ciMZf0wa5qHihvyI9Yn3ldAvXqBzhYFbuQMDxFJFJJzobTwUtGQGJy4wOmisOH8ATojT/EsTW4M7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393407; c=relaxed/simple;
	bh=WRg4wUePEUQi65klNCH4jCt1htraMOOT2ZZsRc/VHwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoMbJpLFrF6YiWA89iSbGZ6ESCdlACNdHPfohqcO+QDAcK088/vY8/lCMibz9nr31kEoUcY5HsMKTNABCV7vO4/WNBf1U+rM0EyOM+8+6GMVHqJ1iQIO4U7polWV/PxRMTJTUXDp6ULYehRcrvlQAnFW3hOSKftkz0QUqqprUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5A21FB;
	Thu,  8 Feb 2024 03:57:27 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC0ED3F5A1;
	Thu,  8 Feb 2024 03:56:41 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v8 13/23] PM: EM: Add performance field to struct em_perf_state and optimize
Date: Thu,  8 Feb 2024 11:55:47 +0000
Message-Id: <20240208115557.1273962-14-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The performance doesn't scale linearly with the frequency. Also, it may
be different in different workloads. Some CPUs are designed to be
particularly good at some applications e.g. images or video processing
and other CPUs in different. When those different types of CPUs are
combined in one SoC they should be properly modeled to get max of the HW
in Energy Aware Scheduler (EAS). The Energy Model (EM) provides the
power vs. performance curves to the EAS, but assumes the CPUs capacity
is fixed and scales linearly with the frequency. This patch allows to
adjust the curve on the 'performance' axis as well.

Code speed optimization:
Removing map_util_freq() allows to avoid one division and one
multiplication operations from the EAS hot code path.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 24 ++++++++++++------------
 kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 158dad6ea313..ce24ea3fe41c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -13,6 +13,7 @@
 
 /**
  * struct em_perf_state - Performance state of a performance domain
+ * @performance:	CPU performance (capacity) at a given frequency
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
@@ -196,25 +198,25 @@ void em_table_free(struct em_perf_table __rcu *table);
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
  * @table:		List of performance states, in ascending order
  * @nr_perf_states:	Number of performance states
- * @freq:		Frequency to map with the EM
+ * @max_util:		Max utilization to map with the EM
  * @pd_flags:		Performance Domain flags
  *
  * It is called from the scheduler code quite frequently and as a consequence
  * doesn't implement any check.
  *
- * Return: An efficient performance state id, high enough to meet @freq
+ * Return: An efficient performance state id, high enough to meet @max_util
  * requirement.
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
@@ -245,9 +247,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_table *em_table;
 	struct em_perf_state *ps;
+	unsigned long scale_cpu;
 	int cpu, i;
 
 #ifdef CONFIG_SCHED_DEBUG
@@ -260,25 +262,23 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
-	 * frequency, like schedutil. Take also into account that the real
-	 * frequency might be set lower (due to thermal capping). Thus, clamp
+	 * performance, like schedutil. Take also into account that the real
+	 * performance might be set lower (due to thermal capping). Thus, clamp
 	 * max utilization to the allowed CPU capacity before calculating
-	 * effective frequency.
+	 * effective performance.
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-	 * requested frequency.
+	 * requested performance.
 	 */
 	em_table = rcu_dereference(pd->em_table);
 	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
-				      freq, pd->flags);
+				      max_util, pd->flags);
 	ps = &em_table->state[i];
 
 	/*
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 667619b70be7..41418aa6daa6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
 	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
 	debugfs_create_ulong("power", 0444, d, &ps->power);
 	debugfs_create_ulong("cost", 0444, d, &ps->cost);
+	debugfs_create_ulong("performance", 0444, d, &ps->performance);
 	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
 }
 
@@ -159,6 +160,30 @@ struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
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
@@ -318,6 +343,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].frequency = prev_freq = freq;
 	}
 
+	em_init_performance(dev, pd, table, nr_states);
+
 	ret = em_compute_costs(dev, table, cb, nr_states, flags);
 	if (ret)
 		return -EINVAL;
-- 
2.25.1


