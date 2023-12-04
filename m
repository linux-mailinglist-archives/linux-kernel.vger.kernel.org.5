Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE57803D94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjLDSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjLDSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:54:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADEEAF;
        Mon,  4 Dec 2023 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701716051; x=1733252051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B2NSS8NtiIoe6sccvuAxJJCMB7gQKtshras2cr9/L8Q=;
  b=RKv0MqtkRG3V5SRIhBzjk5NM6It3VnY5A8QMXTJ4Nb2wzVPtFgVWn8EG
   cYGM+pf+MZNFIJDEg5VpEeKtaS5NEAlp1RUaqRUVgtCT12MHXC7VPYc2D
   XKTuSPQOVkkQmb/HKG/nJFLgadNZmaE+6XdjtezGQctSFcBLeeJKEv5dP
   JfHqaNXT6IllTwRo0PfHPVjqwtbO6Zukepw2Xxuqd7uHkEi1bs/e0i2q9
   qUcw1bdMTCK43ShvWpvyQP8GpXuFcC+w+FoCSLutmksOTjW5Ur8CUkT2h
   LLys61Kkfd6sQHEyCln4m/l5a0WjUDnNxyH3XMDjG+I4bO0A5xCEgNOLt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="838483"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="838483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836687194"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836687194"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:54:07 -0800
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
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v13 3/8] x86/resctrl: Prepare for different scope for control/monitor operations
Date:   Mon,  4 Dec 2023 10:53:52 -0800
Message-ID: <20231204185357.120501-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204185357.120501-1-tony.luck@intel.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrl assumes that control and monitor operations on a resource are
performed at the same scope.

Prepare for systems that use different scope (specifically Intel needs
to split the RDT_RESOURCE_L3 resource to use L3 scope for cache control
and NODE scope for cache occupancy and memory bandwidth monitoring).

Create separate domain lists for control and monitor operations.

Note that errors during initialization of either control or monitor
functions on a domain would previously result in that domain being
excluded from both control and monitor operations. Now the domains are
allocated independently it is no longer required to disable both control
and monitor operations if either fail.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h                   |  25 ++-
 arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 211 ++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  12 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |   4 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  55 +++---
 7 files changed, 220 insertions(+), 97 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index c4067150a6b7..35e700edc6e6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -52,15 +52,22 @@ struct resctrl_staged_config {
 	bool			have_new_ctrl;
 };
 
+enum resctrl_domain_type {
+	RESCTRL_CTRL_DOMAIN,
+	RESCTRL_MON_DOMAIN,
+};
+
 /**
  * struct rdt_domain_hdr - common header for different domain types
  * @list:		all instances of this resource
  * @id:			unique id for this instance
+ * @type:		type of this instance
  * @cpu_mask:		which CPUs share this resource
  */
 struct rdt_domain_hdr {
 	struct list_head		list;
 	int				id;
+	enum resctrl_domain_type	type;
 	struct cpumask			cpu_mask;
 };
 
@@ -163,10 +170,12 @@ enum resctrl_scope {
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
- * @scope:		Scope of this resource
+ * @ctrl_scope:		Scope of this resource for control functions
+ * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
- * @domains:		All domains for this resource
+ * @ctrl_domains:	Control domains for this resource
+ * @mon_domains:	Monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
@@ -181,10 +190,12 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-	enum resctrl_scope	scope;
+	enum resctrl_scope	ctrl_scope;
+	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
-	struct list_head	domains;
+	struct list_head	ctrl_domains;
+	struct list_head	mon_domains;
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
@@ -230,8 +241,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 
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
index a4f1aa15f0a2..24bf9d7989a9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -520,8 +520,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos);
+struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
+				       struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
@@ -540,7 +540,7 @@ int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 62a989fd950d..1fd85533b4ca 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -57,7 +57,8 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 	      struct rdt_resource *r);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
+#define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
+#define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
 
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
@@ -65,8 +66,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_L3),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.mon_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
+			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -79,8 +82,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
-			.scope			= RESCTRL_L2_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_L2),
+			.ctrl_scope		= RESCTRL_L2_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -93,8 +96,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -105,8 +108,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_SMBA),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -352,11 +355,11 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
+struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
 			return d;
@@ -378,7 +381,7 @@ void rdt_ctrl_update(void *arg)
 	int cpu = smp_processor_id();
 	struct rdt_domain *d;
 
-	d = get_domain_from_cpu(cpu, r);
+	d = get_ctrl_domain_from_cpu(cpu, r);
 	if (d) {
 		hw_res->msr_update(d, m, r);
 		return;
@@ -388,26 +391,26 @@ void rdt_ctrl_update(void *arg)
 }
 
 /*
- * rdt_find_domain - Find a domain in a resource that matches input resource id
+ * rdt_find_domain - Search for a domain id in a resource domain list.
  *
- * Search resource r's domain list to find the resource id. If the resource
- * id is found in a domain, return the domain. Otherwise, if requested by
- * caller, return the first domain whose id is bigger than the input id.
- * The domain list is sorted by id in ascending order.
+ * Search the domain list to find the domain id. If the domain id is
+ * found, return the domain. NULL otherwise.  If the domain id is not
+ * found (and NULL returned) then the first domain with id bigger than
+ * the input id can be returned to the caller via @pos.
  */
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos)
+struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
+				       struct list_head **pos)
 {
-	struct rdt_domain *d;
+	struct rdt_domain_hdr *d;
 	struct list_head *l;
 
-	list_for_each(l, &r->domains) {
-		d = list_entry(l, struct rdt_domain, hdr.list);
+	list_for_each(l, h) {
+		d = list_entry(l, struct rdt_domain_hdr, list);
 		/* When id is found, return its domain. */
-		if (id == d->hdr.id)
+		if (id == d->id)
 			return d;
 		/* Stop searching when finding id's position in sorted list. */
-		if (id < d->hdr.id)
+		if (id < d->id)
 			break;
 	}
 
@@ -501,35 +504,28 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	return -EINVAL;
 }
 
-/*
- * domain_add_cpu - Add a cpu to a resource's domain list.
- *
- * If an existing domain in the resource r's domain list matches the cpu's
- * resource id, add the cpu in the domain.
- *
- * Otherwise, a new domain is allocated and inserted into the right position
- * in the domain list sorted by id in ascending order.
- *
- * The order in the domain list is visible to users when we print entries
- * in the schemata file and schemata input is validated to have the same order
- * as this list.
- */
-static void domain_add_cpu(int cpu, struct rdt_resource *r)
+static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
-	int id = get_domain_id_from_scope(cpu, r->scope);
+	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
 	struct rdt_domain *d;
 	int err;
 
 	if (id < 0) {
-		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->scope, r->name);
+		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->ctrl_scope, r->name);
 		return;
 	}
 
-	d = rdt_find_domain(r, id, &add_pos);
-	if (d) {
+	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
+	if (hdr) {
+		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+			return;
+
+		d = container_of(hdr, struct rdt_domain, hdr);
+
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
 			rdt_domain_reconfigure_cdp(r);
@@ -542,51 +538,114 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
+	d->hdr.type = RESCTRL_CTRL_DOMAIN;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	rdt_domain_reconfigure_cdp(r);
 
-	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
+	if (domain_setup_ctrlval(r, d)) {
 		domain_free(hw_dom);
 		return;
 	}
 
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	list_add_tail(&d->hdr.list, add_pos);
+
+	err = resctrl_online_ctrl_domain(r, d);
+	if (err) {
+		list_del(&d->hdr.list);
+		domain_free(hw_dom);
+	}
+}
+
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
+	struct rdt_domain *d;
+	int err;
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
+	if (hdr) {
+		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+			return;
+
+		d = container_of(hdr, struct rdt_domain, hdr);
+
+		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		return;
+	}
+
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
+		return;
+
+	d = &hw_dom->d_resctrl;
+	d->hdr.id = id;
+	d->hdr.type = RESCTRL_MON_DOMAIN;
+	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+
+	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
 		domain_free(hw_dom);
 		return;
 	}
 
 	list_add_tail(&d->hdr.list, add_pos);
 
-	err = resctrl_online_domain(r, d);
+	err = resctrl_online_mon_domain(r, d);
 	if (err) {
 		list_del(&d->hdr.list);
 		domain_free(hw_dom);
 	}
 }
 
-static void domain_remove_cpu(int cpu, struct rdt_resource *r)
+/*
+ * domain_add_cpu - Add a CPU to either/both resource's domain lists.
+ */
+static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_domain_id_from_scope(cpu, r->scope);
+	if (r->alloc_capable)
+		domain_add_cpu_ctrl(cpu, r);
+	if (r->mon_capable)
+		domain_add_cpu_mon(cpu, r);
+}
+
+static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
 	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
 	struct rdt_domain *d;
 
 	if (id < 0) {
-		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->scope, r->name);
+		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->ctrl_scope, r->name);
 		return;
 	}
 
-	d = rdt_find_domain(r, id, NULL);
-	if (!d) {
-		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
+	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
+	if (!hdr) {
+		pr_warn("Can't find control domain for id=%d for CPU %d for resource %s\n",
+			id, cpu, r->name);
 		return;
 	}
+
+	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+		return;
+
+	d = container_of(hdr, struct rdt_domain, hdr);
 	hw_dom = resctrl_to_arch_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
 	if (cpumask_empty(&d->hdr.cpu_mask)) {
-		resctrl_offline_domain(r, d);
+		resctrl_offline_ctrl_domain(r, d);
 		list_del(&d->hdr.list);
 
 		/*
@@ -599,6 +658,42 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		return;
 	}
+}
+
+static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
+	struct rdt_domain *d;
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
+	if (!hdr) {
+		pr_warn("Can't find monitor domain for id=%d for CPU %d for resource %s\n",
+			id, cpu, r->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+		return;
+
+	d = container_of(hdr, struct rdt_domain, hdr);
+	hw_dom = resctrl_to_arch_dom(d);
+
+	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
+	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		resctrl_offline_mon_domain(r, d);
+		list_del(&d->hdr.list);
+		domain_free(hw_dom);
+
+		return;
+	}
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
@@ -613,6 +708,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
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
index 23f8258d36a8..0b4136c42762 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -226,7 +226,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		return -EINVAL;
 	}
 	dom = strim(dom);
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
@@ -318,7 +318,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		return -ENOMEM;
 
 	msr_param.res = NULL;
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
@@ -466,7 +466,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -542,6 +542,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_domain_hdr *hdr;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -562,11 +563,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = &rdt_resources_all[resid].r_resctrl;
-	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
 		ret = -ENOENT;
 		goto out;
 	}
+	d = container_of(hdr, struct rdt_domain, hdr);
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index dd0ea1bc0092..ec5ad926c5dc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -340,7 +340,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 	entry->busy = 0;
 	cpu = get_cpu();
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask)) {
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
@@ -535,7 +535,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
 
-	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
+	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index fcbd99e2eb66..ed6d59af1cef 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,7 +292,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	enum resctrl_scope scope = plr->s->res->scope;
+	enum resctrl_scope scope = plr->s->res->ctrl_scope;
 	struct cpu_cacheinfo *ci;
 	int ret;
 	int i;
@@ -856,7 +856,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * associated with them.
 	 */
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(d_i, &r->domains, hdr.list) {
+		list_for_each_entry(d_i, &r->ctrl_domains, hdr.list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
 					   &d_i->hdr.cpu_mask);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 04d32602ac33..760013ed1bff 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -91,7 +91,7 @@ void rdt_staged_configs_clear(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, hdr.list)
+		list_for_each_entry(dom, &r->ctrl_domains, hdr.list)
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 }
@@ -984,7 +984,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
 		sw_shareable = 0;
@@ -1302,7 +1302,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
 			continue;
 		has_cache = true;
-		list_for_each_entry(d, &r->domains, hdr.list) {
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 			ctrl = resctrl_arch_get_config(r, d, closid,
 						       s->conf_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
@@ -1413,13 +1413,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	unsigned int size = 0;
 	int num_b, i;
 
-	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+	if (WARN_ON_ONCE(r->ctrl_scope != RESCTRL_L2_CACHE && r->ctrl_scope != RESCTRL_L3_CACHE))
 		return size;
 
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->hdr.cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == r->scope) {
+		if (ci->info_list[i].level == r->ctrl_scope) {
 			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
 			break;
 		}
@@ -1477,7 +1477,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		type = schema->conf_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
-		list_for_each_entry(d, &r->domains, hdr.list) {
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1566,7 +1566,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 
 	mutex_lock(&rdtgroup_mutex);
 
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -1689,7 +1689,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
 			if (ret)
@@ -2232,7 +2232,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 		return -ENOMEM;
 
 	r_l = &rdt_resources_all[level].r_resctrl;
-	list_for_each_entry(d, &r_l->domains, hdr.list) {
+	list_for_each_entry(d, &r_l->ctrl_domains, hdr.list) {
 		if (r_l->cache.arch_has_per_cpu_cfg)
 			/* Pick all the CPUs in the domain instance */
 			for_each_cpu(cpu, &d->hdr.cpu_mask)
@@ -2317,7 +2317,7 @@ static int set_mba_sc(bool mba_sc)
 
 	r->membw.mba_sc = mba_sc;
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		for (i = 0; i < num_closid; i++)
 			d->mbps_val[i] = MBA_MAX_MBPS;
 	}
@@ -2653,7 +2653,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, hdr.list)
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
@@ -2777,10 +2777,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
 
 	/*
 	 * Disable resource control for this resource by setting all
-	 * CBMs in all domains to the maximum mask value. Pick one CPU
+	 * CBMs in all ctrl_domains to the maximum mask value. Pick one CPU
 	 * from each domain to update the MSRs below.
 	 */
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
 
@@ -3050,7 +3050,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	struct rdt_domain *dom;
 	int ret;
 
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
 			return ret;
@@ -3232,7 +3232,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &s->res->domains, hdr.list) {
+	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
 		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
@@ -3247,7 +3247,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (is_mba_sc(r)) {
 			d->mbps_val[closid] = MBA_MAX_MBPS;
 			continue;
@@ -3849,15 +3849,17 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
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
@@ -3914,18 +3916,21 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
-	int err;
-
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
-		/* RDT_RESOURCE_MBA is never mon_capable */
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
2.41.0

