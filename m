Return-Path: <linux-kernel+bounces-97612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC67876C77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAEF1C21178
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E25FDD1;
	Fri,  8 Mar 2024 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ/IzyeA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F765F578
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933941; cv=none; b=I37vZCt8IpVVaDvxexYw77uteJHUwFK59WaKM1oqIpqjVDfyZ61jvVZqSt7JloXuIrsHFPWum1LxBQ2JoBrrKY0q0KWk4G4Sjebpnpd4EoA8Aywn9Z9gJlX1Lo2SBxo/pKFV52OyfcHPDEgT0VEiwp9XyL8cn9bqNXwgFrUNjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933941; c=relaxed/simple;
	bh=5+syQIWZZ3Wnr9rjayrBOZvvjhoz7t4wc/c7M6jQ40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARWI2g6KRKG9JfCufViXQcl0ztpKTyYIUJG2Vnuy0nTYO4jTEzP8r2dW5XmgQTzhXseqYkkME3zB7EvNKpY2hdesDxq2p2bGhJmSFkxK6Ke/H8j3x/VrlGuCDXMoMwecKIX4WoaP6X6dgFTfHCQIAcPTGwkDwtFLb9aAhQzLig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ/IzyeA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709933940; x=1741469940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+syQIWZZ3Wnr9rjayrBOZvvjhoz7t4wc/c7M6jQ40Y=;
  b=UJ/IzyeARVxl1ef27ivgjE2cc3x1g7zLeuFYqUZZLxmhhkR4r6yUKJD8
   H46hHFABb410uCdtvp+URq/tXPJgH2QbvZTfYf8Xup2I16HE21H4mID6I
   at9Q5pi/wc9iBbUO6YmlwbXrMYpONO9hgUvpgVNGJawsLlUsw/uJiMBlb
   cg4tHNMynE+QFeO3IU7JL0j6XLy2rQ7U0v/QdCxX7m4ljw2aO9VgC/z+0
   QMhTnUBwdRNyD2xzTz3YqPxSrgu4CAgkOMpezHSj+8/pb+jsxFwXUPwO5
   ShH1ZKNNmMZkdTDHDPNLLr/SEoDjqWrkbM3T5dzcUAr1s7UKZQj5Apxkj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4811416"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4811416"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15295091"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:57 -0800
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
Subject: [PATCH v5 2/2] x86/resctrl: Simplify call convention for MSR update functions
Date: Fri,  8 Mar 2024 13:38:46 -0800
Message-ID: <20240308213846.77075-3-tony.luck@intel.com>
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

The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
and mba_wrmsr_amd() all take three arguments:

  (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)

struct msr_param contains pointers to both struct rdt_resource and struct
rdt_domain, thus only struct msr_param is necessary.

Pass struct msr_param as a single parameter. Clean up formatting and
fix some fir tree declaration ordering.

No functional change.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  3 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 40 +++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bc999471f072..8f40fb35db78 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -444,8 +444,7 @@ struct rdt_hw_resource {
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
index acf52aa185e0..7751eea19fd2 100644
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
@@ -457,10 +448,11 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	hw_dom->ctrl_val = dc;
 	setup_default_ctrlval(r, dc);
 
+	m.res = r;
 	m.dom = d;
 	m.low = 0;
 	m.high = hw_res->num_closid;
-	hw_res->msr_update(d, &m, r);
+	hw_res->msr_update(&m);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 165d8d453c04..b7291f60399c 100644
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


