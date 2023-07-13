Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57875285F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjGMQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjGMQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:32:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916AF273F;
        Thu, 13 Jul 2023 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689265953; x=1720801953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mb0vyqYUmP9/Z2FeljUZJDw2W7rRUKlG9bPFHkTU9kY=;
  b=E1oeZ9A04k0Ke+aX+iHdySs7rP0WfXXQFQfPhL8Hq8X5uhFiHNbm30qF
   gkLeXhIh8ORondiflXknuPk6JIa4E/9G4nXxPErGIWnSxtSledge+vhxd
   iCYqBVJ9AGTCQThXssZp01U2seAPhe69BADaVwN++MImOKVOafvL5Vcff
   xRyOs1PfwEydJz7lD2WSUL6zrkvKG0TNa3IMv7tWJu63KCLnE++Hn35pD
   QIZ9zdzd7N2mNE4jTKAeT2re2uUobxxTLHz6g16Tqh+wP9biwiwo3LdiP
   sSqwL5htgPSykCNjufl8LkMk6Qdab/XB2V/Z1s8lOIPfS6jMqizvAqZw1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362707619"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="362707619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722046377"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="722046377"
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
Subject: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
Date:   Thu, 13 Jul 2023 09:32:02 -0700
Message-Id: <20230713163207.219710-4-tony.luck@intel.com>
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

Add a placeholder in the array of struct rdt_hw_resource to be used
for event monitoring of systems with Sub-NUMA Cluster enabled.

Update get_domain_id() to handle SCOPE_NODE.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +++-
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8275b8a74f7e..243017096ddf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -435,6 +435,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_NODE,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -442,7 +443,8 @@ enum resctrl_res_level {
 
 enum resctrl_scope {
 	SCOPE_L2_CACHE = 2,
-	SCOPE_L3_CACHE = 3
+	SCOPE_L3_CACHE = 3,
+	SCOPE_NODE,
 };
 
 static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6571514752f3..e4bd3072927c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -112,6 +112,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_NODE] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_NODE,
+			.name			= "L3",
+			.scope			= SCOPE_NODE,
+			.domains		= domain_init(RDT_RESOURCE_NODE),
+			.fflags			= 0,
+		},
+	},
 };
 
 /*
@@ -489,6 +499,8 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 
 static int get_domain_id(int cpu, enum resctrl_scope scope)
 {
+	if (scope == SCOPE_NODE)
+		return cpu_to_node(cpu);
 	return get_cpu_cacheinfo_id(cpu, scope);
 }
 
-- 
2.40.1

