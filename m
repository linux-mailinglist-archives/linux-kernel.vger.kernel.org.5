Return-Path: <linux-kernel+bounces-58014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A984E03C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448621C26B07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA07EF1A;
	Thu,  8 Feb 2024 11:57:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4047EF01;
	Thu,  8 Feb 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393427; cv=none; b=TTDZW8PF7g11GqM9Ykj5u54QSBqcA/8fXFgQHoeE6eH56xG6LxXrFMLh31YQDX/146qUQBCiWLQ4GZAS6GOWOHY6tFsXM5/difGyfxh2riksJYP1CxHIxqvyzZE/Qlr2pL1Z5w+ZcFgWHADuDTraD7sNKRMCducEwRrz1NchOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393427; c=relaxed/simple;
	bh=jF9xvV+ffyDXEcEQmXtChRdRJUYNKBG4fWdMvZO8qKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKM4RXpawkxUU+qbfbrJnQfClnXoG0MO36xgrwmYzWvvpsve4lmO4xR6A0ilxoQQIrqnVL3Liu8yqcosCPCwCflYHw1MLmsQUPShRSkWjEXOmlanyW8EHzvJ/ag+fBvRu1TJKmtYb6pQGm6FvSdVU4OJg1O9Cand+gSN45oiWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A88E3DA7;
	Thu,  8 Feb 2024 03:57:47 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.8.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8A8B3F5A1;
	Thu,  8 Feb 2024 03:57:02 -0800 (PST)
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
Subject: [PATCH v8 20/23] PM: EM: Change debugfs configuration to use runtime EM table data
Date: Thu,  8 Feb 2024 11:55:54 +0000
Message-Id: <20240208115557.1273962-21-lukasz.luba@arm.com>
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

Dump the runtime EM table values which can be modified in time. In order
to do that allocate chunk of debug memory which can be later freed
automatically thanks to devm_kcalloc().

This design can handle the fact that the EM table memory can change
after EM update, so debug code cannot use the pointer from initialization
phase.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 67 ++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index a631d7d52c40..548908e686ed 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -37,20 +37,65 @@ static bool _is_cpu_device(struct device *dev)
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
+	rcu_read_lock();						\
+	table = em_perf_state_from_pd(em_dbg->pd);			\
+	val = table[em_dbg->ps_id].name;				\
+	rcu_read_unlock();						\
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
+	rcu_read_lock();
+	table = em_perf_state_from_pd(em_pd);
+	freq = table[i].frequency;
+	rcu_read_unlock();
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
@@ -73,6 +118,7 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 
 static void em_debug_create_pd(struct device *dev)
 {
+	struct em_dbg_info *em_dbg;
 	struct dentry *d;
 	int i;
 
@@ -86,9 +132,14 @@ static void em_debug_create_pd(struct device *dev)
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


