Return-Path: <linux-kernel+bounces-28792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CD830314
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F2828288A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0C1D690;
	Wed, 17 Jan 2024 09:57:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706E721364;
	Wed, 17 Jan 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485424; cv=none; b=c1Mr8U2xrEcwvtzbdCG/ywb+jT7Rccv1MnkQC02zp6X0fpaZ3x1FWNiKtaMMWeMBLTncQeiG07TTmqmJp59qbN+6/QMgDQLIE2F496JKtu+kBnaLm9Pz6b6qe1EqUeVSFytyxJnq+NLXkAJosayynO+7tVZsWpViyyH8NDQikgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485424; c=relaxed/simple;
	bh=a+ihGKmCAGS+/wyl5s2j46tqfPjSLpmEBphz3uVw6lQ=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=RAuL3TYpXGwxqtTSlFLxXpUMfwM2GntiHnl5Zo8MLaVFJySG5aEwUz6plzsDivJj7CE9DODM+qNYu+myni0QTTdu/V9CWq3R5FfhVPGDAWmvihKOHYrnp0v7L8u6EEZIXlEA0N5npC84wVKu0kTo9TvFVkUgBW0q2AU/HkTSKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07001DA7;
	Wed, 17 Jan 2024 01:57:48 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3432F3F5A1;
	Wed, 17 Jan 2024 01:56:59 -0800 (PST)
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
Subject: [PATCH v7 21/23] PM: EM: Remove old table
Date: Wed, 17 Jan 2024 09:57:12 +0000
Message-Id: <20240117095714.1524808-22-lukasz.luba@arm.com>
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

Remove the old EM table which wasn't able to modify the data. Clean the
unneeded function and refactor the code a bit.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  2 --
 kernel/power/energy_model.c  | 46 ++++++------------------------------
 2 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aabfc26fcd31..92866a81abe4 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -53,7 +53,6 @@ struct em_perf_table {
 
 /**
  * struct em_perf_domain - Performance domain
- * @table:		List of performance states, in ascending order
  * @em_table:		Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
  * @flags:		See "em_perf_domain flags"
@@ -69,7 +68,6 @@ struct em_perf_table {
  * field is unused.
  */
 struct em_perf_domain {
-	struct em_perf_state *table;
 	struct em_perf_table __rcu *em_table;
 	int nr_perf_states;
 	unsigned long flags;
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 76aab2801bf0..e91c8efb5361 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -276,17 +276,6 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
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
@@ -331,24 +320,6 @@ int em_dev_update_perf_domain(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
 
-static int em_create_runtime_table(struct em_perf_domain *pd)
-{
-	struct em_perf_table __rcu *table;
-	int table_size;
-
-	table = em_table_alloc(pd);
-	if (!table)
-		return -ENOMEM;
-
-	/* Initialize runtime table with existing data */
-	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
-	memcpy(table->state, pd->table, table_size);
-
-	rcu_assign_pointer(pd->em_table, table);
-
-	return 0;
-}
-
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table,
 				struct em_data_callback *cb,
@@ -409,6 +380,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
+	struct em_perf_table __rcu *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -435,17 +407,15 @@ static int em_create_pd(struct device *dev, int nr_states,
 
 	pd->nr_perf_states = nr_states;
 
-	ret = em_allocate_perf_table(pd, nr_states);
-	if (ret)
+	em_table = em_table_alloc(pd);
+	if (!em_table)
 		goto free_pd;
 
-	ret = em_create_perf_table(dev, pd, pd->table, cb, flags);
+	ret = em_create_perf_table(dev, pd, em_table->state, cb, flags);
 	if (ret)
 		goto free_pd_table;
 
-	ret = em_create_runtime_table(pd);
-	if (ret)
-		goto free_pd_table;
+	rcu_assign_pointer(pd->em_table, em_table);
 
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
@@ -458,7 +428,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 
 free_pd_table:
-	kfree(pd->table);
+	kfree(em_table);
 free_pd:
 	kfree(pd);
 	return -EINVAL;
@@ -629,7 +599,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -666,8 +636,6 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	kfree(dev->em_pd->table);
-
 	em_table_free(dev->em_pd->em_table);
 
 	kfree(dev->em_pd);
-- 
2.25.1


