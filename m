Return-Path: <linux-kernel+bounces-77202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1E860289
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63509B20A26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBC73F2D;
	Thu, 22 Feb 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0jCwowe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886B73F06
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627851; cv=none; b=LLyq0SQW6S/c6O81mtpQtITQPeRS9geiwGtmd06DDE1YQg33p2FeeHSUa1t50bTb8RHh9pnGWG4AAF5xijTWHZ6jgZiLQmyWnWY2eXCPDoDwzepwf/1gkAZmfTvXDqfyTI/GFLK0o83K7WgvczsN47lLOL+0IkO/FKUjE1XShlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627851; c=relaxed/simple;
	bh=uCkraOe2EGA6pQ5TAhfFMh2s+xsRPE+IEAImTNgThHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDf1WO4mHr4/H7wZtOg4WEKE0M813fyocllfRplAodfda6gr7ADoF28u0KQzbGUvxncEBW+54jis7OPjZeGaIhkRpnRItQcWRKDz8Cttq4mWgvFDotSkHiJe/rekcr7SMZOTAMzsXGV8vu1E8E15CcnWX0bcg3zeVa2WAbcjb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0jCwowe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627850; x=1740163850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCkraOe2EGA6pQ5TAhfFMh2s+xsRPE+IEAImTNgThHo=;
  b=m0jCwoweRFTcHa+OvDmQ72BHOhlxQHwgkAMFpxbcOLhzfD6W3fBAg4Ei
   AS2vz6MInXcT+ED6KWsXOZg/S2QmRoPiQcwlisXG89kQGb+cvGhCX/juT
   nID/Pt/xHo1TgkMptCz5hpjjPwAS/7G56dZJJg7j/DNWXIFQBAiSnvyHe
   q6zh6/7l4/teOXm5QIJ8WnXC9VYsqkAU7GJdbxG2K80AEaJL3jaGY8Hw1
   c8iY5BqtFROmr2B2B1Bx/cJI/y8TzQz3ew8O6POtlSaeEs/998knca78b
   nncpZBKxxTS+Bb7fmI4BijGd9QaJz6TeHPQY87N8w8J/KyzMc6cRPIONa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3020567"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3020567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936889175"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936889175"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:50:45 -0800
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
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 2/2] x86/resctrl: Simply call convention for MSR update functions
Date: Thu, 22 Feb 2024 10:50:39 -0800
Message-ID: <20240222185039.72201-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222185039.72201-1-tony.luck@intel.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240222185039.72201-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
and mba_wrmsr_amd() all take three arguments:

  (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)

But struct msr_param has always contained the rdt_resource, and now
contains the rdt_domain too.

Change to just pass struct msr_param as a single parameter. Clean
up formatting and fix some firtree parameter ordering.

No functional change.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  3 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 39 +++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c30d7697b431..2f21358b9621 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -443,8 +443,7 @@ struct rdt_hw_resource {
 	struct rdt_resource	r_resctrl;
 	u32			num_closid;
 	unsigned int		msr_base;
-	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
-				 struct rdt_resource *r);
+	void			(*msr_update)(struct msr_param *m);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8d378fc7a50b..7751eea19fd2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -56,14 +56,9 @@ int max_name_width, max_data_width;
  */
 bool rdt_alloc_capable;
 
-static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
-		struct rdt_resource *r);
-static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r);
-static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
-	      struct rdt_resource *r);
+static void mba_wrmsr_intel(struct msr_param *m);
+static void cat_wrmsr(struct msr_param *m);
+static void mba_wrmsr_amd(struct msr_param *m);
 
 #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
 
@@ -309,12 +304,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
-static void
-mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+static void mba_wrmsr_amd(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
@@ -334,25 +328,22 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 	return r->default_ctrl;
 }
 
-static void
-mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
-		struct rdt_resource *r)
+static void mba_wrmsr_intel(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], m->res));
 }
 
-static void
-cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
+static void cat_wrmsr(struct msr_param *m)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
@@ -384,7 +375,7 @@ void rdt_ctrl_update(void *arg)
 	struct msr_param *m = arg;
 
 	hw_res = resctrl_to_arch_res(m->res);
-	hw_res->msr_update(m->dom, m, m->res);
+	hw_res->msr_update(m);
 }
 
 /*
@@ -461,7 +452,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	m.dom = d;
 	m.low = 0;
 	m.high = hw_res->num_closid;
-	hw_res->msr_update(d, &m, r);
+	hw_res->msr_update(&m);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index a3a0fd80daa8..7471f6b747b6 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -289,7 +289,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 	msr_param.dom = d;
 	msr_param.low = idx;
 	msr_param.high = idx + 1;
-	hw_res->msr_update(d, &msr_param, r);
+	hw_res->msr_update(&msr_param);
 
 	return 0;
 }
-- 
2.43.0


