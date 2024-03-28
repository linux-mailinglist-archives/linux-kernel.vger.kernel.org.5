Return-Path: <linux-kernel+bounces-122610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551488FA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA142A39C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF9657DC;
	Thu, 28 Mar 2024 08:51:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDA657C1;
	Thu, 28 Mar 2024 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615890; cv=none; b=BMb1Tg3zfneT1jCyI1uMWDrHJ+z1iVA51SFfifnsOTG37enGcrYXtJrWNshdgIU8PpI8GNBLsq4t0cHfMVCz+IX0s+gC2+366U1yP+o0l1Ap6GSlySMXRluF5sRD+z55JIvsAwAz2opk8KSdaz/ucweU2jQ+6qfN5TVf2qW/wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615890; c=relaxed/simple;
	bh=OuWtOqF6MFJtj0nBtipe/PrVCqgOimHCQvOOQpylHpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esMvNjm2uDGxRs1NUsjYfHVvOMyNLYp+KbP/IdHs+m9pz6UqayLXoqwaUcO3Wxhz421RNkCYYPRvRWmDD2sT1kvTSbbocWeyY0obNVJgpCcUXAkAy/MFwYBKNtu2bpnP8GnIs/PodIE9s6ONixgfoLdGhCA72CGJLs3OZKqRT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5E72F4;
	Thu, 28 Mar 2024 01:52:02 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.73.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1CB03F7BD;
	Thu, 28 Mar 2024 01:51:25 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: [PATCH v3 3/4] PM: EM: Add em_dev_update_chip_binning()
Date: Thu, 28 Mar 2024 08:51:11 +0000
Message-Id: <20240328085112.3873050-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328085112.3873050-1-lukasz.luba@arm.com>
References: <20240328085112.3873050-1-lukasz.luba@arm.com>
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
 kernel/power/energy_model.c  | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index 6960dd7393b2d..e284aa335b6d0 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -808,3 +808,51 @@ static void em_update_workfn(struct work_struct *work)
 {
 	em_check_capacity_update();
 }
+
+/**
+ * em_dev_update_chip_binning() - Update Energy Model after the new voltage
+				information is present in the OPPs.
+ * @dev		: Device for which the Energy Model has to be updated.
+ *
+ * This function allows to update easily the EM with new values available in
+ * the OPP framework and DT. It can be used after the chip has been properly
+ * verified by device drivers and the voltages adjusted for the 'chip binning'.
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
+		dev_warn(dev, "Couldn't find Energy Model\n");
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


