Return-Path: <linux-kernel+bounces-28775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D48302E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B227C1F24DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A351DA56;
	Wed, 17 Jan 2024 09:56:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546441DA33;
	Wed, 17 Jan 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485374; cv=none; b=kKi0t5q3hef3A7gelYp3sL6FNf6ZoFevcy0ZOAyUII8mZCPb0nvHXjpDnmj+0nQUo194AfMf/pa7JjfguQ1wyD59U8bl9dv0EWuKFW4R8Z2A9Ln7tRnR0zkls0+TXP/HJP05K383bhzsciYzOfFLFpcu5FGJ/mo7TWUDEXmVI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485374; c=relaxed/simple;
	bh=Rzy1bpw1hjeIG4FREVAS7YWhCelPT+QhR3d1SJuCUO0=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=lLbjJPt4EFAiP7fq1FRzEqBM+zwQF9V1j53DHZ/3MWdboQ5uUfRlY32lmyVkfc6hNzjUu/g4pTWtZQx/YTjshF2Nl0gj0D9mGWGDHonv439Kz/Fimr7H3rLRWN+2muoou12XI8PYbKc/aPMim7m+4LZ17Rx/6+W3C4d7C+AHTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB594DA7;
	Wed, 17 Jan 2024 01:56:57 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2267E3F5A1;
	Wed, 17 Jan 2024 01:56:08 -0800 (PST)
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
Subject: [PATCH v7 05/23] PM: EM: Introduce em_compute_costs()
Date: Wed, 17 Jan 2024 09:56:56 +0000
Message-Id: <20240117095714.1524808-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
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

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index aa7c89f9e115..3bea930410c6 100644
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


