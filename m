Return-Path: <linux-kernel+bounces-130186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004F897520
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9858A1C267BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2215099E;
	Wed,  3 Apr 2024 16:23:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FE14F9D7;
	Wed,  3 Apr 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161406; cv=none; b=T0o8ZrfCXKTu/nFH0CC+TNDKoA95TyG74063Uyb+I8iV8cuUaHw0njkTEdfcmggAKALgNX4gHZf4py/XE+LSTcmnDwc2ETHq+Anqn8vGO9Eq/4lWbKk1aihRya2gKEolX089IxRladaexkcmTJaI/+iH8l8nnc3rZB0i+QYh4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161406; c=relaxed/simple;
	bh=tr+JMGJXY9TIpwBwaXLPEGNDHxCz5dDjVJgvCh0FPac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtVNvRzygyOFR/tCKF68SuhS8mfH9NwZgYM85CxVzuDt3zV5DxZISH7cfIJ4CzBYxOO0KM78PdNvr5yfF3HjuEC3ob/xU1LVgXwFZfdLE+8l6iG2F8eLY3ERnm1ULBqvcvJ55nhD1xfd8FA/8HQbuh6Eew/Spca97NGMOA2PrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C351595;
	Wed,  3 Apr 2024 09:23:55 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C03D3F7B4;
	Wed,  3 Apr 2024 09:23:22 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	linux-samsung-soc@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	quic_sibis@quicinc.com
Subject: [PATCH 1/2] PM: EM: Add min/max available performance state limits
Date: Wed,  3 Apr 2024 17:23:14 +0100
Message-Id: <20240403162315.1458337-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403162315.1458337-1-lukasz.luba@arm.com>
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devices there are HW dependencies for shared frequency and voltage
between devices: CPUs and L3 cache. When the L3 cache frequency is
increased, the affected CPUs might run at higher voltage and frequency.
That higher voltage causes higher CPU power and thus more energy is used
for running the tasks.

Add performance state limits which are applied for the device. This allows
the Energy Model (EM) to better reflect the CPU's currently available
performance states. This information is used by Energy Aware Scheduler
(EAS) during task placement to avoid situation when a simulated energy
cost has error due to using wrong Power Domain (PD) frequency.

The function performs only bare minimum checks (and requires EM as
an argument) to reduce the overhead.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 22 ++++++++++++++---
 kernel/power/energy_model.c  | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index d30d67c2f07cf..feadd0fd6b356 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -55,6 +55,8 @@ struct em_perf_table {
  * struct em_perf_domain - Performance domain
  * @em_table:		Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
+ * @min_ps:		Minimum available performance state index
+ * @max_ps:		Maximum available performance state index
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
@@ -70,6 +72,8 @@ struct em_perf_table {
 struct em_perf_domain {
 	struct em_perf_table __rcu *em_table;
 	int nr_perf_states;
+	int min_ps;
+	int max_ps;
 	unsigned long flags;
 	unsigned long cpus[];
 };
@@ -173,6 +177,8 @@ void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -189,12 +195,13 @@ int em_dev_update_chip_binning(struct device *dev);
  */
 static inline int
 em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
-			  unsigned long max_util, unsigned long pd_flags)
+			  unsigned long max_util, unsigned long pd_flags,
+			  int min_ps, int max_ps)
 {
 	struct em_perf_state *ps;
 	int i;
 
-	for (i = 0; i < nr_perf_states; i++) {
+	for (i = min_ps; i <= max_ps; i++) {
 		ps = &table[i];
 		if (ps->performance >= max_util) {
 			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
@@ -204,7 +211,7 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
 		}
 	}
 
-	return nr_perf_states - 1;
+	return max_ps;
 }
 
 /**
@@ -255,7 +262,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	em_table = rcu_dereference(pd->em_table);
 	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
-				      max_util, pd->flags);
+				      max_util, pd->flags, pd->min_ps,
+				      pd->max_ps);
 	ps = &em_table->state[i];
 
 	/*
@@ -392,6 +400,12 @@ static inline int em_dev_update_chip_binning(struct device *dev)
 {
 	return -EINVAL;
 }
+static inline
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 927cc55ba0b3d..1a8b394251cb2 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 		goto unlock;
 
 	dev->em_pd->flags |= flags;
+	dev->em_pd->min_ps = 0;
+	dev->em_pd->max_ps = nr_states - 1;
 
 	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
 
@@ -856,3 +858,49 @@ int em_dev_update_chip_binning(struct device *dev)
 	return em_recalc_and_update(dev, pd, em_table);
 }
 EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
+
+
+/**
+ * em_update_performance_limits() - Update Energy Model with performance
+ *				limits information.
+ * @pd			: Performance Domain with EM that has to be updated.
+ * @freq_min_khz	: New minimum allowed frequency for this device.
+ * @freq_max_khz	: New maximum allowed frequency for this device.
+ *
+ * This function allows to update the EM with information about available
+ * performance levels. It takes the minimum and maximum frequency in kHz
+ * and does internal translation to performance levels.
+ * Returns 0 on success or -EINVAL when failed.
+ */
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz)
+{
+	struct em_perf_state *table;
+	int min_ps = -1;
+	int max_ps = -1;
+	int i;
+
+	if (!pd)
+		return -EINVAL;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		if (freq_min_khz == table[i].frequency)
+			min_ps = i;
+		if (freq_max_khz == table[i].frequency)
+			max_ps = i;
+	}
+	rcu_read_unlock();
+
+	/* Only update when both are found and sane */
+	if (min_ps < 0 || max_ps < 0 || max_ps < min_ps)
+		return -EINVAL;
+
+	pd->min_ps = min_ps;
+	pd->max_ps = max_ps;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_update_performance_limits);
-- 
2.25.1


