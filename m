Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B078D0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbjH2Xo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjH2Xon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:44:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCED1B3;
        Tue, 29 Aug 2023 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693352681; x=1724888681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/EXhJCpyz3uBL/oEdqmrNfXk9bhwq1mYy59t3f/24c=;
  b=GPARNH8f6vG+PD8c1Wv/gfiCnllw2lTotjM1TPiHjf0ZXrAeu0Dfgb4d
   36X4ccxTatGqI++8ucrEORflen8Db8Vf5jsRVUyF1WDcbGNxfTsDbF/Si
   z32PTh8R6VnXHlXb+bu0udwJySFK9MAvrjsjLZR2b546AA9LTHBjdjTXZ
   L9K7HgRJA9fMrRpeBjW8n8qXddibFnyjYv0bY5Jqact3sjfrNKZTnBEf8
   p1xpn1dTvf6p4pfleSV4FXevJUmwKefAEulXoAvOdj5+9PG8dyszk0Gvq
   hXNYrtBriAb/ySxKDn4m//Vvx4HghS9NqMC8Y3FWWVEa0qT0Dlkf4KZgU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355015448"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="355015448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688691030"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="688691030"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:39 -0700
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
Subject: [PATCH v5 4/8] x86/resctrl: Add node-scope to the options for feature scope
Date:   Tue, 29 Aug 2023 16:44:22 -0700
Message-ID: <20230829234426.64421-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829234426.64421-1-tony.luck@intel.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently supported resctrl features are all domain scoped the same as the
scope of the L2 or L3 caches.

Add "node" as a new option for domain scope.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 1 +
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 08382548571e..f55cf7afd4eb 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -163,6 +163,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L3_CACHE,
 	RESCTRL_L2_CACHE,
+	RESCTRL_NODE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3e08aa04a7ff..9fcc264fac6c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -514,6 +514,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 		return get_cpu_cacheinfo_id(cpu, 3);
 	case RESCTRL_L2_CACHE:
 		return get_cpu_cacheinfo_id(cpu, 2);
+	case RESCTRL_NODE:
+		return cpu_to_node(cpu);
 	default:
 		WARN_ON_ONCE(1);
 		break;
-- 
2.41.0

