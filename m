Return-Path: <linux-kernel+bounces-103347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49587BE60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5ACEB228CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911B6FE11;
	Thu, 14 Mar 2024 14:04:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D471723;
	Thu, 14 Mar 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425093; cv=none; b=Rcv6MKdcR/magn7mo7dL5szW1vEDRmH0OebzcWYZlKg/NC5OaGsEFptAlxc3UaoK0Z9iZ2s7IHhfPJxpk4vU1goL+4Ho+lLKL1SkxjHsYfJ0glbktFwrEwexmHgYoUXV0O9jZRYc876oq1YysvFiJxsdnKe7YOMddTOg/uhLe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425093; c=relaxed/simple;
	bh=rmY1Ezl/4TLieyFpoPKm5P9cmNGH4Ej3lVmVLgRJ0WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2D8N6S3LfPjnMn7747EJIwfGbY/q7loiwtIaZgjCmsJG4Qpps0h4RY+fmvHoldQ53GFtlhm8PKd91A20AEmPQK9JkcUMyQXhlaOJs72WXAi3/OhSXrImezWFrBw2olcjPZ4v182Rkw7OETqWole/ZMrgPZBGBGVx1GRTGDvePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A5F1007;
	Thu, 14 Mar 2024 07:05:26 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.13.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C4B53F762;
	Thu, 14 Mar 2024 07:04:47 -0700 (PDT)
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
	mhiramat@kernel.org
Subject: [PATCH 3/4] PM: EM: Add em_dev_update_chip_binning()
Date: Thu, 14 Mar 2024 14:04:20 +0000
Message-Id: <20240314140421.3563571-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314140421.3563571-1-lukasz.luba@arm.com>
References: <20240314140421.3563571-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function which allows to modify easily the EM after the new voltage
information is available. The device drivers for the chip can adjust
the voltage values after setup. The voltage for the same frequency in OPP
can be different due to chip binning. The voltage impacts the power usage
and the EM power values can be updated to reflect that.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  5 ++++
 kernel/power/energy_model.c  | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 770755df852f1..d30d67c2f07cf 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -172,6 +172,7 @@ struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
 void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
+int em_dev_update_chip_binning(struct device *dev);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -387,6 +388,10 @@ int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 {
 	return -EINVAL;
 }
+static inline int em_dev_update_chip_binning(struct device *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6960dd7393b2d..1494a909844a4 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -808,3 +808,54 @@ static void em_update_workfn(struct work_struct *work)
 {
 	em_check_capacity_update();
 }
+
+/**
+ * em_dev_update_chip_binning() - Update Energy Model with new values after
+ *			the new voltage information is present in the OPPs.
+ * @dev		: Device for which the Energy Model has to be updated.
+ *
+ * This function allows to update easily the EM with new values available in
+ * the OPP framework and DT. It can be used after the chip has been properly
+ * verified by device drivers and the voltages adjusted for the 'chip binning'.
+ * It uses the "dynamic-power-coefficient" DT property to calculate the power
+ * values for EM. For power calculation it uses the new adjusted voltage
+ * values known for OPPs, which might be changed after boot.
+ */
+int em_dev_update_chip_binning(struct device *dev)
+{
+	struct em_perf_table __rcu *em_table;
+	struct em_perf_domain *pd;
+	int i, ret;
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
+	em_table = em_table_dup(pd);
+	if (!em_table) {
+		dev_warn(dev, "EM: allocation failed\n");
+		return -ENOMEM;
+	}
+
+	/* Update power values which might change due to new voltage in OPPs */
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		unsigned long freq = em_table->state[i].frequency;
+		unsigned long power;
+
+		ret = dev_pm_opp_calc_power(dev, &power, &freq);
+		if (ret) {
+			em_table_free(em_table);
+			return ret;
+		}
+
+		em_table->state[i].power = power;
+	}
+
+	return em_recalc_and_update(dev, pd, em_table);
+}
+EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
-- 
2.25.1


