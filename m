Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AC7AD2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjIYIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjIYIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 761D7CCF;
        Mon, 25 Sep 2023 01:11:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F6251424;
        Mon, 25 Sep 2023 01:12:23 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B74273F5A1;
        Mon, 25 Sep 2023 01:11:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 12/18] PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
Date:   Mon, 25 Sep 2023 09:11:33 +0100
Message-Id: <20230925081139.1305766-13-lukasz.luba@arm.com>
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

The new Energy Model (EM) supports runtime modification of the performance
state table to better model the power used by the SoC. Use this new
feature to improve energy estimation and therefore task placement in
Energy Aware Scheduler (EAS).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8f055ab356ed..41290ee2cdd0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -261,15 +261,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
+	struct em_perf_table *runtime_table;
 	unsigned long freq, scale_cpu;
-	struct em_perf_state *table, *ps;
+	struct em_perf_state *ps;
 	int cpu, i;
 
 	if (!sum_util)
 		return 0;
 
-	table = pd->default_table->state;
-
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
@@ -280,7 +279,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &table[pd->nr_perf_states - 1];
+
+	/*
+	 * No rcu_read_lock() since it's already called by task scheduler.
+	 * The runtime_table is always there for CPUs, so we don't check.
+	 */
+	runtime_table = rcu_dereference(pd->runtime_table);
+
+	ps = &runtime_table->state[pd->nr_perf_states - 1];
 
 	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
@@ -290,9 +296,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	i = em_pd_get_efficient_state(table, pd->nr_perf_states, freq,
-				      pd->flags);
-	ps = &table[i];
+	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
+				      freq, pd->flags);
+	ps = &runtime_table->state[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.25.1

