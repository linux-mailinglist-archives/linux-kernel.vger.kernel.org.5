Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45275CC97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGUPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGUPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:51:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E115C3AAF;
        Fri, 21 Jul 2023 08:50:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FB51515;
        Fri, 21 Jul 2023 08:51:17 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.0.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B7513F738;
        Fri, 21 Jul 2023 08:50:30 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, mhiramat@kernel.org
Subject: [PATCH v3 11/12] PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
Date:   Fri, 21 Jul 2023 16:50:21 +0100
Message-Id: <20230721155022.2339982-12-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721155022.2339982-1-lukasz.luba@arm.com>
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/energy_model.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index fd4110166e97..62744547b8be 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -261,6 +261,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
+	struct em_perf_table *runtime_table;
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu, i;
@@ -278,7 +279,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
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
@@ -288,9 +296,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
-				      pd->flags);
-	ps = &pd->table[i];
+	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
+				      freq, pd->flags);
+	ps = &runtime_table->state[i];
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.25.1

