Return-Path: <linux-kernel+bounces-45388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D35842F91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D5E1F26024
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBA7AE63;
	Tue, 30 Jan 2024 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvivmxG7"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF287866E;
	Tue, 30 Jan 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653249; cv=none; b=R5IQ6JoeY8TZo7Cq6cidoP0xMeqopDGOjRkdPzcw2GBl7vpHpGoOj5OOwn2wanhFTc5SwQ82bqKEtVHW5AgTUTYaF/U9TnsBx+T2UHp5wbwNtrDHsg+DWtKOiVvE+lQASlpVhxJWOg4hsl9C9a9BP9wiTKeE0nn6q/NLEDX08Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653249; c=relaxed/simple;
	bh=Mg7KR2u6rJ9exJMnzpHcf9Nmdz63x0v06nGiR1d+ub4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEh0UMRCzJqK0J30JTW8RAVoqyDV+JpYh/OrPyiNobNWIL6GF5nyg2NM7RKLCl5BFyZCR0/E3s3VPka7VCrRVG6q7GzbZlCvgRgWZ8uHA/IEPzNPMR3E2G1C3q4rHybiMhL1fGH/ZdA7LznTgIAQ46sdbU+bRaF3SacPsNP5lbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvivmxG7; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706653247; x=1738189247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mg7KR2u6rJ9exJMnzpHcf9Nmdz63x0v06nGiR1d+ub4=;
  b=IvivmxG7QVN636fhBIwHINeT+OtvzwmobUvJtyQjEiVCgjGRBxKUMM2D
   SL4Vmfr7tg0aSeOSsoI+m7pyKJfQMtL3NvRKq/RCVyHETmszqs4yXhmom
   3K/yFaj1vNdEr9LUNTHDWjIC0mfDlrCnwbvKvloRxoY+3LhzDk+1pBoMr
   q+E9/Wag24lgejKD9LFoVUWowA1/6L20SGYUAn+v3LKPoHv5Rw1Wr+PU6
   NwpnDIBtSHUjLzP7LDkGlk+WvJfaUughtnSCI+vkkM6quQIK6xVDQfu2s
   TxN/sDkoYbmlUF08eZckxNlsp7rChnuiTa50zuBggF49MUXOq6/y3+08R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403041733"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="403041733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119412844"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119412844"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
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
Subject: [PATCH v15-RFC 3/8] x86/resctrl: Prepare for non-cache-scoped resources
Date: Tue, 30 Jan 2024 14:20:29 -0800
Message-ID: <20240130222034.37181-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all resources are scoped in line with some level of hardware cache.

Prepare by renaming the "cache_level" field to "scope" and change
the type to an enum to ease adding new scopes.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |  9 +++++++--
 arch/x86/kernel/cpu/resctrl/core.c        | 14 +++++++-------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..2155dc15e636 100644
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
+ * @scope:		Hardware scope for this resource
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
index 0828575c3e13..d89dce63397b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3_MON,
 			.name			= "L3",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L3_MON),
 			.fflags			= RFTYPE_RES_CACHE,
 		},
@@ -75,7 +75,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -89,7 +89,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
-			.cache_level		= 2,
+			.scope			= RESCTRL_L2_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -103,7 +103,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -115,7 +115,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -514,7 +514,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
@@ -564,7 +564,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->scope);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8f559eeae08e..6a72fb627aa5 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -311,7 +311,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
 
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
+		if (ci->info_list[i].level == plr->s->res->scope) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
 			return 0;
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9ee3a9906781..eff9d87547c9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1416,7 +1416,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
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


