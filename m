Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EAE75DE33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGVTIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGVTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C13E6E;
        Sat, 22 Jul 2023 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052873; x=1721588873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cpV3MqFoCBTpdgDSMwnM+O5GM2EEoQCG0WEeo68BAPk=;
  b=HZ5InklorLVBgKziGhW0QDXYliPc4UUuQY3OFo6xBX9xw179gf97JFXi
   vgwYklem5Q6oFlLcluR1jvkK3t7/TUyoUwBIFhb7lWxgjWOpyf+84DLxn
   h0tWqdudDqXfGE+8XRUVzvkLCZtuCyAMJtNZ+aXVv/s1cD+TsH9PPEYWf
   SLg4WYFjr644l650QD4pdO5+ShpLv+N9GuqyzGhBv1lgj4yHBvD/pS57N
   SiWriRGK5Jgo2OL117MJjGKcURgzDjXbiNOUuMtMb31iKMiwt/AZeDFL5
   ES4ti7JXc764vToCtBzD4xcwzj5MQYlvS0MyKo21by6EuwMWFbRH1T9dl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823962"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368077"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368077"
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
Subject: [PATCH v4 1/7] x86/resctrl: Create separate domains for control and monitoring
Date:   Sat, 22 Jul 2023 12:07:34 -0700
Message-Id: <20230722190740.326190-2-tony.luck@intel.com>
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

First step towards supporting resource control where the scope of
control operations is not the same as monitor operations.

Add an extra list in the rdt_resource structure. For this will
just duplicate the existing list of domains based on the L3 cache
scope.

Refactor the domain_add_cpu() and domain_remove() functions to
build separate lists for r->alloc_capable and r->mon_capable
resources. Note that only the "L3" domain currently supports
both types.

Change all places where monitoring functions walk the list of
domains to use the new "mondomains" list instead of the old
"domains" list.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |  10 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
 6 files changed, 167 insertions(+), 74 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..1267d56f9e76 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -151,9 +151,11 @@ struct resctrl_schema;
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
  * @cache_level:	Which cache level defines scope of this resource
+ * @mon_scope:		Scope of this resource if different from cache_level
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @domains:		All domains for this resource
+ * @mondomains:		Monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
@@ -169,9 +171,11 @@ struct rdt_resource {
 	bool			mon_capable;
 	int			num_rmid;
 	int			cache_level;
+	int			mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
 	struct list_head	domains;
+	struct list_head	mondomains;
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
@@ -217,8 +221,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..c5e2ac2a60cf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -511,7 +511,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
+struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
 				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..274605aaa026 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -57,7 +57,7 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 	      struct rdt_resource *r);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
+#define domain_init(id, field) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.field)
 
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
@@ -66,7 +66,9 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
 			.cache_level		= 3,
-			.domains		= domain_init(RDT_RESOURCE_L3),
+			.mon_scope		= 3,
+			.domains		= domain_init(RDT_RESOURCE_L3, domains),
+			.mondomains		= domain_init(RDT_RESOURCE_L3, mondomains),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -80,7 +82,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
 			.cache_level		= 2,
-			.domains		= domain_init(RDT_RESOURCE_L2),
+			.domains		= domain_init(RDT_RESOURCE_L2, domains),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -94,7 +96,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
 			.cache_level		= 3,
-			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.domains		= domain_init(RDT_RESOURCE_MBA, domains),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -106,7 +108,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
 			.cache_level		= 3,
-			.domains		= domain_init(RDT_RESOURCE_SMBA),
+			.domains		= domain_init(RDT_RESOURCE_SMBA, domains),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -384,14 +386,15 @@ void rdt_ctrl_update(void *arg)
 }
 
 /*
- * rdt_find_domain - Find a domain in a resource that matches input resource id
+ * rdt_find_domain - Find a domain in one of the lists for a resource that
+ * matches input resource id
  *
  * Search resource r's domain list to find the resource id. If the resource
  * id is found in a domain, return the domain. Otherwise, if requested by
  * caller, return the first domain whose id is bigger than the input id.
  * The domain list is sorted by id in ascending order.
  */
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
+struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
 				   struct list_head **pos)
 {
 	struct rdt_domain *d;
@@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	if (id < 0)
 		return ERR_PTR(-ENODEV);
 
-	list_for_each(l, &r->domains) {
+	list_for_each(l, h) {
 		d = list_entry(l, struct rdt_domain, list);
 		/* When id is found, return its domain. */
 		if (id == d->id)
@@ -487,6 +490,94 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 	return 0;
 }
 
+static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
+{
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain *d;
+	int err;
+
+	d = rdt_find_domain(&r->domains, id, &add_pos);
+	if (IS_ERR(d)) {
+		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+		return;
+	}
+
+	if (d) {
+		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_has_per_cpu_cfg)
+			rdt_domain_reconfigure_cdp(r);
+		return;
+	}
+
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
+		return;
+
+	d = &hw_dom->d_resctrl;
+	d->id = id;
+	cpumask_set_cpu(cpu, &d->cpu_mask);
+
+	rdt_domain_reconfigure_cdp(r);
+
+	if (domain_setup_ctrlval(r, d)) {
+		domain_free(hw_dom);
+		return;
+	}
+
+	list_add_tail(&d->list, add_pos);
+
+	err = resctrl_online_ctrl_domain(r, d);
+	if (err) {
+		list_del(&d->list);
+		domain_free(hw_dom);
+	}
+}
+
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
+	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain *d;
+	int err;
+
+	d = rdt_find_domain(&r->mondomains, id, &add_pos);
+	if (IS_ERR(d)) {
+		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+		return;
+	}
+
+	if (d) {
+		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_has_per_cpu_cfg)
+			rdt_domain_reconfigure_cdp(r);
+		return;
+	}
+
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
+		return;
+
+	d = &hw_dom->d_resctrl;
+	d->id = id;
+	cpumask_set_cpu(cpu, &d->cpu_mask);
+
+	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+		domain_free(hw_dom);
+		return;
+	}
+
+	list_add_tail(&d->list, add_pos);
+
+	err = resctrl_online_mon_domain(r, d);
+	if (err) {
+		list_del(&d->list);
+		domain_free(hw_dom);
+	}
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
-	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_dom;
-	struct rdt_domain *d;
-	int err;
-
-	d = rdt_find_domain(r, id, &add_pos);
-	if (IS_ERR(d)) {
-		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
-		return;
-	}
-
-	if (d) {
-		cpumask_set_cpu(cpu, &d->cpu_mask);
-		if (r->cache.arch_has_per_cpu_cfg)
-			rdt_domain_reconfigure_cdp(r);
-		return;
-	}
-
-	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
-	if (!hw_dom)
-		return;
-
-	d = &hw_dom->d_resctrl;
-	d->id = id;
-	cpumask_set_cpu(cpu, &d->cpu_mask);
-
-	rdt_domain_reconfigure_cdp(r);
-
-	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		domain_free(hw_dom);
-		return;
-	}
-
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
-		domain_free(hw_dom);
-		return;
-	}
-
-	list_add_tail(&d->list, add_pos);
-
-	err = resctrl_online_domain(r, d);
-	if (err) {
-		list_del(&d->list);
-		domain_free(hw_dom);
-	}
+	if (r->alloc_capable)
+		domain_add_cpu_ctrl(cpu, r);
+	if (r->mon_capable)
+		domain_add_cpu_mon(cpu, r);
 }
 
-static void domain_remove_cpu(int cpu, struct rdt_resource *r)
+static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
-	d = rdt_find_domain(r, id, NULL);
+	d = rdt_find_domain(&r->domains, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
@@ -565,7 +614,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
-		resctrl_offline_domain(r, d);
+		resctrl_offline_ctrl_domain(r, d);
 		list_del(&d->list);
 
 		/*
@@ -578,6 +627,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
+}
+
+static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain *d;
+
+	d = rdt_find_domain(&r->mondomains, id, NULL);
+	if (IS_ERR_OR_NULL(d)) {
+		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+		return;
+	}
+	hw_dom = resctrl_to_arch_dom(d);
+
+	cpumask_clear_cpu(cpu, &d->cpu_mask);
+	if (cpumask_empty(&d->cpu_mask)) {
+		resctrl_offline_mon_domain(r, d);
+		list_del(&d->list);
+
+		domain_free(hw_dom);
+
+		return;
+	}
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
@@ -592,6 +665,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	}
 }
 
+static void domain_remove_cpu(int cpu, struct rdt_resource *r)
+{
+	if (r->alloc_capable)
+		domain_remove_cpu_ctrl(cpu, r);
+	if (r->mon_capable)
+		domain_remove_cpu_mon(cpu, r);
+}
+
 static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..839df83d1a0a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -560,7 +560,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = &rdt_resources_all[resid].r_resctrl;
-	d = rdt_find_domain(r, domid, NULL);
+	d = rdt_find_domain(&r->mondomains, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7cb7cb..66beca785535 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -340,7 +340,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 	entry->busy = 0;
 	cpu = get_cpu();
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->mondomains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..27753eb5d513 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1496,7 +1496,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 
 	mutex_lock(&rdtgroup_mutex);
 
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->mondomains, list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -1619,7 +1619,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->mondomains, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
 			if (ret)
@@ -2525,7 +2525,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, list)
+		list_for_each_entry(dom, &r->mondomains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
@@ -2919,7 +2919,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	struct rdt_domain *dom;
 	int ret;
 
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->mondomains, list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
 			return ret;
@@ -3708,15 +3708,17 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		mba_sc_domain_destroy(r, d);
+}
 
-	if (!r->mon_capable)
-		return;
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
 
 	/*
 	 * If resctrl is mounted, remove all the
@@ -3773,18 +3775,22 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
-	int err;
-
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		/* RDT_RESOURCE_MBA is never mon_capable */
 		return mba_sc_domain_allocate(r, d);
 
-	if (!r->mon_capable)
-		return 0;
+	return 0;
+}
+
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	lockdep_assert_held(&rdtgroup_mutex);
 
 	err = domain_setup_mon_state(r, d);
 	if (err)
-- 
2.40.1

