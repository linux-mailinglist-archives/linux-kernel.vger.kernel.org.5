Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308778D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbjH2Xo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjH2Xop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:44:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8B1BB;
        Tue, 29 Aug 2023 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693352681; x=1724888681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXG4v9i+1OsFXdyBYAVd/IAJAvTBmiZc9K8aLcW4/gw=;
  b=eksQGaxXy5ucbHL30aFMQvFoK+nMk3gY0LuV3/Tk2yjhyIgJfVoGGWNp
   8PkS6RJmDmnymAjQy+Y/z/DbxNVRm8z7nzu1KO81iZQA1OVSHgH4e5ynm
   gsv/TN4uRiyc6tA27kYD4DtqQdVN7VQbYPqI2Ya4IyksJ8p1BAukN+Tuh
   YD8OV5ZIG5PJf/fIuLNJRPynFtBR4qXQKI+bVZP9EyRnuHoNrSIrC/fsm
   p8hqGyGNCbnvms2aLrlCo1XnGRktV6PzjSoK5+WGGvIp0xUFNlEdP2fK4
   ebzGdkvdz0uD3OHjcqcPbfE8haRqgBNPj3ptXI3MRs8KnllkSGbVRAL1g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355015436"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="355015436"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688691027"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="688691027"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:38 -0700
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
Subject: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Date:   Tue, 29 Aug 2023 16:44:21 -0700
Message-ID: <20230829234426.64421-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829234426.64421-1-tony.luck@intel.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same rdt_domain structure is used for both control an monitor
functions. But this results in wasted memory as some of the fields
are only used by control functions, while most are only used for monitor
functions.

Create a new rdt_mondomain structure tailored explicitly for use in
monitor parts of the core. Slim down the rdt_domain structure by
removing the unused monitor fields.

Similar breakout of struct rdt_hw_mondomain from struct rdt_hw_domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   | 46 +++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/internal.h    | 38 +++++++++++++------
 arch/x86/kernel/cpu/resctrl/core.c        | 18 ++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 40 ++++++++++----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 24 ++++++------
 6 files changed, 101 insertions(+), 69 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 33856943a787..08382548571e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,7 +53,29 @@ struct resctrl_staged_config {
 };
 
 /**
- * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * struct rdt_domain - group of CPUs sharing a resctrl control resource
+ * @list:		all instances of this resource
+ * @id:			unique id for this instance
+ * @cpu_mask:		which CPUs share this resource
+ * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		When mba_sc is enabled, this holds the array of user
+ *			specified control values for mba_sc in MBps, indexed
+ *			by closid
+ */
+struct rdt_domain {
+	// First three fields must match struct rdt_mondomain below.
+	struct list_head		list;
+	int				id;
+	struct cpumask			cpu_mask;
+
+	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
+};
+
+/**
+ * struct rdt_mondomain - group of CPUs sharing a resctrl monitor resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
@@ -64,16 +86,13 @@ struct resctrl_staged_config {
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
+struct rdt_mondomain {
+	// First three fields must match struct rdt_domain above.
 	struct list_head		list;
 	int				id;
 	struct cpumask			cpu_mask;
+
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
@@ -81,9 +100,6 @@ struct rdt_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
-	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
-	u32				*mbps_val;
 };
 
 /**
@@ -227,9 +243,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d);
 void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
@@ -245,7 +261,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mondomain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
@@ -258,7 +274,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mondomain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 /**
@@ -270,7 +286,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mondomain *d);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 31a5fc3b717f..c61fd6709730 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -106,7 +106,7 @@ union mon_data_bits {
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
-	struct rdt_domain	*d;
+	struct rdt_mondomain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
 	int			err;
@@ -320,17 +320,28 @@ struct arch_mbm_state {
 
 /**
  * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
- *			  a resource
+ *			  a control resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
- * @arch_mbm_total:	arch private state for MBM total bandwidth
- * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
+};
+
+/**
+ * struct rdt_hw_mondomain - Arch private attributes of a set of CPUs that share
+ *			  a monitor resource
+ * @d_resctrl:	Properties exposed to the resctrl file system
+ * @arch_mbm_total:	arch private state for MBM total bandwidth
+ * @arch_mbm_local:	arch private state for MBM local bandwidth
+ *
+ * Members of this structure are accessed via helpers that provide abstraction.
+ */
+struct rdt_hw_mondomain {
+	struct rdt_mondomain		d_resctrl;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
 };
@@ -340,6 +351,11 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
 	return container_of(r, struct rdt_hw_domain, d_resctrl);
 }
 
+static inline struct rdt_hw_mondomain *resctrl_to_arch_mondom(struct rdt_mondomain *r)
+{
+	return container_of(r, struct rdt_hw_mondomain, d_resctrl);
+}
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
@@ -513,8 +529,8 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
 struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
 				       struct list_head **pos);
-struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
-				      struct list_head **pos);
+struct rdt_mondomain *rdt_find_mondomain(struct list_head *h, int id,
+					 struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
@@ -543,17 +559,17 @@ bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mondomain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
-void mbm_setup_overflow_handler(struct rdt_domain *dom,
+void mbm_setup_overflow_handler(struct rdt_mondomain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_mondomain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
-void __check_limbo(struct rdt_domain *d, bool force_free);
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_mondomain *d);
+void __check_limbo(struct rdt_mondomain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 97f6f9715fdb..3e08aa04a7ff 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -425,8 +425,8 @@ struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
 	return __rdt_find_domain(h, id, pos);
 }
 
-struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
-				      struct list_head **pos)
+struct rdt_mondomain *rdt_find_mondomain(struct list_head *h, int id,
+					 struct list_head **pos)
 {
 	return __rdt_find_domain(h, id, pos);
 }
@@ -451,7 +451,7 @@ static void domain_free(struct rdt_hw_domain *hw_dom)
 	kfree(hw_dom);
 }
 
-static void mondomain_free(struct rdt_hw_domain *hw_dom)
+static void mondomain_free(struct rdt_hw_mondomain *hw_dom)
 {
 	kfree(hw_dom->arch_mbm_total);
 	kfree(hw_dom->arch_mbm_local);
@@ -484,7 +484,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mondomain *hw_dom)
 {
 	size_t tsize;
 
@@ -570,9 +570,9 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_domain *hw_mondom;
+	struct rdt_hw_mondomain *hw_mondom;
 	struct list_head *add_pos = NULL;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 	int err;
 
 	d = rdt_find_mondomain(&r->mondomains, id, &add_pos);
@@ -663,15 +663,15 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_domain *hw_mondom;
-	struct rdt_domain *d;
+	struct rdt_hw_mondomain *hw_mondom;
+	struct rdt_mondomain *d;
 
 	d = rdt_find_mondomain(&r->mondomains, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
 		return;
 	}
-	hw_mondom = resctrl_to_arch_dom(d);
+	hw_mondom = resctrl_to_arch_mondom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 468c1815edfd..5167ac9cbe98 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -521,7 +521,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 }
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mondomain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
 	/*
@@ -544,7 +544,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 	struct rmid_read rr;
 	int ret = 0;
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 66beca785535..42262d59ef9b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -170,7 +170,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mondomain *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
@@ -189,10 +189,10 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 	return NULL;
 }
 
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mondomain *d,
 			     u32 rmid, enum resctrl_event_id eventid)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
 	struct arch_mbm_state *am;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
@@ -208,9 +208,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  * Assumes that hardware counters are also reset and thus that there is
  * no need to record initial non-zero counts.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mondomain *d)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
 
 	if (is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
@@ -229,11 +229,11 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mondomain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mondomain *hw_mondom = resctrl_to_arch_mondom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
 	int ret;
@@ -245,7 +245,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (ret)
 		return ret;
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	am = get_arch_mbm_state(hw_mondom, rmid, eventid);
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
@@ -266,7 +266,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  * decrement the count. If the busy count gets to zero on an RMID, we
  * free the RMID
  */
-void __check_limbo(struct rdt_domain *d, bool force_free)
+void __check_limbo(struct rdt_mondomain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rmid_entry *entry;
@@ -305,7 +305,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	}
 }
 
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
 }
@@ -334,7 +334,7 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 	int cpu, err;
 	u64 val = 0;
 
@@ -383,7 +383,7 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
+static struct mbm_state *get_mbm_state(struct rdt_mondomain *d, u32 rmid,
 				       enum resctrl_event_id evtid)
 {
 	switch (evtid) {
@@ -516,7 +516,7 @@ void mon_event_count(void *info)
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mondomain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
@@ -600,7 +600,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	}
 }
 
-static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_mondomain *d, int rmid)
 {
 	struct rmid_read rr;
 
@@ -641,12 +641,12 @@ void cqm_handle_limbo(struct work_struct *work)
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
 	int cpu = smp_processor_id();
 	struct rdt_resource *r;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	d = container_of(work, struct rdt_domain, cqm_limbo.work);
+	d = container_of(work, struct rdt_mondomain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
@@ -656,7 +656,7 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void cqm_setup_limbo_handler(struct rdt_mondomain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -674,7 +674,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	int cpu = smp_processor_id();
 	struct list_head *head;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -682,7 +682,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	d = container_of(work, struct rdt_domain, mbm_over.work);
+	d = container_of(work, struct rdt_mondomain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->mon.rmid);
@@ -701,7 +701,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void mbm_setup_overflow_handler(struct rdt_mondomain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f2aec39c49df..5feec2c33544 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1496,7 +1496,7 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct rdt_mondomain *d, struct mon_config_info *mon_info)
 {
 	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
 }
@@ -1504,7 +1504,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
 	struct mon_config_info mon_info = {0};
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	bool sep = false;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -1561,7 +1561,7 @@ static void mon_event_config_write(void *info)
 }
 
 static int mbm_config_write_domain(struct rdt_resource *r,
-				   struct rdt_domain *d, u32 evtid, u32 val)
+				   struct rdt_mondomain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
@@ -1611,7 +1611,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 	int ret = 0;
 
 next:
@@ -2476,7 +2476,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	struct rdt_resource *r;
 	int ret;
 
@@ -2858,7 +2858,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain *d,
+				struct rdt_mondomain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	union mon_data_bits priv;
@@ -2907,7 +2907,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain *d)
+					   struct rdt_mondomain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -2929,7 +2929,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	int ret;
 
 	list_for_each_entry(dom, &r->mondomains, list) {
@@ -3714,7 +3714,7 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
-static void domain_destroy_mon_state(struct rdt_domain *d)
+static void domain_destroy_mon_state(struct rdt_mondomain *d)
 {
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
@@ -3729,7 +3729,7 @@ void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 		mba_sc_domain_destroy(r, d);
 }
 
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3758,7 +3758,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
 	domain_destroy_mon_state(d);
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	size_t tsize;
 
@@ -3799,7 +3799,7 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	int err;
 
-- 
2.41.0

