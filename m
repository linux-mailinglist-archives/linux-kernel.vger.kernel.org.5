Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F637D182F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjJTVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJTVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:31:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F59D7D;
        Fri, 20 Oct 2023 14:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837499; x=1729373499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhR8PA03IweFjxEMGnoY/Olwelsj+zdUo25OV+B4b3M=;
  b=ZBcY3BXut4QTesr0O48n/w4ScWKDTAQ7+wmnJYzDe3Dl9L5IZvUk9Y5o
   uzROsLMUBxMS5wnxlCqJkm9UJc4PGUbak93KRUmDfwZUbHwxIgzWxs8+h
   rIh74oRMD9Mjju6blVl0/53EuAoQs8eupmdLeRfIFReZpbzoZdLgihU+O
   B2TYnPdE9VtR8UbrK7CwjzmNshQGjhiFnivu7Wt92lyj9w1cGKpA6ENaI
   uLwYmjdmqTye0dihiXD1ShqXxhyp3pUSAoNOWGCASEj9WSSsCWTJq52YJ
   tzDyWc7jKdJZ1f8TSAylGlCwBAp6BeHHjDbedYWOFxaKF9YY0QbgVJ9ZP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371647105"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="371647105"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881184484"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881184484"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:31:08 -0700
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
Subject: [PATCH v9 2/8] x86/resctrl: Prepare to split rdt_domain structure
Date:   Fri, 20 Oct 2023 14:30:54 -0700
Message-ID: <20231020213100.123598-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020213100.123598-1-tony.luck@intel.com>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rdt_domain structure is used for both control and monitor features.
It is about to be split into separate structures for these two usages
because the scope for control and monitoring features for a resource
will be different for future resources.

To allow for common code that scans a list of domains looking for a
specific domain id, move the "list" and "id" fields into their own
structure within the rdt_domain structure.

Add a "type" field to the header to be used later so that callers looking
up a domain can be assured that they found one of the expected type.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
Changes since v6:

Add the "type" field to rdt_domain_hdr.

 include/linux/resctrl.h                   | 21 +++++++++--
 arch/x86/kernel/cpu/resctrl/core.c        | 16 ++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++-----
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 44 +++++++++++------------
 6 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7d4eb7df611d..320febbb0a4e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -52,10 +52,26 @@ struct resctrl_staged_config {
 	bool			have_new_ctrl;
 };
 
+enum resctrl_domain_type {
+	RESCTRL_CTRL_DOMAIN,
+	RESCTRL_MON_DOMAIN,
+};
+
 /**
- * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * struct rdt_domain_hdr - common header for different domain types
  * @list:		all instances of this resource
  * @id:			unique id for this instance
+ * @type:		type of this instance
+ */
+struct rdt_domain_hdr {
+	struct list_head		list;
+	int				id;
+	enum resctrl_domain_type	type;
+};
+
+/**
+ * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * @hdr:		common header for different domain types
  * @cpu_mask:		which CPUs share this resource
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
@@ -71,8 +87,7 @@ struct resctrl_staged_config {
  *			by closid
  */
 struct rdt_domain {
-	struct list_head		list;
-	int				id;
+	struct rdt_domain_hdr		hdr;
 	struct cpumask			cpu_mask;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e1588bcd9bd2..7daa5b7e6cb0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -356,7 +356,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))
 			return d;
@@ -405,12 +405,12 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 		return ERR_PTR(-ENODEV);
 
 	list_for_each(l, &r->domains) {
-		d = list_entry(l, struct rdt_domain, list);
+		d = list_entry(l, struct rdt_domain, hdr.list);
 		/* When id is found, return its domain. */
-		if (id == d->id)
+		if (id == d->hdr.id)
 			return d;
 		/* Stop searching when finding id's position in sorted list. */
-		if (id < d->id)
+		if (id < d->hdr.id)
 			break;
 	}
 
@@ -548,7 +548,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 
 	d = &hw_dom->d_resctrl;
-	d->id = id;
+	d->hdr.id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
 	rdt_domain_reconfigure_cdp(r);
@@ -563,11 +563,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	list_add_tail(&d->list, add_pos);
+	list_add_tail(&d->hdr.list, add_pos);
 
 	err = resctrl_online_domain(r, d);
 	if (err) {
-		list_del(&d->list);
+		list_del(&d->hdr.list);
 		domain_free(hw_dom);
 	}
 }
@@ -591,7 +591,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
 		resctrl_offline_domain(r, d);
-		list_del(&d->list);
+		list_del(&d->hdr.list);
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index beccb0e87ba7..6f4152b21985 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -67,7 +67,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
 		return -EINVAL;
 	}
 
@@ -146,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
 		return -EINVAL;
 	}
 
@@ -226,8 +226,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		return -EINVAL;
 	}
 	dom = strim(dom);
-	list_for_each_entry(d, &r->domains, list) {
-		if (d->id == dom_id) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
 			if (r->parse_ctrlval(&data, s, d))
@@ -318,7 +318,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		return -ENOMEM;
 
 	msr_param.res = NULL;
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
@@ -466,7 +466,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -476,7 +476,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->id, max_data_width,
+		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
@@ -505,7 +505,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			} else {
 				seq_printf(s, "%s:%d=%x\n",
 					   rdtgrp->plr->s->res->name,
-					   rdtgrp->plr->d->id,
+					   rdtgrp->plr->d->hdr.id,
 					   rdtgrp->plr->cbm);
 			}
 		} else {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..ef12f78392e9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -340,7 +340,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 	entry->busy = 0;
 	cpu = get_cpu();
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8c5f932bc00b..18b6183a1b48 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -856,7 +856,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * associated with them.
 	 */
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(d_i, &r->domains, list) {
+		list_for_each_entry(d_i, &r->domains, hdr.list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
 					   &d_i->cpu_mask);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c44be64d65ec..746ee56856a9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -91,7 +91,7 @@ void rdt_staged_configs_clear(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, list)
+		list_for_each_entry(dom, &r->domains, hdr.list)
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 }
@@ -984,12 +984,12 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
 		sw_shareable = 0;
 		exclusive = 0;
-		seq_printf(seq, "%d=", dom->id);
+		seq_printf(seq, "%d=", dom->hdr.id);
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
@@ -1302,7 +1302,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
 			continue;
 		has_cache = true;
-		list_for_each_entry(d, &r->domains, list) {
+		list_for_each_entry(d, &r->domains, hdr.list) {
 			ctrl = resctrl_arch_get_config(r, d, closid,
 						       s->conf_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
@@ -1465,7 +1465,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
 						    rdtgrp->plr->d,
 						    rdtgrp->plr->cbm);
-			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->hdr.id, size);
 		}
 		goto out;
 	}
@@ -1477,7 +1477,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		type = schema->conf_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
-		list_for_each_entry(d, &r->domains, list) {
+		list_for_each_entry(d, &r->domains, hdr.list) {
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1495,7 +1495,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 				else
 					size = rdtgroup_cbm_to_size(r, d, ctrl);
 			}
-			seq_printf(s, "%d=%u", d->id, size);
+			seq_printf(s, "%d=%u", d->hdr.id, size);
 			sep = true;
 		}
 		seq_putc(s, '\n');
@@ -1566,7 +1566,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 
 	mutex_lock(&rdtgroup_mutex);
 
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -1574,7 +1574,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		mon_info.evtid = evtid;
 		mondata_config_read(dom, &mon_info);
 
-		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
+		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
 		sep = true;
 	}
 	seq_puts(s, "\n");
@@ -1689,8 +1689,8 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
-	list_for_each_entry(d, &r->domains, list) {
-		if (d->id == dom_id) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
 			if (ret)
 				return -EINVAL;
@@ -2232,7 +2232,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 		return -ENOMEM;
 
 	r_l = &rdt_resources_all[level].r_resctrl;
-	list_for_each_entry(d, &r_l->domains, list) {
+	list_for_each_entry(d, &r_l->domains, hdr.list) {
 		if (r_l->cache.arch_has_per_cpu_cfg)
 			/* Pick all the CPUs in the domain instance */
 			for_each_cpu(cpu, &d->cpu_mask)
@@ -2317,7 +2317,7 @@ static int set_mba_sc(bool mba_sc)
 
 	r->membw.mba_sc = mba_sc;
 
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		for (i = 0; i < num_closid; i++)
 			d->mbps_val[i] = MBA_MAX_MBPS;
 	}
@@ -2653,7 +2653,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, list)
+		list_for_each_entry(dom, &r->domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
@@ -2780,7 +2780,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
 	 * from each domain to update the MSRs below.
 	 */
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
@@ -2986,7 +2986,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	char name[32];
 	int ret;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->id);
+	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
 	/* create the directory */
 	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
 	if (IS_ERR(kn))
@@ -3002,7 +3002,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	}
 
 	priv.u.rid = r->rid;
-	priv.u.domid = d->id;
+	priv.u.domid = d->hdr.id;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
@@ -3050,7 +3050,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	struct rdt_domain *dom;
 	int ret;
 
-	list_for_each_entry(dom, &r->domains, list) {
+	list_for_each_entry(dom, &r->domains, hdr.list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
 			return ret;
@@ -3209,7 +3209,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	 */
 	tmp_cbm = cfg->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->hdr.id);
 		return -ENOSPC;
 	}
 	cfg->have_new_ctrl = true;
@@ -3232,7 +3232,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &s->res->domains, list) {
+	list_for_each_entry(d, &s->res->domains, hdr.list) {
 		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
@@ -3247,7 +3247,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
-	list_for_each_entry(d, &r->domains, list) {
+	list_for_each_entry(d, &r->domains, hdr.list) {
 		if (is_mba_sc(r)) {
 			d->mbps_val[closid] = MBA_MAX_MBPS;
 			continue;
@@ -3864,7 +3864,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * per domain monitor data directories.
 	 */
 	if (static_branch_unlikely(&rdt_mon_enable_key))
-		rmdir_mondata_subdir_allrdtgrp(r, d->id);
+		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-- 
2.41.0

