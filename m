Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876175285D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjGMQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGMQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:32:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7571980;
        Thu, 13 Jul 2023 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689265953; x=1720801953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K8r2UZiAK+1TfFAtAuBZuyucEeCR4YldPD7156Ve6Xo=;
  b=V5f3mOwaYud4fz5CpYXkdFI+Y4WDAE8OpTqfdXEBhyjYG7huAQTDDEsm
   KLuifvno5SeceIqCzaZ9/F+yu/kSkXqGRxwaUmFuXVxdR7ZYC5pvQGJKj
   gD3hsNSeE9wJ/7YnIbbz9sVJIUbVo56yjrf53Fh+Et8SnH450ze+1GIjH
   yhxV1x9io2q+TCiOE62suxdO3BJAy8/TeohsFeHaSqOpgQcWtMc3Zu5xl
   nUFPuLlWyDaCBajoyi1WbjZKKoh84DyPu7SIjWeikCL/URzZ2OWV4zVBh
   O5MNjHpiPxV7pdFK3P7MYg5aqLVWAiMlIVATU08VaGzpW2HfoRdt4LirR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362707635"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="362707635"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722046383"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="722046383"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:32:22 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 5/8] x86/resctrl: Add package scoped resource
Date:   Thu, 13 Jul 2023 09:32:04 -0700
Message-Id: <20230713163207.219710-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713163207.219710-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Intel features require setting a package scoped model specific
register.

Add a new resource that builds domains for each package.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
---
 include/linux/resctrl.h                |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++--
 arch/x86/kernel/cpu/resctrl/core.c     | 23 +++++++++++++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 25051daa6655..f504f6263fec 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -167,6 +167,7 @@ struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
+	bool			pkg_actions;
 	int			num_rmid;
 	int			scope;
 	struct resctrl_cache	cache;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 38bac0062c82..67340c83392f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -438,6 +438,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
 	RDT_RESOURCE_NODE,
+	RDT_RESOURCE_PKG,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -447,6 +448,7 @@ enum resctrl_scope {
 	SCOPE_L2_CACHE = 2,
 	SCOPE_L3_CACHE = 3,
 	SCOPE_NODE,
+	SCOPE_PKG,
 };
 
 static inline int get_mbm_res_level(void)
@@ -478,9 +480,9 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	     r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;	      \
 	     r = resctrl_inc(r))
 
-#define for_each_capable_rdt_resource(r)				      \
+#define for_each_domain_needed_rdt_resource(r)				      \
 	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable || r->mon_capable)
+		if (r->alloc_capable || r->mon_capable || r->pkg_actions)
 
 #define for_each_alloc_capable_rdt_resource(r)				      \
 	for_each_rdt_resource(r)					      \
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6fe9f87d4403..af3be3c2db96 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -127,6 +127,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= 0,
 		},
 	},
+	[RDT_RESOURCE_PKG] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_PKG,
+			.name			= "PKG",
+			.scope			= SCOPE_PKG,
+			.domains		= domain_init(RDT_RESOURCE_PKG),
+			.fflags			= 0,
+		},
+	},
 };
 
 /*
@@ -504,9 +514,14 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 
 static int get_domain_id(int cpu, enum resctrl_scope scope)
 {
-	if (scope == SCOPE_NODE)
+	switch (scope) {
+	case SCOPE_NODE:
 		return cpu_to_node(cpu);
-	return get_cpu_cacheinfo_id(cpu, scope);
+	case SCOPE_PKG:
+		return topology_physical_package_id(cpu);
+	default:
+		return get_cpu_cacheinfo_id(cpu, scope);
+	}
 }
 
 /*
@@ -630,7 +645,7 @@ static int resctrl_online_cpu(unsigned int cpu)
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
-	for_each_capable_rdt_resource(r)
+	for_each_domain_needed_rdt_resource(r)
 		domain_add_cpu(cpu, r);
 	/* The cpu is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
@@ -657,7 +672,7 @@ static int resctrl_offline_cpu(unsigned int cpu)
 	struct rdt_resource *r;
 
 	mutex_lock(&rdtgroup_mutex);
-	for_each_capable_rdt_resource(r)
+	for_each_domain_needed_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
 	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
 		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
-- 
2.40.1

