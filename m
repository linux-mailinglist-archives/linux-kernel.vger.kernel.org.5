Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AC7AD2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjIYIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjIYILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E30441A7;
        Mon, 25 Sep 2023 01:11:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7D0DDA7;
        Mon, 25 Sep 2023 01:12:17 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B8E93F5A1;
        Mon, 25 Sep 2023 01:11:37 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans the old data
Date:   Mon, 25 Sep 2023 09:11:31 +0100
Message-Id: <20230925081139.1305766-11-lukasz.luba@arm.com>
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

The EM is going to support runtime modifications of the power data.
Introduce RCU safe mechanism to clean up the old allocated EM data.
It also adds a mutex for the EM structure to serialize the modifiers.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 5b40db38b745..2345837bfd2c 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,9 @@
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+static void em_cpufreq_update_efficiencies(struct device *dev,
+					   struct em_perf_state *table);
+
 static bool _is_cpu_device(struct device *dev)
 {
 	return (dev->bus == &cpu_subsys);
@@ -104,6 +107,32 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
+static void em_destroy_rt_table_rcu(struct rcu_head *rp)
+{
+	struct em_perf_table *runtime_table;
+
+	runtime_table = container_of(rp, struct em_perf_table, rcu);
+	kfree(runtime_table->state);
+	kfree(runtime_table);
+}
+
+static void em_perf_runtime_table_set(struct device *dev,
+				      struct em_perf_table *runtime_table)
+{
+	struct em_perf_domain *pd = dev->em_pd;
+	struct em_perf_table *tmp;
+
+	tmp = pd->runtime_table;
+
+	rcu_assign_pointer(pd->runtime_table, runtime_table);
+
+	em_cpufreq_update_efficiencies(dev, runtime_table->state);
+
+	/* Don't free default table since it's used by other frameworks. */
+	if (tmp != pd->default_table)
+		call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
+}
+
 static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    struct em_data_callback *cb, int nr_states,
 			    unsigned long flags)
-- 
2.25.1

