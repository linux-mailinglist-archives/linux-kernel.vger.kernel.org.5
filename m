Return-Path: <linux-kernel+bounces-28783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B868302FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D37287585
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975901F604;
	Wed, 17 Jan 2024 09:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071C1F610;
	Wed, 17 Jan 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485398; cv=none; b=KjxuQQxSmHLgZst+5nuMdIRgn6GKWbrilD9IUnLRfhDI32YVXNrcJqQTDSPNDwKqlHIV5/4fRObrHMR5QfqHD1S315CR8MdtLOHPbep/0uCZUWg/hJRyWnd4YIpIdx4O7qgTt7P4hJ88U0gNOESZaiULRbO4q4MxfQ0RnLqxlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485398; c=relaxed/simple;
	bh=84f7v19he9h+VGLJC7VvKsqw+c/ii3EBrHtzSfm0L+A=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=sp+XJFB7aEBT8Y5rh0ACdQnHuMxI8kC5QqzUC4NkT3Q1zCrmIAlTqIGJK12YafdW+xdiMJEgSatiS4Q3kSpe+W0ti5PLus+SX/SB5/MQ0inFkvZrD8mxfbUNZoypdNQVutHoRAu6O/ioCDdZu/GlULglGQPbB/PlL/tdCBM1HU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F80DA7;
	Wed, 17 Jan 2024 01:57:21 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E7C3F5A1;
	Wed, 17 Jan 2024 01:56:32 -0800 (PST)
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
Subject: [PATCH v7 13/23] PM: EM: Add performance field to struct em_perf_state and optimize
Date: Wed, 17 Jan 2024 09:57:04 +0000
Message-Id: <20240117095714.1524808-14-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
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

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 24 ++++++++++++------------
 kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 5ebe9dbec8e1..689d71f6b56f 100644
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
@@ -260,26 +262,24 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
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
 
 	max_util = map_util_perf(max_util);
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
index 190042640935..2a817b92804b 100644
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


