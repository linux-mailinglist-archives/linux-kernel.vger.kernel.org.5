Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6275DE2F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGVTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGVTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62BE66;
        Sat, 22 Jul 2023 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052873; x=1721588873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yy6x70ipohJUPyKImz7JLNE9lxHDkygNbgZeApYJDZc=;
  b=nLtkhuXoeMtTnxTgnOfXr4AYQ3L72upxxzgJsCHe/JcdZSMLGvl3Becl
   LWklwzDUT2T3UUR7dIWgHypFfCs7s6ikfmcmSbN8rKE++pi6mjdW7YbBR
   ZxGBhhjVl34VYgVPths3E58HH57qSu7TmIm0PTdVCe0ePzkBhWuX/HEoc
   iESABcaFEu9GfucIPA9/8qz7F7uMlQr1UcZe3QPK0b71/dJvnhTkabY+S
   wTrlQToqmQMdckPTsafoSUpZXs/tniP4iqdoLTso6pyKZClBSJ2h20BKp
   B3pKHGEuikNbZPMrsKQRVDtth4YWW2zcCvV9wgZk9rk7WRoM2zr/6iBLU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823971"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823971"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368081"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368081"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
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
Subject: [PATCH v4 2/7] x86/resctrl: Split the rdt_domain structures
Date:   Sat, 22 Jul 2023 12:07:35 -0700
Message-Id: <20230722190740.326190-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230722190740.326190-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rdt_domain and rdt_hw_domain structures contain an amalgam of
fields used by control and monitoring features. Now that there
are separate domain lists for control/monitoring these can be
divided between two structures.

First step: Add new domain structures for monitoring with the
fields that are needed. Leave these fields in the legacy structure
so compilation won't fail. They will be deleted once all the
monitoring code has been converted to use the new structure.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 28 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h | 17 +++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1267d56f9e76..475912662e47 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,7 +53,7 @@ struct resctrl_staged_config {
 };
 
 /**
- * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * struct rdt_domain - group of CPUs sharing a resctrl control resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
@@ -86,6 +86,32 @@ struct rdt_domain {
 	u32				*mbps_val;
 };
 
+/**
+ * struct rdt_mondomain - group of CPUs sharing a resctrl monitor resource
+ * @list:		all instances of this resource
+ * @id:			unique id for this instance
+ * @cpu_mask:		which CPUs share this resource
+ * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
+ * @mbm_total:		saved state for MBM total bandwidth
+ * @mbm_local:		saved state for MBM local bandwidth
+ * @mbm_over:		worker to periodically read MBM h/w counters
+ * @cqm_limbo:		worker to periodically read CQM h/w counters
+ * @mbm_work_cpu:	worker CPU for MBM h/w counters
+ * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ */
+struct rdt_mondomain {
+	struct list_head		list;
+	int				id;
+	struct cpumask			cpu_mask;
+	unsigned long			*rmid_busy_llc;
+	struct mbm_state		*mbm_total;
+	struct mbm_state		*mbm_local;
+	struct delayed_work		mbm_over;
+	struct delayed_work		cqm_limbo;
+	int				mbm_work_cpu;
+	int				cqm_work_cpu;
+};
+
 /**
  * struct resctrl_cache - Cache allocation related data
  * @cbm_len:		Length of the cache bit mask
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c5e2ac2a60cf..e956090a874e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -320,7 +320,7 @@ struct arch_mbm_state {
 
 /**
  * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
- *			  a resource
+ *			  a control resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @arch_mbm_total:	arch private state for MBM total bandwidth
@@ -335,6 +335,21 @@ struct rdt_hw_domain {
 	struct arch_mbm_state		*arch_mbm_local;
 };
 
+/**
+ * struct rdt_hw_mondomain - Arch private attributes of a set of CPUs that share
+ *			  a monitor resource
+ * @d_resctrl:	Properties exposed to the resctrl file system
+ * @arch_mbm_total:	arch private state for MBM total bandwidth
+ * @arch_mbm_local:	arch private state for MBM local bandwidth
+ *
+ * Members of this structure are accessed via helpers that provide abstraction.
+ */
+struct rdt_hw_mondomain {
+	struct rdt_mondomain		d_resctrl;
+	struct arch_mbm_state		*arch_mbm_total;
+	struct arch_mbm_state		*arch_mbm_local;
+};
+
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
 {
 	return container_of(r, struct rdt_hw_domain, d_resctrl);
-- 
2.40.1

