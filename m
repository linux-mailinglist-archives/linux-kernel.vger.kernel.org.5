Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57BC7FD513
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjK2LJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjK2LIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A89A4210D;
        Wed, 29 Nov 2023 03:08:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9616C2F4;
        Wed, 29 Nov 2023 03:09:18 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 088573F5A1;
        Wed, 29 Nov 2023 03:08:28 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 11/23] PM: EM: Add API for updating the runtime modifiable EM
Date:   Wed, 29 Nov 2023 11:08:41 +0000
Message-Id: <20231129110853.94344-12-lukasz.luba@arm.com>
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

Add API function em_dev_update_perf_domain() which allows to safely
change the EM. The concurrent modifiers are protected by the mutex
to serialize them. Removal of the old memory is asynchronous and
handled by the RCU mechanisms.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 +++++++
 kernel/power/energy_model.c  | 46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index e785211828fe..520a8c8ad849 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -183,6 +183,8 @@ struct em_data_callback {
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
@@ -379,6 +381,12 @@ struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_free_table(struct em_perf_table __rcu *table) {}
+static inline
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 489a358b9a00..614891fde8df 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -221,6 +221,52 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
 	return 0;
 }
 
+/**
+ * em_dev_update_perf_domain() - Update runtime EM table for a device
+ * @dev		: Device for which the EM is to be updated
+ * @table	: The new EM table that is going to used from now
+ *
+ * Update EM runtime modifiable table for the @dev using the privided @table.
+ *
+ * This function uses mutex to serialize writers, so it must not be called
+ * from non-sleeping context.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	struct em_perf_table __rcu *old_table;
+	struct em_perf_domain *pd;
+
+	/*
+	 * The lock serializes update and unregister code paths. When the
+	 * EM has been unregistered in the meantime, we should capture that
+	 * when entering this critical section. It also makes sure that
+	 * two concurrent updates will be serialized.
+	 */
+	mutex_lock(&em_pd_mutex);
+
+	if (!dev || !dev->em_pd) {
+		mutex_unlock(&em_pd_mutex);
+		return -EINVAL;
+	}
+	pd = dev->em_pd;
+
+	em_inc_usage(new_table);
+
+	old_table = pd->runtime_table;
+	rcu_assign_pointer(pd->runtime_table, new_table);
+
+	em_cpufreq_update_efficiencies(dev, new_table->state);
+
+	em_dec_usage(old_table);
+
+	mutex_unlock(&em_pd_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
+
 static int em_create_runtime_table(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *runtime_table;
-- 
2.25.1

