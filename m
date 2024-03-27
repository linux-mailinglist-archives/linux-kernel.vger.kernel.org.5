Return-Path: <linux-kernel+bounces-121954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2C88EFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4885629CAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB8153594;
	Wed, 27 Mar 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRTmx5BT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8251534F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569847; cv=none; b=kdlUwpVukUjF1zQobnBjgiJaulJbEp6bpM2O6k+FM7DDO66VEQK1ww1Z9dV1WJMpuW6sPZupdrB1urpCX4crx8f0h9e0DgeXJAld9Zz7qwciEg6/XZYo5S6MJtNWCggP0QhUb/V2jNNyb9S+9CMPO2r6agys2W46nWBT9AqzR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569847; c=relaxed/simple;
	bh=DQfB7ziQiSVsGqVtUGTeoCLbXrf9m9tIM71X5OZ5E0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0HfrkyIagEMTi7CjW3rr47/WDRakLs2N8om5eocbOWlKUvWzNu9dbI/I2cNE296MV+sgZ6uWjauFRqJH7amPPK6/Z+2KdYe7UAffwJZGB3UF7DPxXjdyjtjj96DCkig429oYCa4tI/UD65GnECTbU0LvXb4YjRC6MJXtjpC4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRTmx5BT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569846; x=1743105846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQfB7ziQiSVsGqVtUGTeoCLbXrf9m9tIM71X5OZ5E0M=;
  b=nRTmx5BTrUAquSAxDnQ+oIDYDUDGCHEWzCU0swnjlqGwrnsOAuiFxJaQ
   ce4pRdcPqHtAopdQ1t9DATw71dbb2FBABXg8Mhgd5JO8KxxaX11/NqUSq
   qTlejnbf6i1JjrFCzSDHRIvWfhKm3fKX6QsZyhGY9izFt97UK0jL/jXKC
   BHkgrkNBDdnWpmFuhheUJyOdx0OExTTDtcJ8eYGb+0X1JIA+djfT21EnL
   e9/7iT8NnpIjrcUxaBlzY+ZN/QgCSFw6wFmBV27WrUYVV3OYr6ZmRkvwP
   eKDYjQVEgLg50kX5yAky617INoM8WfSryA5jI8l5ynl9CZ6wU9SCLagdq
   A==;
X-CSE-ConnectionGUID: g3syR+rmQr69dzODuOCJzw==
X-CSE-MsgGUID: OFBPDUEtSWi0bMwRg8kLrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132991"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246122"
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
Subject: [PATCH 05/10] x86/resctrl: Add parent/child information to rdt_resource and rdt_domain
Date: Wed, 27 Mar 2024 13:03:47 -0700
Message-ID: <20240327200352.236835-6-tony.luck@intel.com>
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

The L3 resource is a "parent" to the SUBL3 resource in that each of the
domains in L3 is subdivided into two or more SUBL3 domains.

Add parent/child pointers to the rdt_resource structure and a
parent domain id number to the rdt_domain structure.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  6 ++++++
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index dea79f6a8122..b7ade7627e08 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -70,6 +70,7 @@ struct resctrl_staged_config {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @parent:		parent domain number in parent resource
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
  * @mbps_val:		When mba_sc is enabled, this holds the array of user
@@ -87,6 +88,7 @@ struct rdt_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	int				parent;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
 	u32				*mbps_val;
@@ -173,6 +175,8 @@ enum resctrl_scope {
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
+ * @parent:		Parent of this resource
+ * @child:		Child of this resource
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -194,6 +198,8 @@ struct rdt_resource {
 						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
 	struct list_head	evt_list;
+	struct rdt_resource	*parent;
+	struct rdt_resource	*child;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2fa04375da8c..1f5d7ee0096e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -552,6 +552,18 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	if (r->parent) {
+		struct rdt_domain *pd;
+
+		list_for_each_entry(pd, &r->parent->domains, list)
+			if (cpumask_test_cpu(cpu, &pd->cpu_mask))
+				goto found;
+		WARN_ON_ONCE(1);
+		return;
+found:
+		d->parent = pd->id;
+	}
+
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a2ebd7e051bb..f2af58a791a4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1107,9 +1107,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 				 struct seq_file *seq, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct list_head *evt_list;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	evt_list = r->child ? &r->child->evt_list : &r->evt_list;
+	list_for_each_entry(mevt, evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
-- 
2.44.0


