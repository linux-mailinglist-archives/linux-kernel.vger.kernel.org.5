Return-Path: <linux-kernel+bounces-28780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C28302F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4BA287663
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28F14A91;
	Wed, 17 Jan 2024 09:56:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45C1E89D;
	Wed, 17 Jan 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485388; cv=none; b=GSrgTGDB/Zc6jCtAKX3X0rtcM6FEhYpL98W6lmj9s74cO8pT3cWLP2IFkPctJk9V7M8dkMxk+GWqT6p76SmVq+nF80wKl3l7NBcdEynrZxi8Pf7DP5babMi/x2wPedw+jG0NJlweD1mFNnfvU82FCA3d2esVsB0j8LNraL+WvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485388; c=relaxed/simple;
	bh=AvyOd1GUNmnUqP/7z2XWIjzHwU151boQ1Y08G9WFx/Y=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=j47jqXcWgC+PTfVlHhyyyZ3l/Maa0IkuRFSPZPAErx2Ac9/X2/R1xPjDcwGQaGPCAAtaYW6xviwxjWdQiKcOjeCMgZSnuZNStsOIL+pySvaJQUoST4l1B9xv1BbG4D1q3ZCwWppDfkeEZrI5OAL2yB55yPdOOzIDRxeHltx5+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11D8DA7;
	Wed, 17 Jan 2024 01:57:12 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAAFA3F5A1;
	Wed, 17 Jan 2024 01:56:23 -0800 (PST)
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
Subject: [PATCH v7 10/23] PM: EM: Add functions for memory allocations for new EM tables
Date: Wed, 17 Jan 2024 09:57:01 +0000
Message-Id: <20240117095714.1524808-11-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
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
 include/linux/energy_model.h | 11 +++++++++++
 kernel/power/energy_model.c  | 38 +++++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index fcd8de1a2dbd..e44c5080407f 100644
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
@@ -366,6 +371,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
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
index c03010084208..ffe94614f004 100644
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


