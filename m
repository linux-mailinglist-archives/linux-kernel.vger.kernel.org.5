Return-Path: <linux-kernel+bounces-17014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0382472A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AA4B24DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858702E3E4;
	Thu,  4 Jan 2024 17:15:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9E2E3FF;
	Thu,  4 Jan 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626DB153B;
	Thu,  4 Jan 2024 09:16:06 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF1B13F64C;
	Thu,  4 Jan 2024 09:15:17 -0800 (PST)
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
Subject: [PATCH v6 11/23] PM: EM: Add API for updating the runtime modifiable EM
Date: Thu,  4 Jan 2024 17:15:41 +0000
Message-Id: <20240104171553.2080674-12-lukasz.luba@arm.com>
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

Add API function em_dev_update_perf_domain() which allows to safely
change the EM. The concurrent modifiers are protected by the mutex
to serialize them. Removal of the old memory is asynchronous and
handled by the RCU mechanisms.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 +++++++
 kernel/power/energy_model.c  | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 753d70d0ce7e..f33257ed83fd 100644
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
@@ -376,6 +378,12 @@ struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
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
index bbc406db0be1..496dc00835c6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -220,6 +220,47 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
 	return 0;
 }
 
+/**
+ * em_dev_update_perf_domain() - Update runtime EM table for a device
+ * @dev		: Device for which the EM is to be updated
+ * @table	: The new EM table that is going to be used from now
+ *
+ * Update EM runtime modifiable table for the @dev using the provided @table.
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
+	/* Serialize update/unregister or concurrent updates */
+	mutex_lock(&em_pd_mutex);
+
+	if (!dev || !dev->em_pd) {
+		mutex_unlock(&em_pd_mutex);
+		return -EINVAL;
+	}
+	pd = dev->em_pd;
+
+	em_table_inc(new_table);
+
+	old_table = pd->em_table;
+	rcu_assign_pointer(pd->em_table, new_table);
+
+	em_cpufreq_update_efficiencies(dev, new_table->state);
+
+	em_table_dec(old_table);
+
+	mutex_unlock(&em_pd_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
+
 static int em_create_runtime_table(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *table;
-- 
2.25.1


