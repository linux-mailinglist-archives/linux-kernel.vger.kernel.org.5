Return-Path: <linux-kernel+bounces-128299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7F895903
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C290D28E589
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D813443E;
	Tue,  2 Apr 2024 15:58:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE58131751;
	Tue,  2 Apr 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073538; cv=none; b=bCweLzhZWISD/gf0DARvouFkLR4BGhxPgyQq9Or6RV5KKCld9p27E/YjLg6/bBmfX+Ya0J1Q4c8Gg0h2higOhE100xZHLqgs77+A/ymERSLAs8VEDZY/jS5x8c4A5D2CZfwwF3L4BDl34RdZXk3fM5ipvtPMxRTn7qCEvjsPNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073538; c=relaxed/simple;
	bh=BhCjs8hNmQMRXzsGGUrm/MK8tLNJTIba63C7/MbzQrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lhe1YGZH6vUuMN59ZrjBanbHYr3UHwonrMYDWWRY2Z0+WznvJqJ+Xf+wZCXcXuLHpMIcDoavbgJu2VKqHWoiL0Smjcbjz+f4gEZAylmyzZoOJi+d/RV6yZ3003m9i2MSMai3ReqAvt70nOqQqoXtpn/lZtc4qtP8GsC85t7BqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883FA106F;
	Tue,  2 Apr 2024 08:59:27 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 177633F64C;
	Tue,  2 Apr 2024 08:58:49 -0700 (PDT)
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
Subject: [PATCH v4 1/4] OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
Date: Tue,  2 Apr 2024 16:58:19 +0100
Message-Id: <20240402155822.505491-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402155822.505491-1-lukasz.luba@arm.com>
References: <20240402155822.505491-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are device drivers which can modify voltage values for OPPs. It
could be due to the chip binning and those drivers have specific chip
knowledge about it. This adjustment can happen after Energy Model is
registered, thus EM can have stale data about power.

Export dev_opp_pm_calc_power() which can be used by Energy Model to
calculate new power with the new voltage for OPPs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/of.c       | 17 ++++++++++++-----
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f9f0b22bccbb4..282eb5966fd03 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1494,20 +1494,26 @@ _get_dt_power(struct device *dev, unsigned long *uW, unsigned long *kHz)
 	return 0;
 }
 
-/*
- * Callback function provided to the Energy Model framework upon registration.
+/**
+ * dev_pm_opp_calc_power() - Calculate power value for device with EM
+ * @dev		: Device for which an Energy Model has to be registered
+ * @uW		: New power value that is calculated
+ * @kHz		: Frequency for which the new power is calculated
+ *
  * This computes the power estimated by @dev at @kHz if it is the frequency
  * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
  * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
  * frequency and @uW to the associated power. The power is estimated as
  * P = C * V^2 * f with C being the device's capacitance and V and f
  * respectively the voltage and frequency of the OPP.
+ * It is also used as a callback function provided to the Energy Model
+ * framework upon registration.
  *
  * Returns -EINVAL if the power calculation failed because of missing
  * parameters, 0 otherwise.
  */
-static int __maybe_unused _get_power(struct device *dev, unsigned long *uW,
-				     unsigned long *kHz)
+int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
+			  unsigned long *kHz)
 {
 	struct dev_pm_opp *opp;
 	struct device_node *np;
@@ -1544,6 +1550,7 @@ static int __maybe_unused _get_power(struct device *dev, unsigned long *uW,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_calc_power);
 
 static bool _of_has_opp_microwatt_property(struct device *dev)
 {
@@ -1619,7 +1626,7 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto failed;
 	}
 
-	EM_SET_ACTIVE_POWER_CB(em_cb, _get_power);
+	EM_SET_ACTIVE_POWER_CB(em_cb, dev_pm_opp_calc_power);
 
 register_em:
 	ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 065a47382302c..31370deb9905f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -476,6 +476,8 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table);
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus);
+int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
+			  unsigned long *kHz);
 static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 {
 	em_dev_unregister_perf_domain(dev);
@@ -539,6 +541,12 @@ static inline void dev_pm_opp_of_unregister_em(struct device *dev)
 {
 }
 
+static inline int dev_pm_opp_calc_power(struct device *dev, unsigned long *uW,
+			  unsigned long *kHz)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	return -EOPNOTSUPP;
-- 
2.25.1


