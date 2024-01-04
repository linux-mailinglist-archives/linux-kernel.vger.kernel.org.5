Return-Path: <linux-kernel+bounces-17019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB382473B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED183B21E96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1C28DB1;
	Thu,  4 Jan 2024 17:15:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C731735;
	Thu,  4 Jan 2024 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84A1E153B;
	Thu,  4 Jan 2024 09:16:17 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EAD93F64C;
	Thu,  4 Jan 2024 09:15:29 -0800 (PST)
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
	wvw@google.com
Subject: [PATCH v6 15/23] PM: EM: Optimize em_cpu_energy() and remove division
Date: Thu,  4 Jan 2024 17:15:45 +0000
Message-Id: <20240104171553.2080674-16-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104171553.2080674-1-lukasz.luba@arm.com>
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Model (EM) can be modified at runtime which brings new
possibilities. The em_cpu_energy() is called by the Energy Aware Scheduler
(EAS) in its hot path. The energy calculation uses power value for
a given performance state (ps) and the CPU busy time as percentage for that
given frequency.

It is possible to avoid the division by 'scale_cpu' at runtime, because
EM is updated whenever new max capacity CPU is set in the system.

Use that feature and do the needed division during the calculation of the
coefficient 'ps->cost'. That enhanced 'ps->cost' value can be then just
multiplied simply by utilization:

pd_nrg = ps->cost * \Sum cpu_util

to get the needed energy for whole Performance Domain (PD).

With this optimization and earlier removal of map_util_freq(), the
em_cpu_energy() should run faster on the Big CPU by 1.43x and on the Little
CPU by 1.69x (RockPi 4B board).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 54 ++++++++++--------------------------
 kernel/power/energy_model.c  |  7 ++---
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8abdf3119afd..4a39825d3479 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -115,27 +115,6 @@ struct em_perf_domain {
 #define EM_MAX_NUM_CPUS 16
 #endif
 
-/*
- * To avoid an overflow on 32bit machines while calculating the energy
- * use a different order in the operation. First divide by the 'cpu_scale'
- * which would reduce big value stored in the 'cost' field, then multiply by
- * the 'sum_util'. This would allow to handle existing platforms, which have
- * e.g. power ~1.3 Watt at max freq, so the 'cost' value > 1mln micro-Watts.
- * In such scenario, where there are 4 CPUs in the Perf. Domain the 'sum_util'
- * could be 4096, then multiplication: 'cost' * 'sum_util'  would overflow.
- * This reordering of operations has some limitations, we lose small
- * precision in the estimation (comparing to 64bit platform w/o reordering).
- *
- * We are safe on 64bit machine.
- */
-#ifdef CONFIG_64BIT
-#define em_estimate_energy(cost, sum_util, scale_cpu) \
-	(((cost) * (sum_util)) / (scale_cpu))
-#else
-#define em_estimate_energy(cost, sum_util, scale_cpu) \
-	(((cost) / (scale_cpu)) * (sum_util))
-#endif
-
 struct em_data_callback {
 	/**
 	 * active_power() - Provide power at the next performance state of
@@ -249,8 +228,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	struct em_perf_table *em_table;
 	struct em_perf_state *ps;
-	unsigned long scale_cpu;
-	int cpu, i;
+	int i;
 
 #ifdef CONFIG_SCHED_DEBUG
 	WARN_ONCE(!rcu_read_lock_held(), "EM: rcu read lock needed\n");
@@ -267,9 +245,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * max utilization to the allowed CPU capacity before calculating
 	 * effective performance.
 	 */
-	cpu = cpumask_first(to_cpumask(pd->cpus));
-	scale_cpu = arch_scale_cpu_capacity(cpu);
-
 	max_util = min(max_util, allowed_cpu_cap);
 
 	/*
@@ -282,12 +257,12 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	ps = &em_table->state[i];
 
 	/*
-	 * The capacity of a CPU in the domain at the performance state (ps)
-	 * can be computed as:
+	 * The performance (capacity) of a CPU in the domain at the performance
+	 * state (ps) can be computed as:
 	 *
-	 *             ps->freq * scale_cpu
-	 *   ps->cap = --------------------                          (1)
-	 *                 cpu_max_freq
+	 *                     ps->freq * scale_cpu
+	 *   ps->performance = --------------------                  (1)
+	 *                         cpu_max_freq
 	 *
 	 * So, ignoring the costs of idle states (which are not available in
 	 * the EM), the energy consumed by this CPU at that performance state
@@ -295,9 +270,10 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 *
 	 *             ps->power * cpu_util
 	 *   cpu_nrg = --------------------                          (2)
-	 *                   ps->cap
+	 *               ps->performance
 	 *
-	 * since 'cpu_util / ps->cap' represents its percentage of busy time.
+	 * since 'cpu_util / ps->performance' represents its percentage of busy
+	 * time.
 	 *
 	 *   NOTE: Although the result of this computation actually is in
 	 *         units of power, it can be manipulated as an energy value
@@ -307,9 +283,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
 	 * of two terms:
 	 *
-	 *             ps->power * cpu_max_freq   cpu_util
-	 *   cpu_nrg = ------------------------ * ---------          (3)
-	 *                    ps->freq            scale_cpu
+	 *             ps->power * cpu_max_freq
+	 *   cpu_nrg = ------------------------ * cpu_util           (3)
+	 *               ps->freq * scale_cpu
 	 *
 	 * The first term is static, and is stored in the em_perf_state struct
 	 * as 'ps->cost'.
@@ -319,11 +295,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * total energy of the domain (which is the simple sum of the energy of
 	 * all of its CPUs) can be factorized as:
 	 *
-	 *            ps->cost * \Sum cpu_util
-	 *   pd_nrg = ------------------------                       (4)
-	 *                  scale_cpu
+	 *   pd_nrg = ps->cost * \Sum cpu_util                       (4)
 	 */
-	return em_estimate_energy(ps->cost, sum_util, scale_cpu);
+	return ps->cost * sum_util;
 }
 
 /**
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 70c41a81286c..0fa98fa7dbec 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -203,11 +203,9 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
-	u64 fmax;
 	int i, ret;
 
 	/* Compute the cost of each performance state. */
-	fmax = (u64) table[nr_states - 1].frequency;
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
 
@@ -219,8 +217,9 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 				return -EINVAL;
 			}
 		} else {
-			power_res = table[i].power;
-			cost = div64_u64(fmax * power_res, table[i].frequency);
+			/* increase resolution of 'cost' precision */
+			power_res = table[i].power * 10;
+			cost = power_res / table[i].performance;
 		}
 
 		table[i].cost = cost;
-- 
2.25.1


