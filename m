Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACF37FD52A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjK2LK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjK2LKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:10:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC512D46;
        Wed, 29 Nov 2023 03:08:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86858C15;
        Wed, 29 Nov 2023 03:09:45 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDC433F5A1;
        Wed, 29 Nov 2023 03:08:55 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 21/23] PM: EM: Remove old table
Date:   Wed, 29 Nov 2023 11:08:51 +0000
Message-Id: <20231129110853.94344-22-lukasz.luba@arm.com>
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

Remove the old EM table which wasn't able to modify the data. Clean the
unneeded function and refactor the code a bit.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  2 --
 kernel/power/energy_model.c  | 47 ++++++------------------------------
 2 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 0f5621898a81..9c47388482a0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -53,7 +53,6 @@ struct em_perf_table {
 
 /**
  * struct em_perf_domain - Performance domain
- * @table:		List of performance states, in ascending order
  * @runtime_table:	Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
@@ -69,7 +68,6 @@ struct em_perf_table {
  * field is unused.
  */
 struct em_perf_domain {
-	struct em_perf_state *table;
 	struct em_perf_table __rcu *runtime_table;
 	int nr_perf_states;
 	unsigned long flags;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index cc47993b4d64..234823c0e59d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -286,17 +286,6 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
-static int em_allocate_perf_table(struct em_perf_domain *pd,
-				  int nr_states)
-{
-	pd->table = kcalloc(nr_states, sizeof(struct em_perf_state),
-			    GFP_KERNEL);
-	if (!pd->table)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /**
  * em_dev_update_perf_domain() - Update runtime EM table for a device
  * @dev		: Device for which the EM is to be updated
@@ -343,24 +332,6 @@ int em_dev_update_perf_domain(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
 
-static int em_create_runtime_table(struct em_perf_domain *pd)
-{
-	struct em_perf_table __rcu *runtime_table;
-	int table_size;
-
-	runtime_table = em_allocate_table(pd);
-	if (!runtime_table)
-		return -ENOMEM;
-
-	/* Initialize runtime table with existing data */
-	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
-	memcpy(runtime_table->state, pd->table, table_size);
-
-	rcu_assign_pointer(pd->runtime_table, runtime_table);
-
-	return 0;
-}
-
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,
 				int nr_states, struct em_data_callback *cb,
@@ -420,6 +391,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
+	struct em_perf_table __rcu *runtime_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -446,17 +418,16 @@ static int em_create_pd(struct device *dev, int nr_states,
 
 	pd->nr_perf_states = nr_states;
 
-	ret = em_allocate_perf_table(pd, nr_states);
-	if (ret)
+	runtime_table = em_allocate_table(pd);
+	if (!runtime_table)
 		goto free_pd;
 
-	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);
+	ret = em_create_perf_table(dev, pd, runtime_table->state,
+				   nr_states, cb, flags);
 	if (ret)
 		goto free_pd_table;
 
-	ret = em_create_runtime_table(pd);
-	if (ret)
-		goto free_pd_table;
+	rcu_assign_pointer(pd->runtime_table, runtime_table);
 
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
@@ -469,7 +440,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 
 free_pd_table:
-	kfree(pd->table);
+	kfree(runtime_table);
 free_pd:
 	kfree(pd);
 	return -EINVAL;
@@ -640,7 +611,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->runtime_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -677,8 +648,6 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	kfree(dev->em_pd->table);
-
 	em_free_table(dev->em_pd->runtime_table);
 
 	kfree(dev->em_pd);
-- 
2.25.1

