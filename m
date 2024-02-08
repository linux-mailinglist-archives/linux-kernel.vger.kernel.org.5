Return-Path: <linux-kernel+bounces-58016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCE84E042
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8336128265E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0388E76046;
	Thu,  8 Feb 2024 11:57:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A84C8002E;
	Thu,  8 Feb 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393434; cv=none; b=ntycIZgKHXyjixu4juEyF3osKVcJUdHohKrjwiguNCYxZNs/JmvrI6PCElVmMpYtd/WbPunfsIX8p3T0YiR2RrK9kAq80vPqojo4QeQRV6EPXIcqUMt0FqIMV+oP35ApNANKECrDTqT+7k4P1Qq03U8pE72rj+qJKHDcF8DBUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393434; c=relaxed/simple;
	bh=ObVLAB8KuRCDvRT3WPT0Lj1kkK4Fwrkdi2IV35YawEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSdpLl+KRREvPSYZALkQZf8odmTOIghtZrEKSsmUkwL1lPKTcmcoD9LHcG5SsGy/atAuR33888qanNOnQW8bBrVLltnMW/Oo/O0Oa4Zob6X32Rt1b/XT3rFoS6RjIBG+oFEYHU9gjF99gLkRy6oG1x2I4VEyxKYeQXqjPlBpts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F801FB;
	Thu,  8 Feb 2024 03:57:53 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B03DD3F5A1;
	Thu,  8 Feb 2024 03:57:08 -0800 (PST)
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
Subject: [PATCH v8 22/23] PM: EM: Add em_dev_compute_costs()
Date: Thu,  8 Feb 2024 11:55:56 +0000
Message-Id: <20240208115557.1273962-23-lukasz.luba@arm.com>
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

The device drivers can modify EM at runtime by providing a new EM table.
The EM is used by the EAS and the em_perf_state::cost stores
pre-calculated value to avoid overhead. This patch provides the API for
device drivers to calculate the cost values properly (and not duplicate
the same code).

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 ++++++++
 kernel/power/energy_model.c  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 92866a81abe4..770755df852f 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -170,6 +170,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
 void em_table_free(struct em_perf_table __rcu *table);
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -379,6 +381,12 @@ struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
 {
 	return NULL;
 }
+static inline
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 57838d28af85..7101fa3fa0c0 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -276,6 +276,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+/**
+ * em_dev_compute_costs() - Calculate cost values for new runtime EM table
+ * @dev		: Device for which the EM table is to be updated
+ * @table	: The new EM table that is going to get the costs calculated
+ *
+ * Calculate the em_perf_state::cost values for new runtime EM table. The
+ * values are used for EAS during task placement. It also calculates and sets
+ * the efficiency flag for each performance state. When the function finish
+ * successfully the EM table is ready to be updated and used by EAS.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return em_compute_costs(dev, table, NULL, nr_states, 0);
+}
+
 /**
  * em_dev_update_perf_domain() - Update runtime EM table for a device
  * @dev		: Device for which the EM is to be updated
-- 
2.25.1


