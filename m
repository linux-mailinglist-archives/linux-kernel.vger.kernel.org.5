Return-Path: <linux-kernel+bounces-58001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7760684E024
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAEF1C25EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3271B57;
	Thu,  8 Feb 2024 11:56:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF25763F8;
	Thu,  8 Feb 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393392; cv=none; b=Kk79A5lqqBxck/xsm5mkZ8j8mKofppdxVESfUf+/g6Tp206FLWWhepK4EQjELyfO2Uls24MXU+MlkVHUuNfa2cYg4bLxN/yPnvj8qh0WE+UhFGJW4pvCF/OJ1srq8TlEVte6aglNCDjkY6DGHPldXZcf8+En2UGXgsT0iMAH0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393392; c=relaxed/simple;
	bh=QZpub5tc2Ol3rvjorYPhlX7VrudK5oDI3YjjuCvccKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg5MuaSUxDyY36hyRN1nro+EkE33ibO0bru4CjZ7SYawNIjeO1Pttanq2WYt3jcGsm4TY9l2QWncMrISCjq/Gw9OWFGYx3AFrKurWMk62nt7K1SkNhsddwuIIRqZ936+OZ+ypTrRPKm6vQm+JTtVLKUOKT9le9sUs5dnVbkSNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1389D1FB;
	Thu,  8 Feb 2024 03:57:12 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3575A3F5A1;
	Thu,  8 Feb 2024 03:56:27 -0800 (PST)
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
Subject: [PATCH v8 08/23] PM: EM: Introduce runtime modifiable table
Date: Thu,  8 Feb 2024 11:55:42 +0000
Message-Id: <20240208115557.1273962-9-lukasz.luba@arm.com>
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

The new runtime table can be populated with a new power data to better
reflect the actual efficiency of the device e.g. CPU. The power can vary
over time e.g. due to the SoC temperature change. Higher temperature can
increase power values. For longer running scenarios, such as game or
camera, when also other devices are used (e.g. GPU, ISP) the CPU power can
change. The new EM framework is able to addresses this issue and change
the EM data at runtime safely.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 12 ++++++++
 kernel/power/energy_model.c  | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1dcd1645dde7..8ddf1d8a9581 100644
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
+ * @em_table:		Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
@@ -54,6 +65,7 @@ struct em_perf_state {
  */
 struct em_perf_domain {
 	struct em_perf_state *table;
+	struct em_perf_table __rcu *em_table;
 	int nr_perf_states;
 	unsigned long flags;
 	unsigned long cpus[];
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7468fa92134b..131ff1d0dc5b 100644
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
+	struct em_perf_table __rcu *table;
+
+	table = container_of(rp, struct em_perf_table, rcu);
+	kfree(table);
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
+	struct em_perf_table __rcu *table;
+	int table_size;
+
+	table = em_allocate_table(pd);
+	if (!table)
+		return -ENOMEM;
+
+	/* Initialize runtime table with existing data */
+	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+	memcpy(table->state, pd->table, table_size);
+
+	rcu_assign_pointer(pd->em_table, table);
+
+	return 0;
+}
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,
 				struct em_data_callback *cb,
@@ -245,6 +291,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	if (ret)
 		goto free_pd_table;
 
+	ret = em_create_runtime_table(pd);
+	if (ret)
+		goto free_pd_table;
+
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
@@ -461,6 +511,9 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	em_debug_remove_pd(dev);
 
 	kfree(dev->em_pd->table);
+
+	em_free_table(dev->em_pd->em_table);
+
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
 	mutex_unlock(&em_pd_mutex);
-- 
2.25.1


