Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781CE7FD512
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjK2LJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK2LIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAD01BC5;
        Wed, 29 Nov 2023 03:08:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E51B8C15;
        Wed, 29 Nov 2023 03:09:15 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A01B3F5A1;
        Wed, 29 Nov 2023 03:08:26 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 10/23] PM: EM: Add API for memory allocations for new tables
Date:   Wed, 29 Nov 2023 11:08:40 +0000
Message-Id: <20231129110853.94344-11-lukasz.luba@arm.com>
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

The runtime modified EM table can be provided from drivers. Create
mechanism which allows safely allocate and free the table for device
drivers. The same table can be used by the EAS in task scheduler code
paths, so make sure the memory is not freed when the device driver module
is unloaded.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 11 +++++++++
 kernel/power/energy_model.c  | 44 ++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 94a77a813724..e785211828fe 100644
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
@@ -368,6 +373,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
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
index 489287666705..489a358b9a00 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
 	kfree(runtime_table);
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
+static inline void em_inc_usage(struct em_perf_table __rcu *table)
+{
+	kref_get(&table->refcount);
+}
+
+static void em_dec_usage(struct em_perf_table __rcu *table)
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
+	em_dec_usage(table);
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
@@ -128,6 +162,12 @@ em_allocate_table(struct em_perf_domain *pd)
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
 
 	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
+	if (!table)
+		return table;
+
+	kref_init(&table->refcount);
+	em_inc_usage(table);
+
 	return table;
 }
 
-- 
2.25.1

