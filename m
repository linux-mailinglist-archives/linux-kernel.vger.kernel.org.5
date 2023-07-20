Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7C75A35D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGTAVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGTAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:21:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4126BA;
        Wed, 19 Jul 2023 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689812471; x=1721348471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hvpB7McaMJWTQw0l4yUdv8Trm9mvHhSVNmnrVlUgN/s=;
  b=ZItoC1Aps7aPVdMXcz2LAcICrwSUaJ4hpvChKbcrkIR/rDA7IS8zfjAp
   VdF/xqMPxlY99XCoZNg45j957CnDBrcNVZPHuEK7siv+fOeD6sAa7Lbfb
   Qm8f4x33Lf5XoGuQ6OYtlOqKDjZgKRGoSYF7aoxCJrhQFJsTHQoCegKT9
   0cnqCXPkATnVyg6mQP1fZndAtn0EME//CBuD5DgDpU9AYUSKkgjcmay5o
   rNj1gKvgTy2JUIalJ/g6MWzelk1hC0i610I0KuuMhERimY6kVX4/No1k0
   TJW1x/VD1CTTGodoKKpPKUz07JBu0SNRNrpKeM21XENKc4dksTqaCg+lF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346193360"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346193360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 17:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789596446"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789596446"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 17:20:29 -0700
Date:   Wed, 19 Jul 2023 17:20:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Message-ID: <ZLh9y8LQNkR/VhOq@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a quick hack to see how things might look with
separate domain lists in the "L3" resource.

For testing purposes on a non-SNC system I set ->mon_scope =
MON_SCOPE_NODE, but made domain_add_cpu() allocate the mondomains
list based on L3 scope ... just so I could check that I found all
the places where monitoring needs to use the mondomains list.
The kernel doesn't crash when running tools/testing/selftests/resctrl,
and the tests all pass. But that doesn't mean I didn't miss something.

Some restructuring of control vs. monitoing initialization might
avoid some of the code I duplicated in domain_add_cpu(). But this
is intended just as a "Is this what you meant?" before I dig deeper.

Overall, I think it is a cleaner approach that making a new
"L3" resource with different scope just for the SNC monitoring

-Tony

---

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..e4b653088a22 100644
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
+ * @mondomains:		Monitor domains for this resource (if mon_scope != 0)
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
@@ -184,6 +188,8 @@ struct rdt_resource {
 	bool			cdp_capable;
 };
 
+#define MON_SCOPE_NODE	1
+
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
@@ -217,8 +223,8 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d, bool mon_setup);
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d, bool mon_teardown);
 
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
index 030d3b409768..545d563ba956 100644
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
+			.mon_scope		= MON_SCOPE_NODE, //FAKE
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
@@ -508,7 +511,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct rdt_domain *d;
 	int err;
 
-	d = rdt_find_domain(r, id, &add_pos);
+	d = rdt_find_domain(&r->domains, id, &add_pos);
 	if (IS_ERR(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
@@ -536,6 +539,44 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	if (!r->mon_scope && r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+		domain_free(hw_dom);
+		return;
+	}
+
+	list_add_tail(&d->list, add_pos);
+
+	err = resctrl_online_domain(r, d, r->mon_scope == 0);
+	if (err) {
+		list_del(&d->list);
+		domain_free(hw_dom);
+	}
+
+	if (r->mon_scope != MON_SCOPE_NODE)
+		return;
+
+	//id = cpu_to_node(cpu);
+	id = get_cpu_cacheinfo_id(cpu, r->cache_level); // FAKE
+	add_pos = NULL;
+	d = rdt_find_domain(&r->mondomains, id, &add_pos);
+	if (IS_ERR(d)) {
+		pr_warn("Couldn't find node id for CPU %d\n", cpu);
+		return;
+	}
+
+	if (d) {
+		cpumask_set_cpu(cpu, &d->cpu_mask);
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
 	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
 		domain_free(hw_dom);
 		return;
@@ -543,7 +584,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	list_add_tail(&d->list, add_pos);
 
-	err = resctrl_online_domain(r, d);
+	err = resctrl_online_domain(r, d, true);
 	if (err) {
 		list_del(&d->list);
 		domain_free(hw_dom);
@@ -556,7 +597,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
-	d = rdt_find_domain(r, id, NULL);
+	d = rdt_find_domain(&r->domains, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
@@ -565,7 +606,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
-		resctrl_offline_domain(r, d);
+		resctrl_offline_domain(r, d, r->mon_scope == 0);
 		list_del(&d->list);
 
 		/*
@@ -579,7 +620,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
+	if (r->mon_scope == 0 && r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0);
@@ -590,6 +631,23 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			cqm_setup_limbo_handler(d, 0);
 		}
 	}
+
+	if (r->mon_scope != MON_SCOPE_NODE)
+		return;
+
+	id = cpu_to_node(cpu);
+	d = rdt_find_domain(&r->mondomains, id, NULL);
+	if (IS_ERR_OR_NULL(d)) {
+		pr_warn("Couldn't find node id for CPU %d\n", cpu);
+		return;
+	}
+
+	cpumask_clear_cpu(cpu, &d->cpu_mask);
+	if (cpumask_empty(&d->cpu_mask)) {
+		resctrl_offline_domain(r, d, true);
+		list_del(&d->list);
+		domain_free(hw_dom);
+	}
 }
 
 static void clear_closid_rmid(int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..80033cb698d0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -545,6 +545,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdt_resource *r;
 	union mon_data_bits md;
 	struct rdt_domain *d;
+	struct list_head *h;
 	struct rmid_read rr;
 	int ret = 0;
 
@@ -560,7 +561,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = &rdt_resources_all[resid].r_resctrl;
-	d = rdt_find_domain(r, domid, NULL);
+	h = r->mon_scope ? &r->mondomains : &r->domains;
+	d = rdt_find_domain(h, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7cb7cb..08085202582a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -335,12 +335,14 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_domain *d;
+	struct list_head *h;
 	int cpu, err;
 	u64 val = 0;
 
 	entry->busy = 0;
 	cpu = get_cpu();
-	list_for_each_entry(d, &r->domains, list) {
+	h = r->mon_scope ? &r->mondomains : &r->domains;
+	list_for_each_entry(d, h, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..fb5b23fcb6d4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1492,11 +1492,13 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 {
 	struct mon_config_info mon_info = {0};
 	struct rdt_domain *dom;
+	struct list_head *h;
 	bool sep = false;
 
 	mutex_lock(&rdtgroup_mutex);
 
-	list_for_each_entry(dom, &r->domains, list) {
+	h = r->mon_scope ? &r->mondomains : &r->domains;
+	list_for_each_entry(dom, h, list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -1599,6 +1601,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
+	struct list_head *h;
 	int ret = 0;
 
 next:
@@ -1619,7 +1622,8 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
-	list_for_each_entry(d, &r->domains, list) {
+	h = r->mon_scope ? &r->mondomains : &r->domains;
+	list_for_each_entry(d, h, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
 			if (ret)
@@ -2465,6 +2469,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
+	struct list_head *h;
 	int ret;
 
 	cpus_read_lock();
@@ -2525,7 +2530,8 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, list)
+		h = r->mon_scope ? &r->mondomains : &r->domains;
+		list_for_each_entry(dom, h, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
@@ -2917,9 +2923,11 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdtgroup *prgrp)
 {
 	struct rdt_domain *dom;
+	struct list_head *h;
 	int ret;
 
-	list_for_each_entry(dom, &r->domains, list) {
+	h = r->mon_scope ? &r->mondomains : &r->domains;
+	list_for_each_entry(dom, h, list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
 			return ret;
@@ -3708,14 +3716,14 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d, bool mon_teardown)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		mba_sc_domain_destroy(r, d);
 
-	if (!r->mon_capable)
+	if (!mon_teardown || !r->mon_capable)
 		return;
 
 	/*
@@ -3773,7 +3781,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d, bool mon_setup)
 {
 	int err;
 
@@ -3783,7 +3791,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 		/* RDT_RESOURCE_MBA is never mon_capable */
 		return mba_sc_domain_allocate(r, d);
 
-	if (!r->mon_capable)
+	if (!mon_setup || !r->mon_capable)
 		return 0;
 
 	err = domain_setup_mon_state(r, d);
