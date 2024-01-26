Return-Path: <linux-kernel+bounces-40786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6708E83E5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84381F25220
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8450A8A;
	Fri, 26 Jan 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9WoYVec"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6A41A90;
	Fri, 26 Jan 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308730; cv=none; b=pc0aQB7s4bhnQszMWVrduGTCYd1+ceLuBSZA8gIgEAXzpRvd1pa8TWrRZ0ZwuuV8fy6rxqvQZFnT2MvDHHZhBJ02RokomOA63PSgFwvPW1wb3ILi5n8gEpt4jUE9Ix4gNkWJSYn+aZR0LKurIUFwPoc8g7kpj9Oh+JNJ9L8andA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308730; c=relaxed/simple;
	bh=crfc+LfZ8XOT2+G0/KJRzv8W3ELKrXufsaVi/E6oGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqIFr5FWhVR3QvSdpf8+86AbQaDgN46Te7Se4WT2O6WnI7cNGodtETTWVYknQ+LNWYwqW226wFEztNXxO/xdS5FqmkqULDKo2USR3Ky/gAC70RRNltnpmKnNkuyipSMnX8lfSN4soAarc30uhpAkxCLJLh9JlthLYi+Ap6k802U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9WoYVec; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706308728; x=1737844728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crfc+LfZ8XOT2+G0/KJRzv8W3ELKrXufsaVi/E6oGr4=;
  b=D9WoYVecVL1D04HI4cfQ9BDpycZU6cNEHBMVElTuYPrKCLX16IZwLodD
   jjq6GPEpwvvaLQ/ur00x+PrguX3rt6YTV+iz72HdPyJibiGgIlAlNw2yc
   Z4C/PIFTDJyOLwA+VjODtZHuKsQ2nJ++arzYhkWiIfXb6H6DKWyha44Cs
   FMkXwDCVkHttaI0w5CCy9MSd+yhc8MV1z+MF9uca/F4b0RKkXpit74Dz+
   m6xrvEVfqZB5LsecBkcPZ1dKwKRNjKO+ERnIXcf1w7Js/5W4rwtJIPJcm
   Rsdap1a+j8CnMTse9+2vqhAo4YpfwFtrJx8R8vyJEzYKKkZ43YCWXLc+o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9707645"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9707645"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35560248"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:38:47 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v14 1/8] x86/resctrl: Prepare for new domain scope
Date: Fri, 26 Jan 2024 14:38:30 -0800
Message-ID: <20240126223837.21835-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223837.21835-1-tony.luck@intel.com>
References: <20231204185357.120501-1-tony.luck@intel.com>
 <20240126223837.21835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl resources operate on subsets of CPUs in the system with the
defining attribute of each subset being an instance of a particular
level of cache. E.g. all CPUs sharing an L3 cache would be part of the
same domain.

In preparation for features that are scoped at the NUMA node level
change the code from explicit references to "cache_level" to a more
generic scope. At this point the only options for this scope are groups
of CPUs that share an L2 cache or L3 cache.

Clean up the error handling when looking up domains. Report invalid id's
before calling rdt_find_domain() in preparation for better messages when
scope can be other than cache scope. This means that rdt_find_domain()
will never return an error. So remove checks for error from the callsites.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |  9 ++++-
 arch/x86/kernel/cpu/resctrl/core.c        | 45 ++++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 ++-
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..7d4eb7df611d 100644
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
index aa9810a64258..268965c7c7ef 100644
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
@@ -399,9 +399,6 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct rdt_domain *d;
 	struct list_head *l;
 
-	if (id < 0)
-		return ERR_PTR(-ENODEV);
-
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
 		/* When id is found, return its domain. */
@@ -489,6 +486,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
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
@@ -504,18 +514,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 	int err;
 
-	d = rdt_find_domain(r, id, &add_pos);
-	if (IS_ERR(d)) {
-		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
 		return;
 	}
 
+	d = rdt_find_domain(r, id, &add_pos);
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
@@ -554,13 +565,19 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
+		return;
+	}
+
 	d = rdt_find_domain(r, id, NULL);
-	if (IS_ERR_OR_NULL(d)) {
-		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+	if (!d) {
+		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
 		return;
 	}
 	hw_dom = resctrl_to_arch_dom(d);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index beccb0e87ba7..3f8891d57fac 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -563,7 +563,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid].r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
-	if (IS_ERR_OR_NULL(d)) {
+	if (!d) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8f559eeae08e..2a682da9f43a 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
+	enum resctrl_scope scope = plr->s->res->scope;
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
index aa24343f1d23..1a9b2cd99b5f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1413,10 +1413,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	unsigned int size = 0;
 	int num_b, i;
 
+	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+		return size;
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
2.43.0


