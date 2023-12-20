Return-Path: <linux-kernel+bounces-6788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C8819D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4684D1C257EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C021A04;
	Wed, 20 Dec 2023 11:03:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5421345;
	Wed, 20 Dec 2023 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07CD2F4;
	Wed, 20 Dec 2023 03:03:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20A973F5A1;
	Wed, 20 Dec 2023 03:02:55 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	xuewen.yan94@gmail.com,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH 1/2] OPP: Add API to update EM after adjustment of voltage for OPPs
Date: Wed, 20 Dec 2023 11:03:38 +0000
Message-Id: <20231220110339.1065505-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220110339.1065505-1-lukasz.luba@arm.com>
References: <20231220110339.1065505-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are device drivers which can modify voltage values for OPPs. It
could be due to the chip binning and those drivers have specific chip
knowledge about this. This adjustment can happen after Energy Model is
registered, thus EM can have stale data about power.

Introduce new API function which can be used by device driver which
adjusted the voltage for OPPs. The implementation takes care about
calculating needed internal details in the new EM table ('cost' field).
It plugs in the new EM table to the framework so other subsystems would
use the correct data.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/of.c       | 69 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 81fa27599d58..992434c0b711 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1596,3 +1596,72 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
+
+/**
+ * dev_pm_opp_of_update_em() - Update Energy Model with new power values
+ * @dev		: Device for which an Energy Model has to be registered
+ *
+ * This uses the "dynamic-power-coefficient" devicetree property to calculate
+ * power values for EM. It uses the new adjusted voltage values known for OPPs
+ * which have changed after boot.
+ */
+int dev_pm_opp_of_update_em(struct device *dev)
+{
+	struct em_perf_table __rcu *runtime_table;
+	struct em_perf_state *table, *new_table;
+	struct em_perf_domain *pd;
+	int ret, table_size, i;
+
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	pd = em_pd_get(dev);
+	if (!pd) {
+		dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
+		return -EINVAL;
+	}
+
+	runtime_table = em_allocate_table(pd);
+	if (!runtime_table) {
+		dev_warn(dev, "new EM allocation failed\n");
+		return -ENOMEM;
+	}
+
+	new_table = runtime_table->state;
+
+	table = em_get_table(pd);
+	/* Initialize data based on older EM table */
+	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
+	memcpy(new_table, table, table_size);
+
+	em_put_table();
+
+	/* Update power values which might change due to new voltage in OPPs */
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		unsigned long freq = new_table[i].frequency;
+		unsigned long power;
+
+		ret = _get_power(dev, &power, &freq);
+		if (ret)
+			goto failed;
+
+		new_table[i].power = power;
+	}
+
+	ret = em_dev_compute_costs(dev, new_table, pd->nr_perf_states);
+	if (ret)
+		goto failed;
+
+	ret = em_dev_update_perf_domain(dev, runtime_table);
+	if (ret)
+		goto failed;
+
+	return 0;
+
+failed:
+	dev_warn(dev, "EM update failed %d\n", ret);
+	em_free_table(runtime_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_update_em);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ccd97bcef269..b3ab117890fc 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -464,6 +464,7 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table);
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus);
+int dev_pm_opp_of_update_em(struct device *dev);
 static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 {
 	em_dev_unregister_perf_domain(dev);
@@ -527,6 +528,11 @@ static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 {
 }
 
+static inline int dev_pm_opp_of_update_em(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	return -EOPNOTSUPP;
-- 
2.25.1


