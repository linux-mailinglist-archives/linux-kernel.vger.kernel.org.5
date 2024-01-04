Return-Path: <linux-kernel+bounces-17010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33A824721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214E51C241C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234E2C849;
	Thu,  4 Jan 2024 17:15:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE92C845;
	Thu,  4 Jan 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA671576;
	Thu,  4 Jan 2024 09:15:55 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4D483F64C;
	Thu,  4 Jan 2024 09:15:06 -0800 (PST)
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
Subject: [PATCH v6 07/23] PM: EM: Refactor how the EM table is allocated and populated
Date: Thu,  4 Jan 2024 17:15:37 +0000
Message-Id: <20240104171553.2080674-8-lukasz.luba@arm.com>
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

Split the process of allocation and data initialization for the EM table.
The upcoming changes for modifiable EM will use it.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 55 ++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3c8542443dd4..e7826403ae1d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -142,18 +142,26 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	return 0;
 }
 
+static int em_allocate_perf_table(struct em_perf_domain *pd,
+				  int nr_states)
+{
+	pd->table = kcalloc(nr_states, sizeof(struct em_perf_state),
+			    GFP_KERNEL);
+	if (!pd->table)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
-				int nr_states, struct em_data_callback *cb,
+				struct em_perf_state *table,
+				struct em_data_callback *cb,
 				unsigned long flags)
 {
 	unsigned long power, freq, prev_freq = 0;
-	struct em_perf_state *table;
+	int nr_states = pd->nr_perf_states;
 	int i, ret;
 
-	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
-
 	/* Build the list of performance states for this performance domain */
 	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
 		/*
@@ -165,7 +173,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (ret) {
 			dev_err(dev, "EM: invalid perf. state: %d\n",
 				ret);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		/*
@@ -175,7 +183,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (freq <= prev_freq) {
 			dev_err(dev, "EM: non-increasing freq: %lu\n",
 				freq);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		/*
@@ -185,7 +193,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		if (!power || power > EM_MAX_POWER) {
 			dev_err(dev, "EM: invalid power: %lu\n",
 				power);
-			goto free_ps_table;
+			return -EINVAL;
 		}
 
 		table[i].power = power;
@@ -194,16 +202,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 	ret = em_compute_costs(dev, table, cb, nr_states, flags);
 	if (ret)
-		goto free_ps_table;
-
-	pd->table = table;
-	pd->nr_perf_states = nr_states;
+		return -EINVAL;
 
 	return 0;
-
-free_ps_table:
-	kfree(table);
-	return -EINVAL;
 }
 
 static int em_create_pd(struct device *dev, int nr_states,
@@ -234,11 +235,15 @@ static int em_create_pd(struct device *dev, int nr_states,
 			return -ENOMEM;
 	}
 
-	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
-	if (ret) {
-		kfree(pd);
-		return ret;
-	}
+	pd->nr_perf_states = nr_states;
+
+	ret = em_allocate_perf_table(pd, nr_states);
+	if (ret)
+		goto free_pd;
+
+	ret = em_create_perf_table(dev, pd, pd->table, cb, flags);
+	if (ret)
+		goto free_pd_table;
 
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
@@ -249,6 +254,12 @@ static int em_create_pd(struct device *dev, int nr_states,
 	dev->em_pd = pd;
 
 	return 0;
+
+free_pd_table:
+	kfree(pd->table);
+free_pd:
+	kfree(pd);
+	return -EINVAL;
 }
 
 static void
-- 
2.25.1


