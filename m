Return-Path: <linux-kernel+bounces-122609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9EC88FA59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161461F2977F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222EA657AF;
	Thu, 28 Mar 2024 08:51:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156C9651A4;
	Thu, 28 Mar 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615887; cv=none; b=qI6M+mr9Hir0WKVlF7PsxcCgjuAfgW1W3sbZqE9pjWfea9jGW20/fFifgh/4Ne7Dby5MU71fTq3CWK52tXl1N081R7ksj3bSsj8XtitdIuMeklypjdGbBv+UIVJfJW9IBBsnXg8htaNnNzp4FSsNdEXk8DndpLjlUmcmL7MfjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615887; c=relaxed/simple;
	bh=r+5CgjWk2UpOT4K0Tdkhu2881InrLA/O8baX+LFRbpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbunhQtQ3NPxCsH5bGOIfeBF5gQSEn3mkNufWmSAjpBQxHuJ+dEAiSyYRL9zId+/Uvu7PE2e5DyNHn/sVJwqicqXE7eu3lhIvp725koMJAI+Eywp35OaWChWJCZdCLmi1CxHgLGLIgh+OzUJ3opmatW8Gc0RftQDxIFFbjdyy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BFEB2F4;
	Thu, 28 Mar 2024 01:51:59 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.73.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E0BC3F7BD;
	Thu, 28 Mar 2024 01:51:22 -0700 (PDT)
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
Subject: [PATCH v3 2/4] PM: EM: Change the em_adjust_new_capacity() to re-use code
Date: Thu, 28 Mar 2024 08:51:10 +0000
Message-Id: <20240328085112.3873050-3-lukasz.luba@arm.com>
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


