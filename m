Return-Path: <linux-kernel+bounces-121958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA288EFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0A42A1BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE7154425;
	Wed, 27 Mar 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFaZCx1K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3E152E00
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569850; cv=none; b=lEd65MJppv6U7YxD2m25sTR19tXut7/zpqOKBTaUA7UxuRrKAKB+7q1U4U6uFZvsLLaN1XdPx1WRPMtBSBaST1uWPHigZEB687PQiLSZrFzJA9q/wKBce9hNd9NjItkBv4iFh0X60u/3SUofBCaug8bMlPRUze0Xq1XFVWmNz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569850; c=relaxed/simple;
	bh=KmXt+nlPE9uG6oRD+ve4qLMKyEv+rwEBB4DSzyRfYbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAW7NpSklhFXW5AiG0pzTa1R8brZCmQseRgwfaS8Vg2YHDQ0SScXerE/Dp542Twd/j46SL3PplQfThYlj1+J21BOpR33ROh0lDxgS4J4KPBcgYIFaSjyfd/d6Dcz5+X6Ngr4L4rYcI/KxV1VAtPNlTsdzTTLj4+XiuXdAqe2etQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFaZCx1K; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569849; x=1743105849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmXt+nlPE9uG6oRD+ve4qLMKyEv+rwEBB4DSzyRfYbU=;
  b=VFaZCx1K1jp5L5YelD6PmCKA+eZYz0VG325j762XcgfaM/OkB3GaTr6c
   ws5hN5bEsfoeZOCx6jF20/EF1Xp3Sql68tBrjCanBTPpRobX9r59rLyA6
   kecJbQcVzHGDIew/HM0M2FLzZ8kGNwM7/o6bXgrnlGmHWkvnYmtyTnkOh
   YnSCDmjjQshbdki7Frp4rFECIMjgPe/ssSeLQQcoUyQVfoN71lA4kVQmu
   vFrT0FCDe+IYfGVJLVs9iyExOkKwfD44HUzPYjdrhxfp1mbLNmkbZsn4l
   dRu4NGkTRsT7eb5qwA6PIIrRC3Qc8LMoUf5dWdX62M9XGEw36sR/xxZQz
   g==;
X-CSE-ConnectionGUID: vz7BRHnNQSyQmTbifSef9g==
X-CSE-MsgGUID: V1s88WVJQ/ag1YSBueO1Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18133023"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18133023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246145"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:04 -0700
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
Subject: [PATCH 09/10] x86/resctrl: Update __mon_event_count() for Sub-NUMA domains
Date: Wed, 27 Mar 2024 13:03:51 -0700
Message-ID: <20240327200352.236835-10-tony.luck@intel.com>
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

Chack the flag to see if the request is for a file that must
calculate the sum of RMID counters from all sibling domains.

Note that when reading RMID counters to sum across SUBL3 domains
it is OK to read from any CPU in the parent L3 domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h               |  2 +
 arch/x86/kernel/cpu/resctrl/monitor.c | 56 ++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b7ade7627e08..4cf256053f53 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -177,6 +177,7 @@ enum resctrl_scope {
  * @evt_list:		List of monitoring events
  * @parent:		Parent of this resource
  * @child:		Child of this resource
+ * @num_siblings:	Number of sibling domains that share a parent
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -200,6 +201,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	struct rdt_resource	*parent;
 	struct rdt_resource	*child;
+	int			num_siblings;
 	unsigned long		fflags;
 	bool			cdp_capable;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 95455cb187eb..1ba40d5f5d77 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -279,12 +279,24 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
-	int ret;
+	int cpu, ret;
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
-		return -EINVAL;
+	/* This sanity check is now heavyweight. Keep it? */
+	cpu = smp_processor_id();
+	if (r->parent) {
+		struct rdt_domain *pd;
+
+		pd = rdt_find_domain(r->parent, d->parent, NULL);
+		if (WARN_ON_ONCE(!pd))
+			return -EINVAL;
+		if (!cpumask_test_cpu(cpu, &pd->cpu_mask))
+			return -EINVAL;
+	} else {
+		if (!cpumask_test_cpu(cpu, &d->cpu_mask))
+			return -EINVAL;
+	}
 
 	ret = __rmid_read(rmid, eventid, &msr_val);
 	if (ret)
@@ -538,7 +550,7 @@ static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
 	}
 }
 
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int ___mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr, u64 *rrval)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
@@ -556,11 +568,44 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	if (rr->err)
 		return rr->err;
 
-	rr->val += tval;
+	*rrval += tval;
 
 	return 0;
 }
 
+static u32 get_node_rmid(struct rdt_resource *r, struct rdt_domain *d, u32 rmid)
+{
+	int cpu = cpumask_any(&d->cpu_mask);
+
+	return rmid + (cpu_to_node(cpu) % r->num_siblings) * r->num_rmid;
+}
+
+static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+{
+	struct rdt_domain *d;
+	struct rmid_read tmp;
+	u32 node_rmid;
+	int ret = 0;
+
+	if (!rr->sumdomains) {
+		node_rmid = get_node_rmid(rr->r, rr->d, rmid);
+		return ___mon_event_count(closid, node_rmid, rr, &rr->val);
+	}
+
+	tmp = *rr;
+	list_for_each_entry(d, &rr->r->domains, list) {
+		if (d->parent == rr->d->parent) {
+			tmp.d = d;
+			node_rmid = get_node_rmid(rr->r, d, rmid);
+			ret = ___mon_event_count(closid, node_rmid, &tmp, &rr->val);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
@@ -1039,6 +1084,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
+	r->num_siblings = 1;
 	rdt_l3_mon_resource = r;
 
 	ret = dom_data_init(rdt_l3_mon_resource);
-- 
2.44.0


