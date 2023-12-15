Return-Path: <linux-kernel+bounces-1455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15F814F24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF31C245D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375FC30124;
	Fri, 15 Dec 2023 17:44:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5721487A4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FEBE1650;
	Fri, 15 Dec 2023 09:45:36 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3723F5A1;
	Fri, 15 Dec 2023 09:44:48 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8 16/24] x86/resctrl: Make resctrl_mounted checks explicit
Date: Fri, 15 Dec 2023 17:43:35 +0000
Message-Id: <20231215174343.13872-17-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rdt_enable_key is switched when resctrl is mounted, and used to
prevent a second mount of the filesystem. It also enables the
architecture's context switch code.

This requires another architecture to have the same set of static-keys,
as resctrl depends on them too. The existing users of these static-keys
are implicitly also checking if the filesystem is mounted.

Make the resctrl_mounted checks explicit: resctrl can keep track of
whether it has been mounted once. This doesn't need to be combined with
whether the arch code is context switching the CLOSID.

rdt_mon_enable_key is never used just to test that resctrl is mounted,
but does also have this implication. Add a resctrl_mounted to all uses
of rdt_mon_enable_key.

This will allow the static-key changing to be moved behind resctrl_arch_
calls.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v3:
 * Removed a newline.
 * Rephrased commit message

Changes since v4:
 * Rephrased comment.

Changes since v7:
 * Removed a sentence with the word 'subsequent' in it.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bb07b9b01e36..5ce49503fcd8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -145,6 +145,7 @@ extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
+extern bool resctrl_mounted;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 20fe7ed494c2..e3e42736fb22 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -835,7 +835,11 @@ void mbm_handle_overflow(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	/*
+	 * If the filesystem has been unmounted this work no longer needs to
+	 * run.
+	 */
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -868,7 +872,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	/*
+	 * When a domain comes online there is no guarantee the filesystem is
+	 * mounted. If not, there is no need to catch counter overflow.
+	 */
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		return;
 	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 460ac501f9e8..646d224c3ac9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -42,6 +42,9 @@ LIST_HEAD(rdt_all_groups);
 /* list of entries for the schemata file */
 LIST_HEAD(resctrl_schema_all);
 
+/* The filesystem can only be mounted once. */
+bool resctrl_mounted;
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -881,7 +884,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 	mutex_lock(&rdtgroup_mutex);
 
 	/* Return empty if resctrl has not been mounted. */
-	if (!static_branch_unlikely(&rdt_enable_key)) {
+	if (!resctrl_mounted) {
 		seq_puts(s, "res:\nmon:\n");
 		goto unlock;
 	}
@@ -2613,7 +2616,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	/*
 	 * resctrl file system can only be mounted once.
 	 */
-	if (static_branch_unlikely(&rdt_enable_key)) {
+	if (resctrl_mounted) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2674,8 +2677,10 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
 
-	if (rdt_alloc_capable || rdt_mon_capable)
+	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
+		resctrl_mounted = true;
+	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2949,6 +2954,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
+	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
@@ -3918,7 +3924,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -3995,8 +4001,13 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (is_llc_occupancy_enabled())
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
-	/* If resctrl is mounted, add per domain monitor data directories. */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	/*
+	 * If the filesystem is not mounted then only the default resource group
+	 * exists. Creation of its directories is deferred until mount time
+	 * by rdt_get_tree() calling mkdir_mondata_all().
+	 * If resctrl is mounted, add per domain monitor data directories.
+	 */
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;
-- 
2.20.1


