Return-Path: <linux-kernel+bounces-73864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920285CCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25548282EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA91396;
	Wed, 21 Feb 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3aqnR4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CC382
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475734; cv=none; b=Ul4v4p0XFB23icV8MxejeXHSSmiCKx1YgXILpdEl6/lL/V9SDIre7yLdaSbVVHdpRr0Aa6Mon1N4ZDU/sLZxoYm8RpdLqyI9ZTXKRE01V0OU313FmMxRFUd6azweRWh3s/6CvRIEBHpae0c4CukGuNn6bT9sA66uxUNS4Tgc/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475734; c=relaxed/simple;
	bh=9aGkgXtJR1/nVfpEGfeAe+MMVQUE8yVMG2PkPxV5iAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBKzrhZburCRBt1zX7fG1aDDtjgvOrZ9k67nAU/lY8M8dveGxB8FVsfbGfrVt5m22XmxLh2urmbzWARJISh7vBlFwmToYMLxvZfw/9kfxYD4GhqU6KM5Rq45dUZbvSfOL2ODpLjYmGnAwMNfdng28o2P0SFKtOE22oBlZO9ERAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3aqnR4h; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708475732; x=1740011732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9aGkgXtJR1/nVfpEGfeAe+MMVQUE8yVMG2PkPxV5iAY=;
  b=O3aqnR4hv6GLL5rN7ntwJ2XTD1lrp+EWZXzuEsrfkc8FzXIOsd2o3F4s
   s+DD0/18/H4rqx3E2MJSB9biix5numYxMETPSixuLP2luX4k9diewmXS+
   wEFQilgYM9cfRA5LrJOdWA2A8U+EIIYiSYBdJEbJ/Ty38DF4D3N7lNAEd
   1IhrKJIJo+S8QLWetf6oYFyekC5ytSSCp8szFIJQCJJiKhwECJqII0D8H
   ladCqzV5l0LD/qulO6F7gdi/Xg6Tk2tFKgJKzivWy4p6ddIfL7G2oOEbb
   7qJ5SVe79IKkhs+K+Q9zGHdUUIgv7q9pjCi2eQWialXNFqyOCH4bXlJTp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2753779"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2753779"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9583468"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:34:21 -0800
Date: Tue, 20 Feb 2024 16:34:20 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] x86/resctrl: Fix WARN in get_domain_from_cpu()
Message-ID: <ZdVFDIJmctsNaGd2@agluck-desk3>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
 <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>

reset_all_ctrls() and resctrl_arch_update_domains() use
on_each_cpu_mask() to call rdt_ctrl_update() on potentially
one CPU from each domain.

But this means rdt_ctrl_update() needs to figure out which domain
to apply changes to. Doing so requires a search of all domains
in a resource, which can only be done safely if cpus_lock is
held. Both callers do hold this lock, but there isn't a way
for a function called on another CPU via IPI to verify this.

Fix by adding the target domain to the msr_param structure and
calling for each domain separately using smp_call_function_single()

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Either apply on top of tip x86/cache:

 fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")

or merge this into that commit.
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/core.c        | 10 +----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 50 +++++------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++-----
 4 files changed, 16 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..c30d7697b431 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -383,6 +383,7 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
+	struct rdt_domain	*dom;
 	u32			low;
 	u32			high;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8a4ef4f5bddc..8d8b8abcda98 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -390,16 +390,8 @@ void rdt_ctrl_update(void *arg)
 	struct msr_param *m = arg;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
 	struct rdt_resource *r = m->res;
-	int cpu = smp_processor_id();
-	struct rdt_domain *d;
 
-	d = get_domain_from_cpu(cpu, r);
-	if (d) {
-		hw_res->msr_update(d, m, r);
-		return;
-	}
-	pr_warn_once("cpu %d not found in any domain for resource %s\n",
-		     cpu, r->name);
+	hw_res->msr_update(m->dom, m, r);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7997b47743a2..aed702d06314 100644
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
@@ -315,17 +299,13 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
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
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
@@ -334,29 +314,19 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
+			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
-
-			if (!msr_param.res) {
-				msr_param.low = idx;
-				msr_param.high = msr_param.low + 1;
-				msr_param.res = r;
-			} else {
-				msr_param.low = min(msr_param.low, idx);
-				msr_param.high = max(msr_param.high, idx + 1);
-			}
+			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
+			cpu = cpumask_any(&d->cpu_mask);
+
+			msr_param.low = idx;
+			msr_param.high = msr_param.low + 1;
+			msr_param.res = r;
+			msr_param.dom = d;
+			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
 		}
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


