Return-Path: <linux-kernel+bounces-58005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83884E02B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD58C28C488
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42979DD2;
	Thu,  8 Feb 2024 11:56:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5FD79DA1;
	Thu,  8 Feb 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393400; cv=none; b=Dv1sxkBgJEmfImUZ0dDGCEsse6OlgCbyb1BhwiB6TFH2WrklUoZYLz+WHjFF7rF1FfXWHcqc9a9oDx/YfNxUd69wyHV+8ntrwo5mfoRZDbibP7ZBh5OdB92m+L+nftu1Umeu9qNi7FuB4BIQElXCBrq0R3t2dxZJPUkEkj291ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393400; c=relaxed/simple;
	bh=OoFrzVwdfR8MuA4B3/NSqIrR20qh/M0U8am5P3jts3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZ89Zw/TrzrjqAYHntSSVxAUjpQzvOEVvsK0iTIznzBhVqdoNOwdKbFSi0lgoX8h/Wede2GwYSOlIowuZ2ra2tg5AH0T+PCYso5o3sxBrT/Yfvg1fvroVSF5sdbesD/K2PBDUP4hjcytCBjCqhMTgsTvXf9wZ8dptuVvAUjCwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E565A1FB;
	Thu,  8 Feb 2024 03:57:20 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1013B3F5A1;
	Thu,  8 Feb 2024 03:56:35 -0800 (PST)
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
Subject: [PATCH v8 11/23] PM: EM: Introduce em_dev_update_perf_domain() for EM updates
Date: Thu,  8 Feb 2024 11:55:45 +0000
Message-Id: <20240208115557.1273962-12-lukasz.luba@arm.com>
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

Add API function em_dev_update_perf_domain() which allows the EM to be
changed safely.

Concurrent updaters are serialized with a mutex and the removal of memory
that will not be used any more is carried out with the help of RCU.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 +++++++
 kernel/power/energy_model.c  | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 27911dc1887e..324a3a8e0a2d 100644
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
@@ -376,6 +378,12 @@ struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_table_free(struct em_perf_table __rcu *table) {}
+static inline
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 16795743f969..667619b70be7 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -209,6 +209,50 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
 	return 0;
 }
 
+/**
+ * em_dev_update_perf_domain() - Update runtime EM table for a device
+ * @dev		: Device for which the EM is to be updated
+ * @new_table	: The new EM table that is going to be used from now
+ *
+ * Update EM runtime modifiable table for the @dev using the provided @table.
+ *
+ * This function uses a mutex to serialize writers, so it must not be called
+ * from a non-sleeping context.
+ *
+ * Return 0 on success or an error code on failure.
+ */
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	struct em_perf_table __rcu *old_table;
+	struct em_perf_domain *pd;
+
+	if (!dev)
+		return -EINVAL;
+
+	/* Serialize update/unregister or concurrent updates */
+	mutex_lock(&em_pd_mutex);
+
+	if (!dev->em_pd) {
+		mutex_unlock(&em_pd_mutex);
+		return -EINVAL;
+	}
+	pd = dev->em_pd;
+
+	kref_get(&new_table->kref);
+
+	old_table = pd->em_table;
+	rcu_assign_pointer(pd->em_table, new_table);
+
+	em_cpufreq_update_efficiencies(dev, new_table->state);
+
+	em_table_free(old_table);
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


