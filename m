Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623275DE37
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGVTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGVTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7CE66;
        Sat, 22 Jul 2023 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052874; x=1721588874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=befwtDDXWSFUCMNKnCYf7+XXxsRZza2+B9XgXPEc3dU=;
  b=WGPR117XTxeLv/U8p6YtbavXBZtuoJkfno8wIElwJbCzo+3go3sY42lu
   ElCyA5gGa3g2Q0fkIvSV+a1YUoNsIRNZ7oTsVpu1CaZYfq1Jk8z3kBD+Z
   DW8s+jHj1K+lac7OYH4F5STFkCrnSUc0hrRuorY86scyKlu/AvfbLTek4
   c99iS59wnSyev+N3SCzF5HnRjmVCkCTdBQW0fFHe3K+G1yUVfXMK5SmqJ
   JSdqJSRozXYK0cLjZRxNw/ndZmvKBe/emjfXTORZRsfUqVrgq1Nz80BnF
   gNYZILDvx8XQONR8WkAeidDeQ3H52Q6P/uwUfpzT/EqrbMtue9mYWzmVB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823972"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823972"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368084"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368084"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
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
Subject: [PATCH v4 3/7] x86/resctrl: Change monitor code to use rdt_mondomain
Date:   Sat, 22 Jul 2023 12:07:36 -0700
Message-Id: <20230722190740.326190-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230722190740.326190-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few functions need to be duplicated to provide versions to
operate on control and monitor domains respectively. But most
of the changes are just fixing argument and return value types.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   | 10 +++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 21 +++++++-----
 arch/x86/kernel/cpu/resctrl/core.c        | 40 ++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 38 ++++++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 24 +++++++-------
 6 files changed, 75 insertions(+), 62 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 475912662e47..663bbc427c4b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -248,9 +248,9 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
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
@@ -266,7 +266,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mondomain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
@@ -279,7 +279,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mondomain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 /**
@@ -291,7 +291,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mondomain *d);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e956090a874e..401af6ccf272 100644
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
@@ -355,6 +355,11 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
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
@@ -526,8 +531,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
-				   struct list_head **pos);
+void *rdt_find_domain(struct list_head *h, int id,
+		      struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
@@ -556,17 +561,17 @@ bool __init rdt_cpu_has(int flag);
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
index 274605aaa026..0161362b0c3e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -393,9 +393,12 @@ void rdt_ctrl_update(void *arg)
  * id is found in a domain, return the domain. Otherwise, if requested by
  * caller, return the first domain whose id is bigger than the input id.
  * The domain list is sorted by id in ascending order.
+ *
+ * N.B. Returned value may be either a pointer to "struct rdt_domain" or
+ * to "struct rdt_mondomain" depending on which domain list is scanned.
  */
-struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
-				   struct list_head **pos)
+void *rdt_find_domain(struct list_head *h, int id,
+		      struct list_head **pos)
 {
 	struct rdt_domain *d;
 	struct list_head *l;
@@ -434,10 +437,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 }
 
 static void domain_free(struct rdt_hw_domain *hw_dom)
+{
+	kfree(hw_dom->ctrl_val);
+	kfree(hw_dom);
+}
+
+static void mondomain_free(struct rdt_hw_mondomain *hw_dom)
 {
 	kfree(hw_dom->arch_mbm_total);
 	kfree(hw_dom->arch_mbm_local);
-	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
 
@@ -467,7 +475,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mondomain *hw_dom)
 {
 	size_t tsize;
 
@@ -539,8 +547,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
 	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_dom;
-	struct rdt_domain *d;
+	struct rdt_hw_mondomain *hw_mondom;
+	struct rdt_mondomain *d;
 	int err;
 
 	d = rdt_find_domain(&r->mondomains, id, &add_pos);
@@ -556,16 +564,16 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
-	if (!hw_dom)
+	hw_mondom = kzalloc_node(sizeof(*hw_mondom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_mondom)
 		return;
 
-	d = &hw_dom->d_resctrl;
+	d = &hw_mondom->d_resctrl;
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
-	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
-		domain_free(hw_dom);
+	if (arch_domain_mbm_alloc(r->num_rmid, hw_mondom)) {
+		mondomain_free(hw_mondom);
 		return;
 	}
 
@@ -574,7 +582,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	err = resctrl_online_mon_domain(r, d);
 	if (err) {
 		list_del(&d->list);
-		domain_free(hw_dom);
+		mondomain_free(hw_mondom);
 	}
 }
 
@@ -632,22 +640,22 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
-	struct rdt_hw_domain *hw_dom;
-	struct rdt_domain *d;
+	struct rdt_hw_mondomain *hw_mondom;
+	struct rdt_mondomain *d;
 
 	d = rdt_find_domain(&r->mondomains, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
 	}
-	hw_dom = resctrl_to_arch_dom(d);
+	hw_mondom = resctrl_to_arch_mondom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
 		resctrl_offline_mon_domain(r, d);
 		list_del(&d->list);
 
-		domain_free(hw_dom);
+		mondomain_free(hw_mondom);
 
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 839df83d1a0a..86fc5b0e3d39 100644
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
index 66beca785535..0d9605fccb34 100644
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
+	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
 	int ret;
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
index 27753eb5d513..4a268df9b456 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1483,7 +1483,7 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct rdt_mondomain *d, struct mon_config_info *mon_info)
 {
 	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
 }
@@ -1491,7 +1491,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
 	struct mon_config_info mon_info = {0};
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	bool sep = false;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -1548,7 +1548,7 @@ static void mon_event_config_write(void *info)
 }
 
 static int mbm_config_write_domain(struct rdt_resource *r,
-				   struct rdt_domain *d, u32 evtid, u32 val)
+				   struct rdt_mondomain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
@@ -1598,7 +1598,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
-	struct rdt_domain *d;
+	struct rdt_mondomain *d;
 	int ret = 0;
 
 next:
@@ -2463,7 +2463,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	struct rdt_resource *r;
 	int ret;
 
@@ -2845,7 +2845,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain *d,
+				struct rdt_mondomain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	union mon_data_bits priv;
@@ -2894,7 +2894,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain *d)
+					   struct rdt_mondomain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -2916,7 +2916,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_domain *dom;
+	struct rdt_mondomain *dom;
 	int ret;
 
 	list_for_each_entry(dom, &r->mondomains, list) {
@@ -3701,7 +3701,7 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
-static void domain_destroy_mon_state(struct rdt_domain *d)
+static void domain_destroy_mon_state(struct rdt_mondomain *d)
 {
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
@@ -3716,7 +3716,7 @@ void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 		mba_sc_domain_destroy(r, d);
 }
 
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3745,7 +3745,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
 	domain_destroy_mon_state(d);
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	size_t tsize;
 
@@ -3786,7 +3786,7 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mondomain *d)
 {
 	int err;
 
-- 
2.40.1

