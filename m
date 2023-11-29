Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4547FD552
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjK2LQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjK2LJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:09:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F272E272C;
        Wed, 29 Nov 2023 03:08:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D610E2F4;
        Wed, 29 Nov 2023 03:09:42 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A6CE3F5A1;
        Wed, 29 Nov 2023 03:08:53 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 20/23] PM: EM: Change debugfs configuration to use runtime EM table data
Date:   Wed, 29 Nov 2023 11:08:50 +0000
Message-Id: <20231129110853.94344-21-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump the runtime EM table values which can be modified in time. In order
to do that allocate chunk of debug memory which can be later freed
automatically thanks to devm_kcalloc().

This design can handle the fact that the EM table memory can change
after EM update, so debug code cannot use the pointer from initialization
phase.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 65 ++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c6e5f35a5129..cc47993b4d64 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -37,20 +37,63 @@ static bool _is_cpu_device(struct device *dev)
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *rootdir;
 
-static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
+struct em_dbg_info {
+	struct em_perf_domain *pd;
+	int ps_id;
+};
+
+#define DEFINE_EM_DBG_SHOW(name, fname)					\
+static int em_debug_##fname##_show(struct seq_file *s, void *unused)	\
+{									\
+	struct em_dbg_info *em_dbg = s->private;			\
+	struct em_perf_state *table;					\
+	unsigned long val;						\
+									\
+	table = em_get_table(em_dbg->pd);				\
+	val = table[em_dbg->ps_id].name;				\
+	em_put_table();							\
+									\
+	seq_printf(s, "%lu\n", val);					\
+	return 0;							\
+}									\
+DEFINE_SHOW_ATTRIBUTE(em_debug_##fname)
+
+DEFINE_EM_DBG_SHOW(frequency, frequency);
+DEFINE_EM_DBG_SHOW(power, power);
+DEFINE_EM_DBG_SHOW(cost, cost);
+DEFINE_EM_DBG_SHOW(performance, performance);
+DEFINE_EM_DBG_SHOW(flags, inefficiency);
+
+static void em_debug_create_ps(struct em_perf_domain *em_pd,
+			       struct em_dbg_info *em_dbg, int i,
+			       struct dentry *pd)
 {
+	struct em_perf_state *table;
+	unsigned long freq;
 	struct dentry *d;
 	char name[24];
 
-	snprintf(name, sizeof(name), "ps:%lu", ps->frequency);
+	em_dbg[i].pd = em_pd;
+	em_dbg[i].ps_id = i;
+
+	table = em_get_table(em_pd);
+	freq = table[i].frequency;
+	em_put_table();
+
+	snprintf(name, sizeof(name), "ps:%lu", freq);
 
 	/* Create per-ps directory */
 	d = debugfs_create_dir(name, pd);
-	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
-	debugfs_create_ulong("power", 0444, d, &ps->power);
-	debugfs_create_ulong("cost", 0444, d, &ps->cost);
-	debugfs_create_ulong("performance", 0444, d, &ps->performance);
-	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
+	debugfs_create_file("frequency", 0444, d, &em_dbg[i],
+			    &em_debug_frequency_fops);
+	debugfs_create_file("power", 0444, d, &em_dbg[i],
+			    &em_debug_power_fops);
+	debugfs_create_file("cost", 0444, d, &em_dbg[i],
+			    &em_debug_cost_fops);
+	debugfs_create_file("performance", 0444, d, &em_dbg[i],
+			    &em_debug_performance_fops);
+	debugfs_create_file("inefficient", 0444, d, &em_dbg[i],
+			    &em_debug_inefficiency_fops);
 }
 
 static int em_debug_cpus_show(struct seq_file *s, void *unused)
@@ -73,6 +116,7 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 
 static void em_debug_create_pd(struct device *dev)
 {
+	struct em_dbg_info *em_dbg;
 	struct dentry *d;
 	int i;
 
@@ -86,9 +130,14 @@ static void em_debug_create_pd(struct device *dev)
 	debugfs_create_file("flags", 0444, d, dev->em_pd,
 			    &em_debug_flags_fops);
 
+	em_dbg = devm_kcalloc(dev, dev->em_pd->nr_perf_states,
+			      sizeof(*em_dbg), GFP_KERNEL);
+	if (!em_dbg)
+		return;
+
 	/* Create a sub-directory for each performance state */
 	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
-		em_debug_create_ps(&dev->em_pd->table[i], d);
+		em_debug_create_ps(dev->em_pd, em_dbg, i, d);
 
 }
 
-- 
2.25.1

