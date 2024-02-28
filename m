Return-Path: <linux-kernel+bounces-85614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51786B850
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523961C21C41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873CF15F306;
	Wed, 28 Feb 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdyrou0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097A7443C;
	Wed, 28 Feb 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149041; cv=none; b=BkrxHjUkGsNwJfmF38XJ5+pSykJsX8hH/pTdJaa0g7aNxR7u50vcFD5k0T1PQKgtpu8cGtZxFfqPm48kkWn+fYk0yUTbbKcvwmaF2mC64fxynEHjqjUBz389oBbuRDa9JetWxEia0yLVzYnT8fvcYGqMIhuFZax48uragSMGGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149041; c=relaxed/simple;
	bh=jLgkMy4ti260dcTqRD9pF5RfpOlymJ24erhHPdJlKMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQb1TaRFSBlwEFGqvYFo15HM66p8tHrqWbXgPyxkVLioeUpjH5H6TOUavtDSfeQqE92qzW9ewIdk7/OuUGrO+voqtREXMaMzxgr1T/caVtSK16/XcxSzcdiK99GQuc6Oo/N8zE27t/Uu/sTH83Bi4XNfiUJphgGIjyc1eBxxmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdyrou0K; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149040; x=1740685040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLgkMy4ti260dcTqRD9pF5RfpOlymJ24erhHPdJlKMw=;
  b=cdyrou0KcMAbhVj0HY34iP5A4xD653ZamYJwIr620ShHLkttFrsgWcZW
   5Fv+OtMtIrcs4/4eoNhyRr91EX5kVijmptJ4/9BIckZhHaVb7eeBEpw5m
   jsc11Oo8ReJQmVWPIu7FrHKqDNEjEhJqNbIPMavJAWNi8j+kINAPFZDft
   rAmavKEODgbzjJ+FpiyZGN5AGSO/Op8AiIsIGpWQBUas+DVsZ5IIYNpPF
   XigtUPzuWePyvW2MGe7G1LkBYPU90UNP7qWutIMshZ82u03SDB3XBmvst
   TtA4YjgYp1FEwGxQfxavDnm/OYtJoJV0OFypYtw5pAOnAS5cMOKqxtRDP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3495457"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3495457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7485367"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:17 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Date: Wed, 28 Feb 2024 11:36:53 -0800
Message-ID: <20240228193717.8170-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228112952.8090-tony.luck@intel.com>
References: <20240228112215.8044-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
to call rdt_ctrl_update() on potentially one CPU from each domain.

But this means rdt_ctrl_update() needs to figure out which domain to
apply changes to. Doing so requires a search of all domains in a resource,
which can only be done safely if cpus_lock is held. Both callers do hold
this lock, but there isn't a way for a function called on another CPU
via IPI to verify this.

Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
false positive") removed the incorrect assertions.

Add the target domain to the msr_param structure and
call rdt_ctrl_update() for each domain separately using
smp_call_function_single(). This means that rdt_ctrl_update() doesn't
need to search for the domain and get_domain_from_cpu() can safely assert
that the cpus_lock is held since the remaining callers do not use IPI.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c        | 17 ++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++-----
 4 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..bc999471f072 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -378,11 +378,13 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
+ * @dom:       The domain to update
  * @low:       Beginning index from base MSR
  * @high:      End index
  */
 struct msr_param {
 	struct rdt_resource	*res;
+	struct rdt_domain	*dom;
 	u32			low;
 	u32			high;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..acf52aa185e0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -362,6 +362,8 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))
@@ -378,19 +380,11 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
 
 void rdt_ctrl_update(void *arg)
 {
+	struct rdt_hw_resource *hw_res;
 	struct msr_param *m = arg;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
-	struct rdt_resource *r = m->res;
-	int cpu = smp_processor_id();
-	struct rdt_domain *d;
 
-	d = get_domain_from_cpu(cpu, r);
-	if (d) {
-		hw_res->msr_update(d, m, r);
-		return;
-	}
-	pr_warn_once("cpu %d not found in any domain for resource %s\n",
-		     cpu, r->name);
+	hw_res = resctrl_to_arch_res(m->res);
+	hw_res->msr_update(m->dom, m, m->res);
 }
 
 /*
@@ -463,6 +457,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	hw_dom->ctrl_val = dc;
 	setup_default_ctrlval(r, dc);
 
+	m.dom = d;
 	m.low = 0;
 	m.high = hw_res->num_closid;
 	hw_res->msr_update(d, &m, r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7997b47743a2..a3a0fd80daa8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -272,22 +272,6 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 	}
 }
 
-static bool apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, u32 idx,
-			 cpumask_var_t cpu_mask)
-{
-	struct rdt_domain *dom = &hw_dom->d_resctrl;
-
-	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
-		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
-
-		return true;
-	}
-
-	return false;
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
@@ -302,6 +286,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	hw_dom->ctrl_val[idx] = cfg_val;
 
 	msr_param.res = r;
+	msr_param.dom = d;
 	msr_param.low = idx;
 	msr_param.high = idx + 1;
 	hw_res->msr_update(d, &msr_param, r);
@@ -315,27 +300,27 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	enum resctrl_conf_type t;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
+	int cpu;
 	u32 idx;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
+		msr_param.res = NULL;
+		msr_param.dom = d;
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
 			if (!cfg->have_new_ctrl)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
+			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
+			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
+			cpu = cpumask_any(&d->cpu_mask);
 
 			if (!msr_param.res) {
 				msr_param.low = idx;
@@ -346,17 +331,10 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				msr_param.high = max(msr_param.high, idx + 1);
 			}
 		}
+		if (msr_param.res)
+			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	if (cpumask_empty(cpu_mask))
-		goto done;
-
-	/* Update resource control msr on all the CPUs. */
-	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-
-done:
-	free_cpumask_var(cpu_mask);
-
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 011e17efb1a6..da4f13db4161 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2813,16 +2813,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
+	int cpu;
 	int i;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	msr_param.res = r;
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
@@ -2834,17 +2831,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 */
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+		cpu = cpumask_any(&d->cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
+		msr_param.dom = d;
+		smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	/* Update CBM on all the CPUs in cpu_mask */
-	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-
-	free_cpumask_var(cpu_mask);
-
 	return 0;
 }
 
-- 
2.43.0


