Return-Path: <linux-kernel+bounces-128302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6989590E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CEB1C228AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405F135A51;
	Tue,  2 Apr 2024 15:59:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03821353FD;
	Tue,  2 Apr 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073546; cv=none; b=b5z2jk/KX1g+lQFr31ORvbX1MwrFWZpGPToAL9yE893fCoChWQpl0nIds/Iz04LvusVMr0+IZ8wL7m0/dEwYOcagvnVhM1HDi1G57jGBwK0y4FGNssKWEzOmfR6geCihWve9PKhoWje7dywKz03/p8zjeqAX/6akrDP9R0KcYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073546; c=relaxed/simple;
	bh=pXehMlDwcfZpExO0koN4FVmfrxBSA3g+V0CXukHjIjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjr6/dgLdqhpzZN5wZfwSB2Y1pnreIp5t1PiRt0BIeCmSeSISQDmp4TidGR3k8jer3bYEditviZdw+Nv9f5U8yS8uApmclYed7soQtrTIQ4wWhUrHsJfxqk2FqtHHIHn7qXSW+xSLMQUWHXEVPPIwWHwQvDIOKLJbtETMQ11JjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9431007;
	Tue,  2 Apr 2024 08:59:35 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C5FF3F64C;
	Tue,  2 Apr 2024 08:59:01 -0700 (PDT)
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
Subject: [PATCH v4 3/4] PM: EM: Add em_dev_update_chip_binning()
Date: Tue,  2 Apr 2024 16:58:21 +0100
Message-Id: <20240402155822.505491-4-lukasz.luba@arm.com>
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
index 6960dd7393b2d..927cc55ba0b3d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -808,3 +808,51 @@ static void em_update_workfn(struct work_struct *work)
 {
 	em_check_capacity_update();
 }
+
+/**
+ * em_dev_update_chip_binning() - Update Energy Model after the new voltage
+ *				information is present in the OPPs.
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


