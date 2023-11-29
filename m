Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D337FD51A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjK2LJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjK2LJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:09:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5EFC26A2;
        Wed, 29 Nov 2023 03:08:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B56EC15;
        Wed, 29 Nov 2023 03:09:26 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DE443F5A1;
        Wed, 29 Nov 2023 03:08:36 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 14/23] PM: EM: Support late CPUs booting and capacity adjustment
Date:   Wed, 29 Nov 2023 11:08:44 +0000
Message-Id: <20231129110853.94344-15-lukasz.luba@arm.com>
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

The patch adds needed infrastructure to handle the late CPUs boot, which
might change the previous CPUs capacity values. With this changes the new
CPUs which try to register EM will trigger the needed re-calculations for
other CPUs EMs. Thanks to that the em_per_state::performance values will
be aligned with the CPU capacity information after all CPUs finish the
boot and EM registrations.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 121 ++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index b5016afe6a19..d3fa5a77de80 100644
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
@@ -596,6 +599,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 unlock:
 	mutex_unlock(&em_pd_mutex);
+
+	if (_is_cpu_device(dev))
+		em_check_capacity_update();
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -631,3 +638,117 @@ void em_dev_unregister_perf_domain(struct device *dev)
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
+	struct em_perf_table __rcu *runtime_table;
+	struct em_perf_state *table, *new_table;
+	int ret, table_size;
+
+	runtime_table = em_allocate_table(pd);
+	if (!runtime_table) {
+		dev_warn(dev, "EM: allocation failed\n");
+		return;
+	}
+
+	new_table = runtime_table->state;
+
+	table = em_get_table(pd);
+	/* Initialize data based on older runtime table */
+	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+	memcpy(new_table, table, table_size);
+
+	em_put_table();
+
+	em_init_performance(dev, pd, new_table, pd->nr_perf_states);
+	ret = em_compute_costs(dev, new_table, NULL, pd->nr_perf_states,
+			       pd->flags);
+	if (ret) {
+		em_free_table(runtime_table);
+		return;
+	}
+
+	ret = em_dev_update_perf_domain(dev, runtime_table);
+	if (ret)
+		dev_warn(dev, "EM: update failed %d\n", ret);
+
+	/*
+	 * This is one-time-update, so give up the ownership in this updater.
+	 * The EM fwk will keep the reference and free the memory when needed.
+	 */
+	em_free_table(runtime_table);
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
+		table = em_get_table(pd);
+		em_max_perf = table[pd->nr_perf_states - 1].performance;
+		em_put_table();
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

