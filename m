Return-Path: <linux-kernel+bounces-65810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33308855223
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CDF1F2AE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC512C549;
	Wed, 14 Feb 2024 18:30:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9112C53C;
	Wed, 14 Feb 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935445; cv=none; b=fHv8LJs2CGhCq+Lz6zilPMMN1QiNkNXyOAYrDut3KgD2lgoAew/UmmDN0buMRVv5FBL/3tFTWpFhQrQYLvVe4+yLGYh+HvkXGaAB/wJmgflDK8cAZf6N52Z4xT/XGR5CPBGiQzjPOUh5eVolCD1TAzAC+2ynxb+MXPp+FW+Jsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935445; c=relaxed/simple;
	bh=FAXe14bgrUJ605crID4nOzEAT9unDU7UAMXUqo6EjIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqZzYCorCSX9YwG9lBP1auGnmTRoeFK/TZ9gHJnBQ5kWwEL4a8de0RqVsWfHKY7YIeHeBJqKrgVYdniXdO9D/J5N3JBo0ndefSwtUUHggml9VPjQQWAmprXS/8SjGAVTNi4jnGf/ruAuT6pp3t0R3pDKRbN4AUfA6NbtdKWAq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D31D21FB;
	Wed, 14 Feb 2024 10:31:23 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9AC83F7B4;
	Wed, 14 Feb 2024 10:30:40 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: [PATCH 6/7] clk: scmi: Allocate CLK operations dynamically
Date: Wed, 14 Feb 2024 18:30:05 +0000
Message-ID: <20240214183006.3403207-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMI Clocks descriptors expose and increasing number of properties that in
turn lead to a different set of supported CLK operations to be associated
dynamically with a clock.

Providing statically pre-defined CLK operations structs for all the
possible combinations of allowed properties is cumbersome and error-prone.

Allocate per-clock operations descriptor dynamically and populate it with
the strictly needed set of operations depending on the advertised clock
properties.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 129 ++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 5747b6d651f0..b91a0dbd2fe0 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -158,51 +158,6 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
 	return !!enabled;
 }
 
-/*
- * We can provide enable/disable/is_enabled atomic callbacks only if the
- * underlying SCMI transport for an SCMI instance is configured to handle
- * SCMI commands in an atomic manner.
- *
- * When no SCMI atomic transport support is available we instead provide only
- * the prepare/unprepare API, as allowed by the clock framework when atomic
- * calls are not available.
- *
- * Two distinct sets of clk_ops are provided since we could have multiple SCMI
- * instances with different underlying transport quality, so they cannot be
- * shared.
- */
-static const struct clk_ops scmi_clk_ops = {
-	.recalc_rate = scmi_clk_recalc_rate,
-	.round_rate = scmi_clk_round_rate,
-	.set_rate = scmi_clk_set_rate,
-	.prepare = scmi_clk_enable,
-	.unprepare = scmi_clk_disable,
-	.set_parent = scmi_clk_set_parent,
-	.get_parent = scmi_clk_get_parent,
-	.determine_rate = scmi_clk_determine_rate,
-};
-
-static const struct clk_ops scmi_atomic_clk_ops = {
-	.recalc_rate = scmi_clk_recalc_rate,
-	.round_rate = scmi_clk_round_rate,
-	.set_rate = scmi_clk_set_rate,
-	.enable = scmi_clk_atomic_enable,
-	.disable = scmi_clk_atomic_disable,
-	.is_enabled = scmi_clk_atomic_is_enabled,
-	.set_parent = scmi_clk_set_parent,
-	.get_parent = scmi_clk_get_parent,
-	.determine_rate = scmi_clk_determine_rate,
-};
-
-static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
-	.recalc_rate = scmi_clk_recalc_rate,
-	.round_rate = scmi_clk_round_rate,
-	.set_rate = scmi_clk_set_rate,
-	.set_parent = scmi_clk_set_parent,
-	.get_parent = scmi_clk_get_parent,
-	.determine_rate = scmi_clk_determine_rate,
-};
-
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 			     const struct clk_ops *scmi_ops)
 {
@@ -239,6 +194,71 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 	return ret;
 }
 
+/**
+ * scmi_clk_ops_alloc() - Alloc and configure CLK ops
+ * @sclk: A reference to an SCMI clock descriptor
+ * @atomic_capable: A flag to indicate if atomic mode is supported by the
+ *		    transport
+ * @atomic_threshold: Platform atomic threshold value
+ *
+ * Allocate and configure a proper set of CLK operations depending on the
+ * specific SCMI clock characteristics and platform atomic operation capability.
+ *
+ * We can provide enable/disable/is_enabled atomic callbacks only if the
+ * underlying SCMI transport for an SCMI instance is configured to handle
+ * SCMI commands in an atomic manner.
+ *
+ * When no SCMI atomic transport support is available we instead provide only
+ * the prepare/unprepare API, as allowed by the clock framework when atomic
+ * calls are not available.
+ *
+ * Return: A pointer to the allocated and configured clk_ops on Success,
+ *	   NULL otherwise.
+ */
+static const struct clk_ops *
+scmi_clk_ops_alloc(struct scmi_clk *sclk, bool atomic_capable,
+		   unsigned int atomic_threshold)
+{
+	const struct scmi_clock_info *ci = sclk->info;
+	struct clk_ops *ops;
+
+	ops = devm_kzalloc(sclk->dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return NULL;
+
+	/*
+	 * Note that when transport is atomic but SCMI protocol did not
+	 * specify (or support) an enable_latency associated with a
+	 * clock, we default to use atomic operations mode.
+	 */
+	if (!ci->state_ctrl_forbidden) {
+		if (atomic_capable && ci->enable_latency <= atomic_threshold) {
+			ops->enable = scmi_clk_atomic_enable;
+			ops->disable = scmi_clk_atomic_disable;
+		} else {
+			ops->prepare = scmi_clk_enable;
+			ops->unprepare = scmi_clk_disable;
+		}
+	}
+
+	if (atomic_capable)
+		ops->is_enabled = scmi_clk_atomic_is_enabled;
+
+	/* Rate ops */
+	ops->recalc_rate = scmi_clk_recalc_rate;
+	ops->round_rate = scmi_clk_round_rate;
+	ops->determine_rate = scmi_clk_determine_rate;
+	if (!ci->rate_ctrl_forbidden)
+		ops->set_rate = scmi_clk_set_rate;
+
+	/* Parent ops */
+	ops->get_parent = scmi_clk_get_parent;
+	if (!ci->parent_ctrl_forbidden)
+		ops->set_parent = scmi_clk_set_parent;
+
+	return ops;
+}
+
 static int scmi_clocks_probe(struct scmi_device *sdev)
 {
 	int idx, count, err;
@@ -294,18 +314,9 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->ph = ph;
 		sclk->dev = dev;
 
-		/*
-		 * Note that when transport is atomic but SCMI protocol did not
-		 * specify (or support) an enable_latency associated with a
-		 * clock, we default to use atomic operations mode.
-		 */
-		if (sclk->info->state_ctrl_forbidden)
-			scmi_ops = &scmi_no_state_ctrl_clk_ops;
-		else if (is_atomic &&
-			 sclk->info->enable_latency <= atomic_threshold)
-			scmi_ops = &scmi_atomic_clk_ops;
-		else
-			scmi_ops = &scmi_clk_ops;
+		scmi_ops = scmi_clk_ops_alloc(sclk, is_atomic, atomic_threshold);
+		if (!scmi_ops)
+			return -ENOMEM;
 
 		/* Initialize clock parent data. */
 		if (sclk->info->num_parents > 0) {
@@ -324,13 +335,13 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);
 			devm_kfree(dev, sclk->parent_data);
+			devm_kfree(dev, scmi_ops);
 			devm_kfree(dev, sclk);
 			hws[idx] = NULL;
 		} else {
 			dev_dbg(dev, "Registered clock:%s%s\n",
 				sclk->info->name,
-				scmi_ops == &scmi_atomic_clk_ops ?
-				" (atomic ops)" : "");
+				scmi_ops->enable ? " (atomic ops)" : "");
 			hws[idx] = &sclk->hw;
 		}
 	}
-- 
2.43.0


