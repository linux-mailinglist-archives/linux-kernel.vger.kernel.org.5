Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DD7FD507
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjK2LIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjK2LIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 070641FCE;
        Wed, 29 Nov 2023 03:08:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91017C15;
        Wed, 29 Nov 2023 03:09:10 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02EED3F5A1;
        Wed, 29 Nov 2023 03:08:20 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 08/23] PM: EM: Introduce runtime modifiable table
Date:   Wed, 29 Nov 2023 11:08:38 +0000
Message-Id: <20231129110853.94344-9-lukasz.luba@arm.com>
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

The new runtime table can be populated with a new power data to better
reflect the actual efficiency of the device e.g. CPU. The power can vary
over time e.g. due to the SoC temperature change. Higher temperature can
increase power values. For longer running scenarios, such as game or
camera, when also other devices are used (e.g. GPU, ISP) the CPU power can
change. The new EM framework is able to addresses this issue and change
the EM data at runtime safely.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 12 ++++++++
 kernel/power/energy_model.c  | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8069f526c9d8..1e618e431cac 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -36,9 +36,20 @@ struct em_perf_state {
  */
 #define EM_PERF_STATE_INEFFICIENT BIT(0)
 
+/**
+ * struct em_perf_table - Performance states table
+ * @rcu:	RCU used for safe access and destruction
+ * @state:	List of performance states, in ascending order
+ */
+struct em_perf_table {
+	struct rcu_head rcu;
+	struct em_perf_state state[];
+};
+
 /**
  * struct em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
+ * @runtime_table:	Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
@@ -54,6 +65,7 @@ struct em_perf_state {
  */
 struct em_perf_domain {
 	struct em_perf_state *table;
+	struct em_perf_table __rcu *runtime_table;
 	int nr_perf_states;
 	unsigned long flags;
 	unsigned long cpus[];
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 99426b5eedb6..489287666705 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,9 @@
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+static void em_cpufreq_update_efficiencies(struct device *dev,
+					   struct em_perf_state *table);
+
 static bool _is_cpu_device(struct device *dev)
 {
 	return (dev->bus == &cpu_subsys);
@@ -103,6 +106,31 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
+static void em_destroy_table_rcu(struct rcu_head *rp)
+{
+	struct em_perf_table __rcu *runtime_table;
+
+	runtime_table = container_of(rp, struct em_perf_table, rcu);
+	kfree(runtime_table);
+}
+
+static void em_free_table(struct em_perf_table __rcu *table)
+{
+	call_rcu(&table->rcu, em_destroy_table_rcu);
+}
+
+static struct em_perf_table __rcu *
+em_allocate_table(struct em_perf_domain *pd)
+{
+	struct em_perf_table __rcu *table;
+	int table_size;
+
+	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+
+	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
+	return table;
+}
+
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    struct em_data_callback *cb, int nr_states,
 			    unsigned long flags)
@@ -153,6 +181,24 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
 	return 0;
 }
 
+static int em_create_runtime_table(struct em_perf_domain *pd)
+{
+	struct em_perf_table __rcu *runtime_table;
+	int table_size;
+
+	runtime_table = em_allocate_table(pd);
+	if (!runtime_table)
+		return -ENOMEM;
+
+	/* Initialize runtime table with existing data */
+	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+	memcpy(runtime_table->state, pd->table, table_size);
+
+	rcu_assign_pointer(pd->runtime_table, runtime_table);
+
+	return 0;
+}
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,
 				int nr_states, struct em_data_callback *cb,
@@ -244,6 +290,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	if (ret)
 		goto free_pd_table;
 
+	ret = em_create_runtime_table(pd);
+	if (ret)
+		goto free_pd_table;
+
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
@@ -460,6 +510,9 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	em_debug_remove_pd(dev);
 
 	kfree(dev->em_pd->table);
+
+	em_free_table(dev->em_pd->runtime_table);
+
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
 	mutex_unlock(&em_pd_mutex);
-- 
2.25.1

