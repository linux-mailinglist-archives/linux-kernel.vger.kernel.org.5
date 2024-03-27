Return-Path: <linux-kernel+bounces-121952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44788EFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02431C34AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231C153518;
	Wed, 27 Mar 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apFZSNjl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB1152DFB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569846; cv=none; b=i1if3A9yDLvPfqPrYoLehHN2h9p9xJ9ADSe+XMkuebY27FJDyRszUgABA/SYFUMEJCqbrs21ilrHwveXqFpVCd8LWbiHqGp+Qfs11k1LkN3NTltx5EEAWIsjn2VccePn77Faaxo7oOBRR/bXH2aG7sYLHns2zaxIOcJCD8lRAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569846; c=relaxed/simple;
	bh=LAoiP0dp4wUs75VF3HzMl8OnzM3feG6POB1Op/0uGlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaBxXeUIzM+nv3bTJSnFf8maTRtxfkTAQz+riyAZWd5cy2cnphGX5vxgDxD0zPBK3A39vn57zdHHgReC67EfMxcVPYvqf7qNH+UGAucXSDB0tO6TeWC3mSAl7B7Blx7iFUdQPSEwX0DDOXEhwLvffOs+W3BzllXjsjcXzHmRGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apFZSNjl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569845; x=1743105845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LAoiP0dp4wUs75VF3HzMl8OnzM3feG6POB1Op/0uGlw=;
  b=apFZSNjlQ8klZOFAzbavwsnSrld3DZ85yVdFmMVJ7zEi7llbuZRIVL5s
   NMJVju4SBt3YFnAhcXMKM1zZwhApr5nyEujezsyiry/ss/5tKDATKTIqd
   99TZw4KVvlBrBty7+dRaZ2fGkbPqwHHJMo10Xz0zA6fTZyd7k+y3WHVBo
   ykOPaslEWrXLLmSPyqIzTk78ZZaonPA4nVv5qeY1UHB9hD6gaVJXCjOm6
   ne+M4UdxljKtFfEni27JR+TWdt5We3xoTA44aSURUgQqEVxUy6588/8dA
   gBCktZsigNUGHdaxYCC3lOOyCzXRL9VwMem/XLG6EK1rAW2RsQePCsYY3
   g==;
X-CSE-ConnectionGUID: wNvgAx8+RPm8BM5PqM3DHQ==
X-CSE-MsgGUID: X9u2Vu/gQwaq/tL16t9ePg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132976"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246111"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 03/10] x86/resctrl: Add new "enabled" state for monitor resources
Date: Wed, 27 Mar 2024 13:03:45 -0700
Message-ID: <20240327200352.236835-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327200352.236835-1-tony.luck@intel.com>
References: <20240327200352.236835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Sub-NUMA cluster is enabled resctrl needs to build domain
lists for both the regular L3 resource (scoped at L3 cache level)
and the SUBL3 resource (scoped at NUMA node level).

But only one of these resources will be used for all monitoring
functions.

Add a new "enabled" flag to indicate which resource should allocate
space for MBM counters, run MBM overflow and LLC occupancy timeouts
etc.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 2 ++
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++++
 arch/x86/kernel/cpu/resctrl/core.c     | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f39a07b27a98..dea79f6a8122 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -161,6 +161,7 @@ enum resctrl_scope {
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
+ * @mon_enabled:	Monitor feature enabled for this resource
  * @num_rmid:		Number of RMIDs available
  * @scope:		Scope of this resource
  * @cache:		Cache allocation related data
@@ -179,6 +180,7 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
+	bool			mon_enabled;
 	int			num_rmid;
 	enum resctrl_scope	scope;
 	struct resctrl_cache	cache;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 24fad5ecc158..5fcff861e185 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -514,6 +514,10 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
+#define for_each_mon_enabled_rdt_resource(r)				      \
+	for_each_rdt_resource(r)					      \
+		if (r->mon_enabled)
+
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 395bcb3199f8..bfa179f20802 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -559,7 +559,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (r->mon_enabled && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
 		domain_free(hw_dom);
 		return;
 	}
@@ -1002,7 +1002,7 @@ static void __exit resctrl_exit(void)
 
 	rdtgroup_exit();
 
-	if (r->mon_capable)
+	if (r->mon_enabled)
 		rdt_put_mon_l3_config();
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35ec0f03..84a2056190c8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1060,6 +1060,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
+	r->mon_enabled = true;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b8588ce88eef..ffcafe567b25 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3150,7 +3150,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	 * Create the subdirectories for each domain. Note that all events
 	 * in a domain like L3 are grouped into a resource whose domain is L3
 	 */
-	for_each_mon_capable_rdt_resource(r) {
+	for_each_mon_enabled_rdt_resource(r) {
 		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
 		if (ret)
 			goto out_destroy;
@@ -3937,7 +3937,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		mba_sc_domain_destroy(r, d);
 
-	if (!r->mon_capable)
+	if (!r->mon_enabled)
 		goto out_unlock;
 
 	/*
@@ -4011,7 +4011,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 		goto out_unlock;
 	}
 
-	if (!r->mon_capable)
+	if (!r->mon_enabled)
 		goto out_unlock;
 
 	err = domain_setup_mon_state(r, d);
@@ -4074,7 +4074,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 		}
 	}
 
-	if (!l3->mon_capable)
+	if (!l3->mon_enabled)
 		goto out_unlock;
 
 	d = get_domain_from_cpu(cpu, l3);
-- 
2.44.0


