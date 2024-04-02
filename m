Return-Path: <linux-kernel+bounces-128300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFC895909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280CB28EA11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286E1350D7;
	Tue,  2 Apr 2024 15:59:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24810134CD0;
	Tue,  2 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073542; cv=none; b=jz3huPB4o2sP4VdYUVnm6I8AjQB/uTGSSoFGTw6uNghjwL9ubvs4uYPBWWVeXTYHwWvlJT+GrPP8/VI30FHab4oRhGedErL2m2NsiWKQ13wb4/ENl0eZuIyhDLpZhKzkp5CapFtqMNgoQWQ+J3amwnDTjDTKjA60JlAE5EdfRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073542; c=relaxed/simple;
	bh=r+5CgjWk2UpOT4K0Tdkhu2881InrLA/O8baX+LFRbpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eB7GvVn6sxobvTljOzx11bt1mqbrKHs8B9yaNeE7t/j0hQq7PxHfmKWs0tFGjXmMOAB2raURX6mZYIV3MuMaqidfUDR5Ym9tDzNqhJwV7+5FJJgLOgfmNlr668EorEokI7zj0bsY7TOKN7EWny6TzcPQD5GxT7R7ErhKHsYCCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C771007;
	Tue,  2 Apr 2024 08:59:31 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CF253F64C;
	Tue,  2 Apr 2024 08:58:56 -0700 (PDT)
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
Subject: [PATCH v4 2/4] PM: EM: Refactor em_adjust_new_capacity()
Date: Tue,  2 Apr 2024 16:58:20 +0100
Message-Id: <20240402155822.505491-3-lukasz.luba@arm.com>
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

Extract em_table_dup() and em_recalc_and_update() from
em_adjust_new_capacity(). Both functions will be later reused by the
'update EM due to chip binning' functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 58 +++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 9e1c9aa399ea9..6960dd7393b2d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -674,23 +674,15 @@ void em_dev_unregister_perf_domain(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
-/*
- * Adjustment of CPU performance values after boot, when all CPUs capacites
- * are correctly calculated.
- */
-static void em_adjust_new_capacity(struct device *dev,
-				   struct em_perf_domain *pd,
-				   u64 max_cap)
+static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *em_table;
 	struct em_perf_state *ps, *new_ps;
-	int ret, ps_size;
+	int ps_size;
 
 	em_table = em_table_alloc(pd);
-	if (!em_table) {
-		dev_warn(dev, "EM: allocation failed\n");
-		return;
-	}
+	if (!em_table)
+		return NULL;
 
 	new_ps = em_table->state;
 
@@ -702,24 +694,52 @@ static void em_adjust_new_capacity(struct device *dev,
 
 	rcu_read_unlock();
 
-	em_init_performance(dev, pd, new_ps, pd->nr_perf_states);
-	ret = em_compute_costs(dev, new_ps, NULL, pd->nr_perf_states,
+	return em_table;
+}
+
+static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
+				struct em_perf_table __rcu *em_table)
+{
+	int ret;
+
+	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
 			       pd->flags);
-	if (ret) {
-		dev_warn(dev, "EM: compute costs failed\n");
-		return;
-	}
+	if (ret)
+		goto free_em_table;
 
 	ret = em_dev_update_perf_domain(dev, em_table);
 	if (ret)
-		dev_warn(dev, "EM: update failed %d\n", ret);
+		goto free_em_table;
 
 	/*
 	 * This is one-time-update, so give up the ownership in this updater.
 	 * The EM framework has incremented the usage counter and from now
 	 * will keep the reference (then free the memory when needed).
 	 */
+free_em_table:
 	em_table_free(em_table);
+	return ret;
+}
+
+/*
+ * Adjustment of CPU performance values after boot, when all CPUs capacites
+ * are correctly calculated.
+ */
+static void em_adjust_new_capacity(struct device *dev,
+				   struct em_perf_domain *pd,
+				   u64 max_cap)
+{
+	struct em_perf_table __rcu *em_table;
+
+	em_table = em_table_dup(pd);
+	if (!em_table) {
+		dev_warn(dev, "EM: allocation failed\n");
+		return;
+	}
+
+	em_init_performance(dev, pd, em_table->state, pd->nr_perf_states);
+
+	em_recalc_and_update(dev, pd, em_table);
 }
 
 static void em_check_capacity_update(void)
-- 
2.25.1


