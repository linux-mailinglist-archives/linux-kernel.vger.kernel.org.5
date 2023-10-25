Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CD7D72E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJYSGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjJYSF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:05:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C51D819B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:05:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090C41515;
        Wed, 25 Oct 2023 11:06:22 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F5F3F738;
        Wed, 25 Oct 2023 11:05:37 -0700 (PDT)
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v7 16/24] x86/resctrl: Make resctrl_mounted checks explicit
Date:   Wed, 25 Oct 2023 18:03:37 +0000
Message-Id: <20231025180345.28061-17-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
References: <20231025180345.28061-1-james.morse@arm.com>
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
of rdt_mon_enable_key. This will allow rdt_mon_enable_key to be swapped
with a helper in a subsequent patch.

This will allow the static-key changing to be moved behind resctrl_arch_
calls.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v3:
 * Removed a newline.
 * Rephrased commit message

Changes since v4:
 * Rephrased comment.

No changes since v6
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
index 1ca8db8c82cc..843df6f64e0e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -837,7 +837,11 @@ void mbm_handle_overflow(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	/*
+	 * If the filesystem has been unmounted this work no longer needs to
+	 * run.
+	 */
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -870,7 +874,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
index fe6dfea471f2..9ce1f981c8e1 100644
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
2.39.2

