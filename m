Return-Path: <linux-kernel+bounces-1463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41F814F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DE61F21B53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2866AC7;
	Fri, 15 Dec 2023 17:45:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC45F868
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B9F1650;
	Fri, 15 Dec 2023 09:46:00 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29203F5A1;
	Fri, 15 Dec 2023 09:45:12 -0800 (PST)
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
Subject: [PATCH v8 24/24] x86/resctrl: Separate arch and fs resctrl locks
Date: Fri, 15 Dec 2023 17:43:43 +0000
Message-Id: <20231215174343.13872-25-james.morse@arm.com>
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

resctrl has one mutex that is taken by the architecture specific code,
and the filesystem parts. The two interact via cpuhp, where the
architecture code updates the domain list. Filesystem handlers that
walk the domains list should not run concurrently with the cpuhp
callback modifying the list.

Exposing a lock from the filesystem code means the interface is not
cleanly defined, and creates the possibility of cross-architecture
lock ordering headaches. The interaction only exists so that certain
filesystem paths are serialised against CPU hotplug. The CPU hotplug
code already has a mechanism to do this using cpus_read_lock().

MPAM's monitors have an overflow interrupt, so it needs to be possible
to walk the domains list in irq context. RCU is ideal for this,
but some paths need to be able to sleep to allocate memory.

Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
of a cpuhp callback, cpus_read_lock() must always be taken first.
rdtgroup_schemata_write() already does this.

Most of the filesystem code's domain list walkers are currently
protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
The exceptions are rdt_bit_usage_show() and the mon_config helpers
which take the lock directly.

Make the domain list protected by RCU. An architecture-specific
lock prevents concurrent writers. rdt_bit_usage_show() could
walk the domain list using RCU, but to keep all the filesystem
operations the same, this is changed to call cpus_read_lock().
The mon_config helpers send multiple IPIs, take the cpus_read_lock()
in these cases.

The other filesystem list walkers need to be able to sleep.
Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
cpuhp callbacks can't be invoked when file system operations are
occurring.

Add lockdep_assert_cpus_held() in the cases where the
rdtgroup_kn_lock_live() call isn't obvious.

Resctrl's domain online/offline calls now need to take the
rdtgroup_mutex themselves.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v2:
 * Reworded a comment,
 * Added a lockdep assertion
 * Moved clear_closid_rmid() outside the locked region of cpu
   online/offline

Changes since v3:
 * Added a header include

Changes since v5:
 * Made rdt_bit_usage_show() take the cpus_read_lock() instead of using
   RCU.

Changes since v6:
 * Added lockdep_is_cpus_held() to get_domain_from_cpu().
 * Added cpus_read_lock() around overflow and limbo handlers.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 44 +++++++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 15 ++++-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 +++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 68 ++++++++++++++++++-----
 include/linux/resctrl.h                   |  2 +-
 6 files changed, 112 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c943cb78b2a1..4a35369e2d3c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"resctrl: " fmt
 
+#include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/cacheinfo.h>
@@ -25,8 +26,15 @@
 #include <asm/resctrl.h>
 #include "internal.h"
 
-/* Mutex to protect rdtgroup access. */
-DEFINE_MUTEX(rdtgroup_mutex);
+/*
+ * rdt_domain structures are kfree()d when their last CPU goes offline,
+ * and allocated when the first CPU in a new domain comes online.
+ * The rdt_resource's domain list is updated when this happens. Readers of
+ * the domain list must either take cpus_read_lock(), or rely on an RCU
+ * read-side critical section, to avoid observing concurrent modification.
+ * All writers take this mutex:
+ */
+static DEFINE_MUTEX(domain_list_lock);
 
 /*
  * The cached resctrl_pqr_state is strictly per CPU and can never be
@@ -356,6 +364,15 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
+	/*
+	 * Walking r->domains, ensure it can't race with cpuhp.
+	 * Because this is called via IPI by rdt_ctrl_update(), assertions
+	 * about locks this thread holds will lead to false positives. Check
+	 * someone is holding the CPUs lock.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		lockdep_is_cpus_held();
+
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))
@@ -512,6 +529,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct rdt_domain *d;
 	int err;
 
+	lockdep_assert_held(&domain_list_lock);
+
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
@@ -545,11 +564,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	list_add_tail(&d->list, add_pos);
+	list_add_tail_rcu(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
 	if (err) {
-		list_del(&d->list);
+		list_del_rcu(&d->list);
+		synchronize_rcu();
 		domain_free(hw_dom);
 	}
 }
@@ -560,6 +580,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
+	lockdep_assert_held(&domain_list_lock);
+
 	d = rdt_find_domain(r, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
@@ -570,7 +592,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
 		resctrl_offline_domain(r, d);
-		list_del(&d->list);
+		list_del_rcu(&d->list);
+		synchronize_rcu();
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
@@ -600,13 +623,13 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
-	mutex_lock(&rdtgroup_mutex);
+	mutex_lock(&domain_list_lock);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
-	clear_closid_rmid(cpu);
+	mutex_unlock(&domain_list_lock);
 
+	clear_closid_rmid(cpu);
 	resctrl_online_cpu(cpu);
-	mutex_unlock(&rdtgroup_mutex);
 
 	return 0;
 }
@@ -615,13 +638,14 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
-	mutex_lock(&rdtgroup_mutex);
 	resctrl_offline_cpu(cpu);
 
+	mutex_lock(&domain_list_lock);
 	for_each_capable_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
+	mutex_unlock(&domain_list_lock);
+
 	clear_closid_rmid(cpu);
-	mutex_unlock(&rdtgroup_mutex);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 64db51455df3..dc59643498bf 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -212,6 +212,9 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	struct rdt_domain *d;
 	unsigned long dom_id;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
@@ -316,6 +319,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_domain *d;
 	u32 idx;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -381,11 +387,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		return -EINVAL;
 	buf[nbytes - 1] = '\0';
 
-	cpus_read_lock();
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
 		rdtgroup_kn_unlock(of->kn);
-		cpus_read_unlock();
 		return -ENOENT;
 	}
 	rdt_last_cmd_clear();
@@ -447,7 +451,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 out:
 	rdt_staged_configs_clear();
 	rdtgroup_kn_unlock(of->kn);
-	cpus_read_unlock();
 	return ret ?: nbytes;
 }
 
@@ -467,6 +470,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
@@ -537,6 +543,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 {
 	int cpu;
 
+	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	/*
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c78b51eb1256..971ca45fc4e6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -15,6 +15,7 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -472,6 +473,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
@@ -800,6 +804,7 @@ void cqm_handle_limbo(struct work_struct *work)
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
 	struct rdt_domain *d;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	d = container_of(work, struct rdt_domain, cqm_limbo.work);
@@ -814,6 +819,7 @@ void cqm_handle_limbo(struct work_struct *work)
 	}
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 }
 
 /**
@@ -845,6 +851,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	/*
@@ -878,6 +885,7 @@ void mbm_handle_overflow(struct work_struct *work)
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8056bed033cc..884b88e25141 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -844,6 +844,9 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	struct rdt_domain *d_i;
 	bool ret = false;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
 		return true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f007c488fa31..39b807a28a55 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -35,6 +35,10 @@
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
+
+/* Mutex to protect rdtgroup access. */
+DEFINE_MUTEX(rdtgroup_mutex);
+
 static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
@@ -1014,6 +1018,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	bool sep = false;
 	u32 ctrl_val;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->domains, list) {
@@ -1074,6 +1079,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	}
 	seq_putc(seq, '\n');
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 	return 0;
 }
 
@@ -1329,6 +1335,9 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 	struct rdt_domain *d;
 	u32 ctrl;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
@@ -1593,6 +1602,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 	struct rdt_domain *dom;
 	bool sep = false;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	list_for_each_entry(dom, &r->domains, list) {
@@ -1609,6 +1619,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 	seq_puts(s, "\n");
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 
 	return 0;
 }
@@ -1700,6 +1711,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	struct rdt_domain *d;
 	int ret = 0;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 next:
 	if (!tok || tok[0] == '\0')
 		return 0;
@@ -1741,6 +1755,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
 	if (nbytes == 0 || buf[nbytes - 1] != '\n')
 		return -EINVAL;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	rdt_last_cmd_clear();
@@ -1750,6 +1765,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
 	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 
 	return ret ?: nbytes;
 }
@@ -1765,6 +1781,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	if (nbytes == 0 || buf[nbytes - 1] != '\n')
 		return -EINVAL;
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	rdt_last_cmd_clear();
@@ -1774,6 +1791,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 
 	return ret ?: nbytes;
 }
@@ -2250,6 +2268,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 	struct rdt_domain *d;
 	int cpu;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -2449,6 +2470,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 
 	rdtgroup_kn_get(rdtgrp, kn);
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	/* Was this group deleted while we waited? */
@@ -2466,6 +2488,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 		return;
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
 	rdtgroup_kn_put(rdtgrp, kn);
 }
 
@@ -2798,6 +2822,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct rdt_domain *d;
 	int i;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -3082,6 +3109,9 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	struct rdt_domain *dom;
 	int ret;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(dom, &r->domains, list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
@@ -3912,13 +3942,13 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
 
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
-	lockdep_assert_held(&rdtgroup_mutex);
+	mutex_lock(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		mba_sc_domain_destroy(r, d);
 
 	if (!r->mon_capable)
-		return;
+		goto out_unlock;
 
 	/*
 	 * If resctrl is mounted, remove all the
@@ -3943,6 +3973,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	}
 
 	domain_destroy_mon_state(d);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
 }
 
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
@@ -3978,20 +4011,22 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
-	int err;
+	int err = 0;
 
-	lockdep_assert_held(&rdtgroup_mutex);
+	mutex_lock(&rdtgroup_mutex);
 
-	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
 		/* RDT_RESOURCE_MBA is never mon_capable */
-		return mba_sc_domain_allocate(r, d);
+		err = mba_sc_domain_allocate(r, d);
+		goto out_unlock;
+	}
 
 	if (!r->mon_capable)
-		return 0;
+		goto out_unlock;
 
 	err = domain_setup_mon_state(r, d);
 	if (err)
-		return err;
+		goto out_unlock;
 
 	if (is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
@@ -4011,15 +4046,18 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
 }
 
 void resctrl_online_cpu(unsigned int cpu)
 {
-	lockdep_assert_held(&rdtgroup_mutex);
-
+	mutex_lock(&rdtgroup_mutex);
 	/* The CPU is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	mutex_unlock(&rdtgroup_mutex);
 }
 
 static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
@@ -4038,8 +4076,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	struct rdtgroup *rdtgrp;
 	struct rdt_domain *d;
 
-	lockdep_assert_held(&rdtgroup_mutex);
-
+	mutex_lock(&rdtgroup_mutex);
 	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
 		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
 			clear_childcpus(rdtgrp, cpu);
@@ -4048,7 +4085,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	}
 
 	if (!l3->mon_capable)
-		return;
+		goto out_unlock;
 
 	d = get_domain_from_cpu(cpu, l3);
 	if (d) {
@@ -4062,6 +4099,9 @@ void resctrl_offline_cpu(unsigned int cpu)
 			cqm_setup_limbo_handler(d, 0, cpu);
 		}
 	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
 }
 
 /*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 270ff1d5c051..a365f67131ec 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -159,7 +159,7 @@ struct resctrl_schema;
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
- * @domains:		All domains for this resource
+ * @domains:		RCU list of all domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
-- 
2.20.1


