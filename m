Return-Path: <linux-kernel+bounces-97611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1D876C76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521F01F2206F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BA85FDB3;
	Fri,  8 Mar 2024 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7suXmio"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B225D471
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933941; cv=none; b=HJxyWWV8OG9b+ZmEQw684FNDkQ1UHh0JMKnjR+9ZhmW0YBb+QN22XLSzZKP1/QnOFFyTAqN8ZElfWCO8lOKtt9EtIyxF6f0q38Y0utG8vocVwP0JV/FB5N2IO6AIGrc9HTe7Xh4ZcM8ftaFE1WvvToZ/N45JYFP7Hec8Dxu1EUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933941; c=relaxed/simple;
	bh=S9kCGyqZQcHJ1572zCRxCJaGpSHTwJpNkfJNbxdCi/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkgWG3wLXvk2XMIeabY3NR/D0Wzk7gW9piiKXjkr63sT/T/PS8hByDTsk4Ip7QqIcOuGFzL6t4e8EWsclzGaTU6M76jhyZ0uqli9MyCnmwnCn9rkZC2EADzGNeNxIAFuYVA6U/D2jaHbZYLiwUHQXquufZmk6vio0bBIM/mE4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7suXmio; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709933940; x=1741469940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9kCGyqZQcHJ1572zCRxCJaGpSHTwJpNkfJNbxdCi/o=;
  b=h7suXmioDWmV0WlVgTaXjhNaEmc2VvUzicMOPPUcm2TJq/a1TuBbHKj+
   nEBq64HEBnTwu1G1ntSK/jVJZUE6eInkIdyMkEuzEpJs1nWRxgt6u+b6f
   6HJc949kpdY9SOs+4vgZJvH7DHCwNJg8LGWlq1xdmS3HsVvY7/8bmsVsR
   Dy4DVGUQlzZz1qCGY+QDi2i6jjgoy6uwZbCjJuwxzkHcYrMtojcNu5K+A
   VbbrFrAHIerENSteG3dnVTVwag6cQ7mOD9c6x+R2pEVHYI8mAuCCdoAoS
   7DN/E1hQHQFpuWYGd2wZCWlpfIu7zYxBzHMXGvm+3DeLC/FyzAA/8fY4O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4811400"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4811400"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15295084"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:56 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Subject: [PATCH v5 1/2] x86/resctrl: Pass domain to target CPU
Date: Fri,  8 Mar 2024 13:38:45 -0800
Message-ID: <20240308213846.77075-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308213846.77075-1-tony.luck@intel.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
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
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c        | 17 ++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 +++++------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++-----
 4 files changed, 17 insertions(+), 52 deletions(-)

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
index 7997b47743a2..165d8d453c04 100644
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
@@ -315,48 +300,39 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	enum resctrl_conf_type t;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
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
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
 			if (!cfg->have_new_ctrl)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
+			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
+			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
 
 			if (!msr_param.res) {
 				msr_param.low = idx;
 				msr_param.high = msr_param.low + 1;
 				msr_param.res = r;
+				msr_param.dom = d;
 			} else {
 				msr_param.low = min(msr_param.low, idx);
 				msr_param.high = max(msr_param.high, idx + 1);
 			}
 		}
+		if (msr_param.res)
+			smp_call_function_any(&d->cpu_mask, rdt_ctrl_update, &msr_param, 1);
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
index 011e17efb1a6..02f213f1c51c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2813,16 +2813,12 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
-	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	int i;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	msr_param.res = r;
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
@@ -2834,17 +2830,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 */
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
+		msr_param.dom = d;
+		smp_call_function_any(&d->cpu_mask, rdt_ctrl_update, &msr_param, 1);
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


