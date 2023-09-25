Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500967AD2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjIYIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjIYIMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:12:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74AF419C;
        Mon, 25 Sep 2023 01:11:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B4B4DA7;
        Mon, 25 Sep 2023 01:12:34 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B44523F5A1;
        Mon, 25 Sep 2023 01:11:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 16/18] PM: EM: Support late CPUs booting and capacity adjustment
Date:   Mon, 25 Sep 2023 09:11:37 +0100
Message-Id: <20230925081139.1305766-17-lukasz.luba@arm.com>
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

The patch adds needed infrastructure to handle the late CPUs boot, which
might change the previous CPUs capacity values. With this changes the new
CPUs which try to register EM will trigger the needed re-calculations for
other CPUs EMs. Thanks to that the em_per_state::performance values will
be aligned with the CPU capacity information after all CPUs finish the
boot.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 108 ++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 17a59a7717f7..6bfd33c2e48c 100644
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
@@ -591,6 +594,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 unlock:
 	mutex_unlock(&em_pd_mutex);
+
+	if (_is_cpu_device(dev))
+		em_check_capacity_update();
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -651,3 +658,104 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_unlock(&em_pd_mutex);
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
+
+/*
+ * Adjustment of CPU performance values after boot, when all CPUs capacites
+ * are correctly calculated.
+ */
+static int get_updated_perf(struct device *dev, unsigned long freq,
+				   unsigned long *power, unsigned long *perf,
+				   void *priv)
+{
+	struct em_perf_state *table = priv;
+	int i, cpu, nr_states;
+	u64 fmax, max_cap;
+
+	nr_states = dev->em_pd->nr_perf_states;
+
+	cpu = cpumask_first(em_span_cpus(dev->em_pd));
+
+	fmax = (u64) table[nr_states - 1].frequency;
+	max_cap = (u64) arch_scale_cpu_capacity(cpu);
+
+	for (i = 0; i < nr_states; i++) {
+		if (freq != table[i].frequency)
+			continue;
+
+		*power = table[i].power;
+		*perf = div64_u64(max_cap * freq, fmax);
+		break;
+	}
+
+	return 0;
+}
+
+static void em_check_capacity_update(void)
+{
+	struct em_data_callback em_cb = EM_UPDATE_CB(get_updated_perf);
+	struct em_perf_table *runtime_table;
+	struct em_perf_domain *em_pd;
+	cpumask_var_t cpu_done_mask;
+	unsigned long cpu_capacity;
+	struct em_perf_state *ps;
+	struct device *dev;
+	int cpu, ret;
+
+	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
+		pr_warn("EM: no free memory\n");
+		return;
+	}
+
+	/* Loop over all EMs and check if the CPU capacity has changed. */
+	for_each_possible_cpu(cpu) {
+		unsigned long em_max_performance;
+		struct cpufreq_policy *policy;
+
+		if (cpumask_test_cpu(cpu, cpu_done_mask))
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			pr_debug("EM: Accessing cpu%d policy failed\n", cpu);
+			schedule_delayed_work(&em_update_work,
+					      msecs_to_jiffies(1000));
+			break;
+		}
+
+		em_pd = em_cpu_get(cpu);
+		if (!em_pd || em_is_artificial(em_pd))
+			continue;
+
+		cpu_capacity = arch_scale_cpu_capacity(cpu);
+
+		rcu_read_lock();
+		runtime_table = rcu_dereference(em_pd->runtime_table);
+		ps = &runtime_table->state[em_pd->nr_perf_states - 1];
+		em_max_performance = ps->performance;
+		rcu_read_unlock();
+
+		/*
+		 * Check if the CPU capacity has been adjusted during boot
+		 * and trigger the update for new performance values.
+		 */
+		if (em_max_performance != cpu_capacity) {
+			dev = get_cpu_device(cpu);
+			ret = em_dev_update_perf_domain(dev, &em_cb,
+						em_pd->default_table->state);
+			if (ret)
+				dev_warn(dev, "EM: update failed %d\n", ret);
+			else
+				dev_info(dev, "EM: updated\n");
+		}
+
+		cpumask_or(cpu_done_mask, cpu_done_mask,
+			   em_span_cpus(em_pd));
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

