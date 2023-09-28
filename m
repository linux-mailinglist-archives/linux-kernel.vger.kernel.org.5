Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF17A7B25BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjI1TOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjI1TOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:14:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839841A8;
        Thu, 28 Sep 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928441; x=1727464441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwQ2brqgMUhemRvUUMd53Pt9MPLz6Qcd9Aym5LDIjhE=;
  b=CnVusxo/lqVNv3Ox1StzKjaJxsc4c15qxirxl8lpsdkSprwA5JJ8GdoW
   f27O9I7RVYw1ezjimwKHkAEvnU5aWqARkkJRCkC3V+g36eT+D8Q0V1lUO
   WZYrYGCMCqLbBLuT2RNOW3koPzmJVoD/PWnRkClRXK5SSUwNcyfmYllQf
   mzZgQUjS2TAICKKu8CanbYsb/9ra38Yt5LgXi37Ihmpg4GBAqmaXgr0Ni
   nrncv+Ytw4Z0WokZIjJ52AXHmhkOqLBjeH7YiCaZ0jangoDSt0c58GUrf
   xQ06/1ZhmVomODObO4LNkuUpFx6yoVd/uA4WO+ydXYF6L+QnjCQL03fLy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367213873"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367213873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779020022"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="779020022"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:13:58 -0700
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
Subject: [PATCH v6 1/8] x86/resctrl: Prepare for new domain scope
Date:   Thu, 28 Sep 2023 12:13:42 -0700
Message-ID: <20230928191350.205703-2-tony.luck@intel.com>
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

Resctrl resources operate on subsets of CPUs in the system with the
defining attribute of each subset being an instance of a particular
level of cache. E.g. all CPUs sharing an L3 cache would be part of the
same domain.

In preparation for features that are scoped at the NUMA node level
change the code from explicit references to "cache_level" to a more
generic scope. At this point the only options for this scope are groups
of CPUs that share an L2 cache or L3 cache.

Provide a more detailed warning message if a domain id cannot be found
when adding a CPU. Just check and silent return if the domain id can't
be found when removing a CPU.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v5:
1) Set enum values of RESCTRL_L2_CACHE and RESCTRL_L3_CACHE to "2" and
   "3 respectively so they can be passed to get_cpu_cacheinfo_id()
   (in code paths that check that scope is one of the cache types).

2) Simplified the check on scope in pseudo_lock_region_init() and
   rdtgroup_cbm_to_size().

3) Added detailed warning if the domain id for a CPU cannot be
   determined when adding a CPU. Simpler check on removal.
---
 include/linux/resctrl.h                   |  9 +++++--
 arch/x86/kernel/cpu/resctrl/core.c        | 33 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 +++-
 4 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..618735e396cb 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -144,13 +144,18 @@ struct resctrl_membw {
 struct rdt_parse_data;
 struct resctrl_schema;
 
+enum resctrl_scope {
+	RESCTRL_L2_CACHE = 2,
+	RESCTRL_L3_CACHE = 3,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
- * @cache_level:	Which cache level defines scope of this resource
+ * @scope:		Scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @domains:		All domains for this resource
@@ -168,7 +173,7 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-	int			cache_level;
+	enum resctrl_scope	scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
 	struct list_head	domains;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..3b1837e1fb6b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
-			.cache_level		= 2,
+			.scope			= RESCTRL_L2_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -487,6 +487,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 	return 0;
 }
 
+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
+{
+	switch (scope) {
+	case RESCTRL_L2_CACHE:
+	case RESCTRL_L3_CACHE:
+		return get_cpu_cacheinfo_id(cpu, scope);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -502,12 +515,17 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 	int err;
 
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
+		return;
+	}
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
@@ -552,10 +570,13 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
+	if (id < 0)
+		return;
+
 	d = rdt_find_domain(r, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8f559eeae08e..8c5f932bc00b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
+	int scope = plr->s->res->scope;
 	struct cpu_cacheinfo *ci;
 	int ret;
 	int i;
 
+	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
+		return -ENODEV;
+
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
 
@@ -311,7 +315,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
 
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
+		if (ci->info_list[i].level == scope) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
 			return 0;
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 725344048f85..1cf2b36f5bf8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1345,10 +1345,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	unsigned int size = 0;
 	int num_b, i;
 
+	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+		return -EINVAL;
+
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == r->cache_level) {
+		if (ci->info_list[i].level == r->scope) {
 			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
 			break;
 		}
-- 
2.41.0

