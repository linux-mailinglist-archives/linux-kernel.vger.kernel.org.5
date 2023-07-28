Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313A76726E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjG1Qwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjG1QwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:52:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C5F5589
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:50:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4291688;
        Fri, 28 Jul 2023 09:44:57 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3FC3F67D;
        Fri, 28 Jul 2023 09:44:11 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: [PATCH v5 19/24] x86/resctrl: Add helpers for system wide mon/alloc capable
Date:   Fri, 28 Jul 2023 16:42:49 +0000
Message-Id: <20230728164254.27562-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
References: <20230728164254.27562-1-james.morse@arm.com>
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

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v1:
 * Added missing conversion in mkdir_rdt_prepare_rmid_free()

Changes since v3:
 * Expanded the commit message.
---
 arch/x86/include/asm/resctrl.h            | 13 +++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++------------
 5 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 3876d4bb4bed..63a4a2332d61 100644
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
index ac39fecba4ca..f99e0a1f39c8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -136,8 +136,6 @@ struct rmid_read {
 	void			*arch_mon_ctx;
 };
 
-extern bool rdt_alloc_capable;
-extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
 extern bool resctrl_mounted;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5350d44b16b6..c0b1ad8d8f6d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -842,7 +842,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	 * If the filesystem has been unmounted this work no longer needs to
 	 * run.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -879,7 +879,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	 * When a domain comes online there is no guarantee the filesystem is
 	 * mounted. If not, there is no need to catch counter overflow.
 	 */
-	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
 	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 5ebd6e54c7f2..460421051abf 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -567,7 +567,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
 		if (ret)
 			goto err_cpus_list;
@@ -614,7 +614,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 	if (ret)
 		goto err_cpus;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
 		if (ret)
 			goto err_cpus_list;
@@ -762,7 +762,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = alloc_rmid(rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ce1ed485e4f7..fef78a3dc632 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -630,13 +630,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 
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
@@ -2519,7 +2519,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret < 0)
 		goto out_schemata_free;
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
 					  &rdtgroup_default, "mon_groups",
 					  &kn_mongrp);
@@ -2541,12 +2541,12 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2560,10 +2560,10 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2815,9 +2815,9 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
-	if (rdt_alloc_capable)
+	if (resctrl_arch_alloc_capable())
 		resctrl_arch_disable_alloc();
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
@@ -3197,7 +3197,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
-	if (!rdt_mon_capable)
+	if (!resctrl_arch_mon_capable())
 		return 0;
 
 	ret = alloc_rmid(rdtgrp->closid);
@@ -3219,7 +3219,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (rdt_mon_capable)
+	if (resctrl_arch_mon_capable())
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
 }
 
@@ -3385,7 +3385,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
-	if (rdt_mon_capable) {
+	if (resctrl_arch_mon_capable()) {
 		/*
 		 * Create an empty mon_groups directory to hold the subset
 		 * of tasks and cpus to monitor.
@@ -3440,14 +3440,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
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
@@ -3779,7 +3779,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -3862,7 +3862,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * by rdt_get_tree() calling mkdir_mondata_all().
 	 * If resctrl is mounted, add per domain monitor data directories.
 	 */
-	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && resctrl_arch_mon_capable())
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;
-- 
2.39.2

