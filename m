Return-Path: <linux-kernel+bounces-58008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4684E031
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AC81F2C86D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4387C095;
	Thu,  8 Feb 2024 11:56:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195817B3F2;
	Thu,  8 Feb 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393409; cv=none; b=fyBf7mwY1+kVneeoVFAA1nCNMI86fVLaZp91uFJDmlTBL3noZbDIAkls5cAHC5hjsOxZOGB7KTF6qEpRhuFB9frfXqIE3foWRvHmX2QYFNclwGLMzV8+k/UrNq7vAYZr12bfgq17ir5m17yO8ZwkMJO9rbKYyRtqzVY5nGhla5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393409; c=relaxed/simple;
	bh=ZR61DaeFcB991ir0orXLWZ0iQoLKSU51+OwfZAOti0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK6bjMl8USVlC87Y8c2kKGqIeMmzYjIWqJXzC69LPoTwup5bxEzsmCyMC25Z2u8UVtCz8p0ZbezlNMIrZ3v9w0GmPpUgWI62jKnKMSJVBSqEEkVKQd0652BHVliZno3oxd5ewjiZ5Cl3ps3ydQT8yi4kiY4J0e7IviGNf9G1J7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AB51FB;
	Thu,  8 Feb 2024 03:57:30 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24D8F3F5A1;
	Thu,  8 Feb 2024 03:56:45 -0800 (PST)
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
Subject: [PATCH v8 14/23] PM: EM: Support late CPUs booting and capacity adjustment
Date: Thu,  8 Feb 2024 11:55:48 +0000
Message-Id: <20240208115557.1273962-15-lukasz.luba@arm.com>
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

The patch adds needed infrastructure to handle the late CPUs boot, which
might change the previous CPUs capacity values. With this changes the new
CPUs which try to register EM will trigger the needed re-calculations for
other CPUs EMs. Thanks to that the em_per_state::performance values will
be aligned with the CPU capacity information after all CPUs finish the
boot and EM registrations.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 41418aa6daa6..b192b0ac8c6e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -25,6 +25,9 @@ static DEFINE_MUTEX(em_pd_mutex);
 
 static void em_cpufreq_update_efficiencies(struct device *dev,
 					   struct em_perf_state *table);
+static void em_check_capacity_update(void);
+static void em_update_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(em_update_work, em_update_workfn);
 
 static bool _is_cpu_device(struct device *dev)
 {
@@ -583,6 +586,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 unlock:
 	mutex_unlock(&em_pd_mutex);
+
+	if (_is_cpu_device(dev))
+		em_check_capacity_update();
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -618,3 +625,120 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_unlock(&em_pd_mutex);
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
+
+/*
+ * Adjustment of CPU performance values after boot, when all CPUs capacites
+ * are correctly calculated.
+ */
+static void em_adjust_new_capacity(struct device *dev,
+				   struct em_perf_domain *pd,
+				   u64 max_cap)
+{
+	struct em_perf_table __rcu *em_table;
+	struct em_perf_state *ps, *new_ps;
+	int ret, ps_size;
+
+	em_table = em_table_alloc(pd);
+	if (!em_table) {
+		dev_warn(dev, "EM: allocation failed\n");
+		return;
+	}
+
+	new_ps = em_table->state;
+
+	rcu_read_lock();
+	ps = em_perf_state_from_pd(pd);
+	/* Initialize data based on old table */
+	ps_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+	memcpy(new_ps, ps, ps_size);
+
+	rcu_read_unlock();
+
+	em_init_performance(dev, pd, new_ps, pd->nr_perf_states);
+	ret = em_compute_costs(dev, new_ps, NULL, pd->nr_perf_states,
+			       pd->flags);
+	if (ret) {
+		dev_warn(dev, "EM: compute costs failed\n");
+		return;
+	}
+
+	ret = em_dev_update_perf_domain(dev, em_table);
+	if (ret)
+		dev_warn(dev, "EM: update failed %d\n", ret);
+
+	/*
+	 * This is one-time-update, so give up the ownership in this updater.
+	 * The EM framework has incremented the usage counter and from now
+	 * will keep the reference (then free the memory when needed).
+	 */
+	em_table_free(em_table);
+}
+
+static void em_check_capacity_update(void)
+{
+	cpumask_var_t cpu_done_mask;
+	struct em_perf_state *table;
+	struct em_perf_domain *pd;
+	unsigned long cpu_capacity;
+	int cpu;
+
+	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
+		pr_warn("no free memory\n");
+		return;
+	}
+
+	/* Check if CPUs capacity has changed than update EM */
+	for_each_possible_cpu(cpu) {
+		struct cpufreq_policy *policy;
+		unsigned long em_max_perf;
+		struct device *dev;
+		int nr_states;
+
+		if (cpumask_test_cpu(cpu, cpu_done_mask))
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			pr_debug("Accessing cpu%d policy failed\n", cpu);
+			schedule_delayed_work(&em_update_work,
+					      msecs_to_jiffies(1000));
+			break;
+		}
+		cpufreq_cpu_put(policy);
+
+		pd = em_cpu_get(cpu);
+		if (!pd || em_is_artificial(pd))
+			continue;
+
+		cpumask_or(cpu_done_mask, cpu_done_mask,
+			   em_span_cpus(pd));
+
+		nr_states = pd->nr_perf_states;
+		cpu_capacity = arch_scale_cpu_capacity(cpu);
+
+		rcu_read_lock();
+		table = em_perf_state_from_pd(pd);
+		em_max_perf = table[pd->nr_perf_states - 1].performance;
+		rcu_read_unlock();
+
+		/*
+		 * Check if the CPU capacity has been adjusted during boot
+		 * and trigger the update for new performance values.
+		 */
+		if (em_max_perf == cpu_capacity)
+			continue;
+
+		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
+			 cpu, cpu_capacity, em_max_perf);
+
+		dev = get_cpu_device(cpu);
+		em_adjust_new_capacity(dev, pd, cpu_capacity);
+	}
+
+	free_cpumask_var(cpu_done_mask);
+}
+
+static void em_update_workfn(struct work_struct *work)
+{
+	em_check_capacity_update();
+}
-- 
2.25.1


