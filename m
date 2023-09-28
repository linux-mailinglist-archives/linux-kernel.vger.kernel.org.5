Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391117B25C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjI1TOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjI1TON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:14:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4328194;
        Thu, 28 Sep 2023 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928443; x=1727464443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKKJBbnMer+IGpPdDFuKBb4TtXUxA2W2eBeyRg4qQhM=;
  b=NIzpmkwPlOiEmq11ZAAOExubA83nw3+Fs1kKVVgFNmRzLL38h8Ku8yNF
   LmLKJ2DKp3KEjS45iWNwDyZAuxhh05UXa34esy68YTXOuyXFQ3sYFqq3x
   +EOkCMQWxvynmhgvTyEXCWtdrm3425gGI7jiXgdYEIDqs+kL25CDrfdVq
   HBXleI6ldvP9aGeehOD5RjzUNJBjTOqgVP0X6aYXY0hK+B5m7trsLK5VS
   UaduRpDsMP/UjcEBsjpe2nXsgjHSfwYyJjmkmx4ESrTnmE9Ty/O5xTfGG
   N9vjjSH9F1ZJM4rcABMnYahLSScko87f3xC0iL4dGk1yi6+TdkXioGf/f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367213913"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367213913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779020033"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="779020033"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:13:59 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 4/8] x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
Date:   Thu, 28 Sep 2023 12:13:45 -0700
Message-ID: <20230928191350.205703-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928191350.205703-1-tony.luck@intel.com>
References: <20230829234426.64421-1-tony.luck@intel.com>
 <20230928191350.205703-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same rdt_domain structure is used for both control and monitor
functions. But this results in wasted memory as some of the fields are
only used by control functions, while most are only used for monitor
functions.

Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
just the fields required for control and monitoring respectively.

Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
and rdt_hw_mon_domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v5:

Make rdt_find_domain() work on either control or monitor domains
using infrastructure setup in previous patch to have a common
header stucture in each.

Don't use a field paramter in the domain_init() macro, just provide
separate "ctrl_domain_init()" and "mon_domain_init()" versions.

Improve error messages if domain_add_cpu_{ctrl,mon}() fail to
locate a domain when adding a CPU.

Re-order local variable declarations to maintain reverse fir tree
pattern in functions when the name changes in this patch broke
the pattern.

Moved the comment describing how domain lists are ordered that used
to be in front of domain_add_cpu() to rdt_find_domain() which is
doing the majority of this work.

Dropped two blank lines that don't belong.
---
 include/linux/resctrl.h                   | 50 +++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    | 60 ++++++++++------
 arch/x86/kernel/cpu/resctrl/core.c        | 87 ++++++++++++-----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 ++++-----
 arch/x86/kernel/cpu/resctrl/monitor.c     | 40 +++++------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 62 ++++++++--------
 7 files changed, 184 insertions(+), 153 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0af5c5aa5a6f..1c925e3db2ea 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -63,7 +63,25 @@ struct rdt_domain_hdr {
 };
 
 /**
- * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
+ * @hdr:		common header for different domain types
+ * @cpu_mask:		which CPUs share this resource
+ * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		When mba_sc is enabled, this holds the array of user
+ *			specified control values for mba_sc in MBps, indexed
+ *			by closid
+ */
+struct rdt_ctrl_domain {
+	struct rdt_domain_hdr		hdr;
+	struct cpumask			cpu_mask;
+	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
+};
+
+/**
+ * struct rdt_mon_domain - group of CPUs sharing a resctrl control resource
  * @hdr:		common header for different domain types
  * @cpu_mask:		which CPUs share this resource
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
@@ -73,13 +91,8 @@ struct rdt_domain_hdr {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
- * @plr:		pseudo-locked region (if any) associated with domain
- * @staged_config:	parsed configuration to be applied
- * @mbps_val:		When mba_sc is enabled, this holds the array of user
- *			specified control values for mba_sc in MBps, indexed
- *			by closid
  */
-struct rdt_domain {
+struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
 	struct cpumask			cpu_mask;
 	unsigned long			*rmid_busy_llc;
@@ -89,9 +102,6 @@ struct rdt_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
-	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
-	u32				*mbps_val;
 };
 
 /**
@@ -195,7 +205,7 @@ struct rdt_resource {
 	const char		*format_str;
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
-						 struct rdt_domain *d);
+						 struct rdt_ctrl_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
@@ -229,15 +239,15 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
  */
-int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
 
-u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
-int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
@@ -253,7 +263,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
@@ -266,7 +276,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 /**
@@ -278,7 +288,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e9a2a8993d14..ee38249c6f1d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -106,7 +106,7 @@ union mon_data_bits {
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
-	struct rdt_domain	*d;
+	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
 	int			err;
@@ -191,7 +191,7 @@ struct mongroup {
  */
 struct pseudo_lock_region {
 	struct resctrl_schema	*s;
-	struct rdt_domain	*d;
+	struct rdt_ctrl_domain	*d;
 	u32			cbm;
 	wait_queue_head_t	lock_thread_wq;
 	int			thread_done;
@@ -319,25 +319,41 @@ struct arch_mbm_state {
 };
 
 /**
- * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
- *			  a resource
+ * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
+ *			  a resource for a control function
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ *
+ * Members of this structure are accessed via helpers that provide abstraction.
+ */
+struct rdt_hw_ctrl_domain {
+	struct rdt_ctrl_domain		d_resctrl;
+	u32				*ctrl_val;
+};
+
+/**
+ * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that share
+ *			  a resource for a monitor function
+ * @d_resctrl:	Properties exposed to the resctrl file system
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
-struct rdt_hw_domain {
-	struct rdt_domain		d_resctrl;
-	u32				*ctrl_val;
+struct rdt_hw_mon_domain {
+	struct rdt_mon_domain		d_resctrl;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
 };
 
-static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
+static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
 {
-	return container_of(r, struct rdt_hw_domain, d_resctrl);
+	return container_of(r, struct rdt_hw_ctrl_domain, d_resctrl);
+}
+
+static inline struct rdt_hw_mon_domain *resctrl_to_arch_mon_dom(struct rdt_mon_domain *r)
+{
+	return container_of(r, struct rdt_hw_mon_domain, d_resctrl);
 }
 
 /**
@@ -405,7 +421,7 @@ struct rdt_hw_resource {
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
 	unsigned int		msr_base;
-	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
+	void (*msr_update)	(struct rdt_ctrl_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
@@ -418,9 +434,9 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 }
 
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d);
+	      struct rdt_ctrl_domain *d);
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d);
+	     struct rdt_ctrl_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
@@ -517,21 +533,21 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
-unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm);
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
 int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_ctrl_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
@@ -541,17 +557,17 @@ bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
-void mbm_setup_overflow_handler(struct rdt_domain *dom,
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
-void __check_limbo(struct rdt_domain *d, bool force_free);
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_mon_domain *d);
+void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7ef178fb7c77..726f00c01079 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -49,12 +49,12 @@ int max_name_width, max_data_width;
 bool rdt_alloc_capable;
 
 static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+mba_wrmsr_intel(struct rdt_ctrl_domain *d, struct msr_param *m,
 		struct rdt_resource *r);
 static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
+cat_wrmsr(struct rdt_ctrl_domain *d, struct msr_param *m, struct rdt_resource *r);
 static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
+mba_wrmsr_amd(struct rdt_ctrl_domain *d, struct msr_param *m,
 	      struct rdt_resource *r);
 
 #define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
@@ -303,11 +303,11 @@ static void rdt_get_cdp_l2_config(void)
 }
 
 static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+mba_wrmsr_amd(struct rdt_ctrl_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
-	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
@@ -328,12 +328,12 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 }
 
 static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+mba_wrmsr_intel(struct rdt_ctrl_domain *d, struct msr_param *m,
 		struct rdt_resource *r)
 {
-	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	unsigned int i;
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
@@ -341,19 +341,19 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 }
 
 static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+cat_wrmsr(struct rdt_ctrl_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
-	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
+struct rdt_ctrl_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		/* Find the domain that contains this CPU */
@@ -375,7 +375,7 @@ void rdt_ctrl_update(void *arg)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
 	struct rdt_resource *r = m->res;
 	int cpu = smp_processor_id();
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	d = get_domain_from_cpu(cpu, r);
 	if (d) {
@@ -443,18 +443,23 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 		*dc = r->default_ctrl;
 }
 
-static void domain_free(struct rdt_hw_domain *hw_dom)
+static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
+{
+	kfree(hw_dom->ctrl_val);
+	kfree(hw_dom);
+}
+
+static void mon_domain_free(struct rdt_hw_mon_domain *hw_dom)
 {
 	kfree(hw_dom->arch_mbm_total);
 	kfree(hw_dom->arch_mbm_local);
-	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
 
-static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
 	u32 *dc;
 
@@ -477,7 +482,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_dom)
 {
 	size_t tsize;
 
@@ -516,10 +521,10 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int err;
 
 	if (id < 0) {
@@ -533,7 +538,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find control scope id=%d for CPU %d\n", id, cpu);
 		return;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
+	d = container_of(hdr, struct rdt_ctrl_domain, hdr);
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
@@ -553,7 +558,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (domain_setup_ctrlval(r, d)) {
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 		return;
 	}
 
@@ -562,17 +567,17 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	err = resctrl_online_ctrl_domain(r, d);
 	if (err) {
 		list_del(&d->hdr.list);
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 	}
 }
 
 static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct rdt_hw_mon_domain *hw_mondom;
 	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_mondom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 	int err;
 
 	if (id < 0) {
@@ -586,7 +591,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find monitor scope id=%d for CPU %d\n", id, cpu);
 		return;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
@@ -602,7 +607,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
 	if (arch_domain_mbm_alloc(r->num_rmid, hw_mondom)) {
-		domain_free(hw_mondom);
+		mon_domain_free(hw_mondom);
 		return;
 	}
 
@@ -611,7 +616,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	err = resctrl_online_mon_domain(r, d);
 	if (err) {
 		list_del(&d->hdr.list);
-		domain_free(hw_mondom);
+		mon_domain_free(hw_mondom);
 	}
 }
 
@@ -629,9 +634,9 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	if (id < 0)
 		return;
@@ -641,8 +646,8 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find control scope id=%d for CPU %d\n", id, cpu);
 		return;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
-	hw_dom = resctrl_to_arch_dom(d);
+	d = container_of(hdr, struct rdt_ctrl_domain, hdr);
+	hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
@@ -650,12 +655,12 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		list_del(&d->hdr.list);
 
 		/*
-		 * rdt_domain "d" is going to be freed below, so clear
+		 * rdt_ctrl_domain "d" is going to be freed below, so clear
 		 * its pointer from pseudo_lock_region struct.
 		 */
 		if (d->plr)
 			d->plr->d = NULL;
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 
 		return;
 	}
@@ -664,9 +669,9 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_domain *hw_mondom;
+	struct rdt_hw_mon_domain *hw_mondom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 
 	if (id < 0)
 		return;
@@ -676,14 +681,14 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
 		return;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
-	hw_mondom = resctrl_to_arch_dom(d);
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
+	hw_mondom = resctrl_to_arch_mon_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
 		resctrl_offline_mon_domain(r, d);
 		list_del(&d->hdr.list);
-		domain_free(hw_mondom);
+		mon_domain_free(hw_mondom);
 
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a6261e177cc1..7513eba9feaf 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -58,7 +58,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 }
 
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d)
+	     struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -135,7 +135,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * resource type.
  */
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d)
+	      struct rdt_ctrl_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct resctrl_staged_config *cfg;
@@ -205,7 +205,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	unsigned long dom_id;
 
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
@@ -265,11 +265,11 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 	}
 }
 
-static bool apply_config(struct rdt_hw_domain *hw_dom,
+static bool apply_config(struct rdt_hw_ctrl_domain *hw_dom,
 			 struct resctrl_staged_config *cfg, u32 idx,
 			 cpumask_var_t cpu_mask)
 {
-	struct rdt_domain *dom = &hw_dom->d_resctrl;
+	struct rdt_ctrl_domain *dom = &hw_dom->d_resctrl;
 
 	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
@@ -281,11 +281,11 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
 	return false;
 }
 
-int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, t);
 	struct msr_param msr_param;
 
@@ -305,11 +305,11 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct msr_param msr_param;
 	enum resctrl_conf_type t;
+	struct rdt_ctrl_domain *d;
 	cpumask_var_t cpu_mask;
-	struct rdt_domain *d;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -317,7 +317,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 
 	msr_param.res = NULL;
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		hw_dom = resctrl_to_arch_dom(d);
+		hw_dom = resctrl_to_arch_ctrl_dom(d);
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
 			if (!cfg->have_new_ctrl)
@@ -447,10 +447,10 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	u32 idx = get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
@@ -459,7 +459,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
-	struct rdt_domain *dom;
+	struct rdt_ctrl_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
@@ -521,7 +521,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 }
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
 	/*
@@ -541,11 +541,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
 	struct rdt_domain_hdr *hdr;
+	struct rdt_mon_domain *d;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	struct rdt_domain *d;
 	struct rmid_read rr;
 	int ret = 0;
 
@@ -566,7 +566,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		ret = -ENOENT;
 		goto out;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3265b8499e2a..97d2ed829f5d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -170,7 +170,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
@@ -189,10 +189,10 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 	return NULL;
 }
 
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct arch_mbm_state *am;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
@@ -208,9 +208,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  * Assumes that hardware counters are also reset and thus that there is
  * no need to record initial non-zero counts.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 
 	if (is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
@@ -229,11 +229,11 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
 	int ret;
@@ -266,7 +266,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  * decrement the count. If the busy count gets to zero on an RMID, we
  * free the RMID
  */
-void __check_limbo(struct rdt_domain *d, bool force_free)
+void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rmid_entry *entry;
@@ -305,7 +305,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	}
 }
 
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
 }
@@ -334,7 +334,7 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 	int cpu, err;
 	u64 val = 0;
 
@@ -383,7 +383,7 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
+static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 rmid,
 				       enum resctrl_event_id evtid)
 {
 	switch (evtid) {
@@ -516,13 +516,13 @@ void mon_event_count(void *info)
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_ctrl_domain *dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
-	struct rdt_domain *dom_mba;
 	struct list_head *head;
 	struct rdtgroup *entry;
 
@@ -600,7 +600,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	}
 }
 
-static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d, int rmid)
 {
 	struct rmid_read rr;
 
@@ -640,13 +640,13 @@ void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
 	int cpu = smp_processor_id();
+	struct rdt_mon_domain *d;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	d = container_of(work, struct rdt_domain, cqm_limbo.work);
+	d = container_of(work, struct rdt_mon_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
@@ -656,7 +656,7 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -672,9 +672,9 @@ void mbm_handle_overflow(struct work_struct *work)
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu = smp_processor_id();
+	struct rdt_mon_domain *d;
 	struct list_head *head;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -682,7 +682,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	d = container_of(work, struct rdt_domain, mbm_over.work);
+	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->mon.rmid);
@@ -701,7 +701,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index bda32b4e1c1e..675e9e47af54 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -814,7 +814,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
  * Return: true if @cbm overlaps with pseudo-locked region on @d, false
  * otherwise.
  */
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm)
 {
 	unsigned int cbm_len;
 	unsigned long cbm_b;
@@ -841,11 +841,11 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
  *         if it is not possible to test due to memory allocation issue,
  *         false otherwise.
  */
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
 {
+	struct rdt_ctrl_domain *d_i;
 	cpumask_var_t cpu_with_psl;
 	struct rdt_resource *r;
-	struct rdt_domain *d_i;
 	bool ret = false;
 
 	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8132f81f31bb..b0901fb95aa9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -80,8 +80,8 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 void rdt_staged_configs_clear(void)
 {
+	struct rdt_ctrl_domain *dom;
 	struct rdt_resource *r;
-	struct rdt_domain *dom;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -920,7 +920,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	unsigned long sw_shareable = 0, hw_shareable = 0;
 	unsigned long exclusive = 0, pseudo_locked = 0;
 	struct rdt_resource *r = s->res;
-	struct rdt_domain *dom;
+	struct rdt_ctrl_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
@@ -1137,7 +1137,7 @@ static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
  *
  * Return: false if CBM does not overlap, true if it does.
  */
-static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 				    unsigned long cbm, int closid,
 				    enum resctrl_conf_type type, bool exclusive)
 {
@@ -1192,7 +1192,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
  *
  * Return: true if CBM overlap detected, false if there is no overlap
  */
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
 	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
@@ -1222,10 +1222,10 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	int closid = rdtgrp->closid;
+	struct rdt_ctrl_domain *d;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
-	struct rdt_domain *d;
 	u32 ctrl;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
@@ -1339,7 +1339,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
  * bitmap functions work correctly.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
-				  struct rdt_domain *d, unsigned long cbm)
+				  struct rdt_ctrl_domain *d, unsigned long cbm)
 {
 	struct cpu_cacheinfo *ci;
 	unsigned int size = 0;
@@ -1372,9 +1372,9 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *schema;
 	enum resctrl_conf_type type;
+	struct rdt_ctrl_domain *d;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 	unsigned int size;
 	int ret = 0;
 	u32 closid;
@@ -1486,7 +1486,7 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
 {
 	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
 }
@@ -1494,7 +1494,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
 	struct mon_config_info mon_info = {0};
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	bool sep = false;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -1551,7 +1551,7 @@ static void mon_event_config_write(void *info)
 }
 
 static int mbm_config_write_domain(struct rdt_resource *r,
-				   struct rdt_domain *d, u32 evtid, u32 val)
+				   struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
@@ -1601,7 +1601,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 	int ret = 0;
 
 next:
@@ -2125,9 +2125,9 @@ static inline bool is_mba_linear(void)
 static int set_cache_qos_cfg(int level, bool enable)
 {
 	void (*update)(void *arg);
+	struct rdt_ctrl_domain *d;
 	struct rdt_resource *r_l;
 	cpumask_var_t cpu_mask;
-	struct rdt_domain *d;
 	int cpu;
 
 	if (level == RDT_RESOURCE_L3)
@@ -2174,7 +2174,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
-static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	int cpu = cpumask_any(&d->cpu_mask);
@@ -2192,7 +2192,7 @@ static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
 }
 
 static void mba_sc_domain_destroy(struct rdt_resource *r,
-				  struct rdt_domain *d)
+				  struct rdt_ctrl_domain *d)
 {
 	kfree(d->mbps_val);
 	d->mbps_val = NULL;
@@ -2218,7 +2218,7 @@ static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	u32 num_closid = resctrl_arch_get_num_closid(r);
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
@@ -2466,7 +2466,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	struct rdt_resource *r;
 	int ret;
 
@@ -2634,10 +2634,10 @@ static int rdt_init_fs_context(struct fs_context *fc)
 static int reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct msr_param msr_param;
+	struct rdt_ctrl_domain *d;
 	cpumask_var_t cpu_mask;
-	struct rdt_domain *d;
 	int i;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -2653,7 +2653,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * from each domain to update the MSRs below.
 	 */
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		hw_dom = resctrl_to_arch_dom(d);
+		hw_dom = resctrl_to_arch_ctrl_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
@@ -2848,7 +2848,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain *d,
+				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	union mon_data_bits priv;
@@ -2897,7 +2897,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain *d)
+					   struct rdt_mon_domain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -2919,7 +2919,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	int ret;
 
 	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
@@ -3021,7 +3021,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
  * Set the RDT domain up to start off with all usable allocations. That is,
  * all shareable and unused bits. All-zero CBM is invalid.
  */
-static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
+static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
@@ -3101,7 +3101,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
  */
 static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int ret;
 
 	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
@@ -3117,7 +3117,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (is_mba_sc(r)) {
@@ -3704,14 +3704,14 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
-static void domain_destroy_mon_state(struct rdt_domain *d)
+static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3719,7 +3719,7 @@ void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 		mba_sc_domain_destroy(r, d);
 }
 
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	/*
 	 * If resctrl is mounted, remove all the
@@ -3746,7 +3746,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
 	domain_destroy_mon_state(d);
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	size_t tsize;
 
@@ -3776,7 +3776,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3787,7 +3787,7 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	int err;
 
-- 
2.41.0

