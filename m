Return-Path: <linux-kernel+bounces-17026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F6824749
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A6B248AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD2358A2;
	Thu,  4 Jan 2024 17:15:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE13588E;
	Thu,  4 Jan 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282A2153B;
	Thu,  4 Jan 2024 09:16:37 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2E583F64C;
	Thu,  4 Jan 2024 09:15:48 -0800 (PST)
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
Subject: [PATCH v6 22/23] PM: EM: Add em_dev_compute_costs() as API for device drivers
Date: Thu,  4 Jan 2024 17:15:52 +0000
Message-Id: <20240104171553.2080674-23-lukasz.luba@arm.com>
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

The device drivers can modify EM at runtime by providing a new EM table.
The EM is used by the EAS and the em_perf_state::cost stores
pre-calculated value to avoid overhead. This patch provides the API for
device drivers to calculate the cost values properly (and not duplicate
the same code).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 ++++++++
 kernel/power/energy_model.c  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index dd8a69bdf0d0..f50f3c6ab2e5 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -170,6 +170,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
 void em_free_table(struct em_perf_table __rcu *table);
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -375,6 +377,12 @@ static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_put_table(void) {}
+static inline
+int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+			 int nr_states)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 79877d8975d5..7f9337f4ae30 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -285,6 +285,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
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


