Return-Path: <linux-kernel+bounces-17013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DE824728
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6161C2424B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F62E3EB;
	Thu,  4 Jan 2024 17:15:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE62E3E4;
	Thu,  4 Jan 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 946861570;
	Thu,  4 Jan 2024 09:16:03 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AE533F64C;
	Thu,  4 Jan 2024 09:15:15 -0800 (PST)
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
Subject: [PATCH v6 10/23] PM: EM: Add API for memory allocations for new tables
Date: Thu,  4 Jan 2024 17:15:40 +0000
Message-Id: <20240104171553.2080674-11-lukasz.luba@arm.com>
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

The runtime modified EM table can be provided from drivers. Create
mechanism which allows safely allocate and free the table for device
drivers. The same table can be used by the EAS in task scheduler code
paths, so make sure the memory is not freed when the device driver module
is unloaded.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 +++++++++
 kernel/power/energy_model.c  | 43 ++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 5f842da3bb0c..753d70d0ce7e 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/jump_label.h>
 #include <linux/kobject.h>
+#include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/cpufreq.h>
 #include <linux/sched/topology.h>
@@ -39,10 +40,12 @@ struct em_perf_state {
 /**
  * struct em_perf_table - Performance states table
  * @rcu:	RCU used for safe access and destruction
+ * @refcount:	Reference count to track the owners
  * @state:	List of performance states, in ascending order
  */
 struct em_perf_table {
 	struct rcu_head rcu;
+	struct kref refcount;
 	struct em_perf_state state[];
 };
 
@@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
+struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
+void em_free_table(struct em_perf_table __rcu *table);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -365,6 +370,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
 }
+static inline
+struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
+{
+	return NULL;
+}
+static inline void em_free_table(struct em_perf_table __rcu *table) {}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c03010084208..bbc406db0be1 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
 	kfree(table);
 }
 
-static void em_free_table(struct em_perf_table __rcu *table)
+static void em_release_table_kref(struct kref *kref)
 {
+	struct em_perf_table __rcu *table;
+
+	/* It was the last owner of this table so we can free */
+	table = container_of(kref, struct em_perf_table, refcount);
+
 	call_rcu(&table->rcu, em_destroy_table_rcu);
 }
 
-static struct em_perf_table __rcu *
+static inline void em_table_inc(struct em_perf_table __rcu *table)
+{
+	kref_get(&table->refcount);
+}
+
+static void em_table_dec(struct em_perf_table __rcu *table)
+{
+	kref_put(&table->refcount, em_release_table_kref);
+}
+
+/**
+ * em_free_table() - Handles safe free of the EM table when needed
+ * @table : EM memory which is going to be freed
+ *
+ * No return values.
+ */
+void em_free_table(struct em_perf_table __rcu *table)
+{
+	em_table_dec(table);
+}
+
+/**
+ * em_allocate_table() - Handles safe allocation of the new EM table
+ * @table : EM memory which is going to be freed
+ *
+ * Increments the reference counter to mark that there is an owner of that
+ * EM table. That might be a device driver module or EAS.
+ * Returns allocated table or error.
+ */
+struct em_perf_table __rcu *
 em_allocate_table(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *table;
@@ -128,6 +162,11 @@ em_allocate_table(struct em_perf_domain *pd)
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
 
 	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
+	if (!table)
+		return table;
+
+	kref_init(&table->refcount);
+
 	return table;
 }
 
-- 
2.25.1


