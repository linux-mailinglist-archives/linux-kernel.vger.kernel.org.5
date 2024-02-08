Return-Path: <linux-kernel+bounces-57998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377684E01C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5666E1C25630
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1571B35;
	Thu,  8 Feb 2024 11:56:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388A6F51E;
	Thu,  8 Feb 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393383; cv=none; b=m/gV6ZvxTClVTM5pY260QR0RyQImfyDZjnqAhAoHDQC3DMKjAhsHuB+GPqcHeOD3kkOQMb74q8tCTlKva5S9/wULcvcsrDx9ShSO+ohBpW1B1rn4O0ZT+KcyyJBic7RsYbbCEgS+M0rtrICaV5kpboE0GRYEv5bT+DYIb/ZuIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393383; c=relaxed/simple;
	bh=bJjuu1EuWo74cFfQaOzHPNk7ZlfyPGiQ3J7BsnvcTcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZ86kaXJxcZX402AsiOH0enAawl/CQhPSrgFJid671aHSFLFa9XR1tc+MJ0UQ1GZusso8MroHUguWWUVO+aKoKz+maAqZ10yC+2d/V/Ey4ZDOKPN/yMhl5DTcuwPLBlQ0nyj3OE7VqAjzlS1O++23Lb2r4lHt+sdS7PLflRTN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9504DA7;
	Thu,  8 Feb 2024 03:57:02 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 143B13F5A1;
	Thu,  8 Feb 2024 03:56:17 -0800 (PST)
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
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v8 05/23] PM: EM: Introduce em_compute_costs()
Date: Thu,  8 Feb 2024 11:55:39 +0000
Message-Id: <20240208115557.1273962-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208115557.1273962-1-lukasz.luba@arm.com>
References: <20240208115557.1273962-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the EM costs computation code into a new dedicated function,
em_compute_costs(), that can be reused in other places in the future.

This change is not expected to alter the general functionality.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 0c3220ff54f7..5c47caaf270e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -103,14 +103,52 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
+static int em_compute_costs(struct device *dev, struct em_perf_state *table,
+			    struct em_data_callback *cb, int nr_states,
+			    unsigned long flags)
+{
+	unsigned long prev_cost = ULONG_MAX;
+	u64 fmax;
+	int i, ret;
+
+	/* Compute the cost of each performance state. */
+	fmax = (u64) table[nr_states - 1].frequency;
+	for (i = nr_states - 1; i >= 0; i--) {
+		unsigned long power_res, cost;
+
+		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
+			ret = cb->get_cost(dev, table[i].frequency, &cost);
+			if (ret || !cost || cost > EM_MAX_POWER) {
+				dev_err(dev, "EM: invalid cost %lu %d\n",
+					cost, ret);
+				return -EINVAL;
+			}
+		} else {
+			power_res = table[i].power;
+			cost = div64_u64(fmax * power_res, table[i].frequency);
+		}
+
+		table[i].cost = cost;
+
+		if (table[i].cost >= prev_cost) {
+			table[i].flags = EM_PERF_STATE_INEFFICIENT;
+			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
+				table[i].frequency);
+		} else {
+			prev_cost = table[i].cost;
+		}
+	}
+
+	return 0;
+}
+
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb,
 				unsigned long flags)
 {
-	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
+	unsigned long power, freq, prev_freq = 0;
 	struct em_perf_state *table;
 	int i, ret;
-	u64 fmax;
 
 	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
 	if (!table)
@@ -154,33 +192,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].frequency = prev_freq = freq;
 	}
 
-	/* Compute the cost of each performance state. */
-	fmax = (u64) table[nr_states - 1].frequency;
-	for (i = nr_states - 1; i >= 0; i--) {
-		unsigned long power_res, cost;
-
-		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
-			ret = cb->get_cost(dev, table[i].frequency, &cost);
-			if (ret || !cost || cost > EM_MAX_POWER) {
-				dev_err(dev, "EM: invalid cost %lu %d\n",
-					cost, ret);
-				goto free_ps_table;
-			}
-		} else {
-			power_res = table[i].power;
-			cost = div64_u64(fmax * power_res, table[i].frequency);
-		}
-
-		table[i].cost = cost;
-
-		if (table[i].cost >= prev_cost) {
-			table[i].flags = EM_PERF_STATE_INEFFICIENT;
-			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
-				table[i].frequency);
-		} else {
-			prev_cost = table[i].cost;
-		}
-	}
+	ret = em_compute_costs(dev, table, cb, nr_states, flags);
+	if (ret)
+		goto free_ps_table;
 
 	pd->table = table;
 	pd->nr_perf_states = nr_states;
-- 
2.25.1


