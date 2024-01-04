Return-Path: <linux-kernel+bounces-17024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193A824745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE771F22502
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F834CEC;
	Thu,  4 Jan 2024 17:15:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8034CEA;
	Thu,  4 Jan 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8886B1007;
	Thu,  4 Jan 2024 09:16:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F6A63F64C;
	Thu,  4 Jan 2024 09:15:42 -0800 (PST)
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
	wvw@google.com
Subject: [PATCH v6 20/23] PM: EM: Change debugfs configuration to use runtime EM table data
Date: Thu,  4 Jan 2024 17:15:50 +0000
Message-Id: <20240104171553.2080674-21-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104171553.2080674-1-lukasz.luba@arm.com>
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 0fa98fa7dbec..1257b8fea9fc 100644
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


