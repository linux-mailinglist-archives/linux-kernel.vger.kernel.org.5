Return-Path: <linux-kernel+bounces-58004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A384384E029
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558F81F2BE44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123B73181;
	Thu,  8 Feb 2024 11:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480D76C79;
	Thu,  8 Feb 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393398; cv=none; b=SGduYDeHBDz8APkeAMP5xmFnLU5x2R+FF9uaW6cO0hE8V6nwDLLUKwLxNplxPlwvWIVC2U7jrjctp9R7CdX06qCHHqGSJdKTQ6HtC3MhEUFZr7SmUtNnzD2DIVejmXIinUjpC4Gk7eRpmYsMh6ijNP59fLaOX1Q0CIdhoxXPQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393398; c=relaxed/simple;
	bh=DiNv7mQncPSnB+eywfhrvz0BEnMEKg6b9IKEAkOD/Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJpiAt10YG5b78qJHHT5ewi0/IajsXgRaId9+MLyEu3Cm7mK9v6YeTsxBPWwGhWbgbZEj2OoPIHiIbf+oHkjvVIp4BTIi73rLXeFcjGiBFwQnFSrRB6k8n65DrB3CRcstmxHNWKXvkaaDTn/vwycJLBPRLTi3hOwyKkLQsv7uh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F051B1FB;
	Thu,  8 Feb 2024 03:57:17 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B12A3F5A1;
	Thu,  8 Feb 2024 03:56:32 -0800 (PST)
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
Subject: [PATCH v8 10/23] PM: EM: Add functions for memory allocations for new EM tables
Date: Thu,  8 Feb 2024 11:55:44 +0000
Message-Id: <20240208115557.1273962-11-lukasz.luba@arm.com>
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

The runtime modified EM table can be provided from drivers. Create
mechanism which allows safely allocate and free the table for device
drivers. The same table can be used by the EAS in task scheduler code
paths, so make sure the memory is not freed when the device driver module
is unloaded.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 +++++++++++
 kernel/power/energy_model.c  | 38 +++++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 5f842da3bb0c..27911dc1887e 100644
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
+ * @kref:	Reference counter to track the users
  * @state:	List of performance states, in ascending order
  */
 struct em_perf_table {
 	struct rcu_head rcu;
+	struct kref kref;
 	struct em_perf_state state[];
 };
 
@@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
+struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
+void em_table_free(struct em_perf_table __rcu *table);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -365,6 +370,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
 }
+static inline
+struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+{
+	return NULL;
+}
+static inline void em_table_free(struct em_perf_table __rcu *table) {}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 131ff1d0dc5b..16795743f969 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -114,13 +114,36 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
 	kfree(table);
 }
 
-static void em_free_table(struct em_perf_table __rcu *table)
+static void em_release_table_kref(struct kref *kref)
 {
+	struct em_perf_table __rcu *table;
+
+	/* It was the last owner of this table so we can free */
+	table = container_of(kref, struct em_perf_table, kref);
+
 	call_rcu(&table->rcu, em_destroy_table_rcu);
 }
 
-static struct em_perf_table __rcu *
-em_allocate_table(struct em_perf_domain *pd)
+/**
+ * em_table_free() - Handles safe free of the EM table when needed
+ * @table : EM table which is going to be freed
+ *
+ * No return values.
+ */
+void em_table_free(struct em_perf_table __rcu *table)
+{
+	kref_put(&table->kref, em_release_table_kref);
+}
+
+/**
+ * em_table_alloc() - Allocate a new EM table
+ * @pd		: EM performance domain for which this must be done
+ *
+ * Allocate a new EM table and initialize its kref to indicate that it
+ * has a user.
+ * Returns allocated table or NULL.
+ */
+struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *table;
 	int table_size;
@@ -128,6 +151,11 @@ em_allocate_table(struct em_perf_domain *pd)
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
 
 	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	kref_init(&table->kref);
+
 	return table;
 }
 
@@ -186,7 +214,7 @@ static int em_create_runtime_table(struct em_perf_domain *pd)
 	struct em_perf_table __rcu *table;
 	int table_size;
 
-	table = em_allocate_table(pd);
+	table = em_table_alloc(pd);
 	if (!table)
 		return -ENOMEM;
 
@@ -512,7 +540,7 @@ void em_dev_unregister_perf_domain(struct device *dev)
 
 	kfree(dev->em_pd->table);
 
-	em_free_table(dev->em_pd->em_table);
+	em_table_free(dev->em_pd->em_table);
 
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
-- 
2.25.1


