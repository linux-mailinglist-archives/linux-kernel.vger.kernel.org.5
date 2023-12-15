Return-Path: <linux-kernel+bounces-1458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFE814F27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3072128A4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA25F841;
	Fri, 15 Dec 2023 17:45:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFF56393
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89B8715DB;
	Fri, 15 Dec 2023 09:45:45 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99B5B3F5A1;
	Fri, 15 Dec 2023 09:44:57 -0800 (PST)
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
Subject: [PATCH v8 19/24] x86/resctrl: Add helpers for system wide mon/alloc capable
Date: Fri, 15 Dec 2023 17:43:38 +0000
Message-Id: <20231215174343.13872-20-james.morse@arm.com>
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

resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
whether any of the resources support the corresponding features.
resctrl also uses the static-keys that affect the architecture's
context-switch code to determine the same thing.

This forces another architecture to have the same static-keys.

As the static-key is enabled based on the capable flag, and none of
the filesystem uses of these are in the scheduler path, move the
capable flags behind helpers, and use these in the filesystem
code instead of the static-key.

After this change, only the architecture code manages and uses
the static-keys to ensure __resctrl_sched_in() does not need
runtime checks.

This avoids multiple architectures having to define the same
static-keys.

Cases where the static-key implicitly tested if the resctrl
filesystem was mounted all have an explicit check added by a
previous patch.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v1:
 * Added missing conversion in mkdir_rdt_prepare_rmid_free()

Changes since v3:
 * Expanded the commit message.

Change since v7:
 * Added a few missing resctrl_arch_mon_capable() that crept in during
   a rebase.
---
 arch/x86/include/asm/resctrl.h            | 13 ++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 38 +++++++++++------------
 5 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b74aa34dc9e8..12dbd2588ca7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -38,10 +38,18 @@ struct resctrl_pqr_state {
 
 DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
+extern bool rdt_alloc_capable;
+extern bool rdt_mon_capable;
+
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
+static inline bool resctrl_arch_alloc_capable(void)
+{
+	return rdt_alloc_capable;
+}
+
 static inline void resctrl_arch_enable_alloc(void)
 {
 	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
@@ -54,6 +62,11 @@ static inline void resctrl_arch_disable_alloc(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+static inline bool resctrl_arch_mon_capable(void)
+{
+	return rdt_mon_capable;
+}
+
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 68b9beed8e42..c4c1e1909058 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -138,8 +138,6 @@ struct rmid_read {
 	void			*arch_mon_ctx;
 };
 
-extern bool rdt_alloc_capable;
-extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 extern bool resctrl_mounted;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e3e42736fb22..95020b113ee5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -839,7 +839,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * If the filesystem has been unmounted this work no longer needs to
 	 * run.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -876,7 +876,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	 * When a domain comes online there is no guarantee the filesystem is
 	 * mounted. If not, there is no need to catch counter overflow.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
 	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d8f44113ed1f..8056bed033cc 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -581,7 +581,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
 		if (ret)
 			goto err_cpus_list;
@@ -628,7 +628,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
 		if (ret)
 			goto err_cpus_list;
@@ -776,7 +776,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = alloc_rmid(rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 74a8494a0c91..89aef67588c0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -641,13 +641,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
+	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
 		resctrl_arch_match_closid(t, r->closid));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
-	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
+	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
 		resctrl_arch_match_rmid(t, r->mon.parent->closid,
 					r->mon.rmid));
 }
@@ -2637,7 +2637,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
 	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
@@ -2650,7 +2650,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_schemata_free;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
 					  &rdtgroup_default, "mon_groups",
 					  &kn_mongrp);
@@ -2672,12 +2672,12 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_psl;
 
-	if (rdt_alloc_capable)
+	if (resctrl_arch_alloc_capable())
 		resctrl_arch_enable_alloc();
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		resctrl_arch_enable_mon();
 
-	if (rdt_alloc_capable || rdt_mon_capable)
+	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
@@ -2691,10 +2691,10 @@ static int rdt_get_tree(struct fs_context *fc)
 out_psl:
 	rdt_pseudo_lock_release();
 out_mondata:
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
@@ -2949,9 +2949,9 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
-	if (rdt_alloc_capable)
+	if (resctrl_arch_alloc_capable())
 		resctrl_arch_disable_alloc();
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
@@ -3331,7 +3331,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (!rdt_mon_capable)
+	if (!resctrl_arch_mon_capable())
 		return 0;
 
 	ret = alloc_rmid(rdtgrp->closid);
@@ -3353,7 +3353,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
 
@@ -3417,7 +3417,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 
 	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-		if (rdt_mon_capable)
+		if (resctrl_arch_mon_capable())
 			files |= RFTYPE_MON;
 	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
@@ -3526,7 +3526,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		/*
 		 * Create an empty mon_groups directory to hold the subset
 		 * of tasks and cpus to monitor.
@@ -3581,14 +3581,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	 * allocation is supported, add a control and monitoring
 	 * subdirectory
 	 */
-	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
+	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
 		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
 
 	/*
 	 * If RDT monitoring is supported and the parent directory is a valid
 	 * "mon_groups" directory, add a monitoring subdirectory.
 	 */
-	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
+	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
 		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
 	return -EPERM;
@@ -3923,7 +3923,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -4006,7 +4006,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * by rdt_get_tree() calling mkdir_mondata_all().
 	 * If resctrl is mounted, add per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;
-- 
2.20.1


