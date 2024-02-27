Return-Path: <linux-kernel+bounces-83952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D8786A079
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D851F25981
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC3149DEE;
	Tue, 27 Feb 2024 19:48:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38C136647;
	Tue, 27 Feb 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063339; cv=none; b=nftxRM6isptAONWMu4fT3sx2XAP8gQNV5Di+yGeyKbUTYxjyIpn7XOM1tjfCI25TM+qJtpZRyjKjqJXGEsKmV35EsfBgugckJXpTSPZOYovGkTSb9ePu886bF53Dkw9MJw67xmRUnbXqAxBn6qYoU9IlU/udF3/2i13WX/TErWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063339; c=relaxed/simple;
	bh=weZTEjsjdHoRlUCwUSNUDmI0Zpbk1jjy/G6mdtv6kOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8Yt7LdjtVcDzWHbN6jsc1N4ZbpA9A0IwWoJlTl3hgeTmY0dA490Oamd8vA+3fVEHk/Uilr00Ga+78pwVr+qxaYZ635fGrov27mbVHvSPFIgDXmesLQsuFbWBZf7HE+dqXuGlC0Ysh+ThM4j8TeiAc9w65DCKE91xmTN/uXMRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA77FFEC;
	Tue, 27 Feb 2024 11:49:31 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946D73F762;
	Tue, 27 Feb 2024 11:48:50 -0800 (PST)
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-clk@vger.kernel.org
Subject: [PATCH 1/5] clk: scmi: Allocate CLK operations dynamically
Date: Tue, 27 Feb 2024 19:48:08 +0000
Message-ID: <20240227194812.1209532-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227194812.1209532-1-cristian.marussi@arm.com>
References: <20240227194812.1209532-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMI Clocks descriptors expose an increasing number of properties, thing
which, in turn, leads to a varying set of supported CLK operations to be
associated with each clock.

Providing statically pre-defined CLK operations structs for all the
possible combinations of allowed clock features is becoming cumbersome and
error-prone.

Allocate the per-clock operations descriptors dynamically and populate it
with the strictly needed set of operations depending on the advertised
clock properties: one descriptor is created for each distinct combination
of clock operations, so minimizing the number of clk_ops structures to the
strictly minimum needed.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 163 ++++++++++++++++++++++++++++-------------
 1 file changed, 114 insertions(+), 49 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..d5d369b052bd 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Power Interface (SCMI) Protocol based clock driver
  *
- * Copyright (C) 2018-2022 ARM Ltd.
+ * Copyright (C) 2018-2024 ARM Ltd.
  */
 
 #include <linux/clk-provider.h>
@@ -16,6 +16,14 @@
 #define NOT_ATOMIC	false
 #define ATOMIC		true
 
+enum scmi_clk_feats {
+	SCMI_CLK_ATOMIC_SUPPORTED,
+	SCMI_CLK_MAX_FEATS
+};
+
+#define SCMI_MAX_CLK_OPS	(1 << SCMI_CLK_MAX_FEATS)
+
+static const struct clk_ops *clk_ops_db[SCMI_MAX_CLK_OPS];
 static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
 struct scmi_clk {
@@ -158,42 +166,6 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
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
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 			     const struct clk_ops *scmi_ops)
 {
@@ -230,6 +202,106 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 	return ret;
 }
 
+/**
+ * scmi_clk_ops_alloc() - Alloc and configure clock operations
+ * @dev: A device reference for devres
+ * @feats_key: A bitmap representing the desired clk_ops capabilities.
+ *
+ * Allocate and configure a proper set of clock operations depending on the
+ * specifically required SCMI clock features.
+ *
+ * Return: A pointer to the allocated and configured clk_ops on Success,
+ *	   or NULL on allocation failure.
+ */
+static const struct clk_ops *
+scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
+{
+	struct clk_ops *ops;
+
+	ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return NULL;
+	/*
+	 * We can provide enable/disable/is_enabled atomic callbacks only if the
+	 * underlying SCMI transport for an SCMI instance is configured to
+	 * handle SCMI commands in an atomic manner.
+	 *
+	 * When no SCMI atomic transport support is available we instead provide
+	 * only the prepare/unprepare API, as allowed by the clock framework
+	 * when atomic calls are not available.
+	 */
+	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
+		ops->enable = scmi_clk_atomic_enable;
+		ops->disable = scmi_clk_atomic_disable;
+		ops->is_enabled = scmi_clk_atomic_is_enabled;
+	} else {
+		ops->prepare = scmi_clk_enable;
+		ops->unprepare = scmi_clk_disable;
+	}
+
+	/* Rate ops */
+	ops->recalc_rate = scmi_clk_recalc_rate;
+	ops->round_rate = scmi_clk_round_rate;
+	ops->determine_rate = scmi_clk_determine_rate;
+	ops->set_rate = scmi_clk_set_rate;
+
+	/* Parent ops */
+	ops->get_parent = scmi_clk_get_parent;
+	ops->set_parent = scmi_clk_set_parent;
+
+	return ops;
+}
+
+/**
+ * scmi_clk_ops_select() - Select a proper set of clock operations
+ * @sclk: A reference to an SCMI clock descriptor
+ * @atomic_capable: A flag to indicate if atomic mode is supported by the
+ *		    transport
+ * @atomic_threshold: Platform atomic threshold value
+ *
+ * After having built a bitmap descriptor to represent the set of features
+ * needed by this SCMI clock, at first use it to lookup into the set of
+ * previously allocated clk_ops to check if a suitable combination of clock
+ * operations was already created; when no match is found allocate a brand new
+ * set of clk_ops satisfying the required combination of features and save it
+ * for future references.
+ *
+ * In this way only one set of clk_ops is ever created for each different
+ * combination that is effectively needed.
+ *
+ * Return: A pointer to the allocated and configured clk_ops on Success, or
+ *	   NULL otherwise.
+ */
+static const struct clk_ops *
+scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
+		    unsigned int atomic_threshold)
+{
+	const struct scmi_clock_info *ci = sclk->info;
+	unsigned int feats_key = 0;
+	const struct clk_ops *ops;
+
+	/*
+	 * Note that when transport is atomic but SCMI protocol did not
+	 * specify (or support) an enable_latency associated with a
+	 * clock, we default to use atomic operations mode.
+	 */
+	if (atomic_capable && ci->enable_latency <= atomic_threshold)
+		feats_key |= BIT(SCMI_CLK_ATOMIC_SUPPORTED);
+
+	/* Lookup previously allocated ops */
+	ops = clk_ops_db[feats_key];
+	if (!ops) {
+		ops = scmi_clk_ops_alloc(sclk->dev, feats_key);
+		if (!ops)
+			return NULL;
+
+		/* Store new ops combinations */
+		clk_ops_db[feats_key] = ops;
+	}
+
+	return ops;
+}
+
 static int scmi_clocks_probe(struct scmi_device *sdev)
 {
 	int idx, count, err;
@@ -285,16 +357,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->ph = ph;
 		sclk->dev = dev;
 
-		/*
-		 * Note that when transport is atomic but SCMI protocol did not
-		 * specify (or support) an enable_latency associated with a
-		 * clock, we default to use atomic operations mode.
-		 */
-		if (is_atomic &&
-		    sclk->info->enable_latency <= atomic_threshold)
-			scmi_ops = &scmi_atomic_clk_ops;
-		else
-			scmi_ops = &scmi_clk_ops;
+		scmi_ops = scmi_clk_ops_select(sclk, is_atomic,
+					       atomic_threshold);
+		if (!scmi_ops)
+			return -ENOMEM;
 
 		/* Initialize clock parent data. */
 		if (sclk->info->num_parents > 0) {
@@ -318,8 +384,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
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


