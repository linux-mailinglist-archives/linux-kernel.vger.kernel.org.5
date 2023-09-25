Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5261E7AD2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjIYILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjIYILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E591BC;
        Mon, 25 Sep 2023 01:11:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 182291424;
        Mon, 25 Sep 2023 01:12:04 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B7C93F5A1;
        Mon, 25 Sep 2023 01:11:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 05/18] PM: EM: Refactor a new function em_compute_costs()
Date:   Mon, 25 Sep 2023 09:11:26 +0100
Message-Id: <20230925081139.1305766-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor a dedicated function which will be easier to maintain and re-use
in future. The upcoming changes for the modifiable EM perf_state table
will use it (instead of duplicating the code).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3dafdd7731c4..7ea882401833 100644
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

