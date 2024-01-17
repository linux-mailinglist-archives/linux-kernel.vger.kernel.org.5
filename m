Return-Path: <linux-kernel+bounces-28778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59B8302F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DBB21110
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD161DFDD;
	Wed, 17 Jan 2024 09:56:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB71DFD7;
	Wed, 17 Jan 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485383; cv=none; b=CsBrnvcZ5onFGgGBg1spvL5inTcic8wnHNS/Mj1KdKPmwHc9q6piFuiDWyHUtcnbdXcnzpigajGLi32imj6IQTSWrnfK7hu8O2KTUdYnDgHTf1mKHM7yg/P9qwVKfobMUJdDgkpIbZIecS05pIn9E8wOGha/PAVP44vcuqwQF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485383; c=relaxed/simple;
	bh=DJG0Pc8+NVQr0FyzRFhON4R08jZ/JxEARBwVvnw6hR4=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=slv1A5DFcsJw8MDx6sYsjWupGEW5UCYKVH0Oefd1BlirPnX4i14umV1aeDvwr8twJJN+cctoGD537bmdYWSuHrZaaMpHgvXKflcLulEvB49kWHSvXDnEChSGbb2a317Nf9rrz5z6/cyY9fLP52oVeYuzsEyOYNBR8USLjlWM47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB9DADA7;
	Wed, 17 Jan 2024 01:57:06 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03D843F5A1;
	Wed, 17 Jan 2024 01:56:17 -0800 (PST)
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
Subject: [PATCH v7 08/23] PM: EM: Introduce runtime modifiable table
Date: Wed, 17 Jan 2024 09:56:59 +0000
Message-Id: <20240117095714.1524808-9-lukasz.luba@arm.com>
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
index b01277b17946..585c5ffc898b 100644
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
index e7826403ae1d..c03010084208 100644
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


